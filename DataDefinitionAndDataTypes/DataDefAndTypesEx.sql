CREATE DATABASE `minions`;
USE `minions`;
CREATE TABLE `minions`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR (45) NOT NULL,
`age` INT 
);

  CREATE TABLE `towns`(
`town_id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR (20) NOT NULL
);

INSERT INTO `minions`
VALUES 
(1, 'Ivan', '20'),
(2name, 'Ivan', null);

SELECT * FROM minions;

ALTER TABLE `towns` 
CHANGE COLUMN `town_id` `id` INT NOT NULL AUTO_INCREMENT ;

ALTER TABLE `minions`
ADD COLUMN `town_id` INT,
ADD CONSTRAINT fk_minions_towns
FOREIGN KEY (`town_id`)
REFERENCES `towns`(`id`);

INSERT INTO `towns` (`id`, `name`)
VALUES
(1,'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna');

TRUNCATE TABLE `minions`;

INSERT INTO `minions` (`id`, `name`, `age`, `town_id`)
VALUES
(1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2);

TRUNCATE TABLE `minions`;

DROP TABLE `minions`;
DROP TABLE `towns`;
DROP TABLE IF EXISTS `people`;
CREATE TABLE `people`(
`id` INT PRIMARY KEY AUTO_INCREMENT,
`name` VARCHAR (200) NOT NULL,
`picture` BLOB,
`height` FLOAT(5,2),
`weight` FLOAT(5,2),
`gender` CHAR(1) NOT NULL,
`birthday` DATE NOT NULL,
`biography` TEXT
);


INSERT INTO `people` (`id`, `name`, `height`, `weight`, `gender`, `birthday`, `biography`) VALUES ('1', 'T1', '2.3', '3.2', 'm', '1888-12-31', 'mamam');
INSERT INTO `people` (`name`, `height`, `weight`, `gender`, `birthday`, `biography`) VALUES ('T2', '3.3', '4.22', 'f', '1982-11-21', 'oasdlyg');
INSERT INTO `people` (`name`, `height`, `weight`, `gender`, `birthday`, `biography`) VALUES ('T3', '7.4', '8.3', 'm', '1492-02-21', 'oeiwhfl');
INSERT INTO `people` (`name`, `height`, `weight`, `gender`, `birthday`, `biography`) VALUES ('T4', '8.3', '7.2', 'm', '1332-03-30', 'jsjsuhd');
INSERT INTO `people` (`name`, `height`, `weight`, `gender`, `birthday`, `biography`) VALUES ('T5', '5.0', '9.3', 'f', '2000-09-09', 'hdouw');

CREATE TABLE `users` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(30) NOT NULL,
  `password` VARCHAR(26) NOT NULL,
  `profile_picture` BLOB(900000) NULL,
  `last_login_time` DATETIME(2) NULL,
  `is_deleted` TINYINT NULL DEFAULT 0,
  PRIMARY KEY (`id`));


INSERT INTO  `users` (`username`, `password`, `last_login_time`, `is_deleted`)
VALUES
('a', 'AAA',  '1982-03-21 22:33:33', 1),
('b', 'bAA',  '1982-03-22 22:33:33', 0),
('v', 'bAA',  '1982-03-21 22:33:33', 1),
('c', 'AAc',  '1982-03-21 22:33:33', 0),
('d', 'AAb',  '1982-03-21 22:33:33', 1);

ALTER TABLE `users` 
DROP COLUMN `id`,
CHANGE COLUMN `username` `pk_users` VARCHAR(30) NOT NULL ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`pk_users`);

ALTER TABLE `users`
MODIFY COLUMN last_login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE `users` 
ADD UNIQUE INDEX `pk_users_UNIQUE` (`pk_users` ASC) VISIBLE;




CREATE DATABASE `movies`;
USE `Movies`;

CREATE TABLE `directors`(
`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
`director_name` VARCHAR(45) NOT NULL,
`notes` TEXT
);

CREATE TABLE `genres`(
`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
`genre_name` VARCHAR(45) NOT NULL,
`notes` TEXT
);

CREATE TABLE `categories`(
`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
`categorie_name` VARCHAR(45) NOT NULL,
`notes` TEXT
);

