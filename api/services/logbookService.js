import fp from "fastify-plugin";

const LogbookService = (postgres) => {

  const getOrgLogbooks = async (memberUid, orgUid) => {
    const client = await postgres.connect();

    try {
      const {
        rows,
      } = await client.query(
        ` SELECT *
        FROM get_org_logbooks($1, $2)`,
        [memberUid, orgUid]
      );

      // Note: avoid doing expensive computation here, this will block releasing the client
      return rows;
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const createLogbook = async (memberUid, logbookData) => {
    const client = await postgres.connect();

    let query;
    let values;

    query = `SELECT "logbookId", "logbookUid" , "createdAt" , name , "logbookId", "logbookUid" 
        FROM create_logbook(
          $1, $2, $3, $4
      )`;

    values = [logbookData.name, logbookData.note, memberUid, logbookData.orgUid];

    try {
      const result = await client.query(query, values);

      const newData = result.rows[0];

      // Note: avoid doing expensive computation here, this will block releasing the client
      return {
        logbookUid: newData.logbookUid,
        createdAt: newData.createdAt,
        name: logbookData.name,
        logbookUid: newData.logbookUid
      };
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const createLogbookEntry = async (memberUid, logbookUid, logbookEntryData) => {
    const client = await postgres.connect();

    let query;
    let values;

    query = `SELECT "logbookEntryId", "logbookEntryUid" , "createdAt"
        FROM create_logbook_entry(
          $1, $2, $3, $4
      )`;

    const nuggetUid = logbookEntryData.nuggetUid ? logbookEntryData.nuggetUid : null;
    const note = logbookEntryData.note ? logbookEntryData.note : null;
    values = [memberUid, logbookUid, nuggetUid, note];

    try {
      const result = await client.query(query, values);

      const newData = result.rows[0];
      
      // Note: avoid doing expensive computation here, this will block releasing the client
      return {
        logbookEntryUid: newData.logbookEntryUid,
        createdAt: newData.createdAt,
        logbookId: newData.logbookId
      };
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const createOrgLogbookEntry = async (memberUid, orgUid, logbookEntryData) => {
    const client = await postgres.connect();

    let query;
    let values;

    query = `SELECT "logbookEntryId", "logbookEntryUid" , "createdAt"
        FROM create_org_logbook_entry(
          $1, $2, $3, $4
      )`;

    const nuggetUid = logbookEntryData.nuggetUid ? logbookEntryData.nuggetUid : null;
    const note = logbookEntryData.note ? logbookEntryData.note : null;
    values = [memberUid, orgUid, nuggetUid, note];

    try {
      const result = await client.query(query, values);

      const newData = result.rows[0];
      
      // Note: avoid doing expensive computation here, this will block releasing the client
      return {
        logbookEntryUid: newData.logbookEntryUid,
        createdAt: newData.createdAt,
        logbookId: newData.logbookId
      };
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const updateOrgLogbookEntry = async (memberUid, orgUid, logbookEntryUid, logbookEntryData) => {
    const client = await postgres.connect();

    let query;
    let values;

    query = `SELECT "updatedAt"
        FROM update_org_logbook_entry(
          $1, $2, $3, $4
      )`;

    const note = logbookEntryData.note ? logbookEntryData.note : null;
    values = [memberUid, orgUid, logbookEntryUid, note];

    try {
      const result = await client.query(query, values);

      const newData = result.rows[0];
      
      // Note: avoid doing expensive computation here, this will block releasing the client
      return {
        updatedAt: newData.updatedAt
      };
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const getLogbookEntries = async (memberUid, logbookUid) => {
    const client = await postgres.connect();

    try {
      const {
        rows,
      } = await client.query(
        ` SELECT *
        FROM get_logbook_entries($1, $2)`,
        [memberUid, logbookUid]
      );

      // Note: avoid doing expensive computation here, this will block releasing the client
      return { logbookEntries: rows };
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  }

  const getOrgLogbookEntries = async (memberUid, orgUid) => {
    const client = await postgres.connect();

    try {
      const {
        rows,
      } = await client.query(
        ` SELECT *
        FROM get_org_logbook_entries($1, $2)`,
        [memberUid, orgUid]
      );

      // Note: avoid doing expensive computation here, this will block releasing the client
      return rows ;
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  }

  const getOrgLogbookEntry = async (memberUid, orgUid, logbookEntryUid) => {
    const client = await postgres.connect();

    try {
      const {
        rows,
      } = await client.query(
        ` SELECT *
        FROM get_org_logbook_entry($1, $2, $3)`,
        [memberUid, orgUid, logbookEntryUid]
      );

      // Note: avoid doing expensive computation here, this will block releasing the client
      return rows ;
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  }

  return { getOrgLogbooks, createLogbook, createLogbookEntry, getOrgLogbookEntries, createOrgLogbookEntry, getOrgLogbookEntry, updateOrgLogbookEntry };
};

export default fp((server, options, next) => {
  server.decorate("logbookService", LogbookService(server.pg));
  next();
});
