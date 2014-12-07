-- FUNCTIONS AND TRIGGERS FOR PATS DATABASE
--
-- by Matthew Nielsen & Theophilus Onime
--
--
-- calculate_total_costs
-- (associated with two triggers: update_total_costs_for_medicines_changes & update_total_costs_for_treatments_changes)

CREATE TRIGGER update_total_costs_for_medicines_changes
AFTER INSERT OR UPDATE ON visit_medicines
FOR EACH ROW
EXECUTE PROCEDURE calculate_total_costs;

CREATE TRIGGER update_total_costs_for_treatments_changes
AFTER INSERT OR UPDATE ON treatments
FOR EACH ROW
EXECUTE PROCEDURE calculate_total_costs;

CREATE OR REPLACE FUNCTION calculate_total_costs() RETURNS TRIGGER AS $$
    DECLARE
        r record;
        total_cost integer;
    BEGIN
        total_cost = 0;
        
        FOR r IN SELECT * FROM visit_medicines WHERE visit_id = NEW.visit_id LOOP
            total_cost = total_cost + ((SELECT cost_per_unit FROM medicine_costs WHERE medicine_costs.medicine_id = r.medicine_id) * r.units_given * (1 - r.discount));
        END LOOP;
        
        FOR r IN SELECT * FROM treatments WHERE visit_id = NEW.visit_id LOOP
            total_cost = total_cost + ((SELECT cost FROM procedure_costs WHERE procedure_costs.procedure_id = r.procedure_id) * (1 - r.discount));
        END LOOP;
        
        UPDATE visits SET total_charge = total_cost WHERE id = NEW.visit_id;
        
        RETURN NULL;
    END;
$$ LANGUAGE plpgsql;

-- calculate_overnight_stay
-- (associated with a trigger: update_overnight_stay_flag)

CREATE TRIGGER update_overnight_stay_flag
AFTER INSERT ON treatments
EXECUTE PROCEDURE calculate_overnight_stay();

CREATE OR REPLACE FUNCTION calculate_overnight_stay() RETURNS TRIGGER AS $$
    DECLARE
        _treatment_id integer;
        _procedure_id integer;
        _visit_id integer;
        total_time integer;
    BEGIN
        _treatment_id = (SELECT currval(pg_get_serial_sequence('treatments', 'id')));
        _procedure_id = (SELECT procedure_id FROM treatments WHERE id = _treatment_id);
        _visit_id = (SELECT visit_id FROM treatments WHERE id = _treatment_id);
        
        total_time = (SELECT SUM(length_of_time) FROM procedures WHERE id = _procedure_id);
        
        IF total_time > 720 THEN
            UPDATE visits SET overnight_stay = true WHERE id = _visit_id;
        END IF;
        
        RETURN NULL;
    END;
$$ LANGUAGE plpgsql;

--TRIGGER set_end_date_for_previous_medicine_cost
--trigger to automatically set the end_date of previous medicine_costs to the 
--current date after a new record is added.
CREATE TRIGGER set_end_date_for_previous_medicine_cost
AFTER INSERT ON medicine_costs
EXECUTE PROCEDURE set_end_date_for_medicine_costs();

-- set_end_date_for_medicine_costs()
-- (associated with a trigger: set_end_date_for_previous_medicine_cost)
CREATE OR REPLACE FUNCTION set_end_date_for_medicine_costs() RETURNS TRIGGER AS $$
	--
	DECLARE
		most_recent_mc_id INTEGER;
        prev_mc_id INTEGER;
	BEGIN
		--get the recently added medicine_costs medicine_id
		most_recent_mc_id = (SELECT currval(pg_get_serial_sequence('medicine_costs', 'id')));
        prev_mc_id = most_recent_mc_id-1;
		--update previous medicine_cost's end_date to be today
		UPDATE medicine_costs SET end_date = (current_date) WHERE id = prev_mc_id;
	  RETURN NULL;
	END;
	$$ LANGUAGE plpgsql;
	-- used $$ as delimiters b/c needed '' inside sequence eval


