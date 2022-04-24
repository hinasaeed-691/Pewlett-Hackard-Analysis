--1.Retrieve the emp_no, first_name, and last_name columns from the Employees table.
Select emp_no, first_name, last_name
from employees
where birth_date between '-1952-01-01' and '1955-12-31';

--2. Retrieve the title, from_date, and to_date columns from the Titles table.
Select title,to_date,from_date
from titles
where birth_date between '-1952-01-01' and '1955-12-31';

--3. Create a new Retirement Titles table using the INTO clause.
Select 
--4. Join both tables on the primary key.
--5. Filter the data on the birth_date column to retrieve the employees who were born between 1952 and 1955. Then, order by the employee number.
--6. Export the Retirement Titles table from the previous step as retirement_titles.csv and save it to your Data folder in the Pewlett-Hackard-Analysis folder.



