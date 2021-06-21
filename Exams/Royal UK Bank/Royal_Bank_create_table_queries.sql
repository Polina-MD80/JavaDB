#02.	Insert
INSERT INTO cards (Card_number, card_status, bank_account_id)
SELECT reverse(full_name), 'Active', id FROM clients
WHERE id BETWEEN 191 AND 200; 



#04.	Delete
DELETE FROM employees
where id not in (SELECT employee_id FROM employees_clients); 

#05.	Clients
SELECT id, full_name from clients
ORDER BY id;

#06.	Newbies

SELECT id, concat_ws(' ', first_name, last_name) as full_name, concat('$', salary) as salary_, started_on from employees
WHERE started_on >= '2018-01-01' and salary>= 100000 
ORDER BY salary DESC, id;

#07.	Cards against Humanity
select c.id, concat(c.card_number, ' : ', cl.full_name) as card_token FROM cards as c
JOIN bank_accounts as ba ON c.bank_account_id = ba.id
JOIN clients as cl ON cl.id = ba.client_id
ORDER BY c.id DESC;

#08.	Top 5 Employees
SELECT concat_ws(' ', e.first_name, e.last_name) as `name`, e.started_on, count(ec.client_id) as count_of_clients FROM employees AS e
JOIN `employees_clients` AS ec ON e.id = ec.employee_id
GROUP BY ec.employee_id
ORDER BY count_of_clients DESC, e.id
LIMIT 5;

#09.	Branch cards

SELECT b.name, count(c.id) as card_count FROM branches as b
LEFT JOIN employees as e on e.branch_id = b.id
LEFT JOIN employees_clients as ec ON e.id = ec.employee_id
LEFT JOIN clients as cl ON ec.client_id = cl.id
LEFT JOIN bank_accounts as bc on bc.client_id = cl.id
LEFT JOIN cards as c ON bc.id = c.bank_account_id
GROUP BY b.id
ORDER BY card_count DESC, b.name;

#10. Extract card's count

DELIMITER $$
CREATE FUNCTION udf_client_cards_count(name VARCHAR(30)) 
RETURNS INT 
DETERMINISTIC
BEGIN
	DECLARE e_count INT;
	SET e_count := (SELECT count(c.id) FROM clients as cl
	LEFT JOIN bank_accounts as bc on bc.client_id = cl.id
	LEFT JOIN cards as c ON bc.id = c.bank_account_id
    WHERE cl.full_name = name
    GROUP BY cl.id);
    
	RETURN e_count;
END $$
SELECT c.full_name, udf_client_cards_count('Baxy David') as `cards` FROM clients c
WHERE c.full_name = 'Baxy David';

#11.	Extract Client Info
DELIMITER $$
CREATE PROCEDURE udp_clientinfo (client_name VARCHAR(50))
BEGIN
  SELECT cl.full_name, cl.age, ba.account_number, concat('$',ba.balance) as balance FROM clients as cl
  LEFT JOIN bank_accounts as ba on ba.client_id = cl.id
  WHERE cl.full_name = client_name
  GROUP BY cl.id;
  
END $$

#3 update

DELIMITER $$
CREATE FUNCTION ufn_()
RETURNS INT 
DETERMINISTIC
BEGIN
	DECLARE e_count INT;
	SET e_count := (SELECT DISTINCT
    c.employee_id
FROM
    employees_clients as c
WHERE
    c.employee_id = (SELECT 
            COUNT(c1.client_id) AS count_
        FROM
            employees_clients as c1
        GROUP BY c1.employee_id
        ORDER BY count_ , c1.employee_id
        LIMIT 1));
	RETURN e_count;
END $$

UPDATE employees_clients
SET employee_id =  (select ufn_())
 WHERE employee_id = client_id;

$$
UPDATE employees_clients as ec
JOIN 
(SELECT ec1.employee_id, count(ec1.client_id) as count_ FROM employees_clients as ec1
GROUP BY ec1.employee_id
ORDER BY count_, ec1.employee_id) as s
SET ec.employee_id = s.employee_id
WHERE ec.employee_id = ec.client_id;