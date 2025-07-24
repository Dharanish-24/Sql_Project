-- CREATE DATA SCHEMA
CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  phone VARCHAR(15),
  address TEXT
);

CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  description TEXT,
  price DECIMAL(10, 2),
  stock_quantity INT,
  category VARCHAR(50)
);

CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(customer_id),
  order_date DATE,
  status VARCHAR(20)
);

CREATE TABLE order_items (
  order_item_id SERIAL PRIMARY KEY,
  order_id INT REFERENCES orders(order_id),
  product_id INT REFERENCES products(product_id),
  quantity INT,
  price_at_time DECIMAL(10, 2)
);

CREATE TABLE payments (
  payment_id SERIAL PRIMARY KEY,
  order_id INT REFERENCES orders(order_id),
  payment_date DATE,
  amount DECIMAL(10, 2),
  payment_method VARCHAR(30)
);

-- INSERT SAMPLE DATA
-- Customers
INSERT INTO customers (name, email, phone, address) VALUES
('Ravi Kumar', 'ravi@example.com', '9876543210', 'Chennai'),
('Anjali Mehra', 'anjali@example.com', '9123456780', 'Delhi');

-- Products
INSERT INTO products (name, description, price, stock_quantity, category) VALUES
('Laptop', 'i5 11th Gen', 55000.00, 10, 'Electronics'),
('Mouse', 'Wireless', 499.00, 50, 'Accessories');

-- Orders
INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2025-07-18', 'placed'),
(2, '2025-07-19', 'shipped');

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity, price_at_time) VALUES
(1, 1, 1, 55000.00),
(2, 2, 2, 499.00);

-- Payments
INSERT INTO payments (order_id, payment_date, amount, payment_method) VALUES
(1, '2025-07-18', 55000.00, 'Credit Card'),
(2, '2025-07-19', 998.00, 'UPI');

-- CREATE VIEW

CREATE VIEW saless_report AS
SELECT o.order_id, c.name AS customer_name, p.name AS product_name, 
       oi.quantity, oi.price_at_time, (oi.quantity * oi.price_at_time) AS total_price,
       pay.payment_date, pay.payment_method
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
JOIN payments pay ON o.order_id = pay.order_id;

