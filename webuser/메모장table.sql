CREATE SEQUENCE visit_seq  -- 시퀀스이름
 START WITH 1             -- 시작을 1로 설정
 INCREMENT BY 1          -- 증가 값을 1씩 증가
 NOMAXVALUE             -- 최대 값이 무한대
 NOCACHE NOCYCLE;

CREATE TABLE visit (
    no      NUMBER(5, 0) NOT NULL,
    writer  VARCHAR2(20) NOT NULL,
    memo    VARCHAR2(4000) NOT NULL,
    regdate DATE NOT NULL
);

ALTER TABLE visit ADD CONSTRAINT visit_no_pk PRIMARY KEY ( no );

INSERT INTO visit VALUES ( visit_seq.NEXTVAL,
                           'JJY',
                           '처음으로 메모장',
                           sysdate );

SELECT
    *
FROM
    visit;

----------------------------------------
CREATE TABLE member (
    no     NUMBER, --PK
    name   VARCHAR2(15) NOT NULL,
    id     VARCHAR2(25) NOT NULL,
    pw     VARCHAR2(30) NOT NULL,
    script VARCHAR2(50)
);

ALTER TABLE member ADD CONSTRAINT member_no_pk PRIMARY KEY ( no );

DROP SEQUENCE member_seq;

CREATE SEQUENCE member_seq START WITH 1 INCREMENT BY 1 NOMAXVALUE             -- 최대 값이 무한대

 NOCACHE NOCYCLE;

INSERT INTO member VALUES ( member_seq.NEXTVAL,
                            '전지연',
                            'jiyeon',
                            '1234',
                            '안녕하세요 잘부탁합니다.' );

SELECT
    *
FROM
    member;

--------------------------------------------------

DROP TABLE login;

DROP SEQUENCE no_seq;

CREATE TABLE login (
    no   NUMBER,
    id   VARCHAR2(12) NOT NULL,
    pass VARCHAR2(12) NOT NULL
);

ALTER TABLE login ADD CONSTRAINT login_no_pk PRIMARY KEY ( no );

CREATE SEQUENCE no_seq START WITH 1 INCREMENT BY 1;

COMMIT;


--------------------------------------
CREATE TABLE account (
    no      NUMBER(5, 0) NOT NULL,
    name    VARCHAR2(20) NOT NULL,
    id      VARCHAR2(4000) NOT NULL,
    pwd     VARCHAR2(4000) NOT NULL,
    regdate DATE NOT NULL
);

ALTER TABLE account ADD CONSTRAINT account_no_pk PRIMARY KEY ( no );

ALTER TABLE account ADD CONSTRAINT account_id_uq UNIQUE ( id );

COMMIT;

SELECT
    *
FROM
    account;

-- login 테이블 
CREATE TABLE login (
    id   VARCHAR2(30) NOT NULL,
    pass VARCHAR2(30) NOT NULL,
    name VARCHAR2(30) NOT NULL
);

ALTER TABLE login ADD CONSTRAINT login_id_pk PRIMARY KEY ( id );

CREATE TABLE tempmember (
    id       VARCHAR2(20),
    passwd   VARCHAR2(20),
    name     VARCHAR2(20),
    mem_num1 VARCHAR2(6),
    mem_num2 VARCHAR2(7),
    e_mail   VARCHAR2(30),
    phone    VARCHAR2(30),
    zipcode  VARCHAR2(7),
    address  VARCHAR2(60),
    job      VARCHAR2(30)
);

ALTER TABLE tempmember ADD CONSTRAINT tempmember_id_pk PRIMARY KEY ( id );

INSERT INTO tempmember VALUES ( 'aaaa',
                                '1111',
                                '홍길동',
                                '123456',
                                '7654321',
                                'hong@gmail.com',
                                '02-1234',
                                '100-100',
                                '서울',
                                '프로그래머' );

INSERT INTO tempmember VALUES ( 'bbbb',
                                '1111',
                                '홍길동',
                                '123456',
                                '7654321',
                                'hong@gmail.com',
                                '02-1234',
                                '100-100',
                                '서울',
                                '프로그래머' );

INSERT INTO tempmember VALUES ( 'cccc',
                                '1111',
                                '홍길동',
                                '123456',
                                '7654321',
                                'hong@gmail.com',
                                '02-1234',
                                '100-100',
                                '서울',
                                '프로그래머' );

COMMIT;

SELECT
    *
