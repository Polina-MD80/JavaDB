#2

INSERT into likes (article_id, comment_id, user_id)
SELECT
if ( u.id % 2 = 0, char_length(u.username), null),
if (u.id%2 =1, char_length(u.email),null),
u.id from users as u
WHERE u.id BETWEEN 16 AND 20;

#3

UPDATE comments 
SET 
    comment = (CASE
        WHEN id % 2 = 0 THEN 'Very good article.'
        WHEN id % 3 = 0 THEN 'This is interesting.'
        WHEN id % 5 = 0 THEN 'I definitely will read the article again.'
        WHEN id % 7 = 0 THEN 'The universe is such an amazing thing.'
    END)
WHERE
    id BETWEEN 1 AND 15;


# 4
DELETE FROM articles 
WHERE category_id IS NULL;


#5
SELECT a1.title, a1.summary FROM
(SELECT a.id, a.title, concat(left(20, content), '...') as summary from articles as a
ORDER BY char_length(content) DESC
LIMIT 3) as a1
ORDER BY a1.id;

#6

SELECT a.id, a.title From articles as a
JOIN users_articles as ua on a.id = ua.article_id
where ua.article_id = ua.user_id
ORDER BY a.id;

#7
SELECT c.category, count(DISTINCT a.id) as articles_, count(l.id) as likes_ FROM categories as c
LEFT JOIN articles as a ON a.id = a.category_id
LEFT JOIN likes as l ON a.id = l.article_id
GROUP BY c.id
ORDER BY likes_ DESC, articles_ DESC, c.id;


# 8
SELECT a.title, count(com.id) as comments from articles as a
JOIN categories as c ON c.id = a.category_id
JOIN comments as com ON a.id = com.article_id
WHERE category = 'Social'
GROUP BY a.id
ORDER BY comments DESC
LIMIT 1;

#9
SELECT concat(Left(20, com.comment), '...') as summary FROM comments as com
LEFT JOIN likes as l ON com.id = l.comment_id
WHERE l.comment_id is NULL
GROUP BY com.id
ORDER BY com.id DESC;

# 10
DELIMITER $$
CREATE FUNCTION udf_users_articles_count(username VARCHAR(30))
RETURNS INT 
DETERMINISTIC
BEGIN
	DECLARE e_count INT;
	SET e_count := (SELECT COUNT(ua.article_id) FROM users_articles AS ua
	 JOIN users AS u ON ua.user_id = user_id
	 WHERE u.username = username
     GROUP BY u.id);
	RETURN e_count;
END $$
