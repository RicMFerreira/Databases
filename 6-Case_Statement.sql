-- Case Statement - add logic, if else

select first_name,
last_name,
age,
case
	when age <= 30 then 'Young'
    when age between 31 and 50  then 'Old'
    when age >= 50 then 'On deaths door'
end as age_bracket
from employee_demographics;

-- Pay increase and bonus
-- < 50000 = 5%
-- >50000 =7%
-- Finance = 10%

-- ME
select *
from employee_salary;

select *
from parks_departments;

select first_name, last_name,salary,
case
    when salary <50000 then salary*1.05
	when salary >50000 then salary*1.07
end as New_Salary,
case
	when dept_id = 6 then salary*0.1
end Bonus
from employee_salary
