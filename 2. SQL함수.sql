/*
    �Լ�
*/
-- 1. ������а� �л����� �й�, �̸�, ���г⵵�� ��ȸ
-- �й� �̸� ���г⵵(��-��-��), ���г⵵�� ���������� ����
-- JOIN
SELECT  STUDENT_NO �й�, STUDENT_NAME �̸�, TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') ���г⵵
FROM    TB_STUDENT S, TB_DEPARTMENT D
-- �÷����� �������, ���̺��� ��������� �տ� ����� �մϴ�!!!!!!!!
--WHERE   TB_STUDENT.DEPARTMENT_NO = TB_DEPARTMENT.DEPARTMENT_NO
-- ��Ī�� ����ϰ� �Ǹ� ���̻� ���̺� �̸��� ��� �� �� ����!!!!!!!
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND     DEPARTMENT_NAME = '������а�'
ORDER BY ENTRANCE_DATE;

SELECT  STUDENT_NO �й�, STUDENT_NAME �̸�, TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') ���г⵵
FROM    TB_STUDENT S
JOIN    TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE   DEPARTMENT_NAME = '������а�'
ORDER BY ENTRANCE_DATE;

-- 2. ������ �̸��� 3���ڰ� �ƴ� ����� ã�� ���ô�
-- �������̸��� �ֹι�ȣ�� ���
SELECT  PROFESSOR_NAME, PROFESSOR_SSN--LENGTH(PROFESSOR_NAME)
FROM    TB_PROFESSOR
--WHERE   LENGTH(PROFESSOR_NAME) ^= 3;
WHERE   PROFESSOR_NAME NOT LIKE '___';

-- 3. ���ڱ������� �̸��� ���̸� ��ȸ 
-- ���̼���(��������)�� ���� �ϵ� ���̰� ���ٸ� 
-- �̸���(��������)���� ����
SELECT 
        PROFESSOR_NAME �����̸�
/*TO_CHAR(SYSDATE,'YYYY') ����⵵
        , DECODE(SUBSTR(PROFESSOR_SSN, 8,1),1,19,2,19,3,20,4,20) �⵵
        -- 1900�������� 2000�������� ����
        , SUBSTR(PROFESSOR_SSN, 1, 2)
        , DECODE(SUBSTR(PROFESSOR_SSN, 8,1),1,19,2,19,3,20,4,20)
            || SUBSTR(PROFESSOR_SSN, 1, 2) "�¾ �⵵"*/
        , TO_CHAR(SYSDATE,'YYYY') - 
            (DECODE(SUBSTR(PROFESSOR_SSN, 8,1),1,19,2,19,3,20,4,20)
            || SUBSTR(PROFESSOR_SSN, 1, 2)) ||'��' "����"
FROM TB_PROFESSOR
--ORDER BY 2 DESC, 1;
ORDER BY ���� DESC, �����̸�;

-- 4��
-- ������ �̸��� ��� �غ��ô� (���� 1����)
-- SUBSTR(�÷���, �����ε���) : �����ε��� ~ ������
SELECT  PROFESSOR_NAME, SUBSTR(PROFESSOR_NAME, 2) �̸�
FROM    TB_PROFESSOR
ORDER BY 2;

-- 5�� 2024�� ũ���������� ���� ���� �ϱ��
-- ���� -> ���ڷ� ����
-- DAY : ������, D : 2(1:�Ͽ���)
SELECT TO_CHAR(SYSDATE, 'DAY')
        , TO_CHAR(TO_DATE('2024-12-25'), 'DAY') ����
FROM DUAL;

-- 6�� 2000�� ���� �����ڵ��� �й��� A�� �����մϴ�.
-- 2000�� ���� �й��� ���� �л����� �й��� �̸��� ��ȸ
SELECT  STUDENT_NO �й�, STUDENT_NAME �̸�
FROM    TB_STUDENT
WHERE   STUDENT_NO NOT LIKE 'A%';

