--
-- PostgreSQL database dump
--

\restrict pEmqW93LlkKsLrcjvvoqA6l6xiidSjHiSGja4m3u8ssp5qeLMuv47VykcZ8f9g2

-- Dumped from database version 14.23
-- Dumped by pg_dump version 14.23

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

ALTER TABLE IF EXISTS ONLY public.immobili DROP CONSTRAINT IF EXISTS immobili_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.foto DROP CONSTRAINT IF EXISTS foto_immobile_id_fkey;
DROP INDEX IF EXISTS public.idx_users_email;
DROP INDEX IF EXISTS public.idx_immobili_user_id;
DROP INDEX IF EXISTS public.idx_immobili_stato;
DROP INDEX IF EXISTS public.idx_immobili_prezzo;
DROP INDEX IF EXISTS public.idx_immobili_citta;
DROP INDEX IF EXISTS public.idx_foto_immobile_id;
DROP INDEX IF EXISTS public.flyway_schema_history_s_idx;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_email_key;
ALTER TABLE IF EXISTS ONLY public.immobili DROP CONSTRAINT IF EXISTS immobili_pkey;
ALTER TABLE IF EXISTS ONLY public.foto DROP CONSTRAINT IF EXISTS foto_pkey;
ALTER TABLE IF EXISTS ONLY public.flyway_schema_history DROP CONSTRAINT IF EXISTS flyway_schema_history_pk;
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.immobili ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.foto ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.immobili_id_seq;
DROP TABLE IF EXISTS public.immobili;
DROP SEQUENCE IF EXISTS public.foto_id_seq;
DROP TABLE IF EXISTS public.foto;
DROP TABLE IF EXISTS public.flyway_schema_history;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


