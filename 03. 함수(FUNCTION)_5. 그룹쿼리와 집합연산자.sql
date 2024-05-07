/*
    <�׷��Լ�>
        �뷮�� �����͵�� ���質 ��谰�� �۾��� ó���ؾ� �ϴ� ��� ��� �ϴ� �Լ�
        ��� �׷��Լ��� NULL ���� �ڵ����� ����
        => NVL()�Լ��� �Բ� ����ϴ°��� ���� �մϴ�.
    
    1) SUM(NUMBER) 
        - �ش� �÷��� �� �հ踦 ��ȯ �մϴ�
    2) AVG(NUMBER)
        - �ش� �÷��� ����� ��ȯ �մϴ�.
    3) MIN(���Ÿ��) / MAX(���Ÿ��)
        - MIN : �ش� �÷��� ������ ���� ���� ���� ��ȯ �մϴ�.
        - MAX : �ش� �÷��� ������ ���� ū ���� ��ȯ �մϴ�.
    4) COUNT(*|�÷���)
        - ��� ���� ������ ���� ��ȯ �ϴ� �Լ�
        - COUNT(*) : ��ȸ����� �ش��ϴ� ��� ���� ������ ��ȯ
        - COUNT(�÷���) : ������ �÷����� NULL�� �ƴ� ���� ������ ��ȯ
        - COUNT(DISTINCT �÷���) : �ش� �÷��� �ߺ��� ������ �� ���� ������ ��ȯ
*/
-- �����Լ� : ������ �Ǵ� ���̺� ��ü ������ ���� �ϳ��� ������� ��ȯ
-- 107��
SELECT  COUNT(*)
FROM    EMP;

SELECT  COUNT(EMPLOYEE_ID)
FROM    EMP;

-- 106�� - �÷��� ����� ��� NULL�� ī��Ʈ ���� �ʴ´�!
SELECT  COUNT(DEPARTMENT_ID)
FROM    EMP;

SELECT DEPARTMENT_ID FROM EMP WHERE DEPARTMENT_ID IS NULL;

-- �ߺ��� ������ �Ǽ� 
-- �÷��� ��� ������ NULL�� ī��Ʈ ���� �����Ƿ�
-- 11��
SELECT  COUNT(DISTINCT DEPARTMENT_ID)
FROM    EMP;
-- NVL �Լ��� �̿��ؼ� NULL���� ġȯ�� ��ȸ
-- 12��
SELECT  COUNT(DISTINCT NVL(DEPARTMENT_ID,0))
FROM    EMP;

-- 12��
SELECT  DISTINCT DEPARTMENT_ID
FROM    EMP;
-- EMP ����� �� �޿���
SELECT  SUM(SALARY)
FROM    EMP;
-- ����� �޿��հ�, �ߺ��� ������ �޿��� �հ�
-- ������ �޿��� ������ 1���� ���� �ݴϴ�
SELECT  SUM(SALARY), SUM(DISTINCT SALARY)
FROM    EMP;
-- �޿� ��ȸ
SELECT  SALARY
FROM    EMP
ORDER BY SALARY;
-- EMP ����� ��� �޿���
SELECT  AVG(SALARY)
FROM    EMP;
-- �޿� ��հ� �ߺ��� ������ �޿��� ���
SELECT  AVG(SALARY), AVG(DISTINCT SALARY)
FROM    EMP;
-- EMP �����ȣ�� �ִ밪
SELECT  MAX(employee_id)+1
FROM    EMP;
-- EMP �޿��� �ִ밪, �ּҰ�
-- �ߺ����� Ű���尡 �͵� ��ȯ �Ǵ� ���� ���� ��
SELECT  MIN(SALARY), MAX(DISTINCT SALARY)
FROM    EMP;

/*
    <GROUP BY>
        - �׷쿡 ���� ������ ������ �� �ִ� ����
        �������� ������ �ϳ��� �׷����� ��� ó���� �������� ����Ѵ�.
        SELECT 
        FROM
        [WHERE]
        [GROUP BY]
        [ORDER BY]
        ������ ���� �� ���� ������ 
        - ������ �ۼ��� ������� �ۼ� �ؾ� �Ѵ�
        - SELECT ������ �����Լ��� GROUP BY���� ��õ� �÷��� �ۼ��� �����ϴ�
*/
-- ��ü����� �ϳ��� �׷����� ���� ������ ���� ���
SELECT  SUM(SALARY)
FROM    EMP;
-- �μ��� ����� �޿��� �հ�
SELECT  department_id �μ�, SUM(SALARY) �޿����հ�, COUNT(employee_id) �����
FROM    EMP
GROUP BY department_id
ORDER BY 1;

