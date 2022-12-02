--Employee_Database_challenge
SELECT employees.emp_no,
     employees.first_name,
     employees.last_name,
	 titles.title,
     titles.from_date,
	 titles.to_date
INTO retirement_titles
FROM employees
RIGHT JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY employees.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (retirement_titles.emp_no) retirement_titles.emp_no,
											retirement_titles.first_name,
											retirement_titles.last_name,
											retirement_titles.title

INTO unique_titles
FROM retirement_titles
WHERE retirement_titles.to_date = ('9999-01-01')
ORDER BY retirement_titles.emp_no, retirement_titles.to_date DESC;

--Retrieve the number of employees by their most recent job title who are about to retire
SELECT COUNT(retirement_titles.emp_no), unique_titles.title
INTO retiring_titles
FROM retirement_titles
LEFT JOIN unique_titles
ON retirement_titles.emp_no = unique_titles.emp_no
WHERE retirement_titles.to_date = ('9999-01-01')
GROUP BY unique_titles.title
ORDER BY unique_titles.count DESC;

SELECT * FROM retiring_titles;
