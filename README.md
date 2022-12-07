# Employee Database Analysis

## Objective
Analysis of the HR data for the PH company to know the number of retiring employes and employees who are qualified to mentor the next generation of PH employees.

## Softwares
- Quick DBD
- PostgreSQL and pgAdmin 4

## Analysis
In order to analyze the HR data, an Employee Database was created based on the entity relationship diagram, shown below. The Employee database was created from the following six (6) source tables: [departments](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/6fd7a0dbeadaab27cd0da36f2696bae390c65024/Data/departments.csv), [dept_emp](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/fd31e8af4ec01033a5251bdd40f4213a55006d05/Data/dept_emp.csv), [dept_manager](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/715eb31e77e2a2404af35849f5fa4fd0e7fd6769/Data/dept_manager.csv), [employees](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/0d0f29f9b7206340b23d879e3dce452120255bb4/Data/employees.csv), [salaries](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/bbf490d37780e5fa46727235e5fc4a86f67dd21d/Data/salaries.csv), [titles](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/8055755fae4ef01166962f3c0fa0efe4d42d7ede/Data/titles.csv). The code for creation of the Employee Database can be found here:
[schema](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/88f39d43b732f025475042ad5b01fd094b01443e/Queries/schema.sql).

![EmployeeDB_corrected](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/8fe1f28002145b1d6d31c31df98789ae835ca774/EmployeeDB_corrected.png)

Once the Employee Database was created, it was filtered using SQL queries to find all current employees who are in retirement age and their most recent job title. In addition, Employee Database was filtered using the SQL query to find all the current employes who are qualified to mentor the next generation of employees. 

## Results
The [retirement_titles](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/19c1eb13c2efdc16b1b359975aa05fd6bb84ce4f/Data/retirement_titles.csv) table (first ten rows out of 133776 shown below) holds all the titles of retirement-age employees, i.e., those who were born between January 1, 1952 and December 31, 1955. Following section of the code ([Employee_Database_challenge](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/eb6c106923eec32f0185da8f0593ece89dbb43c6/Queries/Employee_Database_challenge.sql)) was used for this query:

````
```
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
```
````

![retirement_titles](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/b6b8c0763c37efad72bd4e16bbc0f0f3a0e1f39b/Data/retirement_titles.png)
Because some employees have multiple titles — for example, due to promotions — in the next step the duplicate entries were omitted from the Employee Database. 
<br />
<br />
<br />
<br />
The [unique_titles](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/180ea5c039c4c21314f5b68bff2f06445709ba23/Data/unique_titles.csv) table (first ten rows out of 72458 shown below) contains only the most recent title for each retirement-age employee using the DISTINCT ON statement. In additon, the unique_titles table takes into consideration only the current employees and all the employees who have already left the company are excludes from the data table. Following section of the code ([Employee_Database_challenge](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/eb6c106923eec32f0185da8f0593ece89dbb43c6/Queries/Employee_Database_challenge.sql)) was used for this query:

````
```
SELECT DISTINCT ON (retirement_titles.emp_no) retirement_titles.emp_no,
					      retirement_titles.first_name,
					      retirement_titles.last_name,
					      retirement_titles.title
INTO unique_titles
FROM retirement_titles
WHERE retirement_titles.to_date = ('9999-01-01')
ORDER BY retirement_titles.emp_no, retirement_titles.to_date DESC;
```
````

![unique_titles](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/c61805636c03d2f8d474c9f75ff47ae822a1d5ca/Data/unique_titles.png)
<br />
<br />
<br />
<br />
The [retiring_titles](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/667b71b70c010f8b582bccbe269f7a3c8654e115/Data/retiring_titles.csv) table (shown below) contains the number of retirement-age employees by their most recent title using the COUNT statement. In additon, the retiring_titles table takes into consideration only the current employees and all the employees who have already left the company are excludes from the data table. Following section of the code ([Employee_Database_challenge](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/eb6c106923eec32f0185da8f0593ece89dbb43c6/Queries/Employee_Database_challenge.sql)) was used for this query: 

````
```
SELECT COUNT(retirement_titles.emp_no), unique_titles.title
INTO retiring_titles
FROM retirement_titles
LEFT JOIN unique_titles
ON retirement_titles.emp_no = unique_titles.emp_no
WHERE retirement_titles.to_date = ('9999-01-01')
GROUP BY unique_titles.title
ORDER BY unique_titles.count DESC;
```
````

![retiring_titles](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/41bd283d906456bbdd0256832483ed4945f41d0a/Data/retiring_titles.png)
<br />
<br />
<br />
<br />
The [mentorship_eligibility](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/b601dcc4068c422427f04241432a7411532b9523/Data/mentorship_eligibility.csv) table (first ten rows out of 1549 shown below) contains the list of employees who are eligible to participate in a mentorship program. Following section of the code ([Employee_Database_challenge](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/eb6c106923eec32f0185da8f0593ece89dbb43c6/Queries/Employee_Database_challenge.sql)) was used for this query: 

````
```
SELECT DISTINCT ON (employees.emp_no) employees.emp_no, 
	   			      employees.first_name,
	   			      employees.last_name,
	   			      employees.birth_date,
	   			      dept_emp.from_date,
	   			      dept_emp.to_date,
	   			      titles.title 
INTO mentorship_eligibilty 
FROM employees
LEFT JOIN dept_emp 
ON employees.emp_no = dept_emp.emp_no
LEFT JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (dept_emp.to_date = '9999-01-01')
AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY employees.emp_no;
```
````

![mentorship_eligibility](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/d4505a32fc2131887dfc7e04daaa43f78b8a7225/Data/mentorship_eligibility.png)

## Summary
Analysis show that there are 72458 retiring employees at the PH company. Specifically, 25916 Senior Engineers, 24926 Senior Staffs, 9285 Engineers, 7363 Staffs, 3603 Technique Leaders, 1090 Assistant Engineers, and 2 Managers will be retiring. On the other side, there are only 1549 employees who are qualified to mentor the next generation of PH employees. 

As a follow up analysis, it seems necessary to understand per each job title how many mentorship-eligible employees are currenntly working at the PH company. 
For example, the below code would return that 414 Senior Staffs, 390 Engineers, 310 Staffs, 297	Senior Engineers, 77 Technique Leaders, and 61 Assistant Engineers are qualified to mentor the next generation of PH employees. 

````
```
SELECT COUNT(mentorship_eligibilty.emp_no), mentorship_eligibilty.title
--INTO mentorship_eligibilty_titles
FROM mentorship_eligibilty
WHERE mentorship_eligibilty.to_date = ('9999-01-01')
GROUP BY mentorship_eligibilty.title
ORDER BY mentorship_eligibilty.count DESC;
```
````

![mentorship_eligibility_titles](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/b46076910fdfff5a54a7185ecd257004b15c4726/Data/mentorship_eligibility_titles.png)
