-- Stored Procedures

select *
from employee_salary
where salary >=5000
;


create procedure large_salaries()
select *
from employee_salary
where salary >=5000
;

call large_salaries();-- call this procedure


-- ---------------------------------------
delimiter $$
create procedure large_salaries2()
begin
	select *
	from employee_salary
	where salary >=5000;
	select *
	from employee_salary
	where salary >=10000;
end $$
delimiter ;


call large_salaries2();
call new_procedure();

-- Parameters

delimiter $$
create procedure large_salaries4(p_employee_id int)
begin
	select salary
	from employee_salary
	where employee_id=p_employee_id;
end $$
delimiter ;

call large_salaries4(1);

