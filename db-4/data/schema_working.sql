
CREATE TABLE IF NOT EXISTS models (
    id SERIAL PRIMARY KEY,
    "created_at" TIMESTAMP,
    "name" VARCHAR(255),
    "user_id" VARCHAR(255),
);