-- SELECT
-- ROWNUM 
-- 출판일이 빠른책 세권만
SELECT * FROM 
(
    SELECT names, TO_CHAR(releasedate, 'yyyy-mm-dd') "출판일"
      FROM bookstbl
     ORDER BY releasedate
)
WHERE ROWNUM <= 3;

-- GROUP BY
SELECT author, division, SUM(price) "합계", SUM(1) "책수"
  FROM bookstbl 
 GROUP BY author, division
--HAVING SUM(price) >= 200000
 ORDER BY division;

-- 책 정가 평균치
SELECT CAST(AVG(price) AS NUMBER(8,2)) AS "평균책 정가" FROM bookstbl;

-- 책 가격 제일비싼책, 저렴한책
SELECT MAX(price), MIN(price) FROM bookstbl;

-- 전체 갯수
SELECT COUNT(*) FROM bookstbl
  WHERE division = 'B003';
  
  
-- ROLLUP, CUBE
SELECT division, SUM(price) "합계", SUM(1) "책수"
     , GROUPING_ID(division) "추가행여부"
  FROM bookstbl 
 GROUP BY ROLLUP(division);