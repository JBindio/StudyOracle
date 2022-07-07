--수정 (INSERT)

--CREATE TABLE
CREATE TABLE testTBL
(
     id NUMBER(4) NOT NULL PRIMARY KEY
    ,userName NVARCHAR2(10)
    ,age NUMBER(3)
);

--INSERT INTO 테이블 (컬럼명,컬럼명,컬럼명) VALUES (데이터,데이터,데이터)
INSERT INTO testtbl(id, username, age) VALUES (1, '홍길동', 99);

--되돌리기(ROLLBACK)
ROLLBACK;

--완전저장(COMMIT)
COMMIT;

--컬럼생략 가능
INSERT INTO testtbl VALUES (2, '홍길순', 97);
--컬럼 개수가 같아야함
INSERT INTO testtbl VALUES (3, '홍길자'); -- 오류 (값의 수가 같지않음)
INSERT INTO testtbl VALUES (3, '홍길자', NULL); -- 작동
INSERT INTO testtbl(id, username) VALUES (4, '성명건'); --작동


-- testTBL2
--CREATE TABLE
CREATE TABLE testTBL2
(
     id NUMBER(4) NOT NULL PRIMARY KEY
    ,userName NVARCHAR2(10)
    ,age NUMBER(3)
);

-- 시퀀스 생성

CREATE SEQUENCE test2Seq
 START WITH 1 -- 시작 값
INCREMENT BY 1; -- 증가 값
    
-- 시퀀스 사용 입력
INSERT INTO testtbl2 (id, userName, age)
VALUES (TEST2SEQ.nextval, '홍길동', 99);
  
-- 변경 UPDATE WHERE절은 무조건!!
UPDATE testtbl2
   SET username = '이정빈'
      ,age = 31
 WHERE id = 4;

-- 삭제 DELETE WHERE절은 무조건!!

DELETE FROM testtbl2
 WHERE id = 3;

