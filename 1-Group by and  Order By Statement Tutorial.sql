-- Group By

select gender,AVG(age)
from employee_demographics
group by gender;

select occupation, salary
from employee_salary
group by occupation, salary;

select gender,AVG(age),MAX(age), MIN(age), count(age)
from employee_demographics
group by gender;

-- Order by
select *
from employee_demographics
order by gender asc,age desc
;

select *
from employee_demographics
order by 5, 4 -- index of columns starts with 1 not recommended
;