CREATE OR REPLACE 
TYPE address_typ AS OBJECT (
   address_id      NUMBER(5),
   city            VARCHAR2(50),
   street          VARCHAR2(50),
   postal_code     VARCHAR2(50)
);
/

CREATE OR REPLACE 
TYPE department_typ AS OBJECT (
   department_id   NUMBER(5),
   name            VARCHAR2(50)
);
/

CREATE OR REPLACE 
TYPE person_typ AS OBJECT (
   person_id       NUMBER(5),
   name            VARCHAR2(50)
)
NOT FINAL;
/

CREATE OR REPLACE 
TYPE employee_typ UNDER person_typ (
   hiredate TIMESTAMP(6),
   job VARCHAR2(50),
   salary FLOAT
);
/

CREATE OR REPLACE 
TYPE applicant_typ UNDER person_typ ( 
   applicationdate TIMESTAMP(6),
   position VARCHAR2(50)
);
/

CREATE OR REPLACE 
TYPE task_typ AS OBJECT (
   task_id NUMBER(5),
   description VARCHAR2(50),
   startdate TIMESTAMP(6),
   enddate TIMESTAMP(6)
);
/

CREATE OR REPLACE 
TYPE project_typ AS OBJECT (
   project_id NUMBER(5),
   name VARCHAR2(50),
   subject VARCHAR2(50)
);
/

CREATE OR REPLACE 
TYPE TasksTable_typ AS
   TABLE OF REF task_typ;
/

CREATE OR REPLACE 
TYPE ProjectsTable_typ AS
   TABLE OF REF project_typ;
/

CREATE OR REPLACE 
TYPE EmployeesTable_typ AS
   TABLE OF REF employee_typ;
/

ALTER TYPE address_typ
ADD ATTRIBUTE   (department REF department_typ) CASCADE;
ALTER TYPE address_typ
ADD ATTRIBUTE   (person REF person_typ) CASCADE;
/
ALTER TYPE department_typ
ADD ATTRIBUTE   (head REF employee_typ) CASCADE;
ALTER TYPE department_typ
ADD ATTRIBUTE   (address address_typ) CASCADE;
/
ALTER TYPE person_typ
ADD ATTRIBUTE   (address address_typ) CASCADE;
/
ALTER TYPE employee_typ
ADD ATTRIBUTE   (department department_typ) CASCADE;
ALTER TYPE employee_typ
ADD ATTRIBUTE   (projects ProjectsTable_typ) CASCADE;
/
ALTER TYPE task_typ
ADD ATTRIBUTE   (project REF project_typ) CASCADE;
/
ALTER TYPE project_typ
ADD ATTRIBUTE  (tasks TasksTable_typ) CASCADE;
ALTER TYPE project_typ
ADD ATTRIBUTE  (employees EmployeesTable_typ) CASCADE;
/

CREATE TABLE Address of address_typ(address_id PRIMARY KEY);
/

CREATE TABLE Department of department_typ(department_id PRIMARY KEY);
/

CREATE TABLE Employee of employee_typ(person_id PRIMARY KEY)
NESTED TABLE projects STORE AS Employee_Projects;
/

CREATE TABLE Applicant of applicant_typ(person_id PRIMARY KEY);
/

CREATE TABLE Task of task_typ(task_id PRIMARY KEY);
/

CREATE TABLE Project of project_typ(project_id PRIMARY KEY)
NESTED TABLE tasks STORE AS Project_Tasks,
NESTED TABLE employees STORE AS Project_Employees;
/