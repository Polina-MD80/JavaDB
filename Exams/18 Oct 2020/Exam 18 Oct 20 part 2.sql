#2.	Insert
INSERT INTO products_stores (product_id, store_id)
SELECT p.id,1 FROM products as p 
LEFT JOIN products_stores as ps ON p.id = ps.product_id 
WHERE ps.product_id is NULL;

#3.	Update

UPDATE employees 
SET manager_id = 3 AND salary = salary - 500
WHERE year(hire_date) > '2003' and store_id NOT in (5,14);

# 4.	Delete
DELETE FROM employees
WHERE manager_id IS NOT NULL and salary>=6000 AND id not in (select manager_id from employees);

#5.	Employees
SELECT first_name, middle_name, last_name, salary, hire_date FROM employees
ORDER BY hire_date DESC;

#6.	Products with old pictures

SELECT p.name, p.price, p.best_before, concat(substring(p.description, 1,10), '...'), pi.url FROM products as p
LEFT JOIN pictures as pi on p.picture_id = pi.id
WHERE year(pi.added_on)< '2019' and char_length(p.description)>100 and p.price >20
ORDER BY p.price DESC;

#7.	Counts of products in stores and their average 

SELECT s.name, count(p.id) as product_count, round(avg(p.price),2) as avg from stores as s
LEFT JOIN products_stores as ps ON s.id = ps.store_id
LEFT JOIN products as p ON ps.product_id = p.id
GROUP BY s.name
ORDER BY product_count DESC, avg DESC,s.id;

#8.	Specific employee

SELECT concat_ws(' ', e.first_name, e.last_name) as Full_name, s.name as Store_name, a.name as address, e.salary from employees as e
JOIN stores as s on store_id = s.id
JOIN addresses as a ON s.address_id = a.id
WHERE a.name LIKE '%5%'AND char_length(s.name) > 8 and e.salary<4000 and e.last_name LIKE '%n';

#9.	Find all information of stores

SELECT reverse(s.name)AS reversed_name, concat(upper(t.name),'-', a.name) as full_address, count(e.id) as employees_count FROM stores as s
LEFT JOIN addresses as a ON s.address_id = a.id
LEFT JOIN towns as t ON a.town_id = t.id
JOIN employees as e on e.store_id = s.id
GROUP BY s.id
ORDER BY full_address;

#10.	Find full name of top paid employee by store name
DELIMITER $$
CREATE FUNCTION udf_top_paid_employee_by_store(store_name VARCHAR(50))
RETURNS VARCHAR(150) 
DETERMINISTIC
BEGIN
	DECLARE person VARCHAR(150);
	SET person:= (SELECT concat(concat_ws(' ', e.first_name, concat_ws('.', e.middle_name,''), e.last_name),' works in store for ', 
    ROUND((DATEDIFF('2020-10-18', hire_date) / 365.25)), ' years') FROM employees as e
    JOIN stores as s ON e.store_id = s.id
    WHERE s.name = store_name and e.salary = (SELECT max(salary) FROM employees as e1 WHERE e1.store_id = s.id)
    GROUP BY s.name, e.salary, e.id
    );
	RETURN person;
END 

$$

SELECT udf_top_paid_employee_by_store('Stronghold') as 'full_info';
SELECT udf_top_paid_employee_by_store('Keylex') as 'full_info';

#11.	Update product price by address

DELIMITER $$
CREATE PROCEDURE udp_update_product_price (address_name VARCHAR (50))
BEGIN
  UPDATE products
  SET price = (CASE 
  WHEN address_name LIKE '0%' THEN price + 100
  ELSE price + 200
  END);
  END $$
CALL udp_update_product_price('07 Armistice Parkway');
SELECT name, price FROM products WHERE id = 15;
CALL udp_update_product_price('1 Cody Pass');
SELECT name, price FROM products WHERE id = 17;
