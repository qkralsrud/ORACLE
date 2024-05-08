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
-- �� ������� ���, �����, �μ� �ڵ�, �μ����� ��ȸ
SELECT COUNT(*) FROM EMP; --23��
-- DEPT_CODE
SELECT EMP_ID, EMP_NAME, DEPT_CODE FROM EMP;
SELECT COUNT(*) FROM DEPT; --9��
-- DEPT_ID
SELECT DEPT_ID, DEPT_TITLE FROM DEPT;
-- ����Ŭ ����
-- 1) ������ �÷��� �ٸ����
-- 207 = 23 * 9
SELECT COUNT(*) FROM EMP; -- 23��
SELECT COUNT(*) FROM DEPT; -- 9��
SELECT  *
FROM    EMP, DEPT
WHERE   DEPT_CODE = DEPT_ID; -- 21��
-- INNER JOIN : ���� ���ǿ� �����ϴ� ���� ��ȸ
-- ��� ���̺��� ������ ������ ã��
-- 1) �������� �̿�
-- ��ü ����� ������� - ���ι��� �������
-- ��ġ���� �ʴ� ���� ��ȸ �غ��ô�
-- EMP ���̺� ���� : DEPT_ID��  NULL
SELECT * FROM EMP
MINUS
SELECT  EMP.*    -- EMP���̺��� ������ �ִ� ��� �÷��� ��ȸ
FROM    EMP, DEPT
WHERE   DEPT_CODE = DEPT_ID ; -- ���� ����

-- �μ����̺��� ������ ���� �μ��ڵ带 ã�ƺ��ô�
-- ���ΰ�� �ߺ��� ����
SELECT  DISTINCT(DEPT_ID)
FROM    EMP, DEPT
WHERE   DEPT_CODE = DEPT_ID;
-- ����� �������� ���� �μ� 3��
SELECT * 
FROM DEPT
WHERE DEPT_ID NOT IN (
    SELECT  DISTINCT(DEPT_ID)
    FROM    EMP, DEPT
    WHERE   DEPT_CODE = DEPT_ID
);
-- ǥ�� ANSI
SELECT  EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM    EMP
JOIN    DEPT ON (DEPT_ID = DEPT_CODE);

-- �� ������� ���, �����, ���� �ڵ�, ���޸��� ��ȸ
-- ����Ŭ ����
-- ���� ���ǰ� �ָ��մϴ� : ���̺� ������ �÷��� �ִ°��!
SELECT  EMP_ID, EMP_NAME, EMP.JOB_CODE, JOB_NAME
FROM    EMP, JOB
-- �÷����� ������ ��� �÷��� �տ� ���̺���� ����Ѵ�
WHERE   EMP.JOB_CODE = JOB.JOB_CODE; 

-- ���̺� ��Ī�� ����� ��� SELECT��/WHERE�������� ��Ī�� �̿��ؼ� ����
SELECT  EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM    EMP E, JOB J
WHERE   E.JOB_CODE = J.JOB_CODE;

-- ANSI ����
-- USING ���� �� �κ��� �ĺ��ڸ� ���� �� ����
-- USING���� ���� �÷��� ���̺��̸��� �տ� ���� �� ����
SELECT  EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM    EMP
JOIN    JOB USING (JOB_CODE);
-- ON�� - �÷����� ������ ��� ���̺��� �̸��� �÷��տ� ���
SELECT  EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM    EMP E
JOIN    JOB J ON (E.JOB_CODE = J.JOB_CODE);


/*
	* ANSI SQL
	DBMS(Oracle, My-SQL, DB2 ���)�鿡�� ���� �ٸ� SQL�� ����ϹǷ�, 
	�̱� ǥ�� ��ȸ(American National Standards Institute)���� �̸� 
    ǥ��ȭ�Ͽ� ǥ�� SQL���� ���� ���� ���� ���̴�.
*/

