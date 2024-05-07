/*
    <그룹함수>
        대량의 데이터들로 집계나 통계같은 작업을 처리해야 하는 경우 사용 하는 함수
        모든 그룹함수는 NULL 값을 자동으로 제외
        => NVL()함수와 함께 사용하는것을 권장 합니다.
    
    1) SUM(NUMBER) 
        - 해당 컬럼의 총 합계를 반환 합니다
    2) AVG(NUMBER)
        - 해당 컬럼의 평균을 반환 합니다.
    3) MIN(모든타입) / MAX(모든타입)
        - MIN : 해당 컬럼의 값들중 가장 작은 값을 반환 합니다.
        - MAX : 해당 컬럼의 값들중 가장 큰 값을 반환 합니다.
    4) COUNT(*|컬럼명)
        - 결과 행의 갯수를 세서 반환 하는 함수
        - COUNT(*) : 조회결과에 해당하는 모든 행의 갯수를 반환
        - COUNT(컬럼명) : 제시한 컬럼값이 NULL이 아닌 행의 갯수를 반환
        - COUNT(DISTINCT 컬럼명) : 해당 컬럼의 중복을 제거한 후 행의 갯수를 반환
*/
-- 집계함수 : 여러행 또는 테이블 전체 행으로 부터 하나의 결과값을 반환
-- 107건
SELECT  COUNT(*)
FROM    EMP;

SELECT  COUNT(EMPLOYEE_ID)
FROM    EMP;

-- 106건 - 컬럼을 명시한 경우 NULL은 카운트 하지 않는다!
SELECT  COUNT(DEPARTMENT_ID)
FROM    EMP;

SELECT DEPARTMENT_ID FROM EMP WHERE DEPARTMENT_ID IS NULL;

-- 중복을 제거한 건수 
-- 컬럼을 명시 했을때 NULL을 카운트 하지 않으므로
-- 11건
SELECT  COUNT(DISTINCT DEPARTMENT_ID)
FROM    EMP;
-- NVL 함수를 이용해서 NULL값을 치환후 조회
-- 12건
SELECT  COUNT(DISTINCT NVL(DEPARTMENT_ID,0))
FROM    EMP;

-- 12건
SELECT  DISTINCT DEPARTMENT_ID
FROM    EMP;
-- EMP 사원의 총 급여액
SELECT  SUM(SALARY)
FROM    EMP;
-- 사원의 급여합계, 중복을 제거한 급여의 합계
-- 동일한 급여가 있으면 1번만 더해 줍니다
SELECT  SUM(SALARY), SUM(DISTINCT SALARY)
FROM    EMP;
-- 급여 조회
SELECT  SALARY
FROM    EMP
ORDER BY SALARY;
-- EMP 사원의 평균 급여액
SELECT  AVG(SALARY)
FROM    EMP;
-- 급여 평균과 중복을 제거한 급여의 평균
SELECT  AVG(SALARY), AVG(DISTINCT SALARY)
FROM    EMP;
-- EMP 사원번호의 최대값
SELECT  MAX(employee_id)+1
FROM    EMP;
-- EMP 급여의 최대값, 최소값
-- 중복제거 키워드가 와도 반환 되는 값은 동일 함
SELECT  MIN(SALARY), MAX(DISTINCT SALARY)
FROM    EMP;

/*
    <GROUP BY>
        - 그룹에 대한 기준을 제시할 수 있는 구문
        여러개의 값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용한다.
        SELECT 
        FROM
        [WHERE]
        [GROUP BY]
        [ORDER BY]
        생략이 가능 한 절도 있지만 
        - 쿼리를 작성시 순서대로 작성 해야 한다
        - SELECT 절에는 집계함수와 GROUP BY절에 명시된 컬럼만 작성이 가능하다
*/
-- 전체사원을 하나의 그룹으로 묶어 총합을 구한 결과
SELECT  SUM(SALARY)
FROM    EMP;
-- 부서별 사원의 급여의 합계
SELECT  department_id 부서, SUM(SALARY) 급여의합계, COUNT(employee_id) 사원수
FROM    EMP
GROUP BY department_id
ORDER BY 1;

