SHOW TRANSACTION ISOLATION LEVEL
LOG:  execute <unnamed>: SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL SERIALIZABLE
LOG:  execute S_9: BEGIN
LOG:  execute S_10: SELECT device_id_hash, email, phone_number, link_code_salt, failed_attempts FROM supertokens.passwordless_devices WHERE app_id = $1 AND tenant_id = $2 AND device_id_hash = $3 FOR UPDATE
  DETAIL:  parameters: $1 = 'public', $2 = 'public', $3 = 'BThqQkbXJH-cxnDj-KFH2VZJlXLnm7l1Wt8fkEgn3fs='
LOG:  execute S_11: SELECT code_id, device_id_hash, link_code_hash, created_at FROM supertokens.passwordless_codes WHERE app_id = $1 AND tenant_id = $2 AND link_code_hash = $3
  DETAIL:  parameters: $1 = 'public', $2 = 'public', $3 = 'WLY7u9BZk-kceSoIY392YrbY3rBPPtLymLQHU1bL3LM='
LOG:  execute <unnamed>: DELETE FROM supertokens.passwordless_devices WHERE app_id = $1 AND tenant_id = $2 AND email = $3
  DETAIL:  parameters: $1 = 'public', $2 = 'public', $3 = 'bwinekrs@gmail.com'
LOG:  execute S_1: COMMIT
LOG:  execute <unnamed>: SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL READ COMMITTED
LOG:  execute <unnamed>: SELECT pl_users.user_id as user_id, pl_users.email as email, pl_users.phone_number as phone_number, pl_users.time_joined as time_joined FROM supertokens.passwordless_user_to_tenant AS pl_users_to_tenant JOIN supertokens.passwordless_users AS pl_users ON pl_users.app_id = pl_users_to_tenant.app_id AND pl_users.user_id = pl_users_to_tenant.user_id WHERE pl_users_to_tenant.app_id = $1 AND pl_users_to_tenant.tenant_id = $2 AND pl_users_to_tenant.email = $3 
  DETAIL:  parameters: $1 = 'public', $2 = 'public', $3 = 'bwinekrs@gmail.com'
LOG:  execute <unnamed>: SHOW TRANSACTION ISOLATION LEVEL
LOG:  execute <unnamed>: SET SESSION CHARACTERISTICS AS TRANSACTION ISOLATION LEVEL SERIALIZABLE
LOG:  execute S_9: BEGIN
LOG:  execute <unnamed>: INSERT INTO supertokens.app_id_to_user_id(app_id, user_id, recipe_id) VALUES($1, $2, $3)
  DETAIL:  parameters: $1 = 'public', $2 = 'f52ac1b9-6530-4f37-8739-1226bb8fbf17', $3 = 'passwordless'
LOG:  execute <unnamed>: INSERT INTO supertokens.all_auth_recipe_users(app_id, tenant_id, user_id, recipe_id, time_joined) VALUES($1, $2, $3, $4, $5)
  DETAIL:  parameters: $1 = 'public', $2 = 'public', $3 = 'f52ac1b9-6530-4f37-8739-1226bb8fbf17', $4 = 'passwordless', $5 = '1693965228468'
LOG:  execute <unnamed>: INSERT INTO supertokens.passwordless_users(app_id, user_id, email, phone_number, time_joined) VALUES($1, $2, $3, $4, $5)
  DETAIL:  parameters: $1 = 'public', $2 = 'f52ac1b9-6530-4f37-8739-1226bb8fbf17', $3 = 'bwinekrs@gmail.com', $4 = NULL, $5 = '1693965228468'
LOG:  execute <unnamed>: INSERT INTO supertokens.passwordless_user_to_tenant(app_id, tenant_id, user_id, email, phone_number) VALUES($1, $2, $3, $4, $5)
  DETAIL:  parameters: $1 = 'public', $2 = 'public', $3 = 'f52ac1b9-6530-4f37-8739-1226bb8fbf17', $4 = 'bwinekrs@gmail.com', $5 = NULL

 ERROR:  duplicate key value violates unique constraint "passwordless_user_to_tenant_email_key"
  DETAIL:  Key (app_id, tenant_id, email)=(public, public, bwinekrs@gmail.com) already exists.

STATEMENT:  INSERT INTO supertokens.passwordless_user_to_tenant(app_id, tenant_id, user_id, email, phone_number) VALUES($1, $2, $3, $4, $5)
LOG:  execute S_7: ROLLBACK