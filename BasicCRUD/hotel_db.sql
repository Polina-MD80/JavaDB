CREATE DATABASE IF NOT EXISTS `hotel`; 
USE `hotel`;

CREATE TABLE departments (
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50)
);

INSERT INTO departments(name) VALUES('Front Office'), ('Support'), ('Kitchen'), ('Other');

CREATE TABLE employees (
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	job_title VARCHAR(50) NOT NULL,
	department_id INT NOT NULL,
	salary DOUBLE NOT NULL,
	CONSTRAINT `fk_department_id` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`)
);

INSERT INTO `employees` (`first_name`,`last_name`, `job_title`,`department_id`,`salary`) VALUES
	('John', 'Smith', 'Manager',1, 900.00),
	('John', 'Johnson', 'Customer Service',2, 880.00),
	('Smith', 'Johnson', 'Porter', 4, 1100.00),
	('Peter', 'Petrov', 'Front Desk Clerk', 1, 1100.00),
	('Peter', 'Ivanov', 'Sales', 2, 1500.23),
	('Ivan' ,'Petrov', 'Waiter', 3, 990.00),
	('Jack', 'Jackson', 'Executive Chef', 3, 1800.00),
	('Pedro', 'Petrov', 'Front Desk Supervisor', 1, 2100.00),
	('Nikolay', 'Ivanov', 'Housekeeping', 4, 1600.00);
	

	
CREATE TABLE rooms (
	id INT PRIMARY KEY AUTO_INCREMENT,
	`type` VARCHAR(30)
);

INSERT INTO rooms(`type`) VALUES('apartment'), ('single room');

CREATE TABLE clients (
	id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	room_id INT NOT NULL,
    CONSTRAINT fk_clients_rooms
    FOREIGN KEY (room_id)
    REFERENCES rooms(id)
);

INSERT INTO clients(`first_name`,`last_name`,`room_id`) 
VALUES('Pesho','Petrov', 1),('Gosho','Georgiev', 2),
('Mariya','Marieva', 2), ('Katya','Katerinova', 1), ('Nikolay','Nikolaev', 2);

#1
SELECT  id, first_name, last_name, job_title FROM employees
ORDER BY `id`;
# 000 example
SELECT e.id AS 'No.', 
e.first_name AS 'First Name',
e.last_name AS 'Last Name',
e.job_title AS 'Job Title'
FROM employees AS e ORDER BY id;
# concat_ws скипва null value.
SELECT concat_ws(' ', `first_name`, `last_name`, `job_title`) 
AS 'full_name', 	
`job_title` AS  'Job Title',
`id` AS 'No.'
  FROM `employees`;

SELECT DISTINCT `department_id`
  FROM `employees`;
SELECT `last_name`, `department_id` 
FROM `employees` 
WHERE `department_id` = 1;
SELECT `last_name`, `salary` 
FROM `employees`
WHERE `salary` <= 20000;
SELECT concat(`first_name`,' ',`last_name`) AS 	'Full name', 
	`job_title` AS 'Job title', 
       `salary` AS 'Salary'
  FROM `employees` WHERE salary > 1000;


#2
SELECT id, concat(first_name, ' ',last_name) as `full_name`, job_title, salary FROM employees
WHERE salary >= 1000;

#3
UPDATE employees
SET salary = salary + 100
WHERE job_title = 'Manager';
SELECT salary
FROM employees;

CREATE VIEW `v_hr_result_set` AS
SELECT 
    CONCAT(`first_name`,' ',`last_name`) AS 'Full Name', `salary`
FROM `employees` ORDER BY `department_id`;
SELECT * FROM `v_hr_result_set`;
#4
CREATE VIEW `v_top_paid_employee`
AS
    SELECT * FROM `employees`
    ORDER BY `salary` DESC LIMIT 1;
    
SELECT * FROM hotel.v_top_paid_employee;
