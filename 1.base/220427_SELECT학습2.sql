--ROWNUM �������� ���� 3�Ǹ� ��ȸ ���������θ� ��밡��
SELECT * FROM
(
     SELECT names, TO_CHAR(releasedate, 'YYYY-MM-DD') "������"
       FROM bookstbl
      ORDER BY releasedate
)
 WHERE ROWNUM <= 3;

--�ѱ��� ��¥ǥ��� ����
SELECT names, TO_CHAR(releasedate, 'YYYY-MM-DD') "������"
  FROM bookstbl
 ORDER BY releasedate;

--�̱��� ��¥ ǥ��� ����
SELECT names, TO_CHAR(releasedate, 'MM/DD/YYYY') "������"
  FROM bookstbl;


--�׷�ȭ (GROUP BY) + HAVING
SELECT author, division, SUM(price) "�հ�", SUM(1) "å ��"
  FROM bookstbl
 GROUP BY author, division
--HAVING SUM(price) >= 200000
 ORDER BY division;
 
--���ġ ���ϱ� (AVG)
--�Ҽ��� ��ȯ (CAST AS NUMBER)
 
SELECT CAST (AVG(price) AS NUMBER(8,2)) "���" FROM bookstbl;
 
--å ���� �ְ�, ������ �� (MAX, MIN)
SELECT MAX(price), MIN(price) FROM bookstbl;

-- ��ü ���� (COUNT)
SELECT COUNT(*) FROM bookstbl
 WHERE division = 'B003';
 
-- ROLLUP, CUBE
SELECT division, SUM(price) "�հ�", SUM(1) "å ��"
      ,GROUPING_ID(division) "�߰� ��"
  FROM bookstbl
 GROUP BY ROLLUP(division);
 
 