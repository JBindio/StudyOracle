--���� (INSERT)

--CREATE TABLE
CREATE TABLE testTBL
(
     id NUMBER(4) NOT NULL PRIMARY KEY
    ,userName NVARCHAR2(10)
    ,age NUMBER(3)
);

--INSERT INTO ���̺� (�÷���,�÷���,�÷���) VALUES (������,������,������)
INSERT INTO testtbl(id, username, age) VALUES (1, 'ȫ�浿', 99);

--�ǵ�����(ROLLBACK)
ROLLBACK;

--��������(COMMIT)
COMMIT;

--�÷����� ����
INSERT INTO testtbl VALUES (2, 'ȫ���', 97);
--�÷� ������ ���ƾ���
INSERT INTO testtbl VALUES (3, 'ȫ����'); -- ���� (���� ���� ��������)
INSERT INTO testtbl VALUES (3, 'ȫ����', NULL); -- �۵�
INSERT INTO testtbl(id, username) VALUES (4, '�����'); --�۵�


-- testTBL2
--CREATE TABLE
CREATE TABLE testTBL2
(
     id NUMBER(4) NOT NULL PRIMARY KEY
    ,userName NVARCHAR2(10)
    ,age NUMBER(3)
);

-- ������ ����

CREATE SEQUENCE test2Seq
 START WITH 1 -- ���� ��
INCREMENT BY 1; -- ���� ��
    
-- ������ ��� �Է�
INSERT INTO testtbl2 (id, userName, age)
VALUES (TEST2SEQ.nextval, 'ȫ�浿', 99);
  
-- ���� UPDATE WHERE���� ������!!
UPDATE testtbl2
   SET username = '������'
      ,age = 31
 WHERE id = 4;

-- ���� DELETE WHERE���� ������!!

DELETE FROM testtbl2
 WHERE id = 3;

