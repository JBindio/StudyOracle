-- 2day

-- 서브쿼리(subQuery) 정리

-- (방법1) SELECT 조회 컬럼 대신에 사용하는 경우 (스칼라 서브쿼리)
        -- 단일컬럼의 단일행만 조회 가능
        
-- (방법2) WHERE 절에 사용하는 경우
        -- IN : 단일컬럼의 단일행 또는 다중행 조회가능
        --  = : 단일컬럼의 단일행만 조회가능 

-- 회원정보 전체 조회
SELECT * 
  FROM member;
  
-- 취미가 수영인 회원 중 마일리지의 값이 1000 이상인
-- 회원 아이디, 회원 이름, 회원 취미, 회원 마일리지 조회
-- 정렬은 회원이름 기준 오름차순
SELECT mem_id, mem_name, mem_like, mem_mileage
  FROM member
 WHERE mem_like = '수영' 
   AND mem_mileage >= 1000
 ORDER BY mem_name ASC;
 
-- 김은대 회원과 동일한 취미를 가지는
-- 회원 아이디, 회원 이름, 회원 취미 조회
SELECT mem_id, mem_name, mem_like
  FROM member
 WHERE mem_like = (SELECT mem_like 
                     FROM member
                    WHERE mem_name = '김은대');
                    
-- 주문내역이 있는 회원에 대한 정보 조회하기
-- 회원아이디, 회원이름, 주문번호, 주문수량 조회하기
SELECT cart_member,(SELECT mem_name 
                      FROM member 
                     WHERE mem_id = cart_member) as cart_name,
       cart_no, cart_qty
  FROM cart;

-- 주문내역이 있는 회원에 대한 정보 조회하기
-- 회원아이디, 회원이름, 주문번호, 주문수량, 상품명 조회하기
SELECT cart_member,
     (SELECT mem_name 
        FROM member 
       WHERE mem_id = cart_member) as cart_name,
       cart_no,
     (SELECT prod_name
        FROM prod 
       WHERE prod_id = cart_prod) as cart_prod,
       cart_qty
  FROM cart;

-- a001 회원이 주문한 상품에 대한
-- 상품분류코드, 상품분류명 조회하기
SELECT lprod_gu, lprod_nm
  FROM lprod
 WHERE lprod_gu IN (SELECT prod_lgu
                     FROM prod 
                     WHERE prod_id IN (SELECT cart_prod
                                         FROM cart 
                                        WHERE cart_member = 'a001'));

-- 이쁜이 회원이 주문한 상품 중
-- 상품분류코드가 P201 이고,
-- 거래처코드가 P20101인
-- 상품코드 상품명 조회
SELECT prod_id, prod_name 
  FROM prod
 WHERE prod_lgu = 'P201'
   AND prod_buyer = 'P20101'                                                                     
   AND prod_id IN (SELECT cart_prod 
                     FROM cart
                    WHERE cart_member IN (SELECT mem_id
                                            FROM member
                                           WHERE mem_name = '이쁜이')); 

-- '삼'으로 시작하는 모든 문자열 조회                                           
SELECT prod_id, prod_name
  FROM prod
 WHERE prod_name LIKE '삼%';

-- 두번째 글자가 '성'으로 시작하는 모든 문자열 조회 
SELECT prod_id, prod_name
  FROM prod
 WHERE prod_name LIKE '_성%';

-- '치'로 끝나는 모든 문자열 조회 
SELECT prod_id, prod_name
  FROM prod
 WHERE prod_name LIKE '%치';

-- '치'로 끝나는 모든 문자열을 제외하고 조회                      
SELECT prod_id, prod_name
  FROM prod
 WHERE prod_name NOT LIKE '%치';

-- 문자열에 '%'가 들어갈 경우
-- ESCAPE '구분자' 오른쪽에 있는 값을 문자열로 인식
-- 즉, 홍% 로 끝나는 모든 문자열 조회
SELECT lprod_gu, lprod_nm
  FROM lprod
 WHERE lprod_nm LIKE '%홍\%' ESCAPE '\';
 
-- CONCAT 문자열을 합칠때 사용
SELECT CONCAT('이름 : ', mem_name)
  FROM member;

-- || 여러개 문자열 합칠때 사용  
SELECT '아이디:' || mem_id || ' 이름:' || mem_name
  FROM member;
  
SELECT '<' || TRIM('   A A A   ')||'>' TRIM1,
       '<' || TRIM(LEADING 'a' FROM 'aaAaBaAaa') || '>' TRIM2,
       '<' || TRIM('a' FROM 'aaAaBaAaa') || '>' TRIM3
  FROM dual;