-- 각 부서별 사원수
SELECT  DEPARTMENT_ID, COUNT(*)
FROM    EMP
GROUP BY DEPARTMENT_ID
ORDER BY 2 DESC;

-- 각 부서별 보너스를 받는 사원수
-- NULL을 세어 주지 않으므로 
SELECT  DEPARTMENT_ID, COUNT(COMMISSION_PCT)
FROM    EMP
GROUP BY DEPARTMENT_ID;

-- JOB_ID
-- 직급별 급여의 평균
-- 소수점 버림, 세자리(,)
-- 직급코드, 급여의평균, 사원의수
select  JOB_ID
        , TO_CHAR(FLOOR(AVG(SALARY)),'9,999,999')
        , COUNT(*) || '명'
from    emp
group by job_id;

-- 부서별 
-- 사원수, 보너스를 받는 사원수
-- , 급여의 합, 평균급여, 최고급여, 최저급여
-- 금액 3자리콤마, 사원수에는 명을 붙여서 왼쪽 정렬
-- 사원수가 0명이면 표시하지 않음
SELECT  DEPARTMENT_ID 부서코드
        , LPAD(COUNT(*)||'명',4) 인원수
        , LPAD(DECODE(COUNT(COMMISSION_PCT)
                    , 0, ' '
                    , COUNT(COMMISSION_PCT)||'명'),10) 보너스받는사람
        , SUM(SALARY) "급여의 합계"
        , TO_CHAR(FLOOR(AVG(SALARY)),'999,999') "급여의 평균"
        , MAX(SALARY) "급여의 최대값", MIN(SALARY) "급여의 최소값"
FROM    EMP
GROUP BY DEPARTMENT_ID 
ORDER BY 1;

-- 고객테이블에서 성별별 고객수를 구해봅시다
-- 고객의 수를 내림차순으로 정렬
SELECT  CUST_GENDER, COUNT(*)
FROM    CUSTOMERS
GROUP BY CUST_GENDER;

-- 소계를 구하는 함수 ROLLUP
SELECT  DECODE(CUST_GENDER,'F','여','M','남',' ') 성별, COUNT(*) 고객수
FROM    CUSTOMERS
GROUP BY ROLLUP(CUST_GENDER);

-- 총 고객수 : 55500명
SELECT COUNT(*) FROM CUSTOMERS;

-- 여러 컬럼을 제시해서 그룹의 기준을 설정
-- 부서별 직급별 사원수와 급여의 총합
SELECT  DEPARTMENT_ID, JOB_ID, COUNT(*), SUM(SALARY)
FROM    EMP
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY 1,2;

/*
    <HAVING>
        - 그룹에 대한 조건을 제시할 때 사용 하는 구문
        - 그룹합수의 결과를 가지고 비교를 수행
        
        * 실행순서
          5: SELECT     조회 하고자 하는 컬럼명 | 계산식 | 함수식 [AS] 별칭
          1: FROM       조회 하고자 하는 테이블명
          2: WHERE      조건식
          3: GROUP BY   그룹 기준에 해당하는 컬럼명 | 계산식 | 함수식
          4: HAVING     그룹에 대한 조건식
          6: ORDER BY   정렬기준에 해당하는 컬럼명 | 별칭 | 컬럼순번
*/
-- 직급별 총 급여의 합이 10000이상인 직급,급여의합을 조회
SELECT  JOB_ID, SUM(SALARY)
FROM    EMP 
-- 그룹함수는 WHERE 절에 올수 없습니다.
-- 구룹함수는 허가되지 않습니다. 오류 발생
-- WHERE SUM(SALARY) >= 10000
GROUP BY JOB_ID
HAVING SUM(SALARY) >= 10000;

