/*
    <���� ���� �Լ�>
    
    1) ABS
        - ABS(NUBER)
        - ���밪�� ���ϴ� �Լ�
*/
SELECT ABS(10.9), ABS(-10.9) FROM DUAL;

/*
    2) MOD
        - MOD(NUMBER, NUMBER)
        - �� ���� ���� �������� ��ȯ�� �ִ� �Լ� (�ڹ��� % ����� �����ϴ�.)
*/
-- 10�� 3���� ���� ���������� ��ȯ
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(-10, 3) FROM DUAL;
SELECT MOD(10, -3) FROM DUAL;
SELECT MOD(10.9, -3) FROM DUAL;

/*
    3) ROUND
        - ROUND(NUMBER[, ��ġ])
        - ��ġ�� �����Ͽ� �ݿø����ִ� �Լ�
        - ��ġ : �⺻�� 0(.), ���(�Ҽ��� �������� ������)�� ����(�Ҽ��� �������� ����)�� �Է°���
*/
SELECT ROUND(123.456) FROM DUAL;

SELECT ROUND(123.456,1) FROM DUAL;
-- �Ҽ��� 3��° �ڸ����� �ݿø��� ���� ������
SELECT ROUND(123.456,2) FROM DUAL;
SELECT ROUND(123.456,3) FROM DUAL;
SELECT ROUND(123.456,4) FROM DUAL;

-- �ݿø� �Ͽ� õ����������
SELECT ROUND(15523.456,-3) FROM DUAL;

/*
    4) CEIL
        - CEIL(NUMBER)
        - �Ҽ��� �������� �ø����ִ� �Լ�
*/
-- �Ű������� 2���̻� �Է½� ���� �߻�
-- SELECT CEIL(123.456,1) FROM DUAL;
SELECT CEIL(123.456) FROM DUAL;

/*
    5) FLOOR
        - FLOOR(NUMBER)
        - �Ҽ��� �������� �����ϴ� �Լ�
*/
SELECT FLOOR(123.456) FROM DUAL;

/*
    6) TRUNC
        - TRUNC(NUMBER[, ��ġ])
        - ��ġ�� �����Ͽ� ������ ������ �Լ�
        - ��ġ : �⺻�� 0(.), ���(�Ҽ��� �������� ������)�� ����(�Ҽ��� �������� ����)�� �Է°���
*/
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456, 1) FROM DUAL;
-- ����������
SELECT TRUNC(123.456, -1) FROM DUAL;






