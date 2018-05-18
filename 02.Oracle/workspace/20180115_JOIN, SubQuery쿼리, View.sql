--------------------------------------------------
--employees, departments, jobs, regions 테이블 관련 문제 풀이


--1. 이름(name_), 주민번호(ssn), 입사일(hiredate), 전화번호(phone) 출력
SELECT name_ AS 이름
    , ssn AS 주민번호
    , hiredate AS 입사일
    , phone AS 전화번호
FROM employees;


--2. 지역명(reg_name)이 '서울'인 직원의 이름(name_), 지역명(reg_name), 부서명(dept_name), 직위명(job_title) 출력. WHERE 구문 추가.
SELECT eid, name_
    , reg_name
    , dept_name
    , job_title
FROM employees e, regions r, departments d, jobs j
WHERE e.job_id = j.job_id 
    AND e.dept_id = d.dept_id
    AND e.reg_id = r.reg_id
    AND r.reg_name = '서울';
    

--3. 부서명(dept_name)이 '개발부', '영업부'인 사람만 출력. IN 연산자 사용.
SELECT eid, name_, dept_name
FROM employees e, departments d
WHERE e.dept_id = d.dept_id
    AND dept_name IN ('개발부', '영업부');
    

--4. 지역명(reg_name) 오름차순으로 정렬하고, 지역명(reg_name)이 같으면 기본급(basicpay) 내림차순
SELECT eid, name_
            , reg_name
            , basicpay
    FROM employees e, regions r
    WHERE e.reg_id = r.reg_id
    ORDER BY reg_name, basicpay DESC;



--5. 부서명(dept_name)이 '영업부'이고, 남자인 경우, 여자인 경우 인원수 출력.  
/*
출력 예)
영업부인원수   남자인원수   여자인원수
   XX	          XX	       XX
*/
SELECT COUNT(*) AS "영업부인원수"
    , COUNT(DECODE(gender, 1, 1)) AS "남자인원수"
    , COUNT(DECODE(gender, 2, 2)) AS "여자인원수"    
FROM (SELECT SUBSTR(ssn, 8, 1) AS gender
    , dept_name
    FROM employees e, departments d
        WHERE e.dept_id = d.dept_id
        AND dept_name = '영업부');
    

--6. 부서명(dept_name)별 남자와 여자 인원수 구하기
/*
출력예)
총무부	7	4	3
개발부	14	6	8
영업부	16	8	8
기획부	7	4	3
인사부	4	4	0
자재부	6	2	4
홍보부	6	3	3
*/
SELECT  dept_name
    COUNT(*) AS "부서별인원수"
    , COUNT(DECODE(gender, 1, 1)) AS "남자인원수"
    , COUNT(DECODE(gender, 2, 2)) AS "여자인원수"    
FROM (SELECT SUBSTR(ssn, 8, 1) AS gender
    , dept_name
    FROM employees e, departments d
        WHERE e.dept_id = d.dept_id)
GROUP BY dept_name;
        


--7. 지역명(reg_name)별 남자와 여자 인원수 구하기
SELECT reg_name AS "지역명"
   , COUNT(DECODE(gender, 1, 1)) AS "남자인원수"
   , COUNT(DECODE(gender, 2, 2)) AS "여자인원수"
FROM (SELECT SUBSTR(ssn, 8, 1) AS gender
    , reg_name
FROM employees e, regions r
WHERE e.reg_id = r.reg_id)
GROUP BY reg_name
ORDER BY reg_name;



------------------------------------------------
--뷰(View)

/*
1. 뷰란 이미 특정한 데이터베이스 내에 존재하는 하나 이상의 테이블에서 사용자가 얻기 원하는 데이터들만을 정확하고 편하게 가져오기 위하여 사전에 원하는 컬럼들 만을 모아서 만들어 놓은 가상의 테이블로 편리성 및 보안에 목적이 있다. 가상의 테이블이란 뷰가 실제로 존재하는 테이블이 아니라 하나 이상의 테이블에서 파생된 또 다른 정보를 볼 수 있는 방법 이며 그 정보들을 추출해내는 SQL 문장이라고 볼 수 있다.

2. CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰이름
	[(alias[, alias]...]
	AS subquery
	[WITH CHECK OPTION]
	[WITH READ ONLY];
    
3. 뷰 생성 권한을 부여 받은 경우만 실행 가능    
*/