-- 부서별 평균 급여가 7000 이상인 부서코드와 평균급여와 사원수를 조회
-- 평균 급여는 소수점을 제거하고 세자리콤마를 적용
SELECT  DEPARTMENT_ID 부서코드
        , TO_CHAR(FLOOR(AVG(SALARY)),'9,999,999') 평균급여
        , COUNT(*)
FROM    EMP
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 7000
ORDER BY department_id
;

-- 부서별 보너스를 받는 사원이 있는 부서들만 조회
SELECT  DEPARTMENT_ID, COUNT(COMMISSION_PCT)
FROM    EMP
-- 집계함수는 WHERE 절에 올수 없습니다.
-- WHERE COUNT(COMMISSION_PCT) = 0
GROUP BY DEPARTMENT_ID
HAVING COUNT(COMMISSION_PCT) != 0;

/*
    <집계 함수>
        그룹별 산출한 결과 값의 중간 집계를 계산해 주는 함수
*/
-- 직급별 급여의 합계를 조회
-- 마지막 행에 전체 총 급여의 합계까지 조회
SELECT  JOB_ID, SUM(SALARY)
FROM    EMP
GROUP BY ROLLUP(JOB_ID)
ORDER BY 1;

SELECT  JOB_ID, SUM(SALARY)
FROM    EMP
GROUP BY CUBE(JOB_ID)
ORDER BY 1;

-- 부서 코드도 같고 직급 코드도 같은 사원들을 그룹 지어서 급여의 합계를 조회
SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY)
FROM    EMP
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY 1,2;

SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY)
FROM    EMP
GROUP BY CUBE(DEPARTMENT_ID, JOB_ID)
ORDER BY 1,2;

/*
    <GROUPING>
        RULLUP이나 CUBE에 의해 산출된 값이 
        해당 컬럼의 집합의 산출물이면 0을 반환
                            아니면 1을 반환
*/
SELECT DEPARTMENT_ID, JOB_ID
        , SUM(SALARY)
        , GROUPING(DEPARTMENT_ID)
        , GROUPING(JOB_ID)
FROM    EMP
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY 1,2;

/*
    <집합 연산자>
    - 여러개의 쿼리문을 가지고 하나의 쿼리문을 만드는 연산자
    - 합집합
        UNION       : 두 쿼리문을 수행한 결과를 더한후 중복되는 행은 제거
        UNION ALL   : 중복을 허용한다
    - 교집합
        INTERSECT   : 두 쿼리문을 수행한 결과값에 중복된 결과값만 추출 한다
    - 차집합    
        MINUS       : 선행 결과집합에서 후행 결과집합을 뺀 나머지 결과값만 추출 한다 
*/
-- 부서코드가 20인 사원을 조회  2건 조회
SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   DEPARTMENT_ID = 20;
-- 급여가 5000-6000  3건 조회
SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   SALARY BETWEEN 5000 AND 6000;
-- 사번, 이름, 부서코드, 급여

-- 합집합 UNION : 중복을 제거
-- 202번 사원이 중복 되므로 4건 출력
SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   DEPARTMENT_ID = 20

UNION

SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   SALARY BETWEEN 5000 AND 6000;

-- OR연산과 동일한 결과를 얻을수 있다
SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   DEPARTMENT_ID = 20
        OR SALARY BETWEEN 5000 AND 6000;

-- 두 결과집합을 하나로 합치는데 중복을 허용
SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   DEPARTMENT_ID = 20

UNION ALL

SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   SALARY BETWEEN 5000 AND 6000;

-- 교집합 -- AND 연산과 동일한 결과를 얻을수 있다
SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   DEPARTMENT_ID = 20

INTERSECT

SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   SALARY BETWEEN 5000 AND 6000;

-- 차집합
SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   DEPARTMENT_ID = 20

MINUS

SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   SALARY BETWEEN 5000 AND 6000;
