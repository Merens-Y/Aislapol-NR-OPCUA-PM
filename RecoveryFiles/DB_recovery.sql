--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3
-- Dumped by pg_dump version 15.3

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
-- Name: handle_insert_molding_status(character varying, boolean, boolean, boolean, boolean, boolean, character varying, integer, double precision, double precision, double precision, integer, integer, integer, integer, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_insert_molding_status(machine_serial_number character varying, is_running boolean, is_stopped boolean, is_automatic boolean, is_manual boolean, is_disconnected boolean, last_recipe_name character varying, life_cycles integer, mold_distance double precision, current_cycle_time double precision, last_cycle_time double precision, working_time_auto integer, working_time_manual integer, working_time_total integer, working_time_hydraulic integer, alarm_00_description character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if the machine_serial_number exists in the MoldingMachines table
    IF NOT EXISTS (
        SELECT 1 
        FROM MoldingMachines 
        WHERE machine_serial_number = machine_serial_number
    ) THEN
        -- Insert the new machine
        INSERT INTO MoldingMachines (machine_serial_number)
        VALUES (machine_serial_number);
    END IF;

    -- Now, insert the status data
    INSERT INTO MoldingMachinesStates (
        machine_serial_number, 
        is_running, 
        is_stopped, 
        is_automatic, 
        is_manual, 
        is_disconnected,
        last_recipe_name,
        life_cycles,
        mold_distance,
        current_cycle_time,
        last_cycle_time,
        working_time_auto,
        working_time_manual,
        working_time_total,
        working_time_hydraulic,
        alarm_00_description
    )
    VALUES (
        machine_serial_number, 
        is_running, 
        is_stopped, 
        is_automatic, 
        is_manual, 
        is_disconnected,
        last_recipe_name,
        life_cycles,
        mold_distance,
        current_cycle_time,
        last_cycle_time,
        working_time_auto,
        working_time_manual,
        working_time_total,
        working_time_hydraulic,
        alarm_00_description
    );

    RAISE NOTICE 'Status data inserted successfully.';
END;
$$;


ALTER FUNCTION public.handle_insert_molding_status(machine_serial_number character varying, is_running boolean, is_stopped boolean, is_automatic boolean, is_manual boolean, is_disconnected boolean, last_recipe_name character varying, life_cycles integer, mold_distance double precision, current_cycle_time double precision, last_cycle_time double precision, working_time_auto integer, working_time_manual integer, working_time_total integer, working_time_hydraulic integer, alarm_00_description character varying) OWNER TO postgres;

--
-- Name: handle_insert_pre_exp_status(character varying, boolean, boolean, character varying, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_insert_pre_exp_status(machine_serial_number character varying, is_connected boolean, is_disconnected boolean, last_recipe_name character varying, life_cycles integer, working_time_auto integer, working_time_manual integer, working_time_total integer, m01_working_time integer, m02_working_time integer, m03_working_time integer, m04_working_time integer, m05_working_time integer, m06_working_time integer, m07_working_time integer, m08_working_time integer, m09_working_time integer, m10_working_time integer, m11_working_time integer, m12_working_time integer, m13_working_time integer, m14_working_time integer, m15_working_time integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if the machine_serial_number exists in the PreExpMachines table
    IF NOT EXISTS (
        SELECT 1 
        FROM PreExpMachines 
        WHERE machine_serial_number = machine_serial_number
    ) THEN
        -- Insert the new machine
        INSERT INTO PreExpMachines (machine_serial_number)
        VALUES (machine_serial_number);
    END IF;

    -- Now, insert the status data
    INSERT INTO PreExpMachinesStates (
        machine_serial_number, 
        is_connected, 
        is_disconnected, 
        last_recipe_name, 
        life_cycles, 
        working_time_auto, 
        working_time_manual, 
        working_time_total, 
        m01_working_time, 
        m02_working_time, 
        m03_working_time, 
        m04_working_time, 
        m05_working_time, 
        m06_working_time, 
        m07_working_time, 
        m08_working_time, 
        m09_working_time, 
        m10_working_time, 
        m11_working_time, 
        m12_working_time, 
        m13_working_time, 
        m14_working_time, 
        m15_working_time
    )
    VALUES (
        machine_serial_number, 
        is_connected, 
        is_disconnected, 
        last_recipe_name, 
        life_cycles, 
        working_time_auto, 
        working_time_manual, 
        working_time_total, 
        m01_working_time, 
        m02_working_time, 
        m03_working_time, 
        m04_working_time, 
        m05_working_time, 
        m06_working_time, 
        m07_working_time, 
        m08_working_time, 
        m09_working_time, 
        m10_working_time, 
        m11_working_time, 
        m12_working_time, 
        m13_working_time, 
        m14_working_time, 
        m15_working_time
    );

    RAISE NOTICE 'Status data inserted successfully.';
END;
$$;


ALTER FUNCTION public.handle_insert_pre_exp_status(machine_serial_number character varying, is_connected boolean, is_disconnected boolean, last_recipe_name character varying, life_cycles integer, working_time_auto integer, working_time_manual integer, working_time_total integer, m01_working_time integer, m02_working_time integer, m03_working_time integer, m04_working_time integer, m05_working_time integer, m06_working_time integer, m07_working_time integer, m08_working_time integer, m09_working_time integer, m10_working_time integer, m11_working_time integer, m12_working_time integer, m13_working_time integer, m14_working_time integer, m15_working_time integer) OWNER TO postgres;

--
-- Name: insert_molding_machine_cycle(character varying, character varying, integer, double precision, boolean); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_molding_machine_cycle(machine_serial_number character varying, mold_recipe_name character varying, cycle_number integer, cycle_time double precision, is_maintenance boolean) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if the machine_serial_number exists in the MoldingMachines table
    IF NOT EXISTS (
        SELECT 1 
        FROM MoldingMachines 
        WHERE machine_serial_number = machine_serial_number
    ) THEN
        RAISE EXCEPTION 'Machine serial number does not exist in MoldingMachines table';
        RETURN;
    END IF;

    -- Check if the mold_recipe_name exists in the Molds table
    IF NOT EXISTS (
        SELECT 1 
        FROM Molds 
        WHERE mold_recipe_name = mold_recipe_name
    ) THEN
        RAISE EXCEPTION 'Mold recipe name does not exist in Molds table';
        RETURN;
    END IF;

    -- Now, insert the cycle data
    INSERT INTO MoldingMachinesCycles (
        machine_serial_number, 
        mold_recipe_name, 
        cycle_number, 
        cycle_time
    )
    VALUES (
        machine_serial_number, 
        mold_recipe_name, 
        cycle_number, 
        cycle_time
    );

    RAISE NOTICE 'Molding machine cycle inserted successfully.';
END;
$$;


ALTER FUNCTION public.insert_molding_machine_cycle(machine_serial_number character varying, mold_recipe_name character varying, cycle_number integer, cycle_time double precision, is_maintenance boolean) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: MoldingMachines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."MoldingMachines" (
    machine_id integer NOT NULL,
    machine_serial_number character varying(255) NOT NULL
);


ALTER TABLE public."MoldingMachines" OWNER TO postgres;

--
-- Name: MoldingMachinesCycles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."MoldingMachinesCycles" (
    cycle_id integer NOT NULL,
    machine_serial_number character varying(255),
    mold_recipe_name character varying(255),
    cycle_number integer,
    cycle_time double precision,
    is_maintenance boolean DEFAULT false,
    time_stamp timestamp without time zone DEFAULT now()
);


ALTER TABLE public."MoldingMachinesCycles" OWNER TO postgres;

--
-- Name: MoldingMachinesCycles_cycle_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."MoldingMachinesCycles_cycle_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."MoldingMachinesCycles_cycle_id_seq" OWNER TO postgres;

--
-- Name: MoldingMachinesCycles_cycle_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."MoldingMachinesCycles_cycle_id_seq" OWNED BY public."MoldingMachinesCycles".cycle_id;


--
-- Name: MoldingMachinesStates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."MoldingMachinesStates" (
    state_id integer NOT NULL,
    machine_serial_number character varying(255),
    is_running boolean,
    is_stopped boolean,
    is_automatic boolean,
    is_manual boolean,
    is_disconnected boolean,
    last_recipe_name character varying(255),
    life_cycles integer,
    mold_distance double precision,
    current_cycle_time double precision,
    last_cycle_time double precision,
    working_time_auto integer,
    working_time_manual integer,
    working_time_total integer,
    working_time_hydraulic integer,
    alarm_00_description character varying(255),
    time_stamp timestamp without time zone DEFAULT now()
);


ALTER TABLE public."MoldingMachinesStates" OWNER TO postgres;

--
-- Name: MoldingMachinesStates_state_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."MoldingMachinesStates_state_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."MoldingMachinesStates_state_id_seq" OWNER TO postgres;

--
-- Name: MoldingMachinesStates_state_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."MoldingMachinesStates_state_id_seq" OWNED BY public."MoldingMachinesStates".state_id;


--
-- Name: MoldingMachines_machine_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."MoldingMachines_machine_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."MoldingMachines_machine_id_seq" OWNER TO postgres;

--
-- Name: MoldingMachines_machine_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."MoldingMachines_machine_id_seq" OWNED BY public."MoldingMachines".machine_id;


--
-- Name: Molds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Molds" (
    mold_id integer NOT NULL,
    mold_recipe_name character varying(255) NOT NULL,
    tc_ideal double precision DEFAULT 95.0 NOT NULL,
    tc_max double precision DEFAULT 110.0 NOT NULL,
    nc_ideal integer DEFAULT 15000 NOT NULL,
    nc_max integer DEFAULT 25000 NOT NULL
);


ALTER TABLE public."Molds" OWNER TO postgres;

--
-- Name: Molds_mold_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Molds_mold_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."Molds_mold_id_seq" OWNER TO postgres;

--
-- Name: Molds_mold_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Molds_mold_id_seq" OWNED BY public."Molds".mold_id;


--
-- Name: PreExpMachines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PreExpMachines" (
    machine_id integer NOT NULL,
    machine_serial_number character varying(255) NOT NULL
);


ALTER TABLE public."PreExpMachines" OWNER TO postgres;

--
-- Name: PreExpMachinesStates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PreExpMachinesStates" (
    state_id integer NOT NULL,
    machine_serial_number character varying(255) NOT NULL,
    is_connected boolean,
    is_disconnected boolean,
    last_recipe_name character varying(255),
    life_cycles integer,
    working_time_auto integer,
    working_time_manual integer,
    working_time_total integer,
    m01_working_time integer,
    m02_working_time integer,
    m03_working_time integer,
    m04_working_time integer,
    m05_working_time integer,
    m06_working_time integer,
    m07_working_time integer,
    m08_working_time integer,
    m09_working_time integer,
    m10_working_time integer,
    m11_working_time integer,
    m12_working_time integer,
    m13_working_time integer,
    m14_working_time integer,
    m15_working_time integer,
    time_stamp timestamp without time zone DEFAULT now()
);


ALTER TABLE public."PreExpMachinesStates" OWNER TO postgres;

--
-- Name: PreExpMachinesStates_state_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PreExpMachinesStates_state_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PreExpMachinesStates_state_id_seq" OWNER TO postgres;

--
-- Name: PreExpMachinesStates_state_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PreExpMachinesStates_state_id_seq" OWNED BY public."PreExpMachinesStates".state_id;


--
-- Name: PreExpMachines_machine_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."PreExpMachines_machine_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PreExpMachines_machine_id_seq" OWNER TO postgres;

--
-- Name: PreExpMachines_machine_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."PreExpMachines_machine_id_seq" OWNED BY public."PreExpMachines".machine_id;


--
-- Name: latestmoldingmachinesstates; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.latestmoldingmachinesstates AS
 SELECT DISTINCT ON (mm.machine_serial_number) mm.machine_id,
    mms.state_id,
    mms.machine_serial_number,
    mms.is_running,
    mms.is_stopped,
    mms.is_automatic,
    mms.is_manual,
    mms.is_disconnected,
    mms.last_recipe_name,
    mms.life_cycles,
    mms.mold_distance,
    mms.current_cycle_time,
    mms.last_cycle_time,
    mms.working_time_auto,
    mms.working_time_manual,
    mms.working_time_total,
    mms.working_time_hydraulic,
    mms.alarm_00_description,
    mms.time_stamp
   FROM (public."MoldingMachines" mm
     JOIN public."MoldingMachinesStates" mms ON (((mm.machine_serial_number)::text = (mms.machine_serial_number)::text)))
  ORDER BY mm.machine_serial_number, mms.time_stamp DESC;


ALTER TABLE public.latestmoldingmachinesstates OWNER TO postgres;

--
-- Name: latestpreexpmachinesstates; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.latestpreexpmachinesstates AS
 SELECT DISTINCT ON (pem.machine_serial_number) pem.machine_id,
    pes.state_id,
    pes.machine_serial_number,
    pes.is_connected,
    pes.is_disconnected,
    pes.last_recipe_name,
    pes.life_cycles,
    pes.working_time_auto,
    pes.working_time_manual,
    pes.working_time_total,
    pes.m01_working_time,
    pes.m02_working_time,
    pes.m03_working_time,
    pes.m04_working_time,
    pes.m05_working_time,
    pes.m06_working_time,
    pes.m07_working_time,
    pes.m08_working_time,
    pes.m09_working_time,
    pes.m10_working_time,
    pes.m11_working_time,
    pes.m12_working_time,
    pes.m13_working_time,
    pes.m14_working_time,
    pes.m15_working_time,
    pes.time_stamp
   FROM (public."PreExpMachines" pem
     JOIN public."PreExpMachinesStates" pes ON (((pem.machine_serial_number)::text = (pes.machine_serial_number)::text)))
  ORDER BY pem.machine_serial_number, pes.time_stamp DESC;


ALTER TABLE public.latestpreexpmachinesstates OWNER TO postgres;

--
-- Name: machine_recipe_cycle_counts; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.machine_recipe_cycle_counts AS
 SELECT machines.machine_serial_number AS machine_name,
    ( SELECT json_object_agg(subquery.mold_recipe_name, subquery.recipe_count) AS json_object_agg
           FROM ( SELECT "MoldingMachinesCycles".mold_recipe_name,
                    count(*) AS recipe_count
                   FROM public."MoldingMachinesCycles"
                  WHERE (("MoldingMachinesCycles".time_stamp > ( SELECT max("MoldingMachinesCycles_1".time_stamp) AS max
                           FROM public."MoldingMachinesCycles" "MoldingMachinesCycles_1"
                          WHERE ("MoldingMachinesCycles_1".is_maintenance = true))) AND (("MoldingMachinesCycles".machine_serial_number)::text = (machines.machine_serial_number)::text))
                  GROUP BY "MoldingMachinesCycles".mold_recipe_name
                 HAVING (count(*) > 0)) subquery) AS recipe_counts
   FROM ( SELECT DISTINCT "MoldingMachinesCycles".machine_serial_number
           FROM public."MoldingMachinesCycles") machines;


ALTER TABLE public.machine_recipe_cycle_counts OWNER TO postgres;

--
-- Name: matching_molds; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.matching_molds AS
 SELECT m.mold_id,
    m.mold_recipe_name,
    m.tc_ideal,
    m.tc_max,
    m.nc_ideal,
    m.nc_max
   FROM (public."Molds" m
     JOIN ( SELECT DISTINCT ON ("MoldingMachinesStates".last_recipe_name) "MoldingMachinesStates".last_recipe_name
           FROM public."MoldingMachinesStates"
          WHERE ("MoldingMachinesStates".time_stamp >= (now() - '24:00:00'::interval))) subquery ON (((m.mold_recipe_name)::text = (subquery.last_recipe_name)::text)));


ALTER TABLE public.matching_molds OWNER TO postgres;

--
-- Name: mold_recipe_cycle_count; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.mold_recipe_cycle_count AS
 SELECT "MoldingMachinesCycles".mold_recipe_name,
    count(*) AS cycle_count
   FROM public."MoldingMachinesCycles"
  WHERE ("MoldingMachinesCycles".time_stamp >= (now() - '24:00:00'::interval))
  GROUP BY "MoldingMachinesCycles".mold_recipe_name;


ALTER TABLE public.mold_recipe_cycle_count OWNER TO postgres;

--
-- Name: molding_machine_cycle_time_series; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.molding_machine_cycle_time_series AS
 SELECT "MoldingMachinesCycles".machine_serial_number,
    "MoldingMachinesCycles".mold_recipe_name,
    "MoldingMachinesCycles".cycle_time,
    "MoldingMachinesCycles".time_stamp,
    ((("MoldingMachinesCycles".machine_serial_number)::text || ' - '::text) || ("MoldingMachinesCycles".mold_recipe_name)::text) AS machine_recipe_combination
   FROM public."MoldingMachinesCycles"
  WHERE ("MoldingMachinesCycles".time_stamp >= (now() - '24:00:00'::interval))
  ORDER BY ((("MoldingMachinesCycles".machine_serial_number)::text || ' - '::text) || ("MoldingMachinesCycles".mold_recipe_name)::text), "MoldingMachinesCycles".time_stamp;


ALTER TABLE public.molding_machine_cycle_time_series OWNER TO postgres;

--
-- Name: MoldingMachines machine_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MoldingMachines" ALTER COLUMN machine_id SET DEFAULT nextval('public."MoldingMachines_machine_id_seq"'::regclass);


--
-- Name: MoldingMachinesCycles cycle_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MoldingMachinesCycles" ALTER COLUMN cycle_id SET DEFAULT nextval('public."MoldingMachinesCycles_cycle_id_seq"'::regclass);


--
-- Name: MoldingMachinesStates state_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MoldingMachinesStates" ALTER COLUMN state_id SET DEFAULT nextval('public."MoldingMachinesStates_state_id_seq"'::regclass);


--
-- Name: Molds mold_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Molds" ALTER COLUMN mold_id SET DEFAULT nextval('public."Molds_mold_id_seq"'::regclass);


--
-- Name: PreExpMachines machine_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreExpMachines" ALTER COLUMN machine_id SET DEFAULT nextval('public."PreExpMachines_machine_id_seq"'::regclass);


--
-- Name: PreExpMachinesStates state_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreExpMachinesStates" ALTER COLUMN state_id SET DEFAULT nextval('public."PreExpMachinesStates_state_id_seq"'::regclass);


--
-- Data for Name: MoldingMachines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."MoldingMachines" (machine_id, machine_serial_number) FROM stdin;
\.


--
-- Data for Name: MoldingMachinesCycles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."MoldingMachinesCycles" (cycle_id, machine_serial_number, mold_recipe_name, cycle_number, cycle_time, is_maintenance, time_stamp) FROM stdin;
\.


--
-- Data for Name: MoldingMachinesStates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."MoldingMachinesStates" (state_id, machine_serial_number, is_running, is_stopped, is_automatic, is_manual, is_disconnected, last_recipe_name, life_cycles, mold_distance, current_cycle_time, last_cycle_time, working_time_auto, working_time_manual, working_time_total, working_time_hydraulic, alarm_00_description, time_stamp) FROM stdin;
\.


--
-- Data for Name: Molds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Molds" (mold_id, mold_recipe_name, tc_ideal, tc_max, nc_ideal, nc_max) FROM stdin;
\.


--
-- Data for Name: PreExpMachines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PreExpMachines" (machine_id, machine_serial_number) FROM stdin;
\.


--
-- Data for Name: PreExpMachinesStates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PreExpMachinesStates" (state_id, machine_serial_number, is_connected, is_disconnected, last_recipe_name, life_cycles, working_time_auto, working_time_manual, working_time_total, m01_working_time, m02_working_time, m03_working_time, m04_working_time, m05_working_time, m06_working_time, m07_working_time, m08_working_time, m09_working_time, m10_working_time, m11_working_time, m12_working_time, m13_working_time, m14_working_time, m15_working_time, time_stamp) FROM stdin;
\.


--
-- Name: MoldingMachinesCycles_cycle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."MoldingMachinesCycles_cycle_id_seq"', 1, false);


--
-- Name: MoldingMachinesStates_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."MoldingMachinesStates_state_id_seq"', 1, false);


--
-- Name: MoldingMachines_machine_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."MoldingMachines_machine_id_seq"', 1, false);


--
-- Name: Molds_mold_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Molds_mold_id_seq"', 1, false);


--
-- Name: PreExpMachinesStates_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PreExpMachinesStates_state_id_seq"', 1, false);


--
-- Name: PreExpMachines_machine_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PreExpMachines_machine_id_seq"', 1, false);


--
-- Name: MoldingMachinesCycles MoldingMachinesCycles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MoldingMachinesCycles"
    ADD CONSTRAINT "MoldingMachinesCycles_pkey" PRIMARY KEY (cycle_id);


--
-- Name: MoldingMachinesStates MoldingMachinesStates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MoldingMachinesStates"
    ADD CONSTRAINT "MoldingMachinesStates_pkey" PRIMARY KEY (state_id);


--
-- Name: MoldingMachines MoldingMachines_machine_serial_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MoldingMachines"
    ADD CONSTRAINT "MoldingMachines_machine_serial_number_key" UNIQUE (machine_serial_number);


--
-- Name: MoldingMachines MoldingMachines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MoldingMachines"
    ADD CONSTRAINT "MoldingMachines_pkey" PRIMARY KEY (machine_id);


--
-- Name: Molds Molds_mold_recipe_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Molds"
    ADD CONSTRAINT "Molds_mold_recipe_name_key" UNIQUE (mold_recipe_name);


--
-- Name: Molds Molds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Molds"
    ADD CONSTRAINT "Molds_pkey" PRIMARY KEY (mold_id);


--
-- Name: PreExpMachinesStates PreExpMachinesStates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreExpMachinesStates"
    ADD CONSTRAINT "PreExpMachinesStates_pkey" PRIMARY KEY (state_id);


--
-- Name: PreExpMachines PreExpMachines_machine_serial_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreExpMachines"
    ADD CONSTRAINT "PreExpMachines_machine_serial_number_key" UNIQUE (machine_serial_number);


--
-- Name: PreExpMachines PreExpMachines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreExpMachines"
    ADD CONSTRAINT "PreExpMachines_pkey" PRIMARY KEY (machine_id);


--
-- Name: MoldingMachinesCycles MoldingMachinesCycles_machine_serial_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MoldingMachinesCycles"
    ADD CONSTRAINT "MoldingMachinesCycles_machine_serial_number_fkey" FOREIGN KEY (machine_serial_number) REFERENCES public."MoldingMachines"(machine_serial_number);


--
-- Name: MoldingMachinesCycles MoldingMachinesCycles_mold_recipe_name_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MoldingMachinesCycles"
    ADD CONSTRAINT "MoldingMachinesCycles_mold_recipe_name_fkey" FOREIGN KEY (mold_recipe_name) REFERENCES public."Molds"(mold_recipe_name);


--
-- Name: MoldingMachinesStates MoldingMachinesStates_machine_serial_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MoldingMachinesStates"
    ADD CONSTRAINT "MoldingMachinesStates_machine_serial_number_fkey" FOREIGN KEY (machine_serial_number) REFERENCES public."MoldingMachines"(machine_serial_number);


--
-- Name: PreExpMachinesStates PreExpMachinesStates_machine_serial_number_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreExpMachinesStates"
    ADD CONSTRAINT "PreExpMachinesStates_machine_serial_number_fkey" FOREIGN KEY (machine_serial_number) REFERENCES public."PreExpMachines"(machine_serial_number);


--
-- PostgreSQL database dump complete
--

