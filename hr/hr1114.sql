 -- pl/sql
 -- 내용을 화면에 출력하기
 declare
    phone_num varchar2(15);
    name varchar2(15);
 begin
    phone_num := '010-4900-4812';
    name := 'jiyeon jeon';
    dbms_output.put_line('phone_num='||phone_num);
    dbms_output.put_line('name='||name);
 end;
 /
 
 
 -- 내용을 employee 에 해당된 모든 직원 이름, 직원 사원번호를 출력해주는 프로그램 완성
 declare 
    -- 배열 타입 정의(테이블 타입 정의)
    type first_name_array_type is table of employees.first_name%type index by binary_integer;
    type job_id_array_type is table of employees.job_id%type index by binary_integer;
    type employee_id_array_type is table of employees.employee_id%type index by binary_integer;
    -- 배열 타입 변수 선언 
    first_name_array first_name_array_type;
    job_id_array job_id_array_type;
    employee_id_array employee_id_array_type;
    row_array employees%rowtype;
    i binary_integer := 0;
    j binary_integer;
 begin
    -- 향상된 for문을 통해서 result set 값을 한개씩 가져와서 각 컬럼 배열에 저장한다.
    for row_array in ( select * from employees ) loop
        i := i + 1;
        first_name_array(i) := row_array.first_name;
        job_id_array(i) := row_array.job_id;
        employee_id_array(i) := row_array.employee_id;
    end loop;
    -- 향상된 for문을 이용해서 컬럼 배열값에ㅔ 저장된 값을 가져와서 출력하시오
    for j in 1..i loop
        dbms_output.put_line(first_name_array(j) || ' / ' || job_id_array(j) || ' / ' || employee_id_array(j));
    end loop;
 
 end;
 /
 
-- 내용을 employees 'Susan' 이름을 갖는 사원의 사원번호와 사원명과 부서번호를 출력하시오
select employee_id, first_name, department_id
from employees 
where first_name='Susan';
-- PL/SQL 
-- 내용을 employee 'Susan' 이름을 갖는 사원의 사원번호와 사원명과, 부서번호를 출력하시오.
DECLARE
    VEMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
    VFIRST_NAME EMPLOYEES.FIRST_NAME%TYPE;
    VLAST_NAME EMPLOYEES.LAST_NAME%TYPE;
    VDEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE;
BEGIN
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID 
    INTO VEMPLOYEE_ID,VFIRST_NAME,VLAST_NAME,VDEPARTMENT_ID 
    FROM EMPLOYEES WHERE FIRST_NAME = 'Susan'; 
    
    DBMS_OUTPUT.PUT_LINE(VEMPLOYEE_ID ||','||VFIRST_NAME ||','||VLAST_NAME||','||VDEPARTMENT_ID); 
END;
/


-- 내용을 employee 최고 경영자 이름, 사원번호, 담당업무, 부서번호를 출력하시오(레코드 변수 이용)
select employee_id, first_name, last_name, department_id
from employees 
where manager_id is null;
-- 내용을 employee 최고 경영자 이름, 사원번호, 담당업무, 부서번호를 출력하시오(레코드 변수 이용)
DECLARE
    -- 레코드타입(사원번호, 이름, 담당업무,부서번호)
    TYPE EMP_RECORD_TYPE IS RECORD(
        VEMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE,
        VFIRST_NAME EMPLOYEES.FIRST_NAME%TYPE,
        VLAST_NAME EMPLOYEES.LAST_NAME%TYPE,
        VDEPARTMENT_ID EMPLOYEES.DEPARTMENT_ID%TYPE
    ); 
    -- 레코드 타입 변수선언
    EMP_RECORD EMP_RECORD_TYPE;
BEGIN
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID INTO EMP_RECORD
    FROM EMPLOYEES WHERE MANAGER_ID IS NULL;
    DBMS_OUTPUT.PUT_LINE('사원번호: ' || EMP_RECORD.VEMPLOYEE_ID);
    DBMS_OUTPUT.PUT_LINE('이름: ' || EMP_RECORD.VFIRST_NAME || ' ' || EMP_RECORD.VLAST_NAME);
    DBMS_OUTPUT.PUT_LINE('부서번호: '|| EMP_RECORD.VDEPARTMENT_ID);
  END;
/


-- SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID FROM EMPLOYEES WHERE MANAGER_ID IS NULL;

-- PL/SQL 
-- 내용을 employee 최고경영자 사원번호, 이름, 담당업부, 부서번호를 출력하시오. 로우타입변수를 활용하시오.
DECLARE
    -- 로우 타입 변수선언
    EMP_RECORD EMPLOYEES%ROWTYPE;
