/*
    <함수>
        컬럼값을 읽어서 계산 결과를 반환한다.
          - 단일행 함수 : N개의 값을 읽어서 N개의 결과를 리턴한다. (매 행 함수 실행 -> 결과 반환)
          - 그룹 함수   : N개의 값을 읽어서 1개의 결과를 리턴한다. (하나의 그룹별로 함수 실행 -> 결과 반환)
        SELECT 절에 단일행 함수와 그룹 함수를 함께 사용하지 못한다. (결과 행의 개수가 다르기 때문에)
        함수를 기술할 수 있는 위치는 SELECT, WHERE, ORDER BY, GROUP BY, HAVING 절에 기술할 수 있다.
        (FROM절에는 테이블이름이 기술되므로 사용 할 수 없다)
*/

-- 단일행 함수
/*
    <문자관련 함수>
    1) LENGTH : 글자수를 반환
       LENGTHB : 글자의 바이트수를 반환
       한글은 한글자당 3BYTE(지정된 문자셋에 따라 다를수 있음)
       영어, 숫자, 특수문자 1BYTE
       
*/
SELECT  LENGTH('오라클'), LENGTHB('오라클'), SYSDATE
FROM    DUAL;
/*
    DUAL 테이블
    - SYS 사용자가 소유하는 테이블
    - SYS 사용자가 소유하지만 모든 사용자가 접근 할 수 있다
    - 하나의 행, 하나의 컬럼을 가지고 있는 더미 테이블이다
    - 사용자가 함수를 계산하거나 오늘 날자를 출력할때 임시로 사용되는 테이블
*/
-- 사원테이블로 부터 사원의 이름, 이름의 길이, 이름의 바이트 길이, 
--                      이메일, 이메일의 길이, 이메일의 바이트길이 조회 하시오
SELECT  EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
        , EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM    EMP;

/*
    2) INSTR
        - INSTR(컬럼|'문자값', '문자'[, POSITION[, OCCURRENCE]])
        - 지정한 위치부터 지정된 숫자 번째로 나타나는 문자의 시작 위치를 반환한다.
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- 3번째 자리의 B의 위치값 출력
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- 3번째 자리의 B의 위치값 출력
-- 앞에서부터 시작해서 2번째 나오는 B의 위치를 반환
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- 9번째 자리의 B의 위치값 출력
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- 10번째 자리의 B의 위치값 출력
-- 뒤에서부터 시작해서 3번째 나오는 B의 위치를 반환
SELECT INSTR('AABAACAABBAA', 'B', -1, 3) FROM DUAL; -- 3번째 자리의 B의 위치값 출력


-- 사원 테이블의 이메일 컬럼에서 @의 위치를 찾아보세요!!
SELECT  EMAIL, INSTR(EMAIL, '@')
FROM    EMP;

/*
    3) SUBSTR
        - SUBSTR(컬럼|'문자값', POSITION[, LENGTH])
        - 문자데이터에서 지정한 위치부터 지정한 개수만큼의 문자열을 추출해서 반환한다.
*/
-- SUBSTR(컬럼명, 시작위치, 글자수)
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;
SELECT SUBSTR('쇼우 미 더 머니', 2, 5) FROM DUAL;

-- 사원테이블의 이메일 컬럼에서 이메일 아이디와 도메인 추출을 추출 해보세요
-- sun_di@or.kr   ->  아이디@도메인
-- 1) INSTR함수를 이용해서 @의 위치를 확인
-- 2) SUBSTR함수를 이용해서 문자열을 추출(시작위치, 문자의 갯수)
SELECT EMAIL, INSTR(EMAIL, '@') "@위치"
        , SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) 아이디
        , SUBSTR(EMAIL, INSTR(EMAIL, '@')+1) 도메인
FROM EMP;

-- 사원 테이블의 주민등록 번호의 뒷번호 1번째 자리까지 추출
-- 621235-1985634 -> 621235-1******
-- 뒷번호 1자리를 추출 해보세요
SELECT EMP_NO
        , SUBSTR(EMP_NO, 1, 8) || '******' 주민등록번호
        , SUBSTR(EMP_NO, 8, 1) 성별코드
FROM EMP;

-- 사원테이블에서 여자사원의 모든컬럼을 조회 하세요
SELECT  *
FROM    EMP
WHERE   SUBSTR(EMP_NO,8,1) = 2;

-- 부서테이블에서 부서코드가 D1, D2, D3인 부서만 조회 하세요
SELECT DEPT_ID, INSTR('D1|D2|D3', DEPT_ID)
  FROM DEPT
