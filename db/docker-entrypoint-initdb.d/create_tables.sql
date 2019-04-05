CREATE TABLE app_user (
    id SERIAL PRIMARY KEY,
    name text NOT NULL UNIQUE,
    password_hash text NOT NULL
);

CREATE TABLE item (
    id SERIAL PRIMARY KEY,
    user_id integer REFERENCES app_user (id),
    amazon_asin text NOT NULL,
    hot_level integer NOT NULL
);
