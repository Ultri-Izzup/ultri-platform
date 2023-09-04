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
-- Name: nugget; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA nugget;


--
-- Name: account_roles; Type: TYPE; Schema: nugget; Owner: -
--

CREATE TYPE nugget.account_roles AS ENUM (
    'owner',
    'admin',
    'member'
);


--
-- Name: canvas_templates; Type: TYPE; Schema: nugget; Owner: -
--

CREATE TYPE nugget.canvas_templates AS ENUM (
    'custom',
    'businessModel',
    'coopOwnership',
    'leanCanvas',
    'leanUX',
    'productCanvas',
    'productVisionBoard',
    'productVisionBoardExt',
    's3Delegation',
    's3Organization',
    's3Team'
);


--
-- Name: circle_roles; Type: TYPE; Schema: nugget; Owner: -
--

CREATE TYPE nugget.circle_roles AS ENUM (
    'leader',
    'delegate',
    'secretary',
    'facilitator',
    'peer',
    'member'
);


--
-- Name: invite_status; Type: TYPE; Schema: nugget; Owner: -
--

CREATE TYPE nugget.invite_status AS ENUM (
    'submitted',
    'sending',
    'sent',
    'failed',
    'accepted',
    'rejected',
    'expired',
    'resend',
    'withdrawn'
);


--
-- Name: new_member_from_user(); Type: FUNCTION; Schema: nugget; Owner: -
--

CREATE FUNCTION nugget.new_member_from_user() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE new_member_id BIGINT;
	DECLARE new_account_id BIGINT;	
BEGIN

	INSERT INTO nugget.member(uid, created_at, tenant_id)
	 VALUES(uuid(NEW.user_id), to_timestamp(NEW.time_joined/1000), 1 )
	 RETURNING id INTO new_member_id;
	
	INSERT INTO nugget.account(name, tenant_id)
		 VALUES('Member Account for ' || new_member_id, 1)
		 RETURNING id INTO new_account_id;
		
	INSERT INTO nugget.account_member(account_id, member_id, roles)
		 VALUES(new_account_id, new_member_id, '{"owner"}');
		 RETURN NEW;
END;
$$;


--
-- Name: set_member_canvas(character varying, uuid, uuid, character varying, nugget.canvas_templates, character varying, jsonb, boolean, character varying, character varying, character varying, character varying, boolean, character varying[], character varying[]); Type: FUNCTION; Schema: nugget; Owner: -
--

