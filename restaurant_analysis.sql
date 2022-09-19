-- Part 1 Customer Preference

-- Question 1 : Top five favorite menu that customers really love to order in all branches
SELECT 
	menu_name,
    COUNT(menu_name) AS number_of_menu,
	menu_price,
    SUM(total_price) AS total_revenue   
FROM menu AS m 
JOIN orders AS o ON m.menu_id = o.menu_id
GROUP BY 1
order by 2 DESC LIMIT 5;

-- Question 2 : What are menu types that are popular in all branches? 
SELECT 	    
    type_name AS type_menu,
    ROUND(AVG(total_price), 2) AS avg_revenue
FROM menu AS m 
JOIN orders AS o ON m.menu_id = o.menu_id
JOIN type_menu AS ty ON ty.type_id = m.type_id
GROUP BY 1
ORDER by 2 DESC;

-- Question 3 :  What are menu types that are popular in each branch? 
CREATE VIEW union_table AS
SELECT 
	 city, type_name, 
     COUNT(type_name) AS number_of_menu_type   
FROM location AS l 
JOIN orders AS o ON l.location_id = o.location_id
JOIN menu AS m on m.menu_id = o.menu_id
JOIN type_menu AS tm ON tm.type_id = m.type_id
WHERE city = 'Bangkok'  
GROUP BY type_name
UNION ALL 
SELECT 
	 city, type_name, 
     COUNT(type_name) AS number_of_menu_type   
FROM location AS l 
JOIN orders AS o ON l.location_id = o.location_id
JOIN menu AS m on m.menu_id = o.menu_id
JOIN type_menu AS tm ON tm.type_id = m.type_id
WHERE city = 'London' 
GROUP BY type_name
UNION ALL 
SELECT 
	 city, type_name, 
     COUNT(type_name) AS number_of_menu_type      
FROM location AS l 
JOIN orders AS o ON l.location_id = o.location_id
JOIN menu AS m on m.menu_id = o.menu_id
JOIN type_menu AS tm ON tm.type_id = m.type_id
WHERE city = 'Tokyo' 
GROUP BY type_name
UNION ALL 
SELECT 
	 city, type_name, 
     COUNT(type_name) AS number_of_menu_type   
FROM location AS l 
JOIN orders AS o ON l.location_id = o.location_id
JOIN menu AS m on m.menu_id = o.menu_id
JOIN type_menu AS tm ON tm.type_id = m.type_id
WHERE city = 'Paris' 
GROUP BY type_name
UNION ALL 
SELECT 
	 city, type_name,
     COUNT(type_name) AS number_of_menu_type  
FROM location AS l 
JOIN orders AS o ON l.location_id = o.location_id
JOIN menu AS m on m.menu_id = o.menu_id
JOIN type_menu AS tm ON tm.type_id = m.type_id
WHERE city = 'Singapore' 
GROUP BY type_name

SELECT * from union_table
order BY number_of_menu_type DESC;

-- Question 4 : Which are payment options that customers like to use?
SELECT 
	payment_term,
    COUNT(payment_term) AS number_of_payment
FROM payment AS p 
JOIN orders AS o ON p.payment_id = o.payment_id
GROUP BY 1;


-- Part 2 Restaurant Revenue

-- Question 1 :  Who are the top spenders in all branches on Aug 1-14, 2022?
SELECT 
	customer_name,
    city,
    SUM(total_price) AS total_revenue
FROM customer AS c
JOIN orders AS o ON c.customer_id = o.customer_id
JOIN location AS l ON l.location_id = o.location_id
group BY customer_name
ORDER BY total_revenue DESC LIMIT 10;

-- Question 2 : Compare with average revenue of each region.
WITH region_branches AS
(SELECT	location_id, city,
    CASE 
    WHEN city IN ('London', 'Paris') THEN 'Europe'
    Else 'Asia' 
    END AS region_branches
FROM location)

SELECT 	
	rb.region_branches,
    ROUND(AVG(total_price),2) AS avg_revenue 
FROM region_branches AS rb
JOIN orders AS o ON rb.location_id = o.location_id
GROUP BY 1;

-- Question 3 :  Which are city branches have the best total revenue on Aug 1-14, 2022?
WITH region_branches AS
(SELECT location_id, city,
    CASE 
    WHEN city IN ('London', 'Paris') THEN 'Europe'
    Else 'Asia' 
    END AS region_branches
FROM location)

SELECT 	
	rb.city,
    SUM(total_price) AS total_revenue 
FROM region_branches AS rb
JOIN orders AS o ON rb.location_id = o.location_id
GROUP BY 1
ORDER BY 2 DESC;

-- Question 4 : What is the best golden time of restaurant?
SELECT
	STRFTIME("%H:%M", order_date) AS hours,
    SUM(total_price) as revenue
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

-- Question 5 : Top ten customers use between cash and credit card on Aug 1-14, 2022
WITH top_ten_customer AS(
SELECT 
	c.customer_name, 
  	p.payment_term,
    SUM(o.total_price) as total_invoice 
FROM customer AS c 
JOIN orders AS o ON c.customer_id = o.customer_id
JOIN payment AS p ON p.payment_id = o. payment_id
GROUP BY c.customer_name
ORDER BY total_invoice DESC)

SELECT * from top_ten_customer
WHERE payment_term IN ('Cash', 'Credit Card')
LIMIT 10; 

