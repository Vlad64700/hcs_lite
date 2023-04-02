--
-- PostgreSQL database dump
--

-- Dumped from database version 12.14 (Ubuntu 12.14-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.14 (Ubuntu 12.14-0ubuntu0.20.04.1)

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

DROP DATABASE smarthcs;
--
-- Name: smarthcs; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE smarthcs WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE smarthcs OWNER TO postgres;

\connect smarthcs

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
-- Name: bank_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bank_account (
    bank_account_id integer NOT NULL,
    category_id integer,
    debt money
);


ALTER TABLE public.bank_account OWNER TO postgres;

--
-- Name: bank_account_bank_account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bank_account_bank_account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bank_account_bank_account_id_seq OWNER TO postgres;

--
-- Name: bank_account_bank_account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bank_account_bank_account_id_seq OWNED BY public.bank_account.bank_account_id;


--
-- Name: calendar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calendar (
    calendar_id integer NOT NULL,
    description text,
    date_start bigint,
    date_end bigint,
    CONSTRAINT date_end_bigger_date_start CHECK ((date_end > date_start))
);


ALTER TABLE public.calendar OWNER TO postgres;

--
-- Name: calendar_calendar_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.calendar_calendar_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.calendar_calendar_id_seq OWNER TO postgres;

--
-- Name: calendar_calendar_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.calendar_calendar_id_seq OWNED BY public.calendar.calendar_id;


--
-- Name: device_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.device_settings (
    device_id integer NOT NULL,
    config text NOT NULL,
    description text
);


ALTER TABLE public.device_settings OWNER TO postgres;

--
-- Name: device_types; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.device_types (
    device_type_id integer NOT NULL,
    device_type_name text NOT NULL,
    description_json jsonb
);


ALTER TABLE public.device_types OWNER TO admin;

--
-- Name: device_types_device_type_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.device_types_device_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.device_types_device_type_id_seq OWNER TO admin;

--
-- Name: device_types_device_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.device_types_device_type_id_seq OWNED BY public.device_types.device_type_id;


--
-- Name: devices; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.devices (
    device_id integer NOT NULL,
    description text,
    device_name character varying NOT NULL,
    device_tag character varying NOT NULL,
    user_id integer NOT NULL,
    object_id integer,
    device_type_id integer
);


ALTER TABLE public.devices OWNER TO admin;

--
-- Name: devices_device_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.devices_device_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.devices_device_id_seq OWNER TO admin;

--
-- Name: devices_device_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.devices_device_id_seq OWNED BY public.devices.device_id;


--
-- Name: devices_state; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.devices_state (
    state_id bigint NOT NULL,
    device_id integer NOT NULL,
    state_name character varying NOT NULL,
    state_value character varying NOT NULL,
    state_time bigint NOT NULL,
    state_type integer
);


ALTER TABLE public.devices_state OWNER TO admin;

--
-- Name: devices_state_state_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.devices_state_state_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.devices_state_state_id_seq OWNER TO admin;

--
-- Name: devices_state_state_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.devices_state_state_id_seq OWNED BY public.devices_state.state_id;


--
-- Name: events_out_of_range; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.events_out_of_range (
    range_value_id integer NOT NULL,
    measurement_id integer NOT NULL,
    out_of_range boolean NOT NULL,
    status text,
    events_out_of_range_id integer NOT NULL,
    who_checked integer
);


ALTER TABLE public.events_out_of_range OWNER TO admin;

--
-- Name: events_out_of_range_events_out_of_range_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.events_out_of_range_events_out_of_range_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_out_of_range_events_out_of_range_seq OWNER TO admin;

--
-- Name: events_out_of_range_events_out_of_range_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.events_out_of_range_events_out_of_range_seq OWNED BY public.events_out_of_range.events_out_of_range_id;


--
-- Name: measure_instruments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.measure_instruments (
    measure_instrument_id integer NOT NULL,
    coefficient double precision DEFAULT 1 NOT NULL,
    tariff_id integer,
    serial_number integer NOT NULL,
    bank_account_id integer
);


ALTER TABLE public.measure_instruments OWNER TO postgres;

--
-- Name: measure_instruments_measure_instrument_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.measure_instruments_measure_instrument_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.measure_instruments_measure_instrument_id_seq OWNER TO postgres;

--
-- Name: measure_instruments_measure_instrument_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.measure_instruments_measure_instrument_id_seq OWNED BY public.measure_instruments.measure_instrument_id;


--
-- Name: meter_types; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.meter_types (
    meter_type_id integer NOT NULL,
    meter_type_name text NOT NULL
);


ALTER TABLE public.meter_types OWNER TO admin;

--
-- Name: meter_types_meter_type_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.meter_types_meter_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.meter_types_meter_type_id_seq OWNER TO admin;

--
-- Name: meter_types_meter_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.meter_types_meter_type_id_seq OWNED BY public.meter_types.meter_type_id;


--
-- Name: meter_values; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.meter_values (
    measurement_id integer NOT NULL,
    meter_id integer NOT NULL,
    value double precision NOT NULL,
    "time" bigint NOT NULL,
    received_from_user integer,
    sub_tariff_id integer
);


ALTER TABLE public.meter_values OWNER TO admin;

--
-- Name: meter_values_measurement_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.meter_values_measurement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.meter_values_measurement_id_seq OWNER TO admin;

--
-- Name: meter_values_measurement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.meter_values_measurement_id_seq OWNED BY public.meter_values.measurement_id;


--
-- Name: object_address; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.object_address (
    object_id integer NOT NULL,
    description text,
    parent_id integer,
    city text,
    street text,
    house text,
    flat integer,
    object_type_id integer NOT NULL
);


ALTER TABLE public.object_address OWNER TO admin;

--
-- Name: object_address_object_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.object_address_object_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.object_address_object_id_seq OWNER TO admin;

--
-- Name: object_address_object_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.object_address_object_id_seq OWNED BY public.object_address.object_id;


--
-- Name: object_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.object_types (
    object_type_id integer NOT NULL,
    object_type_name text NOT NULL
);


ALTER TABLE public.object_types OWNER TO postgres;

--
-- Name: object_types_object_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.object_types_object_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.object_types_object_type_id_seq OWNER TO postgres;

--
-- Name: object_types_object_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.object_types_object_type_id_seq OWNED BY public.object_types.object_type_id;


--
-- Name: range_value; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.range_value (
    range_value_id integer NOT NULL,
    description text,
    meter_id integer NOT NULL,
    min_value double precision NOT NULL,
    max_value double precision NOT NULL,
    time_zone_id integer,
    CONSTRAINT minmaxcheck CHECK ((max_value > min_value))
);


ALTER TABLE public.range_value OWNER TO admin;

--
-- Name: range_value_range_value_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.range_value_range_value_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.range_value_range_value_id_seq OWNER TO admin;

--
-- Name: range_value_range_value_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.range_value_range_value_id_seq OWNED BY public.range_value.range_value_id;


--
-- Name: sensors_counters; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.sensors_counters (
    meter_id integer NOT NULL,
    object_id integer NOT NULL,
    description text,
    device_id integer NOT NULL,
    meter_name character varying NOT NULL,
    meter_type integer NOT NULL,
    measure_instrument_id integer
);


ALTER TABLE public.sensors_counters OWNER TO admin;

--
-- Name: sensors_counters_meter_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.sensors_counters_meter_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sensors_counters_meter_id_seq OWNER TO admin;

--
-- Name: sensors_counters_meter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.sensors_counters_meter_id_seq OWNED BY public.sensors_counters.meter_id;


--
-- Name: state_types; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.state_types (
    state_type_id integer NOT NULL,
    state_name text NOT NULL
);


ALTER TABLE public.state_types OWNER TO admin;

--
-- Name: state_types_state_type_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.state_types_state_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.state_types_state_type_id_seq OWNER TO admin;

--
-- Name: state_types_state_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.state_types_state_type_id_seq OWNED BY public.state_types.state_type_id;


--
-- Name: sub_tariff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sub_tariff (
    sub_tariff_id integer NOT NULL,
    tariff_id integer NOT NULL,
    calendar_id integer NOT NULL,
    time_min time without time zone,
    time_max time without time zone,
    price double precision NOT NULL,
    description text
);


ALTER TABLE public.sub_tariff OWNER TO postgres;

--
-- Name: sub_tariff_sub_tariff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sub_tariff_sub_tariff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sub_tariff_sub_tariff_id_seq OWNER TO postgres;

--
-- Name: sub_tariff_sub_tariff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sub_tariff_sub_tariff_id_seq OWNED BY public.sub_tariff.sub_tariff_id;


--
-- Name: tariff; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tariff (
    tariff_id integer NOT NULL,
    description text,
    tariff_name text NOT NULL,
    date_start bigint NOT NULL,
    date_end bigint NOT NULL,
    CONSTRAINT check_date_end_bigger_then_date_start CHECK ((date_end > date_start))
);


ALTER TABLE public.tariff OWNER TO postgres;

--
-- Name: tariff_tariff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tariff_tariff_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tariff_tariff_id_seq OWNER TO postgres;

--
-- Name: tariff_tariff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tariff_tariff_id_seq OWNED BY public.tariff.tariff_id;


--
-- Name: time_zone; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.time_zone (
    time_zone_id integer NOT NULL,
    time_min time without time zone,
    time_max time without time zone,
    date_start bigint,
    date_end bigint
);


ALTER TABLE public.time_zone OWNER TO postgres;

--
-- Name: time_zone_time_zone_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.time_zone_time_zone_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.time_zone_time_zone_id_seq OWNER TO postgres;

--
-- Name: time_zone_time_zone_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.time_zone_time_zone_id_seq OWNED BY public.time_zone.time_zone_id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    transaction_id integer NOT NULL,
    bank_account_id integer,
    status text,
    date bigint,
    sender text,
    number_bank_account text,
    contract_number text,
    payment_purpose text,
    bik text,
    bank_sender text,
    inn text,
    kpp text,
    payment_amount money
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transactions_transaction_id_seq OWNER TO postgres;

--
-- Name: transactions_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_transaction_id_seq OWNED BY public.transactions.transaction_id;


--
-- Name: user_bank_account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_bank_account (
    user_id integer NOT NULL,
    bank_account_id integer NOT NULL
);


ALTER TABLE public.user_bank_account OWNER TO postgres;

--
-- Name: user_object; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_object (
    user_id integer NOT NULL,
    object_id integer NOT NULL
);


ALTER TABLE public.user_object OWNER TO admin;

--
-- Name: users; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    name text NOT NULL,
    role text NOT NULL,
    login text NOT NULL,
    password text NOT NULL,
    email text NOT NULL,
    telegram text,
    phone_number text,
    image_profile text
);


