#1

SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS 'full_name',
    d.department_id,
    d.`name` AS `department_name`
FROM
    employees AS e
     RIGHT JOIN
    departments AS d ON d.manager_id = e.employee_id
ORDER BY e.employee_id
LIMIT 5;


#4
 SELECT COUNT(*) FROM employees
 WHERE salary > (SELECT AVG(salary) from employees);
#4
SELECT COUNT(e.employee_id) AS 'count' 
FROM employees AS e
WHERE e.salary >
(
	SELECT AVG(salary) AS         	'average_salary' FROM employees
);


ALTER TABLE `soft_uni`.`employees` 
ADD INDEX `idx_salary` (`salary` ASC) VISIBLE;
;
#2
SELECT t.town_id, t.`name` as town_name, a.address_text
FROM addresses AS a
RIGHT JOIN towns AS t
USING(town_id)
WHERE t.town_id in(9,15,32)
ORDER BY t.town_id, a.address_id;