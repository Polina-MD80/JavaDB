#1
 DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000() 
BEGIN
  SELECT first_name, last_name 
  FROM employees
  WHERE salary > 35000
  ORDER BY first_name, last_name, employee_id;
END $$


CALL usp_get_employees_salary_above_35000();

#2
 DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(min_salary DECIMAL(10,4))
BEGIN
	SELECT first_name, last_name 
  FROM employees
  WHERE salary >= min_salary
  ORDER BY first_name, last_name, employee_id;
END  $$

CALL usp_get_employees_salary_above(45000);

#3
delimiter &&
CREATE PROCEDURE usp_get_towns_starting_with (string_begin varchar(50))
BEGIN
	SELECT `name` from towns
    WHERE substring(`name`, 1, char_length(string_begin)) = string_begin
    ORDER BY `name`;
END &&
CALL usp_get_towns_starting_with ('b');

#4

 DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(town_name VARCHAR(50)) 
BEGIN
  SELECT 
    e.first_name, e.last_name
FROM
    employees e
        JOIN
    addresses AS a USING (address_id)
        JOIN
    towns AS t USING (town_id)
WHERE
    t.name = town_name
ORDER BY first_name , last_name , employee_id;
END $$

CALL usp_get_employees_from_town('Sofia');

#5
CREATE FUNCTION ufn_get_salary_level(employee_salary DECIMAL(10,2)) 
RETURNS VARCHAR(50) 
DETERMINISTIC
BEGIN
	DECLARE salary_level VARCHAR(50);
	SET salary_level := case
    when employee_salary < 30000 THEN 'Low'
    when employee_salary BETWEEN 30000 AND 50000 THEN 'Average'
    else 'High'
    END;
    RETURN salary_level;
    
    END;
    
#6
CREATE FUNCTION ufn_get_salary_level(employee_salary DECIMAL(10,2)) 
RETURNS VARCHAR(50) 
DETERMINISTIC
BEGIN
	DECLARE salary_level VARCHAR(50);
	SET salary_level := case
    when employee_salary < 30000 THEN 'Low'
    when employee_salary BETWEEN 30000 AND 50000 THEN 'Average'
    else 'High'
    END;
    RETURN salary_level;
    
    END;
    
    



CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level VARCHAR(50))
BEGIN 
SELECT e.first_name, e.last_name FROM employees as e
WHERE ufn_get_salary_level(e.salary) = salary_level
ORDER BY first_name DESC, last_name DESC;
END;


 CALL usp_get_employees_by_salary_level('high');
 
 #7
	
    
    #8
    
    CREATE PROCEDURE usp_get_holders_full_name () 
BEGIN
  SELECT concat_ws(' ', first_name, last_name) as full_name
  FROM account_holders
  ORDER BY full_name, id;
  
END;

CALL usp_get_holders_full_name ();

#9
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(number_parameter DECIMAL(10,2))
BEGIN
SELECT ah.first_name, ah.last_name  FROM account_holders as ah
JOIN accounts as a
ON a.account_holder_id = ah.id
 WHERE (SELECT SUM(balance) FROM accounts as a1
 WHERE a1.account_holder_id = a.account_holder_id
 GROUP BY account_holder_id
 ) > number_parameter
 GROUP BY ah.id
ORDER BY ah.id;
 END;
 
 CALL usp_get_holders_with_balance_higher_than(7000);
 
 #10
 CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(10,4), yearly_interest_rate DECIMAL(10,4), number_of_years INT)
RETURNS DECIMAL(10,4)
DETERMINISTIC
BEGIN
    DECLARE result DECIMAL(10,4);
    SET result := sum * (pow((yearly_interest_rate  + 1),  number_of_years));
	RETURN result;
END;

#11
CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(10,4), yearly_interest_rate DECIMAL(10,4), number_of_years INT)
RETURNS DECIMAL(10,4)
DETERMINISTIC
BEGIN
    DECLARE result DECIMAL(10,4);
    SET result := sum * (pow((yearly_interest_rate  + 1),  number_of_years));
	RETURN result;
END;


CREATE PROCEDURE usp_calculate_future_value_for_account(account_id INT, interest DECIMAL(10,4))
BEGIN
   SELECT a.id, ah.first_name, ah.last_name, a.balance,
     (ufn_calculate_future_value(a.balance,interest,5))as balance_in_5_years 
 FROM accounts as a
 JOIN account_holders as ah ON a.account_holder_id = ah.id
 where a.id = account_id;
 END;
 
CALL usp_calculate_future_value_for_account(1, 0.1);

#12
CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(10,4))
BEGIN 
   UPDATE  accounts as a
   JOIN `account_holders` as ah ON a.`account_holder_id` = ah.id
   SET a.balance = if(money_amount>0, ROUND(a.balance + money_amount,4), a.balance)
   WHERE a.id = account_id;
   END;
   
   #13
   CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(20,4))
BEGIN 
   UPDATE  accounts as a
   JOIN `account_holders` as ah ON a.`account_holder_id` = ah.id
   SET a.balance = if((money_amount>0 and a.balance >= money_amount), ROUND(a.balance - money_amount,4), a.balance)
   WHERE a.id = account_id;
   END;
   
   #14
   CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, amount DECIMAL(20,4))
BEGIN
	START TRANSACTION;
	IF(((SELECT a.id FROM accounts as a WHERE a.id like from_account_id)<>1)
    or ((SELECT a.id FROM accounts as a WHERE a.id like to_account_id)<>1)
    or (SELECT a.balance from accounts as a WHERE a.id = from_account_id) 
    or (amount <0) ) THEN
	ROLLBACK;
	ELSE
		call usp_deposit_money(to_account_id, amount);
        call usp_withdraw_money(from_account_id, amount);
		END IF; 
END;

#15
CREATE table `logs`(
log_id INT PRIMARY KEY AUTO_INCREMENT, 
account_id INT, 
old_sum  DECIMAL(20,4), 
new_sum DECIMAL(20,4));

CREATE TRIGGER account_logs
AFTER UPDATE
ON accounts 
FOR EACH ROW
BEGIN
	INSERT INTO `logs` (account_id, old_sum, new_sum)
	VALUES(NEW.id, OLD.balance, NEW.balance);
END;

#16

CREATE table `logs`(
log_id INT PRIMARY KEY AUTO_INCREMENT, 
account_id INT, 
old_sum  DECIMAL(20,4), 
new_sum DECIMAL(20,4));
CREATE TRIGGER account_logs
AFTER UPDATE
ON accounts 
FOR EACH ROW
BEGIN
	INSERT INTO `logs` (account_id, old_sum, new_sum)
	VALUES(NEW.id, OLD.balance, NEW.balance);
END;
CREATE TABLE notification_emails (
    id INT PRIMARY KEY AUTO_INCREMENT,
    recipient INT,
    subject VARCHAR(200),
    body VARCHAR(200)
);


CREATE TRIGGER new_email_for_each_log
AFTER UPDATE 
ON `logs`
FOR EACH ROW
BEGIN
    INSERT INTO notification_emails(recipient, subject, body)
    VALUES(NEW.account_id, concat('Balance change for account: ','', NEW.account_id), 
    concat_ws(' ','On',NOW(), 'your balance was changed from', NEW.old_sum, NEW.new_sum));
END;