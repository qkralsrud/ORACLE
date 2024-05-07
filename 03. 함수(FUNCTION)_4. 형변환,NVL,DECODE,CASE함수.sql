/*
    <����ȯ �Լ�>
    
    1) TO_CHAR
        [ǥ����]
            TO_CHAR(��¥|����[, ����])
        
        - ��¥ �Ǵ� ���� Ÿ���� �����͸� ���� Ÿ������ ��ȯ�ؼ� ��ȯ�Ѵ�.
        - ������� CHARACTER Ÿ���̴�.
*/

-- ���� -> ����     EX) 3�ڸ� �޸�
SELECT 1234, TO_CHAR(1234) FROM DUAL;
-- 6ĭ(9�� ���� ��ŭ)�� ������ Ȯ��, ����������, ��ĭ �������� ä����
SELECT TO_CHAR(1234, '999999') FROM DUAL;
SELECT TO_CHAR(1234, '999,999') FROM DUAL;
-- ���̰� ª���� #####���� ��� �ǹǷ� ���̸� ����� Ȯ��
SELECT TO_CHAR(123456789, '9,999,999,999') FROM DUAL;
-- ���� ������ ������ ȭ�����
          
SELECT TO_CHAR(123456789, 'L9,999,999,999') FROM DUAL;

SELECT TO_CHAR(123456789, 'FML9,999,999,999') FROM DUAL;
SELECT TO_CHAR(123456789, '$9,999,999,999') FROM DUAL;
-- 6ĭ(9�� ���� ��ŭ)�� ������ Ȯ��, ����������, ��ĭ 0���� ä����
SELECT TO_CHAR(1234, '000000') FROM DUAL;
SELECT TO_CHAR(1234, '000,000') FROM DUAL;

--EMP ���̺��� �����, �޿�(3�ڸ� �޸�) ��ȸ
SELECT EMP_NAME, TO_CHAR(SALARY, 'FM9,999,999,999')
FROM EMP;

-- ��¥ --> ����
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE) FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD(DAY)') FROM DUAL;
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YEAR') FROM DUAL;

-- ���� ���� ����
SELECT TO_CHAR(SYSDATE, 'MM') 
        , TO_CHAR(SYSDATE, 'MON')
        , TO_CHAR(SYSDATE, 'MONTH')
        , TO_CHAR(SYSDATE, 'RM') -- �θ���ȣ
FROM DUAL;
-- �Ͽ� ���� ����
SELECT TO_CHAR(SYSDATE, 'DDD') -- 1���� �������� ����° 
        , TO_CHAR(SYSDATE, 'DD') -- 1���� �������� ����°
        , TO_CHAR(SYSDATE, 'D') -- 1�ָ� �������� ����°
FROM DUAL;
-- ���Ͽ� ���� ����
SELECT TO_CHAR(SYSDATE, 'DY'), TO_CHAR(SYSDATE, 'DAY')
FROM DUAL;
-- �����Է�
SELECT  TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��"(DY)')
FROM    DUAL;

-- EMP ���̺��� ������, �Ի��� ��ȸ
-- ��, �Ի����� ������ �����ؼ� ��ȸ�Ѵ�.(2021-09-28(ȭ))
SELECT  EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD(DY)') �Ի���
FROM    EMP
ORDER BY �Ի��� DESC;

/*
    2) TO_DATE
        [ǥ����]
            TO_DATE(����|����[, ����])
        
        - ���� �Ǵ� ������ �����͸� ��¥ Ÿ������ ��ȯ�ؼ� ��ȯ�Ѵ�.
        - ������� DATE Ÿ���̴�.
*/
-- ���� --> ��¥
SELECT TO_DATE(20211014) FROM DUAL;
SELECT TO_DATE(20211014142020) FROM DUAL;

