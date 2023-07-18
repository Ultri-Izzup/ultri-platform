import fp from "fastify-plugin";

const NuggetService = (postgres) => {
  const getOrgNuggets = async (memberUid, orgUid) => {
    const client = await postgres.connect();

    try {
      const { rows } = await client.query(
        ` SELECT *
        FROM get_org_nuggets($1, $2)`,
        [memberUid, orgUid]
      );

      // Note: avoid doing expensive computation here, this will block releasing the client
      return rows;
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const createMemberOrgLogbookNugget = async (
    memberUid,
    orgUid,
    metaData,
    nuggetData
  ) => {
    const client = await postgres.connect();

    let query;
    let values;

    const pubAt = nuggetData.pubAt ? nuggetData.pubAt : null;
    const unPubAt = nuggetData.unPubAt ? nuggetData.unPubAt : null;
    const publicTitle = nuggetData.publicTitle ? nuggetData.publicTitle : null;
    const internalName = nuggetData.internalName
      ? nuggetData.internalName
      : null;
    const blocks = nuggetData.blocks ? JSON.stringify(nuggetData.blocks) : null;
    const nuggetType = nuggetData.nuggetType ? nuggetData.nuggetType : null;
    const note = metaData.note ? metaData.note : null;

    query = `SELECT * 
        FROM create_org_logbook_entry_nugget(
          $1, $2, $3, $4, $5, $6, $7, $8, $9
      )`;

    values = [
      memberUid,
      orgUid,
      pubAt,
      unPubAt,
      publicTitle,
      internalName,
      blocks,
      nuggetType,
      note,
    ];

    try {
      const result = await client.query(query, values);

      const newData = result.rows[0];

      // Note: avoid doing expensive computation here, this will block releasing the client
      return {
        nuggetId: newData.nuggetId,
        nuggetUid: newData.nuggetUid,
        logbookEntryId: newData.logbookEntryId,
        logbookEntryUid: newData.logbookEntryUid,
        createdAt: newData.createdAt,
      };
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const updateMemberOrgLogbookNugget = async (
    memberUid,
    orgUid,
    logbookEntryUid,
    metaData,
    nuggetData
  ) => {
    const client = await postgres.connect();

    console.log('MADE IT');
    console.log('METADATA', metaData);
    console.log('NUGGETDATA', nuggetData);

    let query;
    let values;

    const pubAt = nuggetData.pubAt ? nuggetData.pubAt : null;
    const unPubAt = nuggetData.unPubAt ? nuggetData.unPubAt : null;
    const publicTitle = nuggetData.publicTitle ? nuggetData.publicTitle : null;
    const internalName = nuggetData.internalName
      ? nuggetData.internalName
      : null;
    const blocks = nuggetData.blocks ? JSON.stringify(nuggetData.blocks) : null;
    const nuggetType = nuggetData.nuggetType ? nuggetData.nuggetType : null;
    const subtype = nuggetData.subtype ? nuggetData.subtype : null;
    const note = metaData.note ? metaData.note : null;

    query = `SELECT * 
        FROM update_org_logbook_entry_nugget(
          $1, $2, $3, $4, $5, $6, $7, $8, $9, $10
      )`;

    values = [
      memberUid,
      orgUid,
      logbookEntryUid,
      note,
      pubAt,
      unPubAt,
      publicTitle,
      internalName,
      blocks,
      subtype
    ];

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

  
  const createNuggetForLogbook = async (memberUid, logbookUid, nuggetData) => {
    const client = await postgres.connect();

    let query;
    let values;

    const pubAt = nuggetData.pubAt ? nuggetData.pubAt : null;
    const unPubAt = nuggetData.unPubAt ? nuggetData.unPubAt : null;
    const publicTitle = nuggetData.publicTitle ? nuggetData.publicTitle : null;
    const internalName = nuggetData.internalName
      ? nuggetData.internalName
      : null;
    const blocks = nuggetData.blocks ? JSON.stringify(nuggetData.blocks) : null;
    const nuggetType = nuggetData.nuggetType ? nuggetData.nuggetType : null;

    query = `SELECT * 
        FROM create_logbook_nugget(
          $1, $2, $3, $4, $5, $6, $7, $8
      )`;

    values = [
      memberUid,
      logbookUid,
      pubAt,
      unPubAt,
      publicTitle,
      internalName,
      blocks,
      nuggetType,
    ];

    try {
      const result = await client.query(query, values);

      const newData = result.rows[0];

      // Note: avoid doing expensive computation here, this will block releasing the client
      return {
        nuggetId: newData.id,
        nuggetUid: newData.uid,
        createdAt: newData.createdAt,
      };
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const createNuggetWithLogbookEntry = async (
    memberUid,
    logbookUid,
    metaData,
    nuggetData
  ) => {
    const client = await postgres.connect();

    let query;
    let values;

    const pubAt = nuggetData.pubAt ? nuggetData.pubAt : null;
    const unPubAt = nuggetData.unPubAt ? nuggetData.unPubAt : null;
    const publicTitle = nuggetData.publicTitle ? nuggetData.publicTitle : null;
    const internalName = nuggetData.internalName
      ? nuggetData.internalName
      : null;
    const blocks = nuggetData.blocks ? JSON.stringify(nuggetData.blocks) : null;
    const nuggetType = nuggetData.nuggetType ? nuggetData.nuggetType : null;
    const note = metaData.note ? metaData.note : null;

    query = `SELECT * 
        FROM create_logbook_entry_nugget(
          $1, $2, $3, $4, $5, $6, $7, $8, $9
      )`;

    values = [
      memberUid,
      logbookUid,
      pubAt,
      unPubAt,
      publicTitle,
      internalName,
      blocks,
      nuggetType,
      note,
    ];

    try {
      const result = await client.query(query, values);

      const newData = result.rows[0];

      // Note: avoid doing expensive computation here, this will block releasing the client
      return {
        nuggetId: newData.nuggetId,
        nuggetUid: newData.nuggetUid,
        logbookEntryId: newData.logbookEntryId,
        logbookEntryUid: newData.logbookEntryUid,
        createdAt: newData.createdAt,
      };
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const createNuggetWithLogbookEntryComment = async (
    memberUid,
    logbookEntryUid,
    metaData,
    nuggetData
  ) => {
    const client = await postgres.connect();

    let query;
    let values;

    const pubAt = nuggetData.pubAt ? nuggetData.pubAt : null;
    const unPubAt = nuggetData.unPubAt ? nuggetData.unPubAt : null;
    const publicTitle = nuggetData.publicTitle ? nuggetData.publicTitle : null;
    const internalName = nuggetData.internalName
      ? nuggetData.internalName
      : null;
    const blocks = nuggetData.blocks ? JSON.stringify(nuggetData.blocks) : null;
    const nuggetType = nuggetData.nuggetType ? nuggetData.nuggetType : null;
    const note = metaData.note ? metaData.note : null;

    query = `SELECT * 
        FROM create_logbook_entry_comment_nugget(
          $1, $2, $3, $4, $5, $6, $7, $8, $9
      )`;

    values = [
      memberUid,
      logbookEntryUid,
      pubAt,
      unPubAt,
      publicTitle,
      internalName,
      blocks,
      nuggetType,
      note,
    ];

    try {
      const result = await client.query(query, values);

      const newData = result.rows[0];

      console.log("NEWDATA#########", newData);

      // Note: avoid doing expensive computation here, this will block releasing the client
      return {
        commentNuggetId: newData.commentNuggetId,
        commentNuggetUid: newData.commentNuggetUid,
        commentUid: newData.commentUid,
        commentNuggetUid: newData.commentNuggetUid,
        createdAt: newData.createdAt,
      };
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const getNuggetEntries = async (memberUid, nuggetUid) => {
    const client = await postgres.connect();

    try {
      const { rows } = await client.query(
        ` SELECT *
        FROM get_nugget_entries($1, $2)`,
        [memberUid, nuggetUid]
      );

      // Note: avoid doing expensive computation here, this will block releasing the client
      return { nuggetEntries: rows };
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const getLogbookNugget = async (memberUid, logbookUid, nuggetUid) => {
    const client = await postgres.connect();

    try {
      const { rows } = await client.query(
        ` SELECT *
        FROM get_logbook_nugget($1, $2, $3)`,
        [memberUid, logbookUid, nuggetUid]
      );

      console.log("SERVICE RESULT", rows);

      // Note: avoid doing expensive computation here, this will block releasing the client
      return { nugget: rows[0] };
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const patchNugget = async (memberUid, nuggetUid, nuggetData) => {
    const client = await postgres.connect();

    const publicTitle = nuggetData.publicTitle ? nuggetData.publicTitle : "";
    const internalName = nuggetData.internalName ? nuggetData.internalName : "";
    try {
      const { rows } = await client.query(
        ` SELECT *
        FROM patch_nugget($1, $2, $3, $4)`,
        [memberUid, nuggetUid, publicTitle, internalName]
      );

      console.log("SERVICE RESULT", rows);

      // Note: avoid doing expensive computation here, this will block releasing the client
      return rows[0];
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  return {
    createNuggetForLogbook,
    createNuggetWithLogbookEntry,
    getLogbookNugget,
    patchNugget,
    createNuggetWithLogbookEntryComment,
    createMemberOrgLogbookNugget,
    updateMemberOrgLogbookNugget
  };
};

export default fp((server, options, next) => {
  server.decorate("nuggetService", NuggetService(server.pg));
  next();
});
