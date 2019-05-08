-- 서브쿼리(SUBQUERY) SQL 문제입니다.
-- 문제1. 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select count(emp_no) 
from salaries s
where s.to_date = '9999-01-01'
and salary > (select avg(salary) 
			from salaries s
			where s.to_date='9999-01-01');

-- 문제2. 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
select e.emp_no, e.first_name, d.dept_name, s.salary
from employees e, departments d, dept_emp de, salaries s 
where e.emp_no = de.emp_no
and e.emp_no = s.emp_no
and de.dept_no = d.dept_no
and s.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
and (de.dept_no, s.salary) in 
						(select de.dept_no, max(s.salary)
						from salaries s, employees e, dept_emp de 
						where s.to_date = '9999-01-01'
						and de.to_date = '9999-01-01'
						and s.emp_no = e.emp_no
						and e.emp_no = de.emp_no
						group by de.dept_no);

-- 문제3. 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
select e.emp_no, e.first_name, s.salary
from employees e, salaries s, dept_emp de,
	(select de.dept_no, avg(s.salary) as avg_salary
	from salaries s, employees e, dept_emp de
	where s.emp_no = e.emp_no
	and e.emp_no = de.emp_no
	and s.to_date = '9999-01-01'
	and de.to_date = '9999-01-01'
	group by de.dept_no) st
where e.emp_no = s.emp_no
and e.emp_no = de.emp_no
and s.to_date = '9999-01-01'
and de.to_date = '9999-01-01' 
and de.dept_no = st.dept_no
and s.salary > st.avg_salary
order by s.salary asc;

-- 문제4. 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
select e.emp_no, e.first_name, cur_dm.부서장 as 매니저이름, d.dept_name
from employees e, dept_emp de, departments d,
	(select dm.dept_no as dept_no, e.first_name as 부서장 
    from dept_manager dm, employees e
    where dm.to_date='9999-01-01'
    and e.emp_no = dm.emp_no) cur_dm
where e.emp_no = de.emp_no
and de.dept_no = d.dept_no 
and de.dept_no = cur_dm.dept_no
and e.emp_no = cur_dm.부서장;



-- 문제5. 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select e.emp_no, e.first_name, t.title, s.salary, v.평균연봉최상위부서
from employees e, dept_emp de, titles t, salaries s ,
	(select max(avg_salaries.avg_salary) as 가장높은평균연봉, dept_no as 평균연봉최상위부서
	from 
		(select dept_no, avg(s.salary) as avg_salary
		from salaries s, dept_emp de 
		where s.emp_no = de.emp_no
		and s.to_date = '9999-01-01'
		and de.to_date = '9999-01-01'
		group by de.dept_no) avg_salaries) v
where e.emp_no = de.emp_no 
and e.emp_no = t.emp_no
and e.emp_no = s.emp_no 
and de.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
and de.dept_no = v.평균연봉최상위부서
order by s.salary desc;

-- 문제6. 평균 연봉이 가장 높은 부서는? 
select d.dept_name
from departments d,
		 	(select v.dept_no as 최고평균연봉부서번호, max(v.avg_salary)
			from 
				(select de.dept_no, avg(s.salary) as avg_salary
				from dept_emp de, salaries s
				where de.emp_no = s.emp_no
				and de.to_date = '9999-01-01'
				and s.to_date = '9999-01-01'
				group by dept_no) v ) vv
where d.dept_no = 최고평균연봉부서번호;

-- 문제7. 평균 연봉이 가장 높은 직책?
select max(avg_salary), tttitle
from 
	(select avg(s.salary) as avg_salary, t.title as tttitle
	from titles t, salaries s
	where t.emp_no = s.emp_no
	and t.to_date = '9999-01-01'
	and s.to_date = '9999-01-01'
	group by t.title) v
where v.avg_salary = 
	(select max(avg_salary)
    from 
	(select avg(s.salary) as avg_salary, t.title as tttitle
		from titles t, salaries s
		where t.emp_no = s.emp_no
		and t.to_date = '9999-01-01'
		and s.to_date = '9999-01-01'
		group by t.title)v);

-- 문제8. 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은? 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
select d.dept_name, e.first_name, s.salary, 매니저이름, 매니저연봉
from employees e, salaries s, departments d, dept_emp de,
	(select s.salary as 매니저연봉, dm.dept_no as 매니저부서, dm.emp_no as 매니저사원번호, e.first_name as 매니저이름
	from salaries s, dept_manager dm, employees e 
	where s.emp_no = dm.emp_no
    and e.emp_no = s.emp_no
	and s.to_date = '9999-01-01'
	and dm.to_date = '9999-01-01') 매니저정보
where e.emp_no = s.emp_no
and e.emp_no = de.emp_no
and d.dept_no = de.dept_no
and de.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
and s.salary > 매니저정보.매니저연봉
and d.dept_no = 매니저정보.매니저부서;