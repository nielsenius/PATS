-- VIEWS FOR PATS DATABASE
--
-- by Matthew Nielsen & Theophilus Onime
--
--

CREATE VIEW owners_view AS
    SELECT p.owner_id, o.first_name, o.last_name, o.street, o.city, o.state, o.zip, o.phone, o.email, o.active AS "owner_active", v.pet_id, p.name, a.name AS "animal", p.female, p.date_of_birth, p.active AS "pet_active", v.id AS "visit_id", v.date, v.weight, v.overnight_stay, v.total_charge
    FROM owners o
        JOIN pets p ON p.owner_id = o.id
        JOIN visits v ON v.pet_id = p.id
        JOIN animals a ON a.id = p.animal_id;

CREATE VIEW medicine_view AS
SELECT m.id, m.name AS "medicine", m.description, m.stock_amount, m.method, m.unit, m.vaccine, mc.cost_per_unit AS "current cost", mc.start_date AS "date_changed", a.name AS "animal"
    FROM medicines m
        JOIN medicine_costs mc ON mc.medicine_id = m.id
        JOIN animal_medicines am ON am.medicine_id = m.id
        JOIN animals a ON a.id = am.animal_id
    WHERE mc.end_date IS NULL;
