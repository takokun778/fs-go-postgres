
-- +migrate Up
ALTER TABLE users ADD COLUMN age integer NOT NULL;

-- +migrate Down
ALTER TABLE users DROP COLUMN age;