ALTER TABLE public.users OWNER TO admin;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO admin;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: bank_account bank_account_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bank_account ALTER COLUMN bank_account_id SET DEFAULT nextval('public.bank_account_bank_account_id_seq'::regclass);


--
-- Name: calendar calendar_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calendar ALTER COLUMN calendar_id SET DEFAULT nextval('public.calendar_calendar_id_seq'::regclass);


--
-- Name: device_types device_type_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.device_types ALTER COLUMN device_type_id SET DEFAULT nextval('public.device_types_device_type_id_seq'::regclass);


--
-- Name: devices device_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.devices ALTER COLUMN device_id SET DEFAULT nextval('public.devices_device_id_seq'::regclass);


--
-- Name: devices_state state_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.devices_state ALTER COLUMN state_id SET DEFAULT nextval('public.devices_state_state_id_seq'::regclass);


--
-- Name: events_out_of_range events_out_of_range_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.events_out_of_range ALTER COLUMN events_out_of_range_id SET DEFAULT nextval('public.events_out_of_range_events_out_of_range_seq'::regclass);


--
-- Name: measure_instruments measure_instrument_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measure_instruments ALTER COLUMN measure_instrument_id SET DEFAULT nextval('public.measure_instruments_measure_instrument_id_seq'::regclass);


