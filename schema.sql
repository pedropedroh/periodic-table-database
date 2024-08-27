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

UPDATE elements
SET symbol = INITCAP(symbol);

ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL(10, 6);
UPDATE properties
SET atomic_mass = ROUND(atomic_mass, 6);

INSERT INTO elements (atomic_number, symbol, name) VALUES (9, 'F', 'Fluorine');
INSERT INTO properties (atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES
(9, 18.998, -220, -188.1, (SELECT type_id FROM types WHERE type = 'nonmetal'));

INSERT INTO elements (atomic_number, symbol, name) VALUES (10, 'Ne', 'Neon');
INSERT INTO properties (atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES
(10, 20.18, -248.6, -246.1, (SELECT type_id FROM types WHERE type = 'nonmetal'));

