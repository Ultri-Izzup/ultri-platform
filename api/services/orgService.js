import fp from "fastify-plugin";

const OrgService = (postgres) => {
  console.log("OrgService", postgres);

  const getMemberOrgs = async (memberUid) => {
    const client = await postgres.connect();

    try {
      const {
        rows,
      } = await client.query(
        ` SELECT *
        FROM get_member_orgs($1)`,
        [memberUid]
      );
      console.log("ROWS", rows)
      // Note: avoid doing expensive computation here, this will block releasing the client
      return rows;
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const getAccountOrgs = async (memberUid, accountUid) => {
    const client = await postgres.connect();

    try {
      const {
        rows,
      } = await client.query(
        ` SELECT *
        FROM get_account_orgs($1, $2)`,
        [memberUid, accountUid]
      );

      // Note: avoid doing expensive computation here, this will block releasing the client
      return rows;
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const createOrg = async (memberUid, accountUid, orgData) => {
    const client = await postgres.connect();

    let query;
    let values;

    query = `SELECT "orgId", "orgUid" , "createdAt" , name , "logbookId", "logbookUid" 
        FROM create_org(
          $1, $2, $3, $4
      )`;

    values = [memberUid, accountUid, orgData.name, orgData.note];

    try {
      const result = await client.query(query, values);

      const newData = result.rows[0];

      // Note: avoid doing expensive computation here, this will block releasing the client
      return {
        orgUid: newData.orgUid,
        createdAt: newData.createdAt,
        name: orgData.name,
        logbookUid: newData.logbookUid
      };
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const createMemberOrg = async (memberUid, orgData) => {
    const client = await postgres.connect();

    let query;
    let values;

    query = `SELECT "id", "uid" , "createdAt" , name , "logbookId", "logbookUid" 
        FROM create_member_org(
          $1, $2, $3
      )`;

    values = [memberUid, orgData.name, orgData.note];

    try {
      const result = await client.query(query, values);

      const newData = result.rows[0];

      // Note: avoid doing expensive computation here, this will block releasing the client
      return {
        uid: newData.uid,
        createdAt: newData.createdAt,
        name: orgData.name,
        logbookUid: newData.logbookUid
      };
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const updateMissionStatement = async (memberUid, orgUid, mission) => {
    const client = await postgres.connect();

    let query;
    let values;

    query = `SELECT "nuggetUid", "updatedAt" 
        FROM set_org_mission_statement(
          $1, $2, $3
      )`;

    values = [memberUid, orgUid, mission];

    try {
      const result = await client.query(query, values);

      const newData = result.rows[0];

      // Note: avoid doing expensive computation here, this will block releasing the client
      return {
        nuggetUid: newData.nuggetUid,
        updatedAt: newData.updatedAt,
      };
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const deleteMemberOrg = async (memberUid, orgUid) => {
    const client = await postgres.connect();

    console.log('MEMBER', memberUid, 'ORGUID', orgUid);

    let query;
    let values;

    query = `SELECT * FROM  delete_member_org(
          $1, $2
      )`;

    values = [memberUid, orgUid];

    try {
      const result = await client.query(query, values);

    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  return { getAccountOrgs, createOrg, getMemberOrgs, createMemberOrg, deleteMemberOrg, updateMissionStatement };
};

export default fp((server, options, next) => {
  server.decorate("orgService", OrgService(server.pg));
  next();
});
