/***************
���ϸ� :  Or11Join.sql
���̺� ����
���� : �ΰ� �̻��� ���̺��� ���ÿ� �����Ͽ� �����͸� �����;� �Ҷ�
    ����ϴ� SQL��
****************/
-- HR�������� �����մϴ�.

/*
1] inner join(��������)
    - ���� ���� ���Ǵ� ���ι����� ���̺��� ���������� ��� �����ϴ�
    ���ڵ带 �˻��Ҷ� ����Ѵ�.
    - �Ϲ������� �⺻Ű(primary key)�� �ܷ�Ű(foreign key)�� ����Ͽ�
    join�ϴ� ��찡 ��κ��̴�.
    - �ΰ��� ���̺� ������ �̸��� �÷��� �����ϸ� "���̺��.�÷���"
    ���·� ����ؾ� �Ѵ�.
    - ���̺��� ��Ī�� ����ϸ� "��Ī.�÷���"���·� ����� �� �ִ�.
    
����1(ǥ�ع��)
    select �÷�1, �÷�2,...
    from ���̺�1 inner join ���̺�2
        on ���̺�1.�⺻Ű�÷� = ���̺�2.�ܷ�Ű�÷�
    where ����1 and ����2 ...;
*/

/*
�ó�����] ������̺�� �μ����̺��� �����Ͽ� �� ������ ��μ�����
    �ٹ��ϴ��� ����Ͻÿ�. ��, ǥ�ع������ �ۼ��Ͻÿ�.
    ��°�� : ������̵�, �̸�1, �̸�2, �̸���, �μ���ȣ, �μ���
*/
desc employees;
desc departments;
-- ù��° �������� ������ �߻��Ѵ�.
/*
ORA-00918 : ���� ���ǰ� �ָ��մϴ�.
00918.000000 - "coloumn ambiguously defined"
department_id�� ������ ���� ���̺� �����ϴ� �÷��̹Ƿ�
� ���̺��� ������ ������� �����ؾ� �Ѵ�.
*/
select
	employee_id, first_name, last_name, email, 
    department_id, department_name
from
	employees inner join departments
on
	employees.department_id=departments.department_id;
-- ���� ���ǰ� �ָ��� ��� �÷��տ� ���̺���� �߰��Ѵ�.
select
	employee_id, first_name, last_name, email, 
    employees.department_id, department_name
from
	employees inner join departments
on
	employees.department_id=departments.department_id;

-- as(�˸��ƽ�)�� ���� ���̺� ��Ī�� �ο��Ͽ� �������� ����ȭ�� �� �ִ�.
select
	employee_id, first_name, last_name, email, 
    Emp.department_id, department_name
from
	employees Emp inner join departments Dep
on
	Emp.department_id=Dep.department_id;
/*
    ���� ��������� �Ҽӵ� �μ��� ���� 1���� ������ ������ 106���� ���ڵ尡
    ����ȴ�. ��, inner join �� ������ ���̺��� ���� ��� �����Ǵ� ���ڵ常 
    �������� �ȴ�.
*/

-- 3�� �̻��� ���̺� �����ϱ�
/*
�ó�����] seattle(�þ�Ʋ)�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������
    ����ϴ� �������� �ۼ��Ͻÿ�. �� ǥ�ع������ �ۼ��Ͻÿ�.
    ��°��] ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�,
        ��������, �ٹ�����
    �� ��°���� ���� ���̺� �����Ѵ�.
    ������̺� : ����̸�, �̸���, �μ����̵�, ������ ���̵�
    �μ����̺� : �μ����̵�(����), �μ���, �����Ϸù�ȣ(����)
    ���������̺� : ��������, ���������̵�(����)
    �������̺� : �ٹ��μ�, �����Ϸù�ȣ(����)
*/
-- 1.���� ���̺��� ���� ���ڵ� Ȯ���ϱ� -> �����Ϸù�ȣ 1700Ȯ��
select * from locations where lower(city)='seattle';
-- 2.���� �Ϸù�ȣ�� ���� �μ� ���̺��� ����� Ȯ���ϱ� ->21�� �μ� Ȯ��
select * from departments where location_id=1700;
-- 3.�μ��Ϸù�ȣ�� ���� ������̺��� ���ڵ� Ȯ���ϱ� -> 6�� Ȯ���ϱ�
select * from employees where department_id=30;
-- 4.������ �������� Ȯ���ϱ�
select * from jobs where job_id='PU_MAN';
select * from jobs where job_id='PU_CLERK';
-- 5.join ������ �ۼ�

select
    first_name, last_name, email, D.department_id, 
    department_name, E.job_id, job_title, city, state_province
 from locations L
    inner join departments D on L.location_id=D.location_id
    inner join employees E on D.department_id=E.department_id
    inner join jobs J on E.job_id=J.job_id
 where 
    lower(city)='seattle';

