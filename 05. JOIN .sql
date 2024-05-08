/*
    <JOIN>
    두 개의 이상의 테이블에서 데이터를 조회하고자 할 때 사용하는 구문이다.
    
    1. 등가 조인(EQUAL JOIN) / 내부 조인(INNER JOIN)
    연결시키는 컬럼의 값이 일치하는 행들만 조인되서 조회한다.
    (일치하는 값이 없는 행은 조회 X)   
    
    1) 오라클 전용구문
        SELECT 컬럼, 컬럼, ...
        FROM   테이블1, 테이블2
        WHERE  테이블1.컬럼명 = 테이블2.컬럼명;
        
        - FROM절에 조회하고자 하는 컬럼들을 ,(콤마)로 구분하여 나열
        - WHERE절에 매칭시킬 컬럼에 대한 조건을 제시 한다.
    
    2) ANSI 표준 구문
        SELECT  컬럼, 컬럼, ...
        FROM    테이블1
        [INNER] JOIN 테이블2 ON (테이블1.컬럼명 = 테이블2.컬럼명);
        [INNER] JOIN 테이블2 USING (컬럼명);
        - FROM절에 기준이 되는 테이블을 기술
        - JOIN 절에 같이 조회하고자 하는 테이블을 기술후 조건을 명시
        - 연결에 사용하려는 커럼명이 같은 경우 ON절 
          대신 USING(컬럼명)을 사용 
*/
-- 각 사원들의 사번, 사원명, 부서 코드, 부서명을 조회
SELECT COUNT(*) FROM EMP; --23건
-- DEPT_CODE
SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMP;
SELECT COUNT(*) FROM DEPT; --9건
-- DEPT_ID
SELECT DEPT_ID, DEPT_TITLE FROM DEPT;
-- 오라클 구문
-- 1) 연결할 컬럼이 다른경우
-- 207 = 23 * 9
SELECT COUNT(*) FROM EMP; -- 23건
SELECT COUNT(*) FROM DEPT; -- 9건
SELECT  *
FROM    EMP, DEPT
WHERE   DEPT_CODE = DEPT_ID; -- 21건
-- INNER JOIN : 조인 조건에 만족하는 값만 조회
-- 사원 테이블에서 누락된 데이터 찾기
-- 1) 차집합을 이용
-- 전체 사원의 결과집합 - 조인문의 결과집합
-- 일치하지 않는 값을 조회 해봅시다
-- EMP 테이블 제외 : DEPT_ID에  NULL
SELECT * FROM EMP
MINUS
SELECT  EMP.*    -- EMP테이블이 가지고 있는 모든 컬럼을 조회
FROM    EMP, DEPT
WHERE   DEPT_CODE = DEPT_ID ; -- 조인 조건

-- 부서테이블에서 사용되지 않은 부서코드를 찾아봅시다
-- 조인결과 중복을 제거
SELECT  DISTINCT(DEPT_ID)
FROM    EMP, DEPT
WHERE   DEPT_CODE = DEPT_ID;
-- 사원이 배정되지 않은 부서 3개
SELECT * 
FROM DEPT
WHERE DEPT_ID NOT IN (
    SELECT  DISTINCT(DEPT_ID)
    FROM    EMP, DEPT
    WHERE   DEPT_CODE = DEPT_ID
);
-- 표준 ANSI
SELECT  EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM    EMP
JOIN    DEPT ON (DEPT_ID = DEPT_CODE);

-- 각 사원들의 사번, 사원명, 직급 코드, 직급명을 조회
-- 오라클 구문
-- 열의 정의가 애매합니다 : 테이블에 동일한 컬럼이 있는경우!
SELECT  EMP_ID, EMP_NAME, EMP.JOB_CODE, JOB_NAME
FROM    EMP, JOB
-- 컬럼명이 동일한 경우 컬럼명 앞에 테이블명을 명시한다
WHERE   EMP.JOB_CODE = JOB.JOB_CODE; 

-- 테이블에 별칭을 사용한 경우 SELECT절/WHERE절에서는 별칭을 이용해서 접근
SELECT  EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM    EMP E, JOB J
WHERE   E.JOB_CODE = J.JOB_CODE;

