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
-- Data for Name: nugget_type; Type: TABLE DATA; Schema: nugget; Owner: -
--

COPY nugget.nugget_type (id, name) FROM stdin;
1	org
2	account
3	circle
4	member
5	tenant
6	driver
7	canvas
8	okr
9	proposal
10	decision
11	agreement
12	presentation
\.


--
-- Name: nugget_type_id_seq; Type: SEQUENCE SET; Schema: nugget; Owner: -
--

SELECT pg_catalog.setval('nugget.nugget_type_id_seq', 12, true);


--
-- PostgreSQL database dump complete
--

