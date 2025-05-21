--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4 (Debian 17.4-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin (
    id integer NOT NULL,
    version integer NOT NULL,
    "contraseña" character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    foto_perfil character varying(255),
    nombre character varying(255) NOT NULL,
    rol smallint,
    usuario character varying(255) NOT NULL,
    CONSTRAINT admin_rol_check CHECK (((rol >= 0) AND (rol <= 2)))
);


ALTER TABLE public.admin OWNER TO postgres;

--
-- Name: anunciante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.anunciante (
    id integer NOT NULL,
    version integer NOT NULL,
    "contraseña" character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    foto_perfil character varying(255),
    nombre character varying(255) NOT NULL,
    rol smallint,
    usuario character varying(255) NOT NULL,
    telefono character varying(255) NOT NULL,
    CONSTRAINT anunciante_rol_check CHECK (((rol >= 0) AND (rol <= 2)))
);


ALTER TABLE public.anunciante OWNER TO postgres;

--
-- Name: comunidad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comunidad (
    id integer NOT NULL,
    version integer DEFAULT 1 NOT NULL,
    nombre character varying(255) NOT NULL
);


ALTER TABLE public.comunidad OWNER TO postgres;

--
-- Name: domain_entity_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.domain_entity_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.domain_entity_seq OWNER TO postgres;

--
-- Name: estudiante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estudiante (
    id integer NOT NULL,
    version integer NOT NULL,
    "contraseña" character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    foto_perfil character varying(255),
    nombre character varying(255) NOT NULL,
    rol smallint,
    usuario character varying(255) NOT NULL,
    vivienda_id integer,
    CONSTRAINT estudiante_rol_check CHECK (((rol >= 0) AND (rol <= 2)))
);


ALTER TABLE public.estudiante OWNER TO postgres;

--
-- Name: foto_vivienda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.foto_vivienda (
    id integer NOT NULL,
    version integer NOT NULL,
    imagen character varying(255),
    vivienda_id integer NOT NULL
);


ALTER TABLE public.foto_vivienda OWNER TO postgres;

--
-- Name: municipio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.municipio (
    id integer NOT NULL,
    version integer DEFAULT 1 NOT NULL,
    cod_municipio integer NOT NULL,
    dc integer NOT NULL,
    nombre character varying(255) NOT NULL,
    provincia_id integer NOT NULL
);


ALTER TABLE public.municipio OWNER TO postgres;

--
-- Name: municipio_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.municipio_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.municipio_id_seq OWNER TO postgres;

--
-- Name: municipio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.municipio_id_seq OWNED BY public.municipio.id;


--
-- Name: provincia; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provincia (
    id integer NOT NULL,
    version integer DEFAULT 1 NOT NULL,
    nombre character varying(255) NOT NULL,
    comunidad_id integer NOT NULL
);


ALTER TABLE public.provincia OWNER TO postgres;

--
-- Name: vivienda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vivienda (
    id integer NOT NULL,
    version integer NOT NULL,
    calle character varying(255) NOT NULL,
    comunidad character varying(255) NOT NULL,
    descripcion character varying(255) NOT NULL,
    fecha_publicacion timestamp(6) without time zone NOT NULL,
    municipio character varying(255) NOT NULL,
    nombre character varying(255) NOT NULL,
    numero character varying(255) NOT NULL,
    numero_habitaciones character varying(255) NOT NULL,
    precio_mensual integer NOT NULL,
    provincia character varying(255) NOT NULL,
    tipo_vivienda smallint NOT NULL,
    ultima_edicion timestamp(6) without time zone NOT NULL,
    anunciante_id integer,
    CONSTRAINT vivienda_tipo_vivienda_check CHECK (((tipo_vivienda >= 0) AND (tipo_vivienda <= 5)))
);


ALTER TABLE public.vivienda OWNER TO postgres;

--
-- Name: municipio id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipio ALTER COLUMN id SET DEFAULT nextval('public.municipio_id_seq'::regclass);


--
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin (id, version, "contraseña", email, foto_perfil, nombre, rol, usuario) FROM stdin;
1	0	$2a$10$nMr.KedOfpImnfUiN49JTe0WmZS9Mfr0Q3Yi21vXyMPXGUgwuF62K	admin@default.es	https://icons.veryicon.com/png/o/application/cloud-supervision-platform-vr10/admin-5.png	Admin por defecto	0	admin
\.


--
-- Data for Name: anunciante; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.anunciante (id, version, "contraseña", email, foto_perfil, nombre, rol, usuario, telefono) FROM stdin;
\.


--
-- Data for Name: comunidad; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comunidad (id, version, nombre) FROM stdin;
1	1	Andalucía
2	1	Aragón
3	1	Principado de Asturias
4	1	Islas Baleares
5	1	Canarias
6	1	Cantabria
7	1	Castilla y León
8	1	Castilla-La Mancha
9	1	Cataluña
10	1	Comunidad Valenciana
11	1	Extremadura
12	1	Galicia
13	1	Comunidad de Madrid
14	1	Región de Murcia
15	1	Comunidad Foral de Navarra
16	1	País Vasco
17	1	La Rioja
18	1	Ceuta
19	1	Melilla
\.


--
-- Data for Name: estudiante; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.estudiante (id, version, "contraseña", email, foto_perfil, nombre, rol, usuario, vivienda_id) FROM stdin;
\.


--
-- Data for Name: foto_vivienda; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.foto_vivienda (id, version, imagen, vivienda_id) FROM stdin;
\.


--
-- Data for Name: municipio; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.municipio (id, version, cod_municipio, dc, nombre, provincia_id) FROM stdin;
1	1	1	4	Alegría-Dulantzi	1
2	1	1	9	Abengibre	2
3	1	1	5	Adsubia	3
4	1	1	0	Abla	4
5	1	1	3	Adanero	5
6	1	1	6	Acedera	6
7	1	1	2	Alaró	7
8	1	1	8	Abrera	8
9	1	1	1	Abajas	9
10	1	1	5	Abadía	10
11	1	1	2	Alcalá de los Gazules	11
12	1	1	7	Atzeneta del Maestrat	12
13	1	1	3	Abenójar	13
14	1	1	8	Adamuz	14
15	1	1	1	Abegondo	15
16	1	1	4	Abia de la Obispalía	16
17	1	1	0	Agullana	17
18	1	1	6	Agrón	18
19	1	1	9	Abánades	19
20	1	1	3	Abaltzisketa	20
21	1	1	0	Alájar	21
22	1	1	5	Abiego	22
23	1	1	1	Albanchez de Mágina	23
24	1	1	6	Acebedo	24
25	1	1	9	Abella de la Conca	25
26	1	1	2	Ábalos	26
27	1	1	8	Abadín	27
28	1	1	4	Acebeda, La	28
29	1	1	7	Alameda	29
30	1	1	1	Abanilla	30
31	1	1	8	Abáigar	31
32	1	1	3	Allariz	32
33	1	1	9	Allande	33
34	1	1	4	Abarca de Campos	34
35	1	1	7	Agaete	35
36	1	1	0	Arbo	36
37	1	1	6	Abusejo	37
38	1	1	2	Adeje	38
39	1	1	5	Alfoz de Lloredo	39
40	1	1	9	Abades	40
41	1	1	6	Aguadulce	41
42	1	1	1	Abejar	42
43	1	1	7	Aiguamúrcia	43
44	1	1	2	Ababuj	44
45	1	1	5	Ajofrín	45
46	1	1	8	Ademuz	46
47	1	1	4	Adalia	47
48	1	1	0	Abadiño	48
49	1	1	6	Abanto	50
50	1	1	3	Ceuta	51
51	1	1	8	Melilla	52
52	1	2	9	Amurrio	1
53	1	2	4	Alatoz	2
54	1	2	0	Agost	3
55	1	2	5	Abrucena	4
56	1	2	8	Adrada, La	5
57	1	2	1	Aceuchal	6
58	1	2	7	Alaior	7
59	1	2	3	Aguilar de Segarra	8
60	1	2	0	Abertura	10
61	1	2	7	Alcalá del Valle	11
62	1	2	2	Aín	12
63	1	2	8	Agudo	13
64	1	2	3	Aguilar de la Frontera	14
65	1	2	6	Ames	15
66	1	2	9	Acebrón, El	16
67	1	2	5	Aiguaviva	17
68	1	2	1	Alamedilla	18
69	1	2	4	Ablanque	19
70	1	2	8	Aduna	20
71	1	2	5	Aljaraque	21
72	1	2	0	Abizanda	22
73	1	2	6	Alcalá la Real	23
74	1	2	1	Algadefe	24
75	1	2	4	Àger	25
76	1	2	7	Agoncillo	26
77	1	2	3	Alfoz	27
78	1	2	9	Ajalvir	28
79	1	2	2	Alcaucín	29
80	1	2	6	Abarán	30
81	1	2	3	Abárzuza/Abartzuza	31
82	1	2	8	Amoeiro	32
83	1	2	4	Aller	33
84	1	2	2	Agüimes	35
85	1	2	5	Barro	36
86	1	2	1	Agallas	37
87	1	2	7	Agulo	38
88	1	2	0	Ampuero	39
89	1	2	4	Adrada de Pirón	40
90	1	2	1	Alanís	41
91	1	2	2	Albinyana	43
92	1	2	7	Abejuela	44
93	1	2	0	Alameda de la Sagra	45
94	1	2	3	Ador	46
95	1	2	9	Aguasal	47
96	1	2	5	Abanto y Ciérvana-Abanto Zierbena	48
97	1	2	8	Abezames	49
98	1	2	1	Acered	50
99	1	3	5	Aramaio	1
100	1	3	0	Albacete	2
101	1	3	6	Agres	3
102	1	3	1	Adra	4
103	1	3	7	Ahillones	6
104	1	3	3	Alcúdia	7
105	1	3	9	Alella	8
106	1	3	2	Adrada de Haza	9
107	1	3	6	Acebo	10
108	1	3	3	Algar	11
109	1	3	8	Albocàsser	12
110	1	3	4	Alamillo	13
111	1	3	9	Alcaracejos	14
112	1	3	2	Aranga	15
113	1	3	5	Alarcón	16
114	1	3	1	Albanyà	17
115	1	3	7	Albolote	18
116	1	3	0	Adobes	19
117	1	3	4	Aizarnazabal	20
118	1	3	1	Almendro, El	21
119	1	3	6	Adahuesca	22
120	1	3	2	Alcaudete	23
121	1	3	7	Alija del Infantado	24
122	1	3	0	Agramunt	25
123	1	3	3	Aguilar del Río Alhama	26
124	1	3	9	Antas de Ulla	27
125	1	3	5	Alameda del Valle	28
126	1	3	8	Alfarnate	29
127	1	3	2	Águilas	30
128	1	3	9	Abaurregaina/Abaurrea Alta	31
129	1	3	4	Arnoia, A	32
130	1	3	0	Amieva	33
131	1	3	5	Abia de las Torres	34
132	1	3	8	Antigua	35
133	1	3	1	Baiona	36
134	1	3	7	Ahigal de los Aceiteros	37
135	1	3	3	Alajeró	38
136	1	3	6	Anievas	39
137	1	3	0	Adrados	40
138	1	3	7	Albaida del Aljarafe	41
139	1	3	2	Adradas	42
140	1	3	8	Albiol	43
141	1	3	3	Aguatón	44
142	1	3	6	Albarreal de Tajo	45
143	1	3	9	Atzeneta de Albaida	46
144	1	3	5	Aguilar de Campos	47
145	1	3	1	Amorebieta-Etxano	48
146	1	3	4	Alcañices	49
147	1	3	7	Agón	50
148	1	4	0	Artziniega	1
149	1	4	5	Albatana	2
150	1	4	1	Aigües	3
151	1	4	6	Albánchez	4
152	1	4	2	Alange	6
153	1	4	8	Algaida	7
154	1	4	4	Alpens	8
155	1	4	1	Acehúche	10
156	1	4	8	Algeciras	11
157	1	4	3	Alcalà de Xivert	12
158	1	4	9	Albaladejo	13
159	1	4	4	Almedinilla	14
160	1	4	7	Ares	15
161	1	4	0	Albaladejo del Cuende	16
162	1	4	6	Albons	17
163	1	4	2	Albondón	18
164	1	4	5	Alaminos	19
165	1	4	9	Albiztur	20
166	1	4	6	Almonaster la Real	21
167	1	4	1	Agüero	22
168	1	4	7	Aldeaquemada	23
169	1	4	2	Almanza	24
170	1	4	5	Alamús, Els	25
171	1	4	8	Ajamil de Cameros	26
172	1	4	4	Baleira	27
173	1	4	0	Álamo, El	28
174	1	4	3	Alfarnatejo	29
175	1	4	7	Albudeite	30
176	1	4	4	Abaurrepea/Abaurrea Baja	31
177	1	4	9	Avión	32
178	1	4	5	Avilés	33
179	1	4	0	Aguilar de Campoo	34
180	1	4	3	Arrecife	35
181	1	4	6	Bueu	36
182	1	4	2	Ahigal de Villarino	37
183	1	4	8	Arafo	38
184	1	4	1	Arenas de Iguña	39
185	1	4	5	Aguilafuente	40
186	1	4	2	Alcalá de Guadaíra	41
187	1	4	7	Ágreda	42
188	1	4	3	Alcanar	43
189	1	4	8	Aguaviva	44
190	1	4	1	Alcabón	45
191	1	4	4	Agullent	46
192	1	4	0	Alaejos	47
193	1	4	6	Amoroto	48
194	1	4	9	Alcubilla de Nogales	49
195	1	4	2	Aguarón	50
196	1	5	8	Alborea	2
197	1	5	4	Albatera	3
198	1	5	9	Alboloduy	4
199	1	5	2	Albornos	5
200	1	5	5	Albuera, La	6
201	1	5	1	Andratx	7
202	1	5	7	Ametlla del Vallès	8
203	1	5	4	Aceituna	10
204	1	5	1	Algodonales	11
205	1	5	6	Alcora	12
206	1	5	2	Alcázar de San Juan	13
207	1	5	7	Almodóvar del Río	14
208	1	5	0	Arteixo	15
209	1	5	3	Albalate de las Nogueras	16
210	1	5	9	Far de Empordà, El	17
211	1	5	5	Albuñán	18
212	1	5	8	Alarilla	19
213	1	5	2	Alegia	20
214	1	5	9	Almonte	21
215	1	5	0	Andújar	23
216	1	5	5	Antigua, La	24
217	1	5	8	Alàs i Cerc	25
218	1	5	1	Albelda de Iregua	26
219	1	5	7	Barreiros	27
220	1	5	3	Alcalá de Henares	28
221	1	5	6	Algarrobo	29
222	1	5	0	Alcantarilla	30
223	1	5	7	Aberin	31
224	1	5	2	Baltar	32
225	1	5	8	Belmonte de Miranda	33
226	1	5	3	Alar del Rey	34
227	1	5	6	Artenara	35
228	1	5	9	Caldas de Reis	36
229	1	5	5	Alameda de Gardón, La	37
230	1	5	1	Arico	38
231	1	5	4	Argoños	39
232	1	5	8	Alconada de Maderuelo	40
233	1	5	5	Alcalá del Río	41
234	1	5	6	Alcover	43
235	1	5	1	Aguilar del Alfambra	44
236	1	5	4	Alcañizo	45
237	1	5	7	Alaquàs	46
238	1	5	3	Alcazarén	47
239	1	5	9	Arakaldo	48
240	1	5	2	Alfaraz de Sayago	49
241	1	5	5	Aguilón	50
242	1	6	6	Armiñón	1
243	1	6	1	Alcadozo	2
244	1	6	7	Alcalalí	3
245	1	6	2	Albox	4
246	1	6	8	Alburquerque	6
247	1	6	4	Artà	7
248	1	6	0	Arenys de Mar	8
249	1	6	3	Aguas Cándidas	9
250	1	6	7	Ahigal	10
251	1	6	4	Arcos de la Frontera	11
252	1	6	9	Alcudia de Veo	12
253	1	6	5	Alcoba	13
254	1	6	0	Añora	14
255	1	6	3	Arzúa	15
256	1	6	6	Albendea	16
257	1	6	2	Alp	17
258	1	6	8	Albuñol	18
259	1	6	1	Albalate de Zorita	19
260	1	6	5	Alkiza	20
261	1	6	2	Alosno	21
262	1	6	7	Aisa	22
263	1	6	3	Arjona	23
264	1	6	8	Ardón	24
265	1	6	1	Albagés	25
266	1	6	4	Alberite	26
267	1	6	0	Becerreá	27
268	1	6	6	Alcobendas	28
269	1	6	9	Algatocín	29
270	1	6	3	Aledo	30
271	1	6	0	Ablitas	31
272	1	6	5	Bande	32
273	1	6	1	Bimenes	33
274	1	6	6	Alba de Cerrato	34
275	1	6	9	Arucas	35
276	1	6	2	Cambados	36
277	1	6	8	La Alamedilla	37
278	1	6	4	Arona	38
279	1	6	7	Arnuero	39
280	1	6	1	Aldealcorvo	40
281	1	6	8	Alcolea del Río	41
282	1	6	3	Alconaba	42
283	1	6	9	Aldover	43
284	1	6	4	Alacón	44
285	1	6	7	Alcaudete de la Jara	45
286	1	6	0	Albaida	46
287	1	6	6	Aldea de San Miguel	47
288	1	6	2	Arantzazu	48
289	1	6	5	Algodre	49
290	1	6	8	Ainzón	50
291	1	7	7	Alcalá del Júcar	2
292	1	7	3	Alcocer de Planes	3
293	1	7	8	Alcolea	4
294	1	7	1	Aldeanueva de Santa Cruz	5
295	1	7	4	Alconchel	6
296	1	7	0	Banyalbufar	7
297	1	7	6	Arenys de Munt	8
298	1	7	9	Aguilar de Bureba	9
299	1	7	3	Albalá	10
300	1	7	0	Barbate	11
301	1	7	5	Alfondeguilla	12
302	1	7	1	Alcolea de Calatrava	13
303	1	7	6	Baena	14
304	1	7	9	A Baña	15
305	1	7	2	La Alberca de Záncara	16
306	1	7	8	Amer	17
307	1	7	4	Albuñuelas	18
308	1	7	7	Albares	19
309	1	7	1	Altzo	20
310	1	7	8	Aracena	21
311	1	7	3	Albalate de Cinca	22
312	1	7	9	Arjonilla	23
313	1	7	4	Arganza	24
314	1	7	7	Albatàrrec	25
315	1	7	0	Alcanadre	26
316	1	7	6	Begonte	27
317	1	7	2	Alcorcón	28
318	1	7	5	Alhaurín de la Torre	29
319	1	7	9	Alguazas	30
320	1	7	6	Adiós	31
321	1	7	1	Baños de Molgas	32
322	1	7	7	Boal	33
323	1	7	5	Betancuria	35
324	1	7	8	Campo Lameiro	36
325	1	7	4	Alaraz	37
326	1	7	0	Barlovento	38
327	1	7	3	Arredondo	39
328	1	7	7	Aldealengua de Pedraza	40
329	1	7	4	La Algaba	41
330	1	7	9	Alcubilla de Avellaneda	42
331	1	7	5	Aleixar	43
332	1	7	0	Alba	44
333	1	7	3	Alcolea de Tajo	45
334	1	7	6	Albal	46
335	1	7	2	Aldeamayor de San Martín	47
336	1	7	8	Munitibar-Arbatzegi Gerrikaitz	48
337	1	7	1	Almaraz de Duero	49
338	1	7	4	Aladrén	50
339	1	8	8	Arrazua-Ubarrundia	1
340	1	8	3	Alcaraz	2
341	1	8	9	Alcoleja	3
342	1	8	4	Alcóntar	4
343	1	8	7	Aldeaseca	5
344	1	8	0	Alconera	6
345	1	8	6	Binissalem	7
346	1	8	2	Argençola	8
347	1	8	9	Alcántara	10
348	1	8	6	Barrios, Los	11
349	1	8	1	Algimia de Almonacid	12
350	1	8	7	Alcubillas	13
351	1	8	2	Belalcázar	14
352	1	8	5	Bergondo	15
353	1	8	8	Alcalá de la Vega	16
354	1	8	4	Anglès	17
355	1	8	3	Albendiego	19
356	1	8	7	Amezketa	20
357	1	8	4	Aroche	21
358	1	8	9	Albalatillo	22
359	1	8	5	Arquillos	23
360	1	8	0	Astorga	24
361	1	8	3	Albesa	25
362	1	8	6	Aldeanueva de Ebro	26
363	1	8	2	Bóveda	27
364	1	8	8	Aldea del Fresno	28
365	1	8	1	Alhaurín el Grande	29
366	1	8	5	Alhama de Murcia	30
367	1	8	2	Aguilar de Codés	31
368	1	8	7	Barbadás	32
369	1	8	3	Cabrales	33
370	1	8	1	Firgas	35
371	1	8	4	Cangas	36
372	1	8	0	Alba de Tormes	37
373	1	8	6	Breña Alta	38
374	1	8	9	Astillero, El	39
375	1	8	3	Aldealengua de Santa María	40
376	1	8	0	Algámitas	41
377	1	8	5	Alcubilla de las Peñas	42
378	1	8	1	Alfara de Carles	43
379	1	8	6	Albalate del Arzobispo	44
380	1	8	9	Aldea en Cabo	45
381	1	8	2	Albalat de la Ribera	46
382	1	8	8	Almenara de Adaja	47
383	1	8	4	Artzentales	48
384	1	8	7	Almeida de Sayago	49
385	1	8	0	Alagón	50
386	1	9	1	Asparrena	1
387	1	9	6	Almansa	2
388	1	9	2	Alcoy/Alcoi	3
389	1	9	7	Alcudia de Monteagud	4
390	1	9	3	Aljucén	6
391	1	9	9	Búger	7
392	1	9	5	Argentona	8
393	1	9	8	Albillos	9
394	1	9	2	Alcollarín	10
395	1	9	9	Benaocaz	11
396	1	9	4	Almazora/Almassora	12
397	1	9	0	Aldea del Rey	13
398	1	9	5	Belmez	14
399	1	9	8	Betanzos	15
400	1	9	1	Alcantud	16
401	1	9	7	Arbúcies	17
402	1	9	6	Alcocer	19
403	1	9	0	Andoain	20
404	1	9	7	Arroyomolinos de León	21
405	1	9	2	Albelda	22
406	1	9	8	Baeza	23
407	1	9	3	Balboa	24
408	1	9	6	Albi	25
409	1	9	9	Alesanco	26
410	1	9	5	Carballedo	27
411	1	9	1	Algete	28
412	1	9	4	Almáchar	29
413	1	9	8	Archena	30
414	1	9	5	Aibar/Oibar	31
415	1	9	0	O Barco de Valdeorras	32
416	1	9	6	Cabranes	33
417	1	9	1	Amayuelas de Arriba	34
418	1	9	4	Gáldar	35
419	1	9	7	A Cañiza	36
420	1	9	3	Alba de Yeltes	37
421	1	9	9	Breña Baja	38
422	1	9	2	Bárcena de Cicero	39
423	1	9	6	Aldeanueva de la Serrezuela	40
424	1	9	3	Almadén de la Plata	41
425	1	9	8	Aldealafuente	42
426	1	9	4	Alforja	43
427	1	9	9	Albarracín	44
428	1	9	2	Aldeanueva de Barbarroya	45
429	1	9	5	Albalat dels Sorells	46
430	1	9	1	Amusquillo	47
431	1	9	7	Arrankudiaga	48
432	1	9	0	Andavías	49
433	1	9	3	Alarba	50
434	1	10	5	Ayala/Aiara	1
435	1	10	0	Alpera	2
436	1	10	6	Alfafara	3
437	1	10	1	Alhabia	4
438	1	10	4	La Aldehuela	5
439	1	10	7	Almendral	6
440	1	10	3	Bunyola	7
441	1	10	9	Artés	8
442	1	10	2	Alcocero de Mola	9
443	1	10	6	Alcuéscar	10
444	1	10	3	Bornos	11
445	1	10	8	Almedíjar	12
446	1	10	4	Alhambra	13
447	1	10	9	Benamejí	14
448	1	10	2	Boimorto	15
449	1	10	5	Alcázar del Rey	16
450	1	10	1	Argelaguer	17
451	1	10	7	Aldeire	18
452	1	10	0	Alcolea de las Peñas	19
453	1	10	4	Anoeta	20
454	1	10	1	Ayamonte	21
455	1	10	2	Bailén	23
456	1	10	7	La Bañeza	24
457	1	10	0	Alcanó	25
458	1	10	3	Alesón	26
459	1	10	9	Castro de Rei	27
460	1	10	5	Alpedrete	28
461	1	10	8	Almargen	29
462	1	10	2	Beniel	30
463	1	10	9	Altsasu/Alsasua	31
464	1	10	4	Beade	32
465	1	10	0	Candamo	33
466	1	10	5	Ampudia	34
467	1	10	8	Haría	35
468	1	10	1	Catoira	36
469	1	10	7	La Alberca	37
470	1	10	3	Buenavista del Norte	38
471	1	10	6	Bárcena de Pie de Concha	39
472	1	10	0	Aldeanueva del Codonal	40
473	1	10	7	Almensilla	41
474	1	10	2	Aldealices	42
475	1	10	8	Alió	43
476	1	10	3	Albentosa	44
477	1	10	6	Aldeanueva de San Bartolomé	45
478	1	10	9	Albalat dels Tarongers	46
479	1	10	5	Arroyo de la Encomienda	47
480	1	10	1	Arrieta	48
481	1	10	4	Arcenillas	49
482	1	10	7	Alberite de San Juan	50
483	1	11	2	Baños de Ebro/Mañueta	1
484	1	11	7	Ayna	2
485	1	11	3	Alfàs del Pi	3
486	1	11	8	Alhama de Almería	4
487	1	11	4	Almendralejo	6
488	1	11	0	Calvià	7
489	1	11	6	Avià	8
490	1	11	9	Alfoz de Bricia	9
491	1	11	3	Aldeacentenera	10
492	1	11	0	Bosque, El	11
493	1	11	5	Almenara	12
494	1	11	1	Almadén	13
495	1	11	6	Blázquez, Los	14
496	1	11	9	Boiro	15
497	1	11	2	Alcohujate	16
498	1	11	8	Armentera	17
499	1	11	4	Alfacar	18
500	1	11	7	Alcolea del Pinar	19
501	1	11	1	Antzuola	20
502	1	11	8	Beas	21
503	1	11	3	Albero Alto	22
504	1	11	9	Baños de la Encina	23
505	1	11	4	Barjas	24
506	1	11	7	Alcarràs	25
507	1	11	0	Alfaro	26
508	1	11	6	Castroverde	27
509	1	11	2	Ambite	28
510	1	11	5	Almogía	29
511	1	11	9	Blanca	30
512	1	11	6	Allín/Allin	31
513	1	11	1	Beariz	32
514	1	11	7	Cangas del Narcea	33
515	1	11	2	Amusco	34
516	1	11	5	Ingenio	35
517	1	11	8	Cerdedo	36
518	1	11	4	Alberguería de Argañán, La	37
519	1	11	0	Candelaria	38
520	1	11	3	Bareyo	39
521	1	11	4	Arahal	41
522	1	11	9	Aldealpozo	42
523	1	11	5	Almoster	43
524	1	11	0	Alcaine	44
525	1	11	3	Almendral de la Cañada	45
526	1	11	6	Alberic	46
527	1	11	2	Ataquines	47
528	1	11	8	Arrigorriaga	48
529	1	11	1	Arcos de la Polvorosa	49
530	1	11	4	Albeta	50
531	1	12	2	Balazote	2
532	1	12	8	Algorfa	3
533	1	12	3	Alicún	4
534	1	12	6	Amavida	5
535	1	12	9	Arroyo de San Serván	6
536	1	12	5	Campanet	7
537	1	12	1	Avinyó	8
538	1	12	4	Alfoz de Santa Gadea	9
539	1	12	8	Aldea del Cano	10
540	1	12	5	Cádiz	11
541	1	12	0	Altura	12
542	1	12	6	Almadenejos	13
543	1	12	1	Bujalance	14
544	1	12	4	Boqueixón	15
545	1	12	7	Alconchel de la Estrella	16
546	1	12	3	Avinyonet de Puigventós	17
547	1	12	9	Algarinejo	18
548	1	12	6	Arama	20
549	1	12	3	Berrocal	21
550	1	12	8	Albero Bajo	22
551	1	12	4	Beas de Segura	23
552	1	12	9	Barrios de Luna, Los	24
553	1	12	2	Alcoletge	25
554	1	12	5	Almarza de Cameros	26
555	1	12	1	Cervantes	27
556	1	12	7	Anchuelo	28
557	1	12	0	Álora	29
558	1	12	4	Bullas	30
559	1	12	1	Allo	31
560	1	12	6	Blancos, Os	32
561	1	12	2	Cangas de Onís	33
562	1	12	7	Antigüedad	34
563	1	12	0	Mogán	35
564	1	12	3	Cotobade	36
565	1	12	9	Alconada	37
566	1	12	5	Fasnia	38
567	1	12	8	Cabezón de la Sal	39
568	1	12	2	Aldea Real	40
569	1	12	9	Aznalcázar	41
570	1	12	4	Aldealseñor	42
571	1	12	0	Altafulla	43
572	1	12	5	Alcalá de la Selva	44
573	1	12	8	Almonacid de Toledo	45
574	1	12	1	Alborache	46
575	1	12	7	Bahabón	47
576	1	12	3	Bakio	48
577	1	12	6	Argañín	49
578	1	12	9	Alborge	50
579	1	13	3	Barrundia	1
580	1	13	8	Balsa de Ves	2
581	1	13	4	Algueña	3
582	1	13	9	Almería	4
583	1	13	2	Arenal, El	5
584	1	13	5	Atalaya	6
585	1	13	1	Campos	7
586	1	13	7	Avinyonet del Penedès	8
587	1	13	0	Altable	9
588	1	13	4	Aldea del Obispo, La	10
589	1	13	1	Castellar de la Frontera	11
590	1	13	6	Arañuel	12
591	1	13	2	Almagro	13
592	1	13	7	Cabra	14
593	1	13	0	Brión	15
594	1	13	3	Algarra	16
595	1	13	9	Begur	17
596	1	13	5	Alhama de Granada	18
597	1	13	8	Alcoroches	19
598	1	13	2	Aretxabaleta	20
599	1	13	9	Bollullos Par del Condado	21
600	1	13	4	Alberuela de Tubo	22
601	1	13	8	Alfarràs	25
602	1	13	1	Anguciana	26
603	1	13	7	Cervo	27
604	1	13	3	Aranjuez	28
605	1	13	6	Alozaina	29
606	1	13	0	Calasparra	30
607	1	13	7	Améscoa Baja	31
608	1	13	2	Boborás	32
609	1	13	8	Caravia	33
610	1	13	6	Moya	35
611	1	13	9	Covelo	36
612	1	13	5	Aldeacipreste	37
613	1	13	1	Frontera	38
614	1	13	4	Cabezón de Liébana	39
615	1	13	8	Aldeasoña	40
616	1	13	5	Aznalcóllar	41
617	1	13	0	Aldehuela de Periáñez	42
618	1	13	6	Ametlla de Mar, 	43
619	1	13	1	Alcañiz	44
620	1	13	4	Almorox	45
621	1	13	7	Alboraya	46
622	1	13	3	Barcial de la Loma	47
623	1	13	9	Barakaldo	48
624	1	13	2	Argujillo	49
625	1	13	5	Alcalá de Ebro	50
626	1	14	8	Berantevilla	1
627	1	14	3	Ballestero, El	2
628	1	14	9	Alicante/Alacant	3
629	1	14	4	Almócita	4
630	1	14	7	Arenas de San Pedro	5
631	1	14	0	Azuaga	6
632	1	14	6	Capdepera	7
633	1	14	2	Aiguafreda	8
634	1	14	5	Altos, Los	9
635	1	14	9	Aldeanueva de la Vera	10
636	1	14	6	Conil de la Frontera	11
637	1	14	1	Ares del Maestrat	12
638	1	14	7	Almedina	13
639	1	14	2	Cañete de las Torres	14
640	1	14	5	Cabana de Bergantiños	15
641	1	14	8	Aliaguilla	16
642	1	14	4	Vajol, La	17
643	1	14	0	Alhendín	18
644	1	14	7	Asteasu	20
645	1	14	4	Bonares	21
646	1	14	9	Alcalá de Gurrea	22
647	1	14	5	Begíjar	23
648	1	14	0	Bembibre	24
649	1	14	3	Alfés	25
650	1	14	6	Anguiano	26
651	1	14	2	Corgo, O	27
652	1	14	8	Arganda del Rey	28
653	1	14	1	Alpandeire	29
654	1	14	5	Campos del Río	30
655	1	14	2	Ancín/Antzin	31
656	1	14	7	Bola, A	32
657	1	14	3	Carreño	33
658	1	14	1	Oliva, La	35
659	1	14	4	Crecente	36
660	1	14	0	Aldeadávila de la Ribera	37
661	1	14	6	Fuencaliente de la Palma	38
662	1	14	9	Cabuérniga	39
663	1	14	3	Aldehorno	40
664	1	14	0	Badolatosa	41
665	1	14	5	Aldehuelas, Las	42
666	1	14	1	Amposta	43
667	1	14	6	Alcorisa	44
668	1	14	9	Añover de Tajo	45
669	1	14	2	Albuixech	46
670	1	14	8	Barruelo del Valle	47
671	1	14	4	Barrika	48
672	1	14	7	Arquillinos	49
673	1	14	0	Alcalá de Moncayo	50
674	1	15	6	Barrax	2
675	1	15	2	Almoradí	3
676	1	15	7	Alsodux	4
677	1	15	0	Arevalillo	5
678	1	15	3	Badajoz	6
679	1	15	9	Ciutadella de Menorca	7
680	1	15	5	Badalona	8
681	1	15	2	Aldeanueva del Camino	10
682	1	15	9	Chiclana de la Frontera	11
683	1	15	4	Argelita	12
684	1	15	0	Almodóvar del Campo	13
685	1	15	5	Carcabuey	14
686	1	15	8	Cabanas	15
687	1	15	1	Almarcha, La	16
688	1	15	7	Banyoles	17
689	1	15	3	Alicún de Ortega	18
690	1	15	6	Aldeanueva de Guadalajara	19
691	1	15	0	Ataun	20
692	1	15	7	Cabezas Rubias	21
693	1	15	2	Alcalá del Obispo	22
694	1	15	8	Bélmez de la Moraleda	23
695	1	15	3	Benavides	24
696	1	15	6	Algerri	25
697	1	15	9	Arenzana de Abajo	26
698	1	15	5	Cospeito	27
699	1	15	1	Arroyomolinos	28
700	1	15	4	Antequera	29
701	1	15	8	Caravaca de la Cruz	30
702	1	15	5	Andosilla	31
703	1	15	0	Bolo, O	32
704	1	15	6	Caso	33
705	1	15	1	Arconada	34
706	1	15	4	Pájara	35
707	1	15	7	Cuntis	36
708	1	15	3	Aldea del Obispo	37
709	1	15	9	Garachico	38
710	1	15	2	Camaleño	39
711	1	15	6	Aldehuela del Codonal	40
712	1	15	3	Benacazón	41
713	1	15	8	Alentisque	42
714	1	15	4	Arbolí	43
715	1	15	2	Arcicóllar	45
716	1	15	5	Alcàsser	46
717	1	15	1	Becilla de Valderaduey	47
718	1	15	7	Basauri	48
719	1	15	0	Arrabalde	49
720	1	15	3	Alconchel de Ariza	50
721	1	16	4	Bernedo	1
722	1	16	9	Bienservida	2
723	1	16	5	Almudaina	3
724	1	16	0	Antas	4
725	1	16	3	Arévalo	5
726	1	16	6	Barcarrota	6
727	1	16	2	Consell	7
728	1	16	8	Bagà	8
729	1	16	1	Ameyugo	9
730	1	16	5	Aldehuela de Jerte	10
731	1	16	2	Chipiona	11
732	1	16	7	Artana	12
733	1	16	3	Almuradiel	13
734	1	16	8	Cardeña	14
735	1	16	1	Camariñas	15
736	1	16	4	Almendros	16
737	1	16	0	Bàscara	17
738	1	16	6	Almegíjar	18
739	1	16	9	Algar de Mesa	19
740	1	16	3	Aia	20
741	1	16	0	Cala	21
742	1	16	5	Alcampell	22
743	1	16	1	Benatae	23
744	1	16	6	Benuza	24
745	1	16	9	Alguaire	25
746	1	16	2	Arenzana de Arriba	26
747	1	16	8	Chantada	27
748	1	16	4	Atazar, El	28
749	1	16	7	Árchez	29
750	1	16	1	Cartagena	30
751	1	16	8	Ansoáin/Antsoain	31
752	1	16	3	Calvos de Randín	32
753	1	16	9	Castrillón	33
754	1	16	7	Palmas de Gran Canaria, Las	35
755	1	16	0	Dozón	36
756	1	16	6	Aldealengua	37
757	1	16	2	Garafía	38
758	1	16	5	Camargo	39
759	1	16	9	Aldeonte	40
760	1	16	6	Bollullos de la Mitación	41
761	1	16	1	Aliud	42
762	1	16	7	Arboç, 	43
763	1	16	2	Alfambra	44
764	1	16	5	Argés	45
765	1	16	8	Alcàntera de Xúquer	46
766	1	16	4	Benafarces	47
767	1	16	0	Berango	48
768	1	16	3	Aspariegos	49
769	1	16	6	Aldehuela de Liestos	50
770	1	17	0	Campezo/Kanpezu	1
771	1	17	5	Bogarra	2
772	1	17	1	Alqueria de Asnar	3
773	1	17	6	Arboleas	4
774	1	17	9	Aveinte	5
775	1	17	2	Baterno	6
776	1	17	8	Costitx	7
777	1	17	4	Balenyà	8
778	1	17	7	Anguix	9
779	1	17	1	Alía	10
780	1	17	8	Espera	11
781	1	17	3	Ayódar	12
782	1	17	9	Anchuras	13
783	1	17	4	Carlota, La	14
784	1	17	7	Cambre	15
785	1	17	0	Almodóvar del Pinar	16
786	1	17	2	Almuñécar	18
787	1	17	5	Algora	19
788	1	17	9	Azkoitia	20
789	1	17	6	Calañas	21
790	1	17	1	Alcolea de Cinca	22
791	1	17	7	Cabra del Santo Cristo	23
792	1	17	2	Bercianos del Páramo	24
793	1	17	5	Alins	25
794	1	17	8	Arnedillo	26
795	1	17	4	Folgoso do Courel	27
796	1	17	0	Batres	28
797	1	17	3	Archidona	29
798	1	17	7	Cehegín	30
799	1	17	4	Anue	31
800	1	17	9	Carballeda de Valdeorras	32
801	1	17	5	Castropol	33
802	1	17	0	Astudillo	34
803	1	17	3	Puerto del Rosario	35
804	1	17	6	Estrada, A	36
805	1	17	2	Aldeanueva de Figueroa	37
806	1	17	8	Granadilla de Abona	38
807	1	17	1	Campoo de Yuso	39
808	1	17	5	Anaya	40
809	1	17	2	Bormujos	41
810	1	17	7	Almajano	42
811	1	17	3	Argentera, 	43
812	1	17	8	Aliaga	44
813	1	17	1	Azután	45
814	1	17	4	Alzira	46
815	1	17	0	Bercero	47
816	1	17	6	Bermeo	48
817	1	17	9	Asturianos	49
818	1	17	2	Alfajarín	50
819	1	18	6	Zigoitia	1
820	1	18	1	Bonete	2
821	1	18	7	Altea	3
822	1	18	2	Armuña de Almanzora	4
823	1	18	5	Avellaneda	5
824	1	18	8	Benquerencia de la Serena	6
825	1	18	4	Deyá	7
826	1	18	0	Balsareny	8
827	1	18	3	Aranda de Duero	9
828	1	18	7	Aliseda	10
829	1	18	4	Gastor, El	11
830	1	18	9	Azuébar	12
831	1	18	5	Arenas de San Juan	13
832	1	18	0	Carpio, El	14
833	1	18	3	Capela, A	15
834	1	18	6	Almonacid del Marquesado	16
835	1	18	2	Bellcaire de Empordà	17
836	1	18	8	Alquife	18
837	1	18	1	Alhóndiga	19
838	1	18	5	Azpeitia	20
839	1	18	2	Campillo, El	21
840	1	18	7	Alcubierre	22
841	1	18	3	Cambil	23
842	1	18	8	Bercianos del Real Camino	24
843	1	18	4	Arnedo	26
844	1	18	0	Fonsagrada, A	27
845	1	18	6	Becerril de la Sierra	28
846	1	18	9	Ardales	29
847	1	18	3	Ceutí	30
848	1	18	0	Añorbe	31
849	1	18	5	Carballeda de Avia	32
850	1	18	1	Coaña	33
851	1	18	6	Autilla del Pino	34
852	1	18	9	San Bartolomé	35
853	1	18	2	Forcarei	36
854	1	18	8	Aldeanueva de la Sierra	37
855	1	18	4	Guancha, La	38
856	1	18	7	Cartes	39
857	1	18	1	Añe	40
858	1	18	8	Brenes	41
859	1	18	3	Almaluez	42
860	1	18	9	Arnes	43
861	1	18	4	Almohaja	44
862	1	18	7	Barcience	45
863	1	18	0	Alcublas	46
864	1	18	6	Berceruelo	47
865	1	18	2	Berriatua	48
866	1	18	5	Ayoó de Vidriales	49
867	1	18	8	Alfamén	50
868	1	19	9	Kripan	1
869	1	19	4	Bonillo, El	2
870	1	19	0	Aspe	3
871	1	19	5	Bacares	4
872	1	19	8	Ávila	5
873	1	19	1	Berlanga	6
874	1	19	7	Escorca	7
875	1	19	3	Barcelona	8
876	1	19	6	Arandilla	9
877	1	19	0	Almaraz	10
878	1	19	7	Grazalema	11
879	1	19	8	Argamasilla de Alba	13
880	1	19	3	Castro del Río	14
881	1	19	6	Carballo	15
882	1	19	9	Altarejos	16
883	1	19	5	Besalú	17
884	1	19	4	Alique	19
885	1	19	8	Beasain	20
886	1	19	5	Campofrío	21
887	1	19	0	Alerre	22
888	1	19	6	Campillo de Arenas	23
889	1	19	1	Berlanga del Bierzo	24
890	1	19	4	Almacelles	25
891	1	19	7	Arrúbal	26
892	1	19	3	Foz	27
893	1	19	9	Belmonte de Tajo	28
894	1	19	2	Arenas	29
895	1	19	6	Cieza	30
896	1	19	3	Aoiz/Agoitz	31
897	1	19	8	Carballiño, O	32
898	1	19	4	Colunga	33
899	1	19	9	Autillo de Campos	34
900	1	19	2	San Bartolomé de Tirajana	35
901	1	19	5	Fornelos de Montes	36
902	1	19	1	Aldearrodrigo	37
903	1	19	7	Guía de Isora	38
904	1	19	0	Castañeda	39
905	1	19	4	Arahuetes	40
906	1	19	1	Burguillos	41
907	1	19	6	Almarza	42
908	1	19	2	Ascó	43
909	1	19	7	Alobras	44
910	1	19	0	Bargas	45
911	1	19	3	Alcúdia, 	46
912	1	19	9	Berrueces	47
913	1	19	5	Berriz	48
914	1	19	8	Barcial del Barco	49
915	1	19	1	Alforque	50
916	1	20	3	Kuartango	1
917	1	20	8	Carcelén	2
918	1	20	4	Balones	3
919	1	20	9	Bayárcal	4
920	1	20	5	Bienvenida	6
921	1	20	1	Esporles	7
922	1	20	7	Begues	8
923	1	20	0	Arauzo de Miel	9
924	1	20	4	Almoharín	10
925	1	20	1	Jerez de la Frontera	11
926	1	20	6	Barracas	12
927	1	20	2	Argamasilla de Calatrava	13
928	1	20	7	Conquista	14
929	1	20	0	Carnota	15
930	1	20	3	Arandilla del Arroyo	16
931	1	20	9	Bescanó	17
932	1	20	5	Arenas del Rey	18
933	1	20	8	Almadrones	19
934	1	20	2	Beizama	20
935	1	20	9	Cañaveral de León	21
936	1	20	4	Alfántega	22
937	1	20	0	Canena	23
938	1	20	5	Boca de Huérgano	24
939	1	20	8	Almatret	25
940	1	20	1	Ausejo	26
941	1	20	7	Friol	27
942	1	20	3	Berzosa del Lozoya	28
943	1	20	6	Arriate	29
944	1	20	0	Fortuna	30
945	1	20	7	Araitz	31
946	1	20	2	Cartelle	32
947	1	20	8	Corvera de Asturias	33
948	1	20	3	Ayuela	34
949	1	20	6	Aldea de San Nicolás, La	35
950	1	20	9	Agolada	36
951	1	20	5	Aldearrubia	37
952	1	20	1	Güímar	38
953	1	20	4	Castro-Urdiales	39
954	1	20	8	Arcones	40
955	1	20	5	Cabezas de San Juan, Las	41
956	1	20	0	Almazán	42
957	1	20	6	Banyeres del Penedès	43
958	1	20	1	Alpeñés	44
959	1	20	4	Belvís de la Jara	45
960	1	20	7	Alcúdia de Crespins, 	46
961	1	20	3	Bobadilla del Campo	47
962	1	20	9	Bilbao	48
963	1	20	2	Belver de los Montes	49
964	1	20	5	Alhama de Aragón	50
965	1	21	0	Elburgo/Burgelu	1
966	1	21	5	Casas de Juan Núñez	2
967	1	21	1	Banyeres de Mariola	3
968	1	21	6	Bayarque	4
969	1	21	9	Barco de Ávila, El	5
970	1	21	2	Bodonal de la Sierra	6
971	1	21	8	Estellencs	7
972	1	21	4	Bellprat	8
973	1	21	7	Arauzo de Salce	9
974	1	21	1	Arroyo de la Luz	10
975	1	21	8	Jimena de la Frontera	11
976	1	21	3	Betxí	12
977	1	21	9	Arroba de los Montes	13
978	1	21	4	Córdoba	14
979	1	21	7	Carral	15
980	1	21	6	Beuda	17
981	1	21	2	Armilla	18
982	1	21	5	Almoguera	19
983	1	21	9	Belauntza	20
984	1	21	6	Cartaya	21
985	1	21	1	Almudévar	22
986	1	21	7	Carboneros	23
987	1	21	2	Boñar	24
988	1	21	5	Almenar	25
989	1	21	8	Autol	26
990	1	21	4	Xermade	27
991	1	21	0	Berrueco, El	28
992	1	21	3	Atajate	29
993	1	21	7	Fuente Álamo de Murcia	30
994	1	21	4	Aranarache/Aranaratxe	31
995	1	21	9	Castrelo do Val	32
996	1	21	5	Cudillero	33
997	1	21	3	Santa Brígida	35
998	1	21	6	Gondomar	36
999	1	21	2	Aldeaseca de Alba	37
1000	1	21	8	Hermigua	38
1001	1	21	1	Cieza	39
1002	1	21	5	Arevalillo de Cega	40
1003	1	21	2	Camas	41
1004	1	21	7	Almazul	42
1005	1	21	3	Barberà de la Conca	43
1006	1	21	8	Allepuz	44
1007	1	21	1	Borox	45
1008	1	21	4	Aldaia	46
1009	1	21	0	Bocigas	47
1010	1	21	6	Busturia	48
1011	1	21	9	Benavente	49
1012	1	21	2	Almochuel	50
1013	1	22	5	Elciego	1
1014	1	22	0	Casas de Lázaro	2
1015	1	22	6	Benasau	3
1016	1	22	1	Bédar	4
1017	1	22	4	Barraco, El	5
1018	1	22	7	Burguillos del Cerro	6
1019	1	22	3	Felanitx	7
1020	1	22	9	Berga	8
1021	1	22	2	Arauzo de Torre	9
1022	1	22	6	Arroyomolinos de la Vera	10
1023	1	22	3	Línea de la Concepción, La	11
1024	1	22	8	Bejís	12
1025	1	22	4	Ballesteros de Calatrava	13
1026	1	22	9	Doña Mencía	14
1027	1	22	2	Cedeira	15
1028	1	22	5	Arcos de la Sierra	16
1029	1	22	1	La Bisbal de Empordà	17
1030	1	22	7	Atarfe	18
1031	1	22	0	Almonacid de Zorita	19
1032	1	22	4	Berastegi	20
1033	1	22	1	Castaño del Robledo	21
1034	1	22	6	Almunia de San Juan	22
1035	1	22	7	Borrenes	24
1036	1	22	0	Alòs de Balaguer	25
1037	1	22	3	Azofra	26
1038	1	22	9	Guitiriz	27
1039	1	22	5	Boadilla del Monte	28
1040	1	22	8	Benadalid	29
1041	1	22	2	Jumilla	30
1042	1	22	9	Arantza	31
1043	1	22	4	Castrelo de Miño	32
1044	1	22	0	Degaña	33
1045	1	22	5	Baltanás	34
1046	1	22	8	Santa Lucía de Tirajana	35
1047	1	22	1	Grove, O	36
1048	1	22	7	Aldeaseca de la Frontera	37
1049	1	22	3	Icod de los Vinos	38
1050	1	22	6	Cillorigo de Liébana	39
1051	1	22	0	Armuña	40
1052	1	22	7	Campana, La	41
1053	1	22	2	Almenar de Soria	42
1054	1	22	8	Batea	43
1055	1	22	3	Alloza	44
1056	1	22	6	Buenaventura	45
1057	1	22	9	Alfafar	46
1058	1	22	5	Bocos de Duero	47
1059	1	22	1	Karrantza Harana/Valle de Carranza	48
1060	1	22	4	Benegiles	49
1061	1	22	7	Almolda, La	50
1062	1	23	1	Elvillar/Bilar	1
1063	1	23	6	Casas de Ves	2
1064	1	23	2	Beneixama	3
1065	1	23	7	Beires	4
1066	1	23	0	Barromán	5
1067	1	23	3	Cabeza del Buey	6
1068	1	23	9	Ferreries	7
1069	1	23	5	Bigues i Riells	8
1070	1	23	8	Arcos	9
1071	1	23	2	Arroyomolinos	10
1072	1	23	9	Medina-Sidonia	11
1073	1	23	0	Bolaños de Calatrava	13
1074	1	23	5	Dos Torres	14
1075	1	23	8	Cee	15
1076	1	23	1	Chillarón de Cuenca	16
1077	1	23	7	Blanes	17
1078	1	23	3	Baza	18
1079	1	23	6	Alocén	19
1080	1	23	0	Berrobi	20
1081	1	23	7	Cerro de Andévalo, El	21
1082	1	23	2	Almuniente	22
1083	1	23	3	Brazuelo	24
1084	1	23	6	Alpicat	25
1085	1	23	9	Badarán	26
1086	1	23	5	Guntín	27
1087	1	23	1	Boalo, El	28
1088	1	23	4	Benahavís	29
1089	1	23	8	Librilla	30
1090	1	23	5	Aranguren	31
1091	1	23	0	Castro Caldelas	32
1092	1	23	6	Franco, El	33
1093	1	23	1	Venta de Baños	34
1094	1	23	4	Santa María de Guía de Gran Canaria	35
1095	1	23	7	Guarda, A	36
1096	1	23	3	Aldeatejada	37
1097	1	23	9	San Cristóbal de La Laguna	38
1098	1	23	2	Colindres	39
1099	1	23	3	Cantillana	41
1100	1	23	8	Alpanseque	42
1101	1	23	4	Bellmunt del Priorat	43
1102	1	23	9	Allueva	44
1103	1	23	2	Burguillos de Toledo	45
1104	1	23	5	Alfauir	46
1105	1	23	1	Boecillo	47
1106	1	23	7	Artea	48
1107	1	23	0	Bermillo de Sayago	49
1108	1	23	3	Almonacid de la Cuba	50
1109	1	24	1	Casas-Ibáñez	2
1110	1	24	7	Benejúzar	3
1111	1	24	2	Benahadux	4
1112	1	24	5	Becedas	5
1113	1	24	8	Cabeza la Vaca	6
1114	1	24	4	Formentera	7
1115	1	24	0	Borredà	8
1116	1	24	3	Arenillas de Riopisuerga	9
1117	1	24	7	Baños de Montemayor	10
1118	1	24	4	Olvera	11
1119	1	24	9	Benafer	12
1120	1	24	5	Brazatortas	13
1121	1	24	0	Encinas Reales	14
1122	1	24	3	Cerceda	15
1123	1	24	6	Arguisuelas	16
1124	1	24	2	Bolvir	17
1125	1	24	8	Beas de Granada	18
1126	1	24	1	Alovera	19
1127	1	24	5	Bidegoian	20
1128	1	24	2	Corteconcepción	21
1129	1	24	7	Alquézar	22
1130	1	24	3	Carolina, La	23
1131	1	24	8	Burgo Ranero, El	24
1132	1	24	1	Alt Àneu	25
1133	1	24	4	Bañares	26
1134	1	24	0	Incio, O	27
1135	1	24	6	Braojos	28
1136	1	24	9	Benalauría	29
1137	1	24	3	Lorca	30
1138	1	24	0	Arano	31
1139	1	24	5	Celanova	32
1140	1	24	1	Gijón	33
1141	1	24	6	Baquerín de Campos	34
1142	1	24	9	Teguise	35
1143	1	24	2	Lalín	36
1144	1	24	8	Aldeavieja de Tormes	37
1145	1	24	4	Llanos de Aridane, Los	38
1146	1	24	7	Comillas	39
1147	1	24	1	Ayllón	40
1148	1	24	8	Carmona	41
1149	1	24	3	Arancón	42
1150	1	24	9	Bellvei	43
1151	1	24	4	Anadón	44
1152	1	24	7	Burujón	45
1153	1	24	0	Alfara de la Baronia	46
1154	1	24	6	Bolaños de Campos	47
1155	1	24	2	Zeanuri	48
1156	1	24	5	Bóveda de Toro, La	49
1157	1	24	8	Almonacid de la Sierra	50
1158	1	25	4	Caudete	2
1159	1	25	0	Benferri	3
1160	1	25	8	Becedillas	5
1161	1	25	1	Calamonte	6
1162	1	25	7	Fornalutx	7
1163	1	25	3	Bruc, El	8
1164	1	25	6	Arija	9
1165	1	25	0	Barrado	10
1166	1	25	7	Paterna de Rivera	11
1167	1	25	2	Benafigos	12
1168	1	25	8	Cabezarados	13
1169	1	25	3	Espejo	14
1170	1	25	6	Cerdido	15
1171	1	25	9	Arrancacepas	16
1172	1	25	5	Bordils	17
1173	1	25	1	Beas de Guadix	18
1174	1	25	8	Zegama	20
1175	1	25	5	Cortegana	21
1176	1	25	0	Altorricón	22
1177	1	25	6	Castellar	23
1178	1	25	1	Burón	24
1179	1	25	4	Naut Aran	25
1180	1	25	7	Baños de Rioja	26
1181	1	25	3	Xove	27
1182	1	25	9	Brea de Tajo	28
1183	1	25	2	Benalmádena	29
1184	1	25	6	Lorquí	30
1185	1	25	3	Arakil	31
1186	1	25	8	Cenlle	32
1187	1	25	4	Gozón	33
1188	1	25	9	Bárcena de Campos	34
1189	1	25	2	Tejeda	35
1190	1	25	5	Lama, A	36
1191	1	25	1	Aldehuela de la Bóveda	37
1192	1	25	7	Matanza de Acentejo, La	38
1193	1	25	0	Corrales de Buelna, Los	39
1194	1	25	4	Barbolla	40
1195	1	25	1	Carrión de los Céspedes	41
1196	1	25	6	Arcos de Jalón	42
1197	1	25	2	Benifallet	43
1198	1	25	7	Andorra	44
1199	1	25	0	Cabañas de la Sagra	45
1200	1	25	3	Alfara del Patriarca	46
1201	1	25	9	Brahojos de Medina	47
1202	1	25	5	Zeberio	48
1203	1	25	8	Bretó	49
1204	1	25	1	Almunia de Doña Godina, La	50
1205	1	26	7	Cenizate	2
1206	1	26	3	Beniarbeig	3
1207	1	26	8	Benitagla	4
1208	1	26	1	Bercial de Zapardiel	5
1209	1	26	4	Calera de León	6
1210	1	26	0	Eivissa	7
1211	1	26	6	Brull, El	8
1212	1	26	9	Arlanzón	9
1213	1	26	3	Belvís de Monroy	10
1214	1	26	0	Prado del Rey	11
1215	1	26	5	Benasal	12
1216	1	26	1	Cabezarrubias del Puerto	13
1217	1	26	6	Espiel	14
1218	1	26	9	Cesuras	15
1219	1	26	2	Atalaya del Cañavate	16
1220	1	26	8	Borrassà	17
1221	1	26	1	Zerain	20
1222	1	26	8	Cortelazor	21
1223	1	26	9	Castillo de Locubín	23
1224	1	26	4	Bustillo del Páramo	24
1225	1	26	0	Baños de Río Tobía	26
1226	1	26	6	Láncara	27
1227	1	26	2	Brunete	28
1228	1	26	5	Benamargosa	29
1229	1	26	9	Mazarrón	30
1230	1	26	6	Aras	31
1231	1	26	1	Coles	32
1232	1	26	7	Grado	33
1233	1	26	5	Telde	35
1234	1	26	8	Marín	36
1235	1	26	4	Aldehuela de Yeltes	37
1236	1	26	0	Orotava, La	38
1237	1	26	3	Corvera de Toranzo	39
1238	1	26	7	Basardilla	40
1239	1	26	4	Casariche	41
1240	1	26	9	Arenillas	42
1241	1	26	5	Benissanet	43
1242	1	26	0	Arcos de las Salinas	44
1243	1	26	3	Cabañas de Yepes	45
1244	1	26	6	Alfarp	46
1245	1	26	2	Bustillo de Chaves	47
1246	1	26	8	Dima	48
1247	1	26	1	Bretocino	49
1248	1	26	4	Alpartir	50
1249	1	27	8	Iruraiz-Gauna	1
1250	1	27	3	Corral-Rubio	2
1251	1	27	9	Beniardá	3
1252	1	27	4	Benizalón	4
1253	1	27	7	Berlanas, Las	5
1254	1	27	0	Calzadilla de los Barros	6
1255	1	27	6	Inca	7
1256	1	27	2	Cabanyes, Les	8
1257	1	27	5	Arraya de Oca	9
1258	1	27	9	Benquerencia	10
1259	1	27	6	Puerto de Santa María, El	11
1260	1	27	1	Benicarló	12
1261	1	27	7	Calzada de Calatrava	13
1262	1	27	2	Fernán-Núñez	14
1263	1	27	5	Coirós	15
1264	1	27	8	Barajas de Melo	16
1265	1	27	4	Breda	17
1266	1	27	0	Benalúa	18
1267	1	27	3	Alustante	19
1268	1	27	7	Zestoa	20
1269	1	27	4	Cumbres de Enmedio	21
1270	1	27	9	Angüés	22
1271	1	27	5	Cazalilla	23
1272	1	27	0	Cabañas Raras	24
1273	1	27	3	Anglesola	25
1274	1	27	6	Berceo	26
1275	1	27	2	Lourenzá	27
1276	1	27	8	Buitrago del Lozoya	28
1277	1	27	1	Benamocarra	29
1278	1	27	5	Molina de Segura	30
1279	1	27	2	Arbizu	31
1280	1	27	7	Cortegada	32
1281	1	27	3	Grandas de Salime	33
1282	1	27	8	Barruelo de Santullán	34
1283	1	27	1	Teror	35
1284	1	27	4	Meaño	36
1285	1	27	0	Almenara de Tormes	37
1286	1	27	6	Paso, El	38
1287	1	27	9	Campoo de Enmedio	39
1288	1	27	0	Castilblanco de los Arroyos	41
1289	1	27	5	Arévalo de la Sierra	42
1290	1	27	1	Bisbal de Falset, La	43
1291	1	27	6	Arens de Lledó	44
1292	1	27	9	Cabezamesada	45
1293	1	27	2	Alfarrasí	46
1294	1	27	8	Cabezón de Pisuerga	47
1295	1	27	4	Durango	48
1296	1	27	7	Brime de Sog	49
1297	1	27	0	Ambel	50
1298	1	28	4	Labastida/Bastida	1
1299	1	28	9	Cotillas	2
1300	1	28	5	Beniarrés	3
1301	1	28	0	Bentarique	4
1302	1	28	6	Campanario	6
1303	1	28	2	Lloret de Vistalegre	7
1304	1	28	8	Cabrera de Anoia	8
1305	1	28	5	Berrocalejo	10
1306	1	28	2	Puerto Real	11
1307	1	28	7	Benicasim/Benicàssim	12
1308	1	28	3	Campo de Criptana	13
1309	1	28	8	Fuente la Lancha	14
1310	1	28	1	Corcubión	15
1311	1	28	0	Brunyola	17
1312	1	28	6	Benalúa de las Villas	18
1313	1	28	3	Zizurkil	20
1314	1	28	0	Cumbres de San Bartolomé	21
1315	1	28	5	Ansó	22
1316	1	28	1	Cazorla	23
1317	1	28	6	Cabreros del Río	24
1318	1	28	2	Bergasa	26
1319	1	28	8	Lugo	27
1320	1	28	4	Bustarviejo	28
1321	1	28	7	Benaoján	29
1322	1	28	1	Moratalla	30
1323	1	28	8	Arce/Artzi	31
1324	1	28	3	Cualedro	32
1325	1	28	9	Ibias	33
1326	1	28	4	Báscones de Ojeda	34
1327	1	28	7	Tías	35
1328	1	28	0	Meis	36
1329	1	28	6	Almendra	37
1330	1	28	2	Puerto de la Cruz	38
1331	1	28	5	Entrambasaguas	39
1332	1	28	9	Bercial	40
1333	1	28	6	Castilleja de Guzmán	41
1334	1	28	1	Ausejo de la Sierra	42
1335	1	28	7	La Bisbal del Penedès	43
1336	1	28	2	Argente	44
1337	1	28	5	Calera y Chozas	45
1338	1	28	8	Algar de Palancia	46
1339	1	28	4	Cabezón de Valderaduey	47
1340	1	28	0	Ea	48
1341	1	28	3	Brime de Urz	49
1342	1	28	6	Anento	50
1343	1	29	2	Chinchilla de Monte-Aragón	2
1344	1	29	8	Benigembla	3
1345	1	29	3	Berja	4
1346	1	29	6	Bernuy-Zapardiel	5
1347	1	29	9	Campillo de Llerena	6
1348	1	29	5	Lloseta	7
1349	1	29	1	Cabrera de Mar	8
1350	1	29	4	Atapuerca	9
1351	1	29	8	Berzocana	10
1352	1	29	5	Puerto Serrano	11
1353	1	29	0	Benlloch	12
1354	1	29	6	Cañada de Calatrava	13
1355	1	29	1	Fuente Obejuna	14
1356	1	29	4	Coristanco	15
1357	1	29	7	Barchín del Hoyo	16
1358	1	29	3	Boadella i les Escaules	17
1359	1	29	9	Benamaurel	18
1360	1	29	6	Deba	20
1361	1	29	3	Cumbres Mayores	21
1362	1	29	8	Antillón	22
1363	1	29	4	Chiclana de Segura	23
1364	1	29	9	Cabrillanes	24
1365	1	29	2	Arbeca	25
1366	1	29	5	Bergasillas Bajera	26
1367	1	29	1	Meira	27
1368	1	29	7	Cabanillas de la Sierra	28
1369	1	29	0	Benarrabá	29
1370	1	29	4	Mula	30
1371	1	29	1	Los Arcos	31
1372	1	29	6	Chandrexa de Queixa	32
1373	1	29	2	Illano	33
1374	1	29	7	Becerril de Campos	34
1375	1	29	0	Tinajo	35
1376	1	29	3	Moaña	36
1377	1	29	9	Anaya de Alba	37
1378	1	29	5	Puntagorda	38
1379	1	29	8	Escalante	39
1380	1	29	2	Bercimuel	40
1381	1	29	9	Castilleja de la Cuesta	41
1382	1	29	4	Baraona	42
1383	1	29	0	Blancafort	43
1384	1	29	5	Ariño	44
1385	1	29	8	Caleruela	45
1386	1	29	1	Algemesí	46
1387	1	29	7	Cabreros del Monte	47
1388	1	29	3	Etxebarri	48
1389	1	29	6	Burganes de Valverde	49
1390	1	29	9	Aniñón	50
1391	1	30	1	Lagrán	1
1392	1	30	6	Elche de la Sierra	2
1393	1	30	2	Benidoleig	3
1394	1	30	7	Canjáyar	4
1395	1	30	0	Berrocalejo de Aragona	5
1396	1	30	3	Capilla	6
1397	1	30	9	Llubí	7
1398	1	30	5	Cabrils	8
1399	1	30	8	Los Ausines	9
1400	1	30	2	Bohonal de Ibor	10
1401	1	30	9	Rota	11
1402	1	30	0	Caracuel de Calatrava	13
1403	1	30	5	Fuente Palmera	14
1404	1	30	8	A Coruña	15
1405	1	30	1	Bascuñana de San Pedro	16
1406	1	30	7	Cabanes	17
1407	1	30	3	Bérchules	18
1408	1	30	0	Eibar	20
1409	1	30	7	Chucena	21
1410	1	30	8	Chilluévar	23
1411	1	30	3	Cacabelos	24
1412	1	30	6	El Pont de Bar	25
1413	1	30	9	Bezares	26
1414	1	30	5	Mondoñedo	27
1415	1	30	1	La Cabrera	28
1416	1	30	4	El Borge	29
1417	1	30	8	Murcia	30
1418	1	30	5	Arellano	31
1419	1	30	0	Entrimo	32
1420	1	30	6	Illas	33
1421	1	30	4	Tuineje	35
1422	1	30	7	Mondariz	36
1423	1	30	3	Añover de Tormes	37
1424	1	30	9	Puntallana	38
1425	1	30	2	Guriezo	39
1426	1	30	6	Bernardos	40
1427	1	30	3	Castilleja del Campo	41
1428	1	30	8	Barca	42
1429	1	30	4	Bonastre	43
1430	1	30	2	Calzada de Oropesa	45
1431	1	30	5	Algimia de Alfara	46
1432	1	30	1	Campaspero	47
1433	1	30	7	Etxebarria	48
1434	1	30	0	Bustillo del Oro	49
1435	1	30	3	Añón de Moncayo	50
1436	1	31	8	Laguardia	1
1437	1	31	3	Férez	2
1438	1	31	9	Benidorm	3
1439	1	31	4	Cantoria	4
1440	1	31	0	Carmonita	6
1441	1	31	6	Llucmajor	7
1442	1	31	2	Calaf	8
1443	1	31	9	Botija	10
1444	1	31	6	San Fernando	11
1445	1	31	1	Borriol	12
1446	1	31	7	Carrión de Calatrava	13
1447	1	31	2	Fuente-Tójar	14
1448	1	31	5	Culleredo	15
1449	1	31	8	Beamud	16
1450	1	31	4	Cabanelles	17
1451	1	31	3	Angón	19
1452	1	31	7	Elduain	20
1453	1	31	4	Encinasola	21
1454	1	31	5	Escañuela	23
1455	1	31	0	Calzada del Coto	24
1456	1	31	3	Arres	25
1457	1	31	6	Bobadilla	26
1458	1	31	2	Monforte de Lemos	27
1459	1	31	8	Cadalso de los Vidrios	28
1460	1	31	1	El Burgo	29
1461	1	31	5	Ojós	30
1462	1	31	2	Areso	31
1463	1	31	7	Esgos	32
1464	1	31	3	Langreo	33
1465	1	31	8	Belmonte de Campos	34
1466	1	31	1	Valsequillo de Gran Canaria	35
1467	1	31	4	Mondariz-Balneario	36
1468	1	31	0	Arabayona de Mógica	37
1469	1	31	6	Los Realejos	38
1470	1	31	9	Hazas de Cesto	39
1471	1	31	3	Bernuy de Porreros	40
1472	1	31	0	El Castillo de las Guardas	41
1473	1	31	5	Barcones	42
1474	1	31	1	Les Borges del Camp	43
1475	1	31	6	Azaila	44
1476	1	31	9	Camarena	45
1477	1	31	2	Alginet	46
1478	1	31	8	El Campillo	47
1479	1	31	4	Elantxobe	48
1480	1	31	7	Cabañas de Sayago	49
1481	1	31	0	Aranda de Moncayo	50
1482	1	32	3	Lanciego/Lantziego	1
1483	1	32	8	Fuensanta	2
1484	1	32	4	Benifallim	3
1485	1	32	9	Carboneras	4
1486	1	32	5	El Carrascalejo	6
1487	1	32	1	Maó	7
1488	1	32	7	Caldes de Estrac	8
1489	1	32	0	Avellanosa de Muñó	9
1490	1	32	4	Brozas	10
1491	1	32	1	Sanlúcar de Barrameda	11
1492	1	32	6	Borriana/Burriana	12
1493	1	32	2	Carrizosa	13
1494	1	32	7	Granjuela, La	14
1495	1	32	0	Curtis	15
1496	1	32	3	Belinchón	16
1497	1	32	9	Cadaqués	17
1498	1	32	5	Bubión	18
1499	1	32	8	Anguita	19
1500	1	32	2	Elgoibar	20
1501	1	32	9	Escacena del Campo	21
1502	1	32	4	Aragüés del Puerto	22
1503	1	32	0	Espelúy	23
1504	1	32	5	Campazas	24
1505	1	32	8	Arsèguel	25
1506	1	32	1	Brieva de Cameros	26
1507	1	32	7	Monterroso	27
1508	1	32	3	Camarma de Esteruelas	28
1509	1	32	6	Campillos	29
1510	1	32	0	Pliego	30
1511	1	32	7	Arguedas	31
1512	1	32	2	Xinzo de Limia	32
1513	1	32	8	Laviana	33
1514	1	32	3	Berzosilla	34
1515	1	32	6	Valleseco	35
1516	1	32	9	Moraña	36
1517	1	32	5	Arapiles	37
1518	1	32	1	Rosario, El	38
1519	1	32	4	Hermandad de Campoo de Suso	39
1520	1	32	8	Boceguillas	40
1521	1	32	5	Cazalla de la Sierra	41
1522	1	32	0	Bayubas de Abajo	42
1523	1	32	6	Bot	43
1524	1	32	1	Bádenas	44
1525	1	32	4	Camarenilla	45
1526	1	32	7	Almàssera	46
1527	1	32	3	Camporredondo	47
1528	1	32	9	Elorrio	48
1529	1	32	2	Calzadilla de Tera	49
1530	1	32	5	Arándiga	50
1531	1	33	9	Lapuebla de Labarca	1
1532	1	33	4	Fuente-Álamo	2
1533	1	33	0	Benifato	3
1534	1	33	5	Castro de Filabres	4
1535	1	33	8	Blascomillán	5
1536	1	33	1	Casas de Don Pedro	6
1537	1	33	7	Manacor	7
1538	1	33	3	Caldes de Montbui	8
1539	1	33	6	Bahabón de Esgueva	9
1540	1	33	0	Cabañas del Castillo	10
1541	1	33	7	San Roque	11
1542	1	33	2	Cabanes	12
1543	1	33	8	Castellar de Santiago	13
1544	1	33	3	Guadalcázar	14
1545	1	33	6	Dodro	15
1546	1	33	9	Belmonte	16
1547	1	33	5	Caldes de Malavella	17
1548	1	33	1	Busquístar	18
1549	1	33	4	Anquela del Ducado	19
1550	1	33	8	Elgeta	20
1551	1	33	5	Fuenteheridos	21
1552	1	33	6	Frailes	23
1553	1	33	1	Campo de Villavidel	24
1554	1	33	4	Artesa de Lleida	25
1555	1	33	7	Briñas	26
1556	1	33	3	Muras	27
1557	1	33	9	Campo Real	28
1558	1	33	2	Canillas de Aceituno	29
1559	1	33	6	Puerto Lumbreras	30
1560	1	33	3	Aria	31
1561	1	33	8	Gomesende	32
1562	1	33	4	Lena	33
1563	1	33	9	Boada de Campos	34
1564	1	33	2	Vega de San Mateo	35
1565	1	33	5	Mos	36
1566	1	33	1	Arcediano	37
1567	1	33	7	San Andrés y Sauces	38
1568	1	33	0	Herrerías	39
1569	1	33	4	Brieva	40
1570	1	33	1	Constantina	41
1571	1	33	6	Bayubas de Arriba	42
1572	1	33	2	Botarell	43
1573	1	33	7	Báguena	44
1574	1	33	0	Campillo de la Jara, El	45
1575	1	33	3	Almiserà	46
1576	1	33	9	Canalejas de Peñafiel	47
1577	1	33	5	Ereño	48
1578	1	33	8	Camarzana de Tera	49
1579	1	33	1	Ardisa	50
1580	1	34	4	Leza	1
1581	1	34	9	Fuentealbilla	2
1582	1	34	5	Benijófar	3
1583	1	34	0	Cóbdar	4
1584	1	34	3	Blasconuño de Matacabras	5
1585	1	34	6	Casas de Reina	6
1586	1	34	2	Mancor de la Vall	7
1587	1	34	8	Calders	8
1588	1	34	1	Balbases, Los	9
1589	1	34	5	Cabezabellosa	10
1590	1	34	2	Setenil de las Bodegas	11
1591	1	34	7	Càlig	12
1592	1	34	3	Ciudad Real	13
1593	1	34	8	Guijo, El	14
1594	1	34	1	Dumbría	15
1595	1	34	4	Belmontejo	16
1596	1	34	0	Calonge	17
1597	1	34	6	Cacín	18
1598	1	34	9	Anquela del Pedregal	19
1599	1	34	3	Eskoriatza	20
1600	1	34	0	Galaroza	21
1601	1	34	1	Fuensanta de Martos	23
1602	1	34	6	Camponaraya	24
1603	1	34	9	Artesa de Segre	25
1604	1	34	2	Briones	26
1605	1	34	8	Navia de Suarna	27
1606	1	34	4	Canencia	28
1607	1	34	7	Canillas de Albaida	29
1608	1	34	1	Ricote	30
1609	1	34	8	Aribe	31
1610	1	34	3	Gudiña, A	32
1611	1	34	9	Valdés	33
1612	1	34	4	Boadilla del Camino	34
1613	1	34	7	Yaiza	35
1614	1	34	0	Neves, As	36
1615	1	34	6	Arco, El	37
1616	1	34	2	San Juan de la Rambla	38
1617	1	34	5	Lamasón	39
1618	1	34	9	Caballar	40
1619	1	34	6	Coria del Río	41
1620	1	34	1	Beratón	42
1621	1	34	7	Bràfim	43
1622	1	34	2	Bañón	44
1623	1	34	5	Camuñas	45
1624	1	34	8	Almoines	46
1625	1	34	4	Canillas de Esgueva	47
1626	1	34	0	Ermua	48
1627	1	34	3	Cañizal	49
1628	1	34	6	Ariza	50
1629	1	35	2	Gineta, La	2
1630	1	35	8	Benilloba	3
1631	1	35	3	Cuevas del Almanzora	4
1632	1	35	6	Blascosancho	5
1633	1	35	9	Castilblanco	6
1634	1	35	5	Maria de la Salut	7
1635	1	35	1	Calella	8
1636	1	35	4	Baños de Valdearados	9
1637	1	35	8	Cabezuela del Valle	10
1638	1	35	5	Tarifa	11
1639	1	35	6	Corral de Calatrava	13
1640	1	35	1	Hinojosa del Duque	14
1641	1	35	4	Fene	15
1642	1	35	7	Beteta	16
1643	1	35	3	Camós	17
1644	1	35	9	Cádiar	18
1645	1	35	6	Ezkio-Itsaso	20
1646	1	35	3	Gibraleón	21
1647	1	35	8	Arén	22
1648	1	35	4	Fuerte del Rey	23
1649	1	35	2	Sentiu de Sió, La	25
1650	1	35	5	Cabezón de Cameros	26
1651	1	35	1	Negueira de Muñiz	27
1652	1	35	7	Carabaña	28
1653	1	35	0	Cañete la Real	29
1654	1	35	4	San Javier	30
1655	1	35	1	Armañanzas	31
1656	1	35	6	Irixo, O	32
1657	1	35	2	Llanera	33
1658	1	35	7	Boadilla de Rioseco	34
1659	1	35	3	Nigrán	36
1660	1	35	9	Armenteros	37
1661	1	35	5	San Miguel de Abona	38
1662	1	35	8	Laredo	39
1663	1	35	2	Cabañas de Polendos	40
1664	1	35	9	Coripe	41
1665	1	35	4	Berlanga de Duero	42
1666	1	35	0	Cabacés	43
1667	1	35	5	Barrachina	44
1668	1	35	8	Cardiel de los Montes	45
1669	1	35	1	Almussafes	46
1670	1	35	7	Carpio	47
1671	1	35	3	Fruiz	48
1672	1	35	6	Cañizo	49
1673	1	35	9	Artieda	50
1674	1	36	0	Laudio/Llodio	1
1675	1	36	5	Golosalvo	2
1676	1	36	1	Benillup	3
1677	1	36	6	Chercos	4
1678	1	36	9	Bohodón, El	5
1679	1	36	2	Castuera	6
1680	1	36	8	Marratxí	7
1681	1	36	4	Calonge de Segarra	8
1682	1	36	7	Bañuelos de Bureba	9
1683	1	36	1	Cabrero	10
1684	1	36	8	Torre Alháquime	11
1685	1	36	3	Canet lo Roig	12
1686	1	36	9	Cortijos, Los	13
1687	1	36	4	Hornachuelos	14
1688	1	36	7	Ferrol	15
1689	1	36	0	Boniches	16
1690	1	36	6	Campdevànol	17
1691	1	36	2	Cájar	18
1692	1	36	5	Aranzueque	19
1693	1	36	9	Hondarribia	20
1694	1	36	6	Granada de Río-Tinto, La	21
1695	1	36	1	Argavieso	22
1696	1	36	2	Candín	24
1697	1	36	5	Aspa	25
1698	1	36	8	Calahorra	26
1699	1	36	0	Casarrubuelos	28
1700	1	36	3	Carratraca	29
1701	1	36	7	San Pedro del Pinatar	30
1702	1	36	4	Arróniz	31
1703	1	36	9	Xunqueira de Ambía	32
1704	1	36	5	Llanes	33
1705	1	36	0	Brañosera	34
1706	1	36	6	Oia	36
1707	1	36	2	San Miguel del Robledo	37
1708	1	36	8	San Sebastián de la Gomera	38
1709	1	36	1	Liendo	39
1710	1	36	5	Cabezuela	40
1711	1	36	2	Coronil, El	41
1712	1	36	7	Blacos	42
1713	1	36	3	Cabra del Camp	43
1714	1	36	8	Bea	44
1715	1	36	1	Carmena	45
1716	1	36	4	Alpuente	46
1717	1	36	0	Casasola de Arión	47
1718	1	36	6	Galdakao	48
1719	1	36	9	Carbajales de Alba	49
1720	1	36	2	Asín	50
1721	1	37	6	Arraia-Maeztu	1
1722	1	37	1	Hellín	2
1723	1	37	7	Benimantell	3
1724	1	37	2	Chirivel	4
1725	1	37	5	Bohoyo	5
1726	1	37	8	Codosera, La	6
1727	1	37	4	Mercadal, Es	7
1728	1	37	0	Calldetenes	8
1729	1	37	3	Barbadillo de Herreros	9
1730	1	37	7	Cáceres	10
1731	1	37	4	Trebujena	11
1732	1	37	9	Castell de Cabres	12
1733	1	37	5	Cózar	13
1734	1	37	0	Iznájar	14
1735	1	37	3	Fisterra	15
1736	1	37	2	Campelles	17
1737	1	37	8	Calicasas	18
1738	1	37	1	Arbancón	19
1739	1	37	5	Gaintza	20
1740	1	37	2	Granado, El	21
1741	1	37	7	Arguis	22
1742	1	37	3	Génave	23
1743	1	37	8	Cármenes	24
1744	1	37	1	Avellanes i Santa Linya, Les	25
1745	1	37	4	Camprovín	26
1746	1	37	0	Nogais, As	27
1747	1	37	6	Cenicientos	28
1748	1	37	9	Cartajima	29
1749	1	37	3	Torre-Pacheco	30
1750	1	37	0	Arruazu	31
1751	1	37	5	Xunqueira de Espadanedo	32
1752	1	37	1	Mieres	33
1753	1	37	6	Buenavista de Valdavia	34
1754	1	37	2	Pazos de Borbén	36
1755	1	37	8	Atalaya, La	37
1756	1	37	4	Santa Cruz de la Palma	38
1757	1	37	7	Liérganes	39
1758	1	37	1	Calabazas de Fuentidueña	40
1759	1	37	8	Corrales, Los	41
1760	1	37	3	Bliecos	42
1761	1	37	9	Calafell	43
1762	1	37	4	Beceite	44
1763	1	37	7	Carpio de Tajo, El	45
1764	1	37	0	Alqueria de la Comtessa, 	46
1765	1	37	6	Castrejón de Trabancos	47
1766	1	37	2	Galdames	48
1767	1	37	5	Carbellino	49
1768	1	37	8	Atea	50
1769	1	38	7	Herrera, La	2
1770	1	38	3	Benimarfull	3
1771	1	38	8	Dalías	4
1772	1	38	1	Bonilla de la Sierra	5
1773	1	38	4	Cordobilla de Lácara	6
1774	1	38	0	Montuïri	7
1775	1	38	6	Callús	8
1776	1	38	9	Barbadillo del Mercado	9
1777	1	38	3	Cachorrilla	10
1778	1	38	0	Ubrique	11
1779	1	38	5	Castellfort	12
1780	1	38	1	Chillón	13
1781	1	38	6	Lucena	14
1782	1	38	9	Frades	15
1783	1	38	2	Buciegas	16
1784	1	38	8	Campllong	17
1785	1	38	4	Campotéjar	18
1786	1	38	7	Arbeteta	19
1787	1	38	1	Gabiria	20
1788	1	38	8	Higuera de la Sierra	21
1789	1	38	9	Guardia de Jaén, La	23
1790	1	38	4	Carracedelo	24
1791	1	38	7	Aitona	25
1792	1	38	0	Canales de la Sierra	26
1793	1	38	6	Ourol	27
1794	1	38	2	Cercedilla	28
1795	1	38	5	Cártama	29
1796	1	38	9	Torres de Cotillas, Las	30
1797	1	38	6	Artajona	31
1798	1	38	1	Larouco	32
1799	1	38	7	Morcín	33
1800	1	38	2	Bustillo de la Vega	34
1801	1	38	8	Pontevedra	36
1802	1	38	4	Babilafuente	37
1803	1	38	0	Santa Cruz de Tenerife	38
1804	1	38	3	Limpias	39
1805	1	38	4	Dos Hermanas	41
1806	1	38	9	Borjabad	42
1807	1	38	5	Cambrils	43
1808	1	38	0	Belmonte de San José	44
1809	1	38	3	Carranque	45
1810	1	38	6	Andilla	46
1811	1	38	2	Castrillo de Duero	47
1812	1	38	8	Gamiz-Fika	48
1813	1	38	1	Casaseca de Campeán	49
1814	1	38	4	Ateca	50
1815	1	39	5	Moreda de Álava/Moreda Araba	1
1816	1	39	0	Higueruela	2
1817	1	39	6	Benimassot	3
1818	1	39	4	Brabos	5
1819	1	39	7	Coronada, La	6
1820	1	39	3	Muro	7
1821	1	39	9	Campins	8
1822	1	39	2	Barbadillo del Pez	9
1823	1	39	6	Cadalso	10
1824	1	39	3	Vejer de la Frontera	11
1825	1	39	8	Castellnovo	12
1826	1	39	4	Daimiel	13
1827	1	39	9	Luque	14
1828	1	39	2	Irixoa	15
1829	1	39	5	Buenache de Alarcón	16
1830	1	39	1	Camprodon	17
1831	1	39	7	Caniles	18
1832	1	39	0	Argecilla	19
1833	1	39	4	Getaria	20
1834	1	39	1	Hinojales	21
1835	1	39	6	Ayerbe	22
1836	1	39	2	Guarromán	23
1837	1	39	7	Carrizo	24
1838	1	39	0	Baix Pallars	25
1839	1	39	3	Canillas de Río Tuerto	26
1840	1	39	9	Outeiro de Rei	27
1841	1	39	5	Cervera de Buitrago	28
1842	1	39	8	Casabermeja	29
1843	1	39	2	Totana	30
1844	1	39	9	Artazu	31
1845	1	39	4	Laza	32
1846	1	39	0	Muros de Nalón	33
1847	1	39	5	Bustillo del Páramo de Carrión	34
1848	1	39	1	Porriño, O	36
1849	1	39	7	Bañobárez	37
1850	1	39	3	Santa Úrsula	38
1851	1	39	6	Luena	39
1852	1	39	0	Campo de San Pedro	40
1853	1	39	7	Écija	41
1854	1	39	2	Borobia	42
1855	1	39	8	Capafonts	43
1856	1	39	3	Bello	44
1857	1	39	6	Carriches	45
1858	1	39	9	Anna	46
1859	1	39	5	Castrillo-Tejeriego	47
1860	1	39	1	Garai	48
1861	1	39	4	Casaseca de las Chanas	49
1862	1	39	7	Azuara	50
1863	1	40	4	Hoya-Gonzalo	2
1864	1	40	0	Benimeli	3
1865	1	40	8	Bularros	5
1866	1	40	1	Corte de Peleas	6
1867	1	40	7	Palma	7
1868	1	40	3	Canet de Mar	8
1869	1	40	0	Calzadilla	10
1870	1	40	7	Villaluenga del Rosario	11
1871	1	40	2	Castellón de la Plana/Castelló de la Plana	12
1872	1	40	8	Fernán Caballero	13
1873	1	40	3	Montalbán de Córdoba	14
1874	1	40	6	Laxe	15
1875	1	40	9	Buenache de la Sierra	16
1876	1	40	5	Canet de Adri	17
1877	1	40	1	Cáñar	18
1878	1	40	4	Armallones	19
1879	1	40	8	Hernani	20
1880	1	40	5	Hinojos	21
1881	1	40	0	Azanuy-Alins	22
1882	1	40	6	Lahiguera	23
1883	1	40	1	Carrocera	24
1884	1	40	4	Balaguer	25
1885	1	40	7	Cañas	26
1886	1	40	3	Palas de Rei	27
1887	1	40	9	Ciempozuelos	28
1888	1	40	2	Casarabonela	29
1889	1	40	6	Ulea	30
1890	1	40	3	Atez	31
1891	1	40	8	Leiro	32
1892	1	40	4	Nava	33
1893	1	40	5	Portas	36
1894	1	40	1	Barbadillo	37
1895	1	40	7	Santiago del Teide	38
1896	1	40	0	Marina de Cudeyo	39
1897	1	40	4	Cantalejo	40
1898	1	40	1	Espartinas	41
1899	1	40	2	Capçanes	43
1900	1	40	7	Berge	44
1901	1	40	0	El Casar de Escalona	45
1902	1	40	3	Antella	46
1903	1	40	9	Castrobol	47
1904	1	40	5	Gatika	48
1905	1	40	8	Castrillo de la Guareña	49
1906	1	40	1	Badules	50
1907	1	41	6	Navaridas	1
1908	1	41	1	Jorquera	2
1909	1	41	7	Benissa	3
1910	1	41	2	Enix	4
1911	1	41	5	Burgohondo	5
1912	1	41	8	Cristina	6
1913	1	41	4	Petra	7
1914	1	41	0	Canovelles	8
1915	1	41	3	Barrio de Muñó	9
1916	1	41	7	Caminomorisco	10
1917	1	41	4	Villamartín	11
1918	1	41	9	Castillo de Villamalefa	12
1919	1	41	5	Fontanarejo	13
1920	1	41	0	Montemayor	14
1921	1	41	3	A Laracha	15
1922	1	41	6	Buendía	16
1923	1	41	2	Cantallops	17
1924	1	41	1	Armuña de Tajuña	19
1925	1	41	5	Hernialde	20
1926	1	41	2	Huelva	21
1927	1	41	7	Azara	22
1928	1	41	3	Higuera de Calatrava	23
1929	1	41	8	Carucedo	24
1930	1	41	1	Barbens	25
1931	1	41	4	Cárdenas	26
1932	1	41	0	Pantón	27
1933	1	41	6	Cobeña	28
1934	1	41	9	Casares	29
1935	1	41	3	La Unión	30
1936	1	41	0	Ayegui/Aiegi	31
1937	1	41	5	Lobeira	32
1938	1	41	1	Navia	33
1939	1	41	6	Calahorra de Boedo	34
1940	1	41	2	Poio	36
1941	1	41	8	Barbalos	37
1942	1	41	4	Sauzal, El	38
1943	1	41	7	Mazcuerras	39
1944	1	41	1	Cantimpalos	40
1945	1	41	8	Estepa	41
1946	1	41	3	Buberos	42
1947	1	41	9	Caseres	43
1948	1	41	4	Bezas	44
1949	1	41	7	Casarrubios del Monte	45
1950	1	41	0	Aras de los Olmos	46
1951	1	41	6	Castrodeza	47
1952	1	41	2	Gautegiz Arteaga	48
1953	1	41	5	Castrogonzalo	49
1954	1	41	8	Bagüés	50
1955	1	42	1	Okondo	1
1956	1	42	6	Letur	2
1957	1	42	2	Benitachell/Poble Nou de Benitatxell, el	3
1958	1	42	0	Cabezas de Alambre	5
1959	1	42	3	Cheles	6
1960	1	42	9	Pollença	7
1961	1	42	5	Cànoves i Samalús	8
1962	1	42	2	Campillo de Deleitosa	10
1963	1	42	9	Zahara	11
1964	1	42	4	Catí	12
1965	1	42	0	Fuencaliente	13
1966	1	42	5	Montilla	14
1967	1	42	8	Lousame	15
1968	1	42	1	Campillo de Altobuey	16
1969	1	42	7	Capmany	17
1970	1	42	3	Capileira	18
1971	1	42	6	Arroyo de las Fraguas	19
1972	1	42	0	Ibarra	20
1973	1	42	7	Isla Cristina	21
1974	1	42	2	Azlor	22
1975	1	42	8	Hinojares	23
1976	1	42	3	Castilfalé	24
1977	1	42	6	Baronia de Rialb, La	25
1978	1	42	9	Casalarreina	26
1979	1	42	5	Paradela	27
1980	1	42	1	Colmenar del Arroyo	28
1981	1	42	4	Coín	29
1982	1	42	8	Villanueva del Río Segura	30
1983	1	42	5	Azagra	31
1984	1	42	0	Lobios	32
1985	1	42	6	Noreña	33
1986	1	42	1	Calzada de los Molinos	34
1987	1	42	7	Ponteareas	36
1988	1	42	3	Barceo	37
1989	1	42	9	Silos, Los	38
1990	1	42	2	Medio Cudeyo	39
1991	1	42	3	Fuentes de Andalucía	41
1992	1	42	8	Buitrago	42
1993	1	42	4	Castellvell del Camp	43
1994	1	42	9	Blancas	44
1995	1	42	2	Casasbuenas	45
1996	1	42	5	Aielo de Malferit	46
1997	1	42	1	Castromembibre	47
1998	1	42	7	Gordexola	48
1999	1	42	0	Castronuevo	49
2000	1	42	3	Balconchán	50
2001	1	43	7	Oyón-Oion	1
2002	1	43	2	Lezuza	2
2003	1	43	8	Biar	3
2004	1	43	3	Felix	4
2005	1	43	6	Cabezas del Pozo	5
2006	1	43	9	Don Álvaro	6
2007	1	43	5	Porreres	7
2008	1	43	1	Canyelles	8
2009	1	43	4	Barrios de Bureba, Los	9
2010	1	43	8	Campo Lugar	10
2011	1	43	0	Caudiel	12
2012	1	43	6	Fuenllana	13
2013	1	43	1	Montoro	14
2014	1	43	4	Malpica de Bergantiños	15
2015	1	43	7	Campillos-Paravientos	16
2016	1	43	3	Queralbs	17
2017	1	43	9	Carataunas	18
2018	1	43	2	Atanzón	19
2019	1	43	6	Idiazabal	20
2020	1	43	3	Jabugo	21
2021	1	43	8	Baélls	22
2022	1	43	4	Hornos	23
2023	1	43	9	Castrillo de Cabrera	24
2024	1	43	2	Vall de Boí, La	25
2025	1	43	5	Castañares de Rioja	26
2026	1	43	1	Páramo, O	27
2027	1	43	7	Colmenar de Oreja	28
2028	1	43	0	Colmenar	29
2029	1	43	4	Yecla	30
2030	1	43	1	Azuelo	31
2031	1	43	6	Maceda	32
2032	1	43	2	Onís	33
2033	1	43	3	Ponte Caldelas	36
2034	1	43	5	Tacoronte	38
2035	1	43	8	Meruelo	39
2036	1	43	2	Carbonero el Mayor	40
2037	1	43	9	Garrobo, El	41
2038	1	43	4	Burgo de Osma-Ciudad de Osma	42
2039	1	43	0	Catllar, El	43
2040	1	43	5	Blesa	44
2041	1	43	8	Castillo de Bayuela	45
2042	1	43	1	Aielo de Rugat	46
2043	1	43	7	Castromonte	47
2044	1	43	3	Gorliz	48
2045	1	43	6	Castroverde de Campos	49
2046	1	43	9	Bárboles	50
2047	1	44	2	Peñacerrada-Urizaharra	1
2048	1	44	7	Liétor	2
2049	1	44	3	Bigastro	3
2050	1	44	8	Fines	4
2051	1	44	1	Cabezas del Villar	5
2052	1	44	4	Don Benito	6
2053	1	44	0	Pobla, Sa	7
2054	1	44	6	Capellades	8
2055	1	44	9	Barrios de Colina	9
2056	1	44	3	Cañamero	10
2057	1	44	5	Cervera del Maestre	12
2058	1	44	1	Fuente el Fresno	13
2059	1	44	6	Monturque	14
2060	1	44	9	Mañón	15
2061	1	44	2	Campillos-Sierra	16
2062	1	44	8	Cassà de la Selva	17
2063	1	44	4	Cástaras	18
2064	1	44	7	Atienza	19
2065	1	44	1	Ikaztegieta	20
2066	1	44	8	Lepe	21
2067	1	44	3	Bailo	22
2068	1	44	9	Huelma	23
2069	1	44	4	Castrillo de la Valduerna	24
2070	1	44	7	Bassella	25
2071	1	44	0	Castroviejo	26
2072	1	44	6	Pastoriza, A	27
2073	1	44	2	Colmenarejo	28
2074	1	44	5	Comares	29
2075	1	44	6	Bakaiku	31
2076	1	44	1	Manzaneda	32
2077	1	44	7	Oviedo	33
2078	1	44	8	Pontecesures	36
2079	1	44	4	Barruecopardo	37
2080	1	44	0	Tanque, El	38
2081	1	44	3	Miengo	39
2082	1	44	7	Carrascal del Río	40
2083	1	44	4	Gelves	41
2084	1	44	9	Cabrejas del Campo	42
2085	1	44	5	Sénia, La	43
2086	1	44	0	Bordón	44
2087	1	44	6	Ayora	46
2088	1	44	2	Castronuevo de Esgueva	47
2089	1	44	8	Getxo	48
2090	1	44	1	Cazurra	49
2091	1	44	4	Bardallur	50
2092	1	45	0	Madrigueras	2
2093	1	45	6	Bolulla	3
2094	1	45	1	Fiñana	4
2095	1	45	4	Cabizuela	5
2096	1	45	7	Entrín Bajo	6
2097	1	45	3	Puigpunyent	7
2098	1	45	9	Capolat	8
2099	1	45	2	Basconcillos del Tozo	9
2100	1	45	6	Cañaveral	10
2101	1	45	8	Cinctorres	12
2102	1	45	4	Granátula de Calatrava	13
2103	1	45	9	Moriles	14
2104	1	45	2	Mazaricos	15
2105	1	45	5	Canalejas del Arroyo	16
2106	1	45	7	Castilléjar	18
2107	1	45	0	Auñón	19
2108	1	45	4	Irun	20
2109	1	45	1	Linares de la Sierra	21
2110	1	45	6	Baldellou	22
2111	1	45	2	Huesa	23
2112	1	45	0	Bausen	25
2113	1	45	3	Cellorigo	26
2114	1	45	9	Pedrafita do Cebreiro	27
2115	1	45	5	Colmenar Viejo	28
2116	1	45	8	Cómpeta	29
2117	1	45	9	Barásoain	31
2118	1	45	4	Maside	32
2119	1	45	0	Parres	33
2120	1	45	5	Capillas	34
2121	1	45	1	Redondela	36
2122	1	45	7	Bastida, La	37
2123	1	45	3	Tazacorte	38
2124	1	45	6	Miera	39
2125	1	45	0	Casla	40
2126	1	45	7	Gerena	41
2127	1	45	2	Cabrejas del Pinar	42
2128	1	45	8	Colldejou	43
2129	1	45	3	Bronchales	44
2130	1	45	6	Cazalegas	45
2131	1	45	9	Barxeta	46
2132	1	45	5	Castronuño	47
2133	1	45	1	Güeñes	48
2134	1	45	7	Belchite	50
2135	1	46	8	Erriberagoitia/Ribera Alta	1
2136	1	46	3	Mahora	2
2137	1	46	9	Busot	3
2138	1	46	4	Fondón	4
2139	1	46	7	Canales	5
2140	1	46	0	Esparragalejo	6
2141	1	46	6	Sant Antoni de Portmany	7
2142	1	46	2	Cardedeu	8
2143	1	46	5	Bascuñana	9
2144	1	46	9	Carbajo	10
2145	1	46	1	Cirat	12
2146	1	46	7	Guadalmez	13
2147	1	46	2	Nueva Carteya	14
2148	1	46	5	Melide	15
2149	1	46	8	Cañada del Hoyo	16
2150	1	46	4	Castellfollit de la Roca	17
2151	1	46	0	Castril	18
2152	1	46	3	Azuqueca de Henares	19
2153	1	46	7	Irura	20
2154	1	46	4	Lucena del Puerto	21
2155	1	46	9	Ballobar	22
2156	1	46	5	Ibros	23
2157	1	46	0	Castrocalbón	24
2158	1	46	3	Belianes	25
2159	1	46	6	Cenicero	26
2160	1	46	2	Pol	27
2161	1	46	8	Collado Mediano	28
2162	1	46	1	Cortes de la Frontera	29
2163	1	46	2	Barbarin	31
2164	1	46	7	Melón	32
2165	1	46	3	Peñamellera Alta	33
2166	1	46	8	Cardeñosa de Volpejera	34
2167	1	46	4	Ribadumia	36
2168	1	46	0	Béjar	37
2169	1	46	6	Tegueste	38
2170	1	46	9	Molledo	39
2171	1	46	3	Castillejo de Mesleón	40
2172	1	46	0	Gilena	41
2173	1	46	5	Calatañazor	42
2174	1	46	1	Conesa	43
2175	1	46	6	Bueña	44
2176	1	46	9	Cebolla	45
2177	1	46	2	Barx	46
2178	1	46	8	Castroponce	47
2179	1	46	4	Gernika-Lumo	48
2180	1	46	7	Cerecinos de Campos	49
2181	1	46	0	Belmonte de Gracián	50
2182	1	47	4	Ribera Baja/Erribera Beitia	1
2183	1	47	9	Masegoso	2
2184	1	47	5	Calp	3
2185	1	47	0	Gádor	4
2186	1	47	3	Candeleda	5
2187	1	47	6	Esparragosa de la Serena	6
2188	1	47	2	Sencelles	7
2189	1	47	8	Cardona	8
2190	1	47	1	Belbimbre	9
2191	1	47	5	Carcaboso	10
2192	1	47	3	Herencia	13
2193	1	47	8	Obejo	14
2194	1	47	1	Mesía	15
2195	1	47	4	Cañada Juncosa	16
2196	1	47	0	Castelló Empúries	17
2197	1	47	6	Cenes de la Vega	18
2198	1	47	9	Baides	19
2199	1	47	3	Itsasondo	20
2200	1	47	0	Manzanilla	21
2201	1	47	5	Banastás	22
2202	1	47	1	Iruela, La	23
2203	1	47	6	Castrocontrigo	24
2204	1	47	9	Bellcaire Urgell	25
2205	1	47	2	Cervera del Río Alhama	26
2206	1	47	8	Pobra do Brollón, A	27
2207	1	47	4	Collado Villalba	28
2208	1	47	7	Cuevas Bajas	29
2209	1	47	8	Bargota	31
2210	1	47	3	Merca, A	32
2211	1	47	9	Peñamellera Baja	33
2212	1	47	4	Carrión de los Condes	34
2213	1	47	0	Rodeiro	36
2214	1	47	6	Beleña	37
2215	1	47	2	Tijarafe	38
2216	1	47	5	Noja	39
2217	1	47	9	Castro de Fuentidueña	40
2218	1	47	6	Gines	41
2219	1	47	7	Constantí	43
2220	1	47	2	Burbáguena	44
2221	1	47	5	Cedillo del Condado	45
2222	1	47	8	Bèlgida	46
2223	1	47	4	Castroverde de Cerrato	47
2224	1	47	0	Gizaburuaga	48
2225	1	47	3	Cerecinos del Carrizal	49
2226	1	47	6	Berdejo	50
2227	1	48	5	Minaya	2
2228	1	48	1	Callosa En Sarrià	3
2229	1	48	6	Gallardos, Los	4
2230	1	48	9	Cantiveros	5
2231	1	48	2	Esparragosa de Lares	6
2232	1	48	8	Sant Josep de sa Talaia	7
2233	1	48	4	Carme	8
2234	1	48	7	Belorado	9
2235	1	48	1	Carrascalejo	10
2236	1	48	3	Cortes de Arenoso	12
2237	1	48	9	Hinojosas de Calatrava	13
2238	1	48	4	Palenciana	14
2239	1	48	7	Miño	15
2240	1	48	0	Cañamares	16
2241	1	48	6	Castell-Platja Aro	17
2242	1	48	2	Cijuela	18
2243	1	48	5	Baños de Tajo	19
2244	1	48	9	Larraul	20
2245	1	48	6	Marines, Los	21
2246	1	48	1	Barbastro	22
2247	1	48	7	Iznatoraf	23
2248	1	48	5	Bell-lloc Urgell	25
2249	1	48	8	Cidamón	26
2250	1	48	4	Pontenova, A	27
2251	1	48	0	Corpa	28
2252	1	48	3	Cuevas del Becerro	29
2253	1	48	4	Barillas	31
2254	1	48	9	Mezquita, A	32
2255	1	48	5	Pesoz	33
2256	1	48	0	Castil de Vela	34
2257	1	48	6	Rosal, O	36
2258	1	48	8	Valverde	38
2259	1	48	1	Penagos	39
2260	1	48	5	Castrojimeno	40
2261	1	48	2	Guadalcanal	41
2262	1	48	7	Caltojar	42
2263	1	48	3	Corbera Ebre	43
2264	1	48	8	Cabra de Mora	44
2265	1	48	1	Cerralbos, Los	45
2266	1	48	4	Bellreguard	46
2267	1	48	0	Ceinos de Campos	47
2268	1	48	6	Ibarrangelu	48
2269	1	48	9	Cernadilla	49
2270	1	48	2	Berrueco	50
2271	1	49	3	Añana	1
2272	1	49	8	Molinicos	2
2273	1	49	4	Callosa de Segura	3
2274	1	49	9	Garrucha	4
2275	1	49	2	Cardeñosa	5
2276	1	49	5	Feria	6
2277	1	49	1	Sant Joan	7
2278	1	49	7	Casserres	8
2279	1	49	4	Casar de Cáceres	10
2280	1	49	6	Costur	12
2281	1	49	2	Horcajo de los Montes	13
2282	1	49	7	Palma del Río	14
2283	1	49	0	Moeche	15
2284	1	49	3	Cañavate, El	16
2285	1	49	9	Celrà	17
2286	1	49	5	Cogollos de Guadix	18
2287	1	49	8	Bañuelos	19
2288	1	49	2	Lazkao	20
2289	1	49	9	Minas de Riotinto	21
2290	1	49	4	Barbués	22
2291	1	49	0	Jabalquinto	23
2292	1	49	5	Castropodame	24
2293	1	49	8	Bellmunt Urgell	25
2294	1	49	1	Cihuri	26
2295	1	49	7	Portomarín	27
2296	1	49	3	Coslada	28
2297	1	49	6	Cuevas de San Marcos	29
2298	1	49	7	Basaburua	31
2299	1	49	2	Montederramo	32
2300	1	49	8	Piloña	33
2301	1	49	3	Castrejón de la Peña	34
2302	1	49	9	Salceda de Caselas	36
2303	1	49	5	Bermellar	37
2304	1	49	1	Valle Gran Rey	38
2305	1	49	4	Peñarrubia	39
2306	1	49	8	Castroserna de Abajo	40
2307	1	49	5	Guillena	41
2308	1	49	0	Candilichera	42
2309	1	49	6	Cornudella de Montsant	43
2310	1	49	1	Calaceite	44
2311	1	49	4	Cervera de los Montes	45
2312	1	49	7	Bellús	46
2313	1	49	3	Cervillego de la Cruz	47
2314	1	49	9	Ispaster	48
2315	1	50	1	Montalvos	2
2316	1	50	7	Campello, el	3
2317	1	50	2	Gérgal	4
2318	1	50	8	Fregenal de la Sierra	6
2319	1	50	4	Sant Joan de Labritja	7
2320	1	50	0	Castellar del Riu	8
2321	1	50	3	Berberana	9
2322	1	50	7	Casar de Palomero	10
2323	1	50	9	Coves de Vinromà, les	12
2324	1	50	5	Labores, Las	13
2325	1	50	0	Pedro Abad	14
2326	1	50	3	Monfero	15
2327	1	50	6	Cañaveras	16
2328	1	50	2	Cervià de Ter	17
2329	1	50	8	Cogollos de la Vega	18
2330	1	50	1	Barriopedro	19
2331	1	50	5	Leaburu	20
2332	1	50	2	Moguer	21
2333	1	50	7	Barbuñales	22
2334	1	50	3	Jaén	23
2335	1	50	8	Castrotierra de Valmadrigal	24
2336	1	50	1	Bellpuig	25
2337	1	50	4	Cirueña	26
2338	1	50	0	Quiroga	27
2339	1	50	6	Cubas de la Sagra	28
2340	1	50	9	Cútar	29
2341	1	50	0	Baztan	31
2342	1	50	5	Monterrei	32
2343	1	50	1	Ponga	33
2344	1	50	6	Castrillo de Don Juan	34
2345	1	50	2	Salvaterra de Miño	36
2346	1	50	8	Berrocal de Huebra	37
2347	1	50	4	Vallehermoso	38
2348	1	50	7	Pesaguero	39
2349	1	50	8	Herrera	41
2350	1	50	3	Cañamaque	42
2351	1	50	9	Creixell	43
2352	1	50	4	Calamocha	44
2353	1	50	7	Ciruelos	45
2354	1	50	0	Benagéber	46
2355	1	50	6	Cigales	47
2356	1	50	2	Izurtza	48
2357	1	50	5	Cobreros	49
2358	1	50	8	Bijuesca	50
2359	1	51	3	Salvatierra/Agurain	1
2360	1	51	8	Montealegre del Castillo	2
2361	1	51	4	Campo de Mirra/Camp de Mirra, el	3
2362	1	51	9	Huécija	4
2363	1	51	2	Carrera, La	5
2364	1	51	5	Fuenlabrada de los Montes	6
2365	1	51	1	Sant Llorenç des Cardassar	7
2366	1	51	7	Castellar del Vallès	8
2367	1	51	0	Berlangas de Roa	9
2368	1	51	4	Casares de las Hurdes	10
2369	1	51	6	Culla	12
2370	1	51	2	Luciana	13
2371	1	51	7	Pedroche	14
2372	1	51	0	Mugardos	15
2373	1	51	3	Cañaveruelas	16
2374	1	51	9	Cistella	17
2375	1	51	5	Colomera	18
2376	1	51	8	Berninches	19
2377	1	51	2	Legazpi	20
2378	1	51	9	Nava, La	21
2379	1	51	4	Bárcabo	22
2380	1	51	0	Jamilena	23
2381	1	51	5	Cea	24
2382	1	51	8	Bellver de Cerdanya	25
2383	1	51	1	Clavijo	26
2384	1	51	7	Ribadeo	27
2385	1	51	3	Chapinería	28
2386	1	51	6	Estepona	29
2387	1	51	7	Beire	31
2388	1	51	2	Muíños	32
2389	1	51	8	Pravia	33
2390	1	51	3	Castrillo de Onielo	34
2391	1	51	9	Sanxenxo	36
2392	1	51	5	Berrocal de Salvatierra	37
2393	1	51	1	Victoria de Acentejo, La	38
2394	1	51	4	Pesquera	39
2395	1	51	8	Castroserracín	40
2396	1	51	5	Huévar del Aljarafe	41
2397	1	51	0	Carabantes	42
2398	1	51	6	Cunit	43
2399	1	51	1	Calanda	44
2400	1	51	4	Cobeja	45
2401	1	51	7	Benaguasil	46
2402	1	51	3	Ciguñuela	47
2403	1	51	9	Lanestosa	48
2404	1	51	5	Biota	50
2405	1	52	8	Samaniego	1
2406	1	52	3	Motilleja	2
2407	1	52	9	Cañada	3
2408	1	52	4	Huércal de Almería	4
2409	1	52	7	Casas del Puerto	5
2410	1	52	0	Fuente de Cantos	6
2411	1	52	6	Sant Lluís	7
2412	1	52	2	Castellar de N Hug	8
2413	1	52	5	Berzosa de Bureba	9
2414	1	52	9	Casas de Don Antonio	10
2415	1	52	1	Chert/Xert	12
2416	1	52	7	Malagón	13
2417	1	52	2	Peñarroya-Pueblonuevo	14
2418	1	52	5	Muxía	15
2419	1	52	8	Cañete	16
2420	1	52	4	Siurana	17
2421	1	52	3	La Bodera	19
2422	1	52	7	Legorreta	20
2423	1	52	4	Nerva	21
2424	1	52	9	Belver de Cinca	22
2425	1	52	5	Jimena	23
2426	1	52	0	Cebanico	24
2427	1	52	3	Bellvís	25
2428	1	52	6	Cordovín	26
2429	1	52	2	Ribas de Sil	27
2430	1	52	8	Chinchón	28
2431	1	52	1	Faraján	29
2432	1	52	2	Belascoáin	31
2433	1	52	7	Nogueira de Ramuín	32
2434	1	52	3	Proaza	33
2435	1	52	8	Castrillo de Villavega	34
2436	1	52	4	Silleda	36
2437	1	52	0	Boada	37
2438	1	52	6	Vilaflor	38
2439	1	52	9	Piélagos	39
2440	1	52	3	Cedillo de la Torre	40
2441	1	52	0	La Lantejuela	41
2442	1	52	5	Caracena	42
2443	1	52	1	Xerta	43
2444	1	52	6	Calomarde	44
2445	1	52	9	Cobisa	45
2446	1	52	2	Benavites	46
2447	1	52	8	Cistérniga	47
2448	1	52	4	Larrabetzu	48
2449	1	52	7	Coomonte	49
2450	1	52	0	Bisimbre	50
2451	1	53	4	San Millán/Donemiliaga	1
2452	1	53	9	Munera	2
2453	1	53	5	Castalla	3
2454	1	53	0	Huércal-Overa	4
2455	1	53	3	Casasola	5
2456	1	53	6	Fuente del Arco	6
2457	1	53	2	Santa Eugènia	7
2458	1	53	8	Castellbell i el Vilar	8
2459	1	53	5	Casas de Don Gómez	10
2460	1	53	7	Chilches/Xilxes	12
2461	1	53	3	Manzanares	13
2462	1	53	8	Posadas	14
2463	1	53	1	Muros	15
2464	1	53	4	Cañizares	16
2465	1	53	6	Cortes de Baza	18
2466	1	53	9	Brihuega	19
2467	1	53	3	Lezo	20
2468	1	53	0	Niebla	21
2469	1	53	5	Benabarre	22
2470	1	53	1	Jódar	23
2471	1	53	6	Cebrones del Río	24
2472	1	53	9	Benavent de Segrià	25
2473	1	53	2	Corera	26
2474	1	53	8	Ribeira de Piquín	27
2475	1	53	4	Daganzo de Arriba	28
2476	1	53	7	Frigiliana	29
2477	1	53	8	Berbinzana	31
2478	1	53	3	Oímbra	32
2479	1	53	9	Quirós	33
2480	1	53	4	Castromocho	34
2481	1	53	0	Soutomaior	36
2482	1	53	2	Villa de Mazo	38
2483	1	53	5	Polaciones	39
2484	1	53	9	Cerezo de Abajo	40
2485	1	53	6	Lebrija	41
2486	1	53	1	Carrascosa de Abajo	42
2487	1	53	7	Duesaigües	43
2488	1	53	2	Camañas	44
2489	1	53	5	Consuegra	45
2490	1	53	8	Beneixida	46
2491	1	53	4	Cogeces de Íscar	47
2492	1	53	0	Laukiz	48
2493	1	53	3	Coreses	49
2494	1	53	6	Boquiñeni	50
2495	1	54	9	Urkabustaiz	1
2496	1	54	4	Navas de Jorquera	2
2497	1	54	0	Castell de Castells	3
2498	1	54	5	Illar	4
2499	1	54	8	Casavieja	5
2500	1	54	1	Fuente del Maestre	6
2501	1	54	7	Santa Eulalia del Río	7
2502	1	54	3	Castellbisbal	8
2503	1	54	6	Bozoó	9
2504	1	54	0	Casas del Castañar	10
2505	1	54	8	Membrilla	13
2506	1	54	3	Pozoblanco	14
2507	1	54	6	Narón	15
2508	1	54	5	Colera	17
2509	1	54	1	Cortes y Graena	18
2510	1	54	4	Budia	19
2511	1	54	8	Lizartza	20
2512	1	54	5	Palma del Condado	21
2513	1	54	0	Benasque	22
2514	1	54	6	Larva	23
2515	1	54	1	Cimanes de la Vega	24
2516	1	54	7	Cornago	26
2517	1	54	3	Riotorto	27
2518	1	54	9	El Escorial	28
2519	1	54	2	Fuengirola	29
2520	1	54	3	Bertizarana	31
2521	1	54	8	Ourense	32
2522	1	54	4	Las Regueras	33
2523	1	54	5	Tomiño	36
2524	1	54	1	El Bodón	37
2525	1	54	0	Polanco	39
2526	1	54	4	Cerezo de Arriba	40
2527	1	54	1	Lora de Estepa	41
2528	1	54	6	Carrascosa de la Sierra	42
2529	1	54	2	Espluga de Francolí, 	43
2530	1	54	7	Camarena de la Sierra	44
2531	1	54	0	Corral de Almaguer	45
2532	1	54	3	Benetússer	46
2533	1	54	9	Cogeces del Monte	47
2534	1	54	5	Leioa	48
2535	1	54	8	Corrales del Vino	49
2536	1	54	1	Bordalba	50
2537	1	55	2	Valdegovía/Gaubea	1
2538	1	55	7	Nerpio	2
2539	1	55	3	Catral	3
2540	1	55	8	Instinción	4
2541	1	55	1	Casillas	5
2542	1	55	4	Fuentes de León	6
2543	1	55	0	Santa Margalida	7
2544	1	55	6	Castellcir	8
2545	1	55	9	Brazacorta	9
2546	1	55	3	Casas del Monte	10
2547	1	55	5	Chodos/Xodos	12
2548	1	55	1	Mestanza	13
2549	1	55	6	Priego de Córdoba	14
2550	1	55	9	Neda	15
2551	1	55	2	Carboneras de Guadazaón	16
2552	1	55	8	Colomers	17
2553	1	55	7	Bujalaro	19
2554	1	55	1	Arrasate/Mondragón	20
2555	1	55	8	Palos de la Frontera	21
2556	1	55	3	Berbegal	22
2557	1	55	9	Linares	23
2558	1	55	4	Cimanes del Tejar	24
2559	1	55	7	Biosca	25
2560	1	55	0	Corporales	26
2561	1	55	6	Samos	27
2562	1	55	2	Estremera	28
2563	1	55	5	Fuente de Piedra	29
2564	1	55	6	Betelu	31
2565	1	55	1	Paderne de Allariz	32
2566	1	55	7	Ribadedeva	33
2567	1	55	2	Cervatos de la Cueza	34
2568	1	55	8	Tui	36
2569	1	55	4	Bogajo	37
2570	1	55	3	Potes	39
2571	1	55	7	Cilleruelo de San Mamés	40
2572	1	55	4	Lora del Río	41
2573	1	55	9	Casarejos	42
2574	1	55	5	Falset	43
2575	1	55	0	Camarillas	44
2576	1	55	3	Cuerva	45
2577	1	55	6	Beniarjó	46
2578	1	55	2	Corcos	47
2579	1	55	8	Lemoa	48
2580	1	55	1	Cotanes del Monte	49
2581	1	55	4	Borja	50
2582	1	56	5	Harana/Valle de Arana	1
2583	1	56	0	Ontur	2
2584	1	56	6	Cocentaina	3
2585	1	56	1	Laroya	4
2586	1	56	4	Castellanos de Zapardiel	5
2587	1	56	7	Garbayuela	6
2588	1	56	3	Santa María del Camí	7
2589	1	56	9	Castelldefels	8
2590	1	56	2	Briviesca	9
2591	1	56	6	Casas de Millán	10
2592	1	56	8	Chóvar	12
2593	1	56	4	Miguelturra	13
2594	1	56	9	Puente Genil	14
2595	1	56	2	Negreira	15
2596	1	56	5	Cardenete	16
2597	1	56	1	Cornellà del Terri	17
2598	1	56	7	Cúllar	18
2599	1	56	4	Mutriku	20
2600	1	56	1	Paterna del Campo	21
2601	1	56	2	Lopera	23
2602	1	56	7	Cistierna	24
2603	1	56	0	Bovera	25
2604	1	56	3	Cuzcurrita de Río Tirón	26
2605	1	56	9	Rábade	27
2606	1	56	5	Fresnedillas de la Oliva	28
2607	1	56	8	Gaucín	29
2608	1	56	9	Biurrun-Olcoz	31
2609	1	56	4	Padrenda	32
2610	1	56	0	Ribadesella	33
2611	1	56	5	Cervera de Pisuerga	34
2612	1	56	1	Valga	36
2613	1	56	7	La Bouza	37
2614	1	56	6	Puente Viesgo	39
2615	1	56	0	Cobos de Fuentidueña	40
2616	1	56	7	La Luisiana	41
2617	1	56	2	Castilfrío de la Sierra	42
2618	1	56	8	La Fatarella	43
2619	1	56	3	Caminreal	44
2620	1	56	6	Chozas de Canales	45
2621	1	56	9	Beniatjar	46
2622	1	56	5	Corrales de Duero	47
2623	1	56	1	Lemoiz	48
2624	1	56	4	Cubillos	49
2625	1	56	7	Botorrita	50
2626	1	57	1	Villabuena de Álava/Eskuernaga	1
2627	1	57	6	Ossa de Montiel	2
2628	1	57	2	Confrides	3
2629	1	57	7	Láujar de Andarax	4
2630	1	57	0	Cebreros	5
2631	1	57	3	Garlitos	6
2632	1	57	9	Santanyí	7
2633	1	57	5	Castell del Areny	8
2634	1	57	8	Bugedo	9
2635	1	57	2	Casas de Miravete	10
2636	1	57	4	Eslida	12
2637	1	57	0	Montiel	13
2638	1	57	5	Rambla, La	14
2639	1	57	8	Noia	15
2640	1	57	1	Carrascosa	16
2641	1	57	7	Corçà	17
2642	1	57	3	Cúllar Vega	18
2643	1	57	6	Bustares	19
2644	1	57	0	Mutiloa	20
2645	1	57	7	Paymogo	21
2646	1	57	2	Bielsa	22
2647	1	57	8	Lupión	23
2648	1	57	3	Congosto	24
2649	1	57	6	Bòrdes, Es	25
2650	1	57	9	Daroca de Rioja	26
2651	1	57	5	Sarria	27
2652	1	57	1	Fresno de Torote	28
2653	1	57	4	Genalguacil	29
2654	1	57	5	Buñuel	31
2655	1	57	0	Parada de Sil	32
2656	1	57	6	Ribera de Arriba	33
2657	1	57	1	Cevico de la Torre	34
2658	1	57	7	Vigo	36
2659	1	57	3	Bóveda del Río Almar	37
2660	1	57	2	Ramales de la Victoria	39
2661	1	57	6	Coca	40
2662	1	57	3	Madroño, El	41
2663	1	57	8	Castilruiz	42
2664	1	57	4	Febró, La	43
2665	1	57	2	Chueca	45
2666	1	57	5	Benicolet	46
2667	1	57	1	Cubillas de Santa Marta	47
2668	1	57	7	Lekeitio	48
2669	1	57	0	Cubo de Benavente	49
2670	1	57	3	Brea de Aragón	50
2671	1	58	7	Legutio	1
2672	1	58	2	Paterna del Madera	2
2673	1	58	8	Cox	3
2674	1	58	3	Líjar	4
2675	1	58	6	Cepeda la Mora	5
2676	1	58	9	Garrovilla, La	6
2677	1	58	5	Selva	7
2678	1	58	1	Castellet i la Gornal	8
2679	1	58	4	Buniel	9
2680	1	58	8	Casatejada	10
2681	1	58	0	Espadilla	12
2682	1	58	6	Moral de Calatrava	13
2683	1	58	1	Rute	14
2684	1	58	4	Oleiros	15
2685	1	58	7	Carrascosa de Haro	16
2686	1	58	3	Crespià	17
2687	1	58	2	Cabanillas del Campo	19
2688	1	58	6	Olaberria	20
2689	1	58	3	Puebla de Guzmán	21
2690	1	58	8	Bierge	22
2691	1	58	4	Mancha Real	23
2692	1	58	9	Corbillos de los Oteros	24
2693	1	58	2	Borges Blanques, Les	25
2694	1	58	5	Enciso	26
2695	1	58	1	Saviñao, O	27
2696	1	58	7	Fuenlabrada	28
2697	1	58	0	Guaro	29
2698	1	58	1	Auritz/Burguete	31
2699	1	58	6	Pereiro de Aguiar, O	32
2700	1	58	2	Riosa	33
2701	1	58	7	Cevico Navero	34
2702	1	58	3	Vilaboa	36
2703	1	58	9	Brincones	37
2704	1	58	8	Rasines	39
2705	1	58	2	Codorniz	40
2706	1	58	9	Mairena del Alcor	41
2707	1	58	4	Castillejo de Robledo	42
2708	1	58	0	Figuera, La	43
2709	1	58	8	Domingo Pérez	45
2710	1	58	1	Benifairó de les Valls	46
2711	1	58	7	Cuenca de Campos	47
2712	1	58	3	Mallabia	48
2713	1	58	6	Cubo de Tierra del Vino, El	49
2714	1	58	9	Bubierca	50
2715	1	59	0	Vitoria-Gasteiz	1
2716	1	59	5	Peñascosa	2
2717	1	59	1	Crevillent	3
2718	1	59	6	Lubrín	4
2719	1	59	9	Cillán	5
2720	1	59	2	Granja de Torrehermosa	6
2721	1	59	8	Salines, Ses	7
2722	1	59	4	Castellfollit del Boix	8
2723	1	59	7	Burgos	9
2724	1	59	1	Casillas de Coria	10
2725	1	59	3	Fanzara	12
2726	1	59	9	Navalpino	13
2727	1	59	4	San Sebastián de los Ballesteros	14
2728	1	59	7	Ordes	15
2729	1	59	2	Chauchina	18
2730	1	59	5	Campillo de Dueñas	19
2731	1	59	9	Oñati	20
2732	1	59	6	Puerto Moral	21
2733	1	59	1	Biescas	22
2734	1	59	7	Marmolejo	23
2735	1	59	2	Corullón	24
2736	1	59	5	Bossòst	25
2737	1	59	8	Entrena	26
2738	1	59	4	Sober	27
2739	1	59	0	Fuente el Saz de Jarama	28
2740	1	59	3	Humilladero	29
2741	1	59	4	Burgui/Burgi	31
2742	1	59	9	Peroxa, A	32
2743	1	59	5	Salas	33
2744	1	59	0	Cisneros	34
2745	1	59	6	Vila de Cruces	36
2746	1	59	2	Buenamadre	37
2747	1	59	1	Reinosa	39
2748	1	59	5	Collado Hermoso	40
2749	1	59	2	Mairena del Aljarafe	41
2750	1	59	7	Centenera de Andaluz	42
2751	1	59	3	Figuerola del Camp	43
2752	1	59	8	Cantavieja	44
2753	1	59	1	Dosbarrios	45
2754	1	59	4	Benifairó de la Valldigna	46
2755	1	59	0	Curiel de Duero	47
2756	1	59	6	Mañaria	48
2757	1	59	9	Cuelgamures	49
2758	1	59	2	Bujaraloz	50
2759	1	60	4	Yécora/Iekora	1
2760	1	60	9	Peñas de San Pedro	2
2761	1	60	5	Quatretondeta	3
2762	1	60	0	Lucainena de las Torres	4
2763	1	60	3	Cisla	5
2764	1	60	6	Guareña	6
2765	1	60	2	Sineu	7
2766	1	60	8	Castellfollit de Riubregós	8
2767	1	60	1	Busto de Bureba	9
2768	1	60	5	Castañar de Ibor	10
2769	1	60	7	Figueroles	12
2770	1	60	3	Navas de Estena	13
2771	1	60	8	Santaella	14
2772	1	60	1	Oroso	15
2773	1	60	4	Casas de Benítez	16
2774	1	60	0	Darnius	17
2775	1	60	9	Campillo de Ranas	19
2776	1	60	3	Orexa	20
2777	1	60	0	Punta Umbría	21
2778	1	60	5	Binaced	22
2779	1	60	1	Martos	23
2780	1	60	6	Crémenes	24
2781	1	60	9	Cabanabona	25
2782	1	60	2	Estollo	26
2783	1	60	8	Taboada	27
2784	1	60	4	Fuentidueña de Tajo	28
2785	1	60	7	Igualeja	29
2786	1	60	8	Burlada/Burlata	31
2787	1	60	3	Petín	32
2788	1	60	9	San Martín del Rey Aurelio	33
2789	1	60	4	Cobos de Cerrato	34
2790	1	60	0	Vilagarcía de Arousa	36
2791	1	60	6	Buenavista	37
2792	1	60	5	Reocín	39
2793	1	60	9	Condado de Castilnovo	40
2794	1	60	6	Marchena	41
2795	1	60	1	Cerbón	42
2796	1	60	7	Flix	43
2797	1	60	2	Cañada de Benatanduz	44
2798	1	60	5	Erustes	45
2799	1	60	8	Benifaió	46
2800	1	60	4	Encinas de Esgueva	47
2801	1	60	0	Markina-Xemein	48
2802	1	60	6	Bulbuente	50
2803	1	61	1	Zalduondo	1
2804	1	61	6	Pétrola	2
2805	1	61	2	Daya Nueva	3
2806	1	61	7	Lúcar	4
2807	1	61	0	Colilla, La	5
2808	1	61	3	Haba, La	6
2809	1	61	9	Sóller	7
2810	1	61	5	Castellgalí	8
2811	1	61	8	Cabañes de Esgueva	9
2812	1	61	2	Ceclavín	10
2813	1	61	4	Forcall	12
2814	1	61	0	Pedro Muñoz	13
2815	1	61	5	Santa Eufemia	14
2816	1	61	8	Ortigueira	15
2817	1	61	1	Casas de Fernando Alonso	16
2818	1	61	7	Das	17
2819	1	61	3	Chimeneas	18
2820	1	61	6	Campisábalos	19
2821	1	61	0	Orio	20
2822	1	61	7	Rociana del Condado	21
2823	1	61	2	Binéfar	22
2824	1	61	8	Mengíbar	23
2825	1	61	3	Cuadros	24
2826	1	61	6	Cabó	25
2827	1	61	9	Ezcaray	26
2828	1	61	5	Trabada	27
2829	1	61	1	Galapagar	28
2830	1	61	4	Istán	29
2831	1	61	5	Busto, El	31
2832	1	61	0	Piñor	32
2833	1	61	6	San Martín de Oscos	33
2834	1	61	1	Collazos de Boedo	34
2835	1	61	7	Vilanova de Arousa	36
2836	1	61	3	Cabaco, El	37
2837	1	61	2	Ribamontán al Mar	39
2838	1	61	6	Corral de Ayllón	40
2839	1	61	3	Marinaleda	41
2840	1	61	8	Cidones	42
2841	1	61	4	Forès	43
2842	1	61	9	Cañada de Verich, La	44
2843	1	61	2	Escalona	45
2844	1	61	5	Beniflá	46
2845	1	61	1	Esguevillas de Esgueva	47
2846	1	61	7	Maruri-Jatabe	48
2847	1	61	0	Entrala	49
2848	1	61	3	Bureta	50
2849	1	62	6	Zambrana	1
2850	1	62	1	Povedilla	2
2851	1	62	7	Daya Vieja	3
2852	1	62	2	Macael	4
2853	1	62	5	Collado de Contreras	5
2854	1	62	8	Helechosa de los Montes	6
2855	1	62	4	Son Servera	7
2856	1	62	0	Castellnou de Bages	8
2857	1	62	3	Cabezón de la Sierra	9
2858	1	62	7	Cedillo	10
2859	1	62	5	Picón	13
2860	1	62	0	Torrecampo	14
2861	1	62	3	Outes	15
2862	1	62	6	Casas de Garcimolina	16
2863	1	62	2	Escala, 	17
2864	1	62	8	Churriana de la Vega	18
2865	1	62	5	Ormaiztegi	20
2866	1	62	2	Rosal de la Frontera	21
2867	1	62	7	Bisaurri	22
2868	1	62	3	Montizón	23
2869	1	62	8	Cubillas de los Oteros	24
2870	1	62	1	Camarasa	25
2871	1	62	4	Foncea	26
2872	1	62	0	Triacastela	27
2873	1	62	6	Garganta de los Montes	28
2874	1	62	9	Iznate	29
2875	1	62	0	Cabanillas	31
2876	1	62	5	Porqueira	32
2877	1	62	1	Santa Eulalia de Oscos	33
2878	1	62	6	Congosto de Valdavia	34
2879	1	62	8	Cabezabellosa de la Calzada	37
2880	1	62	7	Ribamontán al Monte	39
2881	1	62	1	Cubillo	40
2882	1	62	8	Martín de la Jara	41
2883	1	62	3	Cigudosa	42
2884	1	62	9	Freginals	43
2885	1	62	4	Cañada Vellida	44
2886	1	62	7	Escalonilla	45
2887	1	62	0	Benigánim	46
2888	1	62	6	Fombellida	47
2889	1	62	2	Mendata	48
2890	1	62	5	Espadañedo	49
2891	1	62	8	Burgo de Ebro, El	50
2892	1	63	2	Zuia	1
2893	1	63	7	Pozohondo	2
2894	1	63	3	Dénia	3
2895	1	63	8	María	4
2896	1	63	1	Collado del Mirón	5
2897	1	63	4	Herrera del Duque	6
2898	1	63	0	Valldemossa	7
2899	1	63	6	Castellolí	8
2900	1	63	9	Cavia	9
2901	1	63	3	Cerezo	10
2902	1	63	5	Fuente la Reina	12
2903	1	63	1	Piedrabuena	13
2904	1	63	6	Valenzuela	14
2905	1	63	9	Oza dos Ríos	15
2906	1	63	2	Casas de Guijarro	16
2907	1	63	8	Espinelves	17
2908	1	63	4	Darro	18
2909	1	63	1	Oiartzun	20
2910	1	63	8	San Bartolomé de la Torre	21
2911	1	63	3	Biscarrués	22
2912	1	63	9	Navas de San Juan	23
2913	1	63	4	Cubillas de Rueda	24
2914	1	63	7	Canejan	25
2915	1	63	0	Fonzaleche	26
2916	1	63	6	Valadouro, O	27
2917	1	63	2	Gargantilla del Lozoya y Pinilla de Buitrago	28
2918	1	63	5	Jimera de Líbar	29
2919	1	63	6	Cabredo	31
2920	1	63	1	Pobra de Trives, A	32
2921	1	63	7	San Tirso de Abres	33
2922	1	63	2	Cordovilla la Real	34
2923	1	63	4	Cabeza de Béjar, La	37
2924	1	63	3	Rionansa	39
2925	1	63	7	Cuéllar	40
2926	1	63	4	Molares, Los	41
2927	1	63	9	Cihuela	42
2928	1	63	5	Galera, La	43
2929	1	63	0	Cañizar del Olivar	44
2930	1	63	3	Espinoso del Rey	45
2931	1	63	6	Benimodo	46
2932	1	63	2	Fompedraza	47
2933	1	63	8	Mendexa	48
2934	1	63	1	Faramontanos de Tábara	49
2935	1	63	4	Buste, El	50
2936	1	64	2	Pozo-Lorente	2
2937	1	64	8	Dolores	3
2938	1	64	3	Mojácar	4
2939	1	64	6	Constanzana	5
2940	1	64	9	Higuera de la Serena	6
2941	1	64	5	Castell, Es	7
2942	1	64	1	Castellterçol	8
2943	1	64	4	Caleruega	9
2944	1	64	8	Cilleros	10
2945	1	64	0	Fuentes de Ayódar	12
2946	1	64	6	Poblete	13
2947	1	64	1	Valsequillo	14
2948	1	64	4	Paderne	15
2949	1	64	7	Casas de Haro	16
2950	1	64	3	Espolla	17
2951	1	64	9	Dehesas de Guadix	18
2952	1	64	2	Canredondo	19
2953	1	64	6	Pasaia	20
2954	1	64	3	San Juan del Puerto	21
2955	1	64	8	Blecua y Torres	22
2956	1	64	4	Noalejo	23
2957	1	64	9	Cubillos del Sil	24
2958	1	64	2	Castellar de la Ribera	25
2959	1	64	5	Fuenmayor	26
2960	1	64	1	Vicedo, O	27
2961	1	64	7	Gascones	28
2962	1	64	0	Jubrique	29
2963	1	64	1	Cadreita	31
2964	1	64	6	Pontedeva	32
2965	1	64	2	Santo Adriano	33
2966	1	64	8	Riotuerto	39
2967	1	64	9	Montellano	41
2968	1	64	4	Ciria	42
2969	1	64	0	Gandesa	43
2970	1	64	5	Cascante del Río	44
2971	1	64	8	Esquivias	45
2972	1	64	1	Benimuslem	46
2973	1	64	7	Fontihoyuelo	47
2974	1	64	3	Meñaka	48
2975	1	64	6	Fariza	49
2976	1	64	9	Cabañas de Ebro	50
2977	1	65	5	Pozuelo	2
2978	1	65	1	Elche/Elx	3
2979	1	65	6	Nacimiento	4
2980	1	65	9	Crespos	5
2981	1	65	2	Higuera de Llerena	6
2982	1	65	8	Vilafranca de Bonany	7
2983	1	65	4	Castellví de la Marca	8
2984	1	65	7	Campillo de Aranda	9
2985	1	65	1	Collado	10
2986	1	65	3	Gaibiel	12
2987	1	65	9	Porzuna	13
2988	1	65	4	Victoria, La	14
2989	1	65	7	Padrón	15
2990	1	65	0	Casas de los Pinos	16
2991	1	65	6	Esponellà	17
2992	1	65	5	Cantalojas	19
2993	1	65	9	Soraluze/Placencia de las Armas	20
2994	1	65	6	Sanlúcar de Guadiana	21
2995	1	65	7	Orcera	23
2996	1	65	2	Chozas de Abajo	24
2997	1	65	8	Galbárruli	26
2998	1	65	4	Vilalba	27
2999	1	65	0	Getafe	28
3000	1	65	3	Júzcar	29
3001	1	65	4	Caparroso	31
3002	1	65	9	Punxín	32
3003	1	65	5	Sariego	33
3004	1	65	2	Cabeza del Caballo	37
3005	1	65	1	Rozas de Valdearroyo, Las	39
3006	1	65	5	Chañe	40
3007	1	65	2	Morón de la Frontera	41
3008	1	65	7	Cirujales del Río	42
3009	1	65	3	Garcia	43
3010	1	65	8	Castejón de Tornos	44
3011	1	65	1	Estrella, La	45
3012	1	65	4	Beniparrell	46
3013	1	65	0	Fresno el Viejo	47
3014	1	65	6	Ugao-Miraballes	48
3015	1	65	9	Fermoselle	49
3016	1	65	2	Cabolafuente	50
3017	1	66	8	Recueja, La	2
3018	1	66	4	Elda	3
3019	1	66	9	Níjar	4
3020	1	66	2	Cuevas del Valle	5
3021	1	66	5	Higuera de Vargas	6
3022	1	66	7	Castellví de Rosanes	8
3023	1	66	0	Campolara	9
3024	1	66	4	Conquista de la Sierra	10
3025	1	66	2	Pozuelo de Calatrava	13
3026	1	66	7	Villa del Río	14
3027	1	66	0	Pino, O	15
3028	1	66	3	Casasimarro	16
3029	1	66	9	Figueres	17
3030	1	66	5	Deifontes	18
3031	1	66	8	Cañizar	19
3032	1	66	2	Errezil	20
3033	1	66	9	San Silvestre de Guzmán	21
3034	1	66	4	Boltaña	22
3035	1	66	0	Peal de Becerro	23
3036	1	66	5	Destriana	24
3037	1	66	1	Galilea	26
3038	1	66	7	Viveiro	27
3039	1	66	3	Griñón	28
3040	1	66	6	Macharaviaya	29
3041	1	66	7	Cárcar	31
3042	1	66	2	Quintela de Leirado	32
3043	1	66	8	Siero	33
3044	1	66	3	Cubillas de Cerrato	34
3045	1	66	4	Ruente	39
3046	1	66	5	Navas de la Concepción, Las	41
3047	1	66	6	Garidells, Els	43
3048	1	66	1	Castel de Cabra	44
3049	1	66	4	Fuensalida	45
3050	1	66	7	Benirredrà	46
3051	1	66	3	Fuensaldaña	47
3052	1	66	9	Morga	48
3053	1	66	2	Ferreras de Abajo	49
3054	1	66	5	Cadrete	50
3055	1	67	4	Riópar	2
3056	1	67	0	Facheca	3
3057	1	67	5	Ohanes	4
3058	1	67	8	Chamartín	5
3059	1	67	1	Higuera la Real	6
3060	1	67	3	Centelles	8
3061	1	67	6	Canicosa de la Sierra	9
3062	1	67	0	Coria	10
3063	1	67	2	Geldo	12
3064	1	67	8	Pozuelos de Calatrava, Los	13
3065	1	67	3	Villafranca de Córdoba	14
3066	1	67	6	Pobra do Caramiñal, A	15
3067	1	67	9	Castejón	16
3068	1	67	5	Flaçà	17
3069	1	67	1	Diezma	18
3070	1	67	4	Cardoso de la Sierra, El	19
3071	1	67	8	Errenteria	20
3072	1	67	5	Santa Ana la Real	21
3073	1	67	0	Bonansa	22
3074	1	67	6	Pegalajar	23
3075	1	67	1	Encinedo	24
3076	1	67	4	Castelldans	25
3077	1	67	7	Gallinero de Cameros	26
3078	1	67	9	Guadalix de la Sierra	28
3079	1	67	2	Málaga	29
3080	1	67	3	Carcastillo	31
3081	1	67	8	Rairiz de Veiga	32
3082	1	67	4	Sobrescobio	33
3083	1	67	9	Dehesa de Montejo	34
3084	1	67	1	Cabrerizos	37
3085	1	67	0	Ruesga	39
3086	1	67	1	Olivares	41
3087	1	67	2	Ginestar	43
3088	1	67	7	Castelnou	44
3089	1	67	0	Gálvez	45
3090	1	67	3	Benisanó	46
3091	1	67	9	Fuente el Sol	47
3092	1	67	5	Muxika	48
3093	1	67	8	Ferreras de Arriba	49
3094	1	67	1	Calatayud	50
3095	1	68	0	Robledo	2
3096	1	68	6	Famorca	3
3097	1	68	1	Olula de Castro	4
3098	1	68	7	Hinojosa del Valle	6
3099	1	68	9	Cervelló	8
3100	1	68	2	Cantabrana	9
3101	1	68	6	Cuacos de Yuste	10
3102	1	68	8	Herbés	12
3103	1	68	4	Puebla de Don Rodrigo	13
3104	1	68	9	Villaharta	14
3105	1	68	2	Ponteceso	15
3106	1	68	5	Castillejo de Iniesta	16
3107	1	68	1	Foixà	17
3108	1	68	7	Dílar	18
3109	1	68	4	Leintz-Gatzaga	20
3110	1	68	1	Santa Bárbara de Casa	21
3111	1	68	6	Borau	22
3112	1	68	7	Ercina, La	24
3113	1	68	0	Castellnou de Seana	25
3114	1	68	3	Gimileo	26
3115	1	68	5	Guadarrama	28
3116	1	68	8	Manilva	29
3117	1	68	9	Cascante	31
3118	1	68	4	Ramirás	32
3119	1	68	0	Somiedo	33
3120	1	68	5	Dehesa de Romanos	34
3121	1	68	7	Cabrillas	37
3122	1	68	6	Ruiloba	39
3123	1	68	0	Domingo García	40
3124	1	68	7	Osuna	41
3125	1	68	2	Coscurita	42
3126	1	68	8	Godall	43
3127	1	68	3	Castelserás	44
3128	1	68	6	Garciotum	45
3129	1	68	9	Benissoda	46
3130	1	68	5	Fuente-Olmedo	47
3131	1	68	1	Mundaka	48
3132	1	68	4	Ferreruela	49
3133	1	68	7	Calatorao	50
3134	1	69	3	Roda, La	2
3135	1	69	9	Finestrat	3
3136	1	69	4	Olula del Río	4
3137	1	69	7	Donjimeno	5
3138	1	69	0	Hornachos	6
3139	1	69	2	Collbató	8
3140	1	69	9	Cumbre, La	10
3141	1	69	1	Higueras	12
3142	1	69	7	Puebla del Príncipe	13
3143	1	69	2	Villanueva de Córdoba	14
3144	1	69	5	Pontedeume	15
3145	1	69	4	Fontanals de Cerdanya	17
3146	1	69	0	Dólar	18
3147	1	69	7	Donostia-San Sebastián	20
3148	1	69	4	Santa Olalla del Cala	21
3149	1	69	9	Broto	22
3150	1	69	5	Porcuna	23
3151	1	69	0	Escobar de Campos	24
3152	1	69	3	Castelló de Farfanya	25
3153	1	69	6	Grañón	26
3154	1	69	8	Hiruela, La	28
3155	1	69	1	Marbella	29
3156	1	69	2	Cáseda	31
3157	1	69	7	Ribadavia	32
3158	1	69	3	Soto del Barco	33
3159	1	69	8	Dueñas	34
3160	1	69	0	Calvarrasa de Abajo	37
3161	1	69	9	San Felices de Buelna	39
3162	1	69	3	Donhierro	40
3163	1	69	0	Palacios y Villafranca, Los	41
3164	1	69	5	Covaleda	42
3165	1	69	1	Gratallops	43
3166	1	69	9	Gerindote	45
3167	1	69	2	Benisuera	46
3168	1	69	8	Gallegos de Hornija	47
3169	1	69	4	Mungia	48
3170	1	69	7	Figueruela de Arriba	49
3171	1	69	0	Calcena	50
3172	1	70	7	Salobre	2
3173	1	70	3	Formentera del Segura	3
3174	1	70	8	Oria	4
3175	1	70	1	Donvidas	5
3176	1	70	4	Jerez de los Caballeros	6
3177	1	70	6	Collsuspina	8
3178	1	70	9	Carazo	9
3179	1	70	3	Deleitosa	10
3180	1	70	5	Jana, la	12
3181	1	70	1	Puerto Lápice	13
3182	1	70	6	Villanueva del Duque	14
3183	1	70	9	Pontes de García Rodríguez, As	15
3184	1	70	2	Castillejo-Sierra	16
3185	1	70	8	Fontanilles	17
3186	1	70	4	Dúdar	18
3187	1	70	7	Casa de Uceda	19
3188	1	70	1	Segura	20
3189	1	70	8	Trigueros	21
3190	1	70	9	Pozo Alcón	23
3191	1	70	4	Fabero	24
3192	1	70	7	Castellserà	25
3193	1	70	0	Grávalos	26
3194	1	70	2	Horcajo de la Sierra-Aoslos	28
3195	1	70	5	Mijas	29
3196	1	70	6	Castejón	31
3197	1	70	1	San Xoán de Río	32
3198	1	70	7	Tapia de Casariego	33
3199	1	70	2	Espinosa de Cerrato	34
3200	1	70	4	Calvarrasa de Arriba	37
3201	1	70	3	San Miguel de Aguayo	39
3202	1	70	7	Duruelo	40
3203	1	70	4	Palomares del Río	41
3204	1	70	9	Cubilla	42
3205	1	70	5	Guiamets, Els	43
3206	1	70	0	Castellar, El	44
3207	1	70	3	Guadamur	45
3208	1	70	6	Bétera	46
3209	1	70	2	Gatón de Campos	47
3210	1	70	8	Aulesti	48
3211	1	70	4	Calmarza	50
3212	1	71	4	San Pedro	2
3213	1	71	0	Gata de Gorgos	3
3214	1	71	5	Padules	4
3215	1	71	1	Lapa, La	6
3216	1	71	3	Copons	8
3217	1	71	6	Carcedo de Bureba	9
3218	1	71	0	Descargamaría	10
3219	1	71	2	Jérica	12
3220	1	71	8	Puertollano	13
3221	1	71	3	Villanueva del Rey	14
3222	1	71	6	Porto do Son	15
3223	1	71	9	Castillo-Albaráñez	16
3224	1	71	5	Fontcoberta	17
3225	1	71	1	Dúrcal	18
3226	1	71	4	Casar, El	19
3227	1	71	8	Tolosa	20
3228	1	71	5	Valdelarco	21
3229	1	71	6	Puente de Génave	23
3230	1	71	1	Folgoso de la Ribera	24
3231	1	71	4	Cava	25
3232	1	71	7	Haro	26
3233	1	71	9	Horcajuelo de la Sierra	28
3234	1	71	2	Moclinejo	29
3235	1	71	3	Castillonuevo	31
3236	1	71	8	Riós	32
3237	1	71	4	Taramundi	33
3238	1	71	9	Espinosa de Villagonzalo	34
3239	1	71	1	Calzada de Béjar, La	37
3240	1	71	0	San Pedro del Romeral	39
3241	1	71	4	Encinas	40
3242	1	71	1	Paradas	41
3243	1	71	6	Cubo de la Solana	42
3244	1	71	2	Horta de Sant Joan	43
3245	1	71	7	Castellote	44
3246	1	71	0	Guardia, La	45
3247	1	71	3	Bicorp	46
3248	1	71	9	Geria	47
3249	1	71	5	Muskiz	48
3250	1	71	8	Fonfría	49
3251	1	71	1	Campillo de Aragón	50
3252	1	72	9	Socovos	2
3253	1	72	5	Gaianes	3
3254	1	72	0	Partaloa	4
3255	1	72	3	Espinosa de los Caballeros	5
3256	1	72	6	Lobón	6
3257	1	72	8	Corbera de Llobregat	8
3258	1	72	1	Carcedo de Burgos	9
3259	1	72	5	Eljas	10
3260	1	72	7	Lucena del Cid	12
3261	1	72	3	Retuerta del Bullaque	13
3262	1	72	8	Villaralto	14
3263	1	72	1	Rianxo	15
3264	1	72	4	Castillo de Garcimuñoz	16
3265	1	72	6	Escúzar	18
3266	1	72	3	Urnieta	20
3267	1	72	0	Valverde del Camino	21
3268	1	72	5	Caldearenas	22
3269	1	72	1	Puerta de Segura, La	23
3270	1	72	9	Cervera	25
3271	1	72	2	Herce	26
3272	1	72	4	Hoyo de Manzanares	28
3273	1	72	7	Mollina	29
3274	1	72	8	Cintruénigo	31
3275	1	72	3	Rúa, A	32
3276	1	72	9	Teverga	33
3277	1	72	4	Frechilla	34
3278	1	72	6	Calzada de Don Diego	37
3279	1	72	5	San Roque de Riomiera	39
3280	1	72	9	Encinillas	40
3281	1	72	6	Pedrera	41
3282	1	72	7	Lloar, El	43
3283	1	72	5	Herencias, Las	45
3284	1	72	8	Bocairent	46
3285	1	72	0	Otxandio	48
3286	1	72	6	Carenas	50
3287	1	73	5	Tarazona de la Mancha	2
3288	1	73	1	Gorga	3
3289	1	73	6	Paterna del Río	4
3290	1	73	9	Flores de Ávila	5
3291	1	73	2	Llera	6
3292	1	73	4	Cornellà de Llobregat	8
3293	1	73	7	Cardeñadijo	9
3294	1	73	1	Escurial	10
3295	1	73	3	Ludiente	12
3296	1	73	9	Saceruela	13
3297	1	73	4	Villaviciosa de Córdoba	14
3298	1	73	7	Ribeira	15
3299	1	73	0	Cervera del Llano	16
3300	1	73	6	Fornells de la Selva	17
3301	1	73	5	Casas de San Galindo	19
3302	1	73	9	Usurbil	20
3303	1	73	6	Villablanca	21
3304	1	73	7	Quesada	23
3305	1	73	2	Fresno de la Vega	24
3306	1	73	5	Cervià de les Garrigues	25
3307	1	73	8	Herramélluri	26
3308	1	73	0	Humanes de Madrid	28
3309	1	73	3	Monda	29
3310	1	73	4	Ziordia	31
3311	1	73	9	Rubiá	32
3312	1	73	5	Tineo	33
3313	1	73	0	Fresno del Río	34
3314	1	73	2	Calzada de Valdunciel	37
3315	1	73	1	Santa Cruz de Bezana	39
3316	1	73	5	Escalona del Prado	40
3317	1	73	2	Pedroso, El	41
3318	1	73	7	Cueva de Ágreda	42
3319	1	73	3	Llorac	43
3320	1	73	1	Herreruela de Oropesa	45
3321	1	73	4	Bolbaite	46
3322	1	73	0	Herrín de Campos	47
3323	1	73	6	Ondarroa	48
3324	1	73	2	Cariñena	50
3325	1	74	0	Tobarra	2
3326	1	74	6	Granja de Rocamora	3
3327	1	74	1	Pechina	4
3328	1	74	4	Fontiveros	5
3329	1	74	7	Llerena	6
3330	1	74	9	Cubelles	8
3331	1	74	2	Cardeñajimeno	9
3332	1	74	8	Llosa, la	12
3333	1	74	4	San Carlos del Valle	13
3334	1	74	9	Viso, El	14
3335	1	74	2	Rois	15
3336	1	74	5	Cierva, La	16
3337	1	74	1	Fortià	17
3338	1	74	7	Ferreira	18
3339	1	74	0	Caspueñas	19
3340	1	74	4	Bergara	20
3341	1	74	1	Villalba del Alcor	21
3342	1	74	6	Campo	22
3343	1	74	2	Rus	23
3344	1	74	7	Fuentes de Carbajal	24
3345	1	74	0	Ciutadilla	25
3346	1	74	3	Hervías	26
3347	1	74	5	Leganés	28
3348	1	74	8	Montejaque	29
3349	1	74	9	Cirauqui/Zirauki	31
3350	1	74	4	San Amaro	32
3351	1	74	0	Vegadeo	33
3352	1	74	5	Frómista	34
3353	1	74	7	Campillo de Azaba	37
3354	1	74	6	Santa María de Cayón	39
3355	1	74	0	Escarabajosa de Cabezas	40
3356	1	74	7	Peñaflor	41
3357	1	74	8	Llorenç del Penedès	43
3358	1	74	3	Cedrillas	44
3359	1	74	6	Hinojosa de San Vicente	45
3360	1	74	9	Bonrepòs i Mirambell	46
3361	1	74	5	Hornillos de Eresma	47
3362	1	74	1	Urduña/Orduña	48
3363	1	74	7	Caspe	50
3364	1	75	3	Valdeganga	2
3365	1	75	9	Castell de Guadalest, el	3
3366	1	75	4	Pulpí	4
3367	1	75	7	Fresnedilla	5
3368	1	75	0	Magacela	6
3369	1	75	2	Dosrius	8
3370	1	75	5	Cardeñuela Riopico	9
3371	1	75	9	Fresnedoso de Ibor	10
3372	1	75	1	Mata de Morella, la	12
3373	1	75	7	San Lorenzo de Calatrava	13
3374	1	75	2	Zuheros	14
3375	1	75	5	Sada	15
3376	1	75	4	Garrigàs	17
3377	1	75	3	Castejón de Henares	19
3378	1	75	7	Villabona	20
3379	1	75	4	Villanueva de las Cruces	21
3380	1	75	9	Camporrélls	22
3381	1	75	5	Sabiote	23
3382	1	75	3	Clariana de Cardener	25
3383	1	75	6	Hormilla	26
3384	1	75	8	Loeches	28
3385	1	75	1	Nerja	29
3386	1	75	2	Ciriza/Ziritza	31
3387	1	75	7	San Cibrao das Viñas	32
3388	1	75	3	Villanueva de Oscos	33
3389	1	75	9	Santander	39
3390	1	75	3	Escobar de Polendos	40
3391	1	75	0	Pilas	41
3392	1	75	5	Dévanos	42
3393	1	75	1	Margalef	43
3394	1	75	6	Celadas	44
3395	1	75	9	Hontanar	45
3396	1	75	2	Bufali	46
3397	1	75	8	Íscar	47
3398	1	75	4	Orozko	48
3399	1	75	7	Fresno de la Polvorosa	49
3400	1	75	0	Castejón de Alarba	50
3401	1	76	6	Vianos	2
3402	1	76	2	Guardamar del Segura	3
3403	1	76	7	Purchena	4
3404	1	76	0	Fresno, El	5
3405	1	76	3	Maguilla	6
3406	1	76	5	Esparreguera	8
3407	1	76	8	Carrias	9
3408	1	76	2	Galisteo	10
3409	1	76	4	Matet	12
3410	1	76	0	Santa Cruz de los Cáñamos	13
3411	1	76	8	San Sadurniño	15
3412	1	76	7	Garrigoles	17
3413	1	76	3	Fonelas	18
3414	1	76	6	Castellar de la Muela	19
3415	1	76	0	Ordizia	20
3416	1	76	7	Villanueva de los Castillejos	21
3417	1	76	2	Canal de Berdún	22
3418	1	76	8	Santa Elena	23
3419	1	76	3	Garrafe de Torío	24
3420	1	76	6	Cogul, El	25
3421	1	76	9	Hormilleja	26
3422	1	76	1	Lozoya	28
3423	1	76	4	Ojén	29
3424	1	76	5	Cizur	31
3425	1	76	0	San Cristovo de Cea	32
3426	1	76	6	Villaviciosa	33
3427	1	76	1	Fuentes de Nava	34
3428	1	76	2	Santillana del Mar	39
3429	1	76	6	Espinar, El	40
3430	1	76	3	Pruna	41
3431	1	76	8	Deza	42
3432	1	76	4	Marçà	43
3433	1	76	9	Cella	44
3434	1	76	2	Hormigos	45
3435	1	76	5	Bugarra	46
3436	1	76	1	Laguna de Duero	47
3437	1	76	7	Sukarrieta	48
3438	1	76	0	Fresno de la Ribera	49
3439	1	76	3	Castejón de las Armas	50
3440	1	77	2	Villa de Ves	2
3441	1	77	8	Fondó de les Neus, el/Hondón de las Nieves	3
3442	1	77	3	Rágol	4
3443	1	77	6	Fuente el Saúz	5
3444	1	77	9	Malcocinado	6
3445	1	77	1	Esplugues de Llobregat	8
3446	1	77	4	Cascajares de Bureba	9
3447	1	77	8	Garciaz	10
3448	1	77	0	Moncofa	12
3449	1	77	6	Santa Cruz de Mudela	13
3450	1	77	4	Santa Comba	15
3451	1	77	3	Garriguella	17
3452	1	77	6	Urretxu	20
3453	1	77	3	Villarrasa	21
3454	1	77	8	Candasnos	22
3455	1	77	4	Santiago de Calatrava	23
3456	1	77	9	Gordaliza del Pino	24
3457	1	77	2	Coll de Nargó	25
3458	1	77	5	Hornillos de Cameros	26
3459	1	77	0	Parauta	29
3460	1	77	1	Corella	31
3461	1	77	6	Sandiás	32
3462	1	77	2	Villayón	33
3463	1	77	7	Fuentes de Valdepero	34
3464	1	77	9	Campo de Peñaranda, El	37
3465	1	77	8	Santiurde de Reinosa	39
3466	1	77	2	Espirdo	40
3467	1	77	9	Puebla de Cazalla, La	41
3468	1	77	0	Mas de Barberans	43
3469	1	77	5	Cerollera, La	44
3470	1	77	8	Huecas	45
3471	1	77	1	Buñol	46
3472	1	77	7	Langayo	47
3473	1	77	3	Plentzia	48
3474	1	77	6	Fresno de Sayago	49
3475	1	77	9	Castejón de Valdejasa	50
3476	1	78	8	Villalgordo del Júcar	2
3477	1	78	4	Hondón de los Frailes	3
3478	1	78	9	Rioja	4
3479	1	78	2	Fuentes de Año	5
3480	1	78	5	Malpartida de la Serena	6
3481	1	78	7	Espunyola, 	8
3482	1	78	0	Cascajares de la Sierra	9
3483	1	78	4	Garganta, La	10
3484	1	78	6	Montán	12
3485	1	78	2	Socuéllamos	13
3486	1	78	0	Santiago de Compostela	15
3487	1	78	3	Cuenca	16
3488	1	78	9	Ger	17
3489	1	78	5	Freila	18
3490	1	78	8	Castilforte	19
3491	1	78	2	Zaldibia	20
3492	1	78	9	Zalamea la Real	21
3493	1	78	4	Canfranc	22
3494	1	78	5	Gordoncillo	24
3495	1	78	8	Corbins	25
3496	1	78	1	Hornos de Moncalvillo	26
3497	1	78	3	Madarcos	28
3498	1	78	7	Cortes	31
3499	1	78	2	Sarreaus	32
3500	1	78	8	Yernes y Tameza	33
3501	1	78	5	Candelario	37
3502	1	78	4	Santiurde de Toranzo	39
3503	1	78	8	Fresneda de Cuéllar	40
3504	1	78	5	Puebla de los Infantes, La	41
3505	1	78	0	Duruelo de la Sierra	42
3506	1	78	6	Masdenverge	43
3507	1	78	4	Huerta de Valdecarábanos	45
3508	1	78	7	Burjassot	46
3509	1	78	3	Lomoviejo	47
3510	1	78	9	Portugalete	48
3511	1	78	2	Friera de Valverde	49
3512	1	78	5	Castiliscar	50
3513	1	79	1	Villamalea	2
3514	1	79	7	Ibi	3
3515	1	79	2	Roquetas de Mar	4
3516	1	79	5	Gallegos de Altamiros	5
3517	1	79	8	Manchita	6
3518	1	79	0	Estany, 	8
3519	1	79	3	Castellanos de Castro	9
3520	1	79	7	Garganta la Olla	10
3521	1	79	9	Montanejos	12
3522	1	79	5	Solana, La	13
3523	1	79	3	Santiso	15
3524	1	79	6	Cueva del Hierro	16
3525	1	79	2	Girona	17
3526	1	79	8	Fuente Vaqueros	18
3527	1	79	1	Castilnuevo	19
3528	1	79	5	Zarautz	20
3529	1	79	2	Zufre	21
3530	1	79	7	Capdesaso	22
3531	1	79	3	Santisteban del Puerto	23
3532	1	79	8	Gradefes	24
3533	1	79	1	Cubells	25
3534	1	79	4	Huércanos	26
3535	1	79	6	Madrid	28
3536	1	79	9	Periana	29
3537	1	79	0	Desojo	31
3538	1	79	5	Taboadela	32
3539	1	79	6	Grijota	34
3540	1	79	8	Canillas de Abajo	37
3541	1	79	7	Santoña	39
3542	1	79	1	Fresno de Cantespino	40
3543	1	79	8	Puebla del Río, La	41
3544	1	79	3	Escobosa de Almazán	42
3545	1	79	9	Masllorenç	43
3546	1	79	7	Iglesuela, La	45
3547	1	79	0	Calles	46
3548	1	79	6	Llano de Olmedo	47
3549	1	79	2	Errigoiti	48
3550	1	79	5	Fuente Encalada	49
3551	1	79	8	Cervera de la Cañada	50
3552	1	80	5	Villapalacios	2
3553	1	80	1	Jacarilla	3
3554	1	80	6	Santa Cruz de Marchena	4
3555	1	80	9	Gallegos de Sobrinos	5
3556	1	80	2	Medellín	6
3557	1	80	4	Fígols	8
3558	1	80	1	Gargantilla	10
3559	1	80	3	Morella	12
3560	1	80	9	Solana del Pino	13
3561	1	80	7	Sobrado	15
3562	1	80	6	Gombrèn	17
3563	1	80	5	Cendejas de Enmedio	19
3564	1	80	9	Zumarraga	20
3565	1	80	1	Capella	22
3566	1	80	7	Santo Tomé	23
3567	1	80	2	Grajal de Campos	24
3568	1	80	8	Igea	26
3569	1	80	0	Majadahonda	28
3570	1	80	3	Pizarra	29
3571	1	80	4	Dicastillo	31
3572	1	80	9	Teixeira, A	32
3573	1	80	0	Guardo	34
3574	1	80	2	Cantagallo	37
3575	1	80	1	San Vicente de la Barquera	39
3576	1	80	5	Fresno de la Fuente	40
3577	1	80	2	Real de la Jara, El	41
3578	1	80	7	Espeja de San Marcelino	42
3579	1	80	3	Masó, La	43
3580	1	80	8	Codoñera, La	44
3581	1	80	1	Illán de Vacas	45
3582	1	80	4	Camporrobles	46
3583	1	80	0	Manzanillo	47
3584	1	80	6	Valle de Trápaga-Trapagaran	48
3585	1	80	9	Fuentelapeña	49
3586	1	80	2	Cerveruela	50
3587	1	81	2	Villarrobledo	2
3588	1	81	8	Xaló	3
3589	1	81	3	Santa Fe de Mondújar	4
3590	1	81	6	Garganta del Villar	5
3591	1	81	9	Medina de las Torres	6
3592	1	81	1	Fogars de Montclús	8
3593	1	81	8	Gargüera	10
3594	1	81	0	Navajas	12
3595	1	81	6	Terrinches	13
3596	1	81	4	Somozas, As	15
3597	1	81	7	Chumillas	16
3598	1	81	3	Gualta	17
3599	1	81	2	Cendejas de la Torre	19
3600	1	81	6	Zumaia	20
3601	1	81	8	Casbas de Huesca	22
3602	1	81	4	Segura de la Sierra	23
3603	1	81	9	Gusendos de los Oteros	24
3604	1	81	2	Espluga Calba, 	25
3605	1	81	5	Jalón de Cameros	26
3606	1	81	0	Pujerra	29
3607	1	81	1	Donamaria	31
3608	1	81	6	Toén	32
3609	1	81	7	Guaza de Campos	34
3610	1	81	9	Cantalapiedra	37
3611	1	81	8	Saro	39
3612	1	81	2	Frumales	40
3613	1	81	9	Rinconada, La	41
3614	1	81	4	Espejón	42
3615	1	81	0	Maspujols	43
3616	1	81	8	Illescas	45
3617	1	81	1	Canals	46
3618	1	81	7	Marzales	47
3619	1	81	3	Lezama	48
3620	1	81	6	Fuentesaúco	49
3621	1	81	9	Cetina	50
3622	1	82	7	Villatoya	2
3623	1	82	3	Jávea/Xàbia	3
3624	1	82	8	Senés	4
3625	1	82	1	Gavilanes	5
3626	1	82	4	Mengabril	6
3627	1	82	6	Fogars de la Selva	8
3628	1	82	9	Castildelgado	9
3629	1	82	3	Garrovillas de Alconétar	10
3630	1	82	5	Nules	12
3631	1	82	1	Tomelloso	13
3632	1	82	9	Teo	15
3633	1	82	2	Enguídanos	16
3634	1	82	8	Guils de Cerdanya	17
3635	1	82	4	Galera	18
3636	1	82	7	Centenera	19
3637	1	82	3	Castejón del Puente	22
3638	1	82	9	Siles	23
3639	1	82	4	Hospital de Órbigo	24
3640	1	82	7	Espot	25
3641	1	82	0	Laguna de Cameros	26
3642	1	82	2	Manzanares el Real	28
3643	1	82	5	Rincón de la Victoria	29
3644	1	82	6	Etxalar	31
3645	1	82	1	Trasmiras	32
3646	1	82	2	Hérmedes de Cerrato	34
3647	1	82	4	Cantalpino	37
3648	1	82	3	Selaya	39
3649	1	82	7	Fuente de Santa Cruz	40
3650	1	82	4	Roda de Andalucía, La	41
3651	1	82	9	Estepa de San Juan	42
3652	1	82	5	Masroig, El	43
3653	1	82	0	Corbalán	44
3654	1	82	3	Lagartera	45
3655	1	82	6	Canet En Berenguer	46
3656	1	82	2	Matapozuelos	47
3657	1	82	8	Santurtzi	48
3658	1	82	1	Fuentes de Ropel	49
3659	1	82	4	Cimballa	50
3660	1	83	3	Villavaliente	2
3661	1	83	9	Jijona/Xixona	3
3662	1	83	4	Serón	4
3663	1	83	7	Gemuño	5
3664	1	83	0	Mérida	6
3665	1	83	2	Folgueroles	8
3666	1	83	5	Castil de Peones	9
3667	1	83	9	Garvín	10
3668	1	83	1	Olocau del Rey	12
3669	1	83	7	Torralba de Calatrava	13
3670	1	83	5	Toques	15
3671	1	83	8	Fresneda de Altarejos	16
3672	1	83	4	Hostalric	17
3673	1	83	0	Gobernador	18
3674	1	83	9	Castejón de Monegros	22
3675	1	83	0	Igüeña	24
3676	1	83	6	Lagunilla del Jubera	26
3677	1	83	8	Meco	28
3678	1	83	1	Riogordo	29
3679	1	83	2	Echarri	31
3680	1	83	7	Veiga, A	32
3681	1	83	8	Herrera de Pisuerga	34
3682	1	83	0	Cantaracillo	37
3683	1	83	9	Soba	39
3684	1	83	3	Fuente el Olmo de Fuentidueña	40
3685	1	83	0	Ronquillo, El	41
3686	1	83	5	Frechilla de Almazán	42
3687	1	83	1	Milà, El	43
3688	1	83	9	Layos	45
3689	1	83	2	Carcaixent	46
3690	1	83	8	Matilla de los Caños	47
3691	1	83	4	Ortuella	48
3692	1	83	7	Fuentesecas	49
3693	1	83	0	Cinco Olivas	50
3694	1	84	8	Villaverde de Guadalimar	2
3695	1	84	4	Lorcha/Orxa, 	3
3696	1	84	9	Sierro	4
3697	1	84	2	Gilbuena	5
3698	1	84	5	Mirandilla	6
3699	1	84	7	Fonollosa	8
3700	1	84	0	Castrillo de la Reina	9
3701	1	84	4	Gata	10
3702	1	84	6	Onda	12
3703	1	84	2	Torre de Juan Abad	13
3704	1	84	0	Tordoia	15
3705	1	84	3	Fresneda de la Sierra	16
3706	1	84	9	Isòvol	17
3707	1	84	5	Gójar	18
3708	1	84	4	Castejón de Sos	22
3709	1	84	0	Sorihuela del Guadalimar	23
3710	1	84	5	Izagre	24
3711	1	84	1	Lardero	26
3712	1	84	3	Mejorada del Campo	28
3713	1	84	6	Ronda	29
3714	1	84	7	Etxarri-Aranatz	31
3715	1	84	2	Verea	32
3716	1	84	3	Herrera de Valdecañas	34
3717	1	84	4	Solórzano	39
3718	1	84	8	Fuente el Olmo de Íscar	40
3719	1	84	5	Rubio, El	41
3720	1	84	0	Fresno de Caracena	42
3721	1	84	6	Miravet	43
3722	1	84	1	Cortes de Aragón	44
3723	1	84	4	Lillo	45
3724	1	84	7	Càrcer	46
3725	1	84	3	Mayorga	47
3726	1	84	9	Sestao	48
3727	1	84	2	Fuentespreadas	49
3728	1	84	5	Clarés de Ribota	50
3729	1	85	1	Viveros	2
3730	1	85	7	Llíber	3
3731	1	85	2	Somontín	4
3732	1	85	5	Gil García	5
3733	1	85	8	Monesterio	6
3734	1	85	0	Font-rubí	8
3735	1	85	3	Castrillo de la Vega	9
3736	1	85	7	Gordo, El	10
3737	1	85	9	Oropesa del Mar/Orpesa	12
3738	1	85	5	Torrenueva	13
3739	1	85	3	Touro	15
3740	1	85	6	Frontera, La	16
3741	1	85	2	Jafre	17
3742	1	85	8	Gor	18
3743	1	85	7	Castelflorite	22
3744	1	85	3	Torreblascopedro	23
3745	1	85	1	Estaràs	25
3746	1	85	6	Miraflores de la Sierra	28
3747	1	85	9	Salares	29
3748	1	85	0	Etxauri	31
3749	1	85	5	Verín	32
3750	1	85	8	Carbajosa de la Sagrada	37
3751	1	85	7	Suances	39
3752	1	85	8	Salteras	41
3753	1	85	3	Fuentearmegil	42
3754	1	85	9	Molar, El	43
3755	1	85	4	Cosa	44
3756	1	85	7	Lominchar	45
3757	1	85	0	Carlet	46
3758	1	85	6	Medina del Campo	47
3759	1	85	2	Sopelana	48
3760	1	85	5	Galende	49
3761	1	85	8	Codo	50
3762	1	86	4	Yeste	2
3763	1	86	0	Millena	3
3764	1	86	5	Sorbas	4
3765	1	86	8	Gimialcón	5
3766	1	86	1	Montemolín	6
3767	1	86	3	Franqueses del Vallès, Les	8
3768	1	86	6	Castrillo del Val	9
3769	1	86	0	Granja, La	10
3770	1	86	8	Valdemanco del Esteras	13
3771	1	86	6	Trazo	15
3772	1	86	9	Fuente de Pedro Naharro	16
3773	1	86	5	Jonquera, La	17
3774	1	86	1	Gorafe	18
3775	1	86	4	Cifuentes	19
3776	1	86	0	Castiello de Jaca	22
3777	1	86	6	Torre del Campo	23
3778	1	86	1	Joarilla de las Matas	24
3779	1	86	4	Esterri Àneu	25
3780	1	86	7	Ledesma de la Cogolla	26
3781	1	86	9	Molar, El	28
3782	1	86	2	Sayalonga	29
3783	1	86	3	Egüés	31
3784	1	86	8	Viana do Bolo	32
3785	1	86	9	Hontoria de Cerrato	34
3786	1	86	1	Carpio de Azaba	37
3787	1	86	0	Tojos, Los	39
3788	1	86	4	Fuentepelayo	40
3789	1	86	1	San Juan de Aznalfarache	41
3790	1	86	6	Fuentecambrón	42
3791	1	86	2	Montblanc	43
3792	1	86	7	Cretas	44
3793	1	86	0	Lucillos	45
3794	1	86	3	Carrícola	46
3795	1	86	9	Medina de Rioseco	47
3796	1	86	5	Sopuerta	48
3797	1	86	8	Gallegos del Pan	49
3798	1	86	1	Codos	50
3799	1	87	1	Suflí	4
3800	1	87	4	Gotarrendura	5
3801	1	87	7	Monterrubio de la Serena	6
3802	1	87	9	Gallifa	8
3803	1	87	6	Guadalupe	10
3804	1	87	8	Palanques	12
3805	1	87	4	Valdepeñas	13
3806	1	87	2	Valdoviño	15
3807	1	87	5	Fuentelespino de Haro	16
3808	1	87	1	Juià	17
3809	1	87	7	Granada	18
3810	1	87	0	Cincovillas	19
3811	1	87	6	Castigaleu	22
3812	1	87	2	Torredonjimeno	23
3813	1	87	7	Laguna Dalga	24
3814	1	87	0	Esterri de Cardós	25
3815	1	87	3	Leiva	26
3816	1	87	5	Molinos, Los	28
3817	1	87	8	Sedella	29
3818	1	87	9	Elgorriaga	31
3819	1	87	4	Vilamarín	32
3820	1	87	5	Hornillos de Cerrato	34
3821	1	87	7	Carrascal de Barregas	37
3822	1	87	6	Torrelavega	39
3823	1	87	0	Fuentepiñel	40
3824	1	87	7	Sanlúcar la Mayor	41
3825	1	87	2	Fuentecantos	42
3826	1	87	3	Crivillén	44
3827	1	87	6	Madridejos	45
3828	1	87	9	Casas Altas	46
3829	1	87	5	Megeces	47
3830	1	87	1	Trucios-Turtzioz	48
3831	1	87	4	Gallegos del Río	49
3832	1	87	7	Contamina	50
3833	1	88	2	Monforte del Cid	3
3834	1	88	7	Tabernas	4
3835	1	88	0	Grandes y San Martín	5
3836	1	88	3	Montijo	6
3837	1	88	5	Garriga, La	8
3838	1	88	8	Castrillo de Riopisuerga	9
3839	1	88	2	Guijo de Coria	10
3840	1	88	4	Pavías	12
3841	1	88	0	Valenzuela de Calatrava	13
3842	1	88	8	Val do Dubra	15
3843	1	88	1	Fuentelespino de Moya	16
3844	1	88	7	Lladó	17
3845	1	88	3	Guadahortuna	18
3846	1	88	6	Ciruelas	19
3847	1	88	2	Castillazuelo	22
3848	1	88	8	Torreperogil	23
3849	1	88	3	Laguna de Negrillos	24
3850	1	88	6	Estamariu	25
3851	1	88	9	Leza de Río Leza	26
3852	1	88	1	Montejo de la Sierra	28
3853	1	88	4	Sierra de Yeguas	29
3854	1	88	5	Noáin (Valle de Elorz)/Noain (Elortzibar)	31
3855	1	88	0	Vilamartín de Valdeorras	32
3856	1	88	1	Husillos	34
3857	1	88	3	Carrascal del Obispo	37
3858	1	88	2	Tresviso	39
3859	1	88	6	Fuenterrebollo	40
3860	1	88	3	San Nicolás del Puerto	41
3861	1	88	8	Fuentelmonge	42
3862	1	88	4	Montbrió del Camp	43
3863	1	88	9	Cuba, La	44
3864	1	88	2	Magán	45
3865	1	88	5	Casas Bajas	46
3866	1	88	1	Melgar de Abajo	47
3867	1	88	7	Ubide	48
3868	1	88	0	Gamones	49
3869	1	88	3	Cosuenda	50
3870	1	89	5	Monóvar/Monòver	3
3871	1	89	0	Taberno	4
3872	1	89	3	Guisando	5
3873	1	89	6	Morera, La	6
3874	1	89	8	Gavà	8
3875	1	89	5	Guijo de Galisteo	10
3876	1	89	7	Peníscola/Peñíscola	12
3877	1	89	3	Villahermosa	13
3878	1	89	1	Vedra	15
3879	1	89	4	Fuentes	16
3880	1	89	0	Llagostera	17
3881	1	89	6	Guadix	18
3882	1	89	9	Ciruelos del Pinar	19
3883	1	89	5	Castillonroy	22
3884	1	89	6	León	24
3885	1	89	9	Farrera	25
3886	1	89	2	Logroño	26
3887	1	89	4	Moraleja de Enmedio	28
3888	1	89	7	Teba	29
3889	1	89	8	Enériz/Eneritz	31
3890	1	89	3	Vilar de Barrio	32
3891	1	89	4	Itero de la Vega	34
3892	1	89	6	Casafranca	37
3893	1	89	5	Tudanca	39
3894	1	89	9	Fuentesaúco de Fuentidueña	40
3895	1	89	6	Santiponce	41
3896	1	89	1	Fuentelsaz de Soria	42
3897	1	89	7	Montferri	43
3898	1	89	2	Cubla	44
3899	1	89	5	Malpica de Tajo	45
3900	1	89	8	Casinos	46
3901	1	89	4	Melgar de Arriba	47
3902	1	89	0	Urduliz	48
3903	1	89	6	Cuarte de Huerva	50
3904	1	90	9	Mutxamel	3
3905	1	90	4	Tahal	4
3906	1	90	7	Gutierre-Muñoz	5
3907	1	90	0	Nava de Santiago, La	6
3908	1	90	2	Gaià	8
3909	1	90	5	Castrillo Matajudíos	9
3910	1	90	9	Guijo de Granadilla	10
3911	1	90	1	Pina de Montalgrao	12
3912	1	90	7	Villamanrique	13
3913	1	90	5	Vilasantar	15
3914	1	90	4	Llambilles	17
3915	1	90	3	Cobeta	19
3916	1	90	9	Colungo	22
3917	1	90	5	Torres	23
3918	1	90	0	Lucillo	24
3919	1	90	8	Moralzarzal	28
3920	1	90	1	Tolox	29
3921	1	90	2	Eratsun	31
3922	1	90	7	Vilar de Santos	32
3923	1	90	0	Casas del Conde, Las	37
3924	1	90	9	Udías	39
3925	1	90	0	Saucejo, El	41
3926	1	90	5	Fuentepinilla	42
3927	1	90	1	Montmell, El	43
3928	1	90	6	Cucalón	44
3929	1	90	9	Manzaneque	45
3930	1	90	2	Castelló de Rugat	46
3931	1	90	8	Mojados	47
3932	1	90	4	Balmaseda	48
3933	1	90	7	Gema	49
3934	1	90	0	Cubel	50
3935	1	91	6	Murla	3
3936	1	91	1	Terque	4
3937	1	91	7	Navalvillar de Pela	6
3938	1	91	9	Gelida	8
3939	1	91	2	Castrojeriz	9
3940	1	91	6	Guijo de Santa Bárbara	10
3941	1	91	8	Portell de Morella	12
3942	1	91	4	Villamayor de Calatrava	13
3943	1	91	2	Vilarmaior	15
3944	1	91	5	Fuertescusa	16
3945	1	91	1	Llanars	17
3946	1	91	0	Cogollor	19
3947	1	91	2	Torres de Albánchez	23
3948	1	91	7	Luyego	24
3949	1	91	3	Lumbreras	26
3950	1	91	5	Morata de Tajuña	28
3951	1	91	8	Torrox	29
3952	1	91	9	Ergoiena	31
3953	1	91	4	Vilardevós	32
3954	1	91	5	Lagartos	34
3955	1	91	7	Casillas de Flores	37
3956	1	91	6	Valdáliga	39
3957	1	91	0	Fuentesoto	40
3958	1	91	7	Sevilla	41
3959	1	91	8	Mont-ral	43
3960	1	91	6	Maqueda	45
3961	1	91	9	Castellonet de la Conquesta	46
3962	1	91	5	Monasterio de Vega	47
3963	1	91	1	Atxondo	48
3964	1	91	4	Granja de Moreruela	49
3965	1	91	7	Cuerlas, Las	50
3966	1	92	1	Muro de Alcoy	3
3967	1	92	6	Tíjola	4
3968	1	92	9	Hernansancho	5
3969	1	92	2	Nogales	6
3970	1	92	4	Gironella	8
3971	1	92	1	Herguijuela	10
3972	1	92	3	Puebla de Arenoso	12
3973	1	92	9	Villanueva de la Fuente	13
3974	1	92	7	Vimianzo	15
3975	1	92	0	Gabaldón	16
3976	1	92	6	Llançà	17
3977	1	92	5	Cogolludo	19
3978	1	92	7	Úbeda	23
3979	1	92	2	Llamas de la Ribera	24
3980	1	92	5	Floresta, La	25
3981	1	92	8	Manjarrés	26
3982	1	92	0	Móstoles	28
3983	1	92	3	Totalán	29
3984	1	92	4	Erro	31
3985	1	92	9	Vilariño de Conso	32
3986	1	92	0	Lantadilla	34
3987	1	92	2	Castellanos de Moriscos	37
3988	1	92	1	Valdeolea	39
3989	1	92	5	Fuentidueña	40
3990	1	92	2	Tocina	41
3991	1	92	7	Fuentes de Magaña	42
3992	1	92	3	Mont-roig del Camp	43
3993	1	92	8	Cuervo, El	44
3994	1	92	1	Marjaliza	45
3995	1	92	4	Castielfabib	46
3996	1	92	0	Montealegre de Campos	47
3997	1	92	6	Bedia	48
3998	1	92	9	Granucillo	49
3999	1	92	2	Chiprana	50
4000	1	93	7	Novelda	3
4001	1	93	2	Turre	4
4002	1	93	5	Herradón de Pinares	5
4003	1	93	8	Oliva de la Frontera	6
4004	1	93	0	Gisclareny	8
4005	1	93	3	Cayuela	9
4006	1	93	7	Hernán-Pérez	10
4007	1	93	9	Pobla de Benifassà, la	12
4008	1	93	5	Villanueva de los Infantes	13
4009	1	93	3	Zas	15
4010	1	93	6	Garaballa	16
4011	1	93	2	Llers	17
4012	1	93	8	Gualchos	18
4013	1	93	3	Valdepeñas de Jaén	23
4014	1	93	8	Magaz de Cepeda	24
4015	1	93	1	Fondarella	25
4016	1	93	4	Mansilla de la Sierra	26
4017	1	93	6	Navacerrada	28
4018	1	93	9	Valle de Abdalajís	29
4019	1	93	0	Ezcároz/Ezkaroze	31
4020	1	93	6	Vid de Ojeda, La	34
4021	1	93	7	Valdeprado del Río	39
4022	1	93	1	Gallegos	40
4023	1	93	8	Tomares	41
4024	1	93	3	Fuentestrún	42
4025	1	93	9	Móra Ebre	43
4026	1	93	4	Cuevas de Almudén	44
4027	1	93	7	Marrupe	45
4028	1	93	0	Catadau	46
4029	1	93	6	Montemayor de Pililla	47
4030	1	93	2	Areatza	48
4031	1	93	5	Guarrate	49
4032	1	93	8	Chodes	50
4033	1	94	2	Nucia, la	3
4034	1	94	7	Turrillas	4
4035	1	94	0	Herreros de Suso	5
4036	1	94	3	Oliva de Mérida	6
4037	1	94	5	Granada, La	8
4038	1	94	8	Cebrecos	9
4039	1	94	2	Herrera de Alcántara	10
4040	1	94	4	Pobla Tornesa, la	12
4041	1	94	0	Villanueva de San Carlos	13
4042	1	94	1	Gascueña	16
4043	1	94	7	Llívia	17
4044	1	94	3	Güejar Sierra	18
4045	1	94	2	Chalamera	22
4046	1	94	8	Vilches	23
4047	1	94	3	Mansilla de las Mulas	24
4048	1	94	6	Foradada	25
4049	1	94	9	Manzanares de Rioja	26
4050	1	94	1	Navalafuente	28
4051	1	94	4	Vélez-Málaga	29
4052	1	94	5	Eslava	31
4053	1	94	1	Ledigos	34
4054	1	94	2	Valderredible	39
4055	1	94	6	Garcillán	40
4056	1	94	3	Umbrete	41
4057	1	94	8	Garray	42
4058	1	94	4	Móra la Nova	43
4059	1	94	9	Cuevas Labradas	44
4060	1	94	2	Mascaraque	45
4061	1	94	5	Catarroja	46
4062	1	94	1	Moral de la Reina	47
4063	1	94	7	Igorre	48
4064	1	94	0	Hermisende	49
4065	1	94	3	Daroca	50
4066	1	95	5	Ondara	3
4067	1	95	0	Uleila del Campo	4
4068	1	95	3	Higuera de las Dueñas	5
4069	1	95	6	Olivenza	6
4070	1	95	8	Granera	8
4071	1	95	1	Celada del Camino	9
4072	1	95	5	Herreruela	10
4073	1	95	7	Ribesalbes	12
4074	1	95	3	Villar del Pozo	13
4075	1	95	4	Graja de Campalbo	16
4076	1	95	0	Lloret de Mar	17
4077	1	95	6	Güevéjar	18
4078	1	95	9	Condemios de Abajo	19
4079	1	95	5	Chía	22
4080	1	95	1	Villacarrillo	23
4081	1	95	6	Mansilla Mayor	24
4082	1	95	2	Matute	26
4083	1	95	4	Navalagamella	28
4084	1	95	7	Villanueva de Algaidas	29
4085	1	95	8	Esparza de Salazar/Espartza Zaraitzu	31
4086	1	95	5	Val de San Vicente	39
4087	1	95	9	Gomezserracín	40
4088	1	95	6	Utrera	41
4089	1	95	1	Golmayo	42
4090	1	95	7	Morell, El	43
4091	1	95	5	Mata, La	45
4092	1	95	8	Caudete de las Fuentes	46
4093	1	95	4	Moraleja de las Panaderas	47
4094	1	95	0	Zaldibar	48
4095	1	95	3	Hiniesta, La	49
4096	1	95	6	Ejea de los Caballeros	50
4097	1	96	8	Onil	3
4098	1	96	3	Urrácal	4
4099	1	96	6	Hija de Dios, La	5
4100	1	96	9	Orellana de la Sierra	6
4101	1	96	1	Granollers	8
4102	1	96	8	Hervás	10
4103	1	96	0	Rossell	12
4104	1	96	6	Villarrubia de los Ojos	13
4105	1	96	7	Graja de Iniesta	16
4106	1	96	3	Llosses, Les	17
4107	1	96	9	Huélago	18
4108	1	96	2	Condemios de Arriba	19
4109	1	96	8	Chimillas	22
4110	1	96	4	Villanueva de la Reina	23
4111	1	96	9	Maraña	24
4112	1	96	2	Fuliola, La	25
4113	1	96	5	Medrano	26
4114	1	96	7	Navalcarnero	28
4115	1	96	0	Villanueva del Rosario	29
4116	1	96	1	Espronceda	31
4117	1	96	7	Lomas	34
4118	1	96	9	Castillejo de Martín Viejo	37
4119	1	96	8	Vega de Liébana	39
4120	1	96	9	Valencina de la Concepción	41
4121	1	96	4	Gómara	42
4122	1	96	0	Morera de Montsant, La	43
4123	1	96	5	Ejulve	44
4124	1	96	8	Mazarambroz	45
4125	1	96	1	Cerdà	46
4126	1	96	7	Morales de Campos	47
4127	1	96	3	Zalla	48
4128	1	96	6	Jambrina	49
4129	1	96	9	Embid de Ariza	50
4130	1	97	4	Orba	3
4131	1	97	9	Velefique	4
4132	1	97	2	Horcajada, La	5
4133	1	97	5	Orellana la Vieja	6
4134	1	97	7	Gualba	8
4135	1	97	4	Higuera	10
4136	1	97	6	Sacañet	12
4137	1	97	2	Villarta de San Juan	13
4138	1	97	3	Henarejos	16
4139	1	97	9	Madremanya	17
4140	1	97	5	Huéneja	18
4141	1	97	8	Congostrina	19
4142	1	97	0	Villanueva del Arzobispo	23
4143	1	97	5	Matadeón de los Oteros	24
4144	1	97	8	Fulleda	25
4145	1	97	3	Navarredonda y San Mamés	28
4146	1	97	6	Villanueva del Trabuco	29
4147	1	97	7	Estella-Lizarra	31
4148	1	97	5	Castraz	37
4149	1	97	4	Vega de Pas	39
4150	1	97	8	Grajera	40
4151	1	97	5	Villamanrique de la Condesa	41
4152	1	97	0	Gormaz	42
4153	1	97	6	Nou de Gaià, La	43
4154	1	97	1	Escorihuela	44
4155	1	97	4	Mejorada	45
4156	1	97	7	Cofrentes	46
4157	1	97	3	Mota del Marqués	47
4158	1	97	9	Zaratamo	48
4159	1	97	2	Justel	49
4160	1	98	0	Orxeta	3
4161	1	98	5	Vélez-Blanco	4
4162	1	98	1	Palomas	6
4163	1	98	3	Sant Salvador de Guardiola	8
4164	1	98	6	Cerezo de Río Tirón	9
4165	1	98	0	Hinojal	10
4166	1	98	2	Salzadella, la	12
4167	1	98	8	Viso del Marqués	13
4168	1	98	9	Herrumblar, El	16
4169	1	98	5	Maià de Montcal	17
4170	1	98	1	Huéscar	18
4171	1	98	4	Copernal	19
4172	1	98	6	Villardompardo	23
4173	1	98	1	Matallana de Torío	24
4174	1	98	4	Gavet de la Conca	25
4175	1	98	7	Munilla	26
4176	1	98	2	Villanueva de Tapia	29
4177	1	98	3	Esteribar	31
4178	1	98	9	Magaz de Pisuerga	34
4179	1	98	1	Cepeda	37
4180	1	98	0	Villacarriedo	39
4181	1	98	1	Villanueva del Ariscal	41
4182	1	98	6	Herrera de Soria	42
4183	1	98	2	Nulles	43
4184	1	98	0	Menasalbas	45
4185	1	98	3	Corbera	46
4186	1	98	9	Mucientes	47
4187	1	98	8	Losacino	49
4188	1	98	1	Encinacorba	50
4189	1	99	3	Orihuela	3
4190	1	99	8	Vélez-Rubio	4
4191	1	99	1	Horcajo de las Torres	5
4192	1	99	4	Parra, La	6
4193	1	99	6	Guardiola de Berguedà	8
4194	1	99	3	Holguera	10
4195	1	99	5	Sant Jordi/San Jorge	12
4196	1	99	2	Hinojosa, La	16
4197	1	99	8	Meranges	17
4198	1	99	4	Huétor de Santillán	18
4199	1	99	7	Corduente	19
4200	1	99	3	Esplús	22
4201	1	99	9	Villares, Los	23
4202	1	99	4	Matanza	24
4203	1	99	7	Golmés	25
4204	1	99	0	Murillo de Río Leza	26
4205	1	99	2	Navas del Rey	28
4206	1	99	5	Viñuela	29
4207	1	99	6	Etayo	31
4208	1	99	2	Manquillos	34
4209	1	99	4	Cereceda de la Sierra	37
4210	1	99	3	Villaescusa	39
4211	1	99	7	Honrubia de la Cuesta	40
4212	1	99	4	Villanueva del Río y Minas	41
4213	1	99	5	Palma Ebre, La	43
4214	1	99	0	Escucha	44
4215	1	99	3	Méntrida	45
4216	1	99	6	Cortes de Pallás	46
4217	1	99	2	Mudarra, La	47
4218	1	99	1	Losacio	49
4219	1	99	4	Épila	50
4220	1	100	7	Parcent	3
4221	1	100	2	Vera	4
4222	1	100	5	Hornillo, El	5
4223	1	100	8	Peñalsordo	6
4224	1	100	0	Gurb	8
4225	1	100	3	Cerratón de Juarros	9
4226	1	100	7	Hoyos	10
4227	1	100	9	Sant Mateu	12
4228	1	100	6	Hinojosos, Los	16
4229	1	100	2	Masarac	17
4230	1	100	8	Huétor Tájar	18
4231	1	100	8	Molinaseca	24
4232	1	100	1	Gósol	25
4233	1	100	4	Muro de Aguas	26
4234	1	100	6	Nuevo Baztán	28
4235	1	100	9	Yunquera	29
4236	1	100	0	Eulate	31
4237	1	100	6	Mantinos	34
4238	1	100	8	Cerezal de Peñahorcada	37
4239	1	100	7	Villafufre	39
4240	1	100	1	Hontalbilla	40
4241	1	100	8	Villanueva de San Juan	41
4242	1	100	3	Hinojosa del Campo	42
4243	1	100	9	Pallaresos, Els	43
4244	1	100	4	Estercuel	44
4245	1	100	7	Mesegar de Tajo	45
4246	1	100	0	Cotes	46
4247	1	100	6	Muriel	47
4248	1	100	5	Lubián	49
4249	1	100	8	Erla	50
4250	1	101	4	Pedreguer	3
4251	1	101	9	Viator	4
4252	1	101	2	Hoyocasero	5
4253	1	101	5	Peraleda del Zaucejo	6
4254	1	101	7	Hospitalet de Llobregat, 	8
4255	1	101	0	Ciadoncha	9
4256	1	101	4	Huélaga	10
4257	1	101	6	San Rafael del Río	12
4258	1	101	3	Hito, El	16
4259	1	101	9	Massanes	17
4260	1	101	5	Huétor Vega	18
4261	1	101	0	Villarrodrigo	23
4262	1	101	5	Murias de Paredes	24
4263	1	101	8	Granadella, La	25
4264	1	101	1	Muro en Cameros	26
4265	1	101	3	Olmeda de las Fuentes	28
4266	1	101	7	Ezcabarte	31
4267	1	101	3	Marcilla de Campos	34
4268	1	101	5	Cerralbo	37
4269	1	101	4	Valle de Villaverde	39
4270	1	101	8	Hontanares de Eresma	40
4271	1	101	5	Villaverde del Río	41
4272	1	101	6	Passanant i Belltall	43
4273	1	101	1	Ferreruela de Huerva	44
4274	1	101	4	Miguel Esteban	45
4275	1	101	7	Quart de les Valls	46
4276	1	101	3	Nava del Rey	47
4277	1	101	2	Luelmo	49
4278	1	101	5	Escatrón	50
4279	1	102	9	Pego	3
4280	1	102	4	Vícar	4
4281	1	102	7	Hoyo de Pinares, El	5
4282	1	102	0	Puebla de Alcocer	6
4283	1	102	2	Igualada	8
4284	1	102	5	Cillaperlata	9
4285	1	102	9	Ibahernando	10
4286	1	102	1	Santa Magdalena de Pulpis	12
4287	1	102	8	Honrubia	16
4288	1	102	4	Maçanet de Cabrenys	17
4289	1	102	0	Illora	18
4290	1	102	3	Cubillo de Uceda, El	19
4291	1	102	9	Estada	22
4292	1	102	0	Noceda del Bierzo	24
4293	1	102	3	Granja Escarp, La	25
4294	1	102	6	Nájera	26
4295	1	102	8	Orusco de Tajuña	28
4296	1	102	2	Ezkurra	31
4297	1	102	8	Mazariegos	34
4298	1	102	0	Cerro, El	37
4299	1	102	9	Voto	39
4300	1	102	0	Viso del Alcor, El	41
4301	1	102	1	Paüls	43
4302	1	102	6	Fonfría	44
4303	1	102	9	Mocejón	45
4304	1	102	2	Quart de Poblet	46
4305	1	102	8	Nueva Villa de las Torres	47
4306	1	102	7	Maderal, El	49
4307	1	102	0	Fabara	50
4308	1	103	5	Penàguila	3
4309	1	103	0	Zurgena	4
4310	1	103	3	Hoyorredondo	5
4311	1	103	6	Puebla de la Calzada	6
4312	1	103	8	Jorba	8
4313	1	103	1	Cilleruelo de Abajo	9
4314	1	103	5	Jaraicejo	10
4315	1	103	7	Sarratella	12
4316	1	103	4	Hontanaya	16
4317	1	103	0	Maçanet de la Selva	17
4318	1	103	6	Itrabo	18
4319	1	103	9	Checa	19
4320	1	103	5	Estadilla	22
4321	1	103	6	Oencia	24
4322	1	103	9	Granyanella	25
4323	1	103	2	Nalda	26
4324	1	103	8	Ezprogui	31
4325	1	103	4	Mazuecos de Valdeginate	34
4326	1	103	6	Cespedosa de Tormes	37
4327	1	103	9	Huertos, Los	40
4328	1	103	1	Langa de Duero	42
4329	1	103	7	Perafort	43
4330	1	103	2	Formiche Alto	44
4331	1	103	5	Mohedas de la Jara	45
4332	1	103	8	Quartell	46
4333	1	103	4	Olivares de Duero	47
4334	1	103	3	Madridanos	49
4335	1	104	0	Petrer	3
4336	1	104	8	Hoyos del Collado	5
4337	1	104	1	Puebla de la Reina	6
4338	1	104	3	Llacuna, La	8
4339	1	104	6	Cilleruelo de Arriba	9
4340	1	104	0	Jaraíz de la Vera	10
4341	1	104	2	Segorbe	12
4342	1	104	9	Hontecillas	16
4343	1	104	4	Chequilla	19
4344	1	104	1	Omañas, Las	24
4345	1	104	4	Granyena de Segarra	25
4346	1	104	7	Navajún	26
4347	1	104	9	Paracuellos de Jarama	28
4348	1	104	3	Falces	31
4349	1	104	9	Melgar de Yuso	34
4350	1	104	1	Cilleros de la Bastida	37
4351	1	104	4	Ituero y Lama	40
4352	1	104	2	Perelló, El	43
4353	1	104	0	Montearagón	45
4354	1	104	3	Quatretonda	46
4355	1	104	9	Olmedo	47
4356	1	104	8	Mahide	49
4357	1	104	1	Farlete	50
4358	1	105	3	Pinós, el/Pinoso	3
4359	1	105	1	Hoyos del Espino	5
4360	1	105	4	Puebla del Maestre	6
4361	1	105	6	Llagosta, La	8
4362	1	105	9	Ciruelos de Cervera	9
4363	1	105	3	Jarandilla de la Vera	10
4364	1	105	5	Sierra Engarcerán	12
4365	1	105	8	Mieres	17
4366	1	105	4	Iznalloz	18
4367	1	105	7	Chiloeches	19
4368	1	105	3	Estopiñán del Castillo	22
4369	1	105	4	Onzonilla	24
4370	1	105	7	Granyena de les Garrigues	25
4371	1	105	0	Navarrete	26
4372	1	105	6	Fitero	31
4373	1	105	7	Juarros de Riomoros	40
4374	1	105	9	Liceras	42
4375	1	105	5	Piles, Les	43
4376	1	105	0	Fórnoles	44
4377	1	105	3	Montesclaros	45
4378	1	105	6	Cullera	46
4379	1	105	2	Olmos de Esgueva	47
4380	1	105	1	Maire de Castroponce	49
4381	1	105	4	Fayón	50
4382	1	106	6	Planes	3
4383	1	106	4	Hoyos de Miguel Muñoz	5
4384	1	106	7	Puebla del Prior	6
4385	1	106	9	Llinars del Vallès	8
4386	1	106	6	Jarilla	10
4387	1	106	8	Soneja	12
4388	1	106	5	Horcajo de Santiago	16
4389	1	106	1	Mollet de Peralada	17
4390	1	106	0	Chillarón del Rey	19
4391	1	106	6	Fago	22
4392	1	106	7	Oseja de Sajambre	24
4393	1	106	3	Nestares	26
4394	1	106	5	Parla	28
4395	1	106	9	Fontellas	31
4396	1	106	5	Meneses de Campos	34
4397	1	106	7	Cipérez	37
4398	1	106	0	Juarros de Voltoya	40
4399	1	106	2	Losilla, La	42
4400	1	106	8	Pinell de Brai, El	43
4401	1	106	3	Fortanete	44
4402	1	106	6	Mora	45
4403	1	106	9	Chelva	46
4404	1	106	5	Olmos de Peñafiel	47
4405	1	106	7	Fayos, Los	50
4406	1	107	2	Polop	3
4407	1	107	0	Hurtumpascual	5
4408	1	107	3	Puebla de Obando	6
4409	1	107	5	Lliçà Amunt	8
4410	1	107	2	Jerte	10
4411	1	107	4	Sot de Ferrer	12
4412	1	107	1	Huélamo	16
4413	1	107	7	Molló	17
4414	1	107	3	Jayena	18
4415	1	107	6	Driebes	19
4416	1	107	2	Fanlo	22
4417	1	107	3	Pajares de los Oteros	24
4418	1	107	9	Nieva de Cameros	26
4419	1	107	1	Patones	28
4420	1	107	5	Funes	31
4421	1	107	1	Micieces de Ojeda	34
4422	1	107	3	Ciudad Rodrigo	37
4423	1	107	6	Labajos	40
4424	1	107	8	Magaña	42
4425	1	107	4	Pira	43
4426	1	107	9	Foz-Calanda	44
4427	1	107	2	Nambroca	45
4428	1	107	5	Chella	46
4429	1	107	0	Malva	49
4430	1	107	3	Figueruelas	50
4431	1	108	6	Junciana	5
4432	1	108	9	Puebla de Sancho Pérez	6
4433	1	108	1	Lliçà de Vall	8
4434	1	108	4	Cogollos	9
4435	1	108	8	Ladrillar	10
4436	1	108	0	Sueras/Suera	12
4437	1	108	7	Huelves	16
4438	1	108	9	Jerez del Marquesado	18
4439	1	108	2	Durón	19
4440	1	108	9	Palacios de la Valduerna	24
4441	1	108	5	Ocón	26
4442	1	108	7	Pedrezuela	28
4443	1	108	1	Fustiñana	31
4444	1	108	7	Monzón de Campos	34
4445	1	108	9	Coca de Alba	37
4446	1	108	2	Laguna de Contreras	40
4447	1	108	4	Maján	42
4448	1	108	0	Pla de Santa Maria, El	43
4449	1	108	5	Fresneda, La	44
4450	1	108	8	Nava de Ricomalillo, La	45
4451	1	108	1	Chera	46
4452	1	108	6	Manganeses de la Lampreana	49
4453	1	108	9	Fombuena	50
4454	1	109	1	Rafal	3
4455	1	109	9	Langa	5
4456	1	109	2	Quintana de la Serena	6
4457	1	109	4	Lluçà	8
4458	1	109	7	Condado de Treviño	9
4459	1	109	1	Logrosán	10
4460	1	109	3	Tales	12
4461	1	109	0	Huérguina	16
4462	1	109	6	Montagut i Oix	17
4463	1	109	2	Jete	18
4464	1	109	5	Embid	19
4465	1	109	1	Fiscal	22
4466	1	109	2	Palacios del Sil	24
4467	1	109	5	Guimerà	25
4468	1	109	8	Ochánduri	26
4469	1	109	0	Pelayos de la Presa	28
4470	1	109	4	Galar	31
4471	1	109	0	Moratinos	34
4472	1	109	2	Colmenar de Montemayor	37
4473	1	109	5	Languilla	40
4474	1	109	3	Pobla de Mafumet, La	43
4475	1	109	8	Frías de Albarracín	44
4476	1	109	1	Navahermosa	45
4477	1	109	4	Cheste	46
4478	1	109	0	Palazuelo de Vedija	47
4479	1	109	9	Manganeses de la Polvorosa	49
4480	1	109	2	Frago, El	50
4481	1	110	5	Ràfol Almúnia, El	3
4482	1	110	3	Lanzahíta	5
4483	1	110	6	Reina	6
4484	1	110	8	Malgrat de Mar	8
4485	1	110	1	Contreras	9
4486	1	110	5	Losar de la Vera	10
4487	1	110	7	Teresa	12
4488	1	110	4	Huerta de la Obispalía	16
4489	1	110	0	Mont-ras	17
4490	1	110	9	Escamilla	19
4491	1	110	5	Fonz	22
4492	1	110	6	Páramo del Sil	24
4493	1	110	9	Guissona	25
4494	1	110	2	Ojacastro	26
4495	1	110	4	Perales de Tajuña	28
4496	1	110	8	Gallipienzo/Galipentzu	31
4497	1	110	4	Mudá	34
4498	1	110	6	Cordovilla	37
4499	1	110	9	Lastras de Cuéllar	40
4500	1	110	1	Matalebreras	42
4501	1	110	7	Pobla de Massaluca, La	43
4502	1	110	2	Fuenferrada	44
4503	1	110	5	Navalcán	45
4504	1	110	8	Xirivella	46
4505	1	110	4	Parrilla, La	47
4506	1	110	3	Manzanal de Arriba	49
4507	1	110	6	Frasno, El	50
4508	1	111	2	Redován	3
4509	1	111	3	Rena	6
4510	1	111	5	Malla	8
4511	1	111	2	Madrigal de la Vera	10
4512	1	111	4	Tírig	12
4513	1	111	1	Huerta del Marquesado	16
4514	1	111	7	Navata	17
4515	1	111	3	Jun	18
4516	1	111	6	Escariche	19
4517	1	111	2	Foradada del Toscar	22
4518	1	111	6	Guixers	25
4519	1	111	9	Ollauri	26
4520	1	111	1	Pezuela de las Torres	28
4521	1	111	5	Gallués/Galoze	31
4522	1	111	6	Lastras del Pozo	40
4523	1	111	8	Matamala de Almazán	42
4524	1	111	4	Pobla de Montornès, La	43
4525	1	111	9	Fuentes Calientes	44
4526	1	111	2	Navalmoralejo	45
4527	1	111	5	Chiva	46
4528	1	111	1	Pedraja de Portillo, La	47
4529	1	111	0	Manzanal del Barco	49
4530	1	111	3	Fréscano	50
4531	1	112	7	Relleu	3
4532	1	112	5	Losar del Barco, El	5
4533	1	112	8	Retamal de Llerena	6
4534	1	112	0	Manlleu	8
4535	1	112	3	Coruña del Conde	9
4536	1	112	7	Madrigalejo	10
4537	1	112	9	Todolella	12
4538	1	112	6	Huete	16
4539	1	112	2	Ogassa	17
4540	1	112	8	Juviles	18
4541	1	112	1	Escopete	19
4542	1	112	7	Fraga	22
4543	1	112	8	Peranzanes	24
4544	1	112	1	Ivars de Noguera	25
4545	1	112	4	Ortigosa de Cameros	26
4546	1	112	6	Pinilla del Valle	28
4547	1	112	0	Garaioa	31
4548	1	112	6	Nogal de las Huertas	34
4549	1	112	8	Cristóbal	37
4550	1	112	1	Lastrilla, La	40
4551	1	112	9	Poboleda	43
4552	1	112	4	Fuentes Claras	44
4553	1	112	7	Navalmorales, Los	45
4554	1	112	0	Chulilla	46
4555	1	112	6	Pedrajas de San Esteban	47
4556	1	112	5	Manzanal de los Infantes	49
4557	1	113	3	Rojales	3
4558	1	113	1	Llanos de Tormes, Los	5
4559	1	113	4	Ribera del Fresno	6
4560	1	113	6	Manresa	8
4561	1	113	9	Covarrubias	9
4562	1	113	3	Madroñera	10
4563	1	113	5	Toga	12
4564	1	113	2	Iniesta	16
4565	1	113	7	Espinosa de Henares	19
4566	1	113	3	Fueva, La	22
4567	1	113	4	Pobladura de Pelayo García	24
4568	1	113	7	Ivars Urgell	25
4569	1	113	0	Pazuengos	26
4570	1	113	2	Pinto	28
4571	1	113	6	Garde	31
4572	1	113	2	Olea de Boedo	34
4573	1	113	4	Cubo de Don Sancho, El	37
4574	1	113	7	Losa, La	40
4575	1	113	9	Medinaceli	42
4576	1	113	5	Pont Armentera, El	43
4577	1	113	0	Fuentes de Rubielos	44
4578	1	113	3	Navalucillos, Los	45
4579	1	113	6	Daimús	46
4580	1	113	2	Pedrosa del Rey	47
4581	1	113	1	Matilla de Arzón	49
4582	1	113	4	Fuendejalón	50
4583	1	114	8	Romana, la	3
4584	1	114	6	Madrigal de las Altas Torres	5
4585	1	114	9	Risco	6
4586	1	114	1	Martorell	8
4587	1	114	4	Cubillo del Campo	9
4588	1	114	8	Majadas	10
4589	1	114	0	Torás	12
4590	1	114	3	Olot	17
4591	1	114	9	Calahorra, La	18
4592	1	114	2	Esplegares	19
4593	1	114	8	Gistaín	22
4594	1	114	9	Pola de Gordón, La	24
4595	1	114	2	Ivorra	25
4596	1	114	5	Pedroso	26
4597	1	114	7	Piñuécar-Gandullas	28
4598	1	114	1	Garínoain	31
4599	1	114	7	Olmos de Ojeda	34
4600	1	114	9	Chagarcía Medianero	37
4601	1	114	0	Porrera	43
4602	1	114	5	Fuentespalda	44
4603	1	114	8	Navamorcuende	45
4604	1	114	1	Domeño	46
4605	1	114	7	Peñafiel	47
4606	1	114	6	Matilla la Seca	49
4607	1	114	9	Fuendetodos	50
4608	1	115	1	Sagra	3
4609	1	115	9	Maello	5
4610	1	115	2	Roca de la Sierra, La	6
4611	1	115	4	Martorelles	8
4612	1	115	7	Cubo de Bureba	9
4613	1	115	1	Malpartida de Cáceres	10
4614	1	115	3	Toro, El	12
4615	1	115	0	Laguna del Marquesado	16
4616	1	115	6	Ordis	17
4617	1	115	2	Láchar	18
4618	1	115	5	Establés	19
4619	1	115	1	Grado, El	22
4620	1	115	2	Ponferrada	24
4621	1	115	5	Isona i Conca Dellà	25
4622	1	115	8	Pinillos	26
4623	1	115	0	Pozuelo de Alarcón	28
4624	1	115	4	Garralda	31
4625	1	115	2	Dios le Guarde	37
4626	1	115	5	Maderuelo	40
4627	1	115	7	Miño de Medinaceli	42
4628	1	115	3	Pradell de la Teixeta	43
4629	1	115	8	Galve	44
4630	1	115	1	Noblejas	45
4631	1	115	4	Dos Aguas	46
4632	1	115	0	Peñaflor de Hornija	47
4633	1	115	9	Mayalde	49
4634	1	115	2	Fuentes de Ebro	50
4635	1	116	4	Salinas	3
4636	1	116	2	Malpartida de Corneja	5
4637	1	116	5	Salvaleón	6
4638	1	116	7	Masies de Roda, Les	8
4639	1	116	4	Malpartida de Plasencia	10
4640	1	116	6	Torralba del Pinar	12
4641	1	116	3	Lagunaseca	16
4642	1	116	9	Osor	17
4643	1	116	5	Lanjarón	18
4644	1	116	8	Estriégana	19
4645	1	116	4	Grañén	22
4646	1	116	5	Posada de Valdeón	24
4647	1	116	3	Pozuelo del Rey	28
4648	1	116	7	Genevilla	31
4649	1	116	3	Osornillo	34
4650	1	116	5	Doñinos de Ledesma	37
4651	1	116	0	Miño de San Esteban	42
4652	1	116	6	Prades	43
4653	1	116	1	Gargallo	44
4654	1	116	4	Noez	45
4655	1	116	7	Eliana, 	46
4656	1	116	3	Pesquera de Duero	47
4657	1	116	2	Melgar de Tera	49
4658	1	116	5	Fuentes de Jiloca	50
4659	1	117	0	Sanet y Negrals	3
4660	1	117	8	Mamblas	5
4661	1	117	1	Salvatierra de los Barros	6
4662	1	117	3	Masies de Voltregà, Les	8
4663	1	117	6	Cueva de Roa, La	9
4664	1	117	0	Marchagaz	10
4665	1	117	2	Torreblanca	12
4666	1	117	9	Landete	16
4667	1	117	5	Palafrugell	17
4668	1	117	1	Lanteira	18
4669	1	117	4	Fontanar	19
4670	1	117	0	Graus	22
4671	1	117	1	Pozuelo del Páramo	24
4672	1	117	7	Pradejón	26
4673	1	117	9	Prádena del Rincón	28
4674	1	117	3	Goizueta	31
4675	1	117	1	Doñinos de Salamanca	37
4676	1	117	6	Molinos de Duero	42
4677	1	117	2	Prat de Comte	43
4678	1	117	7	Gea de Albarracín	44
4679	1	117	0	Nombela	45
4680	1	117	3	Emperador	46
4681	1	117	9	Piña de Esgueva	47
4682	1	117	8	Micereces de Tera	49
4683	1	117	1	Gallocanta	50
4684	1	118	6	San Fulgencio	3
4685	1	118	4	Mancera de Arriba	5
4686	1	118	7	Sancti-Spíritus	6
4687	1	118	9	Masnou, El	8
4688	1	118	6	Mata de Alcántara	10
4689	1	118	8	Torrechiva	12
4690	1	118	5	Ledaña	16
4691	1	118	1	Palamós	17
4692	1	118	0	Fuembellida	19
4693	1	118	7	Prado de la Guzpeña	24
4694	1	118	0	Juncosa	25
4695	1	118	3	Pradillo	26
4696	1	118	5	Puebla de la Sierra	28
4697	1	118	9	Goñi	31
4698	1	118	7	Ejeme	37
4699	1	118	0	Marazuela	40
4700	1	118	2	Momblona	42
4701	1	118	8	Pratdip	43
4702	1	118	3	Ginebrosa, La	44
4703	1	118	6	Novés	45
4704	1	118	9	Enguera	46
4705	1	118	5	Piñel de Abajo	47
4706	1	118	4	Milles de la Polvorosa	49
4707	1	118	7	Gallur	50
4708	1	119	9	Sant Joan Alacant	3
4709	1	119	7	Manjabálago	5
4710	1	119	0	San Pedro de Mérida	6
4711	1	119	2	Masquefa	8
4712	1	119	5	Cuevas de San Clemente	9
4713	1	119	9	Membrío	10
4714	1	119	1	Torre En Besora, la	12
4715	1	119	8	Leganiel	16
4716	1	119	4	Palau de Santa Eulàlia	17
4717	1	119	0	Lecrín	18
4718	1	119	3	Fuencemillán	19
4719	1	119	9	Gurrea de Gállego	22
4720	1	119	0	Priaranza del Bierzo	24
4721	1	119	3	Juneda	25
4722	1	119	6	Préjano	26
4723	1	119	8	Quijorna	28
4724	1	119	2	Güesa/Gorza	31
4725	1	119	0	Encina, La	37
4726	1	119	3	Martín Miguel	40
4727	1	119	5	Monteagudo de las Vicarías	42
4728	1	119	1	Puigpelat	43
4729	1	119	6	Griegos	44
4730	1	119	9	Numancia de la Sagra	45
4731	1	119	2	Ènova, 	46
4732	1	119	8	Piñel de Arriba	47
4733	1	119	7	Molacillos	49
4734	1	119	0	Gelsa	50
4735	1	120	3	San Miguel de Salinas	3
4736	1	120	1	Marlín	5
4737	1	120	4	Santa Amalia	6
4738	1	120	6	Matadepera	8
4739	1	120	9	Encío	9
4740	1	120	3	Mesas de Ibor	10
4741	1	120	5	Torre en Doménec, la	12
4742	1	120	8	Palau-saverdera	17
4743	1	120	4	Lentegí	18
4744	1	120	7	Fuentelahiguera de Albatages	19
4745	1	120	4	Prioro	24
4746	1	120	7	Lleida	25
4747	1	120	0	Quel	26
4748	1	120	2	Rascafría	28
4749	1	120	6	Guesálaz/Gesalatz	31
4750	1	120	2	Palencia	34
4751	1	120	4	Encina de San Silvestre	37
4752	1	120	7	Martín Muñoz de la Dehesa	40
4753	1	120	9	Montejo de Tiermes	42
4754	1	120	5	Querol	43
4755	1	120	0	Guadalaviar	44
4756	1	120	3	Nuño Gómez	45
4757	1	120	6	Estivella	46
4758	1	120	1	Molezuelas de la Carballeda	49
4759	1	120	4	Godojos	50
4760	1	121	0	Santa Pola	3
4761	1	121	8	Martiherrero	5
4762	1	121	1	Santa Marta	6
4763	1	121	3	Mataró	8
4764	1	121	0	Miajadas	10
4765	1	121	2	Traiguera	12
4766	1	121	9	Majadas, Las	16
4767	1	121	5	Palau-sator	17
4768	1	121	1	Lobras	18
4769	1	121	4	Fuentelencina	19
4770	1	121	1	Puebla de Lillo	24
4771	1	121	4	Les	25
4772	1	121	7	Rabanera	26
4773	1	121	9	Redueña	28
4774	1	121	3	Guirguillano	31
4775	1	121	9	Palenzuela	34
4776	1	121	1	Encinas de Abajo	37
4777	1	121	4	Martín Muñoz de las Posadas	40
4778	1	121	6	Montenegro de Cameros	42
4779	1	121	2	Rasquera	43
4780	1	121	7	Gúdar	44
4781	1	121	0	Ocaña	45
4782	1	121	3	Estubeny	46
4783	1	121	9	Pollos	47
4784	1	121	8	Mombuey	49
4785	1	121	1	Gotor	50
4786	1	122	5	San Vicente del Raspeig/Sant Vicent del Raspeig	3
4787	1	122	3	Martínez	5
4788	1	122	6	Santos de Maimona, Los	6
4789	1	122	8	Mediona	8
4790	1	122	1	Espinosa de Cervera	9
4791	1	122	5	Millanes	10
4792	1	122	7	Useras/Useres, les	12
4793	1	122	4	Mariana	16
4794	1	122	6	Loja	18
4795	1	122	9	Fuentelsaz	19
4796	1	122	5	Hoz de Jaca	22
4797	1	122	6	Puente de Domingo Flórez	24
4798	1	122	9	Linyola	25
4799	1	122	2	Rasillo de Cameros, El	26
4800	1	122	4	Ribatejada	28
4801	1	122	8	Huarte/Uharte	31
4802	1	122	4	Páramo de Boedo	34
4803	1	122	6	Encinas de Arriba	37
4804	1	122	9	Marugán	40
4805	1	122	7	Renau	43
4806	1	122	2	Híjar	44
4807	1	122	5	Olías del Rey	45
4808	1	122	8	Faura	46
4809	1	122	4	Portillo	47
4810	1	122	3	Monfarracinos	49
4811	1	122	6	Grisel	50
4812	1	123	1	Sax	3
4813	1	123	9	Mediana de Voltoya	5
4814	1	123	2	San Vicente de Alcántara	6
4815	1	123	4	Molins de Rei	8
4816	1	123	7	Espinosa del Camino	9
4817	1	123	1	Mirabel	10
4818	1	123	3	Vallat	12
4819	1	123	0	Masegosa	16
4820	1	123	6	Palol de Revardit	17
4821	1	123	2	Lugros	18
4822	1	123	5	Fuentelviejo	19
4823	1	123	2	Quintana del Castillo	24
4824	1	123	5	Lladorre	25
4825	1	123	8	Redal, El	26
4826	1	123	0	Rivas-Vaciamadrid	28
4827	1	123	4	Uharte-Arakil	31
4828	1	123	0	Paredes de Nava	34
4829	1	123	2	Encinasola de los Comendadores	37
4830	1	123	5	Matabuena	40
4831	1	123	7	Morón de Almazán	42
4832	1	123	3	Reus	43
4833	1	123	8	Hinojosa de Jarque	44
4834	1	123	1	Ontígola	45
4835	1	123	4	Favara	46
4836	1	123	0	Pozal de Gallinas	47
4837	1	123	9	Montamarta	49
4838	1	123	2	Grisén	50
4839	1	124	6	Sella	3
4840	1	124	4	Medinilla	5
4841	1	124	7	Segura de León	6
4842	1	124	9	Mollet del Vallès	8
4843	1	124	2	Espinosa de los Monteros	9
4844	1	124	6	Mohedas de Granadilla	10
4845	1	124	8	Vall Alba	12
4846	1	124	5	Mesas, Las	16
4847	1	124	1	Pals	17
4848	1	124	7	Lújar	18
4849	1	124	0	Fuentenovilla	19
4850	1	124	6	Huerto	22
4851	1	124	7	Quintana del Marco	24
4852	1	124	0	Lladurs	25
4853	1	124	3	Ribafrecha	26
4854	1	124	5	Robledillo de la Jara	28
4855	1	124	9	Ibargoiti	31
4856	1	124	5	Payo de Ojeda	34
4857	1	124	7	Endrinal	37
4858	1	124	0	Mata de Cuéllar	40
4859	1	124	2	Muriel de la Fuente	42
4860	1	124	8	Riba, La	43
4861	1	124	3	Hoz de la Vieja, La	44
4862	1	124	6	Orgaz	45
4863	1	124	9	Fontanars dels Alforins	46
4864	1	124	5	Pozaldez	47
4865	1	124	4	Moral de Sayago	49
4866	1	124	7	Herrera de los Navarros	50
4867	1	125	9	Senija	3
4868	1	125	7	Mengamuñoz	5
4869	1	125	0	Siruela	6
4870	1	125	2	Montcada i Reixac	8
4871	1	125	5	Estépar	9
4872	1	125	9	Monroy	10
4873	1	125	1	Vall de Almonacid	12
4874	1	125	8	Minglanilla	16
4875	1	125	4	Pardines	17
4876	1	125	3	Gajanejos	19
4877	1	125	9	Huesca	22
4878	1	125	0	Quintana y Congosto	24
4879	1	125	3	Llardecans	25
4880	1	125	6	Rincón de Soto	26
4881	1	125	8	Robledo de Chavela	28
4882	1	125	2	Igúzquiza	31
4883	1	125	8	Pedraza de Campos	34
4884	1	125	0	Escurial de la Sierra	37
4885	1	125	3	Matilla, La	40
4886	1	125	5	Muriel Viejo	42
4887	1	125	1	Riba-roja Ebre	43
4888	1	125	6	Huesa del Común	44
4889	1	125	9	Oropesa	45
4890	1	125	2	Fortaleny	46
4891	1	125	8	Pozuelo de la Orden	47
4892	1	125	7	Moraleja del Vino	49
4893	1	125	0	Ibdes	50
4894	1	126	0	Mesegar de Corneja	5
4895	1	126	3	Solana de los Barros	6
4896	1	126	5	Montgat	8
4897	1	126	2	Montánchez	10
4898	1	126	4	Vall Uixó, la	12
4899	1	126	1	Mira	16
4900	1	126	7	Parlavà	17
4901	1	126	3	Malahá, La	18
4902	1	126	6	Galápagos	19
4903	1	126	2	Ibieca	22
4904	1	126	6	Llavorsí	25
4905	1	126	9	Robres del Castillo	26
4906	1	126	1	Robregordo	28
4907	1	126	5	Imotz	31
4908	1	126	1	Pedrosa de la Vega	34
4909	1	126	3	Espadaña	37
4910	1	126	6	Melque de Cercos	40
4911	1	126	4	Riera de Gaià, La	43
4912	1	126	9	Iglesuela del Cid, La	44
4913	1	126	2	Otero	45
4914	1	126	5	Foios	46
4915	1	126	1	Puras	47
4916	1	126	0	Moraleja de Sayago	49
4917	1	126	3	Illueca	50
4918	1	127	8	Tàrbena	3
4919	1	127	6	Mijares	5
4920	1	127	9	Talarrubias	6
4921	1	127	1	Monistrol de Montserrat	8
4922	1	127	4	Fontioso	9
4923	1	127	8	Montehermoso	10
4924	1	127	0	Vallibona	12
4925	1	127	9	Maracena	18
4926	1	127	2	Galve de Sorbe	19
4927	1	127	8	Igriés	22
4928	1	127	9	Regueras de Arriba	24
4929	1	127	2	Lles de Cerdanya	25
4930	1	127	5	Rodezno	26
4931	1	127	7	Rozas de Madrid, Las	28
4932	1	127	1	Irañeta	31
4933	1	127	7	Perales	34
4934	1	127	9	Espeja	37
4935	1	127	2	Membibre de la Hoz	40
4936	1	127	4	Nafría de Ucero	42
4937	1	127	0	Riudecanyes	43
4938	1	127	5	Jabaloyas	44
4939	1	127	8	Palomeque	45
4940	1	127	1	Font En Carròs, la	46
4941	1	127	7	Quintanilla de Arriba	47
4942	1	127	6	Morales del Vino	49
4943	1	128	4	Teulada	3
4944	1	128	2	Mingorría	5
4945	1	128	5	Talavera la Real	6
4946	1	128	7	Monistrol de Calders	8
4947	1	128	0	Frandovínez	9
4948	1	128	4	Moraleja	10
4949	1	128	6	Vilafamés	12
4950	1	128	3	Monreal del Llano	16
4951	1	128	9	Pau	17
4952	1	128	5	Marchal	18
4953	1	128	4	Ilche	22
4954	1	128	8	Llimiana	25
4955	1	128	1	Sajazarra	26
4956	1	128	3	Rozas de Puerto Real	28
4957	1	128	7	Isaba/Izaba	31
4958	1	128	5	Espino de la Orbada	37
4959	1	128	8	Migueláñez	40
4960	1	128	0	Narros	42
4961	1	128	6	Riudecols	43
4962	1	128	1	Jarque de la Val	44
4963	1	128	4	Pantoja	45
4964	1	128	7	Font de la Figuera, la	46
4965	1	128	3	Quintanilla del Molar	47
4966	1	128	2	Morales de Rey	49
4967	1	128	5	Isuerre	50
4968	1	129	7	Tibi	3
4969	1	129	5	Mirón, El	5
4970	1	129	8	Táliga	6
4971	1	129	0	Muntanyola	8
4972	1	129	3	Fresneda de la Sierra Tirón	9
4973	1	129	7	Morcillo	10
4974	1	129	9	Villafranca del Cid/Vilafranca	12
4975	1	129	6	Montalbanejo	16
4976	1	129	2	Pedret i Marzà	17
4977	1	129	1	Gascueña de Bornova	19
4978	1	129	7	Isábena	22
4979	1	129	8	Reyero	24
4980	1	129	1	Llobera	25
4981	1	129	4	San Asensio	26
4982	1	129	6	San Agustín del Guadalix	28
4983	1	129	0	Ituren	31
4984	1	129	6	Pino del Río	34
4985	1	129	8	Florida de Liébana	37
4986	1	129	1	Montejo de Arévalo	40
4987	1	129	3	Navaleno	42
4988	1	129	9	Riudoms	43
4989	1	129	4	Jatiel	44
4990	1	129	7	Paredes de Escalona	45
4991	1	129	0	Fuenterrobles	46
4992	1	129	6	Quintanilla de Onésimo	47
4993	1	129	5	Morales de Toro	49
4994	1	129	8	Jaraba	50
4995	1	130	1	Tollos	3
4996	1	130	9	Mironcillo	5
4997	1	130	2	Tamurejo	6
4998	1	130	4	Montclar	8
4999	1	130	7	Fresneña	9
5000	1	130	1	Navaconcejo	10
5001	1	130	3	Villahermosa del Río	12
5002	1	130	0	Montalbo	16
5003	1	130	6	Pera, La	17
5004	1	130	5	Guadalajara	19
5005	1	130	1	Jaca	22
5006	1	130	2	Riaño	24
5007	1	130	5	Maldà	25
5008	1	130	8	San Millán de la Cogolla	26
5009	1	130	0	San Fernando de Henares	28
5010	1	130	4	Iturmendi	31
5011	1	130	0	Piña de Campos	34
5012	1	130	2	Forfoleda	37
5013	1	130	5	Montejo de la Vega de la Serrezuela	40
5014	1	130	7	Nepas	42
5015	1	130	3	Rocafort de Queralt	43
5016	1	130	8	Jorcas	44
5017	1	130	1	Parrillas	45
5018	1	130	4	Gavarda	46
5019	1	130	0	Quintanilla de Trigueros	47
5020	1	130	9	Morales de Valverde	49
5021	1	130	2	Jarque	50
5022	1	131	8	Tormos	3
5023	1	131	6	Mirueña de los Infanzones	5
5024	1	131	9	Torre de Miguel Sesmero	6
5025	1	131	1	Montesquiu	8
5026	1	131	4	Fresnillo de las Dueñas	9
5027	1	131	8	Navalmoral de la Mata	10
5028	1	131	0	Villamalur	12
5029	1	131	7	Monteagudo de las Salinas	16
5030	1	131	8	Jasa	22
5031	1	131	9	Riego de la Vega	24
5032	1	131	2	Massalcoreig	25
5033	1	131	5	San Millán de Yécora	26
5034	1	131	7	San Lorenzo de El Escorial	28
5035	1	131	1	Iza/Itza	31
5036	1	131	7	Población de Arroyo	34
5037	1	131	9	Frades de la Sierra	37
5038	1	131	2	Monterrubio	40
5039	1	131	4	Nolay	42
5040	1	131	0	Roda de Barà	43
5041	1	131	5	Josa	44
5042	1	131	8	Pelahustán	45
5043	1	131	1	Gandia	46
5044	1	131	7	Rábano	47
5045	1	131	6	Moralina	49
5046	1	131	9	Jaulín	50
5047	1	132	3	Torremanzanas/Torre de les Maçanes, la	3
5048	1	132	1	Mombeltrán	5
5049	1	132	4	Torremayor	6
5050	1	132	6	Montmajor	8
5051	1	132	9	Fresno de Río Tirón	9
5052	1	132	3	Navalvillar de Ibor	10
5053	1	132	5	Vilanova Alcolea	12
5054	1	132	2	Mota de Altarejos	16
5055	1	132	8	Peralada	17
5056	1	132	4	Moclín	18
5057	1	132	7	Henche	19
5058	1	132	4	Riello	24
5059	1	132	7	Massoteres	25
5060	1	132	0	San Román de Cameros	26
5061	1	132	2	San Martín de la Vega	28
5062	1	132	6	Izagaondoa	31
5063	1	132	2	Población de Campos	34
5064	1	132	4	Fregeneda, La	37
5065	1	132	7	Moral de Hornuez	40
5066	1	132	9	Noviercas	42
5067	1	132	5	Rodonyà	43
5068	1	132	0	Lagueruela	44
5069	1	132	3	Pepino	45
5070	1	132	6	Genovés	46
5071	1	132	2	Ramiro	47
5072	1	132	1	Moreruela de los Infanzones	49
5073	1	132	4	Joyosa, La	50
5074	1	133	9	Torrevieja	3
5075	1	133	7	Monsalupe	5
5076	1	133	0	Torremejía	6
5077	1	133	2	Montmaneu	8
5078	1	133	5	Fresno de Rodilla	9
5079	1	133	9	Navas del Madroño	10
5080	1	133	1	Villanueva de Viver	12
5081	1	133	8	Mota del Cuervo	16
5082	1	133	4	Planes Hostoles, Les	17
5083	1	133	0	Molvízar	18
5084	1	133	3	Heras de Ayuso	19
5085	1	133	9	Labuerda	22
5086	1	133	0	Rioseco de Tapia	24
5087	1	133	3	Maials	25
5088	1	133	8	San Martín de Valdeiglesias	28
5089	1	133	2	Izalzu/Itzaltzu	31
5090	1	133	8	Población de Cerrato	34
5091	1	133	0	Fresnedoso	37
5092	1	133	1	Roquetes	43
5093	1	133	6	Lanzuela	44
5094	1	133	9	Polán	45
5095	1	133	2	Gestalgar	46
5096	1	133	8	Renedo de Esgueva	47
5097	1	133	7	Moreruela de Tábara	49
5098	1	133	0	Lagata	50
5099	1	134	4	Vall Alcalà, la	3
5100	1	134	2	Moraleja de Matacabras	5
5101	1	134	5	Trasierra	6
5102	1	134	7	Figaró-Montmany	8
5103	1	134	0	Frías	9
5104	1	134	4	Navezuelas	10
5105	1	134	6	Vilar de Canes	12
5106	1	134	3	Motilla del Palancar	16
5107	1	134	9	Planoles	17
5108	1	134	5	Monachil	18
5109	1	134	8	Herrería	19
5110	1	134	5	Robla, La	24
5111	1	134	8	Menàrguens	25
5112	1	134	1	Santa Coloma	26
5113	1	134	3	San Sebastián de los Reyes	28
5114	1	134	7	Jaurrieta	31
5115	1	134	3	Polentinos	34
5116	1	134	5	Fresno Alhándiga	37
5117	1	134	8	Mozoncillo	40
5118	1	134	0	Ólvega	42
5119	1	134	6	Rourell, El	43
5120	1	134	4	Portillo de Toledo	45
5121	1	134	7	Gilet	46
5122	1	134	3	Roales de Campos	47
5123	1	134	2	Muelas de los Caballeros	49
5124	1	134	5	Langa del Castillo	50
5125	1	135	7	Vall Ebo, la	3
5126	1	135	5	Muñana	5
5127	1	135	8	Trujillanos	6
5128	1	135	0	Montmeló	8
5129	1	135	3	Fuentebureba	9
5130	1	135	7	Nuñomoral	10
5131	1	135	9	Vila-real	12
5132	1	135	6	Moya	16
5133	1	135	2	Pont de Molins	17
5134	1	135	8	Montefrío	18
5135	1	135	1	Hiendelaencina	19
5136	1	135	7	Laluenga	22
5137	1	135	1	Miralcamp	25
5138	1	135	4	Santa Engracia del Jubera	26
5139	1	135	6	Santa María de la Alameda	28
5140	1	135	0	Javier	31
5141	1	135	6	Pomar de Valdivia	34
5142	1	135	8	Fuente de San Esteban, La	37
5143	1	135	1	Muñopedro	40
5144	1	135	3	Oncala	42
5145	1	135	9	Salomó	43
5146	1	135	4	Libros	44
5147	1	135	7	Puebla de Almoradiel, La	45
5148	1	135	0	Godella	46
5149	1	135	6	Robladillo	47
5150	1	135	5	Muelas del Pan	49
5151	1	135	8	Layana	50
5152	1	136	0	Vall de Gallinera	3
5153	1	136	8	Muñico	5
5154	1	136	1	Usagre	6
5155	1	136	3	Montornès del Vallès	8
5156	1	136	6	Fuentecén	9
5157	1	136	0	Oliva de Plasencia	10
5158	1	136	2	Vilavella, la	12
5159	1	136	5	Pontós	17
5160	1	136	1	Montejícar	18
5161	1	136	4	Hijes	19
5162	1	136	0	Lalueza	22
5163	1	136	1	Roperuelos del Páramo	24
5164	1	136	4	Molsosa, La	25
5165	1	136	7	Santa Eulalia Bajera	26
5166	1	136	9	Santorcaz	28
5167	1	136	3	Juslapeña	31
5168	1	136	9	Poza de la Vega	34
5169	1	136	1	Fuenteguinaldo	37
5170	1	136	4	Muñoveros	40
5171	1	136	2	Sant Carles de la Ràpita	43
5172	1	136	7	Lidón	44
5173	1	136	0	Puebla de Montalbán, La	45
5174	1	136	3	Godelleta	46
5175	1	136	8	Muga de Sayago	49
5176	1	136	1	Lécera	50
5177	1	137	6	Vall de Laguar, la	3
5178	1	137	7	Valdecaballeros	6
5179	1	137	9	Montseny	8
5180	1	137	2	Fuentelcésped	9
5181	1	137	6	Palomero	10
5182	1	137	8	Villores	12
5183	1	137	5	Narboneta	16
5184	1	137	1	Porqueres	17
5185	1	137	7	Montillana	18
5186	1	137	6	Lanaja	22
5187	1	137	7	Sabero	24
5188	1	137	0	Mollerussa	25
5189	1	137	5	Santos de la Humosa, Los	28
5190	1	137	9	Beintza-Labaien	31
5191	1	137	5	Pozo de Urama	34
5192	1	137	7	Fuenteliante	37
5193	1	137	8	Sant Jaume dels Domenys	43
5194	1	137	3	Linares de Mora	44
5195	1	137	6	Pueblanueva, La	45
5196	1	137	9	Granja de la Costera, la	46
5197	1	137	5	Roturas	47
5198	1	137	4	Navianos de Valverde	49
5199	1	137	7	Leciñena	50
5200	1	138	2	Verger, el	3
5201	1	138	0	Muñogalindo	5
5202	1	138	3	Valdetorres	6
5203	1	138	5	Moià	8
5204	1	138	8	Fuentelisendo	9
5205	1	138	2	Pasarón de la Vera	10
5206	1	138	4	Vinaròs	12
5207	1	138	7	Portbou	17
5208	1	138	3	Moraleda de Zafayona	18
5209	1	138	6	Hita	19
5210	1	138	6	Montgai	25
5211	1	138	9	Santo Domingo de la Calzada	26
5212	1	138	1	Serna del Monte, La	28
5213	1	138	5	Lakuntza	31
5214	1	138	3	Fuenterroble de Salvatierra	37
5215	1	138	6	Nava de la Asunción	40
5216	1	138	4	Santa Bàrbara	43
5217	1	138	9	Loscos	44
5218	1	138	2	Puente del Arzobispo, El	45
5219	1	138	5	Guadasséquies	46
5220	1	138	1	Rubí de Bracamonte	47
5221	1	138	0	Olmillos de Castro	49
5222	1	138	3	Lechón	50
5223	1	139	5	Villajoyosa/Vila Joiosa, la	3
5224	1	139	3	Muñogrande	5
5225	1	139	6	Valencia de las Torres	6
5226	1	139	8	Mura	8
5227	1	139	1	Fuentemolinos	9
5228	1	139	5	Pedroso de Acim	10
5229	1	139	7	Vistabella del Maestrazgo	12
5230	1	139	4	Olivares de Júcar	16
5231	1	139	0	Preses, Les	17
5232	1	139	9	Hombrados	19
5233	1	139	5	Laperdiguera	22
5234	1	139	6	Sahagún	24
5235	1	139	9	Montellà i Martinet	25
5236	1	139	2	San Torcuato	26
5237	1	139	8	Lana	31
5238	1	139	4	Prádanos de Ojeda	34
5239	1	139	6	Fuentes de Béjar	37
5240	1	139	9	Navafría	40
5241	1	139	1	Pinilla del Campo	42
5242	1	139	7	Santa Coloma de Queralt	43
5243	1	139	5	Puerto de San Vicente	45
5244	1	139	8	Guadassuar	46
5245	1	139	4	Rueda	47
5246	1	139	3	Otero de Bodas	49
5247	1	139	6	Letux	50
5248	1	140	9	Villena	3
5249	1	140	7	Muñomer del Peco	5
5250	1	140	0	Valencia del Mombuey	6
5251	1	140	2	Navarcles	8
5252	1	140	5	Fuentenebro	9
5253	1	140	9	Peraleda de la Mata	10
5254	1	140	1	Viver	12
5255	1	140	8	Olmeda de la Cuesta	16
5256	1	140	4	Port de la Selva, El	17
5257	1	140	0	Motril	18
5258	1	140	3	Montferrer i Castellbò	25
5259	1	140	6	Santurde de Rioja	26
5260	1	140	8	Serranillos del Valle	28
5261	1	140	2	Lantz	31
5262	1	140	8	Puebla de Valdavia, La	34
5263	1	140	0	Fuentes de Oñoro	37
5264	1	140	3	Navalilla	40
5265	1	140	5	Portillo de Soria	42
5266	1	140	1	Santa Oliva	43
5267	1	140	9	Pulgar	45
5268	1	140	2	Guardamar de la Safor	46
5269	1	140	8	Saelices de Mayorga	47
5270	1	140	0	Litago	50
5271	1	141	4	Muñopepe	5
5272	1	141	7	Valencia del Ventoso	6
5273	1	141	9	Navàs	8
5274	1	141	2	Fuentespina	9
5275	1	141	6	Peraleda de San Román	10
5276	1	141	8	Zorita del Maestrazgo	12
5277	1	141	5	Olmeda del Rey	16
5278	1	141	1	Puigcerdà	17
5279	1	141	7	Murtas	18
5280	1	141	6	Lascellas-Ponzano	22
5281	1	141	7	San Adrián del Valle	24
5282	1	141	0	Montoliu de Segarra	25
5283	1	141	3	Santurdejo	26
5284	1	141	5	Sevilla la Nueva	28
5285	1	141	9	Lapoblación	31
5286	1	141	5	Quintana del Puente	34
5287	1	141	7	Gajates	37
5288	1	141	0	Navalmanzano	40
5289	1	141	2	Póveda de Soria, La	42
5290	1	141	8	Pontils	43
5291	1	141	3	Lledó	44
5292	1	141	6	Quero	45
5293	1	141	9	Higueruelas	46
5294	1	141	5	Salvador de Zapardiel	47
5295	1	141	4	Pajares de la Lampreana	49
5296	1	141	7	Lituénigo	50
5297	1	142	9	Muñosancho	5
5298	1	142	2	Valverde de Burguillos	6
5299	1	142	4	Nou de Berguedà, La	8
5300	1	142	1	Perales del Puerto	10
5301	1	142	3	Zucaina	12
5302	1	142	0	Olmedilla de Alarcón	16
5303	1	142	6	Quart	17
5304	1	142	5	Hontoba	19
5305	1	142	1	Lascuarre	22
5306	1	142	2	San Andrés del Rabanedo	24
5307	1	142	5	Montoliu de Lleida	25
5308	1	142	8	San Vicente de la Sonsierra	26
5309	1	142	4	Larraga	31
5310	1	142	2	Galindo y Perahuy	37
5311	1	142	5	Navares de Ayuso	40
5312	1	142	7	Pozalmuro	42
5313	1	142	3	Sarral	43
5314	1	142	8	Maicas	44
5315	1	142	1	Quintanar de la Orden	45
5316	1	142	4	Jalance	46
5317	1	142	0	San Cebrián de Mazote	47
5318	1	142	9	Palacios del Pan	49
5319	1	142	2	Lobera de Onsella	50
5320	1	143	5	Muñotello	5
5321	1	143	8	Valverde de Leganés	6
5322	1	143	0	Òdena	8
5323	1	143	3	Galbarros	9
5324	1	143	7	Pescueza	10
5325	1	143	6	Olmedilla de Eliz	16
5326	1	143	2	Rabós	17
5327	1	143	8	Nigüelas	18
5328	1	143	1	Horche	19
5329	1	143	7	Laspaúles	22
5330	1	143	8	Sancedo	24
5331	1	143	1	Montornès de Segarra	25
5332	1	143	4	Sojuela	26
5333	1	143	6	Somosierra	28
5334	1	143	0	Larraona	31
5335	1	143	6	Quintanilla de Onsoña	34
5336	1	143	8	Galinduste	37
5337	1	143	1	Navares de Enmedio	40
5338	1	143	9	Savallà del Comtat	43
5339	1	143	4	Manzanera	44
5340	1	143	7	Quismondo	45
5341	1	143	0	Xeraco	46
5342	1	143	6	San Llorente	47
5343	1	143	5	Palacios de Sanabria	49
5344	1	143	8	Longares	50
5345	1	144	0	Narrillos del Álamo	5
5346	1	144	3	Valverde de Llerena	6
5347	1	144	5	Olvan	8
5348	1	144	8	Gallega, La	9
5349	1	144	2	Pesga, La	10
5350	1	144	7	Regencós	17
5351	1	144	3	Nívar	18
5352	1	144	2	Laspuña	22
5353	1	144	3	San Cristóbal de la Polantera	24
5354	1	144	9	Sorzano	26
5355	1	144	1	Soto del Real	28
5356	1	144	5	Larraun	31
5357	1	144	3	Galisancho	37
5358	1	144	6	Navares de las Cuevas	40
5359	1	144	8	Quintana Redonda	42
5360	1	144	4	Secuita, La	43
5361	1	144	9	Martín del Río	44
5362	1	144	2	Real de San Vicente, El	45
5363	1	144	5	Jarafuel	46
5364	1	144	1	San Martín de Valvení	47
5365	1	144	3	Longás	50
5366	1	145	3	Narrillos del Rebollar	5
5367	1	145	6	Valverde de Mérida	6
5368	1	145	8	Olèrdola	8
5369	1	145	5	Piedras Albas	10
5370	1	145	4	Osa de la Vega	16
5371	1	145	0	Ribes de Freser	17
5372	1	145	6	Ogíjares	18
5373	1	145	9	Hortezuela de Océn	19
5374	1	145	6	San Emiliano	24
5375	1	145	9	Nalec	25
5376	1	145	2	Sotés	26
5377	1	145	4	Talamanca de Jarama	28
5378	1	145	8	Lazagurría	31
5379	1	145	6	Gallegos de Argañán	37
5380	1	145	9	Navas de Oro	40
5381	1	145	1	Quintanas de Gormaz	42
5382	1	145	7	Selva del Camp, La	43
5383	1	145	2	Mas de las Matas	44
5384	1	145	5	Recas	45
5385	1	145	8	Xàtiva	46
5386	1	145	4	San Miguel del Arroyo	47
5387	1	145	3	Pedralba de la Pradería	49
5388	1	146	9	Valle de la Serena	6
5389	1	146	1	Olesa de Bonesvalls	8
5390	1	146	8	Pinofranqueado	10
5391	1	146	7	Pajarón	16
5392	1	146	3	Riells i Viabrea	17
5393	1	146	9	Orce	18
5394	1	146	2	Huerce, La	19
5395	1	146	9	San Esteban de Nogales	24
5396	1	146	2	Navès	25
5397	1	146	5	Soto en Cameros	26
5398	1	146	7	Tielmes	28
5399	1	146	1	Leache	31
5400	1	146	7	Reinoso de Cerrato	34
5401	1	146	9	Gallegos de Solmirón	37
5402	1	146	2	Navas de San Antonio	40
5403	1	146	0	Senan	43
5404	1	146	5	Mata de los Olmos, La	44
5405	1	146	8	Retamoso de la Jara	45
5406	1	146	1	Xeresa	46
5407	1	146	7	San Miguel del Pino	47
5408	1	146	6	Pego, El	49
5409	1	146	9	Lucena de Jalón	50
5410	1	147	2	Narros del Castillo	5
5411	1	147	5	Valle de Matamoros	6
5412	1	147	7	Olesa de Montserrat	8
5413	1	147	4	Piornal	10
5414	1	147	3	Pajaroncillo	16
5415	1	147	9	Ripoll	17
5416	1	147	5	Órgiva	18
5417	1	147	8	Huérmeces del Cerro	19
5418	1	147	1	Terroba	26
5419	1	147	3	Titulcia	28
5420	1	147	7	Legarda	31
5421	1	147	3	Renedo de la Vega	34
5422	1	147	5	Garcibuey	37
5423	1	147	6	Solivella	43
5424	1	147	1	Mazaleón	44
5425	1	147	4	Rielves	45
5426	1	147	7	Llíria	46
5427	1	147	3	San Pablo de la Moraleja	47
5428	1	147	2	Peleagonzalo	49
5429	1	147	5	Luceni	50
5430	1	148	8	Narros del Puerto	5
5431	1	148	1	Valle de Santa Ana	6
5432	1	148	3	Olivella	8
5433	1	148	6	Grijalba	9
5434	1	148	0	Plasencia	10
5435	1	148	9	Palomares del Campo	16
5436	1	148	5	Riudarenes	17
5437	1	148	1	Otívar	18
5438	1	148	4	Huertahernando	19
5439	1	148	1	San Justo de la Vega	24
5440	1	148	4	Odèn	25
5441	1	148	7	Tirgo	26
5442	1	148	9	Torrejón de Ardoz	28
5443	1	148	3	Legaria	31
5444	1	148	1	Garcihernández	37
5445	1	148	4	Nieva	40
5446	1	148	6	Quiñonería	42
5447	1	148	2	Tarragona	43
5448	1	148	7	Mezquita de Jarque	44
5449	1	148	0	Robledo del Mazo	45
5450	1	148	3	Loriguilla	46
5451	1	148	9	San Pedro de Latarce	47
5452	1	148	8	Peleas de Abajo	49
5453	1	148	1	Luesia	50
5454	1	149	1	Narros de Saldueña	5
5455	1	149	4	Villafranca de los Barros	6
5456	1	149	6	Olost	8
5457	1	149	9	Grisaleña	9
5458	1	149	3	Plasenzuela	10
5459	1	149	2	Palomera	16
5460	1	149	8	Riudaura	17
5461	1	149	4	Otura	18
5462	1	149	3	Loarre	22
5463	1	149	4	San Millán de los Caballeros	24
5464	1	149	7	Oliana	25
5465	1	149	0	Tobía	26
5466	1	149	2	Torrejón de la Calzada	28
5467	1	149	6	Leitza	31
5468	1	149	2	Requena de Campos	34
5469	1	149	4	Garcirrey	37
5470	1	149	7	Olombrada	40
5471	1	149	9	Rábanos, Los	42
5472	1	149	5	Tivenys	43
5473	1	149	0	Mirambel	44
5474	1	149	3	Romeral, El	45
5475	1	149	6	Losa del Obispo	46
5476	1	149	2	San Pelayo	47
5477	1	149	1	Peñausende	49
5478	1	149	4	Luesma	50
5479	1	150	7	Villagarcía de la Torre	6
5480	1	150	9	Orís	8
5481	1	150	6	Portaje	10
5482	1	150	5	Paracuellos	16
5483	1	150	1	Riudellots de la Selva	17
5484	1	150	7	Padul	18
5485	1	150	0	Hueva	19
5486	1	150	6	Loporzano	22
5487	1	150	7	San Pedro Bercianos	24
5488	1	150	0	Oliola	25
5489	1	150	3	Tormantos	26
5490	1	150	5	Torrejón de Velasco	28
5491	1	150	9	Leoz/Leotz	31
5492	1	150	7	Gejuelo del Barro	37
5493	1	150	0	Orejana	40
5494	1	150	8	Tivissa	43
5495	1	150	3	Miravete de la Sierra	44
5496	1	150	6	San Bartolomé de las Abiertas	45
5497	1	150	9	Llutxent	46
5498	1	150	5	San Román de Hornija	47
5499	1	150	4	Peque	49
5500	1	150	7	Lumpiaque	50
5501	1	151	1	Navacepedilla de Corneja	5
5502	1	151	4	Villagonzalo	6
5503	1	151	6	Oristà	8
5504	1	151	9	Gumiel de Izán	9
5505	1	151	3	Portezuelo	10
5506	1	151	2	Paredes	16
5507	1	151	8	Riumors	17
5508	1	151	4	Pampaneira	18
5509	1	151	7	Humanes	19
5510	1	151	3	Loscorrales	22
5511	1	151	4	Santa Colomba de Curueño	24
5512	1	151	7	Olius	25
5513	1	151	0	Torrecilla en Cameros	26
5514	1	151	2	Torrelaguna	28
5515	1	151	6	Lerga	31
5516	1	151	2	Respenda de la Peña	34
5517	1	151	4	Golpejas	37
5518	1	151	7	Ortigosa de Pestaño	40
5519	1	151	9	Rebollar	42
5520	1	151	5	Torre de Fontaubella, La	43
5521	1	151	0	Molinos	44
5522	1	151	3	San Martín de Montalbán	45
5523	1	151	6	Llocnou En Fenollet	46
5524	1	151	2	San Salvador	47
5525	1	151	1	Perdigón, El	49
5526	1	151	4	Luna	50
5527	1	152	6	Nava de Arévalo	5
5528	1	152	9	Villalba de los Barros	6
5529	1	152	1	Orpí	8
5530	1	152	4	Gumiel de Mercado	9
5531	1	152	8	Pozuelo de Zarzón	10
5532	1	152	7	Parra de las Vegas, La	16
5533	1	152	3	Roses	17
5534	1	152	9	Pedro Martínez	18
5535	1	152	2	Illana	19
5536	1	152	9	Santa Colomba de Somoza	24
5537	1	152	2	Oluges, Les	25
5538	1	152	5	Torrecilla sobre Alesanco	26
5539	1	152	7	Torrelodones	28
5540	1	152	1	Lerín	31
5541	1	152	7	Revenga de Campos	34
5542	1	152	9	Gomecello	37
5543	1	152	2	Otero de Herreros	40
5544	1	152	4	Recuerda	42
5545	1	152	0	La Torre del Espanyol	43
5546	1	152	5	Monforte de Moyuela	44
5547	1	152	8	San Martín de Pusa	45
5548	1	152	1	Llocnou de la Corona	46
5549	1	152	7	Santa Eufemia del Arroyo	47
5550	1	152	6	Pereruela	49
5551	1	152	9	Maella	50
5552	1	153	2	Nava del Barco	5
5553	1	153	5	Villanueva de la Serena	6
5554	1	153	7	Òrrius	8
5555	1	153	4	Puerto de Santa Cruz	10
5556	1	153	3	El Pedernoso	16
5557	1	153	9	Rupià	17
5558	1	153	5	Peligros	18
5559	1	153	8	Iniéstola	19
5560	1	153	5	Santa Cristina de Valmadrigal	24
5561	1	153	8	Els Omellons	25
5562	1	153	1	Torre en Cameros	26
5563	1	153	3	Torremocha de Jarama	28
5564	1	153	7	Lesaka	31
5565	1	153	0	Rello	42
5566	1	153	6	Torredembarra	43
5567	1	153	1	Monreal del Campo	44
5568	1	153	4	San Pablo de los Montes	45
5569	1	153	7	Llocnou de Sant Jeroni	46
5570	1	153	3	Santervás de Campos	47
5571	1	153	2	Perilla de Castro	49
5572	1	153	5	Magallón	50
5573	1	154	7	Navadijos	5
5574	1	154	0	Villanueva del Fresno	6
5575	1	154	2	Pacs del Penedès	8
5576	1	154	5	Hacinas	9
5577	1	154	9	Rebollar	10
5578	1	154	8	Las Pedroñeras	16
5579	1	154	4	Sales de Llierca	17
5580	1	154	0	La Peza	18
5581	1	154	3	Las Inviernas	19
5582	1	154	0	Santa Elena de Jamuz	24
5583	1	154	3	Els Omells de na Gaia	25
5584	1	154	6	Torremontalbo	26
5585	1	154	8	Torres de la Alameda	28
5586	1	154	2	Lezáun	31
5587	1	154	8	Revilla de Collazos	34
5588	1	154	0	Guadramiro	37
5589	1	154	3	Pajarejos	40
5590	1	154	5	Renieblas	42
5591	1	154	1	Torroja del Priorat	43
5592	1	154	6	Monroyo	44
5593	1	154	9	San Román de los Montes	45
5594	1	154	2	Llanera de Ranes	46
5595	1	154	8	Santibáñez de Valcorba	47
5596	1	154	7	Pías	49
5597	1	154	0	Mainar	50
5598	1	155	0	Navaescurial	5
5599	1	155	3	Villar del Rey	6
5600	1	155	5	Palafolls	8
5601	1	155	8	Haza	9
5602	1	155	2	Riolobos	10
5603	1	155	1	El Peral	16
5604	1	155	7	Salt	17
5605	1	155	6	Irueste	19
5606	1	155	2	Monesma y Cajigar	22
5607	1	155	3	Santa María de la Isla	24
5608	1	155	6	Organyà	25
5609	1	155	9	Treviana	26
5610	1	155	1	Valdaracete	28
5611	1	155	5	Liédena	31
5612	1	155	1	Ribas de Campos	34
5613	1	155	3	Guijo de Ávila	37
5614	1	155	6	Palazuelos de Eresma	40
5615	1	155	8	Retortillo de Soria	42
5616	1	155	4	Tortosa	43
5617	1	155	9	Montalbán	44
5618	1	155	2	Santa Ana de Pusa	45
5619	1	155	5	Llaurí	46
5620	1	155	1	Santovenia de Pisuerga	47
5621	1	155	0	Piedrahita de Castro	49
5622	1	155	3	Malanquilla	50
5623	1	156	3	Navahondilla	5
5624	1	156	6	Villar de Rena	6
5625	1	156	8	Palau-solità i Plegamans	8
5626	1	156	5	Robledillo de Gata	10
5627	1	156	4	La Peraleja	16
5628	1	156	9	Jadraque	19
5629	1	156	5	Monflorite-Lascasas	22
5630	1	156	6	Santa María del Monte de Cea	24
5631	1	156	9	Os de Balaguer	25
5632	1	156	4	Valdeavero	28
5633	1	156	8	Lizoáin-Arriasgoiti	31
5634	1	156	4	Riberos de la Cueza	34
5635	1	156	6	Guijuelo	37
5636	1	156	9	Pedraza	40
5637	1	156	1	Reznos	42
5638	1	156	7	Ulldecona	43
5639	1	156	2	Monteagudo del Castillo	44
5640	1	156	5	Santa Cruz de la Zarza	45
5641	1	156	8	Llombai	46
5642	1	156	4	San Vicente del Palacio	47
5643	1	156	3	Pinilla de Toro	49
5644	1	156	6	Maleján	50
5645	1	157	9	Navalacruz	5
5646	1	157	2	Villarta de los Montes	6
5647	1	157	4	Pallejà	8
5648	1	157	1	Robledillo de la Vera	10
5649	1	157	0	La Pesquera	16
5650	1	157	6	Sant Andreu Salou	17
5651	1	157	2	Pinos Genil	18
5652	1	157	5	Jirueque	19
5653	1	157	1	Montanuy	22
5654	1	157	2	Santa María del Páramo	24
5655	1	157	5	Ossó de Sió	25
5656	1	157	8	Tricio	26
5657	1	157	0	Valdelaguna	28
5658	1	157	4	Lodosa	31
5659	1	157	0	Saldaña	34
5660	1	157	2	Herguijuela de Ciudad Rodrigo	37
5661	1	157	5	Pelayos del Arroyo	40
5662	1	157	7	Riba de Escalote, La	42
5663	1	157	3	Ulldemolins	43
5664	1	157	8	Monterde de Albarracín	44
5665	1	157	1	Santa Cruz del Retamar	45
5666	1	157	4	Llosa de Ranes, la	46
5667	1	157	0	Sardón de Duero	47
5668	1	157	9	Pino del Oro	49
5669	1	157	2	Malón	50
5670	1	158	5	Navalmoral	5
5671	1	158	8	Zafra	6
5672	1	158	0	Papiol, El	8
5673	1	158	7	Robledillo de Trujillo	10
5674	1	158	6	Picazo, El	16
5675	1	158	2	Sant Climent Sescebes	17
5676	1	158	8	Pinos Puente	18
5677	1	158	7	Monzón	22
5678	1	158	8	Santa María de Ordás	24
5679	1	158	1	Palau Anglesola, El	25
5680	1	158	4	Tudelilla	26
5681	1	158	6	Valdemanco	28
5682	1	158	0	Lónguida/Longida	31
5683	1	158	6	Salinas de Pisuerga	34
5684	1	158	8	Herguijuela de la Sierra	37
5685	1	158	1	Perosillo	40
5686	1	158	3	Rioseco de Soria	42
5687	1	158	9	Vallclara	43
5688	1	158	4	Mora de Rubielos	44
5689	1	158	7	Santa Olalla	45
5690	1	158	0	Macastre	46
5691	1	158	6	Seca, La	47
5692	1	158	5	Piñero, El	49
5693	1	159	8	Navalonguilla	5
5694	1	159	1	Zahínos	6
5695	1	159	3	Parets del Vallès	8
5696	1	159	6	Hontanas	9
5697	1	159	0	Robledollano	10
5698	1	159	9	Pinarejo	16
5699	1	159	5	Sant Feliu de Buixalleu	17
5700	1	159	1	Píñar	18
5701	1	159	4	Ledanca	19
5702	1	159	1	Santa Marina del Rey	24
5703	1	159	9	Valdemaqueda	28
5704	1	159	3	Lumbier	31
5705	1	159	9	San Cebrián de Campos	34
5706	1	159	1	Herguijuela del Campo	37
5707	1	159	4	Pinarejos	40
5708	1	159	6	Rollamienta	42
5709	1	159	2	Vallfogona de Riucorb	43
5710	1	159	7	Moscardón	44
5711	1	159	0	Sartajada	45
5712	1	159	3	Manises	46
5713	1	159	9	Serrada	47
5714	1	159	8	Pobladura del Valle	49
5715	1	159	1	Maluenda	50
5716	1	160	2	Navalosa	5
5717	1	160	5	Zalamea de la Serena	6
5718	1	160	7	Perafita	8
5719	1	160	0	Hontangas	9
5720	1	160	4	Romangordo	10
5721	1	160	3	Pineda de Gigüela	16
5722	1	160	9	Sant Feliu de Guíxols	17
5723	1	160	8	Loranca de Tajuña	19
5724	1	160	4	Naval	22
5725	1	160	5	Santas Martas	24
5726	1	160	1	Uruñuela	26
5727	1	160	3	Valdemorillo	28
5728	1	160	7	Luquin	31
5729	1	160	3	San Cebrián de Mudá	34
5730	1	160	5	Hinojosa de Duero	37
5731	1	160	8	Pinarnegrillo	40
5732	1	160	0	Royo, El	42
5733	1	160	6	Vallmoll	43
5734	1	160	1	Mosqueruela	44
5735	1	160	4	Segurilla	45
5736	1	160	7	Manuel	46
5737	1	160	3	Siete Iglesias de Trabancos	47
5738	1	160	2	Pobladura de Valderaduey	49
5739	1	160	5	Mallén	50
5740	1	161	9	Navalperal de Pinares	5
5741	1	161	2	Zarza-Capilla	6
5742	1	161	4	Piera	8
5743	1	161	1	Ruanes	10
5744	1	161	0	Piqueras del Castillo	16
5745	1	161	6	Sant Feliu de Pallerols	17
5746	1	161	2	Polícar	18
5747	1	161	5	Lupiana	19
5748	1	161	2	Santiago Millas	24
5749	1	161	5	Conca de Dalt	25
5750	1	161	8	Valdemadera	26
5751	1	161	0	Valdemoro	28
5752	1	161	4	Mañeru	31
5753	1	161	0	San Cristóbal de Boedo	34
5754	1	161	2	Horcajo de Montemayor	37
5755	1	161	5	Pradales	40
5756	1	161	7	Salduero	42
5757	1	161	3	Valls	43
5758	1	161	8	Muniesa	44
5759	1	161	1	Seseña	45
5760	1	161	4	Marines	46
5761	1	161	0	Simancas	47
5762	1	161	2	Manchones	50
5763	1	162	4	Navalperal de Tormes	5
5764	1	162	7	Zarza, La	6
5765	1	162	9	Hostalets de Pierola, Els	8
5766	1	162	2	Hontoria de la Cantera	9
5767	1	162	6	Salorino	10
5768	1	162	5	Portalrubio de Guadamejud	16
5769	1	162	1	Sant Ferriol	17
5770	1	162	7	Polopos	18
5771	1	162	0	Luzaga	19
5772	1	162	6	Novales	22
5773	1	162	7	Santovenia de la Valdoncina	24
5774	1	162	3	Valgañón	26
5775	1	162	5	Valdeolmos-Alalpardo	28
5776	1	162	9	Marañón	31
5777	1	162	7	Horcajo Medianero	37
5778	1	162	0	Prádena	40
5779	1	162	2	San Esteban de Gormaz	42
5780	1	162	8	Vandellòs il Hospitalet del Infant	43
5781	1	162	6	Sevilleja de la Jara	45
5782	1	162	9	Massalavés	46
5783	1	162	5	Tamariz de Campos	47
5784	1	162	4	Porto	49
5785	1	162	7	Mara	50
5786	1	163	0	Navaluenga	5
5787	1	163	5	Pineda de Mar	8
5788	1	163	8	Hontoria del Pinar	9
5789	1	163	2	Salvatierra de Santiago	10
5790	1	163	1	Portilla	16
5791	1	163	7	Sant Gregori	17
5792	1	163	3	Pórtugos	18
5793	1	163	6	Luzón	19
5794	1	163	2	Nueno	22
5795	1	163	3	Sariegos	24
5796	1	163	6	Coma i la Pedra, La	25
5797	1	163	9	Ventosa	26
5798	1	163	1	Valdepiélagos	28
5799	1	163	5	Marcilla	31
5800	1	163	1	San Mamés de Campos	34
5801	1	163	3	Hoya, La	37
5802	1	163	6	Puebla de Pedraza	40
5803	1	163	8	San Felices	42
5804	1	163	4	Vendrell, El	43
5805	1	163	9	Noguera de Albarracín	44
5806	1	163	2	Sonseca	45
5807	1	163	5	Massalfassar	46
5808	1	163	1	Tiedra	47
5809	1	163	0	Pozoantiguo	49
5810	1	163	3	María de Huerva	50
5811	1	164	5	Navaquesera	5
5812	1	164	0	Pla del Penedès, El	8
5813	1	164	3	Hontoria de Valdearados	9
5814	1	164	7	San Martín de Trevejo	10
5815	1	164	2	Sant Hilari Sacalm	17
5816	1	164	8	Puebla de Don Fadrique	18
5817	1	164	7	Olvena	22
5818	1	164	8	Sena de Luna	24
5819	1	164	1	Penelles	25
5820	1	164	4	Ventrosa	26
5821	1	164	6	Valdetorres de Jarama	28
5822	1	164	0	Mélida	31
5823	1	164	8	Huerta	37
5824	1	164	1	Rapariegos	40
5825	1	164	3	San Leonardo de Yagüe	42
5826	1	164	9	Vespella de Gaià	43
5827	1	164	4	Nogueras	44
5828	1	164	7	Sotillo de las Palomas	45
5829	1	164	0	Massamagrell	46
5830	1	164	6	Tordehumos	47
5831	1	164	5	Pozuelo de Tábara	49
5832	1	164	8	Mediana de Aragón	50
5833	1	165	8	Navarredonda de Gredos	5
5834	1	165	3	Pobla de Claramunt, La	8
5835	1	165	0	Santa Ana	10
5836	1	165	9	Poyatos	16
5837	1	165	5	Sant Jaume de Llierca	17
5838	1	165	1	Pulianas	18
5839	1	165	4	Majaelrayo	19
5840	1	165	0	Ontiñena	22
5841	1	165	1	Sobrado	24
5842	1	165	4	Peramola	25
5843	1	165	7	Viguera	26
5844	1	165	9	Valdilecha	28
5845	1	165	3	Mendavia	31
5846	1	165	9	San Román de la Cuba	34
5847	1	165	1	Iruelos	37
5848	1	165	4	Rebollo	40
5849	1	165	6	San Pedro Manrique	42
5850	1	165	2	Vilabella	43
5851	1	165	7	Nogueruelas	44
5852	1	165	0	Talavera de la Reina	45
5853	1	165	3	Massanassa	46
5854	1	165	9	Tordesillas	47
5855	1	165	8	Prado	49
5856	1	165	1	Mequinenza	50
5857	1	166	1	Navarredondilla	5
5858	1	166	6	Pobla de Lillet, La	8
5859	1	166	9	Hormazas, Las	9
5860	1	166	3	Santa Cruz de la Sierra	10
5861	1	166	2	Pozoamargo	16
5862	1	166	8	Sant Jordi Desvalls	17
5863	1	166	7	Málaga del Fresno	19
5864	1	166	4	Soto de la Vega	24
5865	1	166	7	Pinell de Solsonès	25
5866	1	166	0	Villalba de Rioja	26
5867	1	166	2	Valverde de Alcalá	28
5868	1	166	6	Mendaza	31
5869	1	166	4	Ituero de Azaba	37
5870	1	166	7	Remondo	40
5871	1	166	9	Santa Cruz de Yanguas	42
5872	1	166	5	Vilallonga del Camp	43
5873	1	166	3	Tembleque	45
5874	1	166	6	Meliana	46
5875	1	166	2	Torrecilla de la Abadesa	47
5876	1	166	1	Puebla de Sanabria	49
5877	1	166	4	Mesones de Isuela	50
5878	1	167	7	Navarrevisca	5
5879	1	167	2	Polinyà	8
5880	1	167	5	Hornillos del Camino	9
5881	1	167	9	Santa Cruz de Paniagua	10
5882	1	167	8	Pozorrubio	16
5883	1	167	4	Sant Joan de les Abadesses	17
5884	1	167	0	Purullena	18
5885	1	167	3	Malaguilla	19
5886	1	167	9	Osso de Cinca	22
5887	1	167	0	Soto y Amío	24
5888	1	167	3	Pinós	25
5889	1	167	6	Villalobar de Rioja	26
5890	1	167	8	Velilla de San Antonio	28
5891	1	167	2	Mendigorría	31
5892	1	167	8	Santa Cecilia del Alcor	34
5893	1	167	0	Juzbado	37
5894	1	167	5	Santa María de Huerta	42
5895	1	167	1	Vilanova Escornalbou	43
5896	1	167	6	Obón	44
5897	1	167	9	Toboso, El	45
5898	1	167	2	Millares	46
5899	1	167	8	Torrecilla de la Orden	47
5900	1	167	7	Pueblica de Valverde	49
5901	1	167	0	Mezalocha	50
5902	1	168	3	Navas del Marqués, Las	5
5903	1	168	8	Pontons	8
5904	1	168	1	Horra, La	9
5905	1	168	5	Santa Marta de Magasca	10
5906	1	168	0	Sant Joan de Mollet	17
5907	1	168	6	Quéntar	18
5908	1	168	9	Mandayona	19
5909	1	168	5	Palo	22
5910	1	168	6	Toral de los Guzmanes	24
5911	1	168	9	Poal, El	25
5912	1	168	2	Villamediana de Iregua	26
5913	1	168	4	Vellón, El	28
5914	1	168	8	Metauten	31
5915	1	168	4	Santa Cruz de Boedo	34
5916	1	168	6	Lagunilla	37
5917	1	168	9	Riaguas de San Bartolomé	40
5918	1	168	1	Santa María de las Hoyas	42
5919	1	168	7	Vilanova de Prades	43
5920	1	168	2	Odón	44
5921	1	168	5	Toledo	45
5922	1	168	8	Miramar	46
5923	1	168	4	Torrecilla de la Torre	47
5924	1	168	3	Quintanilla del Monte	49
5925	1	168	6	Mianos	50
5926	1	169	6	Navatalgordo	5
5927	1	169	1	Prat de Llobregat, El	8
5928	1	169	4	Hortigüela	9
5929	1	169	8	Santiago de Alcántara	10
5930	1	169	7	Pozuelo, El	16
5931	1	169	3	Sant Julià de Ramis	17
5932	1	169	2	Mantiel	19
5933	1	169	9	Toreno	24
5934	1	169	2	Pobla de Cérvoles, La	25
5935	1	169	5	Villanueva de Cameros	26
5936	1	169	7	Venturada	28
5937	1	169	1	Milagro	31
5938	1	169	7	Santervás de la Vega	34
5939	1	169	9	Larrodrigo	37
5940	1	169	0	Vilaplana	43
5941	1	169	5	Ojos Negros	44
5942	1	169	8	Torralba de Oropesa	45
5943	1	169	1	Mislata	46
5944	1	169	7	Torre de Esgueva	47
5945	1	169	6	Quintanilla del Olmo	49
5946	1	169	9	Miedes de Aragón	50
5947	1	170	0	Navatejares	5
5948	1	170	5	Prats de Rei, Els	8
5949	1	170	8	Hoyales de Roa	9
5950	1	170	2	Santiago del Campo	10
5951	1	170	1	Priego	16
5952	1	170	7	Vallfogona de Ripollès	17
5953	1	170	3	Rubite	18
5954	1	170	6	Maranchón	19
5955	1	170	2	Panticosa	22
5956	1	170	3	Torre del Bierzo	24
5957	1	170	6	Bellaguarda	25
5958	1	170	9	Villar de Arnedo, El	26
5959	1	170	1	Villaconejos	28
5960	1	170	5	Mirafuentes	31
5961	1	170	1	Santibáñez de Ecla	34
5962	1	170	3	Ledesma	37
5963	1	170	6	Riaza	40
5964	1	170	4	Vila-rodona	43
5965	1	170	2	Torrecilla de la Jara	45
5966	1	170	5	Mogente/Moixent	46
5967	1	170	1	Torre de Peñafiel	47
5968	1	170	0	Quintanilla de Urz	49
5969	1	170	3	Monegrillo	50
5970	1	171	7	Neila de San Miguel	5
5971	1	171	2	Prats de Lluçanès	8
5972	1	171	9	Santibáñez el Alto	10
5973	1	171	8	Provencio, El	16
5974	1	171	4	Sant Llorenç de la Muga	17
5975	1	171	0	Salar	18
5976	1	171	3	Marchamalo	19
5977	1	171	0	Trabadelo	24
5978	1	171	3	Pobla de Segur, La	25
5979	1	171	6	Villar de Torre	26
5980	1	171	8	Villa del Prado	28
5981	1	171	2	Miranda de Arga	31
5982	1	171	8	Santibáñez de la Peña	34
5983	1	171	0	Ledrada	37
5984	1	171	3	Ribota	40
5985	1	171	5	Serón de Nágima	42
5986	1	171	1	Vila-seca	43
5987	1	171	6	Olba	44
5988	1	171	9	Torre de Esteban Hambrán, La	45
5989	1	171	2	Moncada	46
5990	1	171	8	Torrelobatón	47
5991	1	171	7	Quiruelas de Vidriales	49
5992	1	171	0	Moneva	50
5993	1	172	2	Niharra	5
5994	1	172	7	Premià de Mar	8
5995	1	172	0	Huérmeces	9
5996	1	172	4	Santibáñez el Bajo	10
5997	1	172	3	Puebla de Almenara	16
5998	1	172	9	Sant Martí de Llémena	17
5999	1	172	8	Masegoso de Tajuña	19
6000	1	172	4	Peñalba	22
6001	1	172	5	Truchas	24
6002	1	172	8	Ponts	25
6003	1	172	1	Villarejo	26
6004	1	172	3	Villalbilla	28
6005	1	172	7	Monreal/Elo	31
6006	1	172	5	Linares de Riofrío	37
6007	1	172	8	Riofrío de Riaza	40
6008	1	172	0	Soliedra	42
6009	1	172	6	Vilaverd	43
6010	1	172	1	Oliete	44
6011	1	172	4	Torrico	45
6012	1	172	7	Montserrat	46
6013	1	172	3	Torrescárcela	47
6014	1	172	2	Rabanales	49
6015	1	172	5	Monreal de Ariza	50
6016	1	173	8	Ojos-Albos	5
6017	1	173	6	Huerta de Arriba	9
6018	1	173	0	Saucedilla	10
6019	1	173	9	Valle de Altomira, El	16
6020	1	173	5	Sant Martí Vell	17
6021	1	173	1	Salobreña	18
6022	1	173	4	Matarrubia	19
6023	1	173	0	Peñas de Riglos, Las	22
6024	1	173	1	Turcia	24
6025	1	173	4	Pont de Suert, El	25
6026	1	173	7	Villarroya	26
6027	1	173	9	Villamanrique de Tajo	28
6028	1	173	3	Monteagudo	31
6029	1	173	1	Lumbrales	37
6030	1	173	4	Roda de Eresma	40
6031	1	173	6	Soria	42
6032	1	173	2	Vilella Alta, La	43
6033	1	173	7	Olmos, Los	44
6034	1	173	0	Torrijos	45
6035	1	173	3	Montaverner	46
6036	1	173	9	Traspinedo	47
6037	1	173	8	Rábano de Aliste	49
6038	1	173	1	Monterde	50
6039	1	174	3	Orbita	5
6040	1	174	8	Puigdàlber	8
6041	1	174	1	Huerta de Rey	9
6042	1	174	5	Segura de Toro	10
6043	1	174	4	Puebla del Salvador	16
6044	1	174	0	Sant Miquel de Campmajor	17
6045	1	174	6	Santa Cruz del Comercio	18
6046	1	174	9	Matillas	19
6047	1	174	5	Peralta de Alcofea	22
6048	1	174	6	Urdiales del Páramo	24
6049	1	174	9	Portella, La	25
6050	1	174	2	Villarta-Quintana	26
6051	1	174	4	Villamanta	28
6052	1	174	8	Morentin	31
6053	1	174	4	Santoyo	34
6054	1	174	6	Macotera	37
6055	1	174	9	Sacramenia	40
6056	1	174	1	Sotillo del Rincón	42
6057	1	174	7	Vilella Baixa, La	43
6058	1	174	2	Orihuela del Tremedal	44
6059	1	174	5	Totanés	45
6060	1	174	8	Montesa	46
6061	1	174	4	Trigueros del Valle	47
6062	1	174	3	Requejo	49
6063	1	174	6	Montón	50
6064	1	175	6	Oso, El	5
6065	1	175	1	Puig-reig	8
6066	1	175	4	Humada	9
6067	1	175	8	Serradilla	10
6068	1	175	7	Quintanar del Rey	16
6069	1	175	3	Sant Miquel de Fluvià	17
6070	1	175	9	Santa Fe	18
6071	1	175	2	Mazarete	19
6072	1	175	8	Peralta de Calasanz	22
6073	1	175	9	Valdefresno	24
6074	1	175	2	Prats i Sansor	25
6075	1	175	5	Villavelayo	26
6076	1	175	7	Villamantilla	28
6077	1	175	1	Mues	31
6078	1	175	7	Serna, La	34
6079	1	175	9	Machacón	37
6080	1	175	4	Suellacabras	42
6081	1	175	0	Vilalba dels Arcs	43
6082	1	175	5	Orrios	44
6083	1	175	8	Turleque	45
6084	1	175	1	Montitxelvo/Montichelvo	46
6085	1	175	7	Tudela de Duero	47
6086	1	175	6	Revellinos	49
6087	1	175	9	Morata de Jalón	50
6088	1	176	9	Padiernos	5
6089	1	176	4	Pujalt	8
6090	1	176	7	Hurones	9
6091	1	176	1	Serrejón	10
6092	1	176	0	Rada de Haro	16
6093	1	176	6	Sant Mori	17
6094	1	176	2	Soportújar	18
6095	1	176	5	Mazuecos	19
6096	1	176	1	Peraltilla	22
6097	1	176	2	Valdefuentes del Páramo	24
6098	1	176	5	Preixana	25
6099	1	176	8	Villaverde de Rioja	26
6100	1	176	0	Villanueva de la Cañada	28
6101	1	176	4	Murchante	31
6102	1	176	0	Sotobañado y Priorato	34
6103	1	176	2	Madroñal	37
6104	1	176	5	Samboal	40
6105	1	176	7	Tajahuerce	42
6106	1	176	3	Vimbodí i Poblet	43
6107	1	176	8	Palomar de Arroyos	44
6108	1	176	1	Ugena	45
6109	1	176	4	Montroy	46
6110	1	176	0	Unión de Campos, La	47
6111	1	176	9	Riofrío de Aliste	49
6112	1	176	2	Morata de Jiloca	50
6113	1	177	5	Pajares de Adaja	5
6114	1	177	0	Quar, La	8
6115	1	177	3	Ibeas de Juarros	9
6116	1	177	7	Sierra de Fuentes	10
6117	1	177	6	Reíllo	16
6118	1	177	2	Sant Pau de Segúries	17
6119	1	177	8	Sorvilán	18
6120	1	177	1	Medranda	19
6121	1	177	7	Perarrúa	22
6122	1	177	8	Valdelugueros	24
6123	1	177	1	Preixens	25
6124	1	177	4	Villoslada de Cameros	26
6125	1	177	6	Villanueva del Pardillo	28
6126	1	177	0	Murieta	31
6127	1	177	6	Soto de Cerrato	34
6128	1	177	8	Maíllo, El	37
6129	1	177	1	San Cristóbal de Cuéllar	40
6130	1	177	3	Tajueco	42
6131	1	177	9	Vinebre	43
6132	1	177	4	Pancrudo	44
6133	1	177	7	Urda	45
6134	1	177	0	Museros	46
6135	1	177	6	Urones de Castroponce	47
6136	1	177	5	Rionegro del Puente	49
6137	1	177	8	Morés	50
6138	1	178	1	Palacios de Goda	5
6139	1	178	6	Rajadell	8
6140	1	178	9	Ibrillos	9
6141	1	178	3	Talaván	10
6142	1	178	8	Sant Pere Pescador	17
6143	1	178	4	Torre-Cardela	18
6144	1	178	7	Megina	19
6145	1	178	3	Pertusa	22
6146	1	178	4	Valdemora	24
6147	1	178	0	Viniegra de Abajo	26
6148	1	178	2	Villanueva de Perales	28
6149	1	178	6	Murillo el Cuende	31
6150	1	178	2	Tabanera de Cerrato	34
6151	1	178	4	Malpartida	37
6152	1	178	7	San Cristóbal de la Vega	40
6153	1	178	9	Talveila	42
6154	1	178	5	Vinyols i els Arcs	43
6155	1	178	0	Parras de Castellote, Las	44
6156	1	178	6	Náquera	46
6157	1	178	2	Urueña	47
6158	1	178	1	Roales	49
6159	1	178	4	Moros	50
6160	1	179	4	Papatrigo	5
6161	1	179	9	Rellinars	8
6162	1	179	2	Iglesiarrubia	9
6163	1	179	6	Talaveruela de la Vera	10
6164	1	179	7	Torvizcón	18
6165	1	179	0	Membrillera	19
6166	1	179	7	Valdepiélago	24
6167	1	179	0	Prullans	25
6168	1	179	3	Viniegra de Arriba	26
6169	1	179	5	Villar del Olmo	28
6170	1	179	9	Murillo el Fruto	31
6171	1	179	5	Tabanera de Valdavia	34
6172	1	179	7	Mancera de Abajo	37
6173	1	179	0	Sanchonuño	40
6174	1	179	3	Peñarroya de Tastavins	44
6175	1	179	6	Valdeverdeja	45
6176	1	179	9	Navarrés	46
6177	1	179	5	Valbuena de Duero	47
6178	1	179	4	Robleda-Cervantes	49
6179	1	179	7	Moyuela	50
6180	1	180	8	Parral, El	5
6181	1	180	3	Ripollet	8
6182	1	180	6	Iglesias	9
6183	1	180	0	Talayuela	10
6184	1	180	5	Santa Coloma de Farners	17
6185	1	180	1	Trevélez	18
6186	1	180	1	Valdepolo	24
6187	1	180	4	Puiggròs	25
6188	1	180	7	Zarratón	26
6189	1	180	9	Villarejo de Salvanés	28
6190	1	180	3	Muruzábal	31
6191	1	180	9	Támara de Campos	34
6192	1	180	1	Manzano, El	37
6193	1	180	4	Sangarcía	40
6194	1	180	7	Peracense	44
6195	1	180	0	Valmojado	45
6196	1	180	3	Novelé/Novetlè	46
6197	1	180	9	Valdearcos de la Vega	47
6198	1	180	8	Roelos de Sayago	49
6199	1	180	1	Mozota	50
6200	1	181	5	Pascualcobo	5
6201	1	181	0	Roca del Vallès, La	8
6202	1	181	3	Isar	9
6203	1	181	7	Tejeda de Tiétar	10
6204	1	181	6	Rozalén del Monte	16
6205	1	181	2	Santa Cristina Aro	17
6206	1	181	8	Turón	18
6207	1	181	1	Miedes de Atienza	19
6208	1	181	7	Piracés	22
6209	1	181	8	Valderas	24
6210	1	181	1	Puigverd Agramunt	25
6211	1	181	4	Zarzosa	26
6212	1	181	6	Villaviciosa de Odón	28
6213	1	181	0	Navascués/Nabaskoze	31
6214	1	181	6	Tariego de Cerrato	34
6215	1	181	8	Martiago	37
6216	1	181	1	Real Sitio de San Ildefonso	40
6217	1	181	3	Tardelcuende	42
6218	1	181	4	Peralejos	44
6219	1	181	7	Velada	45
6220	1	181	0	Oliva	46
6221	1	181	6	Valdenebro de los Valles	47
6222	1	181	5	Rosinos de la Requejada	49
6223	1	181	8	Muel	50
6224	1	182	0	Pedro Bernardo	5
6225	1	182	5	Pont de Vilomara i Rocafort, El	8
6226	1	182	8	Itero del Castillo	9
6227	1	182	2	Toril	10
6228	1	182	7	Santa Llogaia Àlguema	17
6229	1	182	3	Ugíjar	18
6230	1	182	6	Mierla, La	19
6231	1	182	2	Plan	22
6232	1	182	3	Valderrey	24
6233	1	182	6	Puigverd de Lleida	25
6234	1	182	1	Villavieja del Lozoya	28
6235	1	182	5	Nazar	31
6236	1	182	1	Torquemada	34
6237	1	182	3	Martinamor	37
6238	1	182	6	San Martín y Mudrián	40
6239	1	182	8	Taroda	42
6240	1	182	9	Perales del Alfambra	44
6241	1	182	2	Ventas con Peña Aguilera, Las	45
6242	1	182	5	Olocau	46
6243	1	182	1	Valdestillas	47
6244	1	182	3	Muela, La	50
6245	1	183	6	Pedro-Rodríguez	5
6246	1	183	1	Roda de Ter	8
6247	1	183	4	Jaramillo de la Fuente	9
6248	1	183	8	Tornavacas	10
6249	1	183	3	Sant Aniol de Finestres	17
6250	1	183	9	Válor	18
6251	1	183	2	Milmarcos	19
6252	1	183	9	Valderrueda	24
6253	1	183	2	Rialp	25
6254	1	183	5	Zorraquín	26
6255	1	183	7	Zarzalejo	28
6256	1	183	1	Obanos	31
6257	1	183	9	Martín de Yeltes	37
6258	1	183	2	San Miguel de Bernuy	40
6259	1	183	4	Tejado	42
6260	1	183	5	Pitarque	44
6261	1	183	8	Ventas de Retamosa, Las	45
6262	1	183	1	Olleria, 	46
6263	1	183	7	Valdunquillo	47
6264	1	183	6	Salce	49
6265	1	183	9	Munébrega	50
6266	1	184	1	Peguerinos	5
6267	1	184	6	Rubí	8
6268	1	184	9	Jaramillo Quemado	9
6269	1	184	3	Torno, El	10
6270	1	184	8	Santa Pau	17
6271	1	184	4	Vélez de Benaudalla	18
6272	1	184	7	Millana	19
6273	1	184	3	Poleñino	22
6274	1	184	4	Valdesamario	24
6275	1	184	6	Oco	31
6276	1	184	2	Torremormojón	34
6277	1	184	4	Masueco	37
6278	1	184	7	San Pedro de Gaíllos	40
6279	1	184	9	Torlengua	42
6280	1	184	0	Plou	44
6281	1	184	3	Ventas de San Julián, Las	45
6282	1	184	6	Ontinyent	46
6283	1	184	2	Valoria la Buena	47
6284	1	184	1	Samir de los Caños	49
6285	1	184	4	Murero	50
6286	1	185	4	Peñalba de Ávila	5
6287	1	185	9	Rubió	8
6288	1	185	6	Torrecilla de los Ángeles	10
6289	1	185	5	Saceda-Trasierra	16
6290	1	185	1	Sant Joan les Fonts	17
6291	1	185	7	Ventas de Huelma	18
6292	1	185	0	Miñosa, La	19
6293	1	185	7	Val de San Lorenzo	24
6294	1	185	0	Ribera Urgellet	25
6295	1	185	9	Ochagavía/Otsagabia	31
6296	1	185	5	Triollo	34
6297	1	185	7	Castellanos de Villiquera	37
6298	1	185	0	Santa María la Real de Nieva	40
6299	1	185	2	Torreblacos	42
6300	1	185	3	Pobo, El	44
6301	1	185	6	Villacañas	45
6302	1	185	9	Otos	46
6303	1	185	5	Valverde de Campos	47
6304	1	185	4	San Agustín del Pozo	49
6305	1	185	7	Murillo de Gállego	50
6306	1	186	7	Piedrahíta	5
6307	1	186	9	Torrecillas de la Tiesa	10
6308	1	186	8	Saelices	16
6309	1	186	4	Sarrià de Ter	17
6310	1	186	3	Mirabueno	19
6311	1	186	9	Pozán de Vero	22
6312	1	186	3	Riner	25
6313	1	186	2	Odieta	31
6314	1	186	8	Valbuena de Pisuerga	34
6315	1	186	0	Mata de Ledesma, La	37
6316	1	186	3	Santa Marta del Cerro	40
6317	1	186	9	Villa de Don Fadrique, La	45
6318	1	186	2	Paiporta	46
6319	1	186	8	Valladolid	47
6320	1	186	7	San Cebrián de Castro	49
6321	1	186	0	Navardún	50
6322	1	187	3	Piedralaves	5
6323	1	187	8	Sabadell	8
6324	1	187	5	Torre de Don Miguel	10
6325	1	187	4	Salinas del Manzano	16
6326	1	187	0	Saus,  Camallera i Llampaies	17
6327	1	187	6	Villanueva de las Torres	18
6328	1	187	9	Miralrío	19
6329	1	187	5	Puebla de Castro, La	22
6330	1	187	6	Valdevimbre	24
6331	1	187	8	Oitz	31
6332	1	187	6	Matilla de los Caños del Río	37
6333	1	187	1	Torrubia de Soria	42
6334	1	187	2	Portellada, La	44
6335	1	187	5	Villafranca de los Caballeros	45
6336	1	187	8	Palma de Gandía	46
6337	1	187	4	Vega de Ruiponce	47
6338	1	187	3	San Cristóbal de Entreviñas	49
6339	1	187	6	Nigüella	50
6340	1	188	9	Poveda	5
6341	1	188	4	Sagàs	8
6342	1	188	1	Torre de Santa María	10
6343	1	188	0	Salmeroncillos	16
6344	1	188	6	Selva de Mar, La	17
6345	1	188	2	Villanueva Mesía	18
6346	1	188	5	Mochales	19
6347	1	188	1	Puente de Montañana	22
6348	1	188	2	Valencia de Don Juan	24
6349	1	188	4	Olaibar	31
6350	1	188	2	Maya, La	37
6351	1	188	5	Santiuste de Pedraza	40
6352	1	188	7	Trévago	42
6353	1	188	1	Villaluenga de la Sagra	45
6354	1	188	4	Palmera	46
6355	1	188	0	Vega de Valdetronco	47
6356	1	188	9	San Esteban del Molar	49
6357	1	188	2	Nombrevilla	50
6358	1	189	2	Poyales del Hoyo	5
6359	1	189	7	Sant Pere Sallavinera	8
6360	1	189	0	Junta de Traslaloma	9
6361	1	189	4	Torrejoncillo	10
6362	1	189	3	Salvacañete	16
6363	1	189	9	Cellera de Ter, La	17
6364	1	189	5	Víznar	18
6365	1	189	8	Mohernando	19
6366	1	189	4	Puértolas	22
6367	1	189	5	Valverde de la Virgen	24
6368	1	189	8	Rosselló	25
6369	1	189	7	Olazti/Olazagutía	31
6370	1	189	3	Valdeolmillos	34
6371	1	189	5	Membribe de la Sierra	37
6372	1	189	8	Santiuste de San Juan Bautista	40
6373	1	189	0	Ucero	42
6374	1	189	1	Pozondón	44
6375	1	189	4	Villamiel de Toledo	45
6376	1	189	7	Palomar, el	46
6377	1	189	3	Velascálvaro	47
6378	1	189	2	San Justo	49
6379	1	189	5	Nonaspe	50
6380	1	190	6	Pozanco	5
6381	1	190	1	Saldes	8
6382	1	190	4	Junta de Villalba de Losa	9
6383	1	190	8	Torrejón el Rubio	10
6384	1	190	7	San Clemente	16
6385	1	190	3	Serinyà	17
6386	1	190	2	Molina de Aragón	19
6387	1	190	8	Pueyo de Araguás, El	22
6388	1	190	9	Valverde-Enrique	24
6389	1	190	2	Salàs de Pallars	25
6390	1	190	1	Olejua	31
6391	1	190	7	Valderrábano	34
6392	1	190	9	Mieza	37
6393	1	190	2	Santo Domingo de Pirón	40
6394	1	190	4	Vadillo	42
6395	1	190	5	Pozuel del Campo	44
6396	1	190	8	Villaminaya	45
6397	1	190	1	Paterna	46
6398	1	190	7	Velilla	47
6399	1	190	6	San Martín de Valderaduey	49
6400	1	190	9	Novallas	50
6401	1	191	3	Pradosegar	5
6402	1	191	8	Sallent	8
6403	1	191	1	Jurisdicción de Lara	9
6404	1	191	5	Torremenga	10
6405	1	191	4	San Lorenzo de la Parrilla	16
6406	1	191	0	Serra de Daró	17
6407	1	191	9	Monasterio	19
6408	1	191	6	Vallecillo	24
6409	1	191	9	Sanaüja	25
6410	1	191	8	Olite/Erriberri	31
6411	1	191	6	Milano, El	37
6412	1	191	9	Santo Tomé del Puerto	40
6413	1	191	1	Valdeavellano de Tera	42
6414	1	191	2	Puebla de Híjar, La	44
6415	1	191	5	Villamuelas	45
6416	1	191	8	Pedralba	46
6417	1	191	4	Velliza	47
6418	1	191	3	San Miguel de la Ribera	49
6419	1	191	6	Novillas	50
6420	1	192	8	Puerto Castilla	5
6421	1	192	3	Santpedor	8
6422	1	192	6	Jurisdicción de San Zadornil	9
6423	1	192	0	Torremocha	10
6424	1	192	9	San Martín de Boniches	16
6425	1	192	5	Setcases	17
6426	1	192	1	Zafarraya	18
6427	1	192	4	Mondéjar	19
6428	1	192	4	Sant Guim de Freixenet	25
6429	1	192	3	Olóriz/Oloritz	31
6430	1	192	9	Valde-Ucieza	34
6431	1	192	1	Miranda de Azán	37
6432	1	192	4	Sauquillo de Cabezas	40
6433	1	192	6	Valdegeña	42
6434	1	192	7	Puebla de Valverde, La	44
6435	1	192	0	Villanueva de Alcardete	45
6436	1	192	3	Petrés	46
6437	1	192	9	Ventosa de la Cuesta	47
6438	1	192	8	San Miguel del Valle	49
6439	1	192	1	Nuévalos	50
6440	1	193	4	Rasueros	5
6441	1	193	9	Sant Iscle de Vallalta	8
6442	1	193	6	Torreorgaz	10
6443	1	193	5	San Pedro Palmiches	16
6444	1	193	1	Sils	17
6445	1	193	7	Zubia, La	18
6446	1	193	0	Montarrón	19
6447	1	193	6	Pueyo de Santa Cruz	22
6448	1	193	7	Vecilla, La	24
6449	1	193	0	Sant Llorenç de Morunys	25
6450	1	193	9	Cendea de Olza/Oltza Zendea	31
6451	1	193	7	Miranda del Castañar	37
6452	1	193	0	Sebúlcor	40
6453	1	193	2	Valdelagua del Cerro	42
6454	1	193	3	Puertomingalvo	44
6455	1	193	6	Villanueva de Bogas	45
6456	1	193	9	Picanya	46
6457	1	193	5	Viana de Cega	47
6458	1	193	4	San Pedro de Ceque	49
6459	1	193	7	Nuez de Ebro	50
6460	1	194	9	Riocabado	5
6461	1	194	4	Sant Adrià de Besòs	8
6462	1	194	7	Lerma	9
6463	1	194	1	Torrequemada	10
6464	1	194	0	Santa Cruz de Moya	16
6465	1	194	6	Susqueda	17
6466	1	194	2	Zújar	18
6467	1	194	5	Moratilla de los Meleros	19
6468	1	194	2	Vegacervera	24
6469	1	194	5	Sant Ramon	25
6470	1	194	4	Ollo	31
6471	1	194	2	Mogarraz	37
6472	1	194	5	Segovia	40
6473	1	194	7	Valdemaluque	42
6474	1	194	8	Ráfales	44
6475	1	194	1	Villarejo de Montalbán	45
6476	1	194	4	Picassent	46
6477	1	194	0	Viloria	47
6478	1	194	9	San Pedro de la Nave-Almendra	49
6479	1	194	2	Olvés	50
6480	1	195	2	Riofrío	5
6481	1	195	7	Sant Agustí de Lluçanès	8
6482	1	195	0	Llano de Bureba	9
6483	1	195	4	Trujillo	10
6484	1	195	3	Santa María del Campo Rus	16
6485	1	195	9	Tallada Empordà, La	17
6486	1	195	8	Morenilla	19
6487	1	195	4	Quicena	22
6488	1	195	7	Orbaizeta	31
6489	1	195	5	Molinillo	37
6490	1	195	8	Sepúlveda	40
6491	1	195	0	Valdenebro	42
6492	1	195	1	Rillo	44
6493	1	195	4	Villarrubia de Santiago	45
6494	1	195	7	Piles	46
6495	1	195	3	Villabáñez	47
6496	1	195	5	Orcajo	50
6497	1	196	5	Rivilla de Barajas	5
6498	1	196	0	Sant Andreu de la Barca	8
6499	1	196	3	Madrigal del Monte	9
6500	1	196	7	Valdastillas	10
6501	1	196	6	Santa María de los Llanos	16
6502	1	196	2	Terrades	17
6503	1	196	1	Muduex	19
6504	1	196	8	Vega de Espinareda	24
6505	1	196	1	Sant Esteve de la Sarga	25
6506	1	196	0	Orbara	31
6507	1	196	6	Valle de Cerrato	34
6508	1	196	8	Monforte de la Sierra	37
6509	1	196	1	Sequera de Fresno	40
6510	1	196	3	Valdeprado	42
6511	1	196	4	Riodeva	44
6512	1	196	7	Villaseca de la Sagra	45
6513	1	196	0	Pinet	46
6514	1	196	6	Villabaruz de Campos	47
6515	1	196	8	Orera	50
6516	1	197	1	Salobral	5
6517	1	197	6	Sant Andreu de Llavaneres	8
6518	1	197	9	Madrigalejo del Monte	9
6519	1	197	3	Valdecañas de Tajo	10
6520	1	197	2	Santa María del Val	16
6521	1	197	8	Torrent	17
6522	1	197	7	Navas de Jadraque, Las	19
6523	1	197	3	Robres	22
6524	1	197	4	Vega de Infanzones	24
6525	1	197	7	Sant Guim de la Plana	25
6526	1	197	6	Orísoain	31
6527	1	197	4	Monleón	37
6528	1	197	9	Valderrodilla	42
6529	1	197	0	Ródenas	44
6530	1	197	3	Villasequilla	45
6531	1	197	6	Polinyà de Xúquer	46
6532	1	197	2	Villabrágima	47
6533	1	197	1	Santa Clara de Avedillo	49
6534	1	197	4	Orés	50
6535	1	198	7	Salvadiós	5
6536	1	198	2	Sant Antoni de Vilamajor	8
6537	1	198	5	Mahamud	9
6538	1	198	9	Valdefuentes	10
6539	1	198	8	Sisante	16
6540	1	198	4	Torroella de Fluvià	17
6541	1	198	3	Negredo	19
6542	1	198	0	Vega de Valcarce	24
6543	1	198	2	Oronz/Orontze	31
6544	1	198	0	Monleras	37
6545	1	198	3	Sotillo	40
6546	1	198	5	Valtajeros	42
6547	1	198	6	Royuela	44
6548	1	198	9	Villatobas	45
6549	1	198	2	Potríes	46
6550	1	198	8	Villacarralón	47
6551	1	198	0	Oseja	50
6552	1	199	0	San Bartolomé de Béjar	5
6553	1	199	5	Sant Bartomeu del Grau	8
6554	1	199	8	Mambrilla de Castrejón	9
6555	1	199	2	Valdehúncar	10
6556	1	199	1	Solera de Gabaldón	16
6557	1	199	7	Torroella de Montgrí	17
6558	1	199	6	Ocentejo	19
6559	1	199	2	Sabiñánigo	22
6560	1	199	3	Vegaquemada	24
6561	1	199	5	Oroz-Betelu/Orotz-Betelu	31
6562	1	199	1	Velilla del Río Carrión	34
6563	1	199	3	Monsagro	37
6564	1	199	6	Sotosalbos	40
6565	1	199	9	Rubiales	44
6566	1	199	2	Viso de San Juan, El	45
6567	1	199	5	Pobla de Farnals, la	46
6568	1	199	1	Villacid de Campos	47
6569	1	199	0	Santa Colomba de las Monjas	49
6570	1	199	3	Osera de Ebro	50
6571	1	200	4	San Bartolomé de Corneja	5
6572	1	200	9	Sant Boi de Llobregat	8
6573	1	200	2	Mambrillas de Lara	9
6574	1	200	6	Valdelacasa de Tajo	10
6575	1	200	1	Tortellà	17
6576	1	200	0	Olivar, El	19
6577	1	200	6	Sahún	22
6578	1	200	0	Sarroca de Lleida	25
6579	1	200	9	Oteiza	31
6580	1	200	7	Montejo	37
6581	1	200	0	Tabanera la Luenga	40
6582	1	200	2	Velamazán	42
6583	1	200	3	Rubielos de la Cérida	44
6584	1	200	6	Yébenes, Los	45
6585	1	200	9	Pobla del Duc, la	46
6586	1	200	5	Villaco	47
6587	1	200	4	Santa Cristina de la Polvorosa	49
6588	1	200	7	Paniza	50
6589	1	201	1	San Bartolomé de Pinares	5
6590	1	201	6	Sant Boi de Lluçanès	8
6591	1	201	9	Mamolar	9
6592	1	201	3	Valdemorales	10
6593	1	201	8	Toses	17
6594	1	201	7	Olmeda de Cobeta	19
6595	1	201	3	Salas Altas	22
6596	1	201	4	Vegas del Condado	24
6597	1	201	7	Sarroca de Bellera	25
6598	1	201	6	Pamplona/Iruña	31
6599	1	201	2	Vertavillo	34
6600	1	201	4	Montemayor del Río	37
6601	1	201	7	Tolocirio	40
6602	1	201	9	Velilla de la Sierra	42
6603	1	201	0	Rubielos de Mora	44
6604	1	201	3	Yeles	45
6605	1	201	6	Puebla de San Miguel	46
6606	1	201	1	Santa Croya de Tera	49
6607	1	201	4	Paracuellos de Jiloca	50
6608	1	202	1	Sant Celoni	8
6609	1	202	4	Manciles	9
6610	1	202	8	Valdeobispo	10
6611	1	202	7	Talayuelas	16
6612	1	202	3	Tossa de Mar	17
6613	1	202	2	Olmeda de Jadraque, La	19
6614	1	202	8	Salas Bajas	22
6615	1	202	9	Villablino	24
6616	1	202	2	Senterada	25
6617	1	202	1	Peralta/Azkoien	31
6618	1	202	7	Villabasta de Valdavia	34
6619	1	202	9	Monterrubio de Armuña	37
6620	1	202	2	Torreadrada	40
6621	1	202	4	Velilla de los Ajos	42
6622	1	202	8	Yepes	45
6623	1	202	1	Pobla de Vallbona, la	46
6624	1	202	6	Santa Eufemia del Barco	49
6625	1	202	9	Paracuellos de la Ribera	50
6626	1	203	7	Sant Cebrià de Vallalta	8
6627	1	203	4	Valencia de Alcántara	10
6628	1	203	3	Tarancón	16
6629	1	203	9	Ultramort	17
6630	1	203	8	Ordial, El	19
6631	1	203	4	Salillas	22
6632	1	203	5	Villabraz	24
6633	1	203	8	Seu Urgell, La	25
6634	1	203	7	Petilla de Aragón	31
6635	1	203	5	Monterrubio de la Sierra	37
6636	1	203	8	Torrecaballeros	40
6637	1	203	1	Salcedillo	44
6638	1	203	4	Yuncler	45
6639	1	203	7	Pobla Llarga, la	46
6640	1	203	3	Villafrades de Campos	47
6641	1	203	2	Santa María de la Vega	49
6642	1	203	5	Pastriz	50
6643	1	204	7	Sanchidrián	5
6644	1	204	2	Sant Climent de Llobregat	8
6645	1	204	9	Valverde de la Vera	10
6646	1	204	8	Tébar	16
6647	1	204	4	Ullà	17
6648	1	204	3	Orea	19
6649	1	204	9	Sallent de Gállego	22
6650	1	204	3	Seròs	25
6651	1	204	2	Piedramillera	31
6652	1	204	8	Villacidaler	34
6653	1	204	0	Morasverdes	37
6654	1	204	3	Torrecilla del Pinar	40
6655	1	204	5	Viana de Duero	42
6656	1	204	6	Saldón	44
6657	1	204	9	Yunclillos	45
6658	1	204	2	Puig	46
6659	1	204	8	Villafranca de Duero	47
6660	1	204	7	Santa María de Valverde	49
6661	1	204	0	Pedrola	50
6662	1	205	0	Sanchorreja	5
6663	1	205	5	Sant Cugat del Vallès	8
6664	1	205	2	Valverde del Fresno	10
6665	1	205	1	Tejadillos	16
6666	1	205	7	Ullastret	17
6667	1	205	2	San Esteban de Litera	22
6668	1	205	3	Villadangos del Páramo	24
6669	1	205	6	Sidamon	25
6670	1	205	5	Pitillas	31
6671	1	205	1	Villaconancio	34
6672	1	205	3	Morille	37
6673	1	205	6	Torreiglesias	40
6674	1	205	8	Villaciervos	42
6675	1	205	9	Samper de Calanda	44
6676	1	205	2	Yuncos	45
6677	1	205	5	Puçol	46
6678	1	205	1	Villafrechós	47
6679	1	205	0	Santibáñez de Tera	49
6680	1	205	3	Pedrosas, Las	50
6681	1	206	3	San Esteban de los Patos	5
6682	1	206	8	Sant Cugat Sesgarrigues	8
6683	1	206	1	Mazuela	9
6684	1	206	5	Viandar de la Vera	10
6685	1	206	4	Tinajas	16
6686	1	206	0	Urús	17
6687	1	206	5	Sangarrén	22
6688	1	206	6	Toral de los Vados	24
6689	1	206	9	Soleràs, El	25
6690	1	206	8	Puente la Reina/Gares	31
6691	1	206	4	Villada	34
6692	1	206	6	Moríñigo	37
6693	1	206	9	Torre Val de San Pedro	40
6694	1	206	1	Villanueva de Gormaz	42
6695	1	206	2	San Agustín	44
6696	1	206	8	Quesa	46
6697	1	206	4	Villafuerte	47
6698	1	206	3	Santibáñez de Vidriales	49
6699	1	206	6	Perdiguera	50
6700	1	207	9	San Esteban del Valle	5
6701	1	207	4	Sant Esteve de Palautordera	8
6702	1	207	1	Villa del Campo	10
6703	1	207	6	Vall en Bas, La	17
6704	1	207	1	San Juan de Plan	22
6705	1	207	2	Villademor de la Vega	24
6706	1	207	5	Solsona	25
6707	1	207	4	Pueyo	31
6708	1	207	2	Moriscos	37
6709	1	207	5	Trescasas	40
6710	1	207	7	Villar del Ala	42
6711	1	207	8	San Martín del Río	44
6712	1	207	4	Rafelbuñol/Rafelbunyol	46
6713	1	207	0	Villagarcía de Campos	47
6714	1	207	9	Santovenia	49
6715	1	207	2	Piedratajada	50
6716	1	208	5	San Esteban de Zapardiel	5
6717	1	208	0	Sant Esteve Sesrovires	8
6718	1	208	3	Mecerreyes	9
6719	1	208	7	Villa del Rey	10
6720	1	208	2	Vall de Bianya, La	17
6721	1	208	1	Pálmaces de Jadraque	19
6722	1	208	7	Santa Cilia	22
6723	1	208	1	Soriguera	25
6724	1	208	0	Ribaforada	31
6725	1	208	6	Villaeles de Valdavia	34
6726	1	208	8	Moronta	37
6727	1	208	1	Turégano	40
6728	1	208	3	Villar del Campo	42
6729	1	208	4	Santa Cruz de Nogueras	44
6730	1	208	0	Rafelcofer	46
6731	1	208	6	Villagómez la Nueva	47
6732	1	208	5	San Vicente de la Cabeza	49
6733	1	208	8	Pina de Ebro	50
6734	1	209	8	San García de Ingelmos	5
6735	1	209	3	Sant Fost de Campsentelles	8
6736	1	209	6	Medina de Pomar	9
6737	1	209	0	Villamesías	10
6738	1	209	9	Torralba	16
6739	1	209	5	Vall-llobrega	17
6740	1	209	4	Pardos	19
6741	1	209	0	Santa Cruz de la Serós	22
6742	1	209	1	Villafranca del Bierzo	24
6743	1	209	4	Sort	25
6744	1	209	3	Romanzado	31
6745	1	209	1	Mozárbez	37
6746	1	209	6	Villar del Río	42
6747	1	209	7	Santa Eulalia	44
6748	1	209	3	Rafelguaraf	46
6749	1	209	9	Villalán de Campos	47
6750	1	209	8	San Vitero	49
6751	1	209	1	Pinseque	50
6752	1	210	2	San Juan de la Encinilla	5
6753	1	210	7	Sant Feliu de Codines	8
6754	1	210	4	Villamiel	10
6755	1	210	9	Ventalló	17
6756	1	210	8	Paredes de Sigüenza	19
6757	1	210	5	Villagatón	24
6758	1	210	8	Soses	25
6759	1	210	7	Roncal/Erronkari	31
6760	1	210	3	Villahán	34
6761	1	210	8	Urueñas	40
6762	1	210	1	Sarrión	44
6763	1	210	7	Ráfol de Salem	46
6764	1	210	3	Villalar de los Comuneros	47
6765	1	210	2	Sanzoles	49
6766	1	210	5	Pintanos, Los	50
6767	1	211	9	San Juan de la Nava	5
6768	1	211	4	Sant Feliu de Llobregat	8
6769	1	211	7	Melgar de Fernamental	9
6770	1	211	1	Villanueva de la Sierra	10
6771	1	211	0	Torrejoncillo del Rey	16
6772	1	211	6	Verges	17
6773	1	211	5	Pareja	19
6774	1	211	2	Villamandos	24
6775	1	211	5	Sudanell	25
6776	1	211	4	Orreaga/Roncesvalles	31
6777	1	211	0	Villaherreros	34
6778	1	211	2	Narros de Matalayegua	37
6779	1	211	5	Valdeprados	40
6780	1	211	7	Villares de Soria, Los	42
6781	1	211	8	Segura de los Baños	44
6782	1	211	4	Real de Gandía	46
6783	1	211	0	Villalba de la Loma	47
6784	1	211	2	Plasencia de Jalón	50
6785	1	212	4	San Juan del Molinillo	5
6786	1	212	9	Sant Feliu Sasserra	8
6787	1	212	6	Villanueva de la Vera	10
6788	1	212	5	Torrubia del Campo	16
6789	1	212	1	Vidrà	17
6790	1	212	0	Pastrana	19
6791	1	212	6	Santaliestra y San Quílez	22
6792	1	212	7	Villamañán	24
6793	1	212	0	Sunyer	25
6794	1	212	9	Sada	31
6795	1	212	7	Navacarros	37
6796	1	212	0	Valdevacas de Montejo	40
6797	1	212	2	Villasayas	42
6798	1	212	3	Seno	44
6799	1	212	9	Real	46
6800	1	212	5	Villalba de los Alcores	47
6801	1	212	7	Pleitas	50
6802	1	213	0	San Juan del Olmo	5
6803	1	213	5	Sant Fruitós de Bages	8
6804	1	213	8	Merindad de Cuesta-Urria	9
6805	1	213	2	Villar del Pedroso	10
6806	1	213	1	Torrubia del Castillo	16
6807	1	213	7	Vidreres	17
6808	1	213	6	Pedregal, El	19
6809	1	213	2	Sariñena	22
6810	1	213	3	Villamartín de Don Sancho	24
6811	1	213	5	Saldías	31
6812	1	213	1	Villalaco	34
6813	1	213	3	Nava de Béjar	37
6814	1	213	6	Valdevacas y Guijar	40
6815	1	213	8	Villaseca de Arciel	42
6816	1	213	9	Singra	44
6817	1	213	5	Requena	46
6818	1	213	1	Villalbarba	47
6819	1	213	3	Plenas	50
6820	1	214	5	San Lorenzo de Tormes	5
6821	1	214	0	Vilassar de Dalt	8
6822	1	214	3	Merindad de Montija	9
6823	1	214	7	Villar de Plasencia	10
6824	1	214	2	Vilabertran	17
6825	1	214	1	Peñalén	19
6826	1	214	7	Secastilla	22
6827	1	214	8	Villamejil	24
6828	1	214	0	Salinas de Oro/Jaitz	31
6829	1	214	6	Villalba de Guardo	34
6830	1	214	8	Nava de Francia	37
6831	1	214	1	Valseca	40
6832	1	214	0	Riba-roja de Túria	46
6833	1	214	6	Villalón de Campos	47
6834	1	214	5	Tábara	49
6835	1	214	8	Pomer	50
6836	1	215	8	San Martín de la Vega del Alberche	5
6837	1	215	3	Sant Hipòlit de Voltregà	8
6838	1	215	6	Merindad de Sotoscueva	9
6839	1	215	0	Villasbuenas de Gata	10
6840	1	215	9	Tragacete	16
6841	1	215	5	Vilablareix	17
6842	1	215	4	Peñalver	19
6843	1	215	0	Seira	22
6844	1	215	1	Villamol	24
6845	1	215	4	Talarn	25
6846	1	215	3	San Adrián	31
6847	1	215	9	Villalcázar de Sirga	34
6848	1	215	1	Nava de Sotrobal	37
6849	1	215	4	Valtiendas	40
6850	1	215	6	Vinuesa	42
6851	1	215	7	Terriente	44
6852	1	215	3	Riola	46
6853	1	215	9	Villamuriel de Campos	47
6854	1	215	1	Pozuel de Ariza	50
6855	1	216	1	San Martín del Pimpollar	5
6856	1	216	6	Sant Jaume de Frontanyà	8
6857	1	216	9	Merindad de Valdeporres	9
6858	1	216	3	Zarza de Granadilla	10
6859	1	216	2	Tresjuncos	16
6860	1	216	8	Viladasens	17
6861	1	216	7	Peralejos de las Truchas	19
6862	1	216	4	Villamontán de la Valduerna	24
6863	1	216	7	Talavera	25
6864	1	216	6	Sangüesa/Zangoza	31
6865	1	216	2	Villalcón	34
6866	1	216	4	Navales	37
6867	1	216	7	Valverde del Majano	40
6868	1	216	9	Vizmanos	42
6869	1	216	0	Teruel	44
6870	1	216	6	Rocafort	46
6871	1	216	2	Villán de Tordesillas	47
6872	1	216	1	Tapioles	49
6873	1	216	4	Pozuelo de Aragón	50
6874	1	217	7	San Miguel de Corneja	5
6875	1	217	2	Sant Joan Despí	8
6876	1	217	5	Merindad de Valdivielso	9
6877	1	217	9	Zarza de Montánchez	10
6878	1	217	8	Tribaldos	16
6879	1	217	4	Viladamat	17
6880	1	217	3	Peralveche	19
6881	1	217	9	Sena	22
6882	1	217	0	Villamoratiel de las Matas	24
6883	1	217	3	Tàrrega	25
6884	1	217	2	San Martín de Unx	31
6885	1	217	8	Villalobón	34
6886	1	217	0	Navalmoral de Béjar	37
6887	1	217	5	Vozmediano	42
6888	1	217	6	Toril y Masegoso	44
6889	1	217	2	Rotglà i Corberà	46
6890	1	217	8	Villanubla	47
6891	1	217	0	Pradilla de Ebro	50
6892	1	218	3	San Miguel de Serrezuela	5
6893	1	218	8	Sant Joan de Vilatorrada	8
6894	1	218	1	Milagros	9
6895	1	218	5	Zarza la Mayor	10
6896	1	218	4	Uclés	16
6897	1	218	0	Vilademuls	17
6898	1	218	9	Pinilla de Jadraque	19
6899	1	218	5	Senés de Alcubierre	22
6900	1	218	6	Villanueva de las Manzanas	24
6901	1	218	9	Tarrés	25
6902	1	218	4	Villaluenga de la Vega	34
6903	1	218	6	Navamorales	37
6904	1	218	9	Valle de Tabladillo	40
6905	1	218	1	Yanguas	42
6906	1	218	2	Tormón	44
6907	1	218	8	Rótova	46
6908	1	218	4	Villanueva de Duero	47
6909	1	218	6	Puebla de Albortón	50
6910	1	219	6	San Pascual	5
6911	1	219	1	Vilassar de Mar	8
6912	1	219	4	Miranda de Ebro	9
6913	1	219	8	Zorita	10
6914	1	219	7	Uña	16
6915	1	219	2	Pinilla de Molina	19
6916	1	219	9	Villaobispo de Otero	24
6917	1	219	2	Tarroja de Segarra	25
6918	1	219	1	Sansol	31
6919	1	219	9	Navarredonda de la Rinconada	37
6920	1	219	2	Vallelado	40
6921	1	219	4	Yelo	42
6922	1	219	5	Tornos	44
6923	1	219	1	Rugat	46
6924	1	219	7	Villanueva de la Condesa	47
6925	1	219	6	Toro	49
6926	1	219	9	Puebla de Alfindén, La	50
6927	1	220	0	San Pedro del Arroyo	5
6928	1	220	5	Sant Julià de Vilatorta	8
6929	1	220	8	Miraveche	9
6930	1	220	7	Viladrau	17
6931	1	220	6	Pioz	19
6932	1	220	2	Sesa	22
6933	1	220	6	Térmens	25
6934	1	220	5	Santacara	31
6935	1	220	1	Villamartín de Campos	34
6936	1	220	6	Valleruela de Pedraza	40
6937	1	220	9	Torralba de los Sisones	44
6938	1	220	5	Sagunto/Sagunt	46
6939	1	220	1	Villanueva de los Caballeros	47
6940	1	220	0	Torre del Valle, La	49
6941	1	220	3	Puendeluna	50
6942	1	221	7	Santa Cruz del Valle	5
6943	1	221	2	Sant Just Desvern	8
6944	1	221	5	Modúbar de la Emparedada	9
6945	1	221	4	Vilafant	17
6946	1	221	3	Piqueras	19
6947	1	221	9	Sesué	22
6948	1	221	0	Villaquejida	24
6949	1	221	3	Tírvia	25
6950	1	221	2	Doneztebe/Santesteban	31
6951	1	221	8	Villamediana	34
6952	1	221	0	Navasfrías	37
6953	1	221	3	Valleruela de Sepúlveda	40
6954	1	221	6	Torrecilla de Alcañiz	44
6955	1	221	2	Salem	46
6956	1	221	8	Villanueva de los Infantes	47
6957	1	221	7	Torregamones	49
6958	1	221	0	Purujosa	50
6959	1	222	2	Santa Cruz de Pinares	5
6960	1	222	7	Sant Llorenç Hortons	8
6961	1	222	9	Vilaür	17
6962	1	222	8	Pobo de Dueñas, El	19
6963	1	222	4	Siétamo	22
6964	1	222	5	Villaquilambre	24
6965	1	222	8	Tiurana	25
6966	1	222	7	Sarriés/Sartze	31
6967	1	222	3	Villameriel	34
6968	1	222	5	Negrilla de Palencia	37
6969	1	222	8	Veganzones	40
6970	1	222	1	Torrecilla del Rebollar	44
6971	1	222	7	Sant Joanet	46
6972	1	222	3	Villanueva de San Mancio	47
6973	1	222	2	Torres del Carrizal	49
6974	1	222	5	Quinto	50
6975	1	223	3	Sant Llorenç Savall	8
6976	1	223	6	Monasterio de la Sierra	9
6977	1	223	5	Vilajuïga	17
6978	1	223	4	Poveda de la Sierra	19
6979	1	223	0	Sopeira	22
6980	1	223	1	Villarejo de Órbigo	24
6981	1	223	4	Torà	25
6982	1	223	3	Sartaguda	31
6983	1	223	9	Villamoronta	34
6984	1	223	1	Olmedo de Camaces	37
6985	1	223	4	Vegas de Matute	40
6986	1	223	7	Torre de Arcas	44
6987	1	223	3	Sedaví	46
6988	1	223	9	Villardefrades	47
6989	1	223	8	Trabazos	49
6990	1	223	1	Remolinos	50
6991	1	224	3	Santa María del Arroyo	5
6992	1	224	8	Sant Martí de Centelles	8
6993	1	224	1	Monasterio de Rodilla	9
6994	1	224	4	Valdemeca	16
6995	1	224	0	Vilallonga de Ter	17
6996	1	224	9	Pozo de Almoguera	19
6997	1	224	6	Villares de Órbigo	24
6998	1	224	9	Torms, Els	25
6999	1	224	8	Sesma	31
7000	1	224	4	Villamuera de la Cueza	34
7001	1	224	6	Orbada, La	37
7002	1	224	9	Ventosilla y Tejadilla	40
7003	1	224	2	Torre de las Arcas	44
7004	1	224	8	Segart	46
7005	1	224	4	Villarmentero de Esgueva	47
7006	1	224	3	Trefacio	49
7007	1	224	6	Retascón	50
7008	1	225	6	Santa María del Berrocal	5
7009	1	225	1	Sant Martí Albars	8
7010	1	225	4	Moncalvillo	9
7011	1	225	7	Valdemorillo de la Sierra	16
7012	1	225	3	Vilamacolum	17
7013	1	225	2	Pozo de Guadalajara	19
7014	1	225	8	Tamarite de Litera	22
7015	1	225	9	Villasabariego	24
7016	1	225	2	Tornabous	25
7017	1	225	1	Sorlada	31
7018	1	225	7	Villamuriel de Cerrato	34
7019	1	225	9	Pajares de la Laguna	37
7020	1	225	2	Villacastín	40
7021	1	225	5	Torre del Compte	44
7022	1	225	1	Sellent	46
7023	1	225	7	Villasexmir	47
7024	1	225	6	Uña de Quintana	49
7025	1	225	9	Ricla	50
7026	1	226	9	Santa María de los Caballeros	5
7027	1	226	4	Sant Martí de Tous	8
7028	1	226	7	Monterrubio de la Demanda	9
7029	1	226	6	Vilamalla	17
7030	1	226	5	Prádena de Atienza	19
7031	1	226	1	Tardienta	22
7032	1	226	2	Villaselán	24
7033	1	226	5	Torrebesses	25
7034	1	226	4	Sunbilla	31
7035	1	226	2	Palacios del Arzobispo	37
7036	1	226	8	Torrelacárcel	44
7037	1	226	4	Sempere	46
7038	1	226	0	Villavaquerín	47
7039	1	226	9	Vadillo de la Guareña	49
7040	1	227	5	Santa María del Tiétar	5
7041	1	227	0	Sant Martí Sarroca	8
7042	1	227	3	Montorio	9
7043	1	227	6	Valdemoro-Sierra	16
7044	1	227	2	Vilamaniscle	17
7045	1	227	1	Prados Redondos	19
7046	1	227	7	Tella-Sin	22
7047	1	227	8	Villaturiel	24
7048	1	227	1	Torre de Cabdella, La	25
7049	1	227	0	Tafalla	31
7050	1	227	6	Villanueva del Rebollar	34
7051	1	227	4	Torre los Negros	44
7052	1	227	0	Senyera	46
7053	1	227	6	Villavellid	47
7054	1	227	5	Valcabado	49
7055	1	227	8	Romanos	50
7056	1	228	1	Santiago del Collado	5
7057	1	228	6	Sant Martí Sesgueioles	8
7058	1	228	9	Moradillo de Roa	9
7059	1	228	2	Valdeolivas	16
7060	1	228	8	Vilanant	17
7061	1	228	7	Puebla de Beleña	19
7062	1	228	3	Tierz	22
7063	1	228	4	Villazala	24
7064	1	228	7	Torrefarrera	25
7065	1	228	6	Tiebas-Muruarte de Reta	31
7066	1	228	2	Villanuño de Valdavia	34
7067	1	228	4	Palaciosrubios	37
7068	1	228	7	Villaverde de Íscar	40
7069	1	228	0	Torremocha de Jiloca	44
7070	1	228	6	Serra	46
7071	1	228	2	Villaverde de Medina	47
7072	1	228	1	Valdefinjas	49
7073	1	228	4	Rueda de Jalón	50
7074	1	229	4	Santo Domingo de las Posadas	5
7075	1	229	9	Sant Mateu de Bages	8
7076	1	229	2	Nava de Roa	9
7077	1	229	0	Puebla de Valles	19
7078	1	229	6	Tolva	22
7079	1	229	7	Villazanzo de Valderaduey	24
7080	1	229	9	Tirapu	31
7081	1	229	5	Villaprovedo	34
7082	1	229	7	Palencia de Negrilla	37
7083	1	229	0	Villaverde de Montejo	40
7084	1	229	3	Torres de Albarracín	44
7085	1	229	9	Siete Aguas	46
7086	1	229	5	Villavicencio de los Caballeros	47
7087	1	229	4	Valdescorriel	49
7088	1	229	7	Ruesca	50
7089	1	230	8	Santo Tomé de Zabarcos	5
7090	1	230	3	Premià de Dalt	8
7091	1	230	6	Navas de Bureba	9
7092	1	230	5	Vila-sacra	17
7093	1	230	4	Quer	19
7094	1	230	0	Torla	22
7095	1	230	1	Zotes del Páramo	24
7096	1	230	4	Torregrossa	25
7097	1	230	3	Torralba del Río	31
7098	1	230	9	Villarmentero de Campos	34
7099	1	230	1	Parada de Arriba	37
7100	1	230	4	Villeguillo	40
7101	1	230	7	Torrevelilla	44
7102	1	230	3	Silla	46
7103	1	230	9	Wamba	47
7104	1	230	8	Vallesa de la Guareña	49
7105	1	230	1	Sádaba	50
7106	1	231	5	San Vicente de Arévalo	5
7107	1	231	0	Sant Pere de Ribes	8
7108	1	231	3	Nebreda	9
7109	1	231	6	Valhermoso de la Fuente	16
7110	1	231	1	Rebollosa de Jadraque	19
7111	1	231	1	Torrelameu	25
7112	1	231	0	Torres del Río	31
7113	1	231	6	Villarrabé	34
7114	1	231	8	Parada de Rubiales	37
7115	1	231	1	Yanguas de Eresma	40
7116	1	231	4	Torrijas	44
7117	1	231	0	Simat de la Valldigna	46
7118	1	231	6	Zaratán	47
7119	1	231	5	Vega de Tera	49
7120	1	231	8	Salillas de Jalón	50
7121	1	232	0	Serrada, La	5
7122	1	232	5	Sant Pere de Riudebitlles	8
7123	1	232	8	Neila	9
7124	1	232	7	Vilopriu	17
7125	1	232	6	Recuenco, El	19
7126	1	232	2	Torralba de Aragón	22
7127	1	232	6	Torres de Segre	25
7128	1	232	5	Tudela	31
7129	1	232	1	Villarramiel	34
7130	1	232	3	Paradinas de San Juan	37
7131	1	232	9	Torrijo del Campo	44
7132	1	232	5	Sinarcas	46
7133	1	232	1	Zarza, La	47
7134	1	232	0	Vega de Villalobos	49
7135	1	232	3	Salvatierra de Esca	50
7136	1	233	6	Serranillos	5
7137	1	233	1	Sant Pere de Torelló	8
7138	1	233	3	Vilobí Onyar	17
7139	1	233	2	Renera	19
7140	1	233	8	Torre la Ribera	22
7141	1	233	2	Torre-serona	25
7142	1	233	1	Tulebras	31
7143	1	233	7	Villasarracino	34
7144	1	233	9	Pastores	37
7145	1	233	2	Zarzuela del Monte	40
7146	1	233	1	Sollana	46
7147	1	233	6	Vegalatrave	49
7148	1	233	9	Samper del Salz	50
7149	1	234	1	Sigeres	5
7150	1	234	6	Sant Pere de Vilamajor	8
7151	1	234	2	Valsalobre	16
7152	1	234	8	Biure	17
7153	1	234	7	Retiendas	19
7154	1	234	3	Torrente de Cinca	22
7155	1	234	7	Tremp	25
7156	1	234	6	Ucar	31
7157	1	234	2	Villasila de Valdavia	34
7158	1	234	4	Payo, El	37
7159	1	234	7	Zarzuela del Pinar	40
7160	1	234	0	Tramacastiel	44
7161	1	234	6	Sot de Chera	46
7162	1	234	1	Venialbo	49
7163	1	234	4	San Martín de la Virgen de Moncayo	50
7164	1	235	4	Sinlabajos	5
7165	1	235	9	Sant Pol de Mar	8
7166	1	235	2	Olmedillo de Roa	9
7167	1	235	0	Riba de Saelices	19
7168	1	235	6	Torres de Alcanadre	22
7169	1	235	9	Ujué	31
7170	1	235	7	Pedraza de Alba	37
7171	1	235	3	Tramacastilla	44
7172	1	235	9	Sueca	46
7173	1	235	4	Vezdemarbán	49
7174	1	235	7	San Mateo de Gállego	50
7175	1	236	7	Solana de Ávila	5
7176	1	236	2	Sant Quintí de Mediona	8
7177	1	236	5	Olmillos de Muñó	9
7178	1	236	8	Valverde de Júcar	16
7179	1	236	9	Torres de Barbués	22
7180	1	236	2	Ultzama	31
7181	1	236	8	Villaturde	34
7182	1	236	0	Pedrosillo de Alba	37
7183	1	236	6	Tronchón	44
7184	1	236	2	Sumacàrcer	46
7185	1	236	7	Vidayanes	49
7186	1	236	0	Santa Cruz de Grío	50
7187	1	237	3	Solana de Rioalmar	5
7188	1	237	8	Sant Quirze de Besora	8
7189	1	237	4	Valverdejo	16
7190	1	237	9	Rillo de Gallo	19
7191	1	237	8	Unciti	31
7192	1	237	4	Villaumbrales	34
7193	1	237	6	Pedrosillo de los Aires	37
7194	1	237	2	Urrea de Gaén	44
7195	1	237	8	Tavernes Blanques	46
7196	1	237	3	Videmala	49
7197	1	237	6	Santa Cruz de Moncayo	50
7198	1	238	9	Solosancho	5
7199	1	238	4	Sant Quirze del Vallès	8
7200	1	238	7	Oña	9
7201	1	238	0	Vara de Rey	16
7202	1	238	5	Riofrío del Llano	19
7203	1	238	5	Vallbona de les Monges	25
7204	1	238	4	Unzué/Untzue	31
7205	1	238	0	Villaviudas	34
7206	1	238	2	Pedrosillo el Ralo	37
7207	1	238	8	Utrillas	44
7208	1	238	4	Tavernes de la Valldigna	46
7209	1	238	9	Villabrázaro	49
7210	1	238	2	Santa Eulalia de Gállego	50
7211	1	239	2	Sotalbo	5
7212	1	239	7	Sant Quirze Safaja	8
7213	1	239	0	Oquillas	9
7214	1	239	3	Vega del Codorno	16
7215	1	239	8	Robledillo de Mohernando	19
7216	1	239	4	Tramaced	22
7217	1	239	8	Valls de Valira, Les	25
7218	1	239	7	Urdazubi/Urdax	31
7219	1	239	5	Pedroso de la Armuña, El	37
7220	1	239	1	Valacloche	44
7221	1	239	7	Teresa de Cofrentes	46
7222	1	239	2	Villabuena del Puente	49
7223	1	239	5	Santed	50
7224	1	240	6	Sotillo de la Adrada	5
7225	1	240	1	Sant Sadurní Anoia	8
7226	1	240	7	Vellisca	16
7227	1	240	2	Robledo de Corpes	19
7228	1	240	2	Vallfogona de Balaguer	25
7229	1	240	1	Urdiain	31
7230	1	240	7	Villerías de Campos	34
7231	1	240	9	Pelabravo	37
7232	1	240	5	Valbona	44
7233	1	240	1	Terrateig	46
7234	1	240	6	Villadepera	49
7235	1	240	9	Sástago	50
7236	1	241	3	Tiemblo, El	5
7237	1	241	8	Sant Sadurní Osormort	8
7238	1	241	1	Orbaneja Riopico	9
7239	1	241	9	Romanillos de Atienza	19
7240	1	241	8	Urraul Alto	31
7241	1	241	4	Villodre	34
7242	1	241	6	Pelarrodríguez	37
7243	1	241	2	Valdealgorfa	44
7244	1	241	8	Titaguas	46
7245	1	241	3	Villaescusa	49
7246	1	241	6	Sabiñán	50
7247	1	242	8	Tiñosillos	5
7248	1	242	3	Marganell	8
7249	1	242	6	Padilla de Abajo	9
7250	1	242	9	Villaconejos de Trabaque	16
7251	1	242	4	Romanones	19
7252	1	242	0	Valfarta	22
7253	1	242	4	Verdú	25
7254	1	242	3	Urraul Bajo	31
7255	1	242	9	Villodrigo	34
7256	1	242	1	Pelayos	37
7257	1	242	3	Torrebaja	46
7258	1	242	8	Villafáfila	49
7259	1	242	1	Sediles	50
7260	1	243	4	Tolbaños	5
7261	1	243	9	Santa Cecília de Voltregà	8
7262	1	243	2	Padilla de Arriba	9
7263	1	243	5	Villaescusa de Haro	16
7264	1	243	0	Rueda de la Sierra	19
7265	1	243	6	Valle de Bardají	22
7266	1	243	0	Vielha e Mijaran	25
7267	1	243	9	Urroz-Villa	31
7268	1	243	5	Villoldo	34
7269	1	243	7	Peña, La	37
7270	1	243	3	Valdecuenca	44
7271	1	243	9	Torrella	46
7272	1	243	4	Villaferrueña	49
7273	1	243	7	Sestrica	50
7274	1	244	9	Tormellas	5
7275	1	244	4	Santa Coloma de Cervelló	8
7276	1	244	7	Padrones de Bureba	9
7277	1	244	0	Villagarcía del Llano	16
7278	1	244	5	Sacecorbo	19
7279	1	244	1	Valle de Lierp	22
7280	1	244	5	Vilagrassa	25
7281	1	244	4	Urrotz	31
7282	1	244	2	Peñacaballera	37
7283	1	244	8	Valdelinares	44
7284	1	244	4	Torrent	46
7285	1	244	9	Villageriz	49
7286	1	244	2	Sierra de Luna	50
7287	1	245	2	Tornadizos de Ávila	5
7288	1	245	7	Santa Coloma de Gramenet	8
7289	1	245	3	Villalba de la Sierra	16
7290	1	245	8	Sacedón	19
7291	1	245	4	Velilla de Cinca	22
7292	1	245	8	Vilaller	25
7293	1	245	7	Urzainqui/Urzainki	31
7294	1	245	3	Villota del Páramo	34
7295	1	245	5	Peñaparda	37
7296	1	245	1	Valdeltormo	44
7297	1	245	7	Torres Torres	46
7298	1	245	2	Villalazán	49
7299	1	245	5	Sigüés	50
7300	1	246	5	Tórtoles	5
7301	1	246	0	Santa Eugènia de Berga	8
7302	1	246	3	Palacios de la Sierra	9
7303	1	246	6	Villalba del Rey	16
7304	1	246	1	Saelices de la Sal	19
7305	1	246	7	Beranuy	22
7306	1	246	0	Uterga	31
7307	1	246	6	Villovieco	34
7308	1	246	8	Peñaranda de Bracamonte	37
7309	1	246	4	Valderrobres	44
7310	1	246	0	Tous	46
7311	1	246	5	Villalba de la Lampreana	49
7312	1	246	8	Sisamón	50
7313	1	247	1	Torre, La	5
7314	1	247	6	Santa Eulàlia de Riuprimer	8
7315	1	247	9	Palacios de Riopisuerga	9
7316	1	247	2	Villalgordo del Marquesado	16
7317	1	247	7	Salmerón	19
7318	1	247	3	Viacamp y Litera	22
7319	1	247	7	Vilamòs	25
7320	1	247	6	Uztárroz/Uztarroze	31
7321	1	247	4	Peñarandilla	37
7322	1	247	0	Valjunquera	44
7323	1	247	6	Tuéjar	46
7324	1	247	1	Villalcampo	49
7325	1	247	4	Sobradiel	50
7326	1	248	2	Santa Eulàlia de Ronçana	8
7327	1	248	5	Palazuelos de la Sierra	9
7328	1	248	8	Villalpardo	16
7329	1	248	3	San Andrés del Congosto	19
7330	1	248	9	Vicién	22
7331	1	248	3	Vilanova de Bellpuig	25
7332	1	248	2	Luzaide/Valcarlos	31
7333	1	248	0	Peralejos de Abajo	37
7334	1	248	2	Turís	46
7335	1	248	7	Villalobos	49
7336	1	248	0	Sos del Rey Católico	50
7337	1	249	0	Umbrías	5
7338	1	249	5	Santa Fe del Penedès	8
7339	1	249	8	Palazuelos de Muñó	9
7340	1	249	1	Villamayor de Santiago	16
7341	1	249	6	San Andrés del Rey	19
7342	1	249	2	Villanova	22
7343	1	249	6	Vilanova del Aguda	25
7344	1	249	5	Valtierra	31
7345	1	249	3	Peralejos de Arriba	37
7346	1	249	9	El Vallecillo	44
7347	1	249	5	Utiel	46
7348	1	249	0	Villalonso	49
7349	1	249	3	Tabuenca	50
7350	1	250	8	Santa Margarida de Montbui	8
7351	1	250	1	Pampliega	9
7352	1	250	4	Villanueva de Guadamejud	16
7353	1	250	9	Santiuste	19
7354	1	250	5	Villanúa	22
7355	1	250	9	Vilanova de Meià	25
7356	1	250	8	Bera	31
7357	1	250	6	Pereña de la Ribera	37
7358	1	250	2	Veguillas de la Sierra	44
7359	1	250	8	Valencia	46
7360	1	250	3	Villalpando	49
7361	1	250	6	Talamantes	50
7362	1	251	0	Vadillo de la Sierra	5
7363	1	251	5	Santa Margarida i els Monjos	8
7364	1	251	8	Pancorbo	9
7365	1	251	1	Villanueva de la Jara	16
7366	1	251	6	Saúca	19
7367	1	251	2	Villanueva de Sigena	22
7368	1	251	6	Vilanova de Segrià	25
7369	1	251	5	Viana	31
7370	1	251	3	Peromingo	37
7371	1	251	9	Villafranca del Campo	44
7372	1	251	5	Vallada	46
7373	1	251	0	Villalube	49
7374	1	251	3	Tarazona	50
7375	1	252	5	Valdecasa	5
7376	1	252	0	Barberà del Vallès	8
7377	1	252	1	Sayatón	19
7378	1	252	7	Yebra de Basa	22
7379	1	252	1	Vila-sana	25
7380	1	252	0	Vidángoz/Bidankoze	31
7381	1	252	8	Pinedas	37
7382	1	252	4	Villahermosa del Campo	44
7383	1	252	0	Vallanca	46
7384	1	252	5	Villamayor de Campos	49
7385	1	252	8	Tauste	50
7386	1	253	1	Vega de Santa María	5
7387	1	253	6	Santa Maria de Besora	8
7388	1	253	9	Pardilla	9
7389	1	253	2	Villar de Cañas	16
7390	1	253	3	Yésero	22
7391	1	253	7	El Vilosell	25
7392	1	253	6	Bidaurreta	31
7393	1	253	4	El Pino de Tormes	37
7394	1	253	6	Vallés	46
7395	1	253	4	Terrer	50
7396	1	254	6	Velayos	5
7397	1	254	1	Santa Maria de Corcó	8
7398	1	254	7	Villar de Domingo García	16
7399	1	254	2	Selas	19
7400	1	254	8	Zaidín	22
7401	1	254	2	Vilanova de la Barca	25
7402	1	254	1	Villafranca	31
7403	1	254	9	Pitiegua	37
7404	1	254	1	Venta del Moro	46
7405	1	254	9	Tierga	50
7406	1	255	4	Santa Maria de Merlès	8
7407	1	255	7	Partido de la Sierra en Tobalina	9
7408	1	255	0	Villar de la Encina	16
7409	1	255	5	Setiles	19
7410	1	255	5	Vinaixa	25
7411	1	255	4	Villamayor de Monjardín	31
7412	1	255	2	Pizarral	37
7413	1	255	4	Villalonga	46
7414	1	255	9	Villamor de los Escuderos	49
7415	1	255	2	Tobed	50
7416	1	256	2	Villaflor	5
7417	1	256	7	Santa Maria de Martorelles	8
7418	1	256	0	Pedrosa de Duero	9
7419	1	256	8	Sienes	19
7420	1	256	7	Hiriberri/Villanueva de Aezkoa	31
7421	1	256	5	Poveda de las Cintas	37
7422	1	256	1	Villanueva del Rebollar de la Sierra	44
7423	1	256	7	Vilamarxant	46
7424	1	256	2	Villanázar	49
7425	1	256	5	Torralba de los Frailes	50
7426	1	257	8	Villafranca de la Sierra	5
7427	1	257	3	Santa Maria de Miralles	8
7428	1	257	6	Pedrosa del Páramo	9
7429	1	257	4	Sigüenza	19
7430	1	257	3	Villatuerta	31
7431	1	257	1	Pozos de Hinojo	37
7432	1	257	7	Villar del Cobo	44
7433	1	257	3	Villanueva de Castellón	46
7434	1	257	8	Villanueva de Azoague	49
7435	1	257	1	Torralba de Ribota	50
7436	1	258	4	Villanueva de Gómez	5
7437	1	258	9	Santa Maria Oló	8
7438	1	258	2	Pedrosa del Príncipe	9
7439	1	258	5	Villar del Humo	16
7440	1	258	0	Solanillos del Extremo	19
7441	1	258	9	Villava/Atarrabia	31
7442	1	258	7	Puebla de Azaba	37
7443	1	258	3	Villar del Salz	44
7444	1	258	9	Villar del Arzobispo	46
7445	1	258	4	Villanueva de Campeán	49
7446	1	258	7	Torralbilla	50
7447	1	259	7	Villanueva del Aceral	5
7448	1	259	2	Santa Maria de Palautordera	8
7449	1	259	5	Pedrosa de Río Úrbel	9
7450	1	259	8	Villar del Infantado	16
7451	1	259	3	Somolinos	19
7452	1	259	2	Igantzi	31
7453	1	259	0	Puebla de San Medel	37
7454	1	259	2	Villargordo del Cabriel	46
7455	1	259	7	Villanueva de las Peras	49
7456	1	259	0	Torrehermosa	50
7457	1	260	1	Villanueva del Campillo	5
7458	1	260	6	Santa Perpètua de Mogoda	8
7459	1	260	7	Sotillo, El	19
7460	1	260	6	Valle de Yerri/Deierri	31
7461	1	260	4	Puebla de Yeltes	37
7462	1	260	0	Villarluengo	44
7463	1	260	6	Vinalesa	46
7464	1	260	1	Villanueva del Campo	49
7465	1	260	4	Torrelapaja	50
7466	1	261	8	Villar de Corneja	5
7467	1	261	3	Santa Susanna	8
7468	1	261	6	Peñaranda de Duero	9
7469	1	261	4	Sotodosos	19
7470	1	261	3	Yesa	31
7471	1	261	1	Puente del Congosto	37
7472	1	261	7	Villarquemado	44
7473	1	261	3	Yátova	46
7474	1	261	8	Villaralbo	49
7475	1	261	1	Torrellas	50
7476	1	262	3	Villarejo del Valle	5
7477	1	262	8	Sant Vicenç de Castellet	8
7478	1	262	1	Peral de Arlanza	9
7479	1	262	9	Tamajón	19
7480	1	262	8	Zabalza/Zabaltza	31
7481	1	262	6	Puertas	37
7482	1	262	2	Villarroya de los Pinares	44
7483	1	262	8	Yesa, La	46
7484	1	262	3	Villardeciervos	49
7485	1	262	6	Torres de Berrellén	50
7486	1	263	9	Villatoro	5
7487	1	263	4	Sant Vicenç dels Horts	8
7488	1	263	0	Villar de Olalla	16
7489	1	263	5	Taragudo	19
7490	1	263	4	Zubieta	31
7491	1	263	2	Puerto de Béjar	37
7492	1	263	8	Villastar	44
7493	1	263	4	Zarra	46
7494	1	263	9	Villar de Fallaves	49
7495	1	263	2	Torrijo de la Cañada	50
7496	1	264	4	Viñegra de Moraña	5
7497	1	264	9	Sant Vicenç de Montalt	8
7498	1	264	5	Villarejo de Fuentes	16
7499	1	264	0	Taravilla	19
7500	1	264	9	Zugarramurdi	31
7501	1	264	7	Puerto Seguro	37
7502	1	264	3	Villel	44
7503	1	264	4	Villar del Buey	49
7504	1	264	7	Tosos	50
7505	1	265	7	Vita	5
7506	1	265	2	Sant Vicenç de Torelló	8
7507	1	265	5	Piérnigas	9
7508	1	265	8	Villarejo de la Peñuela	16
7509	1	265	3	Tartanedo	19
7510	1	265	2	Zúñiga	31
7511	1	265	0	Rágama	37
7512	1	265	6	Vinaceite	44
7513	1	265	7	Villardiegua de la Ribera	49
7514	1	265	0	Trasmoz	50
7515	1	266	0	Zapardiel de la Cañada	5
7516	1	266	5	Cerdanyola del Vallès	8
7517	1	266	8	Pineda de la Sierra	9
7518	1	266	1	Villarejo-Periesteban	16
7519	1	266	6	Tendilla	19
7520	1	266	3	Redonda, La	37
7521	1	266	9	Visiedo	44
7522	1	266	0	Villárdiga	49
7523	1	266	3	Trasobares	50
7524	1	267	6	Zapardiel de la Ribera	5
7525	1	267	1	Sentmenat	8
7526	1	267	4	Pineda Trasmonte	9
7527	1	267	2	Terzaga	19
7528	1	267	9	Retortillo	37
7529	1	267	5	Vivel del Río Martín	44
7530	1	267	6	Villardondiego	49
7531	1	267	9	Uncastillo	50
7532	1	268	7	Cercs	8
7533	1	268	0	Pinilla de los Barruecos	9
7534	1	268	8	Tierzo	19
7535	1	268	5	Rinconada de la Sierra, La	37
7536	1	268	1	Zoma, La	44
7537	1	268	2	Villarrín de Campos	49
7538	1	268	5	Undués de Lerda	50
7539	1	269	0	Seva	8
7540	1	269	3	Pinilla de los Moros	9
7541	1	269	6	Villares del Saz	16
7542	1	269	1	Toba, La	19
7543	1	269	8	Robleda	37
7544	1	269	5	Villaseco del Pan	49
7545	1	269	8	Urrea de Jalón	50
7546	1	270	4	Sitges	8
7547	1	270	7	Pinilla Trasmonte	9
7548	1	270	0	Villarrubio	16
7549	1	270	5	Tordelrábano	19
7550	1	270	2	Robliza de Cojos	37
7551	1	270	9	Villavendimio	49
7552	1	270	2	Urriés	50
7553	1	271	1	Sobremunt	8
7554	1	271	7	Villarta	16
7555	1	271	2	Tordellego	19
7556	1	271	9	Rollán	37
7557	1	271	6	Villaveza del Agua	49
7558	1	271	9	Used	50
7559	1	272	6	Sora	8
7560	1	272	9	Poza de la Sal	9
7561	1	272	2	Villas de la Ventosa	16
7562	1	272	7	Tordesilos	19
7563	1	272	4	Saelices el Chico	37
7564	1	272	1	Villaveza de Valverde	49
7565	1	272	4	Utebo	50
7566	1	273	2	Subirats	8
7567	1	273	5	Prádanos de Bureba	9
7568	1	273	8	Villaverde y Pasaconsol	16
7569	1	273	0	Sagrada, La	37
7570	1	273	7	Viñas	49
7571	1	273	0	Valdehorna	50
7572	1	274	7	Súria	8
7573	1	274	0	Pradoluengo	9
7574	1	274	3	Víllora	16
7575	1	274	8	Torija	19
7576	1	274	5	Salamanca	37
7577	1	274	5	Val de San Martín	50
7578	1	275	0	Tavèrnoles	8
7579	1	275	3	Presencio	9
7580	1	275	6	Vindel	16
7581	1	275	8	Saldeana	37
7582	1	275	5	Zamora	49
7583	1	275	8	Valmadrid	50
7584	1	276	3	Tagamanent	8
7585	1	276	6	Puebla de Arganzón, La	9
7586	1	276	9	Yémeda	16
7587	1	276	1	Salmoral	37
7588	1	276	1	Valpalmas	50
7589	1	277	9	Talamanca	8
7590	1	277	2	Puentedura	9
7591	1	277	5	Zafra de Záncara	16
7592	1	277	0	Torrecuadrada de Molina	19
7593	1	277	7	Salvatierra de Tormes	37
7594	1	277	7	Valtorres	50
7595	1	278	5	Taradell	8
7596	1	278	1	Zafrilla	16
7597	1	278	6	Torrecuadradilla	19
7598	1	278	3	San Cristóbal de la Cuesta	37
7599	1	278	3	Velilla de Ebro	50
7600	1	279	8	Terrassa	8
7601	1	279	1	Quemada	9
7602	1	279	4	Zarza de Tajo	16
7603	1	279	9	Torre del Burgo	19
7604	1	279	6	Sancti-Spíritus	37
7605	1	279	6	Velilla de Jiloca	50
7606	1	280	2	Tavertet	8
7607	1	280	5	Quintanabureba	9
7608	1	280	8	Zarzuela	16
7609	1	280	3	Torrejón del Rey	19
7610	1	280	0	Sanchón de la Ribera	37
7611	1	280	0	Vera de Moncayo	50
7612	1	281	9	Teià	8
7613	1	281	2	Quintana del Pidio	9
7614	1	281	0	Torremocha de Jadraque	19
7615	1	281	7	Sanchón de la Sagrada	37
7616	1	281	7	Vierlas	50
7617	1	282	4	Tiana	8
7618	1	282	5	Torremocha del Campo	19
7619	1	282	2	Sanchotello	37
7620	1	282	2	Vilueña, La	50
7621	1	283	0	Tona	8
7622	1	283	3	Quintanaélez	9
7623	1	283	1	Torremocha del Pinar	19
7624	1	283	8	Sando	37
7625	1	283	8	Villadoz	50
7626	1	284	5	Tordera	8
7627	1	284	6	Torremochuela	19
7628	1	284	3	San Esteban de la Sierra	37
7629	1	284	3	Villafeliche	50
7630	1	285	8	Torelló	8
7631	1	285	9	Torrubia	19
7632	1	285	6	San Felices de los Gallegos	37
7633	1	285	6	Villafranca de Ebro	50
7634	1	286	1	Torre de Claramunt, La	8
7635	1	286	2	Tórtola de Henares	19
7636	1	286	9	San Martín del Castañar	37
7637	1	286	9	Villalba de Perejil	50
7638	1	287	7	Torrelavit	8
7639	1	287	0	Quintanaortuño	9
7640	1	287	8	Tortuera	19
7641	1	287	5	San Miguel de Valero	37
7642	1	287	5	Villalengua	50
7643	1	288	3	Torrelles de Foix	8
7644	1	288	6	Quintanapalla	9
7645	1	288	4	Tortuero	19
7646	1	288	1	San Morales	37
7647	1	288	1	Villanueva de Gállego	50
7648	1	289	6	Torrelles de Llobregat	8
7649	1	289	9	Quintanar de la Sierra	9
7650	1	289	7	Traíd	19
7651	1	289	4	San Muñoz	37
7652	1	289	4	Villanueva de Jiloca	50
7653	1	290	0	Ullastrell	8
7654	1	290	1	Trijueque	19
7655	1	290	8	San Pedro del Valle	37
7656	1	290	8	Villanueva de Huerva	50
7657	1	291	7	Vacarisses	8
7658	1	291	8	Trillo	19
7659	1	291	5	San Pedro de Rozados	37
7660	1	291	5	Villar de los Navarros	50
7661	1	292	2	Vallbona Anoia	8
7662	1	292	5	Quintanavides	9
7663	1	292	0	San Pelayo de Guareña	37
7664	1	292	0	Villarreal de Huerva	50
7665	1	293	8	Vallcebre	8
7666	1	293	9	Uceda	19
7667	1	293	6	Santa María de Sando	37
7668	1	293	6	Villarroya de la Sierra	50
7669	1	294	3	Vallgorguina	8
7670	1	294	6	Quintanilla de la Mata	9
7671	1	294	4	Ujados	19
7672	1	294	1	Santa Marta de Tormes	37
7673	1	294	1	Villarroya del Campo	50
7674	1	295	6	Vallirana	8
7675	1	295	9	Quintanilla del Coco	9
7676	1	295	4	Vistabella	50
7677	1	296	9	Vallromanes	8
7678	1	296	0	Utande	19
7679	1	296	7	Santiago de la Puebla	37
7680	1	296	7	Zaida, La	50
7681	1	297	5	Veciana	8
7682	1	297	8	Quintanillas, Las	9
7683	1	297	6	Valdarachas	19
7684	1	297	3	Santibáñez de Béjar	37
7685	1	297	3	Zaragoza	50
7686	1	298	1	Vic	8
7687	1	298	4	Quintanilla San García	9
7688	1	298	2	Valdearenas	19
7689	1	298	9	Santibáñez de la Sierra	37
7690	1	298	9	Zuera	50
7691	1	299	4	Vilada	8
7692	1	299	5	Valdeavellano	19
7693	1	299	2	Santiz	37
7694	1	300	8	Viladecavalls	8
7695	1	300	9	Valdeaveruelo	19
7696	1	300	6	Santos, Los	37
7697	1	301	5	Viladecans	8
7698	1	301	8	Quintanilla Vivar	9
7699	1	301	6	Valdeconcha	19
7700	1	301	3	Sardón de los Frailes	37
7701	1	302	0	Vilanova del Camí	8
7702	1	302	3	Rabanera del Pinar	9
7703	1	302	1	Valdegrudas	19
7704	1	302	8	Saucelle	37
7705	1	303	6	Vilanova de Sau	8
7706	1	303	9	Rábanos	9
7707	1	303	7	Valdelcubo	19
7708	1	303	4	Sahugo, El	37
7709	1	304	1	Vilobí del Penedès	8
7710	1	304	4	Rabé de las Calzadas	9
7711	1	304	2	Valdenuño Fernández	19
7712	1	304	9	Sepulcro-Hilario	37
7713	1	305	4	Vilafranca del Penedès	8
7714	1	305	5	Valdepeñas de la Sierra	19
7715	1	305	2	Sequeros	37
7716	1	306	7	Vilalba Sasserra	8
7717	1	306	0	Rebolledo de la Torre	9
7718	1	306	8	Valderrebollo	19
7719	1	306	5	Serradilla del Arroyo	37
7720	1	307	3	Vilanova i la Geltrú	8
7721	1	307	6	Redecilla del Camino	9
7722	1	307	4	Valdesotos	19
7723	1	307	1	Serradilla del Llano	37
7724	1	308	9	Viver i Serrateix	8
7725	1	308	2	Redecilla del Campo	9
7726	1	308	0	Valfermoso de Tajuña	19
7727	1	309	5	Regumiel de la Sierra	9
7728	1	309	3	Valhermoso	19
7729	1	309	0	Sierpe, La	37
7730	1	310	9	Reinoso	9
7731	1	310	7	Valtablado del Río	19
7732	1	310	4	Sieteiglesias de Tormes	37
7733	1	311	6	Retuerta	9
7734	1	311	4	Valverde de los Arroyos	19
7735	1	311	1	Sobradillo	37
7736	1	312	1	Revilla y Ahedo, La	9
7737	1	312	6	Sorihuela	37
7738	1	313	2	Sotoserrano	37
7739	1	314	2	Revilla del Campo	9
7740	1	314	0	Viana de Jadraque	19
7741	1	314	7	Tabera de Abajo	37
7742	1	315	5	Revillarruz	9
7743	1	315	0	Tala, La	37
7744	1	316	8	Revilla Vallejera	9
7745	1	316	3	Tamames	37
7746	1	317	4	Rezmondo	9
7747	1	317	2	Villanueva de Alcorón	19
7748	1	317	9	Tarazona de Guareña	37
7749	1	318	0	Riocavado de la Sierra	9
7750	1	318	8	Villanueva de Argecilla	19
7751	1	318	5	Tardáguila	37
7752	1	319	1	Villanueva de la Torre	19
7753	1	319	8	Tejado, El	37
7754	1	320	2	Tejeda y Segoyuela	37
7755	1	321	4	Roa	9
7756	1	321	2	Villares de Jadraque	19
7757	1	321	9	Tenebrón	37
7758	1	322	7	Villaseca de Henares	19
7759	1	322	4	Terradillos	37
7760	1	323	5	Rojas	9
7761	1	323	3	Villaseca de Uceda	19
7762	1	323	0	Topas	37
7763	1	324	8	Villel de Mesa	19
7764	1	324	5	Tordillos	37
7765	1	325	3	Royuela de Río Franco	9
7766	1	325	1	Viñuelas	19
7767	1	325	8	Tornadizo, El	37
7768	1	326	6	Rubena	9
7769	1	326	4	Yebes	19
7770	1	327	2	Rublacedo de Abajo	9
7771	1	327	0	Yebra	19
7772	1	327	7	Torresmenudas	37
7773	1	328	8	Rucandio	9
7774	1	328	3	Trabanca	37
7775	1	329	1	Salas de Bureba	9
7776	1	329	9	Yélamos de Abajo	19
7777	1	329	6	Tremedal de Tormes	37
7778	1	330	5	Salas de los Infantes	9
7779	1	330	3	Yélamos de Arriba	19
7780	1	330	0	Valdecarros	37
7781	1	331	0	Yunquera de Henares	19
7782	1	331	7	Valdefuentes de Sangusín	37
7783	1	332	7	Saldaña de Burgos	9
7784	1	332	5	Yunta, La	19
7785	1	332	2	Valdehijaderos	37
7786	1	333	1	Zaorejas	19
7787	1	333	8	Valdelacasa	37
7788	1	334	8	Salinillas de Bureba	9
7789	1	334	6	Zarzuela de Jadraque	19
7790	1	334	3	Valdelageve	37
7791	1	335	1	San Adrián de Juarros	9
7792	1	335	9	Zorita de los Canes	19
7793	1	335	6	Valdelosa	37
7794	1	336	9	Valdemierque	37
7795	1	337	0	San Juan del Monte	9
7796	1	337	5	Valderrodrigo	37
7797	1	338	6	San Mamés de Burgos	9
7798	1	338	1	Valdunciel	37
7799	1	339	9	San Martín de Rubiales	9
7800	1	339	4	Valero	37
7801	1	340	3	San Millán de Lara	9
7802	1	340	8	Valsalabroso	37
7803	1	341	5	Valverde de Valdelacasa	37
7804	1	342	0	Valverdón	37
7805	1	343	1	Santa Cecilia	9
7806	1	343	6	Vallejera de Riofrío	37
7807	1	344	1	Vecinos	37
7808	1	345	9	Santa Cruz de la Salceda	9
7809	1	345	4	Vega de Tirados	37
7810	1	346	2	Santa Cruz del Valle Urbión	9
7811	1	346	7	Veguillas, Las	37
7812	1	347	8	Santa Gadea del Cid	9
7813	1	347	3	Vellés, La	37
7814	1	348	4	Santa Inés	9
7815	1	348	9	Ventosa del Río Almar	37
7816	1	349	2	Vídola, La	37
7817	1	350	0	Santa María del Campo	9
7818	1	350	5	Vilvestre	37
7819	1	351	7	Santa María del Invierno	9
7820	1	351	2	Villaflores	37
7821	1	352	2	Santa María del Mercadillo	9
7822	1	352	7	Villagonzalo de Tormes	37
7823	1	353	8	Santa María Rivarredonda	9
7824	1	353	3	Villalba de los Llanos	37
7825	1	354	3	Santa Olalla de Bureba	9
7826	1	354	8	Villamayor	37
7827	1	355	6	Santibáñez de Esgueva	9
7828	1	355	1	Villanueva del Conde	37
7829	1	356	9	Santibáñez del Val	9
7830	1	356	4	Villar de Argañán	37
7831	1	357	0	Villar de Ciervo	37
7832	1	358	1	Santo Domingo de Silos	9
7833	1	358	6	Villar de Gallimazo	37
7834	1	359	9	Villar de la Yegua	37
7835	1	360	8	San Vicente del Valle	9
7836	1	360	3	Villar de Peralonso	37
7837	1	361	5	Sargentes de la Lora	9
7838	1	361	0	Villar de Samaniego	37
7839	1	362	0	Sarracín	9
7840	1	362	5	Villares de la Reina	37
7841	1	363	6	Sasamón	9
7842	1	363	1	Villares de Yeltes	37
7843	1	364	6	Villarino de los Aires	37
7844	1	365	4	Sequera de Haza, La	9
7845	1	365	9	Villarmayor	37
7846	1	366	7	Solarana	9
7847	1	366	2	Villarmuerto	37
7848	1	367	8	Villasbuenas	37
7849	1	368	9	Sordillos	9
7850	1	368	4	Villasdardo	37
7851	1	369	2	Sotillo de la Ribera	9
7852	1	369	7	Villaseco de los Gamitos	37
7853	1	370	1	Villaseco de los Reyes	37
7854	1	371	8	Villasrubias	37
7855	1	372	8	Sotragero	9
7856	1	372	3	Villaverde de Guareña	37
7857	1	373	4	Sotresgudo	9
7858	1	373	9	Villavieja de Yeltes	37
7859	1	374	9	Susinos del Páramo	9
7860	1	374	4	Villoria	37
7861	1	375	2	Tamarón	9
7862	1	375	7	Villoruela	37
7863	1	376	0	Vitigudino	37
7864	1	377	1	Tardajos	9
7865	1	377	6	Yecla de Yeltes	37
7866	1	378	7	Tejada	9
7867	1	378	2	Zamarra	37
7868	1	379	5	Zamayón	37
7869	1	380	4	Terradillos de Esgueva	9
7870	1	380	9	Zarapicos	37
7871	1	381	1	Tinieblas de la Sierra	9
7872	1	381	6	Zarza de Pumareda, La	37
7873	1	382	6	Tobar	9
7874	1	382	1	Zorita de la Frontera	37
7875	1	384	7	Tordómar	9
7876	1	386	3	Torrecilla del Monte	9
7877	1	387	9	Torregalindo	9
7878	1	388	5	Torrelara	9
7879	1	389	8	Torrepadre	9
7880	1	390	2	Torresandino	9
7881	1	391	9	Tórtoles de Esgueva	9
7882	1	392	4	Tosantos	9
7883	1	394	5	Trespaderne	9
7884	1	395	8	Tubilla del Agua	9
7885	1	396	1	Tubilla del Lago	9
7886	1	398	3	Úrbel del Castillo	9
7887	1	400	0	Vadocondes	9
7888	1	403	8	Valdeande	9
7889	1	405	6	Valdezate	9
7890	1	406	9	Valdorros	9
7891	1	407	5	Valmala	9
7892	1	408	1	Vallarta de Bureba	9
7893	1	409	4	Valle de Manzanedo	9
7894	1	410	8	Valle de Mena	9
7895	1	411	5	Valle de Oca	9
7896	1	412	0	Valle de Tobalina	9
7897	1	413	6	Valle de Valdebezana	9
7898	1	414	1	Valle de Valdelaguna	9
7899	1	415	4	Valle de Valdelucio	9
7900	1	416	7	Valle de Zamanzas	9
7901	1	417	3	Vallejera	9
7902	1	418	9	Valles de Palenzuela	9
7903	1	419	2	Valluércanes	9
7904	1	421	3	Vid y Barrios, La	9
7905	1	422	8	Vid de Bureba, La	9
7906	1	423	4	Vileña	9
7907	1	424	9	Viloria de Rioja	9
7908	1	425	2	Vilviestre del Pinar	9
7909	1	427	1	Villadiego	9
7910	1	428	7	Villaescusa de Roa	9
7911	1	429	0	Villaescusa la Sombría	9
7912	1	430	4	Villaespasa	9
7913	1	431	1	Villafranca Montes de Oca	9
7914	1	432	6	Villafruela	9
7915	1	433	2	Villagalijo	9
7916	1	434	7	Villagonzalo Pedernales	9
7917	1	437	9	Villahoz	9
7918	1	438	5	Villalba de Duero	9
7919	1	439	8	Villalbilla de Burgos	9
7920	1	440	2	Villalbilla de Gumiel	9
7921	1	441	9	Villaldemiro	9
7922	1	442	4	Villalmanzo	9
7923	1	443	0	Villamayor de los Montes	9
7924	1	444	5	Villamayor de Treviño	9
7925	1	445	8	Villambistia	9
7926	1	446	1	Villamedianilla	9
7927	1	447	7	Villamiel de la Sierra	9
7928	1	448	3	Villangómez	9
7929	1	449	6	Villanueva de Argaño	9
7930	1	450	9	Villanueva de Carazo	9
7931	1	451	6	Villanueva de Gumiel	9
7932	1	454	2	Villanueva de Teba	9
7933	1	455	5	Villaquirán de la Puebla	9
7934	1	456	8	Villaquirán de los Infantes	9
7935	1	458	0	Villariezo	9
7936	1	460	7	Villasandino	9
7937	1	463	5	Villasur de Herreros	9
7938	1	464	0	Villatuelda	9
7939	1	466	6	Villaverde del Monte	9
7940	1	467	2	Villaverde-Mogina	9
7941	1	471	2	Villayerno Morquillas	9
7942	1	472	7	Villazopeque	9
7943	1	473	3	Villegas	9
7944	1	476	4	Villoruebo	9
7945	1	478	6	Vizcaínos	9
7946	1	480	3	Zael	9
7947	1	482	5	Zarzosa de Río Pisuerga	9
7948	1	483	1	Zazuar	9
7949	1	485	9	Zuñeda	9
7950	1	901	5	Iruña Oka/Iruña de Oca	1
7951	1	901	0	Pozo Cañada	2
7952	1	901	6	Poblets, els	3
7953	1	901	1	Tres Villas, Las	4
7954	1	901	4	San Juan de Gredos	5
7955	1	901	7	Valdelacalzada	6
7956	1	901	3	Ariany	7
7957	1	901	9	Rupit i Pruit	8
7958	1	901	2	Quintanilla del Agua y Tordueles	9
7959	1	901	6	Rosalejo	10
7960	1	901	3	Benalup-Casas Viejas	11
7961	1	901	8	Alquerías del Niño Perdido	12
7962	1	901	4	Robledo, El	13
7963	1	901	2	Cariño	15
7964	1	901	5	Campos del Paraíso	16
7965	1	901	1	Cruïlles,  Monells i Sant Sadurní del Heura	17
7966	1	901	7	La Taha	18
7967	1	901	0	Semillas	19
7968	1	901	4	Mendaro	20
7969	1	901	6	Valle de Hecho	22
7970	1	901	2	Cárcheles	23
7971	1	901	7	Villamanín	24
7972	1	901	0	Vall de Cardós	25
7973	1	901	9	Baralla	27
7974	1	901	5	Lozoyuela-Navas-Sieteiglesias	28
7975	1	901	8	Torremolinos	29
7976	1	901	2	Santomera	30
7977	1	901	9	Barañain	31
7978	1	901	5	Osorno la Mayor	34
7979	1	901	1	A Illa de Arousa	36
7980	1	901	3	El Pinar de El Hierro	38
7981	1	901	0	Ortigosa del Monte	40
7982	1	901	7	Cañada Rosal	41
7983	1	901	8	Deltebre	43
7984	1	901	6	Santo Domingo-Caudilla	45
7985	1	901	1	Derio	48
7986	1	901	7	Biel	50
7987	1	902	0	Lantarón	1
7988	1	902	1	Pilar de la Horadada	3
7989	1	902	6	Ejido, El	4
7990	1	902	9	Santa María del Cubillo	5
7991	1	902	2	Pueblonuevo del Guadiana	6
7992	1	902	8	Migjorn Gran, Es	7
7993	1	902	4	Vilanova del Vallès	8
7994	1	902	7	Valle de Santibáñez	9
7995	1	902	1	Vegaviana	10
7996	1	902	8	San José del Valle	11
7997	1	902	3	Sant Joan de Moró	12
7998	1	902	9	Ruidera	13
7999	1	902	0	Valdetórtola	16
8000	1	902	6	Forallac	17
8001	1	902	2	Valle, El	18
8002	1	902	9	Lasarte-Oria	20
8003	1	902	1	Puente la Reina de Jaca	22
8004	1	902	7	Bedmar y Garcíez	23
8005	1	902	2	Villaornate y Castro	24
8006	1	902	5	Sant Martí de Riucorb	25
8007	1	902	4	Burela	27
8008	1	902	0	Puentes Viejas	28
8009	1	902	3	Villanueva de la Concepción	29
8010	1	902	7	Alcázares, Los	30
8011	1	902	4	Berrioplano/Berriobeiti	31
8012	1	902	0	Valle del Retortillo	34
8013	1	902	5	Cozuelos de Fuentidueña	40
8014	1	902	2	Isla Mayor	41
8015	1	902	3	Sant Jaume Enveja	43
8016	1	902	4	Gátova	46
8017	1	902	6	Erandio	48
8018	1	902	2	Marracos	50
8019	1	903	7	Montesinos, Los	3
8020	1	903	2	Mojonera, La	4
8021	1	903	5	Diego del Carpio	5
8022	1	903	0	Sant Julià de Cerdanyola	8
8023	1	903	3	Villarcayo de Merindad de Castilla la Vieja	9
8024	1	903	7	Alagón del Río	10
8025	1	903	5	Arenales de San Gregorio	13
8026	1	903	6	Valeras, Las	16
8027	1	903	2	Sant Julià del Llor i Bonmatí	17
8028	1	903	8	Nevada	18
8029	1	903	5	Astigarraga	20
8030	1	903	7	San Miguel del Cinca	22
8031	1	903	3	Villatorres	23
8032	1	903	1	Guingueta Àneu, La	25
8033	1	903	6	Tres Cantos	28
8034	1	903	0	Berriozar	31
8035	1	903	6	Loma de Ucieza	34
8036	1	903	1	Marazoleja	40
8037	1	903	8	Cuervo de Sevilla, El	41
8038	1	903	9	Camarles	43
8039	1	903	0	San Antonio de Benagéber	46
8040	1	903	2	Loiu	48
8041	1	903	8	Villamayor de Gállego	50
8042	1	904	2	San Isidro	3
8043	1	904	0	Santiago del Tormes	5
8044	1	904	5	Badia del Vallès	8
8045	1	904	8	Valle de las Navas	9
8046	1	904	0	Llanos del Caudillo	13
8047	1	904	1	Fuentenava de Jábaga	16
8048	1	904	3	Alpujarra de la Sierra	18
8049	1	904	0	Baliarrain	20
8050	1	904	2	Sotonera, La	22
8051	1	904	8	Santiago-Pontones	23
8052	1	904	6	Castell de Mur	25
8053	1	904	5	Irurtzun	31
8054	1	904	1	Pernía, La	34
8055	1	904	6	Navas de Riofrío	40
8056	1	904	4	Aldea, 	43
8057	1	904	5	Benicull de Xúquer	46
8058	1	904	7	Sondika	48
8059	1	905	3	Villanueva de Ávila	5
8060	1	905	8	Palma de Cervelló, La	8
8061	1	905	1	Valle de Sedano	9
8062	1	905	4	Arcas del Villar	16
8063	1	905	6	Gabias, Las	18
8064	1	905	3	Orendain	20
8065	1	905	5	Lupiñén-Ortilla	22
8066	1	905	1	Arroyo del Ojanco	23
8067	1	905	9	Ribera Ondara	25
8068	1	905	8	Beriáin	31
8069	1	905	9	Cuevas de Provanco	40
8070	1	905	7	Salou	43
8071	1	905	0	Zamudio	48
8072	1	906	4	Merindad de Río Ubierna	9
8073	1	906	7	Valdecolmenas, Los	16
8074	1	906	9	Guajares, Los	18
8075	1	906	6	Altzaga	20
8076	1	906	8	Santa María de Dulcis	22
8077	1	906	2	Valls Aguilar, Les	25
8078	1	906	1	Orkoien	31
8079	1	906	2	San Cristóbal de Segovia	40
8080	1	906	0	Ampolla, 	43
8081	1	906	3	Forua	48
8082	1	907	0	Alfoz de Quintanadueñas	9
8083	1	907	5	Valle del Zalabí	18
8084	1	907	2	Gaztelu	20
8085	1	907	4	Aínsa-Sobrarbe	22
8086	1	907	8	Torrefeta i Florejacs	25
8087	1	907	7	Zizur Mayor/Zizur Nagusia	31
8088	1	907	6	Canonja, La	43
8089	1	907	9	Kortezubi	48
8090	1	908	6	Valle de Losa	9
8091	1	908	9	Pozorrubielos de la Mancha	16
8092	1	908	1	Villamena	18
8093	1	908	0	Hoz y Costean	22
8094	1	908	4	Fígols i Alinyà	25
8095	1	908	3	Lekunberri	31
8096	1	908	5	Murueta	48
8097	1	909	2	Sotorribas	16
8098	1	909	4	Morelábor	18
8099	1	909	3	Vencillón	22
8100	1	909	7	Vansa i Fórnols, La	25
8101	1	909	8	Nabarniz	48
8102	1	910	6	Villar y Velasco	16
8103	1	910	8	Pinar, El	18
8104	1	910	1	Josa i Tuixén	25
8105	1	910	2	Iurreta	48
8106	1	911	5	Vegas del Genil	18
8107	1	911	8	Plans de Sió, Els	25
8108	1	911	9	Ajangiz	48
8109	1	912	0	Cuevas del Campo	18
8110	1	912	3	Gimenells i el Pla de la Font	25
8111	1	912	4	Alonsotegi	48
8112	1	913	6	Zagra	18
8113	1	913	9	Riu de Cerdanya	25
8114	1	913	0	Zierbena	48
8115	1	914	5	Arratzu	48
8116	1	915	8	Ziortza-Bolibar	48
\.


--
-- Data for Name: provincia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provincia (id, version, nombre, comunidad_id) FROM stdin;
2	1	Albacete	8
3	1	Alicante	10
4	1	Almería	1
1	1	Álava	16
33	1	Asturias	3
5	1	Ávila	7
6	1	Badajoz	11
7	1	Islas Baleares	4
8	1	Barcelona	9
48	1	Vizcaya	16
9	1	Burgos	7
10	1	Cáceres	11
11	1	Cádiz	1
39	1	Cantabria	6
12	1	Castellón	10
51	1	Ceuta	18
13	1	Ciudad Real	8
14	1	Córdoba	1
15	1	La Coruña	12
16	1	Cuenca	8
20	1	Guipúzcoa	16
17	1	Gerona	9
18	1	Granada	1
19	1	Guadalajara	8
21	1	Huelva	1
22	1	Huesca	2
23	1	Jaén	1
24	1	León	7
27	1	Lugo	12
25	1	Lérida	9
28	1	Madrid	13
29	1	Málaga	1
52	1	Melilla	19
30	1	Murcia	14
31	1	Navarra	15
32	1	Orense	12
34	1	Palencia	7
35	1	Las Palmas	5
36	1	Pontevedra	12
26	1	La Rioja	17
37	1	Salamanca	7
38	1	Santa Cruz de Tenerife	5
40	1	Segovia	7
41	1	Sevilla	1
42	1	Soria	7
43	1	Tarragona	9
44	1	Teruel	2
45	1	Toledo	8
46	1	Valencia	10
47	1	Valladolid	7
49	1	Zamora	7
50	1	Zaragoza	2
\.


--
-- Data for Name: vivienda; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vivienda (id, version, calle, comunidad, descripcion, fecha_publicacion, municipio, nombre, numero, numero_habitaciones, precio_mensual, provincia, tipo_vivienda, ultima_edicion, anunciante_id) FROM stdin;
\.


--
-- Name: domain_entity_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.domain_entity_seq', 1, true);


--
-- Name: municipio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.municipio_id_seq', 8116, true);


--
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id);


--
-- Name: anunciante anunciante_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anunciante
    ADD CONSTRAINT anunciante_pkey PRIMARY KEY (id);


--
-- Name: comunidad comunidad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comunidad
    ADD CONSTRAINT comunidad_pkey PRIMARY KEY (id);


--
-- Name: estudiante estudiante_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudiante
    ADD CONSTRAINT estudiante_pkey PRIMARY KEY (id);


--
-- Name: foto_vivienda foto_vivienda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foto_vivienda
    ADD CONSTRAINT foto_vivienda_pkey PRIMARY KEY (id);


--
-- Name: municipio municipio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT municipio_pkey PRIMARY KEY (id);


--
-- Name: provincia provincia_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provincia
    ADD CONSTRAINT provincia_pkey PRIMARY KEY (id);


--
-- Name: vivienda vivienda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vivienda
    ADD CONSTRAINT vivienda_pkey PRIMARY KEY (id);


--
-- Name: municipio fk4ud8nsel0i9ti2kr3hboxrosg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.municipio
    ADD CONSTRAINT fk4ud8nsel0i9ti2kr3hboxrosg FOREIGN KEY (provincia_id) REFERENCES public.provincia(id);


--
-- Name: vivienda fk6o48oojyay21y804viv1qvhks; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vivienda
    ADD CONSTRAINT fk6o48oojyay21y804viv1qvhks FOREIGN KEY (anunciante_id) REFERENCES public.anunciante(id);


--
-- Name: foto_vivienda fk9jciucqnknrwvo1l0vevxelk0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.foto_vivienda
    ADD CONSTRAINT fk9jciucqnknrwvo1l0vevxelk0 FOREIGN KEY (vivienda_id) REFERENCES public.vivienda(id);


--
-- Name: provincia fkn399f98rdg8t13vnot56kxfx2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provincia
    ADD CONSTRAINT fkn399f98rdg8t13vnot56kxfx2 FOREIGN KEY (comunidad_id) REFERENCES public.comunidad(id);


--
-- Name: estudiante fkpvj6lss9xvt9oywx182km5cu9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estudiante
    ADD CONSTRAINT fkpvj6lss9xvt9oywx182km5cu9 FOREIGN KEY (vivienda_id) REFERENCES public.vivienda(id);


--
-- PostgreSQL database dump complete
--

