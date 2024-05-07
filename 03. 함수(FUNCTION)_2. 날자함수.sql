/*
    <날짜 관련 함수>
    
    1) SYSDATE
        시스템의 현재 날짜와 시간을 반환한다.
*/
SELECT SYSDATE FROM DUAL;

/* 
    2) MONTHS_BETWEEN
        [표현법]
            MONTHS_BETWEEN(DATE1, DATE2)
            
        - 입력받은 두 날짜 사이의 개월 수를 반환한다.
        - 결과값은 NUMBER 타입이다.
*/
SELECT MONTHS_BETWEEN(SYSDATE, SYSDATE) FROM DUAL;
-- 문자를 날자 형식으로 변환
SELECT TO_DATE('2024/04/30') FROM DUAL;
SELECT TO_DATE('2024-04-30') FROM DUAL;
SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('2024-04-30'))) FROM DUAL;
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2024-04-01')) FROM DUAL;
-- EMP 테이블에서 직원명, 입사일, 근무개월수
SELECT  EMP_NAME, HIRE_DATE, FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) "근무 개월 수"
        , ABS(FLOOR(MONTHS_BETWEEN(HIRE_DATE, SYSDATE)))
FROM    EMP;

/*
    3) ADD_MONTHS
        [표현법]
            ADD_MONTHS(DATE, NUMBER)
            
        - 특정 날짜에 입력받는 숫자만큼의 개월 수를 더한 날짜를 리턴한다.
        - 결과값은 DATE 타입이다.
*/
SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL;
SELECT ADD_MONTHS(SYSDATE, 8) FROM DUAL;
SELECT ADD_MONTHS('2020/12/31', 2) FROM DUAL;
/*
    4) NEXT_DAY
        [표현법]
            NEXT_DAY(DATE, 요일(문자|숫자))
        
        - 특정 날짜에서 구하려는 요일의 가장 가까운 날짜를 리턴한다.
        - 결과값은 DATE 타입이다.
*/

SELECT SYSDATE, NEXT_DAY(SYSDATE, '목요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '일') FROM DUAL;
-- 1: 일요일, 2: 월요일, ...., 7: 토요일
SELECT SYSDATE, NEXT_DAY(SYSDATE, 1) FROM DUAL;
-- 언어설정에 따라 다름
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'SUNDAY') FROM DUAL;

-- 언어설정하는 방법
ALTER SESSION SET NLS_LANGUAGE = AMERICAN; -- 언어 변경

-- 현재 사용중인 언어 확인 하는 방법
SELECT value
FROM nls_session_parameters
WHERE parameter = 'NLS_LANGUAGE';

ALTER SESSION SET NLS_LANGUAGE = KOREAN; -- 언어 변경

/*
    5) LAST_DAY
        [표현법]
            LAST_DAY(DATE|CHAR)
        
        - 해당 월의 마지막 날짜를 반환한다.
        - 결과값은 DATE 타입이다.   
*/
-- 말일을 반환
SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY('2024-05-01') FROM DUAL;
-- 입사월의 마지막 날자 조회
SELECT  HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM    EMP;

/*
    6) EXTRACT
        [표현법]
            EXTRACT(YEAR|MONTH|DAY FROM DATE);
            
        - 특정 날짜에서 연도, 월, 일 정보를 추출해서 반환한다.
          YEAR : 연도만 추출
          MONTH : 월만 추출
          DAY :  일만 추출
        - 결과값은 NUMBER 타입이다.
*/

SELECT EXTRACT(YEAR FROM SYSDATE) 년
        , EXTRACT(MONTH FROM SYSDATE) 월
        , EXTRACT(DAY FROM SYSDATE) 일
        -- 날자|숫자를 문자형으로 타입 변환
        -- YY, RR(50이후인 경우 이전세기를 나타냄)
        , TO_CHAR(SYSDATE, 'YYYY') 년
        , TO_CHAR(SYSDATE, 'MM') 월
        , TO_CHAR(SYSDATE, 'DD') 일
        , TO_CHAR(TO_DATE('51-01-01'), 'RRRR')
        , TO_CHAR(TO_DATE('51-01-01'), 'YYYY')
FROM DUAL;
-- 사원명, 입사년도, 입사월, 입사일 조회
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) 년
        , EXTRACT(MONTH FROM HIRE_DATE) 월
        , EXTRACT(DAY FROM HIRE_DATE) 일
FROM EMP;

-- 날짜포멧변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

SELECT SYSDATE FROM DUAL;

-- 입사일로부터 지금까지 받은 월급
SELECT EMP_NAME
        , TO_CHAR(FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) * SALARY, '999,999,999,999') AS 급여
FROM EMP;



