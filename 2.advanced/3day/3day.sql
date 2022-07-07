-- day3

-- ��ȸ ����
-- 1. ���̺� ã��
-- ���õ� �÷����� �Ҽ� ã��

-- 2. ���̺� ���� ���� ã��
-- ERD���� ����� ������� PK�� FK �÷� �Ǵ�,
-- ������ ���� ������ ������ �� �ִ� �÷� ã��

-- 3. �ۼ� ���� ���ϱ�
-- ��ȸ�ϴ� �÷��� ���� ���̺��� ���� �� (1����)
-- 1���� ���̺���� ERD ������� �ۼ�
-- ���� : �ش� �÷��� ���� ���̺��� ���� ó��


-- ��ǰ�з� �߿� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸� ��ȸ�ϱ�
-- ��, ��ǰ���߿� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ��
-- �׸��� ��̰� ������ ȸ��

SELECT mem_id, mem_name
  FROM member
 WHERE mem_like = '����'
   AND mem_id IN (
          SELECT cart_member
            FROM cart
           WHERE cart_prod IN (
                       SELECT prod_id
                         FROM prod
                        WHERE prod_name LIKE '%�Ｚ����%'
                          AND prod_lgu IN (
                                   SELECT lprod_gu
                                     FROM lprod
                                    WHERE lprod_nm LIKE '%����%')));
   
   
           
SELECT
    * FROM lprod;
    
    
-- ������ ȸ���� ������ ��ǰ�� ����
-- �ŷ�ó ���� Ȯ���ϱ�
-- �ŷ�ó�ڵ�, �ŷ�ó��, ����(���� OR ��õ), �ŷ�ó ��ȭ��ȣ ��ȸ
-- ��ǰ�з��� �߿� ĳ�־� �ܾ ���Ե� ��ǰ

SELECT buyer_id, buyer_name, SUBSTR(buyer_add1,1,2) as buyer_add, buyer_comtel
  FROM buyer
 WHERE buyer_lgu IN (
             SELECT lprod_gu
               FROM lprod
              WHERE lprod_nm LIKE '%ĳ�־�%'
                AND lprod_gu IN (
                        SELECT prod_lgu
                          FROM prod
                         WHERE prod_id IN (
                                   SELECT cart_prod
                                     FROM cart
                                    WHERE cart_member IN(
                                                  SELECT mem_id
                                                    FROM member
                                                   WHERE mem_name = '������'))));
                                                   
SELECT buyer_id, buyer_name, SUBSTR(buyer_add1,1,2) as buyer_add, buyer_comtel
  FROM buyer
 WHERE buyer_id IN (
            SELECT prod_buyer
              FROM prod
             WHERE prod_lgu IN (
                        SELECT lprod_gu
                          FROM lprod
                         WHERE lprod_nm LIKE '%ĳ�־�%')
               AND prod_id IN (
                       SELECT cart_prod
                         FROM cart
                        WHERE cart_member IN(
                                      SELECT mem_id
                                        FROM member
                                       WHERE mem_name = '������')));
              
SELECT
    * FROM buyer;
    
-- ������ ȸ���� ������ ��ǰ ��
-- ��ǰ�з��� ���ڰ� ���ԵǾ��ְ�
-- �ŷ�ó�� ������ ������
-- ��ǰ �ڵ� ��ǰ�� ��ȸ�ϱ�

SELECT *
  FROM prod
 WHERE prod_id IN (
            SELECT cart_prod
              FROM cart
             WHERE cart_member IN (
                           SELECT mem_id
                             FROM member
                            WHERE MOD(SUBSTR(mem_regno2,1,1),2) = 0))
   AND prod_lgu IN (
            SELECT lprod_gu
              FROM lprod
             WHERE lprod_nm LIKE '%����%')
   AND prod_buyer IN (
              SELECT buyer_id
                FROM buyer
               WHERE SUBSTR(buyer_add1,1,2) = '����');
               
-- ��ǰ�ڵ庰 ���ż����� ���� �ִ밪, �ּҰ�, ��հ�, �հ�, ���� ��ȸ
-- ��ȸ�÷� : ��ǰ�ڵ�, �ִ밪, �ּҰ�, ��հ�, �հ�, ����

