DROP TABLE itmember;

CREATE TABLE  itmember
(  it_id VARCHAR2(15) NOT NULL,   -- 회원ID  
   it_name VARCHAR2(20) NOT NULL,   -- 성명
   it_mail VARCHAR2(40) NOT NULL,   -- E-mail주소
   it_nickname VARCHAR2(40) NOT NULL,  -- 닉네임              
   CONSTRAINT pk_it_id PRIMARY KEY (it_id) 
);

INSERT INTO itmember (it_id, it_name, it_mail, it_nickname)
       VALUES ('a001','이정빈','king@batju?.com','잘생김');
INSERT INTO itmember (it_id, it_name, it_mail, it_nickname)
       VALUES ('b001','권지은','king@batju?.com','1');
INSERT INTO itmember (it_id, it_name, it_mail, it_nickname)
       VALUES ('c001','이성경','king@batju?.com','BIBLE');
INSERT INTO itmember (it_id, it_name, it_mail, it_nickname)
       VALUES ('d001','조혜리','king@batju?.com','걸스데이혜리');
