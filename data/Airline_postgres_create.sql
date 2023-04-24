--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 15.1

-- Started on 2023-04-24 20:21:21

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


CREATE DATABASE "AirNet" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE "AirNet" OWNER TO postgres;



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



ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;


CREATE TABLE public."admin"  (
    "admin_id" integer NOT NULL
);


ALTER TABLE public."admin"  OWNER TO postgres;


CREATE TABLE public."airline"  (
    "airlineCode" text NOT NULL,
    "airlineName" text NOT NULL,
    "contactNO" text,
    "city" text NOT NULL,
    "streetAddrs" text NOT NULL,
    "numberAddrs" text NOT NULL
);


ALTER TABLE public."airline"  OWNER TO postgres;



CREATE TABLE public."airport"  (
    "airportID" integer NOT NULL,
    "airportCode" text NOT NULL,
    "name" text NOT NULL,
    "country" text NOT NULL,
    "region" text NOT NULL
);


ALTER TABLE public."airport"  OWNER TO postgres;


CREATE SEQUENCE public."airport_airportID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."airport_airportID_seq" OWNER TO postgres;



ALTER SEQUENCE public."airport_airportID_seq" OWNED BY public."airport" ."airportID";




CREATE TABLE public."belongsTo" (
    "flightNO" integer NOT NULL,
    "seat_no" character varying(5) NOT NULL
);


ALTER TABLE public."belongsTo" OWNER TO postgres;



CREATE SEQUENCE public."belongsTo_flightNO_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."belongsTo_flightNO_seq" OWNER TO postgres;



ALTER SEQUENCE public."belongsTo_flightNO_seq" OWNED BY public."belongsTo"."flightNO";




CREATE TABLE public."book"  (
    "bookID" integer NOT NULL,
    "userID" integer NOT NULL,
    "journeyID" integer NOT NULL,
    "bookingDate" date NOT NULL
);


ALTER TABLE public."book"  OWNER TO postgres;



CREATE SEQUENCE public."book_bookID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."book_bookID_seq" OWNER TO postgres;



ALTER SEQUENCE public."book_bookID_seq" OWNED BY public."book" ."bookID";



CREATE TABLE public."customer"  (
    "customerID" integer NOT NULL,
    "paymnet_id" integer NOT NULL
);


ALTER TABLE public."customer"  OWNER TO postgres;



CREATE SEQUENCE public."customer_customerID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."customer_customerID_seq" OWNER TO postgres;



ALTER SEQUENCE public."customer_customerID_seq" OWNED BY public."customer" ."customerID";



CREATE SEQUENCE public."customer" "_paymnet_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."customer" "_paymnet_id_seq" OWNER TO postgres;



ALTER SEQUENCE public."customer" "_paymnet_id_seq" OWNED BY public."customer" .paymnet_id;


CREATE TABLE public."flight" (
    "flightNO" integer NOT NULL,
    "airline_code" text NOT NULL,
    "journeyID" integer NOT NULL,
    "flightName" text NOT NULL,
    "departureDate" date NOT NULL,
    "arrivalDate" date,
    "departFrom" text NOT NULL,
    "arriveTo" text NOT NULL
);


ALTER TABLE public."flight" OWNER TO postgres;


CREATE SEQUENCE public."flight_flightNO_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."flight_flightNO_seq" OWNER TO postgres;



ALTER SEQUENCE public."flight_flightNO_seq" OWNED BY public."flight"."flightNO";



CREATE TABLE public."journey" (
    "journeyID" integer NOT NULL,
    "cost" double precision NOT NULL,
    "origin" text NOT NULL,
    "destination" text NOT NULL
);


ALTER TABLE public."journey" OWNER TO postgres;



CREATE SEQUENCE public."journey_journeyID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."journey_journeyID_seq" OWNER TO postgres;


ALTER SEQUENCE public."journey_journeyID_seq" OWNED BY public."journey"."journeyID";



CREATE TABLE public."passenger" (
    "cusID" integer NOT NULL,
    "fName" text NOT NULL,
    "lName" text NOT NULL,
    "bdate" date NOT NULL,
    "age" integer NOT NULL,
    "gender" character varying(1) NOT NULL
);


ALTER TABLE public."passenger" OWNER TO postgres;



CREATE SEQUENCE public."passenger_cusID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."passenger_cusID_seq" OWNER TO postgres;



ALTER SEQUENCE public."passenger_cusID_seq" OWNED BY public."passenger"."cusID";




CREATE TABLE public."payment" (
    "paymentID" integer NOT NULL,
    "paydate" date NOT NULL,
    "amount" double precision NOT NULL
);


ALTER TABLE public."payment" OWNER TO postgres;


CREATE SEQUENCE public."payment_paymentID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."payment_paymentID_seq" OWNER TO postgres;



