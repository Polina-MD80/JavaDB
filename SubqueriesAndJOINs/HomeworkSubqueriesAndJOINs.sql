
#1
SELECT e.employee_id, e.job_title, e.address_id, a.address_text FROM employees AS e
LEFT JOIN addresses AS a
USING(address_id)
ORDER BY address_id
LIMIT 5;

#2
SELECT e.first_name, e.last_name, t.name as town, a.address_text from employees as e
LEFT JOIN addresses AS a
USING (address_id)
JOIN towns as t
ON a.town_id = t.town_id
ORDER BY e.first_name, e.last_name
LIMIT 5;

#3

SELECT e.employee_id, e.first_name, e.last_name, d.name as department_name from employees as e
JOIN departments as d
ON e.department_id = d.department_id
WHERE d.name = 'Sales'
ORDER BY e.employee_id DESC;

#4
/*•	employee_id
•	first_name
•	salary
•	department_name
*/

SELECT e.employee_id, e.first_name, e.salary, d.name as department_name 
FROM employees AS e
LEFT JOIN departments as d
USING (department_id)
WHERE e.salary > 15000
ORDER BY e.department_id DESC, e.employee_id
LIMIT 5;