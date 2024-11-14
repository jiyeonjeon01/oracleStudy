-- Transaction
drop table dep02;

-- 테이블 목사(구조만 복사)
create table dep02
as 
select * 
from departments 
where 1=0;

-- 내용 복사
insert into dep02
select * from departments;

-- 세이브 포인트
SAVEPOINT C1; 

-- 일부 삭제
delete 
from dep02
where department_id=90;

-- 세이브 포인트로 롤백하기 
ROLLBACK TO C1; 

-- 내용 삭제
delete from dep02;

select * from dep02;

rollback;



-- view 생성하기 (테이블 생성 복사하기 똑같음)
-- 권한이 없으면 view 가 만들어지지 않는데 지금은 권한이 주어져서 만들어지는 상태임 
-- 권한이 없으면 system에 가서 grant create view to hr; 하면 된다 
create view view_emp01
as 
select employee_id, first_name, salary, department_id 
from employees 
where department_id=10;

select * from view_emp01;

-- employees 복사해서 emp_copy
create table emp_copy
as 
select * from employees;

select * from emp_copy;

-- view 제거하기
drop view view_emp01;

-- view 생성하기 (테이블 생성 복사하기 똑가틍ㅁ)
create view view_emp01
as select employee_id, first_name, department_id
from emp_copy
where department_id=10;

-- select 
select * from view_emp01;
select * 
from emp_copy 
where employee_id=200;

-- view 수정하기
update view_emp01 set salary=4500 
where employee_id=200;

-- data dictionary
-- user_tables, user_constraints, user_cons_columns, user_views, user_indexes
select * 
from user_tables;

select * 
from user_constraints;

select * 
from user_cons_columns 
where table_name='EMPLOYEES';

select *
from user_views;

select *
from user_indexes;

-- 가상 뷰에 입력하기
-- (가상 테이블에 컬럼 4개 입력, 원본 10개인데 그중에 NOT NULL 인데 가상 테이블에 포함돼있지 않으면 
insert into view_emp01 values(1000, 'jdk', 2000, 50);

select * from view_emp01;

select * 
from user_constraints 
where table_name='EMP_COPY';

-- VIEW 생성하기
create view view_emp02
as 
select employee_id, first_name, last_name, email, hire_date, job_id
from emp_copy
where department_id=10;

select * from view_emp02;
insert into view_emp02
values (1000, 'jiyeon', 'jeon', 'jiyeonjeon01@naver.com', to_date('2020/01/01', 'yyyy/mm/dd'), 'it_dev');

commit;

select *
from emp_copy
where employee_id=1000;

desc emp_copy;

-- view 3 생성하기
create view view_emp03
as 
select employee_id, first_name, last_name, email, hire_date, job_id
from emp_copy;

select * 
from view_emp03
where employee_id=2000;

insert into view_emp03
values (1000, 'jiyeon', 'jeon', 'jiyeonjeon01@naver.com', to_date('2020/01/01', 'yyyy/mm/dd'), 'it_dev');

select *
from emp_copy
where employee_id=2000;

-- 가상뷰에서 삭제를 진행하기
delete from view_emp03
where employee_id=2000;

-- 복합뷰 생성하기 (employee, departments) 두 개의 테이블에서 조인해서 새로운 가상 테이블 만들기
create view view_emp_dep
as 
select employee_id, first_name, salary, e.department_id, department_name, location_id
from employees e 
inner join departments d 
on e.department_id=d.department_id
order by e.department_id desc with read only; -- with read only로 인해 조회만 가능해짐 

select * from view_emp_dep;

select distinct department_id, department_name 
from view_emp_dep;

-- 부서명 it 연봉 평균, 최고값, 최저값을 구해주세요
select department_name, max(salary)
from view_emp_dep
where department_name='IT'
group by department_name;

-- view force
create or replace force view view_force
as 
select employee_id, first_name, last_name, department_id 
from emp20;

desc view_force;

select * from emp20;

select * from user_views;

--rownum
select * from employees;

select rownum, department_id, first_name
from employees 
where department_id=100
order by first_name desc;

select rownum, department_id, first_name
from employees 
where department_id=100;

-- rownum 정렬하며 순서가 흐트러진 것을 다시 순차적으로 보여주고 싶을 때
select rownum, employess_id, first_name, hire_date 
from employees
order by hire_date desc;

create view view_hiredate
as 
select employee_id, first_name, hire_date
from employees 
order by hire_date desc;

select rownum, employee_id, first_name, hire_date 
from view_hiredate;

select rownum, employee_id, first_name, hire_date 
from view_hiredate 
where rownum=4;

select rownum, employee_id, first_name, hire_date
from (
select employee_id, first_name, hire_date
from employees 
order by hire_date desc
)
where rownum <= 4;
