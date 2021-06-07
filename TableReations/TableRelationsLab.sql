#1
CREATE SCHEMA `mountains_andPeaks`;
USE mountains_andPeaks;

CREATE TABLE `mountains` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `peaks` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `mountain_id` INT NOT NULL,
    CONSTRAINT fk_peaks_mountains FOREIGN KEY (mountain_id)
        REFERENCES mountains (`id`)
);
SELECT 
    peaks.`name` AS `peak names`,
    mountains.`name` AS `mountain names`
FROM
    peaks
        JOIN
    mountains ON mountain_id = mountains.id
    where peaks.`name` = 'Vihren';

#2
SELECT driver_id, vehicle_type,
  CONCAT(first_name, ' ', last_name) AS driver_name
  FROM vehicles AS v
  JOIN campers AS c 
  ON v.driver_id = c.id;

#3

SELECT 
starting_point as `route_starting_point`,
end_point AS `route_ending_point`,
leader_id,
concat_ws(' ', first_name, last_name) as `leader_name`
FROM routes as r
JOIN campers as c
ON r.leader_id = c.id;
#4
CREATE TABLE `mountains` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `peaks` (
    `id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    `mountain_id` INT NOT NULL,
    CONSTRAINT fk_peaks_mountains FOREIGN KEY (mountain_id)
        REFERENCES mountains (`id`) ON DELETE CASCADE
        
);
DELETE FROM mountains
WHERE `name` = 'Rila';