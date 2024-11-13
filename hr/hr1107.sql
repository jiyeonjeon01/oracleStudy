-- employees 속성 
create table emp03
as 
select * from employees;

-- 모든 사원의 부서번호를 30번으로 수정하자
update emp03 
set department_id=30;

rollback;

-- 모든 사원의 급여를 10% 인상한다.
update emp03 
set salary=salary*1.1;

rollback;

-- 모든 사원의 입사일을 오늘로 수정한다.
update emp03 
set hire_date=sysdate;

rollback;

-- 부서번호가 10번인 사원의 부서번호를 30번으로 수정
select * from emp03 where department_id=10;

update emp03 
set department_id=30 
where department_id=10;

rollback;

-- 급여가 3000이상인 사원만 급여를 10% 인상
select * from emp03 where salary>=3000;

update emp03 
set salary=salary*1.1 
where salary>=3000;

rollback;

-- 2007년에 입사한 사원의 입사일을 오늘로 수정하낟. 
select * from emp03 where to_char(hire_date, 'YYYY')='2007';

update emp03 
set hire_date=sysdate  
where TO_CHAR(hire_date, 'YYYY')='2007';
-- where substr(hire_date, 1, 2)='07'; 도 같은 결과임 
rollback;

select * from emp03 where to_char(hire_date, 'YYYY')='2024';

-- 이름이 Susan인 부서번호는 20번으로 직급은 FI_MGR
update emp03
set department_id=20,
    job_id='FI_MGR'
where upper(first_name)=upper('Susan');
-- upper()를 안써도 동일하게 수행되긴 함 

-- last_name이 Russell인 사원의 급여는 17000로, 커미션 비율이 0.45로 인상된다
update emp03
set salary=17000,
    commission_pct=0.45
where last_name='Russell';
    
     
-- mycustomer 만들어보기      
create table mycustomer (
    code varchar2(7) not null, --pk
    name varchar2(10) not null,
--  name varchar2(10) constraint mycustomer_name_nn not null, (not null 쓰기 ver2)
    gender char(1) not null, -- check
    birthday varchar2(8) not null,
    phone varchar2(16)
--  constraint mycustomer_phone_uk unqiue(phone) (unique 쓰기 ver2)
);
alter table mycustomer
    add constraint mycustomer_code_pk primary key(code);
alter table mycustomer
    add constraint mycustomer_gender_ck check(gender in('W', 'M'));
alter table mycustomer
    add constraint mycustomer_phone_uk unique(phone);
    
desc mycustomer; 

select *
from user_constraints;

select * 
from user_tables;
    
select *
from user_cons_columns;

select *
from user_constraints
where table_name='MYCUSTOMER';

-- customer 테이블의 email의 uk 제약조건 없애기 
alter table customer drop constraint customer_email_uk;

-- MERGE  MYCUSTOMER - > CUSTOMER 병합을진행하는데 없으면 INSERT, 있으면 UPDATE
MERGE INTO CUSTOMER C
    USING MYCUSTOMER M
    ON (C.CODE = M.CODE)
    WHEN MATCHED THEN
        UPDATE SET C.NAME = M.NAME, C.GENDER = M.GENDER, C.BIRTH = M.BIRTH, C.PONE = M.PHONE 
    WHEN NOT MATCHED THEN
        INSERT (C.CODE,C.NAME,C.GENDER,C.BIRTH, C.PONE) values(M.CODE,M.NAME,M.GENDER,M.BIRTH, M.PHONE);

SELECT * FROM CUSTOMER;
SELECT * FROM MYCUSTOMER;
UPDATE MYCUSTOMER SET NAME = '박승우' WHERE CODE = '2017108';



DROP TABLE DEPT01;
-- 17 PDF 12쪽 
CREATE TABLE DEPT01(
    NO VARCHAR2(8),
    NAME VARCHAR2(10) NOT NULL,
    REGION VARCHAR2(10)
);
ALTER TABLE DEPT01 ADD CONSTRAINT DEPT01_NO_PK PRIMARY KEY(NO);

DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    NO NUMBER(8),
    NAME VARCHAR2(10) NOT NULL,
    JOB_ID VARCHAR2(10),
    DEPT_NO VARCHAR2(8)
);
ALTER TABLE MEMBER 
    ADD CONSTRAINT MEMBER_NO_PK PRIMARY KEY(NO);
ALTER TABLE MEMBER 
    ADD CONSTRAINT MEMBER_DEPT_NO_FK FOREIGN KEY(DEPT_NO) REFERENCES DEPT01(NO);


DROP TABLE DEPT02;
CREATE TABLE DEPT02(
    DEPT_NO NUMBER,
    DEPT_NAME VARCHAR2(10),
    LOCATION VARCHAR2(10)
);

ALTER TABLE DEPT02 
    ADD CONSTRAINT DEPT02_NO_PK PRIMARY KEY(DEPT_NO);

INSERT INTO DEPT02 VALUES(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT02 VALUES(20,'RESEARCH','DALLAS');
INSERT INTO DEPT02 VALUES(30,'SALES','CHICAGO');
INSERT INTO DEPT02 VALUES(40,'OPERATIONS','BOSTON');
SELECT * FROM DEPT02;

DROP TABLE MEMBER01;
CREATE TABLE MEMBER01(
    MEMBER_NO NUMBER,
    MEMBER_NAME VARCHAR(10),
    JOB_ID VARCHAR(10),
    DEPT_NO NUMBER
);

ALTER TABLE MEMBER01 
    ADD CONSTRAINT MEMBER01_NO_PK PRIMARY KEY(MEMBER_NO);
ALTER TABLE MEMBER01 
    ADD CONSTRAINT MEMBER01_NO_FK FOREIGN KEY(DEPT_NO) REFERENCES DEPT02(DEPT_NO);

INSERT INTO MEMBER01 VALUES(7499,'ALLEN','SALESMAN',30);
INSERT INTO MEMBER01 VALUES(7566,'JONES','MANAGER',50);
INSERT INTO MEMBER01 VALUES (50, 'MANAGER', 40);

DELETE FROM MEMBER WHERE DEPT_NO=40;
DELETE FROM DEPT01 WHERE NO=40;

ALTER TABLE MEMBER 
    DROP CONSTRAINT MEMBER_DEPT_NO_FK;
-- CASCADE: 부모가 제거하면 자식도 제거할 수 있는 키워드     
ALTER TABLE MEMBER01 
    ADD CONSTRAINT MEMBER01_NO_FK FOREIGN KEY(DEPT_NO) REFERENCES DEPT02(DEPT_NO) ON DELETE CASCADE;    


