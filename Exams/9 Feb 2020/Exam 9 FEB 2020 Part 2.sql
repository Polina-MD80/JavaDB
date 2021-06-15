#2.	Insert
use fsd;
INSERT INTO coaches (first_name, last_name, salary, coach_level)
SELECT first_name, last_name, 2 * salary, char_length(first_name) FROM players
WHERE age >= 45;

#3.	Update

UPDATE coaches as c
SET c.coach_level = c.coach_level + 1
WHERE( SELECT count(coach_id) FROM players_coaches
WHERE c.id = coach_id)>0 AND c.first_name LIKE 'A%';

#4.	Delete
DELETE  FROM players
WHERE age >=45;

#5.	Players

SELECT first_name, age, salary FROM players
ORDER BY salary DESC;

# 6.	Young offense players without contract
SELECT id, concat_ws(' ', first_name, last_name) as full_name, age, position, hire_date FROM players
WHERE age<23 and position ='A' AND hire_date is NULL AND 
(SELECT s.strength FROM skills_data as s
WHERE s.id = skills_data_id) >50
ORDER BY salary, age;

# 7.	Detail info for all teams
SELECT t.name, t.established, t.fan_base,COUNT(p.id) as players_count FROM teams as t
LEFT JOIN players as p
on t.id = p. team_id
GROUP BY t.name
ORDER BY players_count DESC, t.fan_base DESC;

#8.	The fastest player by towns
SELECT MAX(sd.speed) as max_speed, t.name as town_name FROM towns as t
LEFT JOIN stadiums as st ON t.id = st.town_id
LEFT JOIN teams as te ON st.id = te.stadium_id
LEFT JOIN players as p ON  te.id = p.team_id
LEFT JOIN skills_data as sd ON sd.id = p.skills_data_id
WHERE te.name!='Devify'
GROUP BY t.name
ORDER BY max_speed DESC, t.name;

#9.	Total salaries and players by country

SELECT c.name, COUNT(p.id) as total_count_of_players, SUM(p.salary) as total_sum_of_salaries FROM countries as c
LEFT JOIN towns as t ON c.id = t.country_id
LEFT JOIN stadiums as st ON t.id = st.town_id
LEFT JOIN teams as te ON st.id = te.stadium_id
LEFT JOIN players as p ON  te.id = p.team_id
GROUP BY c.name
ORDER BY total_count_of_players DESC, c.name;

#10.	Find all players that play on stadium
DELIMITER $$
CREATE FUNCTION udf_stadium_players_count (stadium_name VARCHAR(30)) 
RETURNS INT 
DETERMINISTIC
BEGIN
	DECLARE e_count INT;
	SET e_count := (SELECT COUNT(p.id) FROM stadiums as st
	LEFT JOIN teams as te ON st.id = te.stadium_id
	LEFT JOIN players as p ON  te.id = p.team_id
	WHERE st.name = stadium_name
    GROUP BY st.name);
	RETURN e_count;
END $$

SELECT udf_stadium_players_count ('Jaxworks') as `count`; 

#11.	Find good playmaker by teams
DELIMITER $$
CREATE PROCEDURE udp_find_playmaker (min_dribble_points INT , team_name VARCHAR(45))
BEGIN
 SELECT concat_ws(' ', p.first_name, p.last_name) as full_name, p.age, p.salary, sd.dribbling, sd.speed, te.name FROM players as p
 LEFT JOIN skills_data as sd ON p.skills_data_id = sd.id
 LEFT JOIN teams as te ON p.team_id = te.id
 WHERE sd.dribbling > min_dribble_points AND te.name = team_name
 ORDER BY sd.speed DESC
 LIMIT 1;
 
END $$

CALL udp_find_playmaker (20, 'Skyble');

