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

ALTER TABLE IF EXISTS ONLY public.categories DROP CONSTRAINT IF EXISTS stores_pkey;
ALTER TABLE IF EXISTS ONLY public.products DROP CONSTRAINT IF EXISTS products_pkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_pkey;
ALTER TABLE IF EXISTS ONLY public.carts DROP CONSTRAINT IF EXISTS carts_pkey;
ALTER TABLE IF EXISTS ONLY public."cartItems" DROP CONSTRAINT IF EXISTS "cartItems_pkey";
ALTER TABLE IF EXISTS public.stores ALTER COLUMN "storeId" DROP DEFAULT;
ALTER TABLE IF EXISTS public.products ALTER COLUMN "productId" DROP DEFAULT;
ALTER TABLE IF EXISTS public.orders ALTER COLUMN "orderId" DROP DEFAULT;
ALTER TABLE IF EXISTS public.carts ALTER COLUMN "cartId" DROP DEFAULT;
ALTER TABLE IF EXISTS public."cartItems" ALTER COLUMN "cartItemId" DROP DEFAULT;
DROP SEQUENCE IF EXISTS public."products_productId_seq";
DROP TABLE IF EXISTS public.products;
DROP SEQUENCE IF EXISTS public."orders_orderId_seq";
DROP TABLE IF EXISTS public.orders;
DROP TABLE IF EXISTS public.categories;
DROP SEQUENCE IF EXISTS public."stores_storeId_seq";
DROP TABLE IF EXISTS public.stores;
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
-- Name: stores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stores (
    "storeId" integer NOT NULL,
    name text NOT NULL
);


--
-- Name: stores_storeId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public."stores_storeId_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stores_storeId_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public."stores_storeId_seq" OWNED BY public.stores."storeId";


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    "categoryId" integer DEFAULT nextval('public."stores_storeId_seq"'::regclass) NOT NULL,
    name text NOT NULL
);


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
    "storeId" integer NOT NULL
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
-- Name: orders orderId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN "orderId" SET DEFAULT nextval('public."orders_orderId_seq"'::regclass);


--
-- Name: products productId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN "productId" SET DEFAULT nextval('public."products_productId_seq"'::regclass);


--
-- Name: stores storeId; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stores ALTER COLUMN "storeId" SET DEFAULT nextval('public."stores_storeId_seq"'::regclass);