-- �л��� ���̸� ���غ��ô�!!
SELECT  
TO_CHAR(SYSDATE, 'YYYY') ����⵵, 
(DECODE(SUBSTR(STUDENT_SSN, 8, 1), 1, 19, 2, 19, 3, 20, 4, 20, '�߸��� �ֹι�ȣ')
    || SUBSTR(STUDENT_SSN, 1, 2)) �¾�⵵
, TO_CHAR(SYSDATE, 'YYYY') - 
(DECODE(SUBSTR(STUDENT_SSN, 8, 1), 1, 19, 2, 19, 3, 20, 4, 20, '�߸��� �ֹι�ȣ')
    || SUBSTR(STUDENT_SSN, 1, 2)) ����
FROM    TB_STUDENT;

-- 7�� �й��� A517178�� �ѾƸ� �л��� 
-- ���� �� ��������� ���ϴ� SQL���� �ۼ��Ͻÿ�.
-- ��� : �й�, �̸�, ���� AVG()
-- ������ �ݿø��ؼ� �Ҽ��� ���� ���ڸ����� ǥ��!
SELECT  T.STUDENT_NO, STUDENT_NAME, ROUND(AVG(POINT),1)
FROM    TB_GRADE T, TB_STUDENT S
-- JOIN������ WHERE���� ù��° ���忡 ���ɴϴ�
WHERE   T.STUDENT_NO = S.STUDENT_NO
AND     T.STUDENT_NO = 'A517178'
GROUP BY T.STUDENT_NO, STUDENT_NAME
;

-- 9�� �а��� �л� ���� ���Ͽ� "�а���", "�л���(��)" �� ��ȸ �غ��ô�
-- �л����� ���� ������� ���� ���ּ���
SELECT  DEPARTMENT_NO, COUNT(*)
FROM    TB_STUDENT S, TB_DEPARTMENT D
WHERE   S.DEPARTMENT_NO = D.DEPARTMENT_NO
GROUP BY    DEPARTMENT_NO
ORDER BY 2 DESC;


-- 10�� ���������� �������� ���� �л��� ���� ����ΰ���
SELECT  COUNT(*)
FROM    TB_STUDENT
WHERE   COACH_PROFESSOR_NO IS NULL;

-- 11�� �й��� A112113�� ���� �л��� �⵵ �� ����
-- �⵵������ ���� �Ҽ��� 1�ڸ����� ǥ�� 
-- �⵵, �⵵�� ����
-- ��������
SELECT  STUDENT_NO �й�
        , (SELECT STUDENT_NAME FROM TB_STUDENT 
                WHERE STUDENT_NO = TB_GRADE.STUDENT_NO) �л���
        , SUBSTR(TERM_NO,1,4) �⵵
        , TO_CHAR(TRUNC(AVG(POINT),1), '9.9') �⵵������
FROM    TB_GRADE
WHERE   STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4), STUDENT_NO
ORDER BY �⵵;

-- ����Ŭ JOIN
SELECT  STUDENT_NAME �й�
        , SUBSTR(TERM_NO,1,4) �⵵
        , TO_CHAR(TRUNC(AVG(POINT),1), '9.9') �⵵������
FROM    TB_GRADE G, TB_STUDENT S
WHERE   G.STUDENT_NO = S.STUDENT_NO
AND     S.STUDENT_NO = 'A112113'
GROUP BY STUDENT_NAME, SUBSTR(TERM_NO,1,4)
ORDER BY �⵵;

-- ǥ�� JOIN
SELECT  STUDENT_NAME �й�
        , SUBSTR(TERM_NO,1,4) �⵵
        , TO_CHAR(TRUNC(AVG(POINT),1), '9.9') �⵵������
FROM    TB_GRADE 
JOIN    TB_STUDENT  USING (STUDENT_NO)
WHERE   STUDENT_NO = 'A112113'
GROUP BY STUDENT_NAME, SUBSTR(TERM_NO,1,4)
ORDER BY �⵵;

























