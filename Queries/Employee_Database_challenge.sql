--1.Retrieve the emp_no, first_name, and last_name columns from the Employees table.
Select emp_no, first_name, last_name
from employees
where birth_date between '1952-01-01' and '1955-12-31';

--2. Retrieve the title, from_date, and to_date columns from the Titles table.
Select title,to_date,from_date
from titles;

--3. Create a new Retirement Titles table using the INTO clause.
drop table IF EXISTS retirement_titles;
Select e.emp_no, e.first_name, e.last_name, t.title,t.from_date,t.to_date
into retirement_titles
from employees as e
	inner join titles as t 
	on t.emp_no = e.emp_no
where birth_date between '1952-01-01' and '1955-12-31'
order by e.emp_no;

select * from retirement_titles;

--Copy the query from the Employee_Challenge_starter_code.sql and add it to your Employee_Database_challenge.sql file.
-- Use Dictinct with Orderby to remove duplicate rows


--Retrieve the employee number, first and last name, and title columns from the Retirement Titles table.
--These columns will be in the new table that will hold the most recent title of each employee.
--Use the DISTINCT ON statement to retrieve the first occurrence of the employee number for each set of rows defined by the ON () clause.
drop table if EXISTS unique_titles ;
select distinct on(r.emp_no) emp_no,
		r.first_name,
		r.last_name ,
		r.title
into unique_titles
from retirement_titles as r
where to_date = '9999-01-01'
order by emp_no asc, to_date desc;
select * from unique_titles; 


--Write another query in the Employee_Database_challenge.sql file to retrieve the number of employees by their most recent job title who are about to retire.
--First, retrieve the number of titles from the Unique Titles table.
--Then, create a Retiring Titles table to hold the required information.
--Group the table by title, then sort the count column in descending order.
--Export the Retiring Titles table as retiring_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.

drop table if exists retiring_titles;
select count (ut.title) , title
into retiring_titles
from unique_titles ut 
group by ut.title
order by count (ut.title) desc;


select * from retiring_titles;

drop table if exists mentorship_eligibility;
select distinct on(e.emp_no) e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		t.title
into mentorship_eligibility
from employees  as e
inner join  dept_emp as de on e.emp_no=de.emp_no 
inner join  titles t  on e.emp_no=t.emp_no 
where birth_date between '1965-01-01' and '1965-12-31'
and de.to_date = '9999-01-01'
order by e.emp_no ;
select * from mentorship_eligibility;