ALTER SEQUENCE public."payment_paymentID_seq" OWNED BY public."payment"."paymentID";



CREATE TABLE public."receive" (
    "pay_id" integer NOT NULL,
    "ticketID" integer NOT NULL
);


ALTER TABLE public."receive" OWNER TO postgres;



CREATE TABLE public."receives" (
    "custID" integer NOT NULL,
    "ticketID" integer NOT NULL
);


ALTER TABLE public."receives" OWNER TO postgres;


CREATE TABLE public."ticket" (
    "ticketID" integer NOT NULL,
    status text,
    "fair" double precision NOT NULL,
    "seatNO" character varying(5) NOT NULL,
    "class" text NOT NULL
);


ALTER TABLE public."ticket" OWNER TO postgres;



CREATE SEQUENCE public."ticket_ticketID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ticket_ticketID_seq" OWNER TO postgres;



ALTER SEQUENCE public."ticket_ticketID_seq" OWNED BY public."ticket"."ticketID";



CREATE TABLE public."user" (
    "userID" integer NOT NULL,
    "email" text NOT NULL,
    "password" text NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    "city" text NOT NULL,
    "streetAddrs" text NOT NULL,
    "numberAddrs" text NOT NULL,
    "bdate" date NOT NULL,
    "age" integer NOT NULL,
    "gender" character varying(1) NOT NULL,
    "phonenumber" text NOT NULL,
    "salt" text NOT NULL
);



ALTER TABLE public."user" OWNER TO postgres;



CREATE SEQUENCE public."user_userID_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;




ALTER SEQUENCE public."user_userID_seq" OWNED BY public."user"."userID";



ALTER TABLE ONLY public."airport"  ALTER COLUMN "airportID" SET DEFAULT nextval('public."airport_airportID_seq"'::regclass);


ALTER TABLE ONLY public."belongsTo" ALTER COLUMN "flightNO" SET DEFAULT nextval('public."belongsTo_flightNO_seq"'::regclass);



ALTER TABLE ONLY public."book" ALTER COLUMN "bookID" SET DEFAULT nextval('public."book_bookID_seq"'::regclass);



ALTER TABLE ONLY public."customer" ALTER COLUMN "customerID" SET DEFAULT nextval('public."customer_customerID_seq"'::regclass);




ALTER TABLE ONLY public."customer" ALTER COLUMN "paymnet_id" SET DEFAULT nextval('public."customer" "_paymnet_id_seq"'::regclass);



ALTER TABLE ONLY public."flight" ALTER COLUMN "flightNO" SET DEFAULT nextval('public."flight_flightNO_seq"'::regclass);



ALTER TABLE ONLY public."journey" ALTER COLUMN "journeyID" SET DEFAULT nextval('public."journey_journeyID_seq"'::regclass);


ALTER TABLE ONLY public."passenger" ALTER COLUMN "cusID" SET DEFAULT nextval('public."passenger_cusID_seq"'::regclass);




ALTER TABLE ONLY public."payment" ALTER COLUMN "paymentID" SET DEFAULT nextval('public."payment_paymentID_seq"'::regclass);


ALTER TABLE ONLY public."ticket" ALTER COLUMN "ticketID" SET DEFAULT nextval('public."ticket_ticketID_seq"'::regclass);



ALTER TABLE ONLY public."user" ALTER COLUMN "userID" SET DEFAULT nextval('public."user_userID_seq"'::regclass);



SELECT pg_catalog.setval('public."airport_airportID_seq"', 12, true);



SELECT pg_catalog.setval('public."belongsTo_flightNO_seq"', 1, false);



SELECT pg_catalog.setval('public."book_bookID_seq"', 1, false);




SELECT pg_catalog.setval('public."customer_customerID_seq"', 1, false);



SELECT pg_catalog.setval('public."customer" "_paymnet_id_seq"', 1, false);


-

SELECT pg_catalog.setval('public."flight_flightNO_seq"', 9, true);




SELECT pg_catalog.setval('public."journey_journeyID_seq"', 9, true);


SELECT pg_catalog.setval('public."passenger_cusID_seq"', 1, false);



SELECT pg_catalog.setval('public."payment_paymentID_seq"', 1, false);



SELECT pg_catalog.setval('public."ticket_ticketID_seq"', 1, false);




SELECT pg_catalog.setval('public."user_userID_seq"', 3, true);




ALTER TABLE ONLY public."admin" 
    ADD CONSTRAINT admin_pk PRIMARY KEY ("admin_id");




ALTER TABLE ONLY public."airline" 
    ADD CONSTRAINT airline_pk PRIMARY KEY ("airlineCode");



ALTER TABLE ONLY public."airport" 
    ADD CONSTRAINT "airport_airportCode_key" UNIQUE ("airportCode");




