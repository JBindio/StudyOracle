-- day3

-- 조회 순서
-- 1. 테이블 찾기
-- 제시된 컬럼들의 소속 찾기

-- 2. 테이블 간의 관계 찾기
-- ERD에서 연결된 순서대로 PK와 FK 컬럼 또는,
-- 성격이 같은 값으로 연결할 수 있는 컬럼 찾기

-- 3. 작성 순서 정하기
-- 조회하는 컬럼이 속한 테이블이 가장 밖 (1순위)
-- 1순위 테이블부터 ERD 순서대로 작성
-- 조건 : 해당 컬럼이 속한 테이블에서 조건 처리


-- 상품분류 중에 '전자'가 포함된 상품을 구매한 회원 조회하기
-- 회원아이디, 회원이름 조회하기
-- 단, 상품명중에 삼성전자가 포함된 상품을 구매한 회원
-- 그리고 취미가 수영인 회원

SELECT mem_id, mem_name
  FROM member
 WHERE mem_like = '수영'
   AND mem_id IN (
          SELECT cart_member
            FROM cart
           WHERE cart_prod IN (
                       SELECT prod_id
                         FROM prod
                        WHERE prod_name LIKE '%삼성전자%'
                          AND prod_lgu IN (
                                   SELECT lprod_gu
                                     FROM lprod
                                    WHERE lprod_nm LIKE '%전자%')));
   
   
           
SELECT
    * FROM lprod;
    
    
-- 김형모 회원이 구매한 상품에 대한
-- 거래처 정보 확인하기
-- 거래처코드, 거래처명, 지역(서울 OR 인천), 거래처 전화번호 조회
-- 상품분류명 중에 캐주얼 단어가 포함된 제품

SELECT buyer_id, buyer_name, SUBSTR(buyer_add1,1,2) as buyer_add, buyer_comtel
  FROM buyer
 WHERE buyer_lgu IN (
             SELECT lprod_gu
               FROM lprod
              WHERE lprod_nm LIKE '%캐주얼%'
                AND lprod_gu IN (
                        SELECT prod_lgu
                          FROM prod
                         WHERE prod_id IN (
                                   SELECT cart_prod
                                     FROM cart
                                    WHERE cart_member IN(
                                                  SELECT mem_id
                                                    FROM member
                                                   WHERE mem_name = '김형모'))));
                                                   
SELECT buyer_id, buyer_name, SUBSTR(buyer_add1,1,2) as buyer_add, buyer_comtel
  FROM buyer
 WHERE buyer_id IN (
            SELECT prod_buyer
              FROM prod
             WHERE prod_lgu IN (
                        SELECT lprod_gu
                          FROM lprod
                         WHERE lprod_nm LIKE '%캐주얼%')
               AND prod_id IN (
                       SELECT cart_prod
                         FROM cart
                        WHERE cart_member IN(
                                      SELECT mem_id
                                        FROM member
                                       WHERE mem_name = '김형모')));
              
SELECT
    * FROM buyer;
    
-- 여자인 회원이 구매한 상품 중
-- 상품분류에 전자가 포함되어있고
-- 거래처의 지역이 서울인
-- 상품 코드 상품명 조회하기

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
             WHERE lprod_nm LIKE '%전자%')
   AND prod_buyer IN (
              SELECT buyer_id
                FROM buyer
               WHERE SUBSTR(buyer_add1,1,2) = '서울');
               
-- 상품코드별 구매수량에 대한 최대값, 최소값, 평균값, 합계, 갯수 조회
-- 조회컬럼 : 상품코드, 최대값, 최소값, 평균값, 합계, 갯수

SELECT cart_prod, MAX(cart_qty), MIN(cart_qty), ROUND(AVG(cart_qty),2), 
                  SUM(cart_qty), COUNT(cart_qty)
  FROM cart
 GROUP BY cart_prod;
 
-- 오늘이 2005년 7월 11일 이라 가정하고
-- 장바구니 테이블에 발생될 추가 주문번호 조회
-- 조회컬럼 : 현재 마지막 주문번호, 추가 주문번호
SELECT MAX(cart_no), MAX(cart_no)+1
  FROM cart
 WHERE SUBSTR(cart_no,1,8) = '20050711';

-- 회원 테이블의 회원 전체의 마일리지 평균, 마일리지 합계,
-- 최고 마일리지, 최소 마일리지, 인원수 조회
-- 조회컬럼 : 마일리지평균, 마일리지합계, 최고마일리지, 최소마일리지, 인원수
SELECT ROUND(AVG(mem_mileage),2) "M_AVG", SUM(mem_mileage) "M_SUM",
            MAX(mem_mileage) "M_MAX", MIN(mem_mileage) "M_MIN",
            COUNT(mem_mileage) "M_COUNT"
  FROM member;
  
