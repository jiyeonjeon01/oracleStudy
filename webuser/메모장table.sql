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

CREATE TABLE zipcode (
    seq     NUMBER(10) NOT NULL,
    zipcode VARCHAR2(50),
    sido    VARCHAR2(50),
    gugun   VARCHAR2(50),
    dong    VARCHAR2(50),
    bunji   VARCHAR2(50)
);

ALTER TABLE zipcode ADD CONSTRAINT zipcode_seq_pk PRIMARY KEY ( seq );

ALTER TABLE zipcode MODIFY BUNJI VARCHAR2(100);
DESCRIBE ZIPCODE;

SELECT * FROM ZIPCODE;

select * from student;

select * from zipcode where dong like '박촌%';

SELECT PASS FROM STUDENT WHERE ID = 'aaaa';

SELECT * FROM STUDENT WHERE ID = 'aaaa';