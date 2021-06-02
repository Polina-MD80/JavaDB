#1
SELECT first_name, last_name FROM employees
WHERE substring(first_name, 1, 2) = 'Sa';
-- first_name LIKE 'Sa%'
#2
SELECT first_name, last_name FROM employees
WHERE lower(last_name) like '%ei%';
#3
SELECT first_name FROM employees
WHERE
YEAR(hire_date) BETWEEN 1995 and 2005 and
department_id in(3,10)
ORDER BY employee_id;

#4
SELECT first_name, last_name FROM employees
WHERE lower(job_title) not like '%engineer%';

#5
SELECT `name` FROM towns
WHERE char_length(`name`) BETWEEN 5 and 6
ORDER BY `name`;

#6
SELECT * from towns
WHERE substring(`name`,1,1) IN ('M', 'K', 'B', 'E')
ORDER BY `name`;

#7
SELECT * from towns
WHERE left(`name`,1) NOT IN ('R', 'B', 'D')
ORDER BY `name`;

#8
CREATE VIEW `v_employees_hired_after_2000`
as
SELECT
`first_name`, `last_name` FROM employees
WHERE year(hire_date) > 2000;

SELECT * FROM v_employees_hired_after_2000;

#9
SELECT first_name, last_name FROM employees
WHERE char_length(last_name) = 5;

#10
SELECT  country_name, iso_code FROM countries
WHERE country_name like '%A%A%A%'
ORDER BY iso_code;

#11
SELECT 
    peak_name,
    river_name,
    CONCAT(LOWER(peak_name),
            SUBSTRING(lower(river_name), 2)) AS `mix`
FROM
    peaks,
    rivers
WHERE
    RIGHT(LOWER(peak_name), 1) = LEFT(LOWER(river_name), 1)
ORDER BY mix;
 
 #12
 
SELECT `name`, date_format(`start`, '%Y-%m-%d') FROM games
WHERE year(`start`) IN (2011,2012)
ORDER BY `start`, `name`
LIMIT 50;

# 13

SELECT 
    user_name,
    SUBSTRING(email, LOCATE('@', email) + 1) AS `Email Provider`
FROM users
ORDER BY `Email Provider`, user_name;
 
 #14
 SELECT user_name, ip_address FROM users
 WHERE ip_address like '___.1%.%.___'
 ORDER BY user_name;
 
 #15
 SELECT 
 `name` as `game`,
 (
 CASE
 WHEN hour(`start`) >= 0 and hour(`start`) <12 THEN 'Morning'
 WHEN hour(`start`) >= 12 and hour(`start`) <18 THEN 'Afternoon'
 ELSE 'Evening'
 END 
 )
 as `Part of the Day`,
 (CASE
 WHEN duration <= 3 THEN 'Extra Short'
 WHEN duration > 3 and duration <= 6 THEN 'Short'
 WHEN duration > 6 and duration <= 10 THEN 'Long'
 ELSE 'Extra Long'
 END
)
as `Duration` from games;
 
 #16
 
 SELECT product_name, order_date, 
 date_add(order_date, interval 3 day) as `pay_due`, 
 date_add(order_date, interval 1 month) as `deliver_due`
 from orders;