SELECT cart_prod, MAX(cart_qty), MIN(cart_qty), ROUND(AVG(cart_qty),2), 
                  SUM(cart_qty), COUNT(cart_qty)
  FROM cart
 GROUP BY cart_prod;
 
-- ������ 2005�� 7�� 11�� �̶� �����ϰ�
-- ��ٱ��� ���̺� �߻��� �߰� �ֹ���ȣ ��ȸ
-- ��ȸ�÷� : ���� ������ �ֹ���ȣ, �߰� �ֹ���ȣ
SELECT MAX(cart_no), MAX(cart_no)+1
  FROM cart
 WHERE SUBSTR(cart_no,1,8) = '20050711';

-- ȸ�� ���̺��� ȸ�� ��ü�� ���ϸ��� ���, ���ϸ��� �հ�,
-- �ְ� ���ϸ���, �ּ� ���ϸ���, �ο��� ��ȸ
-- ��ȸ�÷� : ���ϸ������, ���ϸ����հ�, �ְ��ϸ���, �ּҸ��ϸ���, �ο���
SELECT ROUND(AVG(mem_mileage),2) "M_AVG", SUM(mem_mileage) "M_SUM",
            MAX(mem_mileage) "M_MAX", MIN(mem_mileage) "M_MIN",
            COUNT(mem_mileage) "M_COUNT"
  FROM member;
  
-- ��ǰ ���̺��� �ŷ�ó�ڵ庰, ��ǰ�з��ڵ庰
-- �ǸŰ��� ���� �ְ�, �ּ� ,�ڷ��, ���, �հ� ��ȸ
-- ������ �ڷ�� ���� ��������
-- �߰��� �ŷ�ó��, ��ǰ�з��� ��ȸ
-- ��, �հ谡 100 �̻��� ��
SELECT prod_buyer, (SELECT buyer_name 
                      FROM buyer
                     WHERE prod_buyer = buyer_id) AS BUYER_NAME,
       prod_lgu, (SELECT lprod_nm 
                    FROM lprod
                   WHERE prod_lgu = lprod_gu) AS LPLOD_NAME, 
       MAX(prod_sale) AS MAX_SALE, MIN(prod_sale) AS MIN_SALE, 
       COUNT(prod_sale) AS COUNT_SALE, ROUND(AVG(prod_sale),2) AS AVG_SALE, 
       SUM(prod_sale) AS SUM_SALE
  FROM prod
 GROUP BY prod_buyer, prod_lgu
   HAVING SUM(prod_sale) >= 100 
 ORDER BY COUNT_SALE DESC;

-- IS NULL, IS NOTNILL ����ġ Ȯ�� 
UPDATE buyer SET buyer_charger = NULL
 WHERE buyer_charger LIKE '��%';
  
UPDATE buyer SET buyer_charger = ''
 WHERE buyer_charger LIKE '��%';
 
SELECT buyer_name,
       NVL(buyer_charger,'����')
  FROM buyer;

-- DECODE ���̽��� if��   
SELECT prod_lgu,
       DECODE(SUBSTR(prod_lgu, 1,2), -- if
             'P1', '��ǻ��/���� ��ǰ', 
             'P2', '�Ƿ�',           
             'P3', '��ȭ', 
                   '��Ÿ') as lgu_nm --else
  FROM prod;

-- EXISTS ��ȸ�� ��� TRUE, FALSE  
SELECT prod_id, prod_name, prod_lgu
  FROM prod
 WHERE EXISTS (SELECT lprod_gu
                 FROM lprod
                WHERE lprod_gu = prod_lgu);
                
-- JOIN : CROSS JOIN, NATURAL JOIN, INNER JOIN, OUTER JOIN
-- CROSS JOIN : FROM ���� ������ ���̺�
SELECT * 
  FROM lprod, prod;
  
SELECT * 
  FROM lprod CROSS JOIN prod;
  