--뷰 삭제
--DROP VIEW 뷰이름;







--------------------------------------------
--인라인 뷰
/*
1. 인라인 뷰는 FROM 절에서 서브 쿼리를 사용하여 생성한 임시 뷰이다. 인라인 뷰는 SQL 문이 실행되는 동안만 임시적으로 정의된다. 즉, 객체로서 저장되지 않는다.

2. 뷰 생성 권한 없어도 실행 가능.
*/

------------------------------------------
--특정 순위까지만 출력
--ROW_NUMBER() OVER(순서) 함수
SELECT ROW_NUMBER() OVER(ORDER BY name_) AS num_
    , eid, name_, phone
    FROM employees;

SELECT ROW_NUMBER() OVER(ORDER BY name_) AS num_
    , eid, name_, phone
    FROM employees
    WHERE num_ <= 5; --ORA-00904: "NUM_": invalid identifier

SELECT *
    FROM (SELECT ROW_NUMBER() OVER(ORDER BY name_) AS num_
    , eid, name_, phone
    FROM employees)
    WHERE num_ <= 5; --O



--'사원' 직위인 직원들만을 대상으로 (기본급 내림차순 정렬시) 특정 순위까지 출력

SELECT num_
    , eid, name_, phone, job_title, basicpay
FROM (SELECT ROW_NUMBER() OVER(ORDER BY basicpay DESC) AS num_, eid, name_, phone,  job_title, basicpay
    FROM employees e, jobs j
    WHERE e.job_id = j.job_id
    AND job_title = '사원')
WHERE num_ <= 5;
    
/*    
1	1005	한석봉	018-5211-3542	사원	1420000
2	1002	이순신	010-4758-6532	사원	1320000
3	1049	이미성	010-6654-8854	사원	1300000
4	1043	양미옥	016-8548-6547	사원	1100000
5	1025	우재옥	010-4563-2587	사원	1100000
*/
--> 동점자 처리 안된 상태





-----------------------------------------
--'사원' 직위(jobs.job_title)를 가진 직원 정보(employees.*) 출력
SELECT eid, name_, job_title
    FROM employees e, jobs j
    WHERE e.job_id = j.job_id
    AND job_title = '사원';

--'사원' 직위(jobs.job_title)를 가진 직원의 수 출력
SELECT COUNT(*) AS "사원수"
FROM (SELECT eid, name_, job_title
    FROM employees e, jobs j
    WHERE e.job_id = j.job_id
    AND job_title = '사원');

--'사원' 직위를 가진 직원 정보 삭제
DELETE FROM (SELECT eid, name_, job_title
    FROM employees e, jobs j
    WHERE e.job_id = j.job_id)
     WHERE job_title = '사원';

ROLLBACK;



--'사원' 직위(jobs.job_title)를 가진 직원의 수당(emp.extrapay)을 10% 인상.
UPDATE (SELECT eid, name_, job_title
    FROM employees e, jobs j
    WHERE e.job_id = j.job_id)
	SET extrapay = (extrapay * 1.1)
	 WHERE job_title = '사원';
    
ROLLBACK;



--직원 정보 중에서 부서별로 최고급여 받는 직원 정보 출력.
--출력시 부서명 출력 포함.

SELECT e.dept_id, dept_name, max_
FROM (SELECT dept_id, MAX(basicpay + extrapay) max_
    FROM employees
    GROUP BY dept_id) e, departments d
WHERE e.dept_id = d.dept_id;


