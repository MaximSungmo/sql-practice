-- �⺻ SQL �����Դϴ�. --
-- ����1.����� 10944�� ����� �̸���(��ü �̸�)
select concat(first_name, last_name) '��ü �̸�' from employees where emp_no='10944';  

-- ����2. ��ü������ ���� ������ ��ȸ�ϼ���. ���� ���Ӻ��� ����� �ǵ��� �ϼ���. ����� �̸�, ����, �Ի��� �����̰� ���̸���, ��������, ���Ի��Ϸ� �÷� �̸��� ��ü�� ������.
select concat(first_name, last_name) '�̸�', gender '����', hire_date '�Ի���' from employees order by first_name, gender, hire_date;

-- ����3.�������� �������� �� �� �� ���̳� �ֳ���?
select gender ,count(emp_no) from employees group by gender;

-- ����4.���� �ٹ��ϰ� �ִ� ���� ���� �� ���Դϱ�? (salaries ���̺��� ����մϴ�.) 
select count(emp_no) from salaries where to_date = '9999-01-01';

-- ����5.�μ��� �� �� ���� �ֳ���?
select distinct count(dept_name) from departments; 

-- ����6. ���� �μ� �Ŵ����� �� ���̳� �ֳ���?(���� �ų����� ����)
select count(*) from dept_manager where to_date = '9999-01-01';
select count(*) from titles where title='Manager' and to_date='9999-01-01';

-- ����7. ��ü �μ��� ����Ϸ��� �մϴ�. ������ �μ��̸��� �� ������� ����� ������.
select distinct dept_name from departments order by length(dept_name) desc;

-- ����8. ���� �޿��� 120,000�̻� �޴� ����� �� ���̳� �ֽ��ϱ�?
select count(emp_no) from salaries where salary>=120000 and to_date='9999-01-01';

-- ����9. � ��å���� �ֳ���? �ߺ� ���� �̸��� �� ������� ����� ������.
select distinct title from titles order by length(title) desc;
 
-- ����10. ���� Enginner ��å�� ����� �� �� ���Դϱ�?
select count(emp_no) from titles where title='Engineer';

-- ����11. ����� 13250(Zeydy)�� ������ ��å ���� ��Ȳ�� �ð������� ����غ�����.
select e.emp_no, t.title, t.to_date from employees e, titles t where e.emp_no = t.emp_no and e.emp_no='13250' order by t.to_date asc; 