CREATE TABLE `movies`(
`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
`title` VARCHAR(200) NOT NULL,
`director_id` INT NOT NULL,
`copyright_year` YEAR NOT NULL,
`length` TIME NOT NULL,
`genre_id` INT NOT NULL,
`category_id` INT NOT NULL,
`rating` FLOAT NOT NULL,
`notes` TEXT
);

ALTER TABLE `movies`
ADD CONSTRAINT fk_director_id
FOREIGN KEY (`director_id`)
REFERENCES `directors`(`id`);

ALTER TABLE `movies`
ADD CONSTRAINT fk_genre_id
FOREIGN KEY (`genre_id`)
REFERENCES `genres`(`id`);

ALTER TABLE `movies`
ADD CONSTRAINT fk_category_id
FOREIGN KEY (`category_id`)
REFERENCES `categories`(`id`);



INSERT INTO `directors`(`director_name`)
VALUES
('A'),
('B'),
('C'),
('D'),
('E');

INSERT INTO `genres`(`genre_name`)
VALUES
('Aa'),
('Bb'),
('Cc'),
('Dd'),
('Ee');

INSERT INTO `categories`(`categorie_name`)
VALUES
('Aaa'),
('Bbb'),
('Ccc'),
('Ddd'),
('Eee');

INSERT INTO `movies`(`title`,`director_id`, `copyright_year`, `length`, `genre_id`, `category_id`, `rating`, `notes`)
VALUES
('T1', '1', '2001', '22:13:23', '1', '1', '5', 'MSL'),
('T2', '2', '2001', '22:13:23', '2', '2', '6', 'MSL'),
('T3', '3', '2001', '22:13:23', '3', '3', '5', 'MSL'),
('T4', '4', '2001', '22:13:23', '4', '4', '5', 'MSL'),
('T5', '5', '2001', '22:13:23', '5', '5', '5', 'MSL');


CREATE DATABASE `soft_uni`;
Use `soft_uni`;

CREATE TABLE `towns`(
`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL
);

CREATE TABLE `addresses`(
`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
`address_text` VARCHAR(45),
`town_id`INT,
CONSTRAINT fk_addresses_towns
FOREIGN KEY (`town_id`)
REFERENCES `towns` (`id`)
);

CREATE TABLE `departments`(
`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
`name` VARCHAR(45) NOT NULL
);


CREATE TABLE `employees`(
`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
`first_name` VARCHAR(45) NOT NULL,
`middle_name` VARCHAR(45) NOT NULL,
`last_name` VARCHAR(45) NOT NULL,
`job_title` VARCHAR(45) NOT NULL,
`department_id` INT NOT NULL ,
`hire_date` DATE NOT NULL,
`salary` DECIMAL(19,2) NOT NULL,
`address_id` INT,
CONSTRAINT fk_employees_departments
foreign key (`department_id`)
references `departments`(`id`),
CONSTRAINT fk_employees_addresses
foreign key (`address_id`)
references `addresses`(`id`)
);

INSERT INTO  `towns`
values 
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna'),
(4, 'Burgas');

INSERT INTO  `departments`
values 
(1, 'Engineering'),
(2, 'Sales'),
(3, 'Marketing'),
(4, 'Software Development'),
(5, 'Quality Assurance');

INSERT INTO `employees`(`id`, `first_name`, `middle_name`, `last_name`, `job_title`
, `department_id`, `hire_date`, `salary`)
values
(1, 'Ivan','Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01',3500.00),
(2, 'Petar','Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02',4000.00),
(3, 'Maria ','Petrova', 'Ivanova', 'Intern', 5, '2016-08-28',525.25),
(4, 'Georgi','Terziev', 'Ivanov', 'CEO', 2, '2007-12-09',3000.00),
(5, 'Peter','Pan', 'Pan', 'Intern', 3, '2016-08-28',599.88);

SELECT * FROM `towns`;
SELECT * FROM `departments`;
SELECT * FROM `employees`;

SELECT * FROM `towns`
order by `name`;
SELECT * FROM `departments`
order by `name`;
SELECT * FROM `employees`
order by `salary` desc;


SELECT `name` FROM `towns`;
SELECT `name` FROM `departments`;
SELECT `first_name`, `last_name`, `job_title`, `salary` FROM`employees`;


UPDATE `employees`
SET
`salary` = `salary` * 1.1;


TRUNCATE TABLE `occupancies`;