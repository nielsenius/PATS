-- TABLE STRUCTURE FOR PATS DATABASE
--
-- by Matthew Nielsen & Theophilus Onime
--
--

CREATE TABLE owners (
    id SERIAL PRIMARY KEY, -- PK
    first_name varchar NOT NULL,
    last_name varchar NOT NULL,
    street varchar,
    city varchar,
    state varchar,
    zip varchar,
    phone varchar NOT NULL,
    email varchar,
    active boolean DEFAULT true
);

CREATE TABLE pets (
    id SERIAL PRIMARY KEY, -- PK
    name varchar NOT NULL,
    animal_id integer NOT NULL, -- FK
    owner_id integer NOT NULL, -- FK
    female boolean NOT NULL,
    date_of_birth date NOT NULL,
    active boolean DEFAULT true
);

CREATE TABLE visits (
    id SERIAL PRIMARY KEY, -- PK
    pet_id integer NOT NULL, -- FK
    date date NOT NULL,
    weight integer,
    overnight_stay boolean,
    total_charge integer
);

CREATE TABLE animals (
    id SERIAL PRIMARY KEY, -- PK
    name varchar NOT NULL,
    active boolean DEFAULT true
);

CREATE TABLE medicines (
    id SERIAL PRIMARY KEY, -- PK
    name varchar NOT NULL,
    description text,
    stock_amount integer,
    method varchar NOT NULL,
    unit varchar NOT NULL,
    vaccine boolean NOT NULL
);

CREATE TABLE medicine_costs (
    id SERIAL PRIMARY KEY, -- PK
    medicine_id integer NOT NULL, -- FK
    cost_per_unit integer NOT NULL,
    start_date date DEFAULT now()::date,
    end_date date
);

CREATE TABLE animal_medicines (
    id SERIAL PRIMARY KEY, -- PK
    animal_id integer NOT NULL, -- FK
    medicine_id integer NOT NULL, -- FK
    recommended_num_of_units integer
);

CREATE TABLE visit_medicines (
    id SERIAL PRIMARY KEY, -- PK
    visit_id integer NOT NULL, -- FK
    medicine_id integer NOT NULL, -- FK
    units_given integer NOT NULL,
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
    procedure_id integer NOT NULL, -- FK
    cost integer NOT NULL,
    start_date date DEFAULT now()::date,
    end_date date
);

CREATE TABLE notes (
    id SERIAL PRIMARY KEY, -- PK
    notable_type varchar NOT NULL, -- FK (polymorphic)
    notable_id integer NOT NULL, -- FK (polymorphic)
    title varchar NOT NULL,
    content text NOT NULL,
    user_id integer NOT NULL, -- FK
    date date DEFAULT now()::date
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY, -- PK
    first_name varchar NOT NULL,
    last_name varchar NOT NULL,
    role varchar NOT NULL,
    username varchar NOT NULL,
    password_digest varchar NOT NULL,
    active boolean DEFAULT true
);
