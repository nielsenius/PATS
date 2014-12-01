-- INDEXES FOR PATS DATABASE
--
-- by Matthew Nielsen & Theophilus Onime
--
--

CREATE INDEX med_description_idx ON medicines USING gin(to_tsvector('english', "description"));
