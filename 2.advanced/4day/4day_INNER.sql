-- 4day

-- ��ǰ���̺�� ��ǰ�з����̺��� ��ǰ�з��ڵ尡 'P101'�� �Ϳ� ����
-- ��ǰ�з��ڵ�(��ǰ���̺� �ִ� �÷�), ��ǰ��, ��ǰ�з��� ��ȸ
-- ������ ��ǰ���̵� ��������
-- �Ϲݹ��
SELECT prod_lgu, prod_name, lprod_nm
  FROM lprod, prod
 WHERE lprod_gu = prod_lgu
   AND lprod_gu = 'P101'
 ORDER BY prod_id DESC;

-- ǥ�ع�� 
SELECT prod_lgu, prod_name, lprod_nm
  FROM lprod INNER JOIN prod
                ON (lprod_gu = prod_lgu
                    AND lprod_gu = 'P101')
 ORDER BY prod_id DESC;
 
 -- ������ ȸ���� ������ ��ǰ�� ����
 -- �ŷ�ó ���� Ȯ���ϱ�
 -- �ŷ�ó�ڵ�, �ŷ�ó��, ȸ����������(���� or ��õ ��) ��ȸ
 -- ��, ��ǰ�з��� ĳ�־� �ܾ ���Ե� ��ǰ�� ��ȸ
 -- �Ϲݹ��
 SELECT buyer_id, buyer_name, SUBSTR(mem_add1,1,2)
   FROM buyer, lprod, prod, member, cart
  WHERE buyer_id = prod_buyer
    AND lprod_gu = prod_lgu
    AND prod_id = cart_prod
    AND lprod_nm LIKE '%ĳ�־�%'
    AND mem_id = cart_member
    AND mem_name = '������';
  
 -- ǥ�ع��   
 SELECT buyer_id, buyer_name, SUBSTR(mem_add1,1,2)
   FROM buyer INNER JOIN prod
                 ON (buyer_id = prod_buyer)
              INNER JOIN lprod
                 ON (lprod_gu = prod_lgu
                     AND lprod_nm LIKE '%ĳ�־�%')
              INNER JOIN cart
                 ON (prod_id = cart_prod)
              INNER JOIN member
                 ON (mem_id = cart_member
                     AND mem_name = '������');
                                      
-- ��ǰ�з��� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸�, ��ǰ�з��� ��ȸ�ϱ�
-- ��, ��ǰ�� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ����
--     ȸ���� ��̰� ������ ȸ��
-- �Ϲݹ��
SELECT mem_id, mem_name, lprod_nm
  FROM lprod, prod, cart, member
 WHERE lprod_gu = prod_lgu
   AND cart_prod = prod_id
   AND cart_member = mem_id
   AND lprod_nm LIKE '%����%'
   AND prod_name LIKE '%�Ｚ����%'
   AND mem_like = '����';

-- ǥ�ع��   
SELECT mem_id, mem_name, lprod_nm
  FROM lprod INNER JOIN prod
                ON (lprod_gu = prod_lgu
                    AND lprod_nm LIKE '%����%')
             INNER JOIN cart
                ON (cart_prod = prod_id
                    AND prod_name LIKE '%�Ｚ����%')
             INNER JOIN member
                ON (cart_member = mem_id
                    AND mem_like = '����');
           
-- ��ǰ�з����̺�� ��ǰ���̺�� �ŷ�ó���̺�� ��ٱ��� ���̺� ���
-- ��ǰ�з��ڵ尡 'P101' �ΰ��� ��ȸ
-- �׸���, ������ ��ǰ�з����� �������� ��������
--                ��ǰ���̵� �������� �������� �ϼ���
-- ��ǰ�з���, ��ǰ���̵�, ��ǰ�ǸŰ�, �ŷ�ó�����, ȸ�����̵�, �ֹ�����
-- �Ϲݹ��
SELECT lprod_nm, prod_id, prod_sale, buyer_charger, cart_member, cart_qty
  FROM lprod, prod, buyer, cart
 WHERE lprod_gu = 'P101'
   AND lprod_gu = prod_lgu
   AND buyer_id = prod_buyer
   AND prod_id = cart_prod
 ORDER BY lprod_nm DESC, prod_id ASC;

