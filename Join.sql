select * from salaries where emp_no = 11004;

-- 예제 1 : 각 사원별로 평균연봉 출력

-- 그룹 절에 참여하고 있는 절은 select에서 검색하여도 된다. 
select emp_no, avg(salary) from salaries group by emp_no order by avg(salary) desc;

select * from titles;
select * from titles where title='Manager';

select * from titles order by emp_no, from_date;

select emp_no, avg(salary) as avg_salary from salaries group by emp_no having avg_salary >='50000';

-- 직책별 평균 연봉과 인원수, 직책별 인원이 100명 이상
select title, count(emp_no) from titles where to_date = '9999-01-01' group by title having count(emp_no) >= 100;

select * from employees;
select * from titles;
select * from salaries;
select * from departments;


select titles.title, avg(salaries.salary) from titles, salaries where titles.title='Engineer' and salaries.emp_no=titles.emp_no group by emp_no;

select salaries.emp_no, salaries.salary, titles.title from salaries, titles where salaries.to_date = '9999-01-01' and titles.emp_no = salaries.emp_no;

select titles.title, avg(salaries.salary) as avg_salary from salaries, titles
where salaries.emp_no = titles.emp_no 
	and salaries.to_date='9999-01-01' 
	and titles.to_date='9999-01-01'
    and (titles.title='Engineer' or titles.title='Senior Engineer')
group by titles.title;


select * from departments;
select distinct title from titles;
select * from dept_emp;

-- 예제6: 현재 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균급여를 구하세요.
SELECT 
    de.dept_no, d.dept_name, AVG(s.salary)
FROM
    salaries s,
    titles t,
    dept_emp de,
    departments d
WHERE
    s.emp_no = t.emp_no
        AND s.emp_no = de.emp_no
        AND s.to_date = '9999-01-01'
        AND t.to_date = '9999-01-01'
        AND t.title = 'Engineer'
        and d.dept_no = de.dept_no
GROUP BY de.dept_no;

-- 예제7: 현재 직책별로 급여의 총합을 구하되 Engineer직책은 제외하세요. 단, 총합이 2,000,000,000이상인 직책만 나타내며 급여총합에 대해서 내림차순(DESC)로 정렬하세요.
SELECT 
    title, SUM(salary)
FROM
    salaries s,
    titles t
WHERE
    s.emp_no = t.emp_no
        AND s.to_date = '9999-01-01'
        AND t.to_date = '9999-01-01'
GROUP BY t.title
HAVING SUM(salary) >= 2000000000
ORDER BY SUM(salary) DESC;


-- ANSI/ISO SQL 1999를 따르는 JOIN 
-- 예제 10 : employees 테이블과 titles 테이블를 join하여 직원의 이름과 직책을 출력하되 여성 엔지니어만 출력하세요.
SELECT 
    e.first_name, t.title, e.gender
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    e.gender = 'F'; 
 
-- Natural join
SELECT 
    e.first_name, t.title, e.gender
FROM
    employees e
        NATURAL JOIN
    titles t
WHERE
    e.gender = 'F'; 
 
 
 -- join ~ using
SELECT 
    e.first_name, t.title, e.gender
FROM
    employees e
        JOIN
    titles t USING (emp_no)
WHERE
    e.gender = 'F'; 


-- 실습문제 1:  현재 회사 상황을 반영한 직원별 근무부서를  사번, 직원 전체이름, 근무부서 형태로 출력해 보세요.
SELECT 
    e.emp_no, e.first_name, d.dept_name
FROM
    dept_emp de,
    employees e,
    departments d
WHERE
    de.emp_no = e.emp_no
        AND de.dept_no = d.dept_no
        AND de.to_date = '9999-01-01';
        
SELECT 
    e.emp_no, e.first_name, d.dept_name
FROM
    dept_emp de
        LEFT JOIN
    employees e ON de.emp_no = e.emp_no
        JOIN
    departments d ON de.dept_no = d.dept_no
WHERE
    de.to_date = '9999-01-01';

