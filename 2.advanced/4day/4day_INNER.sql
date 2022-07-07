-- 4day

-- 상품테이블과 상품분류테이블에서 상품분류코드가 'P101'인 것에 대한
-- 상품분류코드(상품테이블에 있는 컬럼), 상품명, 상품분류명 조회
-- 정렬은 상품아이디 내림차순
-- 일반방식
SELECT prod_lgu, prod_name, lprod_nm
  FROM lprod, prod
 WHERE lprod_gu = prod_lgu
   AND lprod_gu = 'P101'
 ORDER BY prod_id DESC;

-- 표준방식 
SELECT prod_lgu, prod_name, lprod_nm
  FROM lprod INNER JOIN prod
                ON (lprod_gu = prod_lgu
                    AND lprod_gu = 'P101')
 ORDER BY prod_id DESC;
 
 -- 김형모 회원이 구매한 상품에 대한
 -- 거래처 정보 확인하기
 -- 거래처코드, 거래처명, 회원거주지역(서울 or 인천 등) 조회
 -- 단, 상품분류명에 캐주얼 단어가 포함된 제품만 조회
 -- 일반방식
 SELECT buyer_id, buyer_name, SUBSTR(mem_add1,1,2)
   FROM buyer, lprod, prod, member, cart
  WHERE buyer_id = prod_buyer
    AND lprod_gu = prod_lgu
    AND prod_id = cart_prod
    AND lprod_nm LIKE '%캐주얼%'
    AND mem_id = cart_member
    AND mem_name = '김형모';
  
 -- 표준방식   
 SELECT buyer_id, buyer_name, SUBSTR(mem_add1,1,2)
   FROM buyer INNER JOIN prod
                 ON (buyer_id = prod_buyer)
              INNER JOIN lprod
                 ON (lprod_gu = prod_lgu
                     AND lprod_nm LIKE '%캐주얼%')
              INNER JOIN cart
                 ON (prod_id = cart_prod)
              INNER JOIN member
                 ON (mem_id = cart_member
                     AND mem_name = '김형모');
                                      
-- 상품분류명에 '전자'가 포함된 상품을 구매한 회원 조회하기
-- 회원아이디, 회원이름, 상품분류명 조회하기
-- 단, 상품명에 삼성전자가 포함된 상품을 구매한 회원과
--     회원의 취미가 수영인 회원
-- 일반방식
SELECT mem_id, mem_name, lprod_nm
  FROM lprod, prod, cart, member
 WHERE lprod_gu = prod_lgu
   AND cart_prod = prod_id
   AND cart_member = mem_id
   AND lprod_nm LIKE '%전자%'
   AND prod_name LIKE '%삼성전자%'
   AND mem_like = '수영';

-- 표준방식   
SELECT mem_id, mem_name, lprod_nm
  FROM lprod INNER JOIN prod
                ON (lprod_gu = prod_lgu
                    AND lprod_nm LIKE '%전자%')
             INNER JOIN cart
                ON (cart_prod = prod_id
                    AND prod_name LIKE '%삼성전자%')
             INNER JOIN member
                ON (cart_member = mem_id
                    AND mem_like = '수영');
           
-- 상품분류테이블과 상품테이블과 거래처테이블과 장바구니 테이블 사용
-- 상품분류코드가 'P101' 인것을 조회
-- 그리고, 정렬은 상품분류명을 기준으로 내림차순
--                상품아이디를 기준으로 오름차순 하세요
-- 상품분류명, 상품아이디, 상품판매가, 거래처담당자, 회원아이디, 주문수량
-- 일반방식
SELECT lprod_nm, prod_id, prod_sale, buyer_charger, cart_member, cart_qty
  FROM lprod, prod, buyer, cart
 WHERE lprod_gu = 'P101'
   AND lprod_gu = prod_lgu
   AND buyer_id = prod_buyer
   AND prod_id = cart_prod
 ORDER BY lprod_nm DESC, prod_id ASC;

-- 표준방식
SELECT lprod_nm, prod_id, prod_sale, buyer_charger, cart_member, cart_qty
  FROM lprod INNER JOIN prod
                ON (lprod_gu = prod_lgu
                    AND lprod_gu = 'P101')
             INNER JOIN buyer
                ON (buyer_id = prod_buyer)
             INNER JOIN cart
                ON (prod_id = cart_prod)
 ORDER BY lprod_nm DESC, prod_id ASC;
 
-- 상품코드별 구매수량에 대한 최대값, 최소값, 평균값, 합계, 갯수 조회
-- 단, 상품명에 삼성이 포함된 상품을 구매한 회원
-- 조회컬럼 : 상품코드, 최대값, 최소값, 평균값, 합계, 갯수
-- 일반방식
SELECT cart_prod, MAX(cart_qty) "q_max", MIN(cart_qty)"q_min", 
                  ROUND(AVG(cart_qty),2) "q_avg", 
                  SUM(cart_qty) "q_sum", COUNT(cart_qty) "q_count"
  FROM cart, prod
 WHERE prod_id = cart_prod
   AND prod_name LIKE '%삼성%'
 GROUP BY cart_prod;

-- 표준방식 
SELECT cart_prod, MAX(cart_qty) "q_max", MIN(cart_qty)"q_min", 
                  ROUND(AVG(cart_qty),2) "q_avg", 
                  SUM(cart_qty) "q_sum", COUNT(cart_qty) "q_count"
  FROM prod INNER JOIN cart
               ON (prod_id = cart_prod
                   AND prod_name LIKE '%삼성%')
 GROUP BY cart_prod; 
 
 
