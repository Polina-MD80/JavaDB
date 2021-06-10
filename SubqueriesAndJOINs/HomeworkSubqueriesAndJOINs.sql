
#1
SELECT e.employee_id, e.job_title, e.address_id, a.address_text FROM employees AS e
LEFT JOIN addresses AS a
USING(address_id)
ORDER BY address_id
LIMIT 5;

#2
SELECT 
    e.first_name, e.last_name, t.name AS town, a.address_text
FROM
    employees AS e
        LEFT JOIN
    addresses AS a USING (address_id)
        JOIN
    towns AS t ON a.town_id = t.town_id
ORDER BY e.first_name , e.last_name
LIMIT 5;

#3

SELECT e.employee_id, e.first_name, e.last_name, d.name as department_name from employees as e
JOIN departments as d
ON e.department_id = d.department_id
WHERE d.name = 'Sales'
ORDER BY e.employee_id DESC;

#4


SELECT e.employee_id, e.first_name, e.salary, d.name as department_name 
FROM employees AS e
LEFT JOIN departments as d
USING (department_id)
WHERE e.salary > 15000
ORDER BY e.department_id DESC, e.employee_id
LIMIT 5;

#5

SELECT e.employee_id, e.first_name FROM employees as e
LEFT JOIN employees_projects as ep
on e.employee_id = ep.employee_id
WHERE ep.employee_id IS NULL
ORDER BY e.employee_id DESC
LIMIT 3;

#6
SELECT e.first_name, e.last_name, e.hire_date, d.name as department_name FROM employees as e
JOIN departments as d
ON e.department_id = d.department_id
WHERE e.hire_date>'1999-01-02' and (d.name = 'Finance' OR d.name ='Sales')
ORDER BY e.hire_date;

#7
SELECT e.employee_id, e.first_name, p.name as project_name FROM employees as e
RIGHT JOIN employees_projects as ep
USING(employee_id)
JOIN projects as p
USING(project_id)
WHERE p.start_date > '2002-08-14' AND p.end_date IS NULL
ORDER BY e.first_name, p.name
LIMIT 5;

#8
SELECT 
    e.employee_id,
    e.first_name,
    IF(YEAR(p.start_date) >= '2005',
        NULL,
        p.name) AS project_name
FROM
    employees AS e
        JOIN
    employees_projects AS ep USING (employee_id)
        JOIN
    projects AS p USING (project_id)
WHERE
    e.employee_id = 24
ORDER BY project_name;

#9
SELECT 
    e.employee_id,
    e.first_name,
    e.manager_id,
    (SELECT 
            em.first_name
        FROM
            employees AS em
        WHERE
            e.manager_id = em.employee_id) AS manager_name
FROM
    employees AS e
WHERE
    e.manager_id IN (3 , 7)
ORDER BY e.first_name
;

#10
SELECT 
    e.employee_id,
    CONCAT_WS(' ', e.first_name, e.last_name),
    (SELECT 
            concat_ws(' ',em.first_name, em.last_name)
        FROM
            employees AS em
        WHERE
            e.manager_id = em.employee_id) AS manager_name,
    d.name AS department_name
FROM
    employees AS e
    JOIN
    departments AS d USING(department_id)
    WHERE e.manager_id is NOT NULL
ORDER BY employee_id
LIMIT 5
;

#11
SELECT 
    MIN(min_avg_salary) as min_average_salary
FROM
    (SELECT 
        AVG(salary) AS min_avg_salary
    FROM
        employees
    GROUP BY department_id)
as min_salary; 

    
#12

SELECT 
    mc.country_code, m.mountain_range, p.peak_name, p.elevation
FROM
    mountains_countries AS mc
        JOIN
    mountains AS m ON mc.mountain_id = m.id
        JOIN
    peaks AS p ON m.id = p.mountain_id
WHERE
    mc.country_code = 'BG'
        AND p.elevation > 2835
ORDER BY p.elevation DESC;

#13

SELECT country_code, count(*) as mountain_range FROM mountains_countries
WHERE country_code in ('BG','RU', 'US')
GROUP BY country_code
ORDER BY mountain_range DESC;

#14
SELECT c.country_name, r.river_name FROM countries as c
LEFT JOIN countries_rivers as cr
USING(country_code)
LEFT JOIN rivers as r
ON cr.river_id = r.id
WHERE c.continent_code = 'AF'
ORDER BY c.country_name
LIMIT 5;

#15
SELECT 
    d1.continent_code, d1.currency_code, d1.currency_usage
FROM
    (SELECT 
        `c`.`continent_code`,
            `c`.`currency_code`,
            COUNT(`c`.`currency_code`) AS `currency_usage`
    FROM
        countries AS c
    GROUP BY c.currency_code , c.continent_code
    HAVING currency_usage > 1) AS d1
        LEFT JOIN
    (SELECT 
        `c`.`continent_code`,
            `c`.`currency_code`,
            COUNT(`c`.`currency_code`) AS `currency_usage`
    FROM
        countries AS c
    GROUP BY c.currency_code , c.continent_code
    HAVING currency_usage > 1) AS d2 ON d1.continent_code = d2.continent_code
        AND d2.currency_usage > d1.currency_usage
WHERE
    d2.currency_usage IS NULL
ORDER BY d1.continent_code , d1.currency_code;

#16

SELECT 
    COUNT(*) AS country_count
FROM
    (SELECT 
        c.country_code, mc.mountain_id
    FROM
        countries AS c
    LEFT JOIN mountains_countries AS mc USING (country_code)
    WHERE
        mc.mountain_id IS NULL) the_count;


#17
SELECT c.country_name,
 MAX(p.elevation) as highest_peak_elevation, 
 MAX(r.length) as longest_river_length FROM countries as c
LEFT JOIN mountains_countries as mc
USING(country_code)
LEFT JOIN peaks as p
USING(mountain_id)
LEFT JOIN countries_rivers as cr
USING(country_code)
LEFT JOIN rivers as r
ON cr.river_id = r.id
GROUP BY country_name
ORDER BY highest_peak_elevation DESC, longest_river_length DESC, country_name
LIMIT 5;