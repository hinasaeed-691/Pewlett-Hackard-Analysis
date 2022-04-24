-- Creating tables for PH-EmployeeDB
-- creating table(departments category)
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);
-- creating another table(employees category)
CREATE TABLE employees 
(emp_no int NOT NULL,
     birth_date date NOT NULL,
	first_name varchar not null,
	last_name varchar not null,
	gender varchar not null,
	hire_date date not null,
     PRIMARY KEY (emp_no));

-- creating another table(manager category)
CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

-- creating another table(salaries category)
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no));

-- creating another table(department employees category)
CREATE TABLE department_employee (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
  	from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);


-- creating another table(titles category)
CREATE TABLE titles (
	emp_no INT NOT NULL,
    title VARCHAR NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no,title,from_date)
);


SELECT * FROM departments;

Select * FROM dept_manager;

Select * FROM employees;

Select * FROM salaries;

Select * FROM department_employee;

Select * FROM titles;


-- employees born in 1952 
select first_name, last_name
from employees
where birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- employees born in 1953 
select first_name, last_name
from employees
where birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- employees born in 1954 
select first_name, last_name
from employees
where birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- employees born in 1955 
select first_name, last_name
from employees
where birth_date BETWEEN '1955-01-01' AND '1955-12-31';

---we can do the above 3 steps in one code below
-- Retirement eligibility

select first_name,last_name
from employees
where(birth_date between '1952-01-01' and '1955-12-31')
--also add the employees hired between 1985 and 1988
and (hire_date between '1985-01-01' and '1988-12-31');

--use count in the above query to find the number of employees retiring
-- Number of employees retiring
select first_name,last_name
from employees
where(birth_date between '1952-01-01' and '1955-12-31')
--also add the employees hired between 1985 and 1988
and (hire_date between '1985-01-01' and '1988-12-31');

--creating a new table by using INTO statement in the above query

SELECT first_name, last_name
into retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;
