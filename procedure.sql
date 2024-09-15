create table worker (worker_id int, first_name varchar(20), last_name varchar(20),salary int, joining_date datetime, department varchar(20));
insert into worker(worker_id , first_name, last_name ,salary , joining_date,department) values
(1, 'Henna', 'Doe', 50000, '2024-01-15 08:30:00', 'Engineering'),
(2, 'Leo', 'Smith', 55000, '2023-05-23 09:00:00', 'Marketing'),
(3, 'CR', 'Johnson', 60000, '2022-11-11 10:15:00', 'Engineering'),
(4, 'Pele', 'Brown', 45000, '2024-02-01 11:00:00', 'Sales'),
(5, 'Dybala', 'Davis', 70000, '2023-07-21 08:45:00', 'Marketing');

delimiter $$
create procedure addworker( IN p_Worker_Id int,IN p_FirstName CHAR(20),IN p_LastName CHAR(20),in p_Salary int,in p_JoiningDate datetime,
    in p_Department char(20))
    begin
    insert into Worker (worker_Id, first_name, last_name, salary, joining_date, department)
    values (p_Worker_Id, p_FirstName, p_LastName, p_Salary, p_JoiningDate, p_Department);
END $$
delimiter ;
call addworker(3, 'CR', 'Johnson', 60000, '2022-11-11 10:15:00', 'Engineering');

delimiter $$
create procedure GetWorkerSalary (in p_worker_id int, out p_salary int)
begin
select salary into p_salary from worker where worker_id=p_worker_id;
end $$
delimiter ;
call GetWorkerSalary(2,@salary);
select @salary;

delimiter $$
create procedure UpdateDepartment (in p_worker_id int, in p_department varchar(20))
begin
update worker set department= p_department where worker_id=p_worker_id;
end $$
delimiter ;
call UpdateDepartment(3,'Marketing');
#set sql_safe_updates=0;
#set sql_safe_updates=1;

delimiter $$
create procedure GetCount(in p_department char(20), out p_workerCount int)
begin
select count(*)  into p_workerCount from worker where department =p_department ;
end $$ 
delimiter ;
call GetCount('Engineering', @workerCount);
select @workerCount;

delimiter $$
create procedure GetavgSalary (in p_department varchar(20), out p_avgSalary decimal(15,2))
begin
select avg(salary)  into p_avgSalary from worker where department=p_department;
end $$
delimiter ;
call GetavgSalary('Engineering', @AvgSalary);
select @AvgSalary;