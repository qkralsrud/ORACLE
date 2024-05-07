-- �ִ�޿��� �ּұ޿�
SELECT MIN(SALARY) �ּұ޿�, MAX(SALARY) �ִ�޿�, FLOOR(AVG(SALARY)) ��ձ޿�
        , COUNT(SALARY) �����, SUM(SALARY) �޿��հ�
FROM EMP;
/*
    <GROUP BY>
        �׷� ������ ������ �� �ִ� ����
        ���� ���� ������ �ϳ��� �׷����� ��� ó���� �������� ����Ѵ�.
*/
-- ��ü ����� �ϳ��� �׷����� ��� ������ ���� ��� ��ȸ
-- ��ü ����� �ϳ��� �׷����� ���� �� ���� ���� ���
SELECT  SUM(SALARY)
FROM    EMP;

-- �μ���(�׷����� ����) �޿��� �հ�
-- GROUP BY ǥ������ �ƴմϴ�.
SELECT  EMP_NAME, DEPT_CODE, SUM(SALARY)
FROM    EMP
GROUP BY DEPT_CODE;

-- �μ��� ����� ��
-- NULL�� ���� �����Ƿ� ���� �ٸ��� ���ü� �ִ�!!!!!!
SELECT DEPT_CODE, COUNT(DEPT_CODE), COUNT(*)
FROM EMP
GROUP BY DEPT_CODE;

-- �� �μ��� ���ʽ��� �޴� �����
SELECT  DEPT_CODE �μ�, COUNT(BONUS) "���ʽ� �޴� ��� ��"
FROM    EMP
GROUP BY DEPT_CODE
--ORDER BY "���ʽ� �޴� ��� ��" DESC;
--ORDER BY 2 DESC;
ORDER BY COUNT(BONUS);

-- �� ���޺� �޿� ��� ��ȸ
SELECT  JOB_CODE �����ڵ�
    , TO_CHAR(FLOOR(AVG(NVL(SALARY,0))),'999,999,999') ��ձ޿�
FROM    EMP
GROUP BY JOB_CODE;

-- �μ��� �����, ���ʽ��� �޴� �����, �޿��� ��, ��� �޿�, �ְ� �޿�, ���� �޿��� ��ȸ
SELECT  DEPT_CODE �μ��ڵ�, COUNT(*) �����
        , TO_CHAR(SUM(SALARY),'999,999,999') �޿�����
        , TO_CHAR(FLOOR(AVG(NVL(SALARY,0))),'999,999,999') ��ձ޿�
        , TO_CHAR(MAX(SALARY),'999,999,999') �ְ�޿�
        , TO_CHAR(MIN(SALARY),'999,999,999') �����޿�
FROM    EMP
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE NULLS FIRST;

-- �Ի��Ϻ� �����
SELECT TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') �Ի���, COUNT(*) �Ի��ڼ�
FROM EMP
GROUP BY HIRE_DATE;

SELECT * FROM EMP;

-- �Ի�⵵�� ����� ��
SELECT  TO_CHAR(HIRE_DATE, 'YYYY') �⵵,  COUNT(*) �Ի��ڼ�
FROM    EMP
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY')
ORDER BY �⵵;

SELECT  TO_CHAR(HIRE_DATE, 'YYYY') �⵵, TO_CHAR(HIRE_DATE, 'MM') �� ,  COUNT(*) �Ի��ڼ�
FROM    EMP
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY'), TO_CHAR(HIRE_DATE, 'MM')
ORDER BY �⵵;

-- ���� �� �����
SELECT  DECODE(SUBSTR(EMP_NO, 8,1), '1', '����', '2', '����') ����, COUNT(*)
FROM    EMP
GROUP BY SUBSTR(EMP_NO, 8,1);

-- �μ��� ���޺� ����� ��, �޿����հ�
SELECT  DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM    EMP
GROUP BY DEPT_CODE, JOB_CODE
ORDER BY 1,2;

/*
    <HAVING>
        �׷쿡 ���� ������ ������ �� ����ϴ� ����(�ַ� �׷� �Լ��� ����� ������ �� ����)
    
    * ���� ����
        5: SELECT      ��ȸ�ϰ��� �ϴ� �÷��� AS "��Ī" | ���� | �Լ���
        1: FROM        ��ȸ�ϰ��� �ϴ� ���̺��
        2: WHERE       ���ǽ�
        3: GROUP BY    �׷� ���ؿ� �ش��ϴ� �÷��� | ���� | �Լ���
        4: HAVING      �׷쿡 ���� ���ǽ�
        6: ORDER BY    ���� ���ؿ� �ش��ϴ� �÷��� | ��Ī | �÷� ����
*/
-- �� �μ��� ��� �޿� ��ȸ
SELECT  DEPT_CODE, FLOOR(AVG(NVL(SALARY, 0))) ��ձ޿�
FROM    EMP
GROUP BY DEPT_CODE;

SELECT  *
FROM    EMP
WHERE   SALARY >= 3000000;
-- �� �μ��� �޿��� 300���� �̻��� ������ ��� �޿� ��ȸ 
SELECT  DEPT_CODE, FLOOR(AVG(NVL(SALARY, 0))) ��ձ޿�
FROM    EMP
WHERE   SALARY >= 3000000
GROUP BY DEPT_CODE;
-- �� �μ��� ��� �޿��� 300���� �̻��� �μ��鸸 ��ȸ
SELECT  DEPT_CODE, FLOOR(AVG(NVL(SALARY, 0))) ��ձ޿�
FROM    EMP
-- �׷� �Լ��� �㰡���� �ʽ��ϴ�
-- WHERE   AVG(NVL(SALARY, 0)) >= 3000000
GROUP BY DEPT_CODE
HAVING AVG(NVL(SALARY, 0)) >= 3000000;

-- ���޺� �� �޿��� ���� 10000000 �̻��� ���޵鸸 ��ȸ
SELECT  JOB_CODE, SUM(SALARY)
FROM    EMP
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- �μ��� ���ʽ��� �޴� ����� ���� �μ��鸸 ��ȸ
SELECT  DEPT_CODE, COUNT(BONUS)
FROM    EMP
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

/*
    <���� �Լ�>
        �׷캰 ������ ��� ���� �߰� ���踦 ��� ���ִ� �Լ�
*/
-- ���޺� �޿��� �հ� 
SELECT  JOB_CODE, SUM(SALARY)
FROM    EMP
GROUP BY JOB_CODE;

-- �������࿡ ��ü �� �޿��� �հ踦 ��ȸ
SELECT  JOB_CODE, SUM(SALARY)
FROM    EMP
GROUP BY ROLLUP(JOB_CODE);

-- �μ� �ڵ嵵 ���� ���� �ڵ嵵 ���� ������� �׷� ��� �޿��� �հ踦 ��ȸ
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMP
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE, JOB_CODE;






