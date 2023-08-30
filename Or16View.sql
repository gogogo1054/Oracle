/***************                                                                
                                                                                
���ϸ� :  Or16View.sql
���� : View (��)�� ���̺��κ��� ������ ������ ���̺��� ���������δ� �������� 
�ʰ� ���������� �����ϴ� ���̺��̴�.
****************/
-- HR ����

/*
���� ����
����]
create [or replace] view ���̸�[(�÷�1, �÷�2, ... )]
as select * from ���̺��� where ���� 
Ȥ�� join���� ������
*/

/*
�ó�����] hr������ ������̺����� �������� ST_CLERK�� ��� ������
��ȸ�� �� �ִ� View�� �����Ͻÿ�.
����׸� : ������̵�, �̸�, �������̵�, �Ի���, �μ����̵�
*/

-- 1. ���Ǵ�� select�ϱ�
select employee_id, first_name, job_id, hire_date, department_id
from employees where job_id = 'ST_CLERK'; -- ��� 20�� ���

-- 2. �� �����ϱ�
create view view_employees
as select employee_id, first_name, job_id, hire_date, department_id
from employees where job_id = 'ST_CLERK';

-- 3. �� �����ϱ� ( HR������ ���� view ���̺��� ������ - �����ص� HR�� ����x )
select * from view_employees;

-- 4. �����ͻ������� �� Ȯ���ϱ�
-- ������ ����� �������� �״�� ����Ǵ°� �� �� �ִ�.
select * from user_views;

/*
�� �����ϱ�
�� ���� ���忡 or replace�� �߰��ϸ� �ȴ�.
�ش� �䰡 �����ϸ� �����ǰ�, �������� ������ ���Ӱ� �����ȴ�.
���� ó�� �並 �����Ҷ����� ����ص� �����ϴ�.
*/

/*
�ó�����] �տ��� ������ �並 ������ ���� �����Ͻÿ�
�����÷��� employee_id, first_name, job_id, hire_date, department_id��
id, fname, jobid, hdate, deptid�� �����Ͽ� �並 �����Ͻÿ�.
*/
create or replace view view_employees ( id, fname, jobid, hdate, deptid ) as
select employee_id, first_name, job_id, hire_date, department_id
from employees where job_id = 'ST_CLERK';

-- �� �����ؼ� Ȯ��
select * from view_employees;

/*
����] ������ ������ view_employees �並 �Ʒ� ���ǿ� �°� �����Ͻÿ�.
�������̵� ST_MAN�� ����� �����ȣ, �̸�, �̸���, �Ŵ������̵�
��ȸ�Ҽ��ֵ��� �����Ͻÿ�.
���� �÷����� e_id, name, email, m_id�� �����Ѵ�. ��, �̸��� first_name��
last_name�� ����� ���·� ����Ͻÿ�.
*/

-- ������ ���Ǵ�� select�� �ۼ�
select employee_id, concat(concat(first_name, ' '), last_name), email,
manager_id from employees where job_id = 'ST_MAN';

-- �� ������ �÷��� ��Ī�� �ο��Ѵ�.
create or replace view view_employees (e_id, name, email, m_id) as
select employee_id, concat(concat(first_name, ' '), last_name), email,
manager_id from employees where job_id = 'ST_MAN';

-- �並 ���ؼ� ��� Ȯ��
select * from view_employees;

/*
����] �����ȣ, �̸�, ������ ����Ͽ� ����ϴ� �並 �����Ͻÿ�.
�÷��� �̸��� emp_id, l_name, annul_sal�� �����Ͻÿ�.
������ѽ� -> (�޿�+(�޿�*���ʽ���))*12
�� �̸� : v_emp_salary
��, ������ ���ڸ����� ,(�޸�)�� ���ԵǾ�� �Ѵ�.
*/
-- ������ ���Ǵ�� select�� �ۼ�
select
employee_id, last_name,
rtrim(to_char((salary+(salary*nvl(commission_pct,0)))*12, '$999,000')) "����"
from employees order by "����"; 

-- �� ������ �÷��� ��Ī�� �ο��Ѵ�.
create or replace view v_emp_salary (emp_id, l_name, annul_sal)
as select employee_id, last_name,
rtrim(to_char((salary+(salary*nvl(commission_pct,0)))*12, '$999,000')) "����"
from employees order by "����";

-- �並 ���ؼ� ��� Ȯ��
select * from v_emp_salary;

/*
������ ���� View ����
�ó�����] ������̺��� �μ����̺�, �������̺��� �����Ͽ� ���� ���ǿ� �´�
�並 �����Ͻÿ�.
����׸� : �����ȣ, ��ü�̸�, �μ���ȣ, �μ���, �Ի�����, ������
�� �̸� : v_emp_join
�� �÷� : empid, fullname, deptid, deptname, hdate, locname
�÷��� ������� :  fullname => first_name + last_name
                   hdate => 0000��00��00��
                   locname => XXX���� XXX ( ex) Texas�� Southlake)
*/

-- ������ ���ǿ� �ش��ϴ� select�� �ۼ�
select employee_id, first_name || ' ' || last_name, department_id, 
department_name, to_char(hire_date, 'yyyy"��"mm"��"dd"��"'),
state_province ||'�� '||city
from employees
inner join departments using (department_id)
inner join locations using(location_id);

-- �� ������ �÷��� ��Ī�� �ο��Ѵ�.
create or replace view v_emp_join 
(empid, fullname, deptid, deptname, hdate, locname) as
select employee_id, first_name || ' ' || last_name, department_id, 
department_name, to_char(hire_date, 'yyyy"��"mm"��"dd"��"'),
state_province ||'�� '||city as "����"
from employees
inner join departments using (department_id)
inner join locations using(location_id)
order by "����";

-- �並 ���ؼ� ��� Ȯ��
select * from v_emp_join;

