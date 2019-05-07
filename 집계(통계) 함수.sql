-- 집계(통계) 함수

-- Group by 절이 있는 경우에는 select 문에는 group by 에 명시된 컬럼만 가능 
select emp_no, avg(salary) 
from salaries 
group by emp_no;

-- having 절이 작동 
select emp_no, avg(salary) 
from salaries 
where from_date like '1985%'
group by emp_no;

-- 동작 순서, select from where group by, having 