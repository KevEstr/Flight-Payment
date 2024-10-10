-- Crear tabla flight
CREATE TABLE IF NOT EXISTS flight (
    id SERIAL PRIMARY KEY,
    departure_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    departure_airport VARCHAR(10) NOT NULL,
    arrival_airport VARCHAR(10) NOT NULL,
    duration VARCHAR(20),
    flight_number VARCHAR(10) NOT NULL,
    flight_class VARCHAR(20),
    stops VARCHAR(50)
);

-- Crear tabla gateway_payment
CREATE TABLE IF NOT EXISTS gateway_payment (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Crear tabla booking
CREATE TABLE IF NOT EXISTS booking (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    price DECIMAL NOT NULL,
    is_paid BOOLEAN NOT NULL,
    additional_charge DECIMAL,
    status INT NOT NULL DEFAULT -1,
    flight_id INT,
    departure_flight_id INT,
    return_flight_id INT,
    FOREIGN KEY (user_id) REFERENCES "user"(id),    -- Referencia a "user"
    FOREIGN KEY (flight_id) REFERENCES flight(id),
    FOREIGN KEY (departure_flight_id) REFERENCES flight(id),
    FOREIGN KEY (return_flight_id) REFERENCES flight(id)
);

-- Crear tabla payment
CREATE TABLE IF NOT EXISTS payment (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    gateway_payment_id INT,
    transaction_id INT,
);

-- ==================== INSERTAR DATOS =============================

-- Insertar datos en "user"
INSERT INTO "user" DEFAULT VALUES;
INSERT INTO "user" DEFAULT VALUES;
INSERT INTO "user" DEFAULT VALUES;
INSERT INTO "user" DEFAULT VALUES;

INSERT INTO public.payment_method (name)
VALUES
('Efectivo'),
('Tarjeta de crédito'),
('Tarjeta de débito');

-- Insertar datos en flight
INSERT INTO flight (departure_date, departure_time, arrival_time, departure_airport, arrival_airport, duration, flight_number, flight_class, stops)
VALUES
('2024-09-20', '10:30:00', '11:30:00', 'MDE', 'BOG', '1h 00m', 'AV9617', 'Básico', 'directFly'),
('2024-09-24', '19:30:00', '20:30:00', 'BOG', 'MDE', '1h 45m', 'AV8902395', 'Golden', '1 parada | CAR');

-- Insertar datos en gateway_payment
INSERT INTO gateway_payment (name) VALUES
('Stripe'),
('U-Pay'),
('Mercadopago');

-- Insertar datos en booking
INSERT INTO booking (user_id, price, is_paid, additional_charge, status, flight_id, departure_flight_id, return_flight_id)
VALUES
(1, 34000, false, 2100, -1, 1, 1, 2),
(2, 66000, false, 4900, 0, 2, 1, 2);