-- 거래처코드 및 상품분류코드별로
-- 판매가에 대한 최고, 최소, 자료수, 평균, 합계 조회
-- 조회컬럼 : 거래처코드, 거래처명, 상품분류코드, 상품분류명
--            판매가에 대한 최고, 최소, 자료수, 평균, 합계
-- 정렬은 평균을 기준으로 내림차순
-- 단 판매가의 평균이 100 이상인것

SELECT buyer_id, buyer_name, lprod_gu, lprod_nm,
       MAX(prod_sale) AS sale_max, MIN(prod_sale) AS sale_min,  
       COUNT(prod_sale) AS sale_count,
       ROUND(AVG(prod_sale),2) AS sale_avg, SUM(prod_sale) AS sale_sum
  FROM buyer, lprod, prod
 WHERE buyer_id = prod_buyer
   AND lprod_gu = prod_lgu
 GROUP BY buyer_id, buyer_name, lprod_gu, lprod_nm
HAVING ROUND(AVG(prod_sale),2) >= 100
 ORDER BY sale_avg DESC;
 
-- 거래처별로 GROUP 지어 매입금액의 합 조회하기
-- 상품입고테이블의 2005년도 1월의 매입일자(입고일자) 인것들
-- 매입금액 = 매입수량 * 매입금액
-- 조회컬럼 : 거래처코드, 거래처명, 매입금액의 합
-- 매입금액의 합이 NULL인 경우 0으로 조회
-- 정렬은 거래처 코드 및 거래처 명을 기준으로 내림차순
-- 일반방식
SELECT buyer_id, buyer_name, 
       NVL(SUM(buy_qty * buy_cost),0) AS cost_sum
  FROM buyer, prod, buyprod
 WHERE buyer_id = prod_buyer
   AND prod_id = buy_prod
   AND buy_date BETWEEN '2005/01/01' AND '2005/01/31'
 GROUP BY buyer_id, buyer_name
 ORDER BY buyer_id, buyer_name DESC;
 
-- 표준방식
SELECT buyer_id, buyer_name, 
        -- NVL은 집계함수 안에 사용
       SUM(NVL(buy_qty * buy_cost,0)) AS "qty*cost_sum"
       FROM buyer INNER JOIN prod
                ON (buyer_id = prod_buyer)
             INNER JOIN buyprod
                ON (prod_id = buy_prod
                    AND buy_date BETWEEN '2005/01/01' AND '2005/01/31')  
 GROUP BY buyer_id, buyer_name
 ORDER BY buyer_id DESC, buyer_name DESC;
 
-- 거래처별로 GROUP 지어서 매입금액의 합 계산
-- 매입금액의 합이 1천만원 이상인 상품코드, 상품명 조회
-- 상품입고테이블의 2005년도 1월의 매입일자(입고일자) 인것들
-- 매입금액 = 매입수량 * 매입금액
-- 조회컬럼 : 상품코드, 상품명
-- 매입금액의 합이 NULL인 경우 0으로 조회
-- 정렬은 상품명 기준 오름차순
-- 일반방식
SELECT prod_id, prod_name
  FROM prod, buyprod
 WHERE prod_id = buy_prod
   AND buy_date BETWEEN '2005/01/01' AND '2005/01/31'
 GROUP BY prod_id, prod_name 
HAVING SUM(NVL(buy_qty * buy_cost,0)) >= 10000000
 ORDER BY prod_name;
 
-- 표준방식
SELECT prod_id, prod_name
  FROM prod INNER JOIN buyprod
               ON (prod_id = buy_prod
                   AND buy_date BETWEEN '2005/01/01' AND '2005/01/31')
 GROUP BY prod_id, prod_name 
HAVING SUM(NVL(buy_qty * buy_cost,0)) >= 10000000
 ORDER BY prod_name;

-- 거래처별로 GROUP 지어 매입금액의 합 조회하기
-- 상품입고테이블의 2005년도 1월의 매입일자(입고일자) 인것들
-- 매입금액 = 매입수량 * 매입금액
-- 조회컬럼 : 거래처코드, 거래처명, 매입금액의 합
-- 매입금액의 합이 NULL인 경우 0으로 조회
-- 정렬은 거래처 코드 및 거래처 명을 기준으로 내림차순
-- 일반방식

-- 위의 결과를 통해
-- 매입금액의 합이 1천만원 이상인 상품코드, 상품명 검색
SELECT prod_id, prod_name
  FROM prod
 WHERE prod_buyer IN (SELECT buyer_id    
                        FROM buyer, prod, buyprod
                       WHERE buyer_id = prod_buyer
                         AND prod_id = buy_prod
                         AND buy_date BETWEEN '2005/01/01' AND '2005/01/31'
                       GROUP BY buyer_id
                       HAVING NVL(SUM(buy_qty * buy_cost),0) >= 10000000);

SELECT prod_id, prod_name
  FROM (SELECT buyer_id, buyer_name, 
               NVL(SUM(buy_qty * buy_cost),0) AS cost_sum
          FROM buyer, prod, buyprod
         WHERE buyer_id = prod_buyer
           AND prod_id = buy_prod
           AND buy_date BETWEEN '2005/01/01' AND '2005/01/31'
         GROUP BY buyer_id, buyer_name
         ORDER BY buyer_id, buyer_name DESC) "COST", prod