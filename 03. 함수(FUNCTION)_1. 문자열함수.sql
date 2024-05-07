/*
    <�Լ�>
        �÷����� �о ��� ����� ��ȯ�Ѵ�.
          - ������ �Լ� : N���� ���� �о N���� ����� �����Ѵ�. (�� �� �Լ� ���� -> ��� ��ȯ)
          - �׷� �Լ�   : N���� ���� �о 1���� ����� �����Ѵ�. (�ϳ��� �׷캰�� �Լ� ���� -> ��� ��ȯ)
        SELECT ���� ������ �Լ��� �׷� �Լ��� �Բ� ������� ���Ѵ�. (��� ���� ������ �ٸ��� ������)
        �Լ��� ����� �� �ִ� ��ġ�� SELECT, WHERE, ORDER BY, GROUP BY, HAVING ���� ����� �� �ִ�.
        (FROM������ ���̺��̸��� ����ǹǷ� ��� �� �� ����)
*/

-- ������ �Լ�
/*
    <���ڰ��� �Լ�>
    1) LENGTH : ���ڼ��� ��ȯ
       LENGTHB : ������ ����Ʈ���� ��ȯ
       �ѱ��� �ѱ��ڴ� 3BYTE(������ ���ڼ¿� ���� �ٸ��� ����)
       ����, ����, Ư������ 1BYTE
       
*/
SELECT  LENGTH('����Ŭ'), LENGTHB('����Ŭ'), SYSDATE
FROM    DUAL;
/*
    DUAL ���̺�
    - SYS ����ڰ� �����ϴ� ���̺�
    - SYS ����ڰ� ���������� ��� ����ڰ� ���� �� �� �ִ�
    - �ϳ��� ��, �ϳ��� �÷��� ������ �ִ� ���� ���̺��̴�
    - ����ڰ� �Լ��� ����ϰų� ���� ���ڸ� ����Ҷ� �ӽ÷� ���Ǵ� ���̺�
*/
-- ������̺�� ���� ����� �̸�, �̸��� ����, �̸��� ����Ʈ ����, 
--                      �̸���, �̸����� ����, �̸����� ����Ʈ���� ��ȸ �Ͻÿ�
SELECT  EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
        , EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM    EMP;

/*
    2) INSTR
        - INSTR(�÷�|'���ڰ�', '����'[, POSITION[, OCCURRENCE]])
        - ������ ��ġ���� ������ ���� ��°�� ��Ÿ���� ������ ���� ��ġ�� ��ȯ�Ѵ�.
*/
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; -- 3��° �ڸ��� B�� ��ġ�� ���
SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- 3��° �ڸ��� B�� ��ġ�� ���
-- �տ������� �����ؼ� 2��° ������ B�� ��ġ�� ��ȯ
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- 9��° �ڸ��� B�� ��ġ�� ���
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- 10��° �ڸ��� B�� ��ġ�� ���
-- �ڿ������� �����ؼ� 3��° ������ B�� ��ġ�� ��ȯ
SELECT INSTR('AABAACAABBAA', 'B', -1, 3) FROM DUAL; -- 3��° �ڸ��� B�� ��ġ�� ���


-- ��� ���̺��� �̸��� �÷����� @�� ��ġ�� ã�ƺ�����!!
SELECT  EMAIL, INSTR(EMAIL, '@')
FROM    EMP;

/*
    3) SUBSTR
        - SUBSTR(�÷�|'���ڰ�', POSITION[, LENGTH])
        - ���ڵ����Ϳ��� ������ ��ġ���� ������ ������ŭ�� ���ڿ��� �����ؼ� ��ȯ�Ѵ�.
*/
-- SUBSTR(�÷���, ������ġ, ���ڼ�)
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;
SELECT SUBSTR('��� �� �� �Ӵ�', 2, 5) FROM DUAL;

-- ������̺��� �̸��� �÷����� �̸��� ���̵�� ������ ������ ���� �غ�����
-- sun_di@or.kr   ->  ���̵�@������
-- 1) INSTR�Լ��� �̿��ؼ� @�� ��ġ�� Ȯ��
-- 2) SUBSTR�Լ��� �̿��ؼ� ���ڿ��� ����(������ġ, ������ ����)
SELECT EMAIL, INSTR(EMAIL, '@') "@��ġ"
        , SUBSTR(EMAIL, 1, INSTR(EMAIL, '@')-1) ���̵�
        , SUBSTR(EMAIL, INSTR(EMAIL, '@')+1) ������
FROM EMP;

-- ��� ���̺��� �ֹε�� ��ȣ�� �޹�ȣ 1��° �ڸ����� ����
-- 621235-1985634 -> 621235-1******
-- �޹�ȣ 1�ڸ��� ���� �غ�����
SELECT EMP_NO
        , SUBSTR(EMP_NO, 1, 8) || '******' �ֹε�Ϲ�ȣ
        , SUBSTR(EMP_NO, 8, 1) �����ڵ�
FROM EMP;

-- ������̺��� ���ڻ���� ����÷��� ��ȸ �ϼ���
SELECT  *
FROM    EMP
WHERE   SUBSTR(EMP_NO,8,1) = 2;

-- �μ����̺��� �μ��ڵ尡 D1, D2, D3�� �μ��� ��ȸ �ϼ���
SELECT DEPT_ID, INSTR('D1|D2|D3', DEPT_ID)
  FROM DEPT