-- ANSI 구문
-- USING 절의 열 부분은 식별자를 가질 수 없음
-- USING절에 사용된 컬럼은 테이블이름을 앞에 붙일 수 없다
SELECT  EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM    EMP
JOIN    JOB USING (JOB_CODE);
-- ON절 - 컬럼명이 동일한 경우 테이블의 이름을 컬럼앞에 명시
SELECT  EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM    EMP E
JOIN    JOB J ON (E.JOB_CODE = J.JOB_CODE);


/*
	* ANSI SQL
	DBMS(Oracle, My-SQL, DB2 등등)들에서 각기 다른 SQL를 사용하므로, 
	미국 표준 협회(American National Standards Institute)에서 이를 
    표준화하여 표준 SQL문을 정립 시켜 놓은 것이다.
*/

-- EMP 테이블과 JOB 테이블을 조인하여 직급이 대리인 사원의
-- 사번, 사원명, 직급명, 급여를 조회
-- 오라클 구문
SELECT  EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM    EMP, JOB
WHERE   EMP.JOB_CODE = JOB.JOB_CODE
AND     EMP.JOB_CODE = 'J6';-- JOB_NAME = '대리';

-- ANSI 구문
SELECT  EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM    EMP
--JOIN    JOB USING (JOB_CODE)
JOIN    JOB ON (EMP.JOB_CODE = JOB.JOB_CODE)
WHERE   JOB_NAME='대리';

/*
    2. 다중 JOIN
      여러개의 테이블을 조인 하는 경우 사용
*/
-- 사번, 사원명, 부서명, 지역명 조회
SELECT * FROM EMP;  -- DEPT_CODE
SELECT * FROM DEPT; -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION; -- LOCAL_CODE

-- 오라클 구문
SELECT  EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM    EMP, DEPT, LOCATION
WHERE   DEPT_CODE = DEPT_ID
AND     LOCATION_ID = LOCAL_CODE;

-- ANSI 구문 
-- 다중조인의 경우 순서가 중요하다
SELECT  EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM    EMP
-- INNER 생략 가능
/*INNER*/ JOIN    DEPT ON (DEPT_CODE=DEPT_ID)
JOIN    LOCATION ON (LOCATION_ID = LOCAL_CODE);

/*
    3. 외부조인(OUTTER JOIN)
        테이블간에 JOIN시 조건에 일치하지 않는 행도 포함시켜서 조회
        기준이 되는 테이블을 지정 해야 한다(LEFT/RIGNT/(+))
*/

-- 1) LEFT [OUTER] JOIN 
--      두 테이블중 왼편에 기술된 테이블의 컬럼을 기준으로 JOIN을 진행
--      JOIN 조건이 일치하지 않아도 왼쪽에 테이블을 모두 출력

-- 누락된 사원 2명을 모두 출력 하고 싶어요!
-- 오라클 구문
SELECT  EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE
FROM    EMP, DEPT
WHERE   EMP.DEPT_CODE = DEPT.DEPT_ID(+);

-- ANSI 구문
SELECT  EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE
FROM    EMP   
LEFT /*OUTER*/ JOIN    DEPT ON (DEPT_CODE = DEPT_ID);

-- 2) RIGHT [OUTER] JOIN 
--    두 테이블 중 오른편에 기술된 테이블의 컬럼을 기준으로 JOIN을 진행
--    오른쪽 테이블을 모두 출력
-- 사원이름, 부서명, 급여를 출력하는데 부서테이블의 모든 데이터가 출력되도록

-- 오라클
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM    EMP, DEPT
WHERE   EMP.DEPT_CODE(+) = DEPT.DEPT_ID;

-- ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM    EMP 
RIGHT OUTER JOIN    DEPT ON (DEPT_CODE = DEPT_ID);

-- 3) FULL [OUTER] JOIN : 두 테이블이 가지는 모든 행을 조회
--    오라클 구문은 지원하지 않음
-- 조회조건만족                           21건 
-- 사원테이블 부서코드가 NULL인             2건 
-- 부서테이블 사원이 배정되지 않은 부서코드   3건
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM   EMP 
FULL OUTER JOIN    DEPT ON (DEPT_CODE = DEPT_ID);

