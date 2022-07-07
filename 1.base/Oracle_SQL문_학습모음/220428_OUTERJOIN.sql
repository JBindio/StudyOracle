-- OUTER JOIN (외부 조인)

SELECT m.idx as "회원번호", m.names as "회원이름"
     , m.levels, m.mobile, m.email
     , r.idx
  FROM membertbl m
  LEFT OUTER JOIN rentaltbl r
    ON m.idx = r.memberidx
 WHERE r.idx IS NULL
   AND m.levels <> 'S';
   
-- 대여테이블 기준으로하면 대여안된 데이터는 하나도 없습니다
SELECT *
  FROM membertbl m
 RIGHT OUTER JOIN rentaltbl r
    ON m.idx = r.memberidx;


-- 대여를 한번도 하지 않은 책리스트 조회
SELECT b.idx as "책번호", b.names as "책제목"
     , b.author, b.price
     , r.idx, r.rentaldate, r.returndate
  FROM bookstbl b
  LEFT OUTER JOIN rentaltbl r
    ON b.idx = r.bookidx
 WHERE r.idx is null;
 

-- 
SELECT * 
  FROM rentaltbl r
 RIGHT OUTER JOIN bookstbl b 
    ON b.idx = r.bookidx
 RIGHT OUTER JOIN divtbl d
    ON b.division = d.division;