BEGIN
    SELECT * INTO EMP_RECORD
    FROM EMPLOYEES WHERE MANAGER_ID IS NULL;
    DBMS_OUTPUT.PUT_LINE('사원번호: '|| EMP_RECORD.EMPLOYEE_ID);
    DBMS_OUTPUT.PUT_LINE('이름: '|| EMP_RECORD.FIRST_NAME || ' ' || EMP_RECORD.LAST_NAME);
    DBMS_OUTPUT.PUT_LINE('부서번호: '|| EMP_RECORD.DEPARTMENT_ID);
  END;
/

-- SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID FROM EMPLOYEES WHERE MANAGER_ID IS NULL;



-- employee 테이블에서 임의의 부서번호를 랜덤으로 생성한뒤, 해당된 부서번호 최고 연봉을 출력한 뒤 평가하여라(낮음, 높음, 중간, 최고)
declare 
    -- 로우 타입 변수 선언, 연봉 타입 선언
    emp_record employees%rowtype;
    totacl_salary number(10, 2);
begin
    select * into emp_record
    from employees where manager_id is null;
    
    if(emp_record.commission_pct is null)then
        total_salary := emp_record.salary * 12;
    else 
        total_salary := emp_record.salary * 12 + (emp_record.salary * emp_record.commission_pct);
    end if;    
    
    DBMS_OUTPUT.PUT_LINE('사원번호: '|| EMP_RECORD.EMPLOYEE_ID);
    DBMS_OUTPUT.PUT_LINE('이름: '|| EMP_RECORD.FIRST_NAME || ' ' || EMP_RECORD.LAST_NAME);
    DBMS_OUTPUT.PUT_LINE('전체 연봉: '|| ltrim(to_char(total_salary, '$999,999,999.99')));
end;
/



-- PL/SQL 
-- employee 테이블에서 임의의 부서번호를 랜덤으로 생성한뒤 , 해당된부서번호 최고연봉을 출력한뒤, 평가하여라(낮음,높음,중간,최고,없음) 
DECLARE
    -- 부서번호, 최고연봉선언
    VNO NUMBER(4);
    VTOP_SALARY NUMBER(12,2);
    VRESULT VARCHAR2(20); 
BEGIN
    --임의의 부서번호 생성하기 (RANDOM)
    VNO := ROUND(DBMS_RANDOM.VALUE(10,110),-1); 
    
    SELECT SALARY INTO VTOP_SALARY
    FROM (SELECT SALARY FROM EMPLOYEES WHERE DEPARTMENT_ID = VNO ORDER BY SALARY DESC)
    WHERE ROWNUM = 1;
    
    -- 평가내리기 1~5000 낮음, 5000~10000 중간, 10000~20000 높음, 20000~ 최고, 없으면 예외처리
    IF(VTOP_SALARY BETWEEN 1  AND 5000 )THEN
       VRESULT := '낮음';
    ELSIF(VTOP_SALARY BETWEEN 5000  AND 10000 )THEN
       VRESULT := '중간';
    ELSIF(VTOP_SALARY BETWEEN 10000  AND 20000 )THEN
       VRESULT := '높음';
    ELSE
       VRESULT := '최고';
    END IF; 
    
    DBMS_OUTPUT.PUT_LINE('부서번호: '|| VNO);
    DBMS_OUTPUT.PUT_LINE('최고연봉 '|| VTOP_SALARY);
    DBMS_OUTPUT.PUT_LINE('최고연봉평가: '|| VRESULT);
 
 EXCEPTION
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE( VNO ||' 해당부서에 해당되는 사원이 없습니다. ');
 END;
/



-- 구구단 3단 -----------------------------------------
declare 
    num1 number := 3;
    num2 number := 1;
begin
    loop
        dbms_output.put_line(num1 || ' * ' || num2 || ' = ' || num1 * num2 );
        num2 := num2 + 1;
        if num1 > 9 then
            exit;
        end if;
    end loop;
end;
/
    

-- 구구단 -------------------------
declare 
    num1 number := 3;
    num2 number := 1;
    dan number := 0;
begin
    loop
        dan := dan + 1;
        num2 := 1;
        loop 
         dbms_output.put_line(dan || ' * ' || num2 || ' = ' || dan * num2 );
         num2 := num2 + 1;
        if num2 > 9 then
            exit;
        end if;
    end loop;
    
    if dan>9 then
        exit;
    end if;
    end loop;
end;
/
    



