import fp from "fastify-plugin";

const LogbookEntryService = (postgres) => {
  console.log("LogbookEntryService", postgres);

  const getLogbookEntry = async (memberUid, logbookEntryUid) => {
    const client = await postgres.connect();

    try {
      const {
        rows,
      } = await client.query(
        ` SELECT *
        FROM get_logbook_entry($1, $2)`,
        [memberUid, logbookEntryUid]
      );

      // Note: avoid doing expensive computation here, this will block releasing the client
      return rows[0];
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  }; 

  const patchLogbookEntry = async (memberUid, logbookEntryUid, entryData) => {
    const client = await postgres.connect();

    const query = `SELECT "logbookEntryUid" , "updatedAt" 
        FROM patch_logbook_entry(
          $1, $2, $3, $4, $5, $6, $7, $8
      )`;

    const note = entryData.note ? entryData.note : null;
    const publicTitle = entryData.publicTitle ? entryData.publicTitle : null;
    const internalName = entryData.internalName ? entryData.internalName : null;
    const blocks = entryData.blocks ? JSON.stringify(entryData.blocks) : null;
    const pubAt = entryData.pubAt ? entryData.pubAt : null;
    const unPubAt = entryData.unPubAt ? entryData.unPubAt : null;

    const values = [memberUid, logbookEntryUid, note, publicTitle, internalName, blocks, pubAt, unPubAt];

    try {
      const result = await client.query(query, values);

      // Note: avoid doing expensive computation here, this will block releasing the client
      return result.rows[0];
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const createLogbookEntryComment = async (memberUid, logbookEntryUid, entryData) => {
    const client = await postgres.connect();

    const query = `SELECT "commentUid" , "createdAt" 
        FROM create_logbook_entry_comment(
          $1, $2, $3
      )`;

    const values = [memberUid, logbookEntryUid, entryData.note];

    try {
      const result = await client.query(query, values);

      // Note: avoid doing expensive computation here, this will block releasing the client
      return result.rows[0];
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  }

  const setLogbookEntryReaction = async (memberUid, logbookEntryUid, reactions) => {
    const client = await postgres.connect();

    const query = `SELECT "reactedAt" 
        FROM set_logbook_entry_reaction(
          $1, $2, $3
      )`;

    const values = [memberUid, logbookEntryUid, reactions];

    try {
      const result = await client.query(query, values);

      // Note: avoid doing expensive computation here, this will block releasing the client
      return result.rows[0];
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  return { getLogbookEntry, patchLogbookEntry, createLogbookEntryComment, setLogbookEntryReaction };
};

export default fp((server, options, next) => {
  server.decorate("logbookEntryService", LogbookEntryService(server.pg));
  next();
});