-- 1. DEPT 테이블과 LOCATION 테이블의 조인하여 
-- 부서 코드, 부서명, 지역 코드, 지역명을 조회
-- 오라클 문법
SELECT  DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM    DEPT, LOCATION
WHERE   LOCATION_ID = LOCAL_CODE;

-- ANSI문법
SELECT  DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM    DEPT
JOIN    LOCATION ON (LOCATION_ID = LOCAL_CODE);

/*
4. 카테시안곱(CARTESIAN PRODUCT) / 교차 조인(CROSS JOIN)
    조인되는 모든 테이블의 각 행들이 서로서로 모두 매핑된 데이터가 검색된다.
    테이블의 행들이 모두 곱해진 행들의 조합이 출력 -> 과부화의 위험
*/
SELECT COUNT(*) FROM EMP; -- 23건
SELECT COUNT(*) FROM DEPT; -- 9건

--23*9 = 207
SELECT  *
FROM    EMP, DEPT
ORDER BY EMP_ID;

-- ANSI
SELECT  COUNT(*)
FROM    EMP
CROSS JOIN DEPT;

/*
5. 비등가 조인(NON EQUAL JOIN)
    조인 조건에 등호(=)를 사용하지 않는 조인문을 비등가 조인이라고 한다.
    지정한 컬럼 값이 일치하는 경우가 아닌, 
    값의 범위에 포함되는 행들을 연결하는 방식이다.
    ( = 이외에 비교 연산자 >, <, >=, <=, 
    BETWEEN AND, IN, NOT IN 등을 사용한다.)
    ANSI 구문으로는 JOIN ON 구문으로만 사용이 가능하다. (USING 사용 불가)    
*/
/* 급여등급 테이블 생성 */
CREATE TABLE SAL_GRADE(
	SAL_LEVEL CHAR(2 BYTE), 
	MIN_SAL NUMBER, 
	MAX_SAL NUMBER
);
COMMENT ON COLUMN SAL_GRADE.SAL_LEVEL IS '급여등급';
COMMENT ON COLUMN SAL_GRADE.MIN_SAL IS '최소급여';
COMMENT ON COLUMN SAL_GRADE.MAX_SAL IS '최대급여';
COMMENT ON TABLE SAL_GRADE IS '급여등급'; 

Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL)
                                values ('S1',6000000,10000000);
Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL) 
                                values ('S2',5000000,5999999);
Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL) 
                                values ('S3',4000000,4999999);
Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL) 
                                values ('S4',3000000,3999999);
Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL) 
                                values ('S5',2000000,2999999);
Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL) 
                                values ('S6',1000000,1999999); 
COMMIT;

SELECT * FROM SAL_GRADE;

-- 비등가조인
SELECT  EMP_NAME, SALARY, SAL_LEVEL, MAX_SAL, MIN_SAL
FROM    EMP, SAL_GRADE
WHERE   SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- 범위가 중복되는경우, 사원이 여러 급여등급을 가질수 있다(중복)
UPDATE SAL_GRADE SET MAX_SAL = 2999999 WHERE SAL_LEVEL = 'S5';
COMMIT;

/*
6. 자체 조인(SELF JOIN)
    같은 테이블을 다시 한번 조인하는 경우에 사용한다.
*/
-- 사원 테이블에는 매니저의 사번이 들어있는 컬럼(MANAGER_ID)이 있다

SELECT  E.EMP_ID 사번, E.EMP_NAME 이름, E.MANAGER_ID 매니저사번, M.EMP_NAME 매니져이름
FROM    EMP E, EMP M
WHERE   E.MANAGER_ID = M.EMP_ID(+);

SELECT * FROM EMP;

-- ANSI 구문
SELECT  E.EMP_ID 사번, E.EMP_NAME 이름, E.MANAGER_ID 매니저사번, M.EMP_NAME 매니져이름
FROM    EMP E
LEFT /*OUTER*/ JOIN    EMP M ON (E.MANAGER_ID = M.EMP_ID);

-- 실습문제
-- 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명을 조회
-- 오라클
SELECT  EMP_ID, EMP_NAME, BONUS, DEPT_TITLE 
FROM    EMP, DEPT
WHERE   DEPT_CODE = DEPT_ID
AND     BONUS IS NOT NULL;
-- ANSI
SELECT  EMP_ID, EMP_NAME, BONUS, DEPT_TITLE 
FROM    EMP
JOIN    DEPT ON (DEPT_CODE = DEPT_ID)
WHERE   BONUS IS NOT NULL;