FROM
    tempmember;















-------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------
--회원가입 
-- 학생관리 테이블
CREATE TABLE student (
    id       VARCHAR2(12) NOT NULL,
    pass     VARCHAR2(12) NOT NULL,
    name     VARCHAR2(10) NOT NULL,
    phone1   VARCHAR2(3) NOT NULL,
    phone2   VARCHAR2(4) NOT NULL,
    phone3   VARCHAR2(4) NOT NULL,
    email    VARCHAR2(30) NOT NULL,
    zipcode  VARCHAR2(7) NOT NULL,
    address1 VARCHAR2(120) NOT NULL,
    address2 VARCHAR2(50) NOT NULL
);
ALTER TABLE student ADD CONSTRAINT student_id_pk PRIMARY KEY ( id );

-- 어드민 테이블
CREATE TABLE ADMIN (
    id       VARCHAR2(12) NOT NULL,
    pass     VARCHAR2(12) NOT NULL,
    name     VARCHAR2(10) NOT NULL,
    phone1   VARCHAR2(3) NOT NULL,
    phone2   VARCHAR2(4) NOT NULL,
    phone3   VARCHAR2(4) NOT NULL,
    email    VARCHAR2(30) NOT NULL,
    zipcode  VARCHAR2(7) NOT NULL,
    address1 VARCHAR2(120) NOT NULL,
    address2 VARCHAR2(50) NOT NULL
);
ALTER TABLE ADMIN ADD CONSTRAINT ADMIN_id_pk PRIMARY KEY ( id );

-- 주소
CREATE TABLE zipcode (
    seq         NUMBER(10) PRIMARY KEY,
    zipcode     VARCHAR2(10) NOT NULL, -- 우편번호
    sido        VARCHAR2(30),         -- 시/도
    gugun       VARCHAR2(30),         -- 구/군
    dong        VARCHAR2(50),         -- 동/읍/면
    bunji       VARCHAR2(100)         -- 번지
);
ALTER TABLE zipcode ADD CONSTRAINT zipcode_seq_pk PRIMARY KEY ( seq );


SELECT * FROM ZIPCODE;
SELECT * FROM ADMIN;
select * from student;
commit;
SELECT * FROM zipcode WHERE dong LIKE '%신촌동%';


------------------------------------------------------------------------------
-- 답변에만 쓰임 
--REF       NUMBER(5,0) DEFAULT 0, 
--    STEP        NUMBER(3,0) DEFAULT 0 , 
--    DEPTH     NUMBER(3,0) DEFAULT 0, 
    
    
--  공지 게시판
CREATE TABLE NOTIBOARD (
    "NUM"         NUMBER(7,0) NOT NULL , 
    WRITER      VARCHAR2(20) NOT NULL, 
    EMAIL       VARCHAR2(30) NOT NULL, 
    SUBJECT     VARCHAR2(50) NOT NULL,  
    READCOUNT   NUMBER(5,0) DEFAULT 0, 
    REGDATE     TIMESTAMP (6) DEFAULT SYSDATE, 
    "CONTENT"   VARCHAR2(4000) NOT NULL , 
    IP          VARCHAR2(45) NOT NULL ,
    ORIGINFILE VARCHAR2(255), -- 원본 파일명
    SYSFILE VARCHAR2(255)    -- 시스템에 저장된 파일명
   );
 ALTER TABLE NOTIBOARD ADD CONSTRAINT NOTIBOARD_NUM_PK PRIMARY KEY (NUM);
 CREATE SEQUENCE NOTIBOARD_SEQ
 START WITH 1
 INCREMENT BY 1
 NOMAXVALUE
 NOCACHE
 NOCYCLE;
 select * from NOTIboard;
 commit;
 
 
 
 --  자유 게시판