/*
����2] ����Ŭ���
    select �÷�1, �÷�2,...
    from ���̺�1, ���̺�2,...
    where
        ���̺�1.�⺻Ű�÷�=���̺�2.�ܷ�Ű�÷�
        and ����1 and ����2 ...;
*/
/*
�ó�����] ������̺�� �μ����̺��� �����Ͽ� �� ������ ����μ�����
    �ٹ��ϴ��� ����Ͻÿ�. �� ����Ŭ������� �ۼ��Ͻÿ�.
    ��°�� : ������̵�, �̸�1, �̸�2, �̸���, �μ���ȣ, �μ���
*/
select
    employee_id, first_name, last_name, email,
    E.department_id, department_name
 from employees E, departments D
 where
    E.department_id=D.department_id;
    
/*
�ó�����] seattle(�þ�Ʋ)�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������
    ����ϴ� �������� �ۼ��Ͻÿ�. �� ����Ŭ������� �ۼ��Ͻÿ�.
    ��°��] ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�,
        ��������, �ٹ�����
    �� ��°���� ���� ���̺� �����Ѵ�.
    ������̺� : ����̸�, �̸���, �μ����̵�, ������ ���̵�
    �μ����̺� : �μ����̵�(����), �μ���, �����Ϸù�ȣ(����)
    ���������̺� : ��������, ���������̵�(����)
    �������̺� : �ٹ��μ�, �����Ϸù�ȣ(����)
*/
select
    first_name, last_name, email, D.department_id, 
    department_name, E.job_id, job_title, city, state_province
 from locations L, departments D, employees E, jobs J
 where 
    L.location_id=D.location_id and
    D.department_id=E.department_id and
    E.job_id=J.job_id and city=initcap('seattle');

/*
2] outer join (�ܺ�����)
    outer join�� inner join���� �޸� �� ���̺� ���������� ��Ȯ�� ��ġ����
    �ʾƵ� ������ �Ǵ� ���̺��� ���ڵ带 �����ϴ� join����̴�.
    outer join�� ����Ҷ��� �ݵ�� outer ���� ������ �Ǵ� ���̺��� �����ϰ�
    �������� �ۼ��ؾ��Ѵ�.
    -> left(�������̺�), right(������ ���̺�), full(�������̺�)
    
����1(ǥ�ع��)
    select �÷�1, �÷�2, ...
    form ���̺�1
        left[right, full] outer join ���̺�2
            on ���̺�1.�⺻Ű=���̺�2.����Ű
    where ����1 and ����2 or ����3;
*/
/*
�ó�����] ��ü������ �����ȣ, �̸�, �μ����̵�, �μ���, ������
    �ܺ�����(left)�� ���� ����Ͻÿ�.
*/
-- �������� ���� �������ΰ��� �ٸ��� 107���� ����ȴ�.�μ��� �������� ����
-- ������� ����Ǳ� �����ε�, �� ��� �μ��ʿ� ���ڵ尡 �����Ƿ� null�� 
-- ��µȴ�.
select
    employee_id, first_name, E.department_id, department_name, city
 from employees E
    left outer join departments D on E.department_id=D.department_id
    left outer join locations L on D.location_id=L.location_id;

/*
����2 (����Ŭ���)
    select �÷�1, �÷�2, ...
    from ���̺�1, ���̺�2
    where
        ���̺�1.�⺻Ű=���̺�2.����Ű (+)
        and ����1 or ����2;��

=> ����Ŭ ������� ����ÿ��� outer join �������� (+)�� �ٿ��ش�.
=> ���� ��� ���� ���̺��� ������ �ȴ�.
=> ������ �Ǵ� ���̺��� �����Ҷ��� ���̺��� ��ġ�� �İ��ش�. (+)��
    �ű��� �ʴ´�.
*/

/*
�ó�����] ��ü������ �����ȣ, �̸�, �μ����̵�, �μ���, ������
    �ܺ�����(left)�� ���� ����Ͻÿ�. �� ����Ŭ������� �ۼ��Ͻÿ�.
*/
select
    employee_id, first_name, E.department_id, department_name, city
 from employees E, departments D, locations L 
 where 
    E.department_id=D.department_id (+)
    and D.location_id=L.location_id (+);

/*
��������] 2007�⿡ �Ի��� ����� ��ȸ�Ͻÿ�. ��, �μ��� ��ġ���� ����
������ ��� <�μ�����>���� ����Ͻÿ�. ��, ǥ�ع������ �ۼ��Ͻÿ�.
����׸� : ���, �̸�, ��, �μ���
*/
-- �켱 ����� ���ڵ� Ȯ��
select first_name, hire_date, to_char(hire_date, 'yyyy') from employees;
-- 2007�⿡ �Ի��� ����� ����
-- ���1 : like�� �̿��Ͽ� 07�� �����ϴ� ���ڵ带 �����Ѵ�.
select first_name, hire_date from employees where hire_date like '07%';
-- ���2 : to_char()�� ���� ��¥������ ���� �� ���ڵ带 ����Ѵ�.
select first_name, hire_date from employees 
    where to_char(hire_date, 'yyyy')='2007';
-- �ܺ�����(ǥ�ع��)���� ��� Ȯ��
-- nvl(�÷���, '������ ��') : null ���� ����Ŀ�� Ư���� ������ �������ش�.
select
    employee_id, first_name, last_name, nvl(department_name, '<�μ�����>')
 from employees E
    left outer join departments D on E.department_id=D.department_id
 where to_char(hire_date, 'yyyy')='2007';