ALTER TABLE ONLY public."airport" 
    ADD CONSTRAINT airport_pk PRIMARY KEY ("airportID");



ALTER TABLE ONLY public."book" 
    ADD CONSTRAINT book_pk PRIMARY KEY ("bookID", "userID", "journeyID");


ALTER TABLE ONLY public."customer" 
    ADD CONSTRAINT customer_pk PRIMARY KEY ("customerID");

ALTER TABLE ONLY public."flight"
    ADD CONSTRAINT flight_pk PRIMARY KEY ("flightNO");



ALTER TABLE ONLY public."journey"
    ADD CONSTRAINT journey_pk PRIMARY KEY ("journeyID");



ALTER TABLE ONLY public."passenger"
    ADD CONSTRAINT passenger_pk PRIMARY KEY ("cusID");



ALTER TABLE ONLY public."payment"
    ADD CONSTRAINT payment_pk PRIMARY KEY ("paymentID");


ALTER TABLE ONLY public."receive"
    ADD CONSTRAINT receive_pk PRIMARY KEY ("pay_id", "ticketID");


ALTER TABLE ONLY public."receives"
    ADD CONSTRAINT receives_pk PRIMARY KEY ("custID", "ticketID");



ALTER TABLE ONLY public."ticket"
    ADD CONSTRAINT ticket_pk PRIMARY KEY ("ticketID");



ALTER TABLE ONLY public."ticket"
    ADD CONSTRAINT "ticket_seatNO_key" UNIQUE ("seatNO");


ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE ("email");



ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pk PRIMARY KEY ("userID");

ALTER TABLE ONLY public."admin" 
    ADD CONSTRAINT admin_fk0 FOREIGN KEY ("admin_id") REFERENCES public."user"("userID");



ALTER TABLE ONLY public."belongsTo"
    ADD CONSTRAINT "belongsTo_fk0" FOREIGN KEY ("flightNO") REFERENCES public."flight"("flightNO");



ALTER TABLE ONLY public."belongsTo"
    ADD CONSTRAINT "belongsTo_fk1" FOREIGN KEY ("seat_no") REFERENCES public."ticket"("seatNO");




ALTER TABLE ONLY public."book" 
    ADD CONSTRAINT book_fk0 FOREIGN KEY ("userID") REFERENCES public."user"("userID");



ALTER TABLE ONLY public."book" 
    ADD CONSTRAINT book_fk1 FOREIGN KEY ("journeyID") REFERENCES public."journey"("journeyID");



ALTER TABLE ONLY public."customer" 
    ADD CONSTRAINT customer_fk0 FOREIGN KEY ("customerID") REFERENCES public."user"("userID");




ALTER TABLE ONLY public."customer" 
    ADD CONSTRAINT customer_fk1 FOREIGN KEY ("paymnet_id") REFERENCES public."payment"("paymentID");


ALTER TABLE ONLY public."flight"
    ADD CONSTRAINT flight_fk0 FOREIGN KEY ("airline_code") REFERENCES public."airline" ("airlineCode");


ALTER TABLE ONLY public."flight"
    ADD CONSTRAINT flight_fk1 FOREIGN KEY ("journeyID") REFERENCES public."journey"("journeyID");


ALTER TABLE ONLY public."flight"
    ADD CONSTRAINT flight_fk2 FOREIGN KEY ("departFrom") REFERENCES public."airport" ("airportCode");


ALTER TABLE ONLY public."flight"
    ADD CONSTRAINT flight_fk3 FOREIGN KEY ("arriveTo") REFERENCES public."airport" ("airportCode");


ALTER TABLE ONLY public."passenger"
    ADD CONSTRAINT passenger_fk0 FOREIGN KEY ("cusID") REFERENCES public."customer" ("customerID");

ALTER TABLE ONLY public."receive"
    ADD CONSTRAINT receive_fk0 FOREIGN KEY ("pay_id") REFERENCES public."payment"("paymentID");



ALTER TABLE ONLY public."receive"
    ADD CONSTRAINT receive_fk1 FOREIGN KEY ("ticketID") REFERENCES public."ticket"("ticketID");


ALTER TABLE ONLY public."receives"
    ADD CONSTRAINT receives_fk0 FOREIGN KEY ("custID") REFERENCES public."customer" ("customerID");


