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
CREATE TABLE dept_emp (
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

Select * FROM dept_emp;

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

DROP TABLE retirement_info;

--Create new table for retirement employees
SELECT emp_no, first_name, last_name
INTO retirement_info
From employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

Select * from retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
	retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;
	
-- (making shortcuts,aliases)Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
    ri.first_name,
	ri.last_name,
    de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;

-- (making shortcuts,aliases)Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- left join between retirement_info and data_emp tables
Select ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
--making new table to hold above info
into current_emp
-- add the code to join the the new current_emp table and the above table 
from retirement_info as ri
left join dept_emp as de
on ri.emp_no=de.emp_no
--add filter for current employees
where de.to_date = ('9999-01-01');

Select * from current_emp;

--join current_emp with dept_emp table.Employee count by depratment number
Select count(ce.emp_no) , de.dept_no
into employee_count
from current_emp as ce
left join dept_emp as de
on ce.emp_no = de.emp_no
group by de.dept_no
--create order in the above query by using ORDER BY
order by de.dept_no;

--create new table table and export as employee count table
DROP TABLE employee_count;

--sorting to_date column in salaries table
Select * from salaries
order by to_date desc;

--reuse the code and add gender info
SELECT emp_no, first_name, last_name,gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- use salaries table to add further info and join the above code into emp_info
Select e.emp_no,
		e.first_name,
		e.last_name,
		e.gender,
		s.salary,
		de.to_date
into emp_info
from employees as e
inner join salaries as s
on (e.emp_no = s.emp_no)
--add another join in the same query
inner join dept_emp as de
on (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01');

--list of managers per department
select dm.dept_no,
		d.dept_name,
		dm.emp_no,
		ce.last_name,
		ce.first_name,
		dm.from_date,
		dm.to_date
into manager_info
from dept_manager as dm
	inner join departments as d
		on (dm.dept_no = d.dept_no)
	inner join current_emp as ce
		on (dm.emp_no = ce.emp_no);
		
--List od department retirees
Select ce.emp_no,
		ce.first_name,
		ce.last_name,
		d.dept_name
into dept_info
from current_emp as ce
	 inner join dept_emp as de
		on (ce.emp_no = de.emp_no)
	inner join departments as d
		on (de.dept_no = d.dept_no);
		