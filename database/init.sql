-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS "user" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Tabla de reservas (bookings)
CREATE TABLE IF NOT EXISTS booking (
    id SERIAL PRIMARY KEY,
    is_paid BOOLEAN NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    user_id INT NOT NULL REFERENCES "user"(id) ON DELETE CASCADE
);

-- Tabla de métodos de pago
CREATE TABLE IF NOT EXISTS payment_method (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Tabla de pasarelas de pago (gateways)
CREATE TABLE IF NOT EXISTS gateway_payment (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Tabla de transacciones
CREATE TABLE IF NOT EXISTS transaction (
    id SERIAL PRIMARY KEY,
    status VARCHAR(255) NOT NULL,
    date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_price DECIMAL(10, 2) NOT NULL,
    additional_fee DECIMAL(10, 2) DEFAULT 0,
    user_id INT NOT NULL REFERENCES "user"(id) ON DELETE CASCADE,
    payment_method_id INT NOT NULL REFERENCES payment_method(id),
    gateway_payment_id INT NOT NULL REFERENCES gateway_payment(id)
);

-- Insertar datos de prueba en la tabla de usuarios
INSERT INTO "user" (name) VALUES
('John Doe'),
('Jane Smith'),
('Alice Johnson'),
('Bob Brown'),
('Charlie Green');

-- Insertar datos de prueba en la tabla de reservas (bookings)
INSERT INTO booking (is_paid, price, user_id) VALUES
(true, 150.00, 1),
(false, 75.00, 2),
(true, 200.00, 3);

-- Insertar datos de prueba en la tabla de métodos de pago
INSERT INTO payment_method (name) VALUES
('Credit Card'),
('PayPal'),
('Bank Transfer');

-- Insertar datos de prueba en la tabla de pasarelas de pago
INSERT INTO gateway_payment (name) VALUES
('Stripe'),
('Mercado Pago');

-- Insertar datos de prueba en la tabla de transacciones
INSERT INTO transaction (status, date, total_price, additional_fee, user_id, payment_method_id, gateway_payment_id) VALUES
('Completed', '2024-10-01', 150.00, 5.00, 1, 1, 1),
('Pending', '2024-10-02', 75.00, 0.00, 2, 2, 2),
('Completed', '2024-10-03', 200.00, 10.00, 3, 1, 1);