-- �� �μ��� �����
SELECT  DEPARTMENT_ID, COUNT(*)
FROM    EMP
GROUP BY DEPARTMENT_ID
ORDER BY 2 DESC;

-- �� �μ��� ���ʽ��� �޴� �����
-- NULL�� ���� ���� �����Ƿ� 
SELECT  DEPARTMENT_ID, COUNT(COMMISSION_PCT)
FROM    EMP
GROUP BY DEPARTMENT_ID;

-- JOB_ID
-- ���޺� �޿��� ���
-- �Ҽ��� ����, ���ڸ�(,)
-- �����ڵ�, �޿������, ����Ǽ�
select  JOB_ID
        , TO_CHAR(FLOOR(AVG(SALARY)),'9,999,999')
        , COUNT(*) || '��'
from    emp
group by job_id;

-- �μ��� 
-- �����, ���ʽ��� �޴� �����
-- , �޿��� ��, ��ձ޿�, �ְ�޿�, �����޿�
-- �ݾ� 3�ڸ��޸�, ��������� ���� �ٿ��� ���� ����
-- ������� 0���̸� ǥ������ ����
SELECT  DEPARTMENT_ID �μ��ڵ�
        , LPAD(COUNT(*)||'��',4) �ο���
        , LPAD(DECODE(COUNT(COMMISSION_PCT)
                    , 0, ' '
                    , COUNT(COMMISSION_PCT)||'��'),10) ���ʽ��޴»��
        , SUM(SALARY) "�޿��� �հ�"
        , TO_CHAR(FLOOR(AVG(SALARY)),'999,999') "�޿��� ���"
        , MAX(SALARY) "�޿��� �ִ밪", MIN(SALARY) "�޿��� �ּҰ�"
FROM    EMP
GROUP BY DEPARTMENT_ID 
ORDER BY 1;

-- �����̺��� ������ ������ ���غ��ô�
-- ���� ���� ������������ ����
SELECT  CUST_GENDER, COUNT(*)
FROM    CUSTOMERS
GROUP BY CUST_GENDER;

-- �Ұ踦 ���ϴ� �Լ� ROLLUP
SELECT  DECODE(CUST_GENDER,'F','��','M','��',' ') ����, COUNT(*) ����
FROM    CUSTOMERS
GROUP BY ROLLUP(CUST_GENDER);

-- �� ���� : 55500��
SELECT COUNT(*) FROM CUSTOMERS;

-- ���� �÷��� �����ؼ� �׷��� ������ ����
-- �μ��� ���޺� ������� �޿��� ����
SELECT  DEPARTMENT_ID, JOB_ID, COUNT(*), SUM(SALARY)
FROM    EMP
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY 1,2;

/*
    <HAVING>
        - �׷쿡 ���� ������ ������ �� ��� �ϴ� ����
        - �׷��ռ��� ����� ������ �񱳸� ����
        
        * �������
          5: SELECT     ��ȸ �ϰ��� �ϴ� �÷��� | ���� | �Լ��� [AS] ��Ī
          1: FROM       ��ȸ �ϰ��� �ϴ� ���̺��
          2: WHERE      ���ǽ�
          3: GROUP BY   �׷� ���ؿ� �ش��ϴ� �÷��� | ���� | �Լ���
          4: HAVING     �׷쿡 ���� ���ǽ�
          6: ORDER BY   ���ı��ؿ� �ش��ϴ� �÷��� | ��Ī | �÷�����
*/
-- ���޺� �� �޿��� ���� 10000�̻��� ����,�޿������� ��ȸ
SELECT  JOB_ID, SUM(SALARY)
FROM    EMP 
-- �׷��Լ��� WHERE ���� �ü� �����ϴ�.
-- �����Լ��� �㰡���� �ʽ��ϴ�. ���� �߻�
-- WHERE SUM(SALARY) >= 10000
GROUP BY JOB_ID
HAVING SUM(SALARY) >= 10000;

