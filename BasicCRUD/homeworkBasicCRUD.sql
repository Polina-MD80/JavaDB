 #1
 SELECT * from `departments`;
 
 #2
 SELECT `name` FROM `departments`;
 
 #3
 SELECT `first_name`, `last_name`, `salary` FROM `employees`;
 
 #4
 SELECT `first_name`, `middle_name`, `last_name` FROM `employees`;

 #5
 SELECT concat (`first_name`, '.', `last_name`, '@softuni.bg') as`full_email_address` FROM `employees`;
 
 #6
 SELECT DISTINCT salary FROM employees
 ORDER BY employee_id;
 
 #7
 SELECT * FROM employees
 WHERE job_title = 'Sales Representative';
 
 #8
 
 SELECT  first_name, last_name, job_title FROM employees
 WHERE salary>=20000 AND salary <= 30000
 ORDER BY employee_id;
 
 #9
 
 SELECT concat_ws(' ', first_name, middle_name, last_name) as `Full Name`FROM employees
 WHERE salary IN(25000, 14000, 12500, 23600);

#10

SELECT first_name, last_name FROM employees
WHERE manager_id is NULL;

#11

SELECT first_name, last_name, salary FROM employees
WHERE salary >50000
ORDER BY salary DESC;

#12
SELECT first_name, last_name FROM employees
ORDER BY salary DESC
LIMIT 5;

#13

 SELECT first_name, last_name FROM employees
 WHERE department_id <> 4;
 
 #14
 /*SQL query to sort all records in the еmployees table by the following criteria:  
•	First by salary in decreasing order 
•	Then by first name alphabetically 
•	Then by last name descending 
•	Then by middle name alphabetically 
*/

SELECT * FROM employees
ORDER BY salary DESC,
first_name, last_name DESC, middle_name;

#15
CREATE VIEW `v_employees_salaries` 
AS 
SELECT `first_name`, `last_name`, `salary` FROM employees;

SELECT * FROM v_employees_salaries;

#16
CREATE VIEW `v_employees_job_titles`
as
SELECT concat_ws(' ', first_name, middle_name, last_name) AS `full_name`,
`job_title` FROM employees;

SELECT * FROM v_employees_job_titles;

#17

SELECT DISTINCT job_title FROM employees
ORDER BY job_title;

#18
/*by start date, then by name. Sort the information by id.  */

SELECT * FROM projects
ORDER BY start_date, `name`, project_id
LIMIT 10;

#19

SELECT first_name, last_name, hire_date FROM employees
ORDER BY hire_date DESC
LIMIT 7;

#20

update  employees
set salary = salary *1.12
WHERE department_id in (1,2,11,4);

SELECT salary FROM employees;

#21

SELECT peak_name FROM peaks
ORDER BY peak_name;

#22

SELECT country_name, population FROM countries
WHERE continent_code = 'EU'
ORDER BY population DESC, country_name
LIMIT 30;

#23
 
 SELECT  country_name, country_code, if(currency_code = 'EUR', 'Euro', 'Not Euro')
 as `Currency` FROM countries
 ORDER BY country_name;
 
 #24
 SELECT `name` FROM characters
 ORDER BY `name`;
 
 
  
