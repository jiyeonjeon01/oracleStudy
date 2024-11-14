-- 시퀀스 생성
create sequence emp_seq
start with 1
increment by 1
minvalue 1
maxvalue 100000
nocycle
cache 2;

-- 데이터 딕셔너리
-- user_tabs, user_constraints, user_cons_columns, user_views, user_indexes, user_sequences
select * from user_sequences;

-- employees 구조만 복사 emp01
drop table emp01;
create table emp01
as 
select employee_id, first_name, hire_date
from employees 
where 1=0;

select * from emp01;

desc emp01;

insert into emp01 values(emp_seq.nextval, 'jjy', sysdate);

-- emp_sq.currval 입력하기
select emp_seq.currval from dual;

-- sequence dept_seq 생성하기, 시작값 10, 증가치10, 결과치 30
create sequence dept_seq
start with 10
increment by 10
maxvalue 30;

select * from user_sequences;

-- dept01 테이블을 구조 복사하기 
drop table dept02;

create table dept02;

create table dept02
as 
select department_id, department_name, locaction_id 
from departments
where 1=0;

insert into dept02 values(dept_seq.nextval, '인사과', 1);
insert into dept02 values(dept_seq.nextval, '총무과', 2);
insert into dept02 values(dept_seq.nextval, '서무과', 3);
insert into dept02 values(dept_seq.nextval, '교육과', 4);
select * from dept02;



-- sequence 수정하기
alter sequence dept_seq
maxvalue 100;

select * 
from user_sequences 
where sequence_name='dept_seq';

-- sequence 삭제
drop sequence dept_seq;

-- 데이터 딕셔너리에서 인덱스 확ㅇ니 
select * 
from user_indexes 
where table_name='EMPLOYEES';
select * 
from user_ind_columns
where table_name='EMPLOYEES';

select *
from employees
where employee_id=100;

drop table emp10;

create table emp10
as select * from employees 
where 1=1;

select *
from emp01
where employee_id=100;

-- 인덱스 생성하기
select *
from user_ind_columns
where table_name='EMP10';

create unique index emp10_employee_ix
on emp10(employee_id);

-- 인덱스 삭제하기
drop index emp10_employee_ix;
