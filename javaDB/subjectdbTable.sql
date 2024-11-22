-- 학과 (01-컴퓨터학과 / 02-교육학과 / 03-신문방송학과 / 04-인터넷비즈니스과 / 05-기술경영과)
-- subject 테이블 작성 
drop table subject;
create table subject( 
    no number, -- pk, seq
    num varchar2(2) not null, -- 학과번호 01, 02, 03, 04, 05
    name varchar2(24) not null -- 학과 이름 
);
ALTER TABLE SUBJECT ADD CONSTRAINT SUBJECT_NO_PK PRIMARY KEY(NO);
ALTER TABLE SUBJECT ADD CONSTRAINT SUBJECT_NUM_UK UNIQUE(NUM);

CREATE SEQUENCE SUBJECT_SEQ
START WITH 1
INCREMENT BY 1;


-- 학생 테이블
DROP TABLE STUDENT;
create table student( 
    no number, -- pk, seq
    num varchar2(8) not null, -- 학번(년도+학과번호) 
    name varchar2(12) not null, -- 이름
    id varchar2(12) not null, -- 아이디
    passwd varchar2(12) not null, -- 패스워드
    s_num varchar2(2) not null, -- 학과번호 (fk)
    birthday varchar2(8) not null, -- 생년월인
    phone varchar2(15) not null,  -- 전화번호
    address varchar2(80) not null, -- 주소
    email varchar2(40) not null, -- 이메일
    sdate date default sysdate -- 등록일
);
ALTER TABLE STUDENT ADD CONSTRAINT STUDNET_NO_PK PRIMARY KEY(NO);
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_ID_UK UNIQUE(ID);
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_NUM_UK UNIQUE(NUM);
ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_SUBJECT_NUM_FK 
    FOREIGN KEY(s_num) REFERENCES SUBJECT(NUM) ON DELETE SET NULL;
ALTER TABLE STUDENT DROP CONSTRAINT STUDENT_SUBJECT_NUM_FK;    
    
CREATE  SEQUENCE STUDENT_SEQ
START WITH 1
INCREMENT BY 1;    


-- LESSON 테이블
DROP TABLE LESSON;
create table lesson( 
    no number, -- pk, weq
    abbre varchar2(2) not null, -- 과목 별칭
    name varchar2(20) not null -- 과목 이름
);    
ALTER TABLE LESSON ADD CONSTRAINT LESSON_NO_PK PRIMARY KEY(NO);
ALTER TABLE LESSON ADD CONSTRAINT LESSON_ABBRE_UK UNIQUE(ABBRE);

create sequence lesson_seq 
start with 1
increment by 1;


-- TRAINEE 테이블
drop table trainee;
create table trainee( 
     no number, -- pk, seq 
     s_num varchar2(8) not null, -- student(fk) 학생번호 
     abbre varchar2(2) not null, -- lesson(fk) 과목 요약
     section varchar2(20) not null, -- 전공, 부전공, 교양
     tdate date default sysdate -- 수강신청일
); 
ALTER TABLE trainee ADD CONSTRAINT trainee_no_pk PRIMARY KEY(NO);
ALTER TABLE trainee ADD CONSTRAINT trainee_student_NUM_FK 
    FOREIGN KEY(s_num) REFERENCES student(num) ON DELETE SET NULL;
ALTER TABLE trainee ADD CONSTRAINT trainee_lesson_abbre_FK 
    FOREIGN KEY(s_num) REFERENCES lesson(abbre) ON DELETE SET NULL;    
 
create sequence trainee_seq 
start with 1
increment by 1;