SELECT dept_name, MAX(pay) max_
FROM (SELECT eid, name_, e.dept_id, dept_name, (basicpay+extrapay) pay
FROM employees e, departments d
WHERE e.dept_id = d.dept_id)
GROUP BY dept_name;



--문제) 직원 정보 중에서 부서별로 최고급여 받는 직원 정보 출력.
--출력시 직원아이디(eid), 직원이름(name_), 직원전화번호(phone)
--, 부서명(dept_name), 최고급여(max_) 출력 포함.

SELECT eid, name_, phone, max_, e1.dept_id, dept_name
FROM (SELECT dept_id, MAX(basicpay + extrapay) max_
    FROM employees
    GROUP BY dept_id) e1
    , (SELECT eid, name_, phone, dept_id, (basicpay+extrapay) pay FROM employees) e2
    , departments d
WHERE e1.dept_id = d.dept_id
AND e1.max_ = e2.pay;
    
/*
1001	홍길동	011-2356-4528	2810000	dept002	기획부
1003	이순애	010-4231-1236	2710000	dept001	개발부
1010	김종서	011-3214-5555	2670000	dept003	영업부
1019	박문수	017-4747-4848	2465000	dept004	인사부
1023	김인수		            2670000	dept003	영업부
1037	최석규	011-7777-7777	2537000	dept007	홍보부
1046	허경운	017-3333-3333	2800000	dept006	총무부
1057	이미경	016-6542-7546	2680000	dept005	자재부
*/






---------------------------------
--CREATE VIEW 뷰이름, DROP VIEW 뷰이름
--뷰 생성 권한이 있는 사용자만 실행 가능
--주의) 원본 쿼리가 join, sub query인 경우 뷰 등록 권장
/*
CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰이름
	[(alias[, alias]...]
	AS subquery
	[WITH CHECK OPTION]
	[WITH READ ONLY];
*/
--OR REPLACE 옵션 추가시 생성 및 수정 가능


--'사원' 직위(jobs.job_title)를 가진 직원의 수 출력
SELECT COUNT(*) AS "사원수"
FROM (SELECT eid, name_, job_title
    FROM employees e, jobs j
    WHERE e.job_id = j.job_id
    AND job_title = '사원');
-->뷰 객체로 등록
CREATE OR REPLACE VIEW emp_job_view
AS
SELECT eid, name_, job_title
    FROM employees e, jobs j
    WHERE e.job_id = j.job_id;
-->뷰 객체를 이용한 쿼리 실행
SELECT COUNT(*) AS "사원 인원수"
FROM emp_job_view
WHERE job_title = '사원';

SELECT COUNT(*) AS "대리 인워수"
FROM emp_job_view
WHERE job_title = '대리';


--DROP VIEW emp_job_view;


--------------------------------
-- WITH CHECK OPTION 지정 뷰
/*
WITH CHECK OPTION 절을 사용하면 뷰를 통해 참조 무결성(reference integrity)을 검사할 수 있고 DB 레벨에서의 constraint 적용이 가능하다.
*/


--------------------------------
--WITH CHECK OPTION 없는 뷰 생성 및 자료 입력 테스트

--'사원' 직위를 가진 직원 정보 출력
SELECT *
     FROM (SELECT eid, name_ , ssn, hiredate, phone
                   , e_.job_id, basicpay, extrapay
            FROM employees e_, jobs j
            WHERE e_.job_id = j.job_id)
     WHERE job_id =  (SELECT job_id FROM jobs WHERE job_title='사원');
     
     
--'사원' 직위를 가진 직원 정보를 보여주는 뷰 생성
CREATE OR REPLACE VIEW emp_jobs_view
AS
SELECT *
     FROM (SELECT eid, name_ , ssn, hiredate, phone
                   , e_.job_id, basicpay, extrapay
            FROM employees e_, jobs j
            WHERE e_.job_id = j.job_id)
     WHERE job_id =  (SELECT job_id FROM jobs WHERE job_title='사원');
     
     