--
-- Name: foto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.foto (
    id bigint NOT NULL,
    immobile_id bigint NOT NULL,
    nome_file character varying(255) NOT NULL,
    percorso character varying(500) NOT NULL,
    ordinamento integer,
    creato_il timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: foto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.foto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: foto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.foto_id_seq OWNED BY public.foto.id;


--
-- Name: immobili; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.immobili (
    id bigint NOT NULL,
    titolo character varying(255) NOT NULL,
    descrizione text,
    prezzo numeric(15,2) NOT NULL,
    citta character varying(100) NOT NULL,
    provincia character varying(100),
    via character varying(255),
    numero_civico character varying(10),
    tipo text NOT NULL,
    superficie_mq double precision,
    numero_locali integer,
    numero_bagni integer,
    piano integer,
    ascensore boolean,
    riscaldamento character varying(100),
    stato character varying(50) NOT NULL,
    user_id bigint NOT NULL,
    creato_il timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    aggiornato_il timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    pannelli_solari boolean DEFAULT false,
    terrazza boolean DEFAULT false,
    riscaldamento_pavimento boolean DEFAULT false,
    giardino boolean DEFAULT false,
    piscina boolean DEFAULT false,
    impianto_allarme boolean DEFAULT false,
    aria_condizionata boolean DEFAULT false,
    vista_panoramica boolean DEFAULT false,
    ripostiglio boolean DEFAULT false,
    termoautonomo boolean DEFAULT false,
    porta_blindata boolean DEFAULT false,
    cappotto boolean DEFAULT false,
    cortile_privato boolean DEFAULT false,
    ubicazione character varying(50),
    destinazione character varying(50),
    camere_da_letto integer,
    garage boolean DEFAULT false,
    note_private text,
    codice_riferimento character varying(100)
);


--
-- Name: immobili_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.immobili_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: immobili_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.immobili_id_seq OWNED BY public.immobili.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    nome character varying(100) NOT NULL,
    cognome character varying(100) NOT NULL,
    role character varying(50) NOT NULL,
    creato_il timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    aggiornato_il timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: foto id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.foto ALTER COLUMN id SET DEFAULT nextval('public.foto_id_seq'::regclass);


--
-- Name: immobili id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.immobili ALTER COLUMN id SET DEFAULT nextval('public.immobili_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	Initial schema	SQL	V1__Initial_schema.sql	-1144182248	agenzia_user	2026-05-25 23:11:27.413617	32	t
2	2	Insert sample data	SQL	V2__Insert_sample_data.sql	-222277299	agenzia_user	2026-05-25 23:11:27.462029	5	t
3	3	Add caratteristiche immobili	SQL	V3__Add_caratteristiche_immobili.sql	510834059	agenzia_user	2026-07-28 11:48:27.226445	34	t
4	4	Add dettagli annuncio immobili	SQL	V4__Add_dettagli_annuncio_immobili.sql	1048446096	agenzia_user	2026-07-29 00:10:03.578383	38	t
5	5	Add garage caratteristica	SQL	V5__Add_garage_caratteristica.sql	-733571335	agenzia_user	2026-07-29 23:16:07.587923	14	t
6	6	Add note private immobili	SQL	V6__Add_note_private_immobili.sql	300828939	agenzia_user	2026-07-30 10:29:18.151615	17	t
7	7	Add codice riferimento immobili	SQL	V7__Add_codice_riferimento_immobili.sql	-647071661	agenzia_user	2026-07-30 12:08:58.374683	21	t
8	8	Tipo immobile multiplo	SQL	V8__Tipo_immobile_multiplo.sql	2100580228	agenzia_user	2026-07-30 14:28:16.623991	14	t
\.


--
-- Data for Name: foto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.foto (id, immobile_id, nome_file, percorso, ordinamento, creato_il) FROM stdin;
234	37	immobili/37/1785283975590-bfefd7a0-a2e5-48cf-968a-7003425c9196.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/37/1785283975590-bfefd7a0-a2e5-48cf-968a-7003425c9196.jpg	0	2026-07-29 00:12:56.71239
235	37	immobili/37/1785283976722-13d3370d-9079-4bc1-b47b-a49491b7a377.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/37/1785283976722-13d3370d-9079-4bc1-b47b-a49491b7a377.jpg	1	2026-07-29 00:12:57.217087
236	37	immobili/37/1785283977221-56f85b18-62c6-4038-b2a4-8802e25e5f73.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/37/1785283977221-56f85b18-62c6-4038-b2a4-8802e25e5f73.jpg	2	2026-07-29 00:12:57.738881
237	37	immobili/37/1785283977743-d8e8e9ba-cd6b-4dee-81a6-cba669569cf3.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/37/1785283977743-d8e8e9ba-cd6b-4dee-81a6-cba669569cf3.jpg	3	2026-07-29 00:12:58.389371
238	37	immobili/37/1785283978395-44af58c6-9bb8-40a1-b796-e9393b9cb414.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/37/1785283978395-44af58c6-9bb8-40a1-b796-e9393b9cb414.jpg	4	2026-07-29 00:12:58.938836
239	37	immobili/37/1785283978947-c81cd7c1-a50e-4557-b559-7a1e6d510421.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/37/1785283978947-c81cd7c1-a50e-4557-b559-7a1e6d510421.jpg	5	2026-07-29 00:12:59.566481
240	37	immobili/37/1785283979572-2b87bfe6-23cf-4f14-9f82-be4d25edd9d0.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/37/1785283979572-2b87bfe6-23cf-4f14-9f82-be4d25edd9d0.jpg	6	2026-07-29 00:13:00.132226
241	37	immobili/37/1785283980140-dec648fd-b8da-4230-acec-ef2be3818d29.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/37/1785283980140-dec648fd-b8da-4230-acec-ef2be3818d29.jpg	7	2026-07-29 00:13:00.618617
242	37	immobili/37/1785283980629-15a3867a-e236-4f48-9834-0aa20ac292a1.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/37/1785283980629-15a3867a-e236-4f48-9834-0aa20ac292a1.jpg	8	2026-07-29 00:13:01.070967
243	37	immobili/37/1785283981083-9248d848-acad-47e3-99f7-23cc4ae2d174.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/37/1785283981083-9248d848-acad-47e3-99f7-23cc4ae2d174.jpg	9	2026-07-29 00:13:01.634469
244	37	immobili/37/1785283981663-420911df-fbf4-4555-9c39-ed3c270435fa.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/37/1785283981663-420911df-fbf4-4555-9c39-ed3c270435fa.jpg	10	2026-07-29 00:13:02.125389
245	37	immobili/37/1785283982130-cf047eb6-d25b-46e5-a5dc-79240777dadd.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/37/1785283982130-cf047eb6-d25b-46e5-a5dc-79240777dadd.jpg	11	2026-07-29 00:13:02.5704
246	37	immobili/37/1785283982575-6f894d30-483b-48ca-937c-ae223b7c74e5.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/37/1785283982575-6f894d30-483b-48ca-937c-ae223b7c74e5.jpg	12	2026-07-29 00:13:03.099419
247	37	immobili/37/1785283983106-f96e76b3-7930-4d6f-ad44-abda955beb6d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/37/1785283983106-f96e76b3-7930-4d6f-ad44-abda955beb6d.jpg	13	2026-07-29 00:13:03.587285
248	37	immobili/37/1785283983592-5c8f3029-d4b4-469d-82f9-605d91f88efc.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/37/1785283983592-5c8f3029-d4b4-469d-82f9-605d91f88efc.jpg	14	2026-07-29 00:13:04.197965
249	37	immobili/37/1785283984203-2f9400b3-dd6d-4cdc-bea4-64429de05551.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/37/1785283984203-2f9400b3-dd6d-4cdc-bea4-64429de05551.jpg	15	2026-07-29 00:13:04.80991
250	38	immobili/38/1785284322800-d09e214a-44df-438a-98cc-3a0295faac9a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/38/1785284322800-d09e214a-44df-438a-98cc-3a0295faac9a.jpg	0	2026-07-29 00:18:43.354663
251	38	immobili/38/1785284323360-3782395c-54ca-4dcd-85e8-d2471b3055a3.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/38/1785284323360-3782395c-54ca-4dcd-85e8-d2471b3055a3.jpg	1	2026-07-29 00:18:44.063248
252	38	immobili/38/1785284324069-b7bb3b00-28b9-4077-b340-ae32449516b7.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/38/1785284324069-b7bb3b00-28b9-4077-b340-ae32449516b7.jpg	2	2026-07-29 00:18:44.842103
253	38	immobili/38/1785284324848-520b6d2b-c9c5-47de-bc26-47923c52f133.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/38/1785284324848-520b6d2b-c9c5-47de-bc26-47923c52f133.jpg	3	2026-07-29 00:18:45.3489
254	38	immobili/38/1785284325351-46b27379-dc05-42d7-ad9c-dea8468f3ef2.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/38/1785284325351-46b27379-dc05-42d7-ad9c-dea8468f3ef2.jpg	4	2026-07-29 00:18:45.85225
255	38	immobili/38/1785284325859-49ae4fa0-2908-4f0e-8657-41313ac6572f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/38/1785284325859-49ae4fa0-2908-4f0e-8657-41313ac6572f.jpg	5	2026-07-29 00:18:46.352329
256	38	immobili/38/1785284326358-e22c099d-b523-4663-84da-22f96367a51a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/38/1785284326358-e22c099d-b523-4663-84da-22f96367a51a.jpg	6	2026-07-29 00:18:47.023391
257	38	immobili/38/1785284327030-0a9bb0bf-23d8-4fb1-8b45-be671523ec71.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/38/1785284327030-0a9bb0bf-23d8-4fb1-8b45-be671523ec71.jpg	7	2026-07-29 00:18:47.72292
258	38	immobili/38/1785284327728-0d1f0ea2-624f-44b7-8201-08f1a6c25c17.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/38/1785284327728-0d1f0ea2-624f-44b7-8201-08f1a6c25c17.jpg	8	2026-07-29 00:18:48.414027
259	38	immobili/38/1785284328419-85f3917f-c68a-46a4-96b3-542bc74b71ae.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/38/1785284328419-85f3917f-c68a-46a4-96b3-542bc74b71ae.jpg	9	2026-07-29 00:18:49.333268
260	39	immobili/39/1785284592969-329f249d-aa83-4855-8dde-71885004870f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/39/1785284592969-329f249d-aa83-4855-8dde-71885004870f.jpg	0	2026-07-29 00:23:13.76288
261	39	immobili/39/1785284593769-b99b5ea4-dd0e-47fd-be20-0895e6b08df5.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/39/1785284593769-b99b5ea4-dd0e-47fd-be20-0895e6b08df5.jpg	1	2026-07-29 00:23:14.330836
262	39	immobili/39/1785284594337-f37e180f-e8e0-4368-b97f-44cff8f6b619.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/39/1785284594337-f37e180f-e8e0-4368-b97f-44cff8f6b619.jpg	2	2026-07-29 00:23:14.821921
263	39	immobili/39/1785284594826-841c58d7-a9f3-488d-92ea-f32574759c9c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/39/1785284594826-841c58d7-a9f3-488d-92ea-f32574759c9c.jpg	3	2026-07-29 00:23:15.228784
264	39	immobili/39/1785284595231-76bafd9a-93e3-4750-bb32-a303ed1cbd2d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/39/1785284595231-76bafd9a-93e3-4750-bb32-a303ed1cbd2d.jpg	4	2026-07-29 00:23:15.661361
265	39	immobili/39/1785284595670-803b0039-7883-4f02-b17a-49b7c49c4886.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/39/1785284595670-803b0039-7883-4f02-b17a-49b7c49c4886.jpg	5	2026-07-29 00:23:16.191299
266	39	immobili/39/1785284596197-6bbcad3a-e62a-4d56-9924-e26b784414a9.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/39/1785284596197-6bbcad3a-e62a-4d56-9924-e26b784414a9.jpg	6	2026-07-29 00:23:16.621415
267	39	immobili/39/1785284596626-363a8788-ef96-44fa-b15e-8b3007e51c47.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/39/1785284596626-363a8788-ef96-44fa-b15e-8b3007e51c47.jpg	7	2026-07-29 00:23:17.061206
268	39	immobili/39/1785284597066-92dd15fd-9932-4986-9d45-d0adcd3ea505.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/39/1785284597066-92dd15fd-9932-4986-9d45-d0adcd3ea505.jpg	8	2026-07-29 00:23:17.521535
269	39	immobili/39/1785284597527-25e497f3-49da-4f37-b8b8-77a5f48eb00d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/39/1785284597527-25e497f3-49da-4f37-b8b8-77a5f48eb00d.jpg	9	2026-07-29 00:23:17.959123
270	39	immobili/39/1785284597963-d384472d-dd66-4960-bccf-d6420bcac919.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/39/1785284597963-d384472d-dd66-4960-bccf-d6420bcac919.jpg	10	2026-07-29 00:23:18.381621
271	40	immobili/40/1785361813120-66c38684-d4aa-471d-9e61-005c08590c02.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/40/1785361813120-66c38684-d4aa-471d-9e61-005c08590c02.jpg	0	2026-07-29 21:50:19.005583
272	40	immobili/40/1785361819036-88346f32-0fe2-4a31-984b-55a595d49071.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/40/1785361819036-88346f32-0fe2-4a31-984b-55a595d49071.jpg	1	2026-07-29 21:50:19.809093
273	40	immobili/40/1785361819812-0e4c266e-af41-49e8-9e40-7dfc7002c1bc.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/40/1785361819812-0e4c266e-af41-49e8-9e40-7dfc7002c1bc.jpg	2	2026-07-29 21:50:20.696574
274	40	immobili/40/1785361820702-3beea05b-1bb7-4525-a441-9ad85f94b9d6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/40/1785361820702-3beea05b-1bb7-4525-a441-9ad85f94b9d6.jpg	3	2026-07-29 21:50:21.909647
275	40	immobili/40/1785361821917-6587e673-0388-4685-a4d4-6734bfa266da.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/40/1785361821917-6587e673-0388-4685-a4d4-6734bfa266da.jpg	4	2026-07-29 21:50:22.555819
276	40	immobili/40/1785361822562-3c3b3ae1-fdca-48f5-815e-9c55ce5a6ec2.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/40/1785361822562-3c3b3ae1-fdca-48f5-815e-9c55ce5a6ec2.jpg	5	2026-07-29 21:50:23.316455
277	41	immobili/41/1785368256406-859f8b97-1691-4f46-bb1c-dffa4a040775.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/41/1785368256406-859f8b97-1691-4f46-bb1c-dffa4a040775.jpg	0	2026-07-29 23:37:41.138475
278	41	immobili/41/1785368261178-c8af6de2-01b7-4bf2-b522-73e58368e9a8.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/41/1785368261178-c8af6de2-01b7-4bf2-b522-73e58368e9a8.jpg	1	2026-07-29 23:37:42.018085
279	41	immobili/41/1785368262024-1814c078-2cf5-499f-87fd-2792d3694675.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/41/1785368262024-1814c078-2cf5-499f-87fd-2792d3694675.jpg	2	2026-07-29 23:37:42.736501
280	41	immobili/41/1785368262740-1886fd83-1f7b-4895-862f-ffa7a4c2e608.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/41/1785368262740-1886fd83-1f7b-4895-862f-ffa7a4c2e608.jpg	3	2026-07-29 23:37:43.249511
281	41	immobili/41/1785368263255-f8b77b63-a5e7-4617-9182-9333e4c98103.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/41/1785368263255-f8b77b63-a5e7-4617-9182-9333e4c98103.jpg	4	2026-07-29 23:37:43.798211
282	41	immobili/41/1785368263807-78353cd1-f455-4c21-b6de-638c955fc76d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/41/1785368263807-78353cd1-f455-4c21-b6de-638c955fc76d.jpg	5	2026-07-29 23:37:44.398803
283	41	immobili/41/1785368264406-7611a43d-35e5-4d7e-ac31-eeef3ceb4000.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/41/1785368264406-7611a43d-35e5-4d7e-ac31-eeef3ceb4000.jpg	6	2026-07-29 23:37:44.975763
284	41	immobili/41/1785368264983-c14e4fde-8d8e-44c4-916d-2681ba28ec0a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/41/1785368264983-c14e4fde-8d8e-44c4-916d-2681ba28ec0a.jpg	7	2026-07-29 23:37:45.496846
285	41	immobili/41/1785368265508-5919b91a-9ff8-4c39-afc9-3aaa2b63c3e5.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/41/1785368265508-5919b91a-9ff8-4c39-afc9-3aaa2b63c3e5.jpg	8	2026-07-29 23:37:46.068131
286	41	immobili/41/1785368266080-27510a5e-9c20-40de-939c-0bebb31b7423.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/41/1785368266080-27510a5e-9c20-40de-939c-0bebb31b7423.jpg	9	2026-07-29 23:37:46.637806
287	41	immobili/41/1785368266643-9511e0cc-0c61-41bb-8951-f9ec81db8888.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/41/1785368266643-9511e0cc-0c61-41bb-8951-f9ec81db8888.jpg	10	2026-07-29 23:37:47.267201
288	41	immobili/41/1785368267272-76e7e235-194c-4a7f-9ced-8084df4838ea.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/41/1785368267272-76e7e235-194c-4a7f-9ced-8084df4838ea.jpg	11	2026-07-29 23:37:48.359786
289	41	immobili/41/1785368268365-c6ee0b42-8b38-4a18-89e1-943c9736e25f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/41/1785368268365-c6ee0b42-8b38-4a18-89e1-943c9736e25f.jpg	12	2026-07-29 23:37:49.358371
290	41	immobili/41/1785368269363-f2c556e7-bddf-4c60-9708-694e40aa79a5.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/41/1785368269363-f2c556e7-bddf-4c60-9708-694e40aa79a5.jpg	13	2026-07-29 23:37:50.246641
291	42	immobili/42/1785418315999-36f8cce3-a8be-4d09-b584-aec57193c8b2.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/42/1785418315999-36f8cce3-a8be-4d09-b584-aec57193c8b2.jpg	0	2026-07-30 13:32:00.415153
292	42	immobili/42/1785418320435-95480f1f-e49a-431b-95da-4c2fdc0de78a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/42/1785418320435-95480f1f-e49a-431b-95da-4c2fdc0de78a.jpg	1	2026-07-30 13:32:01.076783
293	42	immobili/42/1785418321083-75f5ce81-f9dd-49d1-8304-0e8451f108a5.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/42/1785418321083-75f5ce81-f9dd-49d1-8304-0e8451f108a5.jpg	2	2026-07-30 13:32:01.685187
294	42	immobili/42/1785418321690-5a19d52f-6ff2-4c35-af38-f8a613e45524.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/42/1785418321690-5a19d52f-6ff2-4c35-af38-f8a613e45524.jpg	3	2026-07-30 13:32:02.547214
295	42	immobili/42/1785418322555-c6ed55a7-840e-4d78-abd1-764467b4703c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/42/1785418322555-c6ed55a7-840e-4d78-abd1-764467b4703c.jpg	4	2026-07-30 13:32:03.273628
296	42	immobili/42/1785418323279-d1a9ec62-a9e6-49b1-9155-2229f06bf094.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/42/1785418323279-d1a9ec62-a9e6-49b1-9155-2229f06bf094.jpg	5	2026-07-30 13:32:03.80637
297	42	immobili/42/1785418323811-3ddcc162-f23f-4666-9673-9c2b8820d13c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/42/1785418323811-3ddcc162-f23f-4666-9673-9c2b8820d13c.jpg	6	2026-07-30 13:32:04.439239
298	42	immobili/42/1785418324445-c813f7d9-5f4b-43ec-a0cf-e92030788e6b.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/42/1785418324445-c813f7d9-5f4b-43ec-a0cf-e92030788e6b.jpg	7	2026-07-30 13:32:05.177722
299	42	immobili/42/1785418325186-a65a4fa9-208b-4f33-829c-1cb59694742d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/42/1785418325186-a65a4fa9-208b-4f33-829c-1cb59694742d.jpg	8	2026-07-30 13:32:05.847051
300	42	immobili/42/1785418325853-d1be22c0-138e-4a66-8bec-bd45142dd851.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/42/1785418325853-d1be22c0-138e-4a66-8bec-bd45142dd851.jpg	9	2026-07-30 13:32:06.702343
301	42	immobili/42/1785418326711-22c755f5-53cd-414e-8aa3-43cfd1b449dd.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/42/1785418326711-22c755f5-53cd-414e-8aa3-43cfd1b449dd.jpg	10	2026-07-30 13:32:07.498144
302	42	immobili/42/1785418327505-2894b854-0f7c-4a29-8b2d-40246294c4e4.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/42/1785418327505-2894b854-0f7c-4a29-8b2d-40246294c4e4.jpg	11	2026-07-30 13:32:08.256515
303	42	immobili/42/1785418328265-beeacf82-0b18-4ae3-b1a3-95165ea118b2.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/42/1785418328265-beeacf82-0b18-4ae3-b1a3-95165ea118b2.jpg	12	2026-07-30 13:32:09.237981
304	43	immobili/43/1785419511478-c01ebf70-f93c-46c6-9626-79f46b4bffe0.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/43/1785419511478-c01ebf70-f93c-46c6-9626-79f46b4bffe0.jpg	0	2026-07-30 13:51:52.749515
305	43	immobili/43/1785419512762-2b25d4f6-678c-426c-b8f9-5f33e045307d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/43/1785419512762-2b25d4f6-678c-426c-b8f9-5f33e045307d.jpg	1	2026-07-30 13:51:53.298263
306	43	immobili/43/1785419513329-427ddbe4-3d65-4a49-a680-b7589e268ef8.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/43/1785419513329-427ddbe4-3d65-4a49-a680-b7589e268ef8.jpg	2	2026-07-30 13:51:54.233776
307	43	immobili/43/1785419514238-64b81c72-efc1-48e5-ab65-3c5ba362871f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/43/1785419514238-64b81c72-efc1-48e5-ab65-3c5ba362871f.jpg	3	2026-07-30 13:51:54.895046
308	43	immobili/43/1785419514900-47cd113b-71e6-4f39-b656-b1712bd4402e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/43/1785419514900-47cd113b-71e6-4f39-b656-b1712bd4402e.jpg	4	2026-07-30 13:51:55.564247
309	43	immobili/43/1785419515575-74c6c9e2-43af-4e86-88e2-2c745249457e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/43/1785419515575-74c6c9e2-43af-4e86-88e2-2c745249457e.jpg	5	2026-07-30 13:51:56.277862
310	43	immobili/43/1785419516287-8fc3ede8-e310-4825-8485-2a1ead5bda77.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/43/1785419516287-8fc3ede8-e310-4825-8485-2a1ead5bda77.jpg	6	2026-07-30 13:51:56.918362
311	43	immobili/43/1785419516923-beddebff-582e-4a63-9faa-463f8773f8b6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/43/1785419516923-beddebff-582e-4a63-9faa-463f8773f8b6.jpg	7	2026-07-30 13:51:57.507021
312	44	immobili/44/1785422786454-bf1c6202-b79e-4516-895f-4eda509814a4.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/44/1785422786454-bf1c6202-b79e-4516-895f-4eda509814a4.jpg	0	2026-07-30 14:46:28.044082
313	44	immobili/44/1785422788054-017ed910-675c-42d7-88ba-2e5c93d672ca.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/44/1785422788054-017ed910-675c-42d7-88ba-2e5c93d672ca.jpg	1	2026-07-30 14:46:28.740061
320	46	immobili/46/1785423310434-25a79098-6c43-488e-9997-75dfeac5a417.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/46/1785423310434-25a79098-6c43-488e-9997-75dfeac5a417.jpg	0	2026-07-30 14:55:11.371235
321	46	immobili/46/1785423311429-fe5e0814-4e1f-4d4a-8423-f4a93e3abea9.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/46/1785423311429-fe5e0814-4e1f-4d4a-8423-f4a93e3abea9.jpg	1	2026-07-30 14:55:12.183561
322	46	immobili/46/1785423312197-d8885779-7963-4db8-a00a-c7aeb64a3570.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/46/1785423312197-d8885779-7963-4db8-a00a-c7aeb64a3570.jpg	2	2026-07-30 14:55:13.165851
323	46	immobili/46/1785423313168-8403768a-feb3-4fe6-b531-0fb975752f38.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/46/1785423313168-8403768a-feb3-4fe6-b531-0fb975752f38.jpg	3	2026-07-30 14:55:13.884358
324	46	immobili/46/1785423313886-b39aad93-ad48-4e12-84f3-ec7592ab7825.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/46/1785423313886-b39aad93-ad48-4e12-84f3-ec7592ab7825.jpg	4	2026-07-30 14:55:14.538717
325	46	immobili/46/1785423314545-ba926e30-e92d-45b9-9c14-0ef4273bfb75.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/46/1785423314545-ba926e30-e92d-45b9-9c14-0ef4273bfb75.jpg	5	2026-07-30 14:55:15.330044
326	47	immobili/47/1785510271253-fb63cc77-f7d8-4f42-b3d5-787ebcc9251b.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/47/1785510271253-fb63cc77-f7d8-4f42-b3d5-787ebcc9251b.jpg	0	2026-07-31 15:04:33.817982
327	47	immobili/47/1785510273833-fbd03919-d9e4-48c4-94b8-b8a47750516d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/47/1785510273833-fbd03919-d9e4-48c4-94b8-b8a47750516d.jpg	1	2026-07-31 15:04:35.209804
328	47	immobili/47/1785510275216-eee68411-3ed6-4da3-bcbc-e4a8e85c25a2.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/47/1785510275216-eee68411-3ed6-4da3-bcbc-e4a8e85c25a2.jpg	2	2026-07-31 15:04:36.791971
329	47	immobili/47/1785510276806-e0899510-d8aa-4776-a614-1dbdf0a3487e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/47/1785510276806-e0899510-d8aa-4776-a614-1dbdf0a3487e.jpg	3	2026-07-31 15:04:38.372806
330	47	immobili/47/1785510278378-154370e2-8403-4c5f-bdd9-afdb52382254.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/47/1785510278378-154370e2-8403-4c5f-bdd9-afdb52382254.jpg	4	2026-07-31 15:04:38.968283
331	47	immobili/47/1785510278974-46430629-5eaf-4b23-9a7d-5290ead5792f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/47/1785510278974-46430629-5eaf-4b23-9a7d-5290ead5792f.jpg	5	2026-07-31 15:04:39.808008
332	47	immobili/47/1785510279816-d4043998-999f-4a13-9573-18e11f655bcf.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/47/1785510279816-d4043998-999f-4a13-9573-18e11f655bcf.jpg	6	2026-07-31 15:04:41.558119
333	47	immobili/47/1785510281564-b2ac1771-de0b-4d3e-8b90-ad826e311234.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/47/1785510281564-b2ac1771-de0b-4d3e-8b90-ad826e311234.jpg	7	2026-07-31 15:04:42.718435
334	47	immobili/47/1785510282726-ef69f219-cbf0-4b5e-877b-9588f965b2c5.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/47/1785510282726-ef69f219-cbf0-4b5e-877b-9588f965b2c5.jpg	8	2026-07-31 15:04:43.524268
335	47	immobili/47/1785510283531-d7940186-04be-4b35-8a66-4dc6e6dc1693.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/47/1785510283531-d7940186-04be-4b35-8a66-4dc6e6dc1693.jpg	9	2026-07-31 15:04:44.490866
336	47	immobili/47/1785510284494-08f795f8-7465-4e7e-96c6-ca5375dc96a8.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/47/1785510284494-08f795f8-7465-4e7e-96c6-ca5375dc96a8.jpg	10	2026-07-31 15:04:46.015422
337	47	immobili/47/1785510286027-e524c856-bbf3-439c-9dea-b75accc37abf.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/47/1785510286027-e524c856-bbf3-439c-9dea-b75accc37abf.jpg	11	2026-07-31 15:04:47.022977
338	47	immobili/47/1785510287028-3d5cdc2c-7669-44a6-ace4-41babeadd6aa.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/47/1785510287028-3d5cdc2c-7669-44a6-ace4-41babeadd6aa.jpg	12	2026-07-31 15:04:48.155475
339	48	immobili/48/1785510493225-920d49ce-9131-4814-8c3e-a9924e702b4a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510493225-920d49ce-9131-4814-8c3e-a9924e702b4a.jpg	0	2026-07-31 15:08:14.147859
340	48	immobili/48/1785510494152-95967dc3-4e09-4c70-90d0-d26af6ee66d6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510494152-95967dc3-4e09-4c70-90d0-d26af6ee66d6.jpg	1	2026-07-31 15:08:14.988312
341	48	immobili/48/1785510494993-b69d77d6-2d9b-48e8-b981-8b5f70340777.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510494993-b69d77d6-2d9b-48e8-b981-8b5f70340777.jpg	2	2026-07-31 15:08:15.827757
342	48	immobili/48/1785510495833-12cae9d7-fa78-4bf3-8543-754097b48dc6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510495833-12cae9d7-fa78-4bf3-8543-754097b48dc6.jpg	3	2026-07-31 15:08:16.608233
343	48	immobili/48/1785510496614-47b74cce-0547-41fc-a2ea-6d194eb5a6d3.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510496614-47b74cce-0547-41fc-a2ea-6d194eb5a6d3.jpg	4	2026-07-31 15:08:17.4168
344	48	immobili/48/1785510497423-fbf9b0da-353a-48cc-a722-6ba134802c17.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510497423-fbf9b0da-353a-48cc-a722-6ba134802c17.jpg	5	2026-07-31 15:08:17.998452
345	48	immobili/48/1785510498004-afcfa0a5-4459-4138-aa83-6966e8f2a858.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510498004-afcfa0a5-4459-4138-aa83-6966e8f2a858.jpg	6	2026-07-31 15:08:18.63915
346	48	immobili/48/1785510498645-478f1376-f897-4b6f-b79b-98ffee7ab189.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510498645-478f1376-f897-4b6f-b79b-98ffee7ab189.jpg	7	2026-07-31 15:08:19.328364
347	48	immobili/48/1785510499333-80d92e81-cac7-4ddf-bb1f-30f17b0bf9b7.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510499333-80d92e81-cac7-4ddf-bb1f-30f17b0bf9b7.jpg	8	2026-07-31 15:08:20.051816
348	48	immobili/48/1785510500057-9640193a-f25f-4360-b02c-fde463acb077.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510500057-9640193a-f25f-4360-b02c-fde463acb077.jpg	9	2026-07-31 15:08:20.829187
349	48	immobili/48/1785510500835-e3d259bc-f344-4e00-a84b-db9cd317af79.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510500835-e3d259bc-f344-4e00-a84b-db9cd317af79.jpg	10	2026-07-31 15:08:21.632519
350	48	immobili/48/1785510501646-ae9c1bc4-e8ae-4f83-a286-9d16ea215a37.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510501646-ae9c1bc4-e8ae-4f83-a286-9d16ea215a37.jpg	11	2026-07-31 15:08:22.328706
351	48	immobili/48/1785510502334-3e5ff3f2-2edb-40e8-bda7-584d0eacf33a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510502334-3e5ff3f2-2edb-40e8-bda7-584d0eacf33a.jpg	12	2026-07-31 15:08:22.999027
352	48	immobili/48/1785510503004-ef9fec96-4962-404f-a983-0074db08ae39.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510503004-ef9fec96-4962-404f-a983-0074db08ae39.jpg	13	2026-07-31 15:08:23.718811
353	48	immobili/48/1785510503724-5b73ab3c-d96f-4a3c-9de9-4e14d69e79f6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510503724-5b73ab3c-d96f-4a3c-9de9-4e14d69e79f6.jpg	14	2026-07-31 15:08:24.528394
354	48	immobili/48/1785510504541-b45de002-5e6d-412a-9b48-2fa57ddc337a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510504541-b45de002-5e6d-412a-9b48-2fa57ddc337a.jpg	15	2026-07-31 15:08:25.251136
355	48	immobili/48/1785510505266-8a23e6af-32b6-442d-98fb-af82a5bff930.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510505266-8a23e6af-32b6-442d-98fb-af82a5bff930.jpg	16	2026-07-31 15:08:25.958575
356	48	immobili/48/1785510505964-5b8d75ef-bd80-41c8-80c9-c3cf21f7bb49.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510505964-5b8d75ef-bd80-41c8-80c9-c3cf21f7bb49.jpg	17	2026-07-31 15:08:26.657669
357	48	immobili/48/1785510506662-2b99c299-cff2-4162-845c-096f831b2677.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510506662-2b99c299-cff2-4162-845c-096f831b2677.jpg	18	2026-07-31 15:08:27.327096
358	48	immobili/48/1785510507332-3bc577ca-6435-4723-876f-80c9b57547b3.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510507332-3bc577ca-6435-4723-876f-80c9b57547b3.jpg	19	2026-07-31 15:08:28.027776
359	48	immobili/48/1785510508033-b5d80915-a9f8-4010-a11a-b955191b752a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510508033-b5d80915-a9f8-4010-a11a-b955191b752a.jpg	20	2026-07-31 15:08:28.845364
360	48	immobili/48/1785510508861-b498184f-324a-48cd-b99c-f7ef167c6951.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510508861-b498184f-324a-48cd-b99c-f7ef167c6951.jpg	21	2026-07-31 15:08:29.609503
361	48	immobili/48/1785510509615-e8c27a0f-7073-4641-83f1-721df2256bc2.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/48/1785510509615-e8c27a0f-7073-4641-83f1-721df2256bc2.jpg	22	2026-07-31 15:08:30.518534
362	49	immobili/49/1785511330801-0b773a99-e40d-47a4-88f5-608e0ce61be5.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/49/1785511330801-0b773a99-e40d-47a4-88f5-608e0ce61be5.jpg	0	2026-07-31 15:22:12.14551
363	49	immobili/49/1785511332151-f81f775e-0c03-4622-afd7-6a1e433821ff.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/49/1785511332151-f81f775e-0c03-4622-afd7-6a1e433821ff.jpg	1	2026-07-31 15:22:13.667684
364	49	immobili/49/1785511333673-605b7eac-e99b-4860-8e74-dab4f494162e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/49/1785511333673-605b7eac-e99b-4860-8e74-dab4f494162e.jpg	2	2026-07-31 15:22:14.557611
365	49	immobili/49/1785511334566-84ae6b58-d7b8-415a-932e-e0d0bcc90cf0.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/49/1785511334566-84ae6b58-d7b8-415a-932e-e0d0bcc90cf0.jpg	3	2026-07-31 15:22:15.363724
366	49	immobili/49/1785511335381-bf5bef59-15fc-4409-9033-92c501533e89.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/49/1785511335381-bf5bef59-15fc-4409-9033-92c501533e89.jpg	4	2026-07-31 15:22:16.279782
367	49	immobili/49/1785511336286-6b623ff6-a9b4-4f1c-a899-38bf136ed367.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/49/1785511336286-6b623ff6-a9b4-4f1c-a899-38bf136ed367.jpg	5	2026-07-31 15:22:17.336702
368	49	immobili/49/1785511337354-bbd3f0ec-2bb9-4096-8f62-0d57717349e2.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/49/1785511337354-bbd3f0ec-2bb9-4096-8f62-0d57717349e2.jpg	6	2026-07-31 15:22:18.418997
369	49	immobili/49/1785511338425-4cc85a01-eea7-4fd2-b72b-25bb9d888ef2.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/49/1785511338425-4cc85a01-eea7-4fd2-b72b-25bb9d888ef2.jpg	7	2026-07-31 15:22:19.298622
370	49	immobili/49/1785511339304-ce71f020-4a7c-4066-9aac-67339a8de47e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/49/1785511339304-ce71f020-4a7c-4066-9aac-67339a8de47e.jpg	8	2026-07-31 15:22:19.897359
371	49	immobili/49/1785511339902-2cacc10a-c1b0-40f6-bea6-1109a38f5e14.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/49/1785511339902-2cacc10a-c1b0-40f6-bea6-1109a38f5e14.jpg	9	2026-07-31 15:22:20.677971
372	49	immobili/49/1785511340683-7ad85dbe-1b9a-4d8c-a408-2686ecfa9a40.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/49/1785511340683-7ad85dbe-1b9a-4d8c-a408-2686ecfa9a40.jpg	10	2026-07-31 15:22:21.46895
373	49	immobili/49/1785511341473-d1d2a25e-2988-456e-9743-68cd6eb3e493.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/49/1785511341473-d1d2a25e-2988-456e-9743-68cd6eb3e493.jpg	11	2026-07-31 15:22:21.934635
374	49	immobili/49/1785511341938-9822fc6f-2e0a-4095-ad62-32b6c6f537e9.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/49/1785511341938-9822fc6f-2e0a-4095-ad62-32b6c6f537e9.jpg	12	2026-07-31 15:22:22.539209
375	50	immobili/50/1785511464345-c8c64d0d-885c-48b9-90c7-b72ad8fabf60.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511464345-c8c64d0d-885c-48b9-90c7-b72ad8fabf60.jpg	0	2026-07-31 15:24:25.477055
376	50	immobili/50/1785511465517-12194a3c-1349-43db-b290-f6a6fec8a907.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511465517-12194a3c-1349-43db-b290-f6a6fec8a907.jpg	1	2026-07-31 15:24:26.391772
377	50	immobili/50/1785511466396-f2c705f8-dc8e-4a1c-8dbc-3ce14c44b0ad.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511466396-f2c705f8-dc8e-4a1c-8dbc-3ce14c44b0ad.jpg	2	2026-07-31 15:24:27.169317
378	50	immobili/50/1785511467175-48157e1b-6fe0-42e5-916c-68e3569c7633.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511467175-48157e1b-6fe0-42e5-916c-68e3569c7633.jpg	3	2026-07-31 15:24:27.879243
379	50	immobili/50/1785511467885-ea8a4af7-b757-4e61-b228-b3317a9a33af.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511467885-ea8a4af7-b757-4e61-b228-b3317a9a33af.jpg	4	2026-07-31 15:24:28.557576
380	50	immobili/50/1785511468562-2f077143-df29-49f5-9a0f-539a35191c32.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511468562-2f077143-df29-49f5-9a0f-539a35191c32.jpg	5	2026-07-31 15:24:29.235143
381	50	immobili/50/1785511469241-e183ba58-45e4-4f43-ab70-99d6e311cbb4.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511469241-e183ba58-45e4-4f43-ab70-99d6e311cbb4.jpg	6	2026-07-31 15:24:30.04346
382	50	immobili/50/1785511470054-41e94482-2e15-45a2-8867-5b7942ee533f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511470054-41e94482-2e15-45a2-8867-5b7942ee533f.jpg	7	2026-07-31 15:24:30.70938
383	50	immobili/50/1785511470715-18a99184-4c9c-4d5e-bb07-3b6ca383a88c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511470715-18a99184-4c9c-4d5e-bb07-3b6ca383a88c.jpg	8	2026-07-31 15:24:31.438383
384	50	immobili/50/1785511471444-b45f1036-76d1-493a-8b9f-031336db8252.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511471444-b45f1036-76d1-493a-8b9f-031336db8252.jpg	9	2026-07-31 15:24:31.989941
385	50	immobili/50/1785511471995-75952712-8d62-448a-8a23-92a9338c5e03.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511471995-75952712-8d62-448a-8a23-92a9338c5e03.jpg	10	2026-07-31 15:24:32.651187
386	50	immobili/50/1785511472655-0d26e1c6-e89b-4c1b-b833-9977d2cf9cca.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511472655-0d26e1c6-e89b-4c1b-b833-9977d2cf9cca.jpg	11	2026-07-31 15:24:33.558461
387	50	immobili/50/1785511473564-eb4f1d6e-9f91-45be-bf2d-f38d5ae7ce23.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511473564-eb4f1d6e-9f91-45be-bf2d-f38d5ae7ce23.jpg	12	2026-07-31 15:24:34.20873
388	50	immobili/50/1785511474214-a881208f-7013-4330-a5b2-a2b9b3a9f657.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511474214-a881208f-7013-4330-a5b2-a2b9b3a9f657.jpg	13	2026-07-31 15:24:34.829668
389	50	immobili/50/1785511474835-75996916-f24c-41fd-b83d-41eada2bc9f2.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511474835-75996916-f24c-41fd-b83d-41eada2bc9f2.jpg	14	2026-07-31 15:24:35.548435
390	50	immobili/50/1785511475552-08712161-3684-4724-a15a-9507154ca823.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511475552-08712161-3684-4724-a15a-9507154ca823.jpg	15	2026-07-31 15:24:36.259495
391	50	immobili/50/1785511476264-79014176-6cd3-4c6d-8442-fbceeb5c26ad.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511476264-79014176-6cd3-4c6d-8442-fbceeb5c26ad.jpg	16	2026-07-31 15:24:37.038838
392	50	immobili/50/1785511477044-40bf6f52-4a70-44d9-a7cc-cf48fa812b31.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511477044-40bf6f52-4a70-44d9-a7cc-cf48fa812b31.jpg	17	2026-07-31 15:24:37.669819
393	50	immobili/50/1785511477674-a6b4a60c-63c7-457d-a630-6625ec487a4a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511477674-a6b4a60c-63c7-457d-a630-6625ec487a4a.jpg	18	2026-07-31 15:24:38.399946
394	50	immobili/50/1785511478404-6d2eb0e3-a670-4b50-b308-c9956baf45f8.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511478404-6d2eb0e3-a670-4b50-b308-c9956baf45f8.jpg	19	2026-07-31 15:24:39.08896
395	50	immobili/50/1785511479095-b64b0097-fe6f-4963-870b-a02afd7b180d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511479095-b64b0097-fe6f-4963-870b-a02afd7b180d.jpg	20	2026-07-31 15:24:39.829181
396	50	immobili/50/1785511479834-ef1acda4-c546-4f36-8883-5fe22c7e8eab.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511479834-ef1acda4-c546-4f36-8883-5fe22c7e8eab.jpg	21	2026-07-31 15:24:40.603423
397	50	immobili/50/1785511480611-1b4f58c6-dd6f-4795-adce-de63e876e303.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511480611-1b4f58c6-dd6f-4795-adce-de63e876e303.jpg	22	2026-07-31 15:24:41.318706
398	50	immobili/50/1785511481328-2a41f0a0-eff2-4ddd-a20e-13f04c478187.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511481328-2a41f0a0-eff2-4ddd-a20e-13f04c478187.jpg	23	2026-07-31 15:24:42.078656
399	50	immobili/50/1785511482086-9bd9363a-f2e6-4892-83c8-a9ecb08719ec.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/50/1785511482086-9bd9363a-f2e6-4892-83c8-a9ecb08719ec.jpg	24	2026-07-31 15:24:42.729735
400	51	immobili/51/1785511622967-dd53f4dd-3a9f-4d06-b9e6-efbcab0162de.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/51/1785511622967-dd53f4dd-3a9f-4d06-b9e6-efbcab0162de.jpg	0	2026-07-31 15:27:03.981195
401	52	immobili/52/1785511778363-e9e0f21e-1bdd-4b07-81c1-3ebe180b9f21.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/52/1785511778363-e9e0f21e-1bdd-4b07-81c1-3ebe180b9f21.jpg	0	2026-07-31 15:29:39.642101
402	52	immobili/52/1785511779656-9428cc46-2e49-471c-a56a-8a9b5275d7f6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/52/1785511779656-9428cc46-2e49-471c-a56a-8a9b5275d7f6.jpg	1	2026-07-31 15:29:40.812233
403	52	immobili/52/1785511780824-ca7ddb55-7730-4269-a049-991a2f91c089.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/52/1785511780824-ca7ddb55-7730-4269-a049-991a2f91c089.jpg	2	2026-07-31 15:29:41.480366
404	52	immobili/52/1785511781485-dc6b9d80-48ad-4d25-a408-9b9e036d92d9.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/52/1785511781485-dc6b9d80-48ad-4d25-a408-9b9e036d92d9.jpg	3	2026-07-31 15:29:42.220041
405	52	immobili/52/1785511782225-7f32b52e-495f-40e1-8330-58f943819527.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/52/1785511782225-7f32b52e-495f-40e1-8330-58f943819527.jpg	4	2026-07-31 15:29:42.831375
406	52	immobili/52/1785511782836-bbef082f-1b8b-4b05-bdc3-92b96250e8b8.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/52/1785511782836-bbef082f-1b8b-4b05-bdc3-92b96250e8b8.jpg	5	2026-07-31 15:29:43.371426
407	52	immobili/52/1785511783377-d866c8fa-8f73-4a2d-a328-59680d4593d8.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/52/1785511783377-d866c8fa-8f73-4a2d-a328-59680d4593d8.jpg	6	2026-07-31 15:29:43.95145
408	52	immobili/52/1785511783958-53d74497-a22e-41d9-a360-e0ad3ce1333a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/52/1785511783958-53d74497-a22e-41d9-a360-e0ad3ce1333a.jpg	7	2026-07-31 15:29:44.430189
409	52	immobili/52/1785511784435-9a1d1ac0-0b12-42d9-b0a6-0a3ef6a91abe.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/52/1785511784435-9a1d1ac0-0b12-42d9-b0a6-0a3ef6a91abe.jpg	8	2026-07-31 15:29:45.002677
410	52	immobili/52/1785511785008-05ac7270-3f97-404d-9fe7-cd886ff23eba.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/52/1785511785008-05ac7270-3f97-404d-9fe7-cd886ff23eba.jpg	9	2026-07-31 15:29:45.762437
411	52	immobili/52/1785511785768-6f7c2e31-e1a8-4560-a43e-745cfcff472e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/52/1785511785768-6f7c2e31-e1a8-4560-a43e-745cfcff472e.jpg	10	2026-07-31 15:29:46.731408
412	52	immobili/52/1785511786738-162ddde1-4143-4085-861b-e7d68f97ffb2.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/52/1785511786738-162ddde1-4143-4085-861b-e7d68f97ffb2.jpg	11	2026-07-31 15:29:47.674472
413	52	immobili/52/1785511787680-b5c4330e-0411-41b9-b599-97331f01b559.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/52/1785511787680-b5c4330e-0411-41b9-b599-97331f01b559.jpg	12	2026-07-31 15:29:48.424674
414	53	immobili/53/1785512045955-eb8786b1-f1b6-4893-b494-6724ed48b001.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/53/1785512045955-eb8786b1-f1b6-4893-b494-6724ed48b001.jpg	0	2026-07-31 15:34:07.009496
415	53	immobili/53/1785512047014-d5b50502-68d4-4d2a-9816-ac615b7b93cf.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/53/1785512047014-d5b50502-68d4-4d2a-9816-ac615b7b93cf.jpg	1	2026-07-31 15:34:08.308452
416	53	immobili/53/1785512048318-54e71c6a-c24a-401f-9530-3ced137267d9.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/53/1785512048318-54e71c6a-c24a-401f-9530-3ced137267d9.jpg	2	2026-07-31 15:34:09.193064
417	53	immobili/53/1785512049199-8dbaf5d5-57f0-4d50-a2f7-1c315d6a3138.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/53/1785512049199-8dbaf5d5-57f0-4d50-a2f7-1c315d6a3138.jpg	3	2026-07-31 15:34:09.701664
418	53	immobili/53/1785512049708-d13e5b2d-289c-416a-8822-77c3d58bcfef.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/53/1785512049708-d13e5b2d-289c-416a-8822-77c3d58bcfef.jpg	4	2026-07-31 15:34:10.539756
419	53	immobili/53/1785512050547-d90e438b-dffb-4ca4-95ba-10b3756310a6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/53/1785512050547-d90e438b-dffb-4ca4-95ba-10b3756310a6.jpg	5	2026-07-31 15:34:11.466044
420	53	immobili/53/1785512051478-d586b3ff-9d4f-4d79-85ee-ab91faa93aac.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/53/1785512051478-d586b3ff-9d4f-4d79-85ee-ab91faa93aac.jpg	6	2026-07-31 15:34:11.992491
421	53	immobili/53/1785512051997-c5d2190e-8ce1-4d27-a0d2-69d652453f56.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/53/1785512051997-c5d2190e-8ce1-4d27-a0d2-69d652453f56.jpg	7	2026-07-31 15:34:13.148253
422	54	immobili/54/1785512215630-1e57c9a8-7227-4f8a-a412-f024fd78391c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512215630-1e57c9a8-7227-4f8a-a412-f024fd78391c.jpg	0	2026-07-31 15:36:57.134409
423	54	immobili/54/1785512217155-3ea961b1-af18-4ae9-9ce4-2653943d9d40.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512217155-3ea961b1-af18-4ae9-9ce4-2653943d9d40.jpg	1	2026-07-31 15:36:57.943703
424	54	immobili/54/1785512217949-a81ca084-8969-4e90-8694-b8d05944457d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512217949-a81ca084-8969-4e90-8694-b8d05944457d.jpg	2	2026-07-31 15:36:58.463984
425	54	immobili/54/1785512218487-965b39bf-fb6c-43e1-93bf-a511cd132c7e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512218487-965b39bf-fb6c-43e1-93bf-a511cd132c7e.jpg	3	2026-07-31 15:36:59.083175
426	54	immobili/54/1785512219090-97655708-3b41-434c-875e-6770a00d0d2b.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512219090-97655708-3b41-434c-875e-6770a00d0d2b.jpg	4	2026-07-31 15:36:59.631712
427	54	immobili/54/1785512219635-61302700-b4d2-42cc-908a-50f16eb574ec.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512219635-61302700-b4d2-42cc-908a-50f16eb574ec.jpg	5	2026-07-31 15:37:00.463367
428	54	immobili/54/1785512220468-14ea7291-967c-4399-bfdc-4a3542586378.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512220468-14ea7291-967c-4399-bfdc-4a3542586378.jpg	6	2026-07-31 15:37:01.034351
429	54	immobili/54/1785512221038-becbc605-a16a-447f-a22b-895e1c8028fe.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512221038-becbc605-a16a-447f-a22b-895e1c8028fe.jpg	7	2026-07-31 15:37:01.544428
430	54	immobili/54/1785512221550-eb227c16-7d81-4556-b02b-5a04c22e5f4e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512221550-eb227c16-7d81-4556-b02b-5a04c22e5f4e.jpg	8	2026-07-31 15:37:02.253403
431	54	immobili/54/1785512222260-98ecbde6-7696-4d1f-8089-180e7f3a758c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512222260-98ecbde6-7696-4d1f-8089-180e7f3a758c.jpg	9	2026-07-31 15:37:02.753167
432	54	immobili/54/1785512222759-1587b705-5aca-4145-a44c-e9978120ea12.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512222759-1587b705-5aca-4145-a44c-e9978120ea12.jpg	10	2026-07-31 15:37:03.282779
433	54	immobili/54/1785512223285-b90b8980-b95b-4754-a964-8ebc0ed4569f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512223285-b90b8980-b95b-4754-a964-8ebc0ed4569f.jpg	11	2026-07-31 15:37:03.893038
434	54	immobili/54/1785512223898-3311788f-5398-4b8c-813a-4827bebb47a4.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512223898-3311788f-5398-4b8c-813a-4827bebb47a4.jpg	12	2026-07-31 15:37:04.637218
435	54	immobili/54/1785512224642-2421f351-82ad-4545-bcf5-52786c329be3.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512224642-2421f351-82ad-4545-bcf5-52786c329be3.jpg	13	2026-07-31 15:37:05.243768
436	54	immobili/54/1785512225250-8f3d6435-cb25-435c-89d4-0fd91ac5e7de.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512225250-8f3d6435-cb25-435c-89d4-0fd91ac5e7de.jpg	14	2026-07-31 15:37:05.872875
437	54	immobili/54/1785512225878-7a50243d-e789-47da-9286-35280e76d299.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512225878-7a50243d-e789-47da-9286-35280e76d299.jpg	15	2026-07-31 15:37:06.50391
438	54	immobili/54/1785512226509-2822fb23-0b6b-4ffe-8ae8-a48433e8e494.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512226509-2822fb23-0b6b-4ffe-8ae8-a48433e8e494.jpg	16	2026-07-31 15:37:07.024082
439	54	immobili/54/1785512227028-788a296c-c3d6-4982-8d4b-22ce5ce03530.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/54/1785512227028-788a296c-c3d6-4982-8d4b-22ce5ce03530.jpg	17	2026-07-31 15:37:08.003635
440	55	immobili/55/1785512402574-8ca7ea2c-878d-4cc2-be9d-456df108e6a0.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/55/1785512402574-8ca7ea2c-878d-4cc2-be9d-456df108e6a0.jpg	0	2026-07-31 15:40:03.425297
441	55	immobili/55/1785512403479-fbeac140-7618-48d6-b850-3eeb6f3e0d5e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/55/1785512403479-fbeac140-7618-48d6-b850-3eeb6f3e0d5e.jpg	1	2026-07-31 15:40:04.556005
442	55	immobili/55/1785512404561-77e3bef1-b42f-4d08-8ded-bd3f695c3187.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/55/1785512404561-77e3bef1-b42f-4d08-8ded-bd3f695c3187.jpg	2	2026-07-31 15:40:05.187695
443	55	immobili/55/1785512405193-9c46dfb6-7d49-45f4-b77e-fd1f21c65a89.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/55/1785512405193-9c46dfb6-7d49-45f4-b77e-fd1f21c65a89.jpg	3	2026-07-31 15:40:05.937006
444	55	immobili/55/1785512405945-538ef27f-1a31-4408-bdc8-9243ab084f81.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/55/1785512405945-538ef27f-1a31-4408-bdc8-9243ab084f81.jpg	4	2026-07-31 15:40:06.473916
445	55	immobili/55/1785512406482-59b06ad2-c99a-4565-8ce5-f74848b007ad.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/55/1785512406482-59b06ad2-c99a-4565-8ce5-f74848b007ad.jpg	5	2026-07-31 15:40:07.044632
446	55	immobili/55/1785512407050-0af8d49f-961e-4d87-af52-3f0f868c5a1a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/55/1785512407050-0af8d49f-961e-4d87-af52-3f0f868c5a1a.jpg	6	2026-07-31 15:40:07.665471
447	55	immobili/55/1785512407671-0320087c-249f-45ef-8ba1-507d81a3ff42.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/55/1785512407671-0320087c-249f-45ef-8ba1-507d81a3ff42.jpg	7	2026-07-31 15:40:08.714872
448	55	immobili/55/1785512408719-c3c80a77-47af-42db-be1b-cd3479437342.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/55/1785512408719-c3c80a77-47af-42db-be1b-cd3479437342.jpg	8	2026-07-31 15:40:09.534481
449	55	immobili/55/1785512409539-bbb89f36-cac5-416d-a6c2-1972a015e858.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/55/1785512409539-bbb89f36-cac5-416d-a6c2-1972a015e858.jpg	9	2026-07-31 15:40:10.206677
450	55	immobili/55/1785512410210-417540f6-3c0a-4be9-98cd-e0fcc70a8c60.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/55/1785512410210-417540f6-3c0a-4be9-98cd-e0fcc70a8c60.jpg	10	2026-07-31 15:40:10.774576
451	55	immobili/55/1785512410778-c9894f73-fd65-4a53-bc49-3b461e9a0fa7.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/55/1785512410778-c9894f73-fd65-4a53-bc49-3b461e9a0fa7.jpg	11	2026-07-31 15:40:11.475672
452	55	immobili/55/1785512411479-bf11585a-f951-4609-bd64-1cf639f8c5ba.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/55/1785512411479-bf11585a-f951-4609-bd64-1cf639f8c5ba.jpg	12	2026-07-31 15:40:12.155218
453	56	immobili/56/1785512563045-126071fc-f1ef-4043-9bb6-72fae566b8f4.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/56/1785512563045-126071fc-f1ef-4043-9bb6-72fae566b8f4.jpg	0	2026-07-31 15:42:43.914459
454	56	immobili/56/1785512563924-a490c97d-2513-4f0f-8be4-ed069b56fd67.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/56/1785512563924-a490c97d-2513-4f0f-8be4-ed069b56fd67.jpg	1	2026-07-31 15:42:44.545977
455	56	immobili/56/1785512564553-ee36d691-2c4a-4b7d-a8c2-00b0fc9241c1.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/56/1785512564553-ee36d691-2c4a-4b7d-a8c2-00b0fc9241c1.jpg	2	2026-07-31 15:42:45.3655
456	56	immobili/56/1785512565371-1385c4d9-141e-429d-83ea-d399876e63c9.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/56/1785512565371-1385c4d9-141e-429d-83ea-d399876e63c9.jpg	3	2026-07-31 15:42:45.867693
457	56	immobili/56/1785512565875-69a3a06a-c630-4a4b-bc38-0822387c98d3.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/56/1785512565875-69a3a06a-c630-4a4b-bc38-0822387c98d3.jpg	4	2026-07-31 15:42:46.636765
458	56	immobili/56/1785512566641-687cf918-8174-4c3c-8bd8-6e15ad4835bc.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/56/1785512566641-687cf918-8174-4c3c-8bd8-6e15ad4835bc.jpg	5	2026-07-31 15:42:47.396501
459	56	immobili/56/1785512567402-6360e443-d3dd-47f0-b729-5b91ab962a90.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/56/1785512567402-6360e443-d3dd-47f0-b729-5b91ab962a90.jpg	6	2026-07-31 15:42:47.944033
460	56	immobili/56/1785512567947-b21fab46-b57d-4761-9ee6-075ccb416052.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/56/1785512567947-b21fab46-b57d-4761-9ee6-075ccb416052.jpg	7	2026-07-31 15:42:48.636531
461	57	immobili/57/1785512959707-7e6cc50b-3157-4708-bb03-bfa7190a5553.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512959707-7e6cc50b-3157-4708-bb03-bfa7190a5553.jpg	0	2026-07-31 15:49:20.790955
462	57	immobili/57/1785512960795-7c063513-5a93-49e5-b3d4-9ab6eef26d58.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512960795-7c063513-5a93-49e5-b3d4-9ab6eef26d58.jpg	1	2026-07-31 15:49:21.386549
463	57	immobili/57/1785512961440-5907021d-9591-4d6b-be77-e5a62ee65c2a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512961440-5907021d-9591-4d6b-be77-e5a62ee65c2a.jpg	2	2026-07-31 15:49:22.131844
464	57	immobili/57/1785512962139-3ab5ab33-51e7-49d4-bf38-3fad3169a038.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512962139-3ab5ab33-51e7-49d4-bf38-3fad3169a038.jpg	3	2026-07-31 15:49:22.876903
465	57	immobili/57/1785512962888-d3cda8c0-4fb1-44cf-b195-182d83a3a37d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512962888-d3cda8c0-4fb1-44cf-b195-182d83a3a37d.jpg	4	2026-07-31 15:49:23.993301
466	57	immobili/57/1785512964000-e7adab78-6423-4e8f-bbc6-fa8cf3ac8728.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512964000-e7adab78-6423-4e8f-bbc6-fa8cf3ac8728.jpg	5	2026-07-31 15:49:24.51795
467	57	immobili/57/1785512964521-0d061e08-6edf-4fa8-bda3-3c063c8bc277.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512964521-0d061e08-6edf-4fa8-bda3-3c063c8bc277.jpg	6	2026-07-31 15:49:25.020599
468	57	immobili/57/1785512965025-d40f55e4-4c08-4c39-bfd4-f611290a667f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512965025-d40f55e4-4c08-4c39-bfd4-f611290a667f.jpg	7	2026-07-31 15:49:25.620377
469	57	immobili/57/1785512965625-8369187a-c629-4a65-91c9-e8e4704d1c54.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512965625-8369187a-c629-4a65-91c9-e8e4704d1c54.jpg	8	2026-07-31 15:49:26.229281
470	57	immobili/57/1785512966235-f44206b9-bf13-48fe-8265-32174a404b0c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512966235-f44206b9-bf13-48fe-8265-32174a404b0c.jpg	9	2026-07-31 15:49:27.330676
471	57	immobili/57/1785512967335-68cb46e5-7b5f-4353-ad27-46a03fdca038.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512967335-68cb46e5-7b5f-4353-ad27-46a03fdca038.jpg	10	2026-07-31 15:49:28.02073
472	57	immobili/57/1785512968026-c037a85f-5b5b-4e89-8237-5c14d21055c6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512968026-c037a85f-5b5b-4e89-8237-5c14d21055c6.jpg	11	2026-07-31 15:49:28.70808
473	57	immobili/57/1785512968732-5fe9701a-3369-45ce-b2d4-a25a35405028.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512968732-5fe9701a-3369-45ce-b2d4-a25a35405028.jpg	12	2026-07-31 15:49:29.503267
474	57	immobili/57/1785512969508-9918d1ba-1fc1-4938-81cd-f6730cb0e62b.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512969508-9918d1ba-1fc1-4938-81cd-f6730cb0e62b.jpg	13	2026-07-31 15:49:30.281252
475	57	immobili/57/1785512970286-fa9377d5-135d-4f2a-8f81-7e15a2af208d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512970286-fa9377d5-135d-4f2a-8f81-7e15a2af208d.jpg	14	2026-07-31 15:49:31.072668
476	57	immobili/57/1785512971079-bfaae2f2-5980-4643-a861-7502b7711eec.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512971079-bfaae2f2-5980-4643-a861-7502b7711eec.jpg	15	2026-07-31 15:49:31.790731
477	57	immobili/57/1785512971796-079f9976-5801-415f-ae16-ba0446e6936f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512971796-079f9976-5801-415f-ae16-ba0446e6936f.jpg	16	2026-07-31 15:49:32.470188
478	57	immobili/57/1785512972475-a37324b2-a206-42fc-b82a-5b6348e436ac.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512972475-a37324b2-a206-42fc-b82a-5b6348e436ac.jpg	17	2026-07-31 15:49:33.028788
479	57	immobili/57/1785512973032-9b08f679-f7fb-4820-b25c-480a2ea21605.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512973032-9b08f679-f7fb-4820-b25c-480a2ea21605.jpg	18	2026-07-31 15:49:33.690788
480	57	immobili/57/1785512973696-9853ee30-42ee-49af-8852-9e2acadfd180.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512973696-9853ee30-42ee-49af-8852-9e2acadfd180.jpg	19	2026-07-31 15:49:34.300255
481	57	immobili/57/1785512974305-2b202051-dbb2-4142-a90e-fffd9854ae9d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/57/1785512974305-2b202051-dbb2-4142-a90e-fffd9854ae9d.jpg	20	2026-07-31 15:49:35.044406
482	59	immobili/59/1785513426684-a4f12c3e-8a16-4f04-8830-32d2322af9bc.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513426684-a4f12c3e-8a16-4f04-8830-32d2322af9bc.jpg	0	2026-07-31 15:57:07.625279
483	59	immobili/59/1785513427631-1fe1a468-68ae-443d-be4d-fb7f98b97938.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513427631-1fe1a468-68ae-443d-be4d-fb7f98b97938.jpg	1	2026-07-31 15:57:08.501132
484	59	immobili/59/1785513428506-a662ffdf-990d-4d57-b5f5-66b474118a88.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513428506-a662ffdf-990d-4d57-b5f5-66b474118a88.jpg	2	2026-07-31 15:57:09.23199
485	59	immobili/59/1785513429238-e3f07828-560d-4a00-9863-899e01c3ea01.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513429238-e3f07828-560d-4a00-9863-899e01c3ea01.jpg	3	2026-07-31 15:57:09.911155
486	59	immobili/59/1785513429916-25e9d77c-6528-4ea4-97ea-3415b90e4947.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513429916-25e9d77c-6528-4ea4-97ea-3415b90e4947.jpg	4	2026-07-31 15:57:10.471587
487	59	immobili/59/1785513430477-eddd211b-74d9-4b15-9e31-3e493f4948d8.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513430477-eddd211b-74d9-4b15-9e31-3e493f4948d8.jpg	5	2026-07-31 15:57:11.276749
488	59	immobili/59/1785513431299-09b038ca-ce31-417f-8aca-2dd178aecfb3.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513431299-09b038ca-ce31-417f-8aca-2dd178aecfb3.jpg	6	2026-07-31 15:57:12.063061
489	59	immobili/59/1785513432072-8c5c54b9-f78d-4c40-8d56-a47c4907a53b.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513432072-8c5c54b9-f78d-4c40-8d56-a47c4907a53b.jpg	7	2026-07-31 15:57:12.854323
490	59	immobili/59/1785513432858-a563cb83-eb17-4314-b3c6-e2926e33e802.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513432858-a563cb83-eb17-4314-b3c6-e2926e33e802.jpg	8	2026-07-31 15:57:13.678859
491	59	immobili/59/1785513433681-7ce69cbe-e54b-429d-8117-34a525a94f02.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513433681-7ce69cbe-e54b-429d-8117-34a525a94f02.jpg	9	2026-07-31 15:57:14.421607
492	59	immobili/59/1785513434426-a95938fe-1b85-4892-9328-e2158c383cbc.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513434426-a95938fe-1b85-4892-9328-e2158c383cbc.jpg	10	2026-07-31 15:57:15.032137
493	59	immobili/59/1785513435037-c56eafcf-0071-4153-98dd-cf8a36b558f4.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513435037-c56eafcf-0071-4153-98dd-cf8a36b558f4.jpg	11	2026-07-31 15:57:15.864087
494	59	immobili/59/1785513435870-75b58129-9b20-4044-be21-75ecbaa7853e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513435870-75b58129-9b20-4044-be21-75ecbaa7853e.jpg	12	2026-07-31 15:57:16.614005
495	59	immobili/59/1785513436619-20deb68f-30b3-4dd3-ae05-95f89d4ce941.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513436619-20deb68f-30b3-4dd3-ae05-95f89d4ce941.jpg	13	2026-07-31 15:57:17.312034
496	59	immobili/59/1785513437316-d4d7f9e9-48ba-480e-bcda-0f3df5fb908a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513437316-d4d7f9e9-48ba-480e-bcda-0f3df5fb908a.jpg	14	2026-07-31 15:57:17.911885
497	59	immobili/59/1785513437917-f2a8f81f-d808-4c85-8180-bc288f8b558a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513437917-f2a8f81f-d808-4c85-8180-bc288f8b558a.jpg	15	2026-07-31 15:57:18.552031
498	59	immobili/59/1785513438558-6fbb3a0e-7aa2-4cb8-91b0-568761fc0de1.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513438558-6fbb3a0e-7aa2-4cb8-91b0-568761fc0de1.jpg	16	2026-07-31 15:57:19.161856
499	59	immobili/59/1785513439168-2f0956f5-d6e2-497c-9218-203a3b335b1f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513439168-2f0956f5-d6e2-497c-9218-203a3b335b1f.jpg	17	2026-07-31 15:57:20.001414
500	59	immobili/59/1785513440006-04127d83-be9d-404b-a2e6-3a4a9efe3e63.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513440006-04127d83-be9d-404b-a2e6-3a4a9efe3e63.jpg	18	2026-07-31 15:57:20.601287
501	59	immobili/59/1785513440607-15770e33-889d-4493-beb3-b611ba7aa861.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513440607-15770e33-889d-4493-beb3-b611ba7aa861.jpg	19	2026-07-31 15:57:21.352602
502	59	immobili/59/1785513441358-820b12b5-e1b7-4641-a153-a76f7979f875.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513441358-820b12b5-e1b7-4641-a153-a76f7979f875.jpg	20	2026-07-31 15:57:22.011265
503	59	immobili/59/1785513442016-1729c7c8-b62c-4e87-a071-a6780b96693e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513442016-1729c7c8-b62c-4e87-a071-a6780b96693e.jpg	21	2026-07-31 15:57:22.630604
504	59	immobili/59/1785513442635-7bc758b3-8ca7-49ed-9428-a5448ed86af6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/59/1785513442635-7bc758b3-8ca7-49ed-9428-a5448ed86af6.jpg	22	2026-07-31 15:57:23.29015
505	60	immobili/60/1785513600902-075cb508-ae53-4edf-a02d-f7c6263484ec.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513600902-075cb508-ae53-4edf-a02d-f7c6263484ec.jpg	0	2026-07-31 16:00:02.090779
506	60	immobili/60/1785513602100-1d9f8322-62ef-4053-9446-09964614f5c1.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513602100-1d9f8322-62ef-4053-9446-09964614f5c1.jpg	1	2026-07-31 16:00:02.856477
507	60	immobili/60/1785513602868-0e642c09-893a-4b89-9d6e-173e3f43795d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513602868-0e642c09-893a-4b89-9d6e-173e3f43795d.jpg	2	2026-07-31 16:00:03.484789
508	60	immobili/60/1785513603489-c46ad1c8-fbac-4763-aad5-52bc274c1b04.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513603489-c46ad1c8-fbac-4763-aad5-52bc274c1b04.jpg	3	2026-07-31 16:00:04.165047
509	60	immobili/60/1785513604171-b704fdbe-b13f-4a3f-ba5e-43552a3ed596.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513604171-b704fdbe-b13f-4a3f-ba5e-43552a3ed596.jpg	4	2026-07-31 16:00:04.893332
510	60	immobili/60/1785513604898-68aa51dd-06c1-46d5-ab2c-866d2fd5a130.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513604898-68aa51dd-06c1-46d5-ab2c-866d2fd5a130.jpg	5	2026-07-31 16:00:05.563192
511	60	immobili/60/1785513605568-4834c140-6c2d-45ab-aa67-8de082501f5c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513605568-4834c140-6c2d-45ab-aa67-8de082501f5c.jpg	6	2026-07-31 16:00:06.183489
512	60	immobili/60/1785513606188-1df284f9-f2ca-4aee-a5ad-06e5a57bc32d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513606188-1df284f9-f2ca-4aee-a5ad-06e5a57bc32d.jpg	7	2026-07-31 16:00:06.773041
513	60	immobili/60/1785513606777-1c669d0f-a7d2-4432-824c-f15c40f20da6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513606777-1c669d0f-a7d2-4432-824c-f15c40f20da6.jpg	8	2026-07-31 16:00:07.373609
514	60	immobili/60/1785513607377-44ae47f7-d3f1-4cc2-aa82-48a1f5858571.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513607377-44ae47f7-d3f1-4cc2-aa82-48a1f5858571.jpg	9	2026-07-31 16:00:07.942427
515	60	immobili/60/1785513607947-9ca76099-80ee-4547-a395-d6c5d758f09b.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513607947-9ca76099-80ee-4547-a395-d6c5d758f09b.jpg	10	2026-07-31 16:00:08.543222
516	60	immobili/60/1785513608548-2566a607-b05a-4650-901e-a88cb57271b8.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513608548-2566a607-b05a-4650-901e-a88cb57271b8.jpg	11	2026-07-31 16:00:09.122819
517	60	immobili/60/1785513609128-a2d46988-b702-4064-8759-0a57b86cddce.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513609128-a2d46988-b702-4064-8759-0a57b86cddce.jpg	12	2026-07-31 16:00:09.715057
518	60	immobili/60/1785513609721-f83bfa11-8f05-4fba-b28d-67d8f40b038c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513609721-f83bfa11-8f05-4fba-b28d-67d8f40b038c.jpg	13	2026-07-31 16:00:10.292605
519	60	immobili/60/1785513610298-dcc92981-c89f-4ace-9006-6cf83b8f5c91.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513610298-dcc92981-c89f-4ace-9006-6cf83b8f5c91.jpg	14	2026-07-31 16:00:10.782944
520	60	immobili/60/1785513610787-3843c206-a8d3-487a-af25-9758c79ab97f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513610787-3843c206-a8d3-487a-af25-9758c79ab97f.jpg	15	2026-07-31 16:00:11.383505
521	60	immobili/60/1785513611388-596d6e7a-0640-43d8-a5f2-60f70173edf9.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513611388-596d6e7a-0640-43d8-a5f2-60f70173edf9.jpg	16	2026-07-31 16:00:12.022572
522	60	immobili/60/1785513612027-24dc62cc-62a1-4c58-b321-a2643112af81.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513612027-24dc62cc-62a1-4c58-b321-a2643112af81.jpg	17	2026-07-31 16:00:12.571855
523	60	immobili/60/1785513612575-7a930b0b-fa1d-4418-ad91-a6425ec8a7a1.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513612575-7a930b0b-fa1d-4418-ad91-a6425ec8a7a1.jpg	18	2026-07-31 16:00:13.252129
524	60	immobili/60/1785513613256-9e90d842-6cc8-4b09-b256-0c1058496ffc.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513613256-9e90d842-6cc8-4b09-b256-0c1058496ffc.jpg	19	2026-07-31 16:00:13.800636
525	60	immobili/60/1785513613804-738248cd-ebd5-4d24-851e-2a3b2776c210.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513613804-738248cd-ebd5-4d24-851e-2a3b2776c210.jpg	20	2026-07-31 16:00:14.462497
526	60	immobili/60/1785513614467-143fda85-0504-402b-b86f-62a2371e2ea6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513614467-143fda85-0504-402b-b86f-62a2371e2ea6.jpg	21	2026-07-31 16:00:15.272988
527	60	immobili/60/1785513615278-9a051f6c-2561-4395-a624-75a5b336d850.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/60/1785513615278-9a051f6c-2561-4395-a624-75a5b336d850.jpg	22	2026-07-31 16:00:16.293014
528	61	immobili/61/1785513845984-3697bcd7-de48-4608-ab46-2ad5d1275a22.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/61/1785513845984-3697bcd7-de48-4608-ab46-2ad5d1275a22.jpg	0	2026-07-31 16:04:07.036255
529	61	immobili/61/1785513847052-98e36a0b-9b0a-4470-96e7-8dbd1816baed.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/61/1785513847052-98e36a0b-9b0a-4470-96e7-8dbd1816baed.jpg	1	2026-07-31 16:04:07.675963
530	61	immobili/61/1785513847682-9da79fe5-b24a-40d3-8931-979e8027bf70.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/61/1785513847682-9da79fe5-b24a-40d3-8931-979e8027bf70.jpg	2	2026-07-31 16:04:08.335671
531	61	immobili/61/1785513848340-a62075ec-442e-4b64-93d8-abf03cc78b89.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/61/1785513848340-a62075ec-442e-4b64-93d8-abf03cc78b89.jpg	3	2026-07-31 16:04:08.873682
532	61	immobili/61/1785513848877-85cac04e-e908-4291-a602-fc0b348885a2.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/61/1785513848877-85cac04e-e908-4291-a602-fc0b348885a2.jpg	4	2026-07-31 16:04:09.445121
533	61	immobili/61/1785513849450-0d331772-f987-419a-a81f-0ace874398c4.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/61/1785513849450-0d331772-f987-419a-a81f-0ace874398c4.jpg	5	2026-07-31 16:04:10.115566
534	61	immobili/61/1785513850121-bd0432a4-cc8c-4846-aceb-538c29d18227.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/61/1785513850121-bd0432a4-cc8c-4846-aceb-538c29d18227.jpg	6	2026-07-31 16:04:10.846379
535	61	immobili/61/1785513850852-fde6c229-e458-4e34-9376-53c1d9818ecb.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/61/1785513850852-fde6c229-e458-4e34-9376-53c1d9818ecb.jpg	7	2026-07-31 16:04:11.695657
536	61	immobili/61/1785513851700-e7fb247d-ccd6-4ba2-af83-bf19446505ad.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/61/1785513851700-e7fb247d-ccd6-4ba2-af83-bf19446505ad.jpg	8	2026-07-31 16:04:12.385984
537	61	immobili/61/1785513852392-1298fd0e-5514-4089-b70b-223608aece70.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/61/1785513852392-1298fd0e-5514-4089-b70b-223608aece70.jpg	9	2026-07-31 16:04:13.114439
538	61	immobili/61/1785513853120-ec08e190-dd9d-4e43-be1f-65e1bc38a288.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/61/1785513853120-ec08e190-dd9d-4e43-be1f-65e1bc38a288.jpg	10	2026-07-31 16:04:14.039904
539	61	immobili/61/1785513854043-88709e4c-e733-48c2-bee5-4248eb7c5596.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/61/1785513854043-88709e4c-e733-48c2-bee5-4248eb7c5596.jpg	11	2026-07-31 16:04:14.903905
540	62	immobili/62/1785520611287-6678cf09-61dc-4620-9ceb-2bb781b7624e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/62/1785520611287-6678cf09-61dc-4620-9ceb-2bb781b7624e.jpg	0	2026-07-31 17:56:56.509721
541	62	immobili/62/1785520616551-d2d0cead-6b6c-414d-8af7-466957a510cc.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/62/1785520616551-d2d0cead-6b6c-414d-8af7-466957a510cc.jpg	1	2026-07-31 17:56:58.330951
542	62	immobili/62/1785520618336-8224160e-d265-41a1-953a-d39d291b70af.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/62/1785520618336-8224160e-d265-41a1-953a-d39d291b70af.jpg	2	2026-07-31 17:56:59.322556
543	62	immobili/62/1785520619329-066f1871-a9a2-441b-a1b5-1d9d90209630.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/62/1785520619329-066f1871-a9a2-441b-a1b5-1d9d90209630.jpg	3	2026-07-31 17:57:00.192094
544	62	immobili/62/1785520620197-f8306859-7a1e-40a6-98a3-b9d93e6d9204.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/62/1785520620197-f8306859-7a1e-40a6-98a3-b9d93e6d9204.jpg	4	2026-07-31 17:57:01.242806
545	62	immobili/62/1785520621250-8313ff9e-4009-4b50-bf70-47a0700dd530.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/62/1785520621250-8313ff9e-4009-4b50-bf70-47a0700dd530.jpg	5	2026-07-31 17:57:02.073023
546	62	immobili/62/1785520622076-fd999248-01a1-4bdb-bb0a-ea8e8cd249f4.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/62/1785520622076-fd999248-01a1-4bdb-bb0a-ea8e8cd249f4.jpg	6	2026-07-31 17:57:02.945768
547	62	immobili/62/1785520622953-1dc12d04-92fa-4a4d-b35b-2d1e81bb214e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/62/1785520622953-1dc12d04-92fa-4a4d-b35b-2d1e81bb214e.jpg	7	2026-07-31 17:57:03.855848
548	62	immobili/62/1785520623859-1284c4b8-6db8-4e2f-b3c3-22a407078cd6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/62/1785520623859-1284c4b8-6db8-4e2f-b3c3-22a407078cd6.jpg	8	2026-07-31 17:57:05.035266
549	62	immobili/62/1785520625048-77e23b26-a640-44e8-a61c-474e265f69d7.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/62/1785520625048-77e23b26-a640-44e8-a61c-474e265f69d7.jpg	9	2026-07-31 17:57:06.192178
550	62	immobili/62/1785520626197-8eeddf5a-de58-4fe8-bf9d-3435731ec2a8.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/62/1785520626197-8eeddf5a-de58-4fe8-bf9d-3435731ec2a8.jpg	10	2026-07-31 17:57:07.022683
551	62	immobili/62/1785520627027-68ddaa7d-1327-448b-919c-ff2fb21045e6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/62/1785520627027-68ddaa7d-1327-448b-919c-ff2fb21045e6.jpg	11	2026-07-31 17:57:07.801437
552	62	immobili/62/1785520627807-27bcf5fd-fac4-4366-825a-66372b844dfd.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/62/1785520627807-27bcf5fd-fac4-4366-825a-66372b844dfd.jpg	12	2026-07-31 17:57:08.682835
553	62	immobili/62/1785520628688-f2a174b4-9375-4694-943a-8b71bb503ed0.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/62/1785520628688-f2a174b4-9375-4694-943a-8b71bb503ed0.jpg	13	2026-07-31 17:57:09.54251
554	62	immobili/62/1785520629546-4a7c8231-98df-4421-b60a-64399852b9c4.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/62/1785520629546-4a7c8231-98df-4421-b60a-64399852b9c4.jpg	14	2026-07-31 17:57:10.652878
555	62	immobili/62/1785520630658-0bb33cf4-3b62-4197-a30b-9b774abffa7c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/62/1785520630658-0bb33cf4-3b62-4197-a30b-9b774abffa7c.jpg	15	2026-07-31 17:57:11.642838
556	62	immobili/62/1785520631648-d626bc80-5b5a-4177-ba1f-dd30c0684c0b.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/62/1785520631648-d626bc80-5b5a-4177-ba1f-dd30c0684c0b.jpg	16	2026-07-31 17:57:12.462976
557	63	immobili/63/1785522196002-68d7c6ad-f826-4497-bbaf-e1a2ee976c5e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522196002-68d7c6ad-f826-4497-bbaf-e1a2ee976c5e.jpg	0	2026-07-31 18:23:16.90917
558	63	immobili/63/1785522197029-03f25a02-8994-4c5b-ba92-ba6cfd7c18ae.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522197029-03f25a02-8994-4c5b-ba92-ba6cfd7c18ae.jpg	1	2026-07-31 18:23:17.809541
559	63	immobili/63/1785522197824-04c26414-894b-4aaa-a70e-a360277c0f99.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522197824-04c26414-894b-4aaa-a70e-a360277c0f99.jpg	2	2026-07-31 18:23:19.071219
560	63	immobili/63/1785522199078-335c872d-dab2-4490-9d60-e91ad17e0472.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522199078-335c872d-dab2-4490-9d60-e91ad17e0472.jpg	3	2026-07-31 18:23:19.748179
561	63	immobili/63/1785522199753-f70971f0-7b30-4ad2-8760-3316480c9fea.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522199753-f70971f0-7b30-4ad2-8760-3316480c9fea.jpg	4	2026-07-31 18:23:20.390428
562	63	immobili/63/1785522200397-6a483c94-4d58-4f9f-8e37-7c490e1587bc.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522200397-6a483c94-4d58-4f9f-8e37-7c490e1587bc.jpg	5	2026-07-31 18:23:20.959775
563	63	immobili/63/1785522200966-4e74574d-d844-4408-9d5b-b554b0502ec3.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522200966-4e74574d-d844-4408-9d5b-b554b0502ec3.jpg	6	2026-07-31 18:23:21.507778
564	63	immobili/63/1785522201512-2c143118-7daf-41b8-9dfb-2ed50680ab93.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522201512-2c143118-7daf-41b8-9dfb-2ed50680ab93.jpg	7	2026-07-31 18:23:22.088378
565	63	immobili/63/1785522202094-d709558a-7d79-4533-8b79-da43ad28de84.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522202094-d709558a-7d79-4533-8b79-da43ad28de84.jpg	8	2026-07-31 18:23:22.658763
566	63	immobili/63/1785522202664-597a5837-589a-4a10-a991-13e674ed0e12.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522202664-597a5837-589a-4a10-a991-13e674ed0e12.jpg	9	2026-07-31 18:23:23.288968
567	63	immobili/63/1785522203294-9dccbc3e-be97-45fe-9ea9-306cb106c7e5.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522203294-9dccbc3e-be97-45fe-9ea9-306cb106c7e5.jpg	10	2026-07-31 18:23:24.109368
568	63	immobili/63/1785522204115-35dcfc02-88d5-461a-93b3-94e7cff4c84f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522204115-35dcfc02-88d5-461a-93b3-94e7cff4c84f.jpg	11	2026-07-31 18:23:24.729186
569	63	immobili/63/1785522204734-0fbe0a69-ff9d-43a3-be4d-d1fefa6e0c8b.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522204734-0fbe0a69-ff9d-43a3-be4d-d1fefa6e0c8b.jpg	12	2026-07-31 18:23:25.287019
570	63	immobili/63/1785522205290-0794fa0f-4a5c-4bb6-bf6e-a83c3b2b6494.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522205290-0794fa0f-4a5c-4bb6-bf6e-a83c3b2b6494.jpg	13	2026-07-31 18:23:25.934218
571	63	immobili/63/1785522205945-6e784cc8-4f07-490b-82a9-f995868a3bc9.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522205945-6e784cc8-4f07-490b-82a9-f995868a3bc9.jpg	14	2026-07-31 18:23:26.768679
572	63	immobili/63/1785522206773-36dad1c0-2427-488d-8ad8-73859663f89b.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522206773-36dad1c0-2427-488d-8ad8-73859663f89b.jpg	15	2026-07-31 18:23:27.601745
573	63	immobili/63/1785522207605-bd0d4eeb-0432-4f82-b6eb-e072c97171e2.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522207605-bd0d4eeb-0432-4f82-b6eb-e072c97171e2.jpg	16	2026-07-31 18:23:28.410593
574	63	immobili/63/1785522208416-90d8899d-bd50-42bb-9d86-54e873743fb6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522208416-90d8899d-bd50-42bb-9d86-54e873743fb6.jpg	17	2026-07-31 18:23:29.199473
575	63	immobili/63/1785522209204-213d9ea6-d419-4067-9bac-f7f46b8e215e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522209204-213d9ea6-d419-4067-9bac-f7f46b8e215e.jpg	18	2026-07-31 18:23:29.819498
576	63	immobili/63/1785522209824-e430bfc4-b2b4-4634-b69f-0ae03c7c4694.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522209824-e430bfc4-b2b4-4634-b69f-0ae03c7c4694.jpg	19	2026-07-31 18:23:30.588578
577	63	immobili/63/1785522210593-9b4ee030-3d04-42f3-9999-d66d1b059c82.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522210593-9b4ee030-3d04-42f3-9999-d66d1b059c82.jpg	20	2026-07-31 18:23:31.258574
578	63	immobili/63/1785522211263-422c9c17-4bb4-4ffb-93f4-1e030914a0f0.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522211263-422c9c17-4bb4-4ffb-93f4-1e030914a0f0.jpg	21	2026-07-31 18:23:31.908792
579	63	immobili/63/1785522211914-8360968b-08c4-4823-ad5a-9f38a9b5e06f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522211914-8360968b-08c4-4823-ad5a-9f38a9b5e06f.jpg	22	2026-07-31 18:23:32.658668
580	63	immobili/63/1785522212663-2c42cd15-7516-4266-affc-1a8da819956c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522212663-2c42cd15-7516-4266-affc-1a8da819956c.jpg	23	2026-07-31 18:23:33.452424
581	63	immobili/63/1785522213458-2a8021a2-0f0f-4df0-a566-3c98ad9e423f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522213458-2a8021a2-0f0f-4df0-a566-3c98ad9e423f.jpg	24	2026-07-31 18:23:34.049062
582	63	immobili/63/1785522214055-7b123773-5575-4afc-9c17-563b071aab0e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522214055-7b123773-5575-4afc-9c17-563b071aab0e.jpg	25	2026-07-31 18:23:34.649248
583	63	immobili/63/1785522214653-bdbfe9e4-2f74-47cd-92ad-84c31dd9e5a4.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522214653-bdbfe9e4-2f74-47cd-92ad-84c31dd9e5a4.jpg	26	2026-07-31 18:23:35.418723
584	63	immobili/63/1785522215423-1a15aecc-1376-4802-9add-507b1e132e61.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522215423-1a15aecc-1376-4802-9add-507b1e132e61.jpg	27	2026-07-31 18:23:36.079849
585	63	immobili/63/1785522216085-97e220ad-2151-461a-a2f4-6eea72f5ac59.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522216085-97e220ad-2151-461a-a2f4-6eea72f5ac59.jpg	28	2026-07-31 18:23:36.839579
586	63	immobili/63/1785522216844-7a14a703-d572-49b1-af13-5a3afd32839b.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/63/1785522216844-7a14a703-d572-49b1-af13-5a3afd32839b.jpg	29	2026-07-31 18:23:37.609454
587	64	immobili/64/1785522316681-11d982da-d4d8-4052-9991-86d1206a7541.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/64/1785522316681-11d982da-d4d8-4052-9991-86d1206a7541.jpg	0	2026-07-31 18:25:17.501287
588	64	immobili/64/1785522317506-f7c87f07-fdc4-4cd0-81e2-5a091c3691d3.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/64/1785522317506-f7c87f07-fdc4-4cd0-81e2-5a091c3691d3.jpg	1	2026-07-31 18:25:18.110694
589	64	immobili/64/1785522318116-808c3cb4-00bd-47c4-9579-0aefa421d31f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/64/1785522318116-808c3cb4-00bd-47c4-9579-0aefa421d31f.jpg	2	2026-07-31 18:25:18.767758
590	64	immobili/64/1785522318798-c9e91ecc-7f80-4069-a6a6-f0e23eb2b5e5.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/64/1785522318798-c9e91ecc-7f80-4069-a6a6-f0e23eb2b5e5.jpg	3	2026-07-31 18:25:19.430276
591	64	immobili/64/1785522319435-1f43dd55-8980-427c-ab28-ccda7bb1263d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/64/1785522319435-1f43dd55-8980-427c-ab28-ccda7bb1263d.jpg	4	2026-07-31 18:25:20.019823
592	64	immobili/64/1785522320024-74db35dd-c23b-4b7c-938a-72c7aa4218cb.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/64/1785522320024-74db35dd-c23b-4b7c-938a-72c7aa4218cb.jpg	5	2026-07-31 18:25:20.680455
593	64	immobili/64/1785522320685-d469260c-d404-4c4f-a35b-cd03c2bf55a3.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/64/1785522320685-d469260c-d404-4c4f-a35b-cd03c2bf55a3.jpg	6	2026-07-31 18:25:21.43574
594	65	immobili/65/1785522437187-f4d192d4-cc00-4593-b161-b5e4e3c7b347.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/65/1785522437187-f4d192d4-cc00-4593-b161-b5e4e3c7b347.jpg	0	2026-07-31 18:27:18.100664
595	65	immobili/65/1785522438108-2173f6a2-5a4c-4083-a038-3b97da76b4ae.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/65/1785522438108-2173f6a2-5a4c-4083-a038-3b97da76b4ae.jpg	1	2026-07-31 18:27:18.829909
596	65	immobili/65/1785522438839-a9c6c917-5fb5-45bc-888f-eb104fd6b391.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/65/1785522438839-a9c6c917-5fb5-45bc-888f-eb104fd6b391.jpg	2	2026-07-31 18:27:19.329128
597	65	immobili/65/1785522439333-939165a7-41f7-433e-9b2f-711aae261241.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/65/1785522439333-939165a7-41f7-433e-9b2f-711aae261241.jpg	3	2026-07-31 18:27:19.888724
598	65	immobili/65/1785522439892-a70db2a6-d619-4b29-aed7-e9b07ea11642.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/65/1785522439892-a70db2a6-d619-4b29-aed7-e9b07ea11642.jpg	4	2026-07-31 18:27:20.620436
599	65	immobili/65/1785522440626-e7553d6b-2d15-4dd9-8c0a-365491caa7f1.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/65/1785522440626-e7553d6b-2d15-4dd9-8c0a-365491caa7f1.jpg	5	2026-07-31 18:27:21.409857
600	65	immobili/65/1785522441414-0180d5fa-441c-4b57-9253-9eb0c2bc5182.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/65/1785522441414-0180d5fa-441c-4b57-9253-9eb0c2bc5182.jpg	6	2026-07-31 18:27:22.04957
601	65	immobili/65/1785522442053-c29c3fb6-104e-4040-b0d7-389708a081b4.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/65/1785522442053-c29c3fb6-104e-4040-b0d7-389708a081b4.jpg	7	2026-07-31 18:27:22.56931
602	65	immobili/65/1785522442574-7eb5ad23-6213-47a1-9f0d-fff0e39597b5.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/65/1785522442574-7eb5ad23-6213-47a1-9f0d-fff0e39597b5.jpg	8	2026-07-31 18:27:23.099686
603	65	immobili/65/1785522443104-65cf126d-1dde-4e37-855d-9d70995774d0.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/65/1785522443104-65cf126d-1dde-4e37-855d-9d70995774d0.jpg	9	2026-07-31 18:27:23.560106
604	65	immobili/65/1785522443563-bfd1a5ff-ba84-4aa7-9cd3-3349865e1561.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/65/1785522443563-bfd1a5ff-ba84-4aa7-9cd3-3349865e1561.jpg	10	2026-07-31 18:27:24.240081
605	65	immobili/65/1785522444247-30be3cfe-0704-45d6-a60d-ab43cb3cc6a7.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/65/1785522444247-30be3cfe-0704-45d6-a60d-ab43cb3cc6a7.jpg	11	2026-07-31 18:27:24.759347
606	65	immobili/65/1785522444764-5a0fd960-1cdf-4afd-92db-dd3cda7922cb.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/65/1785522444764-5a0fd960-1cdf-4afd-92db-dd3cda7922cb.jpg	12	2026-07-31 18:27:25.399989
607	65	immobili/65/1785522445404-b5ae0b48-414b-4a63-8476-0023bbbe358d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/65/1785522445404-b5ae0b48-414b-4a63-8476-0023bbbe358d.jpg	13	2026-07-31 18:27:25.863407
608	65	immobili/65/1785522445869-52156425-d45f-46a7-82f7-41642181ca6b.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/65/1785522445869-52156425-d45f-46a7-82f7-41642181ca6b.jpg	14	2026-07-31 18:27:26.719335
609	66	immobili/66/1785522548566-ffcb0f92-90e9-4fcf-81c4-80e3783d9146.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/66/1785522548566-ffcb0f92-90e9-4fcf-81c4-80e3783d9146.jpg	0	2026-07-31 18:29:09.617114
610	66	immobili/66/1785522549622-7921f0d3-6f4f-4550-8730-4a7ca0d10627.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/66/1785522549622-7921f0d3-6f4f-4550-8730-4a7ca0d10627.jpg	1	2026-07-31 18:29:10.686056
611	66	immobili/66/1785522550687-99fefaf6-4229-4a9f-a9cf-0aeb2427d916.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/66/1785522550687-99fefaf6-4229-4a9f-a9cf-0aeb2427d916.jpg	2	2026-07-31 18:29:11.43821
612	66	immobili/66/1785522551446-a92277e2-2829-417c-8f70-54ff90b451c4.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/66/1785522551446-a92277e2-2829-417c-8f70-54ff90b451c4.jpg	3	2026-07-31 18:29:12.294877
613	66	immobili/66/1785522552300-89609883-2921-45c6-b8a3-404ee22c23f9.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/66/1785522552300-89609883-2921-45c6-b8a3-404ee22c23f9.jpg	4	2026-07-31 18:29:13.114214
614	66	immobili/66/1785522553121-86c4d075-9d10-44e6-96fa-847282cb1b8e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/66/1785522553121-86c4d075-9d10-44e6-96fa-847282cb1b8e.jpg	5	2026-07-31 18:29:13.728477
615	66	immobili/66/1785522553733-cd8b9970-8f73-42ce-bd71-7a8824dfc506.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/66/1785522553733-cd8b9970-8f73-42ce-bd71-7a8824dfc506.jpg	6	2026-07-31 18:29:14.668571
616	66	immobili/66/1785522554674-fd387813-a61b-45af-96be-f989aca52e08.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/66/1785522554674-fd387813-a61b-45af-96be-f989aca52e08.jpg	7	2026-07-31 18:29:15.498912
617	66	immobili/66/1785522555503-adaf2297-e5b8-47f2-b44a-f859cfb90c30.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/66/1785522555503-adaf2297-e5b8-47f2-b44a-f859cfb90c30.jpg	8	2026-07-31 18:29:16.319054
618	66	immobili/66/1785522556324-2e654ae3-ec86-43bd-b6e7-ac15bb800df7.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/66/1785522556324-2e654ae3-ec86-43bd-b6e7-ac15bb800df7.jpg	9	2026-07-31 18:29:17.298321
619	66	immobili/66/1785522557303-cd052ee3-45ce-40e3-93be-1ecdf76934e3.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/66/1785522557303-cd052ee3-45ce-40e3-93be-1ecdf76934e3.jpg	10	2026-07-31 18:29:18.272585
620	66	immobili/66/1785522558280-286abf45-014c-4970-9a90-75167cdda691.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/66/1785522558280-286abf45-014c-4970-9a90-75167cdda691.jpg	11	2026-07-31 18:29:19.148839
621	66	immobili/66/1785522559154-271bd490-7a31-4169-8104-8d2b126ccc53.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/66/1785522559154-271bd490-7a31-4169-8104-8d2b126ccc53.jpg	12	2026-07-31 18:29:20.078502
622	67	immobili/67/1785522659822-0c309b32-2e84-4534-ad71-a29bafae9032.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/67/1785522659822-0c309b32-2e84-4534-ad71-a29bafae9032.jpg	0	2026-07-31 18:31:00.710298
623	67	immobili/67/1785522660736-6b4feabf-b3d1-42df-a31b-be610f0355c1.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/67/1785522660736-6b4feabf-b3d1-42df-a31b-be610f0355c1.jpg	1	2026-07-31 18:31:01.305422
624	67	immobili/67/1785522661310-d96611d2-18ce-45e5-b960-6659c94faade.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/67/1785522661310-d96611d2-18ce-45e5-b960-6659c94faade.jpg	2	2026-07-31 18:31:01.854674
625	67	immobili/67/1785522661858-04721252-71b2-4626-b85f-14f1b6989f1f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/67/1785522661858-04721252-71b2-4626-b85f-14f1b6989f1f.jpg	3	2026-07-31 18:31:02.40591
626	67	immobili/67/1785522662409-f76427f2-1904-47b8-950a-a88592748122.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/67/1785522662409-f76427f2-1904-47b8-950a-a88592748122.jpg	4	2026-07-31 18:31:02.926241
627	67	immobili/67/1785522662931-6e92fef7-ad10-419f-811c-d5a6e01a8fe9.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/67/1785522662931-6e92fef7-ad10-419f-811c-d5a6e01a8fe9.jpg	5	2026-07-31 18:31:03.536526
628	67	immobili/67/1785522663541-db2cb1d8-954c-4b4f-a34a-3c2b9cd59bab.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/67/1785522663541-db2cb1d8-954c-4b4f-a34a-3c2b9cd59bab.jpg	6	2026-07-31 18:31:04.316973
629	67	immobili/67/1785522664324-ed93b688-3fb6-4c63-a044-5a8e6e1acd1d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/67/1785522664324-ed93b688-3fb6-4c63-a044-5a8e6e1acd1d.jpg	7	2026-07-31 18:31:04.927247
630	67	immobili/67/1785522664932-52af652b-00ae-40c5-bcde-70890496f10d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/67/1785522664932-52af652b-00ae-40c5-bcde-70890496f10d.jpg	8	2026-07-31 18:31:05.426176
631	67	immobili/67/1785522665430-a36cc19b-f5d8-498a-8a0e-0ce431d47c26.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/67/1785522665430-a36cc19b-f5d8-498a-8a0e-0ce431d47c26.jpg	9	2026-07-31 18:31:06.016271
632	67	immobili/67/1785522666019-e34994d6-faa6-4f86-a681-19eb3acfeb53.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/67/1785522666019-e34994d6-faa6-4f86-a681-19eb3acfeb53.jpg	10	2026-07-31 18:31:06.755501
633	67	immobili/67/1785522666760-d02c2c22-2511-4e14-9f17-5d20b4c3141b.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/67/1785522666760-d02c2c22-2511-4e14-9f17-5d20b4c3141b.jpg	11	2026-07-31 18:31:07.77714
634	67	immobili/67/1785522667781-d78f646b-68fb-48df-a5c3-f12aee8035de.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/67/1785522667781-d78f646b-68fb-48df-a5c3-f12aee8035de.jpg	12	2026-07-31 18:31:08.437495
635	67	immobili/67/1785522668442-6ad11fd5-2bf5-4c67-8a2c-2465c5dc4e8a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/67/1785522668442-6ad11fd5-2bf5-4c67-8a2c-2465c5dc4e8a.jpg	13	2026-07-31 18:31:09.042772
636	67	immobili/67/1785522669057-19a689e2-db10-4cd9-8624-8787aec788d1.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/67/1785522669057-19a689e2-db10-4cd9-8624-8787aec788d1.jpg	14	2026-07-31 18:31:09.566424
637	68	immobili/68/1785522778089-5b55556e-3713-4c22-a31b-cfc1e7230f0f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/68/1785522778089-5b55556e-3713-4c22-a31b-cfc1e7230f0f.jpg	0	2026-07-31 18:32:58.806332
638	68	immobili/68/1785522778817-bc166e96-1c51-4313-8f3d-6966ea2bde3d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/68/1785522778817-bc166e96-1c51-4313-8f3d-6966ea2bde3d.jpg	1	2026-07-31 18:32:59.388484
639	68	immobili/68/1785522779395-388410ab-556d-493e-8a46-7cac9c8f04aa.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/68/1785522779395-388410ab-556d-493e-8a46-7cac9c8f04aa.jpg	2	2026-07-31 18:33:00.057155
640	68	immobili/68/1785522780064-cb20a159-0376-47e5-b198-440e084bcce3.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/68/1785522780064-cb20a159-0376-47e5-b198-440e084bcce3.jpg	3	2026-07-31 18:33:00.576781
641	69	immobili/69/1785522883671-15b4e37c-da6f-4b02-92c9-bcd6b9d4aecd.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/69/1785522883671-15b4e37c-da6f-4b02-92c9-bcd6b9d4aecd.jpg	0	2026-07-31 18:34:44.606777
642	69	immobili/69/1785522884613-97320221-5e45-4427-a2e3-e4d57091a368.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/69/1785522884613-97320221-5e45-4427-a2e3-e4d57091a368.jpg	1	2026-07-31 18:34:45.359728
643	69	immobili/69/1785522885378-9c0eb5f2-3957-4e08-9348-4b113b0f4c33.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/69/1785522885378-9c0eb5f2-3957-4e08-9348-4b113b0f4c33.jpg	2	2026-07-31 18:34:46.106658
644	69	immobili/69/1785522886116-d69d5edf-e8d6-45a2-92ad-50fb15281dcf.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/69/1785522886116-d69d5edf-e8d6-45a2-92ad-50fb15281dcf.jpg	3	2026-07-31 18:34:46.820586
645	69	immobili/69/1785522886824-6d16e9fb-9779-4ddf-b3cf-5015c50ed6a0.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/69/1785522886824-6d16e9fb-9779-4ddf-b3cf-5015c50ed6a0.jpg	4	2026-07-31 18:34:47.784151
646	70	immobili/70/1785522993569-d934f720-f6a8-481f-9b5f-af5753ca7a7c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/70/1785522993569-d934f720-f6a8-481f-9b5f-af5753ca7a7c.jpg	0	2026-07-31 18:36:34.225201
647	70	immobili/70/1785522994231-49e63965-f5a2-4994-8076-3fdeae919e79.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/70/1785522994231-49e63965-f5a2-4994-8076-3fdeae919e79.jpg	1	2026-07-31 18:36:34.866318
648	70	immobili/70/1785522994875-48dca298-89f3-40ff-9f13-d24fce294041.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/70/1785522994875-48dca298-89f3-40ff-9f13-d24fce294041.jpg	2	2026-07-31 18:36:35.375039
649	70	immobili/70/1785522995381-9e9322bf-8226-4ad7-be70-b6f9ceacfae6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/70/1785522995381-9e9322bf-8226-4ad7-be70-b6f9ceacfae6.jpg	3	2026-07-31 18:36:35.974427
650	70	immobili/70/1785522995983-34b6f014-4889-41c0-abea-ed1e0a9e9971.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/70/1785522995983-34b6f014-4889-41c0-abea-ed1e0a9e9971.jpg	4	2026-07-31 18:36:36.462917
651	70	immobili/70/1785522996469-21b248c1-aa45-452c-a4d2-05d9052f1321.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/70/1785522996469-21b248c1-aa45-452c-a4d2-05d9052f1321.jpg	5	2026-07-31 18:36:37.092225
652	70	immobili/70/1785522997097-8a5ea3cd-28f0-48dc-826d-73e0621d97d1.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/70/1785522997097-8a5ea3cd-28f0-48dc-826d-73e0621d97d1.jpg	6	2026-07-31 18:36:37.793147
653	70	immobili/70/1785522997798-19d8e7f4-37c1-4ae7-8bbb-9ca7a31f2c25.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/70/1785522997798-19d8e7f4-37c1-4ae7-8bbb-9ca7a31f2c25.jpg	7	2026-07-31 18:36:38.342963
654	70	immobili/70/1785522998347-89c77026-080b-4eb5-8071-683fea173c5b.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/70/1785522998347-89c77026-080b-4eb5-8071-683fea173c5b.jpg	8	2026-07-31 18:36:38.990969
655	70	immobili/70/1785522998993-238eb872-2c08-4c5d-b0c8-25ca62884b71.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/70/1785522998993-238eb872-2c08-4c5d-b0c8-25ca62884b71.jpg	9	2026-07-31 18:36:39.583362
656	71	immobili/71/1785523129872-5e21ffcf-2bc8-4c2b-86e8-ec97dd8ba1e6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523129872-5e21ffcf-2bc8-4c2b-86e8-ec97dd8ba1e6.jpg	0	2026-07-31 18:38:50.872521
657	71	immobili/71/1785523130906-b171035c-f155-46f0-ab23-60dc30affc82.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523130906-b171035c-f155-46f0-ab23-60dc30affc82.jpg	1	2026-07-31 18:38:51.950275
658	71	immobili/71/1785523131956-cebde780-cff8-4fcd-9e62-250a15f58bf6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523131956-cebde780-cff8-4fcd-9e62-250a15f58bf6.jpg	2	2026-07-31 18:38:53.420049
659	71	immobili/71/1785523133426-b51db636-8078-42bd-86ac-7a146d7aaf34.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523133426-b51db636-8078-42bd-86ac-7a146d7aaf34.jpg	3	2026-07-31 18:38:54.100289
660	71	immobili/71/1785523134102-d3792505-db67-4ed4-a89a-42ad517b7e2e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523134102-d3792505-db67-4ed4-a89a-42ad517b7e2e.jpg	4	2026-07-31 18:38:55.790464
661	71	immobili/71/1785523135798-11d5d2db-75bc-4a96-8b62-6995517e7fc7.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523135798-11d5d2db-75bc-4a96-8b62-6995517e7fc7.jpg	5	2026-07-31 18:38:56.542764
662	71	immobili/71/1785523136549-49e383ac-a32c-4ba4-8f57-0e6f977cda93.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523136549-49e383ac-a32c-4ba4-8f57-0e6f977cda93.jpg	6	2026-07-31 18:38:57.169165
663	71	immobili/71/1785523137174-1d053472-93cf-40b6-9349-e587039ecf4a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523137174-1d053472-93cf-40b6-9349-e587039ecf4a.jpg	7	2026-07-31 18:38:58.248829
664	71	immobili/71/1785523138254-2a362e06-8504-4397-ad77-f8b67bb886b3.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523138254-2a362e06-8504-4397-ad77-f8b67bb886b3.jpg	8	2026-07-31 18:38:58.838667
665	71	immobili/71/1785523138844-e4d12d8c-508d-4db5-9634-e6f2acc06b04.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523138844-e4d12d8c-508d-4db5-9634-e6f2acc06b04.jpg	9	2026-07-31 18:38:59.643294
666	71	immobili/71/1785523139647-1b7b23d4-3498-4bb2-8fba-d8650c9ecc5b.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523139647-1b7b23d4-3498-4bb2-8fba-d8650c9ecc5b.jpg	10	2026-07-31 18:39:00.340124
667	71	immobili/71/1785523140350-651e653d-97d5-4591-98b9-a2008afb6a50.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523140350-651e653d-97d5-4591-98b9-a2008afb6a50.jpg	11	2026-07-31 18:39:00.960113
668	71	immobili/71/1785523140966-f293cc51-b05d-4c2f-8780-fbfee332ab0a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523140966-f293cc51-b05d-4c2f-8780-fbfee332ab0a.jpg	12	2026-07-31 18:39:01.517945
669	71	immobili/71/1785523141523-b3d3200d-d78a-4e1c-a087-ffaa70f2d185.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523141523-b3d3200d-d78a-4e1c-a087-ffaa70f2d185.jpg	13	2026-07-31 18:39:02.14964
670	71	immobili/71/1785523142155-6501400e-58bc-4830-904e-ebabc859700f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523142155-6501400e-58bc-4830-904e-ebabc859700f.jpg	14	2026-07-31 18:39:03.112897
671	71	immobili/71/1785523143117-f8ba281f-64e8-4b81-8a4d-a47b64d57a46.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523143117-f8ba281f-64e8-4b81-8a4d-a47b64d57a46.jpg	15	2026-07-31 18:39:03.968926
672	71	immobili/71/1785523143973-01dd86f9-a028-40f2-8327-5e59b500a40f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523143973-01dd86f9-a028-40f2-8327-5e59b500a40f.jpg	16	2026-07-31 18:39:04.510323
673	71	immobili/71/1785523144512-1f4e2594-fa45-4cb5-8f05-0719432a7824.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523144512-1f4e2594-fa45-4cb5-8f05-0719432a7824.jpg	17	2026-07-31 18:39:05.338921
674	71	immobili/71/1785523145343-5f77c0a9-83d3-4a20-8f0a-71d4f7cbdba1.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523145343-5f77c0a9-83d3-4a20-8f0a-71d4f7cbdba1.jpg	18	2026-07-31 18:39:06.026353
675	71	immobili/71/1785523146027-20e231e8-cb23-41f2-96b9-d487bb07abf3.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523146027-20e231e8-cb23-41f2-96b9-d487bb07abf3.jpg	19	2026-07-31 18:39:06.722655
676	71	immobili/71/1785523146726-df31c52f-f912-464a-b4a4-b0022d617fba.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523146726-df31c52f-f912-464a-b4a4-b0022d617fba.jpg	20	2026-07-31 18:39:07.369659
677	71	immobili/71/1785523147374-f11110ac-3556-4ed5-8681-a50cf4f4c25e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523147374-f11110ac-3556-4ed5-8681-a50cf4f4c25e.jpg	21	2026-07-31 18:39:08.051206
678	71	immobili/71/1785523148061-d16ef3eb-833d-4822-b447-0f49fb198afb.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523148061-d16ef3eb-833d-4822-b447-0f49fb198afb.jpg	22	2026-07-31 18:39:08.899592
679	71	immobili/71/1785523148906-cf20c1f8-ddea-4c38-af55-bf7afb9e7ff7.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523148906-cf20c1f8-ddea-4c38-af55-bf7afb9e7ff7.jpg	23	2026-07-31 18:39:09.659185
680	71	immobili/71/1785523149662-1a870052-91f7-4869-91b2-79fbd1f578ea.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523149662-1a870052-91f7-4869-91b2-79fbd1f578ea.jpg	24	2026-07-31 18:39:10.53023
681	71	immobili/71/1785523150535-153f3980-65d8-4548-9f4c-60734283a229.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523150535-153f3980-65d8-4548-9f4c-60734283a229.jpg	25	2026-07-31 18:39:11.629385
682	71	immobili/71/1785523151633-006b6ba8-2c85-4bf6-9b1c-9023e2c2410f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523151633-006b6ba8-2c85-4bf6-9b1c-9023e2c2410f.jpg	26	2026-07-31 18:39:12.419466
683	71	immobili/71/1785523152424-a7be64cf-1da2-45e9-adc2-1f185280e154.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523152424-a7be64cf-1da2-45e9-adc2-1f185280e154.jpg	27	2026-07-31 18:39:13.067937
684	71	immobili/71/1785523153071-c5fc4647-0a3d-4846-b411-e550e70e4851.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523153071-c5fc4647-0a3d-4846-b411-e550e70e4851.jpg	28	2026-07-31 18:39:13.799511
685	71	immobili/71/1785523153804-d0c7353a-88cc-47ef-9689-ba6db44e9f27.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523153804-d0c7353a-88cc-47ef-9689-ba6db44e9f27.jpg	29	2026-07-31 18:39:14.669354
686	71	immobili/71/1785523154674-94c2c54a-1980-4805-89bd-aaae2ed1cc9c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523154674-94c2c54a-1980-4805-89bd-aaae2ed1cc9c.jpg	30	2026-07-31 18:39:15.409013
687	71	immobili/71/1785523155413-1faa3bfc-8b96-4adf-9c5a-5f28dc30bbfd.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523155413-1faa3bfc-8b96-4adf-9c5a-5f28dc30bbfd.jpg	31	2026-07-31 18:39:16.099746
688	71	immobili/71/1785523156104-09670950-7037-44fc-939c-5e383cfaa296.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523156104-09670950-7037-44fc-939c-5e383cfaa296.jpg	32	2026-07-31 18:39:17.029326
689	71	immobili/71/1785523157033-c9c64d5b-7c11-48f7-881f-2f3f4e3c3da9.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523157033-c9c64d5b-7c11-48f7-881f-2f3f4e3c3da9.jpg	33	2026-07-31 18:39:17.660876
690	71	immobili/71/1785523157664-785e3b76-fb4a-4609-8727-9bcc832e49cb.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523157664-785e3b76-fb4a-4609-8727-9bcc832e49cb.jpg	34	2026-07-31 18:39:18.581803
691	71	immobili/71/1785523158587-a52ae973-9e38-4f57-8ac5-e994450ff1bd.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523158587-a52ae973-9e38-4f57-8ac5-e994450ff1bd.jpg	35	2026-07-31 18:39:19.536682
692	71	immobili/71/1785523159546-a0b8757e-9a73-449d-b82a-c519f4e5b235.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523159546-a0b8757e-9a73-449d-b82a-c519f4e5b235.jpg	36	2026-07-31 18:39:20.372337
693	71	immobili/71/1785523160380-0eb45165-423a-4432-9492-88d4976a586e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523160380-0eb45165-423a-4432-9492-88d4976a586e.jpg	37	2026-07-31 18:39:21.269699
694	71	immobili/71/1785523161273-fdfec35e-b844-4620-809a-57c53c248f24.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523161273-fdfec35e-b844-4620-809a-57c53c248f24.jpg	38	2026-07-31 18:39:22.280378
695	71	immobili/71/1785523162285-74d98881-77be-4f5d-8292-9a26526637be.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523162285-74d98881-77be-4f5d-8292-9a26526637be.jpg	39	2026-07-31 18:39:23.283035
696	71	immobili/71/1785523163287-f3160576-04db-489b-affb-a0b18cbda229.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523163287-f3160576-04db-489b-affb-a0b18cbda229.jpg	40	2026-07-31 18:39:24.487322
697	71	immobili/71/1785523164499-00fd67c8-05aa-475b-9530-06281b91110f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523164499-00fd67c8-05aa-475b-9530-06281b91110f.jpg	41	2026-07-31 18:39:25.559528
698	71	immobili/71/1785523165563-97024d06-e6b2-4400-b459-3e675263832c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523165563-97024d06-e6b2-4400-b459-3e675263832c.jpg	42	2026-07-31 18:39:26.478854
699	71	immobili/71/1785523166498-2f2813ec-3505-421c-ba2b-371c6b61a095.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/71/1785523166498-2f2813ec-3505-421c-ba2b-371c6b61a095.jpg	43	2026-07-31 18:39:27.87512
700	72	immobili/72/1785523294851-da9cfb1d-2ca8-4f4e-8e7f-b540dd6a567e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523294851-da9cfb1d-2ca8-4f4e-8e7f-b540dd6a567e.jpg	0	2026-07-31 18:41:35.820012
701	72	immobili/72/1785523295859-36d11f35-daf9-4700-89a2-dd367a8f39a1.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523295859-36d11f35-daf9-4700-89a2-dd367a8f39a1.jpg	1	2026-07-31 18:41:37.81914
702	72	immobili/72/1785523297824-21efdba6-4993-4486-bd97-877030845555.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523297824-21efdba6-4993-4486-bd97-877030845555.jpg	2	2026-07-31 18:41:39.870389
703	72	immobili/72/1785523299878-84224963-4eba-4feb-bc05-aa6421d0c908.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523299878-84224963-4eba-4feb-bc05-aa6421d0c908.jpg	3	2026-07-31 18:41:41.477897
704	72	immobili/72/1785523301482-b5dd8c91-4b70-48cc-b0cb-ae9c9d3f2108.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523301482-b5dd8c91-4b70-48cc-b0cb-ae9c9d3f2108.jpg	4	2026-07-31 18:41:43.759243
705	72	immobili/72/1785523303764-48d1eae6-878a-4369-a936-54a48eb217fe.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523303764-48d1eae6-878a-4369-a936-54a48eb217fe.jpg	5	2026-07-31 18:41:47.740065
706	72	immobili/72/1785523307749-acf4e515-74c2-4fc6-b91e-3879d20ee153.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523307749-acf4e515-74c2-4fc6-b91e-3879d20ee153.jpg	6	2026-07-31 18:41:49.8501
707	72	immobili/72/1785523309859-c8cf49ef-f926-4acd-ac40-fa705bb21a54.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523309859-c8cf49ef-f926-4acd-ac40-fa705bb21a54.jpg	7	2026-07-31 18:41:52.060775
708	72	immobili/72/1785523312066-4d6565b9-44d3-4a54-87a3-65077a412aa6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523312066-4d6565b9-44d3-4a54-87a3-65077a412aa6.jpg	8	2026-07-31 18:41:54.04952
709	72	immobili/72/1785523314058-334cedee-65ac-4dff-b0aa-fbf7fdb15c0a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523314058-334cedee-65ac-4dff-b0aa-fbf7fdb15c0a.jpg	9	2026-07-31 18:41:55.51806
710	72	immobili/72/1785523315524-1908f6a9-5223-41fc-b1e9-72534d9cae58.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523315524-1908f6a9-5223-41fc-b1e9-72534d9cae58.jpg	10	2026-07-31 18:41:57.168583
711	72	immobili/72/1785523317174-0feb1699-ac92-4101-8f8c-e3cbb1fd5b5f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523317174-0feb1699-ac92-4101-8f8c-e3cbb1fd5b5f.jpg	11	2026-07-31 18:41:58.739901
712	72	immobili/72/1785523318748-1f7e04e2-7220-43fc-b35d-66ec799150ac.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523318748-1f7e04e2-7220-43fc-b35d-66ec799150ac.jpg	12	2026-07-31 18:42:00.71019
713	72	immobili/72/1785523320717-437b8558-97b8-4bda-93de-230ebc11b86f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523320717-437b8558-97b8-4bda-93de-230ebc11b86f.jpg	13	2026-07-31 18:42:03.15816
714	72	immobili/72/1785523323165-93de47d4-4fb0-46db-b28c-63fddb232632.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523323165-93de47d4-4fb0-46db-b28c-63fddb232632.jpg	14	2026-07-31 18:42:04.817761
715	72	immobili/72/1785523324823-5d31438d-1b1d-4ff0-81bc-c465706525c2.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523324823-5d31438d-1b1d-4ff0-81bc-c465706525c2.jpg	15	2026-07-31 18:42:05.517809
716	72	immobili/72/1785523325523-f6108d6a-a7ba-46d5-81cb-83340d6aedd9.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523325523-f6108d6a-a7ba-46d5-81cb-83340d6aedd9.jpg	16	2026-07-31 18:42:06.21746
717	72	immobili/72/1785523326222-8086bf22-11f4-4ce8-b034-f1e47b2fae2e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523326222-8086bf22-11f4-4ce8-b034-f1e47b2fae2e.jpg	17	2026-07-31 18:42:06.757572
718	72	immobili/72/1785523326762-62b3c57d-ae9c-44d5-9a17-60b506d0b4fc.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523326762-62b3c57d-ae9c-44d5-9a17-60b506d0b4fc.jpg	18	2026-07-31 18:42:07.644992
719	72	immobili/72/1785523327650-f987aac3-be63-4b02-bef5-ec783efc6dbf.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/72/1785523327650-f987aac3-be63-4b02-bef5-ec783efc6dbf.jpg	19	2026-07-31 18:42:08.428935
720	73	immobili/73/1785523432111-be192a4d-8afd-4773-8178-1fec724c4380.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/73/1785523432111-be192a4d-8afd-4773-8178-1fec724c4380.jpg	0	2026-07-31 18:43:53.048648
721	73	immobili/73/1785523433065-0f505689-d307-40a5-a145-a9546b38e2e5.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/73/1785523433065-0f505689-d307-40a5-a145-a9546b38e2e5.jpg	1	2026-07-31 18:43:53.760857
722	73	immobili/73/1785523433768-4f26b9ed-e542-49c2-8718-f39ecd809071.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/73/1785523433768-4f26b9ed-e542-49c2-8718-f39ecd809071.jpg	2	2026-07-31 18:43:54.510379
723	73	immobili/73/1785523434515-35f14b34-847c-4e30-bb0c-e5fb8271a8d0.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/73/1785523434515-35f14b34-847c-4e30-bb0c-e5fb8271a8d0.jpg	3	2026-07-31 18:43:55.140125
724	73	immobili/73/1785523435144-05ee18f1-75a7-4e60-9fc5-6498b7392ffb.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/73/1785523435144-05ee18f1-75a7-4e60-9fc5-6498b7392ffb.jpg	4	2026-07-31 18:43:55.820409
725	73	immobili/73/1785523435825-4f4af50a-d26d-41d5-be6f-db104e87d0d0.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/73/1785523435825-4f4af50a-d26d-41d5-be6f-db104e87d0d0.jpg	5	2026-07-31 18:43:56.67037
726	73	immobili/73/1785523436675-4d30d78f-e33d-401a-8257-38a453073587.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/73/1785523436675-4d30d78f-e33d-401a-8257-38a453073587.jpg	6	2026-07-31 18:43:57.32007
727	73	immobili/73/1785523437325-32ffbf5d-f488-475c-95dd-c91dcff4550d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/73/1785523437325-32ffbf5d-f488-475c-95dd-c91dcff4550d.jpg	7	2026-07-31 18:43:57.980052
728	73	immobili/73/1785523437985-2d31255e-4e22-47a7-b678-d0fff45fb1cb.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/73/1785523437985-2d31255e-4e22-47a7-b678-d0fff45fb1cb.jpg	8	2026-07-31 18:43:58.560008
729	73	immobili/73/1785523438565-dd911edd-9096-4fba-b724-2c4c634f82aa.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/73/1785523438565-dd911edd-9096-4fba-b724-2c4c634f82aa.jpg	9	2026-07-31 18:43:59.544371
730	73	immobili/73/1785523439556-389e8ceb-eb6c-4697-8c66-c8077b13a2ed.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/73/1785523439556-389e8ceb-eb6c-4697-8c66-c8077b13a2ed.jpg	10	2026-07-31 18:44:00.370872
731	73	immobili/73/1785523440377-9608d584-f716-4676-9330-ffbbe9164021.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/73/1785523440377-9608d584-f716-4676-9330-ffbbe9164021.jpg	11	2026-07-31 18:44:01.167665
732	73	immobili/73/1785523441170-a9287d04-c47d-47e0-97d6-aa200fc0ca03.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/73/1785523441170-a9287d04-c47d-47e0-97d6-aa200fc0ca03.jpg	12	2026-07-31 18:44:02.069311
733	73	immobili/73/1785523442073-6419cc58-8996-46ab-8b9b-1e181c065b24.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/73/1785523442073-6419cc58-8996-46ab-8b9b-1e181c065b24.jpg	13	2026-07-31 18:44:03.219708
734	74	immobili/74/1785523579823-0cc4d4f7-d14c-466b-a50d-8ab674de3e4a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/74/1785523579823-0cc4d4f7-d14c-466b-a50d-8ab674de3e4a.jpg	0	2026-07-31 18:46:21.043909
735	74	immobili/74/1785523581072-357f45d1-e560-4042-a7e4-175c9978c236.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/74/1785523581072-357f45d1-e560-4042-a7e4-175c9978c236.jpg	1	2026-07-31 18:46:22.577792
736	74	immobili/74/1785523582581-3e3f52ca-db79-42af-835f-27cacdbc6726.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/74/1785523582581-3e3f52ca-db79-42af-835f-27cacdbc6726.jpg	2	2026-07-31 18:46:24.61896
737	74	immobili/74/1785523584623-9861e530-2040-43dc-a4a4-b8089f1ba81a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/74/1785523584623-9861e530-2040-43dc-a4a4-b8089f1ba81a.jpg	3	2026-07-31 18:46:26.863247
738	74	immobili/74/1785523586864-1715cfa5-4c3a-4939-99ad-f838a44b7d1d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/74/1785523586864-1715cfa5-4c3a-4939-99ad-f838a44b7d1d.jpg	4	2026-07-31 18:46:27.671276
739	74	immobili/74/1785523587675-210463c2-534d-42a3-b212-e92748d63d31.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/74/1785523587675-210463c2-534d-42a3-b212-e92748d63d31.jpg	5	2026-07-31 18:46:28.4292
740	74	immobili/74/1785523588436-5474733d-469e-4b7d-9542-414ef5024899.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/74/1785523588436-5474733d-469e-4b7d-9542-414ef5024899.jpg	6	2026-07-31 18:46:29.266513
741	74	immobili/74/1785523589268-77bb66f6-259c-4891-bf34-e1d4a5f0b017.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/74/1785523589268-77bb66f6-259c-4891-bf34-e1d4a5f0b017.jpg	7	2026-07-31 18:46:30.758969
742	74	immobili/74/1785523590763-ab4100ba-0cca-458d-aeed-a2effb760126.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/74/1785523590763-ab4100ba-0cca-458d-aeed-a2effb760126.jpg	8	2026-07-31 18:46:32.296656
743	74	immobili/74/1785523592299-c5e8be3a-1006-4761-a5bd-eee6f160bd97.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/74/1785523592299-c5e8be3a-1006-4761-a5bd-eee6f160bd97.jpg	9	2026-07-31 18:46:34.098959
744	75	immobili/75/1785523816142-8090589d-160d-426f-85ce-c3f929eecc98.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523816142-8090589d-160d-426f-85ce-c3f929eecc98.jpg	0	2026-07-31 18:50:17.50902
745	75	immobili/75/1785523817519-459c3272-b39c-462a-bf15-9310c797f482.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523817519-459c3272-b39c-462a-bf15-9310c797f482.jpg	1	2026-07-31 18:50:19.188345
746	75	immobili/75/1785523819198-fbef2462-a272-4149-9f7b-d9f5362d1012.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523819198-fbef2462-a272-4149-9f7b-d9f5362d1012.jpg	2	2026-07-31 18:50:20.127911
747	75	immobili/75/1785523820133-2abec6b7-855a-4e89-b158-4aaab9f84614.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523820133-2abec6b7-855a-4e89-b158-4aaab9f84614.jpg	3	2026-07-31 18:50:22.157442
748	75	immobili/75/1785523822162-ba523407-3be4-484e-80d8-cb7d58fbf9dc.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523822162-ba523407-3be4-484e-80d8-cb7d58fbf9dc.jpg	4	2026-07-31 18:50:23.418124
749	75	immobili/75/1785523823424-2395b287-1709-4d13-a67e-bf178d67e591.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523823424-2395b287-1709-4d13-a67e-bf178d67e591.jpg	5	2026-07-31 18:50:24.46532
750	75	immobili/75/1785523824469-df9fd354-89fc-4523-8918-15b2d7b270f3.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523824469-df9fd354-89fc-4523-8918-15b2d7b270f3.jpg	6	2026-07-31 18:50:25.27704
751	75	immobili/75/1785523825282-26d2ef50-071e-4d45-a08b-5a1e9080ba87.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523825282-26d2ef50-071e-4d45-a08b-5a1e9080ba87.jpg	7	2026-07-31 18:50:26.076988
752	75	immobili/75/1785523826081-38add6f1-804b-45ae-8fa3-527d88f21086.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523826081-38add6f1-804b-45ae-8fa3-527d88f21086.jpg	8	2026-07-31 18:50:26.856627
753	75	immobili/75/1785523826862-f0a55e95-ce50-4477-b347-0ca51ad748de.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523826862-f0a55e95-ce50-4477-b347-0ca51ad748de.jpg	9	2026-07-31 18:50:27.457391
754	75	immobili/75/1785523827463-337d71c9-8259-4b18-85fa-d9aaee72569f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523827463-337d71c9-8259-4b18-85fa-d9aaee72569f.jpg	10	2026-07-31 18:50:28.127071
755	75	immobili/75/1785523828131-2c945944-ea5e-4479-8742-2d4631ead6e2.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523828131-2c945944-ea5e-4479-8742-2d4631ead6e2.jpg	11	2026-07-31 18:50:28.969748
756	75	immobili/75/1785523828979-5c7d5023-2a04-4af9-8e5b-218cdbfef4b2.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523828979-5c7d5023-2a04-4af9-8e5b-218cdbfef4b2.jpg	12	2026-07-31 18:50:29.944957
757	75	immobili/75/1785523829950-c1ddd41f-f3a7-4be7-a372-c2fd782d12be.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523829950-c1ddd41f-f3a7-4be7-a372-c2fd782d12be.jpg	13	2026-07-31 18:50:30.717047
758	75	immobili/75/1785523830722-68ffe4ea-8511-418a-803e-d32e88c75e52.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523830722-68ffe4ea-8511-418a-803e-d32e88c75e52.jpg	14	2026-07-31 18:50:31.484005
759	75	immobili/75/1785523831490-92ab744a-bb96-4d7c-ac6c-fdf3f556bdf1.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523831490-92ab744a-bb96-4d7c-ac6c-fdf3f556bdf1.jpg	15	2026-07-31 18:50:32.216742
760	75	immobili/75/1785523832220-ce0dc366-dd6a-4b39-bfa7-c40150f9bb49.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523832220-ce0dc366-dd6a-4b39-bfa7-c40150f9bb49.jpg	16	2026-07-31 18:50:32.997324
761	75	immobili/75/1785523833001-65b6c6fe-6a4f-44c6-aba7-5abe00f5f584.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523833001-65b6c6fe-6a4f-44c6-aba7-5abe00f5f584.jpg	17	2026-07-31 18:50:34.551459
762	75	immobili/75/1785523834556-e62e8ef5-f0cd-4621-8cbf-20ed0616330f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/75/1785523834556-e62e8ef5-f0cd-4621-8cbf-20ed0616330f.jpg	18	2026-07-31 18:50:35.709059
763	76	immobili/76/1785523938280-06ab96a5-c37b-4c32-97de-b8738f75871a.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/76/1785523938280-06ab96a5-c37b-4c32-97de-b8738f75871a.jpg	0	2026-07-31 18:52:21.318374
764	76	immobili/76/1785523941331-be9140aa-2fa9-43a4-82c5-99b53bf8afe6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/76/1785523941331-be9140aa-2fa9-43a4-82c5-99b53bf8afe6.jpg	1	2026-07-31 18:52:22.695095
765	76	immobili/76/1785523942700-8c7486af-67cc-4ad2-ba58-91092a405183.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/76/1785523942700-8c7486af-67cc-4ad2-ba58-91092a405183.jpg	2	2026-07-31 18:52:24.374792
766	76	immobili/76/1785523944379-6bd82f79-f66b-4c2c-8e89-b97a12dce4a7.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/76/1785523944379-6bd82f79-f66b-4c2c-8e89-b97a12dce4a7.jpg	3	2026-07-31 18:52:25.864681
767	76	immobili/76/1785523945870-9fd2ebb3-c30f-4a40-b441-d9eaffe3f355.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/76/1785523945870-9fd2ebb3-c30f-4a40-b441-d9eaffe3f355.jpg	4	2026-07-31 18:52:26.884785
768	76	immobili/76/1785523946889-317e7da9-6882-44f1-ac3b-209b22afbd9f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/76/1785523946889-317e7da9-6882-44f1-ac3b-209b22afbd9f.jpg	5	2026-07-31 18:52:27.923891
769	76	immobili/76/1785523947927-ce337b50-b8ee-47ad-9eb7-b5259ec3e595.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/76/1785523947927-ce337b50-b8ee-47ad-9eb7-b5259ec3e595.jpg	6	2026-07-31 18:52:28.696363
770	76	immobili/76/1785523948702-bd61dfc0-2a87-42e8-8302-0408ed7e3db9.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/76/1785523948702-bd61dfc0-2a87-42e8-8302-0408ed7e3db9.jpg	7	2026-07-31 18:52:29.986607
771	76	immobili/76/1785523949992-96b19f42-6ad4-4f12-a239-d0a37cdb5e8b.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/76/1785523949992-96b19f42-6ad4-4f12-a239-d0a37cdb5e8b.jpg	8	2026-07-31 18:52:32.474907
772	76	immobili/76/1785523952479-036c7806-af29-44f8-a396-ffb2eca474b4.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/76/1785523952479-036c7806-af29-44f8-a396-ffb2eca474b4.jpg	9	2026-07-31 18:52:34.957784
773	76	immobili/76/1785523954963-8864bedb-5b20-48dc-8177-d2c58bd4a7f7.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/76/1785523954963-8864bedb-5b20-48dc-8177-d2c58bd4a7f7.jpg	10	2026-07-31 18:52:36.674953
774	76	immobili/76/1785523956679-45051633-736d-45d5-b1b6-8158aae9e094.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/76/1785523956679-45051633-736d-45d5-b1b6-8158aae9e094.jpg	11	2026-07-31 18:52:38.546817
775	76	immobili/76/1785523958555-5a6e5b3c-37ad-41bd-9500-fc282fad3973.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/76/1785523958555-5a6e5b3c-37ad-41bd-9500-fc282fad3973.jpg	12	2026-07-31 18:52:40.014526
776	76	immobili/76/1785523960019-4165697f-0387-4b15-804a-11dd75aae612.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/76/1785523960019-4165697f-0387-4b15-804a-11dd75aae612.jpg	13	2026-07-31 18:52:42.253426
777	77	immobili/77/1785524081433-b32d1b06-fd3b-4ae8-932a-c0f49563a3b2.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/77/1785524081433-b32d1b06-fd3b-4ae8-932a-c0f49563a3b2.jpg	0	2026-07-31 18:54:42.531386
778	77	immobili/77/1785524082563-57681257-ad7e-4f81-a889-851df44a705f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/77/1785524082563-57681257-ad7e-4f81-a889-851df44a705f.jpg	1	2026-07-31 18:54:44.435033
779	77	immobili/77/1785524084440-f7395f71-2165-4b0f-8970-369c7e16cd12.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/77/1785524084440-f7395f71-2165-4b0f-8970-369c7e16cd12.jpg	2	2026-07-31 18:54:45.304619
780	77	immobili/77/1785524085310-a23c4864-0873-43cd-b49d-35ff6ee40d8c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/77/1785524085310-a23c4864-0873-43cd-b49d-35ff6ee40d8c.jpg	3	2026-07-31 18:54:46.014867
781	77	immobili/77/1785524086019-6083111c-1f8e-4172-9ffb-1b72e37f4ae1.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/77/1785524086019-6083111c-1f8e-4172-9ffb-1b72e37f4ae1.jpg	4	2026-07-31 18:54:46.875213
782	77	immobili/77/1785524086880-75cec4e0-85fc-4747-927d-38325489e730.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/77/1785524086880-75cec4e0-85fc-4747-927d-38325489e730.jpg	5	2026-07-31 18:54:47.912316
783	77	immobili/77/1785524087932-c6eef3a2-82b4-4b56-b998-3b2ae3960aa6.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/77/1785524087932-c6eef3a2-82b4-4b56-b998-3b2ae3960aa6.jpg	6	2026-07-31 18:54:48.699958
784	77	immobili/77/1785524088704-973089eb-83bf-4f9b-862f-149aa43c434e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/77/1785524088704-973089eb-83bf-4f9b-862f-149aa43c434e.jpg	7	2026-07-31 18:54:49.669906
785	77	immobili/77/1785524089674-a0505fc6-6284-482a-9c20-80a2f496f5fa.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/77/1785524089674-a0505fc6-6284-482a-9c20-80a2f496f5fa.jpg	8	2026-07-31 18:54:50.53974
786	77	immobili/77/1785524090544-c1d05603-b710-468c-b5a7-4b5a45bacef2.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/77/1785524090544-c1d05603-b710-468c-b5a7-4b5a45bacef2.jpg	9	2026-07-31 18:54:51.449423
787	77	immobili/77/1785524091455-7df9cae8-4391-4b8d-899f-aee2767d4b75.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/77/1785524091455-7df9cae8-4391-4b8d-899f-aee2767d4b75.jpg	10	2026-07-31 18:54:52.299754
788	77	immobili/77/1785524092304-b6e82892-676c-46ca-999f-e640800bed39.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/77/1785524092304-b6e82892-676c-46ca-999f-e640800bed39.jpg	11	2026-07-31 18:54:53.160284
789	77	immobili/77/1785524093172-f2a827f3-e1a3-4cca-8754-fc26a7e2c7aa.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/77/1785524093172-f2a827f3-e1a3-4cca-8754-fc26a7e2c7aa.jpg	12	2026-07-31 18:54:53.89999
790	79	immobili/79/1785524300805-90d4b4eb-7f89-4e13-9872-6a8b6babc121.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/79/1785524300805-90d4b4eb-7f89-4e13-9872-6a8b6babc121.jpg	0	2026-07-31 18:58:21.690783
791	79	immobili/79/1785524301708-dd22579b-85a1-424e-847e-5201232f32ec.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/79/1785524301708-dd22579b-85a1-424e-847e-5201232f32ec.jpg	1	2026-07-31 18:58:22.647397
792	79	immobili/79/1785524302658-1339b5c8-daf5-4e82-9195-1d9cbfabef76.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/79/1785524302658-1339b5c8-daf5-4e82-9195-1d9cbfabef76.jpg	2	2026-07-31 18:58:23.655109
793	79	immobili/79/1785524303662-8cce1722-2f25-42d1-8b26-8b3fc245d3b7.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/79/1785524303662-8cce1722-2f25-42d1-8b26-8b3fc245d3b7.jpg	3	2026-07-31 18:58:24.614283
794	79	immobili/79/1785524304619-a0911a41-9bb4-4800-86d2-29414d8a2190.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/79/1785524304619-a0911a41-9bb4-4800-86d2-29414d8a2190.jpg	4	2026-07-31 18:58:25.583266
795	79	immobili/79/1785524305588-5e71a7ac-69a1-407b-b4f4-a3ae6ef3300f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/79/1785524305588-5e71a7ac-69a1-407b-b4f4-a3ae6ef3300f.jpg	5	2026-07-31 18:58:26.333314
796	79	immobili/79/1785524306339-e41f33d7-5be0-4cf5-b5b3-bd11d9297915.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/79/1785524306339-e41f33d7-5be0-4cf5-b5b3-bd11d9297915.jpg	6	2026-07-31 18:58:27.314612
797	79	immobili/79/1785524307320-0de8c537-420b-4b05-bd8e-ee18d2e10a37.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/79/1785524307320-0de8c537-420b-4b05-bd8e-ee18d2e10a37.jpg	7	2026-07-31 18:58:28.906114
798	80	immobili/80/1785524410658-730a8c48-5945-4fe1-9030-450e5ec5ecd8.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/80/1785524410658-730a8c48-5945-4fe1-9030-450e5ec5ecd8.jpg	0	2026-07-31 19:00:11.835793
799	80	immobili/80/1785524411840-48116f29-06e5-46ea-94cb-1c3daf30639c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/80/1785524411840-48116f29-06e5-46ea-94cb-1c3daf30639c.jpg	1	2026-07-31 19:00:13.002875
800	80	immobili/80/1785524413009-83fa7fc6-19c2-4266-816d-260e27156d21.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/80/1785524413009-83fa7fc6-19c2-4266-816d-260e27156d21.jpg	2	2026-07-31 19:00:14.38141
801	81	immobili/81/1785524541011-b2a5d3af-962b-4bc5-88d1-4386514078ba.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/81/1785524541011-b2a5d3af-962b-4bc5-88d1-4386514078ba.jpg	0	2026-07-31 19:02:21.71287
802	81	immobili/81/1785524541718-e09e944a-584f-49b0-9fd6-e1c508487070.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/81/1785524541718-e09e944a-584f-49b0-9fd6-e1c508487070.jpg	1	2026-07-31 19:02:22.650648
803	81	immobili/81/1785524542677-2fd52b0a-73dc-4b1d-a8b0-fdc7e1c6de4d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/81/1785524542677-2fd52b0a-73dc-4b1d-a8b0-fdc7e1c6de4d.jpg	2	2026-07-31 19:02:23.602076
804	81	immobili/81/1785524543607-f5b2f7f5-5c46-4600-a5d7-a9b5ba0ff03c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/81/1785524543607-f5b2f7f5-5c46-4600-a5d7-a9b5ba0ff03c.jpg	3	2026-07-31 19:02:24.586651
805	81	immobili/81/1785524544633-24bb5883-f5b5-43e6-a6e7-9cabad531aa3.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/81/1785524544633-24bb5883-f5b5-43e6-a6e7-9cabad531aa3.jpg	4	2026-07-31 19:02:25.738847
806	81	immobili/81/1785524545743-b1d933d6-11c6-4522-bf38-9f7ee5ca535f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/81/1785524545743-b1d933d6-11c6-4522-bf38-9f7ee5ca535f.jpg	5	2026-07-31 19:02:27.901119
807	81	immobili/81/1785524547904-c32e109d-8a70-40ee-8e47-b7e1987ec641.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/81/1785524547904-c32e109d-8a70-40ee-8e47-b7e1987ec641.jpg	6	2026-07-31 19:02:28.719221
808	81	immobili/81/1785524548731-ed6819fe-dbda-4d67-88d7-4fedd3d40419.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/81/1785524548731-ed6819fe-dbda-4d67-88d7-4fedd3d40419.jpg	7	2026-07-31 19:02:29.52586
809	82	immobili/82/1785524625156-cf819999-85dd-4874-94c5-0367119804d0.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/82/1785524625156-cf819999-85dd-4874-94c5-0367119804d0.jpg	0	2026-07-31 19:03:48.227602
810	82	immobili/82/1785524628239-20300702-ca47-4e96-8a5e-6b4fc8d54d51.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/82/1785524628239-20300702-ca47-4e96-8a5e-6b4fc8d54d51.jpg	1	2026-07-31 19:03:49.850974
811	82	immobili/82/1785524629856-09354190-5237-44d8-a8d4-d2f207fb7473.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/82/1785524629856-09354190-5237-44d8-a8d4-d2f207fb7473.jpg	2	2026-07-31 19:03:50.899592
812	82	immobili/82/1785524630902-f7db9eeb-ecd0-43d9-90fc-427c389e23c5.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/82/1785524630902-f7db9eeb-ecd0-43d9-90fc-427c389e23c5.jpg	3	2026-07-31 19:03:51.890295
813	82	immobili/82/1785524631895-403f7fbf-f5e5-4f03-bded-953aac7746ea.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/82/1785524631895-403f7fbf-f5e5-4f03-bded-953aac7746ea.jpg	4	2026-07-31 19:03:52.649869
814	82	immobili/82/1785524632653-c2ce2bb4-917f-4bc6-aa80-8335c8c5c5bf.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/82/1785524632653-c2ce2bb4-917f-4bc6-aa80-8335c8c5c5bf.jpg	5	2026-07-31 19:03:53.120106
815	82	immobili/82/1785524633125-75db11c2-36d0-403d-bdf6-dcac6192fb8b.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/82/1785524633125-75db11c2-36d0-403d-bdf6-dcac6192fb8b.jpg	6	2026-07-31 19:03:53.540941
816	82	immobili/82/1785524633547-94e3f4ae-e116-4eb3-abf1-b504c5dfa58d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/82/1785524633547-94e3f4ae-e116-4eb3-abf1-b504c5dfa58d.jpg	7	2026-07-31 19:03:53.970435
817	83	immobili/83/1785524762915-a571843f-6dc6-4e0c-b805-d664a795aaa9.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/83/1785524762915-a571843f-6dc6-4e0c-b805-d664a795aaa9.jpg	0	2026-07-31 19:06:03.634357
818	83	immobili/83/1785524763643-218952cc-7c7c-4a71-8c53-27cb42c432b5.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/83/1785524763643-218952cc-7c7c-4a71-8c53-27cb42c432b5.jpg	1	2026-07-31 19:06:05.451719
819	83	immobili/83/1785524765469-9a01e394-2450-4b64-a7d5-ee687af0048e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/83/1785524765469-9a01e394-2450-4b64-a7d5-ee687af0048e.jpg	2	2026-07-31 19:06:06.660122
820	83	immobili/83/1785524766665-0be32008-3471-48b1-95dd-0ae3ae8aa79f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/83/1785524766665-0be32008-3471-48b1-95dd-0ae3ae8aa79f.jpg	3	2026-07-31 19:06:07.490036
821	83	immobili/83/1785524767494-c55dacf0-25c4-43e6-95fc-92ed65f1fca0.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/83/1785524767494-c55dacf0-25c4-43e6-95fc-92ed65f1fca0.jpg	4	2026-07-31 19:06:08.610034
822	83	immobili/83/1785524768613-34d166a2-8db6-4cdb-bacc-40b1a154768d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/83/1785524768613-34d166a2-8db6-4cdb-bacc-40b1a154768d.jpg	5	2026-07-31 19:06:09.399376
823	83	immobili/83/1785524769403-459daf3d-7522-4031-a8fa-e55e7e7a8a56.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/83/1785524769403-459daf3d-7522-4031-a8fa-e55e7e7a8a56.jpg	6	2026-07-31 19:06:10.491713
824	83	immobili/83/1785524770496-9eb11a33-58c6-49b0-8601-d0e7fa8f56a0.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/83/1785524770496-9eb11a33-58c6-49b0-8601-d0e7fa8f56a0.jpg	7	2026-07-31 19:06:11.380928
825	83	immobili/83/1785524771384-508c3bf8-b98b-41b4-9ff0-1d8f6958242e.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/83/1785524771384-508c3bf8-b98b-41b4-9ff0-1d8f6958242e.jpg	8	2026-07-31 19:06:12.349883
826	83	immobili/83/1785524772354-c5330d90-4957-41d0-b609-fd4a8d9ac7da.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/83/1785524772354-c5330d90-4957-41d0-b609-fd4a8d9ac7da.jpg	9	2026-07-31 19:06:13.289964
827	83	immobili/83/1785524773294-90f7a47e-0e03-42c5-9c09-88f1ae13157c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/83/1785524773294-90f7a47e-0e03-42c5-9c09-88f1ae13157c.jpg	10	2026-07-31 19:06:14.059814
828	83	immobili/83/1785524774064-e45641b2-d76a-4f2d-92a6-8836a155d669.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/83/1785524774064-e45641b2-d76a-4f2d-92a6-8836a155d669.jpg	11	2026-07-31 19:06:15.011809
829	83	immobili/83/1785524775017-44db94bb-21b5-44b4-b121-6029c2e6414d.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/83/1785524775017-44db94bb-21b5-44b4-b121-6029c2e6414d.jpg	12	2026-07-31 19:06:15.917647
830	84	immobili/84/1785524913749-8a37e07a-6d1e-47ba-b312-7f084f629531.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/84/1785524913749-8a37e07a-6d1e-47ba-b312-7f084f629531.jpg	0	2026-07-31 19:08:35.070599
831	84	immobili/84/1785524915123-c5effa57-2d30-4e90-b5ca-4b9f79fd239c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/84/1785524915123-c5effa57-2d30-4e90-b5ca-4b9f79fd239c.jpg	1	2026-07-31 19:08:35.869426
832	84	immobili/84/1785524915874-713c00ba-0356-4f2b-9266-4444c5e6930c.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/84/1785524915874-713c00ba-0356-4f2b-9266-4444c5e6930c.jpg	2	2026-07-31 19:08:36.629337
833	84	immobili/84/1785524916636-e733ca98-c1ee-42fc-a17e-0273489c47af.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/84/1785524916636-e733ca98-c1ee-42fc-a17e-0273489c47af.jpg	3	2026-07-31 19:08:37.426951
834	84	immobili/84/1785524917431-f43e71a3-d3b0-4db6-b091-d1bcb1bd3c5f.jpg	https://pub-37c7fcaa3c6949a297c872ab66cb7d53.r2.dev/immobili/84/1785524917431-f43e71a3-d3b0-4db6-b091-d1bcb1bd3c5f.jpg	4	2026-07-31 19:08:38.219389
\.


--
-- Data for Name: immobili; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.immobili (id, titolo, descrizione, prezzo, citta, provincia, via, numero_civico, tipo, superficie_mq, numero_locali, numero_bagni, piano, ascensore, riscaldamento, stato, user_id, creato_il, aggiornato_il, pannelli_solari, terrazza, riscaldamento_pavimento, giardino, piscina, impianto_allarme, aria_condizionata, vista_panoramica, ripostiglio, termoautonomo, porta_blindata, cappotto, cortile_privato, ubicazione, destinazione, camere_da_letto, garage, note_private, codice_riferimento) FROM stdin;
42	id. 1807 Piadena	Vendesi porzione di villa trifamiliare a Piadena (CR)\n\nIn tranquilla zona residenziale e ben servita, proponiamo graziosa porzione di trifamiliare con ingresso indipendente e giardino privato di 200 mq, ideale per chi desidera comfort, privacy e spazi esterni da vivere.\n\nl' abitazione si sviluppa con ambienti accoglienti e ben distribuiti: Una spaziosa cucina abitabile, un grazioso soggiorno, due camere da letto di cui una matrimoniale e una doppia con accesso al terrazzo e un comodo bagno finestrato.\n\nA completare la proprietà troviamo un box auto di generose dimensioni, dove è stata attrezzata una piccola lavanderia con doccia e lavello, oltre a un terreno di proprietà di circa 200mq situato di fronte all' ingresso carraio, ideale come spazio ricreativo o come orto privato.\n\nsoluzione interessante per famiglie, coppie o per chi cerca indipendenza senza rinunciare alla comodità dei servizi.	189000.00	Piadena	CR			VILLETTA	95	3	1	\N	f		DISPONIBILE	1	2026-07-30 13:31:55.797764	2026-07-30 13:31:55.797777	f	t	f	t	f	f	t	f	t	t	t	f	f	FUORI_CITTA	VENDITA	2	f	\N	1807
43	id. 1806 Via Botti 	In Cremona, in zona via Giuseppina, vendesi villetta unifamiliare libera su 4 lati e circondata da circa mq. 200 di giardino di proprietà. La Villetta presenta attualmente un cappotto esterno di circa 14 cm in grafite, serramenti in alluminio con doppio vetro. L'abitazione posta su 2 livelli è a rustico, e composta al piano rialzato da ingresso, ampio soggiorno con angolo cottura, 2 camere da letto matrimoniali, disimpegno, bagno con nicchia per lavatrice ed asciugatrice. Il piano seminterrato, accessibile da scala interna o indipendentemente, è composto da taverna di circa mq. 50 calpestabili. Un garage esterno di circa mq. 20 completa questa interessante soluzione indipendente. Possibilità di avere la villetta "chiavi in mano" scegliendo tra l'ampio capitolato proposto e raggiungendo la classe Energetica "A3". Possibilità detrazioni fiscali. Predisposizione impianto allarme e fotovoltaico.\n\nRichiesta allo stato attuale €. 250.000	250000.00	Cremona	CR	via botti		VILLETTA	128	5	2	\N	f		DISPONIBILE	1	2026-07-30 13:51:51.353305	2026-07-30 13:51:51.353325	f	t	f	t	f	f	t	f	t	f	f	t	f	PERIFERIA	VENDITA	3	t	\N	1806
37	id. 1813  via pippia	Vendesi grazioso ampio bilocale di circa mq. 76 commerciali posto al secondo ed ultimo piano di tipica corte cremonese con ballatoio. L’ appartamento, pronto da abitare, è composto da ingresso, luminoso soggiorno con cucina attrezzata, disimpegno, spazioso bagno, camera da letto e cantina al piano seminterrato. Riscaldamento autonomo, aria condizionata, serramenti in legno con doppio vetro.\nRichiesta € 115.000\nIl mondo immobiliare – Viale Trento Trieste 120	115000.00	Cremona	CR	via pippia, Cremona		BILOCALE,APPARTAMENTO	76	2	1	2	f		DISPONIBILE	1	2026-07-29 00:12:55.474641	2026-07-30 14:28:39.459183	f	f	f	f	f	f	t	f	t	t	t	f	f	SEMI_CENTRALE	VENDITA	1	f		1813
38	id. 1812 via Orti Romani 	Bilocale posto al primo piano servito da ascensore di contesto ben abitato e ordinato. L' appartamento è composto da ingresso, soggiorno, cucinotto, balcone, bagno, ripostiglio, camera da letto e cantina al piano interrato. Ristrutturato nel 2025 è ideale per coppia single o investimento. Serramenti in pvc con doppio vetro, zanzariere, cucina arredata e armadi su misura. Richiesta € 120.000,00	120000.00	Cremona	CR	via orti romani, cremona		BILOCALE,APPARTAMENTO	75	2	1	1	t		DISPONIBILE	1	2026-07-29 00:18:42.744433	2026-07-30 14:29:10.081486	f	f	f	f	f	f	t	f	t	f	t	f	f	SEMI_CENTRALE	VENDITA	1	f	\N	1812
44	zona via Aselli id.1805	Vendesi in centro  a Cremona  ampio e luminoso  magazzino  di mq 245  con doppio accesso, bagno e altezza interna di m. 7 situato al piano terra.L' immobile, è in buono stato d'uso, dispone di ampi portoni/accessi, ed è  fornito di impianti di riscaldmento, possibilità di trasformazione in appartamento su due livelli o di realizzare un grande garage contenente 7 posti auto. Richiesta €. 160.000,00.	160000.00	Cremona	CR	via aselli		MAGAZZINO_CAPANNONE,LABORATORIO	245	6	1	\N	f		DISPONIBILE	1	2026-07-30 14:46:26.366179	2026-07-30 14:46:26.366193	f	f	f	f	f	f	f	f	t	t	f	f	f	CENTRALE	VENDITA	\N	t	\N	1805
46	Seniga id. 1804		250000.00	seniga	BS	Seniga		APPARTAMENTO,CASA_INDIPENDENTE,FABBRICATO,CASCINA,MANSARDA,RUSTICO,VILLA	400	12	4	\N	f		DISPONIBILE	1	2026-07-30 14:55:10.365224	2026-07-30 14:55:10.365237	t	f	f	t	f	f	t	f	t	t	t	f	t	FUORI_CITTA	VENDITA	5	f	\N	1804
49	id. 1801 Bagnara	Vendesi appartamento posto al secondo piano di contesto tranquillo ed ordinato servito da ascensore. Il trilocale di circa mq. 80 è in buono stato d'uso ed attualmente formato da: ingresso, soggiorno con angolo cottura, balcone, ampio disimpegno, 2 camere da letto, bagno, cantina, garage e posto auto. Giardinetto condominiale, riscaldamento autonomo, predisposizione aria condizionata, zanzariere e serramenti in legno con doppio vetro. Classe energetica E.\n\nRichiesta € 119.000	119000.00	Bagnara	CR	Bagnara		APPARTAMENTO	80	3	1	\N	t		DISPONIBILE	1	2026-07-31 15:22:10.661963	2026-07-31 15:22:10.661974	f	f	f	f	f	f	t	f	f	t	t	f	f	PERIFERIA	VENDITA	\N	t	\N	1801
50	id. 1800 Via Battaglione	In Cremona, in fregio alla via Battaglione, casa indipendente di circa mq. 160 pronta da abitare posta su due livelli (piano terra e primo), con locali accessori (cantina e lavanderia) al piano interrato e garage pertinenziale di mq. 23. L’unità immobiliare è attualmente composta da: ingresso, soggiorno di circa mq. 50 con camino ( a norma di legge), cucina abitabile, bagno, balcone. Al piano superiore, collegato con comoda scala, troviamo 3 camere da letto, doppi servizi, disimpegno e ripostiglio. Impianto fotovoltaico, predisposizione impianto allarme, fibra ottica, giardino condominiale. Richiesta € 242.000	242000.00	Cremona	CR	Via battaglione		APPARTAMENTO,CASA_INDIPENDENTE,VILLETTA	160	6	3	\N	f		DISPONIBILE	1	2026-07-31 15:24:24.236763	2026-07-31 15:24:24.236771	t	f	f	f	f	t	t	f	t	t	t	f	f	PERIFERIA	VENDITA	3	f	\N	1800
51	id. 1798 Via Commenda di Malta	Vendesi appartamento di circa mq. 150 di villa bifamiliare libera su 4 lati. L'ampio quadrilocale è pronto da abitare e dotato di riscaldamento autonomo. Attualmente composto da ingresso, grande soggiorno, cucina abitabile, 2 camere da letto matrimoniali, doppi servizi, 2 balconi, disimpegno. Al piano seminterrato, troviamo circa mq. 100 di locali accessori, comprendenti taverna, cantina, e garage. Area cortilizia e giardino comune. Nessuna spesa condominiale.\nRichiesta €. 198.000\nIl mondo immobiliare Viale Trento e Trieste 120, Cremona.	198000.00	Cremona	CR	Via Commenda di Malta		APPARTAMENTO	148	4	2	\N	f		DISPONIBILE	1	2026-07-31 15:27:02.911503	2026-07-31 15:27:02.911513	f	t	f	t	f	f	f	f	t	t	t	f	f	SEMI_CENTRALE	VENDITA	\N	t	\N	1798
52	id. 1797 Via Massarotti	In ordinato e ben abitato contesto, vendesi appartamento pronto da abitare di circa mq. 95 posto al 2° piano servito da ascensore.\nIl trilocale è attualmente composta da ingresso, cucina abitabile, soggiorno, disimpegno, spazioso bagno, 2 camere da letto, ripostiglio, 2 balconi, cantina e garage. Serramenti in alluminio con doppio vetro, portoncino blindato, aria condizionata. Riscaldamento centralizzato con termovalvole.\nRichiesta €. 118.000, ape in elaborazione\nIl Mondo Immobiliare – Viale Trento e Trieste 120, Cremona	118000.00	Cremona	CR			APPARTAMENTO	95	3	1	\N	t		DISPONIBILE	1	2026-07-31 15:29:38.306947	2026-07-31 15:29:38.306966	f	f	f	f	f	f	f	f	t	t	t	f	f	SEMI_CENTRALE	VENDITA	\N	t	\N	1797
40	id. 1810 Viale Trento e Trieste	Negozio di circa mq. 50 commerciali con occhio di vetrina. Posizione di ottimo passaggio e visibilità. Riscaldamento autonomo, nessuna spesa condominiale. Classe F. Richiesta euro 550 mensili.	550.00	Cremona	CR	viale trento e trieste		NEGOZIO	50	3	\N	\N	f		DISPONIBILE	1	2026-07-29 21:50:13.03605	2026-07-30 12:10:16.769823	f	f	f	f	f	f	f	f	t	t	f	f	f	SEMI_CENTRALE	AFFITTO	\N	f	\N	1810
47	id. 1803 Corso Garibaldi	Cremona, Corso Garibaldi - Unico nel suo genere, vendesi appartamento di circa mq 175 commerciali, posto al 1° e penultimo piano di contesto nobiliare con splendido giardino e alberi secolari. Abitazione classica con meravigliosi affacci, ampie metrature, ariose stanze che la caratterizzano e doppi servizi finestrati. Il tutto accessoriato da locale deposito e posto auto coperto. Imperdibile! Richiesta €. 280.000. Ape in elaborazione\n\nUlteriori informazioni in ufficio - Il mondo immobiliare 0372 32397 - Viale Trento e Trieste 120, Cremona	280000.00	Cremona	CR	corso garibaldi		APPARTAMENTO	175	4	2	\N	f		DISPONIBILE	1	2026-07-31 15:04:31.154419	2026-07-31 15:27:17.221319	f	f	f	t	f	f	f	f	t	t	t	f	f	CENTRALE	VENDITA	2	f	\N	1803
53	id. 1796 Via Manzoni	Cremona - Via Manzoni. In recente e ben abitato contesto condominiale, Vendesi Unità immobiliare attualmente a rustico (f3) di circa mq. 170 commerciali posti tra piano terra, interrato e ammezzato collegabili tra loro e con doppio accesso. Possibilità di ottenere sia un locale commerciale (con 6 vetrine) sia una o più unità abitative. Serramenti con doppio vetro, portoncini blindati. Richiesta 130.000. Ape in elaborazione.	130000.00	Cremona	CR	Via Manzoni		APPARTAMENTO,NEGOZIO,RUSTICO	170	4	2	\N	t		DISPONIBILE	1	2026-07-31 15:34:05.897765	2026-07-31 15:34:05.897786	f	f	f	f	f	f	f	f	t	f	t	f	f	CENTRALE	VENDITA	\N	f	\N	1796
54	id. 1795 Via Geromini	In meraviglioso storico contesto del XVI secolo, a due passi dalla piazza principale di Cremona, vendesi al piano terra, appartamento di circa 150 mq commerciali con splendide finiture attualmente composto da ingresso, ampio soggiorno con piccolo cortiletto di proprietà, cucina abitabile, 2 camere da letto matrimoniali, disimpegno, 2 bagni, studio e lavanderia al piano superiore, collegati con scala a vista. Comodo garage pertinenziale e cantina al piano interrato raggiungibili con comodo ascensore. Soffitti a volta e in legno, riscaldamento e raffrescamento autonomo, detrazioni fiscali, classe energetica B.\n\nRichiesta €. 465.000\n\n#cremona #vendesi #appartamento #contestostorico #palazzostorico #dimorastorica #isolamentotermico #isolamentoacustico #classeb	465000.00	Cremona	CR	Via Geromini		APPARTAMENTO	150	4	2	\N	t		DISPONIBILE	1	2026-07-31 15:36:55.547829	2026-07-31 15:36:55.547847	f	t	f	f	f	f	f	f	t	t	t	f	t	CENTRALE	VENDITA	\N	t	\N	1795
41	id. 1808 zona Battaglione	Vendesi casa indipendente pronta da abitare composta al piano terra da: ingresso, lavanderia, comodo garage, giardino  retrostante e area cortilizia, il  primo piano è formato da un   luminoso soggiorno con stufa a pellet, cucina abitabile con balcone, 2 bagni e 2 camere da letto di cui una con cabina armadio e balcone; all' ultimo piano troviamo un ulteriore  spaziosa camera da letto con terrazzo. Classe E. Aria condizionata\n\nRichiesta € 210.000	210000.00	Cremona	CR	zona battiglione		VILLA	140	4	2	0	f		DISPONIBILE	1	2026-07-29 23:37:36.278164	2026-07-30 12:10:24.985552	f	t	f	f	f	f	t	f	t	t	t	f	t	PERIFERIA	VENDITA	2	f	\N	1808
39	id. 1811 Piazza Risorgimento 	Nel cuore di Cremona, nella centralissima e rinomata Piazza Risorgimento, proponiamo in vendita un’opportunità immobiliare di rara reperibilità, ideale per chi desidera una residenza di alta rappresentanza, ampi spazi e massima personalizzazione.\n\nLa proprietà è costituita da due unità trilocali adiacenti (rispettivamente di 100 mq e 125 mq), vendute esclusivamente in blocco unico. Il vero punto di forza di questa proposta risiede nella predisposizione ottimale alla fusione dei due appartamenti, offrendo la possibilità di dare vita a un’unica, sontuosa abitazione padronale di 225 mq complessivi.\n\nGli ambienti, caratterizzati da un'eccellente luminosità naturale e da una distribuzione funzionale, si prestano a un progetto di unificazione capace di coniugare ampie zone giorno, camere da letto padronali con servizi dedicati e studi privati, adattandosi perfettamente alle esigenze di famiglie numerose o di professionisti che ricercano uno spazio abitativo esclusivo in centro città.\n\nL’immobile è inserito in un contesto signorile, dotato di doppio impianto di sollevamento (ascensore e montacarichi), che garantisce massima accessibilità e comfort logistico.\n\nA completare il valore della proprietà:\n\nUna piacevole terrazza di 40mq circa, uno sfogo esterno ideale per godersi il tempo libero nel cuore della città.\nUn box auto privato incluso nella compravendita, un plus fondamentale e introvabile in una zona così centrale.\nNota: La vendita avviene tassativamente in forma congiunta e in blocco unico. Non verranno prese in considerazione proposte di acquisto per le singole unità frazionate.\n\nScheda Tecnica dell'Immobile\n\nUbicazione: Cremona, Piazza Risorgimento\nSuperficie Complessiva: 225 mq (attualmente distribuiti in due unità adiacenti di 100 mq e 125 mq)\nPotenziale: Perfetto per fusione in un'unica grande abitazione di prestigio\nServizi dello stabile: Ascensore e Montacarichi\nSpazi esterni: Terrazza di 40mq circa\nPertinenze: Box auto incluso nella compravendita\nModalità di transazione: Vendita esclusivamente in blocco unico	209000.00	Cremona	CR	piazza risorgimento	8	BILOCALE	225	6	2	3	f		DISPONIBILE	1	2026-07-29 00:23:12.919503	2026-07-31 14:52:52.849641	f	f	f	f	f	f	f	f	f	f	f	f	f	CENTRALE	VENDITA	4	f	\N	1811
48	id. 1802 Corso XX Settembre	In Storico Contesto, appartamento di circa mq. 140 di completa ristrutturazione con finiture di alta qualità.\nIl quadrilocale, posto al 1° e penultimo piano di comoda ed ampia scala, è composto da ingresso con bella vetrata sul cortiletto interno, grande e luminoso soggiorno con cucina di circa mq. 36, 3 camere da letto, doppi servizi completi ed entrambi finestrati, disimpegno, ampio balcone, cantina. Riscaldamento autonomo. Tapparelle elettriche, Serramenti in pvc con doppio vetro e zanzariere, aria condizionata, predisposizione impianto allarme. Possibilità acquisto garage singolo nelle vicinanze (Via Antico Rodano) ad €. 30.000\n\nRichiesta €. 295.000\n\nUlteriori informazioni in ufficio\nIl Mondo Immobiliare - Viale Trento e Trieste 120, Cremona	295000.00	Cremona	CR	corso XX settembre		APPARTAMENTO	140	5	2	\N	f		DISPONIBILE	1	2026-07-31 15:08:13.114758	2026-07-31 15:08:13.11477	f	f	f	f	f	t	t	f	t	t	t	f	f	CENTRALE	VENDITA	3	f	\N	1802
55	id. 1794 Castelverde	In piccolo contesto condominiale, appartamento posto al piano terra di circa mq. 90 commerciali e composto da ingresso, soggiorno, cucina, bagno, 2 camere da letto, ripostiglio, 2 balconcini, garage pertinenziale. Serramenti in legno con doppio vetro, riscaldamento autonomo, giardinetto condominiale, basse spese condominiali. Classe energetica G. richiesta €. 89.000.	89000.00	Castelverde	CR	Castelverde		APPARTAMENTO	90	3	1	\N	f		DISPONIBILE	1	2026-07-31 15:40:02.481124	2026-07-31 15:40:02.481139	f	t	f	f	f	f	f	f	t	t	f	f	f	FUORI_CITTA	VENDITA	2	t	\N	1794
56	id. 1793 Via Massarotti	Affittasi  ufficio sito  in Cremona, in Via Massarotti. L' immobile si trova   in un contesto signorile ed è posto al piano terra e si sviluppa su una superficie di circa 130 mq.  E' attualmente composto da : ingresso, 5 stanze, disimpegno e bagno.  Dotato di aria condizionata, riscaldamento autonomo, serramenti in legno con doppio vetro, impianto elettrico a norma, fibra ottica, predisposizione impianto allarme, possibilità posto auto. Ideale per uno o più professionisti. Bassissime spese condominiali. Classe energetica F\n\n\n\nRichiesta € 1100 mensili	1100.00	Cremona	CR	via massarotti		STUDIO	129.98	1	-4	\N	f		DISPONIBILE	1	2026-07-31 15:42:42.988829	2026-07-31 15:42:42.988842	f	f	f	f	f	t	t	f	t	t	t	f	f	CENTRALE	AFFITTO	\N	f	\N	1793
57	id. 1792 Via M. Sclemo	Vendesi appartamento posto al quarto e penultimo piano di contesto signorile servito da nuovo ascensore. L' ampio quadrilocale di circa\n\nmq. 135 è in buono stato d'uso ed attualmente formato da :\n\ningresso ,soggiorno, cucina abitabile, 2 camere da letto, studio, doppi servzi (entrambi finestrati), 3 balconi , ripostiglio e cantina al piano interrato. L'abitazione è pronta d'abitare e dispone di serramenti in legno con doppio vetro, parquet in ottime condizioni nelle camere da letto, aria condizionata zona giorno e zona notte, impianti elettrici e idraulici recentemente realizzati. Riscaldamento centralizzato con termovalvole, classe energetica F. Possibilità garage. Richiesta € 162.000	162000.00	Cremona	CR			APPARTAMENTO	134	5	2	\N	t		DISPONIBILE	1	2026-07-31 15:49:19.638808	2026-07-31 15:49:19.638844	f	t	f	f	f	f	t	f	t	f	t	f	f	CENTRALE	VENDITA	\N	f	\N	1792
58	id. 1791 Piazza San Paolo	Cremona, Piazza San Paolo - in ordinato contesto condominiale, vendesi appartamento ristrutturato di mq. 78 commerciali , con possibilità di finiture a scelta , posto al 2° piano servito da ascensore. Il trilocale è composto da ingresso , soggiorno con balcone, cucina a vista, bagno, 2 camere di cui una matrimoniale,  ed accessoriata da garage. Consegna dell'appartamento fine Marzo.\n\nRichiesta € 179.000 Spese condominiali circa € 700 annue.	179000.00	Cremona	CR	piazza san paolo		APPARTAMENTO	78	3	1	\N	t		DISPONIBILE	1	2026-07-31 15:53:08.823918	2026-07-31 15:53:08.823932	f	t	f	f	f	f	t	f	f	f	t	f	f	CENTRALE	VENDITA	2	t	\N	1791
60	id. 1789 Zona via Giuseppina	In Cremona, in zona via Giuseppina, vendesi villetta unifamiliare libera su 4 lati e circondata da circa mq. 200 di giardino di proprietà. Il progetto di totale ristrutturazione prevede la realizzazione di un cappotto esterno di circa 14 cm in grafite, serramenti in pvc con doppio vetro, riscaldamento a pavimento con pompa di calore, raffrescamento zona giorno e zona notte, consentendo il tutto di ottenere una classe Energetica da progetto in A3. La villetta posta su 2 livelli sarà composta al piano rialzato da ingresso, ampio soggiorno con angolo cottura, 2 camere da letto matrimoniali, disimpegno, bagno con nicchia per lavatrice ed asciugatrice. Il piano seminterrato, accessibile da scala interna o indipendentemente, è composto da taverna di circa mq. 50 calpestabili con tutte le predisposizioni, lavanderia e locale tecnico. Un garage di circa mq. 20 completa questa interessante soluzione indipendente. Tapparelle elettriche, zanzariere, predisposizione impianto d’allarme e fotovoltaico, ottime finiture a scelta tra capitolato proposto. Consegna in 2 mesi. Possibilità detrazioni fiscali.\n\nRichiesta €. 375.000\nIl Mondo immobiliare\nViale Trento e Trieste 120, Cremona.	375000.00	Cremona	CR	via Giuseppina		VILLA,VILLETTA	128	5	2	\N	f		DISPONIBILE	1	2026-07-31 16:00:00.834469	2026-07-31 16:00:00.834496	f	f	t	t	f	t	t	f	t	t	t	t	f	PERIFERIA	VENDITA	3	t	\N	1789
61	id. 1788 Via Nino Bixio	Locale commerciale di circa mq. 113 commerciali, in locazione o vendita. Il negozio è posto su 2 livelli, con occhi di vetrina al piano terra.\n\nDispone di triplice ingresso/uscita sia al piano stradale che al piano interrato. In buone condizioni e già a norma per diverse attività commerciali. Aria condizionata, serramenti con doppio vetro, porta blindata, riscaldamento autonomo. La zona è servita da molteplici servizi.\n\nRichiesta €. 110,000 e €. 830,00 mensili + iva	110000.00	Cremona	CR	Via Nino Bixio		NEGOZIO	113	\N	2	\N	f		DISPONIBILE	1	2026-07-31 16:04:05.931122	2026-07-31 16:04:05.931137	f	f	f	f	f	f	t	f	t	t	t	f	f	PERIFERIA	VENDITA	\N	f	\N	1788
62	id. 1787 Casalbuttano 	Vendesi casa indipendente a S.Vito di Casalbuttano. L'unità abitativa è posta su due livelli e formata da al piano terra, soggiorno, cucina, bagno e ripostiglio; al piano superiore da 2 camere da letto, uno spazioso balcone e un balconcino. Il tutto è accessoriato da cantina, taverna, lavanderia, cortile privato, autorimessa e piccolo fienile. Serramenti con doppio vetro. Richiesta €. 65.000. Ape in elaborazione.\n\nIl mondo immobiliare 0372 32397\n\nViale Trento e Trieste 120, Cremona	65000.00	Casalbuttano	CR	Casalbuttano		CASA_INDIPENDENTE,FABBRICATO	90	3	1	\N	f		DISPONIBILE	1	2026-07-31 17:56:51.185858	2026-07-31 17:56:51.185872	f	t	f	f	f	f	f	f	t	t	f	f	f	FUORI_CITTA	VENDITA	\N	t	\N	1787
59	id. 1790 Via Palestro	Unità immobiliare di circa 100 mq. commerciali, attualmente ad uso studio, posta al piano terreno di contesto signorile del 1700. Lo studio è composto da ingresso/reception, due vani di circa mq. 15 ciascuno, antibagno e bagno, locale archivio; Due ulteriori vani  di circa mq. 25 con bagno formano il caratteristico soppalco. Completa la proprietà un comodo garage di circa mq. 30 e un' ampia cantina pertinenziale. Riscaldamento autonomo, impianto di raffrescamento, serramenti in legno con doppio vetro. Ape in elaborazione.\n\nRichiesta € 210.000	210000.00	Cremona	CR	Via Palestro		APPARTAMENTO,BILOCALE,STUDIO	100	4	2	\N	t		DISPONIBILE	1	2026-07-31 15:57:06.6105	2026-07-31 18:19:48.423646	f	f	f	f	f	f	t	f	t	t	t	f	f	CENTRALE	VENDITA	\N	t	\N	1790
63	id. 1785 Castelvetro Piacentino	Nel centro paese di Castelvetro Piacentino, vendesi casa semi indipendente ristrutturata nel 2023, posta su due piani fuori terra e in ottimo stato d'uso. La parte abitativa si svolge al primo piano di circa mq. 165 commerciali. Caratterizzata da ottime finiture, è composta da: ingresso, splendido ampio soggiorno con pregevole cucina a vista con penisola, disimpegno, camera da letto matrimoniale con bagno padronale finestrato, spaziosa cabina armadio, seconda camera da letto, ulteriore bagno finestrato, lavanderia, comodo studio e 3 balconi che circondano l'appartamento. Riscaldamento autonomo con caldaia a condensazione, tapparelle elettriche, impianto di aspirazione centralizzata, impianto d'allarme perimetrale, volumetrico e di video sorveglianza, aria condizionata. Il tutto è accessoriato da Taverna, garage doppio, locale tecnico, cantina e giardino piantumanto su 3 lati che garantisce un'ottima privacy e momenti di relax nel verde. Richiesta €. 375.000\n\nIl mondo Immobiliare 0372 32397 - 3294011384\n\nViale Trento e Trieste 120, Cremona	375000.00	Castelvetro Piacentino	PC	Castelvetro Piacentino		APPARTAMENTO,VILLA,CASA_INDIPENDENTE	165	5	2	\N	f		DISPONIBILE	1	2026-07-31 18:23:15.925976	2026-07-31 18:23:15.92599	f	t	f	t	f	t	t	f	t	t	f	f	f	FUORI_CITTA	VENDITA	3	t	\N	1785
64	id. 1784 Via Buoso da Dovara	Vendesi bilocale di circa mq. 85 con cucina separata dal soggiorno in zona Esselunga. Accessoriato da cantina pertinenziale e possibilità garage ad euro 20.000. L’appartamento, posto al piano rialzato servito da ascensore, si presta sia ad una prima abitazione che ad un investimento sicuro. Serramenti in legno con doppio vetro.\n\nRichiesta euro 80.000 #cremona #vendesi #appartamento #ilmondoimmobiliare #bilocaleampio #info	80000.00	Cremona	CR	Via Buoso da Dovara		APPARTAMENTO,BILOCALE	85	2	1	\N	t		DISPONIBILE	1	2026-07-31 18:25:16.624689	2026-07-31 18:25:16.624697	f	f	f	f	f	f	f	f	t	t	t	f	f	SEMI_CENTRALE	VENDITA	\N	t	\N	1784
68	id. 1772 Via Antico Rodano	Vendesi garage in via antico Rodano, Cremona.\n\nGarage in ottime condizioni, al piano interrato. L'ingresso è  di circa mt 2.20 per 5.50 mt in lunghezza.\n\nRichiesta 30.000 euro\n\nNo obbligo ape.	30000.00	Cremona	CR	Via Antico Rodano		BOX	14	\N	\N	\N	f		DISPONIBILE	1	2026-07-31 18:32:21.634162	2026-07-31 18:32:21.634186	f	f	f	f	f	f	f	f	f	f	f	f	f	CENTRALE	VENDITA	\N	t	\N	1772
65	id. 1783 Via Geromini	In meraviglioso storico contesto del XVI secolo, a due passi dalla piazza principale di Cremona, vendesi al piano terra, appartamento di circa 100 mq commerciali attualmente composto da ingresso, ampio soggiorno con splendida vista sul giardino interno, ampio disimpegno e doppia cantina al piano interrato raggiungibile anche con ascensore. L’appartamento è soppalcabile grazie ai soffitti di altezza superiore ai 5 metri. Classe Energetica B, isolamento acustico e termico. Aria condizionata installata. Riscaldamento autonomo. Possibilità garage nelle immediate vicinanze. Richiesta euro €. 200.000.\n\nIl Mondo Immobiliare\nViale Trento e Trieste 120, Cremona.\n\n#cremona #vendesi #appartamento #contestostorico #palazzostorico #dimorastorica #isolamentotermico #isolamentoacustico #classeb	200000.00	Cremona	CR	Via Geromini		APPARTAMENTO,BILOCALE	100	2	1	\N	f		DISPONIBILE	1	2026-07-31 18:27:17.132799	2026-07-31 18:27:17.132814	f	f	f	t	f	f	t	f	t	t	t	f	f	CENTRALE	VENDITA	1	f	\N	1783
66	id. 1782 Corso Matteotti	Vendesi storica abitazione nobiliare inserita al piano padronale di splendido contesto del 500′ denominato “Palazzo Sfondrati”.\n\nPosizionata nel pieno centro di Cremona, è una soluzione ideale per chi ama risiedere e/o lavorare in ambienti in cui si respira storia ed eleganza che caratterizzano questa proposta.\n\nL’unità immobiliare è di circa mq. 600 commerciali ed occupa tutto l’intero primo ed ultimo piano con triplo affaccio, veranda, ampia balconata interna ed esterna.\n\nUlteriori informazioni in ufficio\n\nIl Mondo Immobiliare – Viale Trento e Trieste 120, Cremona	700000.00	Cremona	CR	Corso Matteotti		APPARTAMENTO	600	7	2	\N	f		DISPONIBILE	1	2026-07-31 18:29:08.502391	2026-07-31 18:29:08.502401	f	t	f	f	f	f	f	f	t	t	f	f	f	CENTRALE	VENDITA	5	f	\N	1782
67	id. 1774 Via Pomello	Vendesi appartamento completamente arredato a nuovo, (attualmente affittato con regolare contratto di locazione), posto su 2 livelli e formato da ingresso, ampio soggiorno con cucina, ripostiglio, corridoio, camera da letto matrimoniale, bagno, balcone. Al piano inferiore spaziosa taverna con cantina e lavanderia. Comodo garage pertinenziale di pertinenza. Aria condizionata, serramenti in legno con doppio vetro, aria condizionata. Rendita annua di €. 7200. Richiesta €. 89.000\nIl mondo immobiliare 0372 32397 - 3294011384\nViale Trento e Trieste 120, Cremona	89000.00	Castelvetro Piacentino	PC	Castelvetro Piacentino		APPARTAMENTO	98	2	1	\N	f		DISPONIBILE	1	2026-07-31 18:30:59.763283	2026-07-31 18:30:59.763298	f	t	f	f	f	f	f	f	t	t	t	f	f	FUORI_CITTA	VENDITA	1	t	\N	1774
70	id. 1770 Via del Giordano 	In contesto ordinato e ben abitato, appartamento completamente ristrutturato, posto al 2° piano servito da nuovo ascensore.\nIl trilocale, con moderne finiture, pavimentazione in 60x120, è composto da ingresso, soggiorno con balcone, cucina con ulteriore balcone, disimpegno, bagno con comodissimo piatto doccia, 2 camere da letto matrimoniali, cantina e garage. Riscaldamento autonomo, predisposizione aria condizionata, serramenti in pvc con doppio vetro, zanzariere.\nRichiesta €. 142.000\nConsegna in 120 giorni\nIl mondo immobiliare 0372 32397	142000.00	Cremona	CR	Via del Giordano		APPARTAMENTO	80	3	1	\N	t		DISPONIBILE	1	2026-07-31 18:36:33.528749	2026-07-31 18:36:33.528753	f	t	f	f	f	f	t	f	f	t	t	f	f	CENTRALE	VENDITA	2	t	\N	1770
71	id. 1769 Centro Storico	In vendita nel centro storico di Cremona a 100 metri da Piazza Duomo elegante ed esclusiva\npalazzina d’epoca con finiture di pregio.\nLa proprietà gode di comodo ingresso carraio direttamente dal corso principale di affaccio,\ncortile in sassi di fiume, signorile porticato e colonnato. Le caratteristiche e la posizione\nprivilegiata ne fanno un’opportunità unica!\nL’edificio si sviluppa su tre livelli per una superficie totale di mq 1.100, abitativa mq. 720, composto da 4 unità:\nun appartamento al piano terra, due al primo piano di cui uno servito da ascensore privato, un grande appartamento\npadronale al secondo piano su due livelli anch'esso con ascensore privato e terrazza panoramica.\nSono presenti tre box, uno grande all’interno del fabbricato e due esterni nelle vicinanze.\nLe unità abitative sono uniche nel loro genere con meravigliose finiture che rendono gli ambienti luminosi, eleganti e signorili.          Pavimenti in marmo di Carrara, parquet in rovere, infissi in legno con vetri doppi, aria condizionata, cotto, porte d’ingresso blindate e antifurto per descriverne alcune. Impreziosiscono la casa romantiche vedute sul centro città e viste mozzafiato del Torrazzo.\n\nPur essendo nel centro storico l’immobile gode della massima privacy e silenzio.\nDa Cremona si possono raggiungere facilmente le seguenti città; Brescia, distante solo Km.50, Milano Km.80 ed il vicino lago di Garda.\nCremona è famosa nel mondo, patria del violino, del torrone e città della musica.\nIl centro offre tutti i principali servizi a portata di mano. La città è molto vivibile e d’interesse turistico.                                                                  Ha una magnifica Piazza del Duomo con il suo splendido “Torrazzo” (la torre campanaria medievale più alta d’Europa) simbolo di Cremona.\nNulla manca a questa interessantissima proposta ideale per molteplici richieste sia residenziali che d’investimento.\nL’intero contesto possiede conformità urbanistica, catastale e recenti attestati di prestazione energetica.\n\nDi seguito piacevole articolo di casa.it sul vivere a Cremona\n\nhttps://blog.casa.it/2025/05/09/vivere-a-cremona/\n\nPrezzo su richiesta.\n\nUlteriori informazioni in ufficio.\nIl Mondo Immobiliare\nViale Trento e Trieste 120, Cremona\nTel. 0372.32397 – Cell. 329.4011384\n\n	1900000.00	Cremona	CR	Centro Storico		APPARTAMENTO,ATTICO,CASA_INDIPENDENTE,FABBRICATO	1100	15	8	\N	f		DISPONIBILE	1	2026-07-31 18:38:49.738283	2026-07-31 18:38:49.738288	f	t	f	f	f	t	t	t	t	t	t	f	f	CENTRALE	VENDITA	7	t	\N	1769
72	id. 1762 Via 11 Febbraio	In piccolo e ben curato contesto condominiale, appartamento pronto da abitare e di circa mq. 90, presenta finiture di fine anni 90' ed è attualmente composto da: soggiorno, cucina a vista con penisola, bagno, camera da letto e balcone sul cortile comune. Al Piano superiore, mansardato, troviamo 2 vani con pavimentazione in parquet, bagno (finestrato) e terrazzino (ad uso esclusivo) vista torrazzo. Il tutto accessoriato da prezioso e comodo garage pertinenziale. Riscaldamento autonomo. Serramenti in legno con doppio vetro.\n\nRichiesta €. 180.000\n\nIl mondo Immobiliare 0372 32397 - Viale Trento e Trieste 120, Cremona	180000.00	Cremona	CR	Via 11 Febbraio		APPARTAMENTO,MANSARDA	90	4	2	\N	f		DISPONIBILE	1	2026-07-31 18:41:34.632804	2026-07-31 18:41:34.632814	f	t	f	f	f	f	f	t	f	t	t	f	f	CENTRALE	VENDITA	\N	t	\N	1762
74	id. 1744 Viale Trento e Trieste	In ordinato e signorile contesto, vendesi immobile di circa mq. 200 commerciali posto al piano terra. Attualmente ad uso studio, l'ampia metratura, il doppio affaccio, il giardino pertinenziale e la balconata sul retro, permette la realizzazione di unico appartamento ricavando 3 camere da letto e doppi servizi con spaziosa zona giorno, oppure la creazione di due appartamenti indipendenti di circa mq. 100 ciascuno.\n\nRichiesta €. 200.000\n\nulteriori info e visione progetti\n\nIl mondo immobiliare 0372 32397 - V.le Trento e Trieste 120, Cremona	200000.00	Cremona	CR	Viale Trento e Trieste		APPARTAMENTO,STUDIO	200	5	2	\N	t		DISPONIBILE	1	2026-07-31 18:46:19.623022	2026-07-31 18:46:19.623026	f	t	f	t	f	f	t	f	t	f	t	f	f	CENTRALE	VENDITA	\N	f	\N	1744
73	id. 1746 Via Genala	Vendesi al piano terra di contesto liberty, negozio di circa mq. 75 commerciali. Attualmente utilizzato come studio professionale, il locale è composto da 2 stanze, disimpegno, bagno e stanza archivio. Il locale, con occhio di vetrina di circa mq. 4, è pronto all'utilizzo. Assenti le spese condominiali. Riscaldamento autonomo.\nRichiesta €. 70.000\nUlteriori informazioni\nIl mondo immobiliare 0372 32397 - 3294011384\nViale Trento e Trieste 120, Cremona	70000.00	Cremona	CR	Via Genala		NEGOZIO,STUDIO	75	\N	1	\N	f		DISPONIBILE	1	2026-07-31 18:43:52.016291	2026-07-31 18:43:52.016294	f	f	f	f	f	f	t	f	t	t	f	f	f	CENTRALE	VENDITA	\N	f	\N	1746
76	id. 1741 Via Villirene 	a Pochissimi minuti dall'ospedale di Cremona, vendesi importante e solida villa libera su 4 lati circondata da area orto, giardino e cortilizia. La villa è composta da 2 appartamenti indipendenti di circa mq. 130 ciascuno, posti al piano terra e piano primo. Il tutto è accessoriato da 3 ampi garage pertinenziali e locale ad uso deposito.\n\nQuesta soluzione, ben isolata termicamente nel 2011, è ideale per stare a contatto con i famigliari stretti, mantenendo nel contempo la privacy. Impianto d'allarme, riscaldamento autonomo. Classe energetica F.\n\nRichiesta €. 270.000\n\nIl mondo Immobiliare 0372 32397\n\nViale Trento e Trieste 120, Cremona	270000.00	Bonemerse	CR	Via Villirene 		VILLA,VILLETTA	260	9	4	\N	f		DISPONIBILE	1	2026-07-31 18:52:17.967003	2026-07-31 18:52:17.967007	f	t	f	t	f	t	f	f	t	t	t	f	f	FUORI_CITTA	VENDITA	5	t	\N	1741
77	id. 1701 Zona Piazza Castello	Nella bellissima e servita zona "Piazza Castello", vendesi a corpo intero fabbricato di 5 piani fuori terra, composto da n. 16 appartamenti, n. 11 garage e n. 5 locali commerciali. L'edificio ha recentemente sostenuto l'intervento di riqualificazione delle facciate e dei balconi. Negozi ed appartamenti sono prevalentemente in discreto/buono stato di manutenzione e conservazione.\nInteressante investimento per la Redditività attuale dell'intero fabbricato del 6%.\nLo stabile è conforme urbanisticamente e catastalmente allo stato attuale.\n\nPer ulteriori informazioni in ufficio.\nIl Mondo Immobiliare\nViale Trento e Trieste 120, Cremona.	2439000.00	Cremona	CR	Zona Piazza Castello		FABBRICATO	2500	14	7	\N	t		DISPONIBILE	1	2026-07-31 18:54:41.247342	2026-07-31 18:54:41.247345	f	t	f	f	f	f	t	f	t	f	t	f	f	CENTRALE	VENDITA	1	t	\N	1701
78	id. 1697 Casalbuttano	In contesto di recente ristrutturazione, vendesi Caratteristica Mansarda di circa mq. 95 posta al terzo ed ultimo piano.\n\nL'appartamento in ottimo stato d'uso, con travi a vista,  è composto da ingresso, ampio soggiorno, cucina abitabile, disimpegno, 2 camere da letto, bagno, ripostiglio. Il tutto è accessoriato da comodo garage al piano cortile.\n\nRiscaldamento autonomo, serramenti in legno con doppio vetro, parquet. Classe Energetica F ep 256,04\n\nRichiesta €. 95.000	95000.00	Casalbuttano	CR	Casalbuttano		APPARTAMENTO,MANSARDA	95	3	1	\N	f		DISPONIBILE	1	2026-07-31 18:56:15.866736	2026-07-31 18:56:15.866741	f	f	f	f	f	f	t	f	t	t	t	f	f	FUORI_CITTA	VENDITA	2	f	\N	1697
79	id. 1684 Pieve d'olmi	Villa unifamiliare in costruzione a Pieve D’olmi (Cr).\n\nLa Villa libera su 4 lati con giardino di proprietà su 3 lati, è posta su  2 livelli. Al piano terra troviamo ampia zona giorno e pranzo di circa mq. 35, cucina, bagno e disimpegno. Al primo piano: 3 camere da letto e bagno. Serramenti in legno, cappotto di circa 13 cm.\n\nClasse energetica A, costruzione antisismica, riscaldamento a pavimento con termoregolazione in tutte le stanze, impianto fotovoltaico 3kw, garage doppio esterno. Richiesta euro 255.000	255000.00	Pieve d'olmi	CR	Pieve d'olmi		VILLA,VILLETTA	140	5	2	\N	f		DISPONIBILE	1	2026-07-31 18:58:20.754555	2026-07-31 18:58:20.754559	t	t	t	t	f	f	f	f	t	t	t	f	f	FUORI_CITTA	VENDITA	3	t	\N	1684
80	id. 1648 Zona Via Bergamo 	In Zona via Bergamo vendesi capannone artigianale da ristrutturare di circa mq. 300,\n\ninsistente su area di circa mq. 700. Ingresso pedonale e carraio, altezza capannone circa 7 metri.\n\nrichiesta €. 150.000. no obbligo ape.	150000.00	Zona Via Bergamo 	CR	Zona Via Bergamo 		MAGAZZINO_CAPANNONE	300	\N	\N	\N	f		DISPONIBILE	1	2026-07-31 19:00:10.627962	2026-07-31 19:00:10.627965	f	f	f	t	f	f	f	f	f	f	f	f	f	PERIFERIA	VENDITA	\N	f	\N	1648
75	id. 1742 Castelvetro P.no 	Casetta indipendente pronta da abitare di circa mq. 140 commerciali, disposta tra piano terra, primo e secondo. L'abitazione è attualmente composta da soggiorno, cucina, bagno, ripostiglio al piano terra; al primo piano da camere da letto e bagno e al secondo ed ultimo piano da camera da letto e studiolo. Il tutto è circondato da area comune e giardino. Richiesta €. 120.000\n\nApe in elaborazione	120000.00	Castelvetro P.no 	PC	Castelvetro P.no 		VILLETTA,CASA_INDIPENDENTE	135	4	2	\N	f		DISPONIBILE	1	2026-07-31 18:50:16.070087	2026-07-31 19:00:32.093165	f	f	f	t	f	f	f	f	t	t	f	f	f	FUORI_CITTA	VENDITA	\N	f	\N	1742
69	id. 1771 Castelvetro Piacentino	In ottima posizione, capannone di circa mq. 650 con comodo accesso per manovra e ingresso. Godendo di altezza di circa mt. 10 e di predisposizione carroponte, è adatto per molteplici attività. Presenti anche gli uffici, riscaldati, all'interno. Tetto recentemente rifatto, aria condizionata e pompe di calore. Immediate vicinanze al casello autostradale di Castelvetro Piacentino e Cremona. Richiesta €. 165.000, rendita annua di circa 34.000 euro.\n\nInfo 0372 32397 - Il mondo immobiliare\n\nCremona, Viale Trento e Trieste 120.	165000.00	Castelvetro Piacentino	PC	Castelvetro Piacentino		MAGAZZINO_CAPANNONE	650	\N	\N	\N	f		DISPONIBILE	1	2026-07-31 18:34:43.619155	2026-07-31 19:00:45.932888	f	f	f	f	f	f	f	f	f	f	f	f	f	FUORI_CITTA	VENDITA	\N	f	\N	1771
81	id. 1616 Piazza della Libertà	Appartamento da ristrutturare di circa mq. 180 commerciali posto al 1° piano e composto da ingresso, ampio soggiorno, 3 camere da letto, tinello, cucina, 2 bagni, balcone e terrazza di circa mq. 45. Il tutto accessoriato da ampia soffitta. Riscaldamento autonomo. classe energetica g ipe 322.22.\nrichiesta €. 98.000	98000.00	Piazza della Libertà	CR	Piazza della Libertà		APPARTAMENTO	180	5	2	\N	f		DISPONIBILE	1	2026-07-31 19:02:20.969194	2026-07-31 19:02:20.969198	f	t	f	f	f	f	f	f	t	t	f	f	f	SEMI_CENTRALE	VENDITA	3	f	\N	1616
82	id. 1580 Corso Garibaldi	In contesto signorile, al primo piano servito da ascensore, appartamento recentemente ristrutturato composto da ingresso, soggiorno, cucina (arredata), 2 camere da letto, bagno, lavanderia, 2 balconi e cantina. ape in elaborazione.  Richiesta €. 700 mensili	699.99	Corso Garibaldi	CR	Corso Garibaldi		APPARTAMENTO	100	4	2	\N	t		DISPONIBILE	1	2026-07-31 19:03:45.119843	2026-07-31 19:03:45.119846	f	f	f	f	f	f	t	f	f	t	t	f	f	CENTRALE	AFFITTO_SEMI_ARREDATO	2	f	\N	1580
83	id. 1499 Casalbuttano	A Casalbuttano, proponiamo in vendita Cascina completamente da ristrutturare inserita su lotto di circa mq. 2900 attualmente composta da casa padronale di fine 800' (fronte strada) di circa mq. 350 abitativi su 2 livelli, con annessa area cortilizia, magazzini, rustici e barchessali. No obbligo certificazione energetica. Richiesta euro 85.000	85000.00	Casalbuttano	CR	Casalbuttano		CASCINA,CASA_INDIPENDENTE,FABBRICATO	350	6	2	\N	f		DISPONIBILE	1	2026-07-31 19:06:02.845545	2026-07-31 19:06:02.84555	f	t	f	t	f	f	f	f	f	f	f	f	f	FUORI_CITTA	VENDITA	4	f	\N	1499
84	id. 1482 Zona Centrale 	A 2 passi dal centro storico di Cremona, inseriti in palazzo Nobiliare del '500 completamente ristrutturato recuperando e conservando le parti comuni, splendidi appartamenti  in vendita di varie metrature (dagli 80 ai 220 mq) con Capitolato di primissima qualità a scelta della parte acquirente, disponibili al piano terra e primo (ed ultimo), serviti da ascensore, accessoriati da cortiletto o Terrazzino o balcone vista duomo/cortile interno. Possibilità comodi Box al piano interrato. Appartamenti in classe B con isolamenti termici ed acustici elevati.\n\nrichiesta euro 3000 al mq. esclusi box.\n\nulteriori informazioni in ufficio.	660000.00	Zona Centrale 	CR	Zona Centrale 		APPARTAMENTO	220	5	2	\N	t		DISPONIBILE	1	2026-07-31 19:08:33.687682	2026-07-31 19:08:33.687688	f	t	f	f	f	f	t	t	t	t	t	f	f	CENTRALE	VENDITA	3	t	\N	1482
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, email, password, nome, cognome, role, creato_il, aggiornato_il) FROM stdin;
1	admin@agenzia.it	$2a$10$m4hDc.OJSl/Htc0Hzbef0OqHu/jNEFmyt5ZMFCDyc1jw46SW6FSEu	Admin	Agenzia	ADMIN	2026-05-25 23:11:27.468933	2026-07-31 21:10:34.307975
2	dipendente1@agenzia.it	$2a$10$zw1kj8o6f.P9xKa66yBrUOavH1oW0n6ioW337Ii6BhhclpJjznDDa	Marco	Rossi	EMPLOYEE	2026-05-25 23:11:27.468933	2026-07-31 21:10:34.432283
3	dipendente2@agenzia.it	$2a$10$haH6lz/RW3Bir7AUMJLa9.gTopYv74vWRveck6ASzQcZBiE25mIe.	Laura	Bianchi	EMPLOYEE	2026-05-25 23:11:27.468933	2026-07-31 21:10:34.512609
\.


--
-- Name: foto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.foto_id_seq', 834, true);


--
-- Name: immobili_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.immobili_id_seq', 84, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: foto foto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.foto
    ADD CONSTRAINT foto_pkey PRIMARY KEY (id);


--
-- Name: immobili immobili_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.immobili
    ADD CONSTRAINT immobili_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: idx_foto_immobile_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_foto_immobile_id ON public.foto USING btree (immobile_id);


--
-- Name: idx_immobili_citta; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_immobili_citta ON public.immobili USING btree (citta);


--
-- Name: idx_immobili_prezzo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_immobili_prezzo ON public.immobili USING btree (prezzo);


--
-- Name: idx_immobili_stato; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_immobili_stato ON public.immobili USING btree (stato);


--
-- Name: idx_immobili_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_immobili_user_id ON public.immobili USING btree (user_id);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- Name: foto foto_immobile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.foto
    ADD CONSTRAINT foto_immobile_id_fkey FOREIGN KEY (immobile_id) REFERENCES public.immobili(id) ON DELETE CASCADE;


--
-- Name: immobili immobili_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.immobili
    ADD CONSTRAINT immobili_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict pEmqW93LlkKsLrcjvvoqA6l6xiidSjHiSGja4m3u8ssp5qeLMuv47VykcZ8f9g2

