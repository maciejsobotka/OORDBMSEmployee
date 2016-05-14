declare
addr1 address_typ;
addr2 address_typ;
addr3 address_typ;
addr4 address_typ;
addr5 address_typ;
addr6 address_typ;
addr7 address_typ;
addr8 address_typ;

dept1 department_typ;
dept2 department_typ;

date1 TIMESTAMP(6);
date2 TIMESTAMP(6);
date3 TIMESTAMP(6);
date4 TIMESTAMP(6);
date5 TIMESTAMP(6);
date6 TIMESTAMP(6);

empl1 employee_typ;
empl2 employee_typ;
empl3 employee_typ;
empl4 employee_typ;
empl5 employee_typ;

appl1 applicant_typ;

date7 TIMESTAMP(6);
date8 TIMESTAMP(6);
date9 TIMESTAMP(6);
date10 TIMESTAMP(6);
date11 TIMESTAMP(6);

task1 task_typ;
task2 task_typ;
task3 task_typ;
task4 task_typ;
task5 task_typ;

proj1 project_typ;
proj2 project_typ;

emp_ref REF employee_typ;
emp_ref2 REF employee_typ;
emp_ref3 REF employee_typ;
app_ref REF applicant_typ;
dept_ref REF department_typ;
proj_ref REF project_typ;
proj_ref2 REF project_typ;
task_ref REF task_typ;
task_ref2 REF task_typ;
task_ref3 REF task_typ;

begin
addr1 := address_typ(1,'New York', 'RidgeStreet', 'NY',null,null);
addr2 := address_typ(2,'Los Angeles', 'DivisionStreet', 'LA',null,null);
addr3 := address_typ(3,'New York', 'OakStreet', 'NY',null,null);
addr4 := address_typ(4,'New York', 'LocustLane', 'NY',null,null);
addr5 := address_typ(5,'Los Angeles', 'CanalStreet', 'LA',null,null);
addr6 := address_typ(6,'Los Angeles', 'ClarkStreet', 'LA',null,null);
addr7 := address_typ(7,'Los Angeles', 'AspenDrive', 'LA',null,null);
addr8 := address_typ(8,'New York', 'PheasantRun', 'NY',null,null);

dept1 := department_typ(1,'Management',null,null);
dept2 := department_typ(2,'IT',null,null);

date1 := ('1992-02-13 23:30:12');
empl1 := employee_typ(1,'Walter Smith', null, date1, 'CEO', 12400,null,null);
date2 := ('1992-02-14 21:21:14');
empl2 := employee_typ(2,'Shawn Smith', null, date2, 'Director', 10600,null,null);
date3 := ('1992-05-23 15:30:12');
empl3 := employee_typ(3,'Damian Williams', null, date3, 'Developer', 5200,null,null);
date4 := ('1995-07-09 12:21:14');
empl4 := employee_typ(4,'Shawn Johnson', null, date4, 'IT Guy', 3500,null,null);
date5 := ('1999-12-01 09:30:12');
empl5 := employee_typ(5,'Jessica Jones', null, date5, 'HR', 2800,null,null);
date6 := ('2001-10-05 12:21:55');
appl1 := applicant_typ(1,'Melissa Miller', null, date6, 'Secretary');

date7 := ('1997-04-05 00:00:00');
task1 := task_typ(1,'Development Environments', date7, add_months(date7, 3),null);
date8 := ('1998-02-12 00:00:00');
task2 := task_typ(2,'Collaboration Server', date8, add_months(date8, 5),null);
date9 := ('1996-09-17 00:00:00');
task3 := task_typ(3,'Chat Server', date9, add_months(date9, 3),null);
date10 := ('2000-01-02 00:00:00');
task4 := task_typ(4,'Employee Tracking System', date10, add_months(date10, 4),null);
date11 := ('2001-11-23 00:00:00');
task5 := task_typ(5,'Virtual Shopping', date11, add_months(date11, 2),null);

proj1 := project_typ(1,'S','System',null,null);
proj2 := project_typ(2,'BMS', 'Bank Management System',null,null);
-- Inserts without associations
insert into address values (addr1);
insert into address values (addr2);
insert into address values (addr3);
insert into address values (addr4);
insert into address values (addr5);
insert into address values (addr6);
insert into address values (addr7);
insert into address values (addr8);

