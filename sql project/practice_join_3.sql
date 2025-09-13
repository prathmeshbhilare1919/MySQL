create database practice_join_3;
use practice_join_3;

CREATE TABLE customers (
    cust_id INT PRIMARY KEY,
    cname VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    cust_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO customers (cust_id, cname, city) VALUES
(1, 'Rahul Sharma', 'Mumbai'),
(2, 'Priya Mehta', 'Delhi'),
(3, 'Amit Kumar', 'Pune'),
(4, 'Sneha Joshi', 'Bangalore'),
(5, 'Vikas Gupta', 'Hyderabad'),
(6, 'Neha Verma', 'Kolkata'),
(7, 'Suresh Patil', 'Chennai'),
(8, 'Anjali Singh', 'Pune'),
(9, 'Manoj Yadav', 'Mumbai'),
(10, 'Kavita Desai', 'Jaipur'),
(11, 'Rohit Nair', 'Kochi'),
(12, 'Deepika Rane', 'Nagpur'),
(13, 'Arjun Khanna', 'Lucknow'),
(14, 'Meena Shah', 'Delhi'),
(15, 'Rajesh Tiwari', 'Patna'),
(16, 'Pooja Bhatia', 'Indore'),
(17, 'Sanjay Chauhan', 'Bhopal'),
(18, 'Komal Jain', 'Surat'),
(19, 'Aditya Malhotra', 'Noida'),
(20, 'Sunita Kapoor', 'Chandigarh');

INSERT INTO orders (order_id, cust_id, order_date, total_amount) VALUES
(101, 1, '2025-01-10', 2500.00),
(102, 2, '2025-01-15', 1800.00),
(103, 1, '2025-02-01', 3200.00),
(104, 3, '2025-02-05', 900.00),
(105, 4, '2025-02-12', 1500.00),
(106, 2, '2025-02-20', 2200.00),
(107, 5, '2025-03-02', 4000.00),
(108, 6, '2025-03-07', 1200.00),
(109, 1, '2025-03-10', 800.00),
(110, 7, '2025-03-15', 1750.00);

INSERT INTO order_items (item_id, order_id, product_name, quantity, price) VALUES
(1, 101, 'Laptop', 1, 2500.00),
(2, 102, 'Mobile Phone', 2, 900.00),
(3, 103, 'Headphones', 2, 800.00),
(4, 103, 'Keyboard', 1, 400.00),
(5, 104, 'Book', 3, 300.00),
(6, 105, 'Shoes', 2, 750.00),
(7, 106, 'Tablet', 1, 2200.00),
(8, 107, 'TV', 1, 4000.00),
(9, 108, 'Earbuds', 2, 600.00),
(10, 109, 'Mouse', 2, 400.00);

/*Easy (Level 1 – Basic Joins)

List all customers with their order IDs.

Show customer names and product names they bought.

Find all orders placed by customers in Mumbai.

Display order_id, customer name, and order date.

List distinct product names purchased by customers in Delhi.

🔹 Medium (Level 2 – Aggregations & Conditions)

Find total amount spent by each customer.

Show customers who bought more than 2 different products.

Find the average order amount per city.

List top 5 most frequently ordered products.

Show all orders where the total order value > 3000.

🔹 Hard (Level 3 – Advanced Joins & Subqueries)

Find the top 3 customers who spent the most in the last 6 months.

Show customers who have never placed an order.

Find the product that generated the highest revenue overall.

List customers who bought products in two different cities (multi-join logic).

For each customer, find their largest single order value.*/



# 1. List all customers with their order IDs.
select c.cname , o.order_id 
from customers c inner join orders o 
on c.cust_id = o.cust_id;

# 2. Show customer names and product names they bought
select c.cname, oi.product_name  from customers c inner join orders o 
on c.cust_id = o.cust_id
inner join order_items oi
on oi.order_id = o.order_id;

#3. Find all orders placed by customers in Mumbai.
select c.cname,oi.product_name,oi.quantity,c.city
from customers c inner join orders o
on c.cust_id = o.cust_id
inner join order_items oi
on oi.order_id = o.order_id
where c.city = "Mumbai";

#4. Display order_id, customer name, and order date
select o.order_id, c.cname, o.order_date
from customers c inner join orders o
on c.cust_id = o.cust_id;

#5.List distinct product names purchased by customers in Delhi
select distinct(oi.product_name),c.cname,c.city 
from customers c inner join orders o 
on c.cust_id = o.cust_id
inner join order_items oi
on o.order_id = oi.order_id
where c.city = "Delhi";

#6. Find total amount spent by each customer.
select c.cname, sum(o.total_amount) as total_amount_each_customer
from customers c inner join orders o
on c.cust_id = o.cust_id
group by c.cname with rollup;

#7. Show customers who bought more than 2 different products.
select c.cname,count(oi.product_name)
from customers c inner join orders o 
on c.cust_id = o.cust_id
inner join order_items oi
on oi.order_id = o.order_id
group by c.cname
having count(distinct oi.product_name)>=2;

#8. Find the average order amount per city
select c.city, avg(o.total_amount)
from customers c inner join orders o 
on c.cust_id = o.cust_id
group by c.city;

# 9. Show all orders where the total order value > 3000
select * from orders
where total_amount > 3000;

# 10. Find the product that generated the highest revenue overall.
select product_name, sum(quantity * price) from order_items
group by product_name
order by sum(quantity * price) desc
limit 1;






