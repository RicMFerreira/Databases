-- having vs where

select gender, avg(age)
from employee_demographics
where avg(age)>40
group by gender -- output will give a error, the aggregate function only happens after the group by
;
select gender, avg(age)
from employee_demographics
group by gender 
having avg(age)>40
;
select occupation, avg(salary)
from employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary)>75000 -- the aggregate funtion only calculate after the group by is done
;