-- 인사관리부가 아닌 사원들의 사원명, 부서명, 급여를 조회
-- 오라클
-- 누락된 사원 (부서코드가 입력되지 않은 사원)
SELECT  EMP_NAME, DEPT_TITLE, SALARY
FROM    EMP, DEPT
-- 조인 조건이 일치 하지 않아도 조회!!!!
WHERE   EMP.DEPT_CODE = DEPT.DEPT_ID(+)
-- NULL은 비교되지 않으므로 따로 확인
AND     (DEPT_TITLE != '인사관리부' OR DEPT_TITLE IS NULL);
SELECT * FROM EMP WHERE DEPT_CODE IS NULL;

-- ANSI
SELECT  EMP_NAME, NVL(DEPT_TITLE, '부서없음'), NVL(DEPT_CODE, '부서없음'), SALARY
FROM    EMP LEFT JOIN    DEPT ON (DEPT_CODE = DEPT_ID)
-- NULL은 비교가 되지 않으므로 다른문자로 변경해준다
-- NULL값을 부서없음으로 변경후 실행
WHERE   NVL(DEPT_TITLE, '부서없음') != '인사관리부';

-- 사번, 사원명, 부서명, 지역명, 국가명 조회
-- 누락되는 사원이 없이 조회해봅시다
SELECT  EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM    EMP, DEPT, LOCATION, NATIONAL
-- (+) : 조인조건이 일치하지 않는 데이터를 조회 하기 위해서
-- 어느테이블이 가진 데이터를 가지고 올것인지 
WHERE   DEPT_CODE = DEPT_ID(+)
AND     LOCATION_ID = LOCAL_CODE(+)
AND     LOCATION.NATIONAL_CODE = NATIONAL.NATIONAL_CODE(+);

-- ANSI
SELECT  EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM    EMP
LEFT JOIN    DEPT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN    LOCATION ON (LOCATION_ID = LOCAL_CODE)
LEFT JOIN    NATIONAL USING (NATIONAL_CODE);

-- 사번, 사원명, 부서명, 지역명, 국가명, 급여 등급 조회
-- 급여등급이 S1,S2 이면 고급, S3,S4는 중급, S5,S6은 초급 , 해당하지 않으면 ''
SELECT  EMP_ID, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
        , SAL_LEVEL 급여등급
        , CASE
        , DECODE
FROM    EMP, DEPT, LOCATION, NATIONAL, SAL_GRADE
WHERE   DEPT_CODE = DEPT_ID(+)
AND     LOCATION_ID = LOCAL_CODE(+)
AND     LOCATION.NATIONAL_CODE = NATIONAL.NATIONAL_CODE(+)
AND     SALARY BETWEEN MIN_SAL AND MAX_SAL;
-- JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

-- 부서별 최고 급여를 받는사람 
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM    EMP
WHERE   (DEPT_CODE, SALARY) IN (    SELECT  DEPT_CODE, MAX(SALARY)
                                    FROM    EMP
                                    GROUP BY DEPT_CODE
                                    );


SELECT  MAX(SALARY)
FROM    EMP
GROUP BY DEPT_CODE;


SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMP
-- 서브쿼리의 조회 결과가 단일행인경우 = 또는 IN을 사용할 수있다
-- 서브쿼리의 조회 결과가 다중행인경우 = 을 사용시 오류가 발생 합니다!!!!!!!
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE 
                                    FROM EMP
                                    WHERE SUBSTR(EMP_NO, 8, 1)=2 AND ENT_YN='Y');

SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID
FROM EMP E
WHERE EXISTS (SELECT EMP_ID
                FROM EMP M
                WHERE M.EMP_ID = E.MANAGER_ID);
                
-- 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
-- 값의 수가 너무 많습니다
SELECT E.EMP_ID, E.EMP_NAME, E.MANAGER_ID,
        NVL((SELECT M.EMP_NAME, EMP_ID
                FROM EMP M
                WHERE E.MANAGER_ID = M.EMP_ID), '없음') AS 관리자명
FROM EMP E
ORDER BY 1; 









