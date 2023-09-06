import fp from "fastify-plugin";

const CanavaService = (postgres) => {
  console.log("CanavaService", postgres);

  const getMemberCanvases = async (memberUid) => {
    const client = await postgres.connect();

    try {
      const {
        rows,
      } = await client.query(
        ` SELECT 
          mc.archived,
          mc.attribution,
          mc.canava_version,
          mc.completed_by,
          mc.completed_on,
          mc.editors,
          mc.name,
          mc.public,
          mc.sections,
          mc.sequenced,
          mc.template,
          mc.uid,
          mc.version
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

    try {
      const result = await client.query(query, values);

      return { uid: canvas.uid }

    //   // Note: avoid doing expensive computation here, this will block releasing the client

    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const deleteMemberCanvas = async (memberUid, canvasUid) => {
    const client = await postgres.connect();

    let query;
    let values;


    query = `UPDATE nugget.member_canvas 
              SET deleted = true 
              FROM nugget.member m
              WHERE m.id = member_id
              AND m.uid = $1
              AND nugget.member_canvas.uid = $2`;

    values = [
        memberUid, 
        canvasUid
    ];

    try {
      const result = await client.query(query, values);

     // return { uid: canvasUid }

    //   // Note: avoid doing expensive computation here, this will block releasing the client

    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  return { getMemberCanvases, setMemberCanvas, deleteMemberCanvas };
};

export default fp((server, options, next) => {
  server.decorate("canavaService", CanavaService(server.pg));
  next();
});
