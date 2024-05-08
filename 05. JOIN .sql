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

/*
4. ī�׽þȰ�(CARTESIAN PRODUCT) / ���� ����(CROSS JOIN)
    ���εǴ� ��� ���̺��� �� ����� ���μ��� ��� ���ε� �����Ͱ� �˻��ȴ�.
    ���̺��� ����� ��� ������ ����� ������ ��� -> ����ȭ�� ����
*/
SELECT COUNT(*) FROM EMP; -- 23��
SELECT COUNT(*) FROM DEPT; -- 9��

--23*9 = 207
SELECT  *
FROM    EMP, DEPT
ORDER BY EMP_ID;

-- ANSI
SELECT  COUNT(*)
FROM    EMP
CROSS JOIN DEPT;

/*
5. �� ����(NON EQUAL JOIN)
    ���� ���ǿ� ��ȣ(=)�� ������� �ʴ� ���ι��� �� �����̶�� �Ѵ�.
    ������ �÷� ���� ��ġ�ϴ� ��찡 �ƴ�, 
    ���� ������ ���ԵǴ� ����� �����ϴ� ����̴�.
    ( = �̿ܿ� �� ������ >, <, >=, <=, 
    BETWEEN AND, IN, NOT IN ���� ����Ѵ�.)
    ANSI �������δ� JOIN ON �������θ� ����� �����ϴ�. (USING ��� �Ұ�)    
*/
/* �޿���� ���̺� ���� */
CREATE TABLE SAL_GRADE(
	SAL_LEVEL CHAR(2 BYTE), 
	MIN_SAL NUMBER, 
	MAX_SAL NUMBER
);
COMMENT ON COLUMN SAL_GRADE.SAL_LEVEL IS '�޿����';
COMMENT ON COLUMN SAL_GRADE.MIN_SAL IS '�ּұ޿�';
COMMENT ON COLUMN SAL_GRADE.MAX_SAL IS '�ִ�޿�';
COMMENT ON TABLE SAL_GRADE IS '�޿����'; 

Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL)
                                values ('S1',6000000,10000000);
Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL) 
                                values ('S2',5000000,5999999);
Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL) 
                                values ('S3',4000000,4999999);
Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL) 
                                values ('S4',3000000,3999999);
Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL) 
                                values ('S5',2000000,2999999);
Insert into SAL_GRADE (SAL_LEVEL,MIN_SAL,MAX_SAL) 
                                values ('S6',1000000,1999999); 
COMMIT;

SELECT * FROM SAL_GRADE;

-- ������
SELECT  EMP_NAME, SALARY, SAL_LEVEL, MAX_SAL, MIN_SAL
FROM    EMP, SAL_GRADE
WHERE   SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- ������ �ߺ��Ǵ°��, ����� ���� �޿������ ������ �ִ�(�ߺ�)
UPDATE SAL_GRADE SET MAX_SAL = 2999999 WHERE SAL_LEVEL = 'S5';
COMMIT;

/*
6. ��ü ����(SELF JOIN)
    ���� ���̺��� �ٽ� �ѹ� �����ϴ� ��쿡 ����Ѵ�.
*/
-- ��� ���̺��� �Ŵ����� ����� ����ִ� �÷�(MANAGER_ID)�� �ִ�

SELECT  E.EMP_ID ���, E.EMP_NAME �̸�, E.MANAGER_ID �Ŵ������, M.EMP_NAME �Ŵ����̸�
FROM    EMP E, EMP M
WHERE   E.MANAGER_ID = M.EMP_ID(+);

SELECT * FROM EMP;

-- ANSI ����
SELECT  E.EMP_ID ���, E.EMP_NAME �̸�, E.MANAGER_ID �Ŵ������, M.EMP_NAME �Ŵ����̸�
FROM    EMP E
LEFT /*OUTER*/ JOIN    EMP M ON (E.MANAGER_ID = M.EMP_ID);

-- �ǽ�����
-- ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ����� ��ȸ
-- ����Ŭ
SELECT  EMP_ID, EMP_NAME, BONUS, DEPT_TITLE 
FROM    EMP, DEPT
WHERE   DEPT_CODE = DEPT_ID
AND     BONUS IS NOT NULL;
-- ANSI
SELECT  EMP_ID, EMP_NAME, BONUS, DEPT_TITLE 
FROM    EMP
JOIN    DEPT ON (DEPT_CODE = DEPT_ID)
WHERE   BONUS IS NOT NULL;

