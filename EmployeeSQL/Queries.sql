--------EMPLOYEE DATA: EMPLOYEE_NUMBER, LAST_NAME, FIRST_NAME, SEX, AND SALARY-------------------------------------------------------
SELECT E.EMP_NO, E.LAST_NAME, E.FIRST_NAME, E.SEX, S.SALARY
FROM EMPLOYEES E 
	INNER JOIN SALARIES S ON E.EMP_NO = S.EMP_NO
--LIMIT 10;

--------List first name, last name, and hire date for employees who were hired in 1986-------------------------------------------------------
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '1985-12-31' AND '1987-01-01';  

-------List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name------------
--JOIN 'DEPARTMENTS' WITH 'DEPT_MANAGER' ON DEPT_NO
--JOIN 'DEPT_MANAGER' WITH 'EMPLOYEES' ON EMP_ID

WITH DEPT_CTE AS (
	SELECT D.DEPT_NO, D.DEPT_NAME, DM.EMP_NO
 	FROM DEPARTMENTS D
 		JOIN DEPT_MANAGER DM ON DM.DEPT_NO = D.DEPT_NO
)

SELECT DC.DEPT_NO, DC.DEPT_NAME, DC.EMP_NO, FIRST_NAME, LAST_NAME
FROM EMPLOYEES E
	JOIN DEPT_CTE DC ON DC.EMP_NO = E.EMP_NO;

-------List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B"-------------------------------------------------
SELECT * FROM EMPLOYEES
WHERE FIRST_NAME = 'Hercules' and LAST_NAME LIKE 'B%';

-------List all employees in the Sales department, including their employee number, last name, first name, and department name----------------------------------------
--JOIN 'DEPARTMENTS' WITH 'DEPT_EMP' ON DEPT_ID
--JOIN 'DEPT_EMP' WITH 'EMPLOYEES' ON EMP_ID

WITH DEPT_CTE AS (
	SELECT DEPT_NO, DEPT_NAME
	FROM DEPARTMENTS
	WHERE DEPT_NAME = 'Sales'
)
, EMP_CTE AS (
	SELECT EMP_NO, DE.DEPT_NO, DC.DEPT_NAME
 	FROM DEPT_EMP DE
 		JOIN DEPT_CTE DC ON DC.DEPT_NO = DE.DEPT_NO
)

SELECT E.EMP_NO, FIRST_NAME, LAST_NAME, EC.DEPT_NAME
FROM EMPLOYEES E
	JOIN EMP_CTE EC ON EC.EMP_NO = E.EMP_NO;

-- SELECT COUNT(*)
-- FROM EMPLOYEES E
-- 	JOIN EMP_CTE EC ON EC.EMP_NO = E.EMP_NO;

--------List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name-------------------------
WITH DEPT_CTE AS (
	SELECT DEPT_NO, DEPT_NAME
	FROM DEPARTMENTS
	WHERE DEPT_NAME in ('Sales', 'Development')
)
, EMP_CTE AS (
	SELECT EMP_NO, DE.DEPT_NO, DC.DEPT_NAME
 	FROM DEPT_EMP DE
 		JOIN DEPT_CTE DC ON DC.DEPT_NO = DE.DEPT_NO
)

SELECT E.EMP_NO, FIRST_NAME, LAST_NAME, EC.DEPT_NAME
FROM EMPLOYEES E
	JOIN EMP_CTE EC ON EC.EMP_NO = E.EMP_NO;
	
	
----------In descending order, list the frequency count of employee last names, i.e., how many employees share each last name---------------------------------------------
SELECT LAST_NAME, COUNT(*) 
FROM EMPLOYEES
GROUP BY LAST_NAME
ORDER BY count(*) DESC;

