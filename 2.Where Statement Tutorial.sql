SELECT *
From employee_demographics
where first_name like 'Jer%'
;

SELECT *
From employee_demographics
where first_name like '%er%'
;

SELECT *
From employee_demographics
where first_name like 'a%'
;

SELECT *
From employee_demographics
where first_name like 'a___%'#starts with a 'a' has 3 chars (3x underscore) and anything else after
;
SELECT *
From employee_demographics
where birth_date like '1989%'
;