-- susan 부서 아이디 보기
select department_id from employees where first_name = 'Susan';

-- 부서 테이블에서 40번 부서명을 조회
select department_name from departments where department_id = 40; 

-- susan이 소속되어 있는 부서명을 검색하시오
select * from employees where first_name = 'Susan';
select * from departments where department_id = 40;

-- susan 이 소속되어있는 부서명을 조인해보기 (department_id로 조인됨)
-- inner join 
select * 
from employees e
inner join departments d
on e.department_id = d.department_id;
-- full outer join (left outer join, right outer join 도 있음 )
select * 
from employees e
full outer join departments d
on e.department_id = d.department_id;
-- self join 
select * 
from employees e
join departments d
on e.department_id = d.department_id;

-- 
select E.first_name, D.departmeㄴnt_name 
from departments D
inner join employees E 
on D.department_id = E.department_id
where upper(first_name) = upper('Susan');

select department_id 
from employees 
where first_name='Susan';
-- 단일행은 비교, 크기, 연산이 가능하다
-- 다중행은 비교, 크기, 연산이 불가능하다
-- (IN=OR, ANY=1개 이상, ALL=모두, EXISTS=존재하냐)
select * 
from departments 
where department_id = (
select department_id 
from employees 
where first_name='Susan'
);

-- employess 테이블에서 lex 와 같은 부서에 (10번 부서) 있는 모든 사원의 이름과 
-- 입사일자(형식: 1987-11-17)를 출력하는 select 문을 작성하시오
select department_id 
from employees 
where first_name='Lex';

-- 상사가 null 인 사람은 ceo 
select *
from employees 
where manager_id is null;
-- employees 테이블에서 ceo에게 보고하는 직원의 모든 정보를 출력하는 select 문 select *
select *
from employees
where manager_id=(
select *
from employees
where manager_id is null);

-- 고용 테이블에서 전체 연봉 평균
select round(avg(salary)) as "평균연봉"
from employees;
--위와 밑이 동일함 
select department_id, round(avg(salary)) as "평균연봉"
from employees
group by department_id;

-- 전체 평균 연봉보다 높은 직원 정보 출력
select *
from employees 
where salary > (select round(avg(salary)) as "평균연봉"
from employees);

-- 다중행이면 비교가 가능할까 
select *
from employees 
where exists (
select round(avg(salary)) as "평균연봉"
from employees
group by department_id);

select * from employees where 1=0;

create table imsiTBL
as 
select * from employees where 1=1;

select * from imsiTBL;

select *
from user_constraints
where table_name='imsiTBL';

-- 월급이 13000 이상인 사람의 부서를 보여주시오 
select *
from employees 
where salary>=13000;

select *
from employees 
where department_id in (90, 80, 20);

select *
from employees 
where department_id
in (
select distinct department_id 
from employees 
where salary>=13000
);

-- employees 테이블에서 susan 또는 lex 월급
select first_name, salary 
from employees 
where upper(first_name)=upper('Susan') or 
upper(first_name)=upper('Lex');

-- employees 테이블에서 Susan 또는 Lex 와 월급이 같은 직원의 이름, 업무, 급여를 출력(Susan, Lex 는 제외)
select *
from employees 
where salary in (17000, 6500) and first_name <> 'Susan' and first_name <> 'Lex';
select *
from employees 
where salary in (17000, 6500) and first_name not in ('Susan', 'Lex');
select *
from employees 
where salary in (
select first_name, salary 
from employees 
where upper(first_name)=upper('Susan') or 
upper(first_name)=upper('Lex')
) and first_name <> 'Susan' and first_name <> 'Lex';

-- 한명 이상으로부터 보고를 받는다 = 나는 매니저로 등록이 되어있다. null=ceo
select *
from employees 
where manager_id is not null
or manager_id is null;

-- 한 명 이상으로부터 보고를 받을 수 있는 직원의 직원번호, 이름, 업무, 부서번호를 출력 
select employee_id, first_name, job_id, department_id 
from employees 
where manager_id in (
select distinct manager_id
from employees
);

select * from employees;
select * from departments;

-- employees 테이블에서 accounting 부서에서 근무하는 직원과 같은 업무를 하는 직원의 이름, 업무명 
select *
from employees 
where department_id=110;

select * 
from departments 
where department_name='Accounting';

select distinct *
from employees 
where department_id=110;

-- 선생님 방법 
select first_name, job_id
from employees 
where department_id = (
select department_id
from departments 
where department_name='Accounting'
);

