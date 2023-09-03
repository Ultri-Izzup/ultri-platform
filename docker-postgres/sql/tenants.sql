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
-- Data for Name: tenant; Type: TABLE DATA; Schema: nugget; Owner: -
--

COPY nugget.tenant (id, uid, name, created_at, updated_at, deleted) FROM stdin;
1	75c3184e-396b-482c-8677-9f1f556deb26	platform	2023-09-03 21:48:05.306605	\N	f
\.


--
-- Name: tenant_id_seq; Type: SEQUENCE SET; Schema: nugget; Owner: -
--

SELECT pg_catalog.setval('nugget.tenant_id_seq', 1, true);


--
-- PostgreSQL database dump complete
--

