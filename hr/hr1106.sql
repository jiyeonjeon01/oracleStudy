-- 테이블 설계하기(사원번호, 사원명, 급여): DDL
-- class EMP01 {
--  public int no;
--  public String name;
--  public double salary;
-- }

create table emp01 (
    no number(4),
    name varchar2(20) not null,
    salary number(10, 2) default 1000.0,
    constraint emp01_no_pk primary key(no),
    constraint emp01_name_uk unique(name)
);

-- 테이블 정보 구하기
select *
from tab;

-- 테이블 삭제하기
drop table emp01;

-- 휴지통 보기
select *
from recyclebin;





-- 
flashback ~~~~






-- 테이블 복사 (제약조건 복사 안됨)
desc employees;

select count(*) from employees;

create table emple02
as select * from employees;

desc emple02;

select count(*) from emple02;

-- 제약조건 걸기 primary key, unique
alter table emple02 add constraint emple02_id_pk primary key(employee_id);
alter table emple02 add constraint emple02_email_uk unique(email);

-- 제약조건 삭제하기 unique
alter table emple02 drop constraint emple02_email_uk;

-- 제약조건 정보 검색 (기억하기)
select * 
from user_constraints ; 

select table_name, constraint_name, constraint_type 
from user_constraints 
where table_name = upper('emple02');

-- 컬럼 추가 emp01
alter table emp01 add job varchar2(10) not null;
desc emp01;

-- 컬럼 제거 emp01
-- alter table emp01 drop column job;
desc emp01;

-- 컬럼 변경 (주의: 기본값이 존재하래 생각을 할 것 -> 타입 변경 불가, 사이즈 큰 것으로 변경 가능)
alter table emp01 modify job number(10) default 0;
desc emp01;

-- 컬럼 이름 변경
alter table emp01 rename column job to job2;
alter table emp01 rename column job2 to job;
desc emp01;

-- 테이블명을 변경 emp01 -> emp02 DDL(create, alter, drop, rename, truncate)
rename emp01 to emp02;
select *
from tab;


-- 원본 테이블 -> delete(표의 틀과 th만 남음) -> truncate(th만 남음) -> drop(표 자체가 없어짐)

-- 방법1
CREATE TABLE CUSTOMER (
    CUSTOMER_ID CHAR(7) PRIMARY KEY, 
    CUSTOMER_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(1) NOT NULL CHECK(GENDER IN ('M', 'W')),
    BIRTH_DAY CHAR(8) NOT NULL,
    PHONE_NUMBER VARCHAR2(16) UNIQUE,
    EMAIL VARCHAR2(30) UNIQUE,
    TOTAL_POINT NUMBER(10) DEFAULT 0
);

-- 방법2
create table CUSTOMER (
    CUSTOMER_ID CHAR(7) NOT NULL,
    CUSTMOER_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(1) NOT NULL,
    BIRTH_DAY CHAR(8) NOT NULL,
    PHONE_NUMVER VARCHAR2(16),
    EMAIL VARCHAR2(30) UNIQUE,
    TOTAL_POINT NUMBER(10) DEFAULT 0,
    
    CONSTRAINT CUSTOMER_ID_PK PRIMARY KEY(CUSTOMER_ID),
    CONSTRAINT GENDER_CHK CHECK(GENDER IN ('W','M'))
);

-- 방법3
CREATE TABLE CUSTOMER (
    CUSTOMER_ID CHAR(7) NOT NULL,
    CUSTOMER_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(1) NOT NULL,
    BIRTH_DAY CHAR(8) NOT NULL,
    PHONE_NUMBER VARCHAR2(16),
    EMAIL VARCHAR2(30) UNIQUE,
    TOTAL_POINT NUMBER(10) DEFAULT 0
);

ALTER TABLE CUSTOMER 
    ADD CONSTRAINT CUSTOMER_ID_PK PRIMARY KEY (CUSTOMER_ID);
ALTER TABLE CUSTOMER 
    ADD CONSTRAINT GENDER_CHK CHECK (GENDER IN ('W', 'M'));

-- 조회하기
SELECT *
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME='CUSTOMER';

desc emp01;
-- 제약조건 not null;
alter table emp01 modify ;
