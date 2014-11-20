-- CONSTRAINTS FOR PATS DATABASE
--
-- by Matthew Nielsen & Theophilus Onime
--
--

ALTER TABLE pets
ADD CONSTRAINT animal_id_pets_fk FOREIGN KEY (animal_id)
    REFERENCES animals (id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE pets
ADD CONSTRAINT owner_id_pets_fk FOREIGN KEY (owner_id)
    REFERENCES animals (id)
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
    ON DELETE RESTRICT;

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
    REFERENCES procdures (id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE procedure_costs
ADD CONSTRAINT procedure_id_pc_fk FOREIGN KEY (procedure_id)
    REFERENCES procedures (id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;

ALTER TABLE notes
ADD CONSTRAINT user_id_notes_fk FOREIGN KEY (user_id)
    REFERENCES users (id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT;
