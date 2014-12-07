-- TRANSACTION EXAMPLE FOR PATS DATABASE
--
-- by Matthew Nielsen & Theophilus Onime
--
--

-- Matt's version
BEGIN;
INSERT INTO visits(pet_id, weight) VALUES (173, 39);
INSERT INTO treatments(visit_id, procedure_id, successful) VALUES (SELECT currval(pg_get_serial_sequence('visits', 'id')), SELECT id FROM procedures WHERE name = "Examination", true);
INSERT INTO visit_medicines(visit_id, medicine_id, units_given) VALUES (SELECT currval(pg_get_serial_sequence('visits', 'id')), 3, 500);
INSERT INTO visit_medicines(visit_id, medicine_id, units_given) VALUES (SELECT currval(pg_get_serial_sequence('visits', 'id')), 5, 200);
-- TRIGGERS SHOULD UPDATE overnight_stay AND total_charge, CHECK THAT THIS WORKS!
COMMIT;

-- Zaphod (pet id: 173; owned by Horacio Mayert) the dog comes in today for a visit and weighs 39 pounds. 
-- Zaphod gets an examination because he's lost some weight unexpectedly. (Last two visits he weighed 
-- 	48 and 50 pounds, so 39 pounds is low for Zaphod.) 
-- Assuming the required 500 units are in stock and the medicine is appropriate for a dog, 
-- Zaphod is given Ivermectin (medicine id: 3) to treat a nasty parasite which is responsible for the weight loss. 
-- Assuming the required 200 units are in stock and the medicine is appropriate for a dog, Zaphod is 
-- given Mirtazapine (medicine id: 5) to stimulate his appetite and help get his weight back up to the 
-- 50 pound range. 
--Assuming no problems, then total costs for these services and medicines are calculated 
-- (no discounts for Horacio), 
-- the overnight_stay flag is evaluated and all the data is committed to the database. 
-- If there are any problems at any step, 
-- then none of this data is saved to the system. Set up a transaction that will handle this 
-- scenario successfully.

-- Theo's version
BEGIN;
--need to verify sequence names
--do i need to add savepoints?
--need to calculate overnight_stay and total_charge
--do the calculations happen automatically because they are set to be triggered?
INSERT INTO visits (id, pet_id, date, weight)
VALUES (nextval('visits_visit_id_seq'), 173, current_date, 39);
--discount defaults to 0 so no need to enter
INSERT INTO visit_medicines (id, visit_id, medicine_id, units_given)
VALUES (nextval('visit_medicines_visit_medicine_id_seq'), SELECT id from visits where pet_id = 173, 3, 500);
INSERT INTO visit_medicines (id, visit_id, medicine_id, units_given)
VALUES (nextval('visit_medicines_visit_medicine_id_seq'), SELECT id from visits where pet_id = 173, 5, 200);
COMMIT;
