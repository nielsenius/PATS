-- TABLE STRUCTURE FOR PATS DATABASE
--
-- by Matthew Nielsen & Theophilus Onime
--
--

CREATE TABLE owners (
    id SERIAL PRIMARY KEY, -- PK
    first_name varchar,
    last_name varchar,
    street varchar,
    city varchar,
    state varchar,
    zip varchar,
    phone varchar,
    email varchar,
    active boolean DEFAULT true
);

CREATE TABLE pets (
    id SERIAL PRIMARY KEY, -- PK
    name varchar,
    animal_id integer, -- FK
    owner_id integer, -- FK
    female boolean,
    date_of_birth date,
    active boolean DEFAULT true
);

CREATE TABLE visits (
    id SERIAL PRIMARY KEY, -- PK
    pet_id integer, -- FK
    date date,
    weight integer,
    overnight_stay boolean,
    total_charge integer
);

CREATE TABLE animals (
    id SERIAL PRIMARY KEY, -- PK
    name varchar,
    active boolean DEFAULT true
);

CREATE TABLE medicines (
    id SERIAL PRIMARY KEY, -- PK
    name varchar,
    description text,
    stock_amount integer,
    method varchar,
    unit varchar,
    vaccine boolean
);

CREATE TABLE medicine_costs (
    id SERIAL PRIMARY KEY, -- PK
    medicine_id integer, -- FK
    cost_per_unit integer,
    start_date date DEFAULT now()::date,
    end_date date
);

CREATE TABLE animal_medicines (
    id SERIAL PRIMARY KEY, -- PK
    animal_id integer, -- FK
    medicine_id integer, -- FK
    recommended_num_of_units integer
);

CREATE TABLE visit_medicines (
    id SERIAL PRIMARY KEY, -- PK
    visit_id integer, -- FK
    medicine_id integer, -- FK
    units_given integer,
    discount real DEFAULT 0
);

CREATE TABLE procedures (
    id SERIAL PRIMARY KEY, -- PK
    name varchar,
    description text,
    length_of_time integer,
    active boolean DEFAULT true
);

CREATE TABLE treatments (
    id SERIAL PRIMARY KEY, -- PK
    visit_id integer, -- FK
    procedure_id integer, -- FK
    successful boolean,
    discount real DEFAULT 0
);

CREATE TABLE procedure_costs (
    id SERIAL PRIMARY KEY, -- PK
    procedure_id integer, -- FK
    cost integer,
    start_date date DEFAULT now()::date,
    end_date date
);

CREATE TABLE notes (
    id SERIAL PRIMARY KEY, -- PK
    notable_type varchar, -- FK (polymorphic)
    notable_id integer, -- FK (polymorphic)
    title varchar,
    content text,
    user_id integer, -- FK
    date date DEFAULT now()::date
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY, -- PK
    first_name varchar,
    last_name varchar,
    role varchar,
    username varchar,
    password_digest varchar,
    active boolean DEFAULT true
);
