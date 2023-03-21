--
-- PostgreSQL database cluster dump
--

-- Started on 2023-03-21 22:04:12 WIB

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE root;
ALTER ROLE root WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'md5a2a79aeb9db7ef18078da7805b5c2a16';






--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.10
-- Dumped by pg_dump version 14.7 (Ubuntu 14.7-0ubuntu0.22.04.1)

-- Started on 2023-03-21 22:04:12 WIB

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

-- Completed on 2023-03-21 22:04:12 WIB

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.10
-- Dumped by pg_dump version 14.7 (Ubuntu 14.7-0ubuntu0.22.04.1)

-- Started on 2023-03-21 22:04:12 WIB

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

-- Completed on 2023-03-21 22:04:13 WIB

--
-- PostgreSQL database dump complete
--

--
-- Database "tabungan" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 13.10
-- Dumped by pg_dump version 14.7 (Ubuntu 14.7-0ubuntu0.22.04.1)

-- Started on 2023-03-21 22:04:13 WIB

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
-- TOC entry 3052 (class 1262 OID 16384)
-- Name: tabungan; Type: DATABASE; Schema: -; Owner: root
--

CREATE DATABASE tabungan WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE tabungan OWNER TO root;

\connect tabungan

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 201 (class 1259 OID 16387)
-- Name: daftar_old; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.daftar_old (
    id integer NOT NULL,
    nama character varying NOT NULL,
    nik character varying NOT NULL,
    no_hp character varying NOT NULL
);


ALTER TABLE public.daftar_old OWNER TO root;

--
-- TOC entry 200 (class 1259 OID 16385)
-- Name: daftar_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.daftar_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.daftar_id_seq OWNER TO root;

--
-- TOC entry 3053 (class 0 OID 0)
-- Dependencies: 200
-- Name: daftar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.daftar_id_seq OWNED BY public.daftar_old.id;


--
-- TOC entry 202 (class 1259 OID 16409)
-- Name: daftar; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.daftar (
    id integer DEFAULT nextval('public.daftar_id_seq'::regclass) NOT NULL,
    nama character varying(255) NOT NULL,
    nik character varying(255) NOT NULL,
    no_hp character varying(255) NOT NULL
);


ALTER TABLE public.daftar OWNER TO root;

--
-- TOC entry 204 (class 1259 OID 16444)
-- Name: no_rekening_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.no_rekening_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.no_rekening_id_seq OWNER TO root;

--
-- TOC entry 203 (class 1259 OID 16417)
-- Name: no_rekening; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.no_rekening (
    id integer DEFAULT nextval('public.no_rekening_id_seq'::regclass) NOT NULL,
    daftar_id integer NOT NULL,
    no_rekening integer NOT NULL
);


ALTER TABLE public.no_rekening OWNER TO root;

--
-- TOC entry 206 (class 1259 OID 16449)
-- Name: tabung; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.tabung (
    id integer NOT NULL,
    no_rekening integer NOT NULL,
    nominal character varying,
    status character varying,
    waktu timestamp without time zone
);


ALTER TABLE public.tabung OWNER TO root;

--
-- TOC entry 205 (class 1259 OID 16447)
-- Name: tabung_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.tabung_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tabung_id_seq OWNER TO root;

--
-- TOC entry 3054 (class 0 OID 0)
-- Dependencies: 205
-- Name: tabung_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.tabung_id_seq OWNED BY public.tabung.id;


--
-- TOC entry 2892 (class 2604 OID 16390)
-- Name: daftar_old id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.daftar_old ALTER COLUMN id SET DEFAULT nextval('public.daftar_id_seq'::regclass);


--
-- TOC entry 2895 (class 2604 OID 16452)
-- Name: tabung id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tabung ALTER COLUMN id SET DEFAULT nextval('public.tabung_id_seq'::regclass);


--
-- TOC entry 3042 (class 0 OID 16409)
-- Dependencies: 202
-- Data for Name: daftar; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.daftar (id, nama, nik, no_hp) FROM stdin;
28	asdasdasd	1234567890111112	089123123123
29	olaaaa	1234567890123456	123456789012
\.


--
-- TOC entry 3041 (class 0 OID 16387)
-- Dependencies: 201
-- Data for Name: daftar_old; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.daftar_old (id, nama, nik, no_hp) FROM stdin;
1	asdasd	123123	12312313
\.


--
-- TOC entry 3043 (class 0 OID 16417)
-- Dependencies: 203
-- Data for Name: no_rekening; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.no_rekening (id, daftar_id, no_rekening) FROM stdin;
9	28	12343123
10	29	12349012
\.


--
-- TOC entry 3046 (class 0 OID 16449)
-- Dependencies: 206
-- Data for Name: tabung; Type: TABLE DATA; Schema: public; Owner: root
--

COPY public.tabung (id, no_rekening, nominal, status, waktu) FROM stdin;
30	12343123	1000000	C	2023-03-21 14:51:20.019729
31	12343123	1000000	C	2023-03-21 14:51:27.913501
32	12343123	500000	D	2023-03-21 14:53:41.225461
33	12343123	500000	D	2023-03-21 14:53:51.117674
\.


--
-- TOC entry 3055 (class 0 OID 0)
-- Dependencies: 200
-- Name: daftar_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.daftar_id_seq', 29, true);


--
-- TOC entry 3056 (class 0 OID 0)
-- Dependencies: 204
-- Name: no_rekening_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.no_rekening_id_seq', 10, true);


--
-- TOC entry 3057 (class 0 OID 0)
-- Dependencies: 205
-- Name: tabung_id_seq; Type: SEQUENCE SET; Schema: public; Owner: root
--

SELECT pg_catalog.setval('public.tabung_id_seq', 33, true);


--
-- TOC entry 2897 (class 2606 OID 16406)
-- Name: daftar_old daftar_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.daftar_old
    ADD CONSTRAINT daftar_pk PRIMARY KEY (id);


--
-- TOC entry 2899 (class 2606 OID 16423)
-- Name: daftar daftar_un; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.daftar
    ADD CONSTRAINT daftar_un UNIQUE (id);


--
-- TOC entry 2901 (class 2606 OID 16421)
-- Name: no_rekening no_rekening_daftar_id_unique; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.no_rekening
    ADD CONSTRAINT no_rekening_daftar_id_unique UNIQUE (daftar_id);


--
-- TOC entry 2903 (class 2606 OID 16463)
-- Name: no_rekening no_rekening_id; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.no_rekening
    ADD CONSTRAINT no_rekening_id UNIQUE (id);


--
-- TOC entry 2905 (class 2606 OID 16516)
-- Name: no_rekening no_rekening_un; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.no_rekening
    ADD CONSTRAINT no_rekening_un UNIQUE (no_rekening);


--
-- TOC entry 2907 (class 2606 OID 16457)
-- Name: tabung tabung_pk; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tabung
    ADD CONSTRAINT tabung_pk PRIMARY KEY (id);


--
-- TOC entry 2908 (class 2606 OID 16424)
-- Name: no_rekening no_rekening_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.no_rekening
    ADD CONSTRAINT no_rekening_fk FOREIGN KEY (daftar_id) REFERENCES public.daftar(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2909 (class 2606 OID 16517)
-- Name: tabung tabung_fk; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.tabung
    ADD CONSTRAINT tabung_fk FOREIGN KEY (no_rekening) REFERENCES public.no_rekening(no_rekening);


-- Completed on 2023-03-21 22:04:13 WIB

--
-- PostgreSQL database dump complete
--

-- Completed on 2023-03-21 22:04:13 WIB

--
-- PostgreSQL database cluster dump complete
--

