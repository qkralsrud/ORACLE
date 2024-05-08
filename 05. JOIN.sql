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
