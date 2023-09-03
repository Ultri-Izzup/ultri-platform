--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7 (Debian 14.7-1.pgdg110+1)
-- Dumped by pg_dump version 14.9 (Ubuntu 14.9-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: supertokens; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA supertokens;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: all_auth_recipe_users; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.all_auth_recipe_users (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    tenant_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    user_id character(36) NOT NULL,
    recipe_id character varying(128) NOT NULL,
    time_joined bigint NOT NULL
);


--
-- Name: app_id_to_user_id; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.app_id_to_user_id (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    user_id character(36) NOT NULL,
    recipe_id character varying(128) NOT NULL
);


--
-- Name: apps; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.apps (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    created_at_time bigint
);


--
-- Name: dashboard_user_sessions; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.dashboard_user_sessions (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    session_id character(36) NOT NULL,
    user_id character(36) NOT NULL,
    time_created bigint NOT NULL,
    expiry bigint NOT NULL
);


--
-- Name: dashboard_users; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.dashboard_users (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    user_id character(36) NOT NULL,
    email character varying(256) NOT NULL,
    password_hash character varying(256) NOT NULL,
    time_joined bigint NOT NULL
);


--
-- Name: emailpassword_pswd_reset_tokens; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.emailpassword_pswd_reset_tokens (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    user_id character(36) NOT NULL,
    token character varying(128) NOT NULL,
    token_expiry bigint NOT NULL
);


--
-- Name: emailpassword_user_to_tenant; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.emailpassword_user_to_tenant (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    tenant_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    user_id character(36) NOT NULL,
    email character varying(256) NOT NULL
);


--
-- Name: emailpassword_users; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.emailpassword_users (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    user_id character(36) NOT NULL,
    email character varying(256) NOT NULL,
    password_hash character varying(256) NOT NULL,
    time_joined bigint NOT NULL
);


--
-- Name: emailverification_tokens; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.emailverification_tokens (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    tenant_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    user_id character varying(128) NOT NULL,
    email character varying(256) NOT NULL,
    token character varying(128) NOT NULL,
    token_expiry bigint NOT NULL
);


--
-- Name: emailverification_verified_emails; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.emailverification_verified_emails (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    user_id character varying(128) NOT NULL,
    email character varying(256) NOT NULL
);


--
-- Name: jwt_signing_keys; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.jwt_signing_keys (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    key_id character varying(255) NOT NULL,
    key_string text NOT NULL,
    algorithm character varying(10) NOT NULL,
    created_at bigint
);


--
-- Name: key_value; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.key_value (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    tenant_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    name character varying(128) NOT NULL,
    value text,
    created_at_time bigint
);


--
-- Name: passwordless_codes; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.passwordless_codes (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    tenant_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    code_id character(36) NOT NULL,
    device_id_hash character(44) NOT NULL,
    link_code_hash character(44) NOT NULL,
    created_at bigint NOT NULL
);


--
-- Name: passwordless_devices; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.passwordless_devices (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    tenant_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    device_id_hash character(44) NOT NULL,
    email character varying(256),
    phone_number character varying(256),
    link_code_salt character(44) NOT NULL,
    failed_attempts integer NOT NULL
);


--
-- Name: passwordless_user_to_tenant; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.passwordless_user_to_tenant (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    tenant_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    user_id character(36) NOT NULL,
    email character varying(256),
    phone_number character varying(256)
);


--
-- Name: passwordless_users; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.passwordless_users (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    user_id character(36) NOT NULL,
    email character varying(256),
    phone_number character varying(256),
    time_joined bigint NOT NULL
);


--
-- Name: role_permissions; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.role_permissions (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    role character varying(255) NOT NULL,
    permission character varying(255) NOT NULL
);


--
-- Name: roles; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.roles (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    role character varying(255) NOT NULL
);


--
-- Name: session_access_token_signing_keys; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.session_access_token_signing_keys (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    created_at_time bigint NOT NULL,
    value text
);


--
-- Name: session_info; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.session_info (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    tenant_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    session_handle character varying(255) NOT NULL,
    user_id character varying(128) NOT NULL,
    refresh_token_hash_2 character varying(128) NOT NULL,
    session_data text,
    expires_at bigint NOT NULL,
    created_at_time bigint NOT NULL,
    jwt_user_payload text,
    use_static_key boolean NOT NULL
);


--
-- Name: tenant_configs; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.tenant_configs (
    connection_uri_domain character varying(256) DEFAULT ''::character varying NOT NULL,
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    tenant_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    core_config text,
    email_password_enabled boolean,
    passwordless_enabled boolean,
    third_party_enabled boolean
);


--
-- Name: tenant_thirdparty_provider_clients; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.tenant_thirdparty_provider_clients (
    connection_uri_domain character varying(256) DEFAULT ''::character varying NOT NULL,
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    tenant_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    third_party_id character varying(28) NOT NULL,
    client_type character varying(64) DEFAULT ''::character varying NOT NULL,
    client_id character varying(256) NOT NULL,
    client_secret text,
    scope character varying(128)[],
    force_pkce boolean,
    additional_config text
);


--
-- Name: tenant_thirdparty_providers; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.tenant_thirdparty_providers (
    connection_uri_domain character varying(256) DEFAULT ''::character varying NOT NULL,
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    tenant_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    third_party_id character varying(28) NOT NULL,
    name character varying(64),
    authorization_endpoint text,
    authorization_endpoint_query_params text,
    token_endpoint text,
    token_endpoint_body_params text,
    user_info_endpoint text,
    user_info_endpoint_query_params text,
    user_info_endpoint_headers text,
    jwks_uri text,
    oidc_discovery_endpoint text,
    require_email boolean,
    user_info_map_from_id_token_payload_user_id character varying(64),
    user_info_map_from_id_token_payload_email character varying(64),
    user_info_map_from_id_token_payload_email_verified character varying(64),
    user_info_map_from_user_info_endpoint_user_id character varying(64),
    user_info_map_from_user_info_endpoint_email character varying(64),
    user_info_map_from_user_info_endpoint_email_verified character varying(64)
);


--
-- Name: tenants; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.tenants (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    tenant_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    created_at_time bigint
);


--
-- Name: thirdparty_user_to_tenant; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.thirdparty_user_to_tenant (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    tenant_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    user_id character(36) NOT NULL,
    third_party_id character varying(28) NOT NULL,
    third_party_user_id character varying(256) NOT NULL
);


--
-- Name: thirdparty_users; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.thirdparty_users (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    third_party_id character varying(28) NOT NULL,
    third_party_user_id character varying(256) NOT NULL,
    user_id character(36) NOT NULL,
    email character varying(256) NOT NULL,
    time_joined bigint NOT NULL
);


--
-- Name: totp_used_codes; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.totp_used_codes (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    tenant_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    user_id character varying(128) NOT NULL,
    code character varying(8) NOT NULL,
    is_valid boolean NOT NULL,
    expiry_time_ms bigint NOT NULL,
    created_time_ms bigint NOT NULL
);


--
-- Name: totp_user_devices; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.totp_user_devices (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    user_id character varying(128) NOT NULL,
    device_name character varying(256) NOT NULL,
    secret_key character varying(256) NOT NULL,
    period integer NOT NULL,
    skew integer NOT NULL,
    verified boolean NOT NULL
);


--
-- Name: totp_users; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.totp_users (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    user_id character varying(128) NOT NULL
);


--
-- Name: user_last_active; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.user_last_active (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    user_id character varying(128) NOT NULL,
    last_active_time bigint
);


--
-- Name: user_metadata; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.user_metadata (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    user_id character varying(128) NOT NULL,
    user_metadata text NOT NULL
);


--
-- Name: user_roles; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.user_roles (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    tenant_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    user_id character varying(128) NOT NULL,
    role character varying(255) NOT NULL
);


--
-- Name: userid_mapping; Type: TABLE; Schema: supertokens; Owner: -
--

CREATE TABLE supertokens.userid_mapping (
    app_id character varying(64) DEFAULT 'supertokens'::character varying NOT NULL,
    supertokens_user_id character(36) NOT NULL,
    external_user_id character varying(128) NOT NULL,
    external_user_id_info text
);


--
-- Name: all_auth_recipe_users all_auth_recipe_users_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.all_auth_recipe_users
    ADD CONSTRAINT all_auth_recipe_users_pkey PRIMARY KEY (app_id, tenant_id, user_id);


--
-- Name: app_id_to_user_id app_id_to_user_id_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.app_id_to_user_id
    ADD CONSTRAINT app_id_to_user_id_pkey PRIMARY KEY (app_id, user_id);


--
-- Name: apps apps_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.apps
    ADD CONSTRAINT apps_pkey PRIMARY KEY (app_id);


--
-- Name: dashboard_user_sessions dashboard_user_sessions_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.dashboard_user_sessions
    ADD CONSTRAINT dashboard_user_sessions_pkey PRIMARY KEY (app_id, session_id);


--
-- Name: dashboard_users dashboard_users_email_key; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.dashboard_users
    ADD CONSTRAINT dashboard_users_email_key UNIQUE (app_id, email);


--
-- Name: dashboard_users dashboard_users_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.dashboard_users
    ADD CONSTRAINT dashboard_users_pkey PRIMARY KEY (app_id, user_id);


--
-- Name: emailpassword_pswd_reset_tokens emailpassword_pswd_reset_tokens_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.emailpassword_pswd_reset_tokens
    ADD CONSTRAINT emailpassword_pswd_reset_tokens_pkey PRIMARY KEY (app_id, user_id, token);


--
-- Name: emailpassword_pswd_reset_tokens emailpassword_pswd_reset_tokens_token_key; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.emailpassword_pswd_reset_tokens
    ADD CONSTRAINT emailpassword_pswd_reset_tokens_token_key UNIQUE (token);


--
-- Name: emailpassword_user_to_tenant emailpassword_user_to_tenant_email_key; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.emailpassword_user_to_tenant
    ADD CONSTRAINT emailpassword_user_to_tenant_email_key UNIQUE (app_id, tenant_id, email);


--
-- Name: emailpassword_user_to_tenant emailpassword_user_to_tenant_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.emailpassword_user_to_tenant
    ADD CONSTRAINT emailpassword_user_to_tenant_pkey PRIMARY KEY (app_id, tenant_id, user_id);


--
-- Name: emailpassword_users emailpassword_users_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.emailpassword_users
    ADD CONSTRAINT emailpassword_users_pkey PRIMARY KEY (app_id, user_id);


--
-- Name: emailverification_tokens emailverification_tokens_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.emailverification_tokens
    ADD CONSTRAINT emailverification_tokens_pkey PRIMARY KEY (app_id, tenant_id, user_id, email, token);


--
-- Name: emailverification_tokens emailverification_tokens_token_key; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.emailverification_tokens
    ADD CONSTRAINT emailverification_tokens_token_key UNIQUE (token);


--
-- Name: emailverification_verified_emails emailverification_verified_emails_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.emailverification_verified_emails
    ADD CONSTRAINT emailverification_verified_emails_pkey PRIMARY KEY (app_id, user_id, email);


--
-- Name: jwt_signing_keys jwt_signing_keys_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.jwt_signing_keys
    ADD CONSTRAINT jwt_signing_keys_pkey PRIMARY KEY (app_id, key_id);


--
-- Name: key_value key_value_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.key_value
    ADD CONSTRAINT key_value_pkey PRIMARY KEY (app_id, tenant_id, name);


--
-- Name: passwordless_codes passwordless_codes_link_code_hash_key; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.passwordless_codes
    ADD CONSTRAINT passwordless_codes_link_code_hash_key UNIQUE (app_id, tenant_id, link_code_hash);


--
-- Name: passwordless_codes passwordless_codes_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.passwordless_codes
    ADD CONSTRAINT passwordless_codes_pkey PRIMARY KEY (app_id, tenant_id, code_id);


--
-- Name: passwordless_devices passwordless_devices_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.passwordless_devices
    ADD CONSTRAINT passwordless_devices_pkey PRIMARY KEY (app_id, tenant_id, device_id_hash);


--
-- Name: passwordless_user_to_tenant passwordless_user_to_tenant_email_key; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.passwordless_user_to_tenant
    ADD CONSTRAINT passwordless_user_to_tenant_email_key UNIQUE (app_id, tenant_id, email);


--
-- Name: passwordless_user_to_tenant passwordless_user_to_tenant_phone_number_key; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.passwordless_user_to_tenant
    ADD CONSTRAINT passwordless_user_to_tenant_phone_number_key UNIQUE (app_id, tenant_id, phone_number);


--
-- Name: passwordless_user_to_tenant passwordless_user_to_tenant_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.passwordless_user_to_tenant
    ADD CONSTRAINT passwordless_user_to_tenant_pkey PRIMARY KEY (app_id, tenant_id, user_id);


--
-- Name: passwordless_users passwordless_users_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.passwordless_users
    ADD CONSTRAINT passwordless_users_pkey PRIMARY KEY (app_id, user_id);


--
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (app_id, role, permission);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (app_id, role);


--
-- Name: session_access_token_signing_keys session_access_token_signing_keys_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.session_access_token_signing_keys
    ADD CONSTRAINT session_access_token_signing_keys_pkey PRIMARY KEY (app_id, created_at_time);


--
-- Name: session_info session_info_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.session_info
    ADD CONSTRAINT session_info_pkey PRIMARY KEY (app_id, tenant_id, session_handle);


--
-- Name: tenant_configs tenant_configs_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.tenant_configs
    ADD CONSTRAINT tenant_configs_pkey PRIMARY KEY (connection_uri_domain, app_id, tenant_id);


--
-- Name: tenant_thirdparty_provider_clients tenant_thirdparty_provider_clients_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.tenant_thirdparty_provider_clients
    ADD CONSTRAINT tenant_thirdparty_provider_clients_pkey PRIMARY KEY (connection_uri_domain, app_id, tenant_id, third_party_id, client_type);


--
-- Name: tenant_thirdparty_providers tenant_thirdparty_providers_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.tenant_thirdparty_providers
    ADD CONSTRAINT tenant_thirdparty_providers_pkey PRIMARY KEY (connection_uri_domain, app_id, tenant_id, third_party_id);


--
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (app_id, tenant_id);


--
-- Name: thirdparty_user_to_tenant thirdparty_user_to_tenant_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.thirdparty_user_to_tenant
    ADD CONSTRAINT thirdparty_user_to_tenant_pkey PRIMARY KEY (app_id, tenant_id, user_id);


--
-- Name: thirdparty_user_to_tenant thirdparty_user_to_tenant_third_party_user_id_key; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.thirdparty_user_to_tenant
    ADD CONSTRAINT thirdparty_user_to_tenant_third_party_user_id_key UNIQUE (app_id, tenant_id, third_party_id, third_party_user_id);


--
-- Name: thirdparty_users thirdparty_users_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.thirdparty_users
    ADD CONSTRAINT thirdparty_users_pkey PRIMARY KEY (app_id, user_id);


--
-- Name: totp_used_codes totp_used_codes_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.totp_used_codes
    ADD CONSTRAINT totp_used_codes_pkey PRIMARY KEY (app_id, tenant_id, user_id, created_time_ms);


--
-- Name: totp_user_devices totp_user_devices_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.totp_user_devices
    ADD CONSTRAINT totp_user_devices_pkey PRIMARY KEY (app_id, user_id, device_name);


--
-- Name: totp_users totp_users_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.totp_users
    ADD CONSTRAINT totp_users_pkey PRIMARY KEY (app_id, user_id);


--
-- Name: user_last_active user_last_active_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.user_last_active
    ADD CONSTRAINT user_last_active_pkey PRIMARY KEY (app_id, user_id);


--
-- Name: user_metadata user_metadata_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.user_metadata
    ADD CONSTRAINT user_metadata_pkey PRIMARY KEY (app_id, user_id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (app_id, tenant_id, user_id, role);


--
-- Name: userid_mapping userid_mapping_external_user_id_key; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.userid_mapping
    ADD CONSTRAINT userid_mapping_external_user_id_key UNIQUE (app_id, external_user_id);


--
-- Name: userid_mapping userid_mapping_pkey; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.userid_mapping
    ADD CONSTRAINT userid_mapping_pkey PRIMARY KEY (app_id, supertokens_user_id, external_user_id);


--
-- Name: userid_mapping userid_mapping_supertokens_user_id_key; Type: CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.userid_mapping
    ADD CONSTRAINT userid_mapping_supertokens_user_id_key UNIQUE (app_id, supertokens_user_id);


--
-- Name: access_token_signing_keys_app_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX access_token_signing_keys_app_id_index ON supertokens.session_access_token_signing_keys USING btree (app_id);


--
-- Name: all_auth_recipe_tenant_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX all_auth_recipe_tenant_id_index ON supertokens.all_auth_recipe_users USING btree (app_id, tenant_id);


--
-- Name: all_auth_recipe_user_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX all_auth_recipe_user_id_index ON supertokens.all_auth_recipe_users USING btree (app_id, user_id);


--
-- Name: all_auth_recipe_users_pagination_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX all_auth_recipe_users_pagination_index ON supertokens.all_auth_recipe_users USING btree (time_joined DESC, user_id DESC, tenant_id DESC, app_id DESC);


--
-- Name: app_id_to_user_id_app_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX app_id_to_user_id_app_id_index ON supertokens.app_id_to_user_id USING btree (app_id);


--
-- Name: dashboard_user_sessions_expiry_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX dashboard_user_sessions_expiry_index ON supertokens.dashboard_user_sessions USING btree (expiry);


--
-- Name: dashboard_user_sessions_user_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX dashboard_user_sessions_user_id_index ON supertokens.dashboard_user_sessions USING btree (app_id, user_id);


--
-- Name: dashboard_users_app_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX dashboard_users_app_id_index ON supertokens.dashboard_users USING btree (app_id);


--
-- Name: emailpassword_password_reset_token_expiry_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX emailpassword_password_reset_token_expiry_index ON supertokens.emailpassword_pswd_reset_tokens USING btree (token_expiry);


--
-- Name: emailpassword_pswd_reset_tokens_user_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX emailpassword_pswd_reset_tokens_user_id_index ON supertokens.emailpassword_pswd_reset_tokens USING btree (app_id, user_id);


--
-- Name: emailverification_tokens_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX emailverification_tokens_index ON supertokens.emailverification_tokens USING btree (token_expiry);


--
-- Name: emailverification_tokens_tenant_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX emailverification_tokens_tenant_id_index ON supertokens.emailverification_tokens USING btree (app_id, tenant_id);


--
-- Name: emailverification_verified_emails_app_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX emailverification_verified_emails_app_id_index ON supertokens.emailverification_verified_emails USING btree (app_id);


--
-- Name: jwt_signing_keys_app_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX jwt_signing_keys_app_id_index ON supertokens.jwt_signing_keys USING btree (app_id);


--
-- Name: key_value_tenant_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX key_value_tenant_id_index ON supertokens.key_value USING btree (app_id, tenant_id);


--
-- Name: passwordless_codes_created_at_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX passwordless_codes_created_at_index ON supertokens.passwordless_codes USING btree (app_id, tenant_id, created_at);


--
-- Name: passwordless_codes_device_id_hash_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX passwordless_codes_device_id_hash_index ON supertokens.passwordless_codes USING btree (app_id, tenant_id, device_id_hash);


--
-- Name: passwordless_devices_email_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX passwordless_devices_email_index ON supertokens.passwordless_devices USING btree (app_id, tenant_id, email);


--
-- Name: passwordless_devices_phone_number_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX passwordless_devices_phone_number_index ON supertokens.passwordless_devices USING btree (app_id, tenant_id, phone_number);


--
-- Name: passwordless_devices_tenant_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX passwordless_devices_tenant_id_index ON supertokens.passwordless_devices USING btree (app_id, tenant_id);


--
-- Name: role_permissions_permission_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX role_permissions_permission_index ON supertokens.role_permissions USING btree (app_id, permission);


--
-- Name: role_permissions_role_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX role_permissions_role_index ON supertokens.role_permissions USING btree (app_id, role);


--
-- Name: roles_app_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX roles_app_id_index ON supertokens.roles USING btree (app_id);


--
-- Name: session_expiry_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX session_expiry_index ON supertokens.session_info USING btree (expires_at);


--
-- Name: session_info_tenant_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX session_info_tenant_id_index ON supertokens.session_info USING btree (app_id, tenant_id);


--
-- Name: tenant_thirdparty_provider_clients_third_party_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX tenant_thirdparty_provider_clients_third_party_id_index ON supertokens.tenant_thirdparty_provider_clients USING btree (connection_uri_domain, app_id, tenant_id, third_party_id);


--
-- Name: tenant_thirdparty_providers_tenant_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX tenant_thirdparty_providers_tenant_id_index ON supertokens.tenant_thirdparty_providers USING btree (connection_uri_domain, app_id, tenant_id);


--
-- Name: tenants_app_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX tenants_app_id_index ON supertokens.tenants USING btree (app_id);


--
-- Name: thirdparty_users_email_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX thirdparty_users_email_index ON supertokens.thirdparty_users USING btree (app_id, email);


--
-- Name: thirdparty_users_thirdparty_user_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX thirdparty_users_thirdparty_user_id_index ON supertokens.thirdparty_users USING btree (app_id, third_party_id, third_party_user_id);


--
-- Name: totp_used_codes_expiry_time_ms_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX totp_used_codes_expiry_time_ms_index ON supertokens.totp_used_codes USING btree (app_id, tenant_id, expiry_time_ms);


--
-- Name: totp_used_codes_tenant_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX totp_used_codes_tenant_id_index ON supertokens.totp_used_codes USING btree (app_id, tenant_id);


--
-- Name: totp_used_codes_user_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX totp_used_codes_user_id_index ON supertokens.totp_used_codes USING btree (app_id, user_id);


--
-- Name: totp_user_devices_user_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX totp_user_devices_user_id_index ON supertokens.totp_user_devices USING btree (app_id, user_id);


--
-- Name: totp_users_app_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX totp_users_app_id_index ON supertokens.totp_users USING btree (app_id);


--
-- Name: user_last_active_app_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX user_last_active_app_id_index ON supertokens.user_last_active USING btree (app_id);


--
-- Name: user_metadata_app_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX user_metadata_app_id_index ON supertokens.user_metadata USING btree (app_id);


--
-- Name: user_roles_app_id_role_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX user_roles_app_id_role_index ON supertokens.user_roles USING btree (app_id, role);


--
-- Name: user_roles_role_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX user_roles_role_index ON supertokens.user_roles USING btree (app_id, tenant_id, role);


--
-- Name: user_roles_tenant_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX user_roles_tenant_id_index ON supertokens.user_roles USING btree (app_id, tenant_id);


--
-- Name: userid_mapping_supertokens_user_id_index; Type: INDEX; Schema: supertokens; Owner: -
--

CREATE INDEX userid_mapping_supertokens_user_id_index ON supertokens.userid_mapping USING btree (app_id, supertokens_user_id);


--
-- Name: all_auth_recipe_users create_member_from_user; Type: TRIGGER; Schema: supertokens; Owner: -
--

CREATE TRIGGER create_member_from_user AFTER INSERT ON supertokens.all_auth_recipe_users FOR EACH ROW EXECUTE FUNCTION nugget_api.new_member_from_user();


--
-- Name: emailpassword_users update_emailpassword_email; Type: TRIGGER; Schema: supertokens; Owner: -
--

CREATE TRIGGER update_emailpassword_email AFTER INSERT ON supertokens.emailpassword_users FOR EACH ROW EXECUTE FUNCTION nugget_api.update_member_email();


--
-- Name: passwordless_users update_passwordless_email; Type: TRIGGER; Schema: supertokens; Owner: -
--

CREATE TRIGGER update_passwordless_email AFTER INSERT ON supertokens.passwordless_users FOR EACH ROW EXECUTE FUNCTION nugget_api.update_member_email();


--
-- Name: all_auth_recipe_users all_auth_recipe_users_tenant_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.all_auth_recipe_users
    ADD CONSTRAINT all_auth_recipe_users_tenant_id_fkey FOREIGN KEY (app_id, tenant_id) REFERENCES supertokens.tenants(app_id, tenant_id) ON DELETE CASCADE;


--
-- Name: all_auth_recipe_users all_auth_recipe_users_user_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.all_auth_recipe_users
    ADD CONSTRAINT all_auth_recipe_users_user_id_fkey FOREIGN KEY (app_id, user_id) REFERENCES supertokens.app_id_to_user_id(app_id, user_id) ON DELETE CASCADE;


--
-- Name: app_id_to_user_id app_id_to_user_id_app_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.app_id_to_user_id
    ADD CONSTRAINT app_id_to_user_id_app_id_fkey FOREIGN KEY (app_id) REFERENCES supertokens.apps(app_id) ON DELETE CASCADE;


--
-- Name: dashboard_user_sessions dashboard_user_sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.dashboard_user_sessions
    ADD CONSTRAINT dashboard_user_sessions_user_id_fkey FOREIGN KEY (app_id, user_id) REFERENCES supertokens.dashboard_users(app_id, user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: dashboard_users dashboard_users_app_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.dashboard_users
    ADD CONSTRAINT dashboard_users_app_id_fkey FOREIGN KEY (app_id) REFERENCES supertokens.apps(app_id) ON DELETE CASCADE;


--
-- Name: emailpassword_pswd_reset_tokens emailpassword_pswd_reset_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.emailpassword_pswd_reset_tokens
    ADD CONSTRAINT emailpassword_pswd_reset_tokens_user_id_fkey FOREIGN KEY (app_id, user_id) REFERENCES supertokens.emailpassword_users(app_id, user_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: emailpassword_user_to_tenant emailpassword_user_to_tenant_user_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.emailpassword_user_to_tenant
    ADD CONSTRAINT emailpassword_user_to_tenant_user_id_fkey FOREIGN KEY (app_id, tenant_id, user_id) REFERENCES supertokens.all_auth_recipe_users(app_id, tenant_id, user_id) ON DELETE CASCADE;


--
-- Name: emailpassword_users emailpassword_users_user_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.emailpassword_users
    ADD CONSTRAINT emailpassword_users_user_id_fkey FOREIGN KEY (app_id, user_id) REFERENCES supertokens.app_id_to_user_id(app_id, user_id) ON DELETE CASCADE;


--
-- Name: emailverification_tokens emailverification_tokens_tenant_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.emailverification_tokens
    ADD CONSTRAINT emailverification_tokens_tenant_id_fkey FOREIGN KEY (app_id, tenant_id) REFERENCES supertokens.tenants(app_id, tenant_id) ON DELETE CASCADE;


--
-- Name: emailverification_verified_emails emailverification_verified_emails_app_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.emailverification_verified_emails
    ADD CONSTRAINT emailverification_verified_emails_app_id_fkey FOREIGN KEY (app_id) REFERENCES supertokens.apps(app_id) ON DELETE CASCADE;


--
-- Name: jwt_signing_keys jwt_signing_keys_app_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.jwt_signing_keys
    ADD CONSTRAINT jwt_signing_keys_app_id_fkey FOREIGN KEY (app_id) REFERENCES supertokens.apps(app_id) ON DELETE CASCADE;


--
-- Name: key_value key_value_tenant_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.key_value
    ADD CONSTRAINT key_value_tenant_id_fkey FOREIGN KEY (app_id, tenant_id) REFERENCES supertokens.tenants(app_id, tenant_id) ON DELETE CASCADE;


--
-- Name: passwordless_codes passwordless_codes_device_id_hash_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.passwordless_codes
    ADD CONSTRAINT passwordless_codes_device_id_hash_fkey FOREIGN KEY (app_id, tenant_id, device_id_hash) REFERENCES supertokens.passwordless_devices(app_id, tenant_id, device_id_hash) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: passwordless_devices passwordless_devices_tenant_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.passwordless_devices
    ADD CONSTRAINT passwordless_devices_tenant_id_fkey FOREIGN KEY (app_id, tenant_id) REFERENCES supertokens.tenants(app_id, tenant_id) ON DELETE CASCADE;


--
-- Name: passwordless_user_to_tenant passwordless_user_to_tenant_user_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.passwordless_user_to_tenant
    ADD CONSTRAINT passwordless_user_to_tenant_user_id_fkey FOREIGN KEY (app_id, tenant_id, user_id) REFERENCES supertokens.all_auth_recipe_users(app_id, tenant_id, user_id) ON DELETE CASCADE;


--
-- Name: passwordless_users passwordless_users_user_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.passwordless_users
    ADD CONSTRAINT passwordless_users_user_id_fkey FOREIGN KEY (app_id, user_id) REFERENCES supertokens.app_id_to_user_id(app_id, user_id) ON DELETE CASCADE;


--
-- Name: role_permissions role_permissions_role_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.role_permissions
    ADD CONSTRAINT role_permissions_role_fkey FOREIGN KEY (app_id, role) REFERENCES supertokens.roles(app_id, role) ON DELETE CASCADE;


--
-- Name: roles roles_app_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.roles
    ADD CONSTRAINT roles_app_id_fkey FOREIGN KEY (app_id) REFERENCES supertokens.apps(app_id) ON DELETE CASCADE;


--
-- Name: session_access_token_signing_keys session_access_token_signing_keys_app_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.session_access_token_signing_keys
    ADD CONSTRAINT session_access_token_signing_keys_app_id_fkey FOREIGN KEY (app_id) REFERENCES supertokens.apps(app_id) ON DELETE CASCADE;


--
-- Name: session_info session_info_tenant_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.session_info
    ADD CONSTRAINT session_info_tenant_id_fkey FOREIGN KEY (app_id, tenant_id) REFERENCES supertokens.tenants(app_id, tenant_id) ON DELETE CASCADE;


--
-- Name: tenant_thirdparty_provider_clients tenant_thirdparty_provider_clients_third_party_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.tenant_thirdparty_provider_clients
    ADD CONSTRAINT tenant_thirdparty_provider_clients_third_party_id_fkey FOREIGN KEY (connection_uri_domain, app_id, tenant_id, third_party_id) REFERENCES supertokens.tenant_thirdparty_providers(connection_uri_domain, app_id, tenant_id, third_party_id) ON DELETE CASCADE;


--
-- Name: tenant_thirdparty_providers tenant_thirdparty_providers_tenant_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.tenant_thirdparty_providers
    ADD CONSTRAINT tenant_thirdparty_providers_tenant_id_fkey FOREIGN KEY (connection_uri_domain, app_id, tenant_id) REFERENCES supertokens.tenant_configs(connection_uri_domain, app_id, tenant_id) ON DELETE CASCADE;


--
-- Name: tenants tenants_app_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.tenants
    ADD CONSTRAINT tenants_app_id_fkey FOREIGN KEY (app_id) REFERENCES supertokens.apps(app_id) ON DELETE CASCADE;


--
-- Name: thirdparty_user_to_tenant thirdparty_user_to_tenant_user_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.thirdparty_user_to_tenant
    ADD CONSTRAINT thirdparty_user_to_tenant_user_id_fkey FOREIGN KEY (app_id, tenant_id, user_id) REFERENCES supertokens.all_auth_recipe_users(app_id, tenant_id, user_id) ON DELETE CASCADE;


--
-- Name: thirdparty_users thirdparty_users_user_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.thirdparty_users
    ADD CONSTRAINT thirdparty_users_user_id_fkey FOREIGN KEY (app_id, user_id) REFERENCES supertokens.app_id_to_user_id(app_id, user_id) ON DELETE CASCADE;


--
-- Name: totp_used_codes totp_used_codes_tenant_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.totp_used_codes
    ADD CONSTRAINT totp_used_codes_tenant_id_fkey FOREIGN KEY (app_id, tenant_id) REFERENCES supertokens.tenants(app_id, tenant_id) ON DELETE CASCADE;


--
-- Name: totp_used_codes totp_used_codes_user_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.totp_used_codes
    ADD CONSTRAINT totp_used_codes_user_id_fkey FOREIGN KEY (app_id, user_id) REFERENCES supertokens.totp_users(app_id, user_id) ON DELETE CASCADE;


--
-- Name: totp_user_devices totp_user_devices_user_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.totp_user_devices
    ADD CONSTRAINT totp_user_devices_user_id_fkey FOREIGN KEY (app_id, user_id) REFERENCES supertokens.totp_users(app_id, user_id) ON DELETE CASCADE;


--
-- Name: totp_users totp_users_app_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.totp_users
    ADD CONSTRAINT totp_users_app_id_fkey FOREIGN KEY (app_id) REFERENCES supertokens.apps(app_id) ON DELETE CASCADE;


--
-- Name: user_last_active user_last_active_app_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.user_last_active
    ADD CONSTRAINT user_last_active_app_id_fkey FOREIGN KEY (app_id) REFERENCES supertokens.apps(app_id) ON DELETE CASCADE;


--
-- Name: user_metadata user_metadata_app_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.user_metadata
    ADD CONSTRAINT user_metadata_app_id_fkey FOREIGN KEY (app_id) REFERENCES supertokens.apps(app_id) ON DELETE CASCADE;


--
-- Name: user_roles user_roles_role_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.user_roles
    ADD CONSTRAINT user_roles_role_fkey FOREIGN KEY (app_id, role) REFERENCES supertokens.roles(app_id, role) ON DELETE CASCADE;


--
-- Name: user_roles user_roles_tenant_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.user_roles
    ADD CONSTRAINT user_roles_tenant_id_fkey FOREIGN KEY (app_id, tenant_id) REFERENCES supertokens.tenants(app_id, tenant_id) ON DELETE CASCADE;


--
-- Name: userid_mapping userid_mapping_supertokens_user_id_fkey; Type: FK CONSTRAINT; Schema: supertokens; Owner: -
--

ALTER TABLE ONLY supertokens.userid_mapping
    ADD CONSTRAINT userid_mapping_supertokens_user_id_fkey FOREIGN KEY (app_id, supertokens_user_id) REFERENCES supertokens.app_id_to_user_id(app_id, user_id) ON DELETE CASCADE;


--
-- Name: SCHEMA supertokens; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA supertokens TO nugget_api;


--
-- Name: TABLE all_auth_recipe_users; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.all_auth_recipe_users TO nugget_api;


--
-- Name: TABLE app_id_to_user_id; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.app_id_to_user_id TO nugget_api;


--
-- Name: TABLE apps; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.apps TO nugget_api;


--
-- Name: TABLE dashboard_user_sessions; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.dashboard_user_sessions TO nugget_api;


--
-- Name: TABLE dashboard_users; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.dashboard_users TO nugget_api;


--
-- Name: TABLE emailpassword_pswd_reset_tokens; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.emailpassword_pswd_reset_tokens TO nugget_api;


--
-- Name: TABLE emailpassword_user_to_tenant; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.emailpassword_user_to_tenant TO nugget_api;


--
-- Name: TABLE emailpassword_users; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.emailpassword_users TO nugget_api;


--
-- Name: TABLE emailverification_tokens; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.emailverification_tokens TO nugget_api;


--
-- Name: TABLE emailverification_verified_emails; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.emailverification_verified_emails TO nugget_api;


--
-- Name: TABLE jwt_signing_keys; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.jwt_signing_keys TO nugget_api;


--
-- Name: TABLE key_value; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.key_value TO nugget_api;


--
-- Name: TABLE passwordless_codes; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.passwordless_codes TO nugget_api;


--
-- Name: TABLE passwordless_devices; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.passwordless_devices TO nugget_api;


--
-- Name: TABLE passwordless_user_to_tenant; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.passwordless_user_to_tenant TO nugget_api;


--
-- Name: TABLE passwordless_users; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.passwordless_users TO nugget_api;


--
-- Name: TABLE role_permissions; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.role_permissions TO nugget_api;


--
-- Name: TABLE roles; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.roles TO nugget_api;


--
-- Name: TABLE session_access_token_signing_keys; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.session_access_token_signing_keys TO nugget_api;


--
-- Name: TABLE session_info; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.session_info TO nugget_api;


--
-- Name: TABLE tenant_configs; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.tenant_configs TO nugget_api;


--
-- Name: TABLE tenant_thirdparty_provider_clients; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.tenant_thirdparty_provider_clients TO nugget_api;


--
-- Name: TABLE tenant_thirdparty_providers; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.tenant_thirdparty_providers TO nugget_api;


--
-- Name: TABLE tenants; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.tenants TO nugget_api;


--
-- Name: TABLE thirdparty_user_to_tenant; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.thirdparty_user_to_tenant TO nugget_api;


--
-- Name: TABLE thirdparty_users; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.thirdparty_users TO nugget_api;


--
-- Name: TABLE totp_used_codes; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.totp_used_codes TO nugget_api;


--
-- Name: TABLE totp_user_devices; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.totp_user_devices TO nugget_api;


--
-- Name: TABLE totp_users; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.totp_users TO nugget_api;


--
-- Name: TABLE user_last_active; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.user_last_active TO nugget_api;


--
-- Name: TABLE user_metadata; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.user_metadata TO nugget_api;


--
-- Name: TABLE user_roles; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.user_roles TO nugget_api;


--
-- Name: TABLE userid_mapping; Type: ACL; Schema: supertokens; Owner: -
--

GRANT ALL ON TABLE supertokens.userid_mapping TO nugget_api;


--
-- PostgreSQL database dump complete
--

