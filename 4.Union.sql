-- union - combine rows from separate tables

select age,gender
from employee_demographics
union
select first_name, last_name
from employee_salary -- it will do bad data, it will mix age and gender with first_name and last_name
;

select first_name, last_name
from employee_demographics
union -- by default the union is distinct so removes rows duplicates
select first_name, last_name
from employee_salary 
;

select first_name, last_name
from employee_demographics
union all -- it will add all the rows from both tables
select first_name, last_name
from employee_salary 
;

select first_name, last_name, 'old man' as label -- creates a column called label and gives a value 'old'
from employee_demographics
where age > 40 and gender='male'
union
select first_name, last_name, 'old lady' as label -- creates a column called label and gives a value 'old'
from employee_demographics
where age > 40 and gender = 'female'
union
select first_name, last_name, 'Highly Paid Employee'  as label
from employee_salary
where salary > 70000
;

select first_name, last_name, 'old man' as label -- creates a column called label and gives a value 'old'
from employee_demographics
where age > 40 and gender='male'
union
select first_name, last_name, 'old lady' as label -- creates a column called label and gives a value 'old'
from employee_demographics
where age > 40 and gender = 'female'
union
select first_name, last_name, 'Highly Paid Employee'  as label
from employee_salary
where salary > 70000
order by first_name, last_name
;
