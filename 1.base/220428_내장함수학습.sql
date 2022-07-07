-- 함수
-- 평균
SELECT CAST(AVG(price) AS NUMBER(38,2)) AS "책가격평균" FROM bookstbl;
SELECT CAST(AVG(hisal) AS NUMBER(38,2)) AS "최고" FROM salgrade;


-- DUAL(실제 db테이블을 사용하지 않을때)
SELECT CAST('1000' AS NUMBER(10)) "숫자" FROM dual;
SELECT CAST(1000.08 AS CHAR(10)) "문자" FROM dual;
SELECT CAST('2022/04/28' AS DATE) "날짜" FROM dual;

--TO CHAR
SELECT TO_CHAR(12345, '$999,999') "달러" FROM dual;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MM:SS') "실시간" FROM dual;

--문자열 함수
SELECT CHR(49), UNISTR('\D55F') FROM dual;
SELECT ASCII('A') FROM dual;

--합치다 CONCAT(문자열1, 문자열2) 또는 || <-- 파이프
SELECT 'Hello, '|| 'World'||'!' FROM dual;
SELECT CONCAT('Hello,','World') FROM dual;

--문자수 찾기
SELECT INSTR('이것이 Oracle이다, 반갑습니다.','Oracle') "문자수" FROM dual;

--대문자변경(UPPER), 소문자변경(LOWER)
SELECT UPPER('abcde'), LOWER('ABCDE') FROM dual;

--글자 자르기 (SUBSTR)
SELECT SUBSTR('대한민국만세',5,2) FROM dual; --5시작지점 2종료지점

--공백 없애기(TRIM)
SELECT LTRIM('   안녕하세요'), RTRIM('안녕하세요  '), TRIM('   안녕 하세요  ')
  FROM dual; -- 중간 공백은 없앨 수 없다

--실시간(SYSDATE)
SELECT SYSDATE FROM dual;