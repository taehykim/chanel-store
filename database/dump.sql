--
-- PostgreSQL database dump
--

-- Dumped from database version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)

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

ALTER TABLE IF EXISTS ONLY public.products DROP CONSTRAINT IF EXISTS products_pkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_pkey;
ALTER TABLE IF EXISTS ONLY public.categories DROP CONSTRAINT IF EXISTS category_pkey;
ALTER TABLE IF EXISTS ONLY public.carts DROP CONSTRAINT IF EXISTS carts_pkey;
ALTER TABLE IF EXISTS ONLY public."cartItems" DROP CONSTRAINT IF EXISTS "cartItems_pkey";
ALTER TABLE IF EXISTS public.products ALTER COLUMN "productId" DROP DEFAULT;
ALTER TABLE IF EXISTS public.orders ALTER COLUMN "orderId" DROP DEFAULT;
ALTER TABLE IF EXISTS public.categories ALTER COLUMN "categoryId" DROP DEFAULT;
ALTER TABLE IF EXISTS public.carts ALTER COLUMN "cartId" DROP DEFAULT;
ALTER TABLE IF EXISTS public."cartItems" ALTER COLUMN "cartItemId" DROP DEFAULT;
DROP SEQUENCE IF EXISTS public."products_productId_seq";
DROP TABLE IF EXISTS public.products;
DROP SEQUENCE IF EXISTS public."orders_orderId_seq";
DROP TABLE IF EXISTS public.orders;
DROP SEQUENCE IF EXISTS public."category_categoryId_seq";
DROP TABLE IF EXISTS public.categories;
DROP SEQUENCE IF EXISTS public."carts_cartId_seq";
DROP TABLE IF EXISTS public.carts;
DROP SEQUENCE IF EXISTS public."cartItems_cartItemId_seq";
DROP TABLE IF EXISTS public."cartItems";
DROP EXTENSION IF EXISTS plpgsql;
DROP SCHEMA IF EXISTS public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cartItems; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."cartItems" (
    "cartItemId" integer NOT NULL,
    "cartId" integer NOT NULL,
    "productId" integer NOT NULL,
    price integer NOT NULL
);


--
-- Name: cartItems_cartItemId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."cartItems_cartItemId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cartItems_cartItemId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."cartItems_cartItemId_seq" OWNED BY public."cartItems"."cartItemId";


--
-- Name: carts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.carts (
    "cartId" integer NOT NULL,
    "createdAt" timestamp(6) with time zone DEFAULT now() NOT NULL
);


--
-- Name: carts_cartId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."carts_cartId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: carts_cartId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."carts_cartId_seq" OWNED BY public.carts."cartId";


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    "categoryId" integer NOT NULL,
    name text NOT NULL
);


--
-- Name: category_categoryId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."category_categoryId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: category_categoryId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."category_categoryId_seq" OWNED BY public.categories."categoryId";


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    "orderId" integer NOT NULL,
    "cartId" integer NOT NULL,
    name text NOT NULL,
    "creditCard" text NOT NULL,
    "shippingAddress" text NOT NULL,
    "createdAt" timestamp(6) with time zone DEFAULT now() NOT NULL
);


--
-- Name: orders_orderId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."orders_orderId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_orderId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."orders_orderId_seq" OWNED BY public.orders."orderId";


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    "productId" integer NOT NULL,
    name text NOT NULL,
    price integer NOT NULL,
    image text NOT NULL,
    "shortDescription" text NOT NULL,
    "longDescription" text NOT NULL,
    "categoryId" integer NOT NULL
);


--
-- Name: products_productId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."products_productId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_productId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."products_productId_seq" OWNED BY public.products."productId";


--
-- Name: cartItems cartItemId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."cartItems" ALTER COLUMN "cartItemId" SET DEFAULT nextval('public."cartItems_cartItemId_seq"'::regclass);


--
-- Name: carts cartId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts ALTER COLUMN "cartId" SET DEFAULT nextval('public."carts_cartId_seq"'::regclass);


--
-- Name: categories categoryId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN "categoryId" SET DEFAULT nextval('public."category_categoryId_seq"'::regclass);


--
-- Name: orders orderId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN "orderId" SET DEFAULT nextval('public."orders_orderId_seq"'::regclass);


--
-- Name: products productId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN "productId" SET DEFAULT nextval('public."products_productId_seq"'::regclass);