--뷰를 이용한 자료 입력 (직위가 '사원'인 아닌 경우 준비)
INSERT INTO emp_jobs_view (eid, name_ , ssn, hiredate, phone
                    , job_id, basicpay, extrapay)
            VALUES ('1200', '홍길동', '901212-1234567'
                    , '2010-10-05', '010-1212-3434'
                    , (SELECT job_id FROM jobs WHERE job_title='과장')
                    , 2000000, 1000000);
-->1 행 이(가) 삽입되었습니다.

SELECT * FROM emp_jobs_view;
--> 신규 자료 검색 불가
--> '사원'이 아닌 자료는 검색되지 않는다.
--> 뷰를 이용한 입력시 잘못된 자료가 입력되는 것을 막을 수 없다.
--> WITH CHECK OPTION 지정 필요

SELECT * FROM employees;
--> 원본 테이블에서는 검색 가능

ROLLBACK;
--> 1200, 홍길동 자료 취소


-------------------------------------------
--WITH CHECK OPTION 지정 뷰 생성 및 자료 입력 테스트
--'사원' 직위를 가진 직원 정보를 보여주는 뷰 생성
CREATE OR REPLACE VIEW emp_jobs_view
AS
SELECT *
     FROM (SELECT eid, name_ , ssn, hiredate, phone
                   , e_.job_id, basicpay, extrapay
            FROM employees e_, jobs j
            WHERE e_.job_id = j.job_id)
     WHERE job_id =  (SELECT job_id FROM jobs WHERE job_title='사원')
WITH CHECK OPTION;

--뷰를 이용한 자료 입력 (직위가 '사원'인 아닌 경우 준비)
INSERT INTO emp_jobs_view (eid, name_ , ssn, hiredate, phone
                    , job_id, basicpay, extrapay)
            VALUES ('1200', '홍길동', '901212-1234567'
                    , '2010-10-05', '010-1212-3434'
                    , (SELECT job_id FROM jobs WHERE job_title='과장')
                    , 2000000, 1000000);
--> ORA-01402: view WITH CHECK OPTION where-clause violation

--뷰를 이용한 자료 입력 (직위가 '사원'인 경우 준비)
INSERT INTO emp_jobs_view (eid, name_ , ssn, hiredate, phone
                    , job_id, basicpay, extrapay)
            VALUES ('1200', '홍길동', '901212-1234567'
                    , '2010-10-05', '010-1212-3434'
                    , (SELECT job_id FROM jobs WHERE job_title='사원')
                    , 2000000, 1000000);
-->1 행 이(가) 삽입되었습니다.

SELECT * FROM emp_jobs_view;
--> 신규 자료 검색 가능
--> '사원'인 자료만 검색된다.
--> 뷰를 이용한 입력시 잘못된 자료가 입력되는 것을 막을 수 있다.

ROLLBACK;
-->1200, 홍길동 자료 취소



-------------------------------------------
--WITH READ ONLY 지정 뷰 생성 및 자료 입력 테스트
--'사원' 직위를 가진 직원 정보를 보여주는 뷰 생성
CREATE OR REPLACE VIEW emp_jobs_view
AS
SELECT *
     FROM (SELECT eid, name_ , ssn, hiredate, phone
                   , e_.job_id, basicpay, extrapay
            FROM employees e_, jobs j
            WHERE e_.job_id = j.job_id)
     WHERE job_id =  (SELECT job_id FROM jobs WHERE job_title='사원')
WITH READ ONLY;


--뷰를 이용한 자료 입력 (직위가 '사원'인 경우 준비)
INSERT INTO emp_jobs_view (eid, name_ , ssn, hiredate, phone
                    , job_id, basicpay, extrapay)
            VALUES ('1200', '홍길동', '901212-1234567'
                    , '2010-10-05', '010-1212-3434'
                    , (SELECT job_id FROM jobs WHERE job_title='사원')
                    , 2000000, 1000000);
-->ORA-42399: cannot perform a DML operation on a read-only view


SELECT * FROM emp_jobs_view;
--> 자료 검색 가능


---------------------------------------------

