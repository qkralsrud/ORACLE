/*
    <숫자 관련 함수>
    
    1) ABS
        - ABS(NUBER)
        - 절대값을 구하는 함수
*/
SELECT ABS(10.9), ABS(-10.9) FROM DUAL;

/*
    2) MOD
        - MOD(NUMBER, NUMBER)
        - 두 수를 나눈 나머지를 반환해 주는 함수 (자바의 % 연산과 동일하다.)
*/
-- 10을 3으로 나눈 나머지값이 반환
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(-10, 3) FROM DUAL;
SELECT MOD(10, -3) FROM DUAL;
SELECT MOD(10.9, -3) FROM DUAL;

/*
    3) ROUND
        - ROUND(NUMBER[, 위치])
        - 위치를 지정하여 반올림해주는 함수
        - 위치 : 기본값 0(.), 양수(소수점 기준으로 오른쪽)와 음수(소수점 기준으로 왼쪽)로 입력가능
*/
SELECT ROUND(123.456) FROM DUAL;

SELECT ROUND(123.456,1) FROM DUAL;
-- 소수점 3번째 자리에서 반올림된 값을 보여줌
SELECT ROUND(123.456,2) FROM DUAL;
SELECT ROUND(123.456,3) FROM DUAL;
SELECT ROUND(123.456,4) FROM DUAL;

-- 반올림 하여 천원단위절삭
SELECT ROUND(15523.456,-3) FROM DUAL;

/*
    4) CEIL
        - CEIL(NUMBER)
        - 소수점 기준으로 올림해주는 함수
*/
-- 매개변수를 2개이상 입력시 오류 발생
-- SELECT CEIL(123.456,1) FROM DUAL;
SELECT CEIL(123.456) FROM DUAL;

/*
    5) FLOOR
        - FLOOR(NUMBER)
        - 소수점 기준으로 버림하는 함수
*/
SELECT FLOOR(123.456) FROM DUAL;

/*
    6) TRUNC
        - TRUNC(NUMBER[, 위치])
        - 위치를 지정하여 버림이 가능한 함수
        - 위치 : 기본값 0(.), 양수(소수점 기준으로 오른쪽)와 음수(소수점 기준으로 왼쪽)로 입력가능
*/
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
-- 원단위절삭
SELECT TRUNC(123.456, -1) FROM DUAL;






