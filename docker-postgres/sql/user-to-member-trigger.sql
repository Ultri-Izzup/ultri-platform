GRANT USAGE ON SCHEMA nugget_api TO ultri_supertokens;
GRANT ALL ON ALL SEQUENCES IN SCHEMA nugget_api TO ultri_supertokens;
GRANT ALL ON ALL TABLES IN SCHEMA nugget_api TO ultri_supertokens;
CREATE OR REPLACE TRIGGER new_user_member_account AFTER INSERT ON supertokens.all_auth_recipe_users FOR EACH ROW EXECUTE FUNCTION nugget_api.new_member_from_user();