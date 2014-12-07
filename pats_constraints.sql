-- CONSTRAINTS FOR PATS DATABASE
--
-- by Matthew Nielsen & Theophilus Onime
--
--

-- foreign key constraints

ALTER TABLE pets
ADD CONSTRAINT animal_id_pets_fk FOREIGN KEY (animal_id)
    REFERENCES animals (id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE pets
ADD CONSTRAINT owner_id_pets_fk FOREIGN KEY (owner_id)
    REFERENCES pets (id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE visits
ADD CONSTRAINT pet_id_visits_fk FOREIGN KEY (pet_id)
    REFERENCES pets (id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE medicine_costs
ADD CONSTRAINT medicine_id_mc_fk FOREIGN KEY (medicine_id)
    REFERENCES medicines (id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

ALTER TABLE animal_medicines
ADD CONSTRAINT animal_id_am_fk FOREIGN KEY (animal_id)
    REFERENCES animals (id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE animal_medicines
ADD CONSTRAINT medicine_id_am_fk FOREIGN KEY (medicine_id)
    REFERENCES medicines (id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE visit_medicines
ADD CONSTRAINT visit_id_vm_fk FOREIGN KEY (visit_id)
    REFERENCES visits (id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE visit_medicines
ADD CONSTRAINT medicine_id_vm_fk FOREIGN KEY (medicine_id)
    REFERENCES medicines (id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE treatments
ADD CONSTRAINT visit_id_treatments_fk FOREIGN KEY (visit_id)
    REFERENCES visits (id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE treatments
ADD CONSTRAINT procedure_id_treatments_fk FOREIGN KEY (procedure_id)
    REFERENCES procedures (id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE procedure_costs
ADD CONSTRAINT procedure_id_pc_fk FOREIGN KEY (procedure_id)
    REFERENCES procedures (id)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

ALTER TABLE notes
ADD CONSTRAINT user_id_notes_fk FOREIGN KEY (user_id)
    REFERENCES users (id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

-- other constraints

ALTER TABLE owners
    ALTER COLUMN first_name SET NOT NULL,
    ALTER COLUMN last_name SET NOT NULL,
    ALTER COLUMN street SET NOT NULL,
    ALTER COLUMN city SET NOT NULL,
    ALTER COLUMN state SET NOT NULL,
    ALTER COLUMN zip SET NOT NULL,
    ALTER COLUMN active SET NOT NULL;

ALTER TABLE pets
    ALTER COLUMN name SET NOT NULL,
    ALTER COLUMN animal_id SET NOT NULL,
    ALTER COLUMN owner_id SET NOT NULL,
    ALTER COLUMN female SET NOT NULL,
    ALTER COLUMN active SET NOT NULL;

ALTER TABLE visits
    ALTER COLUMN pet_id SET NOT NULL,
    ALTER COLUMN date SET NOT NULL,
    ALTER COLUMN overnight_stay SET NOT NULL,
    ALTER COLUMN total_charge SET NOT NULL;

ALTER TABLE animals
    ALTER COLUMN name SET NOT NULL
    ALTER COLUMN active SET NOT NULL,;

ALTER TABLE medicines
    ALTER COLUMN name SET NOT NULL,
    ALTER COLUMN description SET NOT NULL,
    ALTER COLUMN stock_amount SET NOT NULL,
    ALTER COLUMN method SET NOT NULL,
    ALTER COLUMN unit SET NOT NULL,
    ALTER COLUMN vaccine SET NOT NULL;

ALTER TABLE medicine_costs
    ALTER COLUMN medicine_id SET NOT NULL,
    ALTER COLUMN cost_per_unit SET NOT NULL,
    ALTER COLUMN start_date SET NOT NULL;

ALTER TABLE animal_medicines
    ALTER COLUMN animal_id SET NOT NULL,
    ALTER COLUMN medicine_id SET NOT NULL;

ALTER TABLE visit_medicines
    ALTER COLUMN visit_id SET NOT NULL,
    ALTER COLUMN medicine_id SET NOT NULL,
    ALTER COLUMN units_given SET NOT NULL,
    ALTER COLUMN discount SET NOT NULL;

ALTER TABLE procedures
    ALTER COLUMN name SET NOT NULL,
    ALTER COLUMN length_of_time SET NOT NULL,
    ALTER COLUMN active SET NOT NULL;

ALTER TABLE treatments
    ALTER COLUMN visit_id SET NOT NULL,
    ALTER COLUMN procedure_id SET NOT NULL,
    ALTER COLUMN discount SET NOT NULL;

ALTER TABLE procedure_costs
    ALTER COLUMN procedure_id SET NOT NULL,
    ALTER COLUMN cost SET NOT NULL,
    ALTER COLUMN start_date SET NOT NULL;

ALTER TABLE notes
    ALTER COLUMN notable_type SET NOT NULL,
    ALTER COLUMN notable_id SET NOT NULL,
    ALTER COLUMN title SET NOT NULL,
    ALTER COLUMN content SET NOT NULL,
    ALTER COLUMN user_id SET NOT NULL,
    ALTER COLUMN date SET NOT NULL;

ALTER TABLE users
    ALTER COLUMN first_name SET NOT NULL,
    ALTER COLUMN last_name SET NOT NULL,
    ALTER COLUMN role SET NOT NULL,
    ALTER COLUMN username SET NOT NULL,
    ALTER COLUMN password_digest SET NOT NULL,
    ALTER COLUMN active SET NOT NULL;

-- declare users(username) to be unique, also creates an index on the field
ALTER TABLE users ADD UNIQUE (username);

ALTER TABLE medicines ADD CONSTRAINT limit_methods CHECK (method IN ('injection', 'oral', 'intravenous'));

ALTER TABLE visit_medicines ADD CONSTRAINT med_discount_range CHECK (discount BETWEEN 0.00 AND 1.00);
ALTER TABLE treatments ADD CONSTRAINT treatment_discount_range CHECK (discount BETWEEN 0.00 AND 1.00);
