-- OUTER JOIN
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu)
  FROM lprod, prod
 WHERE lprod_gu = prod_lgu 
 GROUP BY lprod_gu, lprod_nm;
 
SELECT lprod_gu, lprod_nm, COUNT(prod_lgu)
  FROM lprod, prod
 WHERE lprod_gu = prod_lgu(+)
 GROUP BY lprod_gu, lprod_nm
 ORDER BY lprod_gu;

SELECT lprod_gu, lprod_nm, COUNT(prod_lgu)
  FROM lprod LEFT OUTER JOIN prod
               ON (lprod_gu = prod_lgu)
 GROUP BY lprod_gu, lprod_nm
 ORDER BY lprod_gu;


-- 전체상품의 2005년 1월 입고수량 조회
-- INNER JOIN
SELECT prod_id, prod_name, SUM(buy_qty)
  FROM prod, buyprod
 WHERE prod_id = buy_prod
   AND buy_date BETWEEN '2005/01/01' AND '2005/01/31'
 GROUP BY prod_id, prod_name;

-- OUTER JOIN
-- 일반방식
SELECT prod_id, prod_name, SUM(buy_qty)
  FROM prod, buyprod
 WHERE prod_id = buy_prod(+)
   AND buy_date BETWEEN '2005/01/01' AND '2005/01/31'
 GROUP BY prod_id, prod_name
 ORDER BY prod_id, prod_name;

-- 표준방식
SELECT prod_id, prod_name, SUM(buy_qty)
  FROM prod LEFT OUTER JOIN buyprod
              ON (prod_id = buy_prod
                  AND buy_date BETWEEN '2005/01/01' AND '2005/01/31')
 GROUP BY prod_id, prod_name
 ORDER BY prod_id, prod_name;


-- SELF JOIN
-- 거래처코드가 'P30203'과 동일지역에 속한 거래처만 검색 조회
SELECT B.buyer_id, B.buyer_name,
       B.buyer_add1 ||''||B.buyer_add2
  FROM buyer A, buyer B
 WHERE A.buyer_id = P30203'
   AND SUBSTR(A.buyer_add1, 1,2) = SUBSTR(B.buyer_add1, 1,2);
 
 