--
-- Data for Name: cartItems; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."cartItems" ("cartItemId", "cartId", "productId", price) FROM stdin;
1	7	2999	1
2	8	1	2999
3	9	2	2595
4	10	3	2900
5	10	3	2900
6	10	2	2595
7	10	2	2595
8	10	1	2999
9	11	1	2999
10	11	2	2595
11	11	1	2999
12	11	4	999
13	11	3	2900
14	11	5	9900
15	12	1	2999
16	13	2	2595
17	14	2	2595
18	15	2	2595
19	16	2	2595
20	16	4	999
21	16	6	830
22	17	1	2999
23	18	3	2900
24	18	3	2900
25	18	3	2900
26	19	24	1599
27	20	50	7490
28	20	47	7490
29	21	23	1499
30	21	23	1499
31	22	22	1499
32	22	22	1499
33	22	31	1800
34	23	22	1499
35	23	34	1800
36	23	28	1499
37	23	22	1499
38	24	22	1499
39	24	22	1499
\.


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.carts ("cartId", "createdAt") FROM stdin;
1	2020-09-29 18:15:27.999464+00
2	2020-09-29 18:16:17.887229+00
3	2020-09-29 18:23:02.866611+00
4	2020-09-29 18:26:16.523426+00
5	2020-09-29 18:26:47.629347+00
6	2020-09-29 18:28:06.490349+00
7	2020-09-29 18:28:36.120587+00
8	2020-09-29 18:30:39.115846+00
9	2020-09-29 18:31:42.106273+00
10	2020-09-29 18:37:41.160774+00
11	2020-09-29 20:18:29.701122+00
12	2020-09-30 00:22:20.045476+00
13	2020-09-30 00:27:27.355589+00
14	2020-09-30 00:31:15.648955+00
15	2020-09-30 00:34:35.022882+00
16	2020-09-30 02:08:17.795362+00
17	2020-09-30 02:11:57.432597+00
18	2020-10-12 21:53:43.628131+00
19	2020-10-13 22:29:45.002682+00
20	2020-10-14 23:20:17.362248+00
21	2020-10-15 16:56:28.991719+00
22	2020-10-15 17:31:36.765329+00
23	2020-10-16 00:00:30.386695+00
24	2020-10-16 07:34:04.343257+00
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
2	10	Tia Kim	007	irvine	2020-09-29 23:48:00.158686+00
3	12	Tia Kim	111	irvine	2020-09-30 00:25:54.275268+00
4	13	Tia Kim	111	irvine, ca	2020-09-30 00:28:59.799197+00
5	14	Tia Kim	111	irvine, ca	2020-09-30 00:31:18.702547+00
6	15	Olivia Kim	111	irvine, ca	2020-09-30 00:34:57.418739+00
7	11	Tia Kim	0000 0000 0000 0000	Irvine, CA 91000	2020-09-30 02:05:47.021233+00
8	16	Mimi Kim	1234 1234 1234 1234	San Diego, CA	2020-09-30 02:11:00.137721+00
9	17	Tia 	1234	Irvine, CA	2020-09-30 02:14:38.434189+00
10	21	Christmasi Kim	1234 0000 0000 0000	123 Snow St, Newport CA 92606	2020-10-15 16:58:41.788717+00
11	23	Apple Kim	1234 1234 1234 1234	777 Hello St, Irvine, CA 92010	2020-10-15 23:58:59.832964+00
12	23	Tia Kim	0000 0000 0000 0000	Test	2020-10-16 00:16:30.447575+00
13	24	s	s	s	2020-10-16 07:40:55.081335+00
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products ("productId", name, price, image, "shortDescription", "longDescription", "storeId") FROM stdin;
22	Whole Bean Intenso Coffee - Dark Roast	1499	https://www.illy.com/dw/image/v2/BBDD_PRD/on/demandware.static/-/Sites-masterCatalog_illycaffe/default/dwfac4df3f/products/Coffee/Coffee-Beans/8839ST_coffee_whole-bean_intenso/whole-bean-intenso-dark-roast-coffee-centered-view.jpg?sw=800	Intenso (Dark Roast)	Intenso, bold roast coffee has a pleasantly robust finish, with warm notes of cocoa and dried fruit.	1
23	Whole Bean Classico Coffee - Medium Roast	1499	https://www.illy.com/dw/image/v2/BBDD_PRD/on/demandware.static/-/Sites-masterCatalog_illycaffe/default/dw7627ba2b/products/Coffee/Coffee-Beans/8841ST_coffee_whole-bean_classico/whole-bean-medium-roast-coffee-center.jpg?sw=800	Classico (Medium Roast)	Classico, classic roast coffee has a lingering sweetness and delicate notes of caramel, orange blossom and jasmine.	1
24	Whole Bean Decaffeinated Classico Coffee	1599	https://www.illy.com/dw/image/v2/BBDD_PRD/on/demandware.static/-/Sites-masterCatalog_illycaffe/default/dw6482cc44/products/Coffee/Coffee-Beans/7646ME_coffee_whole-beans_can-decaffeinated_illy-shop/7646_001-new.jpg?sw=900	Classico (Medium Roast)	Classico, classic roast coffee has a lingering sweetness and delicate notes of caramel, orange blossom and jasmine.	1
25	Arabica Selection Whole Bean Colombia	1499	https://www.illy.com/dw/image/v2/BBDD_PRD/on/demandware.static/-/Sites-masterCatalog_illycaffe/default/dw97c7301b/products/Coffee/Coffee-Beans/6989ST_coffee_whole-bean_arabica-selection_colombia/arabica-selection-colombia-whole-bean-coffee.jpg?sw=900	Colombia - Medium Intensity	Smooth taste with fruit notes.	1
26	Arabica Selection Whole Bean Etiopia	1499	https://www.illy.com/dw/image/v2/BBDD_PRD/on/demandware.static/-/Sites-masterCatalog_illycaffe/default/dw44170bb4/products/Coffee/Coffee-Beans/6991ST_coffee_whole-bean_arabica-selection_ethiopia/arabica-selection-etiopia-whole-bean-coffee.jpg?sw=900	Etiopia- Delicate Intensity	Delicate and aromatic with gentle notes of jasmine.	1
27	Arabica Selection Whole Bean Guatemala	1499	https://www.illy.com/dw/image/v2/BBDD_PRD/on/demandware.static/-/Sites-masterCatalog_illycaffe/default/dw51ee0c82/products/Coffee/Coffee-Beans/6990ST_coffee_whole-bean_arabica-selection_guatemala/arabica-selection-guatemala-whole-bean-coffee.jpg?sw=900	Guatemala - Bold Intensity	Complex and balanced, with notes of chocolate.	1
28	Arabica Selection Whole Bean Brasile	1499	https://www.illy.com/dw/image/v2/BBDD_PRD/on/demandware.static/-/Sites-masterCatalog_illycaffe/default/dwb01f1be4/products/Coffee/Coffee-Beans/6992ST_coffee_whole-bean_arabica-selection_brazil/arabica-selection-brasile-whole-bean-coffee.jpg?sw=900	Brasile - Intense Taste	Intense and full flavored, with notes of caramel	1
29	Arabica Selection Whole Bean India	1499	https://www.illy.com/dw/image/v2/BBDD_PRD/on/demandware.static/-/Sites-masterCatalog_illycaffe/default/dwa65401f3/products/Coffee/Coffee-Beans/8973ST_coffee_whole-bean_arabica-selection_india/india-whole-bean_1000x1000.jpg?sw=900	India - Full Bodied	A full-bodied taste and intense aroma with distinctive notes of black pepper and extra-dark chocolate.	1
30	Arabica Selection Origins of Taste 5-Can Bundle	7495	https://www.illy.com/dw/image/v2/BBDD_PRD/on/demandware.static/-/Sites-masterCatalog_illycaffe/default/dw4dacc21e/products/Others/GiftBoxes/US_Bundles/D042_ArabicaSelectionBundle.png?sw=900		This bundle contains five 8.8oz cans of whole bean coffee.	1
37	JACOB'S WONDERBAR	1800	https://images-na.ssl-images-amazon.com/images/I/71eA6KtAdzL._SL1500_.jpg	BLEND: Darker AROMAS: Dark Chocolate, Smoke, Nuts ACIDITY: Low BODY: Full	Named in honor of Phil’s only son, Jacob. Each memorable sip boasts delicious layers of nuts and chocolate filled with a full-bodied flavor. Jacob’s Wonderbar has become a dark roast favorite!	2
34	Hazelnut	1800	data:image/jpeg;base64,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	BLEND: Varietals, AROMAS: Hazelnut Flavor, Almond, Milk Chocolate ACIDITY: Low BODY: Medium	As the name implies, our Hazelnut provides its namesake flavor along with a rich and creamy body. Its aroma is sure warm your soul and put a smile on your face. Contains artificial hazelnut flavor.	2
36	Ecstatic	1800	data:image/jpeg;base64,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	BLEND: Darker AROMAS: Chocolate, Syrup, Caramel ACIDITY: Medium Body: Full	We use this blend to make our Ecstatic Iced Coffee, which is the base of all of our specialty iced coffee drinks. With a balanced combination of bittersweet cocoa, a dense syrupy body and a subtle citris finish, it pairs deliciously with cream and sugar. Try it as iced coffee or your favorite way at home!	2
38	TESORA (4LB BAG, WHOLE BEAN ONLY)	7200	https://d2lnr5mha7bycj.cloudfront.net/product-image/file/large_9c8dc474-94a9-4265-a560-2f47f21b6a9e.jpg	BLEND: Medium AROMAS: Caramel, Nuts, Butter ACIDITY: Medium BODY: Full	Seven years in the making and the first blend created by Phil himself, the Tesora is the quintessential Philz blend. If it is your first time visiting Philz coffee, we highly recommend you order our Tesora blend. Tesora, A grand representation of our coffee and the way coffee should taste!	2
33	Red Sea	1800	data:image/jpeg;base64,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	BLEND: Darker AROMAS: Berry Jam, Bittersweet Dark Chocolate, Malty ACIDITY: Medium BODY: Full	Our beloved and bold Red Sea is back for a limited time. Flavors of berry jam, dark chocolate and subtle malty finish shine through this darker roasted blend. It's a perfect work from home treat. Our beloved Red Sea is back for a limited time. Flavors of berry jam, dark chocolate and subtle malty finish shine through this bold darker roast. It's a perfect work from home treat.	2
31	GREAT OUTDOORS	1800	data:image/jpeg;base64,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	BLEND: Darker AROMAS: Rich, Dark Chocolate, Buttery Roast, Smokey, Syrupy	This year of change has us pining for the fresh air, roasting marshmallows at the campgrounds and enjoying the bliss of nature. Bring home our online exclusive, sip on this delicious buttery, chocolatey blend and be reminded of better days in the great outdoors.	2
35	Dancing Water	1800	data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxQSEhUTExITFhUXFRcZFxgXGBYYHBoZGhoXFxYYGBgYHSggGBolHRgYIjIhJSkrLjouFx8zODMtNygwLisBCgoKDg0OGxAQGy0mICUtLS01LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLf/AABEIAOEA4QMBIgACEQEDEQH/xAAcAAEAAgMBAQEAAAAAAAAAAAAABQYDBAcCAQj/xAA8EAABAwIEBAQCCgAGAgMAAAABAAIRAyEEBRIxBkFRYRMicYEykQcUI0JSobHB0fBicpKi4fEVgjOy4v/EABgBAQEBAQEAAAAAAAAAAAAAAAACAQME/8QAIhEBAQADAAIDAAIDAAAAAAAAAAECESEDEjFBUWFxIjJC/9oADAMBAAIRAxEAPwDuKIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIoPibiWlg6Zc8y6+lgNyYJHoOU91XsLx5Us6pRaabtvDJ1ActzDj8lmzS+otfA41lZgqU3BzSLEfoRyPZbC0EREBERAREQEREBERAREQEREBERARVvifipmG8jRrqnlyb0Lv4XOs345xDfMa5a4/CxsCfb91PtN6V63W3aUVH4A4xfigKVdsVNNnDZ8RM9/TurwtlSIijM9zqlhaZqVTA2AG5PQDqtGfMcxZRaXPdA/uwVWyrjoVsU2h4YDXGGmbzynsqBxVxx4zrD06D+T+Xqq5kmdOo4iliXse5oc4tg6Q5zQLSRcAubMdVO6rT9Lry82XJX/AEg4h4kDTOwAj89ytYcb4oGdZPYxHonszT3xezXia2omQ4AT+GBEdt1XMFjPq7yxxLqRF4vp7iT137L3nHFbqlVr6tKCRoqOZ95v3TB+8L84jput+phqVSl5TYyA7YzsQRuD2Uq+kplGduwtQPYfJMPZNnN7f4uYXW8NXbUY17TLXNDmkcwRIPyX5zDqtNwp6dUkNbuTNmtAHUm0Tz9l33hrBuo4WjSeZc2m0O533IHYGw9FWPE27SaIipgiIgIiICIiAiIgIiICIiAoXirOPq1EuF3E6WD/ABGb+gAJ9u6mlQvpQpvFNlZrS5tMu1AdHRB9JbH/ALKct643HW+ufZ1jnN8xJdVefLq5ncuM8oWjl2TazqqnUbe//HZfMqwxrvNSpvPlabf2FKZtmrMM251VI8rAZ93dFy7OR25e1PcNgMxlKC1jKTXVahNg1uksu7YSXc/wlTua/SG1pig1rm/jdMesCLfmuQ0sTVeHF7jDjqcPTbVzMcgsGPzC2kWHNXNyOeXa/RHCvEdPHU3VKYI0uLSD8wqv9LVGg+ixtWv4b9U0wAHFx2PlLmjY7kgCVDcBZ7Sy/BN1hz6lVxe8CPKNmjuYv2JIMEEKB4zzAYuvWdqloNPwx0pupse0wepcTfmVvtKy42IvhnAYNtUHHeNp1eXTpNMjrUDSXRt8JIurN9J2Fp1Tg24Tw3NYyramWw1rvBc2YNpEke6puW6GSaklgjy9TO46TzUnUzoRDYa21pWZXSscds+CpPZDXNbMT0gbe/svuLqAXIgDeAb+xv7rVr5tSgeZs372PotSpn40kAEjoRb/APKyWlkaGPr6pA5/0LrOeZPgmYalUxOqlXdTZLqciq5+gTLR8RmZ1Wk3XOuHsBpP/kKjw2lQqNOhph9SrZzaY5Bhm+/lDrKRrY5+KqGrUMuJ9mjk1vYJllqNww9q3Mlr08PXFUMfVg+U4hwLh3DWQ0H5wutZBn9PFDyyHDdp/Y8wuNY2o1je8Dv7W2WzwjnBw+I1XPkdAg3fAgdgpxzv2vPCf8u5kr6uOVs/xFR73Vahsf8A42+UNbMAgz5uswprLs8rU7h5cJ2cdQM99wtvmkrJ4LY6Sij8nzVmIZLbOEam8xO3seRUgusss3HGyy6oiItYIiICIiAiIgIiICxVaIcsqg+JuI2YNgLruPwt69z2WUjQx/AuGqv16XMPPw3lgPqAsGdcD0HYWrQo02Ui8We0XkEOEu3IJG0qqY/jXGVD5HimP8LWn/7AqJq8X5iyD9ZkdCykZ9YbKj2jr6VDZpwjmFMuaMOdAm4fT0lovLiXC1pvCw5NkADPHrGwj5nYeqmMz48q4qloqhrYs4MsHEGQSDeO08lWcfmTn7mYFu3ooytvI6YYydqSxGP8WpDRDRAAWth3OpVtNSCIjltyI+Z+ajcoqy5wUnnJ1NY/m0xb/b+4V4zXHLPK5VjzjBNa5tQOIpkyRvcco7rTZWok/C6T/l/hWHN2NdhpDdwD3j+VXm4Nrvg8pDve3crWbbP1S3lYJPV3/CxYPCOqOLXhrQN9Uk26XXmljHMOioCL2JETCkGu8QXsRs79vRLjzhMu9StLKC7D+B4p0mp4kki50BoHoAD81loUfC8piW/n3VewuavbaYI/RZ//ACZduTK4X2+3pkxrxi8dqrBry9upw1HcgE+YgHe23oFcMfhcPSwtGphXF4FQCq5xGrU5hALhyvsBa5VZoYppqM1AEkx8+62a+CeSW03FhNngEgROzhz22W73NM1q72kqzfFIc0DW0cwIcOY7pgsfcs0uAbFzs2bRPNvSV4bhfCbLqhsJmyjqeMbWcRHmE6XEfEPvNMciudwutuk8mNuot2S5saNZtUGxOl3QskSe/VdWY6QCNiuDMcGQNUNLSRM2cIloJ3AkfNdtyUnwKWrfQ2fku3hv04eefFbyIi7vOIiICIiAiIgIiFB8cVyz6RqLqldhaQRojcWMm3qrFxjnxZ9kwwY8xH6KkNxDSZqOgXv/AB7rz+Ty91Hp8Xh57VGtmnc9CJv/AN+6j8ZmjC2GuPObfldS2aZk0jTYX5bx16BQ+X8IYjGlz8Po0h0Ol0XidvQrMLbyqzkk3FYfUPiAtbqOoEtMw4AyWmLwdrQbq5Zrl+ErajRw7cPRaT9o59Rz3wdmtLyBPcE+i+cScB1cvoNxAeHkT4kW0yfLpB3HVU2rjnO3JPT/AKXW7cZY3MVi6bHtFNsNBIJO57lS2Gb4ksOzhb13BVXGFe65BA6q0UqbA5jMJUdWOkDQ8eG/XYECTpcOdjtbuU0zKV6yesNL6DzIAMdrTuoSixzIJBDXc55/taLLbzTB4ig5rK7PCNRv3omARqgAmNwFvVaodS8MubpjtP8A33S3RjjtFY5utsG5FxG/otXD4xzBzcOUg2/t/kvNevosHatx/YXzDNfVLW7DZVvm0+t3qNjLcFXxVUso03VH6S6AQLAgE3IG7gtnHZRisO0urUH0wDBLoF+1/N7SrXwj4eBrPxD5IpUCNLTJdUqOa2mwciTDuw3OyisdjamLrmpiXanfdbMMYJ+FoPIfMwp5er7jyILJQ6rWaB16TA5mCr3W8OkwudZsXvdx533JVXweKp0qxJLQIMEGdv5gr1UxTsQ7xHjS1sQ2evPdZZ+Nl/WR9SpiidTi2kD8Ptue5WxhqRJbQotGp5AAtLjuL/stPGY4EBrRpA9p/t1l4ezWtSrNq0tILJjUNTSDYgjpfkQe6aLVndkX1Ngr48iBUHh0GGS9+nm62n4RMfh9FvYbjDGPl+sNG4aGtIA6XEn3UBx7n78X9XcaenwvE1QZaS/RBHP7mx2nmsmQ49paGmL9ZUZc5F43c3XReGeMfFIp1oDjYO2BPforkuEYhxbUnbnIXWuDsz8fDtky5vlPtsfkrwyvxXPyYydidREXVyEREBERAXmpsvSIOTccU3MrOJm5JHof+iqRjMbpImO0/wB3XeM7ySniGw8ehFiPRcX41yahTq6KdYkD4y4CGnoCDL3dgPdee+Pu3px83+OldfjC5wDZLiYAG8ldr4MwFPL8A5z3tLg11asQZiGyRY/daI9lxOhR28GkSRMvdck9uTfb5rA+piGOPxtBBa4AmC1wLXNcBuC0ke6rGSJz9so382zGpjHvfiHVJJEaZLR1aGOdYAzF9uu628myNgE7nqfy9FuZhgqmHY2o+m+ph3BrmVWAEhpEtbVAs14BE8rWUXlWc6Q4AmO9iehIWeTdivFZKmcRl8CYtt0UHmWXjf3stnFZ842myia+ONR2kcyuWON3x6M85rrHVJrVXPrVXPcQBqeS5xAEAddltHKWunQwgf4ifnpGw9St7LsGwXcQB1O/zWfHZ5Spt0MbfmV368e4q+JwOlwmN4gK1ZVh6IADSNXOTBHXdV3BYptSuA+wIIHr/ZVoxOWMcJm/IiOn57LMtqxblTLmRMA7EW5jYyOah8ywTnGWujrHP3WwaNSk37NxJvzlp/8AUixWOnm9vtaRm92jmOoAUzcVaicxyvw2yD5rEXUi/I8XTwdPFM0VaNQFx0A6qZ2dqETYhwMSLKOxuPkco3E7wdlKnjJxy+lgaIeyPE8Z5jzBz3ODWQSYh1yY257rrHK/KsgvqmJ+Sncpo1adg4EdCJH8/IrLk+CBEAKw+EymAXuaBHp/Ssu/o59onG5g1rCajCeumI9SCbfmofBYzS/ty9+qk61dtR4aNnbq1Zj9GzKtJlXB1Q46RIcQQ4xuHDYzy2vyWfMbv1qsvxs85+S6N9FlYnxekN+d1SqPA+M1hhpH1kaf9Wy6pwVw79TpFpOp7jLj+gE8gsxxu255SxY0RF2cRERAREQERamYZjSoN1VXtY3qT+QG5PYIInjnNHYfB1ajdwAAemohs+0r88Vqz674BncmTYCbz7n8123iLirCVqT6TmVnse0gkNa2x5jxHNXFXzh6rg1jzTcdLSQNREiPhJEz0Ki/wvFaMLi6babQN4iwG/uovHYwEwBf94WpjcK+k4hzXsO+l7S0/I3Wtlz5JcTtYfuuHp16Z5eLBgMIKdI66rgCLtDjBm5tt81Wc5a0mW/PZZcbji4725BRld5O0n0XSRyt/XmhhKjwSCbLN9UqUCHOB5j5Eg/os+U19I3iT/ZUlj8aHs0uuO3dXtGkNXxxK0X1ZX3FUwDY27rbyvDs+J5st4m7YMK6rTlzCRraWGwMtMFwuNrC46KdyvPiANYkDmP+Vmx5eyq3XSNMhjdLTAOkjUCRymZg3WsGAVSNMAgke90vSbiaGcUiPK6LWmBf++ij8bmrGiGPPrtfn6lRedZZoeNMgOvvt1UVUpQ6JlZ6yt9tJDBYV2IeGiw/QLHRZDy0HZxHyMKWyasaQ1NBmDcKMxtMhxeOZn+UamzmYY2AIPVaVTGOfuT7qOY5zthPfkpLA5S+obkcpg9fzPsprZ/DNl5c4nTc9eivv0el+HxLGteSysYqM5bGHQdiLX9QoWlhm0wAIAA5bfl7K7/R9lTnv+suaQ1oIZPM7F3ykKJbbx0skxu3QgwdF7XwL6vQ8wiIgIiICIiDy82XEPpCzx4xzw77kBjT+GJkDvvK7g4LnH0icFOxLxWogeJADxMagJ0kcpvHpHRZWxy3F529wjTM3Mi3QQo6ri4noRcH9wtnMcsfRJa6k9hH4pB+RG299ltZDw3icY4ChRIafiqOEMjY3Niewus1G7XHhXiWkzLHHGtFUsqOp0WOAc94LWvAEiwAdBdyAG5IBpGfZpTfBpYVmHF5DCSDexM84V5424TGFwWHYxxd4b3l7j8T3PAJP+2I5D0VQzHLwKN9x+hH62Km1eKsVavY/JWDhDODhC9zcPTrOqN0kuLrNPxMAA581I43MTjqVAPcR4FMMJN9TvxAT0DRJ7rRyjS1okDv7Kbl+Kxx38o/F5fre5zaXhtcZDASQ3qAXXiZ/RamIwzmj70d1e2YunFmj1/4VZzbENIMcyp9qvU/Gvw/hajT9YDWO0E6Q9oe0mOY2XzJsZ4Vc1RSpud8TWvbqaHB0ugcj06KXyR32DTPM2HVQ2KpaajvwzO+2q0rpLtxymktxLxH9frNeaQpvbTDXQZDiC4yOcXAWi8eRtQbgw7rH9haOLpuZfm079Vu5NgK+MD2YemXaSw1LsAa06gCdRBIsdp2Wwr7nGODqbOrT+0Kcdg8uflzaQxVP62XCpqcyo0B5geG55ZDWAW1G1pmLqns+0fEhwBgETDo2Im8cxbmrU7KWsYCd4kz0hTllpuOO4gMRQr0NPiUqjQYLXbscCAQadRsseLi7SV6p4F79LnWaSJveOcd1uUM2qMpvw+sig54c5u1xuBewPNesU97z8IGwDeg2Att7qbl+Okx18t3O62HdoNCi6kWtZT0lwLXBoDQ9zyRpcBAJNjF4hbuEy3GMY0DB1HNdqc1zIfIJBMlhI5iCYkC2yr9Sm/YltgTv+Q6ldm+jCnVp5c04iA3U51LmfBIDgXd9ReR/h0pjPb5ZlfX4czxrK9KsxmIo6ZGrwg5skD4S5zSQGkyN58psLE3zhr6RmmrToVqLaYdAaWGWjkJnlK53m+amrWrVp81V5j/ACCzQO0QtCi/7Vg5i4PeWx+i3Hic+/L9OotfL3E02E3JY2fWBK2F2cRERAREQEREBeXMBXpEGE4cL0ykAsiIKxx3gvEwz4ElsOA9DDp7aS5ccz0fYCLGm7S4duR+UL9B4ugHtIIkEQVyrizhDD4cPq1K9bS+B4TA2Xx5iASbGARq5alGUVKhOGuGi7LximtcHeI4uBm9Nps8DnFzbe6hMXgTIc2GteSD2O8j+FLUuLa1Wp4dGo7DUacNpUWaAGhtpe6CXuO5BMfmT9oYEvqCnWrhrKjgA5rG6C8zHiss1syBLQBtYbqMsfx1xy/VTxwqU3Oa5rpbuYkdjI6qND3VDABKuvHHCNTCU2OfWa4PqaGhrS2AATeT0EKHwdAUwIHJP9Z/LZ/l98ZeGwaTXMfF7tm/rAXjPqOzmg7EE7dx+i+4zFC3UEEH5/ktTHZg6uzS1lxEkXO4EwBa5HzC3HvU5c4y1Q11IOixYJ9rFamT1n024ksaftsK6iLSDrq0dc9PsxVg9YXmrXc2mKRBDhIdMg79DeV8bjKkBge5rQDYWsBN43v1W/DOVuZGWMc0uGxuOykcdmGqY27/AJBVw4hxcAAXOJAECSSTAaANzJgBMQXh2lzXNdzDgWn5G6i42umOUiWybJ6+K8d9Fhe2m2XC8mZlrbXdF43Uf9bIPxQRaLCO0cvRYmVnR4esloMhpOpoJ+ItBsD1IU9l+b1KLId9qHMLGNq/aBhNmuYH/BEmzY5KrimZVDNrucTu4rt/CWJw7ctFCjiGVHCnVkfC7U4OqPAYbwC/uuPYnCGldu0R0v1XtjDZ4s9pBDp52IiOSTU6y7yumkHGGwBsB7qZ4cy81cZRpgSSWz+pJ7RdSGQcJ1MY19Sm9pqNcNTHW+IkhwN7RO/Np5QuocE8Gtwc1HnVWcIJ5NBuQ31O57LZ2Iy+VtpNAAA2AsvaIuiBERAREQEREBERAREQFzT6SJOIogzGh0es/rsulqo8eZK6vS1UxNRkkD8QI8zfXYj07qcvhWPy4xm2GOp1RtoidhEbE+u3yUzhcUzEUPhkxBBnfn7rA+DqbIAIhzS24PMRyKhcHWqMe+lSa5+pwa3TEuJ+G34o3Uz4V9uoY3K35plGHdLvFY2QSZL309VJxcertJPqVyrG+JSJZUa5rhuCIK/QvBuWHD4KhQf8bWS8SDD3kveARuA5xAPQKH+kHPGYOl5GtdXqSKYIBjq4jmB09EuJjlZdRwUS9waTokapfLRHUW83OI3hXvgniLLcvLm6a9R9SNeILIbA2a1k6mtBM7STcmwArlekGnxa7y+o68bk+u0D0UTjcQ6o4Ma0CbBreXqeayKvWvmmM11qrwdQdUeQeoLiQflCwU8QQD3t+h9rqeweUUWjzS90CRsFMChSDSPq7B0PmsP9SjLyyfTpj4Mr9vnAOCbRpV8zrU9TcM0+CCSA6sfKNuUua2SCAXExLVWcVialWo6pUcXV6h1E8hPMdOgHIQrLm+b1Rhjhw77E6ZYZOnSQ6Wk3G21x2VfwDIf4lTUW7jSL/PZdMcpZuOWWFxuqyYDARciw3JVtyDhI4zDV8RBBbbDi93su4nqPu+s3sqtiscX2a0N6NF47uPMqdyXP8fh2tayudLQAGOa1zYHISLD0gqd6+Vat+HljhVa0AW0mf8JJu32v81FUqehzmk7fmDsfUH9VlwOcGniKjnMawVCSQ0eUE3doBMgapIEneLr7jAHHxGnaSe4O6z7Vrn9Ll9GWL0YsNtFRjm+/xD3lv5rsS4NwCHVMbQDBq0uDjHJrbkld4Cvx/Dl5NWvqIi6OYiIgIiICIiAiIgIiIC8vZK9IgrWdcG4bEnVUp+b8TS5h9y0ifdUTiLB0cma04OnOJqSPEqEv0Nm5DT5QTtYC3VdfK5L9K1Aisx/Vsf6Sf5U3isflQXYrF0z4wxFXWXFxOt1yTJsmY8T1cY9j6xBqMaGNiwNydR5ajN/QKWBa+iRHX/hVqnRFKs1+kOAcCWnYgGSD2Wf2v+kzlOQ1sU+KbTUefid9xvLzP2G+wk7dVZc64IZl+Ea/V4ld1Zup+kxGl40MH3G3mTckDsB1vKKVPwmOptaGOaCNIgQQIWPPssbiKL6TtnCJtY7gieYMFLjuJxy1dvz0KznGGtAN5LpG3YLK4v2dUg/5Rf31Ky4r6P8AFscQ1tN7erXBvzDouvWE4BxbiA6kxg/E6o0j/ZJ/Jef1v49PvP1Ui0OkPc4iLRAk8pIm3otDC4IuLvigGIMiPULtPDv0dU6JD6zvFcDIbEMB9N3e/wAlV/pByN9HEOrNEtq3JANiAAQY9J91cxsjncplVWy+lTp7iT/ey3K2PbAaO94Eyd/zUbc8itrAZVVrODWMc4np+/RTduksjNkOXePi6I0td5xOoSCOYINtpXTMX9G2Fe/U3xKY5tY4aTvuHA/l0WXgfhD6t9rVg1CLDfT1vzKuq7YY868+ee7xD5Dw7QwgIo02tn4juTG0uNzuVMIi6OYiIgIiICIiAiIgIiICIiAiIgKn/SDkpr0CWiXMlw7jn/KuC8VGSss22PzDisQ9ktuF5y6m+tUa0Akk7degXdc54Ew2IcXFmlx5tt+Wy2sg4Ow2FOplPz/idc+3RTpfslskwxpUKVMmSym1p9gAt5fAF9VubyWBAwL0iAsNbDB1iAR3WZEEZ/4OjM+FTn/KP4W1h8ExnwtA9AB+i2UWaNvgC+oi0EREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREBERAREQEREH/2Q==	BLEND: Lighter AROMAS: Milk Chocolate, Grains, Cashew ACIDITY: Medium BODY: Light	Like a ballet on your palate, Dancing Water is as smooth and delicate as the water that sustains life. Graceful notes of chocolate are paired with flavors of molasses and nuts. More captivating than a water show in Vegas!	2
40	Original 50 Capsule Dark Roast Pack	3500	https://www.nespresso.com/ecom/medias/sys_master/public/13560891768862/N-BESTSELLER-PACK-UPDATES-DARK-ROAST-OL-AW-6272x2432-smaller.jpg?impolicy=productPdpMainDefault&imwidth=3136	Rich and powerful blends	Perfect for those who enjoy a rich intense blend of Arabicas. This bestselling 50-count pack consists of a sleeve each of our most popular coffees:\n- Ristretto Italiano\n- Firenze Arpeggio\n- Roma\n- Napoli\n- Palermo Kazaar	4
41	Original 50 Capsule Medium Roast Pack	3500	https://www.nespresso.com/ecom/medias/sys_master/public/13478519668766/N-BESTSELLER-PACK-UPDATES-MEDIUM-ROAST-OL-AW-6272x2432-smaller.jpg?impolicy=productPdpMainDefault&imwidth=3136	Aromatic and mellow blends of Arabicas	Perfect for those who enjoy mild and mellow blends of Central and South American Arabicas. This bestselling 50-count pack consists of a sleeve each of some of our most aromatic cups:\n- Genova Livanto\n- Volluto\n- Vivalto Lungo\n- Linizio Lungo\n- Colombia	4
42	Original 100 Capsule Discovery Pack	7000	https://www.nespresso.com/ecom/medias/sys_master/public/13560898781214/N-BESTSELLER-PACK-UPDATES-100-CAPSULE-OL-AW-6272x2432-smaller.jpg?impolicy=productPdpMainDefault&imwidth=3136	Nespresso recommended variety	For those new to Nespresso and looking for a recommendation, here’s a selection of coffees to start you off with. This bestselling 100-count pack consists of a sleeve each of:\n- Ristretto Italiano\n- Ristretto Italiano Decaffeinato\n- Firenze Arpeggio\n- Firenze Arpeggio Decaffeinato\n- Linizio Lungo\n- Fortissio Lungo\n- Genova Livanto\n- Volluto\n- Caramel Crème Brûlée\n- Vanilla Eclair	4
43	Pumpkin Spice Medium Roast Ground Coffee	7490	https://target.scene7.com/is/image/Target/GUEST_3228ac91-2c98-4ebc-9a9a-e6a51a08c039?fmt=webp&wid=1400&qlt=80	Ground Arabica Coffee, Natural Flavors.	Fall into flavor with Starbucks Pumpkin Spice Flavored Coffee—a blend of our ﬁnest coffee beans and the perfect fall flavors. Here, notes of pumpkin, cinnamon and nutmeg come to life in this cozy fall coffee. Crafted for crisp autumn days where hayrides, pumpkin patches and harvest festivals are as eagerly anticipated as a fresh brewed cup of coffee. This warm and balanced seasonal blend will fill your day with coziness and comfort. But hurry, these harvest season favorites are only here for a limited time.	3
44	Starbucks Caffè Verona Dark Roast Ground Coffee	7490	https://target.scene7.com/is/image/Target/GUEST_f5eaf589-b0be-4fd3-b2a4-e17846c318c1?fmt=webp&wid=1400&qlt=80	Caffe Verona is well-balanced and rich coffee with a dark cocoa texture	This is a coffee of one true love, and three names. We created it just for a Seattle restaurant in 1975, naming it Jakes Blend. And people loved it. So many, in fact, that we began hand scooping and blending it to order in our stores, where it was known as 80/20 Blend, for the recipe. The love was so strong we finally made it official, calling it Verona after the city that inspires so many. By any name, this is a thing of pure romance.	3
45	Starbucks Breakfast Blend Medium Roast Ground Coffee	7490	https://target.scene7.com/is/image/Target/GUEST_814563df-3737-489f-9598-e998bdd6d09c?fmt=webp&wid=1400&qlt=80	Breakfast Blend is a lively and lighter roast with a crisp finish	A shade lighter than most of our offerings—more toasty than roasty—it was the result of playing with roast and taste profiles together for a flavor that appealed to a wider range of palates. Perfect if you want to wake up to a less-intense coffee but still want a lot of character, it's lively with a citrusy tang that gives way to a clean finish.	3
46	Starbucks Veranda Blend Blonde Light Roast Ground Coffee	7490	https://target.scene7.com/is/image/Target/GUEST_9228c8b1-4db9-4426-9d14-b6af038121a2?fmt=webp&wid=1400&qlt=80	A lighter, gentler take on the Starbucks roast, Veranda Blend is flavorful without being overly bold	In Latin America, coffee farms are often run by families, who've built their own homes on the same land where their coffee grows. We've sipped coffee with these farmers for decades, sitting on their verandas, overlooking the lush beauty of the coffee trees out in the distance. Most times, it was a lightly roasted coffee like this one. It took us more than 80 tries to get it right--mellow and flavorful with a nice softness.	3
47	Starbucks Sumatra Dark Roast Ground Coffee	7490	https://target.scene7.com/is/image/Target/GUEST_99665d21-631a-459a-823f-aa8f987f74cd?fmt=webp&wid=1400&qlt=80	Sumatra coffee is a dark-roasted, full-bodied coffee with spicy and herbal notes and a deep, earthy aroma	Like the lush Indonesian island of its origin, this spicy coffee stands alone. Full-bodied with a smooth mouthfeel, lingering flavors of dried herbs and fresh earth and almost no acidity. Our roasters love transforming these unpredictable beans from dark coral green to tiger orange to a rich, oily mahogany, revealing bold flavors that many us of us can't live without. Coffee from Sumatra is the foundation of our most treasured blends and something we've been honored to share with you for four decades.	3
48	Starbucks Italian Roast Dark Roast Ground Coffee	7490	https://target.scene7.com/is/image/Target/GUEST_e928fbc7-b2e7-44d7-92d2-8109ee59aba7?fmt=webp&wid=1400&qlt=80	Italian Roast is intense with a rich, deep flavor and notes of caramelized sugar	This is Starbucks' quintessential dark roast; it's expertly crafted to bring out sweetness and intensity. It showcases the precision and skill of our roasters, who created a coffee that's slightly darker than our Espresso Roast without the smoky edge of French Roast. A great cup of coffee, it has a depth of flavor that holds its own with cream and sugar.	3
49	Starbucks Colombia Medium Roast Ground Coffee	7490	https://target.scene7.com/is/image/Target/GUEST_ecafca22-6fb2-4746-939b-e66e600d1119?fmt=webp&wid=1400&qlt=80	Colombia is a medium-bodied coffee that is rich with juicy undertones and a crisp, nutty finish	Six thousand feet--straight up. Sounds extreme, we know. But high atop the majestic Andes, in a rugged landscape of simmering volcanoes, is where the finest coffee beans in Colombia grow. This Colombian marvel erupts on the palate with a juicy feel and robust flavors, a testament to the hearty riches of volcanic soils. Its remarkable finish, dry with hints of walnut, lifts this superior coffee into a class of its own.	3
50	Starbucks Vanilla Flavored Light Roast Ground Coffee	7490	https://target.scene7.com/is/image/Target/GUEST_1f1e0ffe-84cb-4e18-acf0-34f3b4acfd95?fmt=webp&wid=1400&qlt=80	Starbucks Vanilla Flavored Coffee is lighter-roasted, offering creamy vanilla flavor	A generous kick of vanilla makes this coffee a deliciously satisfying treat. The recipe is an enticing blend of lighter-roasted beans as well as vanilla flavor that you can enjoy anytime. To add some tasty fun to your cup before you brew: ground cinnamon, brown sugar or hot chocolate mix.	3
51	Cafecito de Puerto Rico	200	https://external-preview.redd.it/w62-uBC3VIfWsMLTGMonYTdlyQNcTc5p417ENldyIVc.jpg?auto=webp&s=bcbc158fd6febbb2e3df6aaff0024f87353f6b09	Single origin blend of Latin American Arabicas from the island of Puerto Rico.	Intense and creamy flavor of the espresso reveals an aromatic bouquet of dark cocoa, pepper and brown spice. Perfect on its own, Cafecito de Puerto Rico also mixes well with cream and brown sugar for a typical “Café Cortadito.”	4
52	Amaha awe Uganda	130	data:image/jpeg;base64,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	Single origin coffee from the Rwenzori Mountains of Western region of Uganda.	This rich espresso carries an elegant floral profile underscored by aromatic and exquisitely-uncommon notes of sandalwood. Try Amaha awe Uganda with milk in a Latte Macchiato recipe to reveal a balanced and sweet cup with a round body texture, biscuit and discrete fruity notes.	4
57	Vertuo 40 Capsule Dark Roast Pack	4400	https://b3h2.scene7.com/is/image/BedBathandBeyond/37344269258053p?$690$&wid=690&hei=690	Rich and powerful blends	Perfect for those who enjoy a rich dark roast bursting with aromas	4
56	Vertuo 100 Capsule Indulgent Pack	10250	https://www.nespresso.com/ecom/medias/sys_master/public/13435832533022/N-IndulgentPack-PDP-AW-2000X2000.png	Full range of extraordinary coffees	Explore the rich taste and differing notes of our Vertuo Indulgent Pack. It’s the perfect choice to discover a distinctive range of extraordinary coffees.	4
54	Pour-Over Style (18 oz) - Vertuo Next Machines	160	https://www.nespresso.com/shared_res/nc2/pdp_bg/carafe-experience/img/capsule_XL.png	Unique combination of Peruvian and Colombian Arabicas delicately blended into a well-balanced coffee.	Enjoy the coffee’s bold and smoky aromas hiding beneath a thin layer of crema.	4
55	Hawaii Kona Discovery Box	8000	https://www.nespresso.com/shared_res/mos/free_html/us/gift-boxes/kona-vl/capsule.png	The limited-edition discovery box for Nespresso Hawaii Kona.	100% Arabica Kona coffee is grown exclusively on the steep slopes of the volcanic island of Hawaii. This unique coffee gets its characteristic qualities from the rich, volcanic soil and boasts a complex, harmonious aroma. Indulge your palate in its richly powerful taste rounded with a light acidity and a touch of walnut.	4
53	Mexico	120	https://images-na.ssl-images-amazon.com/images/I/31XKTCJda6L.01_SL500_.jpg	Intense & Spiced	They’ve grown Arabica coffee in Mexico for hundreds of years. But Robusta coffee only appeared in 1949. The producers are intent on getting the best out of this Robusta and won’t settle for treating it like any old coffee for the lower-end market. They found the sticky fruit flesh persistently clings to the coffee bean. A single wash is not enough to loosen the hold. That’s when they developed this peerless process of double washing Robusta.	4
32	TESORA	1800	https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQOUP8q0y6u6W6Lkep_GYGtzHEJfscZy3D-VQ&usqp=CAU	BLEND: Medium AROMAS: Caramel, Nuts, Butter ACIDITY: Medium BODY: Full	Seven years in the making and the first blend created by Phil himself, the Tesora is the quintessential Philz blend. If it is your first time visiting Philz coffee, we highly recommend you order our Tesora blend. Tesora, A grand representation of our coffee and the way coffee should taste!	2
39	JACOB'S WONDERBAR (4LB BAG, WHOLE BEAN ONLY)	7200	data:image/jpeg;base64,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	BLEND: Darker AROMAS: Dark Chocolate, Smoke, Nuts ACIDITY: Low BODY: Full	Named in honor of Phil’s only son, Jacob. Each memorable sip boasts delicious layers of nuts and chocolate filled with a full-bodied flavor. Jacob’s Wonderbar has become a dark roast favorite!	2
\.


--
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.stores ("storeId", name) FROM stdin;
1	illycaffè
2	Philz Coffee
3	Starbucks
4	Nespresso
1	illycaffè
2	Philz Coffee
3	Starbucks
4	Nespresso
\.


--
-- Name: cartItems_cartItemId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."cartItems_cartItemId_seq"', 39, true);


--
-- Name: carts_cartId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."carts_cartId_seq"', 24, true);


--
-- Name: orders_orderId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."orders_orderId_seq"', 13, true);


--
-- Name: products_productId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."products_productId_seq"', 57, true);


--
-- Name: stores_storeId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."stores_storeId_seq"', 4, true);


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
-- Name: categories stores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT stores_pkey PRIMARY KEY ("categoryId");


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

