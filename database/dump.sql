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

ALTER TABLE IF EXISTS ONLY public.stores DROP CONSTRAINT IF EXISTS stores_pkey;
ALTER TABLE IF EXISTS ONLY public.products DROP CONSTRAINT IF EXISTS products_pkey;
ALTER TABLE IF EXISTS ONLY public.orders DROP CONSTRAINT IF EXISTS orders_pkey;
ALTER TABLE IF EXISTS ONLY public.carts DROP CONSTRAINT IF EXISTS carts_pkey;
ALTER TABLE IF EXISTS ONLY public."cartItems" DROP CONSTRAINT IF EXISTS "cartItems_pkey";
ALTER TABLE IF EXISTS public.stores ALTER COLUMN "storeId" DROP DEFAULT;
ALTER TABLE IF EXISTS public.products ALTER COLUMN "productId" DROP DEFAULT;
ALTER TABLE IF EXISTS public.orders ALTER COLUMN "orderId" DROP DEFAULT;
ALTER TABLE IF EXISTS public.carts ALTER COLUMN "cartId" DROP DEFAULT;
ALTER TABLE IF EXISTS public."cartItems" ALTER COLUMN "cartItemId" DROP DEFAULT;
DROP SEQUENCE IF EXISTS public."stores_storeId_seq";
DROP TABLE IF EXISTS public.stores;
DROP SEQUENCE IF EXISTS public."products_productId_seq";
DROP TABLE IF EXISTS public.products;
DROP SEQUENCE IF EXISTS public."orders_orderId_seq";
DROP TABLE IF EXISTS public.orders;
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
31	GREAT OUTDOORS	1800	https://www.philzcoffee.com/images/items/coffee-darker-blends-great-outdoors.01.png?resizeid=3&resizeh=400&resizew=400	BLEND: Darker AROMAS: Rich, Dark Chocolate, Buttery Roast, Smokey, Syrupy	This year of change has us pining for the fresh air, roasting marshmallows at the campgrounds and enjoying the bliss of nature. Bring home our online exclusive, sip on this delicious buttery, chocolatey blend and be reminded of better days in the great outdoors.	2
32	TESORA	1800	https://www.philzcoffee.com/images/items/coffee-medium-blends-tesora.01.png?resizeid=3&resizeh=400&resizew=400	BLEND: Medium AROMAS: Caramel, Nuts, Butter ACIDITY: Medium BODY: Full	Seven years in the making and the first blend created by Phil himself, the Tesora is the quintessential Philz blend. If it is your first time visiting Philz coffee, we highly recommend you order our Tesora blend. Tesora, A grand representation of our coffee and the way coffee should taste!	2
33	Red Sea	1800	https://www.philzcoffee.com/images/items/coffee-darker-blends-red-sea.01.png?resizeid=3&resizeh=400&resizew=400	BLEND: Darker AROMAS: Berry Jam, Bittersweet Dark Chocolate, Malty ACIDITY: Medium BODY: Full	Our beloved and bold Red Sea is back for a limited time. Flavors of berry jam, dark chocolate and subtle malty finish shine through this darker roasted blend. It's a perfect work from home treat. Our beloved Red Sea is back for a limited time. Flavors of berry jam, dark chocolate and subtle malty finish shine through this bold darker roast. It's a perfect work from home treat.	2
34	Hazelnut	1800	https://www.philzcoffee.com/images/items/coffee-varietals-hazelnut.01.png?resizeid=3&resizeh=400&resizew=400	BLEND: Varietals, AROMAS: Hazelnut Flavor, Almond, Milk Chocolate ACIDITY: Low BODY: Medium	As the name implies, our Hazelnut provides its namesake flavor along with a rich and creamy body. Its aroma is sure warm your soul and put a smile on your face. Contains artificial hazelnut flavor.	2
35	Dancing Water	1800	https://www.philzcoffee.com/images/items/coffee-lighter-blends-dancing-water.01.png?resizeid=3&resizeh=400&resizew=400	BLEND: Lighter AROMAS: Milk Chocolate, Grains, Cashew ACIDITY: Medium BODY: Light	Like a ballet on your palate, Dancing Water is as smooth and delicate as the water that sustains life. Graceful notes of chocolate are paired with flavors of molasses and nuts. More captivating than a water show in Vegas!	2
36	Ecstatic	1800	https://www.philzcoffee.com/images/items/coffee-darker-blends-ecstatic.01.png?resizeid=3&resizeh=400&resizew=400	BLEND: Darker AROMAS: Chocolate, Syrup, Caramel ACIDITY: Medium Body: Full	We use this blend to make our Ecstatic Iced Coffee, which is the base of all of our specialty iced coffee drinks. With a balanced combination of bittersweet cocoa, a dense syrupy body and a subtle citris finish, it pairs deliciously with cream and sugar. Try it as iced coffee or your favorite way at home!	2
37	JACOB'S WONDERBAR	1800	https://www.philzcoffee.com/images/items/coffee-darker-blends-jacobs-wonderbar.01.png?resizeid=3&resizeh=400&resizew=400	BLEND: Darker AROMAS: Dark Chocolate, Smoke, Nuts ACIDITY: Low BODY: Full	Named in honor of Phil’s only son, Jacob. Each memorable sip boasts delicious layers of nuts and chocolate filled with a full-bodied flavor. Jacob’s Wonderbar has become a dark roast favorite!	2
38	TESORA (4LB BAG, WHOLE BEAN ONLY)	7200	https://www.philzcoffee.com/images/items/coffee-medium-blends-tesora-4lb-bag.01.png?resizeid=3&resizeh=400&resizew=400	BLEND: Medium AROMAS: Caramel, Nuts, Butter ACIDITY: Medium BODY: Full	Seven years in the making and the first blend created by Phil himself, the Tesora is the quintessential Philz blend. If it is your first time visiting Philz coffee, we highly recommend you order our Tesora blend. Tesora, A grand representation of our coffee and the way coffee should taste!	2
39	JACOB'S WONDERBAR (4LB BAG, WHOLE BEAN ONLY)	7200	https://www.philzcoffee.com/images/items/coffee-darker-blends-jacobs-wonderbar-4lb-bag.01.png?resizeid=3&resizeh=400&resizew=400	BLEND: Darker AROMAS: Dark Chocolate, Smoke, Nuts ACIDITY: Low BODY: Full	Named in honor of Phil’s only son, Jacob. Each memorable sip boasts delicious layers of nuts and chocolate filled with a full-bodied flavor. Jacob’s Wonderbar has become a dark roast favorite!	2
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
51	Cafecito de Puerto Rico	200	https://www.nespresso.com/ecom/medias/sys_master/public/13441275625502/N-RevivingOrigins-PDP-AW-PuertoRico-VL-TopImage-6272x2432.jpg?impolicy=productPdpMainDefault&imwidth=1568	Single origin blend of Latin American Arabicas from the island of Puerto Rico.	Intense and creamy flavor of the espresso reveals an aromatic bouquet of dark cocoa, pepper and brown spice. Perfect on its own, Cafecito de Puerto Rico also mixes well with cream and brown sugar for a typical “Café Cortadito.”	4
52	Amaha awe Uganda	130	https://www.nespresso.com/ecom/medias/sys_master/public/13228836749342/Desktop-PDP-6272x2432.jpg?impolicy=productPdpMainDefault&imwidth=1568	Single origin coffee from the Rwenzori Mountains of Western region of Uganda.	This rich espresso carries an elegant floral profile underscored by aromatic and exquisitely-uncommon notes of sandalwood. Try Amaha awe Uganda with milk in a Latte Macchiato recipe to reveal a balanced and sweet cup with a round body texture, biscuit and discrete fruity notes.	4
53	Mexico	120	https://www.nespresso.com/ecom/medias/sys_master/public/13309805395998/C-0368-Main-PDP-MasterOrigin-Mexico-VL.jpg?impolicy=productPdpMainDefault&imwidth=1568	Intense & Spiced	They’ve grown Arabica coffee in Mexico for hundreds of years. But Robusta coffee only appeared in 1949. The producers are intent on getting the best out of this Robusta and won’t settle for treating it like any old coffee for the lower-end market. They found the sticky fruit flesh persistently clings to the coffee bean. A single wash is not enough to loosen the hold. That’s when they developed this peerless process of double washing Robusta.	4
54	Pour-Over Style (18 oz) - Vertuo Next Machines	160	https://www.nespresso.com/ecom/medias/sys_master/public/13631480791070/4N-PourOverStyleCoffee-PDP-AW-6272x2432-1.jpg?impolicy=productPdpMainDefault&imwidth=1568	Unique combination of Peruvian and Colombian Arabicas delicately blended into a well-balanced coffee.	Enjoy the coffee’s bold and smoky aromas hiding beneath a thin layer of crema.	4
55	Hawaii Kona Discovery Box	8000	https://www.nespresso.com/ecom/medias/sys_master/public/13567495143454/N-DiscoveryBox-PDP-AW-Kona-VL-6272x2432-1.jpg?impolicy=productPdpMainDefault&imwidth=1568	Introducing the limited-edition discovery box for Nespresso Hawaii Kona. Featuring an exclusive design by Hawaiian artist Manaola Yap, it evokes the true spirit of the island and the world-renowned Kona coffee.	100% Arabica Kona coffee is grown exclusively on the steep slopes of the volcanic island of Hawaii. This unique coffee gets its characteristic qualities from the rich, volcanic soil and boasts a complex, harmonious aroma. Indulge your palate in its richly powerful taste rounded with a light acidity and a touch of walnut.	4
56	Vertuo 100 Capsule Indulgent Pack	10250	https://www.nespresso.com/ecom/medias/sys_master/public/13435833581598/N-IndulgentPack-PDP-AW-6272x2432.jpg?impolicy=productPdpMainDefault&imwidth=1568	Full range of extraordinary coffees	Explore the rich taste and differing notes of our Vertuo Indulgent Pack. It’s the perfect choice to discover a distinctive range of extraordinary coffees.	4
57	Vertuo 40 Capsule Dark Roast Pack	4400	https://www.nespresso.com/ecom/medias/sys_master/public/13641862545438/N-PourOverStyle-starterpack-PDP-AW-6272x2432-1.jpg?impolicy=productPdpMainDefault&imwidth=1568	Rich and powerful blends	Perfect for those who enjoy a rich dark roast bursting with aromas	4
\.


--
-- Data for Name: stores; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.stores ("storeId", name) FROM stdin;
1	illycaffè
2	Philz Coffee
3	Starbucks
4	Nespresso
\.


--
-- Name: cartItems_cartItemId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."cartItems_cartItemId_seq"', 33, true);


--
-- Name: carts_cartId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."carts_cartId_seq"', 22, true);


--
-- Name: orders_orderId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."orders_orderId_seq"', 10, true);


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
-- Name: stores stores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stores
    ADD CONSTRAINT stores_pkey PRIMARY KEY ("storeId");


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

