-- 1. �а� �̸��� �迭 ��ȸ
-- �а� ��  �迭
SELECT  DEPARTMENT_NAME "�а� ��", CATEGORY AS �迭
FROM    TB_DEPARTMENT;

-- 2. �а��� ������ ���
-- ������а��� ������ 20�� �Դϴ�. ||, CONCAT()
SELECT DEPARTMENT_NAME || '�� ������ ' || CAPACITY || '�� �Դϴ�.' "�а��� ����"
FROM TB_DEPARTMENT;

-- 3. ������а��� �ٴϴ� ���л��� �������� ���л��� ã�ƺ��ô�
SELECT  *
FROM    TB_STUDENT
WHERE   DEPARTMENT_NO = '001' -- ������а�
AND     (SUBSTR(STUDENT_SSN, 8, 1) = 2 OR SUBSTR(STUDENT_SSN, 8, 1)  = 4) -- ���л�
AND     ABSENCE_YN = 'Y';   -- ������
--SUBSTR(�÷�|���ڿ�, ���°����, ���ڸ�)
SELECT  STUDENT_SSN, SUBSTR(STUDENT_SSN, 8, 1) 
FROM    TB_STUDENT;

-- �а��ڵ带 �˻�
SELECT * FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '������а�';

SELECT COUNT(*) FROM TB_STUDENT;
-- JOIN�� �̿��ؼ� �ѹ������� �ۼ�

-- JOIN�� ������ ��ġ���� �ʴ°��, ������ �л��� �߻� �� �� �ִ�
-- COUNT�Լ��� �̿��Ͽ� �� �Ǽ��� ��� �غ��ô�
SELECT  STUDENT_NO, STUDENT_NAME
FROM    TB_STUDENT
-- �� ���̺� ���� ���踦 �ξ��ش�
-- ���踦 ���� ���� ���� ��� 
-- TB_STUDENT���̺��� ���Ǽ� * TB_DEPARTMENT ���̺��� ���Ǽ���ŭ ��µ�
JOIN    TB_DEPARTMENT USING (DEPARTMENT_NO)
WHERE   (SUBSTR(STUDENT_SSN, 8, 1) = 2 OR SUBSTR(STUDENT_SSN, 8, 1)  = 4) -- ���л�
AND     ABSENCE_YN = 'Y'   -- ������
AND     DEPARTMENT_NAME = '������а�';

-- 4�� �л��ڵ尡 A513079, A513090, A513091, A513110, A513119��
-- �л��� �̸� ������� �̸��� ��ȸ
SELECT  *
FROM    TB_STUDENT
WHERE   STUDENT_NO = 'A513079'
OR      STUDENT_NO = 'A513090'
ORDER BY STUDENT_NAME;

SELECT  *
FROM    TB_STUDENT
WHERE   STUDENT_NO NOT IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
ORDER BY STUDENT_NAME;

-- ������ �̸��� ��ȸ �Ͻÿ�
-- ������ ������ ��� �������� �Ҽ� �а��� ������ �ֽ��ϴ�.
COMMENT ON COLUMN TB_PROFESSOR.DEPARTMENT_NO IS '�а��ڵ�';

SELECT  PROFESSOR_NAME �����̸�
FROM    TB_PROFESSOR
-- NULL�� �� �� �� ����
-- IS NULL �Ǵ� IS NOT NULL�� ����Ѵ�!!!!!!!!
WHERE   DEPARTMENT_NO IS NULL;

-- 6. �а��� �������� ���� �л��� ��
SELECT  COUNT(*) "�л� ��"
FROM    TB_STUDENT
WHERE   DEPARTMENT_NO IS NULL;

-- 7. ���������� �����ϴ� ������ �����ȣ�� ��ȸ
SELECT  CLASS_NO
FROM    TB_CLASS
WHERE   preattending_class_no IS NOT NULL;

-- 8. ���� ������ 20�� �̻� 30�� ������ �а����� 
-- �а� �̸��� �迭�� ���
SELECT  DEPARTMENT_NAME �а��̸�, CATEGORY �迭
FROM    TB_DEPARTMENT
-- WHERE   CAPACITY >=20 AND     CAPACITY <=30
WHERE CAPACITY BETWEEN 20 AND 30
ORDER BY 2 DESC;

-- 9�� �а� �迭�� �ߺ��� �����ϰ� ��ȸ
-- 1. Ű���带 �̿� (DISTINCT �÷���)
SELECT  DISTINCT CATEGORY
FROM    TB_DEPARTMENT;

-- 2. GROUP BY ������ �̿�
-- �迭�� �а���, �а������� ��
-- �迭�� �̿��Ͽ� �������� ����
SELECT  CATEGORY �迭, COUNT(*) �а���
            , SUM(CAPACITY)||'��' ��������
FROM    TB_DEPARTMENT
GROUP BY    CATEGORY;

-- 10. 02�й�(2002�� ����) ����(���ָ� �����ϴ�) �����ڵ��� ����
-- ���л��� ����� ���л����� �й�, �̸�, �ֹι�ȣ�� ��ȸ
SELECT  STUDENT_NO �й�, STUDENT_NAME �̸�, STUDENT_SSN �ֹι�ȣ
FROM    TB_STUDENT
WHERE   EXTRACT(YEAR FROM ENTRANCE_DATE) = 2002
-- �����ϴ� %�÷�%
-- �����ϴ� �÷�%
-- ������   %�÷�
AND     STUDENT_ADDRESS LIKE '%����%'
-- AND     ABSENCE_YN = 'N'
AND     ABSENCE_YN != 'Y'
-- �̸����� �������� ����
ORDER BY STUDENT_NAME DESC
;










