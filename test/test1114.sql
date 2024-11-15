-- 문제1) employees 테이블에 등록된 총 사원의 수, 급여의 합, 급여의 평균을 변수에 대하여 출력
DECLARE 
    SUMPEOPLE NUMBER(15);
    SUMSAL NUMBER(15);
    AVGSAL NUMBER(15);
BEGIN
    SELECT COUNT(*), SUM(SALARY), AVG(SALARY)
    INTO SUMPEOPLE, SUMSAL, AVGSAL
    FROM EMPLOYEES;
    
    DBMS_OUTPUT.PUT_LINE('총 사원의 수: ' || SUMPEOPLE);
    DBMS_OUTPUT.PUT_LINE('급여의 합: ' || SUMSAL);
    DBMS_OUTPUT.PUT_LINE('급여의 평균: ' || AVGSAL);
END;
/


----------------------------------------------------------------------------------------
-- 문제2) Clara 사원의 직무, 급여, 입사일자, 커미션, 부서명을 변수에 대입하여 출력
SELECT E.JOB_ID, E.SALARY, E.HIRE_DATE, E.COMMISSION_PCT, D.DEPARTMENT_NAME
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
WHERE FIRST_NAME='Clara';
------------------------------------------------------------------------------
DECLARE 
    TYPE EMP_RECORD_TYPE IS RECORD(
        JOBID EMPLOYEES.JOB_ID%TYPE,
        SALARY EMPLOYEES.SALARY%TYPE,
        HIREDATE EMPLOYEES.HIRE_DATE%TYPE,
        CMS EMPLOYEES.COMMISSION_PCT%TYPE,
        DPTID EMPLOYEES.DEPARTMENT_ID%TYPE
    ); 
    -- 레코드 타입 변수선언
    EMP_RECORD EMP_RECORD_TYPE;
BEGIN
    SELECT JOB_ID, SALARY, HIRE_DATE, COMMISSION_PCT, DEPARTMENT_ID
    INTO EMP_RECORD
    FROM EMPLOYEES 
    WHERE FIRST_NAME='Clara';
    
    DBMS_OUTPUT.PUT_LINE('사원 직무: ' || EMP_RECORD.JOBID);
    DBMS_OUTPUT.PUT_LINE('급여: ' || EMP_RECORD.SALARY);
    DBMS_OUTPUT.PUT_LINE('입사 일자: '|| EMP_RECORD.HIREDATE);
    DBMS_OUTPUT.PUT_LINE('커미션: '|| EMP_RECORD.CMS);
    DBMS_OUTPUT.PUT_LINE('부서명: '|| EMP_RECORD.DPTID);
END;
/


-- 선생님 VER
-- PL/SQL 
-- Clara 사원의 (직무, 급여, 입사일자, 커미션)(employees), 부서명(departments)을 변수에 대입하여 출력

select job_id, salary, hire_date, commission_pct, depratment_id from employees where first_name = 'Clara';
select department_name, department_id from departments; 

select job_id, salary, hire_date, commission_pct,department_name 
from employees E inner join departments D on E.department_id = D.department_id where first_name = 'Clara';

DECLARE
    VFIRST_NAME EMPLOYEES.FIRST_NAME%TYPE;
    VJOB_ID EMPLOYEES.JOB_ID%TYPE;
    VSALARY EMPLOYEES.SALARY%TYPE;
    VHIRE_DATE EMPLOYEES.HIRE_DATE%TYPE;
    VCOMMISSION_PCT EMPLOYEES.COMMISSION_PCT%TYPE;
    VDEPARTMENT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE;
BEGIN
    SELECT FIRST_NAME, JOB_ID, SALARY, HIRE_DATE, COMMISSION_PCT, DEPARTMENT_NAME
    INTO VFIRST_NAME, VJOB_ID, VSALARY, VHIRE_DATE, VCOMMISSION_PCT, VDEPARTMENT_NAME
    FROM EMPLOYEES E INNER JOIN DEPARTMENTS D ON e.department_id=d.department_id
    WHERE FIRST_NAME = 'Clara';

    DBMS_OUTPUT.PUT_LINE('이름 : '||VFIRST_NAME);
    DBMS_OUTPUT.PUT_LINE('직무 : '||VJOB_ID);
    DBMS_OUTPUT.PUT_LINE('급여 : '||VSALARY);
    DBMS_OUTPUT.PUT_LINE('입사일자 : '||VHIRE_DATE);
    DBMS_OUTPUT.PUT_LINE('커미션 : '||VCOMMISSION_PCT);
    DBMS_OUTPUT.PUT_LINE('부서명 : '||VDEPARTMENT_NAME);
END;
/