-- ǥ�ع��
SELECT lprod_nm, prod_id, prod_sale, buyer_charger, cart_member, cart_qty
  FROM lprod INNER JOIN prod
                ON (lprod_gu = prod_lgu
                    AND lprod_gu = 'P101')
             INNER JOIN buyer
                ON (buyer_id = prod_buyer)
             INNER JOIN cart
                ON (prod_id = cart_prod)
 ORDER BY lprod_nm DESC, prod_id ASC;
 
-- ��ǰ�ڵ庰 ���ż����� ���� �ִ밪, �ּҰ�, ��հ�, �հ�, ���� ��ȸ
-- ��, ��ǰ�� �Ｚ�� ���Ե� ��ǰ�� ������ ȸ��
-- ��ȸ�÷� : ��ǰ�ڵ�, �ִ밪, �ּҰ�, ��հ�, �հ�, ����
-- �Ϲݹ��
SELECT cart_prod, MAX(cart_qty) "q_max", MIN(cart_qty)"q_min", 
                  ROUND(AVG(cart_qty),2) "q_avg", 
                  SUM(cart_qty) "q_sum", COUNT(cart_qty) "q_count"
  FROM cart, prod
 WHERE prod_id = cart_prod
   AND prod_name LIKE '%�Ｚ%'
 GROUP BY cart_prod;

-- ǥ�ع�� 
SELECT cart_prod, MAX(cart_qty) "q_max", MIN(cart_qty)"q_min", 
                  ROUND(AVG(cart_qty),2) "q_avg", 
                  SUM(cart_qty) "q_sum", COUNT(cart_qty) "q_count"
  FROM prod INNER JOIN cart
               ON (prod_id = cart_prod
                   AND prod_name LIKE '%�Ｚ%')
 GROUP BY cart_prod; 
 
 
-- �ŷ�ó�ڵ� �� ��ǰ�з��ڵ庰��
-- �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ� ��ȸ
-- ��ȸ�÷� : �ŷ�ó�ڵ�, �ŷ�ó��, ��ǰ�з��ڵ�, ��ǰ�з���
--            �ǸŰ��� ���� �ְ�, �ּ�, �ڷ��, ���, �հ�
-- ������ ����� �������� ��������
-- �� �ǸŰ��� ����� 100 �̻��ΰ�

SELECT buyer_id, buyer_name, lprod_gu, lprod_nm,
       MAX(prod_sale) AS sale_max, MIN(prod_sale) AS sale_min,  
       COUNT(prod_sale) AS sale_count,
       ROUND(AVG(prod_sale),2) AS sale_avg, SUM(prod_sale) AS sale_sum
  FROM buyer, lprod, prod
 WHERE buyer_id = prod_buyer
   AND lprod_gu = prod_lgu
 GROUP BY buyer_id, buyer_name, lprod_gu, lprod_nm
HAVING ROUND(AVG(prod_sale),2) >= 100
 ORDER BY sale_avg DESC;
 
-- �ŷ�ó���� GROUP ���� ���Աݾ��� �� ��ȸ�ϱ�
-- ��ǰ�԰����̺��� 2005�⵵ 1���� ��������(�԰�����) �ΰ͵�
-- ���Աݾ� = ���Լ��� * ���Աݾ�
-- ��ȸ�÷� : �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��� ��
-- ���Աݾ��� ���� NULL�� ��� 0���� ��ȸ
-- ������ �ŷ�ó �ڵ� �� �ŷ�ó ���� �������� ��������
-- �Ϲݹ��
SELECT buyer_id, buyer_name, 
       NVL(SUM(buy_qty * buy_cost),0) AS cost_sum
  FROM buyer, prod, buyprod
 WHERE buyer_id = prod_buyer
   AND prod_id = buy_prod
   AND buy_date BETWEEN '2005/01/01' AND '2005/01/31'
 GROUP BY buyer_id, buyer_name
 ORDER BY buyer_id, buyer_name DESC;
 
