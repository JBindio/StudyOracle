--ROWNUM 출판일이 빠른 3권만 조회 서브쿼리로만 사용가능
SELECT * FROM
(
     SELECT names, TO_CHAR(releasedate, 'YYYY-MM-DD') "출판일"
       FROM bookstbl
      ORDER BY releasedate
)
 WHERE ROWNUM <= 3;

--한국식 날짜표기법 변경
SELECT names, TO_CHAR(releasedate, 'YYYY-MM-DD') "출판일"
  FROM bookstbl
 ORDER BY releasedate;

--미국식 날짜 표기법 변경
SELECT names, TO_CHAR(releasedate, 'MM/DD/YYYY') "출판일"
  FROM bookstbl;


--그룹화 (GROUP BY) + HAVING
SELECT author, division, SUM(price) "합계", SUM(1) "책 수"
  FROM bookstbl
 GROUP BY author, division
--HAVING SUM(price) >= 200000
 ORDER BY division;
 
--평균치 구하기 (AVG)
--소수점 변환 (CAST AS NUMBER)
 
SELECT CAST (AVG(price) AS NUMBER(8,2)) "평균" FROM bookstbl;
 
--책 가격 최고가, 최저가 비교 (MAX, MIN)
SELECT MAX(price), MIN(price) FROM bookstbl;

-- 전체 개수 (COUNT)
SELECT COUNT(*) FROM bookstbl
 WHERE division = 'B003';
 
-- ROLLUP, CUBE
SELECT division, SUM(price) "합계", SUM(1) "책 수"
      ,GROUPING_ID(division) "추가 행"
  FROM bookstbl
 GROUP BY ROLLUP(division);
 
 