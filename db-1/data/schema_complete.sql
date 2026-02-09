CREATE TABLE public.aircraft_real (
    hex character varying(6) NOT NULL,
    flight character varying(10),
    lat double precision,
    lon double precision,
    altitude integer,
    speed integer,
    track integer,
    vertical_rate integer,
    squawk character varying(4),
    receiver_id character varying(255),
    seen_at timestamp with time zone DEFAULT now(),
    created_at timestamp with time zone DEFAULT now()
);
CREATE TABLE public.aircraft_sessions_real (
    hex character varying(6) NOT NULL,
    flight character varying(10),
    receiver_id character varying(255),
    first_seen timestamp with time zone NOT NULL,
    last_seen timestamp with time zone NOT NULL,
    ended_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now()
);
CREATE TABLE public.aircraft_position_history (
    id bigint NOT NULL,
    hex character varying(6) NOT NULL,
    lat double precision NOT NULL,
    lon double precision NOT NULL,
    altitude integer NOT NULL,
    speed integer,
    track integer,
    vertical_rate integer,
    "timestamp" timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);
CREATE TABLE public.collision_alerts (
    id bigint NOT NULL,
    hex1 character varying(6) NOT NULL,
    hex2 character varying(6) NOT NULL,
    flight1 character varying(10),
    flight2 character varying(10),
    horizontal_distance_nm double precision,
    vertical_distance_ft integer,
    severity character varying(20),
    detected_at timestamp with time zone DEFAULT now(),
    resolved_at timestamp with time zone
);
CREATE TABLE public.risk_assessments (
    id bigint NOT NULL,
    hex1 character varying(6) NOT NULL,
    hex2 character varying(6) NOT NULL,
    flight1 character varying(10),
    flight2 character varying(10),
    risk_score double precision NOT NULL,
    horizontal_distance_nm double precision,
    vertical_distance_ft integer,
    closure_rate_knots double precision,
    time_to_cpa_seconds integer,
    risk_level character varying(20),
    detected_at timestamp with time zone DEFAULT now(),
    resolved_at timestamp with time zone
);