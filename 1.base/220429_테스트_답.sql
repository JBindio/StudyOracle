-- 220429(��) SQL�׽�Ʈ

-- 1. ȸ�� ���̺��� �̸���, �����, �̸�, �ּ�, ���� ���� ������ ����ϰ�, 
-- �̸��� ������������, �̸����� �ҹ��ڷ� ����ϼ���.
SELECT LOWER(email) AS "EMAIL", mobile, names, addr, levels
   FROM membertbl
  ORDER BY names DESC;
  
-- 2.å ���̺��� å����, ����, ������, �ݾ� ������ ����ϰ� 
-- ������ ��� ������ ������ �Ͻʽÿ�. �÷��̸��� Ȯ���ϼ���!!
SELECT names AS "å����", author AS "���ڸ�",
       TO_CHAR(releasedate, 'YYYY-MM-DD') AS "������", price AS "����"
  FROM bookstbl
 ORDER BY price DESC;
 
-- 3.å ���̺�� ���� ���̺��� �����Ͽ� �Ʒ��� ���� ������ �������� �����ϼ���. 
-- �Ȱ��� ���;� �մϴ�!! �帣 å���� ���� ������ å�ڵ��ȣ ����
SELECT d.names AS "�帣", b.names AS "å����", b.author AS "����",
       TO_CHAR(b.releasedate, 'YYYY-MM-DD') AS "������", 
       b.isbn AS "å�ڵ��ȣ", b.price||'��' AS "����"
  FROM bookstbl b
  JOIN divtbl d
    ON b.division = d.division
 ORDER BY b.idx DESC;
 
-- 4.ȸ�� ���̺� ������ ȫ�浿 ȸ���� �Է��ϴ� ������ �ۼ��ϼ���. 
-- �������� ���� ����ؾ� �մϴ�.

-- ������ ����
CREATE SEQUENCE Seq_member
 START WITH 27
INCREMENT BY 1;

-- ������ ���
INSERT INTO membertbl
VALUES 
(
Seq_member.nextval, 'ȫ�浿', 'A', '�λ�� ���� �ʷ���', '010-7989-0909',
                    'HGD09@NAVER.COM', 'HGD7989', '12345', '', ''
);
COMMIT;

-- 5.�Ʒ��� ���� å�� ���к��� �հ�� ��� å�� �հ谡 ���� �������� �����ϼ���. 
-- ��...��...
SELECT NVL(d.names,'--�հ�--') AS "�帣", SUM(b.price) AS "����"
  FROM bookstbl b
  JOIN divtbl d
    ON b.division = d.division
 GROUP BY ROLLUP(d.names)
 ORDER BY d.names;