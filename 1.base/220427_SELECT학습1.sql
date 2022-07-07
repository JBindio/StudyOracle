-- idx 5���� 10���� levels A�� �� ��ȸ
SELECT * FROM membertbl
 WHERE (idx >= 5 AND idx <= 10)
   AND levels = 'A';

-- BETWEEN A and B
-- idx 5���� 10���� ��ȸ
SELECT * FROM membertbl
 WHERE idx BETWEEN 5 AND 10;

-- OR = A OR B A �ƴϸ� B
SELECT * FROM membertbl
 WHERE levels = 'B' OR levels = 'D' OR levels = 'S';

-- IN = �ѹ��� ���� �� ��Ƽ� ��ȸ
SELECT * FROM membertbl
 WHERE levels NOT IN ('B','D','S');

-- LIKE = ����� ���� �˻�(���� �˻���)
SELECT * FROM bookstbl
 WHERE names LIKE '������__'; --'������%', '������__','_����%'


SELECT * FROM bookstbl
 WHERE (description LIKE '%��ǰ%')
   AND division = 'B005';

--�������� (ANY, ALL, SOME) WHERE�� ��������
SELECT * FROM bookstbl
 WHERE division IN (SELECT division FROM divtbl
 WHERE names = 'SF/��Ÿ��');

--��������2 �÷���� ��������
SELECT b.idx "��ȣ"
      ,b.author "����"
      ,b.division "�帣�ڵ�"
      ,(SELECT d.names FROM divtbl d WHERE d.division = b.division) �帣
      ,b.names "å����"
      ,b.price "����"
    
  FROM bookstbl b
 WHERE division ='B005';
 
--��������3 FROM�� ��������
SELECT *
  FROM (SELECT b.author, b.division, b.names FROM bookstbl b) bb;
  
--�������� ANY
SELECT * FROM bookstbl
 WHERE division IN (SELECT division FROM divtbl
 WHERE division LIKE 'B%');

--����(ORDER BY) ASC(��������) DESC(��������)
SELECT idx, author, names, releasedate, price 
  FROM bookstbl
 ORDER BY price ASC;

--�ߺ����� (DISTINCT)
SELECT DISTINCT price
  FROM bookstbl;

SELECT * FROM divtbl
 WHERE division NOT IN (
SELECT DISTINCT division
  FROM bookstbl);

