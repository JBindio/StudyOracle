-- �Լ�
-- ���
SELECT CAST(AVG(price) AS NUMBER(38,2)) AS "å�������" FROM bookstbl;
SELECT CAST(AVG(hisal) AS NUMBER(38,2)) AS "�ְ�" FROM salgrade;


-- DUAL(���� db���̺��� ������� ������)
SELECT CAST('1000' AS NUMBER(10)) "����" FROM dual;
SELECT CAST(1000.08 AS CHAR(10)) "����" FROM dual;
SELECT CAST('2022/04/28' AS DATE) "��¥" FROM dual;

--TO CHAR
SELECT TO_CHAR(12345, '$999,999') "�޷�" FROM dual;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MM:SS') "�ǽð�" FROM dual;

--���ڿ� �Լ�
SELECT CHR(49), UNISTR('\D55F') FROM dual;
SELECT ASCII('A') FROM dual;

--��ġ�� CONCAT(���ڿ�1, ���ڿ�2) �Ǵ� || <-- ������
SELECT 'Hello, '|| 'World'||'!' FROM dual;
SELECT CONCAT('Hello,','World') FROM dual;

--���ڼ� ã��
SELECT INSTR('�̰��� Oracle�̴�, �ݰ����ϴ�.','Oracle') "���ڼ�" FROM dual;

--�빮�ں���(UPPER), �ҹ��ں���(LOWER)
SELECT UPPER('abcde'), LOWER('ABCDE') FROM dual;

--���� �ڸ��� (SUBSTR)
SELECT SUBSTR('���ѹα�����',5,2) FROM dual; --5�������� 2��������

--���� ���ֱ�(TRIM)
SELECT LTRIM('   �ȳ��ϼ���'), RTRIM('�ȳ��ϼ���  '), TRIM('   �ȳ� �ϼ���  ')
  FROM dual; -- �߰� ������ ���� �� ����

--�ǽð�(SYSDATE)
SELECT SYSDATE FROM dual;