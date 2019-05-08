-- ��������(SUBQUERY) SQL �����Դϴ�.
-- ����1. ���� ��� �������� ���� ������ �޴� ������ �� ���̳� �ֽ��ϱ�?
select count(emp_no) 
from salaries s
where s.to_date = '9999-01-01'
and salary > (select avg(salary) 
			from salaries s
			where s.to_date='9999-01-01');

-- ����2. ����, �� �μ����� �ְ��� �޿��� �޴� ����� ���, �̸�, �μ� ������ ��ȸ�ϼ���. �� ��ȸ����� ������ ������������ ���ĵǾ� ��Ÿ���� �մϴ�. 
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

-- ����3. ����, �ڽ��� �μ� ��� �޿����� ����(salary)�� ���� ����� ���, �̸��� ������ ��ȸ�ϼ��� 
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

-- ����4. ����, ������� ���, �̸�, �Ŵ��� �̸�, �μ� �̸����� ����� ������.
select e.emp_no, e.first_name, cur_dm.�μ��� as �Ŵ����̸�, d.dept_name
from employees e, dept_emp de, departments d,
	(select dm.dept_no as dept_no, e.first_name as �μ��� 
    from dept_manager dm, employees e
    where dm.to_date='9999-01-01'
    and e.emp_no = dm.emp_no) cur_dm
where e.emp_no = de.emp_no
and de.dept_no = d.dept_no 
and de.dept_no = cur_dm.dept_no
and e.emp_no = cur_dm.�μ���;



-- ����5. ����, ��տ����� ���� ���� �μ��� ������� ���, �̸�, ��å, ������ ��ȸ�ϰ� ���� ������ ����ϼ���.
select e.emp_no, e.first_name, t.title, s.salary, v.��տ����ֻ����μ�
from employees e, dept_emp de, titles t, salaries s ,
	(select max(avg_salaries.avg_salary) as ���������տ���, dept_no as ��տ����ֻ����μ�
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
and de.dept_no = v.��տ����ֻ����μ�
order by s.salary desc;

-- ����6. ��� ������ ���� ���� �μ���? 
select d.dept_name
from departments d,
		 	(select v.dept_no as �ְ���տ����μ���ȣ, max(v.avg_salary)
			from 
				(select de.dept_no, avg(s.salary) as avg_salary
				from dept_emp de, salaries s
				where de.emp_no = s.emp_no
				and de.to_date = '9999-01-01'
				and s.to_date = '9999-01-01'
				group by dept_no) v ) vv
where d.dept_no = �ְ���տ����μ���ȣ;

-- ����7. ��� ������ ���� ���� ��å?
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

-- ����8. ���� �ڽ��� �Ŵ������� ���� ������ �ް� �ִ� ������? �μ��̸�, ����̸�, ����, �Ŵ��� �̸�, �޴��� ���� ������ ����մϴ�.
select d.dept_name, e.first_name, s.salary, �Ŵ����̸�, �Ŵ�������
from employees e, salaries s, departments d, dept_emp de,
	(select s.salary as �Ŵ�������, dm.dept_no as �Ŵ����μ�, dm.emp_no as �Ŵ��������ȣ, e.first_name as �Ŵ����̸�
	from salaries s, dept_manager dm, employees e 
	where s.emp_no = dm.emp_no
    and e.emp_no = s.emp_no
	and s.to_date = '9999-01-01'
	and dm.to_date = '9999-01-01') �Ŵ�������
where e.emp_no = s.emp_no
and e.emp_no = de.emp_no
and d.dept_no = de.dept_no
and de.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
and s.salary > �Ŵ�������.�Ŵ�������
and d.dept_no = �Ŵ�������.�Ŵ����μ�;