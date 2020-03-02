-- Creating tables for PH-EmployeeDB

--Create table for departments
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);
--Create table for employees
CREATE TABLE employees (
	 emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

--Create table for Managers
CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);
--Create table for Salaries
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);
--Create table for Titles
CREATE TABLE titles(
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
	--PRIMARY KEY (emp_no)
);
--Create table for dept_Emp
DROP TABLE dept_emp;
CREATE TABLE dept_emp(
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
PRIMARY KEY (emp_no, dept_no)
);

SELECT * FROM departments;
SELECT * FROM departments;
SELECT * FROM dept_manager;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM dept_emp;
SELECT * FROM titles;

DROP TABLE dept_emp CASCADE;

--Determine retirment eligibility 
DROP TABLE retirement_info;
SELECT first_name, last_name
FROM employees
WHERE birth_date Between '1955-01-01' AND '1955-12-31';

--Retirement eligibility (use this one)

DROP TABLE retirement_info;
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--create a new table with retirement information
DROP TABLE retirement_info;
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--drop the queried table retirment information so we can add in emp_no 
--then comment out to avoid accidently killing it ----later

--Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--View the Table
SELECT * FROM retirement_info;
-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

--joining departments and dept_manager tables
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

--joining retirement_info and dept_emp tables
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date,
	de.dept_no
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

--join departments and dept manager and make new table
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
INTO dept_dept_mgr
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		

		
--Department retirees
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info_sales_dev
FROM current_emp AS ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
on (de.dept_no = d.dept_no)
WHERE de.to_date = ('9999-01-01') AND d.dept_name IN ('Sales','Development');

SELECT * FROM dept_info_sales_dev

--Challenge

-- Create new table for number of titles retiring employees
SELECT emp_no, first_name, last_name
INTO retirement 
FROM employees

WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Check the table
SELECT * FROM retirement

--Join Title, from_date and Salary to the query 
SELECT e.emp_no, e.first_name, e.last_name,
	t. title, t.from_date,
	s. salary
INTO retirement_title
From employees AS e
INNER JOIN titles AS t
ON (e. emp_no = t. emp_no)
INNER JOIN salaries AS s
ON (e.emp_no = s. emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
ORDER BY from_date desc;

SELECT * FROM retirement_title;


SELECT COUNT (*) FROM retirement_title


SELECT * FROM retirement_title

--Counting the number of each employee per title
SELECT COUNT (title), title
INTO unique_title 
FROM retirement_title
Group BY title
ORDER BY count DESC;
SELECT * FROM unique_title

--Employees most recent title
SELECT emp_no, first_name, last_name,  MAX(from_date) maxDate
	   FROM retirement_title
	   GROUP BY emp_no, first_name, last_name;


--Who's ready for a Mentor
SELECT e. emp_no, e. first_name, e. last_name, t. title, t. from_date, t. to_date
INTO Mentors 
FROM employees As e
INNER JOIN  titles AS t
ON (e.emp_no = t. emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (to_date = '9999-01-01');

SELECT * From Mentors

