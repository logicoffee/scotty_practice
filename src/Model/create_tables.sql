CREATE TABLE users (
    id SERIAL NOT NULL,
    twitter_id text NOT NULL,
)

CREATE TABLE items (
    id SERIAL NOT NULL,
    user_id integer REFERENCES users (id),
    amazon_url text NOT NULL,
    hot_level integer NOT NULL
)
