-- 테이블 생성
CREATE TABLE userTBL 
(
    userID CHAR(8) NOT NULL PRIMARY KEY,
    userName NVARCHAR2(10) NOT NULL,
    addr NVARCHAR2(50)
);

CREATE TABLE buyTBL 
(
   idNum NUMBER(8) NOT NULL PRIMARY KEY, 
   userID CHAR(8) NOT NULL,
   buyDate DATE,
   
   FOREIGN KEY(userID) REFERENCES userTBL(userID)
);

-- 테이블삭제 자식테이블부터 삭제해야 함
DROP TABLE buyTBL;
DROP TABLE userTBL;




