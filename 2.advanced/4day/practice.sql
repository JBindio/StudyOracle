-- 4조 - 김성현, 강동현, 김지환, 방수진

-- 1번
-- 판매가가 가장 높은 제품의 상품 분류명을 주문한 
-- 회원명, 회원 주민등록번호, 직업, 취미 조회
-- 단, 주민등록번호 전체를 추출 (뒤의 첫번째 자리를 제외하고 나머지를 * 로 표시)
-- 정렬은 주민등록번호 기준으로 오름차순
   
-- 제일 비싼 제품의 제품 분류명
SELECT mem_name,
       mem_regno1 || '-' || SUBSTR(mem_regno2, 1,1)||'******' mem_regno,
       mem_job, mem_like
  FROM member, cart, prod, lprod,
       (SELECT lprod_gu, lprod_nm
          FROM(SELECT lprod_gu, lprod_nm, MAX(prod_sale) "MAX_SALE"
                 FROM lprod, prod
                WHERE lprod_gu = prod_lgu
                GROUP BY lprod_gu, lprod_nm
                ORDER BY MAX_SALE DESC)     
         WHERE ROWNUM = 1) "MAX_LPROD"
 WHERE prod_lgu = MAX_LPROD.lprod_gu      
   AND mem_id = cart_member
   AND prod_id = cart_prod
 GROUP BY mem_name, 
          mem_regno1 || '-' || SUBSTR(mem_regno2, 1,1)||'******',
          mem_job, mem_like          
 ORDER BY mem_regno;

-- 각각 
SELECT mem_name,
       mem_regno1 || '-' || SUBSTR(mem_regno2, 1,1)||'******' mem_regno,
       mem_job, mem_like
  FROM member, cart, prod, lprod,
      (SELECT lprod_gu, lprod_nm, MAX(prod_sale) "MAX_SALE"
         FROM lprod, prod
        WHERE lprod_gu = prod_lgu
        GROUP BY lprod_gu, lprod_nm
        ORDER BY MAX_SALE DESC) "MAX_LPROD"     
 WHERE prod_lgu = MAX_LPROD.lprod_gu      
   AND mem_id = cart_member
   AND prod_id = cart_prod
 GROUP BY mem_name, 
          mem_regno1 || '-' || SUBSTR(mem_regno2, 1,1)||'******',
          mem_job, mem_like          
 ORDER BY mem_regno; 
 
-- 2번
-- 거래처 주소가 대전에 빌딩이고 5층이상이고
-- 아파트에 살고, 취미가 독서인 사람
-- 회원이름,거래처명,거래처주소,취미,회원주소
-- LPAD("값", "총 문자길이", "채움문자") 사용
-- 일반방식사용

SELECT mem_name, buyer_name, buyer_add1, 
       LPAD(buyer_add2, 6, 0), mem_like, mem_add1
  FROM buyer, prod, cart, member
 WHERE buyer_id = prod_buyer
   AND prod_id = cart_prod
   AND mem_id = cart_member
   AND SUBSTR(buyer_add1, 1, 2) = '대전'
   AND SUBSTR(LPAD(buyer_add2, 6, 0),1,2) >= 5
   AND mem_like = '독서'
   AND mem_add2 LIKE '%아파트%';
   
 508
1008
SELECT *
FROM MEMBER;

-- 3번
-- 구매자의 이메일의 불완전한 메일을 수정하여 
-- 완전한 메일 형식으로 고쳐주시오
-- instr을 사용하여 해야함 (ex (instr(바꿀것,위치),1(바꿀것의 위치),2(번째))


-- 1974년 7월 이후 1980년 12월 까지 태어난 여성이 구입하였고,
-- 거래처 담당자가 존재하거나 주소가 부산이 아니며, 
-- 입고일자가 4월 이상이고 
-- 매입수량이 10 이상이거나 매입단가가 200000원 이하인 상품 중에서
-- 크기가 L인 상품명에 2가 포함된 제품을 조회하고 여자옷 사이즈 77 남자옷은 32
-- 할인이 가장 많이 된 상품의 상품명, 판매가, 할인율(2번째자리까지),사이즈를 
-- 1~5등만 나타내시오!
-- 단, 서브쿼리만을 이용해서!
SELECT prod_id,prod_name
  FROM prod,
       (SELECT prod_id, prod_name,
           MAX(ROUND((prod_price - prod_sale) / prod_price * 100,2)) "SALE"
          FROM prod
         GROUP BY prod_id, prod_name
         ORDER BY SALE DESC)
 WHERE ROWNUM = 5;