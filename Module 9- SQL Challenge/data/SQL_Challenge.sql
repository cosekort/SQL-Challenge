-- drop tables if they exist
drop table departments;
drop table dept_emp; 
drop table dept_manager;
drop table employees;
drop table salaries;
drop table titles; 

-- create tables and import
create table departments (
	dept_no varchar PRIMARY KEY,
	dept_name varchar
);
create table titles(
	title_id varchar PRIMARY KEY,
	title varchar
);
create table employees(
	emp_no int PRIMARY KEY,
	emp_title varchar REFERENCES titles(title_id),
	birth_date varchar,
	first_name varchar,
	last_name varchar,
	sex varchar, 
	hire_date varchar
);
create table dept_emp(
	emp_no int,
	dept_no varchar
);

ALTER TABLE dept_emp 
ADD CONSTRAINT PK PRIMARY KEY(emp_no,dept_no);

create table dept_manager(
	dept_no varchar, 
	emp_no int 
);

ALTER TABLE dept_manager
ADD CONSTRAINT PK_man PRIMARY KEY(dept_no,emp_no);

create table salaries(
	emp_no int PRIMARY KEY,
	salary int
);

--check imported data
select *
from salaries;

select *
from dept_manager;

select *
from dept_emp;

select *
from employees;

select *
from departments;

select *
from titles;

-- List the employee number, last name, first name, sex, and salary of each employee.
select employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary 
from employees
inner join salaries on 
employees.emp_no=salaries.emp_no

-- List the first name, last name, and hire date for the employees who were hired in 1986.
select employees.first_name, employees.last_name, employees.hire_date
from employees
where hire_date LIKE '%/1986'

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
select dept_manager.emp_no,employees.first_name,employees.last_name, dept_manager.dept_no, departments.dept_name  
from dept_manager 
inner join departments on 
dept_manager.dept_no= departments.dept_no
inner join employees on 
dept_manager.emp_no= employees.emp_no

-- List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
select dept_emp.dept_no, employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
inner join dept_emp on 
employees.emp_no= dept_emp.emp_no
inner join departments on 
dept_emp.dept_no= departments.dept_no

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
select employees.first_name, employees.last_name, employees.sex
from employees
where first_name LIKE 'Hercules'
and last_name LIKE 'B%'

-- List each employee in the Sales department, including their employee number, last name, and first name.
select departments.dept_name, dept_emp.emp_no, employees.last_name, employees.first_name 
from departments
inner join dept_emp on 
departments.dept_no= dept_emp.dept_no
inner join employees on 
dept_emp.emp_no= employees.emp_no
where dept_name LIKE 'Sales'

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select departments.dept_name, dept_emp.emp_no, employees.last_name, employees.first_name 
from departments
inner join dept_emp on 
departments.dept_no= dept_emp.dept_no
inner join employees on 
dept_emp.emp_no= employees.emp_no
where dept_name LIKE 'Sales'
or dept_name LIKE 'Development'

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
select employees.last_name, COUNT(last_name)AS frequency
from employees
GROUP BY last_name 
ORDER BY last_name DESC