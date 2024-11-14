select * from employees;
select * from departments;

-- 문제1) 사원번호, 사원명, 부서명, 부서위치를 출력하는 뷰(view_loc) 작성
create view view_loc
as 
select e.employee_id, e.first_name, d.department_name, d.location_id
from employees e
inner join departments d
on e.department_id=d.department_id;

select * from view_loc;


-- 문제2) 30번 부서 소속 사원의 이름과 입사일과 부서명을 출력하는 뷰(view_dept30) 작성 
create view view_dept30
as 
select e.first_name, e.hire_date, d.department_name
from employees e
inner join departments d
on e.department_id=d.department_id
where e.department_id=30;

select * from view_dept30;


-- 문제3) 부서별 최대 급여 정보 뷰(view_dept_maxsal) 작성
create view view_dept_maxsal
as 
select department_id, salary
from employees 
where (department_id, salary) in (
select department_id, max(salary)
from employees 
group by department_id
)
order by department_id;

select * from view_dept_maxsal;


-- 문제4) 급여를 많이 받는 순서대로 3명만 출력하는 뷰(view_sal_top3)와 인라인뷰 작성
drop view view_sal_top3;
drop view view_sal;

-- 1. 뷰
create view view_sal
as 
select first_name, salary
from employees
order by salary
desc;

select * from view_sal;

select rownum, first_name, salary
from view_sal
where rownum<=3
order by rownum
;

-- 2. 인라인뷰
select rownum, first_name, salary
from (
select first_name, salary
from employees 
order by salary
desc
)
where rownum<=3;



