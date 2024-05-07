/*
    <�׷� �Լ�>
        �뷮�� �����͵�� ���質 ��� ���� �۾��� ó���ؾ� �ϴ� ��� ���Ǵ� �Լ����̴�.
        ��� �׷� �Լ��� NULL ���� �ڵ����� �����ϰ� ���� �ִ� �͵鸸 ����� �Ѵ�.
        ���� AVG �Լ��� ����� ���� �ݵ�� NVL() �Լ��� �Բ� ����ϴ� ���� �����Ѵ�.
        
        1) SUM
            [ǥ����]
                SUM(NUMBER)
                
            - �ش� �÷� ������ �� �հ踦 ��ȯ�Ѵ�.
*/

-- EMPLOYEE ���̺��� ����� �� �޿��� �հ�
SELECT TO_CHAR(SUM(SALARY),'L99,999,999')||'��' �ѱ޿�
FROM EMP;

-- EMPLOYEE ���̺��� ���� ����� �� �޿��� �հ�
SELECT  --EMP_NO
        SUM(SALARY)
FROM    EMP
-- ������
WHERE   SUBSTR(EMP_NO, 8,1) = 1;

-- EMPLOYEE ���̺��� ����� �� ������ �հ�
SELECT  SUM(SALARY*12)
FROM    EMP;

-- EMPLOYEE ���̺��� D1�μ��� �� ������ �հ�
SELECT  SUM(SALARY*12)
FROM    EMP
WHERE   DEPT_CODE = 'D1';

/*
        2) AVG
            [ǥ����]
                AVG(NUMBER)
            
            - �ش� �÷� ������ ����� ���ؼ� ��ȯ�Ѵ�.
*/
-- NULL�� ������ �ֱ� ������ Ȯ���ϴ� �۾�
SELECT  TO_CHAR(FLOOR(AVG(SALARY)),'999,999,999') ��ձ޿�
FROM    EMP;
SELECT  SUM(SALARY), COUNT(SALARY), SUM(SALARY)/COUNT(SALARY)
FROM    EMP;

/*
        3) COUNT
            [ǥ����]
                COUNT(*|�÷���|DISTINCT �÷���)
            
            - �÷� �Ǵ� ���� ������ ���� ��ȯ�ϴ� �Լ��̴�.
            - COUNT(*) : ��ȸ ����� �ش��ϴ� ��� ���� ������ ��ȯ�Ѵ�.
            - COUNT(�÷���) : ������ �÷� ���� NULL�� �ƴ� ���� ������ ��ȯ�Ѵ�.
            - COUNT(DISTINCT �÷���) �ش� �÷� ���� �ߺ��� ������ ���� ������ ��ȯ�Ѵ�. 
*/
-- ��ü ��� ��
SELECT COUNT(*)
FROM EMP;

-- ���� ����� ��
SELECT  COUNT(*)
FROM    EMP
WHERE   (SUBSTR(EMP_NO, 8, 1) = '2' OR SUBSTR(EMP_NO, 8, 1) = '4');

-- ���ʽ��� �޴� ������ �� 
SELECT  COUNT(BONUS)
FROM    EMP;

-- ����������(RESULT SET)�� ������ �����ش�
SELECT  COUNT(*)
FROM    EMP
WHERE   BONUS IS NOT NULL;

-- ���������   ENT_DATE, ENT_YN
SELECT  COUNT(ENT_DATE)
FROM    EMP;

SELECT  COUNT(*)
FROM    EMP
WHERE   ENT_YN = 'Y';

-- ���� ������� ���� �ִ� �μ��� ��
-- �� ����� 23���ε�, 21�� ����? NULL(�μ��� �������� �������) 2��
SELECT  COUNT(DISTINCT DEPT_CODE)
FROM    EMP;

SELECT  DISTINCT DEPT_CODE
FROM    EMP;

-- ���� ������� ���� �ִ� ������ ��
SELECT  COUNT(DISTINCT JOB_CODE)
FROM    EMP;







