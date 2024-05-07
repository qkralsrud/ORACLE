/*
    <JOIN>
    �� ���� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ����ϴ� �����̴�.
    
    1. � ����(EQUAL JOIN) / ���� ����(INNER JOIN)
    �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ���εǼ� ��ȸ�Ѵ�.
    (��ġ�ϴ� ���� ���� ���� ��ȸ X)   
    
    1) ����Ŭ ���뱸��
        SELECT �÷�, �÷�, ...
        FROM   ���̺�1, ���̺�2
        WHERE  ���̺�1.�÷��� = ���̺�2.�÷���;
        
        - FROM���� ��ȸ�ϰ��� �ϴ� �÷����� ,(�޸�)�� �����Ͽ� ����
        - WHERE���� ��Ī��ų �÷��� ���� ������ ���� �Ѵ�.
    
    2) ANSI ǥ�� ����
        SELECT  �÷�, �÷�, ...
        FROM    ���̺�1
        [INNER] JOIN ���̺�2 ON (���̺�1.�÷��� = ���̺�2.�÷���);
        [INNER] JOIN ���̺�2 USING (�÷���);
        - FROM���� ������ �Ǵ� ���̺��� ���
        - JOIN ���� ���� ��ȸ�ϰ��� �ϴ� ���̺��� ����� ������ ���
        - ���ῡ ����Ϸ��� Ŀ������ ���� ��� ON�� 
          ��� USING(�÷���)�� ��� 
          
*/

--INNERJION--

-- �� ������� ���, �����, �μ� �ڵ�, �μ����� ��ȸ 
--�ѻ������ 23�� �̳� 21�� ����� 2�� ���� 
--��ġ�ϴ� �����͸� ����! (�μ��ڵ��� NULL�� ���ܵ�)
SELECT EMP_ID,EMP_NAME,DEPT_CODE,DEPT_ID, DEPT_TITLE
FROM  EMP,DEPT
ORDER BY EMP_ID, DEPT_ID;
--WHERE DEPT_CODE = DEPT_ID;


SELECT EMP_ID,EMP_NAME,DEPT_CODE,DEPT_ID, DEPT_TITLE
FROM EMP
JOIN DEPT ON (DEPT_ID= DEPT_CODE);

SELECT COUNT(*) FROM EMP; --23��
SELECT COUNT(*) FROM DEPT; --9��

--��� ���̺��� ������ ������ ã��
--1) �������� �̿� 
--��ü����� ��� ���� -���ι��� ��� ���� 
SELECT * 
FROM EMP

MINUS
--EMP ���̺�� DEPT���̺��� �÷��� �����ؼ� ������ �״�� DEPT_ID�� DEPT_CODE�� �����͸� ������ 
SELECT EMP.*
FROM EMP
JOIN DEPT ON (DEPT_ID = DEPT_CODE);

--�μ����̺��� ������ ���� �μ��ڵ带 ã�ƺ��ô�.
--���ΰ�� �ߺ��� ����
SELECT DISTINCT(DEPT_ID)
FROM EMP
JOIN DEPT ON DEPT_CODE = DEPT_ID;

--����� �������� ���� �μ�
SELECT * 
FROM DEPT
WHERE DEPT_ID NOT IN (
                    SELECT DISTINCT(DEPT_ID)
                    FROM EMP
                    JOIN DEPT ON DEPT_CODE = DEPT_ID
                    );
                    

-- �� ������� ���, �����, ���� �ڵ�, ���޸��� ��ȸ 

SELECT EMP_ID, EMP_NAME,EMP.JOB_CODE,JOB_NAME
FROM EMP , JOB 
WHERE EMP.JOB_CODE = JOB.JOB_CODE;

--ANSI ����
SELECT *
FROM EMP
JOIN JOB USING (JOB_CODE);

-- EMP ���̺�� JOB ���̺��� �����Ͽ� ������ �븮�� �����
-- ���, �����, ���޸�, �޿��� ��ȸ 
SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMP
JOIN JOB  ON EMP.JOB_CODE = JOB.JOB_CODE
WHERE JOB.JOB_NAME = '�븮';

SELECT EMP_ID,EMP_NAME,JOB_NAME,SALARY
FROM EMP,JOB
WHERE EMP.JOB_CODE = JOB.JOB_CODE
AND JOB_NAME ='�븮';


/*
    2. ���� JOIN
      �������� ���̺��� ���� �ϴ� ��� ���
*/
-- ���, �����, �μ���, ������ ��ȸ 
SELECT * FROM EMP; 
SELECT * FROM DEPT;
SELECT * FROM LOCATION;

--����Ŭ ���� 
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,LOCAL_NAME 
FROM EMP, DEPT, LOCATION
WHERE DEPT_CODE = DEPT_ID
AND LOCATION_ID = LOCAL_CODE;

--ANSI ���� 
--���������� ��� ������ �߿��ϴ�
SELECT EMP_ID,EMP_NAME,DEPT_TITLE,LOCAL_NAME 
FROM EMP
JOIN DEPT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);


/*
    3. �ܺ�����(OUTTER JOIN)
        ���̺��� JOIN�� ���ǿ� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ
        ������ �Ǵ� ���̺��� ���� �ؾ� �Ѵ�(LEFT/RIGNT/(+))
*/
-- 1) LEFT [OUTER] JOIN 
--      �� ���̺��� ���� ����� ���̺��� �÷��� �������� JOIN�� ����
--      JOIN ������ ��ġ���� �ʾƵ� ���ʿ� ���̺��� ��� ��� 





-- 2) RIGHT [OUTER] JOIN 
--    �� ���̺� �� ������ ����� ���̺��� �÷��� �������� JOIN�� ����
--    ������ ���̺��� ��� ���
-- ����̸�, �μ���, �޿��� ����ϴµ� �μ����̺��� ��� �����Ͱ� ��µǵ��� 


-- 3) FULL [OUTER] JOIN : �� ���̺��� ������ ��� ���� ��ȸ
--    ����Ŭ ������ �������� ���� 


-- 1. DEPT ���̺�� LOCATION ���̺��� �����Ͽ� 
-- �μ� �ڵ�, �μ���, ���� �ڵ�, �������� ��ȸ 
SELECT 


























