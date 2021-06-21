
# 02.	Insert

INSERT INTO addresses (address, town, country, user_id)
SELECT username, password,ip, age FROM users
WHERE gender = 'M';


#03.	Update
UPDATE addresses 
SET country = (
CASE 
WHEN country LIKE 'B%' THEN 'Blocked'
WHEN country LIKE 'T%' THEN 'Test'
WHEN country LIKE 'P%' THEN 'In Progress'
END);


#04.	Delete
DELETE FROM addresses
WHERE id % 3 = 0;

#05.	User
SELECT username, gender, age FROM users
ORDER BY age DESC, username;

#06.	Extract 5 Most Commented Photos
SELECT 
    ph.id,
    ph.date AS date_and_time,
    ph.description,
    COUNT(c.id) AS commentsCount
FROM
    photos AS ph
        LEFT JOIN
    comments AS c ON c.photo_id = ph.id
    GROUP BY ph.id
ORDER BY commentsCount DESC , ph.id
LIMIT 5;


# 07.	Lucky Users
SELECT DISTINCT concat_ws(' ', u.id, u.username) as id_username, u.email FROM users as u
JOIN users_photos as up ON u.id = up.user_id
WHERE up.user_id = up.photo_id
ORDER BY u.id;

#08.	Count Likes and Comments
SELECT ph.id as photo_id, count(l.id) as likes_count, count(c.id) as comments_count FROM photos as ph
LEFT JOIN likes as l ON l.photo_id = ph.id
LEFT JOIN comments as c ON c.photo_id = ph.id
GROUP  BY ph.id
ORDER BY likes_count DESC, comments_count DESC, ph.id DESC;

# 09.	The Photo on the Tenth Day of the Month
SELECT concat(left(p.description,10), '...') as summary, p.date from photos as p
WHERE extract(day from p.date) = 10;

#10.	Get User’s Photos Count

DELIMITER $$
CREATE FUNCTION udf_users_photos_count(username VARCHAR(30)) 
RETURNS INT 
DETERMINISTIC
BEGIN
	DECLARE e_count INT;
	SET e_count := (SELECT COUNT(photo_id) FROM users_photos AS up
    RIGHT JOIN users as u on u.id = up.user_id
	WHERE u.username = username
    GROUP BY u.username);
	RETURN e_count;
END $$

SELECT udf_users_photos_count('ssantryd') AS photosCount;


# 11.	Increase User Age
DELIMITER $$
CREATE PROCEDURE udp_modify_user (address VARCHAR(30), town VARCHAR(30)) 
BEGIN
  UPDATE users
  JOIN addresses AS a ON users.id = a.user_id 
  SET age = age +10
  WHERE a.address = address AND a.town = town;
END $$
CALL udp_modify_user ('97 Valley Edge Parkway', 'Divinópolis');
SELECT u.username, u.email,u.gender,u.age,u.job_title FROM users AS u
WHERE u.username = 'eblagden21';