-- �λ�����ΰ� �ƴ� ������� �����, �μ���, �޿��� ��ȸ
-- ����Ŭ
-- ������ ��� (�μ��ڵ尡 �Էµ��� ���� ���)
SELECT  EMP_NAME, DEPT_TITLE, SALARY
FROM    EMP, DEPT
-- ���� ������ ��ġ ���� �ʾƵ� ��ȸ!!!!
WHERE   EMP.DEPT_CODE = DEPT.DEPT_ID(+)
-- NULL�� �񱳵��� �����Ƿ� ���� Ȯ��
AND     (DEPT_TITLE != '�λ������' OR DEPT_TITLE IS NULL);
SELECT * FROM EMP WHERE DEPT_CODE IS NULL;

-- ANSI
SELECT  EMP_NAME, NVL(DEPT_TITLE, '�μ�����'), NVL(DEPT_CODE, '�μ�����'), SALARY
FROM    EMP LEFT JOIN    DEPT ON (DEPT_CODE = DEPT_ID)
-- NULL�� �񱳰� ���� �����Ƿ� �ٸ����ڷ� �������ش�
-- NULL���� �μ��������� ������ ����
WHERE   NVL(DEPT_TITLE, '�μ�����') != '�λ������';

-- ���, �����, �μ���, ������, ������ ��ȸ
-- �����Ǵ� ����� ���� ��ȸ�غ��ô�
SELECT  EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM    EMP, DEPT, LOCATION, NATIONAL
-- (+) : ���������� ��ġ���� �ʴ� �����͸� ��ȸ �ϱ� ���ؼ�
-- ������̺��� ���� �����͸� ������ �ð����� 
WHERE   DEPT_CODE = DEPT_ID(+)
AND     LOCATION_ID = LOCAL_CODE(+)
AND     LOCATION.NATIONAL_CODE = NATIONAL.NATIONAL_CODE(+);

-- ANSI
SELECT  EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM    EMP
LEFT JOIN    DEPT ON (DEPT_CODE = DEPT_ID)
LEFT JOIN    LOCATION ON (LOCATION_ID = LOCAL_CODE)
LEFT JOIN    NATIONAL USING (NATIONAL_CODE);

-- ���, �����, �μ���, ������, ������, �޿� ��� ��ȸ
-- �޿������ S1,S2 �̸� ���, S3,S4�� �߱�, S5,S6�� �ʱ� , �ش����� ������ ''
SELECT  EMP_ID, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
        , SAL_LEVEL �޿����
        , CASE
        , DECODE
FROM    EMP, DEPT, LOCATION, NATIONAL, SAL_GRADE
WHERE   DEPT_CODE = DEPT_ID(+)
AND     LOCATION_ID = LOCAL_CODE(+)
AND     LOCATION.NATIONAL_CODE = NATIONAL.NATIONAL_CODE(+)
AND     SALARY BETWEEN MIN_SAL AND MAX_SAL;
-- JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

-- �μ��� �ְ� �޿��� �޴»�� 
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM    EMP
WHERE   (DEPT_CODE, SALARY) IN (    SELECT  DEPT_CODE, MAX(SALARY)
                                    FROM    EMP
                                    GROUP BY DEPT_CODE
                                    );


SELECT  MAX(SALARY)
FROM    EMP
GROUP BY DEPT_CODE;


SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMP
-- ���������� ��ȸ ����� �������ΰ�� = �Ǵ� IN�� ����� ���ִ�
-- ���������� ��ȸ ����� �������ΰ�� = �� ���� ������ �߻� �մϴ�!!!!!!!
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE 
                                    FROM EMP
                                    WHERE SUBSTR(EMP_NO, 8, 1)=2 AND ENT_YN='Y');

SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID
FROM EMP E
WHERE EXISTS (SELECT EMP_ID
                FROM EMP M
                WHERE M.EMP_ID = E.MANAGER_ID);
                
-- ���� �� ���� ���ǿ� 2�� �̻��� ���� ���ϵǾ����ϴ�.
-- ���� ���� �ʹ� �����ϴ�
SELECT E.EMP_ID, E.EMP_NAME, E.MANAGER_ID,
        NVL((SELECT M.EMP_NAME, EMP_ID
                FROM EMP M
                WHERE E.MANAGER_ID = M.EMP_ID), '����') AS �����ڸ�
FROM EMP E
ORDER BY 1; 









