-- 사용자 계정만들기 (시스템 관리자 모드에서 진행해야됨)
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
DROP USER SHOPPINGMALL CASCADE;
CREATE USER SHOPPINGMALL IDENTIFIED BY 123456
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP;
GRANT CONNECT, RESOURCE, DBA TO SHOPPINGMALL;    