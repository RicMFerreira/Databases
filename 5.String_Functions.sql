-- String Functions

select length('skyfall');

select first_name, length(first_name)
from employee_demographics;

select first_name, length(first_name)
from employee_demographics
order by 2
;
select first_name, length(first_name) len
from employee_demographics
order by len 
; -- same as above

select upper('sky'); -- output uppercase the string
select lower('SKY'); -- output lowercase the string

select first_name, upper(first_name)
from employee_demographics
;

select trim('               sky             '); -- cleans the white space
select ltrim('               sky             ');-- cleans the white space from the left side
select rtrim('               sky             ');-- cleans the white space from the right side

select first_name, left(first_name,4) -- we want to select 4 characters from the left side
from employee_demographics;

select first_name, 
left(first_name,4), -- we want to select 4 characters from the left side
right(first_name,4), -- we want to select 4 characters from the right side
substring(first_name,3,2), -- we want the 3rd position and show 2 characters to the right
birth_date
from employee_demographics;

select first_name, 
left(first_name,4), -- we want to select 4 characters from the left side
right(first_name,4), -- we want to select 4 characters from the right side
substring(first_name,3,2), -- we want the 3rd position and show 2 characters to the right
substring(birth_date,6,2) as birth_month
from employee_demographics;

select first_name, replace(first_name, 'a','z') -- replace a to z
from employee_demographics;

select locate('x','Alexander'); -- search the char X in alexander and gives the position (4)

select first_name, locate('An',first_name)
from employee_demographics;

select first_name, last_name,
concat(first_name,' ',last_name) as full_name
from employee_demographics;
