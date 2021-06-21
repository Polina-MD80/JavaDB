#2

INSERT INTO clients (full_name, phone_number)
SELECT concat_ws(' ', d.first_name, d.last_name), concat('(088) 9999', 2*d.id) FROM drivers as d
WHERE d.id BETWEEN 10 and 20;

#3
UPDATE cars 
SET `condition` = 'C'
WHERE mileage >= 800000 OR mileage is NULL  AND year <= 2010 AND make != 'Mercedes-Benz';
#4

#5
SELECT make, model, `condition` FROM cars
ORDER BY id;

#6 6.	Drivers and Cars

SELECT d.first_name, d. last_name, c.make, c.model, c.mileage FROM drivers as d
LEFT JOIN cars_drivers as cd ON d.id = cd.driver_id
LEFT JOIN cars AS c on cd.car_id = c.id
WHERE c.mileage is NOT NULL
ORDER BY c.mileage DESC, d.first_name;

#7.	Number of courses for each car

SELECT c.id as car_id, c.make, c.mileage, count(co.id) as count_of_courses, ROUND(avg(co.bill),2) as avg_bill FROM cars as c
LEFT JOIN courses as co ON c.id = co.car_id
GROUP BY c.id
HAVING count_of_courses != 2
ORDER BY count_of_courses DESC, c.id;

#8.	Regular clients

SELECT  cl.full_name, count(DISTINCT c.id) as count_of_cars, SUM(co.bill) as tottal_sum FROM clients as cl
JOIN courses as co ON cl.id = co.client_id
JOIN cars as c ON co.car_id = c.id
WHERE cl.full_name LIKE '_a%'
GROUP BY cl.id
HAVING count_of_cars > 1;

#10
DELIMITER $$
CREATE FUNCTION udf_courses_by_client (phone_num VARCHAR (20)) 
RETURNS INT 
DETERMINISTIC
BEGIN
	DECLARE e_count INT;
	SET e_count := (SELECT COUNT(co.id) FROM courses as co
    JOIN clients as cl ON co.client_id = cl.id
    WHERE cl.phone_number = phone_num
    GROUP BY client_id);
RETURN e_count;
END $$


