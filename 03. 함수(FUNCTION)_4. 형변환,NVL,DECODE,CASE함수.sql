/*
    <형변환 함수>
    
    1) TO_CHAR
        [표현법]
            TO_CHAR(날짜|숫자[, 포멧])
        
        - 날짜 또는 숫자 타입의 데이터를 문자 타입으로 변환해서 반환한다.
        - 결과값은 CHARACTER 타입이다.
*/

-- 숫자 -> 문자     EX) 3자리 콤마
SELECT 1234, TO_CHAR(1234) FROM DUAL;
-- 6칸(9의 갯수 만큼)의 공간을 확보, 오른쪽정렬, 빈칸 공백으로 채워줌
SELECT TO_CHAR(1234, '999999') FROM DUAL;
SELECT TO_CHAR(1234, '999,999') FROM DUAL;
-- 길이가 짧으면 #####으로 출력 되므로 길이를 충분히 확보
SELECT TO_CHAR(123456789, '9,999,999,999') FROM DUAL;
-- 현재 설정된 나라의 화폐단위
          
SELECT TO_CHAR(123456789, 'L9,999,999,999') FROM DUAL;

SELECT TO_CHAR(123456789, 'FML9,999,999,999') FROM DUAL;
SELECT TO_CHAR(123456789, '$9,999,999,999') FROM DUAL;
-- 6칸(9의 갯수 만큼)의 공간을 확보, 오른쪽정렬, 빈칸 0으로 채워줌
SELECT TO_CHAR(1234, '000000') FROM DUAL;
SELECT TO_CHAR(1234, '000,000') FROM DUAL;

--EMP 테이블에서 사원명, 급여(3자리 콤마) 조회
SELECT EMP_NAME, TO_CHAR(SALARY, 'FM9,999,999,999')
FROM EMP;

-- 날짜 --> 문자
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE) FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD(DAY)') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YEAR') FROM DUAL;

-- 월에 대한 포맷
SELECT TO_CHAR(SYSDATE, 'MM') 
        , TO_CHAR(SYSDATE, 'MON')
        , TO_CHAR(SYSDATE, 'MONTH')
        , TO_CHAR(SYSDATE, 'RM') -- 로마기호
FROM DUAL;
-- 일에 대한 포맷
SELECT TO_CHAR(SYSDATE, 'DDD') -- 1년을 기준으로 몇일째 
        , TO_CHAR(SYSDATE, 'DD') -- 1달을 기준으로 몇일째
        , TO_CHAR(SYSDATE, 'D') -- 1주를 기준으로 몇일째
FROM DUAL;
-- 요일에 대한 포맷
SELECT TO_CHAR(SYSDATE, 'DY'), TO_CHAR(SYSDATE, 'DAY')
FROM DUAL;
-- 직접입력
SELECT  TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"(DY)')
FROM    DUAL;

-- EMP 테이블에서 직원명, 입사일 조회
-- 단, 입사일은 포멧을 지정해서 조회한다.(2021-09-28(화))
SELECT  EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD(DY)') 입사일
FROM    EMP
ORDER BY 입사일 DESC;

/*
    2) TO_DATE
        [표현법]
            TO_DATE(숫자|문자[, 포멧])
        
        - 숫자 또는 문자형 데이터를 날짜 타입으로 변환해서 반환한다.
        - 결과값은 DATE 타입이다.
*/
-- 숫자 --> 날짜
SELECT TO_DATE(20211014) FROM DUAL;
SELECT TO_DATE(20211014142020) FROM DUAL;

-- 문자 --> 날짜
SELECT TO_DATE('20240501') FROM DUAL;
SELECT TO_DATE('20240501 190830') FROM DUAL;
SELECT TO_DATE('20240501', 'YYYYMMDD') FROM DUAL;

-- EMP 테이블에서 1998년 1월 1일 이후에 입사한 사원의 사번, 이름, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMP
-- 자동형변환
--WHERE HIRE_DATE > '19980101';
--WHERE HIRE_DATE > TO_DATE('19980101', 'YYYYMMDD');
--WHERE HIRE_DATE > TO_DATE('980101', 'RRMMDD');
--WHERE HIRE_DATE > '1998-01-01';
--WHERE HIRE_DATE BETWEEN '1990-01-01' AND '2001-12-31';
;

-- YY와 RR 비교
SELECT TO_DATE('211014', 'YYMMDD') FROM DUAL;
SELECT TO_DATE('981014', 'YYMMDD') FROM DUAL; -- YY : 무조건 현재 세기

-- RR : 해당 값이 50 이상이면 이전 세기, 50 미만이면 현제 세기 
--2021
SELECT TO_DATE('211014', 'RRMMDD') FROM DUAL;
--1998
SELECT TO_DATE('981014', 'RRMMDD') FROM DUAL; 

SELECT TO_CHAR(TO_DATE('51-01-01'), 'RRRR')
        , TO_CHAR(TO_DATE('51-01-01'), 'YYYY') FROM DUAL;


