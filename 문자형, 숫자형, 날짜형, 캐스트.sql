-- 문자형 함수

-- 대문자로 바꾸는 함수 
select upper('Seoul'), ucase('seoul');
select upper(first_name) from employees;

-- 소문자로 바꾸는 함수 
select lower('Seoul'), lcase('seoul');

-- 데이터 중간 가져오기 (3번부터 2개(4번까지) 가져오기)
select substring('Happy Day', 3, 2);
select hire_date from employees where substring(hire_date, 1,4) = '1989';

-- 패딩(양 옆에 데이터 부족하면 채우는 것)
-- hi데이터를 5 자릿수로 가져올건데 부족하다면 ?로 채워줘 
select lpad('hi', 5, '?');

select rpad('hi', 5, '---');
select emp_no, lpad(salary, 10, '*') from salaries where from_date like '2001-%' and salary <70000;

-- trim(옆 공백 제거하는 것)
select concat(ltrim('    hello'),"    ",'*'); 
-- trim 변형
select concat('---', trim(both 'x' from 'xxxhelloxx'));

-- 숫자형 함수
select abs(1), abs(-1);
-- 나누기 후 나머지
select mod(234, 10), 234%10;
select floor(1.234), ceiling(1.2342);
-- 반올림
select round(-1.23), round(-1.58);
-- 2의 3제곱 // 2의 -3제곱 
select pow(2,3), power(2, -3);

-- 가장 큰 것 찾기
select greatest(98, 30, 25);
select greatest('a', 'D', 'e');

-- 날짜형 함수
select curdate(), current_date;
select curtime(), current_time;

-- 차이점은 now는 쿼리 실행 전에 값을 상수로 받아버리고 sysdate는 실행된 시점에서 값을 받음; 
select now(), sysdate(), current_timestamp();
select now(), sleep(2), now();
-- sysdate는 변화의 위험이 있으므로 now함수로 시간이 동일하게 잡는 것이 위험이 적을 것 같음.
select sysdate(), sleep(2), sysdate();

-- 데이터 포멧 지정해주기
select date_format(now(), '%Y년 %c월 %d일 %h시 %i분 %s초') as 'now';

select concat(first_name, ' ', last_name) as name, 
		period_diff(DATE_FORMAT(curdate(), '%Y%m'), DATE_FORMAT(hire_date, '%Y%m')) where employees;

select first_name, hire_date, 
date_add(hire_date, interval 5 month) as 'after 5 months'
from employees;

-- 형변환
select cast(now() as date);

select cast(cast(1-2 as unsigned) as signed);


