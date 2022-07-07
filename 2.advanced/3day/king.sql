-- itmember ���̺� ���� �ϼ���
-- itmember�� �Ѱ��� IT �п��� �л� ����Դϴ�

-- < �÷� >
-- it_id(ID), it_name(ȸ���̸�), it_mail(�����ּ�), it_nickname(����)
-- ��� �÷��� NULL�� �����ϴ�
-- PK�� it_id �Դϴ�

-- < ������ >
-- �л����� 4���̸� �̸��� ������, ������, �̼���, ������ �Դϴ�
-- �л� ID�� ������:a001, ������:b001, �̼���:c001, ������:d001 �Դϴ�.
-- ���� �ּҴ� king@batju?.com �� 4�� �� �����մϴ�.
-- ������ ������:�߻���, ������:1, �̼���:���̺�, ������:�ɽ��������� �Դϴ�.

-- < ���� >
-- IT�л����� ȭ��ǰ�� �緯 �����ϴ�! ��ǰ�з����� ȭ��ǰ�̰���?
-- �츰 ��Ų�� ����� �� ��ǰ���� ��Ų�� ����ΰ͸� ��ȸ�ϼ���! *^^*
-- ������!, ��� NULL ���� 'ŷ����?'�� �����ϼ��� Ű�� ^_^
-- ���ĵ� �ؾ���? IT�л��� �г��� ���� ������������ ��Ź�ؿ�
-- ��ǰ��, ��ǰ�з���, IT�л��� �̸�, IT�л��� �г����� ��ȸ�ϼ���~

-- �� 28���� ���� ������ ��ȣ~! �����Դϴ� �m

-- ���̺� ����
CREATE TABLE  itmember
(  it_id VARCHAR2(15) NOT NULL,   -- ȸ��ID  
   it_name VARCHAR2(20) NOT NULL,   -- ����
   it_mail VARCHAR2(40) NOT NULL,   -- E-mail�ּ�
   it_nickname VARCHAR2(40) NOT NULL,  -- �г���              
   CONSTRAINT pk_it_id PRIMARY KEY (it_id) 
);

INSERT INTO itmember (it_id, it_name, it_mail, it_nickname)
       VALUES ('a001','������','king@batju?.com','�߻���');
INSERT INTO itmember (it_id, it_name, it_mail, it_nickname)
       VALUES ('b001','������','king@batju?.com','1');
INSERT INTO itmember (it_id, it_name, it_mail, it_nickname)
       VALUES ('c001','�̼���','king@batju?.com','BIBLE');
INSERT INTO itmember (it_id, it_name, it_mail, it_nickname)
       VALUES ('d001','������','king@batju?.com','�ɽ���������');

-- ����
SELECT prod_name,
      lprod_nm,
      NVL((SELECT it_name FROM itmember
              WHERE it_id = cart_member), 'ŷ����?'),
      NVL((SELECT it_nickname FROM itmember
              WHERE it_id = cart_member), 'ŷ����?')
  FROM prod, cart, lprod
 WHERE prod_id = cart_prod
   AND lprod_gu = prod_lgu
   AND lprod_nm = 'ȭ��ǰ'
   AND (prod_name LIKE ('%��Ų%')
    OR  prod_name LIKE ('%���%'))
 ORDER BY (SELECT it_name FROM itmember
              WHERE it_id = cart_member);
              
SELECT prod_name,
      lprod_nm,
      it_name,
      it_nickname
  FROM prod, cart, lprod, itmember
 WHERE prod_id = cart_prod
   AND it_id = cart_member
   AND lprod_gu = prod_lgu
   AND lprod_nm = 'ȭ��ǰ'
   AND (prod_name LIKE ('%��Ų%')
    OR  prod_name LIKE ('%���%'))
 ORDER BY (SELECT it_name FROM itmember
              WHERE it_id = cart_member);