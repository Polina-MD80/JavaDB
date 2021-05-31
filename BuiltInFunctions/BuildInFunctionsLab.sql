#lab 1

SELECT * FROM books
WHERE substring(title, 1,3 ) = 'The';
#off

SELECT substring(lower('Ival'), 1,3);

SELECT `article_id`, `author`, `content`,
       SUBSTRING(`content`, 1, 200) AS 'Summary'
  FROM `articles`;
SELECT length(title) as title_length, title FROM books;

SELECT char_length('Ivan');
SELECT length('Ivan');
SELECT char_length('Иван');
SELECT length('Иван');

SELECT round(rand()*100,0);

SELECT conv(165, 10,2);

#lab 2
SELECT 
replace(title, 'The', '***') FROM books
WHERE substring(title, 1,3 ) = 'The';

#lab 3
SELECT round(sum(`cost`), 2) as sum FROM books;





