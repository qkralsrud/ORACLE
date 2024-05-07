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

--INNERJION--

-- 각 사원들의 사번, 사원명, 부서 코드, 부서명을 조회 
--총사원수는 23명 이나 21명 추출됨 2명 누락 
--일치하는 데이터만 추출! (부서코드의 NULL은 제외됨)
SELECT EMP_ID,EMP_NAME,DEPT_CODE,DEPT_ID, DEPT_TITLE
FROM  EMP,DEPT
ORDER BY EMP_ID, DEPT_ID;
--WHERE DEPT_CODE = DEPT_ID;


SELECT EMP_ID,EMP_NAME,DEPT_CODE,DEPT_ID, DEPT_TITLE
FROM EMP
JOIN DEPT ON (DEPT_ID= DEPT_CODE);

SELECT COUNT(*) FROM EMP; --23건
SELECT COUNT(*) FROM DEPT; --9건

--사원 테이블에서 누락된 데이터 찾기
--1) 차집합을 이용 
--전체사원의 결과 집합 -조인문의 결과 집합 
SELECT * 
FROM EMP

MINUS
--EMP 테이블과 DEPT테이블의 컬럼을 연결해서 보여줘 그대신 DEPT_ID랑 DEPT_CODE가 같은것만 보여줘 
SELECT EMP.*
FROM EMP
JOIN DEPT ON (DEPT_ID = DEPT_CODE);

--부서테이블에서 사용되지 않은 부서코드를 찾아봅시다.
--조인결과 중복을 제거
SELECT DISTINCT(DEPT_ID)
FROM EMP
JOIN DEPT ON DEPT_CODE = DEPT_ID;

--사원이 배정되지 않은 부서
SELECT * 
FROM DEPT
WHERE DEPT_ID NOT IN (
                    SELECT DISTINCT(DEPT_ID)
                    FROM EMP
                    JOIN DEPT ON DEPT_CODE = DEPT_ID
                    );
                    

-- 각 사원들의 사번, 사원명, 직급 코드, 직급명을 조회 

SELECT EMP_ID, EMP_NAME,EMP.JOB_CODE,JOB_NAME
FROM EMP , JOB 
WHERE EMP.JOB_CODE = JOB.JOB_CODE;

--ANSI 구문
SELECT *
FROM EMP
JOIN JOB USING (JOB_CODE);

-- EMP 테이블과 JOB 테이블을 조인하여 직급이 대리인 사원의
-- 사번, 사원명, 직급명, 급여를 조회 
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMP
JOIN JOB  ON EMP.JOB_CODE = JOB.JOB_CODE
WHERE JOB.JOB_NAME = '대리';

SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMP,JOB
WHERE EMP.JOB_CODE = JOB.JOB_CODE
AND JOB_NAME ='대리';


/*
    2. 다중 JOIN
      여러개의 테이블을 조인 하는 경우 사용
*/
-- 사번, 사원명, 부서명, 지역명 조회 
SELECT * FROM EMP; 
SELECT * FROM DEPT;
SELECT * FROM LOCATION;

--오라클 구문 
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,LOCAL_NAME 
FROM EMP, DEPT, LOCATION
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE;

--ANSI 구문 
--다중조인의 경우 순서가 중요하다
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,LOCAL_NAME 
FROM EMP
JOIN DEPT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);


/*
    3. 외부조인(OUTTER JOIN)
        테이블간에 JOIN시 조건에 일치하지 않는 행도 포함시켜서 조회
        기준이 되는 테이블을 지정 해야 한다(LEFT/RIGNT/(+))
*/
-- 1) LEFT [OUTER] JOIN 
--      두 테이블중 왼편에 기술된 테이블의 컬럼을 기준으로 JOIN을 진행
--      JOIN 조건이 일치하지 않아도 왼쪽에 테이블을 모두 출력 





-- 2) RIGHT [OUTER] JOIN 
--    두 테이블 중 오른편에 기술된 테이블의 컬럼을 기준으로 JOIN을 진행
--    오른쪽 테이블을 모두 출력
-- 사원이름, 부서명, 급여를 출력하는데 부서테이블의 모든 데이터가 출력되도록 


-- 3) FULL [OUTER] JOIN : 두 테이블이 가지는 모든 행을 조회
--    오라클 구문은 지원하지 않음 


-- 1. DEPT 테이블과 LOCATION 테이블의 조인하여 
-- 부서 코드, 부서명, 지역 코드, 지역명을 조회 
SELECT 


























