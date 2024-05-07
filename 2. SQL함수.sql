/*
    함수
*/
-- 1. 영어영문학과 학생들의 학번, 이름, 입학년도를 조회
-- 학번 이름 입학년도(년-월-일), 입학년도가 빠른순으로 정렬
-- JOIN
SELECT  STUDENT_NO 학번, STUDENT_NAME 이름, TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') 입학년도
FROM    TB_STUDENT S, TB_DEPARTMENT D
-- 컬럼명이 같은경우, 테이블을 명시적으로 앞에 써줘야 합니다!!!!!!!!
--WHERE   TB_STUDENT.DEPARTMENT_NO = TB_DEPARTMENT.DEPARTMENT_NO
-- 별칭을 사용하게 되면 더이상 테이블 이름을 사용 할 수 없다!!!!!!!
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND     DEPARTMENT_NAME = '영어영문학과'
ORDER BY ENTRANCE_DATE;

SELECT  STUDENT_NO 학번, STUDENT_NAME 이름, TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') 입학년도
FROM    TB_STUDENT S
JOIN    TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE   DEPARTMENT_NAME = '영어영문학과'
ORDER BY ENTRANCE_DATE;

-- 2. 교수중 이름이 3글자가 아닌 사람을 찾아 봅시다
-- 교수의이름과 주민번호를 출력
SELECT  PROFESSOR_NAME, PROFESSOR_SSN--LENGTH(PROFESSOR_NAME)
FROM    TB_PROFESSOR
--WHERE   LENGTH(PROFESSOR_NAME) ^= 3;
WHERE   PROFESSOR_NAME NOT LIKE '___';

-- 3. 남자교수들의 이름과 나이를 조회 
-- 나이순서(내림차순)로 정렬 하되 나이가 같다면 
-- 이름순(오름차순)으로 정렬
SELECT 
        PROFESSOR_NAME 교수이름
/*TO_CHAR(SYSDATE,'YYYY') 현재년도
        , DECODE(SUBSTR(PROFESSOR_SSN, 8,1),1,19,2,19,3,20,4,20) 년도
        -- 1900년대생인지 2000년대생인지 구분
        , SUBSTR(PROFESSOR_SSN, 1, 2)
        , DECODE(SUBSTR(PROFESSOR_SSN, 8,1),1,19,2,19,3,20,4,20)
            || SUBSTR(PROFESSOR_SSN, 1, 2) "태어난 년도"*/
        , TO_CHAR(SYSDATE,'YYYY') - 
            (DECODE(SUBSTR(PROFESSOR_SSN, 8,1),1,19,2,19,3,20,4,20)
            || SUBSTR(PROFESSOR_SSN, 1, 2)) ||'세' "나이"
FROM TB_PROFESSOR
--ORDER BY 2 DESC, 1;
ORDER BY 나이 DESC, 교수이름;

-- 4번
-- 교수의 이름을 출력 해봅시다 (성은 1글자)
-- SUBSTR(컬럼명, 시작인덱스) : 시작인덱스 ~ 끝까지
SELECT  PROFESSOR_NAME, SUBSTR(PROFESSOR_NAME, 2) 이름
FROM    TB_PROFESSOR
ORDER BY 2;

-- 5번 2024년 크리스마스는 무슨 요일 일까요
-- 문자 -> 날자로 변경
-- DAY : 월요일, D : 2(1:일요일)
SELECT TO_CHAR(SYSDATE, 'DAY')
        , TO_CHAR(TO_DATE('2024-12-25'), 'DAY') 요일
FROM DUAL;

-- 6번 2000년 이후 입학자들의 학번은 A로 시작합니다.
-- 2000년 이전 학번을 받은 학생들의 학번과 이름을 조회
SELECT  STUDENT_NO 학번, STUDENT_NAME 이름
FROM    TB_STUDENT
WHERE   STUDENT_NO NOT LIKE 'A%';

-- 학생의 나이를 구해봅시다!!
SELECT  
TO_CHAR(SYSDATE, 'YYYY') 현재년도, 
(DECODE(SUBSTR(STUDENT_SSN, 8, 1), 1, 19, 2, 19, 3, 20, 4, 20, '잘못된 주민번호')
    || SUBSTR(STUDENT_SSN, 1, 2)) 태어난년도
, TO_CHAR(SYSDATE, 'YYYY') - 
(DECODE(SUBSTR(STUDENT_SSN, 8, 1), 1, 19, 2, 19, 3, 20, 4, 20, '잘못된 주민번호')
    || SUBSTR(STUDENT_SSN, 1, 2)) 나이
FROM    TB_STUDENT;

-- 7번 학번이 A517178인 한아름 학생의 
-- 학점 총 평균점수을 구하는 SQL문을 작성하시오.
-- 헤더 : 학번, 이름, 평점 AVG()
-- 점수는 반올림해서 소수점 이하 한자리까지 표시!
SELECT  T.STUDENT_NO, STUDENT_NAME, ROUND(AVG(POINT),1)
FROM    TB_GRADE T, TB_STUDENT S
-- JOIN조건은 WHERE절의 첫번째 문장에 나옵니다
WHERE   T.STUDENT_NO = S.STUDENT_NO
AND     T.STUDENT_NO = 'A517178'
GROUP BY T.STUDENT_NO, STUDENT_NAME
;

-- 9번 학과별 학생 수를 구하여 "학과명", "학생수(명)" 를 조회 해봅시다
-- 학생수가 많은 순서대로 정렬 해주세요
SELECT  DEPARTMENT_NO, COUNT(*)
FROM    TB_STUDENT S, TB_DEPARTMENT D
WHERE   S.DEPARTMENT_NO = D.DEPARTMENT_NO
GROUP BY    DEPARTMENT_NO
ORDER BY 2 DESC;


-- 10번 지도교수를 배정받지 못한 학생의 수는 몇명인가요
SELECT  COUNT(*)
FROM    TB_STUDENT
WHERE   COACH_PROFESSOR_NO IS NULL;

-- 11번 학번이 A112113인 김고운 학생의 년도 별 평점
-- 년도별평점 버림 소수점 1자리까지 표시 
-- 년도, 년도별 평점
-- 서브쿼리
SELECT  STUDENT_NO 학번
        , (SELECT STUDENT_NAME FROM TB_STUDENT 
                WHERE STUDENT_NO = TB_GRADE.STUDENT_NO) 학생명
        , SUBSTR(TERM_NO,1,4) 년도
        , TO_CHAR(TRUNC(AVG(POINT),1), '9.9') 년도별평점
FROM    TB_GRADE
WHERE   STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4), STUDENT_NO
ORDER BY 년도;

-- 오라클 JOIN
SELECT  STUDENT_NAME 학번
        , SUBSTR(TERM_NO,1,4) 년도
        , TO_CHAR(TRUNC(AVG(POINT),1), '9.9') 년도별평점
FROM    TB_GRADE G, TB_STUDENT S
WHERE   G.STUDENT_NO = S.STUDENT_NO
AND     S.STUDENT_NO = 'A112113'
GROUP BY STUDENT_NAME, SUBSTR(TERM_NO,1,4)
ORDER BY 년도;

-- 표준 JOIN
SELECT  STUDENT_NAME 학번
        , SUBSTR(TERM_NO,1,4) 년도
        , TO_CHAR(TRUNC(AVG(POINT),1), '9.9') 년도별평점
FROM    TB_GRADE 
JOIN    TB_STUDENT  USING (STUDENT_NO)
WHERE   STUDENT_NO = 'A112113'
GROUP BY STUDENT_NAME, SUBSTR(TERM_NO,1,4)
ORDER BY 년도;

