-- WHERE DEPT_ID = 'D1' OR DEPT_ID = 'D2' OR DEPT_ID = 'D3';
-- WHERE DEPT_ID IN ('D1', 'D2', 'D3');
 WHERE INSTR('D1|D2|D3', DEPT_ID) > 0;

/*
    4) LPAD/RPAD
    - LPAD/RPAD(값, 길이[,'덧붙이려고 하는 문자'])
    - 제시된 값에 임의의 문자를 왼쪽 또는 오른쪽에 
        붙여 최종 N길이 만큼 문자열을 반환 한다.
    - 문자를 통일감있게 표시하고자 할때 사용
*/
-- 20만큼의 길이중 EMAIL은 오른쪽으로 정렬하고 공백을 왼쪽으로 채운다
SELECT EMAIL, LPAD(EMAIL,20) FROM EMP;
-- 오른쪽으로 붙이고 나머지 길이를 공백/지정 문자열로 채워줍니다
SELECT EMAIL, LPAD(EMAIL,20,'*') FROM EMP;

SELECT EMAIL, RPAD(EMAIL,20) FROM EMP;
SELECT EMAIL, RPAD(EMAIL,20,'$') FROM EMP;

-- 사원테이블에서 주민등록번호의 뒤1자리까지 추출하고 오른쪽에 *문자를 채워서 출력
SELECT RPAD(SUBSTR(EMP_NO,1,8),14,'*'), SUBSTR(EMP_NO,1,8)||'******'
FROM EMP;

/*
    5) LOWER / UPPER / INITCAP
    - LOWER|UPPER|INITCAP (컬럼|'문자값')
     LOWER : 모두 소문자로 변경
     UPPER : 모두 대문자로 변경
     INITCAP : 단어 앞 글자마다 대문자로 변경
*/
-- HR계정에서 확인
SELECT  INITCAP(LOWER(FIRST_NAME) ||' '|| UPPER(LAST_NAME))
FROM    EMPLOYEES;
/*
    6) CONCAT
    - CONCAT(컬럼|'문자열', 컬럼|'문자열')   ==   ||
    - 문자데이터 두개를 전달 받아서 하나로 합친후 결과를 반환
*/
-- 인수는 2개만 넣어줄 수 있다 ======> 3개 이상 넣을경우 인수의 갯수가 부적합합니다 오류 발생
SELECT  CONCAT(CONCAT('가나다라', '마바사'), '오호')
FROM    DUAL;

/*
    7) REPLACE : 치환, 바꾸기
    - REPLACE(컬럼|'문자값', 변경하려는 문자, 변경하고자 하는 문자)
    - 컬럼, 문자값에서 변경하고자 하는 문자를 변경하려는 문자로 변경하여 반환
*/
-- 변경하려는 문자를 변경하고자 하는 문자로 변경
SELECT  REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') FROM    DUAL;
SELECT  REPLACE('서울시 강남구 역삼동', '역삼동', '') FROM    DUAL;
-- OR.KR  -->> GMAIL.COM
-- 사원명, 이메일주소를 조회
-- 쿼리를 작성할때는 대소문자를 구분하지 않지만 데이터를 조회 할때는 대소문자를 구분 합니다!!!!
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'or.kr', 'GMAIL.COM')
FROM EMP;

/*
    8) LTRIM / RTRIM
        - LTRIM/RTRIM(컬럼|'문자값'[, '제거하고자 하는 문자'])
        - 문자열의 왼쪽 혹은 오른쪽에서 제거하고자 하는 문자들을 찾아서 제거한 결과를 반환한다.
        - 제거하고자 하는 문자값을 생략 시 기본값으로 공백을 제거한다.
*/
-- 제거하고자 하는 문자값을 생략할 경우 공백을 제거 합니다. 
SELECT LTRIM('     HUMAN     ' ) FROM DUAL;
SELECT LTRIM('0001234560', '0') FROM DUAL;
SELECT LTRIM(' 123123HUMAN', '31 ') FROM DUAL;
SELECT LTRIM(' 123123HUMAN', '1 32') FROM DUAL;
SELECT RTRIM('HUMAN       '), LENGTH(RTRIM('HUMAN       ')) FROM DUAL;
SELECT RTRIM('0001234560', '0') FROM DUAL;

SELECT RTRIM(LTRIM('      HUMAN      ')) FROM DUAL;

/*
    9) TRIM
        - TRIM(['제거하고자 하는 문자값' FROM] 컬럼|'문자값')
        - 문자값 앞/뒤/양쪽에 있는 지정한 문자를 제거한 나머지를 반환한다. 
        - 제거하고자 하는 문자값을 생략 시 기본적으로 양쪽에 있는 공백을 제거한다. 
*/

SELECT TRIM('      HUMAN      ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZHUMANZZZ') FROM DUAL;







