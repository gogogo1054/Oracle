/***************                                                                -- A4 ����
                                                                                -- ����Ѱ�
���ϸ� :  Or09DDL.sql
DDL : ������ ���Ǿ�(Data Definition Language)
���� : ���̺�, ��� ���� ��ü�� ���� �� �����ϴ� �������� ���Ѵ�. 
****************/
-- system ����

-- ���ο� ����� ������ ������ �� ���ӱ��Ѱ� ���̺� ���� ���ѵ��� �ο��Ѵ�.

-- Oracle 21c ���ĺ��ʹ� ���� ������ �ش� ����� �����ؾ��մϴ�. (C## ��������)
alter session set "_ORACLE_SCRIPT" = true;
-- study������ �����ϰ�, �н����带 1234�� �ο��Ѵ�.
create user study identified by 1234;
-- ������ ������ �� ���� ������ �ο��Ѵ�.
grant connect, resource to study;
--------------------------------------------------------------------------------

-- study ������ ������ �� �ǽ��� �����մϴ�.

-- ��� ������ �����ϴ� ������ ���̺�
select * from dual;

-- �ش� ������ ������ ���̺��� ����� ������ �ý��� ���̺�
-- �̿� ���� ���̺��� "�����ͻ���"�̶�� �Ѵ�.
select * from tab;

/*
���̺� �����ϱ�
����] create table ���̺�� (
        �÷���1 �ڷ���,
        �÷���2 �ڷ���,
        .....
        primary key(�÷���) ���� �������� �߰�
);
*/

create table tb_member (
    idx number(10), -- 10�ڸ��� ������ ǥ��
    userid varchar2(30), -- ���������� 30byte ���尡��
    passwd varchar2(50), -- ���������� 50byte ���尡��
    username varchar2(30), -- ���������� 30byte ���尡��
    mileage number(7,2) -- 7�ڸ��� �Ǽ��� ǥ�� ( �Ҽ��� 2�ڸ����� )
);

-- ���� ������ ������ ������ ���̺� ����� Ȯ���մϴ�.
select * from tab;

-- ���̺��� ����(schema -��Ű��) Ȯ��. �÷���, �ڷ���, ũ�� ���� Ȯ���Ѵ�.
desc tb_member;

/*
���� ������ ���̺� ���ο� �÷� �߰��ϱ�
=> tb_member ���̺� email �÷��� �߰��Ͻÿ�. - �߰����ٴ� ������ ����
����] alter table ���̺�� add �߰��� Į�� �ڷ���(ũ��) ��������;
*/
alter table tb_member add email varchar2(100);
desc tb_member;

/*
���� ������ ���̺��� �÷� �����ϱ�
=< tb_member ���̺��� email �÷��� ����� 200���� Ȯ���Ͻÿ�.
����, �̸��� ����Ǵ� username�� 60���� Ȯ���Ͻÿ�.
����] alter table ���̺�� modify ������ Į���� �ڷ���(��
*/
alter table tb_member modify email varchar2(200);
alter table tb_member modify username varchar2(60);
desc tb_member;

/*
���� ������ ���̺��� �÷� �����ϱ�
=> tb_member ���̺��� mileage �÷��� �����Ͻÿ�
����] alter table ���̺�� drop column ������ �÷���;
*/
alter table tb_member drop column mileage;
desc tb_member;

/*
����] ���̺� ���Ǽ��� �ۼ��� employees ���̺��� �ش� study ������ �״��
�����Ͻÿ�. ��, ��������� ������� �ʽ��ϴ�.
*/

create table employees (
    EMPLOYEE_ID number(6),
    FIRST_NAME varchar2(20),
    LAST_NAME varchar2(25),
    EMAIL varchar2(25),
    PHONE_NUMBER varchar2(20),
    HIRE_DATE date,
    JOB_ID varchar2(10),
    salary number(8, 2),
    COMMISSION_PCT number(2, 2),
    MANAGER_ID number(6, 0),
    DEPARTMENT_ID number(4)
);
desc tb_member;

/*
���̺� �����ϱ�
=> employees ���̺��� ���̻� ������� �����Ƿ� �����Ͻÿ�.
����] drop table ������ ���̺����
*/
-- ���̺� ���� Ȯ��
select * from tab;

-- ���̺� ����
drop table employees;
-- ���� �� ���̺� ��Ͽ����� ������ �ʴ´�. �����뿡 �� �����̴�.
select * from tab;
-- ��ü�� �������� �ʴ´ٴ� ������ �߻��Ѵ�.
desc employees;

/*
tb_member ���̺� ���ο� ���ڵ带 �����Ѵ�.(DML �κп��� �н� - �޺κ�)
������ ���̺� �����̽���� ������ ���� ������ �� ���� �����̴�.
*/
insert into tb_member values
    (1, 'hong', '1234', 'ȫ�浿', 'hong@naver.com');

/*
����Ŭ 11g������ ���ο� ������ ������ �� connect, resource��
��(Role)�� �ο��ϸ� ���̺� ���� �� ���Ա��� ������, �� ���� ����������
���̺� �����̽� ���� ������ �߻��Ѵ�. ���� �Ʒ��� ���� ���̺� �����̽���
���� ���ѵ� �ο��ؾ��Ѵ�. 
*/
-- system ����
grant unlimited tablespace to study;

-- study ����
-- �ٽ� study�������� ������ �� ���ڵ带 �����Ѵ�.
insert into tb_member values
    (1, 'hong', '1234', 'ȫ�浿', 'hong@naver.com');
insert into tb_member values
    (2, 'yu', '9876', '����', 'yoo@hanmail.net');
-- ���Ե� ���ڵ带 Ȯ���Ѵ�
select * from tb_member;

-- ���̺� �����ϱ�1 : ���ڵ���� �Բ� ����
/*
select���� ����Ҷ� where���� ������ ��� ���ڵ带 ����϶�� ����̹Ƿ�
�Ʒ������� ��� ���ڵ带 �����ͼ� ���纻 ���̺��� �����Ѵ�. ��, ���ڵ����
����ȴ�.
*/

create table tb_member_copy
    as
    select * from tb_member;

-- where 1=1; �� �������� - default��
-- ����� ���̺��� Ȯ���Ѵ�
desc tb_member_copy;
select * from tb_member_copy;

-- ���̺� �����ϱ�2 : ���ڵ�� �����ϰ� ���̺� ������ ����
create table tb_member_empty
    as 
    select * from tb_member where 1=0;

-- where 1=0; - ������ ����
-- ����� ���̺��� Ȯ���Ѵ�
desc tb_member_empty;
select * from tb_member_empty;

/*
DDL�� 
���̺��� ���� �� �����ϴ� ������(Data Definition Language : ������ ���Ǿ�)
    ���̺� ���� : create table ���̺��
    ���̺� ����
        �÷� �߰� : alter table ���̺�� add �÷���
        �÷� ���� : alter table ���̺�� modify �÷���
        �÷� ���� : alter table ���̺�� drop column �÷���
    ���̺� ���� : drop table ���̺��
*/

--------------------------------------------------------------------------------
-- study����

/*
���� 1
���� ���ǿ� �´� "pr_dept" ���̺��� �����Ͻÿ�.
dno number(2),
dname varchar2(20),
loc varchar2(35)
*/

create table pr_dept (
dno number(2),
dname varchar2(20),
loc varchar2(35)
);

desc pr_dept; -- ���̺� ���� Ȯ��

/*
���� 2
���� ���ǿ� �´� "pr_emp" ���̺��� �����Ͻÿ�.
eno number(4),
ename varchar2(10),
job varchar2(30),
regist_date date
*/
create table pr_emp (
eno number(4),
ename varchar2(10),
job varchar2(30),
regist_date date
);

desc pr_emp;