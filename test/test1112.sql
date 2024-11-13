select * from employees;
select * from departments;

-- 문제1) HR 부서의 어떤 사원은 급여 정보를 조회하는 업무를 맡고 있다.------------------------ 
-- Tucker(last_name) 사원보다 급여를 많이 받고 있는 사원의 
-- 성&이름(name으로 별칭), 업무, 급여를 출력하시오
-- 답1)
select first_name || ' ' || last_name AS 이름, d.department_name as 업무번호, e.salary as 급여 
from employees e
inner join departments d
on e.department_id=d.department_id
where salary > (
select salary
from employees 
where last_name='Tucker'
);
-----------------------------------------------------------------------------------

---- 1. Tucker 인 사원의 급여 찾기(10000)
--select salary
--from employees 
--where last_name='Tucker';
---- 2. 조인으로 출력하기 
--select first_name || ' ' || last_name AS 이름, d.department_name as 업무번호, e.salary as 급여 
--from employees e
--inner join departments d
--on e.department_id=d.department_id
--where salary > (
--select salary
--from employees 
--where last_name='Tucker'
--);







-- 문제2) 사원의 급여 정보 중 업무별 최소 급여를 받고 있는 ---------------------------------------------
-- 사원의 성&이름(name으로 별칭), 업무, 급여, 입사일을 출력하시오
-- 답1) department_id 로 분류
select first_name || ' ' || last_name AS 이름, department_id as 부서번호, salary as 급여, hire_date as 입사일
from employees 
where(department_id, salary) in (
select department_id, min(salary) 
from employees 
group by department_id
)
order by department_id;
-- 답2) job_id 로 분류
select first_name || ' ' || last_name AS 이름, job_id as 업무, salary as 급여, hire_date as 입사일
from employees 
where (job_id, salary) in (
select job_id, min(salary)
from employees 
group by job_id
)
order by job_id;
--------------------------------------------------------------------------------------------------
-- 풀이
select * from employees;

select min(salary)
from employees 
group by job_id;

select first_name, job_id, salary, hire_date 
from employees
where job_id='잡아이디' 
and 
salary='최소금액';

select first_name, job_id, salary, hire_date 
from employees
where job_id='잡아이디' 
and 
salary in ( -- 단일행이먄 = 을 써도 되는데 다중행이기 때문에 in, all, exist...이런걸 쓴다 
select min(salary)
from employees 
group by job_id
);

select first_name, job_id, salary, hire_date 
from employees
where (job_id, salary) in ( -- 단일행이먄 = 을 써도 되는데 다중행이기 때문에 in, all, exist...이런걸 쓴다 
select job_id, min(salary)
from employees 
group by job_id
);



-- 1. 업무(department_id)별 최소 급여 출력
--select department_id, min(salary)
--from employees 
--group by department_id
--order by department_id;

-- +) 
--select first_name, salary, hire_date, e.department_id , 
--(select min(salary) from employees where department_id = e.department_id group by department_id) from employees e;



-- 문제3) 소속 부서의 평균 급여보다 많은 급여를 받는 사원에 대하여 ----------------------------------------
-- 사원의 성&이름(name으로 별칭), 급여, 부서번호, 업무를 출력하시오
-- 부서별 평균 급여
-- 답3)
select first_name || ' ' || last_name AS 이름, salary as 급여, department_id as 부서번호, job_id as 업무 
from employees e 
where salary > ( 
select avg(salary) 
from employees 
where department_id = e.department_id 
);
-----------------------------------------------------------------------------------------------------
-- 풀이
select department_id, round(avg(salary))
from employees 
group by department_id;

select first_name, salary, department_id, job_id 
from employees 
where (department_id, salary) in (
select round(avg(salary))
from employees 
where department_id=90
group by department_id
);

select first_name, salary, e.department_id, job_id 
from employees e
where e.salary > (
select round(avg(salary))
from employees 
where department_id=e.department_id
group by department_id
);
--select department_id, avg(salary)
--from employees
--group by department_id;
--
--SELECT first_name || ' ' || last_name AS name, (
--select department_id, avg(salary)
--from employees
--group by department_id
--), department_id, job_id
--FROM employees
--where salary > (
--select avg(salary)
--from employees
--group by department_id
--);

--select first_name || ' ' || last_name AS 이름, salary as 급여, department_id as 부서번호, job_id as 업무
--from employees e
--where salary > (
--    select avg(salary)
--    from employees
--    where department_id = e.department_id
--)
--;
--
--
--
--
--select department_id, avg(salary)
--from employees
--group by department_id;


-- 문제4) 모든 사원의 소속부서 평균 급여를 계산하여 --------------------------------------------------------------------
-- 사원별로 성&이름(name으로 별칭), 업무, 급여, 부서번호, 
-- 부서 평균 급여(department avg salary 별칭)를 출력하시오
-- 답4) 
select first_name || ' ' || last_name AS 이름, job_id as 업무, salary as 급여, department_id as 부서번호, (
select avg(salary) 
from employees e1
where e1.department_id=e.department_id) as 부서평균급여
from employees e
order by department_id;
------------------------------------------------------------------------------------------------------------
-- 풀이
select round(avg(salary)) 
from employees s
where department_id=90
group by department_id;

select first_name, salary, e.department_id, 
(select round(avg(salary))
from employees 
where department_id=e.department_id
group by department_id) as "부서평균급여"
from employees e;




--select first_name || ' ' || last_name AS 이름, job_id as 업무, salary as 급여, department_id as 부서번호, avg(salary) as 부서평균급여
--from employees e
--where salary = (
--    select avg(salary)
--    from employees
--    where department_id = e.department_id
--)
--;
--
--
--select first_name || ' ' || last_name AS 이름, job_id as 업무, salary as 급여, department_id as 부서번호, (
--select avg(salary) 
--from employees e1
--where e1.department_id=e.department_id) as 부서평균급여
--from employees e
--order by department_id;
--
--
--SELECT 
--    first_name || ' ' || last_name AS 이름,
--    job_id AS 업무,
--    salary AS 급여,
--    department_id AS 부서번호,
--    (SELECT avg(salary) FROM employees e2 WHERE e2.department_id = e.department_id) AS 부서평균급여
--FROM 
--    employees e
--order by department_id    
--    ;