ALTER TABLE ONLY public."receives"
    ADD CONSTRAINT receives_fk1 FOREIGN KEY ("ticketID") REFERENCES public."ticket"("ticketID");

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('SQ', 'Singapores Airline Limited', NULL, 'Singapore', 'Upper Changi Rd E', '722');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('EK', 'Emirates', NULL, 'Deira', 'Airport Road', 'A48');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('NH', 'All Nippon Airways', NULL, 'Tokyo', 'Higashi Shimbashi', '1-5-2');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('QF', 'Qantas Airways Limited', NULL, 'Mascot', 'Bourke Road', '10');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('QR', 'Qatar Airways Company', NULL, 'Doha', 'Qatar Airways Tower', '-');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('AA', 'American Airlines', NULL, 'Dallas', 'Amon Carter Boulevard', '4333');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('JL', 'Japan Airlines', NULL, 'Tokyo', 'Higashi-Shinagawa', '2-4-11');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('TK', 'Turkish Airlines', NULL, 'Istanbul', 'Yesilkoy', '34149');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('AF', 'Air France', NULL, 'Paris', 'rue de Paris', '45');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('KE', 'Korean Air', NULL, 'Seoul', 'Haneul-gil', '260');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('A3', 'Aegean Airlines', NULL, 'Athens', 'Viltanioti St.', '31');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('DL', 'Delta Air Lines', NULL, 'Atlanta', 'Delta Boulevard', '1030');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('UA', 'United Airlines', NULL, 'Chicago', 'South Wacker Drive', '233');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('WN', 'Southwest Airlines', NULL, 'Dallas', 'Love Field Dr', '2702');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('AC', 'Air Canada', NULL, 'Montreal', 'Cote Vertu Boulevard', '7373');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('LH', 'Lufthansa', NULL, 'Cologne', 'Frankfurt/Main', 'D-60546');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('CA', 'Air China', NULL, 'Beijing', 'Tianzhu Road', '101312');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('CZ', 'China Southern Airlines', NULL, 'Guangzhou', 'Nan Yun Street East', '510406');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('BA', 'British Airways', NULL, 'Harmondsworth', 'Waterside', 'B99');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('FR', 'Ryanair', NULL, 'Dublin', 'Dublin', 'K67NY94');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('AK', 'AirAsia', NULL, 'Kuala Lumpur', '-', '-');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('AS', 'Alaska Airlines', NULL, 'Seattle', 'International Blvd', '19300');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('B6', 'Jetblue Airways', NULL, 'New York', 'Queens Blvd Forest Hills', '118-29');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('SU', 'Aeroflot', NULL, 'Moscow', 'Arbat St', '10');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('TG', 'Thai Airways', NULL, 'Bangkok', 'Vighavadi Rangsit Road', '89');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('HU', 'Hainan Airlines', NULL, 'Haikou', 'Grand China Air Plaza', '18F');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('IB', 'Ideria', NULL, 'Madrid', 'Velazquez', '130');
INSERT INTO public."airline" ("airlineCode", "airlineName", "contactNO", "city", "streetAddrs", "numberAddrs") VALUES ('LX', 'Swiss International Air Line', NULL, 'Basel', 'Malzagasse', '15');



INSERT INTO public."airport" ("airportID", "airportCode", "name", "country", "region") VALUES (1, 'DOH', 'Hamad International Airport', 'Qatar', 'Doha');
INSERT INTO public."airport" ("airportID", "airportCode", "name", "country", "region") VALUES (2, 'SIN', 'Singapore Changi Aiport', 'Singapore', 'East Region');
INSERT INTO public."airport" ("airportID", "airportCode", "name", "country", "region") VALUES (3, 'DXB', 'Dubai International Airport', 'Dubai', 'Al Garhoud district');
INSERT INTO public."airport" ("airportID", "airportCode", "name", "country", "region") VALUES (4, 'NRT', 'Narita International Airport', 'Japan', 'Chiba');
INSERT INTO public."airport" ("airportID", "airportCode", "name", "country", "region") VALUES (5, 'SYD', 'Sydney Airport', 'Australia', 'New South Wales');
INSERT INTO public."airport" ("airportID", "airportCode", "name", "country", "region") VALUES (6, 'HND', 'Haneda Airport', 'Japan', 'Greater Tokyo Area');
INSERT INTO public."airport" ("airportID", "airportCode", "name", "country", "region") VALUES (7, 'IST', 'Istanbul Airport', 'Turkey', 'Arnavutkoy district');
INSERT INTO public."airport" ("airportID", "airportCode", "name", "country", "region") VALUES (8, 'CDG', 'Charles de Gaulle Airport', 'France', 'Paris');
INSERT INTO public."airport" ("airportID", "airportCode", "name", "country", "region") VALUES (9, 'ICN', 'Incheon International Airport', 'South Korea', 'Jung District');
INSERT INTO public."airport" ("airportID", "airportCode", "name", "country", "region") VALUES (10, 'ATH', 'Athens International Airport', 'Greece', 'Attica Region');
INSERT INTO public."airport" ("airportID", "airportCode", "name", "country", "region") VALUES (11, 'DFW', 'Dalla/Fort Worth International Airport', 'United States', 'North Texas Region');
INSERT INTO public."airport" ("airportID", "airportCode", "name", "country", "region") VALUES (12, 'LHR', 'Heathrow Airport', 'England', 'London');