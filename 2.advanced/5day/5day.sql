-- 전체회원의 2005년도 4월 구매일자에 대한 구매수량의 합을 조회하세요
-- 구매일자는 장바구니 테이블에서 주문번호 앞 8자리 입니다.
-- 구매수량은 장바구니 테이블에서 수량을 의미합니다.
-- 회원ID, 회원성명, 구매수량의 합 조회
-- 구매수량이 없으면 0으로 처리

SELECT mem_id, mem_name, SUM(NVL(cart_qty,0)) "SUM_QTY"
  FROM member LEFT OUTER JOIN
      (SELECT cart_member, cart_no, cart_qty
         FROM cart
        WHERE SUBSTR(cart_no,1,8) LIKE '200504%') S
        ON (mem_id = S.cart_member)
 GROUP BY mem_id, mem_name
 ORDER BY mem_id, mem_name;