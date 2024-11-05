-- hr resource 있는 테이블정보(프로젝트 클래스 종류)
select * from tab;
-- employees 테이블 구조(클래스구조)
desc employees; 
-- employees 속에 들어있는 레코드(객체들)를보여주세요.
select * from employees; 
-- departments 테이블 객체(레코드=인스턴스)를 확인
select * from departments;
-- departments 구조
desc departments;
-- department_id, department_name 보임
select department_id, department_name from departments;
-- 필드명에 별칭사용하기
select department_id as "부서번호", department_name as "부서명" from departments;
select department_id as DEPT_NO, department_name as DEPT_NAME from departments;
select department_id as "DEPT NO", department_name as "DEPT NAME" from departments;
-- + ||
select '5' + 5 from dual;
select '5' || 5 from dual;
-- 문자열을 기능을 이용해서 필드명을 보여주기
select first_name, job_id from employees;
select first_name || '의 직급은' || job_id ||'입니다' from employees;
select first_name || '의 직급은' || job_id ||'입니다' as data from employees;
-- 중복되지 않게 보여주기 distinct
select distinct job_id from employees;
-- 연봉을 3000 이상 받는 사람 정보
select * from employees;
desc employees;
-- 2008년 이후에 입사한 직원 조사
select * from employees where hire_date >= '2008/01/01';
select * from employees where TO_CHAR(hire_date, 'YYYY/MM/DD') >= '2008/01/01';
select * from employees where hire_date >= TO_DATE('2008/01/01', 'YYYY/MM/DD HH24:MI:SS)');
-- AND, BETWEEN a AND b
select * from employees where salary>=2000 and salary<=3000;
select * from employees where salary between 2000 and 3000;
-- OR, IN (, ) 직원 번호가 67이거나 101이거나 184인 사원
select * from employees where employee_ID=67 or employee_ID=101 or employee_ID=184;
select * from employees where employee_ID in (67, 101, 184);
-- null 연산, 비교, 할당 안된다
select 100 + null from dual;
select * from employees where commission_pct is not null;
select * from employees where commission_pct is null;
select employee_id, first_name, commission_pct from employees order by employee_id desc;
-- order by asc, desc 사번을 기준으로 오름차순으로 정렬
select employee_id, first_name from employees order by employee_id desc;
-- group by 
select department_id, sum(salary) from employees 
group by department_id having  department_id=30;

select * from employees;
select * from employees where department_id>=90;

select department_id, salary from employees where department_id>=80;
select department_id, max(salary) from employees where department_id>=70 group by department_id;
select department_id, max(salary), min(salary), sum(salary), round(avg(salary),1), 
count(salary) from employees where department_id>=70 group by department_id having sum(salary)>=30000;
select max(salary), round(avg(salary),1), sum(salary) from employees;
-- 문자열 일부만 추출 substr(대상, 시작위치, 추출갯수)
select substr('DATABASE', 1, 3) from dual;
-- 20번 부서에서 사원들의 입사년도 가져오기
select employee_id, first_name, substr(hire_date, 1, 2) || '년도' as "입사년도" from employees where department_id=20;
-- trim
select trim(leading from ' abcd ') lt, length(trim(leading from '       abcd ')) lt_len,
       trim(trailing from ' abcd ') rt, length(trim(trailing from '     abcd ')) rt_len,
       trim(both from ' abcd ') both1, length(trim(both from '   abcd ')) both1,
       trim('    abcd    ') both2, length(trim(' abcd ')) bothlen2 from dual;
-- 부서 30번 소속된 직원들 근무 달수를 구하기
select first_name, hire_date as 입사일, sysdate as 현재날짜,
round (months_between(sysdate, hire_date)) as "근무달수" from employees where department_id=30;
-- next_day() 함수의 기능
select sysdate, to_char(sysdate, 'YYYY/MM/DD HH24:Mi:SS'), next_day(sysdate, '수요일') from dual;






