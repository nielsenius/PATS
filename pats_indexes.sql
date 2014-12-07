-- INDEXES FOR PATS DATABASE
--
-- by Matthew Nielsen & Theophilus Onime
--
--

-- medicines(description) text search index
CREATE INDEX med_description_idx ON medicines USING gin(to_tsvector('english', "description"));

-- indexes on foreign keys for faster lookups
CREATE INDEX pets_animal_id_idx ON pets(animal_id);
CREATE INDEX pets_owner_id_idx ON pets(owner_id);
CREATE INDEX visits_pet_id_idx ON visits(pet_id);
CREATE INDEX mc_medicine_id_idx ON medicine_costs(medicine_id);
CREATE INDEX am_animal_id_idx ON animal_medicines(animal_id);
CREATE INDEX am_medicine_id_idx ON animal_medicines(medicine_id);
CREATE INDEX vm_visit_id_idx ON visit_medicines(visit_id);
CREATE INDEX vm_medicine_id_idx ON visit_medicines(medicine_id);
CREATE INDEX treatments_visit_id_idx ON treatments(visit_id);
CREATE INDEX treatments_procedure_id_idx ON treatments(procedure_id);
CREATE INDEX pc_procedure_id_idx ON procedure_costs(procedure_id);
CREATE INDEX notes_notable_type_idx ON notes(notable_type);
CREATE INDEX notes_notable_id_idx ON notes(notable_id);
CREATE INDEX notes_user_id_idx ON notes(user_id);
