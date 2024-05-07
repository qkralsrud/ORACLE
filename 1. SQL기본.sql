-- 1. 학과 이름과 계열 조회
-- 학과 명  계열
SELECT  DEPARTMENT_NAME "학과 명", CATEGORY AS 계열
FROM    TB_DEPARTMENT;

-- 2. 학과의 정원을 출력
-- 국어국문학과의 정원은 20명 입니다. ||, CONCAT()
SELECT DEPARTMENT_NAME || '의 정원은 ' || CAPACITY || '명 입니다.' "학과의 정원"
FROM TB_DEPARTMENT;

-- 3. 국어국문학과에 다니는 여학생중 휴학중인 여학생을 찾아봅시다
SELECT  *
FROM    TB_STUDENT
WHERE   DEPARTMENT_NO = '001' -- 국어국문학과
AND     (SUBSTR(STUDENT_SSN, 8, 1) = 2 OR SUBSTR(STUDENT_SSN, 8, 1)  = 4) -- 여학생
AND     ABSENCE_YN = 'Y';   -- 휴학중
--SUBSTR(컬럼|문자열, 몇번째부터, 몇자리)
SELECT  STUDENT_SSN, SUBSTR(STUDENT_SSN, 8, 1) 
FROM    TB_STUDENT;

-- 학과코드를 검색
SELECT * FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '국어국문학과';

SELECT COUNT(*) FROM TB_STUDENT;
-- JOIN을 이용해서 한문장으로 작성

-- JOIN시 조건이 일치하지 않는경우, 누락된 학생이 발생 할 수 있다
-- COUNT함수를 이용하여 총 건수를 출력 해봅시다
SELECT  STUDENT_NO, STUDENT_NAME
FROM    TB_STUDENT
-- 두 테이블 간의 관계를 맺어준다
-- 관계를 지정 하지 않을 경우 
-- TB_STUDENT테이블의 행의수 * TB_DEPARTMENT 테이블의 행의수만큼 출력됨
JOIN    TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE   (SUBSTR(STUDENT_SSN, 8, 1) = 2 OR SUBSTR(STUDENT_SSN, 8, 1)  = 4) -- 여학생
AND     ABSENCE_YN = 'Y'   -- 휴학중
AND     DEPARTMENT_NAME = '국어국문학과';

-- 4번 학생코드가 A513079, A513090, A513091, A513110, A513119인
-- 학생의 이름 순서대로 이름을 조회
SELECT  *
FROM    TB_STUDENT
WHERE   STUDENT_NO = 'A513079'
OR      STUDENT_NO = 'A513090'
ORDER BY STUDENT_NAME;

SELECT  *
FROM    TB_STUDENT
WHERE   STUDENT_NO NOT IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
ORDER BY STUDENT_NAME;

-- 총장의 이름을 조회 하시오
-- 총장을 제외한 모든 교수들은 소속 학과를 가지고 있습니다.
COMMENT ON COLUMN TB_PROFESSOR.DEPARTMENT_NO IS '학과코드';

SELECT  PROFESSOR_NAME 총장이름
FROM    TB_PROFESSOR
-- NULL은 비교 할 수 없다
-- IS NULL 또는 IS NOT NULL을 사용한다!!!!!!!!
WHERE   DEPARTMENT_NO IS NULL;

-- 6. 학과가 지정되지 않은 학생의 수
SELECT  COUNT(*) "학생 수"
FROM    TB_STUDENT
WHERE   DEPARTMENT_NO IS NULL;

-- 7. 선수과목이 존재하는 과목의 과목번호를 조회
SELECT  CLASS_NO
FROM    TB_CLASS
WHERE   preattending_class_no IS NOT NULL;

-- 8. 입학 정원이 20명 이상 30명 이하인 학과들의 
-- 학과 이름과 계열을 출력
SELECT  DEPARTMENT_NAME 학과이름, CATEGORY 계열
FROM    TB_DEPARTMENT
-- WHERE   CAPACITY >=20 AND     CAPACITY <=30
WHERE CAPACITY BETWEEN 20 AND 30
ORDER BY 2 DESC;

-- 9번 학과 계열을 중복을 제거하고 조회
-- 1. 키워드를 이용 (DISTINCT 컬럼명)
SELECT  DISTINCT CATEGORY
FROM    TB_DEPARTMENT;

-- 2. GROUP BY 문장을 이용
-- 계열별 학과수, 학과정원의 합
-- 계열을 이용하여 오름차순 정렬
SELECT  CATEGORY 계열, COUNT(*) 학과수
            , SUM(CAPACITY)||'명' 정원의합
FROM    TB_DEPARTMENT
GROUP BY    CATEGORY;

-- 10. 02학번(2002년 입학) 전주(전주를 포함하는) 거주자들의 모임
-- 휴학생을 재외한 재학생들의 학번, 이름, 주민번호를 조회
SELECT  STUDENT_NO 학번, STUDENT_NAME 이름, STUDENT_SSN 주민번호
FROM    TB_STUDENT
WHERE   EXTRACT(YEAR FROM ENTRANCE_DATE) = 2002
-- 포함하는 %컬럼%
-- 시작하는 컬럼%
-- 끝나는   %컬럼
AND     STUDENT_ADDRESS LIKE '%전주%'
-- AND     ABSENCE_YN = 'N'
AND     ABSENCE_YN != 'Y'
-- 이름으로 내림차순 정렬
ORDER BY STUDENT_NAME DESC
;