-- ���� --> ��¥
SELECT TO_DATE('20240501') FROM DUAL;
SELECT TO_DATE('20240501 190830') FROM DUAL;
SELECT TO_DATE('20240501', 'YYYYMMDD') FROM DUAL;

-- EMP ���̺��� 1998�� 1�� 1�� ���Ŀ� �Ի��� ����� ���, �̸�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMP
-- �ڵ�����ȯ
--WHERE HIRE_DATE > '19980101';
--WHERE HIRE_DATE > TO_DATE('19980101', 'YYYYMMDD');
--WHERE HIRE_DATE > TO_DATE('980101', 'RRMMDD');
--WHERE HIRE_DATE > '1998-01-01';
--WHERE HIRE_DATE BETWEEN '1990-01-01' AND '2001-12-31';
;

-- YY�� RR ��
SELECT TO_DATE('211014', 'YYMMDD') FROM DUAL;
SELECT TO_DATE('981014', 'YYMMDD') FROM DUAL; -- YY : ������ ���� ����

-- RR : �ش� ���� 50 �̻��̸� ���� ����, 50 �̸��̸� ���� ���� 
--2021
SELECT TO_DATE('211014', 'RRMMDD') FROM DUAL;
--1998
SELECT TO_DATE('981014', 'RRMMDD') FROM DUAL; 

SELECT TO_CHAR(TO_DATE('51-01-01'), 'RRRR')
        , TO_CHAR(TO_DATE('51-01-01'), 'YYYY') FROM DUAL;


/*
    3) TO_NUMBER
        [ǥ����]
            TO_NUMBER('���ڰ�'[, ����])
        
        - ���� Ÿ���� �����͸� ���� Ÿ���� �����ͷ� ��ȯ�ؼ� ��ȯ�Ѵ�.
        - ������� NUMBER Ÿ���̴�.
*/
SELECT '123456789', TO_NUMBER('0123456789') FROM DUAL;
-- �ڵ����� ���� Ÿ������ �� ��ȯ�� ���� ó��!
SELECT '123' + '456' FROM DUAL;
-- ���� ������ ���ڵ鸸 �ڵ� ����ȯ �ȴ�!!
SELECT '123' + '456A' FROM DUAL;
SELECT '10,000,000' + '99,999,999' FROM DUAL;
SELECT TO_NUMBER('10,000,000', '99,999,999') FROM DUAL;
SELECT TO_NUMBER('10,000,000', '99,999,999') + TO_NUMBER('500,000','999,999') FROM DUAL;

/*
    <NULL ó�� �Լ�>
    
    1) NVL
        [ǥ����]
            NVL(�÷�, �÷����� NULL�� ��� ��ȯ�� ��)
        
        - NULL�� �Ǿ��ִ� �÷��� ���� ���ڷ� ������ ������ �����Ͽ� ��ȯ�Ѵ�.

    2) NVL2
        [ǥ����]
            NVL2(�÷�, ������ �� 1, ������ �� 2)
            
        - �÷� ���� NULL�� �ƴϸ� ������ �� 1, �÷� ���� NULL�̸� ������ �� 2�� �����Ͽ� ��ȯ�Ѵ�.  
    
    3) NULLIF
        [ǥ����]
            NULLIF(�񱳴�� 1, �񱳴�� 2)
            
        - �� ���� ���� �����ϸ� NULL ��ȯ, �� ���� ���� �������� ������ �񱳴�� 1�� ��ȯ�Ѵ�.
*/
-- EMPLOYEE ���̺��� �����, ���ʽ�, ���ʽ��� ���Ե� ���� ��ȸ (NVL �Լ� ���)
-- NULL�� �������� NULL
SELECT  EMP_NAME, BONUS, SALARY, (SALARY +  (SALARY * NVL(BONUS, 0))) * 12 ����
FROM    EMP;
-- EMPLOYEE ���̺��� �����, �μ� �ڵ� ��ȸ (��, �μ� �ڵ尡 NULL�̸� "�μ�����" ���)
SELECT  EMP_NAME, NVL(DEPT_CODE, '�μ�����')
FROM    EMP;