/*
    3) TO_NUMBER
        [표현법]
            TO_NUMBER('문자값'[, 포멧])
        
        - 문자 타입의 데이터를 숫자 타입의 데이터로 변환해서 반환한다.
        - 결과값은 NUMBER 타입이다.
*/
SELECT '123456789', TO_NUMBER('0123456789') FROM DUAL;
-- 자동으로 숫자 타입으로 형 변환뒤 연산 처리!
SELECT '123' + '456' FROM DUAL;
-- 숫자 형태의 문자들만 자동 형변환 된다!!
SELECT '123' + '456A' FROM DUAL;
SELECT '10,000,000' + '99,999,999' FROM DUAL;
SELECT TO_NUMBER('10,000,000', '99,999,999') FROM DUAL;
SELECT TO_NUMBER('10,000,000', '99,999,999') + TO_NUMBER('500,000','999,999') FROM DUAL;

/*
    <NULL 처리 함수>
    
    1) NVL
        [표현법]
            NVL(컬럼, 컬럼값이 NULL일 경우 반환할 값)
        
        - NULL로 되어있는 컬럼의 값을 인자로 지정한 값으로 변경하여 반환한다.

    2) NVL2
        [표현법]
            NVL2(컬럼, 변경할 값 1, 변경할 값 2)
            
        - 컬럼 값이 NULL이 아니면 변경할 값 1, 컬럼 값이 NULL이면 변경할 값 2로 변경하여 반환한다.  
    
    3) NULLIF
        [표현법]
            NULLIF(비교대상 1, 비교대상 2)
            
        - 두 개의 값이 동일하면 NULL 반환, 두 개의 값이 동일하지 않으면 비교대상 1을 반환한다.
*/
-- EMPLOYEE 테이블에서 사원명, 보너스, 보너스가 포함된 연봉 조회 (NVL 함수 사용)
-- NULL의 연산결과는 NULL
SELECT  EMP_NAME, BONUS, SALARY, (SALARY +  (SALARY * NVL(BONUS, 0))) * 12 연봉
FROM    EMP;
-- EMPLOYEE 테이블에서 사원명, 부서 코드 조회 (단, 부서 코드가 NULL이면 "부서없음" 출력)
SELECT  EMP_NAME, NVL(DEPT_CODE, '부서없음')
FROM    EMP;

SELECT  NVL(BONUS,0) "기존 보너스율", NVL2(BONUS, 0.1,0) "동결된 보너스율"
FROM    EMP;

-- 두개의 값을 인자로 받아서 비교, 같으면 NULL
SELECT NULLIF('123', '123') FROM DUAL;
-- 다르면 첫번째 값을 반환
SELECT NULLIF('123', '456') FROM DUAL;

/*
    <선택함수>
        여러 가지 경우에 선택을 할 수 있는 기능을 제공하는 함수이다.
    
    1) DECODE
        [표현법]
            DECODE(컬럼|계산식, 조건값 1, 결과값 1, 조건값 2, 결과값 2, ..., 결과값)
        
        - 비교하고자 하는 값이 조건값과 일치할 경우 그에 해당하는 결과값을 반환해 주는 함수이다.
*/
SELECT DECODE('3', '1', '남자', '2', '여자', '알수없음') FROM DUAL;
-- EMPLOYEE 테이블에서 사번, 사원명, 주민번호, 성별(남/여) 조회
SELECT EMP_NO
    , DECODE(SUBSTR(EMP_NO, 8, 1),1,'남자',2,'여자','잘못된 주민등록 번호입니다.') 성별
FROM EMP;

-- EMPLOYEE 테이블에서 사원명, 직급 코드, 기존 급여, 인상된 급여를 조회
-- 직급 코드가 J7인 사원은 급여를 10% 인상(SALARY * 1.1) 
-- 직급 코드가 J6인 사원은 급여를 15% 인상(SALARY * 1.15) 
-- 직급 코드가 J5인 사원은 급여를 20% 인상(SALARY * 1.2) 
-- 이 외의 직급은 사원은 급여를 5%만 인상 (SALARY * 1.05)
SELECT EMP_NAME, JOB_CODE, SALARY "기존 급여"
        , TO_CHAR(DECODE(JOB_CODE, 'J7', SALARY*1.1
                                , 'J6', SALARY*1.15
                                , 'J5', SALARY*1.2
                                , SALARY*1.05 ),'999,999,999') "인상된 급여"
FROM EMP;

/*
    2) CASE
        [표현법]
            CASE WHEN 조건식 1 THEN 결과값 1
                 WHEN 조건식 2 THEN 결과값 2
                 ...
                 ELSE 결과값 N
            END
*/
SELECT CASE WHEN SUBSTR('111111-1111111', 8, 1) = '1' THEN '남자'
            WHEN SUBSTR('111111-1111111', 8, 1) = '2' THEN '여자'
            ELSE '잘못된 주민번호!'
        END 성별
FROM DUAL;
-- EMPLOYEE 테이블에서 사번, 사원명, 주민번호, 성별(남/여) 조회
SELECT  EMP_ID 사번, EMP_NAME 이름, EMP_NO 주민번호,
        CASE WHEN SUBSTR(EMP_NO, 8, 1) = '1' THEN '남자'
             WHEN SUBSTR(EMP_NO, 8, 1) = '2' THEN '여자'
             ELSE '주민번호 확인요망'
        END AS 성별
FROM    EMP;

-- 사원의 급여가 5000000 이상이면 고수익, 3000000이상이면 일반, 나머지는 ''
SELECT  CASE WHEN SALARY > 5000000 THEN '고수익'
            WHEN SALARY > 3000000 THEN '일반'
            ELSE '' -- 생략가능
        END -- 필수!!!!!!!
FROM    EMP;