CREATE TABLE NORMALBOARD (
    "NUM"         NUMBER(7,0) NOT NULL , 
    WRITER      VARCHAR2(20) NOT NULL, 
    EMAIL       VARCHAR2(30) NOT NULL, 
    SUBJECT     VARCHAR2(50) NOT NULL, 
    PASS        VARCHAR2(10) NOT NULL , 
    READCOUNT   NUMBER(5,0) DEFAULT 0, 
    "REF"       NUMBER(5,0) DEFAULT 0, 
    STEP        NUMBER(3,0) DEFAULT 0 , 
    "DEPTH"     NUMBER(3,0) DEFAULT 0, 
    REGDATE     TIMESTAMP (6) DEFAULT SYSDATE, 
    "CONTENT"   VARCHAR2(4000) NOT NULL , 
    IP          VARCHAR2(45) NOT NULL ,
    ORIGINFILE VARCHAR2(255), -- 원본 파일명
    SYSFILE VARCHAR2(255)    -- 시스템에 저장된 파일명
   );
 ALTER TABLE NORMALBOARD ADD CONSTRAINT NORMALBOARD_NUM_PK PRIMARY KEY (NUM);
 CREATE SEQUENCE NORMALBOARD_SEQ
 START WITH 1
 INCREMENT BY 1
 NOMAXVALUE
 NOCACHE
 NOCYCLE;
 select * from NORMALboard;
 commit;




-- QNA게시판
CREATE TABLE QNABOARD (
    "NUM"         NUMBER(7,0) NOT NULL , 
    WRITER      VARCHAR2(20) NOT NULL, 
    EMAIL       VARCHAR2(30) NOT NULL, 
    SUBJECT     VARCHAR2(50) NOT NULL, 
    PASS        VARCHAR2(10) NOT NULL , 
    READCOUNT   NUMBER(5,0) DEFAULT 0, 
    "REF"       NUMBER(5,0) DEFAULT 0, 
    STEP        NUMBER(3,0) DEFAULT 0 , 
    "DEPTH"     NUMBER(3,0) DEFAULT 0, 
    REGDATE     TIMESTAMP (6) DEFAULT SYSDATE, 
    "CONTENT"   VARCHAR2(4000) NOT NULL , 
    IP          VARCHAR2(45) NOT NULL ,
    ORIGINFILE VARCHAR2(255), -- 원본 파일명
    SYSFILE VARCHAR2(255)    -- 시스템에 저장된 파일명
   );
 ALTER TABLE QNABOARD ADD CONSTRAINT QNABOARD_NUM_PK PRIMARY KEY (NUM);
 CREATE SEQUENCE QNABOARD_SEQ
 START WITH 1
 INCREMENT BY 1
 NOMAXVALUE
 NOCACHE
 NOCYCLE;
 select * from QNAboard;
 commit;
 
 
 
 -- 쇼핑 게시판
CREATE TABLE SHOPPINGBOARD (
    "NUM"         NUMBER(7,0) NOT NULL , 
    WRITER      VARCHAR2(20) NOT NULL, 
    EMAIL       VARCHAR2(30) NOT NULL, 
    SUBJECT     VARCHAR2(50) NOT NULL,  
    READCOUNT   NUMBER(5,0) DEFAULT 0, 
    REGDATE     TIMESTAMP (6) DEFAULT SYSDATE, 
    "CONTENT"   VARCHAR2(4000) NOT NULL , 
    IP          VARCHAR2(45) NOT NULL,
    ORIGINFILE VARCHAR2(255), -- 원본 파일명
    SYSFILE VARCHAR2(255)    -- 시스템에 저장된 파일명
   );
 ALTER TABLE SHOPPINGBOARD ADD CONSTRAINT SHOPPINGBOARD_NUM_PK PRIMARY KEY (NUM);
 CREATE SEQUENCE SHOPPINGBOARD_SEQ
 START WITH 1
 INCREMENT BY 1
 NOMAXVALUE
 NOCACHE
 NOCYCLE;
 select * from SHOPPINGboard;
 commit;
 
 -- 댓글 
CREATE TABLE NORMALREPLY (
    NUM    NUMBER(7,0) NOT NULL,    
    NORMALNUM    NUMBER(7,0) NOT NULL, --FK
    WRITER      VARCHAR2(20) NOT NULL,  
    CONTENT     VARCHAR2(1000) NOT NULL,   
    REGDATE     TIMESTAMP DEFAULT SYSDATE,   
    IP          VARCHAR2(45) NOT NULL     
);
ALTER TABLE NORMALREPLY ADD CONSTRAINT NORMALREPLY_PK PRIMARY KEY (NUM);
ALTER TABLE NORMALREPLY ADD CONSTRAINT NORMALREPLY_NORMALNUM_FK FOREIGN KEY (NORMALNUM) 
    REFERENCES NORMALBOARD (NUM) ON DELETE CASCADE;
CREATE SEQUENCE NORMALREPLY_SEQ
    START WITH 1
    INCREMENT BY 1
    NOMAXVALUE
    NOCACHE
    NOCYCLE;
commit;