select first_name, job_id
from employees 
where department_id = (
select department_id
from departments 
where department_name='Accounting'
)
and job_id in ('AC_MGR', 'AC_ACCOUNT');

select first_name, job_id
from employees 
where department_id = (
select department_id
from departments 
where department_name='Accounting'
)
and job_id in (
select distinct job_id 
from employees 
where department_id=(
select department_id 
from departments 
where department_name='Accounting'
)
);

-- department_id=(
-- select department_id 
-- from departments 
-- where department_name='Accounting'
-- ) => A

select first_name, job_id 
from employees 
where job_id in(
select distinct job_id 
from employees 
where department_id=110
);

select first_name, job_id 
from employees 
where job_id in (
select distinct job_id 
from employees 
where department_id=(
select department_id
from departments 
where department_name='Accounting'
));

-- 내 방법 
select first_name, job_id
from employees e 
inner join departments d 
on d.department_id = e.department_id
where upper(d.department_name) = upper('Accounting');

-- exists
select *
from employees 
where department_id=10;

-- 테이블 복사
drop table emp02;
create table emp02
as select employee_id, first_name
from employees; 

select * from emp02;

-- 서브쿼리를 이용해서 데이터 복사
-- 구조만 복사 department 테이블 생성(dep01)
drop table dep01;
create table dep01
as 
select * from departments
where 1=0;

-- 내용을 서브쿼리를 이용해서 저장하시오
--insert into dep01(컬럼명.. ) values (컬럼값.. )
insert into dep01 (
select * 
from departments
);
insert into dep01
select *
from departments;

-- updata 서브쿼리를 활용한다.
-- 부서 10번에 지역위치를 부서 40번 지역 위치로 수정하시오
--update dep01 
--set location_id=
--(2400)where department_id=10;
--select 

select * from employees;
select * from departments;
-- 문제1) 직급이 'ST_MAN'(job_id)인 직원이 받는 급여들의 최소 급여보다 많이 받는 직원들의 이름과 급여를 출력
-- 부서번호가 20번인 직원은 제외
-- 1. st_man 인 직원이 받는 급여가 중 최소 급여 = 5800
select min(salary)
from employees 
where job_id='ST_MAN';
-- 2. 1번의 조건보다 많이 받는 사람의 이름과 급여 출력
select first_name, salary, department_id 
from employees 
where salary>(
select min(salary)
from employees 
where job_id='ST_MAN'
);
-- 3. 2번의 조건에서 부서번호가 20번인 직원은 제외 
select first_name, salary, department_id 
from employees 
where salary>(
select min(salary)
from employees 
where job_id='ST_MAN'
)
and department_id <> 20;
-- 4. order by로 정렬해서 확인하기 
select first_name, salary, department_id 
from employees 
where salary>(
select min(salary)
from employees 
where job_id='ST_MAN'
)
and department_id <> 20
order by department_id;


-- 문제2) employees 테이블에서 Valli라는 이름을 가진 직원(e.first_name)과 업무명(d.department_name) 및 월급(e.salary)이 같은 사원의 모든 정보 출력 
-- 결과에서 Valli는 제외
-- 1. 이름이 Valli인 직원의 업무명과 월급 찾기(IT_PROG, 4800)
select job_id, salary
from employees 
where first_name='Valli';
-- 2. 1조건을 만족하는 쿼리문 틀 만들기 
select *
from employees 
where job_id='IT_PROG' and salary=4800;
-- 3. 2번에 그대로 첫번째 조건 집어넣기 
select *
from employees 
where job_id=(
select job_id
from employees 
where first_name='Valli'
)and salary=(
select salary
from employees 
where first_name='Valli'
);
-- 4. Valli는 제외시키기
select *
from employees 
where job_id=(
select job_id
from employees 
where first_name='Valli'
)and salary=(
select salary
from employees 
where first_name='Valli'
)
and first_name <> 'Valli';


-- 문제3) employees 테이블에서 월급이 Valli가 속한 부서의 평균 월급보다 높은 사원의 부서번호 이름 급여 출력
-- 1. Valli가 속한 부서 구하기 (60)
select department_id
from employees 
where first_name='Valli';
-- 2. 1조건의 부서(60번)의 평균 월급 구하기 (5760)
select round(avg(salary))
from employees 
where department_id=60;
-- 3. 틀 잡기
select department_id, first_name, salary
from employees 
where salary>5760;
-- 4. 틀에 값 집어넣기 
select department_id, first_name, salary
from employees
where salary > (
select round(avg(salary))
from employees 
where department_id=(
select department_id
from employees 
where first_name='Valli'
));

