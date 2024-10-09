-- Crear tabla users (asumiendo que necesitas esta tabla)
CREATE TABLE IF NOT EXISTS public.users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL
);

-- Crear tabla flight
CREATE TABLE IF NOT EXISTS public.flight (
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

CREATE TABLE IF NOT EXISTS public.gateway_payment (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.booking (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    price DECIMAL NOT NULL,
    is_paid BOOLEAN NOT NULL,
    additional_charge DECIMAL,
    status INT NOT NULL DEFAULT -1,
    flight_id INT,
    departure_flight_id INT,
    return_flight_id INT,
    FOREIGN KEY (user_id) REFERENCES public.users(id), -- Referencia a la tabla users
    FOREIGN KEY (flight_id) REFERENCES public.flight(id),
    FOREIGN KEY (departure_flight_id) REFERENCES public.flight(id),
    FOREIGN KEY (return_flight_id) REFERENCES public.flight(id)
);

CREATE TABLE IF NOT EXISTS public.payment (
    id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    total_paid DECIMAL NOT NULL,
    gateway_payment_id INT,
    transaction_id INT,
    payment_status VARCHAR(20),
    payment_id INT,
    FOREIGN KEY (gateway_payment_id) REFERENCES public.gateway_payment(id)
);

CREATE TABLE IF NOT EXISTS public.payment_method (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS public.payment_method_user (
    id SERIAL PRIMARY KEY,
    card_number TEXT NOT NULL,
    card_type TEXT NOT NULL,
    ccv TEXT NOT NULL,
    expiry_date TEXT NOT NULL,
    payment_method_id INT,
    user_id INT,
    last4digits TEXT,
    FOREIGN KEY (payment_method_id) REFERENCES public.payment_method(id),
    FOREIGN KEY (user_id) REFERENCES public.users(id) -- Referencia a la tabla users
);

CREATE TABLE IF NOT EXISTS public.transaction (
    id SERIAL PRIMARY KEY,
    additional_charge DECIMAL,
    date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    booking_id INT,
    payment_method_id INT,
    status INT NOT NULL DEFAULT -1,
    gateway_payment_id INT,
    FOREIGN KEY (booking_id) REFERENCES public.booking(id),
    FOREIGN KEY (payment_method_id) REFERENCES public.payment_method(id),
    FOREIGN KEY (gateway_payment_id) REFERENCES public.gateway_payment(id)
);


-- Insertar datos en flight
INSERT INTO public.flight (departure_date, departure_time, arrival_time, departure_airport, arrival_airport, duration, flight_number, flight_class, stops)
VALUES
('2024-09-20', '10:30:00', '11:30:00', 'MDE', 'BOG', '1h 00m', 'AV9617', 'Básico', 'directFly'),
('2024-09-24', '19:30:00', '20:30:00', 'BOG', 'MDE', '1h 45m', 'AV8902395', 'Golden', '1 parada | CAR');

-- Crear tabla gateway_payment


-- Insertar datos en gateway_payment
INSERT INTO public.gateway_payment (name) VALUES
('E-Payco'),
('Stripe'),
('Mercadopago');

-- Crear tabla booking


-- Insertar datos en booking
INSERT INTO public.booking (user_id, price, is_paid, additional_charge, status, flight_id, departure_flight_id, return_flight_id)
VALUES
(1, 34000, false, 0, -1, 1, 1, 2),
(1, 56000, true, 4500, 0, 2, 1, 2);

-- Crear tabla payment


-- Insertar datos en payment
INSERT INTO public.payment (date, total_paid, gateway_payment_id, transaction_id, payment_status, payment_id)
VALUES
('2024-09-19', 4056, 1, 8, 'CANCELLED', 1),
('2024-09-19', 4056, 1, 8, 'FAILED', 2),
('2024-09-19', 4056, 1, 8, 'PENDING', 3),
('2024-09-19', 4056, 1, 8, 'FAILED', 4),
('2024-09-19', 4056, 1, 8, 'FAILED', 5),
('2024-09-19', 4056, 1, 8, 'CANCELLED', 6),
('2024-09-19', 4056, 1, 8, 'FAILED', 7),
('2024-09-20', 4056, 1, 8, 'SUCCESS', 8);

-- Crear tabla payment_method


-- Insertar datos en payment_method
INSERT INTO public.payment_method (name, description)
VALUES
('Efectivo', NULL),
('Tarjeta de crédito', NULL),
('Tarjeta de débito', NULL);

-- Crear tabla payment_method_user


-- Insertar datos en payment_method_user
INSERT INTO public.payment_method_user (card_number, card_type, ccv, expiry_date, payment_method_id, user_id, last4digits)
VALUES
('L6GYDC0uM0LzKZFDNpx0z00+fGYu+RUcA9uaGbvGHNA=', 'S9CJNhrsqjler+OGZoHHHw==', 'J12y1xRowu88O+tYEYV3lQ==', 'lDtbXGHySXUzB7wK7BSIEg==', 1, 1, '3456'),
('RK7cLlZlDs3d6zpPOKmDOc1zviZOtZooPLgBU3FmmKw=', '57qPx2SiCM8+h13HYfQo9Q==', 'tRdetLqEeQkieRp/JXNw9w==', 'eUSKlMY8+2TbNUd7FzXc7w==', 3, 1, '3456'),
('xVItuVK/r8OZxiyA4cPUrOhE1w4M3ll6ZKM9jNSnDjU=', 'Do8whIXAEmfzxSE6cRn8Tg==', 'QbHtSWfDlm3kcekmkOEHSg==', '++kRT1Xuz5D2f+3ZUVSZNQ==', 3, 1, '1234'),
('5pbqAjQ4N9Tq/VUCWu95MkcLIDp1zk0NkbTtKcNNGQM=', '2RbojngL56WQ55+ww169HA==', 'j0NIHuf8/5EpvG7yHRpIiQ==', '9qCRv1KloE7thcBCBwOqQw==', 3, 1, '345');

-- Crear tabla transaction


-- Insertar datos en transaction
INSERT INTO public.transaction (additional_charge, date, total_price, booking_id, payment_method_id, status, gateway_payment_id)
VALUES
(0, '2024-09-19', 4056, 1, 1, 0, 1),
(0, '2024-09-19', 4056, 2, 2, 1, 2),
(0, '2024-09-19', 4056, 1, 3, 0, 3),
(0, '2024-09-19', 4056, 1, 1, 0, 1);
