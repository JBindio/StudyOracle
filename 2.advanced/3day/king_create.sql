DROP TABLE itmember;

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
