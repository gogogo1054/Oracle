/***************                                                                
                                                                                
���ϸ� :  Or14Sequence&Index.sql
������ & �ε���
���� : ���̺��� �⺻Ű �ʵ忡 �������� �Ϸù�ȣ�� �ο��ϴ� �������� 
�˻��ӵ��� ����ų �� �ִ� �ε���
****************/
-- study ����

/*
������
���̺��� �÷�(�ʵ�)�� �ߺ����� �ʴ� �������� �Ϸù�ȣ�� �ο��Ѵ�.
�������� ���̺� ���� �� ������ ������ �Ѵ�. �� �������� ���̺�� ����������
����ǰ� �����ȴ�.

[������ ��������]
create sequence ��������
    [Increment by N]            -> ����ġ ����
    [Start with N]              -> ���۰� ����
    [Minvalue n | NoMinvalue]   -> ������ �ּҰ� ���� : ����Ʈ 1
    [Maxvalue n | NoMaxvalue]   -> ������ �ִ밪 ���� : ����Ʈ 1.0000E+28
    [Cycle | NoCycle]           -> �ִ�/�ּҰ��� ������ ��� ó������ �ٽ� 
                                   ������ �� ���θ� ����(Cycle�� �����ϸ�
                                   �ִ밪���� ���� �� �ٽ� ���۰����� ����۵�)
    [Cache | NoCache];          -> cache �޸𸮿� ����Ŭ ������ ������ ����
                                   �Ҵ翩�θ� ����
                                   
���ǻ���
1. start with�� minvalue���� �������� ������ �� ����. �� start with�� ����
minvalue�� ���ų� Ŀ���Ѵ�.
2. nocycle�� �����ϰ� �������� ��� ���ö� maxvalue�� �������� �ʰ��ϸ�
������ �߻��Ѵ�.
3. primary key�� cycle�ɼ��� ���� �����ϸ� �ȵȴ�.
*/
create table tb_goods (
g_idx number(10) primary key,
g_game varchar2(30)
);

insert into tb_goods values (1, '�������ݸ�');
insert into tb_goods values (1, '�����'); -- �Է½���(�������� ����)

-- ������ ����
create sequence seq_serial_num
increment by 1  -- ����ġ : 1
start with 100  -- �ʱⰪ : 100
minvalue 99     -- �ּҰ� : 99
maxvalue 110    -- �ִ밪 : 110
cycle           -- �ִ밪 ���޽� ���۰����� ��������� ���� : yes
nocache;        -- ĳ�ø޸� ��� ���� : no

-- ������ �������� ������ ������ Ȯ���ϱ�
select * from user_sequences;

/*
������ ���� �� ���ʽ���� ������ �߻��Ѵ�. nextval�� ���� ������ ��
�����ؾ� �������� ��µȴ�.
*/
select seq_serial_num.currval from dual; -- nextval ���� x - ����
/*
���� �Է��� ������(�Ϸù�ȣ)�� ��ȯ�Ѵ�. �����Ҷ����� �������� �Ѿ��.
*/

select seq_serial_num.nextval from dual; -- nextval ����
select seq_serial_num.currval from dual; -- ���������� ����

insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��1');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��2');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��3');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��4');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��5');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��6');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��7');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��8');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��9');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��10');
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��11');

-- �Ϸù�ȣ 99�� ȸ��
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��12');

-- �Ϸù�ȣ 100���� �̹� �����Ƿ� �����߻� 
-- primary key�� ��� ���� ��ġ�� �ȵǱ� ����
insert into tb_goods values (seq_serial_num.nextval, '�ܲʹ��13');

/*
�������� cycle �ɼǿ� ���� �ִ밪�� �����ϸ� �ٽ� ó������ �Ϸù�ȣ��
�����ǹǷ� ���Ἲ �������ǿ� ����ȴ�. �� �⺻Ű�� ����� ��������
cycle �ɼ��� ������� �ʾƾ� �Ѵ�.
*/

select * from tb_goods;
select seq_serial_num.currval from dual;

/*
������ ����
start with�� �������� �ʴ´�.
*/
alter sequence seq_serial_num
increment by 10 
minvalue 1
nomaxvalue
nocycle 
nocache;

-- ���� �� ������ �������� Ȯ���Ѵ�.
select * from user_sequences;

--����ġ�� 10���� ����Ȱ��� Ȯ���Ѵ�.
select seq_serial_num.nextval from dual; -- 110
select seq_serial_num.nextval from dual; -- 120

-- ������ ����
drop sequence seq_serial_num;

-- �Ϲ����� ������ ������ �Ʒ��� ���� �ϸ� �ȴ�.
create sequence seq_serial_num
increment by 1 
start with 1
minvalue 1
nomaxvalue  
nocycle    
nocache;

/*
�ε���(index)
���� �˻��ӵ��� ����ų �� �ִ� ��ü
�ε����� �����(create index)�� �ڵ���(primary key, unique)���� ������ �� �ִ�.
�÷��� ���� �ε����� ������ ���̺� ��ü�� �˻��ϰ� �ȴ�.
�� �ε����� ������ ������ ����Ű�� ���� �����̴�.

�ε����� �Ʒ��� ���� ��쿡 �����Ѵ�.
1. where �����̳� join���ǿ� ���� ����ϴ� �÷�
2. �������� ���� �����ϴ� �÷�
3. ���� null ���� �����ϴ� �÷�
*/
desc tb_goods;
select * from tb_goods;

-- �ε��� �����ϱ�. Ư�� ���̺��� �÷��� �����Ͽ� �����Ѵ�.
create index tb_goods_name_idx on tb_goods (g_game);
-- ������ �ε��� Ȯ���ϱ�
/*
������ �������� Ȯ���ϴ� PK Ȥ�� Unique�� ������ �÷��� �ڵ����� �ε�����
�����ǹǷ� �̹� ������ �ε����� ���� Ȯ�εȴ�.
*/
select * from user_ind_columns;

/*
Ư�� ���̺��� �ε��� Ȯ��
������ ������ ��Ͻ� �빮�ڷ� �ԷµǹǷ� upper�� ���� ��ȯ�Լ��� ����ϸ�
���ϴ�.
*/
select * from user_ind_columns where table_name = upper('tb_goods');
-- ������ ���� ���ڵ尡 �ִٰ� ���������� �˻��ӵ��� ����� �ִ�.
select * from tb_goods where g_game like '%��%';

-- �ε��� ����
drop index tb_goods_name_idx;

-- �ε��� ���� : ������ �Ұ����ϴ�. ���� �� �ٽ� �����ؾ� �Ѵ�.

























