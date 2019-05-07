-- ���̺� ����(JOIN) SQL �����Դϴ�.
-- ���� 1. ���� �޿��� ���� �������� ������ ���, �̸�, �׸��� ������ ��� �Ͻÿ�.
select e.emp_no '���', concat(e.first_name, " ", e.last_name) '�̸�', s.salary '����' 
from employees e, salaries s where e.emp_no = s.emp_no and s.to_date ='9999-01-01' order by s.salary desc;

-- ����2. ��ü ����� ���, �̸�, ���� ��å�� �̸� ������ ����ϼ���.
select e.emp_no, concat(e.first_name, " ", e.last_name) '�̸�', t.title '��å' from employees e, titles t
where e.emp_no = t.emp_no and t.to_date = '9999-01-01' 
order by e.first_name, e.last_name;

-- ����3. ��ü ����� ���, �̸�, ���� �μ��� �̸� ������ ����ϼ���..
select e.emp_no '���', concat(e.first_name, " ", e.last_name) '�̸�', d.dept_name 
from employees e, dept_emp de, departments d
where e.emp_no = de.emp_no and d.dept_no = de.dept_no and de.to_date = '9999-01-01' 
order by e.first_name, e.last_name;

-- ����4. ��ü ����� ���, �̸�, ����, ��å, �μ��� ��� �̸� ������ ����մϴ�.
select e.emp_no '���', concat(e.first_name, " ", e.last_name) '�̸�', s.salary '����' , t.title '��å', d.dept_name '�μ�'
from employees e, titles t, salaries s, dept_emp de, departments d
where e.emp_no = t.emp_no 
and e.emp_no = s.emp_no
and e.emp_no = de.emp_no
and de.dept_no = d.dept_no
and s.to_date = '9999-01-01'
and de.to_date = '9999-01-01'
and t.to_date = '9999-01-01'
order by e.first_name, e.last_name;

-- ����5. ��Technique Leader���� ��å���� ���ſ� �ٹ��� ���� �ִ� ��� ����� ����� �̸��� ����ϼ���. (���� ��Technique Leader���� ��å(���� �ٹ��ϴ� ����� ������� �ʽ��ϴ�.) �̸��� first_name�� last_name�� ���� ��� �մϴ�.
select e.emp_no '���', concat(e.first_name, " ", e.last_name) '�̸�' 
from titles t, employees e 
where t.title = 'Technique Leader' 
and e.emp_no = t.emp_no
and not to_date='9999-01-01';

-- ����6. ���� �̸�(last_name) �߿��� S(�빮��)�� �����ϴ� �������� �̸�, �μ���, ��å�� ��ȸ�ϼ���.
select e.last_name, d.dept_name, t.title from employees e, dept_emp de, departments d, titles t 
where e.emp_no = de.emp_no
and e.emp_no = t.emp_no
and d.dept_no = de.dept_no
and t.to_date = '9999-01-01' 
and de.to_date = '9999-01-01'
and e.last_name like 'S%';

-- ����7. ����, ��å�� Engineer�� ��� �߿��� ���� �޿��� 40000 �̻��� ����� �޿��� ū ������� ����ϼ���.

-- ����8. ���� �޿��� 50000�� �Ѵ� ��å�� ��å, �޿��� �޿��� ū ������� ����Ͻÿ�

-- ����9. ����, �μ��� ��� ������ ������ ū �μ� ������� ����ϼ���.

-- ����10. ����, ��å�� ��� ������ ������ ū ��å ������� ����ϼ���.