-- VIEWS FOR PATS DATABASE
--
-- by Matthew Nielsen & Theophilus Onime
--
--

CREATE OR REPLACE VIEW owners_view AS
    SELECT first_name, last_name, street, city, state, zip, phone, email, owners.active AS "owner_active", pets.name AS "pet_name", animals.name AS "animal_name", owner_id, female, date_of_birth, pets.active AS "pet_active", pet_id, date, weight, overnight_stay, total_charge
    FROM owners
        JOIN pets ON pets.owner_id = owners.id
        JOIN visits ON visits.pet_id = pets.id
        JOIN animals ON animals.id = pets.animal_id;
