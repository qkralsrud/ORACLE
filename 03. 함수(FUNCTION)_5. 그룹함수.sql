/*
    <그룹 함수>
        대량의 데이터들로 집계나 통계 같은 작업을 처리해야 하는 경우 사용되는 함수들이다.
        모든 그룹 함수는 NULL 값을 자동으로 제외하고 값이 있는 것들만 계산을 한다.
        따라서 AVG 함수를 사용할 때는 반드시 NVL() 함수와 함께 사용하는 것을 권장한다.
        
        1) SUM
            [표현법]
                SUM(NUMBER)
                
            - 해당 컬럼 값들의 총 합계를 반환한다.
*/

-- EMPLOYEE 테이블에서 전사원 총 급여의 합계
SELECT TO_CHAR(SUM(SALARY),'L99,999,999')||'원' 총급여
FROM EMP;

-- EMPLOYEE 테이블에서 남자 사원의 총 급여의 합계
SELECT  --EMP_NO
        SUM(SALARY)
FROM    EMP
-- 조건절
WHERE   SUBSTR(EMP_NO, 8,1) = 1;

-- EMPLOYEE 테이블에서 전사원 총 연봉의 합계
SELECT  SUM(SALARY*12)
FROM    EMP;

-- EMPLOYEE 테이블에서 D1부서의 총 연봉의 합계
SELECT  SUM(SALARY*12)
FROM    EMP
WHERE   DEPT_CODE = 'D1';

/*
        2) AVG
            [표현법]
                AVG(NUMBER)
            
            - 해당 컬럼 값들의 평균을 구해서 반환한다.
*/
-- NULL이 있을수 있기 때문에 확인하는 작업
SELECT  TO_CHAR(FLOOR(AVG(SALARY)),'999,999,999') 평균급여
FROM    EMP;
SELECT  SUM(SALARY), COUNT(SALARY), SUM(SALARY)/COUNT(SALARY)
FROM    EMP;

/*
        3) COUNT
            [표현법]
                COUNT(*|컬럼명|DISTINCT 컬럼명)
            
            - 컬럼 또는 행의 개수를 세서 반환하는 함수이다.
            - COUNT(*) : 조회 결과에 해당하는 모든 행의 개수를 반환한다.
            - COUNT(컬럼명) : 제시한 컬럼 값이 NULL이 아닌 행의 개수를 반환한다.
            - COUNT(DISTINCT 컬럼명) 해당 컬럼 값의 중복을 제거한 행의 개수를 반환한다. 
*/
-- 전체 사원 수
SELECT COUNT(*)
FROM EMP;

-- 여자 사원의 수
SELECT  COUNT(*)
FROM    EMP
WHERE   (SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4');

-- 보너스를 받는 직원의 수 
SELECT  COUNT(BONUS)
FROM    EMP;

-- 쿼리실행결과(RESULT SET)의 갯수를 세어준다
SELECT  COUNT(*)
FROM    EMP
WHERE   BONUS IS NOT NULL;

-- 퇴사한직원   ENT_DATE, ENT_YN
SELECT  COUNT(ENT_DATE)
FROM    EMP;

SELECT  COUNT(*)
FROM    EMP
WHERE   ENT_YN = 'Y';

-- 현재 사원들이 속해 있는 부서의 수
-- 총 사원은 23명인데, 21인 이유? NULL(부서가 지정되지 않은사람) 2명
SELECT  COUNT(DISTINCT DEPT_CODE)
FROM    EMP;

SELECT  DISTINCT DEPT_CODE
FROM    EMP;

-- 현재 사원들이 속해 있는 직급의 수
SELECT  COUNT(DISTINCT JOB_CODE)
FROM    EMP;







