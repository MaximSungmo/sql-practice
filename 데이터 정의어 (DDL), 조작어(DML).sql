-- DDL 

-- 테이블 생성
create table member(
	no int not null auto_increment,
    email varchar(50) not null default '',
    passwd varchar(64) not null,
    name varchar(25),
    dept_name varchar(25),
    
    primary key(no)
);

-- 테이블 제거
drop table member;

-- 테이블 상태 확인 
desc member;

-- 칼럼을 지정하지 않고 테이블에 데이터 넣는 법
insert into member values(null, null, password('1234'), '강아지', '애교팀');
-- 칼럼을 지정하고 테이블에 데이터 넣는 법 
insert into member(passwd, name, dept_name)
values(password('1234'), '강아지', '애교팀');

-- 데이터가 잘 들어갔는 지 확인
select * from member;

-- 테이블 변경(수정)
alter table member add juminbunho char(13) not null;
-- 테이블이 변경되었는 지 확인
desc member;
-- 테이블 내 필드 제거 
alter table member drop juminbunho; 
-- 테이블 내 필드 위치 지정 (after 필드명)
alter table member add juminbunho char(13) not null after no;
desc member;

-- join_date 필드를 member 테이블에 추가 
alter table member add join_date datetime not null;
desc member;

-- member 테이블의 no 필드를 변경, auto_increment 제거 
alter table member change no no int unsigned not null;
desc member;
-- member 테이블의 no 필드를 변경, auto_increment 추가
alter table member change no no int unsigned not null auto_increment;
desc member;

-- member테이블의 dept_name 필드명을 department_name으로 변경, 주의사항으로 이름만 바꾼다고 하여도 타입까지 작성하여야 함.
alter table member change dept_name department_name varchar(25); 
desc member;

-- member테이블의 name 필드의 varchar(25) 에서 varchar(10)으로 변경 
alter table member change name name varchar(10) not null;

-- member 테이블의 이름을 user로 변경
alter table member rename user;
desc user;


-- 데이터 조작어(DML)
desc user;

-- 칼럼을 지정하지 않고 테이블에 데이터 넣는 법
insert into user values(null, '9001011100111', '', password('1234'), '강아지2', '애교팀', now());
-- 칼럼을 지정하고 테이블에 데이터 넣는 법 
insert into user(passwd, name, department_name)
values(password('1234'), '강아지', '애교팀');
-- 데이터 입력 확인 
select * from user;

-- user 테이블의 no가 1인 데이터의 join_date를 now()로 업데이트.
update user 
 set join_date = (select now())
 where no = 1;
-- 업데이트 내역 확인 
select * from user;

-- user 테이블의 no가 1인 데이터의 join_date를 now(), name은 'SungmoKim' 으로 업데이트.
update user
set join_date = now(),
	name = 'SungmoKim'
where no = 1;

-- user 테이블의 no가 2인 데이터 삭제.
delete from user where no = 2;
-- 삭제 내역 확인
select * from user;

