-- Создание таблиц для тестовой базы "Аэропорт"

CREATE TABLE airports (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    code CHAR(3) UNIQUE NOT NULL
);

CREATE TABLE airplanes (
    id SERIAL PRIMARY KEY,
    model VARCHAR(50) NOT NULL,
    seats INTEGER NOT NULL,
    manufacturer VARCHAR(50)
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    position VARCHAR(50) NOT NULL,
    airport_id INTEGER REFERENCES airports(id)
);

CREATE TABLE flights (
    id SERIAL PRIMARY KEY,
    flight_number VARCHAR(10) NOT NULL,
    departure_airport_id INTEGER REFERENCES airports(id),
    arrival_airport_id INTEGER REFERENCES airports(id),
    airplane_id INTEGER REFERENCES airplanes(id),
    departure_time TIMESTAMP NOT NULL,
    arrival_time TIMESTAMP NOT NULL
);

CREATE TABLE passengers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    passport_number VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE tickets (
    id SERIAL PRIMARY KEY,
    flight_id INTEGER REFERENCES flights(id),
    passenger_id INTEGER REFERENCES passengers(id),
    seat VARCHAR(5) NOT NULL,
    purchase_time TIMESTAMP NOT NULL DEFAULT NOW()
); 