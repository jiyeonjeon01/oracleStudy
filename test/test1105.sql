-- 'jking'이란 이메일을 가진 직원의 이름과 급여와 커미션을 출력하라(initcap, upper 사용)
select first_name, salary, commission_pct 
from employees 
where email=upper('jking');
select initcap(first_name), salary, commission_pct 
from employees 
where email=upper('jking');
-- 이름이 6글자 이상인 직원의 직원번호와 이름과 급여를 출력하라
select employee_id, first_name, salary 
from employees 
where length(first_name)>=6;
-- 03년도에 입사한 사원 알아내기
select * 
from employees
where substr(to_char(hire_date, 'YYYY-MM-DD'), 1, 4)='2003';
-- 이름이 k로 끝나는 직원을 검색 
select *
from employees
where first_name like '%k';
-- 직원 번호가 짝수인 직원들의 직원 번호와 이름과 직급을 출력하라
select employee_id, last_name, department_id
from employees
where mod(employee_id, 2)=0;
-- 모든 직원은 자신의 상관(manager_id)이 있다. 
-- 하지만 employees 테이블에 유일하게 상관이 없는 로우가 있는데 그 사원의 manager_id 칼럼값이 null이다. 
-- 상관이 없는 대표이사만 출력하되 manager_id 칼럼 값 null 대신 ceo로 출력한다
select employee_id, first_name,
    case when manager_id is null then 'ceo'
    else to_char(manager_id) end as manager_id
from employees
where manager_id is null;
-- 선생님 VER 
select nvl2(manager_id, manager_id, 'CEO') 
from employees 
where manager_id is null;

-- 부서별에 따라 급여를 인상하도록 하자(직원번호, 직원명, 직급, 급여)
-- 부서명이 marketing 인 직원은 5%, purchasing인 사원은 10%, 
-- human resources인 사원은 15%, it인 직원은 20% 인상한다. 
select employee_id, first_name, department_id, salary,
        decode(department_id, 20, salary*1.05, 30, salary*1.1, 
        40, salary*1.15, 60, salary*1.2) as salary2
from employees;

-- 내꺼 고쳐준 ver 
select employee_id, first_name, department_id, salary,
        decode(upper(D.department_name), upper('Marketing'), salary*1.05, upper('Purchasing'), salary*1.1,
        upper('Human resources'), salary*1.15, upper('IT'), salary*1.2) as salary2
from employees E
inner join departments D 
    on E.department_id=D.department_id
where upper(D.department_name) in (upper('Marketing'), upper('Purchasing'), upper('Human Resources'), upper('IT'))
order by salary2 desc;

-- 지피티 ver1
SELECT E.employee_id, 
       E.first_name, 
       E.department_id, 
       E.salary,
       CASE 
           WHEN upper(D.department_name) = 'MARKETING' THEN E.salary * 1.05
           WHEN upper(D.department_name) = 'PURCHASING' THEN E.salary * 1.1
           WHEN upper(D.department_name) = 'HUMAN RESOURCES' THEN E.salary * 1.15
           WHEN upper(D.department_name) = 'IT' THEN E.salary * 1.2
           ELSE E.salary
       END AS salary2
FROM employees E
INNER JOIN departments D 
    ON E.department_id = D.department_id
WHERE upper(D.department_name) IN ('MARKETING', 'PURCHASING', 'HUMAN RESOURCES', 'IT')
ORDER BY salary2 DESC;

-- 지피티 ver2
SELECT 
    E.employee_id, 
    E.first_name, 
    E.department_id, 
    E.salary,
    DECODE(
        UPPER(D.department_name), 
        'MARKETING', E.salary * 1.05, 
        'PURCHASING', E.salary * 1.10,
        'HUMAN RESOURCES', E.salary * 1.15, 
        'IT', E.salary * 1.20
    ) AS salary2
FROM 
    employees E
INNER JOIN 
    departments D 
    ON E.department_id = D.department_id
WHERE 
    UPPER(D.department_name) IN ('MARKETING', 'PURCHASING', 'HUMAN RESOURCES', 'IT')
ORDER BY 
    salary2 DESC;


-- 선생님 ver
select employee_id, first_name, salary, department_id 
from employees;

select * 
from employees 
inner join departments on employees.department_id= departments.department_id;

select employee_id, first_name, job_id, salary, E.department_id, D.department_name,
case when upper(D.department_name)=upper('Marketing') then salary*1.05
     when upper(D.department_name)=upper('Purchasing') then salary*1.10
     when upper(D.departmnet_name)=upper('Human Resources') then salary*1.15
     when upper(D.department_name)=upper('IT') then salary*1.20
     end newsalary
from employees E
inner join departments D 
    on E.department_id=D.department_id
where upper(D.department_name) in (upper('Marketing'), upper('Purchasing'), upper('Human Resources'), upper('IT'))
order by newsalary desc;

select employee_id, first_name, salary, job_id, A.department_id, B.department_name,
case when B.department_name='Marketing' then salary*1.05
     when B.department_name='Purchasing' then salary*1.10
     when B.department_name='Human Resouces' then salary*1.15
     when B.department_name='IT' then salary*1.20
     end newsalary
from employees A 
inner join departments B 
    on A.department_id = B.department_id
where A.department_id in(20, 30, 40, 60);
    

-- --------------------------------------------------------------------------

-- 03년도에 입사한 사원 알아내기
Select 입사년도, 사원이름 from employees where TO_CHAR(hire_date, ‘YY’) = ‘03’;  
select hire_date, TO_CHAR(hire_date,'YY/MM/DD HH24:MI:SS'),  TO_CHAR(hire_date,'MI')  from employees;
select TO_DATE('20041214','YYYY/MM/DD')+1 from dual; 

-- 이름이 k로 끝나는 직원을 검색
select first_name from employees;
select first_name from employees where first_name like '%k';
select first_name from employees where upper(substr(first_name, LENGTH(first_name),1)) = UPPER('k');

-- 현재시간표현
select sysdate from dual;
select to_char(sysdate,'YYYY/MM/DD HH24:MI:SS') from dual;
select FLOOR(sysdate - TO_DATE('2024/11/05', 'YYYY/MM/DD')) from dual;

-- 숫자를 우리가 원하는 형식으로 출력하기 1234567.23 => $1,234,567.23
select trim(to_char(1234567.23, 'L999,999,999,999.99')) as money from dual; 
select first_name, trim(to_char(salary, 'L999,999,999,999.99')) as salary from employees; 

-- 문자 + 문자 = 숫자
select to_number('10,000', '999,999') + to_number('20,000','999,999') from dual;
select to_number('10,000', '999999') from dual;

-- NVL
select first_name, salary, commission_pct, job_id from employees order by job_id;
select first_name, salary, nvl(commission_pct,0) commission_pct, job_id from employees order by job_id;

-- NVL2(대상, 널이아닐때 적용될값, 널일때 적용될값)
select first_name, salary, commission_pct, salary+(salary*commission_pct) as total from employees; 
select first_name, salary, commission_pct, salary+(salary*NVL(commission_pct,0)) as total from employees;
select first_name, salary, commission_pct, salary+(salary*NVL2(commission_pct,commission_pct, 0)) as total from employees;