-- EQUI JOIN = INNER JOIN
-- PK�� FK�� �����ؾ� �Ѵ�
-- �������� : PK = FK
-- �������� ���� : FROM ���� ���õ� (���̺� ���� - 1��)
-- �Ϲ� ���
SELECT prod_id,
       buyer_name,  
       prod.prod_name,
       lprod_nm,
       cart_qty,
       mem_name
  FROM lprod,prod,buyer,cart,member
-- ���� ���ǽ�
 WHERE lprod_gu = prod_lgu
   AND buyer_id = prod_buyer
   AND prod_id = cart_prod
   AND mem_id = cart_member
   AND mem_id = 'a001';
   
-- ǥ�� ���
SELECT prod_id,
       buyer_name,  
       prod.prod_name,
       lprod_nm,
       cart_qty,
       mem_name
  FROM lprod INNER JOIN prod
                ON (lprod_gu = prod_lgu)
             INNER JOIN buyer
                ON (buyer_id = prod_buyer)
             INNER JOIN cart
                ON (prod_id = cart_prod)
             INNER JOIN member
                ON (mem_id = cart_member
                    AND mem_id = 'a001');

-- ��ǰ ���̺��� ��ǰ�ڵ�, ��ǰ��, �з���, �ŷ�ó��, �ŷ�ó �ּ� ��ȸ
-- �ǸŰ����� 10���� ����
-- �ŷ�ó �ּҴ� �λ�
-- �Ϲ� ǥ��, �Ѵ� ����ϱ�
SELECT prod_id, prod_name, lprod_nm, buyer_name, buyer_add1
  FROM prod, lprod, buyer
 WHERE lprod_gu = prod_lgu
   AND buyer_id = prod_buyer
   AND prod_sale <= 100000
   AND SUBSTR(buyer_add1,1,2) = '�λ�';
   
SELECT prod_id, prod_name, lprod_nm, buyer_name, buyer_add1
  FROM prod INNER JOIN lprod
               ON (lprod_gu = prod_lgu
                   AND prod_sale <= 100000)
            INNER JOIN buyer
               ON (buyer_id = prod_buyer
                   AND SUBSTR(buyer_add1,1,2) = '�λ�');
                   

-- ��ǰ�з���, ��ǰ��, ��ǰ����, ���Լ���, �ֹ�����, �ŷ�ó�� ��ȸ
-- ��ǰ�з� �ڵ尡 'P101', 'P201', 'P301' �ΰ�
-- ���Լ����� 15�� �̻��� ��
-- ���￡ ��� �ִ� ȸ���߿� ������ 1974�� ���� ȸ��
-- ������ ȸ�� ���̵� ���� ��������, ���Լ��� ���� ��������
-- �Ϲݹ��, ǥ�ع��

-- �Ϲݹ��
SELECT lprod_nm, prod_name, prod_color, buy_qty, cart_qty ,buyer_name
  FROM lprod, prod, buyer, buyprod, cart, member
 WHERE lprod_gu = prod_lgu
   AND buyer_id = prod_buyer
   AND prod_id = buy_prod
   AND prod_id = cart_prod
   AND cart_member = mem_id
   AND (lprod_gu = 'P101' OR lprod_gu = 'P201' OR lprod_gu = 'P301')
   AND buy_qty >= 15
   AND mem_add1 LIKE '����%'
   AND EXTRACT(YEAR FROM mem_bir) = 1974
 ORDER BY mem_id DESC, buy_qty ASC;

-- ǥ�ع�� 
SELECT lprod_nm, prod_name, prod_color, buy_qty, cart_qty ,buyer_name
  FROM lprod INNER JOIN prod
                ON (lprod_gu = prod_lgu
                   AND lprod_gu IN ('P101','P201','P301'))
             INNER JOIN buyer
                ON (buyer_id = prod_buyer)
             INNER JOIN buyprod
                ON (prod_id = buy_prod
                   AND buy_qty >= 15)
             INNER JOIN cart
                ON (prod_id = cart_prod)
             INNER JOIN member
                ON (cart_member = mem_id)
                   AND mem_add1 LIKE '����%'
                   AND EXTRACT(YEAR FROM mem_bir) = 1974
 ORDER BY mem_id DESC, buy_qty ASC;
 
 SELECT
     * FROM member;
     
--