-- SUBSTR 문자열 자르기 함수 (SUBSTR(문자열,시작지점,거리)
SELECT SUBSTR('SQL PROJECT',1,3) RESULT1,
       SUBSTR('SQL PROJECT',5) RESULT2,
       SUBSTR('SQL PROJECT',-7,3) RESULT3
  FROM dual;

SELECT mem_id, SUBSTR(mem_name,1,1) 성씨
  FROM member;
  
SELECT prod_id,prod_name 
  FROM prod
 WHERE SUBSTR(prod_name,4,2) = '칼라';
 
-- REPLACE 문자열 치환
SELECT buyer_name, REPLACE(buyer_name,'삼','육') "삼->육"
  FROM buyer;
  
SELECT mem_name 회원명, REPLACE(SUBSTR(mem_name,1,1),'이','리') || 
                                SUBSTR(mem_name,2,2) 회원명치환
  FROM member;

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

-- ROUND 소숫점 반올림        
-- TRUNK 소숫점 절삭
SELECT mem_mileage, ROUND(mem_mileage / 12, 2) ROUND,
                    TRUNC(mem_mileage / 12, 2) TRUNC
  FROM member;
  
-- MOD 나눗셈 후 나머지
SELECT MOD(10,3)
  FROM dual;
  
SELECT 
    * FROM member;
    
SELECT mem_name,mem_regno1,mem_regno2, MOD(SUBSTR(mem_regno2,1,1),2) 성별코드
FROM member;

-- SYSDATE 현재 날짜
SELECT SYSDATE "현재시간",
       SYSDATE-1 "어제 이시간",
       SYSDATE+1 "내일 이시간"
  FROM dual;
  
SELECT mem_name, mem_bir, mem_bir + 12000 "12000일째"
  FROM member;
  
SELECT ADD_MONTHS(SYSDATE, 5)
  FROM dual;
  
SELECT NEXT_DAY(SYSDATE,'월요일'),
       LAST_DAY(SYSDATE)
  FROM dual;
  
SELECT LAST_DAY(SYSDATE) - SYSDATE
  FROM dual;
  
SELECT ROUND(SYSDATE,'YYYY'),
       ROUND(SYSDATE,'Q')
  FROM dual;
  
-- EXTRACT 날짜에서 필요한 부분 추출
SELECT EXTRACT(YEAR FROM SYSDATE) "년도",
       EXTRACT(MONTH FROM SYSDATE) "월",
       EXTRACT(DAY FROM SYSDATE) "일"
  FROM dual;
  
SELECT mem_name, mem_bir
  FROM member
 WHERE EXTRACT(MONTH FROM mem_bir) = 3;
 
-- CAST 형 변환
SELECT CAST('1997/12/25' AS DATE)
  FROM dual;

SELECT '[' || CAST('Hello' AS CHAR(30)) || ']' "형변환"
  FROM dual;

SELECT '[' || CAST('Hello' AS VARCHAR(30)) || ']' "형변환"
  FROM dual;

SELECT TO_CHAR(SYSDATE,'AD YYYY,CC"세기"')
  FROM dual;
SELECT TO_CHAR(CAST('2008-12-25' AS DATE),
               'YYYY.MM.DD HH24:MI')
  FROM dual;
  
SELECT prod_name,prod_sale,TO_CHAR(prod_insdate, 'YYYY-MM-DD')
  FROM prod;
  
SELECT mem_name||'님은 '||TO_CHAR(mem_bir,'YYYY')||'년 '||
       TO_CHAR(mem_bir,'MM') || '월 출생이고 태어난 요일은 ' ||
       TO_CHAR(mem_bir,'DAY')||' 입니다' "BIR"
  FROM member;  
  
SELECT TO_CHAR(1234.6, '99,999.00'),
       TO_CHAR(1234.6, '9999.99'),
       TO_CHAR(1234.6, '9999999999999.999')
  FROM dual;
  
SELECT TO_CHAR(1234.6, 'L99,999.00PR'),
       TO_CHAR(-1234.6, 'L99,999.99PR')

  FROM dual;
  
-- 여자인 회원이 구매한 상품 중
-- 상품분류에 전자가 포함되어 있고
-- 거래처의 지역이 서울인
-- 상품코드, 상품명 조회하기
SELECT prod_id, prod_name
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
                                                 
                                                 
-- 집계함수                                                 
SELECT ROUND(AVG(DISTINCT prod_cost),2) rnd_1, 
       ROUND(AVG(ALL prod_cost),2) rnd_2, 
       ROUND(AVG(prod_cost),2) rnd_3
  FROM prod;
  
SELECT COUNT(DISTINCT prod_cost), 
       COUNT(ALL prod_cost),
       COUNT(prod_cost),
       COUNT(*)
  FROM prod;

-- 집계함수만 사용하는 경우 GROUP BY 생략 가능
-- 집계함수 : sum(), avg(), min(), max(), count()
-- 조회할 일반 컬럼이 사용되는 경우에는 GROUP BY절 사용
-- GROUP BY 절에는 조회에 사용된 일반 컬럼 필수
-- 함수를 사용한 경우 원형 그대로 사용
-- ORDER BY 절에 사용되는 컬럼은 GROUP BY 절에 필수 사용
SELECT mem_job, mem_like,
       COUNT(mem_job) as cnt_1,
       COUNT(*) as cnt_2
  FROM member
 WHERE mem_mileage > 10
   AND mem_mileage > 10
 GROUP BY mem_job, mem_like, mem_id
 ORDER BY cnt_1, mem_id DESC;
 
-- 수영을 취미로 하는 회원들이
-- 주로 구매하는 상품에 대한 정보 조회
-- 상품명별 count 집계
-- 조회 컬럼 : 상품명, 상품count
-- 정렬은 상품코드를 기준으로 내림차순.

SELECT prod_name as P_NAME, COUNT(prod_name) as P_COUNT
  FROM prod
 WHERE prod_id IN (
           SELECT cart_prod
             FROM cart
            WHERE cart_member IN(
                          SELECT mem_id 
                            FROM member
                           WHERE mem_like = '수영' ))
 GROUP BY prod_name,prod_id
 ORDER BY prod_id DESC;

-- 70년도에 태어난 대전에 사는 회원이
-- 구매한 제품 조회
SELECT prod_name as P_NAME, COUNT(prod_name) as P_COUNT
  FROM prod
 WHERE prod_id IN(
           SELECT cart_prod
             FROM cart
            WHERE cart_member IN(
                          SELECT mem_id
                            FROM member
                           WHERE EXTRACT(YEAR FROM mem_bir) >= 1970
                             AND EXTRACT(YEAR FROM mem_bir) < 1980
                             AND SUBSTR(mem_add1,1,2) = '대전'))
