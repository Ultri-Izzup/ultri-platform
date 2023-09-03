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
    'peer'
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
    deleted boolean DEFAULT false NOT NULL
);


--
-- Name: account_credential; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.account_credential (
    account_id bigint NOT NULL,
    credential_id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    role nugget.account_roles DEFAULT 'member'::nugget.account_roles NOT NULL,
    deleted boolean DEFAULT false NOT NULL
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
-- Name: canvas; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.canvas (
    id bigint NOT NULL,
    uid uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
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
    archived boolean DEFAULT false
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
    org_id bigint NOT NULL
);


--
-- Name: circle_credential; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.circle_credential (
    circle_id bigint NOT NULL,
    credential_id bigint NOT NULL,
    roles nugget.circle_roles[] NOT NULL,
    uid uuid DEFAULT gen_random_uuid(),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    deleted boolean DEFAULT false NOT NULL
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
-- Name: credential; Type: TABLE; Schema: nugget; Owner: -
--

CREATE TABLE nugget.credential (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    email character varying(256),
    tel character varying(128),
    deleted boolean DEFAULT false NOT NULL,
    tenant_id bigint
);


--
-- Name: credential_id_seq; Type: SEQUENCE; Schema: nugget; Owner: -
--

CREATE SEQUENCE nugget.credential_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: credential_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget; Owner: -
--

ALTER SEQUENCE nugget.credential_id_seq OWNED BY nugget.credential.id;


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
    active boolean DEFAULT true NOT NULL
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
    status nugget.invite_status DEFAULT 'submitted'::nugget.invite_status
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
    archived boolean DEFAULT false NOT NULL
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
    nugget_id bigint
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
-- Name: credential id; Type: DEFAULT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.credential ALTER COLUMN id SET DEFAULT nextval('nugget.credential_id_seq'::regclass);


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
-- Name: nugget id; Type: DEFAULT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.nugget ALTER COLUMN id SET DEFAULT nextval('nugget.nugget_id_seq'::regclass);


--
-- Name: org id; Type: DEFAULT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.org ALTER COLUMN id SET DEFAULT nextval('nugget.org_id_seq'::regclass);


--
-- Name: tenant id; Type: DEFAULT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.tenant ALTER COLUMN id SET DEFAULT nextval('nugget.tenant_id_seq'::regclass);


--
-- Name: account_credential account_credential_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.account_credential
    ADD CONSTRAINT account_credential_pkey PRIMARY KEY (account_id, credential_id);


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
-- Name: circle_credential circle_credential_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.circle_credential
    ADD CONSTRAINT circle_credential_pkey PRIMARY KEY (credential_id, circle_id);


--
-- Name: circle circle_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.circle
    ADD CONSTRAINT circle_pkey PRIMARY KEY (id);


--
-- Name: credential credential_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.credential
    ADD CONSTRAINT credential_pkey PRIMARY KEY (id);


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
-- Name: nugget nugget_pkey; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.nugget
    ADD CONSTRAINT nugget_pkey PRIMARY KEY (id);


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
-- Name: credential uq_credential_tenant_email; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.credential
    ADD CONSTRAINT uq_credential_tenant_email UNIQUE (email, tenant_id);


--
-- Name: credential uq_credential_tenant_tel; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.credential
    ADD CONSTRAINT uq_credential_tenant_tel UNIQUE (tel, tenant_id);


--
-- Name: credential uq_credential_tenant_uid; Type: CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.credential
    ADD CONSTRAINT uq_credential_tenant_uid UNIQUE (uid, tenant_id);


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
-- Name: account_credential fk_account_credential_account; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.account_credential
    ADD CONSTRAINT fk_account_credential_account FOREIGN KEY (account_id) REFERENCES nugget.account(id);


--
-- Name: account_credential fk_account_credential_credential; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.account_credential
    ADD CONSTRAINT fk_account_credential_credential FOREIGN KEY (credential_id) REFERENCES nugget.credential(id);


--
-- Name: account fk_account_tenant; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.account
    ADD CONSTRAINT fk_account_tenant FOREIGN KEY (tenant_id) REFERENCES nugget.tenant(id);


--
-- Name: canvas fk_canvas_org; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.canvas
    ADD CONSTRAINT fk_canvas_org FOREIGN KEY (org_id) REFERENCES nugget.org(id) NOT VALID;


--
-- Name: circle fk_circle_org; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.circle
    ADD CONSTRAINT fk_circle_org FOREIGN KEY (org_id) REFERENCES nugget.org(id);


--
-- Name: credential fk_credential_tenant_id; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.credential
    ADD CONSTRAINT fk_credential_tenant_id FOREIGN KEY (tenant_id) REFERENCES nugget.tenant(id) NOT VALID;


--
-- Name: driver fk_driver_org; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.driver
    ADD CONSTRAINT fk_driver_org FOREIGN KEY (org_id) REFERENCES nugget.org(id) NOT VALID;


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
-- Name: nugget fk_nugget_org; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.nugget
    ADD CONSTRAINT fk_nugget_org FOREIGN KEY (org_id) REFERENCES nugget.org(id);


--
-- Name: org fk_org_account; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.org
    ADD CONSTRAINT fk_org_account FOREIGN KEY (account_id) REFERENCES nugget.account(id);


--
-- Name: org fk_org_nugget; Type: FK CONSTRAINT; Schema: nugget; Owner: -
--

ALTER TABLE ONLY nugget.org
    ADD CONSTRAINT fk_org_nugget FOREIGN KEY (nugget_id) REFERENCES nugget.nugget(id) NOT VALID;


--
-- PostgreSQL database dump complete
--

