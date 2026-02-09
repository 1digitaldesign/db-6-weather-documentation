
CREATE TABLE IF NOT EXISTS aircraft_position_history (
    id SERIAL PRIMARY KEY,
    "altitude" NUMERIC,
    "created_at" TIMESTAMP,
    "hex" VARCHAR(255),
    "lat" NUMERIC,
    "lon" NUMERIC,
    "speed" VARCHAR(255),
    "timestamp" TIMESTAMP,
    "track" VARCHAR(255),
    "vertical_rate" VARCHAR(255),
);