CREATE FUNCTION nugget.set_member_canvas(in_tenant_name character varying, in_member_uid uuid, in_canvas_uid uuid, in_name character varying, in_template nugget.canvas_templates, in_attribution character varying, in_sections jsonb, in_sequenced boolean, in_canava_version character varying, in_completed_on character varying, in_completed_by character varying, in_version character varying, in_public boolean, in_editors character varying[], in_viewers character varying[]) RETURNS TABLE("createdAt" timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
#variable_conflict use_column

DECLARE valid_tenant_id bigint;
DECLARE valid_member_id bigint;
DECLARE new_record_created_at timestamp without time zone;

BEGIN

SELECT id FROM nugget.tenant WHERE name = in_tenant_name INTO valid_tenant_id;
SELECT id FROM nugget.member WHERE uid = in_member_uid AND tenant_id = valid_tenant_id INTO valid_member_id;

INSERT INTO nugget.member_canvas(
		uid,
        member_id,
        name, 
        template, 
        attribution, 
        sections, 
        sequenced, 
        canava_version, 
        completed_on, 
        completed_by, 
        version, 
        public, 
        editors, 
        viewers,
        created_by)
        VALUES (
			in_canvas_uid,
			valid_member_id, 
			in_name,
			in_template::canvas_templates, 
			in_attribution,
			in_sections, 
			in_sequenced, 
			in_canava_version,
			in_completed_on, 
			in_completed_by, 
			in_version,
			in_public,
			in_editors,
			in_viewers,
		    valid_member_id
			)
		ON CONFLICT ON CONSTRAINT uq_member_canvas_uid 
		DO UPDATE SET 
		name = EXCLUDED.name,
		attribution = EXCLUDED.attribution,
		sections = EXCLUDED.sections,
		sequenced = EXCLUDED.sequenced,
		canava_version = EXCLUDED.canava_version,
		completed_on = EXCLUDED.completed_on,
		completed_by = EXCLUDED.completed_by,
		version = EXCLUDED.version,
		public = EXCLUDED.public,
		editors = EXCLUDED.editors,
		viewers = EXCLUDED.viewers
		
 	RETURNING nugget.member_canvas.created_at INTO new_record_created_at;
	
	RETURN QUERY SELECT new_record_created_at;
	
END; 
$$;


--
-- Name: set_updated_at(); Type: FUNCTION; Schema: nugget; Owner: -
--

CREATE FUNCTION nugget.set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;


--
-- Name: update_member_email(); Type: FUNCTION; Schema: nugget; Owner: -
--

CREATE FUNCTION nugget.update_member_email() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN
	UPDATE nugget.member 
	SET email = NEW.email
	WHERE uid::text = NEW.user_id ;
 RETURN NULL;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.account (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    tenant_id bigint NOT NULL,
    name character varying(64),
    deleted boolean DEFAULT false NOT NULL,
    created_by bigint,
    updated_by bigint
);


--
-- Name: account_id_seq; Type: SEQUENCE; Schema: nugget; Owner: -
--

CREATE SEQUENCE nugget.account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: account_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget; Owner: -
--

ALTER SEQUENCE nugget.account_id_seq OWNED BY nugget.account.id;


--
-- Name: account_member; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.account_member (
    account_id bigint NOT NULL,
    member_id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_by bigint,
    updated_at timestamp without time zone,
    updated_by bigint,
    roles nugget.account_roles[] DEFAULT '{member}'::nugget.account_roles[] NOT NULL
);


--
-- Name: canvas; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.canvas (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    deleted boolean DEFAULT false NOT NULL,
    org_id bigint,
    name character varying(256) DEFAULT 'please provide a name'::character varying NOT NULL,
    template nugget.canvas_templates DEFAULT 'custom'::nugget.canvas_templates NOT NULL,
    attribution character varying(2056),
    sections jsonb,
    sequenced boolean,
    canava_version character varying(15),
    completed_on character varying(256),
    completed_by character varying(2056),
    version character varying(256),
    public boolean,
    archived boolean DEFAULT false,
    member_id bigint,
    created_by bigint,
    updated_by bigint,
    editors character varying(250)[],
    viewers character varying(250)[]
);


--
-- Name: canvas_id_seq; Type: SEQUENCE; Schema: nugget; Owner: -
--

CREATE SEQUENCE nugget.canvas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: canvas_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget; Owner: -
--

ALTER SEQUENCE nugget.canvas_id_seq OWNED BY nugget.canvas.id;


--
-- Name: circle; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.circle (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    deleted boolean DEFAULT false NOT NULL,
    name character varying,
    org_id bigint NOT NULL,
    created_by bigint,
    updated_by bigint
);


--
-- Name: circle_id_seq; Type: SEQUENCE; Schema: nugget; Owner: -
--

CREATE SEQUENCE nugget.circle_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: circle_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget; Owner: -
--

ALTER SEQUENCE nugget.circle_id_seq OWNED BY nugget.circle.id;


--
-- Name: circle_member; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.circle_member (
    circle_id bigint NOT NULL,
    member_id bigint NOT NULL,
    uid uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    created_by bigint,
    updated_at timestamp without time zone,
    updated_by bigint,
    deleted boolean DEFAULT false NOT NULL,
    roles nugget.circle_roles[] DEFAULT '{member}'::nugget.circle_roles[]
);


--
-- Name: driver; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.driver (
    id bigint NOT NULL,
    org_id bigint NOT NULL,
    circle_ids bigint[] NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    deleted boolean DEFAULT false NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    infinite boolean DEFAULT false NOT NULL,
    internal boolean DEFAULT true,
    active boolean DEFAULT true NOT NULL,
    updated_by bigint,
    created_by bigint
);


--
-- Name: driver_id_seq; Type: SEQUENCE; Schema: nugget; Owner: -
--

CREATE SEQUENCE nugget.driver_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: driver_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget; Owner: -
--

ALTER SEQUENCE nugget.driver_id_seq OWNED BY nugget.driver.id;


--
-- Name: email; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.email (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    org_id bigint NOT NULL,
    account_id bigint NOT NULL,
    tenant_id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    to_address character varying(256),
    subject character varying(256),
    data jsonb,
    template character varying(32),
    smtp_id character varying(64),
    status character varying(32)
);


--
-- Name: email_id_seq; Type: SEQUENCE; Schema: nugget; Owner: -
--

CREATE SEQUENCE nugget.email_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: email_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget; Owner: -
--

ALTER SEQUENCE nugget.email_id_seq OWNED BY nugget.email.id;


--
-- Name: invite; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.invite (
    id bigint NOT NULL,
    uid uuid NOT NULL,
    org_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    email character varying(256) NOT NULL,
    name character varying(256) NOT NULL,
    message character varying(512),
    status nugget.invite_status DEFAULT 'submitted'::nugget.invite_status,
    created_by bigint,
    updated_by bigint
);


--
-- Name: invite_id_seq; Type: SEQUENCE; Schema: nugget; Owner: -
--

CREATE SEQUENCE nugget.invite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invite_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget; Owner: -
--

ALTER SEQUENCE nugget.invite_id_seq OWNED BY nugget.invite.id;


--
-- Name: member; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.member (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    deleted boolean DEFAULT false NOT NULL,
    email character varying(255),
    tel character varying(24),
    tenant_id bigint
);


--
-- Name: member_canvas; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.member_canvas (
    id bigint DEFAULT nextval('nugget_api.member_canvas_id_seq'::regclass) NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    deleted boolean DEFAULT false NOT NULL,
    name character varying(256) DEFAULT 'please provide a name'::character varying NOT NULL,
    template nugget.canvas_templates DEFAULT 'custom'::nugget.canvas_templates NOT NULL,
    attribution character varying(2056),
    sections jsonb,
    sequenced boolean,
    canava_version character varying(15),
    completed_on character varying(256),
    completed_by character varying(2056),
    version character varying(256),
    public boolean,
    archived boolean DEFAULT false,
    member_id bigint,
    created_by bigint,
    updated_by bigint,
    editors character varying(250)[],
    viewers character varying(250)[]
);


--
-- Name: member_canvas_id_seq; Type: SEQUENCE; Schema: nugget; Owner: -
--

CREATE SEQUENCE nugget.member_canvas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: member_canvas_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget; Owner: -
--

ALTER SEQUENCE nugget.member_canvas_id_seq OWNED BY nugget.member_canvas.id;


--
-- Name: member_id_seq; Type: SEQUENCE; Schema: nugget; Owner: -
--

CREATE SEQUENCE nugget.member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: member_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget; Owner: -
--

ALTER SEQUENCE nugget.member_id_seq OWNED BY nugget.member.id;


--
-- Name: nugget; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.nugget (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    deleted boolean DEFAULT false NOT NULL,
    org_id bigint NOT NULL,
    pub_at timestamp without time zone[],
    unpub_at timestamp with time zone,
    data jsonb,
    label character varying(256),
    internal_label character varying(256),
    subtype character varying(256),
    archived boolean DEFAULT false NOT NULL,
    created_by bigint,
    updated_by bigint,
    nugget_type_id bigint NOT NULL,
    related_id bigint,
    editors character varying(250)[],
    viewers character varying(250)[]
);


--
-- Name: nugget_id_seq; Type: SEQUENCE; Schema: nugget; Owner: -
--

CREATE SEQUENCE nugget.nugget_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: nugget_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget; Owner: -
--

ALTER SEQUENCE nugget.nugget_id_seq OWNED BY nugget.nugget.id;


--
-- Name: nugget_type; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.nugget_type (
    id bigint NOT NULL,
    name character varying(32) NOT NULL
);


--
-- Name: nugget_type_id_seq; Type: SEQUENCE; Schema: nugget; Owner: -
--

CREATE SEQUENCE nugget.nugget_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: nugget_type_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget; Owner: -
--

ALTER SEQUENCE nugget.nugget_type_id_seq OWNED BY nugget.nugget_type.id;


--
-- Name: org; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.org (
    id bigint NOT NULL,
    uid uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    account_id bigint NOT NULL,
    deleted boolean DEFAULT false NOT NULL,
    name character varying(256) NOT NULL,
    created_by bigint,
    updated_by bigint
);


--
-- Name: org_id_seq; Type: SEQUENCE; Schema: nugget; Owner: -
--

CREATE SEQUENCE nugget.org_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: org_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget; Owner: -
--

ALTER SEQUENCE nugget.org_id_seq OWNED BY nugget.org.id;


--
-- Name: tenant; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.tenant (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(32),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    deleted boolean DEFAULT false NOT NULL
);


--
-- Name: tenant_id_seq; Type: SEQUENCE; Schema: nugget; Owner: -
--

CREATE SEQUENCE nugget.tenant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tenant_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget; Owner: -
--

ALTER SEQUENCE nugget.tenant_id_seq OWNED BY nugget.tenant.id;


--
-- Name: account id; Type: DEFAULT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.account ALTER COLUMN id SET DEFAULT nextval('nugget.account_id_seq'::regclass);


--
-- Name: canvas id; Type: DEFAULT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.canvas ALTER COLUMN id SET DEFAULT nextval('nugget.canvas_id_seq'::regclass);


--
-- Name: circle id; Type: DEFAULT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.circle ALTER COLUMN id SET DEFAULT nextval('nugget.circle_id_seq'::regclass);


--
-- Name: driver id; Type: DEFAULT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.driver ALTER COLUMN id SET DEFAULT nextval('nugget.driver_id_seq'::regclass);


--
-- Name: email id; Type: DEFAULT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.email ALTER COLUMN id SET DEFAULT nextval('nugget.email_id_seq'::regclass);


--
-- Name: invite id; Type: DEFAULT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.invite ALTER COLUMN id SET DEFAULT nextval('nugget.invite_id_seq'::regclass);


--
-- Name: member id; Type: DEFAULT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.member ALTER COLUMN id SET DEFAULT nextval('nugget.member_id_seq'::regclass);


--
-- Name: nugget id; Type: DEFAULT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.nugget ALTER COLUMN id SET DEFAULT nextval('nugget.nugget_id_seq'::regclass);


--
-- Name: nugget_type id; Type: DEFAULT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.nugget_type ALTER COLUMN id SET DEFAULT nextval('nugget.nugget_type_id_seq'::regclass);


--
-- Name: org id; Type: DEFAULT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.org ALTER COLUMN id SET DEFAULT nextval('nugget.org_id_seq'::regclass);


--
-- Name: tenant id; Type: DEFAULT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.tenant ALTER COLUMN id SET DEFAULT nextval('nugget.tenant_id_seq'::regclass);


--
-- Name: account_member account_member_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.account_member
    ADD CONSTRAINT account_member_pkey PRIMARY KEY (account_id, member_id);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: canvas canvas_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.canvas
    ADD CONSTRAINT canvas_pkey PRIMARY KEY (id);


--
-- Name: circle_member circle_member_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.circle_member
    ADD CONSTRAINT circle_member_pkey PRIMARY KEY (circle_id, member_id);


--
-- Name: circle circle_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.circle
    ADD CONSTRAINT circle_pkey PRIMARY KEY (id);


--
-- Name: driver driver_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.driver
    ADD CONSTRAINT driver_pkey PRIMARY KEY (id);


--
-- Name: email email_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.email
    ADD CONSTRAINT email_pkey PRIMARY KEY (id);


--
-- Name: invite invite_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.invite
    ADD CONSTRAINT invite_pkey PRIMARY KEY (id);


--
-- Name: member_canvas member_canvas_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.member_canvas
    ADD CONSTRAINT member_canvas_pkey PRIMARY KEY (id);


--
-- Name: member member_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.member
    ADD CONSTRAINT member_pkey PRIMARY KEY (id);


--
-- Name: nugget nugget_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.nugget
    ADD CONSTRAINT nugget_pkey PRIMARY KEY (id);


--
-- Name: nugget_type nugget_type_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.nugget_type
    ADD CONSTRAINT nugget_type_pkey PRIMARY KEY (id);


--
-- Name: org org_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.org
    ADD CONSTRAINT org_pkey PRIMARY KEY (id);


--
-- Name: tenant tenant_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.tenant
    ADD CONSTRAINT tenant_pkey PRIMARY KEY (id);


--
-- Name: account uq_account_uid; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.account
    ADD CONSTRAINT uq_account_uid UNIQUE (uid, tenant_id);


--
-- Name: canvas uq_canvas_uid; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.canvas
    ADD CONSTRAINT uq_canvas_uid UNIQUE (uid, org_id);


--
-- Name: driver uq_driver_uid; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.driver
    ADD CONSTRAINT uq_driver_uid UNIQUE (uid, org_id);


--
-- Name: email uq_email_uid; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.email
    ADD CONSTRAINT uq_email_uid UNIQUE (uid, account_id);


--
-- Name: member_canvas uq_member_canvas_uid; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.member_canvas
    ADD CONSTRAINT uq_member_canvas_uid UNIQUE (uid, member_id);


--
-- Name: member uq_member_uid; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.member
    ADD CONSTRAINT uq_member_uid UNIQUE (uid, tenant_id);


--
-- Name: nugget_type uq_nugget_type_name; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.nugget_type
    ADD CONSTRAINT uq_nugget_type_name UNIQUE (name);


--
-- Name: nugget uq_nugget_uid; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.nugget
    ADD CONSTRAINT uq_nugget_uid UNIQUE (uid, org_id);


--
-- Name: org uq_org_uid; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.org
    ADD CONSTRAINT uq_org_uid UNIQUE (uid, account_id);


--
-- Name: member_canvas set_member_canvas_updated_at; Type: TRIGGER; Schema: nugget; Owner: -
--

CREATE TRIGGER set_member_canvas_updated_at BEFORE UPDATE ON nugget.member_canvas FOR EACH ROW EXECUTE FUNCTION nugget.set_updated_at();


--
-- Name: account fk_account_created_by_member; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.account
    ADD CONSTRAINT fk_account_created_by_member FOREIGN KEY (created_by) REFERENCES nugget.member(id) NOT VALID;


--
-- Name: account fk_account_tenant; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.account
    ADD CONSTRAINT fk_account_tenant FOREIGN KEY (tenant_id) REFERENCES nugget.tenant(id);


--
-- Name: account fk_account_updated_by; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.account
    ADD CONSTRAINT fk_account_updated_by FOREIGN KEY (updated_by) REFERENCES nugget.member(id) NOT VALID;


--
-- Name: canvas fk_account_updated_by; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.canvas
    ADD CONSTRAINT fk_account_updated_by FOREIGN KEY (updated_by) REFERENCES nugget.member(id) NOT VALID;


--
-- Name: canvas fk_canvas_created_by; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.canvas
    ADD CONSTRAINT fk_canvas_created_by FOREIGN KEY (created_by) REFERENCES nugget.member(id) NOT VALID;


--
-- Name: canvas fk_canvas_org; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.canvas
    ADD CONSTRAINT fk_canvas_org FOREIGN KEY (org_id) REFERENCES nugget.org(id) NOT VALID;


--
-- Name: circle fk_circle_created_by; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.circle
    ADD CONSTRAINT fk_circle_created_by FOREIGN KEY (created_by) REFERENCES nugget.member(id) NOT VALID;


--
-- Name: circle_member fk_circle_member_circle; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.circle_member
    ADD CONSTRAINT fk_circle_member_circle FOREIGN KEY (circle_id) REFERENCES nugget.circle(id) NOT VALID;


--
-- Name: circle_member fk_circle_member_created_by; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.circle_member
    ADD CONSTRAINT fk_circle_member_created_by FOREIGN KEY (created_by) REFERENCES nugget.member(id) NOT VALID;


--
-- Name: circle_member fk_circle_member_member; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.circle_member
    ADD CONSTRAINT fk_circle_member_member FOREIGN KEY (member_id) REFERENCES nugget.member(id) NOT VALID;


--
-- Name: circle_member fk_circle_member_updated_by; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.circle_member
    ADD CONSTRAINT fk_circle_member_updated_by FOREIGN KEY (updated_by) REFERENCES nugget.member(id) NOT VALID;


--
-- Name: circle fk_circle_org; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.circle
    ADD CONSTRAINT fk_circle_org FOREIGN KEY (org_id) REFERENCES nugget.org(id);


--
-- Name: circle fk_circle_updated_by; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.circle
    ADD CONSTRAINT fk_circle_updated_by FOREIGN KEY (updated_by) REFERENCES nugget.member(id) NOT VALID;


--
-- Name: driver fk_driver_created_by; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.driver
    ADD CONSTRAINT fk_driver_created_by FOREIGN KEY (created_by) REFERENCES nugget.member(id) NOT VALID;


--
-- Name: driver fk_driver_org; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.driver
    ADD CONSTRAINT fk_driver_org FOREIGN KEY (org_id) REFERENCES nugget.org(id) NOT VALID;


--
-- Name: driver fk_driver_updated_by; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.driver
    ADD CONSTRAINT fk_driver_updated_by FOREIGN KEY (updated_by) REFERENCES nugget.member(id) NOT VALID;


--
-- Name: email fk_email_account; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.email
    ADD CONSTRAINT fk_email_account FOREIGN KEY (account_id) REFERENCES nugget.account(id) NOT VALID;


--
-- Name: email fk_email_org; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.email
    ADD CONSTRAINT fk_email_org FOREIGN KEY (org_id) REFERENCES nugget.org(id) NOT VALID;


--
-- Name: email fk_email_tenant; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.email
    ADD CONSTRAINT fk_email_tenant FOREIGN KEY (tenant_id) REFERENCES nugget.tenant(id) NOT VALID;


--
-- Name: invite fk_invite_created_by; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.invite
    ADD CONSTRAINT fk_invite_created_by FOREIGN KEY (created_by) REFERENCES nugget.member(id) NOT VALID;


--
-- Name: invite fk_invite_org; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.invite
    ADD CONSTRAINT fk_invite_org FOREIGN KEY (org_id) REFERENCES nugget.org(id) NOT VALID;


--
-- Name: invite fk_invite_updated_by; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.invite
    ADD CONSTRAINT fk_invite_updated_by FOREIGN KEY (updated_by) REFERENCES nugget.member(id) NOT VALID;


--
-- Name: member_canvas fk_member_canvas_created_by; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.member_canvas
    ADD CONSTRAINT fk_member_canvas_created_by FOREIGN KEY (created_by) REFERENCES nugget.member(id);


--
-- Name: member_canvas fk_member_canvas_member; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.member_canvas
    ADD CONSTRAINT fk_member_canvas_member FOREIGN KEY (member_id) REFERENCES nugget.member(id);


--
-- Name: member_canvas fk_member_canvas_updated_by; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.member_canvas
    ADD CONSTRAINT fk_member_canvas_updated_by FOREIGN KEY (updated_by) REFERENCES nugget.member(id);


--
-- Name: member fk_member_tenant; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.member
    ADD CONSTRAINT fk_member_tenant FOREIGN KEY (tenant_id) REFERENCES nugget.tenant(id);


--
-- Name: nugget fk_nugget_created_by; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.nugget
    ADD CONSTRAINT fk_nugget_created_by FOREIGN KEY (created_by) REFERENCES nugget.member(id) NOT VALID;


--
-- Name: nugget fk_nugget_org; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.nugget
    ADD CONSTRAINT fk_nugget_org FOREIGN KEY (org_id) REFERENCES nugget.org(id);


--
-- Name: nugget fk_nugget_type; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.nugget
    ADD CONSTRAINT fk_nugget_type FOREIGN KEY (nugget_type_id) REFERENCES nugget.nugget_type(id) NOT VALID;


--
-- Name: nugget fk_nugget_updated_by; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.nugget
    ADD CONSTRAINT fk_nugget_updated_by FOREIGN KEY (updated_by) REFERENCES nugget.member(id) NOT VALID;


--
-- Name: org fk_org_account; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.org
    ADD CONSTRAINT fk_org_account FOREIGN KEY (account_id) REFERENCES nugget.account(id);


--
-- Name: org fk_org_created_by; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.org
    ADD CONSTRAINT fk_org_created_by FOREIGN KEY (created_by) REFERENCES nugget.member(id) NOT VALID;


--
-- Name: org fk_org_updated_by; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.org
    ADD CONSTRAINT fk_org_updated_by FOREIGN KEY (updated_by) REFERENCES nugget.member(id) NOT VALID;


--
-- Name: SCHEMA nugget; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA nugget TO ultri_supertokens;


--
-- Name: TABLE account; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON TABLE nugget.account TO ultri_supertokens;


--
-- Name: SEQUENCE account_id_seq; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON SEQUENCE nugget.account_id_seq TO ultri_supertokens;


--
-- Name: TABLE account_member; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON TABLE nugget.account_member TO ultri_supertokens;


--
-- Name: TABLE canvas; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON TABLE nugget.canvas TO ultri_supertokens;


--
-- Name: SEQUENCE canvas_id_seq; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON SEQUENCE nugget.canvas_id_seq TO ultri_supertokens;


--
-- Name: TABLE circle; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON TABLE nugget.circle TO ultri_supertokens;


--
-- Name: SEQUENCE circle_id_seq; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON SEQUENCE nugget.circle_id_seq TO ultri_supertokens;


--
-- Name: TABLE circle_member; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON TABLE nugget.circle_member TO ultri_supertokens;


--
-- Name: TABLE driver; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON TABLE nugget.driver TO ultri_supertokens;


--
-- Name: SEQUENCE driver_id_seq; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON SEQUENCE nugget.driver_id_seq TO ultri_supertokens;


--
-- Name: TABLE email; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON TABLE nugget.email TO ultri_supertokens;


--
-- Name: SEQUENCE email_id_seq; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON SEQUENCE nugget.email_id_seq TO ultri_supertokens;


--
-- Name: TABLE invite; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON TABLE nugget.invite TO ultri_supertokens;


--
-- Name: SEQUENCE invite_id_seq; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON SEQUENCE nugget.invite_id_seq TO ultri_supertokens;


--
-- Name: TABLE member; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON TABLE nugget.member TO ultri_supertokens;


--
-- Name: TABLE member_canvas; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON TABLE nugget.member_canvas TO ultri_supertokens;


--
-- Name: SEQUENCE member_canvas_id_seq; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON SEQUENCE nugget.member_canvas_id_seq TO ultri_supertokens;


--
-- Name: SEQUENCE member_id_seq; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON SEQUENCE nugget.member_id_seq TO ultri_supertokens;


--
-- Name: TABLE nugget; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON TABLE nugget.nugget TO ultri_supertokens;


--
-- Name: SEQUENCE nugget_id_seq; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON SEQUENCE nugget.nugget_id_seq TO ultri_supertokens;


--
-- Name: TABLE nugget_type; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON TABLE nugget.nugget_type TO ultri_supertokens;


--
-- Name: SEQUENCE nugget_type_id_seq; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON SEQUENCE nugget.nugget_type_id_seq TO ultri_supertokens;


--
-- Name: TABLE org; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON TABLE nugget.org TO ultri_supertokens;


--
-- Name: SEQUENCE org_id_seq; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON SEQUENCE nugget.org_id_seq TO ultri_supertokens;


--
-- Name: TABLE tenant; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON TABLE nugget.tenant TO ultri_supertokens;


--
-- Name: SEQUENCE tenant_id_seq; Type: ACL; Schema: nugget; Owner: -
--

GRANT ALL ON SEQUENCE nugget.tenant_id_seq TO ultri_supertokens;


--
-- PostgreSQL database dump complete
--

