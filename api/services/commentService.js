import fp from "fastify-plugin";

const CommentService = (postgres) => {
  console.log("CommentService", postgres);

  const getComment = async (memberUid, commentUid) => {
    const client = await postgres.connect();

    try {
      const {
        rows,
      } = await client.query(
        ` SELECT *
        FROM get_comment($1, $2)`,
        [memberUid, commentUid]
      );

      // Note: avoid doing expensive computation here, this will block releasing the client
      return rows[0];
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  }; 

  const getLogbookEntryComments = async (memberUid, logbookEntryUid) => {
    const client = await postgres.connect();

    try {
      const {
        rows,
      } = await client.query(
        ` SELECT *
        FROM get_logbook_entry_comments($1, $2)`,
        [memberUid, logbookEntryUid]
      );

      // Note: avoid doing expensive computation here, this will block releasing the client
      return rows;
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  }; 

  const patchComment = async (memberUid, commentUid, entryData) => {
    const client = await postgres.connect();

    const query = `SELECT "commentUid" , "updatedAt" 
        FROM patch_comment(
          $1, $2, $3, $4, $5, $6, $7, $8
      )`;

    const note = entryData.note ? entryData.note : null;
    const publicTitle = entryData.publicTitle ? entryData.publicTitle : null;
    const internalName = entryData.internalName ? entryData.internalName : null;
    const blocks = entryData.blocks ? JSON.stringify(entryData.blocks) : null;
    const pubAt = entryData.pubAt ? entryData.pubAt : null;
    const unPubAt = entryData.unPubAt ? entryData.unPubAt : null;

    const values = [memberUid, commentUid, note, publicTitle, internalName, blocks, pubAt, unPubAt];

    try {
      const result = await client.query(query, values);

      // Note: avoid doing expensive computation here, this will block releasing the client
      return result.rows[0];
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  return { getComment, getLogbookEntryComments, patchComment };
};

export default fp((server, options, next) => {
  server.decorate("commentService", CommentService(server.pg));
  next();
});
