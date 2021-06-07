
#1
CREATE SCHEMA test;
use test;

CREATE TABLE people(
`person_id` INT PRIMARY KEY AUTO_INCREMENT,
`first_name` VARCHAR(45) NOT NULL,
`salary` DECIMAL(7,2),
`passport_id` INT NOT NULL UNIQUE)
;

CREATE TABLE passports(
`passport_id` INT PRIMARY key,
`passport_number` VARCHAR(20) UNIQUE NOT NULL)
AUTO_INCREMENT = 101;

ALTER TABLE people
add CONSTRAINT fk_people_passports
FOREIGN KEY (passport_id)
REFERENCES passports(passport_id)
on DELETE CASCADE;



INSERT INTO `passports` (`passport_id`, `passport_number`) 
VALUES ('101', 'N34FG21B'),
('102', 'K65LO4R7'),
('103', 'ZE657QP2');

INSERT INTO `people` (`first_name`, `salary`, `passport_id`) 
VALUES ('Roberto', '43300.00', '102'),
('Tom', '56100.00', '103'),
('Yana', '60200.00', '101');

#2
CREATE TABLE manufacturers (
`manufacturer_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL,
`established_on` DATE);

CREATE TABLE models(
`model_id` INT PRIMARY KEY NOT NULL,
`name` VARCHAR(45) NOT NULL,
`manufacturer_id` INT,
CONSTRAINT fk_models_manufacturers
FOREIGN KEY (manufacturer_id)
REFERENCES manufacturers(`manufacturer_id`)
on DELETE CASCADE);

INSERT INTO `manufacturers` (`name`, `established_on`) 
VALUES ('BMW', '1916-03-01'),
('Tesla', '2003-01-01'),
('Lada', '1966-05-01');

INSERT INTO `models` (`model_id`, `name`, `manufacturer_id`) VALUES ('101', 'X1', '1'),
('102', 'i6', '1'),
('103', 'Model S', '2'),
('104', 'Model X', '2'),
('105', 'Model 3', '2'),
('106', 'Nova', '3');




#3

CREATE table students(
`student_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL);

CREATE TABLE exams(
`exam_id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
`name` VARCHAR (45)NOT NULL)
AUTO_INCREMENT = 101;



INSERT INTO `students` (`name`) 
VALUES ('Mila'),
('Toni'),
('Ron');

INSERT INTO `exams` ( `name`) 
VALUES ('Spring MVC'),
('Neo4j'),
('Oracle 11g');

CREATE TABLE students_exams (
    `student_id` INT,
    `exam_id` INT,
    CONSTRAINT pk_students_exams PRIMARY KEY (student_id , exam_id),
    CONSTRAINT fk_students_exams_students FOREIGN KEY (student_id)
        REFERENCES students (`student_id`),
    CONSTRAINT fk_students_exams_exams FOREIGN KEY (exam_id)
        REFERENCES exams (`exam_id`)
);
INSERT INTO `students_exams` (`student_id`, `exam_id`) VALUES ('1', '101'),
('1', '102'),
('2', '101'),
 ('3', '103'),
('2', '102'),
('2', '103');

#4
CREATE TABLE teachers(
teacher_id INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL,
`manager_id` INT )
AUTO_INCREMENT = 101;
INSERT into `teachers` (`name`, `manager_id`)
VALUES
('John',NULL),
('Maya', 106),
('Silvia', 106),
('Ted', 105),
('Mark', 101),
('Greta', 101);



ALTER TABLE teachers AUTO_INCREMENT = 100,
add CONSTRAINT fk_teacher_teacher
FOREIGN KEY(manager_id)
REFERENCES teachers(teacher_id)
ON UPDATE CASCADE
ON DELETE CASCADE;

#5
CREATE TABLE cities(
city_id INT(11) PRIMARY KEY,
`name` VARCHAR(50));

CREATE TABLE customers(
`customer_id` INT(11) PRIMARY KEY,
`name` VARCHAR(50),
birthday DATE,
city_id INT,
CONSTRAINT fk_customers_cities
FOREIGN KEY (city_id)
REFERENCES cities(`city_id`));

CREATE TABLE orders(
`order_id` INT(11) PRIMARY KEY,
`customer_id` INT(11),
CONSTRAINT fk_orders_customers
FOREIGN KEY (`customer_id`)
REFERENCES customers(`customer_id`)
ON DELETE CASCADE
ON UPDATE CASCADE);

CREATE TABLE item_types(
item_type_id INT(11) PRIMARY KEY,
`name` VARCHAR(50));

CREATE TABLE items(
item_id INT(11) PRIMARY KEY,
`name` VARCHAR(50),
item_type_id INT,
CONSTRAINT fk_items_item_types
FOREIGN KEY (item_type_id)
REFERENCES item_types(item_type_id)
ON UPDATE CASCADE
ON DELETE CASCADE);

CREATE TABLE order_items(
order_id INT(11),
item_id INT(11),
CONSTRAINT pk_order_items
PRIMARY KEY (order_id, item_id),
CONSTRAINT fk_order_items_orders
FOREIGN KEY(order_id)
REFERENCES orders(order_id)
ON UPDATE CASCADE
ON DELETE CASCADE,
CONSTRAINT fk_orders_items_items
FOREIGN KEY(item_id)
REFERENCES items(item_id)
ON UPDATE CASCADE
ON DELETE CASCADE);

# 6

CREATE TABLE subjects(
subject_id INT PRIMARY KEY,
subject_name VARCHAR(50));

CREATE TABLE majors(
major_id INT PRIMARY key,
`name` VARCHAR(50));

CREATE TABLE students(
student_id INT PRIMARY KEY,
student_number VARCHAR(12) UNIQUE,
student_name VARCHAR(50),
major_id INT,
CONSTRAINT fk_students_majors
FOREIGN KEY (major_id)
REFERENCES majors(major_id)
ON UPDATE CASCADE
ON DELETE CASCADE);

CREATE TABLE agenda(
student_id INT,
subject_id INT,
CONSTRAINT pk_agenda
PRIMARY KEY (student_id, subject_id),
CONSTRAINT fk_agenda_students
FOREIGN KEY (student_id)
REFERENCES students(student_id)
ON UPDATE CASCADE
ON DELETE CASCADE,
CONSTRAINT fk_agenda_subjects
FOREIGN KEY (subject_id)
REFERENCES subjects(subject_id)
ON UPDATE CASCADE
ON DELETE CASCADE);

CREATE TABLE payments(
payment_id INT PRIMARY KEY,
payment_date DATE,
payment_amount DECIMAL(8,2),
student_id INT,
CONSTRAINT fk_payments_students
FOREIGN KEY(student_id)
REFERENCES students(student_id)
ON UPDATE CASCADE
ON DELETE CASCADE);

#9

SELECT m.mountain_range, p.peak_name, p.elevation FROM mountains AS m
JOIN `peaks` AS p
ON m.id = p.mountain_id
WHERE mountain_range = 'Rila'
ORDER BY p.elevation DESC;
