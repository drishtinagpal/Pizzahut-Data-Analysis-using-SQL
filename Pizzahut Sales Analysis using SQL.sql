create database pizzahut;
use pizzahut;

create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id));


create table order_details(
order_details_id int not null,
order_id int not null,
quantity int not null,
pizza_id text not null,
primary key(order_details_id));


-- Total no of orders placed

SELECT 
    *
FROM
    orders;
SELECT 
    COUNT(order_id)
FROM
    orders;

;


-- Total revenue generated

SELECT 
    SUM(order_details.quantity * pizzas.price) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;


-- identify highest price pizza

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;


--  identify most common pizza size ordered

SELECT 
    pizzas.size, COUNT(order_details.order_details_id) AS o
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY o DESC
LIMIT 1;



-- top 5 most orderd pizza along with quantity

SELECT 
    pizza_types.category, SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC
LIMIT 5;


-- determine distribution of orders by hour of the day


SELECT 
    HOUR(order_time), COUNT(order_id)
FROM
    orders
GROUP BY HOUR(order_time);



SELECT 
    ROUND(AVG(x))
FROM
    (SELECT 
        order_date, SUM(order_details.quantity) AS x
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY order_date) AS y;
    
    
    select * from pizza_types;
     select * from pizzas;
     select * from orders;
     select * from order_details;
     
	
SELECT 
    pizza_types.category,
    SUM(pizzas.price * (order_details.quantity)) AS revenue
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.category
ORDER BY revenue DESC
LIMIT 3;