-- ǥ�ع��
SELECT buyer_id, buyer_name, 
        -- NVL�� �����Լ� �ȿ� ���
       SUM(NVL(buy_qty * buy_cost,0)) AS "qty*cost_sum"
       FROM buyer INNER JOIN prod
                ON (buyer_id = prod_buyer)
             INNER JOIN buyprod
                ON (prod_id = buy_prod
                    AND buy_date BETWEEN '2005/01/01' AND '2005/01/31')  
 GROUP BY buyer_id, buyer_name
 ORDER BY buyer_id DESC, buyer_name DESC;
 
-- �ŷ�ó���� GROUP ��� ���Աݾ��� �� ���
-- ���Աݾ��� ���� 1õ���� �̻��� ��ǰ�ڵ�, ��ǰ�� ��ȸ
-- ��ǰ�԰����̺��� 2005�⵵ 1���� ��������(�԰�����) �ΰ͵�
-- ���Աݾ� = ���Լ��� * ���Աݾ�
-- ��ȸ�÷� : ��ǰ�ڵ�, ��ǰ��
-- ���Աݾ��� ���� NULL�� ��� 0���� ��ȸ
-- ������ ��ǰ�� ���� ��������
-- �Ϲݹ��
SELECT prod_id, prod_name
  FROM prod, buyprod
 WHERE prod_id = buy_prod
   AND buy_date BETWEEN '2005/01/01' AND '2005/01/31'
 GROUP BY prod_id, prod_name 
HAVING SUM(NVL(buy_qty * buy_cost,0)) >= 10000000
 ORDER BY prod_name;
 
-- ǥ�ع��
SELECT prod_id, prod_name
  FROM prod INNER JOIN buyprod
               ON (prod_id = buy_prod
                   AND buy_date BETWEEN '2005/01/01' AND '2005/01/31')
 GROUP BY prod_id, prod_name 
HAVING SUM(NVL(buy_qty * buy_cost,0)) >= 10000000
 ORDER BY prod_name;

-- �ŷ�ó���� GROUP ���� ���Աݾ��� �� ��ȸ�ϱ�
-- ��ǰ�԰����̺��� 2005�⵵ 1���� ��������(�԰�����) �ΰ͵�
-- ���Աݾ� = ���Լ��� * ���Աݾ�
-- ��ȸ�÷� : �ŷ�ó�ڵ�, �ŷ�ó��, ���Աݾ��� ��
-- ���Աݾ��� ���� NULL�� ��� 0���� ��ȸ
-- ������ �ŷ�ó �ڵ� �� �ŷ�ó ���� �������� ��������
-- �Ϲݹ��

-- ���� ����� ����
-- ���Աݾ��� ���� 1õ���� �̻��� ��ǰ�ڵ�, ��ǰ�� �˻�
SELECT prod_id, prod_name
  FROM prod
 WHERE prod_buyer IN (SELECT buyer_id    
                        FROM buyer, prod, buyprod
                       WHERE buyer_id = prod_buyer
                         AND prod_id = buy_prod
                         AND buy_date BETWEEN '2005/01/01' AND '2005/01/31'
                       GROUP BY buyer_id
                       HAVING NVL(SUM(buy_qty * buy_cost),0) >= 10000000);

SELECT prod_id, prod_name
  FROM (SELECT buyer_id, buyer_name, 
               NVL(SUM(buy_qty * buy_cost),0) AS cost_sum
          FROM buyer, prod, buyprod
         WHERE buyer_id = prod_buyer
           AND prod_id = buy_prod
           AND buy_date BETWEEN '2005/01/01' AND '2005/01/31'
         GROUP BY buyer_id, buyer_name
         ORDER BY buyer_id, buyer_name DESC) "COST", prod