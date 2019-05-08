-- Subquery 연습
-- 현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 출력해보세요. 
-- 1) Fai Bale이 근무하는 부서 확인 
select de.dept_no
from employees e, dept_emp de 
where e.emp_no = de.emp_no
and de.to_date='9999-01-01'
and concat(e.first_name, " ", e.last_name) ='Fai Bale';

-- 2) Fai Bale 근무 부서 확인 후 해당 부서에 근무하는 모든 직원 확인
select * 
from employees e, dept_emp de 
where e.emp_no = de.emp_no
and de.to_date = '9999-01-01'
and de.dept_no = 'd004';

-- Subquery
select * 
from employees e, dept_emp de 
where e.emp_no = de.emp_no
and de.to_date = '9999-01-01'
and de.dept_no = 	(select de.dept_no
					from employees e, dept_emp de 
					where e.emp_no = de.emp_no
					and de.to_date='9999-01-01'
					and concat(e.first_name, " ", e.last_name) ='Fai Bale');
                    
				
-- 단일행 연산 
-- 실습문제 1:   현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의  이름, 급여를 나타내세요.
select * 
from employees e, salaries s
where e.emp_no = s.emp_no
and s.to_date = '9999-01-01'
and s.salary < (select avg(salary) from salaries s where s.to_date = '9999-01-01') 
order by s.salary desc;


-- 실습문제 2:   현재 가장적은 평균 급여를 받고 있는 직책에 대해서  평균 급여를 구하세요  
-- 2-1) 
-- 직책별 평균 급여에 대하여 확인. 
select avg(s.salary)
from salaries s, titles t 
where s.emp_no = t.emp_no
and s.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
group by t.title; 

-- 위의 결과를 임시테이블로 볼 생각을 한 뒤 from 절에 넣어주면 쉽게 해결 
select * 
from (select avg(s.salary) as avg_salary 
	from salaries s, titles t 
	where s.emp_no = t.emp_no
	and s.to_date = '9999-01-01'
	and t.to_date = '9999-01-01'
	group by t.title) a;
    
-- 임시테이블에서 뽑힌 데이터 중 최소 값을 선별
select min(avg_salary)
from (select avg(s.salary) as avg_salary 
	from salaries s, titles t 
	where s.emp_no = t.emp_no
	and s.to_date = '9999-01-01'
	and t.to_date = '9999-01-01'
	group by t.title) a; 
    
select avg(s.salary)
from salaries s, titles t 
where s.emp_no = t.emp_no
and s.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
group by t.title 
having round(avg(s.salary)) = round((select min(avg_salary)
from (select avg(s.salary) as avg_salary 
	from salaries s, titles t 
	where s.emp_no = t.emp_no
	and s.to_date = '9999-01-01'
	and t.to_date = '9999-01-01'
	group by t.title) a)); 
    
-- 2-2) TOP-K
-- 임시테이블로 만들어 낸 직급별 연봉 평균에서 order by 를 사용해서 가장 적은 연봉을 가진 직급의 평균 연봉을 찾기 위해 limit으로 1개만 나오도록 하였음. 
select t.title, avg(s.salary) as avg_salary 
from salaries s, titles t 
where s.emp_no = t.emp_no
and s.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
group by t.title 
order by avg_salary asc
limit 0, 1;


-- 다중행 연산 
-- in (not in), 
-- any(in 과 동일), >any, <any, <>any(!=all), <=any, >=any, 
-- all, >all, <all

-- 현재 급여가 50000 이상인 직원 이름 출력
select s.emp_no 
from salaries s 
where s.to_date ='9999-01-01'
and s.salary >='50000';

-- any를 사용하여 문제 해결, where 절에서 subquery
select e.first_name, s.salary
from employees e, salaries s
where e.emp_no = s.emp_no
and s.to_date='9999-01-01'
and (e.emp_no, s.salary) = any (select s.emp_no, s.salary 
								from salaries s 
								where s.to_date ='9999-01-01'
								and s.salary >='50000');
                                
-- from 절에서 subquery 
select  e.first_name, b.salary
from employees e,
	(select s.emp_no, s.salary 
	from salaries s 
	where s.to_date ='9999-01-01'
	and s.salary >='50000') b
where e.emp_no = b.emp_no;

--  각 부서별로 최고 월급을 받는 직원의 이름과 월급을 출력

-- 기본 풀이
select de.dept_no, e.first_name, max(s.salary) as max_salary 
from dept_emp de, salaries s, employees e
where de.emp_no = s.emp_no
and de.emp_no = e.emp_no
and de.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
group by de.dept_no
order by de.dept_no asc;

-- where 절에 subquery 사용 
select  de.dept_no, e.first_name, s.salary 
from dept_emp de, salaries s, employees e
where de.emp_no = s.emp_no
and de.emp_no = e.emp_no
and de.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
and (de.dept_no, s.salary) = any (select de.dept_no, max(s.salary) as max_salary 
								from dept_emp de, salaries s, employees e
								where de.emp_no = s.emp_no
								and de.emp_no = e.emp_no
								and de.to_date = '9999-01-01'
								and s.to_date = '9999-01-01'
								group by de.dept_no)
order by de.dept_no asc;


select e.first_name, de.dept_no, s.salary 
from dept_emp de, salaries s, employees e, 
    (select e.emp_no, de.dept_no, s.salary 
    from dept_emp de, salaries s, employees e
	where de.emp_no = s.emp_no
	and de.emp_no = e.emp_no
	and de.to_date = '9999-01-01'
	and s.to_date = '9999-01-01'
	group by de.dept_no) d
where de.emp_no = s.emp_no
and de.emp_no = e.emp_no
and de.emp_no = d.emp_no
and de.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
group by de.dept_no;