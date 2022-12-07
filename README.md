# Employee Database Analysis

## Objective
Analysis of the HR data for the PH company to know the number of retiring employes - specifically, the number of retiring employees by job title.

## Softwares
- Quick DBD
- PostgreSQL and pgAdmin 4

## Analysis
- Create the Employee Database from six (6) source tables based on the following entity relationship diagram:
![EmployeeDB_corrected](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/8fe1f28002145b1d6d31c31df98789ae835ca774/EmployeeDB_corrected.png)

The code for creation of the Employee Database can be found here:
[schema](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/88f39d43b732f025475042ad5b01fd094b01443e/Queries/schema.sql).
Source tables can be found here:
[departments](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/6fd7a0dbeadaab27cd0da36f2696bae390c65024/Data/departments.csv), [dept_emp](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/fd31e8af4ec01033a5251bdd40f4213a55006d05/Data/dept_emp.csv), [dept_manager](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/715eb31e77e2a2404af35849f5fa4fd0e7fd6769/Data/dept_manager.csv), [employees](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/0d0f29f9b7206340b23d879e3dce452120255bb4/Data/employees.csv), 


- Create a [retirement_titles](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/19c1eb13c2efdc16b1b359975aa05fd6bb84ce4f/Data/retirement_titles.csv) table that holds all the titles of employees who were born between January 1, 1952 and December 31, 1955. 

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

[Employee_Database_challenge](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/9ad29dae426e9bad4b13f59138cf436fd41dfb59/Queries/Employee_Database_challenge.sql)

[retirement_titles](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/19c1eb13c2efdc16b1b359975aa05fd6bb84ce4f/Data/retirement_titles.csv)


Because some employees may have multiple titles in the database—for example, due to promotions—you’ll need to use the DISTINCT ON statement to create a table that contains the most recent title of each employee. Then, use the COUNT() function to create a table that has the number of retirement-age employees by most recent job title. Finally, because we want to include only current employees in our analysis, be sure to exclude those employees who have already left the company.


There are duplicate entries for some employees because they have switched titles over the years. Use the following instructions to remove these duplicates and keep only the most recent title of each employee.


Following the initial [queries](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/a34a3655624e3f8baa822c887c8cd625d96ba158/Queries/queries.sql), the number of retiring employees was inquired using the following code [Employee_Database_challenge](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/9ad29dae426e9bad4b13f59138cf436fd41dfb59/Queries/Employee_Database_challenge.sql).

- Determine the number of retiring employees per title:
- 
## Results
Number of retiring employees by job title shown below:

![retiring_titles](https://github.com/MSF2141/Pewlett-Hackard-Analysis./blob/41bd283d906456bbdd0256832483ed4945f41d0a/Data/retiring_titles.png)
