ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;
ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;

ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;
ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;

ALTER TABLE elements ADD CONSTRAINT unique_symbol UNIQUE (symbol);
ALTER TABLE elements ADD CONSTRAINT unique_name UNIQUE (name);
ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;
ALTER TABLE elements ALTER COLUMN name SET NOT NULL;

ALTER TABLE properties ADD CONSTRAINT fk_atomic_number FOREIGN KEY (atomic_number) REFERENCES elements (atomic_number);

CREATE TABLE types (
    type_id SERIAL PRIMARY KEY,
    type VARCHAR NOT NULL
);

INSERT INTO types (type) VALUES
('nonmetal'),
('metal'),
('metalloid');

ALTER TABLE properties ADD COLUMN type_id INT NOT NULL;
ALTER TABLE properties ADD CONSTRAINT fk_type_id FOREIGN KEY (type_id) REFERENCES types (type_id);

UPDATE properties
SET type_id = (SELECT type_id FROM types WHERE types.type = properties.type);

ALTER TABLE properties DROP COLUMN type;

