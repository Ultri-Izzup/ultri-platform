import fp from "fastify-plugin";

const CanavaService = (postgres) => {
  console.log("CanavaService", postgres);

  const getMemberCanvases = async (memberUid) => {
    const client = await postgres.connect();

    try {
      const {
        rows,
      } = await client.query(
        ` SELECT *
        FROM canvas c 
        JOIN member m ON m.id = c.created_by
        WHERE m.uid = $1
        AND c.org_id IS NULL`, 
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

  const setMemberCanvas = async (memberUid, orgData) => {
    const client = await postgres.connect();

    let query;
    let values;

    console.log('======================ORGDATA==========================', orgData)

    query = `INSERT INTO nugget.member_canvas(
        name, template, attribution, sections, sequenced, canava_version, completed_on, completed_by, version, public, created_by, updated_by, editors, viewers)
        VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);`;

    values = [memberUid, orgData.name, orgData.note];

    try {
      const result = ''; // await client.query(query, values);

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

  return { getMemberCanvases, setMemberCanvas };
};

export default fp((server, options, next) => {
  server.decorate("canavaService", CanavaService(server.pg));
  next();
});
