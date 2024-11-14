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

-- Insertar datos en booking
INSERT INTO booking (user_id, price, is_paid, additional_charge)
VALUES
(1, 34000, false, 2100),
(2, 66000, false, 4900),
(1, 98000, false, 3500),
(2, 98000, false, 3500),
(1, 98000, false, 3500),
(2, 98000, false, 3500),
(1, 98000, false, 3500),
(2, 98000, false, 3500),
(1, 98000, false, 3500),
(1, 98000, false, 3500),
(2, 98000, false, 3500),
(2, 98000, false, 3500),
(1, 98000, false, 3500),
(2, 98000, false, 3500),
(1, 98000, false, 3500),
(1, 98000, false, 3500),
(1, 98000, false, 3500),
(1, 98000, false, 3500),
(1, 98000, false, 3500),
(2, 98000, false, 3500),
(2, 98000, false, 3500),
(2, 98000, false, 3500),
(2, 98000, false, 3500),
(2, 98000, false, 3500),
(2, 98000, false, 3500),
(1, 98000, false, 3500);
INSERT INTO flight_info (flight_id, booking_id)
VALUES
(1,1),
(2,1),
(1,2),
(2,2),
(1,3),
(2,3);
(1,30),
(2,31),
(1,32);

-- Insertar datos en flight
INSERT INTO flight (departure_date, departure_time, arrival_time, departure_airport, arrival_airport, duration, flight_number, flight_class, stops)
VALUES
('2024-09-20', '10:30:00', '11:30:00', 'MDE', 'BOG', '1h 00m', 'AV9617', 'Básico', 'directFly'),
('2024-09-24', '19:30:00', '20:30:00', 'BOG', 'MDE', '1h 45m', 'AV8902395', 'Golden', '1 parada | CAR'),
('2024-10-01', '07:00:00', '08:00:00', 'BOG', 'CLO', '1h 00m', 'AV1001', 'Económica', 'directFly'),
('2024-10-01', '09:00:00', '10:45:00', 'MDE', 'BOG', '1h 45m', 'AV1002', 'Económica', 'directFly'),
('2024-10-02', '12:00:00', '15:00:00', 'CLO', 'BOG', '3h 00m', 'AV1003', 'Business', 'directFly'),
('2024-10-02', '16:30:00', '18:00:00', 'BOG', 'MDE', '1h 30m', 'AV1004', 'Golden', 'directFly'),
('2024-10-03', '14:00:00', '16:00:00', 'CTG', 'BOG', '2h 00m', 'AV1005', 'Económica', 'directFly');

-- Insertar datos en booking
INSERT INTO booking (id, user_id, price, is_paid, additional_charge)
VALUES
(1, 1, 34000, true, 2100),
(2, 2, 66000, true, 4900),
(3, 1, 98000, false, 3500),
(36, 2, 98000, false, 3500),
(37, 1, 98000, false, 3500),
(38, 2, 98000, false, 3500),
(39, 1, 98000, false, 3500),
(40, 2, 98000, false, 3500),
(41, 1, 98000, false, 3500),
(42, 2, 98000, false, 3500),
(43, 1, 98000, false, 3500),
(44, 2, 98000, false, 3500),
(45, 1, 98000, false, 3500),
(46, 2, 98000, false, 3500),
(47, 1, 98000, false, 3500),
(48, 2, 98000, false, 3500),
(49, 1, 98000, false, 3500),
(50, 2, 98000, false, 3500),
(51, 1, 98000, false, 3500),
(52, 2, 98000, false, 3500),
(53, 1, 98000, false, 3500),
(54, 2, 98000, false, 3500),
(55, 1, 98000, false, 3500),
(30, 2, 34000, true, 2100),
(31, 1, 66000, true, 4900),
(56, 2, 34000, false, 2100),
(57, 1, 66000, false, 4900),
(58, 2, 98000, false, 3500),
(59, 1, 98000, false, 3500),
(60, 2, 98000, false, 3500),
(61, 1, 98000, false, 3500),
(62, 2, 98000, false, 3500),
(63, 1, 98000, false, 3500),
(64, 2, 98000, false, 3500),
(65, 1, 98000, false, 3500),
(66, 2, 98000, false, 3500),
(67, 1, 98000, false, 3500),
(68, 2, 98000, false, 3500),
(69, 1, 98000, false, 3500),
(70, 2, 98000, false, 3500),
(71, 1, 98000, false, 3500),
(72, 2, 98000, false, 3500),
(73, 1, 98000, false, 3500),
(74, 2, 98000, false, 3500),
(75, 1, 98000, false, 3500),
(76, 2, 98000, false, 3500),
(77, 1, 98000, false, 3500),
(78, 2, 98000, false, 3500),
(79, 1, 98000, false, 3500),
(80, 2, 98000, false, 3500),
(81, 1, 98000, false, 3500),
(32, 2, 98000, true, 3500),
(33, 1, 98000, true, 3500),
(34, 2, 98000, true, 3500),
(35, 1, 98000, true, 3500);

-- Asignar vuelos a todas las reservas en la tabla "flight_info"
-- Repitiendo vuelos cuando sea necesario para cubrir todas las reservas
INSERT INTO flight_info (flight_id, booking_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 36),
(5, 37),
(1, 38),
(2, 39),
(3, 40),
(4, 41),
(5, 42),
(1, 43),
(2, 44),
(3, 45),
(4, 46),
(5, 47),
(1, 48),
(2, 49),
(3, 50),
(4, 51),
(5, 52),
(1, 53),
(2, 54),
(3, 55),
(1, 30),
(2, 31),
(3, 56),
(4, 57),
(5, 58),
(1, 59),
(2, 60),
(3, 61),
(4, 62),
(5, 63),
(1, 64),
(2, 65),
(3, 66),
(4, 67),
(5, 68),
(1, 69),
(2, 70),
(3, 71),
(4, 72),
(5, 73),
(1, 74),
(2, 75),
(3, 76),
(4, 77),
(5, 78),
(1, 79),
(2, 80),
(3, 81),
(4, 32),
(5, 33),
(1, 34),
(2, 35);
