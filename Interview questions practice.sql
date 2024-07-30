show databases;

## 1. Write an sql query to retrieve all details where first name from employee table starts with 'd', also write where name ends with 'h' and where 't' lies anywhere in first_name
select * from employees where firstname like 'd%';

select * from employees where first_name like '%h';

select * from employees where first_name like '%t%';

  
## 2. WRite an sql query to retrieve details of the employees whose salary between 10000 to 35000

select * from employees where salary between 10000 and 35000;

select concat(first_name, ' ', last_name) as Employee_name, salary 
from employees where empid in
(select * from employees where salary between 10000 and 35000);

## 3. SQL query to retrieve details of the employees who have joined on a given date

select * from employees where year(joinng_date)=2014 and month(joinng_date)=12;


## 4. SQL query to fetch number of employees in every department;

select count(*) from employees group by department_name;

select * from employees where department_name="Development";


## INTERMEDIATE

# 5. SQL Query to print details of the employees who  are also Executives

select employees.first_name, designation.designation from 
employees 
inner join 
designation 
on employees.empid=designation.emp_ref_id
and designation.designation = 'Executive';


select employees.first_name, designation.designation from 
employees 
inner join 
designation 
on employees.empid=designation.emp_ref_id
and designation.designation in ('Executive');

# 6. SWL query to clone a new table from another table;

 # A. This will create a new table employees_clone with the same columns and data as the employees table.
create table cloned_table as
select * from employees;

# B. If you only want to clone the structure (schema) without the data, you can use a WHERE clause that evaluates to false, such as WHERE 1 = 0.

create table cloned_table as
select * from employees
where 1= 0;

create table clone_employee like employees;

# C. Copy the data in cloned table from employees table
INSERT INTO employees_clone
SELECT * FROM employees;


# 7. SQL query to show top n salary of the employees

# A.
select concat(first_name, ' ', last_name) as Employee_name, salary 
from employees order by
salary desc limit 4; 

# B. SQL query to determine the 4th highest salary. Skips the first three rows (which are the highest, second highest, and third highest salaries) and then limits the result to the next row, effectively selecting the fourth-highest salary.

select Salary from employee order by salary desc limit 3 offset 1;

## ( Assignment
## SQL query to determine the 6th highest salary without limits

SELECT Salary
FROM (
    SELECT DISTINCT Salary
    FROM employee
    ORDER BY Salary DESC
) AS distinct_salaries OFFSET 3 ROWS FETCH NEXT 1 ROW ONLY;
 
/*Explanation:
The inner subquery SELECT DISTINCT Salary FROM employee ORDER BY Salary DESC selects all unique salaries and orders them in descending order.
The outer query then fetches the 4th highest salary using the OFFSET 3 ROWS FETCH NEXT 1 ROW ONLY clause, which skips the first 3 rows and fetches the next one.
*/



SELECT Salary
FROM (
    SELECT Salary, ROW_NUMBER() OVER (ORDER BY Salary DESC) AS rnk
    FROM employee
) AS ranked_salaries
WHERE rnk = 4;

/*
Explanation:
The subquery assigns a rank to each salary using the ROW_NUMBER() window function, ordered by Salary in descending order.
The outer query then selects the salary with the rank equal to 4.
*/


SELECT Salary
FROM (
    SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS rnk
    FROM employee
) AS ranked_salaries
WHERE rnk = 4;

/*
Explanation:
The subquery assigns a dense rank to each salary using the DENSE_RANK() window function, ordered by Salary in descending order.
The outer query then selects the salary with the dense rank equal to 4.*/

