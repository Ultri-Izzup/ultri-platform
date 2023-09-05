import fp from "fastify-plugin";

const CanavaService = (postgres) => {
  console.log("CanavaService", postgres);

  const getMemberCanvases = async (memberUid) => {
    const client = await postgres.connect();

    try {
      const {
        rows,
      } = await client.query(
        ` SELECT mc.*
        FROM member_canvas mc 
        JOIN member m ON m.id = mc.member_id
        WHERE m.uid = $1 
        AND mc.deleted = false`,
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

  const setMemberCanvas = async (memberUid, canvas) => {
    const client = await postgres.connect();

    let query;
    let values;

    console.log('======================CANVAS==========================', canvas)

    query = `SELECT * from nugget.set_member_canvas($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15)`;

    values = [
        'platform',
        memberUid, 
        canvas.uid, 
        canvas.name ? canvas.name : '', 
        canvas.templateName ? canvas.templateName : '',
        canvas.attribution ? canvas.attribution : '',
        canvas.sections ? JSON.stringify(canvas.sections) : '{}',
        canvas.sequenced,
        canvas.canavaVers  ? canvas.canavaVers : '',
        canvas.completedOn ? canvas.completedOn : '',
        canvas.completedBy ? canvas.completedBy : '',
        canvas.version ? canvas.version : '',
        canvas.public ? canvas.public : false,
        '{}',
        '{}'
    ];

    console.log('===VALUES===', values);

    try {
      const result = await client.query(query, values);
      console.log('RESULT', result)

    //   const newData = result.rows[0];

    return { uid: canvas.uid }

    //   // Note: avoid doing expensive computation here, this will block releasing the client
    //   return {
    //     uid: newData.uid,
    //     createdAt: newData.createdAt,
    //     name: orgData.name,
    //     logbookUid: newData.logbookUid
    //   };
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
