show tables;

desc department;
desc employee;

insert into department values(null, '총무팀');
insert into department values(null, '개발팀');
insert into department values(null, '인사팀');
insert into department values(null, '영업팀');


select * from department;

insert into employee values(null, '둘리', 1);
insert into employee values(null, '마이콜', 2);
insert into employee values(null, '또치', 3);
insert into employee values(null, '길동이', null);

select * from employee;

-- left join (outter join)
SELECT 
    e.name, ifnull(d.name, '없음')  as department
FROM
    employee e
        LEFT JOIN
    department d ON (e.department_no = d.no);

-- right join (outter join)
SELECT 
    ifnull(e.name,"없음"), d.name AS department
FROM
    employee e
        RIGHT JOIN
    department d ON (e.department_no = d.no);
    
-- full join -- (outter join, mysql/mariadb 지원 안함)
-- SELECT 
--     e.name, d.name AS department
-- FROM
--     employee e
--         full JOIN
--     department d ON (e.department_no = d.no);

