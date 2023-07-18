--
-- PostgreSQL database dump
--

-- Dumped from database version 14.7 (Debian 14.7-1.pgdg110+1)
-- Dumped by pg_dump version 14.8 (Ubuntu 14.8-0ubuntu0.22.04.1)

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
-- Name: nugget_api; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA nugget_api;


--
-- Name: account_roles; Type: TYPE; Schema: nugget_api; Owner: -
--

CREATE TYPE nugget_api.account_roles AS ENUM (
    'owner',
    'member-admin',
    'billing-admin',
    'viewer',
    'editor',
    'org-admin',
    'admin'
);


--
-- Name: email_status; Type: TYPE; Schema: nugget_api; Owner: -
--

CREATE TYPE nugget_api.email_status AS ENUM (
    'queued',
    'sent',
    'bounced',
    'sending'
);


--
-- Name: invite_status; Type: TYPE; Schema: nugget_api; Owner: -
--

CREATE TYPE nugget_api.invite_status AS ENUM (
    'sent',
    'accepted',
    'rejected',
    'expired',
    'queued',
    'failed'
);


--
-- Name: ledger_account_type; Type: TYPE; Schema: nugget_api; Owner: -
--

CREATE TYPE nugget_api.ledger_account_type AS ENUM (
    'asset',
    'liability',
    'equity',
    'revenu',
    'expense'
);


--
-- Name: ledger_transaction_type; Type: TYPE; Schema: nugget_api; Owner: -
--

CREATE TYPE nugget_api.ledger_transaction_type AS ENUM (
    'credit',
    'debit'
);


--
-- Name: nugget_types; Type: TYPE; Schema: nugget_api; Owner: -
--

CREATE TYPE nugget_api.nugget_types AS ENUM (
    'org',
    'team',
    'circle',
    'role',
    'driver',
    'proposal',
    'decision',
    'agreement',
    'peer-review',
    'asset',
    'json',
    'bylaws',
    'policy',
    'procedure',
    'job-description',
    'charter',
    'agenda',
    'minutes',
    'budget',
    'ledger',
    'ledger-account',
    'topic',
    'outcome',
    'process',
    'objective',
    'key-result',
    'vote',
    'survey',
    'howto',
    'sop',
    'mission-statement',
    'canvas',
    'task',
    'spint',
    'epic',
    'training',
    'quiz',
    'course',
    'chapter',
    'session',
    'activity',
    'faq',
    'plan',
    'kpi',
    'okr',
    'modules',
    'module',
    'result',
    'metric',
    'outline',
    'secretstash'
);


--
-- Name: org_roles; Type: TYPE; Schema: nugget_api; Owner: -
--

CREATE TYPE nugget_api.org_roles AS ENUM (
    'owner',
    'leader',
    'participant',
    'contributor',
    'administrator',
    'facilitator',
    'secretary',
    'delegate',
    'representative',
    'veto'
);


--
-- Name: TYPE org_roles; Type: COMMENT; Schema: nugget_api; Owner: -
--

COMMENT ON TYPE nugget_api.org_roles IS 'This allows for testing whether the authed_user has a distinct role on an org.
Used before working on records within an org.';


--
-- Name: reaction_types; Type: TYPE; Schema: nugget_api; Owner: -
--

CREATE TYPE nugget_api.reaction_types AS ENUM (
    'consent',
    'object',
    'abstain',
    'agree',
    'disagree',
    'unsure',
    'like',
    'dislike',
    'neutral',
    'promote',
    'bury',
    'block',
    'sympathy',
    'empathy',
    'concern',
    'frustration',
    'anger',
    'confusion',
    'boredom'
);


--
-- Name: relation_type; Type: TYPE; Schema: nugget_api; Owner: -
--

CREATE TYPE nugget_api.relation_type AS ENUM (
    'input',
    'output',
    'parent',
    'child',
    'sibling',
    'start-to-finish',
    'finish-to-start',
    'start-to-start',
    'finish-to-finish',
    'contributor',
    'benefiter',
    'predecessor',
    'successor'
);


--
-- Name: create_account(uuid, character varying); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.create_account(owner_uid uuid, name_in character varying) RETURNS TABLE(id bigint, uid uuid, created_at timestamp without time zone, roles nugget_api.account_roles[])
    LANGUAGE plpgsql
    AS $$

DECLARE new_account_id BIGINT;
DECLARE new_account_uid uuid;
DECLARE new_account_created_at timestamp without time zone;
DECLARE new_account_member_roles account_roles[];

BEGIN
    
	INSERT INTO nugget_api.account(name)
		 VALUES(name_in)
		 RETURNING nugget_api.account.id, nugget_api.account.uid, nugget_api.account.created_at INTO new_account_id, new_account_uid, new_account_created_at;
		
	INSERT INTO nugget_api.account_member(account_id, member_id , roles)
		 VALUES(new_account_id, (SELECT m.id FROM nugget_api.member m where m.uid = owner_uid),  '{"owner"}')
		 RETURNING nugget_api.account_member.roles INTO new_account_member_roles;

	RETURN QUERY SELECT new_account_id, new_account_uid, new_account_created_at, new_account_member_roles;
	
	
END; 
$$;


