import fp from "fastify-plugin";

const AccountService = (postgres) => {
  console.log("AccountService", postgres);

  const getMemberAccounts = async (memberUid) => {
    const client = await postgres.connect();

    try {
      const {
        rows,
      } = await client.query(
        ` SELECT "accountUid", "createdAt", name, roles::text[]
        FROM get_member_accounts($1)`,
        [memberUid]
      );

      console.log(rows)

      // Note: avoid doing expensive computation here, this will block releasing the client
      return rows;
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  const createAccount = async (accountData, authMemberId) => {
    const client = await postgres.connect();

    let query;
    let values;

    query = `SELECT uid, created_at, roles::text[]
        FROM create_account(
          $1, $2
      )`;

    values = [authMemberId, accountData.name];

    try {
      const result = await client.query(query, values);

      const newData = result.rows[0];

      // Note: avoid doing expensive computation here, this will block releasing the client
      return {
        accountUid: newData.uid,
        createdAt: newData.created_at,
        name: accountData.name,
        roles: newData.roles
      };
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  };

  return { getMemberAccounts, createAccount };
};

export default fp((server, options, next) => {
  server.decorate("accountService", AccountService(server.pg));
  next();
});
