CREATE DATABASE sales_project;
USE sales_project;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    gender VARCHAR(10),
    city VARCHAR(50),
    state VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

# Insert Data
# Customers Data
INSERT INTO customers VALUES
(1,'Amit Sharma','Male','Pune','Maharashtra'),
(2,'Priya Verma','Female','Mumbai','Maharashtra'),
(3,'Rahul Patil','Male','Nashik','Maharashtra'),
(4,'Neha Joshi','Female','Nagpur','Maharashtra'),
(5,'Sachin More','Male','Aurangabad','Maharashtra'),
(6,'Anjali Kulkarni','Female','Sangli','Maharashtra'),
(7,'Rohan Deshpande','Male','Kolhapur','Maharashtra'),
(8,'Pooja Chavan','Female','Satara','Maharashtra'),
(9,'Akash Pawar','Male','Solapur','Maharashtra'),
(10,'Smita Jadhav','Female','Jalgaon','Maharashtra');

# Products Data
INSERT INTO products VALUES
(101,'Laptop','Electronics',55000),
(102,'Mobile','Electronics',25000),
(103,'Headphones','Electronics',3000),
(104,'Office Chair','Furniture',7000),
(105,'Study Table','Furniture',12000),
(106,'Water Bottle','Accessories',800),
(107,'Backpack','Accessories',2500),
(108,'Printer','Electronics',15000),
(109,'LED Monitor','Electronics',18000),
(110,'Desk Lamp','Accessories',1500);

# Orders Data
INSERT INTO orders VALUES
(1,1,101,'2025-01-05',1),
(2,2,102,'2025-01-10',2),
(3,3,104,'2025-02-12',1),
(4,4,103,'2025-02-18',3),
(5,5,105,'2025-03-05',1),
(6,6,107,'2025-03-11',2),
(7,7,109,'2025-04-09',1),
(8,8,106,'2025-04-15',5),
(9,9,108,'2025-05-03',1),
(10,10,110,'2025-05-10',3),
(11,1,102,'2025-06-07',1),
(12,2,101,'2025-06-20',1),
(13,3,107,'2025-07-14',2),
(14,4,109,'2025-07-28',1),
(15,5,103,'2025-08-05',2),
(16,6,105,'2025-08-18',1),
(17,7,108,'2025-09-11',1),
(18,8,110,'2025-09-22',4),
(19,9,106,'2025-10-04',3),
(20,10,104,'2025-10-19',1);

 # Run Your First Analysis Query
 
SELECT c.customer_name,
       SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

# Top Highest Paying Customers
SELECT c.customer_name, 
       SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 5;

 # Category Wise Total Sales
 select p.category,
 sum(p.price*o.quantity) AS category_sales
 from orders o 
 join products p on o.product_id =p.product_id
 group by p.category
 order by category_sales desc;
 
  # City Wise Revenue
  select c. city,
      sum(p.price*o.quantity)as city_sales
  from orders o
  join customers c on o.customer_id = c.customer_id
  join products p on o.product_id = p.product_id
  group by c.city
  order by city_sales desc;
  
  # Gender Based Spending
  SELECT c.gender,
       SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.gender;

#  Month Wise Sales Trend 
SELECT MONTHNAME(order_date) AS month,
       SUM(p.price * o.quantity) AS monthly_sales
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY month
ORDER BY monthly_sales DESC;

# Best Selling Products
SELECT p.product_name,
       SUM(o.quantity) AS total_units_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_units_sold DESC;

# High Value Orders (Above ₹30,000)
SELECT o.order_id, c.customer_name,
       (p.price * o.quantity) AS order_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
WHERE (p.price * o.quantity) > 30000;

# Repeat Customers (Loyal Customers)
SELECT c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 1;

 # Most Profitable Product Category
 SELECT p.category,
       SUM(p.price * o.quantity) AS profit
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY profit DESC
LIMIT 1;