SELECT  NVL(BONUS,0) "���� ���ʽ���", NVL2(BONUS, 0.1,0) "����� ���ʽ���"
FROM    EMP;

-- �ΰ��� ���� ���ڷ� �޾Ƽ� ��, ������ NULL
SELECT NULLIF('123', '123') FROM DUAL;
-- �ٸ��� ù��° ���� ��ȯ
SELECT NULLIF('123', '456') FROM DUAL;

/*
    <�����Լ�>
        ���� ���� ��쿡 ������ �� �� �ִ� ����� �����ϴ� �Լ��̴�.
    
    1) DECODE
        [ǥ����]
            DECODE(�÷�|����, ���ǰ� 1, ����� 1, ���ǰ� 2, ����� 2, ..., �����)
        
        - ���ϰ��� �ϴ� ���� ���ǰ��� ��ġ�� ��� �׿� �ش��ϴ� ������� ��ȯ�� �ִ� �Լ��̴�.
*/
SELECT DECODE('3', '1', '����', '2', '����', '�˼�����') FROM DUAL;
-- EMPLOYEE ���̺��� ���, �����, �ֹι�ȣ, ����(��/��) ��ȸ
SELECT EMP_NO
    , DECODE(SUBSTR(EMP_NO, 8, 1),1,'����',2,'����','�߸��� �ֹε�� ��ȣ�Դϴ�.') ����
FROM EMP;

-- EMPLOYEE ���̺��� �����, ���� �ڵ�, ���� �޿�, �λ�� �޿��� ��ȸ
-- ���� �ڵ尡 J7�� ����� �޿��� 10% �λ�(SALARY * 1.1) 
-- ���� �ڵ尡 J6�� ����� �޿��� 15% �λ�(SALARY * 1.15) 
-- ���� �ڵ尡 J5�� ����� �޿��� 20% �λ�(SALARY * 1.2) 
-- �� ���� ������ ����� �޿��� 5%�� �λ� (SALARY * 1.05)
SELECT EMP_NAME, JOB_CODE, SALARY "���� �޿�"
        , TO_CHAR(DECODE(JOB_CODE, 'J7', SALARY*1.1
                                , 'J6', SALARY*1.15
                                , 'J5', SALARY*1.2
                                , SALARY*1.05 ),'999,999,999') "�λ�� �޿�"
FROM EMP;

/*
    2) CASE
        [ǥ����]
            CASE WHEN ���ǽ� 1 THEN ����� 1
                 WHEN ���ǽ� 2 THEN ����� 2
                 ...
                 ELSE ����� N
            END
*/
SELECT CASE WHEN SUBSTR('111111-1111111', 8, 1) = '1' THEN '����'
            WHEN SUBSTR('111111-1111111', 8, 1) = '2' THEN '����'
            ELSE '�߸��� �ֹι�ȣ!'
        END ����
FROM DUAL;
-- EMPLOYEE ���̺��� ���, �����, �ֹι�ȣ, ����(��/��) ��ȸ
SELECT  EMP_ID ���, EMP_NAME �̸�, EMP_NO �ֹι�ȣ,
        CASE WHEN SUBSTR(EMP_NO, 8, 1) = '1' THEN '����'
             WHEN SUBSTR(EMP_NO, 8, 1) = '2' THEN '����'
             ELSE '�ֹι�ȣ Ȯ�ο��'
        END AS ����
FROM    EMP;

-- ����� �޿��� 5000000 �̻��̸� �����, 3000000�̻��̸� �Ϲ�, �������� ''
SELECT  CASE WHEN SALARY > 5000000 THEN '�����'
            WHEN SALARY > 3000000 THEN '�Ϲ�'
            ELSE '' -- ��������
        END -- �ʼ�!!!!!!!
FROM    EMP;




