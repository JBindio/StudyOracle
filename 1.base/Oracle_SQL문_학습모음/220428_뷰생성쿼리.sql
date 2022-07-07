-- 뷰 생성
-- 사용자 SCOTT은 뷰생성 권한이 없기 때문에 DBA로 생성할 것
CREATE VIEW scott.v_Bookslist
AS
    SELECT bt.idx, bt.author, dt.names AS "책장르명"
         , bt.names, to_char(bt.releasedate, 'YYYY-MM-DD') AS "출판일" 
         , bt.isbn
         , TO_CHAR(bt.price, '999,999') AS "정가"
      FROM scott.bookstbl bt
     INNER JOIN scott.divtbl dt
        ON bt.division = dt.division;