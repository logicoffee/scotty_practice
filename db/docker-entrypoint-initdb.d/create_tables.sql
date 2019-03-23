CREATE TABLE app_user (
    id SERIAL PRIMARY KEY,
    twitter_id text NOT NULL
);

CREATE TABLE item (
    id SERIAL PRIMARY KEY,
    user_id integer REFERENCES app_user (id),
    amazon_url text NOT NULL,
    hot_level integer NOT NULL
);
