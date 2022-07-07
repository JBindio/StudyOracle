---- ����Ŭ �н����� �нǽ�
-- 1. cmd â ����
-- 
---- �������� ���� ����
-- 2. sqlplus /nolog �Է� ����
-- 
-- SQL>conn / as sysdba
-- SQL>alter user system identified by ���ο� ��ȣ;
-- SQL>alter user sys identified by ���ο� ��ȣ;
-- SQL>conn system/���ο� ��ȣ
--
---- ����Ȯ��
-- SQL>show user
--
-- 
---- ����Ŭ 12���� �̻���ʹ� �Ʒ��� �����ؾ�
---- �Ϲ����� ���� �ۼ��� ������
--Alter session set "_ORACLE_SCRIPT"=true;
--
---- �� ������ ���� �ѹ��� ����
---- �� ������ ���ϸ� �Ʒ�ó�� ������ �ۼ��ؾ���
--Create User c##busan_06 Identified by dbdb;
--
---- 1. ����� �����ϱ�
-- 
--Create User busan_06 
--    Identified By dbdb;
-- 
---- 2. ���� �ο��ϱ�
--GRANT Connect, Resource, DBA To busan_06;
--
---- ���� ȸ���ϱ�
--Revoke DBA From busan_06
--
---- �н����� �����ϱ�
--ALTER User busan_06
--    Identified By ���ο��ȣ;
--
---- ����� �����ϱ�
--DROP User busan_06;

CREATE TABLE lprod
(
 lprod_id NUMBER(5) NOT NULL,    -- ��ǰ�з���ȣ
 lprod_gu CHAR(4) NOT NULL,      -- ��ǰ�з��ڵ�
 lprod_nm VARCHAR2(40) NOT NULL, -- ��ǰ�з��̸�
 CONSTRAINT pk_lprod PRIMARY KEY (lprod_gu)
);

SELECT * 
  FROM lprod;

INSERT INTO lprod(lprod_id, lprod_gu, lprod_nm)
     VALUES (1,'P101','��ǻ����ǰ');
     
INSERT INTO lprod(lprod_id, lprod_gu, lprod_nm)
     VALUES (1,'P102','��ǻ����ǰ');

SELECT lprod_gu, lprod_nm 
  FROM lprod;
  
COMMIT;
ROLLBACK;

-- ������ ���̺�
SELECT * 
  FROM member;
-- ��ٱ��� ���̺�  
SELECT * 
  FROM cart;
-- ��ǰ���� ���̺�  
SELECT * 
  FROM prod;
-- ��ǰ�з����� ���̺�  
SELECT * 
  FROM lprod;
-- �ŷ�ó���� ���̺�
SELECT * 
  FROM buyer;
-- �԰��ǰ����(���) ���̺�
SELECT * 
  FROM buyprod;
  
-- ȸ�����̺��� ȸ�����̵�, ȸ���̸� ��ȸ�ϱ�
SELECT mem_id,mem_name 
  FROM member;

-- ��ǰ�ڵ�� ��ǰ�� ��ȸ�ϱ�
SELECT prod_id,prod_name
  FROM prod;
  
-- ��ǰ�ڵ�, ��ǰ��, �Ǹűݾ� ��ȸ�ϱ�
-- ��, �Ǹűݾ�=�ǸŴܰ� *55 �� ����ؼ� ��ȸ
-- �Ǹűݾ��� 400���� �̻��� �����͸� ��ȸ
-- ������ �Ǹűݾ��� �������� ��������
-- SELECT > FROM ���̺� > WHERE > �÷���ȸ > ORDER BY
SELECT prod_id,prod_name,
      (prod_sale*55) as prod_sale
  FROM prod
 WHERE (prod_sale*55) >= 4000000
 ORDER BY prod_sale DESC;
 
-- ��ǰ�������� �ŷ�ó�ڵ带 ��ȸ
-- �� �ߺ��� �����ϰ� ��ȸ
SELECT DISTINCT prod_buyer 
           FROM prod;
           
-- ��ǰ�߿� �ǸŰ����� 17������ ��ǰ ��ȸ�ϱ�
SELECT prod_id,prod_name,prod_sale
  FROM prod
 WHERE prod_sale = 170000;

-- ��ǰ�߿� �ǸŰ����� 17������ �ƴ� ��ǰ ��ȸ�ϱ�
SELECT prod_id,prod_name,prod_sale
  FROM prod
 WHERE prod_sale != 170000;
 
-- ��ǰ�߿� �ǸŰ����� 17���� �̻��̰� 20���� ������ ��ǰ ��ȸ
SELECT prod_id,prod_name,prod_sale
  FROM prod
 WHERE prod_sale >= 170000 
   AND prod_sale <= 200000;

-- ��ǰ�߿� �ǸŰ����� 17���� �̻� �Ǵ� 20���� ������ ��ǰ ��ȸ
SELECT prod_id,prod_name,prod_sale
  FROM prod
 WHERE prod_sale >= 170000 
    OR prod_sale <= 200000;

-- ��ǰ �ǸŰ����� 10���� �̻��̰� 
-- ��ǰ �ŷ�ó(���޾�ü) �ڵ尡 p30203 �Ǵ� p10201
-- ��ǰ�ڵ�, �ǸŰ���, ���޾�ü �ڵ� ��ȸ
SELECT prod_id,prod_sale,prod_buyer
  FROM prod
 WHERE prod_sale >= 100000 
   AND (prod_buyer = 'P30203'
    OR prod_buyer = 'P10201');
    
SELECT prod_id,prod_sale,prod_buyer
  FROM prod
 WHERE prod_sale >= 100000 
   AND prod_buyer NOT IN ('P30203','P10201');
   
SELECT DISTINCT prod_buyer
  FROM prod
 ORDER BY prod_buyer ASC;

SELECT * 
  FROM buyer
 WHERE buyer_id NOT 
 IN (SELECT DISTINCT prod_buyer
       FROM prod);
       
-- �ѹ��� �ֹ��� ���� ���� ȸ�� ���̵�, �̸� ��ȸ
SELECT mem_id, mem_name 
  FROM member
 WHERE mem_id 
   NOT IN (SELECT DISTINCT cart_member
             FROM cart);

-- ��ǰ�з� �߿� ��ǰ������ ���� �з��ڵ常 ��ȸ
SELECT lprod_gu 
  FROM lprod
 WHERE lprod_gu 
   NOT IN (SELECT DISTINCT prod_lgu 
             FROM prod);

-- ȸ���� ���� �߿� 75����� �ƴ� ȸ�����̵�, ���� ��ȸ�ϱ�
-- ������ ���� ���� ��������
SELECT mem_id, mem_bir
  FROM member
 WHERE TO_CHAR(mem_bir, 'YY') != '75'
 ORDER BY mem_bir DESC;
 
-- ȸ�� ���̵� a001�� ȸ���� �ֹ��� ��ǰ�ڵ带 ��ȸ�ϱ�
-- ��ȸ �÷��� ȸ�����̵�, ��ǰ�ڵ�
SELECT cart_member, cart_prod 
  FROM cart
 WHERE cart_member IN (SELECT mem_id 
                         FROM member 
                        WHERE mem_id = 'a001');

    

 