--
-- Data for Name: cartItems; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."cartItems" ("cartItemId", "cartId", "productId", price) FROM stdin;
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.carts ("cartId", "createdAt") FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories ("categoryId", name) FROM stdin;
1	sunglasses
2	sun protection
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders ("orderId", "cartId", name, "creditCard", "shippingAddress", "createdAt") FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products ("productId", name, price, image, "shortDescription", "longDescription", "categoryId") FROM stdin;
1	rectangle sunglasses	51500	https://www.chanel.com/images/t_fashionzoom1/f_jpg/rectangle-sunglasses-black-gold-acetate-acetate-packshot-default-a71377x08101s2216-8830542807070.jpg	Acetate	00% UVA and UVB Protection CE - Lenses are UV Category Filter 3 - Prescription friendly Made in Italy	1
2	square sunglasses	52000	https://www.chanel.com/images/t_fashionzoom1/f_jpg/square-sunglasses-black-white-acetate-acetate-packshot-default-a71203x08101s6621-8826443497502.jpg	Acetate	100% UVA and UVB Protection CE - Lenses are UV Category Filter 3 - Prescription friendly Made in Italy	1
3	oval sunglasses	114000	https://www.chanel.com/images/t_fashionzoom1/f_jpg/oval-sunglasses-transparent-metal-acetate-resin-glass-pearls-metal-acetate-resin-glass-pearls-packshot-default-a71356x06086s6057-8824934563870.jpg	Metal, Acetate, Resin & Glass Pearls	100% UVA and UVB Protection CE - Lenses are UV Category Filter 3 Made in Italy	1
4	butterfly sunglasses	52000	https://www.chanel.com/images/t_fashionzoom1/f_jpg/butterfly-sunglasses-black-gray-acetate-acetate-packshot-default-a71347x08101s6414-8826438844446.jpg	Acetate	100% UVA and UVB Protection CE - Lenses are UV Category Filter 3 - Prescription friendly Made in Italy	1
5	round sunglasses	62500	https://www.chanel.com/images/t_fashionzoom1/f_jpg/round-sunglasses-black-acetate-strass-acetate-strass-packshot-default-a71350x08902s0128-8822364471326.jpg	Acetate & Strass	100% UVA and UVB Protection CE - Lenses are UV Category Filter 3 - Polarized - Prescription friendly Made in Italy	1
6	pilot sunglasses	62500	https://www.chanel.com/images/t_fashionzoom1/f_jpg/pilot-sunglasses-black-acetate-strass-acetate-strass-packshot-default-a71354x08902s0128-8822365487134.jpg	Acetate & Strass	100% UVA and UVB Protection CE - Lenses are UV Category Filter 3 - Polarized - Prescription friendly Made in Italy	1
7	uv essentiel	5500	https://www.chanel.com/images///w_0.51,h_0.51,c_crop/q_auto,f_jpg,fl_lossy,dpr_2/w_620/uv-essentiel-complete-protection-antioxidant-anti-pollution-br-sunscreen-broad-spectrum-spf-50-1fl-oz--packshot-default-141876-8824189583390.jpg	Complete Protection Antioxidant Anti-Pollution	Sunscreen Broad Spectrum SPF 50	2
8	cc cream	5500	https://www.chanel.com/images///w_0.43,h_0.43,c_crop/q_auto,f_jpg,fl_lossy,dpr_2/w_620/cc-cream-super-active-complete-correction-sunscreen-broad-spectrum-spf-50-40-beige-1fl-oz--packshot-default-140586-8824189911070.jpg	Super Active Complete Correction	Sunscreen Broad Spectrum SPF 50	2
\.


--
-- Name: cartItems_cartItemId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."cartItems_cartItemId_seq"', 1, false);


--
-- Name: carts_cartId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."carts_cartId_seq"', 1, false);


--
-- Name: category_categoryId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."category_categoryId_seq"', 2, true);


--
-- Name: orders_orderId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."orders_orderId_seq"', 1, false);


--
-- Name: products_productId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."products_productId_seq"', 8, true);


--
-- Name: cartItems cartItems_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."cartItems"
    ADD CONSTRAINT "cartItems_pkey" PRIMARY KEY ("cartItemId");


--
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY ("cartId");


--
-- Name: categories category_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT category_pkey PRIMARY KEY ("categoryId");


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY ("orderId");


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY ("productId");


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

