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

#5
SELECT deposit_group, sum(deposit_amount) AS `total_sum`FROM wizzard_deposits
GROUP BY deposit_group
ORDER BY total_sum;

#6
select deposit_group, sum(deposit_amount) as `total_sum` FROM wizzard_deposits
WHERE magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
ORDER BY total_sum;

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
 SELECT (case
 WHEN age BETWEEN 0 and 10 then '[0-10]'
 when age between 11 and 20 then '[11-20]'
 when age between 21 and 30 then '[21-30]'
 when age between 31 and 40 then '[31-40]'
 when age between 41 and 50 then '[41-50]'
 when age between 51 and 60 then '[51-60]'
 else '[60+]'
end) as `age_group`, count(*) AS `wizard_count` from wizzard_deposits 
group by age_group
order by age_group;

#10

SELECT DISTINCT left(first_name,1) AS `first_letter` FROM wizzard_deposits
WHERE deposit_group = 'Troll Chest'
GROUP BY first_letter
ORDER BY first_letter;

#11
SELECT deposit_group, is_deposit_expired, AVG(deposit_interest) AS `average_interest` FROM wizzard_deposits
WHERE deposit_start_date > 1985-01-01
GROUP BY deposit_group, is_deposit_expired
ORDER BY deposit_group DESC, is_deposit_expired;

#12
select department_id, min(salary) as minimum_salary from employees
WHERE department_id in(2, 5, 7) and hire_date > 2000-01-01
group by department_id
order by department_id;

#13
SELECT department_id, avg(if(department_id != 1, salary, salary + 5000)) as `avg_salary` from employees
WHERE manager_id != 42 and salary > 3000
GROUP BY department_id
ORDER BY department_id;


#14
select department_id, max(salary) as max_salary from employees
WHERE salary not between 30000 and 70000
group by department_id
order by department_id;

#15
SELECT count(*) as ``from employees
where manager_id is NULL;

#18

SELECT department_id, round((salary),2) as `total_salary` FROM employees
GROUP BY department_id
ORDER BY department_id;