-- WHERE DEPT_ID = 'D1' OR DEPT_ID = 'D2' OR DEPT_ID = 'D3';
-- WHERE DEPT_ID IN ('D1', 'D2', 'D3');
 WHERE INSTR('D1|D2|D3', DEPT_ID) > 0;

/*
    4) LPAD/RPAD
    - LPAD/RPAD(��, ����[,'�����̷��� �ϴ� ����'])
    - ���õ� ���� ������ ���ڸ� ���� �Ǵ� �����ʿ� 
        �ٿ� ���� N���� ��ŭ ���ڿ��� ��ȯ �Ѵ�.
    - ���ڸ� ���ϰ��ְ� ǥ���ϰ��� �Ҷ� ���
*/
-- 20��ŭ�� ������ EMAIL�� ���������� �����ϰ� ������ �������� ä���
SELECT EMAIL, LPAD(EMAIL,20) FROM EMP;
-- ���������� ���̰� ������ ���̸� ����/���� ���ڿ��� ä���ݴϴ�
SELECT EMAIL, LPAD(EMAIL,20,'*') FROM EMP;

SELECT EMAIL, RPAD(EMAIL,20) FROM EMP;
SELECT EMAIL, RPAD(EMAIL,20,'$') FROM EMP;

-- ������̺��� �ֹε�Ϲ�ȣ�� ��1�ڸ����� �����ϰ� �����ʿ� *���ڸ� ä���� ���
SELECT RPAD(SUBSTR(EMP_NO,1,8),14,'*'), SUBSTR(EMP_NO,1,8)||'******'
FROM EMP;

/*
    5) LOWER / UPPER / INITCAP
    - LOWER|UPPER|INITCAP (�÷�|'���ڰ�')
     LOWER : ��� �ҹ��ڷ� ����
     UPPER : ��� �빮�ڷ� ����
     INITCAP : �ܾ� �� ���ڸ��� �빮�ڷ� ����
*/
-- HR�������� Ȯ��
SELECT  INITCAP(LOWER(FIRST_NAME) ||' '|| UPPER(LAST_NAME))
FROM    EMPLOYEES;
/*
    6) CONCAT
    - CONCAT(�÷�|'���ڿ�', �÷�|'���ڿ�')   ==   ||
    - ���ڵ����� �ΰ��� ���� �޾Ƽ� �ϳ��� ��ģ�� ����� ��ȯ
*/
-- �μ��� 2���� �־��� �� �ִ� ======> 3�� �̻� ������� �μ��� ������ �������մϴ� ���� �߻�
SELECT  CONCAT(CONCAT('�����ٶ�', '���ٻ�'), '��ȣ')
FROM    DUAL;

/*
    7) REPLACE : ġȯ, �ٲٱ�
    - REPLACE(�÷�|'���ڰ�', �����Ϸ��� ����, �����ϰ��� �ϴ� ����)
    - �÷�, ���ڰ����� �����ϰ��� �ϴ� ���ڸ� �����Ϸ��� ���ڷ� �����Ͽ� ��ȯ
*/
-- �����Ϸ��� ���ڸ� �����ϰ��� �ϴ� ���ڷ� ����
SELECT  REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��') FROM    DUAL;
SELECT  REPLACE('����� ������ ���ﵿ', '���ﵿ', '') FROM    DUAL;
-- OR.KR  -->> GMAIL.COM
-- �����, �̸����ּҸ� ��ȸ
-- ������ �ۼ��Ҷ��� ��ҹ��ڸ� �������� ������ �����͸� ��ȸ �Ҷ��� ��ҹ��ڸ� ���� �մϴ�!!!!
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'or.kr', 'GMAIL.COM')
FROM EMP;

/*
    8) LTRIM / RTRIM
        - LTRIM/RTRIM(�÷�|'���ڰ�'[, '�����ϰ��� �ϴ� ����'])
        - ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� ������ ����� ��ȯ�Ѵ�.
        - �����ϰ��� �ϴ� ���ڰ��� ���� �� �⺻������ ������ �����Ѵ�.
*/
-- �����ϰ��� �ϴ� ���ڰ��� ������ ��� ������ ���� �մϴ�. 
SELECT LTRIM('     HUMAN     ' ) FROM DUAL;
SELECT LTRIM('0001234560', '0') FROM DUAL;
SELECT LTRIM(' 123123HUMAN', '31 ') FROM DUAL;
SELECT LTRIM(' 123123HUMAN', '1 32') FROM DUAL;
SELECT RTRIM('HUMAN       '), LENGTH(RTRIM('HUMAN       ')) FROM DUAL;
SELECT RTRIM('0001234560', '0') FROM DUAL;

SELECT RTRIM(LTRIM('      HUMAN      ')) FROM DUAL;

/*
    9) TRIM
        - TRIM(['�����ϰ��� �ϴ� ���ڰ�' FROM] �÷�|'���ڰ�')
        - ���ڰ� ��/��/���ʿ� �ִ� ������ ���ڸ� ������ �������� ��ȯ�Ѵ�. 
        - �����ϰ��� �ϴ� ���ڰ��� ���� �� �⺻������ ���ʿ� �ִ� ������ �����Ѵ�. 
*/

SELECT TRIM('      HUMAN      ') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZHUMANZZZ') FROM DUAL;