-- �μ��� ��� �޿��� 7000 �̻��� �μ��ڵ�� ��ձ޿��� ������� ��ȸ
-- ��� �޿��� �Ҽ����� �����ϰ� ���ڸ��޸��� ����
SELECT  DEPARTMENT_ID �μ��ڵ�
        , TO_CHAR(FLOOR(AVG(SALARY)),'9,999,999') ��ձ޿�
        , COUNT(*)
FROM    EMP
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) >= 7000
ORDER BY department_id
;

-- �μ��� ���ʽ��� �޴� ����� �ִ� �μ��鸸 ��ȸ
SELECT  DEPARTMENT_ID, COUNT(COMMISSION_PCT)
FROM    EMP
-- �����Լ��� WHERE ���� �ü� �����ϴ�.
-- WHERE COUNT(COMMISSION_PCT) = 0
GROUP BY DEPARTMENT_ID
HAVING COUNT(COMMISSION_PCT) != 0;

/*
    <���� �Լ�>
        �׷캰 ������ ��� ���� �߰� ���踦 ����� �ִ� �Լ�
*/
-- ���޺� �޿��� �հ踦 ��ȸ
-- ������ �࿡ ��ü �� �޿��� �հ���� ��ȸ
SELECT  JOB_ID, SUM(SALARY)
FROM    EMP
GROUP BY ROLLUP(JOB_ID)
ORDER BY 1;

SELECT  JOB_ID, SUM(SALARY)
FROM    EMP
GROUP BY CUBE(JOB_ID)
ORDER BY 1;

-- �μ� �ڵ嵵 ���� ���� �ڵ嵵 ���� ������� �׷� ��� �޿��� �հ踦 ��ȸ
SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY)
FROM    EMP
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY 1,2;

SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY)
FROM    EMP
GROUP BY CUBE(DEPARTMENT_ID, JOB_ID)
ORDER BY 1,2;

/*
    <GROUPING>
        RULLUP�̳� CUBE�� ���� ����� ���� 
        �ش� �÷��� ������ ���⹰�̸� 0�� ��ȯ
                            �ƴϸ� 1�� ��ȯ
*/
SELECT DEPARTMENT_ID, JOB_ID
        , SUM(SALARY)
        , GROUPING(DEPARTMENT_ID)
        , GROUPING(JOB_ID)
FROM    EMP
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY 1,2;

/*
    <���� ������>
    - �������� �������� ������ �ϳ��� �������� ����� ������
    - ������
        UNION       : �� �������� ������ ����� ������ �ߺ��Ǵ� ���� ����
        UNION ALL   : �ߺ��� ����Ѵ�
    - ������
        INTERSECT   : �� �������� ������ ������� �ߺ��� ������� ���� �Ѵ�
    - ������    
        MINUS       : ���� ������տ��� ���� ��������� �� ������ ������� ���� �Ѵ� 
*/
-- �μ��ڵ尡 20�� ����� ��ȸ  2�� ��ȸ
SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   DEPARTMENT_ID = 20;
-- �޿��� 5000-6000  3�� ��ȸ
SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   SALARY BETWEEN 5000 AND 6000;
-- ���, �̸�, �μ��ڵ�, �޿�

-- ������ UNION : �ߺ��� ����
-- 202�� ����� �ߺ� �ǹǷ� 4�� ���
SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   DEPARTMENT_ID = 20

UNION

SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   SALARY BETWEEN 5000 AND 6000;

-- OR����� ������ ����� ������ �ִ�
SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   DEPARTMENT_ID = 20
        OR SALARY BETWEEN 5000 AND 6000;

-- �� ��������� �ϳ��� ��ġ�µ� �ߺ��� ���
SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   DEPARTMENT_ID = 20

UNION ALL

SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   SALARY BETWEEN 5000 AND 6000;

-- ������ -- AND ����� ������ ����� ������ �ִ�
SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   DEPARTMENT_ID = 20

INTERSECT

SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   SALARY BETWEEN 5000 AND 6000;

-- ������
SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   DEPARTMENT_ID = 20

MINUS

SELECT  EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
FROM    EMP
WHERE   SALARY BETWEEN 5000 AND 6000;