-- set_end_date_for_procedure_costs
-- (associated with a trigger: set_end_date_for_previous_procedure_cost
--to automatically set the end_date of either procedure_costs to 
--the current date before a new record is added.)
CREATE TRIGGER set_end_date_for_previous_procedure_cost
AFTER INSERT ON procedure_costs
EXECUTE PROCEDURE set_end_date_for_procedure_costs();

CREATE OR REPLACE FUNCTION set_end_date_for_procedure_costs() RETURNS TRIGGER AS $$
    --
    DECLARE
        most_recent_pc_id INTEGER;
        prev_pc_id INTEGER;
    BEGIN
        --get the recently added procedure procedure_id
        most_recent_pc_id = (SELECT currval(pg_get_serial_sequence('procedure_costs', 'id')));
        prev_pc_id = most_recent_pc_id-1;
        --update previous procedure's end_date to be today
        UPDATE procedure_costs SET end_date = (current_date) WHERE id = prev_pc_id;
      RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    -- used $$ as delimiters b/c needed '' inside sequence eval



-- decrease_stock_amount_after_dosage
-- (associated with a trigger: update_stock_amount_for_medicines)
 --reduce the medicine stock levels after a new visit_medicines application is recorded in the system.

CREATE TRIGGER update_stock_amount_for_medicines
AFTER INSERT ON visit_medicines
EXECUTE PROCEDURE decrease_stock_amount_after_dosage();

CREATE OR REPLACE FUNCTION decrease_stock_amount_after_dosage() RETURNS TRIGGER AS $$
    --
    DECLARE
        newest_vm_id INTEGER;
        newest_vm_medicine_id INTEGER;
        appropriate_medicine_id INTEGER;
        m_stock_amount INTEGER;
        vm_units_given INTEGER;      
        

    BEGIN
        --get id of recently added visit_medicine_id
        newest_vm_id = (SELECT currval(pg_get_serial_sequence('visit_medicines', 'id')));
         --get associated medicine_id of recently added visit_medicine
        newest_vm_medicine_id = (SELECT medicine_id FROM visit_medicines WHERE id = newest_vm_id);
        --find the appropriate medicine to dock stock using id
        appropriate_medicine_id = (SELECT id FROM medicines WHERE id = newest_vm_medicine_id);
        --grab the medicine's stock_amount
        m_stock_amount = (SELECT stock_amount from medicines WHERE id = appropriate_medicine_id);
        --grab the visit_medicine's units_given
        vm_units_given = (SELECT units_given from visit_medicines WHERE id = newest_vm_id);
        --dock the stock of the medicine by the visit_medicine's units given
        UPDATE medicines SET stock_amount = (m_stock_amount - vm_units_given) WHERE id = appropriate_medicine_id;
        
      RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    -- used $$ as delimiters b/c needed '' inside sequence eval




-- verify_that_medicine_requested_in_stock
-- (takes medicine_id and units_needed as arguments and returns a boolean)

CREATE OR REPLACE FUNCTION verify_that_medicine_requested_in_stock(medicine_id int, units_needed int) RETURNS boolean AS $$
    DECLARE
        units_in_stock int;
    BEGIN
        units_in_stock = (SELECT stock_amount FROM medicines WHERE id = medicine_id);
        RETURN units_in_stock - units_needed >= 0;
    END;
$$ LANGUAGE plpgsql;

-- verify_that_medicine_is_appropriate_for_pet
-- (takes medicine_id and pet_id as arguments and returns a boolean)

CREATE OR REPLACE FUNCTION verify_that_medicine_is_appropriate_for_pet(_medicine_id int, _pet_id int) RETURNS boolean AS $$
    DECLARE
        pet_animal_id int;
    BEGIN
        pet_animal_id = (SELECT animal_id FROM pets WHERE id = _pet_id);
        RETURN (SELECT COUNT(*) FROM animal_medicines WHERE animal_id = pet_animal_id AND medicine_id = _medicine_id) = 1;
    END;
$$ LANGUAGE plpgsql;