--
-- Name: create_account_nugget(character varying, character varying, character varying, bigint, uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.create_account_nugget(public_title character varying, internal_name character varying, nugget_type character varying, account_uid bigint, member_uid uuid, OUT id bigint, OUT uid uuid, OUT created_at timestamp without time zone, OUT account_id bigint) RETURNS record
    LANGUAGE plpgsql
    AS $_$
#variable_conflict use_column
BEGIN

	INSERT INTO nugget_api.nugget(
				public_title, 
				internal_name,   
				account_id, 
				nugget_type_id,
				created_at
			)
			VALUES (
				$1, 
				$2, 
				nugget_api.get_member_account($4),
				1,
				DEFAULT
				)
 	RETURNING id, uid, created_at, account_id INTO id, uid, created_at, account_id;

	

	
END; 
$_$;


--
-- Name: create_logbook_entry(uuid, uuid, uuid, text); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.create_logbook_entry(member_uid_in uuid, logbook_uid_in uuid, nugget_uid_in uuid, note_in text) RETURNS TABLE("logbookEntryId" bigint, "logbookEntryUid" uuid, "createdAt" timestamp without time zone)
    LANGUAGE plpgsql
    AS $$

DECLARE new_record_id BIGINT;
DECLARE new_record_uid uuid;
DECLARE new_record_created_at timestamp without time zone;

BEGIN
    
	INSERT INTO nugget_api.logbook_entry(logbook_id, nugget_id, note)
		 VALUES(
			(SELECT id FROM logbook_by_member(member_uid_in, logbook_uid_in)),
		    (SELECT id FROM nugget WHERE uid = nugget_uid_in),
		     note_in)
		 RETURNING nugget_api.logbook_entry.id, nugget_api.logbook_entry.uid, nugget_api.logbook_entry.created_at INTO new_record_id, new_record_uid, new_record_created_at;
		
	 
	RETURN QUERY SELECT new_record_id, new_record_uid, new_record_created_at;
	
	
END; 
$$;


--
-- Name: create_logbook_entry_comment(uuid, uuid, text); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.create_logbook_entry_comment(member_uid_in uuid, logbook_entry_uid_in uuid, note_in text) RETURNS TABLE("commentId" bigint, "commentUid" uuid, "createdAt" timestamp without time zone)
    LANGUAGE plpgsql
    AS $$

DECLARE new_comment_id BIGINT;
DECLARE new_comment_uid uuid;
DECLARE new_comment_created_at timestamp without time zone;
DECLARE valid_org_id bigint;
DECLARE valid_account_id bigint;
DECLARE valid_logbook_id bigint;
DECLARE valid_logbook_entry_id bigint;
DECLARE valid_logbook_entry_nugget_id bigint;

BEGIN
	-- Get account and org id, ensuring they are connected to the member
	SELECT account_id, org_id, logbook_id, logbook_entry_id, logbook_entry_nugget_id  FROM valid_logbook_entry_account_org(member_uid_in, logbook_entry_uid_in) INTO valid_account_id, valid_org_id, valid_logbook_id, valid_logbook_entry_id, valid_logbook_entry_nugget_id;
  
  -- Create a new comment, referencing the nugget as data_nugget
	INSERT INTO nugget_api.comment(target_nugget_id, note)
		 VALUES(
			valid_logbook_entry_nugget_id,
		     note_in)
		 RETURNING nugget_api.comment.id, nugget_api.comment.uid, nugget_api.comment.created_at INTO new_comment_id, new_comment_uid, new_comment_created_at;

	-- Return ID and UID of nugget and logbookRecord
	RETURN QUERY SELECT new_comment_id, new_comment_uid, new_comment_created_at;
	
	
END; 
$$;


--
-- Name: create_logbook_entry_comment_nugget(uuid, uuid, timestamp with time zone, timestamp with time zone, character varying, character varying, jsonb, nugget_api.nugget_types, text); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.create_logbook_entry_comment_nugget(member_uid_in uuid, logbook_entry_uid_in uuid, pub_at_in timestamp with time zone, un_pub_at_in timestamp with time zone, public_title_in character varying, internal_name_in character varying, blocks_in jsonb, nugget_type_in nugget_api.nugget_types, note_in text) RETURNS TABLE("commentNuggetId" bigint, "commentNuggetUid" uuid, "commentId" bigint, "commentUid" uuid, "createdAt" timestamp without time zone)
    LANGUAGE plpgsql
    AS $$

DECLARE new_nugget_id BIGINT;
DECLARE new_nugget_uid uuid;
DECLARE new_comment_id BIGINT;
DECLARE new_comment_uid uuid;
DECLARE new_comment_created_at timestamp without time zone;
DECLARE valid_org_id bigint;
DECLARE valid_account_id bigint;
DECLARE valid_logbook_id bigint;
DECLARE valid_logbook_entry_id bigint;
DECLARE valid_logbook_entry_nugget_id bigint;

BEGIN
	-- Get account and org id, ensuring they are connected to the member
	SELECT account_id, org_id, logbook_id, logbook_entry_id, logbook_entry_nugget_id FROM valid_logbook_entry_account_org(member_uid_in, logbook_entry_uid_in) INTO valid_account_id, valid_org_id, valid_logbook_id, valid_logbook_entry_id, valid_logbook_entry_nugget_id;
    
	-- Create the nugget
	INSERT INTO nugget_api.nugget(
		pub_at, 
		  un_pub_at, 
		  public_title, 
		  internal_name, 
		  blocks,
		  nugget_type, 
		  org_id, 
		  account_id)
		 VALUES(
			 pub_at_in, 
			 un_pub_at_in, 
			 public_title_in, 
			 internal_name_in, 
			 blocks_in,
			 nugget_type_in, 
			 valid_org_id,
			 valid_account_id
			)
		-- Store nugget creation results
		RETURNING nugget_api.nugget.id, nugget_api.nugget.uid, nugget_api.nugget.created_at 
		INTO new_nugget_id, new_nugget_uid;
	
	-- Create a new comment, referencing the nugget as data_nugget
	INSERT INTO nugget_api.comment(target_nugget_id, data_nugget_id, note)
		 VALUES(
			valid_logbook_entry_nugget_id,
		    new_nugget_id,
		     note_in)
		 RETURNING nugget_api.comment.id, nugget_api.comment.uid, nugget_api.comment.created_at INTO new_comment_id, new_comment_uid, new_comment_created_at;

	-- Return ID and UID of nugget and logbookRecord
	RETURN QUERY SELECT new_nugget_id, new_nugget_uid, new_comment_id, new_comment_uid, new_comment_created_at;
	
	
END; 
$$;


--
-- Name: create_logbook_entry_nugget(uuid, uuid, timestamp with time zone, timestamp with time zone, character varying, character varying, jsonb, nugget_api.nugget_types, text); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.create_logbook_entry_nugget(member_uid_in uuid, logbook_uid_in uuid, pub_at_in timestamp with time zone, un_pub_at_in timestamp with time zone, public_title_in character varying, internal_name_in character varying, blocks_in jsonb, nugget_type_in nugget_api.nugget_types, note_in text) RETURNS TABLE("nuggetId" bigint, "nuggetUid" uuid, "logbookEntryId" bigint, "logbookEntryUid" uuid, "createdAt" timestamp without time zone)
    LANGUAGE plpgsql
    AS $$

DECLARE new_nugget_id BIGINT;
DECLARE new_nugget_uid uuid;
DECLARE new_logbook_entry_id BIGINT;
DECLARE new_logbook_entry_uid uuid;
DECLARE new_logbook_entry_created_at timestamp without time zone;
DECLARE valid_org_id bigint;
DECLARE valid_account_id bigint;
DECLARE valid_logbook_id bigint;

BEGIN
	-- Get account and org id, ensuring they are connected to the member
	SELECT account_id, org_id, logbook_id FROM valid_logbook_account_org(member_uid_in, logbook_uid_in) INTO valid_account_id, valid_org_id, valid_logbook_id;
    
	-- Create the nugget
	INSERT INTO nugget_api.nugget(
		pub_at, 
		  un_pub_at, 
		  public_title, 
		  internal_name, 
		  blocks,
		  nugget_type, 
		  org_id, 
		  account_id)
		 VALUES(
			 pub_at_in, 
			 un_pub_at_in, 
			 public_title_in, 
			 internal_name_in, 
			 blocks_in,
			 nugget_type_in, 
			 valid_org_id,
			 valid_account_id
			)
		-- Store nugget creation results
		RETURNING nugget_api.nugget.id, nugget_api.nugget.uid, nugget_api.nugget.created_at 
		INTO new_nugget_id, new_nugget_uid;
	
	-- Create a new logbook entry, referencing the nugget
	INSERT INTO nugget_api.logbook_entry(logbook_id, nugget_id, note)
		 VALUES(
			valid_logbook_id,
		    new_nugget_id,
		     note_in)
		 RETURNING nugget_api.logbook_entry.id, nugget_api.logbook_entry.uid, nugget_api.logbook_entry.created_at INTO new_logbook_entry_id, new_logbook_entry_uid, new_logbook_entry_created_at;

	-- Return ID and UID of nugget and logbookRecord
	RETURN QUERY SELECT new_nugget_id, new_nugget_uid, new_logbook_entry_id, new_logbook_entry_uid, new_logbook_entry_created_at;
	
	
END; 
$$;


--
-- Name: create_logbook_nugget(uuid, uuid, timestamp with time zone, timestamp with time zone, character varying, character varying, jsonb, nugget_api.nugget_types); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.create_logbook_nugget(member_uid_in uuid, logbook_uid_in uuid, pub_at_in timestamp with time zone, un_pub_at_in timestamp with time zone, public_title_in character varying, internal_name_in character varying, blocks_in jsonb, nugget_type_in nugget_api.nugget_types) RETURNS TABLE(id bigint, uid uuid, "createdAt" timestamp without time zone)
    LANGUAGE plpgsql
    AS $$

DECLARE new_record_id BIGINT;
DECLARE new_record_uid uuid;
DECLARE new_record_created_at timestamp without time zone;
DECLARE valid_org_id bigint;
DECLARE valid_account_id bigint;

BEGIN

	SELECT account_id, org_id FROM valid_logbook_account_org(member_uid_in, logbook_uid_in) INTO valid_account_id, valid_org_id;
    
	INSERT INTO nugget_api.nugget(pub_at, 
										  un_pub_at, 
										  public_title, 
										  internal_name, 
										  blocks,
										  nugget_type, 
										  org_id, 
										  account_id)
		 VALUES(
			 pub_at_in, 
			  un_pub_at_in, 
			  public_title_in, 
			  internal_name_in, 
			  blocks_in,
			  nugget_type_in, 
			 valid_org_id,
			 valid_account_id
			)
		 RETURNING nugget_api.nugget.id, nugget_api.nugget.uid, nugget_api.nugget.created_at INTO new_record_id, new_record_uid, new_record_created_at;
		
	 
	RETURN QUERY SELECT new_record_id, new_record_uid, new_record_created_at;
	
	
END; 
$$;


--
-- Name: create_member_nugget(character varying, character varying, character varying, uuid, jsonb); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.create_member_nugget(public_title character varying, internal_name character varying, nugget_type character varying, member_uid uuid, blocks jsonb, OUT id bigint, OUT uid uuid, OUT created_at timestamp without time zone, OUT account_id bigint) RETURNS record
    LANGUAGE plpgsql
    AS $_$
#variable_conflict use_column
BEGIN

	INSERT INTO nugget_api.nugget(
				public_title, 
				internal_name, 
				nugget_type,
				account_id,
				blocks
				)
			VALUES (
				$1, 
				$2, 
				$3,
				nugget_api.get_member_account($4),
				$5
				)
 	RETURNING id, uid, created_at, account_id INTO id, uid, created_at, account_id;

	

	
END; 
$_$;


--
-- Name: create_member_org(uuid, character varying, text); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.create_member_org(member_uid_in uuid, name_in character varying, note_in text) RETURNS TABLE(id bigint, uid uuid, "createdAt" timestamp without time zone, name character varying, "logbookId" bigint, "logbookUid" uuid)
    LANGUAGE plpgsql
    AS $$

#variable_conflict use_column

DECLARE new_org_id bigint;
DECLARE new_org_uid uuid;
DECLARE new_org_created_at timestamp without time zone;
DECLARE new_logbook_id bigint;
DECLARE new_logbook_uid uuid;

BEGIN
    
	INSERT INTO nugget_api.org(name, note, account_id )
		 VALUES(name_in, note_in, (SELECT id from nugget_api.member_account_by_role(member_uid_in, 'owner')))
		 RETURNING nugget_api.org.id, nugget_api.org.uid, nugget_api.org.created_at INTO new_org_id, new_org_uid, new_org_created_at;
		 
    INSERT INTO nugget_api.org_member(member_id, org_id, roles)
		 VALUES((SELECT id FROM nugget_api.member m WHERE m.uid = member_uid_in), new_org_id, '{owner}');
			INSERT INTO nugget_api.logbook(name, org_id)
		 VALUES(CONCAT('Logbook for ', name_in), new_org_id)
		 RETURNING nugget_api.logbook.id, nugget_api.logbook.uid INTO new_logbook_id, new_logbook_uid;
		 
	INSERT INTO nugget_api.logbook_entry(note, logbook_id)
		 VALUES(CONCAT('First entry for logbook: ', new_logbook_uid), new_logbook_id);
		 
	RETURN QUERY SELECT new_org_id, new_org_uid, new_org_created_at, name_in, new_logbook_id, new_logbook_uid;
	
	
END; 
$$;


--
-- Name: create_org(uuid, uuid, character varying, text); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.create_org(member_uid_in uuid, account_uid_in uuid, name_in character varying, note_in text) RETURNS TABLE(id bigint, uid uuid, "createdAt" timestamp without time zone, name character varying, "logbookId" bigint, "logbookUid" uuid)
    LANGUAGE plpgsql
    AS $$

DECLARE new_org_id bigint;
DECLARE new_org_uid uuid;
DECLARE new_org_created_at timestamp without time zone;
DECLARE new_logbook_id bigint;
DECLARE new_logbook_uid uuid;

BEGIN
    
	INSERT INTO nugget_api.org(name, note, account_id )
		 VALUES(name_in, note_in, (SELECT id from nugget_api.account_by_role(
			member_uid_in, 
			account_uid_in, 
			'owner'
		)))
		 RETURNING nugget_api.org.id, nugget_api.org.uid, nugget_api.org.created_at INTO new_org_id, new_org_uid, new_org_created_at;
		 
    INSERT INTO nugget_api.org_member(member_id, org_id, role)
		 VALUES((SELECT id FROM nugget_api.member m WHERE m.uid = member_uid_in), new_org_id, 'owner');
		
	INSERT INTO nugget_api.logbook(name, org_id)
		 VALUES(CONCAT('Logbook for ', name_in), new_org_id)
		 RETURNING nugget_api.logbook.id, nugget_api.logbook.uid INTO new_logbook_id, new_logbook_uid;
		 
	INSERT INTO nugget_api.logbook_entry(note, logbook_id)
		 VALUES(CONCAT('First entry for logboook: ', new_logbook_uid), new_logbook_id);
		 
	RETURN QUERY SELECT new_org_id, new_org_uid, new_org_created_at, name_in, new_logbook_id, new_logbook_uid;
	
	
END; 
$$;


--
-- Name: create_org_logbook_entry(uuid, uuid, uuid, text); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.create_org_logbook_entry(member_uid_in uuid, org_uid_in uuid, nugget_uid_in uuid, note_in text) RETURNS TABLE("logbookEntryId" bigint, "logbookEntryUid" uuid, "createdAt" timestamp without time zone)
    LANGUAGE plpgsql
    AS $$

DECLARE new_record_id BIGINT;
DECLARE new_record_uid uuid;
DECLARE new_record_created_at timestamp without time zone;

DECLARE valid_org_id bigint = secure_org_by_roles(member_uid_in, 
	org_uid_in, 
	ARRAY['owner','leader','delegate','representative']::org_roles[]);

BEGIN
    
	INSERT INTO nugget_api.logbook_entry(logbook_id, nugget_id, note)
		 VALUES(
			(SELECT id FROM logbook WHERE org_id = valid_org_id),
		    (SELECT id FROM nugget WHERE uid = nugget_uid_in AND org_id = valid_org_id),
		     note_in)
		 RETURNING nugget_api.logbook_entry.id, nugget_api.logbook_entry.uid, nugget_api.logbook_entry.created_at INTO new_record_id, new_record_uid, new_record_created_at;
		
	 
	RETURN QUERY SELECT new_record_id, new_record_uid, new_record_created_at;
	
	
END; 
$$;


--
-- Name: create_org_logbook_entry_nugget(uuid, uuid, timestamp with time zone, timestamp with time zone, character varying, character varying, jsonb, nugget_api.nugget_types, text); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.create_org_logbook_entry_nugget(member_uid_in uuid, org_uid_in uuid, pub_at_in timestamp with time zone, un_pub_at_in timestamp with time zone, public_title_in character varying, internal_name_in character varying, blocks_in jsonb, nugget_type_in nugget_api.nugget_types, note_in text) RETURNS TABLE("nuggetId" bigint, "nuggetUid" uuid, "logbookEntryId" bigint, "logbookEntryUid" uuid, "createdAt" timestamp without time zone)
    LANGUAGE plpgsql
    AS $$

DECLARE new_nugget_id BIGINT;
DECLARE new_nugget_uid uuid;
DECLARE new_logbook_entry_id BIGINT;
DECLARE new_logbook_entry_uid uuid;
DECLARE new_logbook_entry_created_at timestamp without time zone;
DECLARE valid_org_id bigint;
DECLARE valid_account_id bigint;
DECLARE valid_logbook_id bigint;

BEGIN
	-- Get account and org id, ensuring they are connected to the member
	SELECT account_id, org_id, logbook_id FROM secure_logbook_account_org_by_roles(member_uid_in, org_uid_in, ARRAY['owner']::org_roles[]) INTO valid_account_id, valid_org_id, valid_logbook_id;
    
	-- Create the nugget
	INSERT INTO nugget_api.nugget(
		pub_at, 
		  un_pub_at, 
		  public_title, 
		  internal_name, 
		  blocks,
		  nugget_type, 
		  org_id, 
		  account_id)
		 VALUES(
			 pub_at_in, 
			 un_pub_at_in, 
			 public_title_in, 
			 internal_name_in, 
			 blocks_in,
			 nugget_type_in, 
			 valid_org_id,
			 valid_account_id
			)
		-- Store nugget creation results
		RETURNING nugget_api.nugget.id, nugget_api.nugget.uid, nugget_api.nugget.created_at 
		INTO new_nugget_id, new_nugget_uid;
	
	-- Create a new logbook entry, referencing the nugget
	INSERT INTO nugget_api.logbook_entry(logbook_id, nugget_id, note)
		 VALUES(
			valid_logbook_id,
		    new_nugget_id,
		     note_in)
		 RETURNING nugget_api.logbook_entry.id, nugget_api.logbook_entry.uid, nugget_api.logbook_entry.created_at INTO new_logbook_entry_id, new_logbook_entry_uid, new_logbook_entry_created_at;

	-- Return ID and UID of nugget and logbookRecord
	RETURN QUERY SELECT new_nugget_id, new_nugget_uid, new_logbook_entry_id, new_logbook_entry_uid, new_logbook_entry_created_at;
	
	
END; 
$$;


--
-- Name: delete_member_org(uuid, uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.delete_member_org(member_uid_in uuid, org_uid_in uuid) RETURNS TABLE("deletedAt" timestamp without time zone)
    LANGUAGE plpgsql
    AS $$

#variable_conflict use_column

DECLARE new_deleted_at timestamp without time zone;

BEGIN
    
	UPDATE org o
	 SET deleted = true
	 FROM  org_member om 
	 JOIN member m ON m.id = om.member_id
	 WHERE o.id = om.org_id
	  AND o.uid = org_uid_in::uuid
	  AND m.uid = member_uid_in::uuid
	  AND 'owner' = ANY(om.roles)
	 RETURNING o.updated_at AS deleted_at INTO new_deleted_at;
		 
	RETURN QUERY SELECT new_deleted_at;
	
	
END; 
$$;


--
-- Name: get_account_nuggets_by_type(uuid, uuid, text); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.get_account_nuggets_by_type(member_uid_in uuid, account_uid_in uuid, nugget_type_in text) RETURNS TABLE("nuggetUid" uuid, "createdAt" timestamp without time zone, "updatedAt" timestamp without time zone, "pubAt" timestamp without time zone, "unPubAt" timestamp without time zone, "publicTitle" character varying, "internalName" character varying, "nuggetType" character varying, blocks jsonb)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY 
SELECT 
n.uid AS "nuggetUid",  
n.created_at AS "createdAt",  
n.updated_at AS "updatedAt",  
n.pub_at AS "pubAt", 
n.un_pub_at AS "unPubAt", 
n.public_title AS "publicTitle", 
n.internal_name AS "internalName", 
n.nugget_type AS "nuggetType",
n.blocks
FROM nugget_api.member m 
INNER JOIN nugget_api.account_member am ON am.member_id = m.id
INNER JOIN nugget_api.account a ON a.id = am.account_id
INNER JOIN nugget_api.nugget n ON n.account_id = am.account_id
WHERE m.uid = member_uid_in
AND a.uid = account_uid_in
AND n.nugget_type = nugget_type_in;
END;
$$;


--
-- Name: get_account_orgs(uuid, uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.get_account_orgs(member_uid_in uuid, account_uid_in uuid) RETURNS TABLE("orgUid" uuid, "createdAt" timestamp without time zone, name character varying, note text, "logbookUid" uuid, "orgNuggetUid" uuid)
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN QUERY (SELECT o.uid, o.created_at, o.name, o.note, l.uid, n.uid
	FROM nugget_api.org o 
	INNER JOIN nugget_api.logbook l ON l.org_id = o.id
	INNER JOIN nugget_api.account a ON a.id = o.account_id
	INNER JOIN nugget_api.account_member am ON am.account_id = a.id
	INNER JOIN nugget_api.member m ON m.id = am.member_id
	LEFT JOIN nugget_api.nugget n ON n.id = o.nugget_id				  
	WHERE m.uid = member_uid_in
 	AND a.uid =account_uid_in );

	
END; 
$$;


--
-- Name: get_comment(uuid, uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.get_comment(member_uid_in uuid, comment_uid_in uuid) RETURNS TABLE("commentUid" uuid, "createdAt" timestamp without time zone, "updatedAt" timestamp without time zone, note text, "pubAt" timestamp with time zone, "unPubAt" timestamp with time zone, "publicTitle" character varying, "internalName" character varying, blocks jsonb, "nuggetType" nugget_api.nugget_types)
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN QUERY (SELECT 
				  c.uid, 
				  c.created_at, 
				  c.updated_at, 
				  c.note, 
				  n.pub_at,
				  n.un_pub_at,
				  n.public_title,
				  n.internal_name,
				  n.blocks,
				  n.nugget_type
	FROM comment c
	LEFT JOIN nugget n ON n.id =c.target_nugget_id
	INNER JOIN org o ON o.id = n.org_id
	INNER JOIN account a ON a.id = o.account_id
	INNER JOIN account_member am ON am.account_id = a.id
	INNER JOIN member m ON m.id = am.member_id
	WHERE m.uid = member_uid_in
 	AND c.uid = comment_uid_in );
END
$$;


--
-- Name: get_logbook_entries(uuid, uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.get_logbook_entries(member_uid_in uuid, logbook_uid_in uuid) RETURNS TABLE("logbookEntryUid" uuid, "createdAt" timestamp without time zone, note text, "nuggetUid" uuid)
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN QUERY (SELECT le.uid, le.created_at, le.note, n.uid
	FROM nugget_api.logbook_entry le
	LEFT JOIN nugget n ON n.id = le.nugget_id
    INNER JOIN nugget_api.logbook l ON l.id = le.logbook_id
	INNER JOIN nugget_api.org o ON o.id = l.org_id
	INNER JOIN nugget_api.account a ON a.id = o.account_id
	INNER JOIN nugget_api.account_member am ON am.account_id = a.id
	INNER JOIN nugget_api.member m ON m.id = am.member_id
	WHERE m.uid = member_uid_in
 	AND l.uid = logbook_uid_in );

	
END; 
$$;


--
-- Name: get_logbook_entry(uuid, uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.get_logbook_entry(member_uid_in uuid, logbook_entry_uid_in uuid) RETURNS TABLE("logbookEntryUid" uuid, "createdAt" timestamp without time zone, "updatedAt" timestamp without time zone, note text, "pubAt" timestamp with time zone, "unPubAt" timestamp with time zone, "publicTitle" character varying, "internalName" character varying, blocks jsonb, "nuggetType" nugget_api.nugget_types)
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN QUERY (SELECT 
				  le.uid, 
				  le.created_at, 
				  le.updated_at, 
				  le.note, 
				  n.pub_at,
				  n.un_pub_at,
				  n.public_title,
				  n.internal_name,
				  n.blocks,
				  n.nugget_type
	FROM nugget_api.logbook_entry le
	LEFT JOIN nugget n ON n.id = le.nugget_id
    INNER JOIN nugget_api.logbook l ON l.id = le.logbook_id
	INNER JOIN nugget_api.org o ON o.id = l.org_id
	INNER JOIN nugget_api.account a ON a.id = o.account_id
	INNER JOIN nugget_api.account_member am ON am.account_id = a.id
	INNER JOIN nugget_api.member m ON m.id = am.member_id
	WHERE m.uid = member_uid_in
 	AND le.uid = logbook_entry_uid_in );
END
$$;


--
-- Name: get_logbook_entry_comments(uuid, uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.get_logbook_entry_comments(member_uid_in uuid, logbook_entry_uid_in uuid) RETURNS TABLE("commentUid" uuid, "createdAt" timestamp without time zone, "updatedAt" timestamp without time zone, note text, "pubAt" timestamp with time zone, "unPubAt" timestamp with time zone, "publicTitle" character varying, "internalName" character varying, blocks jsonb, "nuggetType" nugget_api.nugget_types)
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN QUERY (SELECT 
				  c.uid, 
				  c.created_at, 
				  c.updated_at, 
				  c.note,
	  		      cn.pub_at,
				  cn.un_pub_at,
				  cn.public_title,
				  cn.internal_name,
				  cn.blocks,
				  cn.nugget_type
	FROM logbook_entry le
	LEFT JOIN nugget n ON n.id = le.nugget_id
	JOIN comment c ON c.target_nugget_id = n.id
    LEFT JOIN nugget cn ON cn.id = c.data_nugget_id
    INNER JOIN logbook l ON l.id = le.logbook_id
	INNER JOIN org o ON o.id = l.org_id
	INNER JOIN account a ON a.id = o.account_id
	INNER JOIN account_member am ON am.account_id = a.id
	INNER JOIN member m ON m.id = am.member_id
	WHERE m.uid = member_uid_in
 	AND le.uid = logbook_entry_uid_in );
END
$$;


--
-- Name: get_logbook_entry_reactions(uuid, uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.get_logbook_entry_reactions(member_uid_in uuid, logbook_entry_uid_in uuid) RETURNS TABLE("memberUid" uuid, "reactedAt" timestamp without time zone, reactions nugget_api.reaction_types[])
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN QUERY (SELECT 
				  m.uid, 
				  r.reacted_at, 
				  r.reactions
	FROM logbook_entry le
	JOIN nugget n ON n.id = le.nugget_id
	JOIN reaction r ON r.nugget_id = n.id
	INNER JOIN org o ON o.id = n.org_id
	INNER JOIN account a ON a.id = o.account_id
	INNER JOIN account_member am ON am.account_id = a.id
	INNER JOIN member m ON m.id = am.member_id
	WHERE m.uid = member_uid_in
 	AND le.uid = logbook_entry_uid_in );
END
$$;


--
-- Name: get_logbook_nugget(uuid, uuid, uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.get_logbook_nugget(member_uid_in uuid, logbook_uid_in uuid, nugget_uid_in uuid) RETURNS TABLE("nuggetUid" uuid, "createdAt" timestamp without time zone, "updatedAt" timestamp without time zone, "pubAt" timestamp with time zone, "unPubAt" timestamp with time zone, "publicTitle" character varying, "internalName" character varying, blocks jsonb, "nuggetType" nugget_api.nugget_types, "orgUid" uuid, "accountUid" uuid)
    LANGUAGE plpgsql ROWS 1
    AS $$
BEGIN
	
	RETURN QUERY (SELECT 
				  n.uid, 
				  n.created_at, 
				  n.updated_at,
				  n.pub_at, 
				  n.un_pub_at,
				  n.public_title,
				  n.internal_name,
				  n.blocks,
				  n.nugget_type,
				  o.uid AS org_uid,
				  a.uid AS account_uid
	FROM nugget n 
	INNER JOIN org o ON o.id = n.org_id
	INNER JOIN account a ON a.id = n.account_id
	INNER JOIN account_member am ON am.account_id = a.id
	INNER JOIN member m ON m.id = am.member_id
    INNER JOIN logbook_entry le ON le.nugget_id = n.id
	INNER JOIN logbook l ON l.id = le.logbook_id
	WHERE n.uid = nugget_uid_in
	AND m.uid = member_uid_in
 	AND l.uid = logbook_uid_in );

	
END; 
$$;


--
-- Name: get_member_account(uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.get_member_account(uid_in uuid) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN (SELECT a.id 
	FROM nugget_api.account_member am 
	INNER JOIN nugget_api.account a ON a.id = am.account_id
	INNER JOIN nugget_api.member m ON m.id = am.member_id
	WHERE m.uid = uid_in
	 AND a.personal = true
	ORDER BY a.created_at LIMIT 1);

	
END; 
$$;


--
-- Name: get_member_accounts(uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.get_member_accounts(uid_in uuid) RETURNS TABLE("accountUid" uuid, "createdAt" timestamp without time zone, name character varying, roles nugget_api.account_roles[])
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN QUERY (SELECT a.uid, a.created_at, a.name, am.roles
	FROM nugget_api.account_member am 
	INNER JOIN nugget_api.account a ON a.id = am.account_id
	INNER JOIN nugget_api.member m ON m.id = am.member_id
	WHERE m.uid = uid_in);

	
END; 
$$;


--
-- Name: get_member_nuggets_by_type(uuid, text); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.get_member_nuggets_by_type(member_uid_in uuid, nugget_type_in text) RETURNS TABLE("nuggetUid" uuid, "createdAt" timestamp without time zone, "updatedAt" timestamp without time zone, "pubAt" timestamp without time zone, "unPubAt" timestamp without time zone, "publicTitle" character varying, "internalName" character varying, "nuggetType" character varying, blocks jsonb)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY 
SELECT 
n.uid AS "nuggetUid",  
n.created_at AS "createdAt",  
n.updated_at AS "updatedAt",  
n.pub_at AS "pubAt", 
n.un_pub_at AS "unPubAt", 
n.public_title AS "publicTitle", 
n.internal_name AS "internalName", 
n.nugget_type AS "nuggetType",
n.blocks
FROM nugget_api.member m 
INNER JOIN nugget_api.account_member am ON am.member_id = m.id
INNER JOIN nugget_api.account a ON a.id = am.account_id
	AND a.personal = true
INNER JOIN nugget_api.nugget n ON n.account_id = am.account_id
WHERE m.uid = member_uid_in
AND n.nugget_type = nugget_type_in;
END;
$$;


--
-- Name: get_member_orgs(uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.get_member_orgs(member_uid_in uuid) RETURNS TABLE(uid uuid, "createdAt" timestamp without time zone, name character varying, note text, "logbookUid" uuid, "nuggetUid" uuid)
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN QUERY (SELECT o.uid, o.created_at, o.name, o.note, l.uid, n.uid
	FROM nugget_api.org o 
	INNER JOIN nugget_api.logbook l ON l.org_id = o.id
    INNER JOIN nugget_api.account a ON a.id = o.account_id
	INNER JOIN nugget_api.account_member am ON am.account_id = a.id
	INNER JOIN nugget_api.member m ON m.id = am.member_id
	LEFT JOIN nugget_api.nugget n ON n.id = o.nugget_id				  
	WHERE m.uid = member_uid_in  AND o.deleted IS NOT TRUE );

	
END; 
$$;


--
-- Name: get_org_logbook_entries(uuid, uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.get_org_logbook_entries(member_uid_in uuid, org_uid_in uuid) RETURNS TABLE("logbookEntryUid" uuid, "createdAt" timestamp without time zone, note text, "nuggetUid" uuid)
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN QUERY (
		SELECT le.uid, le.created_at, le.note, n.uid
	FROM nugget_api.logbook_entry le
	LEFT JOIN nugget n ON n.id = le.nugget_id
    INNER JOIN nugget_api.logbook l ON l.id = le.logbook_id
	INNER JOIN nugget_api.org o ON o.id = l.org_id
	INNER JOIN nugget_api.account a ON a.id = o.account_id
	INNER JOIN nugget_api.account_member am ON am.account_id = a.id
	INNER JOIN nugget_api.member m ON m.id = am.member_id
	WHERE m.uid = member_uid_in
 	AND o.uid = org_uid_in 
	);

END; 
$$;


--
-- Name: get_org_logbook_entry(uuid, uuid, uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.get_org_logbook_entry(member_uid_in uuid, org_uid_in uuid, logbook_entry_uid_in uuid) RETURNS TABLE("logbookEntryUid" uuid, "createdAt" timestamp without time zone, "updatedAt" timestamp without time zone, note text, "pubAt" timestamp with time zone, "unPubAt" timestamp with time zone, "publicTitle" character varying, "internalName" character varying, blocks jsonb, "nuggetType" nugget_api.nugget_types, subtype character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN QUERY (SELECT 
				  le.uid, 
				  le.created_at, 
				  le.updated_at, 
				  le.note, 
				  n.pub_at,
				  n.un_pub_at,
				  n.public_title,
				  n.internal_name,
				  n.blocks,
				  n.nugget_type,
				  n.subtype
	FROM nugget_api.logbook_entry le
	LEFT JOIN nugget n ON n.id = le.nugget_id
    INNER JOIN nugget_api.logbook l ON l.id = le.logbook_id
	INNER JOIN nugget_api.org o ON o.id = l.org_id
	INNER JOIN nugget_api.account a ON a.id = o.account_id
	INNER JOIN nugget_api.account_member am ON am.account_id = a.id
	INNER JOIN nugget_api.member m ON m.id = am.member_id
	WHERE m.uid = member_uid_in
 	AND le.uid = logbook_entry_uid_in );
END
$$;


--
-- Name: get_org_logbooks(uuid, uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.get_org_logbooks(member_uid_in uuid, org_uid_in uuid) RETURNS TABLE("logbookUid" uuid, "createdAt" timestamp without time zone, name character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN QUERY (SELECT l.uid, l.created_at, l.name
	FROM nugget_api.logbook l
	INNER JOIN nugget_api.org o ON o.id = l.org_id
	INNER JOIN nugget_api.account a ON a.id = o.account_id
	INNER JOIN nugget_api.account_member am ON am.account_id = a.id
	INNER JOIN nugget_api.member m ON m.id = am.member_id
	WHERE m.uid = member_uid_in
 	AND o.uid = org_uid_in );

	
END; 
$$;


--
-- Name: logbook_by_member(uuid, uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.logbook_by_member(member_uid_in uuid, logbook_uid_in uuid) RETURNS TABLE(id bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN QUERY (SELECT l.id
					FROM logbook l
					JOIN org o ON o.id = l.org_id
					JOIN org_member om ON om.org_id = o.id
					JOIN account a ON a.id = o.account_id
					JOIN account_member am ON am.account_id = a.id
					JOIN member m ON m.id = am.member_id
					WHERE l.uid = logbook_uid_in
					AND m.uid = member_uid_in
					AND (om.role = ANY('{"owner","leader"}') OR  'owner' = ANY(am.roles)));	
END; 
$$;


--
-- Name: logbook_by_org_member(uuid, uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.logbook_by_org_member(member_uid_in uuid, org_uid_in uuid) RETURNS TABLE(id bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN QUERY (SELECT l.id
					FROM logbook l
					JOIN org o ON o.id = l.org_id
					JOIN org_member om ON om.org_id = o.id
					JOIN account a ON a.id = o.account_id
					JOIN account_member am ON am.account_id = a.id
					JOIN member m ON m.id = am.member_id
					WHERE o.uid = org_uid_in
					AND m.uid = member_uid_in
					AND (om.roles = ANY('{"owner","leader"}') OR  'owner' = ANY(am.roles)));	
END; 
$$;


--
-- Name: logbook_entry_by_member(uuid, uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.logbook_entry_by_member(member_uid_in uuid, logbook_entry_uid_in uuid) RETURNS TABLE(logbook_id bigint, logbook_nugget_id bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN QUERY (SELECT le.id AS logbook_id, le.nugget_id AS logbook_nugget_id
					FROM logbook_entry le
				  INNER JOIN logbook l ON l.id =le.logbook_id
					JOIN org o ON o.id = l.org_id
					JOIN org_member om ON om.org_id = o.id
					JOIN account a ON a.id = o.account_id
					JOIN account_member am ON am.account_id = a.id
					JOIN member m ON m.id = am.member_id
					WHERE le.uid = logbook_entry_uid_in
					AND m.uid = member_uid_in);	
END; 
$$;


--
-- Name: member_account_by_role(uuid, nugget_api.account_roles); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.member_account_by_role(member_uid_in uuid, role_in nugget_api.account_roles) RETURNS TABLE(id bigint, uid uuid)
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN QUERY (SELECT a.id, a.uid
		FROM nugget_api.account a
		INNER JOIN nugget_api.account_member am ON am.account_id = a.id
		INNER JOIN nugget_api.member m ON m.id = am.member_id
		WHERE m.uid =  member_uid_in
		AND role_in = ANY(am.roles));	
END; 
$$;


--
-- Name: member_by_email(character varying); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.member_by_email(email_in character varying) RETURNS TABLE(id bigint, uid uuid)
    LANGUAGE plpgsql
    AS $$

DECLARE found_id bigint;
DECLARE found_uid uuid;

BEGIN

	SELECT m.id, m.uid FROM (
	SELECT user_id 
	FROM supertokens.emailpassword_users eu 
	WHERE eu.email = LOWER(email_in)
	UNION 
	SELECT user_id
	FROM supertokens.passwordless_users pu 
	WHERE pu.email = LOWER(email_in)
	) AS t
	JOIN member m ON m.uid = UUID(t.user_id)
	LIMIT 1 INTO found_id, found_uid;
	
	RETURN QUERY SELECT found_id, found_uid;

	
END; 
$$;


--
-- Name: new_member_from_user(); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.new_member_from_user() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
	DECLARE new_member_id BIGINT;
	DECLARE new_account_id BIGINT;	
BEGIN

	INSERT INTO nugget_api.member(uid, created_at)
	 VALUES(uuid(NEW.user_id), to_timestamp(NEW.time_joined/1000) )
	 RETURNING id INTO new_member_id;
	
	INSERT INTO nugget_api.account(name)
		 VALUES('Member Account for ' || new_member_id )
		 RETURNING id INTO new_account_id;
		
	INSERT INTO nugget_api.account_member(account_id, member_id, roles)
		 VALUES(new_account_id, new_member_id, '{"owner"}');
		 RETURN NEW;
END;
$$;


--
-- Name: patch_comment(uuid, uuid, text, character varying, character varying, jsonb, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.patch_comment(member_uid_in uuid, comment_uid_in uuid, note_in text, public_title_in character varying, internal_name_in character varying, blocks_in jsonb, pub_at_in timestamp without time zone, un_pub_at_in timestamp without time zone) RETURNS TABLE("commentUid" uuid, "updatedAt" timestamp without time zone)
    LANGUAGE plpgsql ROWS 1
    AS $$

DECLARE found_nugget_id bigint;
DECLARE new_updated_at timestamp without time zone;

BEGIN
	-- UPDATE logbook_entry.updated_at and if provided, logbook_entry.note
	-- RETURNING the updated_at and nugget_id INTO new_updated_at, and found_nugget_id
	UPDATE comment SET
	  note = COALESCE(NULLIF(note_in, ''), note)
	WHERE uid = comment_uid_in
	RETURNING updated_at, data_nugget_id INTO new_updated_at, found_nugget_id;

	-- UPDATE the underlying nugget 
	UPDATE nugget SET
	  public_title = COALESCE(NULLIF(public_title_in, ''), public_title),
	  internal_name = COALESCE(NULLIF(internal_name_in, ''), internal_name),
	  blocks = COALESCE(blocks_in, blocks),
	  pub_at = COALESCE(pub_at_in, pub_at),
	  un_pub_at = COALESCE(un_pub_at_in, un_pub_at)
	  
	WHERE nugget.id = found_nugget_id;
	 
	RETURN QUERY SELECT comment_uid_in, new_updated_at;
	
	
END; 
$$;


--
-- Name: patch_logbook_entry(uuid, uuid, text, character varying, character varying, jsonb, timestamp without time zone, timestamp without time zone); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.patch_logbook_entry(member_uid_in uuid, logbook_entry_uid_in uuid, note_in text, public_title_in character varying, internal_name_in character varying, blocks_in jsonb, pub_at_in timestamp without time zone, un_pub_at_in timestamp without time zone) RETURNS TABLE("logbookEntryUid" uuid, "updatedAt" timestamp without time zone)
    LANGUAGE plpgsql ROWS 1
    AS $$

DECLARE found_nugget_id bigint;
DECLARE new_updated_at timestamp without time zone;

BEGIN
	-- UPDATE logbook_entry.updated_at and if provided, logbook_entry.note
	-- RETURNING the updated_at and nugget_id INTO new_updated_at, and found_nugget_id
	UPDATE logbook_entry SET
	  note = COALESCE(NULLIF(note_in, ''), note)
	WHERE uid = logbook_entry_uid_in
	RETURNING updated_at, nugget_id INTO new_updated_at, found_nugget_id;

	-- UPDATE the underlying nugget 
	UPDATE nugget SET
	  public_title = COALESCE(NULLIF(public_title_in, ''), public_title),
	  internal_name = COALESCE(NULLIF(internal_name_in, ''), internal_name),
	  blocks = COALESCE(blocks_in, blocks),
	  pub_at = COALESCE(pub_at_in, pub_at),
	  un_pub_at = COALESCE(un_pub_at_in, un_pub_at)
	  
	WHERE nugget.id = found_nugget_id;
	 
	RETURN QUERY SELECT logbook_entry_uid_in, new_updated_at;
	
	
END; 
$$;


--
-- Name: secure_account_by_roles(uuid, uuid, nugget_api.account_roles[]); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.secure_account_by_roles(member_uid_in uuid, account_uid_in uuid, roles_in nugget_api.account_roles[]) RETURNS TABLE(id bigint)
    LANGUAGE plpgsql
    AS $$

DECLARE found_id bigint := 0;
DECLARE target org_roles;

BEGIN
	FOREACH target IN ARRAY roles_in LOOP
		SELECT a.id
		FROM account a 
		JOIN account_member am ON am.org_id = o.id
		JOIN member m ON m.id = am.member_id
		WHERE target = ANY(am.roles)
		INTO found_id;

		IF found_id > 0 
		THEN
			EXIT;
		END IF;
	END LOOP ;
	
	RETURN QUERY SELECT found_id;

END; 
$$;


--
-- Name: secure_logbook_account_org_by_roles(uuid, uuid, nugget_api.org_roles[]); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.secure_logbook_account_org_by_roles(member_uid_in uuid, org_uid_in uuid, roles_in nugget_api.org_roles[]) RETURNS TABLE(account_id bigint, org_id bigint, logbook_id bigint)
    LANGUAGE plpgsql
    AS $$

DECLARE found_account_id bigint := 0;
DECLARE found_org_id bigint := 0;
DECLARE found_logbook_id bigint := 0;
DECLARE target org_roles;

BEGIN

	FOREACH target IN ARRAY roles_in LOOP
		SELECT a.id AS account_id, o.id AS org_id, l.id AS logbook_id
		FROM org o
		JOIN org_member om ON om.org_id = o.id
		JOIN member m ON m.id = om.member_id
		JOIN account a ON a.id = o.account_id
		JOIN logbook l ON l.org_id = o.id
		WHERE o.uid = org_uid_in
		AND target = ANY(om.roles)
		INTO found_account_id, found_org_id, found_logbook_id;

		IF found_account_id > 0 AND  found_org_id > 0 AND found_logbook_id > 0
		THEN
			EXIT;
		END IF;
	END LOOP ;
	
	RETURN QUERY SELECT found_account_id AS account_id, found_org_id AS org_id, found_logbook_id AS logbook_id;

END; 
$$;


--
-- Name: secure_org_by_roles(uuid, uuid, nugget_api.org_roles[]); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.secure_org_by_roles(member_uid_in uuid, org_uid_in uuid, roles_in nugget_api.org_roles[]) RETURNS TABLE(id bigint)
    LANGUAGE plpgsql
    AS $$

DECLARE found_id bigint := 0;
DECLARE target org_roles;

BEGIN
	FOREACH target IN ARRAY roles_in LOOP
		SELECT o.id
		FROM org o 
		JOIN org_member om ON om.org_id = o.id
		JOIN member m ON m.id = om.member_id
		WHERE o.uid = org_uid_in
		AND target = ANY(om.roles)
		INTO found_id;

		IF found_id > 0 
		THEN
			EXIT;
		END IF;
	END LOOP ;
	
	RETURN QUERY SELECT found_id;

END; 
$$;


--
-- Name: set_logbook_entry_reaction(uuid, uuid, nugget_api.reaction_types[]); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.set_logbook_entry_reaction(member_uid_in uuid, logbook_entry_uid_in uuid, reactions_in nugget_api.reaction_types[]) RETURNS TABLE("reactedAt" timestamp without time zone)
    LANGUAGE plpgsql
    AS $$

DECLARE new_reacted_at timestamp without time zone;

BEGIN
    
	INSERT INTO nugget_api.reaction(nugget_id, member_id, reactions)
		 VALUES(
			(SELECT logbook_nugget_id FROM logbook_entry_by_member(member_uid_in, logbook_entry_uid_in)),
		    (SELECT id FROM member WHERE uid = member_uid_in),
		     reactions_in)
		ON CONFLICT ON CONSTRAINT reaction_pkey
		DO UPDATE SET reactions = reactions_in
		 RETURNING nugget_api.reaction.reacted_at INTO new_reacted_at;
		
	 
	RETURN QUERY SELECT new_reacted_at;
	
	
END; 
$$;


--
-- Name: set_reacted_at(); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.set_reacted_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.reacted_at = now();
    RETURN NEW;
END;
$$;


--
-- Name: set_updated_at(); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;


--
-- Name: update_member_email(); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.update_member_email() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN
	UPDATE nugget_api.member 
	SET email = NEW.email
	WHERE uid::text = NEW.user_id ;
 RETURN NULL;
END;
$$;


--
-- Name: update_org_logbook_entry(uuid, uuid, uuid, text); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.update_org_logbook_entry(member_uid_in uuid, org_uid_in uuid, logbook_entry_uid_in uuid, note_in text) RETURNS TABLE("updatedAt" timestamp without time zone)
    LANGUAGE plpgsql
    AS $$

DECLARE new_updated_at timestamp without time zone;

DECLARE valid_org_id bigint = secure_org_by_roles(member_uid_in, 
	org_uid_in, 
	ARRAY['owner','leader','delegate','representative']::org_roles[]);

BEGIN
    
	UPDATE logbook_entry le
	SET note =  COALESCE(NULLIF(note_in, ''), note)
	FROM logbook l 
	WHERE le.logbook_id = l.id
	AND le.uid = logbook_entry_uid_in
	AND l.org_id = valid_org_id
	RETURNING le.updated_at INTO new_updated_at;

	RETURN QUERY SELECT new_updated_at;
	
END; 
$$;


--
-- Name: update_org_logbook_entry_nugget(uuid, uuid, uuid, text, timestamp with time zone, timestamp with time zone, character varying, character varying, jsonb, character varying); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.update_org_logbook_entry_nugget(member_uid_in uuid, org_uid_in uuid, logbook_entry_uid_in uuid, note_in text, pub_at_in timestamp with time zone, un_pub_at_in timestamp with time zone, public_title_in character varying, internal_name_in character varying, blocks_in jsonb, subtype_in character varying) RETURNS TABLE("updatedAt" timestamp without time zone)
    LANGUAGE plpgsql
    AS $$

DECLARE new_updated_at timestamp without time zone;
DECLARE found_nugget_id bigint;

DECLARE valid_org_id bigint = secure_org_by_roles(member_uid_in, 
	org_uid_in, 
	ARRAY['owner','leader','delegate','representative']::org_roles[]);

BEGIN
    
	UPDATE logbook_entry le
	SET note = COALESCE(NULLIF(note_in, ''), note)
	FROM logbook l 
	WHERE le.logbook_id = l.id
	AND le.uid = logbook_entry_uid_in
	AND l.org_id = valid_org_id
	RETURNING le.updated_at, le.nugget_id INTO new_updated_at,found_nugget_id;
	
	-- Update the Nugget
	UPDATE nugget SET
	  public_title = COALESCE(NULLIF(public_title_in, ''), public_title),
	  internal_name = COALESCE(NULLIF(internal_name_in, ''), internal_name),
	  blocks = COALESCE(blocks_in, blocks),
	  pub_at = COALESCE(pub_at_in, pub_at),
	  un_pub_at = COALESCE(un_pub_at_in, un_pub_at),
      subtype = COALESCE(subtype_in, subtype)	  	
	WHERE nugget.id = found_nugget_id;
	
	RETURN QUERY SELECT new_updated_at;
	
END; 
$$;


--
-- Name: valid_logbook_account_org(uuid, uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.valid_logbook_account_org(member_uid_in uuid, logbook_uid_in uuid) RETURNS TABLE(account_id bigint, org_id bigint, logbook_id bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN QUERY (SELECT a.id AS account_id, o.id AS org_id, l.id AS logbook_id
		FROM nugget_api.account a
		INNER JOIN nugget_api.account_member am ON am.account_id = a.id
		INNER JOIN nugget_api.member m ON m.id = am.member_id
	    INNER JOIN nugget_api.org o ON o.account_id = a.id
	    INNER JOIN nugget_api.org_member om ON om.org_id = o.id AND om.member_id = m.id
	    INNER JOIN nugget_api.logbook l ON l.org_id = o.id
		WHERE m.uid =  member_uid_in
		AND l.uid = logbook_uid_in
		AND (om.role = ANY('{"owner","leader"}') OR  'owner' = ANY(am.roles)));	
END; 
$$;


--
-- Name: valid_logbook_entry_account_org(uuid, uuid); Type: FUNCTION; Schema: nugget_api; Owner: -
--

CREATE FUNCTION nugget_api.valid_logbook_entry_account_org(member_uid_in uuid, logbook_entry_uid_in uuid) RETURNS TABLE(account_id bigint, org_id bigint, logbook_id bigint, logbook_entry_id bigint, logbook_entry_nugget_id bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
	
	RETURN QUERY (SELECT a.id AS account_id, o.id AS org_id, l.id AS logbook_id, le.id AS logbook_entry_id, le.nugget_id AS logbook_entry_nugget_id
		FROM nugget_api.account a
		INNER JOIN nugget_api.account_member am ON am.account_id = a.id
		INNER JOIN nugget_api.member m ON m.id = am.member_id
	    INNER JOIN nugget_api.org o ON o.account_id = a.id
	    INNER JOIN nugget_api.org_member om ON om.org_id = o.id AND om.member_id = m.id
	    INNER JOIN nugget_api.logbook l ON l.org_id = o.id
	    INNER JOIN nugget_api.logbook_entry le ON le.logbook_id = l.id
		WHERE m.uid =  member_uid_in
		AND le.uid = logbook_entry_uid_in
		AND (om.role = ANY('{"owner","leader"}') OR  'owner' = ANY(am.roles)));	
END; 
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.account (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    name character varying(150),
    nugget_id bigint,
    deleted boolean DEFAULT false,
    updated_at timestamp without time zone,
    tenant_id bigint
);


--
-- Name: account_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: account_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.account_id_seq OWNED BY nugget_api.account.id;


--
-- Name: account_member; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.account_member (
    account_id bigint NOT NULL,
    member_id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    roles nugget_api.account_roles[] DEFAULT '{viewer}'::nugget_api.account_roles[] NOT NULL,
    deleted boolean DEFAULT false
);


--
-- Name: asset; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.asset (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid(),
    name character varying(150),
    byte_size integer,
    ext character varying(16),
    location character varying(2500),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    deleted boolean DEFAULT false NOT NULL,
    org_id bigint,
    nugget_id bigint
);


--
-- Name: asset_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.asset_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: asset_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.asset_id_seq OWNED BY nugget_api.asset.id;


--
-- Name: calendar; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.calendar (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    org_id bigint,
    deleted boolean DEFAULT false,
    all_day boolean,
    start timestamp without time zone,
    "end" timestamp without time zone,
    note character varying(4096),
    geo point[],
    duration integer,
    labels character varying(24)[],
    nugget_id bigint,
    local_tz character varying(29),
    account_id bigint NOT NULL
);


--
-- Name: calendar_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.calendar_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: calendar_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.calendar_id_seq OWNED BY nugget_api.calendar.id;


--
-- Name: comment; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.comment (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    target_nugget_id bigint NOT NULL,
    updated_at timestamp without time zone,
    note text,
    data_nugget_id bigint,
    deleted boolean
);


--
-- Name: email; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.email (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    recipient character varying(256),
    template character varying(32),
    data jsonb,
    status nugget_api.email_status DEFAULT 'queued'::nugget_api.email_status,
    delivery_id character varying(32)
);


--
-- Name: email_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.email_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: email_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.email_id_seq OWNED BY nugget_api.email.id;


--
-- Name: entry_relation; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.entry_relation (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    entry_id bigint NOT NULL,
    related_entry_id bigint NOT NULL,
    nugget_type nugget_api.nugget_types NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    deleted boolean
);


--
-- Name: entry_relation_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.entry_relation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: entry_relation_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.entry_relation_id_seq OWNED BY nugget_api.entry_relation.id;


--
-- Name: invite; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.invite (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    by_member_id bigint NOT NULL,
    acting_as_account_id bigint,
    to_org_id bigint,
    note character varying(2048),
    email character varying(256) NOT NULL,
    deleted boolean,
    status nugget_api.invite_status DEFAULT 'queued'::nugget_api.invite_status NOT NULL,
    email_id bigint
);


--
-- Name: invite_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.invite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invite_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.invite_id_seq OWNED BY nugget_api.invite.id;


--
-- Name: ledger; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.ledger (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp with time zone,
    name character varying(64),
    org_id bigint,
    deleted boolean
);


--
-- Name: ledger_account; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.ledger_account (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    ledger_id bigint NOT NULL,
    name character(64),
    allow_negative boolean DEFAULT false NOT NULL,
    balance integer DEFAULT 0 NOT NULL
);


--
-- Name: ledger_accounts_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.ledger_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ledger_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.ledger_accounts_id_seq OWNED BY nugget_api.ledger_account.id;


--
-- Name: ledger_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.ledger_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ledger_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.ledger_id_seq OWNED BY nugget_api.ledger.id;


--
-- Name: ledger_transaction; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.ledger_transaction (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_up timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    ledger_id bigint,
    total integer DEFAULT 0,
    transaction_items jsonb
);


--
-- Name: logbook; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.logbook (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    name character varying(64) NOT NULL,
    org_id bigint NOT NULL,
    deleted boolean DEFAULT false,
    updated_at timestamp without time zone
);


--
-- Name: logbook_entry; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.logbook_entry (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    logbook_id bigint,
    note text,
    nugget_id bigint,
    updated_at timestamp without time zone,
    deleted boolean DEFAULT false
);


--
-- Name: logbook_entry_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.logbook_entry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: logbook_entry_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.logbook_entry_id_seq OWNED BY nugget_api.logbook_entry.id;


--
-- Name: logbook_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.logbook_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: logbook_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.logbook_id_seq OWNED BY nugget_api.logbook.id;


--
-- Name: member; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.member (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    full_name character varying(64),
    platform_username character varying(32),
    public_profile boolean DEFAULT false NOT NULL,
    updated_at timestamp without time zone,
    nugget_id bigint,
    deleted boolean,
    tenant_id bigint,
    email character varying(256)
);


--
-- Name: org; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.org (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    account_id bigint NOT NULL,
    name character varying(64),
    note text,
    updated_at timestamp without time zone,
    nugget_id bigint,
    deleted boolean DEFAULT false
);


--
-- Name: member_account_org_logbooks; Type: VIEW; Schema: nugget_api; Owner: -
--

CREATE VIEW nugget_api.member_account_org_logbooks AS
 SELECT m.email,
    m.id AS member_id,
    m.uid AS member_uid,
    a.id AS account_id,
    a.uid AS account_uid,
    o.id AS org_id,
    o.uid AS org_uid,
    l.id AS logbook_id,
    l.uid AS logbook_uid
   FROM ((((nugget_api.member m
     JOIN nugget_api.account_member am ON ((am.member_id = m.id)))
     JOIN nugget_api.account a ON ((a.id = am.account_id)))
     JOIN nugget_api.org o ON ((o.account_id = a.id)))
     JOIN nugget_api.logbook l ON ((l.org_id = o.id)));


--
-- Name: member_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: member_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.member_id_seq OWNED BY nugget_api.member.id;


--
-- Name: nugget; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.nugget (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    pub_at timestamp with time zone,
    un_pub_at timestamp with time zone,
    public_title character varying(150),
    internal_name character varying(75),
    blocks jsonb DEFAULT '{}'::jsonb,
    nugget_type nugget_api.nugget_types DEFAULT 'json'::nugget_api.nugget_types NOT NULL,
    org_id bigint,
    account_id bigint NOT NULL,
    subtype character varying(32),
    deleted boolean DEFAULT false
);


--
-- Name: nugget_comment_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.nugget_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: nugget_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.nugget_comment_id_seq OWNED BY nugget_api.comment.id;


--
-- Name: nugget_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.nugget_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: nugget_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.nugget_id_seq OWNED BY nugget_api.nugget.id;


--
-- Name: nugget_metric; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.nugget_metric (
    nugget_id bigint NOT NULL,
    comments integer,
    views integer,
    shares integer,
    consent integer,
    object integer,
    abstain integer,
    agree integer,
    disagree integer,
    unsure integer,
    "like" integer,
    dislike integer,
    neutral integer,
    promote integer,
    bury integer,
    block integer,
    sympathy integer,
    empathy integer,
    concern integer,
    frustration integer,
    anger integer,
    confusion integer,
    boredom integer
);


--
-- Name: org_account_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.org_account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: org_account_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.org_account_id_seq OWNED BY nugget_api.org.account_id;


--
-- Name: org_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.org_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: org_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.org_id_seq OWNED BY nugget_api.org.id;


--
-- Name: org_member; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.org_member (
    org_id bigint NOT NULL,
    member_id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    deleted boolean DEFAULT false,
    nugget_id bigint,
    roles nugget_api.org_roles[]
);


--
-- Name: reaction; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.reaction (
    nugget_id bigint NOT NULL,
    member_id bigint NOT NULL,
    reacted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    reactions nugget_api.reaction_types[] DEFAULT '{like}'::nugget_api.reaction_types[] NOT NULL,
    deleted boolean DEFAULT false
);


--
-- Name: reply; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.reply (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    comment_id bigint,
    reply_id bigint,
    nugget_id bigint NOT NULL,
    note text,
    org_id bigint,
    updated_at timestamp without time zone,
    deleted boolean DEFAULT false
);


--
-- Name: response_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.response_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: response_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.response_id_seq OWNED BY nugget_api.reply.id;


--
-- Name: tenant; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.tenant (
    id bigint NOT NULL,
    uid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    name character varying(32) NOT NULL
);


--
-- Name: tenant_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.tenant_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tenant_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.tenant_id_seq OWNED BY nugget_api.tenant.id;


--
-- Name: transaction_items; Type: TABLE; Schema: nugget_api; Owner: -
--

CREATE TABLE nugget_api.transaction_items (
    id bigint NOT NULL,
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone,
    amount integer NOT NULL,
    credit_account_id bigint NOT NULL,
    debit_account_id bigint NOT NULL,
    transaction_id bigint NOT NULL
);


--
-- Name: transaction_items_id_seq; Type: SEQUENCE; Schema: nugget_api; Owner: -
--

CREATE SEQUENCE nugget_api.transaction_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: transaction_items_id_seq; Type: SEQUENCE OWNED BY; Schema: nugget_api; Owner: -
--

ALTER SEQUENCE nugget_api.transaction_items_id_seq OWNED BY nugget_api.transaction_items.id;


--
-- Name: account id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.account ALTER COLUMN id SET DEFAULT nextval('nugget_api.account_id_seq'::regclass);


--
-- Name: asset id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.asset ALTER COLUMN id SET DEFAULT nextval('nugget_api.asset_id_seq'::regclass);


--
-- Name: calendar id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.calendar ALTER COLUMN id SET DEFAULT nextval('nugget_api.calendar_id_seq'::regclass);


--
-- Name: comment id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.comment ALTER COLUMN id SET DEFAULT nextval('nugget_api.nugget_comment_id_seq'::regclass);


--
-- Name: email id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.email ALTER COLUMN id SET DEFAULT nextval('nugget_api.email_id_seq'::regclass);


--
-- Name: entry_relation id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.entry_relation ALTER COLUMN id SET DEFAULT nextval('nugget_api.entry_relation_id_seq'::regclass);


--
-- Name: invite id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.invite ALTER COLUMN id SET DEFAULT nextval('nugget_api.invite_id_seq'::regclass);


--
-- Name: ledger id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.ledger ALTER COLUMN id SET DEFAULT nextval('nugget_api.ledger_id_seq'::regclass);


--
-- Name: ledger_account id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.ledger_account ALTER COLUMN id SET DEFAULT nextval('nugget_api.ledger_accounts_id_seq'::regclass);


--
-- Name: logbook id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.logbook ALTER COLUMN id SET DEFAULT nextval('nugget_api.logbook_id_seq'::regclass);


--
-- Name: logbook_entry id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.logbook_entry ALTER COLUMN id SET DEFAULT nextval('nugget_api.logbook_entry_id_seq'::regclass);


--
-- Name: member id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.member ALTER COLUMN id SET DEFAULT nextval('nugget_api.member_id_seq'::regclass);


--
-- Name: nugget id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.nugget ALTER COLUMN id SET DEFAULT nextval('nugget_api.nugget_id_seq'::regclass);


--
-- Name: org id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.org ALTER COLUMN id SET DEFAULT nextval('nugget_api.org_id_seq'::regclass);


--
-- Name: org account_id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.org ALTER COLUMN account_id SET DEFAULT nextval('nugget_api.org_account_id_seq'::regclass);


--
-- Name: reply id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.reply ALTER COLUMN id SET DEFAULT nextval('nugget_api.response_id_seq'::regclass);


--
-- Name: tenant id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.tenant ALTER COLUMN id SET DEFAULT nextval('nugget_api.tenant_id_seq'::regclass);


--
-- Name: transaction_items id; Type: DEFAULT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.transaction_items ALTER COLUMN id SET DEFAULT nextval('nugget_api.transaction_items_id_seq'::regclass);


--
-- Name: account_member account_member_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.account_member
    ADD CONSTRAINT account_member_pkey PRIMARY KEY (account_id, member_id);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: asset asset_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.asset
    ADD CONSTRAINT asset_pkey PRIMARY KEY (id);


--
-- Name: calendar calendar_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.calendar
    ADD CONSTRAINT calendar_pkey PRIMARY KEY (id);


--
-- Name: email email_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.email
    ADD CONSTRAINT email_pkey PRIMARY KEY (id);


--
-- Name: entry_relation entry_relation_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.entry_relation
    ADD CONSTRAINT entry_relation_pkey PRIMARY KEY (id);


--
-- Name: invite invite_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.invite
    ADD CONSTRAINT invite_pkey PRIMARY KEY (id);


--
-- Name: ledger_account ledger_account_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.ledger_account
    ADD CONSTRAINT ledger_account_pkey PRIMARY KEY (id);


--
-- Name: ledger ledger_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.ledger
    ADD CONSTRAINT ledger_pkey PRIMARY KEY (id);


--
-- Name: ledger_transaction ledger_transaction_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.ledger_transaction
    ADD CONSTRAINT ledger_transaction_pkey PRIMARY KEY (id);


--
-- Name: logbook_entry logbook_entry_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.logbook_entry
    ADD CONSTRAINT logbook_entry_pkey PRIMARY KEY (id);


--
-- Name: logbook logbook_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.logbook
    ADD CONSTRAINT logbook_pkey PRIMARY KEY (id);


--
-- Name: member member_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.member
    ADD CONSTRAINT member_pkey PRIMARY KEY (id);


--
-- Name: comment nugget_comment_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.comment
    ADD CONSTRAINT nugget_comment_pkey PRIMARY KEY (id);


--
-- Name: nugget_metric nugget_metric_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.nugget_metric
    ADD CONSTRAINT nugget_metric_pkey PRIMARY KEY (nugget_id);


--
-- Name: nugget nugget_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.nugget
    ADD CONSTRAINT nugget_pkey PRIMARY KEY (id);


--
-- Name: org_member org_member_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.org_member
    ADD CONSTRAINT org_member_pkey PRIMARY KEY (org_id, member_id);


--
-- Name: org org_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.org
    ADD CONSTRAINT org_pkey PRIMARY KEY (id);


--
-- Name: reaction reaction_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.reaction
    ADD CONSTRAINT reaction_pkey PRIMARY KEY (nugget_id, member_id);


--
-- Name: reply response_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.reply
    ADD CONSTRAINT response_pkey PRIMARY KEY (id);


--
-- Name: tenant tenant_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.tenant
    ADD CONSTRAINT tenant_pkey PRIMARY KEY (id);


--
-- Name: transaction_items transaction_items_pkey; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.transaction_items
    ADD CONSTRAINT transaction_items_pkey PRIMARY KEY (id);


--
-- Name: account uq_account_uid; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.account
    ADD CONSTRAINT uq_account_uid UNIQUE (uid);


--
-- Name: asset uq_asset_uid; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.asset
    ADD CONSTRAINT uq_asset_uid UNIQUE (uid);


--
-- Name: calendar uq_calendar_uuid; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.calendar
    ADD CONSTRAINT uq_calendar_uuid UNIQUE (uid);


--
-- Name: comment uq_comment_uid; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.comment
    ADD CONSTRAINT uq_comment_uid UNIQUE (uid);


--
-- Name: entry_relation uq_entry_relation_uid; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.entry_relation
    ADD CONSTRAINT uq_entry_relation_uid UNIQUE (uid);


--
-- Name: invite uq_invite_uuid; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.invite
    ADD CONSTRAINT uq_invite_uuid UNIQUE (uid);


--
-- Name: ledger_account uq_ledger_account_uid; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.ledger_account
    ADD CONSTRAINT uq_ledger_account_uid UNIQUE (uid);


--
-- Name: ledger_transaction uq_ledger_transaction_uid; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.ledger_transaction
    ADD CONSTRAINT uq_ledger_transaction_uid UNIQUE (uid);


--
-- Name: ledger uq_ledger_uid; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.ledger
    ADD CONSTRAINT uq_ledger_uid UNIQUE (uid);


--
-- Name: logbook_entry uq_logbook_entry_uid; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.logbook_entry
    ADD CONSTRAINT uq_logbook_entry_uid UNIQUE (uid);


--
-- Name: logbook uq_logbook_org_name; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.logbook
    ADD CONSTRAINT uq_logbook_org_name UNIQUE (name, org_id);


--
-- Name: logbook uq_logbook_uid; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.logbook
    ADD CONSTRAINT uq_logbook_uid UNIQUE (uid);


--
-- Name: member uq_member_uid; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.member
    ADD CONSTRAINT uq_member_uid UNIQUE (uid);


--
-- Name: nugget uq_nugget_uid; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.nugget
    ADD CONSTRAINT uq_nugget_uid UNIQUE (uid);


--
-- Name: org uq_org_uid; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.org
    ADD CONSTRAINT uq_org_uid UNIQUE (uid);


--
-- Name: reply uq_response_uid; Type: CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.reply
    ADD CONSTRAINT uq_response_uid UNIQUE (uid);


--
-- Name: account_member set_account_member_created_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_account_member_created_at BEFORE UPDATE ON nugget_api.account_member FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: account set_account_updated_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_account_updated_at BEFORE UPDATE ON nugget_api.account FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: asset set_asset_updated_at ; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER "set_asset_updated_at " BEFORE UPDATE ON nugget_api.asset FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: comment set_comment_updated_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_comment_updated_at BEFORE UPDATE ON nugget_api.comment FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: email set_email_updated_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_email_updated_at BEFORE UPDATE ON nugget_api.email FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: invite set_invite_updated_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_invite_updated_at BEFORE UPDATE ON nugget_api.invite FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: ledger_account set_ledger_account_updated_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_ledger_account_updated_at BEFORE UPDATE OF updated_at ON nugget_api.ledger_account FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: ledger_transaction set_ledger_transaction_updated_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_ledger_transaction_updated_at BEFORE UPDATE ON nugget_api.ledger_transaction FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: ledger set_ledger_updated_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_ledger_updated_at BEFORE UPDATE ON nugget_api.ledger FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: logbook_entry set_logbook_entry_updated_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_logbook_entry_updated_at BEFORE UPDATE ON nugget_api.logbook_entry FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: logbook set_logbook_updated_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_logbook_updated_at BEFORE UPDATE ON nugget_api.logbook FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: member set_member_updated_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_member_updated_at BEFORE UPDATE ON nugget_api.member FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: nugget set_nugget_updated_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_nugget_updated_at BEFORE UPDATE ON nugget_api.nugget FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: org_member set_org_member_updated_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_org_member_updated_at BEFORE UPDATE ON nugget_api.org_member FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: org set_org_updated_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_org_updated_at BEFORE UPDATE ON nugget_api.org FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: reaction set_reaction_reacted_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_reaction_reacted_at BEFORE UPDATE ON nugget_api.reaction FOR EACH ROW EXECUTE FUNCTION nugget_api.set_reacted_at();


--
-- Name: reply set_reply_updated_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_reply_updated_at BEFORE UPDATE ON nugget_api.reply FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: tenant set_tenant_updated_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_tenant_updated_at BEFORE UPDATE ON nugget_api.tenant FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: transaction_items set_transaction_items_updated_at; Type: TRIGGER; Schema: nugget_api; Owner: -
--

CREATE TRIGGER set_transaction_items_updated_at BEFORE UPDATE ON nugget_api.transaction_items FOR EACH ROW EXECUTE FUNCTION nugget_api.set_updated_at();


--
-- Name: ledger_account fk_account_ledger_org_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.ledger_account
    ADD CONSTRAINT fk_account_ledger_org_id FOREIGN KEY (ledger_id) REFERENCES nugget_api.ledger(id);


--
-- Name: account_member fk_account_member_account_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.account_member
    ADD CONSTRAINT fk_account_member_account_id FOREIGN KEY (account_id) REFERENCES nugget_api.account(id) NOT VALID;


--
-- Name: account_member fk_account_member_member_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.account_member
    ADD CONSTRAINT fk_account_member_member_id FOREIGN KEY (member_id) REFERENCES nugget_api.member(id) NOT VALID;


--
-- Name: account fk_account_nugget_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.account
    ADD CONSTRAINT fk_account_nugget_id FOREIGN KEY (nugget_id) REFERENCES nugget_api.nugget(id) NOT VALID;


--
-- Name: account fk_account_tenant_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.account
    ADD CONSTRAINT fk_account_tenant_id FOREIGN KEY (tenant_id) REFERENCES nugget_api.tenant(id) NOT VALID;


--
-- Name: asset fk_asset_nugget_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.asset
    ADD CONSTRAINT fk_asset_nugget_id FOREIGN KEY (nugget_id) REFERENCES nugget_api.nugget(id) NOT VALID;


--
-- Name: asset fk_asset_orgid; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.asset
    ADD CONSTRAINT fk_asset_orgid FOREIGN KEY (org_id) REFERENCES nugget_api.org(id) NOT VALID;


--
-- Name: calendar fk_calendar_account_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.calendar
    ADD CONSTRAINT fk_calendar_account_id FOREIGN KEY (account_id) REFERENCES nugget_api.account(id) NOT VALID;


--
-- Name: calendar fk_calendar_nugget_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.calendar
    ADD CONSTRAINT fk_calendar_nugget_id FOREIGN KEY (nugget_id) REFERENCES nugget_api.nugget(id) NOT VALID;


--
-- Name: calendar fk_calendar_org_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.calendar
    ADD CONSTRAINT fk_calendar_org_id FOREIGN KEY (org_id) REFERENCES nugget_api.org(id) NOT VALID;


--
-- Name: comment fk_comment_data_nugget_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.comment
    ADD CONSTRAINT fk_comment_data_nugget_id FOREIGN KEY (data_nugget_id) REFERENCES nugget_api.nugget(id) NOT VALID;


--
-- Name: comment fk_comment_target_nugget_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.comment
    ADD CONSTRAINT fk_comment_target_nugget_id FOREIGN KEY (target_nugget_id) REFERENCES nugget_api.nugget(id) NOT VALID;


--
-- Name: entry_relation fk_entry_relation_entry_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.entry_relation
    ADD CONSTRAINT fk_entry_relation_entry_id FOREIGN KEY (entry_id) REFERENCES nugget_api.logbook_entry(id) NOT VALID;


--
-- Name: entry_relation fk_entry_relation_related_entry_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.entry_relation
    ADD CONSTRAINT fk_entry_relation_related_entry_id FOREIGN KEY (related_entry_id) REFERENCES nugget_api.logbook_entry(id) NOT VALID;


--
-- Name: invite fk_invite_account_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.invite
    ADD CONSTRAINT fk_invite_account_id FOREIGN KEY (acting_as_account_id) REFERENCES nugget_api.account(id) NOT VALID;


--
-- Name: invite fk_invite_email_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.invite
    ADD CONSTRAINT fk_invite_email_id FOREIGN KEY (email_id) REFERENCES nugget_api.email(id) NOT VALID;


--
-- Name: invite fk_invite_member_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.invite
    ADD CONSTRAINT fk_invite_member_id FOREIGN KEY (by_member_id) REFERENCES nugget_api.member(id) NOT VALID;


--
-- Name: invite fk_invite_org_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.invite
    ADD CONSTRAINT fk_invite_org_id FOREIGN KEY (to_org_id) REFERENCES nugget_api.org(id) NOT VALID;


--
-- Name: ledger fk_ledger_org_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.ledger
    ADD CONSTRAINT fk_ledger_org_id FOREIGN KEY (org_id) REFERENCES nugget_api.org(id) NOT VALID;


--
-- Name: ledger_transaction fk_ledger_transaction_ledger_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.ledger_transaction
    ADD CONSTRAINT fk_ledger_transaction_ledger_id FOREIGN KEY (ledger_id) REFERENCES nugget_api.ledger(id);


--
-- Name: logbook_entry fk_logbook_entry_logbook_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.logbook_entry
    ADD CONSTRAINT fk_logbook_entry_logbook_id FOREIGN KEY (logbook_id) REFERENCES nugget_api.logbook(id) NOT VALID;


--
-- Name: logbook_entry fk_logbook_entry_nugget_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.logbook_entry
    ADD CONSTRAINT fk_logbook_entry_nugget_id FOREIGN KEY (nugget_id) REFERENCES nugget_api.nugget(id) NOT VALID;


--
-- Name: logbook fk_logbook_org_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.logbook
    ADD CONSTRAINT fk_logbook_org_id FOREIGN KEY (org_id) REFERENCES nugget_api.org(id) NOT VALID;


--
-- Name: member fk_member_nugget_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.member
    ADD CONSTRAINT fk_member_nugget_id FOREIGN KEY (nugget_id) REFERENCES nugget_api.nugget(id) NOT VALID;


--
-- Name: member fk_member_tenant_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.member
    ADD CONSTRAINT fk_member_tenant_id FOREIGN KEY (tenant_id) REFERENCES nugget_api.tenant(id) NOT VALID;


--
-- Name: nugget fk_nugget_org_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.nugget
    ADD CONSTRAINT fk_nugget_org_id FOREIGN KEY (org_id) REFERENCES nugget_api.org(id) NOT VALID;


--
-- Name: org fk_org_account_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.org
    ADD CONSTRAINT fk_org_account_id FOREIGN KEY (account_id) REFERENCES nugget_api.account(id) NOT VALID;


--
-- Name: org_member fk_org_member_member_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.org_member
    ADD CONSTRAINT fk_org_member_member_id FOREIGN KEY (member_id) REFERENCES nugget_api.member(id);


--
-- Name: org_member fk_org_member_nugget_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.org_member
    ADD CONSTRAINT fk_org_member_nugget_id FOREIGN KEY (nugget_id) REFERENCES nugget_api.nugget(id) NOT VALID;


--
-- Name: org_member fk_org_member_org_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.org_member
    ADD CONSTRAINT fk_org_member_org_id FOREIGN KEY (org_id) REFERENCES nugget_api.org(id);


--
-- Name: org fk_org_nugget_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.org
    ADD CONSTRAINT fk_org_nugget_id FOREIGN KEY (nugget_id) REFERENCES nugget_api.nugget(id) NOT VALID;


--
-- Name: reaction fk_reaction_member_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.reaction
    ADD CONSTRAINT fk_reaction_member_id FOREIGN KEY (member_id) REFERENCES nugget_api.member(id) NOT VALID;


--
-- Name: reaction fk_reaction_nugget_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.reaction
    ADD CONSTRAINT fk_reaction_nugget_id FOREIGN KEY (nugget_id) REFERENCES nugget_api.nugget(id) NOT VALID;


--
-- Name: reply fk_reply_comment_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.reply
    ADD CONSTRAINT fk_reply_comment_id FOREIGN KEY (comment_id) REFERENCES nugget_api.comment(id) NOT VALID;


--
-- Name: reply fk_reply_nugget_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.reply
    ADD CONSTRAINT fk_reply_nugget_id FOREIGN KEY (nugget_id) REFERENCES nugget_api.nugget(id) NOT VALID;


--
-- Name: reply fk_reply_org_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.reply
    ADD CONSTRAINT fk_reply_org_id FOREIGN KEY (org_id) REFERENCES nugget_api.org(id) NOT VALID;


--
-- Name: reply fk_reply_reply_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.reply
    ADD CONSTRAINT fk_reply_reply_id FOREIGN KEY (reply_id) REFERENCES nugget_api.reply(id) NOT VALID;


--
-- Name: transaction_items fk_transaction_items_credit_account_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.transaction_items
    ADD CONSTRAINT fk_transaction_items_credit_account_id FOREIGN KEY (credit_account_id) REFERENCES nugget_api.ledger_account(id) NOT VALID;


--
-- Name: transaction_items fk_transaction_items_debit_account_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.transaction_items
    ADD CONSTRAINT fk_transaction_items_debit_account_id FOREIGN KEY (debit_account_id) REFERENCES nugget_api.ledger_account(id) NOT VALID;


--
-- Name: transaction_items fk_transaction_items_transaction_id; Type: FK CONSTRAINT; Schema: nugget_api; Owner: -
--

ALTER TABLE ONLY nugget_api.transaction_items
    ADD CONSTRAINT fk_transaction_items_transaction_id FOREIGN KEY (transaction_id) REFERENCES nugget_api.ledger_transaction(id) NOT VALID;


--
-- Name: SCHEMA nugget_api; Type: ACL; Schema: -; Owner: -
--

GRANT USAGE ON SCHEMA nugget_api TO ultri_supertokens;


--
-- Name: TABLE account; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON TABLE nugget_api.account TO ultri_supertokens;


--
-- Name: SEQUENCE account_id_seq; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON SEQUENCE nugget_api.account_id_seq TO ultri_supertokens;


--
-- Name: TABLE account_member; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON TABLE nugget_api.account_member TO ultri_supertokens;


--
-- Name: TABLE asset; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON TABLE nugget_api.asset TO ultri_supertokens;


--
-- Name: SEQUENCE asset_id_seq; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON SEQUENCE nugget_api.asset_id_seq TO ultri_supertokens;


--
-- Name: TABLE comment; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON TABLE nugget_api.comment TO ultri_supertokens;


--
-- Name: TABLE logbook; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON TABLE nugget_api.logbook TO ultri_supertokens;


--
-- Name: TABLE logbook_entry; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON TABLE nugget_api.logbook_entry TO ultri_supertokens;


--
-- Name: SEQUENCE logbook_entry_id_seq; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON SEQUENCE nugget_api.logbook_entry_id_seq TO ultri_supertokens;


--
-- Name: SEQUENCE logbook_id_seq; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON SEQUENCE nugget_api.logbook_id_seq TO ultri_supertokens;


--
-- Name: TABLE member; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON TABLE nugget_api.member TO ultri_supertokens;


--
-- Name: TABLE org; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON TABLE nugget_api.org TO ultri_supertokens;


--
-- Name: SEQUENCE member_id_seq; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON SEQUENCE nugget_api.member_id_seq TO ultri_supertokens;


--
-- Name: TABLE nugget; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON TABLE nugget_api.nugget TO ultri_supertokens;


--
-- Name: SEQUENCE nugget_comment_id_seq; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON SEQUENCE nugget_api.nugget_comment_id_seq TO ultri_supertokens;


--
-- Name: SEQUENCE nugget_id_seq; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON SEQUENCE nugget_api.nugget_id_seq TO ultri_supertokens;


--
-- Name: TABLE nugget_metric; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON TABLE nugget_api.nugget_metric TO ultri_supertokens;


--
-- Name: SEQUENCE org_account_id_seq; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON SEQUENCE nugget_api.org_account_id_seq TO ultri_supertokens;


--
-- Name: SEQUENCE org_id_seq; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON SEQUENCE nugget_api.org_id_seq TO ultri_supertokens;


--
-- Name: TABLE org_member; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON TABLE nugget_api.org_member TO ultri_supertokens;


--
-- Name: TABLE reaction; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON TABLE nugget_api.reaction TO ultri_supertokens;


--
-- Name: TABLE reply; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON TABLE nugget_api.reply TO ultri_supertokens;


--
-- Name: SEQUENCE response_id_seq; Type: ACL; Schema: nugget_api; Owner: -
--

GRANT ALL ON SEQUENCE nugget_api.response_id_seq TO ultri_supertokens;


--
-- PostgreSQL database dump complete
--

