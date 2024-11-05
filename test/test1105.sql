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
-- 부서별에 따라 급여를 인상하도록 하자(직원번호, 직원명, 직급, 급여)
-- 부서명이 marketing 인 직원은 5%, purchasing인 사원은 10%, 
-- human resources인 사원은 15%, it인 직원은 20% 인상한다. 
select employee_id, first_name, department_id, salary,
        decode(department_id, 20, salary*1.05, 30, salary*1.1, 
        40, salary*1.15, 60, salary*1.2) as salary2
from employees;