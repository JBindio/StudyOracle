---- 오라클 패스워드 분실시
-- 1. cmd 창 열기
-- 
---- 계정없이 서버 접속
-- 2. sqlplus /nolog 입력 엔터
-- 
-- SQL>conn / as sysdba
-- SQL>alter user system identified by 새로운 암호;
-- SQL>alter user sys identified by 새로운 암호;
-- SQL>conn system/새로운 암호
--
---- 접속확인
-- SQL>show user
--
-- 
---- 오라클 12버전 이상부터는 아래를 실행해야
---- 일반적인 구분 작성이 가능함
--Alter session set "_ORACLE_SCRIPT"=true;
--
---- 위 실행은 최초 한번만 실행
---- 위 실행을 안하면 아래처럼 구문을 작성해야함
--Create User c##busan_06 Identified by dbdb;
--
---- 1. 사용자 생성하기
-- 
--Create User busan_06 
--    Identified By dbdb;
-- 
---- 2. 권한 부여하기
--GRANT Connect, Resource, DBA To busan_06;
--
---- 권한 회수하기
--Revoke DBA From busan_06
--
---- 패스워드 수정하기
--ALTER User busan_06
--    Identified By 새로운암호;
--
---- 사용자 삭제하기
--DROP User busan_06;

CREATE TABLE lprod
(
 lprod_id NUMBER(5) NOT NULL,    -- 상품분류번호
 lprod_gu CHAR(4) NOT NULL,      -- 상품분류코드
 lprod_nm VARCHAR2(40) NOT NULL, -- 상품분류이름
 CONSTRAINT pk_lprod PRIMARY KEY (lprod_gu)
);

SELECT * 
  FROM lprod;

INSERT INTO lprod(lprod_id, lprod_gu, lprod_nm)
     VALUES (1,'P101','컴퓨터제품');
     
INSERT INTO lprod(lprod_id, lprod_gu, lprod_nm)
     VALUES (1,'P102','컴퓨터제품');

SELECT lprod_gu, lprod_nm 
  FROM lprod;
  
COMMIT;
ROLLBACK;

-- 고객정보 테이블
SELECT * 
  FROM member;
-- 장바구니 테이블  
SELECT * 
  FROM cart;
-- 상품정보 테이블  
SELECT * 
  FROM prod;
-- 상품분류정보 테이블  
SELECT * 
  FROM lprod;
-- 거래처정보 테이블
SELECT * 
  FROM buyer;
-- 입고상품정보(재고) 테이블
SELECT * 
  FROM buyprod;
  
-- 회원테이블에서 회원아이디, 회원이름 조회하기
SELECT mem_id,mem_name 
  FROM member;

-- 상품코드와 상품명 조회하기
SELECT prod_id,prod_name
  FROM prod;
  
-- 상품코드, 상품명, 판매금액 조회하기
-- 단, 판매금액=판매단가 *55 로 계산해서 조회
-- 판매금액이 400만원 이상인 데이터만 조회
-- 정렬은 판매금액을 기준으로 내림차순
-- SELECT > FROM 테이블 > WHERE > 컬럼조회 > ORDER BY
SELECT prod_id,prod_name,
      (prod_sale*55) as prod_sale
  FROM prod
 WHERE (prod_sale*55) >= 4000000
 ORDER BY prod_sale DESC;
 
-- 상품정보에서 거래처코드를 조회
-- 단 중복을 제거하고 조회
SELECT DISTINCT prod_buyer 
           FROM prod;
           
-- 상품중에 판매가격이 17만원인 상품 조회하기
SELECT prod_id,prod_name,prod_sale
  FROM prod
 WHERE prod_sale = 170000;

-- 상품중에 판매가격이 17만원이 아닌 상품 조회하기
SELECT prod_id,prod_name,prod_sale
  FROM prod
 WHERE prod_sale != 170000;
 
-- 상품중에 판매가격이 17만원 이상이고 20만원 이하인 상품 조회
SELECT prod_id,prod_name,prod_sale
  FROM prod
 WHERE prod_sale >= 170000 
   AND prod_sale <= 200000;

-- 상품중에 판매가격이 17만원 이상 또는 20만원 이하인 상품 조회
SELECT prod_id,prod_name,prod_sale
  FROM prod
 WHERE prod_sale >= 170000 
    OR prod_sale <= 200000;

-- 상품 판매가격이 10만원 이상이고 
-- 상품 거래처(공급업체) 코드가 p30203 또는 p10201
-- 상품코드, 판매가격, 공급업체 코드 조회
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
       
-- 한번도 주문한 적이 없는 회원 아이디, 이름 조회
SELECT mem_id, mem_name 
  FROM member
 WHERE mem_id 
   NOT IN (SELECT DISTINCT cart_member
             FROM cart);

-- 상품분류 중에 상품정보에 없는 분류코드만 조회
SELECT lprod_gu 
  FROM lprod
 WHERE lprod_gu 
   NOT IN (SELECT DISTINCT prod_lgu 
             FROM prod);

-- 회원의 생일 중에 75년생이 아닌 회원아이디, 생일 조회하기
-- 정렬은 생일 기준 내림차순
SELECT mem_id, mem_bir
  FROM member
 WHERE TO_CHAR(mem_bir, 'YY') != '75'
 ORDER BY mem_bir DESC;
 
-- 회원 아이디가 a001인 회원이 주문한 상품코드를 조회하기
-- 조회 컬럼은 회원아이디, 상품코드
SELECT cart_member, cart_prod 
  FROM cart
 WHERE cart_member IN (SELECT mem_id 
                         FROM member 
                        WHERE mem_id = 'a001');

    

 