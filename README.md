# Pewlett-Hackard-Analysis

Pewlett Hackard, is a  large company hosting several thousands of employees, to plan for the future and avoid surprising jobs vacancies. Pewlett Hackard requested an analysis on employees who are going to be retiring in the next few coming years and the number of positions that will need to be filled. Another analysis was conducted to generate a list for a retirees to be mentors for new and young employees.


### Software 
QuickDBD; 
pgAdmin4

### Image of ERD from Quick DBD

![erd](https://github.com/Samira786/Pewlett-Hackard-Analysis/blob/master/QuickDBD-export%20.png)

### Number of employees retiring

A retirement_title query was created to combine three tables (employee, salaries, and title) using INNER JOIN. This created a chart to show employee information into a table.

![retiring](https://github.com/Samira786/Pewlett-Hackard-Analysis/blob/master/retiree%20list.png)

### Count Query

![count](https://github.com/Samira786/Pewlett-Hackard-Analysis/blob/master/count%20query.png)

### Mentors

A mentor table was created combining two tables with the following information: Employee number, First and last name, Title, from_date and to_date.

Considering the birth date needs to be between January 1, 1965 and December 31, 1965.

![mentor](https://github.com/Samira786/Pewlett-Hackard-Analysis/blob/master/mentor.png)

### Conclusion

By using SQL, multiple tables were combined to help plan for the future for Pewlett Hackard.


