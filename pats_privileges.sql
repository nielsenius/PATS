-- PRIVILEGES FOR pats USER OF PATS DATABASE
--
-- by Matthew Nielsen & Theophilus Onime
--
-- SQL needed to create the pats user

CREATE USER pats WITH PASSWORD 'secret';

-- SQL to limit pats user access on key tables

GRANT ALL PRIVILEGES ON DATABASE pats TO pats;
REVOKE DELETE ON TABLE visit_medicines FROM pats;
REVOKE DELETE ON TABLE treatments FROM pats;
REVOKE UPDATE (units_given) ON TABLE visit_medicines FROM pats;

REVOKE ALL PRIVILEGES ON TABLE users FROM public;
GRANT SELECT ON TABLE users TO public;
