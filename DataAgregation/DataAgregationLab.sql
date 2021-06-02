select department_id, sum(salary) as `total_salary`
from employees
GROUP BY department_id;

#1
 select department_id, COUNT(*) as `Number of employees`
 from employees
 GROUP BY department_id
 order by department_id, `Number of employees`;
 
 #2
 select department_id, round(AVG(salary),2) as `Average Salary`
 from employees
 GROUP BY department_id
 order by department_id;
 
 #3
 select department_id, round((salary),2) as `Min Salary`
 from employees
 GROUP BY department_id
 having `Min salary` >=800 ;
 
 #4
 select count(*) from products
 where category_id = 2 and 
 price > 8;
 
 #5
SELECT 
    category_id,
    ROUND(AVG(price), 2) AS 'Average Price',
    MIN(price) AS 'Cheapest Product',
    MAX(price) AS 'Most Expensive Product'
FROM
    products
GROUP BY category_id
ORDER BY category_id;
 