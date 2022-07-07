-- idx 5에서 10사이 levels A인 값 조회
SELECT * FROM membertbl
 WHERE (idx >= 5 AND idx <= 10)
   AND levels = 'A';

-- BETWEEN A and B
-- idx 5에서 10사이 조회
SELECT * FROM membertbl
 WHERE idx BETWEEN 5 AND 10;

-- OR = A OR B A 아니면 B
SELECT * FROM membertbl
 WHERE levels = 'B' OR levels = 'D' OR levels = 'S';

-- IN = 한번에 여러 값 모아서 조회
SELECT * FROM membertbl
 WHERE levels NOT IN ('B','D','S');

-- LIKE = 비슷한 글자 검색(유사 검색어)
SELECT * FROM bookstbl
 WHERE names LIKE '애프터__'; --'애프터%', '애프터__','_프터%'


SELECT * FROM bookstbl
 WHERE (description LIKE '%작품%')
   AND division = 'B005';

--서브쿼리 (ANY, ALL, SOME) WHERE절 서브쿼리
SELECT * FROM bookstbl
 WHERE division IN (SELECT division FROM divtbl
 WHERE names = 'SF/판타지');

--서브쿼리2 컬럼사용 서브쿼리
SELECT b.idx "번호"
      ,b.author "저자"
      ,b.division "장르코드"
      ,(SELECT d.names FROM divtbl d WHERE d.division = b.division) 장르
      ,b.names "책제목"
      ,b.price "가격"
    
  FROM bookstbl b
 WHERE division ='B005';
 
--서브쿼리3 FROM절 서브쿼리
SELECT *
  FROM (SELECT b.author, b.division, b.names FROM bookstbl b) bb;
  
--서브쿼리 ANY
SELECT * FROM bookstbl
 WHERE division IN (SELECT division FROM divtbl
 WHERE division LIKE 'B%');

--정렬(ORDER BY) ASC(오름차순) DESC(내림차순)
SELECT idx, author, names, releasedate, price 
  FROM bookstbl
 ORDER BY price ASC;

--중복제거 (DISTINCT)
SELECT DISTINCT price
  FROM bookstbl;

SELECT * FROM divtbl
 WHERE division NOT IN (
SELECT DISTINCT division
  FROM bookstbl);

