import fp from "fastify-plugin";

const ReactionService = (postgres) => {
  console.log("ReactionService", postgres);

  const getReaction = async (memberUid, reactionUid) => {
    const client = await postgres.connect();

    try {
      const {
        rows,
      } = await client.query(
        ` SELECT *
        FROM get_reaction($1, $2)`,
        [memberUid, reactionUid]
      );

      // Note: avoid doing expensive computation here, this will block releasing the client
      return rows[0];
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  }; 

  const getLogbookEntryReactions = async (memberUid, logbookEntryUid) => {
    const client = await postgres.connect();

    try {
      const {
        rows,
      } = await client.query(
        ` SELECT *
        FROM get_logbook_entry_reactions($1, $2)`,
        [memberUid, logbookEntryUid]
      );

      // Note: avoid doing expensive computation here, this will block releasing the client
      return rows;
    } finally {
      // Release the client immediately after query resolves, or upon error
      client.release();
    }
  }; 



  return { getReaction, getLogbookEntryReactions };
};

export default fp((server, options, next) => {
  server.decorate("reactionService", ReactionService(server.pg));
  next();
});
