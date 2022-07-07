-- 조인
-- 1. INNER JOIN
SELECT bt.idx, bt.author, dt.names AS "책장르명"
     , bt.names, to_char(bt.releasedate, 'YYYY-MM-DD') AS "출판일" 
     , bt.isbn
     , TO_CHAR(bt.price, '999,999') AS "정가"
  FROM bookstbl bt
 INNER JOIN divtbl dt
    ON bt.division = dt.division
 WHERE dt.division = 'B005';
 
 
-- INNER JOIN, 테이블 3개
SELECT r.idx, TO_CHAR(r.rentaldate, 'YYYY-MM-DD') AS "대여일"
     , TO_CHAR(r.returndate, 'YYYY-MM-DD') AS "반납일"
     , m.names as "대여자"
     , b.names as "빌린책"
  FROM membertbl m
 INNER JOIN rentaltbl r
    ON m.idx = r.memberidx
 INNER JOIN bookstbl b
    ON b.idx = r.bookidx
 WHERE r.returndate IS NOT null
 ORDER BY r.idx;
