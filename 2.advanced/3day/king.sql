-- itmember 테이블 생성 하세요
-- itmember는 한가람 IT 학원의 학생 명단입니다

-- < 컬럼 >
-- it_id(ID), it_name(회원이름), it_mail(메일주소), it_nickname(별명)
-- 모든 컬럼에 NULL은 없습니다
-- PK는 it_id 입니다

-- < 데이터 >
-- 학생수는 4명이며 이름은 이정빈, 권지은, 이성경, 조혜리 입니다
-- 학생 ID는 이정빈:a001, 권지은:b001, 이성경:c001, 조혜리:d001 입니다.
-- 메일 주소는 king@batju?.com 로 4명 다 동일합니다.
-- 별명은 이정빈:잘생김, 권지은:1, 이성경:바이블, 조혜리:걸스데이혜리 입니다.

-- < 문제 >
-- IT학생들이 화장품을 사러 갔습니당! 상품분류명은 화장품이겠져?
-- 우린 스킨과 향수를 샀어여 상품명이 스킨과 향수인것만 조회하세여! *^^*
-- 아차차!, 모든 NULL 값은 '킹받쥬?'로 변경하세욤 키득 ^_^
-- 정렬도 해야쥬? IT학생의 닉네임 기준 오름차순으로 부탁해용
-- 상품명, 상품분류명, IT학생의 이름, IT학생의 닉네임을 조회하세여~

-- 총 28개의 행이 나오면 야호~! 정답입니다 헿

-- 테이블 생성
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

-- 정답
SELECT prod_name,
      lprod_nm,
      NVL((SELECT it_name FROM itmember
              WHERE it_id = cart_member), '킹받쥬?'),
      NVL((SELECT it_nickname FROM itmember
              WHERE it_id = cart_member), '킹받쥬?')
  FROM prod, cart, lprod
 WHERE prod_id = cart_prod
   AND lprod_gu = prod_lgu
   AND lprod_nm = '화장품'
   AND (prod_name LIKE ('%스킨%')
    OR  prod_name LIKE ('%향수%'))
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
   AND lprod_nm = '화장품'
   AND (prod_name LIKE ('%스킨%')
    OR  prod_name LIKE ('%향수%'))
 ORDER BY (SELECT it_name FROM itmember
              WHERE it_id = cart_member);