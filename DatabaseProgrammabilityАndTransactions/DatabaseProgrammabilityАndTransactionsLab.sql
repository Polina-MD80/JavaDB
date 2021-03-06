#1.	Count Employees by Town
DELIMITER $$

CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(20))
RETURNS INT 
DETERMINISTIC
BEGIN
	DECLARE e_count INT;
	SET e_count := (SELECT COUNT(employee_id) FROM employees AS e
	 JOIN addresses AS a ON a.address_id = e.address_id
	 JOIN towns AS t ON t.town_id = a.town_id
	WHERE t.name = town_name);
	RETURN e_count;
END $$

SELECT ufn_count_employees_by_town('Sofia');
SELECT ufn_count_employees_by_town('Berlin');
SELECT ufn_count_employees_by_town(NULL);


DELIMITER $$
CREATE PROCEDURE usp_select_employees_by_seniority() 
BEGIN
  SELECT * 
  FROM employees
  WHERE ROUND((DATEDIFF(NOW(), hire_date) / 365.25)) < 20;
END $$

CALL usp_select_employees_by_seniority();
DROP PROCEDURE usp_select_employees_by_seniority;


-- CREATE PROCEDURE usp_procedure_name 
-- (parameter_1_name parameter_type,
-- parameter_2_name parameter_type,…)


DELIMITER $$
CREATE PROCEDURE usp_select_employees_by_seniority(min_years_at_work INT)
BEGIN
  SELECT first_name, last_name, hire_date,
    ROUND(DATEDIFF(NOW(),DATE(hire_date)) / 365.25,0) AS 'years'
  FROM employees
  WHERE ROUND(DATEDIFF(NOW(),DATE(hire_date)) / 365.25,0) > min_years_at_work
  ORDER BY hire_date;
END $$
CALL usp_select_employees_by_seniority(15);


DELIMITER $$


CREATE PROCEDURE usp_add_numbers
(first_number INT,
second_number INT,
   OUT result INT)
BEGIN
   SET result = first_number + second_number;
END $$
DELIMITER ;
SET @answer=0;
CALL usp_add_numbers(5, 6,@answer);
SELECT @answer; 


#2.	Employees Promotion
DELIMITER $$
CREATE PROCEDURE usp_raise_salaries(department_name varchar(50))
BEGIN
	UPDATE employees AS e 
	 JOIN departments AS d 
	ON e.department_id = d.department_id 
	SET salary = salary * 1.05
	WHERE d.name = department_name;
END $$
CALL usp_raise_salaries('Sales');

#3. Employees Promotion by ID
DELIMITER $$
CREATE PROCEDURE usp_raise_salary_by_id(id int)
BEGIN
	START TRANSACTION;
	IF((SELECT count(employee_id) FROM employees WHERE employee_id like id)<>1) THEN
	ROLLBACK;
	ELSE
		UPDATE employees AS e SET salary = salary + salary*0.05 
		WHERE e.employee_id = id;
	END IF; 
END $$


# 4. Triggered
CREATE TABLE deleted_employees(
	employee_id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	middle_name VARCHAR(20),
	job_title VARCHAR(50),
	department_id INT,
	salary DOUBLE 
);
CREATE TABLE new_employees(
	employee_id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(20),
	last_name VARCHAR(20),
	middle_name VARCHAR(20),
	job_title VARCHAR(50),
	department_id INT,
	salary DOUBLE 
);
DELIMITER $$

CREATE TRIGGER tr_deleted_employees
AFTER DELETE
ON new_employees
FOR EACH ROW
BEGIN
	INSERT INTO deleted_employees (first_name,last_name, middle_name,job_title,department_id,salary)
	VALUES(OLD.first_name,OLD.last_name,OLD.middle_name, OLD.job_title, OLD.department_id, OLD.salary);
END; $$

INSERT INTO new_employees (first_name,last_name, middle_name,job_title,department_id,salary)
VALUES('Ivan1', 'Ivanov', 'To', 'hihi', 3, 500),
('Ivan2', 'Ivan', 'Toe', 'hihi', 3, 50),
('Ivan3', 'Inov', 'To', 'hihi', 3, 5000);

DELETE FROM new_employees Where employee_id = 1;