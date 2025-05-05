-- joins -- combines 2 or more tables that they have a common collumn inner outer and self-join

select *
from employee_demographics;

select *
from employee_salary;

-- inner join - returns rows that are the same of both tables

select *
from employee_demographics
inner join employee_salary
	on employee_demographics.employee_id = employee_salary.employee_id
;

select employee_id, age, occupation
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id -- output is a error because the column names are not explicit
;

select dem.employee_id, age, occupation
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

-- outer joins - left and right
select dem.employee_id, age, occupation
from employee_demographics as dem
left outer join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

select *
from employee_demographics as dem
right outer join employee_salary as sal
	on dem.employee_id = sal.employee_id
;

-- self join

select *
from employee_salary emp1
join employee_salary emp2
	on emp1.employee_id=emp2.employee_id
;

select *
from employee_salary emp1
join employee_salary emp2
	on emp1.employee_id + 1 =emp2.employee_id
;

select emp1.employee_id as emp_santa,
emp1.first_name as fist_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id as emp_name,
emp2.first_name as fist_name_emp,
emp2.last_name as last_name_emp
from employee_salary emp1
join employee_salary emp2
	on emp1.employee_id + 1 =emp2.employee_id
;

-- joining multiple tables together

select *
from parks_departments; -- reference table

select *
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
inner join parks_departments pd
	on sal.dept_id=pd.department_id -- dem can combine with sal that sal can combine with pd
;