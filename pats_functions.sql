-- FUNCTIONS AND TRIGGERS FOR PATS DATABASE
--
-- by (student_1) & (student_2)
--
--
-- calculate_total_costs
-- (associated with two triggers: update_total_costs_for_medicines_changes & update_total_costs_for_treatments_changes)




-- calculate_overnight_stay
-- (associated with a trigger: update_overnight_stay_flag)




-- set_end_date_for_medicine_costs
-- (associated with a trigger: set_end_date_for_previous_medicine_cost)

--trigger first
--we need triggers to automatically set the end_date of either procedure_costs or 
--medicine_costs to the current date before a new record is added.
CREATE FUNCTION set_end_date_for_previous_medicine_cost() RETURNS TRIGGER AS $$
	DECLARE
		--today's date (current_date)
		new_end_date DATE;
		get_mc_id = 
	BEGIN
		--find the medicine cost table itself which will soon become obsolete
		prev_medicine_cost = (SELECT currval(pg_get_serial_sequence('medicine_costs', 'medicine_id')));
		--reset the medicine_cost medicine_id to be correct
		new_end_date = (SELECT end_date FROM medicine_cost WHERE medicine_id = prev_medicine_cost);
		UPDATE medicine_cost SET end_date = (current_date) WHERE medicine_id = get_mc_id;
	  RETURN NULL;
	END;
	$$ LANGUAGE plpgsql;
	-- used $$ as delimiters b/c needed '' inside sequence eval

-- Step 2: call that trigger function whenever a new task is inserted
CREATE TRIGGER increment_created_count
AFTER INSERT ON tasks
EXECUTE PROCEDURE set_end_date_for_previous_medicine_cost();




-- set_end_date_for_procedure_costs
-- (associated with a trigger: set_end_date_for_previous_procedure_cost)




-- decrease_stock_amount_after_dosage
-- (associated with a trigger: update_stock_amount_for_medicines)




-- verify_that_medicine_requested_in_stock
-- (takes medicine_id and units_needed as arguments and returns a boolean)




-- verify_that_medicine_is_appropriate_for_pet
-- (takes medicine_id and pet_id as arguments and returns a boolean)