insert into department values (dept1);
insert into department values (dept2);

insert into employee values (empl1);
insert into employee values (empl2);
insert into employee values (empl3);
insert into employee values (empl4);
insert into employee values (empl5);

insert into applicant values (appl1);

insert into task values (task1);
insert into task values (task2);
insert into task values (task3);
insert into task values (task4);
insert into task values (task5);

insert into project values (proj1);
insert into project values (proj2);
commit;
-- Update associations
update department d set d.address = addr1 where d.department_id = 1;
update department d set d.address = addr2 where d.department_id = 2;
update employee e set e.address = addr3, e.department = dept1 where e.person_id = 1;
update employee e set e.address = addr4, e.department = dept1 where e.person_id = 2;
update employee e set e.address = addr5, e.department = dept2 where e.person_id = 3;
update employee e set e.address = addr6, e.department = dept2 where e.person_id = 4;
update employee e set e.address = addr7, e.department = dept2 where e.person_id = 5;
update applicant a set a.address = addr8 where a.person_id = 1;
-- REF dept for address
select REF(d) into dept_ref from department d where d.department_id=1;
update address a set a.department = dept_ref where a.address_id=1;
select REF(d) into dept_ref from department d where d.department_id=2;
update address a set a.department = dept_ref where a.address_id=2;
-- REF appl for address
select REF(a) into app_ref from applicant a where a.person_id=1;
update address a set a.person = app_ref where a.address_id=8;
-- REF task for tasks
select REF(t) into task_ref from task t where t.task_id=1;
select REF(t) into task_ref2 from task t where t.task_id=2;
select REF(t) into task_ref3 from task t where t.task_id=3;
update project p set p.tasks = taskstable_typ(task_ref,task_ref2,task_ref3) where p.project_id=1;
select REF(t) into task_ref from task t where t.task_id=4;
select REF(t) into task_ref2 from task t where t.task_id=5;
update project p set p.tasks = taskstable_typ(task_ref,task_ref2) where p.project_id=2;
-- REF empl for head and empls
select REF(e) into emp_ref from employee e where e.person_id=1;
update department d set d.head = emp_ref where d.department_id = 1;
update address a set a.person = emp_ref where a.address_id =3;
select REF(e) into emp_ref2 from employee e where e.person_id=3;
update address a set a.person = emp_ref2 where a.address_id =5;
select REF(e) into emp_ref3 from employee e where e.person_id=4;
update address a set a.person = emp_ref3 where a.address_id =6;
-- Empls for proj1
update project p set p.employees = employeestable_typ(emp_ref,emp_ref2,emp_ref3) where p.project_id=1;
-- REF empl for head and empls
select REF(e) into emp_ref from employee e where e.person_id=2;
update department d set d.head = emp_ref where d.department_id = 2;
update address a set a.person = emp_ref where a.address_id =4;
select REF(e) into emp_ref2 from employee e where e.person_id=5;
update address a set a.person = emp_ref2 where a.address_id =7;
-- Empls for proj2
update project p set p.employees = employeestable_typ(emp_ref,emp_ref2,emp_ref3) where p.project_id=2;
-- REF proj for projects and project
select REF(p) into proj_ref from project p where p.project_id=1;
select REF(p) into proj_ref2 from project p where p.project_id=2;
update task t set t.project = proj_ref where t.task_id=1;
update task t set t.project = proj_ref where t.task_id=2;
update task t set t.project = proj_ref where t.task_id=3;
update task t set t.project = proj_ref2 where t.task_id=4;
update task t set t.project = proj_ref2 where t.task_id=5;
update employee e set e.projects = projectstable_typ(proj_ref) where e.person_id=1;
update employee e set e.projects = projectstable_typ(proj_ref2) where e.person_id=2;
update employee e set e.projects = projectstable_typ(proj_ref) where e.person_id=3;
update employee e set e.projects = projectstable_typ(proj_ref) where e.person_id=4;
update employee e set e.projects = projectstable_typ(proj_ref,proj_ref2) where e.person_id=5;
end;
/