-- 4�� - �輺��, ������, ����ȯ, �����

-- 1��
-- �ǸŰ��� ���� ���� ��ǰ�� ��ǰ �з����� �ֹ��� 
-- ȸ����, ȸ�� �ֹε�Ϲ�ȣ, ����, ��� ��ȸ
-- ��, �ֹε�Ϲ�ȣ ��ü�� ���� (���� ù��° �ڸ��� �����ϰ� �������� * �� ǥ��)
-- ������ �ֹε�Ϲ�ȣ �������� ��������
   
-- ���� ��� ��ǰ�� ��ǰ �з���
SELECT mem_name,
       mem_regno1 || '-' || SUBSTR(mem_regno2, 1,1)||'******' mem_regno,
       mem_job, mem_like
  FROM member, cart, prod, lprod,
       (SELECT lprod_gu, lprod_nm
          FROM(SELECT lprod_gu, lprod_nm, MAX(prod_sale) "MAX_SALE"
                 FROM lprod, prod
                WHERE lprod_gu = prod_lgu
                GROUP BY lprod_gu, lprod_nm
                ORDER BY MAX_SALE DESC)     
         WHERE ROWNUM = 1) "MAX_LPROD"
 WHERE prod_lgu = MAX_LPROD.lprod_gu      
   AND mem_id = cart_member
   AND prod_id = cart_prod
 GROUP BY mem_name, 
          mem_regno1 || '-' || SUBSTR(mem_regno2, 1,1)||'******',
          mem_job, mem_like          
 ORDER BY mem_regno;

-- ���� 
SELECT mem_name,
       mem_regno1 || '-' || SUBSTR(mem_regno2, 1,1)||'******' mem_regno,
       mem_job, mem_like
  FROM member, cart, prod, lprod,
      (SELECT lprod_gu, lprod_nm, MAX(prod_sale) "MAX_SALE"
         FROM lprod, prod
        WHERE lprod_gu = prod_lgu
        GROUP BY lprod_gu, lprod_nm
        ORDER BY MAX_SALE DESC) "MAX_LPROD"     
 WHERE prod_lgu = MAX_LPROD.lprod_gu      
   AND mem_id = cart_member
   AND prod_id = cart_prod
 GROUP BY mem_name, 
          mem_regno1 || '-' || SUBSTR(mem_regno2, 1,1)||'******',
          mem_job, mem_like          
 ORDER BY mem_regno; 
 
-- 2��
-- �ŷ�ó �ּҰ� ������ �����̰� 5���̻��̰�
-- ����Ʈ�� ���, ��̰� ������ ���
-- ȸ���̸�,�ŷ�ó��,�ŷ�ó�ּ�,���,ȸ���ּ�
-- LPAD("��", "�� ���ڱ���", "ä����") ���
-- �Ϲݹ�Ļ��

SELECT mem_name, buyer_name, buyer_add1, 
       LPAD(buyer_add2, 6, 0), mem_like, mem_add1
  FROM buyer, prod, cart, member
 WHERE buyer_id = prod_buyer
   AND prod_id = cart_prod
   AND mem_id = cart_member
   AND SUBSTR(buyer_add1, 1, 2) = '����'
   AND SUBSTR(LPAD(buyer_add2, 6, 0),1,2) >= 5
   AND mem_like = '����'
   AND mem_add2 LIKE '%����Ʈ%';
   
 508
1008
SELECT *
FROM MEMBER;

-- 3��
-- �������� �̸����� �ҿ����� ������ �����Ͽ� 
-- ������ ���� �������� �����ֽÿ�
-- instr�� ����Ͽ� �ؾ��� (ex (instr(�ٲܰ�,��ġ),1(�ٲܰ��� ��ġ),2(��°))


-- 1974�� 7�� ���� 1980�� 12�� ���� �¾ ������ �����Ͽ���,
-- �ŷ�ó ����ڰ� �����ϰų� �ּҰ� �λ��� �ƴϸ�, 
-- �԰����ڰ� 4�� �̻��̰� 
-- ���Լ����� 10 �̻��̰ų� ���Դܰ��� 200000�� ������ ��ǰ �߿���
-- ũ�Ⱑ L�� ��ǰ�� 2�� ���Ե� ��ǰ�� ��ȸ�ϰ� ���ڿ� ������ 77 ���ڿ��� 32
-- ������ ���� ���� �� ��ǰ�� ��ǰ��, �ǸŰ�, ������(2��°�ڸ�����),����� 
-- 1~5� ��Ÿ���ÿ�!
-- ��, ������������ �̿��ؼ�!
SELECT prod_id,prod_name
  FROM prod,
       (SELECT prod_id, prod_name,
           MAX(ROUND((prod_price - prod_sale) / prod_price * 100,2)) "SALE"
          FROM prod
         GROUP BY prod_id, prod_name
         ORDER BY SALE DESC)
 WHERE ROWNUM = 5;