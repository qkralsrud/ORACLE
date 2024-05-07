-- 최대급여와 최소급여
SELECT MIN(SALARY) 최소급여, MAX(SALARY) 최대급여, FLOOR(AVG(SALARY)) 평균급여
        , COUNT(SALARY) 사원수, SUM(SALARY) 급여합계
FROM EMP;
/*
    <GROUP BY>
        그룹 기준을 제시할 수 있는 구문
        여러 개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용한다.
*/
-- 전체 사원을 하나의 그룹으로 묶어서 충합을 구한 결과 조회
-- 전체 사원을 하나의 그룹으로 묶어 총 합을 구한 결과
SELECT  SUM(SALARY)
FROM    EMP;

-- 부서별(그룹으로 묶은) 급여의 합계
-- GROUP BY 표현식이 아닙니다.
SELECT  EMP_NAME, DEPT_CODE, SUM(SALARY)
FROM    EMP
GROUP BY DEPT_CODE;

-- 부서별 사원의 수
-- NULL은 세지 않으므로 값이 다르게 나올수 있다!!!!!!
SELECT DEPT_CODE, COUNT(DEPT_CODE), COUNT(*)
FROM EMP
GROUP BY DEPT_CODE;

-- 각 부서별 보너스를 받는 사원수
SELECT  DEPT_CODE 부서, COUNT(BONUS) "보너스 받는 사원 수"
FROM    EMP
GROUP BY DEPT_CODE
--ORDER BY "보너스 받는 사원 수" DESC;
--ORDER BY 2 DESC;
ORDER BY COUNT(BONUS);

-- 각 직급별 급여 평균 조회
SELECT  JOB_CODE 직급코드
    , TO_CHAR(FLOOR(AVG(NVL(SALARY,0))),'999,999,999') 평균급여
FROM    EMP
GROUP BY JOB_CODE;

-- 부서별 사원수, 보너스를 받는 사원수, 급여의 합, 평균 급여, 최고 급여, 최저 급여를 조회
SELECT  DEPT_CODE 부서코드, COUNT(*) 사원수
        , TO_CHAR(SUM(SALARY),'999,999,999') 급여의합
        , TO_CHAR(FLOOR(AVG(NVL(SALARY,0))),'999,999,999') 평균급여
        , TO_CHAR(MAX(SALARY),'999,999,999') 최고급여
        , TO_CHAR(MIN(SALARY),'999,999,999') 최저급여
FROM    EMP
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE NULLS FIRST;

-- 입사일별 사원수
SELECT TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') 입사일, COUNT(*) 입사자수
FROM EMP
GROUP BY HIRE_DATE;

SELECT * FROM EMP;

-- 입사년도별 사원의 수
SELECT  TO_CHAR(HIRE_DATE, 'YYYY') 년도,  COUNT(*) 입사자수
FROM    EMP
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY')
ORDER BY 년도;

SELECT  TO_CHAR(HIRE_DATE, 'YYYY') 년도, TO_CHAR(HIRE_DATE, 'MM') 월 ,  COUNT(*) 입사자수
FROM    EMP
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY'), TO_CHAR(HIRE_DATE, 'MM')
ORDER BY 년도;

-- 성별 별 사원수
SELECT  DECODE(SUBSTR(EMP_NO, 8,1), '1', '남자', '2', '여자') 성별, COUNT(*)
FROM    EMP
GROUP BY SUBSTR(EMP_NO, 8,1);

-- 부서별 직급별 사원의 수, 급여의합계
SELECT  DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM    EMP
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1,2;

/*
    <HAVING>
        그룹에 대한 조건을 제시할 때 사용하는 구문(주로 그룹 함수의 결과를 가지고 비교 수행)
    
    * 실행 순서
        5: SELECT      조회하고자 하는 컬럼명 AS "별칭" | 계산식 | 함수식
        1: FROM        조회하고자 하는 테이블명
        2: WHERE       조건식
        3: GROUP BY    그룹 기준에 해당하는 컬럼명 | 계산식 | 함수식
        4: HAVING      그룹에 대한 조건식
        6: ORDER BY    정렬 기준에 해당하는 컬럼명 | 별칭 | 컬럼 순번
*/
-- 각 부서별 평균 급여 조회
SELECT  DEPT_CODE, FLOOR(AVG(NVL(SALARY, 0))) 평균급여
FROM    EMP
GROUP BY DEPT_CODE;

SELECT  *
FROM    EMP
WHERE   SALARY >= 3000000;
-- 각 부서별 급여가 300만원 이상인 직원의 평균 급여 조회 
SELECT  DEPT_CODE, FLOOR(AVG(NVL(SALARY, 0))) 평균급여
FROM    EMP
WHERE   SALARY >= 3000000
GROUP BY DEPT_CODE;
-- 각 부서별 평균 급여가 300만원 이상인 부서들만 조회
SELECT  DEPT_CODE, FLOOR(AVG(NVL(SALARY, 0))) 평균급여
FROM    EMP
-- 그룹 함수는 허가되지 않습니다
-- WHERE   AVG(NVL(SALARY, 0)) >= 3000000
GROUP BY DEPT_CODE
HAVING AVG(NVL(SALARY, 0)) >= 3000000;

-- 직급별 총 급여의 합이 10000000 이상인 직급들만 조회
SELECT  JOB_CODE, SUM(SALARY)
FROM    EMP
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- 부서별 보너스를 받는 사원이 없는 부서들만 조회
SELECT  DEPT_CODE, COUNT(BONUS)
FROM    EMP
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

/*
    <집계 함수>
        그룹별 산출한 결과 값의 중간 집계를 계산 해주는 함수
*/
-- 직급별 급여의 합계 
SELECT  JOB_CODE, SUM(SALARY)
FROM    EMP
GROUP BY JOB_CODE;

-- 마지막행에 전체 총 급여의 합계를 조회
SELECT  JOB_CODE, SUM(SALARY)
FROM    EMP
GROUP BY ROLLUP(JOB_CODE);

-- 부서 코드도 같고 직급 코드도 같은 사원들을 그룹 지어서 급여의 합계를 조회
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMP
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE, JOB_CODE;