--
-- Name: meter_types meter_type_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.meter_types ALTER COLUMN meter_type_id SET DEFAULT nextval('public.meter_types_meter_type_id_seq'::regclass);


--
-- Name: meter_values measurement_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.meter_values ALTER COLUMN measurement_id SET DEFAULT nextval('public.meter_values_measurement_id_seq'::regclass);


--
-- Name: object_address object_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.object_address ALTER COLUMN object_id SET DEFAULT nextval('public.object_address_object_id_seq'::regclass);


--
-- Name: object_types object_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.object_types ALTER COLUMN object_type_id SET DEFAULT nextval('public.object_types_object_type_id_seq'::regclass);


--
-- Name: range_value range_value_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.range_value ALTER COLUMN range_value_id SET DEFAULT nextval('public.range_value_range_value_id_seq'::regclass);


--
-- Name: sensors_counters meter_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sensors_counters ALTER COLUMN meter_id SET DEFAULT nextval('public.sensors_counters_meter_id_seq'::regclass);


--
-- Name: state_types state_type_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.state_types ALTER COLUMN state_type_id SET DEFAULT nextval('public.state_types_state_type_id_seq'::regclass);


--
-- Name: sub_tariff sub_tariff_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_tariff ALTER COLUMN sub_tariff_id SET DEFAULT nextval('public.sub_tariff_sub_tariff_id_seq'::regclass);