-- EMP ���̺�� JOB ���̺��� �����Ͽ� ������ �븮�� �����
-- ���, �����, ���޸�, �޿��� ��ȸ
-- ����Ŭ ����
SELECT  EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM    EMP, JOB
WHERE   EMP.JOB_CODE = JOB.JOB_CODE
AND     EMP.JOB_CODE = 'J6';-- JOB_NAME = '�븮';

-- ANSI ����
SELECT  EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM    EMP
--JOIN    JOB USING (JOB_CODE)
JOIN    JOB ON (EMP.JOB_CODE = JOB.JOB_CODE)
WHERE   JOB_NAME='�븮';

/*
    2. ���� JOIN
      �������� ���̺��� ���� �ϴ� ��� ���
*/
-- ���, �����, �μ���, ������ ��ȸ
SELECT * FROM EMP;  -- DEPT_CODE
SELECT * FROM DEPT; -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION; -- LOCAL_CODE

-- ����Ŭ ����
SELECT  EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM    EMP, DEPT, LOCATION
WHERE   DEPT_CODE = DEPT_ID
AND     LOCATION_ID = LOCAL_CODE;

-- ANSI ���� 
-- ���������� ��� ������ �߿��ϴ�
SELECT  EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM    EMP
-- INNER ���� ����
/*INNER*/ JOIN    DEPT ON (DEPT_CODE=DEPT_ID)
JOIN    LOCATION ON (LOCATION_ID = LOCAL_CODE);

/*
    3. �ܺ�����(OUTTER JOIN)
        ���̺��� JOIN�� ���ǿ� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ
        ������ �Ǵ� ���̺��� ���� �ؾ� �Ѵ�(LEFT/RIGNT/(+))
*/

-- 1) LEFT [OUTER] JOIN 
--      �� ���̺��� ���� ����� ���̺��� �÷��� �������� JOIN�� ����
--      JOIN ������ ��ġ���� �ʾƵ� ���ʿ� ���̺��� ��� ���

-- ������ ��� 2���� ��� ��� �ϰ� �;��!
-- ����Ŭ ����
SELECT  EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE
FROM    EMP, DEPT
WHERE   EMP.DEPT_CODE = DEPT.DEPT_ID(+);

-- ANSI ����
SELECT  EMP_ID, EMP_NAME, DEPT_ID, DEPT_TITLE
FROM    EMP   
LEFT /*OUTER*/ JOIN    DEPT ON (DEPT_CODE = DEPT_ID);

-- 2) RIGHT [OUTER] JOIN 
--    �� ���̺� �� ������ ����� ���̺��� �÷��� �������� JOIN�� ����
--    ������ ���̺��� ��� ���
-- ����̸�, �μ���, �޿��� ����ϴµ� �μ����̺��� ��� �����Ͱ� ��µǵ���

-- ����Ŭ
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM    EMP, DEPT
WHERE   EMP.DEPT_CODE(+) = DEPT.DEPT_ID;

-- ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM    EMP 
RIGHT OUTER JOIN    DEPT ON (DEPT_CODE = DEPT_ID);

-- 3) FULL [OUTER] JOIN : �� ���̺��� ������ ��� ���� ��ȸ
--    ����Ŭ ������ �������� ����
-- ��ȸ���Ǹ���                           21�� 
-- ������̺� �μ��ڵ尡 NULL��             2�� 
-- �μ����̺� ����� �������� ���� �μ��ڵ�   3��
SELECT EMP_NAME, DEPT_TITLE, SALARY
FROM   EMP 
FULL OUTER JOIN    DEPT ON (DEPT_CODE = DEPT_ID);

-- 1. DEPT ���̺�� LOCATION ���̺��� �����Ͽ� 
-- �μ� �ڵ�, �μ���, ���� �ڵ�, �������� ��ȸ
-- ����Ŭ ����
SELECT  DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM    DEPT, LOCATION
WHERE   LOCATION_ID = LOCAL_CODE;

-- ANSI����
SELECT  DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM    DEPT
JOIN    LOCATION ON (LOCATION_ID = LOCAL_CODE);
