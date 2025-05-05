-- Window functions - window functions allow you to perform calculations across a subset of rows related to the current row, 
-- without affecting the overall grouping of results. Unlike standard aggregate functions, window functions do not collapse rows but instead apply calculations within a specified "window".

select gender, avg(salary) as avg_sal
from employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id
group by gender    
;

select gender, avg(salary) Over() -- it will calculate the average salary over everything
from employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id
  
;

select dem.first_name,dem.last_name, gender, avg(salary) Over(partition by gender) -- it will calculate the average salary by the different values of column gender
from employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id
;

select dem.first_name,dem.last_name, gender,salary, 
sum(salary) Over(partition by gender order by dem.employee_id) as rolling_total -- it will calculate the running total
from employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id
;

select dem.first_name,dem.last_name, gender,salary, 
sum(salary) Over(order by dem.employee_id) as rolling_total -- it will calculate the running total
from employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id
;
select dem.employee_id, dem.first_name,dem.last_name, gender,salary, 
row_number() over() -- adds a unique column number
from employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id
;

select dem.employee_id, dem.first_name,dem.last_name, gender,salary, 
row_number() over(partition by gender) -- adds a unique column number by the gender
from employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id
;

select dem.employee_id, dem.first_name,dem.last_name, gender,salary, 
row_number() over(partition by gender order by salary desc) -- adds a unique column number by the gender from the highest to the lower
from employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id
;

select dem.employee_id, dem.first_name,dem.last_name, gender,salary, 
row_number() over(partition by gender order by salary desc) as row_num, -- adds a unique column number by the gender from the highest to the lower
rank() over(partition by gender order by salary desc) as rank_num -- it will give a number by the salary but if it finds a duplicate it will keep the same number and afterwards it gives a position
from employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id
;

select dem.employee_id, dem.first_name,dem.last_name, gender,salary, 
row_number() over(partition by gender order by salary desc) as row_num, -- adds a unique column number by the gender from the highest to the lower
rank() over(partition by gender order by salary desc) as rank_num, -- it will give a number by the salary but if it finds a duplicate it will keep the same number and afterwards it gives a position
dense_rank() over(partition by gender order by salary desc) as dense_rank_num -- it will give a number by the salary but if it finds a duplicate it will keep the same number and afterwards it the next number
from employee_demographics dem
join employee_salary sal
	on dem.employee_id=sal.employee_id
;