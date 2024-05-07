/*
    <��¥ ���� �Լ�>
    
    1) SYSDATE
        �ý����� ���� ��¥�� �ð��� ��ȯ�Ѵ�.
*/
SELECT SYSDATE FROM DUAL;

/* 
    2) MONTHS_BETWEEN
        [ǥ����]
            MONTHS_BETWEEN(DATE1, DATE2)
            
        - �Է¹��� �� ��¥ ������ ���� ���� ��ȯ�Ѵ�.
        - ������� NUMBER Ÿ���̴�.
*/
SELECT MONTHS_BETWEEN(SYSDATE, SYSDATE) FROM DUAL;
-- ���ڸ� ���� �������� ��ȯ
SELECT TO_DATE('2024/04/30') FROM DUAL;
SELECT TO_DATE('2024-04-30') FROM DUAL;
SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('2024-04-30'))) FROM DUAL;
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2024-04-01')) FROM DUAL;
-- EMP ���̺��� ������, �Ի���, �ٹ�������
SELECT  EMP_NAME, HIRE_DATE, FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) "�ٹ� ���� ��"
        , ABS(FLOOR(MONTHS_BETWEEN(HIRE_DATE, SYSDATE)))
FROM    EMP;

/*
    3) ADD_MONTHS
        [ǥ����]
            ADD_MONTHS(DATE, NUMBER)
            
        - Ư�� ��¥�� �Է¹޴� ���ڸ�ŭ�� ���� ���� ���� ��¥�� �����Ѵ�.
        - ������� DATE Ÿ���̴�.
*/
SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL;
SELECT ADD_MONTHS(SYSDATE, 8) FROM DUAL;
SELECT ADD_MONTHS('2020/12/31', 2) FROM DUAL;
/*
    4) NEXT_DAY
        [ǥ����]
            NEXT_DAY(DATE, ����(����|����))
        
        - Ư�� ��¥���� ���Ϸ��� ������ ���� ����� ��¥�� �����Ѵ�.
        - ������� DATE Ÿ���̴�.
*/

SELECT SYSDATE, NEXT_DAY(SYSDATE, '�����') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
-- 1: �Ͽ���, 2: ������, ...., 7: �����
SELECT SYSDATE, NEXT_DAY(SYSDATE, 1) FROM DUAL;
-- ������ ���� �ٸ�
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'SUNDAY') FROM DUAL;

-- �����ϴ� ���
ALTER SESSION SET NLS_LANGUAGE = AMERICAN; -- ��� ����

-- ���� ������� ��� Ȯ�� �ϴ� ���
SELECT value
FROM nls_session_parameters
WHERE parameter = 'NLS_LANGUAGE';

ALTER SESSION SET NLS_LANGUAGE = KOREAN; -- ��� ����

/*
    5) LAST_DAY
        [ǥ����]
            LAST_DAY(DATE|CHAR)
        
        - �ش� ���� ������ ��¥�� ��ȯ�Ѵ�.
        - ������� DATE Ÿ���̴�.   
*/
-- ������ ��ȯ
SELECT LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY('2024-05-01') FROM DUAL;
-- �Ի���� ������ ���� ��ȸ
SELECT  HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM    EMP;

/*
    6) EXTRACT
        [ǥ����]
            EXTRACT(YEAR|MONTH|DAY FROM DATE);
            
        - Ư�� ��¥���� ����, ��, �� ������ �����ؼ� ��ȯ�Ѵ�.
          YEAR : ������ ����
          MONTH : ���� ����
          DAY :  �ϸ� ����
        - ������� NUMBER Ÿ���̴�.
*/

SELECT EXTRACT(YEAR FROM SYSDATE) ��
        , EXTRACT(MONTH FROM SYSDATE) ��
        , EXTRACT(DAY FROM SYSDATE) ��
        -- ����|���ڸ� ���������� Ÿ�� ��ȯ
        -- YY, RR(50������ ��� �������⸦ ��Ÿ��)
        , TO_CHAR(SYSDATE, 'YYYY') ��
        , TO_CHAR(SYSDATE, 'MM') ��
        , TO_CHAR(SYSDATE, 'DD') ��
        , TO_CHAR(TO_DATE('51-01-01'), 'RRRR')
        , TO_CHAR(TO_DATE('51-01-01'), 'YYYY')
FROM DUAL;
-- �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) ��
        , EXTRACT(MONTH FROM HIRE_DATE) ��
        , EXTRACT(DAY FROM HIRE_DATE) ��
FROM EMP;

-- ��¥���亯��
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
ALTER SESSION SET NLS_DATE_FORMAT = 'RR/MM/DD';

SELECT SYSDATE FROM DUAL;

-- �Ի��Ϸκ��� ���ݱ��� ���� ����
SELECT EMP_NAME
        , TO_CHAR(FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) * SALARY, '999,999,999,999') AS �޿�
FROM EMP;



