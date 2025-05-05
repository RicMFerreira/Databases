-- limit and aliasing

select *
from employee_demographics
limit 3 -- it only shows 3 rows
;

select *
from employee_demographics
order by age desc
limit 3 -- it only shows 3 rows -- output the 2 oldest enployees
;

select *
from employee_demographics
order by age desc
limit 2,1 -- it will start from row 2 and outputs the next 1 row
;

-- aliasing - change a name of a column
select gender, avg(age)
from employee_demographics
group by gender
having avg(age)>40
;

select gender, avg(age) as avg_age -- rename the column name
from employee_demographics
group by gender
having avg_age>40
;

select gender, avg(age) avg_age -- it works also rename the column name
from employee_demographics
group by gender
having avg_age>40
;