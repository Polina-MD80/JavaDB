#1
SELECT  COUNT(*) AS 'count' from wizzard_deposits;

#2
SELECT MAX(magic_wand_size) AS 'longest_magic_wand'FROM wizzard_deposits;

#3
SELECT deposit_group, MAX(magic_wand_size) AS `longest_magic_wand`FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY longest_magic_wand, deposit_group;
#4
SELECT deposit_group from wizzard_deposits
GROUP BY deposit_group
ORDER BY  avg(magic_wand_size)
LIMIT 1;

#
SELECT deposit_group from wizzard_deposits
GROUP BY deposit_group
HAVING min(magic_wand_size)
LIMIT 1;

 
#5
SELECT deposit_group, sum(deposit_amount) AS `total_sum`FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY total_sum;

#6
select deposit_group, sum(deposit_amount) as `total_sum` FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
ORDER BY deposit_group;

#7

select deposit_group, sum(deposit_amount) as `total_sum` FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
HAVING total_sum < 150000
ORDER BY total_sum DESC;


 #8
 
 select deposit_group, magic_wand_creator, min(deposit_charge) as `min_deposit_charge` 
 FROM wizzard_deposits
 GROUP BY deposit_group, magic_wand_creator
 ORDER BY magic_wand_creator, deposit_group;
 
 #9
SELECT 
    (CASE
        WHEN age BETWEEN 0 AND 10 THEN '[0-10]'
        WHEN age BETWEEN 11 AND 20 THEN '[11-20]'
        WHEN age BETWEEN 21 AND 30 THEN '[21-30]'
        WHEN age BETWEEN 31 AND 40 THEN '[31-40]'
        WHEN age BETWEEN 41 AND 50 THEN '[41-50]'
        WHEN age BETWEEN 51 AND 60 THEN '[51-60]'
        ELSE '[61+]'
    END) AS `age_group`,
    COUNT(*) AS `wizard_count`
FROM
    wizzard_deposits
GROUP BY age_group
ORDER BY age_group;

#10

SELECT DISTINCT left(first_name,1) AS `first_letter` FROM wizzard_deposits
WHERE deposit_group = 'Troll Chest'
GROUP BY first_letter
ORDER BY first_letter;

#11
SELECT 
    deposit_group,
    is_deposit_expired,
    AVG(deposit_interest) AS `average_interest`
FROM
    wizzard_deposits
WHERE
    deposit_start_date > '1985-01-01'
GROUP BY deposit_group , is_deposit_expired
ORDER BY deposit_group DESC , is_deposit_expired;


#12
select department_id, min(salary) as minimum_salary from employees
WHERE department_id in(2, 5, 7) and hire_date > '2000-01-01'
group by department_id
order by department_id;

#13
SELECT department_id, avg(if(department_id != 1, salary, salary + 5000)) as `avg_salary` from employees
WHERE manager_id != 42 and salary > 30000
GROUP BY department_id
ORDER BY department_id;



#14
select department_id, max(salary) as max_salary from employees
group by department_id
having max_salary not between 30000 and 70000
order by department_id;

#15
SELECT count(*) as ``from employees
where manager_id is NULL;

#16

SELECT 
    `department_id`,
    (SELECT DISTINCT
            `e2`.`salary`
        FROM
            `employees` AS `e2`
        WHERE
            `e2`.`department_id` = `e1`.`department_id`
        ORDER BY `e2`.`salary` DESC
        LIMIT 2 , 1) AS `third_highest_salary`
FROM
    `employees` AS `e1`
GROUP BY `department_id`
HAVING `third_highest_salary` IS NOT NULL
ORDER BY department_id;

#18

SELECT department_id, round(sum(salary),4) as `total_salary` FROM employees
GROUP BY department_id
ORDER BY department_id;

#17

SELECT 
    e1.first_name, e1.last_name, e1.department_id
FROM
    employees AS `e1`
WHERE
    e1.salary > (SELECT 
            AVG(e2.salary)
        FROM
            employees AS `e2`
        WHERE
            e1.department_id = e2.department_id
        )
ORDER BY e1.department_id , e1.employee_id
LIMIT 10;



