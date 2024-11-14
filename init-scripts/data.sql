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

-- Crear tabla gateway_payment
CREATE TABLE IF NOT EXISTS "user" (
    id SERIAL PRIMARY KEY
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
    FOREIGN KEY (user_id) REFERENCES "user"(id)    -- Referencia a "user"
);

-- Crear tabla payment
CREATE TABLE IF NOT EXISTS payment (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    gateway_payment_id INT,
    transaction_id INT
);


-- Crear tabla flight_info
CREATE TABLE IF NOT EXISTS flight_info (
    id SERIAL PRIMARY KEY,
    flight_id INT,
    booking_id INT,
    FOREIGN KEY (flight_id) REFERENCES flight(id),
    FOREIGN KEY (booking_id) REFERENCES booking(id)
);

-- ==================== INSERTAR DATOS =============================

-- Insertar datos en "user"
-- Insertar registros en la tabla "user"
INSERT INTO "user" (id)
VALUES
    (1),
    (2),
    (3),
    (4),
    (5);



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
('Mercadopago');

INSERT INTO flight (departure_date, departure_time, arrival_time, departure_airport, arrival_airport, duration, flight_number, flight_class, stops)
VALUES
('2024-11-15', '06:00:00', '07:15:00', 'BOG', 'MDE', '1h 15m', 'AV101', 'Económica', 'directFly'),
('2024-11-16', '14:00:00', '15:30:00', 'CLO', 'BOG', '1h 30m', 'AV102', 'Business', 'directFly'),
('2024-11-17', '12:00:00', '13:30:00', 'MDE', 'CTG', '1h 30m', 'AV103', 'Golden', 'directFly'),
('2024-11-18', '18:00:00', '20:00:00', 'CTG', 'BOG', '2h 00m', 'AV104', 'Económica', 'directFly'),
('2024-11-19', '08:00:00', '10:15:00', 'BOG', 'BAQ', '2h 15m', 'AV105', 'Golden', '1 parada | MDE'),
('2024-11-20', '16:30:00', '17:45:00', 'BAQ', 'BOG', '1h 15m', 'AV106', 'Básico', 'directFly'),
('2024-11-21', '09:00:00', '10:30:00', 'BOG', 'SMR', '1h 30m', 'AV107', 'Golden', 'directFly'),
('2024-11-22', '13:00:00', '15:15:00', 'SMR', 'BOG', '2h 15m', 'AV108', 'Business', '1 parada | MDE'),
('2024-11-23', '11:00:00', '13:00:00', 'BOG', 'PEI', '2h 00m', 'AV109', 'Económica', 'directFly'),
('2024-11-24', '17:00:00', '19:30:00', 'PEI', 'BOG', '2h 30m', 'AV110', 'Básico', '1 parada | CLO'),
('2024-11-25', '10:00:00', '12:00:00', 'BOG', 'MZL', '2h 00m', 'AV111', 'Golden', 'directFly'),
('2024-11-26', '19:30:00', '21:30:00', 'MZL', 'BOG', '2h 00m', 'AV112', 'Business', 'directFly'),
('2024-11-27', '15:00:00', '17:00:00', 'BOG', 'LET', '2h 00m', 'AV113', 'Económica', 'directFly'),
('2024-11-28', '18:00:00', '20:15:00', 'LET', 'BOG', '2h 15m', 'AV114', 'Golden', 'directFly'),
('2024-11-29', '07:00:00', '09:30:00', 'BOG', 'CLO', '2h 30m', 'AV115', 'Business', 'directFly');

-- Insertar nuevos datos en booking
INSERT INTO booking (user_id, price, is_paid, additional_charge)
VALUES
(1, 150000, false, 5000),
(2, 120000, false, 4500),
(3, 180000, false, 4000),
(4, 210000, false, 7000),
(5, 175000, false, 6000),
(1, 190000, false, 5500),
(2, 160000, false, 3500),
(3, 145000, false, 3000),
(4, 230000, false, 5000),
(5, 240000, false, 7500),
(1, 125000, false, 4000),
(2, 155000, false, 4200),
(3, 165000, false, 6000),
(4, 220000, false, 6500),
(5, 130000, false, 3800);

-- Insertar datos en flight_info (asociación de vuelos y reservas)
INSERT INTO flight_info (flight_id, booking_id)
VALUES
(1, 1),
(2,1),
(2, 2),
(3,2),
(3, 3),
(4,1),
(4, 4),
(5,4),
(5, 5),
(6,5),
(6, 6),
(7,6),
(7, 7),
(8,7),
(8, 8),
(9,8),
(9, 9),
(10,9),
(10, 10),
(11,10),
(11, 11),
(12,11),
(12, 12),
(13,12),
(13, 13),
(14,13),
(14, 14),
(15,14),
(15, 15);