--
-- Name: tariff tariff_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariff ALTER COLUMN tariff_id SET DEFAULT nextval('public.tariff_tariff_id_seq'::regclass);


--
-- Name: time_zone time_zone_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.time_zone ALTER COLUMN time_zone_id SET DEFAULT nextval('public.time_zone_time_zone_id_seq'::regclass);


--
-- Name: transactions transaction_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN transaction_id SET DEFAULT nextval('public.transactions_transaction_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: bank_account bank_account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bank_account
    ADD CONSTRAINT bank_account_pkey PRIMARY KEY (bank_account_id);


--
-- Name: calendar calendar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calendar
    ADD CONSTRAINT calendar_pkey PRIMARY KEY (calendar_id);


--
-- Name: device_types device_type_name_unique; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.device_types
    ADD CONSTRAINT device_type_name_unique UNIQUE (device_type_name);


--
-- Name: device_types device_types_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.device_types
    ADD CONSTRAINT device_types_pkey PRIMARY KEY (device_type_id);


--
-- Name: devices devices_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_pkey PRIMARY KEY (device_id);


--
-- Name: devices_state devices_state_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.devices_state
    ADD CONSTRAINT devices_state_pkey PRIMARY KEY (state_id);


--
-- Name: events_out_of_range events_out_of_range_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.events_out_of_range
    ADD CONSTRAINT events_out_of_range_pkey PRIMARY KEY (events_out_of_range_id);


--
-- Name: measure_instruments measure_instruments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measure_instruments
    ADD CONSTRAINT measure_instruments_pkey PRIMARY KEY (measure_instrument_id);


--
-- Name: meter_values meter_values_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.meter_values
    ADD CONSTRAINT meter_values_pkey PRIMARY KEY (measurement_id);


--
-- Name: object_address object_address_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.object_address
    ADD CONSTRAINT object_address_pkey PRIMARY KEY (object_id);


--
-- Name: object_types object_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.object_types
    ADD CONSTRAINT object_types_pkey PRIMARY KEY (object_type_id);


--
-- Name: user_bank_account pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_bank_account
    ADD CONSTRAINT pk PRIMARY KEY (user_id, bank_account_id);


--
-- Name: meter_types pk_meter_types; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.meter_types
    ADD CONSTRAINT pk_meter_types PRIMARY KEY (meter_type_id);


--
-- Name: state_types pk_state_types; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.state_types
    ADD CONSTRAINT pk_state_types PRIMARY KEY (state_type_id);


--
-- Name: range_value range_value_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.range_value
    ADD CONSTRAINT range_value_pkey PRIMARY KEY (range_value_id);


--
-- Name: sensors_counters sensors_counters_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sensors_counters
    ADD CONSTRAINT sensors_counters_pkey PRIMARY KEY (meter_id);


--
-- Name: sub_tariff sub_tariff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_tariff
    ADD CONSTRAINT sub_tariff_pkey PRIMARY KEY (sub_tariff_id);


--
-- Name: tariff tariff_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tariff
    ADD CONSTRAINT tariff_pkey PRIMARY KEY (tariff_id);


--
-- Name: time_zone time_zone_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.time_zone
    ADD CONSTRAINT time_zone_pkey PRIMARY KEY (time_zone_id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (transaction_id);


--
-- Name: devices unique_name_tag; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT unique_name_tag UNIQUE (device_name, device_tag);


--
-- Name: users unique_users; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT unique_users UNIQUE (login);


--
-- Name: user_object user_object_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_object
    ADD CONSTRAINT user_object_pkey PRIMARY KEY (user_id, object_id);


--
-- Name: users user_unique; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_unique UNIQUE (login);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: bank_account_id_on_measure_instrument; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX bank_account_id_on_measure_instrument ON public.measure_instruments USING btree (bank_account_id);


--
-- Name: calendar_id_on_sub_tariff; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX calendar_id_on_sub_tariff ON public.sub_tariff USING btree (calendar_id);


--
-- Name: device_id_on_sensors_counters; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX device_id_on_sensors_counters ON public.sensors_counters USING btree (device_id);


--
-- Name: device_id_state_name; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX device_id_state_name ON public.devices_state USING btree (device_id, state_name);


--
-- Name: measure_instrument_on_sensors_counters; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX measure_instrument_on_sensors_counters ON public.sensors_counters USING btree (measure_instrument_id);


--
-- Name: measurement_id_on_events_out_of_range; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX measurement_id_on_events_out_of_range ON public.events_out_of_range USING btree (measurement_id);


--
-- Name: meter_id_mater_name; Type: INDEX; Schema: public; Owner: admin
--

CREATE UNIQUE INDEX meter_id_mater_name ON public.sensors_counters USING btree (device_id, meter_name);


--
-- Name: meter_id_on_meter_valus; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX meter_id_on_meter_valus ON public.meter_values USING btree (meter_id);


--
-- Name: meter_id_on_range_value; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX meter_id_on_range_value ON public.range_value USING btree (meter_id);


--
-- Name: object_id_on_devices; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX object_id_on_devices ON public.devices USING btree (object_id);


--
-- Name: object_id_on_sensors_counters; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX object_id_on_sensors_counters ON public.sensors_counters USING btree (object_id);


--
-- Name: range_value_on_events_out_of_range; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX range_value_on_events_out_of_range ON public.events_out_of_range USING btree (range_value_id);


--
-- Name: tariff_id_on_measure_instrument; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tariff_id_on_measure_instrument ON public.measure_instruments USING btree (tariff_id);


--
-- Name: tariff_id_on_sub_tariff; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tariff_id_on_sub_tariff ON public.sub_tariff USING btree (tariff_id);


--
-- Name: time_on_meter_valus; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX time_on_meter_valus ON public.meter_values USING btree ("time");


--
-- Name: time_zone_id_on_range_value; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX time_zone_id_on_range_value ON public.range_value USING btree (time_zone_id);


--
-- Name: user_id_on_devices; Type: INDEX; Schema: public; Owner: admin
--

CREATE INDEX user_id_on_devices ON public.devices USING btree (user_id);


--
-- Name: device_settings device_settings_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.device_settings
    ADD CONSTRAINT device_settings_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.devices(device_id);


--
-- Name: devices devices_device_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_device_type_id_fkey FOREIGN KEY (device_type_id) REFERENCES public.device_types(device_type_id);


--
-- Name: devices devices_object_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_object_id_fkey FOREIGN KEY (object_id) REFERENCES public.object_address(object_id);


--
-- Name: devices_state devices_state_state_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.devices_state
    ADD CONSTRAINT devices_state_state_type_fkey FOREIGN KEY (state_type) REFERENCES public.state_types(state_type_id);


--
-- Name: devices devices_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: events_out_of_range events_out_of_range_measurement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.events_out_of_range
    ADD CONSTRAINT events_out_of_range_measurement_id_fkey FOREIGN KEY (measurement_id) REFERENCES public.meter_values(measurement_id);


--
-- Name: events_out_of_range events_out_of_range_range_value_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.events_out_of_range
    ADD CONSTRAINT events_out_of_range_range_value_id_fkey FOREIGN KEY (range_value_id) REFERENCES public.range_value(range_value_id);


--
-- Name: events_out_of_range events_out_of_range_who_checked_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.events_out_of_range
    ADD CONSTRAINT events_out_of_range_who_checked_fkey FOREIGN KEY (who_checked) REFERENCES public.users(user_id);


--
-- Name: devices_state fk_devices_state_device_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.devices_state
    ADD CONSTRAINT fk_devices_state_device_id FOREIGN KEY (device_id) REFERENCES public.devices(device_id);


--
-- Name: range_value fk_meter_id; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.range_value
    ADD CONSTRAINT fk_meter_id FOREIGN KEY (meter_id) REFERENCES public.sensors_counters(meter_id);


--
-- Name: measure_instruments measure_instruments_bank_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measure_instruments
    ADD CONSTRAINT measure_instruments_bank_account_id_fkey FOREIGN KEY (bank_account_id) REFERENCES public.bank_account(bank_account_id);


--
-- Name: measure_instruments measure_instruments_tariff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.measure_instruments
    ADD CONSTRAINT measure_instruments_tariff_id_fkey FOREIGN KEY (tariff_id) REFERENCES public.tariff(tariff_id);


--
-- Name: meter_values meter_values_meter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.meter_values
    ADD CONSTRAINT meter_values_meter_id_fkey FOREIGN KEY (meter_id) REFERENCES public.sensors_counters(meter_id);


--
-- Name: meter_values meter_values_received_from_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.meter_values
    ADD CONSTRAINT meter_values_received_from_user_fkey FOREIGN KEY (received_from_user) REFERENCES public.users(user_id);


--
-- Name: meter_values meter_values_sub_tariff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.meter_values
    ADD CONSTRAINT meter_values_sub_tariff_id_fkey FOREIGN KEY (sub_tariff_id) REFERENCES public.sub_tariff(sub_tariff_id);


--
-- Name: object_address object_address_object_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.object_address
    ADD CONSTRAINT object_address_object_type_id_fkey FOREIGN KEY (object_type_id) REFERENCES public.object_types(object_type_id);


--
-- Name: range_value range_value_time_zone_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.range_value
    ADD CONSTRAINT range_value_time_zone_id_fkey FOREIGN KEY (time_zone_id) REFERENCES public.time_zone(time_zone_id);


--
-- Name: sensors_counters sensors_counters_device_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sensors_counters
    ADD CONSTRAINT sensors_counters_device_id_fkey FOREIGN KEY (device_id) REFERENCES public.devices(device_id);


--
-- Name: sensors_counters sensors_counters_measure_instrument_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sensors_counters
    ADD CONSTRAINT sensors_counters_measure_instrument_id_fkey FOREIGN KEY (measure_instrument_id) REFERENCES public.measure_instruments(measure_instrument_id);


--
-- Name: sensors_counters sensors_counters_meter_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sensors_counters
    ADD CONSTRAINT sensors_counters_meter_type_fkey FOREIGN KEY (meter_type) REFERENCES public.meter_types(meter_type_id);


--
-- Name: sensors_counters sensors_counters_object_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sensors_counters
    ADD CONSTRAINT sensors_counters_object_id_fkey FOREIGN KEY (object_id) REFERENCES public.object_address(object_id);


--
-- Name: sub_tariff sub_tariff_calendar_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_tariff
    ADD CONSTRAINT sub_tariff_calendar_id_fkey FOREIGN KEY (calendar_id) REFERENCES public.calendar(calendar_id);


--
-- Name: sub_tariff sub_tariff_tariff_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sub_tariff
    ADD CONSTRAINT sub_tariff_tariff_id_fkey FOREIGN KEY (tariff_id) REFERENCES public.tariff(tariff_id);


--
-- Name: transactions transactions_bank_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_bank_account_id_fkey FOREIGN KEY (bank_account_id) REFERENCES public.bank_account(bank_account_id);


--
-- Name: user_bank_account user_bank_account_bank_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_bank_account
    ADD CONSTRAINT user_bank_account_bank_account_id_fkey FOREIGN KEY (bank_account_id) REFERENCES public.bank_account(bank_account_id);


--
-- Name: user_bank_account user_bank_account_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_bank_account
    ADD CONSTRAINT user_bank_account_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: user_object user_object_object_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_object
    ADD CONSTRAINT user_object_object_id_fkey FOREIGN KEY (object_id) REFERENCES public.object_address(object_id);


--
-- Name: user_object user_object_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_object
    ADD CONSTRAINT user_object_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: TABLE bank_account; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.bank_account TO smarthcs;
GRANT ALL ON TABLE public.bank_account TO admin;


--
-- Name: SEQUENCE bank_account_bank_account_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.bank_account_bank_account_id_seq TO smarthcs;
GRANT ALL ON SEQUENCE public.bank_account_bank_account_id_seq TO admin;


--
-- Name: TABLE calendar; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.calendar TO smarthcs;
GRANT ALL ON TABLE public.calendar TO admin;


--
-- Name: SEQUENCE calendar_calendar_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.calendar_calendar_id_seq TO smarthcs;
GRANT ALL ON SEQUENCE public.calendar_calendar_id_seq TO admin;


--
-- Name: TABLE device_settings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.device_settings TO smarthcs;
GRANT ALL ON TABLE public.device_settings TO admin;


--
-- Name: TABLE device_types; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON TABLE public.device_types TO smarthcs;


--
-- Name: SEQUENCE device_types_device_type_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.device_types_device_type_id_seq TO smarthcs;


--
-- Name: TABLE devices; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON TABLE public.devices TO smarthcs;


--
-- Name: SEQUENCE devices_device_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.devices_device_id_seq TO smarthcs;


--
-- Name: TABLE devices_state; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON TABLE public.devices_state TO smarthcs;


--
-- Name: SEQUENCE devices_state_state_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.devices_state_state_id_seq TO smarthcs;


--
-- Name: TABLE events_out_of_range; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON TABLE public.events_out_of_range TO smarthcs;


--
-- Name: SEQUENCE events_out_of_range_events_out_of_range_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.events_out_of_range_events_out_of_range_seq TO smarthcs;


--
-- Name: TABLE measure_instruments; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.measure_instruments TO smarthcs;
GRANT ALL ON TABLE public.measure_instruments TO admin;


--
-- Name: SEQUENCE measure_instruments_measure_instrument_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.measure_instruments_measure_instrument_id_seq TO smarthcs;
GRANT ALL ON SEQUENCE public.measure_instruments_measure_instrument_id_seq TO admin;


--
-- Name: TABLE meter_types; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON TABLE public.meter_types TO smarthcs;


--
-- Name: SEQUENCE meter_types_meter_type_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.meter_types_meter_type_id_seq TO smarthcs;


--
-- Name: TABLE meter_values; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON TABLE public.meter_values TO smarthcs;


--
-- Name: SEQUENCE meter_values_measurement_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.meter_values_measurement_id_seq TO smarthcs;


--
-- Name: TABLE object_address; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON TABLE public.object_address TO smarthcs;


--
-- Name: SEQUENCE object_address_object_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.object_address_object_id_seq TO smarthcs;


--
-- Name: TABLE object_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.object_types TO smarthcs;
GRANT ALL ON TABLE public.object_types TO admin;


--
-- Name: SEQUENCE object_types_object_type_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.object_types_object_type_id_seq TO smarthcs;
GRANT ALL ON SEQUENCE public.object_types_object_type_id_seq TO admin;


--
-- Name: TABLE range_value; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON TABLE public.range_value TO smarthcs;


--
-- Name: SEQUENCE range_value_range_value_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.range_value_range_value_id_seq TO smarthcs;


--
-- Name: TABLE sensors_counters; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON TABLE public.sensors_counters TO smarthcs;


--
-- Name: SEQUENCE sensors_counters_meter_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.sensors_counters_meter_id_seq TO smarthcs;


--
-- Name: TABLE state_types; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON TABLE public.state_types TO smarthcs;


--
-- Name: SEQUENCE state_types_state_type_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.state_types_state_type_id_seq TO smarthcs;


--
-- Name: TABLE sub_tariff; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sub_tariff TO smarthcs;
GRANT ALL ON TABLE public.sub_tariff TO admin;


--
-- Name: SEQUENCE sub_tariff_sub_tariff_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.sub_tariff_sub_tariff_id_seq TO smarthcs;
GRANT ALL ON SEQUENCE public.sub_tariff_sub_tariff_id_seq TO admin;


--
-- Name: TABLE tariff; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.tariff TO smarthcs;
GRANT ALL ON TABLE public.tariff TO admin;


--
-- Name: SEQUENCE tariff_tariff_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.tariff_tariff_id_seq TO smarthcs;
GRANT ALL ON SEQUENCE public.tariff_tariff_id_seq TO admin;


--
-- Name: TABLE time_zone; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.time_zone TO smarthcs;
GRANT ALL ON TABLE public.time_zone TO admin;


--
-- Name: SEQUENCE time_zone_time_zone_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.time_zone_time_zone_id_seq TO smarthcs;
GRANT ALL ON SEQUENCE public.time_zone_time_zone_id_seq TO admin;


--
-- Name: TABLE transactions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.transactions TO smarthcs;
GRANT ALL ON TABLE public.transactions TO admin;


--
-- Name: SEQUENCE transactions_transaction_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.transactions_transaction_id_seq TO smarthcs;
GRANT ALL ON SEQUENCE public.transactions_transaction_id_seq TO admin;


--
-- Name: TABLE user_bank_account; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_bank_account TO smarthcs;
GRANT ALL ON TABLE public.user_bank_account TO admin;


--
-- Name: TABLE user_object; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON TABLE public.user_object TO smarthcs;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON TABLE public.users TO smarthcs;


--
-- Name: SEQUENCE users_user_id_seq; Type: ACL; Schema: public; Owner: admin
--

GRANT ALL ON SEQUENCE public.users_user_id_seq TO smarthcs;


--
-- PostgreSQL database dump complete
--