-- 상품 테이블에서 거래처코드별, 상품분류코드별
-- 판매가에 대한 최고, 최소 ,자료수, 평균, 합계 조회
-- 정렬은 자료수 기준 내림차순
-- 추가로 거래처명, 상품분류명 조회
-- 단, 합계가 100 이상인 것
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

-- IS NULL, IS NOTNILL 결측치 확인 
UPDATE buyer SET buyer_charger = NULL
 WHERE buyer_charger LIKE '김%';
  
UPDATE buyer SET buyer_charger = ''
 WHERE buyer_charger LIKE '성%';
 
SELECT buyer_name,
       NVL(buyer_charger,'없음')
  FROM buyer;

-- DECODE 파이썬의 if문   
SELECT prod_lgu,
       DECODE(SUBSTR(prod_lgu, 1,2), -- if
             'P1', '컴퓨터/전자 제품', 
             'P2', '의류',           
             'P3', '잡화', 
                   '기타') as lgu_nm --else
  FROM prod;

-- EXISTS 조회된 결과 TRUE, FALSE  
SELECT prod_id, prod_name, prod_lgu
  FROM prod
 WHERE EXISTS (SELECT lprod_gu
                 FROM lprod
                WHERE lprod_gu = prod_lgu);
                
-- JOIN : CROSS JOIN, NATURAL JOIN, INNER JOIN, OUTER JOIN
-- CROSS JOIN : FROM 절에 여러개 테이블
SELECT * 
  FROM lprod, prod;
  
SELECT * 
  FROM lprod CROSS JOIN prod;
  
-- EQUI JOIN = INNER JOIN
-- PK와 FK가 존재해야 한다
-- 관계조건 : PK = FK
-- 관계조건 갯수 : FROM 절에 제시된 (테이블 갯수 - 1개)
-- 일반 방식
SELECT prod_id,
       buyer_name,  
       prod.prod_name,
       lprod_nm,
       cart_qty,
       mem_name
  FROM lprod,prod,buyer,cart,member
-- 관계 조건식
 WHERE lprod_gu = prod_lgu
   AND buyer_id = prod_buyer
   AND prod_id = cart_prod
   AND mem_id = cart_member
   AND mem_id = 'a001';
   
-- 표준 방식
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

-- 상품 테이블에서 상품코드, 상품명, 분류명, 거래처명, 거래처 주소 조회
-- 판매가격이 10만원 이하
-- 거래처 주소는 부산
-- 일반 표준, 둘다 사용하기
SELECT prod_id, prod_name, lprod_nm, buyer_name, buyer_add1
  FROM prod, lprod, buyer
 WHERE lprod_gu = prod_lgu
   AND buyer_id = prod_buyer
   AND prod_sale <= 100000
   AND SUBSTR(buyer_add1,1,2) = '부산';
   
SELECT prod_id, prod_name, lprod_nm, buyer_name, buyer_add1
  FROM prod INNER JOIN lprod
               ON (lprod_gu = prod_lgu
                   AND prod_sale <= 100000)
            INNER JOIN buyer
               ON (buyer_id = prod_buyer
                   AND SUBSTR(buyer_add1,1,2) = '부산');
                   

-- 상품분류명, 상품명, 상품색상, 매입수량, 주문수량, 거래처명 조회
-- 상품분류 코드가 'P101', 'P201', 'P301' 인것
-- 매입수량이 15개 이상인 것
-- 서울에 살고 있는 회원중에 생일이 1974년 생인 회원
-- 정렬은 회원 아이디 기준 내림차순, 매입수량 기준 오름차순
-- 일반방식, 표준방식

-- 일반방식
SELECT lprod_nm, prod_name, prod_color, buy_qty, cart_qty ,buyer_name
  FROM lprod, prod, buyer, buyprod, cart, member
 WHERE lprod_gu = prod_lgu
   AND buyer_id = prod_buyer
   AND prod_id = buy_prod
   AND prod_id = cart_prod
   AND cart_member = mem_id
   AND (lprod_gu = 'P101' OR lprod_gu = 'P201' OR lprod_gu = 'P301')
   AND buy_qty >= 15
   AND mem_add1 LIKE '서울%'
   AND EXTRACT(YEAR FROM mem_bir) = 1974
 ORDER BY mem_id DESC, buy_qty ASC;

-- 표준방식 
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
                   AND mem_add1 LIKE '서울%'
                   AND EXTRACT(YEAR FROM mem_bir) = 1974
 ORDER BY mem_id DESC, buy_qty ASC;
 
 SELECT
     * FROM member;
     
--