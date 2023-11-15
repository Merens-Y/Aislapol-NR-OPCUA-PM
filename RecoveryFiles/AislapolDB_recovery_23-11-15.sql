--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

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

CREATE FUNCTION public.handle_insert_molding_status(in_machine_serial_number character varying, in_is_running boolean, in_is_stopped boolean, in_is_automatic boolean, in_is_manual boolean, in_is_disconnected boolean, in_last_recipe_name character varying, in_life_cycles integer, in_mold_distance double precision, in_current_cycle_time double precision, in_last_cycle_time double precision, in_working_time_auto integer, in_working_time_manual integer, in_working_time_total integer, in_working_time_hydraulic integer, in_alarm_00_description character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if the MoldingMachines table is empty
    IF NOT EXISTS (SELECT 1 FROM "MoldingMachines") THEN
        -- Insert the new machine
        INSERT INTO "MoldingMachines" (machine_serial_number)
        VALUES (in_machine_serial_number);
    ELSE
        -- Check if the machine_serial_number exists in the MoldingMachines table
        IF NOT EXISTS (
            SELECT 1 
            FROM "MoldingMachines" 
            WHERE machine_serial_number = in_machine_serial_number
        ) THEN
            -- Insert the new machine
            INSERT INTO "MoldingMachines" (machine_serial_number)
            VALUES (in_machine_serial_number);
        END IF;
    END IF;

    -- Now, insert the status data
    INSERT INTO "MoldingMachinesStates" (
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
        in_machine_serial_number, 
        in_is_running, 
        in_is_stopped, 
        in_is_automatic, 
        in_is_manual, 
        in_is_disconnected,
        in_last_recipe_name,
        in_life_cycles,
        in_mold_distance,
        in_current_cycle_time,
        in_last_cycle_time,
        in_working_time_auto,
        in_working_time_manual,
        in_working_time_total,
        in_working_time_hydraulic,
        in_alarm_00_description
    );

    RAISE NOTICE 'Status data inserted successfully.';
END;
$$;


ALTER FUNCTION public.handle_insert_molding_status(in_machine_serial_number character varying, in_is_running boolean, in_is_stopped boolean, in_is_automatic boolean, in_is_manual boolean, in_is_disconnected boolean, in_last_recipe_name character varying, in_life_cycles integer, in_mold_distance double precision, in_current_cycle_time double precision, in_last_cycle_time double precision, in_working_time_auto integer, in_working_time_manual integer, in_working_time_total integer, in_working_time_hydraulic integer, in_alarm_00_description character varying) OWNER TO postgres;

--
-- Name: handle_insert_pre_exp_status(character varying, boolean, boolean, character varying, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_insert_pre_exp_status(in_machine_serial_number character varying, in_is_connected boolean, in_is_disconnected boolean, in_last_recipe_name character varying, in_life_cycles integer, in_working_time_auto integer, in_working_time_manual integer, in_working_time_total integer, in_m01_working_time integer, in_m02_working_time integer, in_m03_working_time integer, in_m04_working_time integer, in_m05_working_time integer, in_m06_working_time integer, in_m07_working_time integer, in_m08_working_time integer, in_m09_working_time integer, in_m10_working_time integer, in_m11_working_time integer, in_m12_working_time integer, in_m13_working_time integer, in_m14_working_time integer, in_m15_working_time integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if the MoldingMachines table is empty
    IF NOT EXISTS (SELECT 1 FROM "PreExpMachines") THEN
        -- Insert the new machine
        INSERT INTO "PreExpMachines" (machine_serial_number)
        VALUES (in_machine_serial_number);
    ELSE
        -- Check if the machine_serial_number exists in the MoldingMachines table
        IF NOT EXISTS (
            SELECT 1 
            FROM "PreExpMachines" 
            WHERE machine_serial_number = in_machine_serial_number
        ) THEN
            -- Insert the new machine
            INSERT INTO "PreExpMachines" (machine_serial_number)
            VALUES (in_machine_serial_number);
        END IF;
    END IF;

    -- Now, insert the status data
    INSERT INTO "PreExpMachinesStates" (
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
        in_machine_serial_number, 
        in_is_connected, 
        in_is_disconnected,
        in_last_recipe_name,
        in_life_cycles,
        in_working_time_auto,
        in_working_time_manual,
        in_working_time_total,
        in_m01_working_time,
        in_m02_working_time,
        in_m03_working_time,
        in_m04_working_time,
        in_m05_working_time,
        in_m06_working_time,
        in_m07_working_time,
        in_m08_working_time,
        in_m09_working_time,
        in_m10_working_time,
        in_m11_working_time,
        in_m12_working_time,
        in_m13_working_time,
        in_m14_working_time,
        in_m15_working_time
    );

    RAISE NOTICE 'Status data inserted successfully.';
END;
$$;


ALTER FUNCTION public.handle_insert_pre_exp_status(in_machine_serial_number character varying, in_is_connected boolean, in_is_disconnected boolean, in_last_recipe_name character varying, in_life_cycles integer, in_working_time_auto integer, in_working_time_manual integer, in_working_time_total integer, in_m01_working_time integer, in_m02_working_time integer, in_m03_working_time integer, in_m04_working_time integer, in_m05_working_time integer, in_m06_working_time integer, in_m07_working_time integer, in_m08_working_time integer, in_m09_working_time integer, in_m10_working_time integer, in_m11_working_time integer, in_m12_working_time integer, in_m13_working_time integer, in_m14_working_time integer, in_m15_working_time integer) OWNER TO postgres;

--
-- Name: insert_molding_cycle(character varying, character varying, integer, double precision); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_molding_cycle(in_machine_serial_number character varying, in_mold_recipe_name character varying, in_cycle_number integer, in_cycle_time double precision) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if the "machine_serial_number" exists in the "Molds" table
    IF NOT EXISTS (
        SELECT 1
        FROM "MoldingMachines"
        WHERE machine_serial_number = in_machine_serial_number
    ) THEN
        RAISE NOTICE 'Machine does not exist. Aborting insertion.';
        RETURN;
    END IF;

    -- Check if the "mold_recipe_name" exists in the "Molds" table
    IF NOT EXISTS (
        SELECT 1
        FROM "Molds"
        WHERE mold_recipe_name = in_mold_recipe_name
    ) THEN
        INSERT INTO "Molds" (mold_recipe_name)
        VALUES (in_mold_recipe_name);
    END IF;

    -- Now, insert the cycle data
    INSERT INTO "MoldingMachinesCycles" (
        machine_serial_number, 
        mold_recipe_name, 
        cycle_number, 
        cycle_time
    )
    VALUES (
        in_machine_serial_number, 
        in_mold_recipe_name, 
        in_cycle_number, 
        in_cycle_time
    );

    RAISE NOTICE 'Cycle data inserted successfully.';
END;
$$;


ALTER FUNCTION public.insert_molding_cycle(in_machine_serial_number character varying, in_mold_recipe_name character varying, in_cycle_number integer, in_cycle_time double precision) OWNER TO postgres;

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
1	P01286
2	P01230
3	P01229
\.


--
-- Data for Name: MoldingMachinesCycles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."MoldingMachinesCycles" (cycle_id, machine_serial_number, mold_recipe_name, cycle_number, cycle_time, is_maintenance, time_stamp) FROM stdin;
1	P01230	35 lbs nov.xml	41930	84936	f	2023-11-15 12:59:36.475548
2	P01229	10 lbs octubre.xml	30035	89952	f	2023-11-15 13:00:43.8303
3	P01286	Mixto 25 (KGS).xml	87939	95856	f	2023-11-15 13:00:44.125042
4	P01230	35 lbs nov.xml	41931	84932	f	2023-11-15 13:01:01.396309
5	P01229	10 lbs octubre.xml	30036	90124	f	2023-11-15 13:02:13.945593
6	P01286	Mixto 25 (KGS).xml	87940	95836	f	2023-11-15 13:02:19.772636
7	P01230	35 lbs nov.xml	41932	84916	f	2023-11-15 13:02:26.799727
8	P01229	10 lbs octubre.xml	30037	90080	f	2023-11-15 13:03:44.080529
9	P01230	35 lbs nov.xml	41933	84840	f	2023-11-15 13:03:52.121083
10	P01286	Mixto 25 (KGS).xml	87941	95824	f	2023-11-15 13:03:59.848866
\.


--
-- Data for Name: MoldingMachinesStates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."MoldingMachinesStates" (state_id, machine_serial_number, is_running, is_stopped, is_automatic, is_manual, is_disconnected, last_recipe_name, life_cycles, mold_distance, current_cycle_time, last_cycle_time, working_time_auto, working_time_manual, working_time_total, working_time_hydraulic, alarm_00_description, time_stamp) FROM stdin;
1	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87902	128101.20914862883	57004	95556	9336148	597322	9937070	1242406		2023-11-15 12:02:38.403797
2	P01230	t	f	t	f	f	35 lbs nov.xml	41889	73911.98687396274	44572	82300	2945879	443078	3388837	137083		2023-11-15 12:02:40.180431
3	P01229	t	f	t	f	f	10 lbs octubre.xml	29998	42138.15866847086	47516	95184	3540349	117949	3658298	419460		2023-11-15 12:02:42.528809
4	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87902	128101.20914862883	62004	95556	9336148	597322	9937070	1242406		2023-11-15 12:02:43.411122
5	P01230	t	f	t	f	f	35 lbs nov.xml	41889	73911.98687396274	49572	82300	2945879	443078	3388837	137083		2023-11-15 12:02:45.26769
6	P01229	t	f	t	f	f	10 lbs octubre.xml	29998	42138.15866847086	52516	95184	3540349	117949	3658298	419460		2023-11-15 12:02:47.367899
7	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87902	128101.20914862883	67004	95556	9336148	597322	9937070	1242406		2023-11-15 12:02:48.608024
8	P01230	t	f	t	f	f	35 lbs nov.xml	41889	73911.98687396274	54572	82300	2945879	443078	3388837	137083		2023-11-15 12:02:49.947265
9	P01229	t	f	t	f	f	10 lbs octubre.xml	29998	42138.15866847086	57516	95184	3540349	117949	3658298	419460		2023-11-15 12:02:52.38335
10	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87902	128101.20914862883	72004	95556	9336148	597322	9937070	1242406		2023-11-15 12:02:53.4265
11	P01230	t	f	t	f	f	35 lbs nov.xml	41889	73911.98687396274	59572	82300	2945879	443078	3388837	137083		2023-11-15 12:02:54.956269
12	P01229	t	f	t	f	f	10 lbs octubre.xml	29998	42138.15866847086	62516	95184	3540349	117949	3658298	419460		2023-11-15 12:02:57.522874
13	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87902	128101.20914862883	77004	95556	9336148	597322	9937070	1242406		2023-11-15 12:02:58.432304
14	P01230	t	f	t	f	f	35 lbs nov.xml	41889	73911.98687396274	64572	82300	2945879	443078	3388837	137083		2023-11-15 12:03:00.427868
15	P01229	t	f	t	f	f	10 lbs octubre.xml	29998	42138.15866847086	67516	95184	3540349	117949	3658298	419460		2023-11-15 12:03:02.792142
16	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87902	128101.20914862883	82004	95556	9336148	597322	9937070	1242406		2023-11-15 12:03:03.447729
17	P01230	t	f	t	f	f	35 lbs nov.xml	41889	73911.98687396274	69572	82300	2945879	443078	3388837	137083		2023-11-15 12:03:05.245243
18	P01229	t	f	t	f	f	10 lbs octubre.xml	29998	42138.15866847086	72516	95184	3540349	117949	3658298	419460		2023-11-15 12:03:07.407961
19	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87902	128101.20914862883	87004	95556	9336148	597322	9937070	1242406		2023-11-15 12:03:08.445186
20	P01230	t	f	t	f	f	35 lbs nov.xml	41889	73912.11217396198	74572	82300	2945879	443078	3388837	137083		2023-11-15 12:03:10.139814
21	P01229	t	f	t	f	f	10 lbs octubre.xml	29998	42138.15866847086	77516	95184	3540349	117949	3658298	419460		2023-11-15 12:03:12.532956
22	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87902	128101.52244861095	92004	95556	9336148	597322	9937070	1242406		2023-11-15 12:03:13.457253
23	P01230	t	f	t	f	f	35 lbs nov.xml	41890	73912.72507398632	1148	78420	2945879	443078	3388837	137089		2023-11-15 12:03:15.018509
24	P01229	t	f	t	f	f	10 lbs octubre.xml	29998	42138.15866847086	82516	95184	3540349	117949	3658298	419460		2023-11-15 12:03:17.432231
25	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.09834866591	1404	95596	9336148	597322	9937070	1242412		2023-11-15 12:03:18.462409
26	P01230	t	f	t	f	f	35 lbs nov.xml	41890	73913.32157401115	6148	78420	2945879	443078	3388837	137094		2023-11-15 12:03:20.010047
27	P01229	t	f	t	f	f	10 lbs octubre.xml	29998	42138.15866847086	87516	95184	3540349	117949	3658298	419460		2023-11-15 12:03:22.441417
28	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.69744866621	6404	95596	9336148	597322	9937070	1242418		2023-11-15 12:03:23.472452
29	P01230	t	f	t	f	f	35 lbs nov.xml	41890	73913.32157401115	11148	78420	2945879	443078	3388837	137094		2023-11-15 12:03:25.328851
30	P01229	t	f	t	f	f	10 lbs octubre.xml	29998	42138.63256847717	92516	95184	3540349	117949	3658298	419460		2023-11-15 12:03:27.465258
31	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.69744866621	11404	95596	9336148	597322	9937070	1242418		2023-11-15 12:03:28.471574
32	P01230	t	f	t	f	f	35 lbs nov.xml	41890	73913.32527401383	16148	78420	2945879	443078	3388837	137094		2023-11-15 12:03:30.198964
33	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.25436855655	2556	94956	3540349	117949	3658298	419465		2023-11-15 12:03:32.479583
34	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.69854866852	16404	95596	9336148	597322	9937070	1242421		2023-11-15 12:03:33.468757
35	P01230	t	f	t	f	f	35 lbs nov.xml	41890	73913.32577401384	21148	78420	2945879	443078	3388837	137098		2023-11-15 12:03:35.019633
36	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.731968544496	7556	94956	3540349	117949	3658298	419470		2023-11-15 12:03:37.487494
37	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.69854866852	21404	95596	9336148	597322	9937070	1242421		2023-11-15 12:03:38.482399
38	P01230	t	f	t	f	f	35 lbs nov.xml	41890	73913.32577401384	26148	78420	2945879	443078	3388837	137098		2023-11-15 12:03:40.299384
39	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.731968544496	12556	94956	3540349	117949	3658298	419470		2023-11-15 12:03:42.635061
40	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.69854866852	26404	95596	9336148	597322	9937070	1242421		2023-11-15 12:03:43.504592
41	P01230	t	f	t	f	f	35 lbs nov.xml	41890	73913.32577401384	31148	78420	2945879	443078	3388837	137098		2023-11-15 12:03:45.205284
42	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.737368545524	17756	94956	3540349	117949	3658298	419470		2023-11-15 12:03:47.504883
43	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.69854866852	31404	95596	9336148	597322	9937070	1242421		2023-11-15 12:03:48.51416
44	P01230	t	f	t	f	f	35 lbs nov.xml	41890	73913.32577401384	36148	78420	2945879	443078	3388837	137098		2023-11-15 12:03:50.054872
45	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.737368545524	22756	94956	3540349	117949	3658298	419473		2023-11-15 12:03:52.539347
46	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.69854866852	36404	95596	9336148	597322	9937070	1242421		2023-11-15 12:03:53.518802
47	P01230	t	f	t	f	f	35 lbs nov.xml	41890	73913.32577401384	41148	78420	2945879	443078	3388837	137098		2023-11-15 12:03:55.058456
48	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.737368545524	27756	94956	3540349	117949	3658298	419473		2023-11-15 12:03:57.765025
49	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.69854866852	41404	95596	9336148	597322	9937070	1242421		2023-11-15 12:03:58.545533
50	P01230	t	f	t	f	f	35 lbs nov.xml	41890	73913.32577401384	46148	78420	2945879	443078	3388837	137098		2023-11-15 12:04:00.234434
51	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.737368545524	32756	94956	3540349	117949	3658298	419473		2023-11-15 12:04:02.578995
52	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.69854866852	46404	95596	9336148	597322	9937070	1242421		2023-11-15 12:04:03.541809
53	P01230	t	f	t	f	f	35 lbs nov.xml	41890	73913.32577401384	51148	78420	2945879	443078	3388837	137098		2023-11-15 12:04:05.276343
54	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.737368545524	37756	94956	3540349	117949	3658298	419473		2023-11-15 12:04:07.583057
55	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.69854866852	51404	95596	9336148	597322	9937070	1242421		2023-11-15 12:04:08.546369
56	P01230	t	f	t	f	f	35 lbs nov.xml	41890	73913.32577401384	56148	78420	2945879	443078	3388837	137098		2023-11-15 12:04:10.085184
57	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.737368545524	42756	94956	3540349	117949	3658298	419473		2023-11-15 12:04:12.741172
58	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.69854866852	56404	95596	9336148	597322	9937070	1242421		2023-11-15 12:04:13.554842
59	P01230	t	f	t	f	f	35 lbs nov.xml	41890	73913.32577401384	61148	78420	2945879	443078	3388837	137098		2023-11-15 12:04:15.086624
60	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.737368545524	47756	94956	3540349	117949	3658298	419473		2023-11-15 12:04:17.602108
61	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.69854866852	61604	95596	9336148	597322	9937070	1242421		2023-11-15 12:04:18.563062
62	P01230	t	f	t	f	f	35 lbs nov.xml	41890	73913.32577401384	66348	78420	2945879	443078	3388837	137098		2023-11-15 12:04:20.290918
63	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.737368545524	52756	94956	3540349	117949	3658298	419473		2023-11-15 12:04:22.609837
64	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.69854866852	66604	95596	9336148	597322	9937070	1242421		2023-11-15 12:04:23.570009
65	P01230	t	f	t	f	f	35 lbs nov.xml	41890	73913.32577401384	71348	78420	2945879	443078	3388837	137098		2023-11-15 12:04:25.279638
66	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.737368545524	57756	94956	3540349	117949	3658298	419473		2023-11-15 12:04:27.713304
67	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.69854866852	71604	95596	9336148	597322	9937070	1242421		2023-11-15 12:04:28.571607
68	P01230	t	f	t	f	f	35 lbs nov.xml	41890	73913.53757401786	76348	78420	2945879	443078	3388837	137098		2023-11-15 12:04:30.267041
69	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.737368545524	62756	94956	3540349	117949	3658298	419473		2023-11-15 12:04:32.622072
70	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.69854866852	76604	95596	9336148	597322	9937070	1242421		2023-11-15 12:04:33.579875
71	P01230	t	f	t	f	f	35 lbs nov.xml	41891	73914.13357406355	1644	79700	2945879	443078	3388837	137103		2023-11-15 12:04:35.114045
72	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.737368545524	67756	94956	3540349	117949	3658298	419473		2023-11-15 12:04:37.627031
73	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.69854866852	81604	95596	9336148	597322	9937070	1242421		2023-11-15 12:04:38.588143
74	P01230	t	f	t	f	f	35 lbs nov.xml	41891	73914.65957406453	6644	79700	2945879	443078	3388837	137108		2023-11-15 12:04:40.265702
75	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.737368545524	72756	94956	3540349	117949	3658298	419473		2023-11-15 12:04:42.63898
76	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.69854866852	86604	95596	9336148	597322	9937070	1242421		2023-11-15 12:04:43.597342
77	P01230	t	f	t	f	f	35 lbs nov.xml	41891	73914.65957406453	11644	79700	2945879	443078	3388837	137108		2023-11-15 12:04:45.281934
78	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.737368545524	77756	94956	3540349	117949	3658298	419473		2023-11-15 12:04:47.640055
79	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87903	128102.91344866245	91604	95596	9336148	597322	9937070	1242421		2023-11-15 12:04:48.604021
80	P01230	t	f	t	f	f	35 lbs nov.xml	41891	73914.66367406683	16644	79700	2945879	443078	3388837	137108		2023-11-15 12:04:50.342103
81	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.737368545524	82756	94956	3540349	117949	3658298	419473		2023-11-15 12:04:52.652197
82	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128103.49894869296	992	95608	9336148	597322	9937070	1242426		2023-11-15 12:04:53.620758
83	P01230	t	f	t	f	f	35 lbs nov.xml	41891	73914.66367406683	21644	79700	2945879	443078	3388837	137111		2023-11-15 12:04:55.143362
84	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42139.737368545524	87756	94956	3540349	117949	3658298	419473		2023-11-15 12:04:57.768061
85	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.18864871847	5992	95608	9336148	597322	9937070	1242431		2023-11-15 12:04:58.626038
86	P01230	t	f	t	f	f	35 lbs nov.xml	41891	73914.66367406683	26644	79700	2945879	443078	3388837	137111		2023-11-15 12:05:00.31491
87	P01229	t	f	t	f	f	10 lbs octubre.xml	29999	42140.199368532645	92756	94956	3540349	117949	3658298	419473		2023-11-15 12:05:02.670624
88	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.18864871847	10992	95608	9336148	597322	9937070	1242431		2023-11-15 12:05:03.640535
89	P01230	t	f	t	f	f	35 lbs nov.xml	41891	73914.66367406683	31644	79700	2945879	443078	3388837	137111		2023-11-15 12:05:05.168264
90	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42140.80606869745	2468	95284	3540349	117949	3658298	419479		2023-11-15 12:05:07.671347
91	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.18924872077	15992	95608	9336148	597322	9937070	1242434		2023-11-15 12:05:08.651719
92	P01230	t	f	t	f	f	35 lbs nov.xml	41891	73914.66367406683	36644	79700	2945879	443078	3388837	137111		2023-11-15 12:05:10.179984
93	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.30876866721	7468	95284	3540349	117949	3658298	419485		2023-11-15 12:05:12.775357
94	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.18924872077	20992	95608	9336148	597322	9937070	1242434		2023-11-15 12:05:13.651639
95	P01230	t	f	t	f	f	35 lbs nov.xml	41891	73914.66367406683	41644	79700	2945879	443078	3388837	137111		2023-11-15 12:05:15.194206
96	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.30876866721	12468	95284	3540349	117949	3658298	419485		2023-11-15 12:05:17.688756
97	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.18924872077	25992	95608	9336148	597322	9937070	1242434		2023-11-15 12:05:18.657953
98	P01230	t	f	t	f	f	35 lbs nov.xml	41891	73914.66367406683	46644	79700	2945879	443078	3388837	137111		2023-11-15 12:05:20.486943
99	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.31366866777	17468	95284	3540349	117949	3658298	419485		2023-11-15 12:05:22.693319
100	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.18924872077	30992	95608	9336148	597322	9937070	1242434		2023-11-15 12:05:23.660627
101	P01230	t	f	t	f	f	35 lbs nov.xml	41891	73914.66367406683	51644	79700	2945879	443078	3388837	137111		2023-11-15 12:05:25.363593
102	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.31366866777	22668	95284	3540349	117949	3658298	419488		2023-11-15 12:05:27.805655
103	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.18924872077	35992	95608	9336148	597322	9937070	1242434		2023-11-15 12:05:28.660785
104	P01230	t	f	t	f	f	35 lbs nov.xml	41891	73914.66367406683	56644	79700	2945879	443078	3388837	137111		2023-11-15 12:05:30.220099
105	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.31366866777	27668	95284	3540349	117949	3658298	419488		2023-11-15 12:05:32.708025
106	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.18924872077	40992	95608	9336148	597322	9937070	1242434		2023-11-15 12:05:33.675306
107	P01230	t	f	t	f	f	35 lbs nov.xml	41891	73914.66367406683	61644	79700	2945879	443078	3388837	137111		2023-11-15 12:05:35.230476
108	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.31366866777	32668	95284	3540349	117949	3658298	419488		2023-11-15 12:05:37.719691
109	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.18924872077	45992	95608	9336148	597322	9937070	1242434		2023-11-15 12:05:38.681592
110	P01230	t	f	t	f	f	35 lbs nov.xml	41891	73914.66367406683	66644	79700	2945879	443078	3388837	137111		2023-11-15 12:05:40.398936
111	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.31366866777	37668	95284	3540349	117949	3658298	419488		2023-11-15 12:05:42.875063
112	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.18924872077	50992	95608	9336148	597322	9937070	1242434		2023-11-15 12:05:43.696295
113	P01230	t	f	t	f	f	35 lbs nov.xml	41891	73914.66367406683	71644	79700	2945879	443078	3388837	137111		2023-11-15 12:05:45.242582
114	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.31366866777	42668	95284	3540349	117949	3658298	419488		2023-11-15 12:05:47.736407
115	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.18924872077	55992	95608	9336148	597322	9937070	1242434		2023-11-15 12:05:48.715961
116	P01230	t	f	t	f	f	35 lbs nov.xml	41891	73914.94857404933	76644	79700	2945879	443078	3388837	137111		2023-11-15 12:05:50.494658
117	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.31366866777	47668	95284	3540349	117949	3658298	419488		2023-11-15 12:05:52.733392
118	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.18924872077	60992	95608	9336148	597322	9937070	1242434		2023-11-15 12:05:53.71272
119	P01230	t	f	t	f	f	35 lbs nov.xml	41892	73915.55687406764	1880	79760	2945879	443078	3388837	137116		2023-11-15 12:05:55.262447
120	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.31366866777	52668	95284	3540349	117949	3658298	419488		2023-11-15 12:05:57.835716
121	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.18924872077	65992	95608	9336148	597322	9937070	1242434		2023-11-15 12:05:58.713862
122	P01230	t	f	t	f	f	35 lbs nov.xml	41892	73915.998174044	6880	79760	2945879	443078	3388837	137122		2023-11-15 12:06:00.272231
123	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.31366866777	57668	95284	3540349	117949	3658298	419488		2023-11-15 12:06:02.750679
124	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.18924872077	70992	95608	9336148	597322	9937070	1242434		2023-11-15 12:06:03.723027
125	P01230	t	f	t	f	f	35 lbs nov.xml	41892	73915.998174044	11880	79760	2945879	443078	3388837	137122		2023-11-15 12:06:05.290157
126	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.31366866777	62668	95284	3540349	117949	3658298	419488		2023-11-15 12:06:07.764843
127	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.18924872077	75992	95608	9336148	597322	9937070	1242434		2023-11-15 12:06:08.736466
128	P01230	t	f	t	f	f	35 lbs nov.xml	41892	73916.00277404822	17080	79760	2945879	443078	3388837	137122		2023-11-15 12:06:10.468845
129	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.31366866777	67668	95284	3540349	117949	3658298	419488		2023-11-15 12:06:12.880302
130	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.18924872077	80992	95608	9336148	597322	9937070	1242434		2023-11-15 12:06:13.735481
131	P01230	t	f	t	f	f	35 lbs nov.xml	41892	73916.00277404822	22080	79760	2945879	443078	3388837	137125		2023-11-15 12:06:15.313438
132	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.31366866777	72668	95284	3540349	117949	3658298	419488		2023-11-15 12:06:17.773704
133	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.18924872077	85992	95608	9336148	597322	9937070	1242434		2023-11-15 12:06:18.750308
134	P01230	t	f	t	f	f	35 lbs nov.xml	41892	73916.00277404822	27080	79760	2945879	443078	3388837	137125		2023-11-15 12:06:20.629707
135	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.31366866777	77668	95284	3540349	117949	3658298	419488		2023-11-15 12:06:22.789165
136	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87904	128104.31784872121	90992	95608	9336148	597322	9937070	1242434		2023-11-15 12:06:23.765867
137	P01230	t	f	t	f	f	35 lbs nov.xml	41892	73916.00277404822	32080	79760	2945879	443078	3388837	137125		2023-11-15 12:06:25.477664
138	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.31366866777	82668	95284	3540349	117949	3658298	419488		2023-11-15 12:06:27.792394
139	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128104.94554873339	592	95596	9336148	597322	9937070	1242440		2023-11-15 12:06:28.767921
140	P01230	t	f	t	f	f	35 lbs nov.xml	41892	73916.00277404822	37080	79760	2945879	443078	3388837	137125		2023-11-15 12:06:30.338106
141	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.31366866777	87668	95284	3540349	117949	3658298	419488		2023-11-15 12:06:32.806555
142	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.67534873454	5592	95596	9336148	597322	9937070	1242440		2023-11-15 12:06:33.773845
143	P01230	t	f	t	f	f	35 lbs nov.xml	41892	73916.00277404822	42080	79760	2945879	443078	3388837	137125		2023-11-15 12:06:35.354656
144	P01229	t	f	t	f	f	10 lbs octubre.xml	30000	42141.77496868037	92668	95284	3540349	117949	3658298	419488		2023-11-15 12:06:37.810205
145	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.67684873454	10592	95596	9336148	597322	9937070	1242446		2023-11-15 12:06:38.77103
146	P01230	t	f	t	f	f	35 lbs nov.xml	41892	73916.00277404822	47080	79760	2945879	443078	3388837	137125		2023-11-15 12:06:40.512946
147	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.38126879024	2528	95136	3540349	117949	3658298	419494		2023-11-15 12:06:42.972424
148	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.6776487376	15592	95596	9336148	597322	9937070	1242446		2023-11-15 12:06:43.781577
149	P01230	t	f	t	f	f	35 lbs nov.xml	41892	73916.00277404822	52080	79760	2945879	443078	3388837	137125		2023-11-15 12:06:45.382139
150	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.88366877839	7528	95136	3540349	117949	3658298	419500		2023-11-15 12:06:47.834836
151	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.6776487376	20592	95596	9336148	597322	9937070	1242449		2023-11-15 12:06:48.794852
152	P01230	t	f	t	f	f	35 lbs nov.xml	41892	73916.00277404822	57080	79760	2945879	443078	3388837	137125		2023-11-15 12:06:50.601869
153	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.88366877839	12528	95136	3540349	117949	3658298	419500		2023-11-15 12:06:52.840038
154	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.6776487376	25592	95596	9336148	597322	9937070	1242449		2023-11-15 12:06:53.805734
155	P01230	t	f	t	f	f	35 lbs nov.xml	41892	73916.00277404822	62080	79760	2945879	443078	3388837	137125		2023-11-15 12:06:55.401628
156	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.88906877895	17528	95136	3540349	117949	3658298	419500		2023-11-15 12:06:57.939519
157	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.6776487376	30592	95596	9336148	597322	9937070	1242449		2023-11-15 12:06:58.81185
158	P01230	t	f	t	f	f	35 lbs nov.xml	41892	73916.00277404822	67080	79760	2945879	443078	3388837	137125		2023-11-15 12:07:00.414627
159	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.88906877895	22528	95136	3540349	117949	3658298	419504		2023-11-15 12:07:02.848748
160	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.6776487376	35592	95596	9336148	597322	9937070	1242449		2023-11-15 12:07:03.821215
161	P01230	t	f	t	f	f	35 lbs nov.xml	41892	73916.00277404822	72080	79760	2945879	443078	3388837	137125		2023-11-15 12:07:05.740932
162	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.88906877895	27528	95136	3540349	117949	3658298	419504		2023-11-15 12:07:07.84887
163	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.6776487376	40592	95596	9336148	597322	9937070	1242449		2023-11-15 12:07:08.827022
164	P01230	t	f	t	f	f	35 lbs nov.xml	41892	73916.37407406079	77080	79760	2945879	443078	3388837	137125		2023-11-15 12:07:10.689663
165	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.88906877895	32528	95136	3540349	117949	3658298	419504		2023-11-15 12:07:12.945385
166	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.6776487376	45592	95596	9336148	597322	9937070	1242449		2023-11-15 12:07:13.834473
167	P01230	t	f	t	f	f	35 lbs nov.xml	41893	73916.97017400581	2300	79776	2945879	443078	3388837	137130		2023-11-15 12:07:15.437294
168	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.88906877895	37528	95136	3540349	117949	3658298	419504		2023-11-15 12:07:17.854213
169	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.6776487376	50592	95596	9336148	597322	9937070	1242449		2023-11-15 12:07:18.841691
170	P01230	t	f	t	f	f	35 lbs nov.xml	41893	73917.33677402338	7300	79776	2945879	443078	3388837	137135		2023-11-15 12:07:20.668158
171	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.88906877895	42528	95136	3540349	117949	3658298	419504		2023-11-15 12:07:22.858916
172	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.6776487376	55592	95596	9336148	597322	9937070	1242449		2023-11-15 12:07:23.847699
173	P01230	t	f	t	f	f	35 lbs nov.xml	41893	73917.33677402338	12300	79776	2945879	443078	3388837	137135		2023-11-15 12:07:25.604956
174	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.88906877895	47528	95136	3540349	117949	3658298	419504		2023-11-15 12:07:27.863736
175	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.6776487376	60592	95596	9336148	597322	9937070	1242449		2023-11-15 12:07:28.851385
176	P01230	t	f	t	f	f	35 lbs nov.xml	41893	73917.34107402644	17300	79776	2945879	443078	3388837	137135		2023-11-15 12:07:30.453146
177	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.88906877895	52528	95136	3540349	117949	3658298	419504		2023-11-15 12:07:32.868047
178	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.6776487376	65592	95596	9336148	597322	9937070	1242449		2023-11-15 12:07:33.852979
179	P01230	t	f	t	f	f	35 lbs nov.xml	41893	73917.34107402644	22300	79776	2945879	443078	3388837	137138		2023-11-15 12:07:35.46001
180	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.88906877895	57528	95136	3540349	117949	3658298	419504		2023-11-15 12:07:37.882942
181	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.6776487376	70592	95596	9336148	597322	9937070	1242449		2023-11-15 12:07:38.870321
182	P01230	t	f	t	f	f	35 lbs nov.xml	41893	73917.34107402644	27300	79776	2945879	443078	3388837	137138		2023-11-15 12:07:40.606116
183	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.88906877895	62528	95136	3540349	117949	3658298	419504		2023-11-15 12:07:42.986134
184	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.6776487376	75592	95596	9336148	597322	9937070	1242449		2023-11-15 12:07:43.873443
185	P01230	t	f	t	f	f	35 lbs nov.xml	41893	73917.34107402644	32300	79776	2945879	443078	3388837	137138		2023-11-15 12:07:45.468929
186	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.88906877895	67728	95136	3540349	117949	3658298	419504		2023-11-15 12:07:47.906784
187	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.6776487376	80592	95596	9336148	597322	9937070	1242449		2023-11-15 12:07:48.872729
188	P01230	t	f	t	f	f	35 lbs nov.xml	41893	73917.34107402644	37300	79776	2945879	443078	3388837	137138		2023-11-15 12:07:50.473788
189	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.88906877895	72728	95136	3540349	117949	3658298	419504		2023-11-15 12:07:52.915822
190	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.6776487376	85592	95596	9336148	597322	9937070	1242449		2023-11-15 12:07:53.872999
191	P01230	t	f	t	f	f	35 lbs nov.xml	41893	73917.34107402644	42300	79776	2945879	443078	3388837	137138		2023-11-15 12:07:55.484085
192	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.88906877895	77728	95136	3540349	117949	3658298	419504		2023-11-15 12:07:58.022747
193	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87905	128105.71314873763	90592	95596	9336148	597322	9937070	1242449		2023-11-15 12:07:58.870177
194	P01230	t	f	t	f	f	35 lbs nov.xml	41893	73917.34107402644	47300	79776	2945879	443078	3388837	137138		2023-11-15 12:08:00.488343
195	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.88906877895	82728	95136	3540349	117949	3658298	419504		2023-11-15 12:08:02.927575
196	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128106.42254875063	95592	95596	9336148	597322	9937070	1242454		2023-11-15 12:08:03.884607
197	P01230	t	f	t	f	f	35 lbs nov.xml	41893	73917.34107402644	52300	79776	2945879	443078	3388837	137138		2023-11-15 12:08:05.639042
198	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42142.88906877895	87728	95136	3540349	117949	3658298	419504		2023-11-15 12:08:07.941064
199	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.1410487277	4936	95652	9336148	597322	9937070	1242454		2023-11-15 12:08:08.893354
200	P01230	t	f	t	f	f	35 lbs nov.xml	41893	73917.34107402644	57500	79776	2945879	443078	3388837	137138		2023-11-15 12:08:10.663765
201	P01229	t	f	t	f	f	10 lbs octubre.xml	30001	42143.314368767235	92728	95136	3540349	117949	3658298	419504		2023-11-15 12:08:13.151425
202	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.16844872732	9936	95652	9336148	597322	9937070	1242460		2023-11-15 12:08:13.895144
203	P01230	t	f	t	f	f	35 lbs nov.xml	41893	73917.34107402644	62500	79776	2945879	443078	3388837	137138		2023-11-15 12:08:15.517255
204	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42143.9332689137	2424	95300	3540349	117949	3658298	419510		2023-11-15 12:08:17.963289
205	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.16934873076	14936	95652	9336148	597322	9937070	1242460		2023-11-15 12:08:18.908058
206	P01230	t	f	t	f	f	35 lbs nov.xml	41893	73917.34107402644	67500	79776	2945879	443078	3388837	137138		2023-11-15 12:08:20.675556
207	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.45986892598	7424	95300	3540349	117949	3658298	419516		2023-11-15 12:08:22.966962
208	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.16934873076	19936	95652	9336148	597322	9937070	1242463		2023-11-15 12:08:23.911295
209	P01230	t	f	t	f	f	35 lbs nov.xml	41893	73917.34107402644	72500	79776	2945879	443078	3388837	137138		2023-11-15 12:08:25.679507
210	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.45986892598	12424	95300	3540349	117949	3658298	419516		2023-11-15 12:08:27.978111
211	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.16934873076	24936	95652	9336148	597322	9937070	1242463		2023-11-15 12:08:28.92043
212	P01230	t	f	t	f	f	35 lbs nov.xml	41893	73917.34107402644	77500	79776	2945879	443078	3388837	137138		2023-11-15 12:08:30.541933
213	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.465168926654	17424	95300	3540349	117949	3658298	419516		2023-11-15 12:08:32.98043
214	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.16934873076	29936	95652	9336148	597322	9937070	1242463		2023-11-15 12:08:33.925019
215	P01230	t	f	t	f	f	35 lbs nov.xml	41893	73917.77357402837	82500	79776	2945879	443078	3388837	137138		2023-11-15 12:08:35.559387
216	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.465168926654	22424	95300	3540349	117949	3658298	419520		2023-11-15 12:08:37.982543
217	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.16934873076	34936	95652	9336148	597322	9937070	1242463		2023-11-15 12:08:38.922764
218	P01230	t	f	t	f	f	35 lbs nov.xml	41894	73918.37077404054	2656	84840	2945879	443078	3388837	137143		2023-11-15 12:08:40.780518
219	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.465168926654	27424	95300	3540349	117949	3658298	419520		2023-11-15 12:08:43.081657
220	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.16934873076	39936	95652	9336148	597322	9937070	1242463		2023-11-15 12:08:43.932521
221	P01230	t	f	t	f	f	35 lbs nov.xml	41894	73918.67737404096	7656	84840	2945879	443078	3388837	137148		2023-11-15 12:08:45.576435
222	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.465168926654	32424	95300	3540349	117949	3658298	419520		2023-11-15 12:08:47.995784
223	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.16934873076	44936	95652	9336148	597322	9937070	1242463		2023-11-15 12:08:48.938334
224	P01230	t	f	t	f	f	35 lbs nov.xml	41894	73918.67737404096	12656	84840	2945879	443078	3388837	137148		2023-11-15 12:08:50.579262
225	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.465168926654	37424	95300	3540349	117949	3658298	419520		2023-11-15 12:08:53.009526
226	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.16934873076	49936	95652	9336148	597322	9937070	1242463		2023-11-15 12:08:53.94457
227	P01230	t	f	t	f	f	35 lbs nov.xml	41894	73918.68167404212	17656	84840	2945879	443078	3388837	137148		2023-11-15 12:08:55.589922
228	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.465168926654	42424	95300	3540349	117949	3658298	419520		2023-11-15 12:08:58.10466
229	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.16934873076	54936	95652	9336148	597322	9937070	1242463		2023-11-15 12:08:58.947351
230	P01230	t	f	t	f	f	35 lbs nov.xml	41894	73918.68167404212	22656	84840	2945879	443078	3388837	137151		2023-11-15 12:09:00.594407
231	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.465168926654	47424	95300	3540349	117949	3658298	419520		2023-11-15 12:09:03.028252
232	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.16934873076	59936	95652	9336148	597322	9937070	1242463		2023-11-15 12:09:03.956086
233	P01230	t	f	t	f	f	35 lbs nov.xml	41894	73918.68167404212	27656	84840	2945879	443078	3388837	137151		2023-11-15 12:09:05.743394
234	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.465168926654	52424	95300	3540349	117949	3658298	419520		2023-11-15 12:09:08.039589
235	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.16934873076	65136	95652	9336148	597322	9937070	1242463		2023-11-15 12:09:08.971558
236	P01230	t	f	t	f	f	35 lbs nov.xml	41894	73918.68167404212	32656	84840	2945879	443078	3388837	137151		2023-11-15 12:09:10.777926
237	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.465168926654	57424	95300	3540349	117949	3658298	419520		2023-11-15 12:09:13.041045
238	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.16934873076	70136	95652	9336148	597322	9937070	1242463		2023-11-15 12:09:13.969712
239	P01230	t	f	t	f	f	35 lbs nov.xml	41894	73918.68167404212	37656	84840	2945879	443078	3388837	137151		2023-11-15 12:09:15.617967
240	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.465168926654	62424	95300	3540349	117949	3658298	419520		2023-11-15 12:09:18.044275
241	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.16934873076	75136	95652	9336148	597322	9937070	1242463		2023-11-15 12:09:18.980053
242	P01230	t	f	t	f	f	35 lbs nov.xml	41894	73918.68167404212	42656	84840	2945879	443078	3388837	137151		2023-11-15 12:09:20.774576
243	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.465168926654	67424	95300	3540349	117949	3658298	419520		2023-11-15 12:09:23.048918
244	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.16934873076	80136	95652	9336148	597322	9937070	1242463		2023-11-15 12:09:23.981203
245	P01230	t	f	t	f	f	35 lbs nov.xml	41894	73918.68167404212	47656	84840	2945879	443078	3388837	137151		2023-11-15 12:09:25.788977
246	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.465168926654	72424	95300	3540349	117949	3658298	419520		2023-11-15 12:09:28.04742
247	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.16934873076	85136	95652	9336148	597322	9937070	1242463		2023-11-15 12:09:28.993026
248	P01230	t	f	t	f	f	35 lbs nov.xml	41894	73918.68167404212	52656	84840	2945879	443078	3388837	137151		2023-11-15 12:09:30.640132
249	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.465168926654	77424	95300	3540349	117949	3658298	419520		2023-11-15 12:09:33.05487
250	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.17044873307	90136	95652	9336148	597322	9937070	1242463		2023-11-15 12:09:34.003738
251	P01230	t	f	t	f	f	35 lbs nov.xml	41894	73918.68167404212	57656	84840	2945879	443078	3388837	137151		2023-11-15 12:09:35.640049
252	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.465168926654	82424	95300	3540349	117949	3658298	419520		2023-11-15 12:09:38.064953
253	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87906	128107.9083486965	95136	95652	9336148	597322	9937070	1242463		2023-11-15 12:09:39.015129
254	P01230	t	f	t	f	f	35 lbs nov.xml	41894	73918.68167404212	62656	84840	2945879	443078	3388837	137151		2023-11-15 12:09:40.640472
255	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.465168926654	87424	95300	3540349	117949	3658298	419520		2023-11-15 12:09:43.158352
256	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.61134870793	4540	95592	9336148	597322	9937070	1242468		2023-11-15 12:09:44.023438
257	P01230	t	f	t	f	f	35 lbs nov.xml	41894	73918.68167404212	67656	84840	2945879	443078	3388837	137151		2023-11-15 12:09:45.645401
258	P01229	t	f	t	f	f	10 lbs octubre.xml	30002	42144.91536892741	92424	95300	3540349	117949	3658298	419520		2023-11-15 12:09:48.080913
259	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.65744871022	9540	95592	9336148	597322	9937070	1242474		2023-11-15 12:09:49.036549
260	P01230	t	f	t	f	f	35 lbs nov.xml	41894	73918.68167404212	72656	84840	2945879	443078	3388837	137151		2023-11-15 12:09:50.810171
261	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42145.52226895184	2400	95020	3540349	117949	3658298	419526		2023-11-15 12:09:53.093274
262	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.65824871138	14540	95592	9336148	597322	9937070	1242474		2023-11-15 12:09:54.037013
263	P01230	t	f	t	f	f	35 lbs nov.xml	41894	73918.68167404212	77656	84840	2945879	443078	3388837	137151		2023-11-15 12:09:55.675837
264	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.0382689766	7600	95020	3540349	117949	3658298	419532		2023-11-15 12:09:58.18989
265	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.65824871138	19540	95592	9336148	597322	9937070	1242476		2023-11-15 12:09:59.045138
266	P01230	t	f	t	f	f	35 lbs nov.xml	41894	73919.16197404801	82656	84840	2945879	443078	3388837	137151		2023-11-15 12:10:00.68199
267	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.0382689766	12600	95020	3540349	117949	3658298	419532		2023-11-15 12:10:03.101222
268	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.65824871138	24540	95592	9336148	597322	9937070	1242476		2023-11-15 12:10:04.053893
269	P01230	t	f	t	f	f	35 lbs nov.xml	41895	73919.75957408462	2796	84856	2945879	443078	3388837	137157		2023-11-15 12:10:05.917084
270	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.04296897832	17600	95020	3540349	117949	3658298	419532		2023-11-15 12:10:08.114598
271	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.65824871138	29540	95592	9336148	597322	9937070	1242476		2023-11-15 12:10:09.060527
272	P01230	t	f	t	f	f	35 lbs nov.xml	41895	73920.01697410241	7796	84856	2945879	443078	3388837	137162		2023-11-15 12:10:10.846186
273	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.04296897832	22600	95020	3540349	117949	3658298	419535		2023-11-15 12:10:13.122902
274	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.65824871138	34540	95592	9336148	597322	9937070	1242476		2023-11-15 12:10:14.064928
275	P01230	t	f	t	f	f	35 lbs nov.xml	41895	73920.01697410241	12796	84856	2945879	443078	3388837	137162		2023-11-15 12:10:15.700364
276	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.04296897832	27600	95020	3540349	117949	3658298	419535		2023-11-15 12:10:18.248176
277	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.65824871138	39540	95592	9336148	597322	9937070	1242476		2023-11-15 12:10:19.069763
278	P01230	t	f	t	f	f	35 lbs nov.xml	41895	73920.0217741036	17996	84856	2945879	443078	3388837	137162		2023-11-15 12:10:20.876067
279	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.04296897832	32600	95020	3540349	117949	3658298	419535		2023-11-15 12:10:23.1622
280	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.65824871138	44540	95592	9336148	597322	9937070	1242476		2023-11-15 12:10:24.073265
281	P01230	t	f	t	f	f	35 lbs nov.xml	41895	73920.0217741036	22996	84856	2945879	443078	3388837	137166		2023-11-15 12:10:25.875773
282	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.04296897832	37600	95020	3540349	117949	3658298	419535		2023-11-15 12:10:28.168804
283	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.65824871138	49540	95592	9336148	597322	9937070	1242476		2023-11-15 12:10:29.072797
284	P01230	t	f	t	f	f	35 lbs nov.xml	41895	73920.0217741036	27996	84856	2945879	443078	3388837	137166		2023-11-15 12:10:30.728176
285	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.04296897832	42600	95020	3540349	117949	3658298	419535		2023-11-15 12:10:33.279086
286	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.65824871138	54540	95592	9336148	597322	9937070	1242476		2023-11-15 12:10:34.08104
287	P01230	t	f	t	f	f	35 lbs nov.xml	41895	73920.0217741036	32996	84856	2945879	443078	3388837	137166		2023-11-15 12:10:35.733087
288	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.04296897832	47600	95020	3540349	117949	3658298	419535		2023-11-15 12:10:38.182826
289	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.65824871138	59540	95592	9336148	597322	9937070	1242476		2023-11-15 12:10:39.184527
290	P01230	t	f	t	f	f	35 lbs nov.xml	41895	73920.0217741036	37996	84856	2945879	443078	3388837	137166		2023-11-15 12:10:40.742111
291	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.04296897832	52600	95020	3540349	117949	3658298	419535		2023-11-15 12:10:43.187147
292	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.65824871138	64540	95592	9336148	597322	9937070	1242476		2023-11-15 12:10:44.092913
293	P01230	t	f	t	f	f	35 lbs nov.xml	41895	73920.0217741036	42996	84856	2945879	443078	3388837	137166		2023-11-15 12:10:45.745444
294	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.04296897832	57600	95020	3540349	117949	3658298	419535		2023-11-15 12:10:48.198747
295	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.65824871138	69540	95592	9336148	597322	9937070	1242476		2023-11-15 12:10:49.097978
296	P01230	t	f	t	f	f	35 lbs nov.xml	41895	73920.0217741036	47996	84856	2945879	443078	3388837	137166		2023-11-15 12:10:50.905874
297	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.04296897832	62600	95020	3540349	117949	3658298	419535		2023-11-15 12:10:53.202664
298	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.65824871138	74540	95592	9336148	597322	9937070	1242476		2023-11-15 12:10:54.097589
299	P01230	t	f	t	f	f	35 lbs nov.xml	41895	73920.0217741036	52996	84856	2945879	443078	3388837	137166		2023-11-15 12:10:55.755523
300	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.04296897832	67600	95020	3540349	117949	3658298	419535		2023-11-15 12:10:58.319923
301	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.65824871138	79540	95592	9336148	597322	9937070	1242476		2023-11-15 12:10:59.105607
302	P01230	t	f	t	f	f	35 lbs nov.xml	41895	73920.0217741036	57996	84856	2945879	443078	3388837	137166		2023-11-15 12:11:00.759621
303	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.04296897832	72600	95020	3540349	117949	3658298	419535		2023-11-15 12:11:03.215991
304	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.65824871138	84540	95592	9336148	597322	9937070	1242476		2023-11-15 12:11:04.106378
305	P01230	t	f	t	f	f	35 lbs nov.xml	41895	73920.0217741036	62996	84856	2945879	443078	3388837	137166		2023-11-15 12:11:05.919805
306	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.04296897832	77600	95020	3540349	117949	3658298	419535		2023-11-15 12:11:08.216571
307	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128108.65824871138	89540	95592	9336148	597322	9937070	1242476		2023-11-15 12:11:09.114195
308	P01230	t	f	t	f	f	35 lbs nov.xml	41895	73920.0217741036	67996	84856	2945879	443078	3388837	137166		2023-11-15 12:11:10.890381
309	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.04296897832	82600	95020	3540349	117949	3658298	419535		2023-11-15 12:11:13.313168
310	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87907	128109.3753487252	94540	95592	9336148	597322	9937070	1242476		2023-11-15 12:11:14.124753
311	P01230	t	f	t	f	f	35 lbs nov.xml	41895	73920.0217741036	72996	84856	2945879	443078	3388837	137166		2023-11-15 12:11:15.788252
312	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.04296897832	87600	95020	3540349	117949	3658298	419535		2023-11-15 12:11:18.389766
313	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.05144876183	3940	95596	9336148	597322	9937070	1242482		2023-11-15 12:11:19.133667
314	P01230	t	f	t	f	f	35 lbs nov.xml	41895	73920.0217741036	77996	84856	2945879	443078	3388837	137166		2023-11-15 12:11:20.944033
315	P01229	t	f	t	f	f	10 lbs octubre.xml	30003	42146.541768978044	92600	95020	3540349	117949	3658298	419535		2023-11-15 12:11:23.228505
316	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.14704876221	8940	95596	9336148	597322	9937070	1242488		2023-11-15 12:11:24.143017
317	P01230	t	f	t	f	f	35 lbs nov.xml	41895	73920.5631740689	82996	84856	2945879	443078	3388837	137166		2023-11-15 12:11:25.973331
318	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.16166906347	2720	94876	3540349	117949	3658298	419541		2023-11-15 12:11:28.237399
319	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.14764876451	13940	95596	9336148	597322	9937070	1242488		2023-11-15 12:11:29.151397
320	P01230	t	f	t	f	f	35 lbs nov.xml	41896	73921.17257406267	3168	84824	2945879	443078	3388837	137171		2023-11-15 12:11:30.817797
321	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.61356905114	7720	94876	3540349	117949	3658298	419547		2023-11-15 12:11:33.388805
322	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.14784876528	18940	95596	9336148	597322	9937070	1242491		2023-11-15 12:11:34.152943
323	P01230	t	f	t	f	f	35 lbs nov.xml	41896	73921.35507406843	8168	84824	2945879	443078	3388837	137176		2023-11-15 12:11:35.826017
324	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.61356905114	12720	94876	3540349	117949	3658298	419547		2023-11-15 12:11:38.247837
325	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.14784876528	23940	95596	9336148	597322	9937070	1242491		2023-11-15 12:11:39.165483
326	P01230	t	f	t	f	f	35 lbs nov.xml	41896	73921.35507406843	13168	84824	2945879	443078	3388837	137176		2023-11-15 12:11:40.977577
327	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.61906905209	17720	94876	3540349	117949	3658298	419547		2023-11-15 12:11:43.262018
328	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.14784876528	29140	95596	9336148	597322	9937070	1242491		2023-11-15 12:11:44.171293
329	P01230	t	f	t	f	f	35 lbs nov.xml	41896	73921.35907407034	18168	84824	2945879	443078	3388837	137179		2023-11-15 12:11:45.841848
330	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.61906905209	22720	94876	3540349	117949	3658298	419550		2023-11-15 12:11:48.266983
331	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.14784876528	34140	95596	9336148	597322	9937070	1242491		2023-11-15 12:11:49.182208
332	P01230	t	f	t	f	f	35 lbs nov.xml	41896	73921.35907407034	23168	84824	2945879	443078	3388837	137179		2023-11-15 12:11:51.006919
333	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.61906905209	27720	94876	3540349	117949	3658298	419550		2023-11-15 12:11:53.280411
334	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.14784876528	39140	95596	9336148	597322	9937070	1242491		2023-11-15 12:11:54.190832
335	P01230	t	f	t	f	f	35 lbs nov.xml	41896	73921.35907407034	28168	84824	2945879	443078	3388837	137179		2023-11-15 12:11:55.859872
336	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.61906905209	32720	94876	3540349	117949	3658298	419550		2023-11-15 12:11:58.294098
337	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.14784876528	44140	95596	9336148	597322	9937070	1242491		2023-11-15 12:11:59.189974
338	P01230	t	f	t	f	f	35 lbs nov.xml	41896	73921.35907407034	33168	84824	2945879	443078	3388837	137179		2023-11-15 12:12:00.870921
339	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.61906905209	37920	94876	3540349	117949	3658298	419550		2023-11-15 12:12:03.304076
340	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.14784876528	49140	95596	9336148	597322	9937070	1242491		2023-11-15 12:12:04.195163
341	P01230	t	f	t	f	f	35 lbs nov.xml	41896	73921.35907407034	38168	84824	2945879	443078	3388837	137179		2023-11-15 12:12:06.028924
342	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.61906905209	42920	94876	3540349	117949	3658298	419550		2023-11-15 12:12:08.302916
343	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.14784876528	54140	95596	9336148	597322	9937070	1242491		2023-11-15 12:12:09.198349
344	P01230	t	f	t	f	f	35 lbs nov.xml	41896	73921.35907407034	43168	84824	2945879	443078	3388837	137179		2023-11-15 12:12:11.037131
345	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.61906905209	47920	94876	3540349	117949	3658298	419550		2023-11-15 12:12:13.308895
346	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.14784876528	59140	95596	9336148	597322	9937070	1242491		2023-11-15 12:12:14.207118
347	P01230	t	f	t	f	f	35 lbs nov.xml	41896	73921.35907407034	48168	84824	2945879	443078	3388837	137179		2023-11-15 12:12:15.895883
348	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.61906905209	52920	94876	3540349	117949	3658298	419550		2023-11-15 12:12:18.416864
349	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.14784876528	64140	95596	9336148	597322	9937070	1242491		2023-11-15 12:12:19.228093
350	P01230	t	f	t	f	f	35 lbs nov.xml	41896	73921.35907407034	53168	84824	2945879	443078	3388837	137179		2023-11-15 12:12:21.051152
351	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.61906905209	57920	94876	3540349	117949	3658298	419550		2023-11-15 12:12:23.422333
352	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.14784876528	69140	95596	9336148	597322	9937070	1242491		2023-11-15 12:12:24.225045
353	P01230	t	f	t	f	f	35 lbs nov.xml	41896	73921.35907407034	58368	84824	2945879	443078	3388837	137179		2023-11-15 12:12:25.906042
354	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.61906905209	62920	94876	3540349	117949	3658298	419550		2023-11-15 12:12:28.333251
355	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.14784876528	74140	95596	9336148	597322	9937070	1242491		2023-11-15 12:12:29.229897
356	P01230	t	f	t	f	f	35 lbs nov.xml	41896	73921.35907407034	63368	84824	2945879	443078	3388837	137179		2023-11-15 12:12:30.914739
357	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.61906905209	67920	94876	3540349	117949	3658298	419550		2023-11-15 12:12:33.436669
358	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.14784876528	79140	95596	9336148	597322	9937070	1242491		2023-11-15 12:12:34.230375
359	P01230	t	f	t	f	f	35 lbs nov.xml	41896	73921.35907407034	68368	84824	2945879	443078	3388837	137179		2023-11-15 12:12:35.915587
360	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.61906905209	72920	94876	3540349	117949	3658298	419550		2023-11-15 12:12:38.433097
361	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.14784876528	84140	95596	9336148	597322	9937070	1242491		2023-11-15 12:12:39.242248
362	P01230	t	f	t	f	f	35 lbs nov.xml	41896	73921.35907407034	73368	84824	2945879	443078	3388837	137179		2023-11-15 12:12:41.072295
363	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.61906905209	77920	94876	3540349	117949	3658298	419550		2023-11-15 12:12:43.346705
364	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.14784876528	89140	95596	9336148	597322	9937070	1242491		2023-11-15 12:12:44.254596
365	P01230	t	f	t	f	f	35 lbs nov.xml	41896	73921.35907407034	78368	84824	2945879	443078	3388837	137179		2023-11-15 12:12:45.921207
366	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.61906905209	82920	94876	3540349	117949	3658298	419550		2023-11-15 12:12:48.35602
367	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87908	128110.84264877981	94140	95596	9336148	597322	9937070	1242491		2023-11-15 12:12:49.266285
368	P01230	t	f	t	f	f	35 lbs nov.xml	41896	73921.9649740604	83368	84824	2945879	443078	3388837	137179		2023-11-15 12:12:51.075495
369	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42147.61906905209	87920	94876	3540349	117949	3658298	419550		2023-11-15 12:12:53.36683
370	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.47574877062	3532	95604	9336148	597322	9937070	1242496		2023-11-15 12:12:54.280919
371	P01230	t	f	t	f	f	35 lbs nov.xml	41897	73922.56087408484	3588	84776	2945879	443078	3388837	137184		2023-11-15 12:12:55.931115
372	P01229	t	f	t	f	f	10 lbs octubre.xml	30004	42148.1301690525	92920	94876	3540349	117949	3658298	419550		2023-11-15 12:12:58.376524
373	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.6373487691	8532	95604	9336148	597322	9937070	1242501		2023-11-15 12:12:59.287034
374	P01230	t	f	t	f	f	35 lbs nov.xml	41897	73922.6947740845	8588	84776	2945879	443078	3388837	137190		2023-11-15 12:13:00.938485
375	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42148.74976908914	2828	95088	3540349	117949	3658298	419556		2023-11-15 12:13:03.535481
376	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.63764877025	13532	95604	9336148	597322	9937070	1242501		2023-11-15 12:13:04.293458
377	P01230	t	f	t	f	f	35 lbs nov.xml	41897	73922.6947740845	13588	84776	2945879	443078	3388837	137190		2023-11-15 12:13:06.094746
378	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.19056910168	7828	95088	3540349	117949	3658298	419562		2023-11-15 12:13:08.40301
379	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.63814877217	18532	95604	9336148	597322	9937070	1242504		2023-11-15 12:13:09.298851
380	P01230	t	f	t	f	f	35 lbs nov.xml	41897	73922.69907408758	18588	84776	2945879	443078	3388837	137193		2023-11-15 12:13:11.115984
381	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.19056910168	12828	95088	3540349	117949	3658298	419562		2023-11-15 12:13:13.406415
382	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.63814877217	23532	95604	9336148	597322	9937070	1242504		2023-11-15 12:13:14.303062
383	P01230	t	f	t	f	f	35 lbs nov.xml	41897	73922.69907408758	23588	84776	2945879	443078	3388837	137193		2023-11-15 12:13:15.966432
384	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.195369101864	17828	95088	3540349	117949	3658298	419562		2023-11-15 12:13:18.529338
385	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.63814877217	28532	95604	9336148	597322	9937070	1242504		2023-11-15 12:13:19.315611
386	P01230	t	f	t	f	f	35 lbs nov.xml	41897	73922.69907408758	28588	84776	2945879	443078	3388837	137193		2023-11-15 12:13:20.968376
387	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.195369101864	22828	95088	3540349	117949	3658298	419565		2023-11-15 12:13:23.540124
388	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.63814877217	33532	95604	9336148	597322	9937070	1242504		2023-11-15 12:13:24.318494
389	P01230	t	f	t	f	f	35 lbs nov.xml	41897	73922.69907408758	33588	84776	2945879	443078	3388837	137193		2023-11-15 12:13:25.971237
390	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.195369101864	27828	95088	3540349	117949	3658298	419565		2023-11-15 12:13:28.428179
391	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.63814877217	38532	95604	9336148	597322	9937070	1242504		2023-11-15 12:13:29.325533
392	P01230	t	f	t	f	f	35 lbs nov.xml	41897	73922.69907408758	38588	84776	2945879	443078	3388837	137193		2023-11-15 12:13:30.978553
393	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.195369101864	32828	95088	3540349	117949	3658298	419565		2023-11-15 12:13:33.526946
394	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.63814877217	43532	95604	9336148	597322	9937070	1242504		2023-11-15 12:13:34.332753
395	P01230	t	f	t	f	f	35 lbs nov.xml	41897	73922.69907408758	43588	84776	2945879	443078	3388837	137193		2023-11-15 12:13:35.980164
396	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.195369101864	37828	95088	3540349	117949	3658298	419565		2023-11-15 12:13:38.544331
397	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.63814877217	48532	95604	9336148	597322	9937070	1242504		2023-11-15 12:13:39.345047
398	P01230	t	f	t	f	f	35 lbs nov.xml	41897	73922.69907408758	48588	84776	2945879	443078	3388837	137193		2023-11-15 12:13:41.1407
399	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.195369101864	42828	95088	3540349	117949	3658298	419565		2023-11-15 12:13:43.449698
400	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.63814877217	53532	95604	9336148	597322	9937070	1242504		2023-11-15 12:13:44.347723
401	P01230	t	f	t	f	f	35 lbs nov.xml	41897	73922.69907408758	53588	84776	2945879	443078	3388837	137193		2023-11-15 12:13:46.004433
402	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.195369101864	47828	95088	3540349	117949	3658298	419565		2023-11-15 12:13:48.457861
403	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.63814877217	58532	95604	9336148	597322	9937070	1242504		2023-11-15 12:13:49.357205
404	P01230	t	f	t	f	f	35 lbs nov.xml	41897	73922.69907408758	58588	84776	2945879	443078	3388837	137193		2023-11-15 12:13:51.160581
405	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.195369101864	52828	95088	3540349	117949	3658298	419565		2023-11-15 12:13:53.469429
406	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.63814877217	63532	95604	9336148	597322	9937070	1242504		2023-11-15 12:13:54.36932
407	P01230	t	f	t	f	f	35 lbs nov.xml	41897	73922.69907408758	63588	84776	2945879	443078	3388837	137193		2023-11-15 12:13:56.019734
408	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.195369101864	57828	95088	3540349	117949	3658298	419565		2023-11-15 12:13:58.47487
409	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.63814877217	68732	95604	9336148	597322	9937070	1242504		2023-11-15 12:13:59.380131
410	P01230	t	f	t	f	f	35 lbs nov.xml	41897	73922.69907408758	68588	84776	2945879	443078	3388837	137193		2023-11-15 12:14:01.023315
411	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.195369101864	62828	95088	3540349	117949	3658298	419565		2023-11-15 12:14:03.584394
412	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.63814877217	73732	95604	9336148	597322	9937070	1242504		2023-11-15 12:14:04.386875
413	P01230	t	f	t	f	f	35 lbs nov.xml	41897	73922.69907408758	73588	84776	2945879	443078	3388837	137193		2023-11-15 12:14:06.184316
414	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.195369101864	68028	95088	3540349	117949	3658298	419565		2023-11-15 12:14:08.500514
415	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.63814877217	78732	95604	9336148	597322	9937070	1242504		2023-11-15 12:14:09.40352
416	P01230	t	f	t	f	f	35 lbs nov.xml	41897	73922.69907408758	78588	84776	2945879	443078	3388837	137193		2023-11-15 12:14:11.185234
417	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.195369101864	73028	95088	3540349	117949	3658298	419565		2023-11-15 12:14:13.508195
418	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.63814877217	83732	95604	9336148	597322	9937070	1242504		2023-11-15 12:14:14.407961
419	P01230	t	f	t	f	f	35 lbs nov.xml	41897	73923.334274075	83588	84776	2945879	443078	3388837	137193		2023-11-15 12:14:16.044249
420	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.195369101864	78028	95088	3540349	117949	3658298	419565		2023-11-15 12:14:18.648485
421	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128111.63814877217	88732	95604	9336148	597322	9937070	1242504		2023-11-15 12:14:19.415417
422	P01230	t	f	t	f	f	35 lbs nov.xml	41898	73923.96377409787	3748	84836	2945879	443078	3388837	137198		2023-11-15 12:14:21.0578
423	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.195369101864	83028	95088	3540349	117949	3658298	419565		2023-11-15 12:14:23.619821
424	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87909	128112.27724878404	93732	95604	9336148	597322	9937070	1242504		2023-11-15 12:14:24.424427
425	P01230	t	f	t	f	f	35 lbs nov.xml	41898	73924.0347740998	8748	84836	2945879	443078	3388837	137204		2023-11-15 12:14:26.20902
426	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.195369101864	88028	95088	3540349	117949	3658298	419565		2023-11-15 12:14:28.530218
427	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128112.87224881451	3104	95624	9336148	597322	9937070	1242510		2023-11-15 12:14:29.432071
428	P01230	t	f	t	f	f	35 lbs nov.xml	41898	73924.0347740998	13748	84836	2945879	443078	3388837	137204		2023-11-15 12:14:31.074671
429	P01229	t	f	t	f	f	10 lbs octubre.xml	30005	42149.74266911447	93028	95088	3540349	117949	3658298	419565		2023-11-15 12:14:33.632555
430	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.12644882099	8104	95624	9336148	597322	9937070	1242516		2023-11-15 12:14:34.438519
431	P01230	t	f	t	f	f	35 lbs nov.xml	41898	73924.03907410285	18748	84836	2945879	443078	3388837	137207		2023-11-15 12:14:36.078368
432	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.36476909005	3048	94976	3540349	117949	3658298	419571		2023-11-15 12:14:38.722234
433	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.12644882099	13104	95624	9336148	597322	9937070	1242516		2023-11-15 12:14:39.448249
434	P01230	t	f	t	f	f	35 lbs nov.xml	41898	73924.03907410285	23748	84836	2945879	443078	3388837	137207		2023-11-15 12:14:41.188372
435	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.76826909002	8048	94976	3540349	117949	3658298	419577		2023-11-15 12:14:43.555029
436	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.12724882405	18104	95624	9336148	597322	9937070	1242518		2023-11-15 12:14:44.447003
437	P01230	t	f	t	f	f	35 lbs nov.xml	41898	73924.03907410285	28748	84836	2945879	443078	3388837	137207		2023-11-15 12:14:46.099113
438	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.76826909002	13048	94976	3540349	117949	3658298	419577		2023-11-15 12:14:48.56865
439	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.12724882405	23104	95624	9336148	597322	9937070	1242518		2023-11-15 12:14:49.459877
440	P01230	t	f	t	f	f	35 lbs nov.xml	41898	73924.03907410285	33948	84836	2945879	443078	3388837	137207		2023-11-15 12:14:51.259963
441	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.77376909097	18048	94976	3540349	117949	3658298	419577		2023-11-15 12:14:53.657918
442	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.12724882405	28104	95624	9336148	597322	9937070	1242518		2023-11-15 12:14:54.463838
443	P01230	t	f	t	f	f	35 lbs nov.xml	41898	73924.03907410285	38948	84836	2945879	443078	3388837	137207		2023-11-15 12:14:56.115102
444	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.77376909097	23048	94976	3540349	117949	3658298	419581		2023-11-15 12:14:58.577277
445	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.12724882405	33104	95624	9336148	597322	9937070	1242518		2023-11-15 12:14:59.478395
446	P01230	t	f	t	f	f	35 lbs nov.xml	41898	73924.03907410285	43948	84836	2945879	443078	3388837	137207		2023-11-15 12:15:01.132131
447	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.77376909097	28048	94976	3540349	117949	3658298	419581		2023-11-15 12:15:03.672619
448	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.12724882405	38104	95624	9336148	597322	9937070	1242518		2023-11-15 12:15:04.48572
449	P01230	t	f	t	f	f	35 lbs nov.xml	41898	73924.03907410285	48948	84836	2945879	443078	3388837	137207		2023-11-15 12:15:06.292253
450	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.77376909097	33048	94976	3540349	117949	3658298	419581		2023-11-15 12:15:08.583673
451	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.12724882405	43104	95624	9336148	597322	9937070	1242518		2023-11-15 12:15:09.497265
452	P01230	t	f	t	f	f	35 lbs nov.xml	41898	73924.03907410285	53948	84836	2945879	443078	3388837	137207		2023-11-15 12:15:11.151261
453	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.77376909097	38048	94976	3540349	117949	3658298	419581		2023-11-15 12:15:13.589605
454	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.12724882405	48104	95624	9336148	597322	9937070	1242518		2023-11-15 12:15:14.50186
455	P01230	t	f	t	f	f	35 lbs nov.xml	41898	73924.03907410285	58948	84836	2945879	443078	3388837	137207		2023-11-15 12:15:16.153806
456	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.77376909097	43048	94976	3540349	117949	3658298	419581		2023-11-15 12:15:18.805607
457	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.12724882405	53104	95624	9336148	597322	9937070	1242518		2023-11-15 12:15:19.510003
458	P01230	t	f	t	f	f	35 lbs nov.xml	41898	73924.03907410285	63948	84836	2945879	443078	3388837	137207		2023-11-15 12:15:21.311642
459	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.77376909097	48048	94976	3540349	117949	3658298	419581		2023-11-15 12:15:23.803691
460	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.12724882405	58104	95624	9336148	597322	9937070	1242518		2023-11-15 12:15:24.517783
461	P01230	t	f	t	f	f	35 lbs nov.xml	41898	73924.03907410285	68948	84836	2945879	443078	3388837	137207		2023-11-15 12:15:26.315213
462	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.77376909097	53048	94976	3540349	117949	3658298	419581		2023-11-15 12:15:28.620329
463	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.12724882405	63104	95624	9336148	597322	9937070	1242518		2023-11-15 12:15:29.530512
464	P01230	t	f	t	f	f	35 lbs nov.xml	41898	73924.03907410285	73948	84836	2945879	443078	3388837	137207		2023-11-15 12:15:31.169722
465	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.77376909097	58048	94976	3540349	117949	3658298	419581		2023-11-15 12:15:33.830511
466	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.12724882405	68104	95624	9336148	597322	9937070	1242518		2023-11-15 12:15:34.545937
467	P01230	t	f	t	f	f	35 lbs nov.xml	41898	73924.03907410285	78948	84836	2945879	443078	3388837	137207		2023-11-15 12:15:36.170314
468	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.77376909097	63048	94976	3540349	117949	3658298	419581		2023-11-15 12:15:38.638467
469	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.12724882405	73104	95624	9336148	597322	9937070	1242518		2023-11-15 12:15:39.562496
470	P01230	t	f	t	f	f	35 lbs nov.xml	41898	73924.68247407762	83948	84836	2945879	443078	3388837	137207		2023-11-15 12:15:41.338904
471	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.77376909097	68048	94976	3540349	117949	3658298	419581		2023-11-15 12:15:43.649332
472	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.12724882405	78104	95624	9336148	597322	9937070	1242518		2023-11-15 12:15:44.56015
473	P01230	t	f	t	f	f	35 lbs nov.xml	41899	73925.33277405394	4160	84784	2945879	443078	3388837	137212		2023-11-15 12:15:46.185567
474	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.77376909097	73048	94976	3540349	117949	3658298	419581		2023-11-15 12:15:48.663364
475	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.12724882405	83104	95624	9336148	597322	9937070	1242518		2023-11-15 12:15:49.563346
476	P01230	t	f	t	f	f	35 lbs nov.xml	41899	73925.37567405362	9160	84784	2945879	443078	3388837	137217		2023-11-15 12:15:51.345158
477	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.77376909097	78048	94976	3540349	117949	3658298	419581		2023-11-15 12:15:53.763239
478	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.12724882405	88104	95624	9336148	597322	9937070	1242518		2023-11-15 12:15:54.570695
479	P01230	t	f	t	f	f	35 lbs nov.xml	41899	73925.37567405362	14160	84784	2945879	443078	3388837	137217		2023-11-15 12:15:56.204907
480	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.77376909097	83048	94976	3540349	117949	3658298	419581		2023-11-15 12:15:58.67187
481	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87910	128113.67344884774	93104	95624	9336148	597322	9937070	1242518		2023-11-15 12:15:59.568705
482	P01230	t	f	t	f	f	35 lbs nov.xml	41899	73925.38017405364	19160	84784	2945879	443078	3388837	137220		2023-11-15 12:16:01.210596
483	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42150.77376909097	88048	94976	3540349	117949	3658298	419581		2023-11-15 12:16:03.763597
484	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.25064879887	2664	95636	9336148	597322	9937070	1242524		2023-11-15 12:16:04.633439
485	P01230	t	f	t	f	f	35 lbs nov.xml	41899	73925.38017405364	24160	84784	2945879	443078	3388837	137220		2023-11-15 12:16:06.225189
486	P01229	t	f	t	f	f	10 lbs octubre.xml	30006	42151.333669114894	93048	94976	3540349	117949	3658298	419581		2023-11-15 12:16:08.679409
487	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.61574879926	7664	95636	9336148	597322	9937070	1242530		2023-11-15 12:16:09.593127
488	P01230	t	f	t	f	f	35 lbs nov.xml	41899	73925.38017405364	29160	84784	2945879	443078	3388837	137220		2023-11-15 12:16:11.230328
489	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42151.95366920645	2976	95068	3540349	117949	3658298	419587		2023-11-15 12:16:13.686299
490	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.61574879926	12664	95636	9336148	597322	9937070	1242530		2023-11-15 12:16:14.60086
491	P01230	t	f	t	f	f	35 lbs nov.xml	41899	73925.38017405364	34160	84784	2945879	443078	3388837	137220		2023-11-15 12:16:16.24855
492	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.34506921223	7976	95068	3540349	117949	3658298	419593		2023-11-15 12:16:18.870971
493	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.61664880271	17664	95636	9336148	597322	9937070	1242533		2023-11-15 12:16:19.615317
494	P01230	t	f	t	f	f	35 lbs nov.xml	41899	73925.38017405364	39160	84784	2945879	443078	3388837	137220		2023-11-15 12:16:21.409099
495	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.34506921223	12976	95068	3540349	117949	3658298	419593		2023-11-15 12:16:23.785799
496	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.61664880271	22664	95636	9336148	597322	9937070	1242533		2023-11-15 12:16:24.620339
497	P01230	t	f	t	f	f	35 lbs nov.xml	41899	73925.38017405364	44160	84784	2945879	443078	3388837	137220		2023-11-15 12:16:26.40401
498	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.349869212885	18176	95068	3540349	117949	3658298	419593		2023-11-15 12:16:28.696349
499	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.61664880271	27664	95636	9336148	597322	9937070	1242533		2023-11-15 12:16:29.627495
500	P01230	t	f	t	f	f	35 lbs nov.xml	41899	73925.38017405364	49160	84784	2945879	443078	3388837	137220		2023-11-15 12:16:31.453632
501	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.349869212885	23176	95068	3540349	117949	3658298	419597		2023-11-15 12:16:33.69798
502	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.61664880271	32664	95636	9336148	597322	9937070	1242533		2023-11-15 12:16:34.634551
503	P01230	t	f	t	f	f	35 lbs nov.xml	41899	73925.38017405364	54360	84784	2945879	443078	3388837	137220		2023-11-15 12:16:36.310271
504	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.349869212885	28176	95068	3540349	117949	3658298	419597		2023-11-15 12:16:38.704129
505	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.61664880271	37664	95636	9336148	597322	9937070	1242533		2023-11-15 12:16:39.647031
506	P01230	t	f	t	f	f	35 lbs nov.xml	41899	73925.38017405364	59360	84784	2945879	443078	3388837	137220		2023-11-15 12:16:41.481124
507	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.349869212885	33176	95068	3540349	117949	3658298	419597		2023-11-15 12:16:43.716299
508	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.61664880271	42664	95636	9336148	597322	9937070	1242533		2023-11-15 12:16:44.659933
509	P01230	t	f	t	f	f	35 lbs nov.xml	41899	73925.38017405364	64360	84784	2945879	443078	3388837	137220		2023-11-15 12:16:46.497592
510	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.349869212885	38176	95068	3540349	117949	3658298	419597		2023-11-15 12:16:48.71691
511	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.61664880271	47664	95636	9336148	597322	9937070	1242533		2023-11-15 12:16:49.658893
512	P01230	t	f	t	f	f	35 lbs nov.xml	41899	73925.38017405364	69360	84784	2945879	443078	3388837	137220		2023-11-15 12:16:51.501468
513	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.349869212885	43176	95068	3540349	117949	3658298	419597		2023-11-15 12:16:53.811251
514	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.61664880271	52664	95636	9336148	597322	9937070	1242533		2023-11-15 12:16:54.676637
515	P01230	t	f	t	f	f	35 lbs nov.xml	41899	73925.38017405364	74360	84784	2945879	443078	3388837	137220		2023-11-15 12:16:56.37097
516	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.349869212885	48176	95068	3540349	117949	3658298	419597		2023-11-15 12:16:58.735122
517	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.61664880271	57664	95636	9336148	597322	9937070	1242533		2023-11-15 12:16:59.680355
518	P01230	t	f	t	f	f	35 lbs nov.xml	41899	73925.38017405364	79360	84784	2945879	443078	3388837	137220		2023-11-15 12:17:01.378514
519	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.349869212885	53176	95068	3540349	117949	3658298	419597		2023-11-15 12:17:03.82617
520	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.61664880271	62664	95636	9336148	597322	9937070	1242533		2023-11-15 12:17:04.683983
521	P01230	t	f	t	f	f	35 lbs nov.xml	41899	73926.03527404061	84360	84784	2945879	443078	3388837	137220		2023-11-15 12:17:06.382948
522	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.349869212885	58176	95068	3540349	117949	3658298	419597		2023-11-15 12:17:08.744887
523	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.61664880271	67664	95636	9336148	597322	9937070	1242533		2023-11-15 12:17:09.687369
524	P01230	t	f	t	f	f	35 lbs nov.xml	41900	73926.68427406345	4564	84792	2945879	443078	3388837	137226		2023-11-15 12:17:11.749635
525	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.349869212885	63176	95068	3540349	117949	3658298	419597		2023-11-15 12:17:13.753364
526	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.61664880271	72664	95636	9336148	597322	9937070	1242533		2023-11-15 12:17:14.696205
527	P01230	t	f	t	f	f	35 lbs nov.xml	41900	73926.71457406461	9564	84792	2945879	443078	3388837	137231		2023-11-15 12:17:16.388541
528	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.349869212885	68176	95068	3540349	117949	3658298	419597		2023-11-15 12:17:18.899208
529	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.61664880271	77664	95636	9336148	597322	9937070	1242533		2023-11-15 12:17:19.707416
530	P01230	t	f	t	f	f	35 lbs nov.xml	41900	73926.71457406461	14564	84792	2945879	443078	3388837	137231		2023-11-15 12:17:21.541416
531	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.349869212885	73176	95068	3540349	117949	3658298	419597		2023-11-15 12:17:23.861378
532	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.61664880271	82664	95636	9336148	597322	9937070	1242533		2023-11-15 12:17:24.72425
533	P01230	t	f	t	f	f	35 lbs nov.xml	41900	73926.71897406616	19564	84792	2945879	443078	3388837	137235		2023-11-15 12:17:26.545173
534	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.349869212885	78176	95068	3540349	117949	3658298	419597		2023-11-15 12:17:28.776
535	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128114.61664880271	87664	95636	9336148	597322	9937070	1242533		2023-11-15 12:17:29.738932
536	P01230	t	f	t	f	f	35 lbs nov.xml	41900	73926.71897406616	24564	84792	2945879	443078	3388837	137235		2023-11-15 12:17:31.592623
537	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.349869212885	83176	95068	3540349	117949	3658298	419597		2023-11-15 12:17:33.777121
538	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87911	128115.06514879702	92664	95636	9336148	597322	9937070	1242533		2023-11-15 12:17:34.736828
539	P01230	t	f	t	f	f	35 lbs nov.xml	41900	73926.71897406616	29564	84792	2945879	443078	3388837	137235		2023-11-15 12:17:36.415802
540	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.349869212885	88176	95068	3540349	117949	3658298	419597		2023-11-15 12:17:38.934794
541	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128115.64214882754	2012	95648	9336148	597322	9937070	1242538		2023-11-15 12:17:39.735049
542	P01230	t	f	t	f	f	35 lbs nov.xml	41900	73926.71897406616	34564	84792	2945879	443078	3388837	137235		2023-11-15 12:17:41.6835
543	P01229	t	f	t	f	f	10 lbs octubre.xml	30007	42152.933469200885	93176	95068	3540349	117949	3658298	419597		2023-11-15 12:17:43.803015
544	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.10664883895	7012	95648	9336148	597322	9937070	1242543		2023-11-15 12:17:44.74284
545	P01230	t	f	t	f	f	35 lbs nov.xml	41900	73926.71897406616	39564	84792	2945879	443078	3388837	137235		2023-11-15 12:17:46.726129
546	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.554769310715	3172	95000	3540349	117949	3658298	419603		2023-11-15 12:17:48.812963
547	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.10664883895	12012	95648	9336148	597322	9937070	1242543		2023-11-15 12:17:49.752095
548	P01230	t	f	t	f	f	35 lbs nov.xml	41900	73926.71897406616	44564	84792	2945879	443078	3388837	137235		2023-11-15 12:17:51.660167
549	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.92186929867	8172	95000	3540349	117949	3658298	419609		2023-11-15 12:17:53.918824
550	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.10724884125	17012	95648	9336148	597322	9937070	1242546		2023-11-15 12:17:54.760026
551	P01230	t	f	t	f	f	35 lbs nov.xml	41900	73926.71897406616	49564	84792	2945879	443078	3388837	137235		2023-11-15 12:17:56.447693
552	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.92186929867	13172	95000	3540349	117949	3658298	419609		2023-11-15 12:17:58.879609
553	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.10724884125	22012	95648	9336148	597322	9937070	1242546		2023-11-15 12:17:59.772838
554	P01230	t	f	t	f	f	35 lbs nov.xml	41900	73926.71897406616	54564	84792	2945879	443078	3388837	137235		2023-11-15 12:18:01.447133
555	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.92686929961	18172	95000	3540349	117949	3658298	419609		2023-11-15 12:18:03.990892
556	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.10724884125	27012	95648	9336148	597322	9937070	1242546		2023-11-15 12:18:04.77087
557	P01230	t	f	t	f	f	35 lbs nov.xml	41900	73926.71897406616	59564	84792	2945879	443078	3388837	137235		2023-11-15 12:18:06.631061
558	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.92686929961	23172	95000	3540349	117949	3658298	419613		2023-11-15 12:18:08.889636
559	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.10724884125	32012	95648	9336148	597322	9937070	1242546		2023-11-15 12:18:09.775775
560	P01230	t	f	t	f	f	35 lbs nov.xml	41900	73926.71897406616	64564	84792	2945879	443078	3388837	137235		2023-11-15 12:18:11.619022
561	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.92686929961	28372	95000	3540349	117949	3658298	419613		2023-11-15 12:18:13.897458
562	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.10724884125	37212	95648	9336148	597322	9937070	1242546		2023-11-15 12:18:14.778056
563	P01230	t	f	t	f	f	35 lbs nov.xml	41900	73926.71897406616	69564	84792	2945879	443078	3388837	137235		2023-11-15 12:18:16.626119
564	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.92686929961	33372	95000	3540349	117949	3658298	419613		2023-11-15 12:18:19.183495
565	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.10724884125	42212	95648	9336148	597322	9937070	1242546		2023-11-15 12:18:19.78502
566	P01230	t	f	t	f	f	35 lbs nov.xml	41900	73926.71897406616	74564	84792	2945879	443078	3388837	137235		2023-11-15 12:18:21.635273
567	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.92686929961	38372	95000	3540349	117949	3658298	419613		2023-11-15 12:18:23.929081
568	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.10724884125	47212	95648	9336148	597322	9937070	1242546		2023-11-15 12:18:24.791896
569	P01230	t	f	t	f	f	35 lbs nov.xml	41900	73926.71897406616	79564	84792	2945879	443078	3388837	137235		2023-11-15 12:18:26.487735
570	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.92686929961	43372	95000	3540349	117949	3658298	419613		2023-11-15 12:18:28.941431
571	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.10724884125	52212	95648	9336148	597322	9937070	1242546		2023-11-15 12:18:29.810487
572	P01230	t	f	t	f	f	35 lbs nov.xml	41900	73927.38077407875	84564	84792	2945879	443078	3388837	137235		2023-11-15 12:18:31.710627
573	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.92686929961	48372	95000	3540349	117949	3658298	419613		2023-11-15 12:18:34.039091
574	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.10724884125	57212	95648	9336148	597322	9937070	1242546		2023-11-15 12:18:34.812404
575	P01230	t	f	t	f	f	35 lbs nov.xml	41901	73928.03237404286	4684	84876	2945879	443078	3388837	137240		2023-11-15 12:18:36.500846
576	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.92686929961	53372	95000	3540349	117949	3658298	419613		2023-11-15 12:18:39.046234
577	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.10724884125	62212	95648	9336148	597322	9937070	1242546		2023-11-15 12:18:39.818572
578	P01230	t	f	t	f	f	35 lbs nov.xml	41901	73928.0562740425	9884	84876	2945879	443078	3388837	137245		2023-11-15 12:18:41.515468
579	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.92686929961	58372	95000	3540349	117949	3658298	419613		2023-11-15 12:18:43.950144
580	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.10724884125	67212	95648	9336148	597322	9937070	1242546		2023-11-15 12:18:44.817407
581	P01230	t	f	t	f	f	35 lbs nov.xml	41901	73928.0562740425	14884	84876	2945879	443078	3388837	137245		2023-11-15 12:18:46.746117
582	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.92686929961	63372	95000	3540349	117949	3658298	419613		2023-11-15 12:18:48.957422
583	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.10724884125	72212	95648	9336148	597322	9937070	1242546		2023-11-15 12:18:49.822081
584	P01230	t	f	t	f	f	35 lbs nov.xml	41901	73928.06107404556	19884	84876	2945879	443078	3388837	137249		2023-11-15 12:18:51.531608
585	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.92686929961	68372	95000	3540349	117949	3658298	419613		2023-11-15 12:18:54.063408
586	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.10724884125	77212	95648	9336148	597322	9937070	1242546		2023-11-15 12:18:54.821606
587	P01230	t	f	t	f	f	35 lbs nov.xml	41901	73928.06107404556	24884	84876	2945879	443078	3388837	137249		2023-11-15 12:18:56.539817
588	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.92686929961	73372	95000	3540349	117949	3658298	419613		2023-11-15 12:18:58.984116
589	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.10724884125	82212	95648	9336148	597322	9937070	1242546		2023-11-15 12:18:59.832409
590	P01230	t	f	t	f	f	35 lbs nov.xml	41901	73928.06107404556	29884	84876	2945879	443078	3388837	137249		2023-11-15 12:19:01.761222
591	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.92686929961	78372	95000	3540349	117949	3658298	419613		2023-11-15 12:19:04.075855
592	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.10724884125	87212	95648	9336148	597322	9937070	1242546		2023-11-15 12:19:04.836933
593	P01230	t	f	t	f	f	35 lbs nov.xml	41901	73928.06107404556	34884	84876	2945879	443078	3388837	137249		2023-11-15 12:19:06.708312
594	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.92686929961	83372	95000	3540349	117949	3658298	419613		2023-11-15 12:19:08.992259
595	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87912	128116.43324882413	92212	95648	9336148	597322	9937070	1242546		2023-11-15 12:19:09.84561
596	P01230	t	f	t	f	f	35 lbs nov.xml	41901	73928.06107404556	39884	84876	2945879	443078	3388837	137249		2023-11-15 12:19:11.552425
597	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42153.92686929961	88372	95000	3540349	117949	3658298	419613		2023-11-15 12:19:13.996697
598	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.02174885463	1512	95696	9336148	597322	9937070	1242552		2023-11-15 12:19:14.855831
599	P01230	t	f	t	f	f	35 lbs nov.xml	41901	73928.06107404556	44884	84876	2945879	443078	3388837	137249		2023-11-15 12:19:16.557022
600	P01229	t	f	t	f	f	10 lbs octubre.xml	30008	42154.55826927491	93372	95000	3540349	117949	3658298	419613		2023-11-15 12:19:18.995717
601	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.59634883015	6512	95696	9336148	597322	9937070	1242558		2023-11-15 12:19:19.862663
602	P01230	t	f	t	f	f	35 lbs nov.xml	41901	73928.06107404556	49884	84876	2945879	443078	3388837	137249		2023-11-15 12:19:21.714509
603	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.1665692322	3384	94984	3540349	117949	3658298	419619		2023-11-15 12:19:24.008517
604	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.59634883015	11512	95696	9336148	597322	9937070	1242558		2023-11-15 12:19:24.873835
605	P01230	t	f	t	f	f	35 lbs nov.xml	41901	73928.06107404556	54884	84876	2945879	443078	3388837	137249		2023-11-15 12:19:26.572063
606	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.49566925019	8384	94984	3540349	117949	3658298	419625		2023-11-15 12:19:29.023315
607	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.59714883321	16512	95696	9336148	597322	9937070	1242560		2023-11-15 12:19:29.88961
608	P01230	t	f	t	f	f	35 lbs nov.xml	41901	73928.06107404556	59884	84876	2945879	443078	3388837	137249		2023-11-15 12:19:31.746799
609	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.49566925019	13384	94984	3540349	117949	3658298	419625		2023-11-15 12:19:34.11868
610	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.59714883321	21512	95696	9336148	597322	9937070	1242560		2023-11-15 12:19:34.897773
611	P01230	t	f	t	f	f	35 lbs nov.xml	41901	73928.06107404556	64884	84876	2945879	443078	3388837	137249		2023-11-15 12:19:36.597041
612	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.50116925065	18384	94984	3540349	117949	3658298	419625		2023-11-15 12:19:39.13283
613	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.59714883321	26512	95696	9336148	597322	9937070	1242560		2023-11-15 12:19:39.908726
614	P01230	t	f	t	f	f	35 lbs nov.xml	41901	73928.06107404556	69884	84876	2945879	443078	3388837	137249		2023-11-15 12:19:41.610887
615	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.50116925065	23384	94984	3540349	117949	3658298	419629		2023-11-15 12:19:44.047426
616	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.59714883321	31512	95696	9336148	597322	9937070	1242560		2023-11-15 12:19:44.937429
617	P01230	t	f	t	f	f	35 lbs nov.xml	41901	73928.06107404556	74884	84876	2945879	443078	3388837	137249		2023-11-15 12:19:46.614459
618	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.50116925065	28384	94984	3540349	117949	3658298	419629		2023-11-15 12:19:49.054915
619	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.59714883321	36512	95696	9336148	597322	9937070	1242560		2023-11-15 12:19:49.950315
620	P01230	t	f	t	f	f	35 lbs nov.xml	41901	73928.06307404557	79884	84876	2945879	443078	3388837	137249		2023-11-15 12:19:51.621295
621	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.50116925065	33384	94984	3540349	117949	3658298	419629		2023-11-15 12:19:54.156155
622	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.59714883321	41512	95696	9336148	597322	9937070	1242560		2023-11-15 12:19:54.951027
623	P01230	t	f	t	f	f	35 lbs nov.xml	41902	73928.72947404512	36	84844	2945879	443078	3388837	137254		2023-11-15 12:19:56.633434
624	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.50116925065	38384	94984	3540349	117949	3658298	419629		2023-11-15 12:19:59.073276
625	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.59714883321	46512	95696	9336148	597322	9937070	1242560		2023-11-15 12:19:59.951085
626	P01230	t	f	t	f	f	35 lbs nov.xml	41902	73929.38037410575	5036	84844	2945879	443078	3388837	137254		2023-11-15 12:20:01.781266
627	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.50116925065	43384	94984	3540349	117949	3658298	419629		2023-11-15 12:20:04.17234
628	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.59714883321	51512	95696	9336148	597322	9937070	1242560		2023-11-15 12:20:04.967157
629	P01230	t	f	t	f	f	35 lbs nov.xml	41902	73929.39547410615	10036	84844	2945879	443078	3388837	137260		2023-11-15 12:20:06.796979
630	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.50116925065	48384	94984	3540349	117949	3658298	419629		2023-11-15 12:20:09.087316
631	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.59714883321	56512	95696	9336148	597322	9937070	1242560		2023-11-15 12:20:09.963126
632	P01230	t	f	t	f	f	35 lbs nov.xml	41902	73929.39587410768	15036	84844	2945879	443078	3388837	137260		2023-11-15 12:20:11.659155
633	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.50116925065	53584	94984	3540349	117949	3658298	419629		2023-11-15 12:20:14.097101
634	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.59714883321	61712	95696	9336148	597322	9937070	1242560		2023-11-15 12:20:14.979849
635	P01230	t	f	t	f	f	35 lbs nov.xml	41902	73929.40027410924	20036	84844	2945879	443078	3388837	137263		2023-11-15 12:20:16.672909
636	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.50116925065	58584	94984	3540349	117949	3658298	419629		2023-11-15 12:20:19.098118
637	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.59714883321	66712	95696	9336148	597322	9937070	1242560		2023-11-15 12:20:19.979148
638	P01230	t	f	t	f	f	35 lbs nov.xml	41902	73929.40027410924	25036	84844	2945879	443078	3388837	137263		2023-11-15 12:20:21.890569
639	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.50116925065	63584	94984	3540349	117949	3658298	419629		2023-11-15 12:20:24.200821
640	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.59714883321	71712	95696	9336148	597322	9937070	1242560		2023-11-15 12:20:24.986524
641	P01230	t	f	t	f	f	35 lbs nov.xml	41902	73929.40027410924	30036	84844	2945879	443078	3388837	137263		2023-11-15 12:20:26.702817
642	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.50116925065	68584	94984	3540349	117949	3658298	419629		2023-11-15 12:20:29.109915
643	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.59714883321	76712	95696	9336148	597322	9937070	1242560		2023-11-15 12:20:29.991854
644	P01230	t	f	t	f	f	35 lbs nov.xml	41902	73929.40027410924	35036	84844	2945879	443078	3388837	137263		2023-11-15 12:20:31.873066
645	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.50116925065	73584	94984	3540349	117949	3658298	419629		2023-11-15 12:20:34.217417
646	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.59714883321	81712	95696	9336148	597322	9937070	1242560		2023-11-15 12:20:35.006945
647	P01230	t	f	t	f	f	35 lbs nov.xml	41902	73929.40027410924	40236	84844	2945879	443078	3388837	137263		2023-11-15 12:20:36.717429
648	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.50116925065	78584	94984	3540349	117949	3658298	419629		2023-11-15 12:20:39.223408
649	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.59714883321	86712	95696	9336148	597322	9937070	1242560		2023-11-15 12:20:40.010611
650	P01230	t	f	t	f	f	35 lbs nov.xml	41902	73929.40027410924	45236	84844	2945879	443078	3388837	137263		2023-11-15 12:20:41.727095
651	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.50116925065	83584	94984	3540349	117949	3658298	419629		2023-11-15 12:20:44.13363
652	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87913	128117.82464884662	91712	95696	9336148	597322	9937070	1242560		2023-11-15 12:20:45.015011
653	P01230	t	f	t	f	f	35 lbs nov.xml	41902	73929.40027410924	50236	84844	2945879	443078	3388837	137263		2023-11-15 12:20:46.729738
654	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42155.50116925065	88584	94984	3540349	117949	3658298	419629		2023-11-15 12:20:49.134591
655	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128118.39804881	1008	95700	9336148	597322	9937070	1242566		2023-11-15 12:20:50.016884
656	P01230	t	f	t	f	f	35 lbs nov.xml	41902	73929.40027410924	55236	84844	2945879	443078	3388837	137263		2023-11-15 12:20:51.895484
657	P01229	t	f	t	f	f	10 lbs octubre.xml	30009	42156.09626925103	93584	94984	3540349	117949	3658298	419629		2023-11-15 12:20:54.351104
658	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.08734880923	6008	95700	9336148	597322	9937070	1242572		2023-11-15 12:20:55.015005
659	P01230	t	f	t	f	f	35 lbs nov.xml	41902	73929.40027410924	60236	84844	2945879	443078	3388837	137263		2023-11-15 12:20:56.748981
660	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42156.71706926934	3268	95312	3540349	117949	3658298	419634		2023-11-15 12:20:59.160682
661	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.08734880923	11008	95700	9336148	597322	9937070	1242572		2023-11-15 12:21:00.027946
662	P01230	t	f	t	f	f	35 lbs nov.xml	41902	73929.40027410924	65236	84844	2945879	443078	3388837	137263		2023-11-15 12:21:01.90487
663	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.071069263606	8268	95312	3540349	117949	3658298	419639		2023-11-15 12:21:04.263392
664	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.08824880887	16008	95700	9336148	597322	9937070	1242575		2023-11-15 12:21:05.027262
665	P01230	t	f	t	f	f	35 lbs nov.xml	41902	73929.40027410924	70236	84844	2945879	443078	3388837	137263		2023-11-15 12:21:06.898988
666	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.071069263606	13268	95312	3540349	117949	3658298	419639		2023-11-15 12:21:09.174563
667	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.08824880887	21008	95700	9336148	597322	9937070	1242575		2023-11-15 12:21:10.039762
668	P01230	t	f	t	f	f	35 lbs nov.xml	41902	73929.40027410924	75236	84844	2945879	443078	3388837	137263		2023-11-15 12:21:11.754693
669	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.076369264265	18268	95312	3540349	117949	3658298	419639		2023-11-15 12:21:14.179724
670	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.08824880887	26008	95700	9336148	597322	9937070	1242575		2023-11-15 12:21:15.058912
671	P01230	t	f	t	f	f	35 lbs nov.xml	41902	73929.41047411002	80236	84844	2945879	443078	3388837	137263		2023-11-15 12:21:16.916176
672	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.076369264265	23268	95312	3540349	117949	3658298	419643		2023-11-15 12:21:19.299154
673	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.08824880887	31008	95700	9336148	597322	9937070	1242575		2023-11-15 12:21:20.050707
674	P01230	t	f	t	f	f	35 lbs nov.xml	41903	73930.0703741344	380	84852	2945879	443078	3388837	137268		2023-11-15 12:21:21.995456
675	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.076369264265	28268	95312	3540349	117949	3658298	419643		2023-11-15 12:21:24.296486
676	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.08824880887	36008	95700	9336148	597322	9937070	1242575		2023-11-15 12:21:25.063696
677	P01230	t	f	t	f	f	35 lbs nov.xml	41903	73930.72767412217	5380	84852	2945879	443078	3388837	137268		2023-11-15 12:21:26.76541
678	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.076369264265	33268	95312	3540349	117949	3658298	419643		2023-11-15 12:21:29.212017
679	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.08824880887	41008	95700	9336148	597322	9937070	1242575		2023-11-15 12:21:30.076285
680	P01230	t	f	t	f	f	35 lbs nov.xml	41903	73930.73597412142	10380	84852	2945879	443078	3388837	137274		2023-11-15 12:21:31.930528
681	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.076369264265	38268	95312	3540349	117949	3658298	419643		2023-11-15 12:21:34.324271
682	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.08824880887	46008	95700	9336148	597322	9937070	1242575		2023-11-15 12:21:35.09636
683	P01230	t	f	t	f	f	35 lbs nov.xml	41903	73930.73647412333	15380	84852	2945879	443078	3388837	137274		2023-11-15 12:21:36.777676
684	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.076369264265	43268	95312	3540349	117949	3658298	419643		2023-11-15 12:21:39.331911
685	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.08824880887	51008	95700	9336148	597322	9937070	1242575		2023-11-15 12:21:40.096117
686	P01230	t	f	t	f	f	35 lbs nov.xml	41903	73930.74047412335	20380	84852	2945879	443078	3388837	137277		2023-11-15 12:21:41.779959
687	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.076369264265	48268	95312	3540349	117949	3658298	419643		2023-11-15 12:21:44.231849
688	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.08824880887	56008	95700	9336148	597322	9937070	1242575		2023-11-15 12:21:45.114946
689	P01230	t	f	t	f	f	35 lbs nov.xml	41903	73930.74047412335	25380	84852	2945879	443078	3388837	137277		2023-11-15 12:21:46.926857
690	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.076369264265	53268	95312	3540349	117949	3658298	419643		2023-11-15 12:21:49.23837
691	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.08824880887	61008	95700	9336148	597322	9937070	1242575		2023-11-15 12:21:50.116098
692	P01230	t	f	t	f	f	35 lbs nov.xml	41903	73930.74047412335	30380	84852	2945879	443078	3388837	137277		2023-11-15 12:21:51.933302
693	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.076369264265	58268	95312	3540349	117949	3658298	419643		2023-11-15 12:21:54.334177
694	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.08824880887	66008	95700	9336148	597322	9937070	1242575		2023-11-15 12:21:55.123965
695	P01230	t	f	t	f	f	35 lbs nov.xml	41903	73930.74047412335	35380	84852	2945879	443078	3388837	137277		2023-11-15 12:21:56.793248
696	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.076369264265	63268	95312	3540349	117949	3658298	419643		2023-11-15 12:21:59.246591
697	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.08824880887	71008	95700	9336148	597322	9937070	1242575		2023-11-15 12:22:00.129361
698	P01230	t	f	t	f	f	35 lbs nov.xml	41903	73930.74047412335	40380	84852	2945879	443078	3388837	137277		2023-11-15 12:22:01.953023
699	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.076369264265	68268	95312	3540349	117949	3658298	419643		2023-11-15 12:22:04.26222
700	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.08824880887	76008	95700	9336148	597322	9937070	1242575		2023-11-15 12:22:05.244426
701	P01230	t	f	t	f	f	35 lbs nov.xml	41903	73930.74047412335	45380	84852	2945879	443078	3388837	137277		2023-11-15 12:22:06.970046
702	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.076369264265	73268	95312	3540349	117949	3658298	419643		2023-11-15 12:22:09.269741
703	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.08824880887	81008	95700	9336148	597322	9937070	1242575		2023-11-15 12:22:10.146541
704	P01230	t	f	t	f	f	35 lbs nov.xml	41903	73930.74047412335	50380	84852	2945879	443078	3388837	137277		2023-11-15 12:22:11.814485
705	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.076369264265	78268	95312	3540349	117949	3658298	419643		2023-11-15 12:22:14.273078
706	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.08824880887	86008	95700	9336148	597322	9937070	1242575		2023-11-15 12:22:15.167593
707	P01230	t	f	t	f	f	35 lbs nov.xml	41903	73930.74047412335	55380	84852	2945879	443078	3388837	137277		2023-11-15 12:22:17.023467
708	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.076369264265	83268	95312	3540349	117949	3658298	419643		2023-11-15 12:22:19.365234
709	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87914	128119.1919488135	91008	95700	9336148	597322	9937070	1242575		2023-11-15 12:22:20.169465
710	P01230	t	f	t	f	f	35 lbs nov.xml	41903	73930.74047412335	60380	84852	2945879	443078	3388837	137277		2023-11-15 12:22:21.977714
711	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.076369264265	88268	95312	3540349	117949	3658298	419643		2023-11-15 12:22:24.377647
712	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128119.83814887151	316	95688	9336148	597322	9937070	1242580		2023-11-15 12:22:25.172319
713	P01230	t	f	t	f	f	35 lbs nov.xml	41903	73930.74047412335	65380	84852	2945879	443078	3388837	137277		2023-11-15 12:22:26.828027
714	P01229	t	f	t	f	f	10 lbs octubre.xml	30010	42157.68386925236	93268	95312	3540349	117949	3658298	419643		2023-11-15 12:22:29.290016
715	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.57084887223	5516	95688	9336148	597322	9937070	1242580		2023-11-15 12:22:30.184687
716	P01230	t	f	t	f	f	35 lbs nov.xml	41903	73930.74047412335	70380	84852	2945879	443078	3388837	137277		2023-11-15 12:22:31.840199
717	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.29126930727	3380	95084	3540349	117949	3658298	419648		2023-11-15 12:22:34.455611
718	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.57614887146	10516	95688	9336148	597322	9937070	1242585		2023-11-15 12:22:35.188174
719	P01230	t	f	t	f	f	35 lbs nov.xml	41903	73930.74047412335	75380	84852	2945879	443078	3388837	137277		2023-11-15 12:22:36.8449
720	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.64486931383	8380	95084	3540349	117949	3658298	419653		2023-11-15 12:22:39.409653
721	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.577048873	15516	95688	9336148	597322	9937070	1242585		2023-11-15 12:22:40.19698
722	P01230	t	f	t	f	f	35 lbs nov.xml	41903	73930.7666741203	80380	84852	2945879	443078	3388837	137277		2023-11-15 12:22:41.8531
723	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.64486931383	13380	95084	3540349	117949	3658298	419653		2023-11-15 12:22:44.427622
724	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.577048873	20516	95688	9336148	597322	9937070	1242588		2023-11-15 12:22:45.201559
725	P01230	t	f	t	f	f	35 lbs nov.xml	41904	73931.41457412178	460	84916	2945879	443078	3388837	137282		2023-11-15 12:22:47.085799
726	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.64976931438	18380	95084	3540349	117949	3658298	419653		2023-11-15 12:22:49.329131
727	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.577048873	25516	95688	9336148	597322	9937070	1242588		2023-11-15 12:22:50.20529
728	P01230	t	f	t	f	f	35 lbs nov.xml	41904	73932.07367413363	5460	84916	2945879	443078	3388837	137282		2023-11-15 12:22:52.015297
729	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.64976931438	23380	95084	3540349	117949	3658298	419656		2023-11-15 12:22:54.430054
730	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.577048873	30516	95688	9336148	597322	9937070	1242588		2023-11-15 12:22:55.219813
731	P01230	t	f	t	f	f	35 lbs nov.xml	41904	73932.07677413401	10460	84916	2945879	443078	3388837	137288		2023-11-15 12:22:56.877435
732	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.64976931438	28380	95084	3540349	117949	3658298	419656		2023-11-15 12:22:59.354653
733	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.577048873	35516	95688	9336148	597322	9937070	1242588		2023-11-15 12:23:00.237805
734	P01230	t	f	t	f	f	35 lbs nov.xml	41904	73932.0778741344	15460	84916	2945879	443078	3388837	137288		2023-11-15 12:23:01.888573
735	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.64976931438	33380	95084	3540349	117949	3658298	419656		2023-11-15 12:23:04.36065
736	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.577048873	40516	95688	9336148	597322	9937070	1242588		2023-11-15 12:23:05.240539
737	P01230	t	f	t	f	f	35 lbs nov.xml	41904	73932.08107413516	20460	84916	2945879	443078	3388837	137291		2023-11-15 12:23:07.054067
738	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.64976931438	38380	95084	3540349	117949	3658298	419656		2023-11-15 12:23:09.364818
739	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.577048873	45516	95688	9336148	597322	9937070	1242588		2023-11-15 12:23:10.247073
740	P01230	t	f	t	f	f	35 lbs nov.xml	41904	73932.08107413516	25460	84916	2945879	443078	3388837	137291		2023-11-15 12:23:11.903521
741	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.64976931438	43380	95084	3540349	117949	3658298	419656		2023-11-15 12:23:14.49489
742	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.577048873	50516	95688	9336148	597322	9937070	1242588		2023-11-15 12:23:15.24788
743	P01230	t	f	t	f	f	35 lbs nov.xml	41904	73932.08107413516	30660	84916	2945879	443078	3388837	137291		2023-11-15 12:23:17.124097
744	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.64976931438	48380	95084	3540349	117949	3658298	419656		2023-11-15 12:23:19.471705
745	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.577048873	55516	95688	9336148	597322	9937070	1242588		2023-11-15 12:23:20.253926
746	P01230	t	f	t	f	f	35 lbs nov.xml	41904	73932.08107413516	35660	84916	2945879	443078	3388837	137291		2023-11-15 12:23:21.923551
747	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.64976931438	53380	95084	3540349	117949	3658298	419656		2023-11-15 12:23:24.379253
748	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.577048873	60516	95688	9336148	597322	9937070	1242588		2023-11-15 12:23:25.260504
749	P01230	t	f	t	f	f	35 lbs nov.xml	41904	73932.08107413516	40660	84916	2945879	443078	3388837	137291		2023-11-15 12:23:26.923984
750	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.64976931438	58380	95084	3540349	117949	3658298	419656		2023-11-15 12:23:29.379484
751	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.577048873	65516	95688	9336148	597322	9937070	1242588		2023-11-15 12:23:30.259985
752	P01230	t	f	t	f	f	35 lbs nov.xml	41904	73932.08107413516	45660	84916	2945879	443078	3388837	137291		2023-11-15 12:23:31.929079
753	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.64976931438	63380	95084	3540349	117949	3658298	419656		2023-11-15 12:23:34.478375
754	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.577048873	70516	95688	9336148	597322	9937070	1242588		2023-11-15 12:23:35.270844
755	P01230	t	f	t	f	f	35 lbs nov.xml	41904	73932.08107413516	50660	84916	2945879	443078	3388837	137291		2023-11-15 12:23:37.15407
756	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.64976931438	68380	95084	3540349	117949	3658298	419656		2023-11-15 12:23:39.38659
757	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.577048873	75516	95688	9336148	597322	9937070	1242588		2023-11-15 12:23:40.270677
758	P01230	t	f	t	f	f	35 lbs nov.xml	41904	73932.08107413516	55660	84916	2945879	443078	3388837	137291		2023-11-15 12:23:41.948759
759	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.64976931438	73380	95084	3540349	117949	3658298	419656		2023-11-15 12:23:44.544574
760	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.577048873	80516	95688	9336148	597322	9937070	1242588		2023-11-15 12:23:45.280654
761	P01230	t	f	t	f	f	35 lbs nov.xml	41904	73932.08107413516	60660	84916	2945879	443078	3388837	137291		2023-11-15 12:23:47.107594
762	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.64976931438	78380	95084	3540349	117949	3658298	419656		2023-11-15 12:23:49.395284
763	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.577048873	85516	95688	9336148	597322	9937070	1242588		2023-11-15 12:23:50.291302
764	P01230	t	f	t	f	f	35 lbs nov.xml	41904	73932.08107413516	65660	84916	2945879	443078	3388837	137291		2023-11-15 12:23:52.116184
765	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.64976931438	83380	95084	3540349	117949	3658298	419656		2023-11-15 12:23:54.406577
766	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128120.59984887416	90516	95688	9336148	597322	9937070	1242588		2023-11-15 12:23:55.302668
767	P01230	t	f	t	f	f	35 lbs nov.xml	41904	73932.08107413516	70660	84916	2945879	443078	3388837	137291		2023-11-15 12:23:56.961759
768	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42158.64976931438	88380	95084	3540349	117949	3658298	419656		2023-11-15 12:23:59.407451
769	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87915	128121.32104889784	95516	95688	9336148	597322	9937070	1242593		2023-11-15 12:24:00.315233
770	P01230	t	f	t	f	f	35 lbs nov.xml	41904	73932.08107413516	75660	84916	2945879	443078	3388837	137291		2023-11-15 12:24:01.968015
771	P01229	t	f	t	f	f	10 lbs octubre.xml	30011	42159.25766930211	93380	95084	3540349	117949	3658298	419656		2023-11-15 12:24:04.505539
772	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.03574894818	4808	95704	9336148	597322	9937070	1242593		2023-11-15 12:24:05.327244
773	P01230	t	f	t	f	f	35 lbs nov.xml	41904	73932.13927413974	80660	84916	2945879	443078	3388837	137291		2023-11-15 12:24:07.138815
774	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42159.878669271595	3268	95108	3540349	117949	3658298	419662		2023-11-15 12:24:09.414452
775	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.06554894742	9808	95704	9336148	597322	9937070	1242599		2023-11-15 12:24:10.329558
776	P01230	t	f	t	f	f	35 lbs nov.xml	41905	73932.7631741717	756	84900	2945879	443078	3388837	137296		2023-11-15 12:24:11.979322
777	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.22056928978	8268	95108	3540349	117949	3658298	419667		2023-11-15 12:24:14.51092
778	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.06654895125	14808	95704	9336148	597322	9937070	1242599		2023-11-15 12:24:15.334295
779	P01230	t	f	t	f	f	35 lbs nov.xml	41905	73933.41687419731	5756	84900	2945879	443078	3388837	137302		2023-11-15 12:24:17.140354
780	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.22056928978	13268	95108	3540349	117949	3658298	419667		2023-11-15 12:24:19.523886
781	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.06654895125	19808	95704	9336148	597322	9937070	1242601		2023-11-15 12:24:20.335922
782	P01230	t	f	t	f	f	35 lbs nov.xml	41905	73933.41687419731	10756	84900	2945879	443078	3388837	137302		2023-11-15 12:24:21.998475
783	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.2254692913	18268	95108	3540349	117949	3658298	419667		2023-11-15 12:24:24.439148
784	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.06654895125	24808	95704	9336148	597322	9937070	1242601		2023-11-15 12:24:25.335923
785	P01230	t	f	t	f	f	35 lbs nov.xml	41905	73933.4193741973	15756	84900	2945879	443078	3388837	137302		2023-11-15 12:24:27.008327
786	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.2254692913	23268	95108	3540349	117949	3658298	419670		2023-11-15 12:24:29.445758
787	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.06654895125	29808	95704	9336148	597322	9937070	1242601		2023-11-15 12:24:30.342173
788	P01230	t	f	t	f	f	35 lbs nov.xml	41905	73933.42077420074	20756	84900	2945879	443078	3388837	137305		2023-11-15 12:24:32.167831
789	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.2254692913	28268	95108	3540349	117949	3658298	419670		2023-11-15 12:24:34.549115
790	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.06654895125	34808	95704	9336148	597322	9937070	1242601		2023-11-15 12:24:35.348609
791	P01230	t	f	t	f	f	35 lbs nov.xml	41905	73933.42077420074	25756	84900	2945879	443078	3388837	137305		2023-11-15 12:24:37.1838
792	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.2254692913	33268	95108	3540349	117949	3658298	419670		2023-11-15 12:24:39.454718
793	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.06654895125	39808	95704	9336148	597322	9937070	1242601		2023-11-15 12:24:40.350034
794	P01230	t	f	t	f	f	35 lbs nov.xml	41905	73933.42077420074	30756	84900	2945879	443078	3388837	137305		2023-11-15 12:24:42.028611
795	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.2254692913	38268	95108	3540349	117949	3658298	419670		2023-11-15 12:24:44.561468
796	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.06654895125	44808	95704	9336148	597322	9937070	1242601		2023-11-15 12:24:45.3588
797	P01230	t	f	t	f	f	35 lbs nov.xml	41905	73933.42077420074	35756	84900	2945879	443078	3388837	137305		2023-11-15 12:24:47.194542
798	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.2254692913	43268	95108	3540349	117949	3658298	419670		2023-11-15 12:24:49.473986
799	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.06654895125	49808	95704	9336148	597322	9937070	1242601		2023-11-15 12:24:50.369704
800	P01230	t	f	t	f	f	35 lbs nov.xml	41905	73933.42077420074	40756	84900	2945879	443078	3388837	137305		2023-11-15 12:24:52.199415
801	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.2254692913	48268	95108	3540349	117949	3658298	419670		2023-11-15 12:24:54.489229
802	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.06654895125	55008	95704	9336148	597322	9937070	1242601		2023-11-15 12:24:55.386766
803	P01230	t	f	t	f	f	35 lbs nov.xml	41905	73933.42077420074	45756	84900	2945879	443078	3388837	137305		2023-11-15 12:24:57.041995
804	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.2254692913	53268	95108	3540349	117949	3658298	419670		2023-11-15 12:24:59.591428
805	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.06654895125	60008	95704	9336148	597322	9937070	1242601		2023-11-15 12:25:00.397947
806	P01230	t	f	t	f	f	35 lbs nov.xml	41905	73933.42077420074	50756	84900	2945879	443078	3388837	137305		2023-11-15 12:25:02.046328
807	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.2254692913	58268	95108	3540349	117949	3658298	419670		2023-11-15 12:25:04.592694
808	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.06654895125	65008	95704	9336148	597322	9937070	1242601		2023-11-15 12:25:05.396676
809	P01230	t	f	t	f	f	35 lbs nov.xml	41905	73933.42077420074	55756	84900	2945879	443078	3388837	137305		2023-11-15 12:25:07.22066
810	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.2254692913	63468	95108	3540349	117949	3658298	419670		2023-11-15 12:25:09.494918
811	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.06654895125	70008	95704	9336148	597322	9937070	1242601		2023-11-15 12:25:10.402933
812	P01230	t	f	t	f	f	35 lbs nov.xml	41905	73933.42077420074	60756	84900	2945879	443078	3388837	137305		2023-11-15 12:25:12.074253
813	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.2254692913	68468	95108	3540349	117949	3658298	419670		2023-11-15 12:25:14.600479
814	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.06654895125	75008	95704	9336148	597322	9937070	1242601		2023-11-15 12:25:15.403521
815	P01230	t	f	t	f	f	35 lbs nov.xml	41905	73933.42077420074	65756	84900	2945879	443078	3388837	137305		2023-11-15 12:25:17.083594
816	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.2254692913	73468	95108	3540349	117949	3658298	419670		2023-11-15 12:25:19.61008
817	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.06654895125	80008	95704	9336148	597322	9937070	1242601		2023-11-15 12:25:20.411704
818	P01230	t	f	t	f	f	35 lbs nov.xml	41905	73933.42077420074	70756	84900	2945879	443078	3388837	137305		2023-11-15 12:25:22.100267
819	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.2254692913	78468	95108	3540349	117949	3658298	419670		2023-11-15 12:25:24.519786
820	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.06654895125	85008	95704	9336148	597322	9937070	1242601		2023-11-15 12:25:25.415467
821	P01230	t	f	t	f	f	35 lbs nov.xml	41905	73933.42077420074	75756	84900	2945879	443078	3388837	137305		2023-11-15 12:25:27.097648
822	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.2254692913	83468	95108	3540349	117949	3658298	419670		2023-11-15 12:25:29.534735
823	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.06694895087	90008	95704	9336148	597322	9937070	1242601		2023-11-15 12:25:30.416748
824	P01230	t	f	t	f	f	35 lbs nov.xml	41905	73933.53437420494	80956	84900	2945879	443078	3388837	137305		2023-11-15 12:25:32.270426
825	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.2254692913	88468	95108	3540349	117949	3658298	419670		2023-11-15 12:25:34.635085
826	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87916	128122.79424895206	95008	95704	9336148	597322	9937070	1242601		2023-11-15 12:25:35.42386
827	P01230	t	f	t	f	f	35 lbs nov.xml	41906	73934.14117420028	1160	84792	2945879	443078	3388837	137310		2023-11-15 12:25:37.353603
828	P01229	t	f	t	f	f	10 lbs octubre.xml	30012	42160.868669291594	93468	95108	3540349	117949	3658298	419670		2023-11-15 12:25:39.547338
829	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.49194889177	4308	95696	9336148	597322	9937070	1242607		2023-11-15 12:25:40.428739
830	P01230	t	f	t	f	f	35 lbs nov.xml	41906	73934.75657416365	6160	84792	2945879	443078	3388837	137315		2023-11-15 12:25:42.128739
831	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.48066926107	3496	94968	3540349	117949	3658298	419676		2023-11-15 12:25:44.550648
832	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.55504889213	9308	95696	9336148	597322	9937070	1242613		2023-11-15 12:25:45.433999
833	P01230	t	f	t	f	f	35 lbs nov.xml	41906	73934.75657416365	11160	84792	2945879	443078	3388837	137315		2023-11-15 12:25:47.341276
834	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.79726925525	8496	94968	3540349	117949	3658298	419681		2023-11-15 12:25:49.55573
835	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.55584889329	14308	95696	9336148	597322	9937070	1242613		2023-11-15 12:25:50.437585
836	P01230	t	f	t	f	f	35 lbs nov.xml	41906	73934.76017416596	16160	84792	2945879	443078	3388837	137315		2023-11-15 12:25:52.302467
837	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.79726925525	13496	94968	3540349	117949	3658298	419681		2023-11-15 12:25:54.562201
838	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.55584889329	19308	95696	9336148	597322	9937070	1242616		2023-11-15 12:25:55.443727
839	P01230	t	f	t	f	f	35 lbs nov.xml	41906	73934.76087416674	21160	84792	2945879	443078	3388837	137318		2023-11-15 12:25:57.157303
840	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.80226925619	18496	94968	3540349	117949	3658298	419681		2023-11-15 12:25:59.656239
841	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.55584889329	24308	95696	9336148	597322	9937070	1242616		2023-11-15 12:26:00.447784
842	P01230	t	f	t	f	f	35 lbs nov.xml	41906	73934.76087416674	26160	84792	2945879	443078	3388837	137318		2023-11-15 12:26:02.157455
843	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.80226925619	23496	94968	3540349	117949	3658298	419684		2023-11-15 12:26:04.673865
844	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.55584889329	29308	95696	9336148	597322	9937070	1242616		2023-11-15 12:26:05.456588
845	P01230	t	f	t	f	f	35 lbs nov.xml	41906	73934.76087416674	31160	84792	2945879	443078	3388837	137318		2023-11-15 12:26:07.275776
846	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.80226925619	28496	94968	3540349	117949	3658298	419684		2023-11-15 12:26:09.591424
847	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.55584889329	34308	95696	9336148	597322	9937070	1242616		2023-11-15 12:26:10.49883
848	P01230	t	f	t	f	f	35 lbs nov.xml	41906	73934.76087416674	36160	84792	2945879	443078	3388837	137318		2023-11-15 12:26:12.181193
849	P01229	f	t	f	f	f	10 lbs octubre.xml	30013	42161.80226925619	33360	94968	3542567	117949	3660516	419684		2023-11-15 12:26:14.694265
850	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.55584889329	39308	95696	9336148	597322	9937070	1242616		2023-11-15 12:26:15.500127
851	P01230	t	f	t	f	f	35 lbs nov.xml	41906	73934.76087416674	41160	84792	2945879	443078	3388837	137318		2023-11-15 12:26:17.186942
852	P01229	f	t	f	f	f	10 lbs octubre.xml	30013	42161.80226925619	33360	94968	3542567	117949	3660516	419684		2023-11-15 12:26:19.704739
853	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.55584889329	44308	95696	9336148	597322	9937070	1242616		2023-11-15 12:26:20.512425
854	P01230	t	f	t	f	f	35 lbs nov.xml	41906	73934.76087416674	46160	84792	2945879	443078	3388837	137318		2023-11-15 12:26:22.194441
855	P01229	f	t	f	f	f	10 lbs octubre.xml	30013	42161.80226925619	33360	94968	3542567	117949	3660516	419684		2023-11-15 12:26:24.620699
856	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.55584889329	49308	95696	9336148	597322	9937070	1242616		2023-11-15 12:26:25.522501
857	P01230	t	f	t	f	f	35 lbs nov.xml	41906	73934.76087416674	51160	84792	2945879	443078	3388837	137318		2023-11-15 12:26:27.20226
858	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.80226925619	35816	94968	3542567	117949	3660516	419684		2023-11-15 12:26:29.623782
859	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.55584889329	54308	95696	9336148	597322	9937070	1242616		2023-11-15 12:26:30.516559
860	P01230	t	f	t	f	f	35 lbs nov.xml	41906	73934.76087416674	56160	84792	2945879	443078	3388837	137318		2023-11-15 12:26:32.363768
861	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.80226925619	40816	94968	3542567	117949	3660516	419684		2023-11-15 12:26:34.724859
862	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.55584889329	59308	95696	9336148	597322	9937070	1242616		2023-11-15 12:26:35.524557
863	P01230	t	f	t	f	f	35 lbs nov.xml	41906	73934.76087416674	61160	84792	2945879	443078	3388837	137318		2023-11-15 12:26:37.360501
864	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.80226925619	45816	94968	3542567	117949	3660516	419684		2023-11-15 12:26:39.628901
865	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.55584889329	64308	95696	9336148	597322	9937070	1242616		2023-11-15 12:26:40.541203
866	P01230	t	f	t	f	f	35 lbs nov.xml	41906	73934.76087416674	66160	84792	2945879	443078	3388837	137318		2023-11-15 12:26:42.209468
867	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.80226925619	50816	94968	3542567	117949	3660516	419684		2023-11-15 12:26:44.635191
868	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.55584889329	69308	95696	9336148	597322	9937070	1242616		2023-11-15 12:26:45.545303
869	P01230	t	f	t	f	f	35 lbs nov.xml	41906	73934.76087416674	71160	84792	2945879	443078	3388837	137318		2023-11-15 12:26:47.365964
870	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.80226925619	55816	94968	3542567	117949	3660516	419684		2023-11-15 12:26:49.637392
871	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.55584889329	74308	95696	9336148	597322	9937070	1242616		2023-11-15 12:26:50.548123
872	P01230	t	f	t	f	f	35 lbs nov.xml	41906	73934.76087416674	76160	84792	2945879	443078	3388837	137318		2023-11-15 12:26:52.357208
873	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.80226925619	60816	94968	3542567	117949	3660516	419684		2023-11-15 12:26:54.64154
874	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.55584889329	79308	95696	9336148	597322	9937070	1242616		2023-11-15 12:26:55.54923
875	P01230	t	f	t	f	f	35 lbs nov.xml	41906	73934.94737417629	81160	84792	2945879	443078	3388837	137318		2023-11-15 12:26:57.221431
876	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.80226925619	65816	94968	3542567	117949	3660516	419684		2023-11-15 12:26:59.74535
877	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.55584889329	84308	95696	9336148	597322	9937070	1242616		2023-11-15 12:27:00.562083
878	P01230	t	f	t	f	f	35 lbs nov.xml	41907	73935.53297416706	1376	84780	2945879	443078	3388837	137324		2023-11-15 12:27:02.213642
879	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.80226925619	70816	94968	3542567	117949	3660516	419684		2023-11-15 12:27:04.74605
880	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128123.55584889329	89508	95696	9336148	597322	9937070	1242616		2023-11-15 12:27:05.599893
881	P01230	t	f	t	f	f	35 lbs nov.xml	41907	73936.09627414345	6376	84780	2945879	443078	3388837	137329		2023-11-15 12:27:07.216653
882	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.80226925619	75816	94968	3542567	117949	3660516	419684		2023-11-15 12:27:09.661734
883	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87917	128124.25884889335	94508	95696	9336148	597322	9937070	1242616		2023-11-15 12:27:10.605932
884	P01230	t	f	t	f	f	35 lbs nov.xml	41907	73936.09627414345	11376	84780	2945879	443078	3388837	137329		2023-11-15 12:27:12.218638
885	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.80226925619	80816	94968	3542567	117949	3660516	419684		2023-11-15 12:27:14.763459
886	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128124.91304895133	3788	95716	9336148	597322	9937070	1242621		2023-11-15 12:27:15.615756
887	P01230	t	f	t	f	f	35 lbs nov.xml	41907	73936.10097414424	16376	84780	2945879	443078	3388837	137329		2023-11-15 12:27:17.373489
888	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.80226925619	85816	94968	3542567	117949	3660516	419684		2023-11-15 12:27:19.765928
889	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.04454894182	8788	95716	9336148	597322	9937070	1242626		2023-11-15 12:27:20.623199
890	P01230	t	f	t	f	f	35 lbs nov.xml	41907	73936.10107414462	21376	84780	2945879	443078	3388837	137333		2023-11-15 12:27:22.239588
891	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.80226925619	90816	94968	3542567	117949	3660516	419684		2023-11-15 12:27:24.679655
892	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.04494894145	13788	95716	9336148	597322	9937070	1242626		2023-11-15 12:27:25.627141
893	P01230	t	f	t	f	f	35 lbs nov.xml	41907	73936.10107414462	26376	84780	2945879	443078	3388837	137333		2023-11-15 12:27:27.248004
894	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42161.80226925619	95816	94968	3542567	117949	3660516	419684		2023-11-15 12:27:29.685986
895	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.04544894146	18788	95716	9336148	597322	9937070	1242629		2023-11-15 12:27:30.626535
896	P01230	t	f	t	f	f	35 lbs nov.xml	41907	73936.10107414462	31376	84780	2945879	443078	3388837	137333		2023-11-15 12:27:32.405453
897	P01229	t	f	t	f	f	10 lbs octubre.xml	30013	42162.455969257	100816	94968	3542567	117949	3660516	419684		2023-11-15 12:27:34.689476
898	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.04544894146	23788	95716	9336148	597322	9937070	1242629		2023-11-15 12:27:35.631774
899	P01230	t	f	t	f	f	35 lbs nov.xml	41907	73936.10107414462	36376	84780	2945879	443078	3388837	137333		2023-11-15 12:27:37.426008
900	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.08046937904	3648	102364	3542567	117949	3660516	419690		2023-11-15 12:27:39.698032
901	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.04544894146	28788	95716	9336148	597322	9937070	1242629		2023-11-15 12:27:40.642437
902	P01230	t	f	t	f	f	35 lbs nov.xml	41907	73936.10107414462	41376	84780	2945879	443078	3388837	137333		2023-11-15 12:27:42.277426
903	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.37236936718	8648	102364	3542567	117949	3660516	419695		2023-11-15 12:27:44.787222
904	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.04544894146	33788	95716	9336148	597322	9937070	1242629		2023-11-15 12:27:45.644813
905	P01230	t	f	t	f	f	35 lbs nov.xml	41907	73936.10107414462	46376	84780	2945879	443078	3388837	137333		2023-11-15 12:27:47.443177
906	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.37236936718	13648	102364	3542567	117949	3660516	419695		2023-11-15 12:27:49.699787
907	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.04544894146	38788	95716	9336148	597322	9937070	1242629		2023-11-15 12:27:50.642486
908	P01230	t	f	t	f	f	35 lbs nov.xml	41907	73936.10107414462	51376	84780	2945879	443078	3388837	137333		2023-11-15 12:27:52.45068
909	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.37696936754	18648	102364	3542567	117949	3660516	419695		2023-11-15 12:27:54.70344
910	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.04544894146	43788	95716	9336148	597322	9937070	1242629		2023-11-15 12:27:55.645303
911	P01230	t	f	t	f	f	35 lbs nov.xml	41907	73936.10107414462	56376	84780	2945879	443078	3388837	137333		2023-11-15 12:27:57.302802
912	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.37696936754	23648	102364	3542567	117949	3660516	419698		2023-11-15 12:27:59.799804
913	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.04544894146	48788	95716	9336148	597322	9937070	1242629		2023-11-15 12:28:00.674554
914	P01230	t	f	t	f	f	35 lbs nov.xml	41907	73936.10107414462	61376	84780	2945879	443078	3388837	137333		2023-11-15 12:28:02.30668
915	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.37696936754	28648	102364	3542567	117949	3660516	419698		2023-11-15 12:28:04.910288
916	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.04544894146	53788	95716	9336148	597322	9937070	1242629		2023-11-15 12:28:05.668474
917	P01230	t	f	t	f	f	35 lbs nov.xml	41907	73936.10107414462	66576	84780	2945879	443078	3388837	137333		2023-11-15 12:28:07.322366
918	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.37696936754	33648	102364	3542567	117949	3660516	419698		2023-11-15 12:28:09.723333
919	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.04544894146	58788	95716	9336148	597322	9937070	1242629		2023-11-15 12:28:10.683155
920	P01230	t	f	t	f	f	35 lbs nov.xml	41907	73936.10107414462	71576	84780	2945879	443078	3388837	137333		2023-11-15 12:28:12.320411
921	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.37696936754	38648	102364	3542567	117949	3660516	419698		2023-11-15 12:28:14.833513
922	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.04544894146	63788	95716	9336148	597322	9937070	1242629		2023-11-15 12:28:15.693975
923	P01230	t	f	t	f	f	35 lbs nov.xml	41907	73936.10107414462	76576	84780	2945879	443078	3388837	137333		2023-11-15 12:28:17.48088
924	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.37696936754	43648	102364	3542567	117949	3660516	419698		2023-11-15 12:28:19.842779
925	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.04544894146	68788	95716	9336148	597322	9937070	1242629		2023-11-15 12:28:20.698777
926	P01230	t	f	t	f	f	35 lbs nov.xml	41907	73936.32487413242	81576	84780	2945879	443078	3388837	137333		2023-11-15 12:28:22.332195
927	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.37696936754	48648	102364	3542567	117949	3660516	419698		2023-11-15 12:28:24.758335
928	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.04544894146	73788	95716	9336148	597322	9937070	1242629		2023-11-15 12:28:25.703577
929	P01230	t	f	t	f	f	35 lbs nov.xml	41908	73936.92147423	1672	84900	2945879	443078	3388837	137338		2023-11-15 12:28:27.334377
930	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.37696936754	53648	102364	3542567	117949	3660516	419698		2023-11-15 12:28:29.76541
931	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.04544894146	78788	95716	9336148	597322	9937070	1242629		2023-11-15 12:28:30.705563
932	P01230	t	f	t	f	f	35 lbs nov.xml	41908	73937.43557423039	6672	84900	2945879	443078	3388837	137343		2023-11-15 12:28:32.587764
933	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.37696936754	58648	102364	3542567	117949	3660516	419698		2023-11-15 12:28:34.766703
934	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.04544894146	83788	95716	9336148	597322	9937070	1242629		2023-11-15 12:28:35.709192
935	P01230	t	f	t	f	f	35 lbs nov.xml	41908	73937.43557423039	11672	84900	2945879	443078	3388837	137343		2023-11-15 12:28:37.505948
936	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.37696936754	63648	102364	3542567	117949	3660516	419698		2023-11-15 12:28:39.774111
937	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.04544894146	88788	95716	9336148	597322	9937070	1242629		2023-11-15 12:28:40.718733
938	P01230	t	f	t	f	f	35 lbs nov.xml	41908	73937.44017423269	16672	84900	2945879	443078	3388837	137343		2023-11-15 12:28:42.350059
939	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.37696936754	68648	102364	3542567	117949	3660516	419698		2023-11-15 12:28:44.876118
940	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87918	128125.69354894182	93788	95716	9336148	597322	9937070	1242629		2023-11-15 12:28:45.733387
941	P01230	t	f	t	f	f	35 lbs nov.xml	41908	73937.44017423269	21672	84900	2945879	443078	3388837	137347		2023-11-15 12:28:47.505957
942	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.37696936754	73648	102364	3542567	117949	3660516	419698		2023-11-15 12:28:49.796095
943	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.29224892349	3100	95684	9336148	597322	9937070	1242634		2023-11-15 12:28:50.732879
944	P01230	t	f	t	f	f	35 lbs nov.xml	41908	73937.44017423269	26672	84900	2945879	443078	3388837	137347		2023-11-15 12:28:52.508729
945	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.37696936754	78648	102364	3542567	117949	3660516	419698		2023-11-15 12:28:54.802127
946	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.53444891663	8100	95684	9336148	597322	9937070	1242640		2023-11-15 12:28:55.745956
947	P01230	t	f	t	f	f	35 lbs nov.xml	41908	73937.44017423269	31672	84900	2945879	443078	3388837	137347		2023-11-15 12:28:57.356286
948	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.37696936754	83648	102364	3542567	117949	3660516	419698		2023-11-15 12:28:59.899387
949	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.53444891663	13100	95684	9336148	597322	9937070	1242640		2023-11-15 12:29:00.749209
950	P01230	t	f	t	f	f	35 lbs nov.xml	41908	73937.44017423269	36672	84900	2945879	443078	3388837	137347		2023-11-15 12:29:02.370832
951	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42163.37696936754	88648	102364	3542567	117949	3660516	419698		2023-11-15 12:29:04.910727
952	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.53524891779	18100	95684	9336148	597322	9937070	1242642		2023-11-15 12:29:05.769651
953	P01230	t	f	t	f	f	35 lbs nov.xml	41908	73937.44017423269	41672	84900	2945879	443078	3388837	137347		2023-11-15 12:29:07.535732
954	P01229	t	f	t	f	f	10 lbs octubre.xml	30014	42164.031469356116	93648	102364	3542567	117949	3660516	419698		2023-11-15 12:29:09.826642
955	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.53524891779	23100	95684	9336148	597322	9937070	1242642		2023-11-15 12:29:10.770252
956	P01230	t	f	t	f	f	35 lbs nov.xml	41908	73937.44017423269	46672	84900	2945879	443078	3388837	137347		2023-11-15 12:29:12.573434
957	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.64486938051	3464	95180	3542567	117949	3660516	419704		2023-11-15 12:29:14.985223
958	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.53524891779	28300	95684	9336148	597322	9937070	1242642		2023-11-15 12:29:15.783154
959	P01230	t	f	t	f	f	35 lbs nov.xml	41908	73937.44017423269	51672	84900	2945879	443078	3388837	137347		2023-11-15 12:29:17.567491
960	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.94936938047	8464	95180	3542567	117949	3660516	419710		2023-11-15 12:29:19.938569
961	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.53524891779	33300	95684	9336148	597322	9937070	1242642		2023-11-15 12:29:20.787755
962	P01230	t	f	t	f	f	35 lbs nov.xml	41908	73937.44017423269	56672	84900	2945879	443078	3388837	137347		2023-11-15 12:29:22.412541
963	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.94936938047	13464	95180	3542567	117949	3660516	419710		2023-11-15 12:29:24.851231
964	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.53524891779	38300	95684	9336148	597322	9937070	1242642		2023-11-15 12:29:25.794599
965	P01230	t	f	t	f	f	35 lbs nov.xml	41908	73937.44017423269	61672	84900	2945879	443078	3388837	137347		2023-11-15 12:29:27.617752
966	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.95436938142	18464	95180	3542567	117949	3660516	419713		2023-11-15 12:29:29.967689
967	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.53524891779	43300	95684	9336148	597322	9937070	1242642		2023-11-15 12:29:30.804643
968	P01230	t	f	t	f	f	35 lbs nov.xml	41908	73937.44017423269	66672	84900	2945879	443078	3388837	137347		2023-11-15 12:29:32.567846
969	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.95436938142	23464	95180	3542567	117949	3660516	419713		2023-11-15 12:29:34.97456
970	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.53524891779	48300	95684	9336148	597322	9937070	1242642		2023-11-15 12:29:35.814405
971	P01230	t	f	t	f	f	35 lbs nov.xml	41908	73937.44017423269	71672	84900	2945879	443078	3388837	137347		2023-11-15 12:29:37.595662
972	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.95436938142	28464	95180	3542567	117949	3660516	419713		2023-11-15 12:29:39.885034
973	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.53524891779	53300	95684	9336148	597322	9937070	1242642		2023-11-15 12:29:40.825769
974	P01230	t	f	t	f	f	35 lbs nov.xml	41908	73937.44017423269	76672	84900	2945879	443078	3388837	137347		2023-11-15 12:29:42.432834
975	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.95436938142	33464	95180	3542567	117949	3660516	419713		2023-11-15 12:29:44.985071
976	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.53524891779	58300	95684	9336148	597322	9937070	1242642		2023-11-15 12:29:45.833896
977	P01230	t	f	t	f	f	35 lbs nov.xml	41908	73937.70047422814	81672	84900	2945879	443078	3388837	137347		2023-11-15 12:29:47.59405
978	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.95436938142	38664	95180	3542567	117949	3660516	419713		2023-11-15 12:29:49.902597
979	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.53524891779	63300	95684	9336148	597322	9937070	1242642		2023-11-15 12:29:50.843901
980	P01230	t	f	t	f	f	35 lbs nov.xml	41909	73938.3097742159	1776	84892	2945879	443078	3388837	137352		2023-11-15 12:29:52.439701
981	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.95436938142	43664	95180	3542567	117949	3660516	419713		2023-11-15 12:29:54.915173
982	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.53524891779	68300	95684	9336148	597322	9937070	1242642		2023-11-15 12:29:55.841204
983	P01230	t	f	t	f	f	35 lbs nov.xml	41909	73938.77477421025	6776	84892	2945879	443078	3388837	137357		2023-11-15 12:29:57.602125
984	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.95436938142	48664	95180	3542567	117949	3660516	419713		2023-11-15 12:30:00.010565
985	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.53524891779	73300	95684	9336148	597322	9937070	1242642		2023-11-15 12:30:00.848306
986	P01230	t	f	t	f	f	35 lbs nov.xml	41909	73938.77477421025	11776	84892	2945879	443078	3388837	137357		2023-11-15 12:30:02.455255
987	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.95436938142	53664	95180	3542567	117949	3660516	419713		2023-11-15 12:30:05.02772
988	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.53524891779	78300	95684	9336148	597322	9937070	1242642		2023-11-15 12:30:05.854742
989	P01230	t	f	t	f	f	35 lbs nov.xml	41909	73938.77967421371	16776	84892	2945879	443078	3388837	137357		2023-11-15 12:30:07.460678
990	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.95436938142	58664	95180	3542567	117949	3660516	419713		2023-11-15 12:30:09.945123
991	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.53524891779	83300	95684	9336148	597322	9937070	1242642		2023-11-15 12:30:10.861465
992	P01230	t	f	t	f	f	35 lbs nov.xml	41909	73938.77967421371	21776	84892	2945879	443078	3388837	137361		2023-11-15 12:30:12.679766
993	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.95436938142	63664	95180	3542567	117949	3660516	419713		2023-11-15 12:30:15.036807
994	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128126.53524891779	88300	95684	9336148	597322	9937070	1242642		2023-11-15 12:30:15.871468
995	P01230	t	f	t	f	f	35 lbs nov.xml	41909	73938.77967421371	26776	84892	2945879	443078	3388837	137361		2023-11-15 12:30:17.613009
996	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.95436938142	68664	95180	3542567	117949	3660516	419713		2023-11-15 12:30:19.952268
997	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87919	128127.0927489178	93300	95684	9336148	597322	9937070	1242642		2023-11-15 12:30:20.880363
998	P01230	t	f	t	f	f	35 lbs nov.xml	41909	73938.77967421371	31776	84892	2945879	443078	3388837	137361		2023-11-15 12:30:22.462858
999	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.95436938142	73664	95180	3542567	117949	3660516	419713		2023-11-15 12:30:24.967142
1000	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128127.67154887503	2604	95692	9336148	597322	9937070	1242648		2023-11-15 12:30:25.891488
1001	P01230	t	f	t	f	f	35 lbs nov.xml	41909	73938.77967421371	36776	84892	2945879	443078	3388837	137361		2023-11-15 12:30:27.70849
1002	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.95436938142	78664	95180	3542567	117949	3660516	419713		2023-11-15 12:30:29.974475
1003	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.02354886934	7604	95692	9336148	597322	9937070	1242654		2023-11-15 12:30:30.898518
1004	P01230	t	f	t	f	f	35 lbs nov.xml	41909	73938.77967421371	41776	84892	2945879	443078	3388837	137361		2023-11-15 12:30:32.623231
1005	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.95436938142	83664	95180	3542567	117949	3660516	419713		2023-11-15 12:30:35.063125
1006	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.02354886934	12604	95692	9336148	597322	9937070	1242654		2023-11-15 12:30:35.90836
1007	P01230	t	f	t	f	f	35 lbs nov.xml	41909	73938.77967421371	46776	84892	2945879	443078	3388837	137361		2023-11-15 12:30:37.483378
1008	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42164.95436938142	88664	95180	3542567	117949	3660516	419713		2023-11-15 12:30:39.980742
1009	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.02434887241	17604	95692	9336148	597322	9937070	1242657		2023-11-15 12:30:40.920192
1010	P01230	t	f	t	f	f	35 lbs nov.xml	41909	73938.77967421371	51776	84892	2945879	443078	3388837	137361		2023-11-15 12:30:42.493559
1011	P01229	t	f	t	f	f	10 lbs octubre.xml	30015	42165.628569393644	93664	95180	3542567	117949	3660516	419713		2023-11-15 12:30:45.080329
1012	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.02434887241	22604	95692	9336148	597322	9937070	1242657		2023-11-15 12:30:45.931625
1013	P01230	t	f	t	f	f	35 lbs nov.xml	41909	73938.77967421371	56776	84892	2945879	443078	3388837	137361		2023-11-15 12:30:47.493299
1014	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.24486944243	3620	95040	3542567	117949	3660516	419719		2023-11-15 12:30:50.189353
1015	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.02434887241	27604	95692	9336148	597322	9937070	1242657		2023-11-15 12:30:50.944524
1016	P01230	t	f	t	f	f	35 lbs nov.xml	41909	73938.77967421371	61776	84892	2945879	443078	3388837	137361		2023-11-15 12:30:52.500764
1017	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.524169442615	8620	95040	3542567	117949	3660516	419725		2023-11-15 12:30:55.000737
1018	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.02434887241	32604	95692	9336148	597322	9937070	1242657		2023-11-15 12:30:55.959191
1019	P01230	t	f	t	f	f	35 lbs nov.xml	41909	73938.77967421371	66976	84892	2945879	443078	3388837	137361		2023-11-15 12:30:57.671526
1020	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.524169442615	13620	95040	3542567	117949	3660516	419725		2023-11-15 12:31:00.107771
1021	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.02434887241	37604	95692	9336148	597322	9937070	1242657		2023-11-15 12:31:00.963808
1022	P01230	t	f	t	f	f	35 lbs nov.xml	41909	73938.77967421371	71976	84892	2945879	443078	3388837	137361		2023-11-15 12:31:02.523847
1023	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.52936944338	18620	95040	3542567	117949	3660516	419725		2023-11-15 12:31:05.102111
1024	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.02434887241	42604	95692	9336148	597322	9937070	1242657		2023-11-15 12:31:05.969927
1025	P01230	t	f	t	f	f	35 lbs nov.xml	41909	73938.77967421371	76976	84892	2945879	443078	3388837	137361		2023-11-15 12:31:07.535532
1026	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.52936944338	23620	95040	3542567	117949	3660516	419729		2023-11-15 12:31:10.013779
1027	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.02434887241	47604	95692	9336148	597322	9937070	1242657		2023-11-15 12:31:10.986588
1028	P01230	t	f	t	f	f	35 lbs nov.xml	41909	73939.0884742034	81976	84892	2945879	443078	3388837	137361		2023-11-15 12:31:12.697528
1029	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.52936944338	28620	95040	3542567	117949	3660516	419729		2023-11-15 12:31:15.026081
1030	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.02434887241	52804	95692	9336148	597322	9937070	1242657		2023-11-15 12:31:15.996103
1031	P01230	t	f	t	f	f	35 lbs nov.xml	41910	73939.68667418507	2104	84868	2945879	443078	3388837	137366		2023-11-15 12:31:17.758155
1032	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.52936944338	33620	95040	3542567	117949	3660516	419729		2023-11-15 12:31:20.039223
1033	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.02434887241	57804	95692	9336148	597322	9937070	1242657		2023-11-15 12:31:21.015029
1034	P01230	t	f	t	f	f	35 lbs nov.xml	41910	73940.11507417896	7104	84868	2945879	443078	3388837	137372		2023-11-15 12:31:22.554986
1035	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.52936944338	38620	95040	3542567	117949	3660516	419729		2023-11-15 12:31:25.042082
1036	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.02434887241	62804	95692	9336148	597322	9937070	1242657		2023-11-15 12:31:26.017068
1037	P01230	t	f	t	f	f	35 lbs nov.xml	41910	73940.11507417896	12104	84868	2945879	443078	3388837	137372		2023-11-15 12:31:27.711282
1038	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.52936944338	43620	95040	3542567	117949	3660516	419729		2023-11-15 12:31:30.160673
1039	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.02434887241	67804	95692	9336148	597322	9937070	1242657		2023-11-15 12:31:31.027587
1040	P01230	t	f	t	f	f	35 lbs nov.xml	41910	73940.11997418241	17104	84868	2945879	443078	3388837	137372		2023-11-15 12:31:32.736009
1041	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.52936944338	48620	95040	3542567	117949	3660516	419729		2023-11-15 12:31:35.159369
1042	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.02434887241	72804	95692	9336148	597322	9937070	1242657		2023-11-15 12:31:36.039379
1043	P01230	t	f	t	f	f	35 lbs nov.xml	41910	73940.11997418241	22104	84868	2945879	443078	3388837	137375		2023-11-15 12:31:37.584832
1044	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.52936944338	53620	95040	3542567	117949	3660516	419729		2023-11-15 12:31:40.074081
1045	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.02434887241	77804	95692	9336148	597322	9937070	1242657		2023-11-15 12:31:41.051651
1046	P01230	t	f	t	f	f	35 lbs nov.xml	41910	73940.11997418241	27104	84868	2945879	443078	3388837	137375		2023-11-15 12:31:42.592598
1047	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.52936944338	58620	95040	3542567	117949	3660516	419729		2023-11-15 12:31:45.17206
1048	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.02434887241	82804	95692	9336148	597322	9937070	1242657		2023-11-15 12:31:46.049514
1049	P01230	t	f	t	f	f	35 lbs nov.xml	41910	73940.11997418241	32104	84868	2945879	443078	3388837	137375		2023-11-15 12:31:47.597766
1050	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.52936944338	63620	95040	3542567	117949	3660516	419729		2023-11-15 12:31:50.180575
1051	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.02434887241	87804	95692	9336148	597322	9937070	1242657		2023-11-15 12:31:51.054332
1052	P01230	t	f	t	f	f	35 lbs nov.xml	41910	73940.11997418241	37104	84868	2945879	443078	3388837	137375		2023-11-15 12:31:52.613415
1053	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.52936944338	68620	95040	3542567	117949	3660516	419729		2023-11-15 12:31:55.086211
1054	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87920	128128.46054884841	92804	95692	9336148	597322	9937070	1242657		2023-11-15 12:31:56.053909
1055	P01230	t	f	t	f	f	35 lbs nov.xml	41910	73940.11997418241	42104	84868	2945879	443078	3388837	137375		2023-11-15 12:31:57.763904
1056	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.52936944338	73620	95040	3542567	117949	3660516	419729		2023-11-15 12:32:00.177183
1057	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.03854887893	2032	95768	9336148	597322	9937070	1242663		2023-11-15 12:32:01.063824
1058	P01230	t	f	t	f	f	35 lbs nov.xml	41910	73940.11997418241	47104	84868	2945879	443078	3388837	137375		2023-11-15 12:32:02.624854
1059	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.52936944338	78620	95040	3542567	117949	3660516	419729		2023-11-15 12:32:05.187603
1060	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.5152488606	7032	95768	9336148	597322	9937070	1242669		2023-11-15 12:32:06.069897
1061	P01230	t	f	t	f	f	35 lbs nov.xml	41910	73940.11997418241	52104	84868	2945879	443078	3388837	137375		2023-11-15 12:32:07.633167
1062	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.52936944338	83820	95040	3542567	117949	3660516	419729		2023-11-15 12:32:10.106412
1063	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.5152488606	12032	95768	9336148	597322	9937070	1242669		2023-11-15 12:32:11.075964
1064	P01230	t	f	t	f	f	35 lbs nov.xml	41910	73940.11997418241	57104	84868	2945879	443078	3388837	137375		2023-11-15 12:32:12.788492
1065	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42166.52936944338	88820	95040	3542567	117949	3660516	419729		2023-11-15 12:32:15.122228
1066	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.51604886175	17032	95768	9336148	597322	9937070	1242672		2023-11-15 12:32:16.089924
1067	P01230	t	f	t	f	f	35 lbs nov.xml	41910	73940.11997418241	62104	84868	2945879	443078	3388837	137375		2023-11-15 12:32:17.792412
1068	P01229	t	f	t	f	f	10 lbs octubre.xml	30016	42167.172569418886	93820	95040	3542567	117949	3660516	419729		2023-11-15 12:32:20.212606
1069	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.51604886175	22032	95768	9336148	597322	9937070	1242672		2023-11-15 12:32:21.096125
1070	P01230	t	f	t	f	f	35 lbs nov.xml	41910	73940.11997418241	67104	84868	2945879	443078	3388837	137375		2023-11-15 12:32:22.638319
1071	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42167.783669424985	3504	95312	3542567	117949	3660516	419735		2023-11-15 12:32:25.126642
1072	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.51604886175	27032	95768	9336148	597322	9937070	1242672		2023-11-15 12:32:26.099255
1073	P01230	t	f	t	f	f	35 lbs nov.xml	41910	73940.11997418241	72104	84868	2945879	443078	3388837	137375		2023-11-15 12:32:27.789678
1074	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.100169431156	8504	95312	3542567	117949	3660516	419741		2023-11-15 12:32:30.270216
1075	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.51604886175	32032	95768	9336148	597322	9937070	1242672		2023-11-15 12:32:31.105541
1076	P01230	t	f	t	f	f	35 lbs nov.xml	41910	73940.11997418241	77104	84868	2945879	443078	3388837	137375		2023-11-15 12:32:32.809223
1077	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.100169431156	13504	95312	3542567	117949	3660516	419741		2023-11-15 12:32:35.233
1078	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.51604886175	37032	95768	9336148	597322	9937070	1242672		2023-11-15 12:32:36.112219
1079	P01230	t	f	t	f	f	35 lbs nov.xml	41910	73940.47807419424	82104	84868	2945879	443078	3388837	137375		2023-11-15 12:32:37.655848
1080	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.10536943191	18504	95312	3542567	117949	3660516	419745		2023-11-15 12:32:40.150727
1081	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.51604886175	42032	95768	9336148	597322	9937070	1242672		2023-11-15 12:32:41.118716
1082	P01230	t	f	t	f	f	35 lbs nov.xml	41911	73941.0632742369	2200	84900	2945879	443078	3388837	137380		2023-11-15 12:32:42.663024
1083	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.10536943191	23504	95312	3542567	117949	3660516	419745		2023-11-15 12:32:45.257686
1084	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.51604886175	47032	95768	9336148	597322	9937070	1242672		2023-11-15 12:32:46.123925
1085	P01230	t	f	t	f	f	35 lbs nov.xml	41911	73941.45497423009	7200	84900	2945879	443078	3388837	137386		2023-11-15 12:32:47.821033
1086	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.10536943191	28504	95312	3542567	117949	3660516	419745		2023-11-15 12:32:50.315548
1087	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.51604886175	52032	95768	9336148	597322	9937070	1242672		2023-11-15 12:32:51.133076
1088	P01230	t	f	t	f	f	35 lbs nov.xml	41911	73941.45497423009	12200	84900	2945879	443078	3388837	137386		2023-11-15 12:32:52.675786
1089	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.10536943191	33504	95312	3542567	117949	3660516	419745		2023-11-15 12:32:55.173403
1090	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.51604886175	57032	95768	9336148	597322	9937070	1242672		2023-11-15 12:32:56.142836
1091	P01230	t	f	t	f	f	35 lbs nov.xml	41911	73941.45987423162	17200	84900	2945879	443078	3388837	137386		2023-11-15 12:32:57.83627
1092	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.10536943191	38504	95312	3542567	117949	3660516	419745		2023-11-15 12:33:00.266899
1093	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.51604886175	62032	95768	9336148	597322	9937070	1242672		2023-11-15 12:33:01.1505
1094	P01230	t	f	t	f	f	35 lbs nov.xml	41911	73941.45987423162	22200	84900	2945879	443078	3388837	137389		2023-11-15 12:33:02.693182
1095	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.10536943191	43504	95312	3542567	117949	3660516	419745		2023-11-15 12:33:05.193252
1096	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.51604886175	67032	95768	9336148	597322	9937070	1242672		2023-11-15 12:33:06.344503
1097	P01230	t	f	t	f	f	35 lbs nov.xml	41911	73941.45987423162	27200	84900	2945879	443078	3388837	137389		2023-11-15 12:33:07.709042
1098	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.10536943191	48504	95312	3542567	117949	3660516	419745		2023-11-15 12:33:10.20863
1099	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.51604886175	72032	95768	9336148	597322	9937070	1242672		2023-11-15 12:33:11.161635
1100	P01230	t	f	t	f	f	35 lbs nov.xml	41911	73941.45987423162	32200	84900	2945879	443078	3388837	137389		2023-11-15 12:33:12.858322
1101	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.10536943191	53504	95312	3542567	117949	3660516	419745		2023-11-15 12:33:15.214849
1102	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.51604886175	77032	95768	9336148	597322	9937070	1242672		2023-11-15 12:33:16.16482
1103	P01230	t	f	t	f	f	35 lbs nov.xml	41911	73941.45987423162	37400	84900	2945879	443078	3388837	137389		2023-11-15 12:33:17.914141
1104	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.10536943191	58504	95312	3542567	117949	3660516	419745		2023-11-15 12:33:20.322142
1105	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.51604886175	82032	95768	9336148	597322	9937070	1242672		2023-11-15 12:33:21.171282
1106	P01230	t	f	t	f	f	35 lbs nov.xml	41911	73941.45987423162	42400	84900	2945879	443078	3388837	137389		2023-11-15 12:33:22.727309
1107	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.10536943191	63504	95312	3542567	117949	3660516	419745		2023-11-15 12:33:25.697761
1108	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.51604886175	87032	95768	9336148	597322	9937070	1242672		2023-11-15 12:33:26.199582
1109	P01230	t	f	t	f	f	35 lbs nov.xml	41911	73941.45987423162	47400	84900	2945879	443078	3388837	137389		2023-11-15 12:33:28.080251
1110	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.10536943191	68504	95312	3542567	117949	3660516	419745		2023-11-15 12:33:30.388238
1111	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87921	128129.82884885152	92032	95768	9336148	597322	9937070	1242672		2023-11-15 12:33:31.183035
1112	P01230	t	f	t	f	f	35 lbs nov.xml	41911	73941.45987423162	52400	84900	2945879	443078	3388837	137389		2023-11-15 12:33:32.738967
1113	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.10536943191	73504	95312	3542567	117949	3660516	419745		2023-11-15 12:33:35.290149
1114	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128130.4060489248	1284	95744	9336148	597322	9937070	1242677		2023-11-15 12:33:36.192657
1115	P01230	t	f	t	f	f	35 lbs nov.xml	41911	73941.45987423162	57400	84900	2945879	443078	3388837	137389		2023-11-15 12:33:37.743231
1116	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.10536943191	78504	95312	3542567	117949	3660516	419745		2023-11-15 12:33:40.290005
1117	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.00454896099	6484	95744	9336148	597322	9937070	1242682		2023-11-15 12:33:41.197828
1118	P01230	t	f	t	f	f	35 lbs nov.xml	41911	73941.45987423162	62400	84900	2945879	443078	3388837	137389		2023-11-15 12:33:42.759078
1119	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.10536943191	83704	95312	3542567	117949	3660516	419745		2023-11-15 12:33:45.496392
1120	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.00454896099	11484	95744	9336148	597322	9937070	1242682		2023-11-15 12:33:46.364895
1121	P01230	t	f	t	f	f	35 lbs nov.xml	41911	73941.45987423162	67400	84900	2945879	443078	3388837	137389		2023-11-15 12:33:47.954841
1122	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.10536943191	88704	95312	3542567	117949	3660516	419745		2023-11-15 12:33:50.411657
1123	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.0056489633	16484	95744	9336148	597322	9937070	1242685		2023-11-15 12:33:51.214751
1124	P01230	t	f	t	f	f	35 lbs nov.xml	41911	73941.45987423162	72400	84900	2945879	443078	3388837	137389		2023-11-15 12:33:52.760303
1125	P01229	t	f	t	f	f	10 lbs octubre.xml	30017	42168.77016945595	93704	95312	3542567	117949	3660516	419745		2023-11-15 12:33:55.319644
1126	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.0056489633	21484	95744	9336148	597322	9937070	1242685		2023-11-15 12:33:56.22781
1127	P01230	t	f	t	f	f	35 lbs nov.xml	41911	73941.45987423162	77400	84900	2945879	443078	3388837	137389		2023-11-15 12:33:57.961999
1128	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.39706954136	3652	95048	3542567	117949	3660516	419750		2023-11-15 12:34:00.326505
1129	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.0056489633	26484	95744	9336148	597322	9937070	1242685		2023-11-15 12:34:01.473829
1130	P01230	t	f	t	f	f	35 lbs nov.xml	41911	73941.85447424343	82400	84900	2945879	443078	3388837	137389		2023-11-15 12:34:02.775745
1131	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.677069541336	8652	95048	3542567	117949	3660516	419756		2023-11-15 12:34:05.341195
1132	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.0056489633	31484	95744	9336148	597322	9937070	1242685		2023-11-15 12:34:06.259731
1133	P01230	t	f	t	f	f	35 lbs nov.xml	41912	73942.45227420067	2476	84920	2945879	443078	3388837	137394		2023-11-15 12:34:07.782747
1134	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.677069541336	13652	95048	3542567	117949	3660516	419756		2023-11-15 12:34:10.680478
1135	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.0056489633	36484	95744	9336148	597322	9937070	1242685		2023-11-15 12:34:11.269687
1136	P01230	t	f	t	f	f	35 lbs nov.xml	41912	73942.79527420642	7476	84920	2945879	443078	3388837	137400		2023-11-15 12:34:12.983599
1137	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.68206954372	18652	95048	3542567	117949	3660516	419760		2023-11-15 12:34:15.614661
1138	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.0056489633	41484	95744	9336148	597322	9937070	1242685		2023-11-15 12:34:16.290268
1139	P01230	t	f	t	f	f	35 lbs nov.xml	41912	73942.79527420642	12476	84920	2945879	443078	3388837	137400		2023-11-15 12:34:18.023447
1140	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.68206954372	23652	95048	3542567	117949	3660516	419760		2023-11-15 12:34:20.422618
1141	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.0056489633	46484	95744	9336148	597322	9937070	1242685		2023-11-15 12:34:21.291028
1142	P01230	t	f	t	f	f	35 lbs nov.xml	41912	73942.800174208	17476	84920	2945879	443078	3388837	137400		2023-11-15 12:34:22.815129
1143	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.68206954372	28652	95048	3542567	117949	3660516	419760		2023-11-15 12:34:25.527472
1144	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.0056489633	51484	95744	9336148	597322	9937070	1242685		2023-11-15 12:34:26.336464
1145	P01230	t	f	t	f	f	35 lbs nov.xml	41912	73942.800174208	22476	84920	2945879	443078	3388837	137403		2023-11-15 12:34:27.828635
1146	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.68206954372	33652	95048	3542567	117949	3660516	419760		2023-11-15 12:34:30.433948
1147	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.0056489633	56484	95744	9336148	597322	9937070	1242685		2023-11-15 12:34:31.339728
1148	P01230	t	f	t	f	f	35 lbs nov.xml	41912	73942.800174208	27476	84920	2945879	443078	3388837	137403		2023-11-15 12:34:32.838689
1149	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.68206954372	38652	95048	3542567	117949	3660516	419760		2023-11-15 12:34:35.435646
1150	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.0056489633	61484	95744	9336148	597322	9937070	1242685		2023-11-15 12:34:36.35062
1151	P01230	t	f	t	f	f	35 lbs nov.xml	41912	73942.800174208	32476	84920	2945879	443078	3388837	137403		2023-11-15 12:34:37.842014
1152	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.68206954372	43652	95048	3542567	117949	3660516	419760		2023-11-15 12:34:40.539664
1153	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.0056489633	66484	95744	9336148	597322	9937070	1242685		2023-11-15 12:34:41.364342
1154	P01230	t	f	t	f	f	35 lbs nov.xml	41912	73942.800174208	37476	84920	2945879	443078	3388837	137403		2023-11-15 12:34:42.850093
1155	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.68206954372	48652	95048	3542567	117949	3660516	419760		2023-11-15 12:34:45.578762
1156	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.0056489633	71484	95744	9336148	597322	9937070	1242685		2023-11-15 12:34:46.479533
1157	P01230	t	f	t	f	f	35 lbs nov.xml	41912	73942.800174208	42476	84920	2945879	443078	3388837	137403		2023-11-15 12:34:48.128978
1158	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.68206954372	53652	95048	3542567	117949	3660516	419760		2023-11-15 12:34:50.486403
1159	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.0056489633	76484	95744	9336148	597322	9937070	1242685		2023-11-15 12:34:51.366178
1160	P01230	t	f	t	f	f	35 lbs nov.xml	41912	73942.800174208	47476	84920	2945879	443078	3388837	137403		2023-11-15 12:34:52.866875
1161	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.68206954372	58852	95048	3542567	117949	3660516	419760		2023-11-15 12:34:55.50203
1162	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.0056489633	81484	95744	9336148	597322	9937070	1242685		2023-11-15 12:34:56.39358
1163	P01230	t	f	t	f	f	35 lbs nov.xml	41912	73942.800174208	52476	84920	2945879	443078	3388837	137403		2023-11-15 12:34:58.062534
1164	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.68206954372	63852	95048	3542567	117949	3660516	419760		2023-11-15 12:35:00.513756
1165	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.0056489633	86684	95744	9336148	597322	9937070	1242685		2023-11-15 12:35:01.392831
1166	P01230	t	f	t	f	f	35 lbs nov.xml	41912	73942.800174208	57476	84920	2945879	443078	3388837	137403		2023-11-15 12:35:02.871436
1167	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.68206954372	68852	95048	3542567	117949	3660516	419760		2023-11-15 12:35:05.518826
1168	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87922	128131.20794896068	91684	95744	9336148	597322	9937070	1242685		2023-11-15 12:35:06.493574
1169	P01230	t	f	t	f	f	35 lbs nov.xml	41912	73942.800174208	62476	84920	2945879	443078	3388837	137403		2023-11-15 12:35:07.885098
1170	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.68206954372	73852	95048	3542567	117949	3660516	419760		2023-11-15 12:35:10.661478
1171	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128131.80674902472	964	95716	9336148	597322	9937070	1242690		2023-11-15 12:35:11.428273
1172	P01230	t	f	t	f	f	35 lbs nov.xml	41912	73942.800174208	67476	84920	2945879	443078	3388837	137403		2023-11-15 12:35:13.140371
1173	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.68206954372	78852	95048	3542567	117949	3660516	419760		2023-11-15 12:35:15.627866
1174	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.49614903769	5964	95716	9336148	597322	9937070	1242696		2023-11-15 12:35:16.431774
1175	P01230	t	f	t	f	f	35 lbs nov.xml	41912	73942.800174208	72476	84920	2945879	443078	3388837	137403		2023-11-15 12:35:18.256968
1176	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.68206954372	83852	95048	3542567	117949	3660516	419760		2023-11-15 12:35:20.536307
1177	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.49614903769	10964	95716	9336148	597322	9937070	1242696		2023-11-15 12:35:21.439992
1178	P01230	t	f	t	f	f	35 lbs nov.xml	41912	73942.800174208	77476	84920	2945879	443078	3388837	137403		2023-11-15 12:35:22.910195
1179	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42169.68206954372	88852	95048	3542567	117949	3660516	419760		2023-11-15 12:35:25.737305
1180	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.49674903999	15964	95716	9336148	597322	9937070	1242696		2023-11-15 12:35:26.442903
1181	P01230	t	f	t	f	f	35 lbs nov.xml	41912	73943.23117419658	82676	84920	2945879	443078	3388837	137403		2023-11-15 12:35:27.915517
1182	P01229	t	f	t	f	f	10 lbs octubre.xml	30018	42170.366969569084	93852	95048	3542567	117949	3660516	419760		2023-11-15 12:35:30.802338
1183	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.49674903999	20964	95716	9336148	597322	9937070	1242698		2023-11-15 12:35:31.447485
1184	P01230	t	f	t	f	f	35 lbs nov.xml	41913	73943.82917422705	2720	84952	2945879	443078	3388837	137408		2023-11-15 12:35:33.580785
1185	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42170.985869593496	3656	95192	3542567	117949	3660516	419765		2023-11-15 12:35:35.811929
1186	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.49674903999	25964	95716	9336148	597322	9937070	1242698		2023-11-15 12:35:36.456356
1187	P01230	t	f	t	f	f	35 lbs nov.xml	41913	73944.13527423318	7720	84952	2945879	443078	3388837	137414		2023-11-15 12:35:37.938367
1188	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.25446960529	8656	95192	3542567	117949	3660516	419770		2023-11-15 12:35:40.625477
1189	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.49674903999	30964	95716	9336148	597322	9937070	1242698		2023-11-15 12:35:41.469685
1190	P01230	t	f	t	f	f	35 lbs nov.xml	41913	73944.13527423318	12720	84952	2945879	443078	3388837	137414		2023-11-15 12:35:42.94096
1191	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.25446960529	13656	95192	3542567	117949	3660516	419770		2023-11-15 12:35:45.730077
1192	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.49674903999	35964	95716	9336148	597322	9937070	1242698		2023-11-15 12:35:46.643334
1193	P01230	t	f	t	f	f	35 lbs nov.xml	41913	73944.13937423356	17720	84952	2945879	443078	3388837	137414		2023-11-15 12:35:48.131799
1194	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.259369606814	18656	95192	3542567	117949	3660516	419774		2023-11-15 12:35:50.634638
1195	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.49674903999	40964	95716	9336148	597322	9937070	1242698		2023-11-15 12:35:51.487169
1196	P01230	t	f	t	f	f	35 lbs nov.xml	41913	73944.13937423356	22720	84952	2945879	443078	3388837	137417		2023-11-15 12:35:52.954116
1197	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.259369606814	23656	95192	3542567	117949	3660516	419774		2023-11-15 12:35:55.638006
1198	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.49674903999	45964	95716	9336148	597322	9937070	1242698		2023-11-15 12:35:56.496473
1199	P01230	t	f	t	f	f	35 lbs nov.xml	41913	73944.13937423356	27720	84952	2945879	443078	3388837	137417		2023-11-15 12:35:58.400752
1200	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.259369606814	28656	95192	3542567	117949	3660516	419774		2023-11-15 12:36:00.651079
1201	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.49674903999	50964	95716	9336148	597322	9937070	1242698		2023-11-15 12:36:01.491326
1202	P01230	t	f	t	f	f	35 lbs nov.xml	41913	73944.13937423356	32720	84952	2945879	443078	3388837	137417		2023-11-15 12:36:02.99732
1203	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.259369606814	33656	95192	3542567	117949	3660516	419774		2023-11-15 12:36:05.664576
1204	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.49674903999	55964	95716	9336148	597322	9937070	1242698		2023-11-15 12:36:06.652389
1205	P01230	t	f	t	f	f	35 lbs nov.xml	41913	73944.13937423356	37720	84952	2945879	443078	3388837	137417		2023-11-15 12:36:07.997573
1206	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.259369606814	38656	95192	3542567	117949	3660516	419774		2023-11-15 12:36:10.679328
1207	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.49674903999	60964	95716	9336148	597322	9937070	1242698		2023-11-15 12:36:11.506391
1208	P01230	t	f	t	f	f	35 lbs nov.xml	41913	73944.13937423356	42720	84952	2945879	443078	3388837	137417		2023-11-15 12:36:13.404589
1209	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.259369606814	43656	95192	3542567	117949	3660516	419774		2023-11-15 12:36:15.796083
1210	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.49674903999	65964	95716	9336148	597322	9937070	1242698		2023-11-15 12:36:16.51397
1211	P01230	t	f	t	f	f	35 lbs nov.xml	41913	73944.13937423356	47720	84952	2945879	443078	3388837	137417		2023-11-15 12:36:18.006723
1212	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.259369606814	48656	95192	3542567	117949	3660516	419774		2023-11-15 12:36:20.680004
1213	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.49674903999	70964	95716	9336148	597322	9937070	1242698		2023-11-15 12:36:21.523958
1214	P01230	t	f	t	f	f	35 lbs nov.xml	41913	73944.13937423356	52720	84952	2945879	443078	3388837	137417		2023-11-15 12:36:23.009923
1215	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.259369606814	53656	95192	3542567	117949	3660516	419774		2023-11-15 12:36:25.810941
1216	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.49674903999	75964	95716	9336148	597322	9937070	1242698		2023-11-15 12:36:26.550345
1217	P01230	t	f	t	f	f	35 lbs nov.xml	41913	73944.13937423356	57720	84952	2945879	443078	3388837	137417		2023-11-15 12:36:28.232775
1218	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.259369606814	58656	95192	3542567	117949	3660516	419774		2023-11-15 12:36:30.691263
1219	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.49674903999	80964	95716	9336148	597322	9937070	1242698		2023-11-15 12:36:31.5498
1220	P01230	t	f	t	f	f	35 lbs nov.xml	41913	73944.13937423356	62720	84952	2945879	443078	3388837	137417		2023-11-15 12:36:33.470482
1221	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.259369606814	63656	95192	3542567	117949	3660516	419774		2023-11-15 12:36:35.686942
1222	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.49674903999	85964	95716	9336148	597322	9937070	1242698		2023-11-15 12:36:36.550783
1223	P01230	t	f	t	f	f	35 lbs nov.xml	41913	73944.13937423356	67720	84952	2945879	443078	3388837	137417		2023-11-15 12:36:38.026435
1224	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.259369606814	68856	95192	3542567	117949	3660516	419774		2023-11-15 12:36:40.702045
1225	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87923	128132.58834903852	90964	95716	9336148	597322	9937070	1242698		2023-11-15 12:36:41.564193
1226	P01230	t	f	t	f	f	35 lbs nov.xml	41913	73944.13937423356	72720	84952	2945879	443078	3388837	137417		2023-11-15 12:36:43.044643
1227	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.259369606814	73856	95192	3542567	117949	3660516	419774		2023-11-15 12:36:45.711963
1228	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.24294911331	252	95708	9336148	597322	9937070	1242704		2023-11-15 12:36:46.773256
1229	P01230	t	f	t	f	f	35 lbs nov.xml	41913	73944.13937423356	77720	84952	2945879	443078	3388837	137417		2023-11-15 12:36:48.243883
1230	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.259369606814	78856	95192	3542567	117949	3660516	419774		2023-11-15 12:36:50.721376
1231	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.97644912663	5252	95708	9336148	597322	9937070	1242704		2023-11-15 12:36:51.58096
1232	P01230	t	f	t	f	f	35 lbs nov.xml	41913	73944.64437423355	82720	84952	2945879	443078	3388837	137417		2023-11-15 12:36:53.057768
1233	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.259369606814	83856	95192	3542567	117949	3660516	419774		2023-11-15 12:36:56.105904
1234	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.98494912662	10252	95708	9336148	597322	9937070	1242710		2023-11-15 12:36:56.59264
1235	P01230	t	f	t	f	f	35 lbs nov.xml	41914	73945.24117425179	2928	84788	2945879	443078	3388837	137422		2023-11-15 12:36:58.489859
1236	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.259369606814	88856	95192	3542567	117949	3660516	419774		2023-11-15 12:37:00.775292
1237	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.9861491293	15452	95708	9336148	597322	9937070	1242710		2023-11-15 12:37:01.604651
1238	P01230	t	f	t	f	f	35 lbs nov.xml	41914	73945.47367425758	7928	84788	2945879	443078	3388837	137427		2023-11-15 12:37:03.076977
1239	P01229	t	f	t	f	f	10 lbs octubre.xml	30019	42171.97216965516	93856	95192	3542567	117949	3660516	419774		2023-11-15 12:37:05.779031
1240	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.9861491293	20452	95708	9336148	597322	9937070	1242713		2023-11-15 12:37:06.601254
1241	P01230	t	f	t	f	f	35 lbs nov.xml	41914	73945.47367425758	12928	84788	2945879	443078	3388837	137427		2023-11-15 12:37:08.088514
1242	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.61346970398	3904	94948	3542567	117949	3660516	419779		2023-11-15 12:37:10.78104
1243	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.9861491293	25452	95708	9336148	597322	9937070	1242713		2023-11-15 12:37:11.615007
1244	P01230	t	f	t	f	f	35 lbs nov.xml	41914	73945.4776742614	17928	84788	2945879	443078	3388837	137427		2023-11-15 12:37:13.100579
1245	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.83156970387	8904	94948	3542567	117949	3660516	419785		2023-11-15 12:37:15.898941
1246	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.9861491293	30452	95708	9336148	597322	9937070	1242713		2023-11-15 12:37:16.620265
1247	P01230	t	f	t	f	f	35 lbs nov.xml	41914	73945.4776742614	22928	84788	2945879	443078	3388837	137430		2023-11-15 12:37:18.103018
1248	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.83156970387	13904	94948	3542567	117949	3660516	419785		2023-11-15 12:37:20.789755
1249	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.9861491293	35452	95708	9336148	597322	9937070	1242713		2023-11-15 12:37:21.628417
1250	P01230	t	f	t	f	f	35 lbs nov.xml	41914	73945.4776742614	27928	84788	2945879	443078	3388837	137430		2023-11-15 12:37:23.103142
1251	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.83686970501	18904	94948	3542567	117949	3660516	419789		2023-11-15 12:37:25.893981
1252	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.9861491293	40452	95708	9336148	597322	9937070	1242713		2023-11-15 12:37:26.630247
1253	P01230	t	f	t	f	f	35 lbs nov.xml	41914	73945.4776742614	32928	84788	2945879	443078	3388837	137430		2023-11-15 12:37:28.56587
1254	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.83686970501	23904	94948	3542567	117949	3660516	419789		2023-11-15 12:37:30.854844
1255	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.9861491293	45452	95708	9336148	597322	9937070	1242713		2023-11-15 12:37:31.632599
1256	P01230	t	f	t	f	f	35 lbs nov.xml	41914	73945.4776742614	37928	84788	2945879	443078	3388837	137430		2023-11-15 12:37:33.525758
1257	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.83686970501	28904	94948	3542567	117949	3660516	419789		2023-11-15 12:37:35.867313
1258	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.9861491293	50452	95708	9336148	597322	9937070	1242713		2023-11-15 12:37:36.646802
1259	P01230	t	f	t	f	f	35 lbs nov.xml	41914	73945.4776742614	43128	84788	2945879	443078	3388837	137430		2023-11-15 12:37:38.34976
1260	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.83686970501	33904	94948	3542567	117949	3660516	419789		2023-11-15 12:37:40.868928
1261	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.9861491293	55452	95708	9336148	597322	9937070	1242713		2023-11-15 12:37:41.654668
1262	P01230	t	f	t	f	f	35 lbs nov.xml	41914	73945.4776742614	48128	84788	2945879	443078	3388837	137430		2023-11-15 12:37:43.138989
1263	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.83686970501	38904	94948	3542567	117949	3660516	419789		2023-11-15 12:37:45.87088
1264	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.9861491293	60452	95708	9336148	597322	9937070	1242713		2023-11-15 12:37:46.668587
1265	P01230	t	f	t	f	f	35 lbs nov.xml	41914	73945.4776742614	53128	84788	2945879	443078	3388837	137430		2023-11-15 12:37:48.336405
1266	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.83686970501	43904	94948	3542567	117949	3660516	419789		2023-11-15 12:37:50.876457
1267	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.9861491293	65452	95708	9336148	597322	9937070	1242713		2023-11-15 12:37:51.669695
1268	P01230	t	f	t	f	f	35 lbs nov.xml	41914	73945.4776742614	58128	84788	2945879	443078	3388837	137430		2023-11-15 12:37:53.775907
1269	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.83686970501	48904	94948	3542567	117949	3660516	419789		2023-11-15 12:37:55.883791
1270	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.9861491293	70452	95708	9336148	597322	9937070	1242713		2023-11-15 12:37:56.68239
1271	P01230	t	f	t	f	f	35 lbs nov.xml	41914	73945.4776742614	63128	84788	2945879	443078	3388837	137430		2023-11-15 12:37:58.439049
1272	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.83686970501	53904	94948	3542567	117949	3660516	419789		2023-11-15 12:38:00.896712
1273	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.9861491293	75452	95708	9336148	597322	9937070	1242713		2023-11-15 12:38:01.700957
1274	P01230	t	f	t	f	f	35 lbs nov.xml	41914	73945.4776742614	68128	84788	2945879	443078	3388837	137430		2023-11-15 12:38:03.1772
1275	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.83686970501	59104	94948	3542567	117949	3660516	419789		2023-11-15 12:38:05.91199
1276	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.9861491293	80452	95708	9336148	597322	9937070	1242713		2023-11-15 12:38:06.701149
1277	P01230	t	f	t	f	f	35 lbs nov.xml	41914	73945.4776742614	73128	84788	2945879	443078	3388837	137430		2023-11-15 12:38:08.189769
1278	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.83686970501	64104	94948	3542567	117949	3660516	419789		2023-11-15 12:38:10.924702
1279	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.9861491293	85452	95708	9336148	597322	9937070	1242713		2023-11-15 12:38:11.712968
1280	P01230	t	f	t	f	f	35 lbs nov.xml	41914	73945.4776742614	78128	84788	2945879	443078	3388837	137430		2023-11-15 12:38:13.730073
1281	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.83686970501	69104	94948	3542567	117949	3660516	419789		2023-11-15 12:38:16.03434
1282	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128133.99824912779	90452	95708	9336148	597322	9937070	1242713		2023-11-15 12:38:16.708506
1283	P01230	t	f	t	f	f	35 lbs nov.xml	41914	73946.05477427322	83128	84788	2945879	443078	3388837	137430		2023-11-15 12:38:18.393164
1284	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.83686970501	74104	94948	3542567	117949	3660516	419789		2023-11-15 12:38:20.927539
1285	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87924	128134.73094916475	95452	95708	9336148	597322	9937070	1242718		2023-11-15 12:38:21.711571
1286	P01230	t	f	t	f	f	35 lbs nov.xml	41915	73946.66657429146	3320	84804	2945879	443078	3388837	137436		2023-11-15 12:38:23.239848
1287	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.83686970501	79104	94948	3542567	117949	3660516	419789		2023-11-15 12:38:26.034508
1288	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.44034922724	4700	95748	9336148	597322	9937070	1242718		2023-11-15 12:38:26.740041
1289	P01230	t	f	t	f	f	35 lbs nov.xml	41915	73946.81307428576	8320	84804	2945879	443078	3388837	137441		2023-11-15 12:38:28.400354
1290	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.83686970501	84104	94948	3542567	117949	3660516	419789		2023-11-15 12:38:30.947265
1291	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.47604922607	9700	95748	9336148	597322	9937070	1242723		2023-11-15 12:38:31.740925
1292	P01230	t	f	t	f	f	35 lbs nov.xml	41915	73946.81307428576	13320	84804	2945879	443078	3388837	137441		2023-11-15 12:38:33.250113
1293	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42172.83686970501	89104	94948	3542567	117949	3660516	419789		2023-11-15 12:38:35.960385
1294	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.47714922647	14700	95748	9336148	597322	9937070	1242723		2023-11-15 12:38:36.747303
1295	P01230	t	f	t	f	f	35 lbs nov.xml	41915	73946.81717428616	18320	84804	2945879	443078	3388837	137445		2023-11-15 12:38:38.26761
1296	P01229	t	f	t	f	f	10 lbs octubre.xml	30020	42173.57026968174	94104	94948	3542567	117949	3660516	419789		2023-11-15 12:38:40.975113
1297	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.47714922647	19700	95748	9336148	597322	9937070	1242726		2023-11-15 12:38:41.76561
1298	P01230	t	f	t	f	f	35 lbs nov.xml	41915	73946.81717428616	23320	84804	2945879	443078	3388837	137445		2023-11-15 12:38:43.263321
1299	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.22896970919	4076	95024	3542567	117949	3660516	419794		2023-11-15 12:38:46.182782
1300	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.47714922647	24700	95748	9336148	597322	9937070	1242726		2023-11-15 12:38:46.763522
1301	P01230	t	f	t	f	f	35 lbs nov.xml	41915	73946.81717428616	28320	84804	2945879	443078	3388837	137445		2023-11-15 12:38:48.268518
1302	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.409969706314	9076	95024	3542567	117949	3660516	419799		2023-11-15 12:38:51.034707
1303	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.47714922647	29700	95748	9336148	597322	9937070	1242726		2023-11-15 12:38:51.788055
1304	P01230	t	f	t	f	f	35 lbs nov.xml	41915	73946.81717428616	33320	84804	2945879	443078	3388837	137445		2023-11-15 12:38:53.282362
1305	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.409969706314	14076	95024	3542567	117949	3660516	419799		2023-11-15 12:38:56.020105
1306	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.47714922647	34900	95748	9336148	597322	9937070	1242726		2023-11-15 12:38:56.822073
1307	P01230	t	f	t	f	f	35 lbs nov.xml	41915	73946.81717428616	38320	84804	2945879	443078	3388837	137445		2023-11-15 12:38:58.539797
1308	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.41496970726	19076	95024	3542567	117949	3660516	419803		2023-11-15 12:39:01.03221
1309	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.47714922647	39900	95748	9336148	597322	9937070	1242726		2023-11-15 12:39:01.804599
1310	P01230	t	f	t	f	f	35 lbs nov.xml	41915	73946.81717428616	43320	84804	2945879	443078	3388837	137445		2023-11-15 12:39:03.304186
1311	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.41496970726	24076	95024	3542567	117949	3660516	419803		2023-11-15 12:39:06.045986
1312	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.47714922647	44900	95748	9336148	597322	9937070	1242726		2023-11-15 12:39:06.815126
1313	P01230	t	f	t	f	f	35 lbs nov.xml	41915	73946.81717428616	48320	84804	2945879	443078	3388837	137445		2023-11-15 12:39:08.428768
1314	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.41496970726	29076	95024	3542567	117949	3660516	419803		2023-11-15 12:39:11.048373
1315	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.47714922647	49900	95748	9336148	597322	9937070	1242726		2023-11-15 12:39:11.830498
1316	P01230	t	f	t	f	f	35 lbs nov.xml	41915	73946.81717428616	53320	84804	2945879	443078	3388837	137445		2023-11-15 12:39:13.465265
1317	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.41496970726	34076	95024	3542567	117949	3660516	419803		2023-11-15 12:39:16.050678
1318	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.47714922647	54900	95748	9336148	597322	9937070	1242726		2023-11-15 12:39:16.843923
1319	P01230	t	f	t	f	f	35 lbs nov.xml	41915	73946.81717428616	58320	84804	2945879	443078	3388837	137445		2023-11-15 12:39:18.31429
1320	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.41496970726	39076	95024	3542567	117949	3660516	419803		2023-11-15 12:39:21.072934
1321	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.47714922647	59900	95748	9336148	597322	9937070	1242726		2023-11-15 12:39:21.847906
1322	P01230	t	f	t	f	f	35 lbs nov.xml	41915	73946.81717428616	63520	84804	2945879	443078	3388837	137445		2023-11-15 12:39:23.453215
1323	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.41496970726	44076	95024	3542567	117949	3660516	419803		2023-11-15 12:39:26.184482
1324	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.47714922647	64900	95748	9336148	597322	9937070	1242726		2023-11-15 12:39:26.847399
1325	P01230	t	f	t	f	f	35 lbs nov.xml	41915	73946.81717428616	68520	84804	2945879	443078	3388837	137445		2023-11-15 12:39:28.643376
1326	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.41496970726	49076	95024	3542567	117949	3660516	419803		2023-11-15 12:39:31.084076
1327	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.47714922647	69900	95748	9336148	597322	9937070	1242726		2023-11-15 12:39:31.88634
1328	P01230	t	f	t	f	f	35 lbs nov.xml	41915	73946.81717428616	73520	84804	2945879	443078	3388837	137445		2023-11-15 12:39:33.451071
1329	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.41496970726	54076	95024	3542567	117949	3660516	419803		2023-11-15 12:39:36.095774
1330	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.47714922647	74900	95748	9336148	597322	9937070	1242726		2023-11-15 12:39:36.905165
1331	P01230	t	f	t	f	f	35 lbs nov.xml	41915	73946.81717428616	78520	84804	2945879	443078	3388837	137445		2023-11-15 12:39:38.458595
1332	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.41496970726	59276	95024	3542567	117949	3660516	419803		2023-11-15 12:39:41.100052
1333	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.47714922647	79900	95748	9336148	597322	9937070	1242726		2023-11-15 12:39:41.897383
1334	P01230	t	f	t	f	f	35 lbs nov.xml	41915	73947.44877429798	83520	84804	2945879	443078	3388837	137445		2023-11-15 12:39:43.473615
1335	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.41496970726	64076	95024	3542567	117949	3660516	419803		2023-11-15 12:39:46.232791
1336	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.47714922647	84900	95748	9336148	597322	9937070	1242726		2023-11-15 12:39:46.905139
1337	P01230	t	f	t	f	f	35 lbs nov.xml	41916	73948.07187429642	3716	84800	2945879	443078	3388837	137450		2023-11-15 12:39:48.485071
1338	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.41496970726	69276	95024	3542567	117949	3660516	419803		2023-11-15 12:39:51.108442
1339	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128135.47744922762	89900	95748	9336148	597322	9937070	1242726		2023-11-15 12:39:51.923645
1340	P01230	t	f	t	f	f	35 lbs nov.xml	41916	73948.15217429762	8716	84800	2945879	443078	3388837	137455		2023-11-15 12:39:53.500854
1341	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.41496970726	74276	95024	3542567	117949	3660516	419803		2023-11-15 12:39:56.118453
1342	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87925	128136.20214925127	94900	95748	9336148	597322	9937070	1242726		2023-11-15 12:39:56.935792
1343	P01230	t	f	t	f	f	35 lbs nov.xml	41916	73948.15217429762	13716	84800	2945879	443078	3388837	137455		2023-11-15 12:39:58.504337
1344	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.41496970726	79276	95024	3542567	117949	3660516	419803		2023-11-15 12:40:01.12388
1345	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.89764922834	4136	95760	9336148	597322	9937070	1242731		2023-11-15 12:40:01.96606
1346	P01230	t	f	t	f	f	35 lbs nov.xml	41916	73948.15637429837	18716	84800	2945879	443078	3388837	137459		2023-11-15 12:40:03.506278
1347	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.41496970726	84276	95024	3542567	117949	3660516	419803		2023-11-15 12:40:06.147865
1348	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.96654922607	9136	95760	9336148	597322	9937070	1242736		2023-11-15 12:40:06.972543
1349	P01230	t	f	t	f	f	35 lbs nov.xml	41916	73948.15637429837	23916	84800	2945879	443078	3388837	137459		2023-11-15 12:40:08.523838
1350	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42174.41496970726	89276	95024	3542567	117949	3660516	419803		2023-11-15 12:40:11.163049
1351	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.96714922646	14136	95760	9336148	597322	9937070	1242736		2023-11-15 12:40:11.982176
1352	P01230	t	f	t	f	f	35 lbs nov.xml	41916	73948.15637429837	28916	84800	2945879	443078	3388837	137459		2023-11-15 12:40:13.747572
1353	P01229	t	f	t	f	f	10 lbs octubre.xml	30021	42175.16366968321	94276	95024	3542567	117949	3660516	419803		2023-11-15 12:40:16.171767
1354	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.96744922761	19136	95760	9336148	597322	9937070	1242739		2023-11-15 12:40:17.002365
1355	P01230	t	f	t	f	f	35 lbs nov.xml	41916	73948.15637429837	33916	84800	2945879	443078	3388837	137459		2023-11-15 12:40:18.538983
1356	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.829469732	4240	95032	3542567	117949	3660516	419808		2023-11-15 12:40:21.19186
1357	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.96744922761	24336	95760	9336148	597322	9937070	1242739		2023-11-15 12:40:22.013513
1358	P01230	t	f	t	f	f	35 lbs nov.xml	41916	73948.15637429837	38916	84800	2945879	443078	3388837	137459		2023-11-15 12:40:23.547192
1359	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.98606973236	9240	95032	3542567	117949	3660516	419813		2023-11-15 12:40:26.195037
1360	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.96744922761	29336	95760	9336148	597322	9937070	1242739		2023-11-15 12:40:27.014228
1361	P01230	t	f	t	f	f	35 lbs nov.xml	41916	73948.15637429837	43916	84800	2945879	443078	3388837	137459		2023-11-15 12:40:28.780029
1362	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.98606973236	14240	95032	3542567	117949	3660516	419813		2023-11-15 12:40:31.196546
1363	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.96744922761	34336	95760	9336148	597322	9937070	1242739		2023-11-15 12:40:32.024176
1364	P01230	t	f	t	f	f	35 lbs nov.xml	41916	73948.15637429837	48916	84800	2945879	443078	3388837	137459		2023-11-15 12:40:33.557998
1365	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.99126973264	19240	95032	3542567	117949	3660516	419816		2023-11-15 12:40:36.197697
1366	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.96744922761	39336	95760	9336148	597322	9937070	1242739		2023-11-15 12:40:37.02939
1367	P01230	t	f	t	f	f	35 lbs nov.xml	41916	73948.15637429837	53916	84800	2945879	443078	3388837	137459		2023-11-15 12:40:38.564647
1368	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.99126973264	24240	95032	3542567	117949	3660516	419816		2023-11-15 12:40:41.206987
1369	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.96744922761	44336	95760	9336148	597322	9937070	1242739		2023-11-15 12:40:42.035788
1370	P01230	t	f	t	f	f	35 lbs nov.xml	41916	73948.15637429837	58916	84800	2945879	443078	3388837	137459		2023-11-15 12:40:43.572764
1371	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.99126973264	29240	95032	3542567	117949	3660516	419816		2023-11-15 12:40:46.364168
1372	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.96744922761	49336	95760	9336148	597322	9937070	1242739		2023-11-15 12:40:47.045434
1373	P01230	t	f	t	f	f	35 lbs nov.xml	41916	73948.15637429837	63916	84800	2945879	443078	3388837	137459		2023-11-15 12:40:48.581347
1374	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.99126973264	34240	95032	3542567	117949	3660516	419816		2023-11-15 12:40:51.230122
1375	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.96744922761	54336	95760	9336148	597322	9937070	1242739		2023-11-15 12:40:52.067926
1376	P01230	t	f	t	f	f	35 lbs nov.xml	41916	73948.15637429837	68916	84800	2945879	443078	3388837	137459		2023-11-15 12:40:53.580188
1377	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.99126973264	39240	95032	3542567	117949	3660516	419816		2023-11-15 12:40:56.229577
1378	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.96744922761	59336	95760	9336148	597322	9937070	1242739		2023-11-15 12:40:57.090234
1379	P01230	t	f	t	f	f	35 lbs nov.xml	41916	73948.15637429837	73916	84800	2945879	443078	3388837	137459		2023-11-15 12:40:58.585484
1380	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.99126973264	44240	95032	3542567	117949	3660516	419816		2023-11-15 12:41:01.251019
1381	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.96744922761	64336	95760	9336148	597322	9937070	1242739		2023-11-15 12:41:02.093675
1382	P01230	t	f	t	f	f	35 lbs nov.xml	41916	73948.15637429837	78916	84800	2945879	443078	3388837	137459		2023-11-15 12:41:03.581509
1383	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.99126973264	49240	95032	3542567	117949	3660516	419816		2023-11-15 12:41:06.26099
1384	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.96744922761	69336	95760	9336148	597322	9937070	1242739		2023-11-15 12:41:07.110001
1385	P01230	t	f	t	f	f	35 lbs nov.xml	41916	73948.79847429878	83916	84800	2945879	443078	3388837	137459		2023-11-15 12:41:08.588168
1386	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.99126973264	54240	95032	3542567	117949	3660516	419816		2023-11-15 12:41:11.264118
1387	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.96744922761	74336	95760	9336148	597322	9937070	1242739		2023-11-15 12:41:12.110496
1388	P01230	t	f	t	f	f	35 lbs nov.xml	41917	73949.44827429802	4116	84796	2945879	443078	3388837	137464		2023-11-15 12:41:13.954629
1389	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.99126973264	59240	95032	3542567	117949	3660516	419816		2023-11-15 12:41:16.267831
1390	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.96744922761	79336	95760	9336148	597322	9937070	1242739		2023-11-15 12:41:17.129666
1391	P01230	t	f	t	f	f	35 lbs nov.xml	41917	73949.49067429955	9116	84796	2945879	443078	3388837	137470		2023-11-15 12:41:18.603512
1392	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.99126973264	64240	95032	3542567	117949	3660516	419816		2023-11-15 12:41:21.278125
1393	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.96744922761	84336	95760	9336148	597322	9937070	1242739		2023-11-15 12:41:22.126372
1394	P01230	t	f	t	f	f	35 lbs nov.xml	41917	73949.49067429955	14116	84796	2945879	443078	3388837	137470		2023-11-15 12:41:23.624175
1395	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.99126973264	69440	95032	3542567	117949	3660516	419816		2023-11-15 12:41:26.465663
1396	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128136.96744922761	89336	95760	9336148	597322	9937070	1242739		2023-11-15 12:41:27.148941
1397	P01230	t	f	t	f	f	35 lbs nov.xml	41917	73949.49537430223	19116	84796	2945879	443078	3388837	137473		2023-11-15 12:41:28.84702
1398	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.99126973264	74440	95032	3542567	117949	3660516	419816		2023-11-15 12:41:31.320943
1399	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87926	128137.66664922841	94336	95760	9336148	597322	9937070	1242739		2023-11-15 12:41:32.135117
1400	P01230	t	f	t	f	f	35 lbs nov.xml	41917	73949.49537430223	24116	84796	2945879	443078	3388837	137473		2023-11-15 12:41:33.645613
1401	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.99126973264	79440	95032	3542567	117949	3660516	419816		2023-11-15 12:41:36.324171
1402	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.30464927416	3584	95748	9336148	597322	9937070	1242744		2023-11-15 12:41:37.150383
1403	P01230	t	f	t	f	f	35 lbs nov.xml	41917	73949.49537430223	29116	84796	2945879	443078	3388837	137473		2023-11-15 12:41:38.654141
1404	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.99126973264	84440	95032	3542567	117949	3660516	419816		2023-11-15 12:41:41.325997
1405	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.45564926462	8584	95748	9336148	597322	9937070	1242750		2023-11-15 12:41:42.156909
1406	P01230	t	f	t	f	f	35 lbs nov.xml	41917	73949.49537430223	34116	84796	2945879	443078	3388837	137473		2023-11-15 12:41:43.663164
1407	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42175.99126973264	89440	95032	3542567	117949	3660516	419816		2023-11-15 12:41:46.447539
1408	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.45594926387	13584	95748	9336148	597322	9937070	1242750		2023-11-15 12:41:47.162459
1409	P01230	t	f	t	f	f	35 lbs nov.xml	41917	73949.49537430223	39116	84796	2945879	443078	3388837	137473		2023-11-15 12:41:48.655546
1410	P01229	t	f	t	f	f	10 lbs octubre.xml	30022	42176.73496973245	94440	95032	3542567	117949	3660516	419816		2023-11-15 12:41:51.340355
1411	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.45694926387	18584	95748	9336148	597322	9937070	1242753		2023-11-15 12:41:52.171514
1412	P01230	t	f	t	f	f	35 lbs nov.xml	41917	73949.49537430223	44116	84796	2945879	443078	3388837	137473		2023-11-15 12:41:53.66924
1413	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.40526978129	4224	95212	3542567	117949	3660516	419822		2023-11-15 12:41:56.350836
1414	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.45694926387	23584	95748	9336148	597322	9937070	1242753		2023-11-15 12:41:57.177876
1415	P01230	t	f	t	f	f	35 lbs nov.xml	41917	73949.49537430223	49116	84796	2945879	443078	3388837	137473		2023-11-15 12:41:59.085368
1416	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.5621697809	9224	95212	3542567	117949	3660516	419827		2023-11-15 12:42:01.349138
1417	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.45694926387	28584	95748	9336148	597322	9937070	1242753		2023-11-15 12:42:02.182857
1418	P01230	t	f	t	f	f	35 lbs nov.xml	41917	73949.49537430223	54116	84796	2945879	443078	3388837	137473		2023-11-15 12:42:03.709904
1419	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.5621697809	14224	95212	3542567	117949	3660516	419827		2023-11-15 12:42:06.362524
1420	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.45694926387	33584	95748	9336148	597322	9937070	1242753		2023-11-15 12:42:07.19198
1421	P01230	t	f	t	f	f	35 lbs nov.xml	41917	73949.49537430223	59316	84796	2945879	443078	3388837	137473		2023-11-15 12:42:08.730049
1422	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.56736978166	19224	95212	3542567	117949	3660516	419830		2023-11-15 12:42:11.371361
1423	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.45694926387	38784	95748	9336148	597322	9937070	1242753		2023-11-15 12:42:12.205875
1424	P01230	t	f	t	f	f	35 lbs nov.xml	41917	73949.49537430223	64316	84796	2945879	443078	3388837	137473		2023-11-15 12:42:14.02221
1425	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.56736978166	24224	95212	3542567	117949	3660516	419830		2023-11-15 12:42:16.375407
1426	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.45694926387	43784	95748	9336148	597322	9937070	1242753		2023-11-15 12:42:17.220792
1427	P01230	t	f	t	f	f	35 lbs nov.xml	41917	73949.49537430223	69316	84796	2945879	443078	3388837	137473		2023-11-15 12:42:18.751057
1428	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.56736978166	29224	95212	3542567	117949	3660516	419830		2023-11-15 12:42:21.492046
1429	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.45694926387	48784	95748	9336148	597322	9937070	1242753		2023-11-15 12:42:22.240159
1430	P01230	t	f	t	f	f	35 lbs nov.xml	41917	73949.49537430223	74316	84796	2945879	443078	3388837	137473		2023-11-15 12:42:23.824675
1431	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.56736978166	34224	95212	3542567	117949	3660516	419830		2023-11-15 12:42:26.512506
1432	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.45694926387	53784	95748	9336148	597322	9937070	1242753		2023-11-15 12:42:27.232299
1433	P01230	t	f	t	f	f	35 lbs nov.xml	41917	73949.49537430223	79316	84796	2945879	443078	3388837	137473		2023-11-15 12:42:29.034407
1434	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.56736978166	39224	95212	3542567	117949	3660516	419830		2023-11-15 12:42:31.386047
1435	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.45694926387	58784	95748	9336148	597322	9937070	1242753		2023-11-15 12:42:32.240777
1436	P01230	t	f	t	f	f	35 lbs nov.xml	41917	73950.150574303	84316	84796	2945879	443078	3388837	137473		2023-11-15 12:42:33.825553
1437	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.56736978166	44224	95212	3542567	117949	3660516	419830		2023-11-15 12:42:36.54836
1438	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.45694926387	63784	95748	9336148	597322	9937070	1242753		2023-11-15 12:42:37.26454
1439	P01230	t	f	t	f	f	35 lbs nov.xml	41918	73950.79827424267	4528	84784	2945879	443078	3388837	137478		2023-11-15 12:42:38.863936
1440	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.56736978166	49224	95212	3542567	117949	3660516	419830		2023-11-15 12:42:41.422451
1441	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.45694926387	68784	95748	9336148	597322	9937070	1242753		2023-11-15 12:42:42.264856
1442	P01230	t	f	t	f	f	35 lbs nov.xml	41918	73950.82937424308	9528	84784	2945879	443078	3388837	137484		2023-11-15 12:42:43.862873
1443	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.56736978166	54224	95212	3542567	117949	3660516	419830		2023-11-15 12:42:46.545558
1444	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.45694926387	73784	95748	9336148	597322	9937070	1242753		2023-11-15 12:42:47.271562
1445	P01230	t	f	t	f	f	35 lbs nov.xml	41918	73950.82937424308	14528	84784	2945879	443078	3388837	137484		2023-11-15 12:42:48.864367
1446	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.56736978166	59224	95212	3542567	117949	3660516	419830		2023-11-15 12:42:51.438403
1447	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.45694926387	78784	95748	9336148	597322	9937070	1242753		2023-11-15 12:42:52.283757
1448	P01230	t	f	t	f	f	35 lbs nov.xml	41918	73950.83407424578	19528	84784	2945879	443078	3388837	137487		2023-11-15 12:42:53.886829
1449	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.56736978166	64224	95212	3542567	117949	3660516	419830		2023-11-15 12:42:56.453053
1450	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.45694926387	83784	95748	9336148	597322	9937070	1242753		2023-11-15 12:42:57.288212
1451	P01230	t	f	t	f	f	35 lbs nov.xml	41918	73950.83407424578	24528	84784	2945879	443078	3388837	137487		2023-11-15 12:42:59.15382
1452	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.56736978166	69224	95212	3542567	117949	3660516	419830		2023-11-15 12:43:01.455027
1453	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128138.45694926387	88784	95748	9336148	597322	9937070	1242753		2023-11-15 12:43:02.302845
1454	P01230	t	f	t	f	f	35 lbs nov.xml	41918	73950.83407424578	29528	84784	2945879	443078	3388837	137487		2023-11-15 12:43:03.890473
1455	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.56736978166	74224	95212	3542567	117949	3660516	419830		2023-11-15 12:43:06.464113
1456	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87927	128139.08664928947	93784	95748	9336148	597322	9937070	1242753		2023-11-15 12:43:07.309478
1457	P01230	t	f	t	f	f	35 lbs nov.xml	41918	73950.83407424578	34528	84784	2945879	443078	3388837	137487		2023-11-15 12:43:08.901683
1458	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.56736978166	79224	95212	3542567	117949	3660516	419830		2023-11-15 12:43:11.47709
1459	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.67884930162	3020	95760	9336148	597322	9937070	1242759		2023-11-15 12:43:12.322917
1460	P01230	t	f	t	f	f	35 lbs nov.xml	41918	73950.83407424578	39528	84784	2945879	443078	3388837	137487		2023-11-15 12:43:14.052461
1461	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.56736978166	84224	95212	3542567	117949	3660516	419830		2023-11-15 12:43:16.479303
1462	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.9457493146	8020	95760	9336148	597322	9937070	1242765		2023-11-15 12:43:17.319916
1463	P01230	t	f	t	f	f	35 lbs nov.xml	41918	73950.83407424578	44728	84784	2945879	443078	3388837	137487		2023-11-15 12:43:18.941042
1464	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42177.56736978166	89224	95212	3542567	117949	3660516	419830		2023-11-15 12:43:21.483098
1465	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.9457493146	13020	95760	9336148	597322	9937070	1242765		2023-11-15 12:43:22.325092
1466	P01230	t	f	t	f	f	35 lbs nov.xml	41918	73950.83407424578	49728	84784	2945879	443078	3388837	137487		2023-11-15 12:43:23.939502
1467	P01229	t	f	t	f	f	10 lbs octubre.xml	30023	42178.30676976985	94224	95212	3542567	117949	3660516	419830		2023-11-15 12:43:26.629252
1468	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.94664931613	18020	95760	9336148	597322	9937070	1242768		2023-11-15 12:43:27.333262
1469	P01230	t	f	t	f	f	35 lbs nov.xml	41918	73950.83407424578	54728	84784	2945879	443078	3388837	137487		2023-11-15 12:43:29.136659
1470	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42178.97056986446	4224	95196	3542567	117949	3660516	419836		2023-11-15 12:43:31.522376
1471	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.94664931613	23020	95760	9336148	597322	9937070	1242768		2023-11-15 12:43:32.355445
1472	P01230	t	f	t	f	f	35 lbs nov.xml	41918	73950.83407424578	59728	84784	2945879	443078	3388837	137487		2023-11-15 12:43:33.951436
1473	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.13946986788	9224	95196	3542567	117949	3660516	419842		2023-11-15 12:43:36.534907
1474	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.94664931613	28020	95760	9336148	597322	9937070	1242768		2023-11-15 12:43:37.446363
1475	P01230	t	f	t	f	f	35 lbs nov.xml	41918	73950.83407424578	64728	84784	2945879	443078	3388837	137487		2023-11-15 12:43:38.971291
1476	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.13946986788	14224	95196	3542567	117949	3660516	419842		2023-11-15 12:43:41.541483
1477	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.94664931613	33020	95760	9336148	597322	9937070	1242768		2023-11-15 12:43:42.369088
1478	P01230	t	f	t	f	f	35 lbs nov.xml	41918	73950.83407424578	69728	84784	2945879	443078	3388837	137487		2023-11-15 12:43:43.981999
1479	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.144369867485	19224	95196	3542567	117949	3660516	419845		2023-11-15 12:43:46.641111
1480	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.94664931613	38020	95760	9336148	597322	9937070	1242768		2023-11-15 12:43:47.374329
1481	P01230	t	f	t	f	f	35 lbs nov.xml	41918	73950.83407424578	74728	84784	2945879	443078	3388837	137487		2023-11-15 12:43:48.984758
1482	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.144369867485	24224	95196	3542567	117949	3660516	419845		2023-11-15 12:43:51.557572
1483	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.94664931613	43020	95760	9336148	597322	9937070	1242768		2023-11-15 12:43:52.397439
1484	P01230	t	f	t	f	f	35 lbs nov.xml	41918	73950.83427424655	79728	84784	2945879	443078	3388837	137487		2023-11-15 12:43:53.9932
1485	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.144369867485	29224	95196	3542567	117949	3660516	419845		2023-11-15 12:43:56.566562
1486	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.94664931613	48020	95760	9336148	597322	9937070	1242768		2023-11-15 12:43:57.561274
1487	P01230	t	f	t	f	f	35 lbs nov.xml	41918	73951.49847421102	84728	84784	2945879	443078	3388837	137487		2023-11-15 12:43:59.207941
1488	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.144369867485	34224	95196	3542567	117949	3660516	419845		2023-11-15 12:44:01.579375
1489	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.94664931613	53220	95760	9336148	597322	9937070	1242768		2023-11-15 12:44:02.409647
1490	P01230	t	f	t	f	f	35 lbs nov.xml	41919	73952.14747419958	4880	84844	2945879	443078	3388837	137492		2023-11-15 12:44:04.02325
1491	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.144369867485	39224	95196	3542567	117949	3660516	419845		2023-11-15 12:44:06.579821
1492	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.94664931613	58220	95760	9336148	597322	9937070	1242768		2023-11-15 12:44:07.412449
1493	P01230	t	f	t	f	f	35 lbs nov.xml	41919	73952.16977419882	9880	84844	2945879	443078	3388837	137497		2023-11-15 12:44:09.040826
1494	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.144369867485	44224	95196	3542567	117949	3660516	419845		2023-11-15 12:44:11.587103
1495	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.94664931613	63220	95760	9336148	597322	9937070	1242768		2023-11-15 12:44:12.608225
1496	P01230	t	f	t	f	f	35 lbs nov.xml	41919	73952.1698741992	14880	84844	2945879	443078	3388837	137497		2023-11-15 12:44:14.485448
1497	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.144369867485	49224	95196	3542567	117949	3660516	419845		2023-11-15 12:44:16.597637
1498	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.94664931613	68220	95760	9336148	597322	9937070	1242768		2023-11-15 12:44:17.42887
1499	P01230	t	f	t	f	f	35 lbs nov.xml	41919	73952.17407420189	19880	84844	2945879	443078	3388837	137500		2023-11-15 12:44:19.079854
1500	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.144369867485	54224	95196	3542567	117949	3660516	419845		2023-11-15 12:44:21.597486
1501	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.94664931613	73220	95760	9336148	597322	9937070	1242768		2023-11-15 12:44:22.443457
1502	P01230	t	f	t	f	f	35 lbs nov.xml	41919	73952.17407420189	24880	84844	2945879	443078	3388837	137500		2023-11-15 12:44:24.08231
1503	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.144369867485	59224	95196	3542567	117949	3660516	419845		2023-11-15 12:44:26.724985
1504	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.94664931613	78220	95760	9336148	597322	9937070	1242768		2023-11-15 12:44:27.479148
1505	P01230	t	f	t	f	f	35 lbs nov.xml	41919	73952.17407420189	29880	84844	2945879	443078	3388837	137500		2023-11-15 12:44:29.283669
1506	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.144369867485	64224	95196	3542567	117949	3660516	419845		2023-11-15 12:44:31.629956
1507	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.94664931613	83220	95760	9336148	597322	9937070	1242768		2023-11-15 12:44:32.475402
1508	P01230	t	f	t	f	f	35 lbs nov.xml	41919	73952.17407420189	34880	84844	2945879	443078	3388837	137500		2023-11-15 12:44:34.085952
1509	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.144369867485	69224	95196	3542567	117949	3660516	419845		2023-11-15 12:44:36.618922
1510	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128139.94664931613	88220	95760	9336148	597322	9937070	1242768		2023-11-15 12:44:37.465031
1511	P01230	t	f	t	f	f	35 lbs nov.xml	41919	73952.17407420189	39880	84844	2945879	443078	3388837	137500		2023-11-15 12:44:39.101271
1512	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.144369867485	74224	95196	3542567	117949	3660516	419845		2023-11-15 12:44:41.635047
1513	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87928	128140.46864929139	93220	95760	9336148	597322	9937070	1242768		2023-11-15 12:44:42.4852
1514	P01230	t	f	t	f	f	35 lbs nov.xml	41919	73952.17407420189	44880	84844	2945879	443078	3388837	137500		2023-11-15 12:44:44.577356
1515	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.144369867485	79224	95196	3542567	117949	3660516	419845		2023-11-15 12:44:46.782719
1516	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.04584930358	2444	95772	9336148	597322	9937070	1242774		2023-11-15 12:44:47.481262
1517	P01230	t	f	t	f	f	35 lbs nov.xml	41919	73952.17407420189	49880	84844	2945879	443078	3388837	137500		2023-11-15 12:44:49.120988
1518	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.144369867485	84224	95196	3542567	117949	3660516	419845		2023-11-15 12:44:51.641354
1519	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.43534929209	7444	95772	9336148	597322	9937070	1242779		2023-11-15 12:44:52.490788
1520	P01230	t	f	t	f	f	35 lbs nov.xml	41919	73952.17407420189	54880	84844	2945879	443078	3388837	137500		2023-11-15 12:44:54.119664
1521	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.144369867485	89224	95196	3542567	117949	3660516	419845		2023-11-15 12:44:56.654798
1522	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.43534929209	12444	95772	9336148	597322	9937070	1242779		2023-11-15 12:44:57.489389
1523	P01230	t	f	t	f	f	35 lbs nov.xml	41919	73952.17407420189	60080	84844	2945879	443078	3388837	137500		2023-11-15 12:44:59.293276
1524	P01229	t	f	t	f	f	10 lbs octubre.xml	30024	42179.88866985578	94224	95196	3542567	117949	3660516	419845		2023-11-15 12:45:01.662323
1525	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.43664929325	17444	95772	9336148	597322	9937070	1242782		2023-11-15 12:45:02.499829
1526	P01230	t	f	t	f	f	35 lbs nov.xml	41919	73952.17407420189	65080	84844	2945879	443078	3388837	137500		2023-11-15 12:45:04.128137
1527	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.54756989543	4088	95132	3542567	117949	3660516	419851		2023-11-15 12:45:07.191602
1528	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.43664929325	22444	95772	9336148	597322	9937070	1242782		2023-11-15 12:45:07.51004
1529	P01230	t	f	t	f	f	35 lbs nov.xml	41919	73952.17407420189	70080	84844	2945879	443078	3388837	137500		2023-11-15 12:45:09.142416
1530	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.715669904865	9088	95132	3542567	117949	3660516	419857		2023-11-15 12:45:11.702209
1531	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.43664929325	27444	95772	9336148	597322	9937070	1242782		2023-11-15 12:45:12.523021
1532	P01230	t	f	t	f	f	35 lbs nov.xml	41919	73952.17407420189	75080	84844	2945879	443078	3388837	137500		2023-11-15 12:45:14.744604
1533	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.715669904865	14288	95132	3542567	117949	3660516	419857		2023-11-15 12:45:16.791215
1534	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.43664929325	32444	95772	9336148	597322	9937070	1242782		2023-11-15 12:45:17.522935
1535	P01230	t	f	t	f	f	35 lbs nov.xml	41919	73952.17567420228	80080	84844	2945879	443078	3388837	137500		2023-11-15 12:45:19.19652
1536	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.7212699062	19288	95132	3542567	117949	3660516	419861		2023-11-15 12:45:21.793867
1537	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.43664929325	37444	95772	9336148	597322	9937070	1242782		2023-11-15 12:45:22.538878
1538	P01230	t	f	t	f	f	35 lbs nov.xml	41920	73952.84367417742	160	84916	2945879	443078	3388837	137505		2023-11-15 12:45:24.197952
1539	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.7212699062	24288	95132	3542567	117949	3660516	419861		2023-11-15 12:45:27.086085
1540	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.43664929325	42444	95772	9336148	597322	9937070	1242782		2023-11-15 12:45:27.564858
1541	P01230	t	f	t	f	f	35 lbs nov.xml	41920	73953.49667416597	5160	84916	2945879	443078	3388837	137505		2023-11-15 12:45:29.214417
1542	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.7212699062	29288	95132	3542567	117949	3660516	419861		2023-11-15 12:45:31.817401
1543	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.43664929325	47444	95772	9336148	597322	9937070	1242782		2023-11-15 12:45:32.570813
1544	P01230	t	f	t	f	f	35 lbs nov.xml	41920	73953.51077416445	10160	84916	2945879	443078	3388837	137510		2023-11-15 12:45:34.242348
1545	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.7212699062	34288	95132	3542567	117949	3660516	419861		2023-11-15 12:45:36.830505
1546	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.43664929325	52444	95772	9336148	597322	9937070	1242782		2023-11-15 12:45:37.588224
1547	P01230	t	f	t	f	f	35 lbs nov.xml	41920	73953.51127416636	15160	84916	2945879	443078	3388837	137510		2023-11-15 12:45:39.253668
1548	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.7212699062	39288	95132	3542567	117949	3660516	419861		2023-11-15 12:45:41.840823
1549	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.43664929325	57444	95772	9336148	597322	9937070	1242782		2023-11-15 12:45:42.5893
1550	P01230	t	f	t	f	f	35 lbs nov.xml	41920	73953.5152741683	20160	84916	2945879	443078	3388837	137513		2023-11-15 12:45:44.469311
1551	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.7212699062	44288	95132	3542567	117949	3660516	419861		2023-11-15 12:45:47.01437
1552	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.43664929325	62444	95772	9336148	597322	9937070	1242782		2023-11-15 12:45:47.593459
1553	P01230	t	f	t	f	f	35 lbs nov.xml	41920	73953.5152741683	25160	84916	2945879	443078	3388837	137513		2023-11-15 12:45:49.308533
1554	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.7212699062	49288	95132	3542567	117949	3660516	419861		2023-11-15 12:45:51.845458
1555	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.43664929325	67444	95772	9336148	597322	9937070	1242782		2023-11-15 12:45:52.606608
1556	P01230	t	f	t	f	f	35 lbs nov.xml	41920	73953.5152741683	30160	84916	2945879	443078	3388837	137513		2023-11-15 12:45:54.322543
1557	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.7212699062	54288	95132	3542567	117949	3660516	419861		2023-11-15 12:45:56.858384
1558	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.43664929325	72444	95772	9336148	597322	9937070	1242782		2023-11-15 12:45:57.606861
1559	P01230	t	f	t	f	f	35 lbs nov.xml	41920	73953.5152741683	35160	84916	2945879	443078	3388837	137513		2023-11-15 12:45:59.522827
1560	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.7212699062	59288	95132	3542567	117949	3660516	419861		2023-11-15 12:46:01.86508
1561	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.43664929325	77644	95772	9336148	597322	9937070	1242782		2023-11-15 12:46:02.614408
1562	P01230	t	f	t	f	f	35 lbs nov.xml	41920	73953.5152741683	40360	84916	2945879	443078	3388837	137513		2023-11-15 12:46:04.326534
1563	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.7212699062	64288	95132	3542567	117949	3660516	419861		2023-11-15 12:46:07.368912
1564	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.43664929325	82644	95772	9336148	597322	9937070	1242782		2023-11-15 12:46:07.627079
1565	P01230	t	f	t	f	f	35 lbs nov.xml	41920	73953.5152741683	45360	84916	2945879	443078	3388837	137513		2023-11-15 12:46:09.327934
1566	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.7212699062	69288	95132	3542567	117949	3660516	419861		2023-11-15 12:46:11.881898
1567	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.43664929325	87644	95772	9336148	597322	9937070	1242782		2023-11-15 12:46:12.629039
1568	P01230	t	f	t	f	f	35 lbs nov.xml	41920	73953.5152741683	50360	84916	2945879	443078	3388837	137513		2023-11-15 12:46:14.713236
1569	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.7212699062	74288	95132	3542567	117949	3660516	419861		2023-11-15 12:46:16.88714
1570	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87929	128141.83574930504	92644	95772	9336148	597322	9937070	1242782		2023-11-15 12:46:17.638749
1571	P01230	t	f	t	f	f	35 lbs nov.xml	41920	73953.5152741683	55360	84916	2945879	443078	3388837	137513		2023-11-15 12:46:19.405132
1572	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.7212699062	79288	95132	3542567	117949	3660516	419861		2023-11-15 12:46:21.898476
1573	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.41214932942	1864	95776	9336148	597322	9937070	1242787		2023-11-15 12:46:22.722204
1574	P01230	t	f	t	f	f	35 lbs nov.xml	41920	73953.5152741683	60360	84916	2945879	443078	3388837	137513		2023-11-15 12:46:24.395697
1575	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.7212699062	84488	95132	3542567	117949	3660516	419861		2023-11-15 12:46:27.040503
1576	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.92424928017	6864	95776	9336148	597322	9937070	1242792		2023-11-15 12:46:27.654225
1577	P01230	t	f	t	f	f	35 lbs nov.xml	41920	73953.5152741683	65360	84916	2945879	443078	3388837	137513		2023-11-15 12:46:29.39588
1578	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42180.7212699062	89488	95132	3542567	117949	3660516	419861		2023-11-15 12:46:31.925308
1579	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.92424928017	11864	95776	9336148	597322	9937070	1242792		2023-11-15 12:46:32.673909
1580	P01230	t	f	t	f	f	35 lbs nov.xml	41920	73953.5152741683	70360	84916	2945879	443078	3388837	137513		2023-11-15 12:46:34.409923
1581	P01229	t	f	t	f	f	10 lbs octubre.xml	30025	42181.46546988266	94488	95132	3542567	117949	3660516	419861		2023-11-15 12:46:36.933683
1582	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.92564928171	16864	95776	9336148	597322	9937070	1242795		2023-11-15 12:46:37.683499
1583	P01230	t	f	t	f	f	35 lbs nov.xml	41920	73953.5152741683	75360	84916	2945879	443078	3388837	137513		2023-11-15 12:46:39.424639
1584	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.12496994366	4212	95272	3542567	117949	3660516	419866		2023-11-15 12:46:41.940409
1585	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.92564928171	21864	95776	9336148	597322	9937070	1242795		2023-11-15 12:46:42.693519
1586	P01230	t	f	t	f	f	35 lbs nov.xml	41920	73953.55557417327	80360	84916	2945879	443078	3388837	137513		2023-11-15 12:46:44.640859
1587	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.29326994338	9212	95272	3542567	117949	3660516	419872		2023-11-15 12:46:46.947408
1588	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.92564928171	26864	95776	9336148	597322	9937070	1242795		2023-11-15 12:46:47.717967
1589	P01230	t	f	t	f	f	35 lbs nov.xml	41921	73954.19317413356	604	84752	2945879	443078	3388837	137519		2023-11-15 12:46:49.452197
1590	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.29326994338	14212	95272	3542567	117949	3660516	419872		2023-11-15 12:46:51.947544
1591	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.92564928171	31864	95776	9336148	597322	9937070	1242795		2023-11-15 12:46:52.725802
1592	P01230	t	f	t	f	f	35 lbs nov.xml	41921	73954.84977409583	5604	84752	2945879	443078	3388837	137524		2023-11-15 12:46:54.458149
1593	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.29866994298	19212	95272	3542567	117949	3660516	419876		2023-11-15 12:46:56.94999
1594	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.92564928171	36864	95776	9336148	597322	9937070	1242795		2023-11-15 12:46:57.735699
1595	P01230	t	f	t	f	f	35 lbs nov.xml	41921	73954.84977409583	10604	84752	2945879	443078	3388837	137524		2023-11-15 12:46:59.649145
1596	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.29866994298	24212	95272	3542567	117949	3660516	419876		2023-11-15 12:47:01.965115
1597	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.92564928171	41864	95776	9336148	597322	9937070	1242795		2023-11-15 12:47:02.738267
1598	P01230	t	f	t	f	f	35 lbs nov.xml	41921	73954.85187409623	15604	84752	2945879	443078	3388837	137524		2023-11-15 12:47:04.477673
1599	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.29866994298	29212	95272	3542567	117949	3660516	419876		2023-11-15 12:47:07.093567
1600	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.92564928171	46864	95776	9336148	597322	9937070	1242795		2023-11-15 12:47:07.743506
1601	P01230	t	f	t	f	f	35 lbs nov.xml	41921	73954.85437409813	20604	84752	2945879	443078	3388837	137528		2023-11-15 12:47:09.492822
1602	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.29866994298	34212	95272	3542567	117949	3660516	419876		2023-11-15 12:47:11.968188
1603	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.92564928171	51864	95776	9336148	597322	9937070	1242795		2023-11-15 12:47:12.761353
1604	P01230	t	f	t	f	f	35 lbs nov.xml	41921	73954.85437409813	25604	84752	2945879	443078	3388837	137528		2023-11-15 12:47:14.831701
1605	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.29866994298	39212	95272	3542567	117949	3660516	419876		2023-11-15 12:47:16.973692
1606	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.92564928171	56864	95776	9336148	597322	9937070	1242795		2023-11-15 12:47:17.813727
1607	P01230	t	f	t	f	f	35 lbs nov.xml	41921	73954.85437409813	30604	84752	2945879	443078	3388837	137528		2023-11-15 12:47:19.512656
1608	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.29866994298	44212	95272	3542567	117949	3660516	419876		2023-11-15 12:47:21.988938
1609	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.92564928171	61864	95776	9336148	597322	9937070	1242795		2023-11-15 12:47:22.779682
1610	P01230	t	f	t	f	f	35 lbs nov.xml	41921	73954.85437409813	35804	84752	2945879	443078	3388837	137528		2023-11-15 12:47:24.527773
1611	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.29866994298	49212	95272	3542567	117949	3660516	419876		2023-11-15 12:47:27.344407
1612	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.92564928171	66864	95776	9336148	597322	9937070	1242795		2023-11-15 12:47:27.775362
1613	P01230	t	f	t	f	f	35 lbs nov.xml	41921	73954.85437409813	40804	84752	2945879	443078	3388837	137528		2023-11-15 12:47:29.83575
1614	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.29866994298	54212	95272	3542567	117949	3660516	419876		2023-11-15 12:47:32.009334
1615	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.92564928171	71864	95776	9336148	597322	9937070	1242795		2023-11-15 12:47:32.785489
1616	P01230	t	f	t	f	f	35 lbs nov.xml	41921	73954.85437409813	45804	84752	2945879	443078	3388837	137528		2023-11-15 12:47:34.54635
1617	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.29866994298	59212	95272	3542567	117949	3660516	419876		2023-11-15 12:47:37.011541
1618	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.92564928171	76864	95776	9336148	597322	9937070	1242795		2023-11-15 12:47:37.801961
1619	P01230	t	f	t	f	f	35 lbs nov.xml	41921	73954.85437409813	50804	84752	2945879	443078	3388837	137528		2023-11-15 12:47:39.727409
1620	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.29866994298	64212	95272	3542567	117949	3660516	419876		2023-11-15 12:47:42.014975
1621	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.92564928171	82064	95776	9336148	597322	9937070	1242795		2023-11-15 12:47:42.815454
1622	P01230	t	f	t	f	f	35 lbs nov.xml	41921	73954.85437409813	55804	84752	2945879	443078	3388837	137528		2023-11-15 12:47:44.734386
1623	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.29866994298	69212	95272	3542567	117949	3660516	419876		2023-11-15 12:47:47.016095
1624	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128142.92564928171	87064	95776	9336148	597322	9937070	1242795		2023-11-15 12:47:47.81771
1625	P01230	t	f	t	f	f	35 lbs nov.xml	41921	73954.85437409813	60804	84752	2945879	443078	3388837	137528		2023-11-15 12:47:49.555556
1626	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.29866994298	74212	95272	3542567	117949	3660516	419876		2023-11-15 12:47:52.023767
1627	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87930	128143.18964929317	92064	95776	9336148	597322	9937070	1242795		2023-11-15 12:47:52.830832
1628	P01230	t	f	t	f	f	35 lbs nov.xml	41921	73954.85437409813	65804	84752	2945879	443078	3388837	137528		2023-11-15 12:47:54.78144
1629	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.29866994298	79212	95272	3542567	117949	3660516	419876		2023-11-15 12:47:57.044479
1630	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128143.76704925657	1256	95804	9336148	597322	9937070	1242800		2023-11-15 12:47:57.825813
1631	P01230	t	f	t	f	f	35 lbs nov.xml	41921	73954.85437409813	70804	84752	2945879	443078	3388837	137528		2023-11-15 12:47:59.745095
1632	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.29866994298	84212	95272	3542567	117949	3660516	419876		2023-11-15 12:48:02.046635
1633	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.41544924473	6256	95804	9336148	597322	9937070	1242805		2023-11-15 12:48:02.847307
1634	P01230	t	f	t	f	f	35 lbs nov.xml	41921	73954.85437409813	75804	84752	2945879	443078	3388837	137528		2023-11-15 12:48:04.583813
1635	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42182.29866994298	89212	95272	3542567	117949	3660516	419876		2023-11-15 12:48:07.308405
1636	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.41544924473	11256	95804	9336148	597322	9937070	1242805		2023-11-15 12:48:07.851609
1637	P01230	t	f	t	f	f	35 lbs nov.xml	41921	73954.93187410006	80804	84752	2945879	443078	3388837	137528		2023-11-15 12:48:09.853091
1638	P01229	t	f	t	f	f	10 lbs octubre.xml	30026	42183.038069931186	94212	95272	3542567	117949	3660516	419876		2023-11-15 12:48:12.067348
1639	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.41714924549	16256	95804	9336148	597322	9937070	1242808		2023-11-15 12:48:12.869136
1640	P01230	t	f	t	f	f	35 lbs nov.xml	41922	73955.55327406335	884	84916	2945879	443078	3388837	137533		2023-11-15 12:48:14.59629
1641	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.690169906775	4020	95188	3542567	117949	3660516	419881		2023-11-15 12:48:17.076205
1642	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.41714924549	21256	95804	9336148	597322	9937070	1242808		2023-11-15 12:48:17.88074
1643	P01230	t	f	t	f	f	35 lbs nov.xml	41922	73956.1909740756	5884	84916	2945879	443078	3388837	137538		2023-11-15 12:48:19.611165
1644	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.87176991907	9020	95188	3542567	117949	3660516	419886		2023-11-15 12:48:22.095746
1645	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.41714924549	26256	95804	9336148	597322	9937070	1242808		2023-11-15 12:48:22.880251
1646	P01230	t	f	t	f	f	35 lbs nov.xml	41922	73956.1909740756	10884	84916	2945879	443078	3388837	137538		2023-11-15 12:48:24.619229
1647	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.87176991907	14020	95188	3542567	117949	3660516	419886		2023-11-15 12:48:27.302866
1648	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.41714924549	31256	95804	9336148	597322	9937070	1242808		2023-11-15 12:48:27.901698
1649	P01230	t	f	t	f	f	35 lbs nov.xml	41922	73956.19497407753	15884	84916	2945879	443078	3388837	137538		2023-11-15 12:48:29.828972
1650	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.87646992031	19020	95188	3542567	117949	3660516	419890		2023-11-15 12:48:32.103914
1651	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.41714924549	36256	95804	9336148	597322	9937070	1242808		2023-11-15 12:48:32.906155
1652	P01230	t	f	t	f	f	35 lbs nov.xml	41922	73956.19597407755	20884	84916	2945879	443078	3388837	137542		2023-11-15 12:48:34.877715
1653	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.87646992031	24220	95188	3542567	117949	3660516	419890		2023-11-15 12:48:37.132196
1654	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.41714924549	41256	95804	9336148	597322	9937070	1242808		2023-11-15 12:48:37.912524
1655	P01230	t	f	t	f	f	35 lbs nov.xml	41922	73956.19597407755	25884	84916	2945879	443078	3388837	137542		2023-11-15 12:48:39.848511
1656	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.87646992031	29220	95188	3542567	117949	3660516	419890		2023-11-15 12:48:42.137902
1657	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.41714924549	46256	95804	9336148	597322	9937070	1242808		2023-11-15 12:48:42.915389
1658	P01230	t	f	t	f	f	35 lbs nov.xml	41922	73956.19597407755	30884	84916	2945879	443078	3388837	137542		2023-11-15 12:48:44.913345
1659	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.87646992031	34220	95188	3542567	117949	3660516	419890		2023-11-15 12:48:47.15093
1660	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.41714924549	51256	95804	9336148	597322	9937070	1242808		2023-11-15 12:48:47.928884
1661	P01230	t	f	t	f	f	35 lbs nov.xml	41922	73956.19597407755	35884	84916	2945879	443078	3388837	137542		2023-11-15 12:48:49.688272
1662	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.87646992031	39220	95188	3542567	117949	3660516	419890		2023-11-15 12:48:52.161672
1663	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.41714924549	56256	95804	9336148	597322	9937070	1242808		2023-11-15 12:48:52.928627
1664	P01230	t	f	t	f	f	35 lbs nov.xml	41922	73956.19597407755	40884	84916	2945879	443078	3388837	137542		2023-11-15 12:48:54.910615
1665	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.87646992031	44220	95188	3542567	117949	3660516	419890		2023-11-15 12:48:57.175411
1666	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.41714924549	61256	95804	9336148	597322	9937070	1242808		2023-11-15 12:48:57.943575
1667	P01230	t	f	t	f	f	35 lbs nov.xml	41922	73956.19597407755	45884	84916	2945879	443078	3388837	137542		2023-11-15 12:48:59.890252
1668	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.87646992031	49220	95188	3542567	117949	3660516	419890		2023-11-15 12:49:02.186773
1669	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.41714924549	66256	95804	9336148	597322	9937070	1242808		2023-11-15 12:49:02.958373
1670	P01230	t	f	t	f	f	35 lbs nov.xml	41922	73956.19597407755	51084	84916	2945879	443078	3388837	137542		2023-11-15 12:49:05.058012
1671	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.87646992031	54220	95188	3542567	117949	3660516	419890		2023-11-15 12:49:07.285253
1672	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.41714924549	71256	95804	9336148	597322	9937070	1242808		2023-11-15 12:49:07.969566
1673	P01230	t	f	t	f	f	35 lbs nov.xml	41922	73956.19597407755	56084	84916	2945879	443078	3388837	137542		2023-11-15 12:49:09.759977
1674	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.87646992031	59220	95188	3542567	117949	3660516	419890		2023-11-15 12:49:12.20522
1675	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.41714924549	76256	95804	9336148	597322	9937070	1242808		2023-11-15 12:49:12.97954
1676	P01230	t	f	t	f	f	35 lbs nov.xml	41922	73956.19597407755	61084	84916	2945879	443078	3388837	137542		2023-11-15 12:49:14.763672
1677	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.87646992031	64220	95188	3542567	117949	3660516	419890		2023-11-15 12:49:17.226075
1678	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.41714924549	81256	95804	9336148	597322	9937070	1242808		2023-11-15 12:49:17.977825
1679	P01230	t	f	t	f	f	35 lbs nov.xml	41922	73956.19597407755	66084	84916	2945879	443078	3388837	137542		2023-11-15 12:49:19.985946
1680	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.87646992031	69220	95188	3542567	117949	3660516	419890		2023-11-15 12:49:22.234744
1681	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.41714924549	86256	95804	9336148	597322	9937070	1242808		2023-11-15 12:49:22.982323
1682	P01230	t	f	t	f	f	35 lbs nov.xml	41922	73956.19597407755	71084	84916	2945879	443078	3388837	137542		2023-11-15 12:49:25.032183
1683	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.87646992031	74220	95188	3542567	117949	3660516	419890		2023-11-15 12:49:27.329114
1684	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87931	128144.55814923978	91256	95804	9336148	597322	9937070	1242808		2023-11-15 12:49:27.98919
1685	P01230	t	f	t	f	f	35 lbs nov.xml	41922	73956.19597407755	76084	84916	2945879	443078	3388837	137542		2023-11-15 12:49:30.018396
1686	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.87646992031	79220	95188	3542567	117949	3660516	419890		2023-11-15 12:49:32.251925
1687	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.1775492337	468	95784	9336148	597322	9937070	1242813		2023-11-15 12:49:33.010354
1688	P01230	t	f	t	f	f	35 lbs nov.xml	41922	73956.34507407412	81084	84916	2945879	443078	3388837	137542		2023-11-15 12:49:35.066069
1689	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.87646992031	84220	95188	3542567	117949	3660516	419890		2023-11-15 12:49:37.262999
1690	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.9057492821	5668	95784	9336148	597322	9937070	1242819		2023-11-15 12:49:38.024084
1691	P01230	t	f	t	f	f	35 lbs nov.xml	41923	73956.94537415341	1240	84840	2945879	443078	3388837	137547		2023-11-15 12:49:40.106062
1692	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42183.87646992031	89220	95188	3542567	117949	3660516	419890		2023-11-15 12:49:42.275674
1693	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.9057492821	10668	95784	9336148	597322	9937070	1242819		2023-11-15 12:49:43.030587
1694	P01230	t	f	t	f	f	35 lbs nov.xml	41923	73957.53137415342	6240	84840	2945879	443078	3388837	137553		2023-11-15 12:49:45.013655
1695	P01229	t	f	t	f	f	10 lbs octubre.xml	30027	42184.634169920595	94220	95188	3542567	117949	3660516	419890		2023-11-15 12:49:47.287362
1696	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.90724928594	15668	95784	9336148	597322	9937070	1242819		2023-11-15 12:49:48.037151
1697	P01230	t	f	t	f	f	35 lbs nov.xml	41923	73957.53137415342	11240	84840	2945879	443078	3388837	137553		2023-11-15 12:49:49.837229
1698	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.33457006709	4324	94892	3542567	117949	3660516	419895		2023-11-15 12:49:52.292306
1699	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.90724928594	20668	95784	9336148	597322	9937070	1242821		2023-11-15 12:49:53.047432
1700	P01230	t	f	t	f	f	35 lbs nov.xml	41923	73957.53547415571	16240	84840	2945879	443078	3388837	137553		2023-11-15 12:49:55.039795
1701	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.44807006662	9524	94892	3542567	117949	3660516	419901		2023-11-15 12:49:57.307622
1702	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.90724928594	25668	95784	9336148	597322	9937070	1242821		2023-11-15 12:49:58.084198
1703	P01230	t	f	t	f	f	35 lbs nov.xml	41923	73957.53597415572	21240	84840	2945879	443078	3388837	137556		2023-11-15 12:50:00.057219
1704	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.44807006662	14524	94892	3542567	117949	3660516	419901		2023-11-15 12:50:02.329515
1705	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.90724928594	30668	95784	9336148	597322	9937070	1242821		2023-11-15 12:50:03.084894
1706	P01230	t	f	t	f	f	35 lbs nov.xml	41923	73957.53597415572	26240	84840	2945879	443078	3388837	137556		2023-11-15 12:50:04.85865
1707	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.45377006832	19524	94892	3542567	117949	3660516	419905		2023-11-15 12:50:07.433326
1708	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.90724928594	35668	95784	9336148	597322	9937070	1242821		2023-11-15 12:50:08.091163
1709	P01230	t	f	t	f	f	35 lbs nov.xml	41923	73957.53597415572	31240	84840	2945879	443078	3388837	137556		2023-11-15 12:50:09.871259
1710	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.45377006832	24524	94892	3542567	117949	3660516	419905		2023-11-15 12:50:12.350724
1711	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.90724928594	40668	95784	9336148	597322	9937070	1242821		2023-11-15 12:50:13.090814
1712	P01230	t	f	t	f	f	35 lbs nov.xml	41923	73957.53597415572	36240	84840	2945879	443078	3388837	137556		2023-11-15 12:50:15.165018
1713	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.45377006832	29524	94892	3542567	117949	3660516	419905		2023-11-15 12:50:17.353092
1714	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.90724928594	45668	95784	9336148	597322	9937070	1242821		2023-11-15 12:50:18.097455
1715	P01230	t	f	t	f	f	35 lbs nov.xml	41923	73957.53597415572	41240	84840	2945879	443078	3388837	137556		2023-11-15 12:50:20.105657
1716	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.45377006832	34524	94892	3542567	117949	3660516	419905		2023-11-15 12:50:22.376874
1717	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.90724928594	50668	95784	9336148	597322	9937070	1242821		2023-11-15 12:50:23.097567
1718	P01230	t	f	t	f	f	35 lbs nov.xml	41923	73957.53597415572	46240	84840	2945879	443078	3388837	137556		2023-11-15 12:50:25.106271
1719	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.45377006832	39524	94892	3542567	117949	3660516	419905		2023-11-15 12:50:27.479072
1720	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.90724928594	55668	95784	9336148	597322	9937070	1242821		2023-11-15 12:50:28.105764
1721	P01230	t	f	t	f	f	35 lbs nov.xml	41923	73957.53597415572	51240	84840	2945879	443078	3388837	137556		2023-11-15 12:50:30.107029
1722	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.45377006832	44524	94892	3542567	117949	3660516	419905		2023-11-15 12:50:32.390948
1723	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.90724928594	60668	95784	9336148	597322	9937070	1242821		2023-11-15 12:50:33.121801
1724	P01230	t	f	t	f	f	35 lbs nov.xml	41923	73957.53597415572	56240	84840	2945879	443078	3388837	137556		2023-11-15 12:50:35.490507
1725	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.45377006832	49524	94892	3542567	117949	3660516	419905		2023-11-15 12:50:37.403761
1726	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.90724928594	65668	95784	9336148	597322	9937070	1242821		2023-11-15 12:50:38.122657
1727	P01230	t	f	t	f	f	35 lbs nov.xml	41923	73957.53597415572	61440	84840	2945879	443078	3388837	137556		2023-11-15 12:50:40.115128
1728	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.45377006832	54524	94892	3542567	117949	3660516	419905		2023-11-15 12:50:42.405059
1729	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.90724928594	70668	95784	9336148	597322	9937070	1242821		2023-11-15 12:50:43.1431
1730	P01230	t	f	t	f	f	35 lbs nov.xml	41923	73957.53597415572	66440	84840	2945879	443078	3388837	137556		2023-11-15 12:50:44.946565
1731	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.45377006832	59524	94892	3542567	117949	3660516	419905		2023-11-15 12:50:47.459348
1732	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.90724928594	75668	95784	9336148	597322	9937070	1242821		2023-11-15 12:50:48.135128
1733	P01230	t	f	t	f	f	35 lbs nov.xml	41923	73957.53597415572	71440	84840	2945879	443078	3388837	137556		2023-11-15 12:50:50.193389
1734	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.45377006832	64524	94892	3542567	117949	3660516	419905		2023-11-15 12:50:52.463526
1735	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.90724928594	80668	95784	9336148	597322	9937070	1242821		2023-11-15 12:50:53.153494
1736	P01230	t	f	t	f	f	35 lbs nov.xml	41923	73957.53597415572	76440	84840	2945879	443078	3388837	137556		2023-11-15 12:50:55.354387
1737	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.45377006832	69524	94892	3542567	117949	3660516	419905		2023-11-15 12:50:57.469747
1738	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.90724928594	85668	95784	9336148	597322	9937070	1242821		2023-11-15 12:50:58.159689
1739	P01230	t	f	t	f	f	35 lbs nov.xml	41923	73957.73447416333	81440	84840	2945879	443078	3388837	137556		2023-11-15 12:50:59.973778
1740	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.45377006832	74524	94892	3542567	117949	3660516	419905		2023-11-15 12:51:02.481705
1741	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87932	128145.93574928596	90668	95784	9336148	597322	9937070	1242821		2023-11-15 12:51:03.18663
1742	P01230	t	f	t	f	f	35 lbs nov.xml	41924	73958.33377412059	1516	84920	2945879	443078	3388837	137561		2023-11-15 12:51:04.978087
1743	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.45377006832	79524	94892	3542567	117949	3660516	419905		2023-11-15 12:51:07.65275
1744	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128146.6515492986	95668	95784	9336148	597322	9937070	1242827		2023-11-15 12:51:08.188384
1745	P01230	t	f	t	f	f	35 lbs nov.xml	41924	73958.87307408558	6516	84920	2945879	443078	3388837	137567		2023-11-15 12:51:10.246462
1746	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.45377006832	84524	94892	3542567	117949	3660516	419905		2023-11-15 12:51:12.497749
1747	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.36874934702	4848	95816	9336148	597322	9937070	1242827		2023-11-15 12:51:13.201397
1748	P01230	t	f	t	f	f	35 lbs nov.xml	41924	73958.87307408558	11516	84920	2945879	443078	3388837	137567		2023-11-15 12:51:15.182847
1749	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42185.45597006861	89524	94892	3542567	117949	3660516	419905		2023-11-15 12:51:17.501852
1750	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.39614934854	9848	95816	9336148	597322	9937070	1242833		2023-11-15 12:51:18.212465
1751	P01230	t	f	t	f	f	35 lbs nov.xml	41924	73958.87707408749	16516	84920	2945879	443078	3388837	137567		2023-11-15 12:51:20.599955
1752	P01229	t	f	t	f	f	10 lbs octubre.xml	30028	42186.219870069195	94724	94892	3542567	117949	3660516	419905		2023-11-15 12:51:22.615424
1753	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.39764935237	15048	95816	9336148	597322	9937070	1242833		2023-11-15 12:51:23.221589
1754	P01230	t	f	t	f	f	35 lbs nov.xml	41924	73958.87707408749	21516	84920	2945879	443078	3388837	137570		2023-11-15 12:51:25.249186
1755	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42186.94087011493	4680	95040	3542567	117949	3660516	419910		2023-11-15 12:51:27.523446
1756	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.39764935237	20048	95816	9336148	597322	9937070	1242836		2023-11-15 12:51:28.253629
1757	P01230	t	f	t	f	f	35 lbs nov.xml	41924	73958.87707408749	26516	84920	2945879	443078	3388837	137570		2023-11-15 12:51:30.251003
1758	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.02627011834	9680	95040	3542567	117949	3660516	419916		2023-11-15 12:51:32.544947
1759	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.39764935237	25048	95816	9336148	597322	9937070	1242836		2023-11-15 12:51:33.268506
1760	P01230	t	f	t	f	f	35 lbs nov.xml	41924	73958.87707408749	31516	84920	2945879	443078	3388837	137570		2023-11-15 12:51:35.280367
1761	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.02627011834	14680	95040	3542567	117949	3660516	419916		2023-11-15 12:51:37.560035
1762	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.39764935237	30048	95816	9336148	597322	9937070	1242836		2023-11-15 12:51:38.280303
1763	P01230	t	f	t	f	f	35 lbs nov.xml	41924	73958.87707408749	36516	84920	2945879	443078	3388837	137570		2023-11-15 12:51:40.255011
1764	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.03197011908	19680	95040	3542567	117949	3660516	419919		2023-11-15 12:51:42.705907
1765	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.39764935237	35048	95816	9336148	597322	9937070	1242836		2023-11-15 12:51:43.275995
1766	P01230	t	f	t	f	f	35 lbs nov.xml	41924	73958.87707408749	41516	84920	2945879	443078	3388837	137570		2023-11-15 12:51:45.062305
1767	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.03197011908	24680	95040	3542567	117949	3660516	419919		2023-11-15 12:51:47.571713
1768	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.39764935237	40048	95816	9336148	597322	9937070	1242836		2023-11-15 12:51:48.281921
1769	P01230	t	f	t	f	f	35 lbs nov.xml	41924	73958.87707408749	46516	84920	2945879	443078	3388837	137570		2023-11-15 12:51:50.591562
1770	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.03197011908	29680	95040	3542567	117949	3660516	419919		2023-11-15 12:51:52.686999
1771	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.39764935237	45048	95816	9336148	597322	9937070	1242836		2023-11-15 12:51:53.29098
1772	P01230	t	f	t	f	f	35 lbs nov.xml	41924	73958.87707408749	51516	84920	2945879	443078	3388837	137570		2023-11-15 12:51:55.089766
1773	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.03197011908	34680	95040	3542567	117949	3660516	419919		2023-11-15 12:51:57.594798
1774	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.39764935237	50048	95816	9336148	597322	9937070	1242836		2023-11-15 12:51:58.29296
1775	P01230	t	f	t	f	f	35 lbs nov.xml	41924	73958.87707408749	56516	84920	2945879	443078	3388837	137570		2023-11-15 12:52:00.107259
1776	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.03197011908	39680	95040	3542567	117949	3660516	419919		2023-11-15 12:52:02.601284
1777	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.39764935237	55048	95816	9336148	597322	9937070	1242836		2023-11-15 12:52:03.29894
1778	P01230	t	f	t	f	f	35 lbs nov.xml	41924	73958.87707408749	61516	84920	2945879	443078	3388837	137570		2023-11-15 12:52:05.384485
1779	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.03197011908	44680	95040	3542567	117949	3660516	419919		2023-11-15 12:52:07.73017
1780	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.39764935237	60048	95816	9336148	597322	9937070	1242836		2023-11-15 12:52:08.297579
1781	P01230	t	f	t	f	f	35 lbs nov.xml	41924	73958.87707408749	66716	84920	2945879	443078	3388837	137570		2023-11-15 12:52:10.578442
1782	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.03197011908	49680	95040	3542567	117949	3660516	419919		2023-11-15 12:52:12.729789
1783	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.39764935237	65048	95816	9336148	597322	9937070	1242836		2023-11-15 12:52:13.306844
1784	P01230	t	f	t	f	f	35 lbs nov.xml	41924	73958.87707408749	71716	84920	2945879	443078	3388837	137570		2023-11-15 12:52:15.147688
1785	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.03197011908	54680	95040	3542567	117949	3660516	419919		2023-11-15 12:52:17.62038
1786	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.39764935237	70048	95816	9336148	597322	9937070	1242836		2023-11-15 12:52:18.322335
1787	P01230	t	f	t	f	f	35 lbs nov.xml	41924	73958.87707408749	76716	84920	2945879	443078	3388837	137570		2023-11-15 12:52:20.384388
1788	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.03197011908	59680	95040	3542567	117949	3660516	419919		2023-11-15 12:52:22.624259
1789	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.39764935237	75048	95816	9336148	597322	9937070	1242836		2023-11-15 12:52:23.320898
1790	P01230	t	f	t	f	f	35 lbs nov.xml	41924	73959.1496740936	81716	84920	2945879	443078	3388837	137570		2023-11-15 12:52:25.170963
1791	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.03197011908	64680	95040	3542567	117949	3660516	419919		2023-11-15 12:52:27.631182
1792	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.39764935237	80048	95816	9336148	597322	9937070	1242836		2023-11-15 12:52:28.32566
1793	P01230	t	f	t	f	f	35 lbs nov.xml	41925	73959.74527413018	1884	84828	2945879	443078	3388837	137575		2023-11-15 12:52:30.176041
1794	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.03197011908	69680	95040	3542567	117949	3660516	419919		2023-11-15 12:52:32.644981
1795	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.39764935237	85048	95816	9336148	597322	9937070	1242836		2023-11-15 12:52:33.335637
1796	P01230	t	f	t	f	f	35 lbs nov.xml	41925	73960.21127414737	6884	84828	2945879	443078	3388837	137581		2023-11-15 12:52:35.415738
1797	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.03197011908	74680	95040	3542567	117949	3660516	419919		2023-11-15 12:52:37.657066
1798	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128147.39804935199	90048	95816	9336148	597322	9937070	1242836		2023-11-15 12:52:38.345994
1799	P01230	t	f	t	f	f	35 lbs nov.xml	41925	73960.21127414737	11884	84828	2945879	443078	3388837	137581		2023-11-15 12:52:40.338633
1800	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.03197011908	79680	95040	3542567	117949	3660516	419919		2023-11-15 12:52:42.774327
1801	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87933	128148.12494940116	95048	95816	9336148	597322	9937070	1242836		2023-11-15 12:52:43.344471
1802	P01230	t	f	t	f	f	35 lbs nov.xml	41925	73960.21587414968	16884	84828	2945879	443078	3388837	137581		2023-11-15 12:52:45.199868
1803	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.03197011908	84680	95040	3542567	117949	3660516	419919		2023-11-15 12:52:47.676313
1804	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.81774939655	4212	95832	9336148	597322	9937070	1242842		2023-11-15 12:52:48.35506
1805	P01230	t	f	t	f	f	35 lbs nov.xml	41925	73960.21587414968	21884	84828	2945879	443078	3388837	137584		2023-11-15 12:52:50.216807
1806	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.03297011908	89680	95040	3542567	117949	3660516	419919		2023-11-15 12:52:52.798609
1807	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.88634940072	9212	95832	9336148	597322	9937070	1242848		2023-11-15 12:52:53.369196
1808	P01230	t	f	t	f	f	35 lbs nov.xml	41925	73960.21587414968	26884	84828	2945879	443078	3388837	137584		2023-11-15 12:52:55.227394
1809	P01229	t	f	t	f	f	10 lbs octubre.xml	30029	42187.792470095264	94680	95040	3542567	117949	3660516	419919		2023-11-15 12:52:57.683238
1810	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.88774940418	14212	95832	9336148	597322	9937070	1242848		2023-11-15 12:52:58.386863
1811	P01230	t	f	t	f	f	35 lbs nov.xml	41925	73960.21587414968	31884	84828	2945879	443078	3388837	137584		2023-11-15 12:53:00.236567
1812	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.490270220376	4364	95312	3542567	117949	3660516	419925		2023-11-15 12:53:02.696956
1813	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.88784940456	19212	95832	9336148	597322	9937070	1242851		2023-11-15 12:53:03.383803
1814	P01230	t	f	t	f	f	35 lbs nov.xml	41925	73960.21587414968	36884	84828	2945879	443078	3388837	137584		2023-11-15 12:53:05.243894
1815	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.604470217324	9364	95312	3542567	117949	3660516	419931		2023-11-15 12:53:07.812838
1816	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.88784940456	24212	95832	9336148	597322	9937070	1242851		2023-11-15 12:53:08.384498
1817	P01230	t	f	t	f	f	35 lbs nov.xml	41925	73960.21587414968	41884	84828	2945879	443078	3388837	137584		2023-11-15 12:53:10.41593
1818	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.604470217324	14564	95312	3542567	117949	3660516	419931		2023-11-15 12:53:12.817108
1819	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.88784940456	29212	95832	9336148	597322	9937070	1242851		2023-11-15 12:53:13.384443
1820	P01230	t	f	t	f	f	35 lbs nov.xml	41925	73960.21587414968	46884	84828	2945879	443078	3388837	137584		2023-11-15 12:53:15.268773
1821	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.60887021837	19564	95312	3542567	117949	3660516	419934		2023-11-15 12:53:17.718017
1822	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.88784940456	34212	95832	9336148	597322	9937070	1242851		2023-11-15 12:53:18.395106
1823	P01230	t	f	t	f	f	35 lbs nov.xml	41925	73960.21587414968	51884	84828	2945879	443078	3388837	137584		2023-11-15 12:53:20.487387
1824	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.60887021837	24564	95312	3542567	117949	3660516	419934		2023-11-15 12:53:22.720935
1825	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.88784940456	39212	95832	9336148	597322	9937070	1242851		2023-11-15 12:53:23.406074
1826	P01230	t	f	t	f	f	35 lbs nov.xml	41925	73960.21587414968	56884	84828	2945879	443078	3388837	137584		2023-11-15 12:53:25.278778
1827	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.60887021837	29564	95312	3542567	117949	3660516	419934		2023-11-15 12:53:27.925804
1828	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.88784940456	44212	95832	9336148	597322	9937070	1242851		2023-11-15 12:53:28.404182
1829	P01230	t	f	t	f	f	35 lbs nov.xml	41925	73960.21587414968	61884	84828	2945879	443078	3388837	137584		2023-11-15 12:53:30.289095
1830	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.60887021837	34564	95312	3542567	117949	3660516	419934		2023-11-15 12:53:32.745195
1831	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.88784940456	49212	95832	9336148	597322	9937070	1242851		2023-11-15 12:53:33.407626
1832	P01230	t	f	t	f	f	35 lbs nov.xml	41925	73960.21587414968	66884	84828	2945879	443078	3388837	137584		2023-11-15 12:53:35.571381
1833	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.60887021837	39564	95312	3542567	117949	3660516	419934		2023-11-15 12:53:37.753382
1834	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.88784940456	54212	95832	9336148	597322	9937070	1242851		2023-11-15 12:53:38.414076
1835	P01230	t	f	t	f	f	35 lbs nov.xml	41925	73960.21587414968	71884	84828	2945879	443078	3388837	137584		2023-11-15 12:53:40.459671
1836	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.60887021837	44564	95312	3542567	117949	3660516	419934		2023-11-15 12:53:42.865128
1837	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.88784940456	59412	95832	9336148	597322	9937070	1242851		2023-11-15 12:53:43.43074
1838	P01230	t	f	t	f	f	35 lbs nov.xml	41925	73960.21587414968	76884	84828	2945879	443078	3388837	137584		2023-11-15 12:53:45.316723
1839	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.60887021837	49564	95312	3542567	117949	3660516	419934		2023-11-15 12:53:47.763541
1840	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.88784940456	64412	95832	9336148	597322	9937070	1242851		2023-11-15 12:53:48.431783
1841	P01230	t	f	t	f	f	35 lbs nov.xml	41925	73960.54957413708	81884	84828	2945879	443078	3388837	137584		2023-11-15 12:53:50.324168
1842	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.60887021837	54564	95312	3542567	117949	3660516	419934		2023-11-15 12:53:52.775973
1843	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.88784940456	69412	95832	9336148	597322	9937070	1242851		2023-11-15 12:53:53.435977
1844	P01230	t	f	t	f	f	35 lbs nov.xml	41926	73961.159074137	2272	84808	2945879	443078	3388837	137589		2023-11-15 12:53:55.606179
1845	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.60887021837	59564	95312	3542567	117949	3660516	419934		2023-11-15 12:53:57.782688
1846	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.88784940456	74412	95832	9336148	597322	9937070	1242851		2023-11-15 12:53:58.454304
1847	P01230	t	f	t	f	f	35 lbs nov.xml	41926	73961.55087413629	7272	84808	2945879	443078	3388837	137594		2023-11-15 12:54:00.338027
1848	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.60887021837	64564	95312	3542567	117949	3660516	419934		2023-11-15 12:54:02.796832
1849	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.88784940456	79412	95832	9336148	597322	9937070	1242851		2023-11-15 12:54:03.465034
1850	P01230	t	f	t	f	f	35 lbs nov.xml	41926	73961.55087413629	12272	84808	2945879	443078	3388837	137594		2023-11-15 12:54:05.342584
1851	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.60887021837	69564	95312	3542567	117949	3660516	419934		2023-11-15 12:54:07.903585
1852	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.88784940456	84412	95832	9336148	597322	9937070	1242851		2023-11-15 12:54:08.471796
1853	P01230	t	f	t	f	f	35 lbs nov.xml	41926	73961.55517413936	17272	84808	2945879	443078	3388837	137594		2023-11-15 12:54:10.507512
1854	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.60887021837	74564	95312	3542567	117949	3660516	419934		2023-11-15 12:54:12.798869
1855	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128148.88784940456	89412	95832	9336148	597322	9937070	1242851		2023-11-15 12:54:13.468753
1856	P01230	t	f	t	f	f	35 lbs nov.xml	41926	73961.55517413936	22272	84808	2945879	443078	3388837	137597		2023-11-15 12:54:15.363193
1857	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.60887021837	79564	95312	3542567	117949	3660516	419934		2023-11-15 12:54:17.808073
1858	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87934	128149.58214940381	94412	95832	9336148	597322	9937070	1242851		2023-11-15 12:54:18.482064
1859	P01230	t	f	t	f	f	35 lbs nov.xml	41926	73961.55517413936	27272	84808	2945879	443078	3388837	137597		2023-11-15 12:54:20.607762
1860	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.60887021837	84564	95312	3542567	117949	3660516	419934		2023-11-15 12:54:23.012741
1861	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.2150493519	3580	95828	9336148	597322	9937070	1242856		2023-11-15 12:54:23.4986
1862	P01230	t	f	t	f	f	35 lbs nov.xml	41926	73961.55517413936	32272	84808	2945879	443078	3388837	137597		2023-11-15 12:54:25.386622
1863	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42188.61197021875	89564	95312	3542567	117949	3660516	419934		2023-11-15 12:54:27.939225
1864	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.3760493538	8580	95828	9336148	597322	9937070	1242861		2023-11-15 12:54:28.498427
1865	P01230	t	f	t	f	f	35 lbs nov.xml	41926	73961.55517413936	37272	84808	2945879	443078	3388837	137597		2023-11-15 12:54:30.389581
1866	P01229	t	f	t	f	f	10 lbs octubre.xml	30030	42189.37677023136	94564	95312	3542567	117949	3660516	419934		2023-11-15 12:54:32.834905
1867	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.37624935457	13580	95828	9336148	597322	9937070	1242861		2023-11-15 12:54:33.508839
1868	P01230	t	f	t	f	f	35 lbs nov.xml	41926	73961.55517413936	42272	84808	2945879	443078	3388837	137597		2023-11-15 12:54:35.861151
1869	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.10217033207	4640	94920	3542567	117949	3660516	419940		2023-11-15 12:54:37.848166
1870	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.37774935648	18580	95828	9336148	597322	9937070	1242864		2023-11-15 12:54:38.518755
1871	P01230	t	f	t	f	f	35 lbs nov.xml	41926	73961.55517413936	47272	84808	2945879	443078	3388837	137597		2023-11-15 12:54:40.582909
1872	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.17977032862	9640	94920	3542567	117949	3660516	419945		2023-11-15 12:54:42.962109
1873	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.37774935648	23580	95828	9336148	597322	9937070	1242864		2023-11-15 12:54:43.538399
1874	P01230	t	f	t	f	f	35 lbs nov.xml	41926	73961.55517413936	52272	84808	2945879	443078	3388837	137597		2023-11-15 12:54:45.429585
1875	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.17977032862	14640	94920	3542567	117949	3660516	419945		2023-11-15 12:54:47.866885
1876	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.37774935648	28580	95828	9336148	597322	9937070	1242864		2023-11-15 12:54:48.543046
1877	P01230	t	f	t	f	f	35 lbs nov.xml	41926	73961.55517413936	57272	84808	2945879	443078	3388837	137597		2023-11-15 12:54:50.628756
1878	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.18507032976	19640	94920	3542567	117949	3660516	419948		2023-11-15 12:54:52.998781
1879	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.37774935648	33580	95828	9336148	597322	9937070	1242864		2023-11-15 12:54:53.546244
1880	P01230	t	f	t	f	f	35 lbs nov.xml	41926	73961.55517413936	62272	84808	2945879	443078	3388837	137597		2023-11-15 12:54:55.716865
1881	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.18507032976	24640	94920	3542567	117949	3660516	419948		2023-11-15 12:54:57.887607
1882	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.37774935648	38580	95828	9336148	597322	9937070	1242864		2023-11-15 12:54:58.55854
1883	P01230	t	f	t	f	f	35 lbs nov.xml	41926	73961.55517413936	67272	84808	2945879	443078	3388837	137597		2023-11-15 12:55:00.447522
1884	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.18507032976	29640	94920	3542567	117949	3660516	419948		2023-11-15 12:55:02.898568
1885	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.37774935648	43580	95828	9336148	597322	9937070	1242864		2023-11-15 12:55:03.568263
1886	P01230	t	f	t	f	f	35 lbs nov.xml	41926	73961.55517413936	72272	84808	2945879	443078	3388837	137597		2023-11-15 12:55:05.456589
1887	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.18507032976	34640	94920	3542567	117949	3660516	419948		2023-11-15 12:55:07.901944
1888	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.37774935648	48580	95828	9336148	597322	9937070	1242864		2023-11-15 12:55:08.578162
1889	P01230	t	f	t	f	f	35 lbs nov.xml	41926	73961.55517413936	77272	84808	2945879	443078	3388837	137597		2023-11-15 12:55:10.618924
1890	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.18507032976	39840	94920	3542567	117949	3660516	419948		2023-11-15 12:55:12.911175
1891	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.37774935648	53580	95828	9336148	597322	9937070	1242864		2023-11-15 12:55:13.586392
1892	P01230	t	f	t	f	f	35 lbs nov.xml	41926	73961.95017415847	82272	84808	2945879	443078	3388837	137597		2023-11-15 12:55:15.477663
1893	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.18507032976	44840	94920	3542567	117949	3660516	419948		2023-11-15 12:55:17.917607
1894	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.37774935648	58580	95828	9336148	597322	9937070	1242864		2023-11-15 12:55:18.590764
1895	P01230	t	f	t	f	f	35 lbs nov.xml	41927	73962.547274134	2400	84868	2945879	443078	3388837	137602		2023-11-15 12:55:20.887597
1896	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.18507032976	49840	94920	3542567	117949	3660516	419948		2023-11-15 12:55:23.032715
1897	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.37774935648	63580	95828	9336148	597322	9937070	1242864		2023-11-15 12:55:23.599134
1898	P01230	t	f	t	f	f	35 lbs nov.xml	41927	73962.89077412829	7400	84868	2945879	443078	3388837	137607		2023-11-15 12:55:25.487584
1899	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.18507032976	54840	94920	3542567	117949	3660516	419948		2023-11-15 12:55:28.254649
1900	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.37774935648	68580	95828	9336148	597322	9937070	1242864		2023-11-15 12:55:28.611417
1901	P01230	t	f	t	f	f	35 lbs nov.xml	41927	73962.89077412829	12400	84868	2945879	443078	3388837	137607		2023-11-15 12:55:30.501495
1902	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.18507032976	59840	94920	3542567	117949	3660516	419948		2023-11-15 12:55:32.96048
1903	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.37774935648	73580	95828	9336148	597322	9937070	1242864		2023-11-15 12:55:33.612613
1904	P01230	t	f	t	f	f	35 lbs nov.xml	41927	73962.89497412906	17400	84868	2945879	443078	3388837	137607		2023-11-15 12:55:35.683332
1905	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.18507032976	64840	94920	3542567	117949	3660516	419948		2023-11-15 12:55:37.965586
1906	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.37774935648	78580	95828	9336148	597322	9937070	1242864		2023-11-15 12:55:38.620509
1907	P01230	t	f	t	f	f	35 lbs nov.xml	41927	73962.89497412906	22400	84868	2945879	443078	3388837	137610		2023-11-15 12:55:40.530164
1908	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.18507032976	69840	94920	3542567	117949	3660516	419948		2023-11-15 12:55:43.083102
1909	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.37774935648	83580	95828	9336148	597322	9937070	1242864		2023-11-15 12:55:43.624182
1910	P01230	t	f	t	f	f	35 lbs nov.xml	41927	73962.89497412906	27600	84868	2945879	443078	3388837	137610		2023-11-15 12:55:45.540318
1911	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.18507032976	74840	94920	3542567	117949	3660516	419948		2023-11-15 12:55:47.975099
1912	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.37774935648	88780	95828	9336148	597322	9937070	1242864		2023-11-15 12:55:48.628294
1913	P01230	t	f	t	f	f	35 lbs nov.xml	41927	73962.89497412906	32600	84868	2945879	443078	3388837	137610		2023-11-15 12:55:50.718399
1914	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.18507032976	79840	94920	3542567	117949	3660516	419948		2023-11-15 12:55:53.265857
1915	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87935	128150.97844935727	93780	95828	9336148	597322	9937070	1242864		2023-11-15 12:55:53.651774
1916	P01230	t	f	t	f	f	35 lbs nov.xml	41927	73962.89497412906	37600	84868	2945879	443078	3388837	137610		2023-11-15 12:55:55.699752
1917	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.18507032976	84840	94920	3542567	117949	3660516	419948		2023-11-15 12:55:57.993704
1918	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.56244932668	2928	95848	9336148	597322	9937070	1242869		2023-11-15 12:55:58.647549
1919	P01230	t	f	t	f	f	35 lbs nov.xml	41927	73962.89497412906	42600	84868	2945879	443078	3388837	137610		2023-11-15 12:56:00.560942
1920	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.188270330524	89840	94920	3542567	117949	3660516	419948		2023-11-15 12:56:02.994851
1921	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.86564933317	7928	95848	9336148	597322	9937070	1242874		2023-11-15 12:56:03.664219
1922	P01230	t	f	t	f	f	35 lbs nov.xml	41927	73962.89497412906	47600	84868	2945879	443078	3388837	137610		2023-11-15 12:56:05.833407
1923	P01229	t	f	t	f	f	10 lbs octubre.xml	30031	42190.96117033015	94840	94920	3542567	117949	3660516	419948		2023-11-15 12:56:07.997842
1924	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.86564933317	12928	95848	9336148	597322	9937070	1242874		2023-11-15 12:56:08.671307
1925	P01230	t	f	t	f	f	35 lbs nov.xml	41927	73962.89497412906	52600	84868	2945879	443078	3388837	137610		2023-11-15 12:56:10.882366
1926	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.692970356075	4808	95028	3542567	117949	3660516	419954		2023-11-15 12:56:13.268944
1927	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.86734933394	17928	95848	9336148	597322	9937070	1242877		2023-11-15 12:56:13.684513
1928	P01230	t	f	t	f	f	35 lbs nov.xml	41927	73962.89497412906	57600	84868	2945879	443078	3388837	137610		2023-11-15 12:56:15.638291
1929	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.756770354325	9808	95028	3542567	117949	3660516	419959		2023-11-15 12:56:18.00487
1930	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.86734933394	22928	95848	9336148	597322	9937070	1242877		2023-11-15 12:56:18.690594
1931	P01230	t	f	t	f	f	35 lbs nov.xml	41927	73962.89497412906	62600	84868	2945879	443078	3388837	137610		2023-11-15 12:56:20.836734
1932	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.756770354325	14808	95028	3542567	117949	3660516	419959		2023-11-15 12:56:23.284717
1933	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.86734933394	27928	95848	9336148	597322	9937070	1242877		2023-11-15 12:56:23.714318
1934	P01230	t	f	t	f	f	35 lbs nov.xml	41927	73962.89497412906	67600	84868	2945879	443078	3388837	137610		2023-11-15 12:56:25.660392
1935	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.761870355185	19808	95028	3542567	117949	3660516	419962		2023-11-15 12:56:28.03952
1936	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.86734933394	32928	95848	9336148	597322	9937070	1242877		2023-11-15 12:56:28.709949
1937	P01230	t	f	t	f	f	35 lbs nov.xml	41927	73962.89497412906	72600	84868	2945879	443078	3388837	137610		2023-11-15 12:56:30.672223
1938	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.761870355185	24808	95028	3542567	117949	3660516	419962		2023-11-15 12:56:33.04299
1939	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.86734933394	37928	95848	9336148	597322	9937070	1242877		2023-11-15 12:56:33.717737
1940	P01230	t	f	t	f	f	35 lbs nov.xml	41927	73962.89497412906	77600	84868	2945879	443078	3388837	137610		2023-11-15 12:56:35.683144
1941	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.761870355185	29808	95028	3542567	117949	3660516	419962		2023-11-15 12:56:38.051251
1942	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.86734933394	42928	95848	9336148	597322	9937070	1242877		2023-11-15 12:56:38.719509
1943	P01230	t	f	t	f	f	35 lbs nov.xml	41927	73963.36357412182	82600	84868	2945879	443078	3388837	137610		2023-11-15 12:56:40.915903
1944	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.761870355185	34808	95028	3542567	117949	3660516	419962		2023-11-15 12:56:43.166953
1945	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.86734933394	47928	95848	9336148	597322	9937070	1242877		2023-11-15 12:56:43.725044
1946	P01230	t	f	t	f	f	35 lbs nov.xml	41928	73963.94897417669	2696	84900	2945879	443078	3388837	137616		2023-11-15 12:56:45.718149
1947	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.761870355185	39808	95028	3542567	117949	3660516	419962		2023-11-15 12:56:48.466654
1948	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.86734933394	52928	95848	9336148	597322	9937070	1242877		2023-11-15 12:56:48.740295
1949	P01230	t	f	t	f	f	35 lbs nov.xml	41928	73964.23127417595	7696	84900	2945879	443078	3388837	137621		2023-11-15 12:56:50.934413
1950	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.761870355185	44808	95028	3542567	117949	3660516	419962		2023-11-15 12:56:53.215215
1951	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.86734933394	57928	95848	9336148	597322	9937070	1242877		2023-11-15 12:56:53.740613
1952	P01230	t	f	t	f	f	35 lbs nov.xml	41928	73964.23127417595	12896	84900	2945879	443078	3388837	137621		2023-11-15 12:56:55.965702
1953	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.761870355185	49808	95028	3542567	117949	3660516	419962		2023-11-15 12:56:58.107792
1954	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.86734933394	62928	95848	9336148	597322	9937070	1242877		2023-11-15 12:56:58.750498
1955	P01230	t	f	t	f	f	35 lbs nov.xml	41928	73964.23587417444	17896	84900	2945879	443078	3388837	137621		2023-11-15 12:57:00.745494
1956	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.761870355185	55008	95028	3542567	117949	3660516	419962		2023-11-15 12:57:03.114537
1957	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.86734933394	67928	95848	9336148	597322	9937070	1242877		2023-11-15 12:57:03.751899
1958	P01230	t	f	t	f	f	35 lbs nov.xml	41928	73964.23587417444	22896	84900	2945879	443078	3388837	137625		2023-11-15 12:57:05.752229
1959	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.761870355185	60008	95028	3542567	117949	3660516	419962		2023-11-15 12:57:08.263013
1960	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.86734933394	72928	95848	9336148	597322	9937070	1242877		2023-11-15 12:57:08.767204
1961	P01230	t	f	t	f	f	35 lbs nov.xml	41928	73964.23587417444	27896	84900	2945879	443078	3388837	137625		2023-11-15 12:57:10.943409
1962	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.761870355185	65008	95028	3542567	117949	3660516	419962		2023-11-15 12:57:13.221575
1963	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.86734933394	77928	95848	9336148	597322	9937070	1242877		2023-11-15 12:57:13.771778
1964	P01230	t	f	t	f	f	35 lbs nov.xml	41928	73964.23587417444	32896	84900	2945879	443078	3388837	137625		2023-11-15 12:57:15.767234
1965	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.761870355185	70008	95028	3542567	117949	3660516	419962		2023-11-15 12:57:18.131731
1966	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.86734933394	82928	95848	9336148	597322	9937070	1242877		2023-11-15 12:57:18.772319
1967	P01230	t	f	t	f	f	35 lbs nov.xml	41928	73964.23587417444	37896	84900	2945879	443078	3388837	137625		2023-11-15 12:57:20.967366
1968	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.761870355185	75008	95028	3542567	117949	3660516	419962		2023-11-15 12:57:23.410382
1969	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128151.86734933394	87928	95848	9336148	597322	9937070	1242877		2023-11-15 12:57:23.779741
1970	P01230	t	f	t	f	f	35 lbs nov.xml	41928	73964.23587417444	42896	84900	2945879	443078	3388837	137625		2023-11-15 12:57:25.798064
1971	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.761870355185	80008	95028	3542567	117949	3660516	419962		2023-11-15 12:57:28.149905
1972	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87936	128152.32754934045	92928	95848	9336148	597322	9937070	1242877		2023-11-15 12:57:28.77873
1973	P01230	t	f	t	f	f	35 lbs nov.xml	41928	73964.23587417444	47896	84900	2945879	443078	3388837	137625		2023-11-15 12:57:30.79775
1974	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.761870355185	85008	95028	3542567	117949	3660516	419962		2023-11-15 12:57:33.325182
1975	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128152.90614925504	2048	95876	9336148	597322	9937070	1242882		2023-11-15 12:57:33.805183
1976	P01230	t	f	t	f	f	35 lbs nov.xml	41928	73964.23587417444	52896	84900	2945879	443078	3388837	137625		2023-11-15 12:57:35.809922
1977	P01229	t	f	t	f	f	10 lbs octubre.xml	30032	42191.77147035557	90008	95028	3542567	117949	3660516	419962		2023-11-15 12:57:38.186205
1978	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.35734926154	7048	95876	9336148	597322	9937070	1242887		2023-11-15 12:57:38.79944
1979	P01230	t	f	t	f	f	35 lbs nov.xml	41928	73964.23587417444	57896	84900	2945879	443078	3388837	137625		2023-11-15 12:57:41.032209
1980	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42192.54667037926	16	94988	3542567	117949	3660516	419968		2023-11-15 12:57:43.199288
1981	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.35734926154	12048	95876	9336148	597322	9937070	1242887		2023-11-15 12:57:43.805279
1982	P01230	t	f	t	f	f	35 lbs nov.xml	41928	73964.23587417444	62896	84900	2945879	443078	3388837	137625		2023-11-15 12:57:45.825107
1983	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42193.28967047843	5016	94988	3542567	117949	3660516	419968		2023-11-15 12:57:48.373608
1984	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.35884926154	17048	95876	9336148	597322	9937070	1242890		2023-11-15 12:57:48.82468
1985	P01230	t	f	t	f	f	35 lbs nov.xml	41928	73964.23587417444	67896	84900	2945879	443078	3388837	137625		2023-11-15 12:57:51.101406
1986	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42193.33277047688	10016	94988	3542567	117949	3660516	419973		2023-11-15 12:57:53.308646
1987	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.35884926154	22248	95876	9336148	597322	9937070	1242890		2023-11-15 12:57:53.835123
1988	P01230	t	f	t	f	f	35 lbs nov.xml	41928	73964.23587417444	72896	84900	2945879	443078	3388837	137625		2023-11-15 12:57:56.047638
1989	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42193.33277047688	15016	94988	3542567	117949	3660516	419973		2023-11-15 12:57:58.233185
1990	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.35884926154	27248	95876	9336148	597322	9937070	1242890		2023-11-15 12:57:58.834096
1991	P01230	t	f	t	f	f	35 lbs nov.xml	41928	73964.23587417444	77896	84900	2945879	443078	3388837	137625		2023-11-15 12:58:00.857573
1992	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42193.33867047935	20016	94988	3542567	117949	3660516	419976		2023-11-15 12:58:03.446901
1993	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.35884926154	32248	95876	9336148	597322	9937070	1242890		2023-11-15 12:58:03.843635
1994	P01230	t	f	t	f	f	35 lbs nov.xml	41928	73964.75227419882	82896	84900	2945879	443078	3388837	137625		2023-11-15 12:58:05.875877
1995	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42193.33867047935	25016	94988	3542567	117949	3660516	419976		2023-11-15 12:58:08.50288
1996	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.35884926154	37248	95876	9336148	597322	9937070	1242890		2023-11-15 12:58:08.873487
1997	P01230	t	f	t	f	f	35 lbs nov.xml	41929	73965.3501742995	3004	84888	2945879	443078	3388837	137631		2023-11-15 12:58:11.164348
1998	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42193.33867047935	30016	94988	3542567	117949	3660516	419976		2023-11-15 12:58:13.287008
1999	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.35884926154	42248	95876	9336148	597322	9937070	1242890		2023-11-15 12:58:13.876499
2000	P01230	t	f	t	f	f	35 lbs nov.xml	41929	73965.57117429761	8004	84888	2945879	443078	3388837	137636		2023-11-15 12:58:15.883055
2001	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42193.33867047935	35016	94988	3542567	117949	3660516	419976		2023-11-15 12:58:18.292947
2002	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.35884926154	47248	95876	9336148	597322	9937070	1242890		2023-11-15 12:58:18.886376
2003	P01230	t	f	t	f	f	35 lbs nov.xml	41929	73965.57117429761	13004	84888	2945879	443078	3388837	137636		2023-11-15 12:58:21.151829
2004	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42193.33867047935	40016	94988	3542567	117949	3660516	419976		2023-11-15 12:58:23.415477
2005	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.35884926154	52248	95876	9336148	597322	9937070	1242890		2023-11-15 12:58:23.889318
2006	P01230	t	f	t	f	f	35 lbs nov.xml	41929	73965.57527429993	18004	84888	2945879	443078	3388837	137636		2023-11-15 12:58:25.917646
2007	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42193.33867047935	45216	94988	3542567	117949	3660516	419976		2023-11-15 12:58:28.342897
2008	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.35884926154	57248	95876	9336148	597322	9937070	1242890		2023-11-15 12:58:28.905914
2009	P01230	t	f	t	f	f	35 lbs nov.xml	41929	73965.57527429993	23004	84888	2945879	443078	3388837	137640		2023-11-15 12:58:30.924288
2010	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42193.33867047935	50216	94988	3542567	117949	3660516	419976		2023-11-15 12:58:33.723047
2011	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.35884926154	62248	95876	9336148	597322	9937070	1242890		2023-11-15 12:58:33.905613
2012	P01230	t	f	t	f	f	35 lbs nov.xml	41929	73965.57527429993	28204	84888	2945879	443078	3388837	137640		2023-11-15 12:58:36.12248
2013	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42193.33867047935	55216	94988	3542567	117949	3660516	419976		2023-11-15 12:58:38.377016
2014	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.35884926154	67248	95876	9336148	597322	9937070	1242890		2023-11-15 12:58:38.911905
2015	P01230	t	f	t	f	f	35 lbs nov.xml	41929	73965.57527429993	33204	84888	2945879	443078	3388837	137640		2023-11-15 12:58:41.152935
2016	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42193.33867047935	60216	94988	3542567	117949	3660516	419976		2023-11-15 12:58:43.376959
2017	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.35884926154	72248	95876	9336148	597322	9937070	1242890		2023-11-15 12:58:43.915443
2018	P01230	t	f	t	f	f	35 lbs nov.xml	41929	73965.57527429993	38204	84888	2945879	443078	3388837	137640		2023-11-15 12:58:45.951086
2019	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42193.33867047935	65216	94988	3542567	117949	3660516	419976		2023-11-15 12:58:48.476723
2020	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.35884926154	77248	95876	9336148	597322	9937070	1242890		2023-11-15 12:58:48.917564
2021	P01230	t	f	t	f	f	35 lbs nov.xml	41929	73965.57527429993	43204	84888	2945879	443078	3388837	137640		2023-11-15 12:58:51.405561
2022	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42193.33867047935	70216	94988	3542567	117949	3660516	419976		2023-11-15 12:58:53.392521
2023	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.35884926154	82248	95876	9336148	597322	9937070	1242890		2023-11-15 12:58:53.92202
2024	P01230	t	f	t	f	f	35 lbs nov.xml	41929	73965.57527429993	48204	84888	2945879	443078	3388837	137640		2023-11-15 12:58:56.171641
2025	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42193.33867047935	75216	94988	3542567	117949	3660516	419976		2023-11-15 12:58:58.394504
2026	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.35884926154	87248	95876	9336148	597322	9937070	1242890		2023-11-15 12:58:58.933487
2027	P01230	t	f	t	f	f	35 lbs nov.xml	41929	73965.57527429993	53204	84888	2945879	443078	3388837	137640		2023-11-15 12:59:00.980792
2028	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42193.33867047935	80216	94988	3542567	117949	3660516	419976		2023-11-15 12:59:03.492864
2029	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87937	128153.67194926956	92248	95876	9336148	597322	9937070	1242890		2023-11-15 12:59:03.935333
2030	P01230	t	f	t	f	f	35 lbs nov.xml	41929	73965.57527429993	58204	84888	2945879	443078	3388837	137640		2023-11-15 12:59:05.988145
2031	P01229	t	f	t	f	f	10 lbs octubre.xml	30033	42193.35497048097	85216	94988	3542567	117949	3660516	419976		2023-11-15 12:59:08.505284
2032	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.24814925125	1400	95844	9336148	597322	9937070	1242895		2023-11-15 12:59:08.945644
2033	P01230	t	f	t	f	f	35 lbs nov.xml	41929	73965.57527429993	63204	84888	2945879	443078	3388837	137640		2023-11-15 12:59:11.187124
2034	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.124270455446	96	90116	3542567	117949	3660516	419982		2023-11-15 12:59:13.430192
2035	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.8464492753	6400	95844	9336148	597322	9937070	1242901		2023-11-15 12:59:13.951756
2036	P01230	t	f	t	f	f	35 lbs nov.xml	41929	73965.57527429993	68204	84888	2945879	443078	3388837	137640		2023-11-15 12:59:16.004274
2037	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.86807048136	5096	90116	3542567	117949	3660516	419982		2023-11-15 12:59:18.436699
2038	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.8464492753	11400	95844	9336148	597322	9937070	1242901		2023-11-15 12:59:18.957334
2039	P01230	t	f	t	f	f	35 lbs nov.xml	41929	73965.57527429993	73204	84888	2945879	443078	3388837	137640		2023-11-15 12:59:21.016976
2040	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.90907047992	10096	90116	3542567	117949	3660516	419988		2023-11-15 12:59:23.658982
2041	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.84854927378	16400	95844	9336148	597322	9937070	1242904		2023-11-15 12:59:23.971612
2042	P01230	t	f	t	f	f	35 lbs nov.xml	41929	73965.57527429993	78204	84888	2945879	443078	3388837	137640		2023-11-15 12:59:26.020021
2043	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.90907047992	15096	90116	3542567	117949	3660516	419988		2023-11-15 12:59:28.454565
2044	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.84854927378	21400	95844	9336148	597322	9937070	1242904		2023-11-15 12:59:28.97304
2045	P01230	t	f	t	f	f	35 lbs nov.xml	41929	73966.1392743133	83204	84888	2945879	443078	3388837	137640		2023-11-15 12:59:31.048408
2046	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.91407048181	20096	90116	3542567	117949	3660516	419991		2023-11-15 12:59:33.571297
2047	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.84854927378	26400	95844	9336148	597322	9937070	1242904		2023-11-15 12:59:33.990979
2048	P01230	t	f	t	f	f	35 lbs nov.xml	41930	73966.73857434682	3264	84936	2945879	443078	3388837	137645		2023-11-15 12:59:36.456608
2049	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.91407048181	25096	90116	3542567	117949	3660516	419991		2023-11-15 12:59:38.47942
2050	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.84854927378	31400	95844	9336148	597322	9937070	1242904		2023-11-15 12:59:39.007066
2051	P01230	t	f	t	f	f	35 lbs nov.xml	41930	73966.91027433808	8264	84936	2945879	443078	3388837	137650		2023-11-15 12:59:41.226358
2052	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.91407048181	30096	90116	3542567	117949	3660516	419991		2023-11-15 12:59:43.492554
2053	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.84854927378	36400	95844	9336148	597322	9937070	1242904		2023-11-15 12:59:44.008268
2054	P01230	t	f	t	f	f	35 lbs nov.xml	41930	73966.91027433808	13264	84936	2945879	443078	3388837	137650		2023-11-15 12:59:46.039739
2055	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.91407048181	35096	90116	3542567	117949	3660516	419991		2023-11-15 12:59:48.497677
2056	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.84854927378	41400	95844	9336148	597322	9937070	1242904		2023-11-15 12:59:49.020555
2057	P01230	t	f	t	f	f	35 lbs nov.xml	41930	73966.91507434113	18264	84936	2945879	443078	3388837	137654		2023-11-15 12:59:51.227155
2058	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.91407048181	40096	90116	3542567	117949	3660516	419991		2023-11-15 12:59:53.500924
2059	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.84854927378	46400	95844	9336148	597322	9937070	1242904		2023-11-15 12:59:54.021839
2060	P01230	t	f	t	f	f	35 lbs nov.xml	41930	73966.91507434113	23264	84936	2945879	443078	3388837	137654		2023-11-15 12:59:56.223158
2061	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.91407048181	45296	90116	3542567	117949	3660516	419991		2023-11-15 12:59:58.512707
2062	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.84854927378	51400	95844	9336148	597322	9937070	1242904		2023-11-15 12:59:59.02939
2063	P01230	t	f	t	f	f	35 lbs nov.xml	41930	73966.91507434113	28264	84936	2945879	443078	3388837	137654		2023-11-15 13:00:01.050922
2064	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.91407048181	50296	90116	3542567	117949	3660516	419991		2023-11-15 13:00:03.725038
2065	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.84854927378	56600	95844	9336148	597322	9937070	1242904		2023-11-15 13:00:04.04594
2066	P01230	t	f	t	f	f	35 lbs nov.xml	41930	73966.91507434113	33264	84936	2945879	443078	3388837	137654		2023-11-15 13:00:06.288565
2067	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.91407048181	55296	90116	3542567	117949	3660516	419991		2023-11-15 13:00:08.659152
2068	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.84854927378	61600	95844	9336148	597322	9937070	1242904		2023-11-15 13:00:09.042989
2069	P01230	t	f	t	f	f	35 lbs nov.xml	41930	73966.91507434113	38264	84936	2945879	443078	3388837	137654		2023-11-15 13:00:11.340166
2070	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.91407048181	60296	90116	3542567	117949	3660516	419991		2023-11-15 13:00:13.540124
2071	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.84854927378	66600	95844	9336148	597322	9937070	1242904		2023-11-15 13:00:14.045192
2072	P01230	t	f	t	f	f	35 lbs nov.xml	41930	73966.91507434113	43264	84936	2945879	443078	3388837	137654		2023-11-15 13:00:16.124973
2073	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.91407048181	65296	90116	3542567	117949	3660516	419991		2023-11-15 13:00:18.546873
2074	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.84854927378	71600	95844	9336148	597322	9937070	1242904		2023-11-15 13:00:19.049442
2075	P01230	t	f	t	f	f	35 lbs nov.xml	41930	73966.91507434113	48264	84936	2945879	443078	3388837	137654		2023-11-15 13:00:21.134952
2076	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.91407048181	70296	90116	3542567	117949	3660516	419991		2023-11-15 13:00:24.039454
2077	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.84854927378	76600	95844	9336148	597322	9937070	1242904		2023-11-15 13:00:24.50816
2078	P01230	t	f	t	f	f	35 lbs nov.xml	41930	73966.91507434113	53464	84936	2945879	443078	3388837	137654		2023-11-15 13:00:26.422278
2079	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.91407048181	75296	90116	3542567	117949	3660516	419991		2023-11-15 13:00:28.576205
2080	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.84854927378	81600	95844	9336148	597322	9937070	1242904		2023-11-15 13:00:29.081026
2081	P01230	t	f	t	f	f	35 lbs nov.xml	41930	73966.91507434113	58464	84936	2945879	443078	3388837	137654		2023-11-15 13:00:31.13763
2082	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.91407048181	80296	90116	3542567	117949	3660516	419991		2023-11-15 13:00:33.764186
2083	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128154.84854927378	86600	95844	9336148	597322	9937070	1242904		2023-11-15 13:00:34.082696
2084	P01230	t	f	t	f	f	35 lbs nov.xml	41930	73966.91507434113	63464	84936	2945879	443078	3388837	137654		2023-11-15 13:00:36.33054
2085	P01229	t	f	t	f	f	10 lbs octubre.xml	30034	42194.951970481896	85296	90116	3542567	117949	3660516	419991		2023-11-15 13:00:38.593206
2086	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87938	128155.02614926273	91600	95844	9336148	597322	9937070	1242904		2023-11-15 13:00:39.122077
2087	P01230	t	f	t	f	f	35 lbs nov.xml	41930	73966.91507434113	68464	84936	2945879	443078	3388837	137654		2023-11-15 13:00:41.347158
2088	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42195.69927046968	340	89952	3542567	117949	3660516	419997		2023-11-15 13:00:43.600756
2089	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128155.62504928713	740	95856	9336148	597322	9937070	1242910		2023-11-15 13:00:44.124734
2090	P01230	t	f	t	f	f	35 lbs nov.xml	41930	73966.91507434113	73464	84936	2945879	443078	3388837	137654		2023-11-15 13:00:46.171331
2091	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42196.45437054444	5340	89952	3542567	117949	3660516	419997		2023-11-15 13:00:49.034952
2092	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.33534932451	5740	95856	9336148	597322	9937070	1242916		2023-11-15 13:00:49.145882
2093	P01230	t	f	t	f	f	35 lbs nov.xml	41930	73966.91507434113	78464	84936	2945879	443078	3388837	137654		2023-11-15 13:00:51.328001
2094	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42196.48317054319	10340	89952	3542567	117949	3660516	420003		2023-11-15 13:00:53.722238
2095	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.33534932451	10740	95856	9336148	597322	9937070	1242916		2023-11-15 13:00:54.146116
2096	P01230	t	f	t	f	f	35 lbs nov.xml	41930	73967.51027434185	83464	84936	2945879	443078	3388837	137654		2023-11-15 13:00:56.353872
2097	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42196.483370543	15340	89952	3542567	117949	3660516	420003		2023-11-15 13:00:58.627368
2098	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.33694932681	15740	95856	9336148	597322	9937070	1242916		2023-11-15 13:00:59.148191
2099	P01230	t	f	t	f	f	35 lbs nov.xml	41931	73968.11507431432	3528	84932	2945879	443078	3388837	137659		2023-11-15 13:01:01.187322
2100	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42196.48857054375	20340	89952	3542567	117949	3660516	420006		2023-11-15 13:01:03.752473
2101	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.33694932681	20740	95856	9336148	597322	9937070	1242918		2023-11-15 13:01:04.161095
2102	P01230	t	f	t	f	f	35 lbs nov.xml	41931	73968.25067431855	8528	84932	2945879	443078	3388837	137664		2023-11-15 13:01:06.475914
2103	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42196.48857054375	25340	89952	3542567	117949	3660516	420006		2023-11-15 13:01:08.864673
2104	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.33694932681	25740	95856	9336148	597322	9937070	1242918		2023-11-15 13:01:09.216912
2105	P01230	t	f	t	f	f	35 lbs nov.xml	41931	73968.25067431855	13528	84932	2945879	443078	3388837	137664		2023-11-15 13:01:11.209506
2106	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42196.48857054375	30340	89952	3542567	117949	3660516	420006		2023-11-15 13:01:13.647005
2107	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.33694932681	30740	95856	9336148	597322	9937070	1242918		2023-11-15 13:01:14.193058
2108	P01230	t	f	t	f	f	35 lbs nov.xml	41931	73968.25547431971	18528	84932	2945879	443078	3388837	137668		2023-11-15 13:01:16.217971
2109	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42196.48857054375	35340	89952	3542567	117949	3660516	420006		2023-11-15 13:01:18.664907
2110	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.33694932681	35740	95856	9336148	597322	9937070	1242918		2023-11-15 13:01:19.205209
2111	P01230	t	f	t	f	f	35 lbs nov.xml	41931	73968.25547431971	23528	84932	2945879	443078	3388837	137668		2023-11-15 13:01:21.417903
2112	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42196.48857054375	40340	89952	3542567	117949	3660516	420006		2023-11-15 13:01:23.922579
2113	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.33694932681	40740	95856	9336148	597322	9937070	1242918		2023-11-15 13:01:24.323827
2114	P01230	t	f	t	f	f	35 lbs nov.xml	41931	73968.25547431971	28528	84932	2945879	443078	3388837	137668		2023-11-15 13:01:26.456077
2115	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42196.48857054375	45540	89952	3542567	117949	3660516	420006		2023-11-15 13:01:28.71858
2116	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.33694932681	45740	95856	9336148	597322	9937070	1242918		2023-11-15 13:01:29.231294
2117	P01230	t	f	t	f	f	35 lbs nov.xml	41931	73968.25547431971	33528	84932	2945879	443078	3388837	137668		2023-11-15 13:01:31.264143
2118	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42196.48857054375	50540	89952	3542567	117949	3660516	420006		2023-11-15 13:01:33.981822
2119	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.33694932681	50940	95856	9336148	597322	9937070	1242918		2023-11-15 13:01:34.270723
2120	P01230	t	f	t	f	f	35 lbs nov.xml	41931	73968.25547431971	38528	84932	2945879	443078	3388837	137668		2023-11-15 13:01:36.509838
2121	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42196.48857054375	55540	89952	3542567	117949	3660516	420006		2023-11-15 13:01:38.732847
2122	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.33694932681	55940	95856	9336148	597322	9937070	1242918		2023-11-15 13:01:39.287495
2123	P01230	t	f	t	f	f	35 lbs nov.xml	41931	73968.25547431971	43528	84932	2945879	443078	3388837	137668		2023-11-15 13:01:41.502294
2124	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42196.48857054375	60540	89952	3542567	117949	3660516	420006		2023-11-15 13:01:43.74161
2125	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.33694932681	60940	95856	9336148	597322	9937070	1242918		2023-11-15 13:01:44.283705
2126	P01230	t	f	t	f	f	35 lbs nov.xml	41931	73968.25547431971	48528	84932	2945879	443078	3388837	137668		2023-11-15 13:01:46.288728
2127	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42196.48857054375	65540	89952	3542567	117949	3660516	420006		2023-11-15 13:01:48.912658
2128	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.33694932681	65940	95856	9336148	597322	9937070	1242918		2023-11-15 13:01:49.318199
2129	P01230	t	f	t	f	f	35 lbs nov.xml	41931	73968.25547431971	53528	84932	2945879	443078	3388837	137668		2023-11-15 13:01:51.545294
2130	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42196.48857054375	70540	89952	3542567	117949	3660516	420006		2023-11-15 13:01:54.014373
2131	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.33694932681	70940	95856	9336148	597322	9937070	1242918		2023-11-15 13:01:54.476739
2132	P01230	t	f	t	f	f	35 lbs nov.xml	41931	73968.25547431971	58528	84932	2945879	443078	3388837	137668		2023-11-15 13:01:56.501536
2133	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42196.48857054375	75540	89952	3542567	117949	3660516	420006		2023-11-15 13:01:58.754495
2134	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.33694932681	75940	95856	9336148	597322	9937070	1242918		2023-11-15 13:01:59.334287
2135	P01230	t	f	t	f	f	35 lbs nov.xml	41931	73968.25547431971	63528	84932	2945879	443078	3388837	137668		2023-11-15 13:02:01.305145
2136	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42196.48857054375	80540	89952	3542567	117949	3660516	420006		2023-11-15 13:02:03.907806
2137	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.33694932681	80940	95856	9336148	597322	9937070	1242918		2023-11-15 13:02:04.338293
2138	P01230	t	f	t	f	f	35 lbs nov.xml	41931	73968.25547431971	68528	84932	2945879	443078	3388837	137668		2023-11-15 13:02:06.312672
2139	P01229	t	f	t	f	f	10 lbs octubre.xml	30035	42196.52577054544	85540	89952	3542567	117949	3660516	420006		2023-11-15 13:02:08.938171
2140	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.33694932681	85940	95856	9336148	597322	9937070	1242918		2023-11-15 13:02:09.413182
2141	P01230	t	f	t	f	f	35 lbs nov.xml	41931	73968.25547431971	73528	84932	2945879	443078	3388837	137668		2023-11-15 13:02:11.333886
2142	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42197.27237060499	412	90124	3542567	117949	3660516	420012		2023-11-15 13:02:13.77319
2143	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87939	128156.40664932186	90940	95856	9336148	597322	9937070	1242918		2023-11-15 13:02:14.39767
2144	P01230	t	f	t	f	f	35 lbs nov.xml	41931	73968.25547431971	78928	84932	2945879	443078	3388837	137668		2023-11-15 13:02:16.623151
2145	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42198.03057059428	5412	90124	3542567	117949	3660516	420012		2023-11-15 13:02:18.828275
2146	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.08144930203	100	95836	9336148	597322	9937070	1242924		2023-11-15 13:02:19.409069
2147	P01230	t	f	t	f	f	35 lbs nov.xml	41931	73968.89507430675	83928	84932	2945879	443078	3388837	137668		2023-11-15 13:02:21.91381
2148	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42198.056670592756	10412	90124	3542567	117949	3660516	420018		2023-11-15 13:02:24.128984
2149	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.80994930009	5300	95836	9336148	597322	9937070	1242924		2023-11-15 13:02:24.455294
2150	P01230	t	f	t	f	f	35 lbs nov.xml	41932	73969.53897429301	4008	84916	2945879	443078	3388837	137673		2023-11-15 13:02:26.617933
2151	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42198.05687059352	15412	90124	3542567	117949	3660516	420018		2023-11-15 13:02:28.854097
2152	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.82614930086	10300	95836	9336148	597322	9937070	1242930		2023-11-15 13:02:29.467608
2153	P01230	t	f	t	f	f	35 lbs nov.xml	41932	73969.58937429458	9008	84916	2945879	443078	3388837	137679		2023-11-15 13:02:31.632708
2154	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42198.06187059447	20412	90124	3542567	117949	3660516	420021		2023-11-15 13:02:33.855918
2155	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.82764930278	15300	95836	9336148	597322	9937070	1242930		2023-11-15 13:02:34.480006
2156	P01230	t	f	t	f	f	35 lbs nov.xml	41932	73969.58937429458	14008	84916	2945879	443078	3388837	137679		2023-11-15 13:02:36.831687
2157	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42198.06187059447	25412	90124	3542567	117949	3660516	420021		2023-11-15 13:02:38.868624
2158	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.82764930278	20300	95836	9336148	597322	9937070	1242933		2023-11-15 13:02:39.482162
2159	P01230	t	f	t	f	f	35 lbs nov.xml	41932	73969.5932742961	19008	84916	2945879	443078	3388837	137682		2023-11-15 13:02:41.838382
2160	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42198.06187059447	30412	90124	3542567	117949	3660516	420021		2023-11-15 13:02:43.870655
2161	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.82764930278	25300	95836	9336148	597322	9937070	1242933		2023-11-15 13:02:44.495447
2162	P01230	t	f	t	f	f	35 lbs nov.xml	41932	73969.5932742961	24008	84916	2945879	443078	3388837	137682		2023-11-15 13:02:46.656051
2163	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42198.06187059447	35412	90124	3542567	117949	3660516	420021		2023-11-15 13:02:48.995593
2164	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.82764930278	30300	95836	9336148	597322	9937070	1242933		2023-11-15 13:02:49.501361
2165	P01230	t	f	t	f	f	35 lbs nov.xml	41932	73969.5932742961	29008	84916	2945879	443078	3388837	137682		2023-11-15 13:02:51.888642
2166	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42198.06187059447	40412	90124	3542567	117949	3660516	420021		2023-11-15 13:02:54.021642
2167	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.82764930278	35300	95836	9336148	597322	9937070	1242933		2023-11-15 13:02:54.515506
2168	P01230	t	f	t	f	f	35 lbs nov.xml	41932	73969.5932742961	34008	84916	2945879	443078	3388837	137682		2023-11-15 13:02:56.998409
2169	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42198.06187059447	45412	90124	3542567	117949	3660516	420021		2023-11-15 13:02:58.891015
2170	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.82764930278	40300	95836	9336148	597322	9937070	1242933		2023-11-15 13:02:59.52628
2171	P01230	t	f	t	f	f	35 lbs nov.xml	41932	73969.5932742961	39008	84916	2945879	443078	3388837	137682		2023-11-15 13:03:01.680531
2172	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42198.06187059447	50412	90124	3542567	117949	3660516	420021		2023-11-15 13:03:04.01623
2173	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.82764930278	45300	95836	9336148	597322	9937070	1242933		2023-11-15 13:03:04.532777
2174	P01230	t	f	t	f	f	35 lbs nov.xml	41932	73969.5932742961	44008	84916	2945879	443078	3388837	137682		2023-11-15 13:03:06.719568
2175	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42198.06187059447	55412	90124	3542567	117949	3660516	420021		2023-11-15 13:03:09.026188
2176	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.82764930278	50300	95836	9336148	597322	9937070	1242933		2023-11-15 13:03:09.532061
2177	P01230	t	f	t	f	f	35 lbs nov.xml	41932	73969.5932742961	49008	84916	2945879	443078	3388837	137682		2023-11-15 13:03:12.014312
2178	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42198.06187059447	60612	90124	3542567	117949	3660516	420021		2023-11-15 13:03:13.918058
2179	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.82764930278	55300	95836	9336148	597322	9937070	1242933		2023-11-15 13:03:14.547586
2180	P01230	t	f	t	f	f	35 lbs nov.xml	41932	73969.5932742961	54008	84916	2945879	443078	3388837	137682		2023-11-15 13:03:16.738656
2181	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42198.06187059447	65612	90124	3542567	117949	3660516	420021		2023-11-15 13:03:18.922037
2182	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.82764930278	60300	95836	9336148	597322	9937070	1242933		2023-11-15 13:03:19.549593
2183	P01230	t	f	t	f	f	35 lbs nov.xml	41932	73969.5932742961	59008	84916	2945879	443078	3388837	137682		2023-11-15 13:03:21.981649
2184	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42198.06187059447	70612	90124	3542567	117949	3660516	420021		2023-11-15 13:03:24.040563
2185	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.82764930278	65300	95836	9336148	597322	9937070	1242933		2023-11-15 13:03:24.550105
2186	P01230	t	f	t	f	f	35 lbs nov.xml	41932	73969.5932742961	64208	84916	2945879	443078	3388837	137682		2023-11-15 13:03:26.7458
2187	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42198.06187059447	75612	90124	3542567	117949	3660516	420021		2023-11-15 13:03:28.928598
2188	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.82764930278	70300	95836	9336148	597322	9937070	1242933		2023-11-15 13:03:29.556532
2189	P01230	t	f	t	f	f	35 lbs nov.xml	41932	73969.5932742961	69208	84916	2945879	443078	3388837	137682		2023-11-15 13:03:31.755156
2190	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42198.06187059447	80612	90124	3542567	117949	3660516	420021		2023-11-15 13:03:33.939418
2191	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.82764930278	75300	95836	9336148	597322	9937070	1242933		2023-11-15 13:03:34.55894
2192	P01230	t	f	t	f	f	35 lbs nov.xml	41932	73969.5932742961	74208	84916	2945879	443078	3388837	137682		2023-11-15 13:03:37.030942
2193	P01229	t	f	t	f	f	10 lbs octubre.xml	30036	42198.11427059313	85612	90124	3542567	117949	3660516	420021		2023-11-15 13:03:38.951945
2194	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.82764930278	80300	95836	9336148	597322	9937070	1242933		2023-11-15 13:03:39.568391
2195	P01230	t	f	t	f	f	35 lbs nov.xml	41932	73969.5932742961	79208	84916	2945879	443078	3388837	137682		2023-11-15 13:03:41.96396
2196	P01229	t	f	t	f	f	10 lbs octubre.xml	30037	42198.84767066713	528	90080	3542567	117949	3660516	420027		2023-11-15 13:03:43.956495
2197	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.82764930278	85300	95836	9336148	597322	9937070	1242933		2023-11-15 13:03:44.579265
2198	P01230	t	f	t	f	f	35 lbs nov.xml	41932	73970.24307427055	84208	84916	2945879	443078	3388837	137682		2023-11-15 13:03:46.790623
2199	P01229	t	f	t	f	f	10 lbs octubre.xml	30037	42199.61177071518	5528	90080	3542567	117949	3660516	420027		2023-11-15 13:03:49.352625
2200	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128157.82944930393	90300	95836	9336148	597322	9937070	1242933		2023-11-15 13:03:49.589905
2201	P01230	t	f	t	f	f	35 lbs nov.xml	41933	73970.89097429495	4364	84840	2945879	443078	3388837	137687		2023-11-15 13:03:52.126343
2202	P01229	t	f	t	f	f	10 lbs octubre.xml	30037	42199.631870716505	10528	90080	3542567	117949	3660516	420033		2023-11-15 13:03:54.224638
2203	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87940	128158.5721493047	95500	95836	9336148	597322	9937070	1242939		2023-11-15 13:03:54.668431
2204	P01230	t	f	t	f	f	35 lbs nov.xml	41933	73970.92867429384	9364	84840	2945879	443078	3388837	137693		2023-11-15 13:03:56.8118
2205	P01229	t	f	t	f	f	10 lbs octubre.xml	30037	42199.63207071727	15528	90080	3542567	117949	3660516	420033		2023-11-15 13:03:59.023094
2206	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87941	128159.27394930008	4672	95824	9336148	597322	9937070	1242939		2023-11-15 13:03:59.656724
2207	P01230	t	f	t	f	f	35 lbs nov.xml	41933	73970.92867429384	14364	84840	2945879	443078	3388837	137693		2023-11-15 13:04:01.828275
2208	P01229	t	f	t	f	f	10 lbs octubre.xml	30037	42199.63737071744	20528	90080	3542567	117949	3660516	420037		2023-11-15 13:04:04.145722
2209	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87941	128159.3173493054	9672	95824	9336148	597322	9937070	1242944		2023-11-15 13:04:04.671666
2210	P01230	t	f	t	f	f	35 lbs nov.xml	41933	73970.93277429427	19364	84840	2945879	443078	3388837	137696		2023-11-15 13:04:06.84022
2211	P01229	t	f	t	f	f	10 lbs octubre.xml	30037	42199.63737071744	25528	90080	3542567	117949	3660516	420037		2023-11-15 13:04:09.127299
2212	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87941	128159.31904930809	14672	95824	9336148	597322	9937070	1242944		2023-11-15 13:04:09.665234
2213	P01230	t	f	t	f	f	35 lbs nov.xml	41933	73970.93277429427	24364	84840	2945879	443078	3388837	137696		2023-11-15 13:04:12.081157
2214	P01229	t	f	t	f	f	10 lbs octubre.xml	30037	42199.63737071744	30528	90080	3542567	117949	3660516	420037		2023-11-15 13:04:14.277239
2215	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87941	128159.31904930809	19672	95824	9336148	597322	9937070	1242947		2023-11-15 13:04:14.68578
2216	P01230	t	f	t	f	f	35 lbs nov.xml	41933	73970.93277429427	29364	84840	2945879	443078	3388837	137696		2023-11-15 13:04:16.86052
2217	P01229	t	f	t	f	f	10 lbs octubre.xml	30037	42199.63737071744	35528	90080	3542567	117949	3660516	420037		2023-11-15 13:04:19.110301
2218	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87941	128159.31904930809	24672	95824	9336148	597322	9937070	1242947		2023-11-15 13:04:19.691563
2219	P01230	t	f	t	f	f	35 lbs nov.xml	41933	73970.93277429427	34364	84840	2945879	443078	3388837	137696		2023-11-15 13:04:22.216279
2220	P01229	t	f	t	f	f	10 lbs octubre.xml	30037	42199.63737071744	40528	90080	3542567	117949	3660516	420037		2023-11-15 13:04:24.112235
2221	P01286	t	f	t	f	f	Mixto 25 (KGS).xml	87941	128159.31904930809	29672	95824	9336148	597322	9937070	1242947		2023-11-15 13:04:24.684793
\.


--
-- Data for Name: Molds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Molds" (mold_id, mold_recipe_name, tc_ideal, tc_max, nc_ideal, nc_max) FROM stdin;
1	35 lbs nov.xml	95	110	15000	25000
2	10 lbs octubre.xml	95	110	15000	25000
3	Mixto 25 (KGS).xml	95	110	15000	25000
\.


--
-- Data for Name: PreExpMachines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PreExpMachines" (machine_id, machine_serial_number) FROM stdin;
1	P01233
\.


--
-- Data for Name: PreExpMachinesStates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PreExpMachinesStates" (state_id, machine_serial_number, is_connected, is_disconnected, last_recipe_name, life_cycles, working_time_auto, working_time_manual, working_time_total, m01_working_time, m02_working_time, m03_working_time, m04_working_time, m05_working_time, m06_working_time, m07_working_time, m08_working_time, m09_working_time, m10_working_time, m11_working_time, m12_working_time, m13_working_time, m14_working_time, m15_working_time, time_stamp) FROM stdin;
1	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:46:16.045611
2	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:46:21.226816
3	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:46:26.05391
4	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:46:30.958746
5	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:46:36.099633
6	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:46:41.245997
7	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:46:46.425241
8	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:46:51.596656
9	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:46:56.22721
10	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:47:01.352378
11	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:47:06.332015
12	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:47:11.413612
13	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:47:16.182327
14	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:47:21.554552
15	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:47:26.299546
16	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:47:31.64646
17	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:47:36.386937
18	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:47:41.56384
19	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:47:46.41758
20	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:47:51.675446
21	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:47:56.443785
22	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:48:01.481608
23	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:48:06.649117
24	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:48:11.573156
25	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:48:16.462377
26	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:48:21.599752
27	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:48:26.544388
28	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:48:31.519428
29	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:48:36.632343
30	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:48:41.603763
31	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:48:46.512379
32	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:48:51.785873
33	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:48:56.592131
34	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:49:01.544249
35	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:49:06.772763
36	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:49:11.468143
37	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:49:16.471911
38	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:49:21.982818
39	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:49:26.601718
40	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:49:31.785273
41	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:49:36.719458
42	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:49:41.732695
43	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:49:46.557735
44	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:49:51.815501
45	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:49:56.693199
46	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:50:01.634051
47	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:50:06.871363
48	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:50:11.764587
49	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:50:16.842047
50	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:50:21.7757
51	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:50:26.794034
52	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:50:31.937802
53	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:50:36.890007
54	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:50:41.937031
55	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:50:47.005857
56	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:50:51.819883
57	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:50:56.829018
58	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:51:01.833777
59	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:51:06.85069
60	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:51:11.843043
61	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:51:16.954873
62	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:51:21.875147
63	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:51:26.923983
64	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:51:32.05382
65	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:51:36.775321
66	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:51:41.993921
67	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:51:47.312477
68	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:51:51.91789
69	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:51:57.061134
70	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:52:02.02159
71	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:52:07.061441
72	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:52:12.063225
73	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:52:17.108234
74	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:52:21.97353
75	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:52:27.171964
76	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:52:32.071345
77	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:52:36.893243
78	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:52:42.014104
79	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:52:47.357942
80	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:52:52.035749
81	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:52:57.043336
82	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:53:02.151888
83	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:53:07.188939
84	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:53:12.074018
85	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:53:17.184946
86	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:53:22.089191
87	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:53:27.248178
88	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:53:32.221155
89	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:53:37.02096
90	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:53:42.157806
91	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:53:47.380441
92	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:53:52.153617
93	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:53:57.33799
94	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:54:02.333626
95	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:54:07.2324
96	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:54:12.379687
97	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:54:17.249233
98	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:54:22.264874
99	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:54:27.376205
100	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:54:32.333402
101	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:54:37.428287
102	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:54:42.295366
103	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:54:47.47798
104	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:54:52.310268
105	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:54:57.474413
106	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:55:02.390566
107	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:55:07.437651
108	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:55:12.334473
109	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:55:17.481922
110	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:55:22.431452
111	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:55:27.479365
112	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:55:32.452607
113	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:55:37.341653
114	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:55:42.479702
115	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:55:47.597988
116	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:55:52.497136
117	P01233	t	f	t22 segunda opcion.xml	8804	1573293	981181	2554474	1669810	1665367	1667624	1667402	310224	0	0	0	116771	48509	1667409	0	0	0	0	2023-11-15 11:55:57.375331
118	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:56:02.575909
119	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:56:07.492804
120	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:56:12.677474
121	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:56:17.521574
122	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:56:22.41881
123	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:56:27.578295
124	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:56:32.521787
125	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:56:37.590703
126	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:56:42.540921
127	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:56:47.625025
128	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:56:52.552875
129	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:56:57.910426
130	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:57:02.698284
131	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:57:07.736216
132	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:57:12.843669
133	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:57:17.672694
134	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:57:22.762634
135	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:57:27.651953
136	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:57:32.929126
137	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:57:37.906488
138	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:57:42.729818
139	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:57:47.910243
140	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:57:52.794113
141	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:57:57.752306
142	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:58:02.817722
143	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:58:07.90695
144	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:58:12.785848
145	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:58:17.823843
146	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:58:22.925373
147	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:58:27.848566
148	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:58:33.042908
149	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:58:38.033276
150	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:58:42.85037
151	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:58:47.962876
152	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:58:52.886622
153	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:58:57.772303
154	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:59:02.953061
155	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:59:08.100096
156	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:59:12.909256
157	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:59:17.917617
158	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:59:23.070644
159	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:59:28.120571
160	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:59:33.168042
161	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:59:38.277993
162	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:59:43.096583
163	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:59:48.49797
164	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:59:53.232034
165	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 11:59:58.141113
166	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:00:03.153546
167	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:00:08.823042
168	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:00:13.105995
169	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:00:18.008768
170	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:00:23.209743
171	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:00:28.156848
172	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:00:33.187864
173	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:00:38.13742
174	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:00:43.239134
175	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:00:48.295926
176	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:00:53.215199
177	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:00:58.504018
178	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:01:03.295643
179	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:01:08.265938
180	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:01:13.176754
181	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:01:19.140094
182	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:01:23.508795
183	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:01:28.762661
184	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:01:33.678719
185	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:01:38.232709
186	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:01:43.729795
187	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:01:48.494728
188	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:01:53.371472
189	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:01:58.533235
190	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:02:03.403242
191	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:02:08.440101
192	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:02:13.543954
193	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:02:18.922646
194	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:02:23.388321
195	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:02:28.648769
196	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:02:33.69441
197	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:02:38.592476
198	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:02:43.41362
199	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:02:48.618644
200	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:02:53.546274
201	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:02:58.438616
202	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:03:03.56742
203	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:03:08.451866
204	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:03:13.629698
205	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:03:18.657119
206	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:03:23.594284
207	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:03:28.578019
208	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:03:33.47313
209	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:03:38.606984
210	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:03:43.651372
211	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:03:48.646317
212	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:03:53.523122
213	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:03:58.709479
214	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:04:03.545568
215	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:04:08.551239
216	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:04:13.67352
217	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:04:18.570258
218	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:04:23.578332
219	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:04:28.5765
220	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:04:33.681629
221	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:04:38.693186
222	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:04:43.687894
223	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:04:48.700079
224	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:04:53.776927
225	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:04:58.727345
226	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:05:03.645915
227	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:05:08.656427
228	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:05:13.657327
229	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:05:18.667157
230	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:05:23.664127
231	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:05:28.664316
232	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:05:33.678848
233	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:05:38.7827
234	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:05:43.702281
235	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:05:48.946409
236	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:05:53.803243
237	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:05:58.837467
238	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:06:03.727559
239	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:06:08.831053
240	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:06:13.739236
241	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:06:18.963778
242	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:06:23.940001
243	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:06:28.959791
244	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:06:33.868874
245	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:06:38.781473
246	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:06:43.785235
247	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:06:48.890429
248	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:06:53.906266
249	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:06:58.818876
250	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:07:03.915009
251	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:07:08.925704
252	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:07:13.946343
253	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:07:18.939916
254	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:07:23.936987
255	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:07:28.852615
256	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:07:33.856849
257	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:07:38.96625
258	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:07:43.966076
259	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:07:48.963854
260	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:07:53.964819
261	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:07:58.873946
262	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:08:04.040603
263	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:08:08.991315
264	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:08:13.991654
265	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:08:19.000769
266	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:08:24.005521
267	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:08:29.016322
268	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:08:34.015328
269	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:08:38.927654
270	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:08:44.085476
271	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:08:48.94193
272	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:08:54.055683
273	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:08:59.040512
274	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:09:03.96012
275	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:09:09.164177
276	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:09:14.068733
277	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:09:19.18605
278	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:09:23.981636
279	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:09:29.092016
280	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:09:34.099836
281	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:09:39.120008
282	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:09:44.027768
283	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:09:49.041433
284	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:09:54.040741
285	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:09:59.148336
286	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:10:04.150038
287	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:10:09.065944
288	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:10:14.068616
289	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:10:19.070563
290	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:10:24.1742
291	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:10:29.166012
292	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:10:34.08142
293	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:10:39.086307
294	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:10:44.095401
295	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:10:49.204636
296	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:10:54.201768
297	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:10:59.206794
298	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:11:04.110555
299	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:11:09.208435
300	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:11:14.128613
301	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:11:19.138877
302	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:11:24.148363
303	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:11:29.248725
304	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:11:34.156497
305	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:11:39.256901
306	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:11:44.175129
307	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:11:49.1882
308	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:11:54.280757
309	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:11:59.193554
310	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:12:04.198853
311	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:12:09.202979
312	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:12:14.299738
313	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:12:19.228476
314	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:12:24.355296
315	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:12:29.320994
316	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:12:34.234106
317	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:12:39.333924
318	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:12:44.258116
319	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:12:49.271016
320	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:12:54.440489
321	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:12:59.291659
322	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:13:04.294558
323	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:13:09.302644
324	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:13:14.30661
325	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:13:19.438316
326	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:13:24.322581
327	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:13:29.424593
328	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:13:34.428257
329	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:13:39.445467
330	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:13:44.438612
331	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:13:49.463433
332	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:13:54.467263
333	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:13:59.490377
334	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:14:04.390716
335	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:14:09.406603
336	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676326	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:14:14.537797
337	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:14:19.420109
338	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:14:24.42873
339	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:14:29.589508
340	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:14:34.53446
341	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:14:39.547227
342	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:14:44.450539
343	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:14:49.463477
344	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:14:54.467372
345	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:14:59.571657
346	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:15:04.584021
347	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:15:09.501339
348	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:15:14.601583
349	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:15:19.605837
350	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:15:24.52135
351	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:15:29.534367
352	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:15:34.644038
353	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:15:39.563821
354	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:15:44.656442
355	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:15:49.667506
356	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:15:54.770802
357	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:15:59.572299
358	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:16:04.783285
359	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:16:09.597551
360	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:16:14.605698
361	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:16:19.619904
362	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:16:24.623172
363	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:16:29.724651
364	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:16:34.638126
365	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:16:39.652334
366	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:16:44.752554
367	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:16:49.662459
368	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:16:54.771213
369	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:16:59.775484
370	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:17:04.778634
371	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676407	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:17:09.784008
372	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:17:14.793573
373	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:17:19.711005
374	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:17:24.922689
375	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:17:29.83076
376	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:17:34.837301
377	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:17:39.739685
378	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:17:44.749623
379	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:17:49.85952
380	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:17:54.8772
381	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:17:59.864468
382	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:18:04.777667
383	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:18:09.868359
384	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:18:14.879075
385	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:18:19.977439
386	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:18:24.796385
387	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:18:29.908963
388	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:18:34.816001
389	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:18:39.927911
390	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:18:44.822195
391	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:18:49.915663
392	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676487	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:18:54.82523
393	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676568	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:18:59.835992
394	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981181	2560990	1676568	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:19:04.840512
395	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981557	2561366	1676568	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:19:09.943286
396	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981557	2561366	1676568	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:19:14.861393
397	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981557	2561366	1676568	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:19:19.958501
398	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981557	2561366	1676568	1671804	1674063	1673841	310224	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:19:24.97116
399	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981557	2561366	1676568	1671804	1674063	1673841	310241	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:19:29.985545
400	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981557	2561366	1676568	1671804	1674063	1673841	310241	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:19:34.998368
401	P01233	t	f	t22 segunda opcion.xml	8804	1579809	981557	2561366	1676568	1671804	1674063	1673841	310241	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:19:39.913367
402	P01233	t	f	t22 segunda opcion.xml	8804	1579839	981557	2561396	1676598	1671804	1674063	1673841	310241	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:19:45.034874
403	P01233	t	f	t22 segunda opcion.xml	8804	1579839	981557	2561396	1676598	1671804	1674063	1673841	310241	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:19:50.045031
404	P01233	t	f	t22 segunda opcion.xml	8804	1579839	981557	2561396	1676598	1671804	1674063	1673841	310241	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:19:55.039859
405	P01233	t	f	t22 segunda opcion.xml	8804	1579839	981557	2561396	1676598	1671804	1674063	1673841	310256	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:19:59.95481
406	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310256	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:20:05.060753
407	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310256	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:20:09.966812
408	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310256	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:20:15.076516
409	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310256	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:20:20.075269
410	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310256	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:20:25.079029
411	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310256	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:20:30.087589
412	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310256	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:20:35.101227
413	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310256	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:20:40.015831
414	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:20:45.109739
415	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:20:50.175339
416	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:20:55.020597
417	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:21:00.127454
418	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:21:05.03081
419	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:21:10.137779
420	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:21:15.060781
421	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:21:20.0544
422	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:21:25.06723
423	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:21:30.169971
424	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:21:35.199937
425	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:21:40.099649
426	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:21:45.215356
427	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:21:50.120849
428	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:21:55.22098
429	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:22:00.224226
430	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:22:05.148383
431	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:22:10.150122
432	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:22:15.26141
433	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:22:20.273836
434	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:22:25.176736
435	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:22:30.191756
436	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:22:35.191758
437	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:22:40.201538
438	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:22:45.203075
439	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:22:50.209953
440	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48509	1673848	0	0	0	0	2023-11-15 12:22:55.224597
441	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48514	1673848	0	0	0	0	2023-11-15 12:23:00.437044
442	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48514	1673848	0	0	0	0	2023-11-15 12:23:05.246078
443	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48514	1673848	0	0	0	0	2023-11-15 12:23:10.341618
444	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116771	48514	1673848	0	0	0	0	2023-11-15 12:23:15.251642
445	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:23:20.258404
446	P01233	t	f	t22 segunda opcion.xml	8805	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:23:25.361459
447	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:23:30.35593
448	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:23:35.365075
449	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:23:40.365107
450	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:23:45.281053
451	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:23:50.384025
452	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:23:55.402309
453	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:24:00.320385
454	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310289	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:24:05.491379
455	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:24:10.333229
456	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:24:15.335028
457	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:24:20.430983
458	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:24:25.339466
459	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:24:30.432582
460	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:24:35.448615
461	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:24:40.356104
462	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:24:45.362318
463	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:24:50.375967
464	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:24:55.478286
465	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:25:00.496209
466	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:25:05.492168
467	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:25:10.406703
468	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:25:15.407466
469	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:25:20.415245
470	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:25:25.510306
471	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:25:30.515278
472	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:25:35.512529
473	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:25:40.595547
474	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:25:45.527962
475	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:25:50.534432
476	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:25:55.545294
477	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:26:00.547643
478	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:26:05.554156
479	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:26:10.605567
480	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48514	1673848	0	0	0	0	2023-11-15 12:26:15.503779
481	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48519	1673848	0	0	0	0	2023-11-15 12:26:20.601233
482	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48519	1673848	0	0	0	0	2023-11-15 12:26:25.612497
483	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48519	1673848	0	0	0	0	2023-11-15 12:26:30.520145
484	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116783	48519	1673848	0	0	0	0	2023-11-15 12:26:35.528037
485	P01233	t	f	t22 segunda opcion.xml	8806	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:26:40.643273
486	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:26:45.548828
487	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:26:50.55237
488	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:26:55.552761
489	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:27:00.66217
490	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:27:05.691109
491	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:27:10.700516
492	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:27:15.720022
493	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:27:20.815738
494	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310322	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:27:25.731317
495	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:27:30.719788
496	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:27:35.721597
497	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:27:40.739231
498	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:27:45.739264
499	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:27:50.73389
500	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:27:55.648792
501	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:28:00.778255
502	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:28:05.672064
503	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:28:10.773947
504	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:28:15.699367
505	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:28:20.891433
506	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:28:25.796238
507	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:28:30.709626
508	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:28:35.714699
509	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:28:40.722352
510	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:28:45.738548
511	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:28:50.737941
512	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:28:55.843406
513	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:29:00.753599
514	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:29:05.863595
515	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:29:10.773986
516	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:29:15.787736
517	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:29:20.791382
518	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:29:25.798073
519	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48519	1673848	0	0	0	0	2023-11-15 12:29:30.805436
520	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48524	1673848	0	0	0	0	2023-11-15 12:29:35.817921
521	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48524	1673848	0	0	0	0	2023-11-15 12:29:40.920958
522	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48524	1673848	0	0	0	0	2023-11-15 12:29:45.839984
523	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48524	1673848	0	0	0	0	2023-11-15 12:29:50.949547
524	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116793	48524	1673848	0	0	0	0	2023-11-15 12:29:55.844733
525	P01233	t	f	t22 segunda opcion.xml	8807	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:30:00.849484
526	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:30:05.860174
527	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:30:10.862717
528	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:30:15.872715
529	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:30:20.881576
530	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:30:25.898678
531	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:30:30.903129
532	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:30:35.909544
533	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:30:40.923728
534	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310354	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:30:45.935475
535	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:30:50.945539
536	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:30:56.051091
537	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:31:00.967432
538	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:31:05.976233
539	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:31:10.987927
540	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:31:16.000596
541	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:31:21.105708
542	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:31:26.113093
543	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:31:31.032483
544	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:31:36.042944
545	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:31:41.152403
546	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:31:46.053353
547	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:31:51.054728
548	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:31:56.058558
549	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:32:01.068111
550	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:32:06.175737
551	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:32:11.080322
552	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:32:16.094135
553	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:32:21.100337
554	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:32:26.10078
555	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:32:31.109484
556	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:32:36.11572
557	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:32:41.123849
558	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48524	1673848	0	0	0	0	2023-11-15 12:32:46.230273
559	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48529	1673848	0	0	0	0	2023-11-15 12:32:51.136761
560	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48529	1673848	0	0	0	0	2023-11-15 12:32:56.146469
561	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48529	1673848	0	0	0	0	2023-11-15 12:33:01.154222
562	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116805	48529	1673848	0	0	0	0	2023-11-15 12:33:06.348425
563	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:33:11.162118
564	P01233	t	f	t22 segunda opcion.xml	8808	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:33:16.28003
565	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:33:21.17222
566	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:33:26.200313
567	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:33:31.187873
568	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:33:36.194914
569	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:33:41.233518
570	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:33:46.214042
571	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:33:51.219191
572	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:33:56.231513
573	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310386	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:34:01.259582
574	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:34:06.261506
575	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:34:11.270792
576	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:34:16.29229
577	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:34:21.29492
578	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:34:26.338832
579	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:34:31.340259
580	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:34:36.441855
581	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:34:41.366093
582	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:34:46.367991
583	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:34:51.370017
584	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:34:56.576734
585	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:35:01.397642
586	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:35:06.404836
587	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:35:11.428924
588	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:35:16.433201
589	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:35:21.441409
590	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:35:26.562632
591	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:35:31.448897
592	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:35:36.458032
593	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:35:41.58836
594	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:35:46.647913
595	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:35:51.608664
596	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:35:56.498472
597	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:36:01.49672
598	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48529	1673848	0	0	0	0	2023-11-15 12:36:06.657214
599	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48534	1673848	0	0	0	0	2023-11-15 12:36:11.50724
600	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48534	1673848	0	0	0	0	2023-11-15 12:36:16.518941
601	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48534	1673848	0	0	0	0	2023-11-15 12:36:21.525845
602	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116816	48534	1673848	0	0	0	0	2023-11-15 12:36:26.550879
603	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:36:31.550467
604	P01233	t	f	t22 segunda opcion.xml	8809	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:36:36.552097
605	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:36:41.675554
606	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:36:46.778238
607	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:36:51.695793
608	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:36:56.593938
609	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:37:01.720571
610	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:37:06.728025
611	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:37:11.6169
612	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310419	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:37:16.732587
613	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:37:21.629667
614	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:37:26.756132
615	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:37:31.633031
616	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:37:36.774753
617	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:37:41.65959
618	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:37:46.796496
619	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:37:51.674381
620	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:37:56.686979
621	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:38:01.834965
622	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:38:06.705568
623	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:38:11.920539
624	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:38:16.714655
625	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:38:21.833508
626	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:38:27.209307
627	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:38:31.746772
628	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:38:36.753625
629	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:38:41.767067
630	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:38:46.770186
631	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:38:51.789405
632	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:38:57.077828
633	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:39:01.808713
634	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:39:06.818794
635	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:39:11.831025
636	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:39:17.066856
637	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48534	1673848	0	0	0	0	2023-11-15 12:39:21.852787
638	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48538	1673848	0	0	0	0	2023-11-15 12:39:26.855511
639	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48538	1673848	0	0	0	0	2023-11-15 12:39:32.184182
640	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48538	1673848	0	0	0	0	2023-11-15 12:39:37.078754
641	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116827	48538	1673848	0	0	0	0	2023-11-15 12:39:41.901173
642	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:39:47.009859
643	P01233	t	f	t22 segunda opcion.xml	8810	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:39:52.202908
644	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:39:57.06733
645	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:40:02.384687
646	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:40:06.979215
647	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:40:12.107267
648	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:40:17.246779
649	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:40:22.229482
650	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:40:27.019455
651	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310452	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:40:32.024545
652	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:40:37.251076
653	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:40:42.040455
654	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:40:47.04922
655	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:40:52.342557
656	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:40:57.296036
657	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:41:02.098776
658	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:41:07.210851
659	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:41:12.248235
660	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:41:17.397179
661	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:41:22.220263
662	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:41:27.150674
663	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:41:32.226881
664	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:41:37.153622
665	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:41:42.252068
666	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:41:47.166229
667	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:41:52.263053
668	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:41:57.179247
669	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:42:02.186573
670	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:42:07.195762
671	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:42:12.211114
672	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:42:17.451913
673	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:42:22.242084
674	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:42:27.343346
675	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:42:32.251933
676	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48538	1673848	0	0	0	0	2023-11-15 12:42:37.265002
677	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48543	1673848	0	0	0	0	2023-11-15 12:42:42.387991
678	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48543	1673848	0	0	0	0	2023-11-15 12:42:47.412743
679	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48543	1673848	0	0	0	0	2023-11-15 12:42:52.616277
680	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116838	48543	1673848	0	0	0	0	2023-11-15 12:42:57.413508
681	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:43:02.416494
682	P01233	t	f	t22 segunda opcion.xml	8811	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:43:07.423581
683	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:43:12.325018
684	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:43:17.435652
685	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:43:22.329723
686	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:43:27.483079
687	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:43:32.355812
688	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:43:37.685427
689	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:43:42.370915
690	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310485	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:43:47.536676
691	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:43:52.551435
692	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:43:57.565304
693	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:44:02.499675
694	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:44:07.416209
695	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:44:12.613196
696	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:44:17.432711
697	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:44:22.596696
698	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:44:27.66849
699	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:44:32.630695
700	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:44:37.469736
701	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:44:42.665045
702	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:44:47.58365
703	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:44:52.625362
704	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:44:57.494758
705	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:45:02.616529
706	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:45:07.510627
707	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:45:12.732462
708	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:45:17.527698
709	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:45:22.54468
710	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:45:27.716936
711	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:45:32.574892
712	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:45:37.727297
713	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:45:42.683247
714	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48543	1673848	0	0	0	0	2023-11-15 12:45:47.737706
715	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48547	1673848	0	0	0	0	2023-11-15 12:45:52.720955
716	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48547	1673848	0	0	0	0	2023-11-15 12:45:57.737745
717	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48547	1673848	0	0	0	0	2023-11-15 12:46:02.619818
718	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48547	1673848	0	0	0	0	2023-11-15 12:46:07.628296
719	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116849	48547	1673848	0	0	0	0	2023-11-15 12:46:12.760433
720	P01233	t	f	t22 segunda opcion.xml	8812	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:46:17.645784
721	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:46:22.936307
722	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:46:27.656015
723	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:46:32.879048
724	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:46:37.689349
725	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:46:42.701509
726	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:46:48.052968
727	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:46:52.864145
728	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:46:57.829559
729	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310518	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:47:02.751179
730	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:47:07.748733
731	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:47:12.878653
732	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:47:17.948051
733	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:47:22.911972
734	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:47:27.779621
735	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:47:32.791564
736	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:47:37.92586
737	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:47:42.929511
738	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:47:48.032009
739	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:47:52.970806
740	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:47:57.831329
741	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:48:02.952034
742	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:48:07.956026
743	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:48:13.042115
744	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:48:17.881105
745	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:48:22.889649
746	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:48:28.104861
747	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:48:33.011997
748	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:48:37.91799
749	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:48:42.921737
750	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:48:48.042022
751	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:48:52.933304
752	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48547	1673848	0	0	0	0	2023-11-15 12:48:57.94907
753	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48551	1673848	0	0	0	0	2023-11-15 12:49:03.064714
754	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48551	1673848	0	0	0	0	2023-11-15 12:49:08.109342
755	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48551	1673848	0	0	0	0	2023-11-15 12:49:13.209661
756	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116860	48551	1673848	0	0	0	0	2023-11-15 12:49:17.982464
757	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:49:22.987715
758	P01233	t	f	t22 segunda opcion.xml	8813	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:49:27.996031
759	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:49:33.388871
760	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:49:38.23074
761	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:49:43.039102
762	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:49:48.163252
763	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:49:53.049095
764	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:49:58.297036
765	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:50:03.270414
766	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310551	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:50:08.100175
767	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:50:13.095668
768	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:50:18.3036
769	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:50:23.102365
770	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:50:28.111198
771	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:50:33.219907
772	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:50:38.211834
773	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:50:43.369958
774	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:50:48.139866
775	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:50:53.251373
776	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:50:58.164779
777	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:51:03.421269
778	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:51:08.195229
779	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:51:13.205135
780	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:51:18.213625
781	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:51:23.228751
782	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:51:28.254294
783	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:51:33.271555
784	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:51:38.281516
785	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:51:43.279619
786	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:51:48.379048
787	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:51:53.555513
788	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:51:58.300053
789	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:52:03.395597
790	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:52:08.303646
791	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48551	1673848	0	0	0	0	2023-11-15 12:52:13.310495
792	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48556	1673848	0	0	0	0	2023-11-15 12:52:18.538114
793	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48556	1673848	0	0	0	0	2023-11-15 12:52:23.419226
794	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48556	1673848	0	0	0	0	2023-11-15 12:52:28.429306
795	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116872	48556	1673848	0	0	0	0	2023-11-15 12:52:33.42956
796	P01233	t	f	t22 segunda opcion.xml	8814	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:52:38.611093
797	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:52:43.442184
798	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:52:48.582652
799	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:52:53.47222
800	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:52:58.542753
801	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:53:03.384356
802	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:53:08.478006
803	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:53:13.39171
804	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:53:18.483655
805	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310584	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:53:23.647378
806	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:53:28.407981
807	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:53:33.505294
808	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:53:38.503656
809	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:53:43.774468
810	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:53:48.563995
811	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:53:53.439615
812	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:53:58.598291
813	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:54:03.635841
814	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:54:08.561426
815	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:54:13.473261
816	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:54:18.580312
817	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:54:23.900966
818	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:54:28.586126
819	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:54:33.512488
820	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:54:38.519505
821	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:54:43.684749
822	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:54:48.63723
823	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:54:53.550286
824	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:54:58.654449
825	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:55:03.725752
826	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:55:08.67402
827	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:55:13.682919
828	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:55:18.69269
829	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:55:23.602906
830	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48556	1673848	0	0	0	0	2023-11-15 12:55:28.803025
831	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48561	1673848	0	0	0	0	2023-11-15 12:55:33.616521
832	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48561	1673848	0	0	0	0	2023-11-15 12:55:38.735584
833	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48561	1673848	0	0	0	0	2023-11-15 12:55:43.728225
834	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116883	48561	1673848	0	0	0	0	2023-11-15 12:55:48.632381
835	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:55:53.76443
836	P01233	t	f	t22 segunda opcion.xml	8815	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:55:58.775597
837	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:56:03.672187
838	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:56:08.675807
839	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:56:13.68902
840	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:56:18.695057
841	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:56:23.871438
842	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:56:28.714844
843	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:56:33.830324
844	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:56:38.724186
845	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310617	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:56:43.729832
846	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:56:48.741696
847	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:56:53.745059
848	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:56:58.866755
849	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:57:03.758713
850	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:57:08.769006
851	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:57:13.88393
852	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:57:19.087939
853	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:57:23.783117
854	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:57:28.891127
855	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:57:34.119969
856	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:57:38.804142
857	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:57:43.810042
858	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:57:48.825317
859	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:57:53.937932
860	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:57:58.83873
861	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:58:03.851363
862	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:58:09.030164
863	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:58:13.985495
864	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:58:18.892751
865	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:58:23.894706
866	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:58:29.095624
867	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:58:33.911433
868	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48561	1673848	0	0	0	0	2023-11-15 12:58:38.916457
869	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48565	1673848	0	0	0	0	2023-11-15 12:58:43.920835
870	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48565	1673848	0	0	0	0	2023-11-15 12:58:48.923315
871	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48565	1673848	0	0	0	0	2023-11-15 12:58:53.926484
872	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48565	1673848	0	0	0	0	2023-11-15 12:58:59.037142
873	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116894	48565	1673848	0	0	0	0	2023-11-15 12:59:03.941422
874	P01233	t	f	t22 segunda opcion.xml	8816	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 12:59:08.95322
875	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 12:59:13.958616
876	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 12:59:18.962131
877	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 12:59:24.409293
878	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 12:59:28.97711
879	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 12:59:33.992168
880	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 12:59:39.212017
881	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 12:59:44.013061
882	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 12:59:49.025748
883	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310650	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 12:59:54.029486
884	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 12:59:59.035988
885	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:00:04.183711
886	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:00:09.048772
887	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:00:14.05216
888	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:00:19.059129
889	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:00:24.072094
890	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:00:29.500195
891	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:00:34.374987
892	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:00:39.593382
893	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:00:44.354731
894	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:00:49.146186
895	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:00:54.237267
896	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:00:59.238324
897	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:01:04.270943
898	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:01:09.532325
899	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:01:14.292929
900	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:01:19.399912
901	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:01:24.466542
902	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:01:29.354382
903	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:01:34.273392
904	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:01:39.2884
905	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:01:44.289733
906	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48565	1673848	0	0	0	0	2023-11-15 13:01:49.699866
907	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48570	1673848	0	0	0	0	2023-11-15 13:01:54.599895
908	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48570	1673848	0	0	0	0	2023-11-15 13:01:59.3362
909	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48570	1673848	0	0	0	0	2023-11-15 13:02:04.342975
910	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48570	1673848	0	0	0	0	2023-11-15 13:02:09.613529
911	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116905	48570	1673848	0	0	0	0	2023-11-15 13:02:14.399432
912	P01233	t	f	t22 segunda opcion.xml	8817	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:02:19.767777
913	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:02:24.655418
914	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:02:29.693387
915	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:02:34.644896
916	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:02:39.48604
917	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:02:44.500166
918	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:02:49.507853
919	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:02:54.519296
920	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:02:59.680537
921	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310683	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:03:04.687016
922	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310716	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:03:09.535902
923	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310716	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:03:14.640043
924	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310716	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:03:19.640361
925	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310716	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:03:24.665347
926	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310716	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:03:29.740231
927	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310716	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:03:34.69343
928	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310716	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:03:39.661179
929	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310716	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:03:44.580469
930	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310716	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:03:49.836487
931	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310716	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:03:54.686744
932	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310716	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:03:59.664289
933	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310716	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:04:04.819742
934	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310716	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:04:09.669883
935	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310716	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:04:14.80133
936	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310716	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:04:19.971666
937	P01233	t	f	t22 segunda opcion.xml	8818	1579839	981557	2561396	1676598	1671804	1674063	1673841	310716	0	0	0	116920	48570	1673848	0	0	0	0	2023-11-15 13:04:24.689342
\.


--
-- Name: MoldingMachinesCycles_cycle_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."MoldingMachinesCycles_cycle_id_seq"', 10, true);


--
-- Name: MoldingMachinesStates_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."MoldingMachinesStates_state_id_seq"', 2221, true);


--
-- Name: MoldingMachines_machine_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."MoldingMachines_machine_id_seq"', 3, true);


--
-- Name: Molds_mold_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Molds_mold_id_seq"', 3, true);


--
-- Name: PreExpMachinesStates_state_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PreExpMachinesStates_state_id_seq"', 937, true);


--
-- Name: PreExpMachines_machine_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PreExpMachines_machine_id_seq"', 1, true);


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

