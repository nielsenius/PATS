-- TRANSACTION EXAMPLE FOR PATS DATABASE
--
-- by Matthew Nielsen & Theophilus Onime
--
--

BEGIN;
INSERT INTO visits(pet_id, weight) VALUES (173, 39);
INSERT INTO treatments(visit_id, procedure_id, successful) VALUES (SELECT currval(pg_get_serial_sequence('visits', 'id')), SELECT id FROM procedures WHERE name = "Examination", true);
INSERT INTO visit_medicines(visit_id, medicine_id, units_given) VALUES (SELECT currval(pg_get_serial_sequence('visits', 'id')), 3, 500);
INSERT INTO visit_medicines(visit_id, medicine_id, units_given) VALUES (SELECT currval(pg_get_serial_sequence('visits', 'id')), 5, 200);
-- TRIGGERS SHOULD UPDATE overnight_stay AND total_charge, CHECK THAT THIS WORKS!
COMMIT;
