-- 2day

-- ��������(subQuery) ����

-- (���1) SELECT ��ȸ �÷� ��ſ� ����ϴ� ��� (��Į�� ��������)
        -- �����÷��� �����ุ ��ȸ ����
        
-- (���2) WHERE ���� ����ϴ� ���
        -- IN : �����÷��� ������ �Ǵ� ������ ��ȸ����
        --  = : �����÷��� �����ุ ��ȸ���� 

-- ȸ������ ��ü ��ȸ
SELECT * 
  FROM member;
  
-- ��̰� ������ ȸ�� �� ���ϸ����� ���� 1000 �̻���
-- ȸ�� ���̵�, ȸ�� �̸�, ȸ�� ���, ȸ�� ���ϸ��� ��ȸ
-- ������ ȸ���̸� ���� ��������
SELECT mem_id, mem_name, mem_like, mem_mileage
  FROM member
 WHERE mem_like = '����' 
   AND mem_mileage >= 1000
 ORDER BY mem_name ASC;
 
-- ������ ȸ���� ������ ��̸� ������
-- ȸ�� ���̵�, ȸ�� �̸�, ȸ�� ��� ��ȸ
SELECT mem_id, mem_name, mem_like
  FROM member
 WHERE mem_like = (SELECT mem_like 
                     FROM member
                    WHERE mem_name = '������');
                    
-- �ֹ������� �ִ� ȸ���� ���� ���� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸�, �ֹ���ȣ, �ֹ����� ��ȸ�ϱ�
SELECT cart_member,(SELECT mem_name 
                      FROM member 
                     WHERE mem_id = cart_member) as cart_name,
       cart_no, cart_qty
  FROM cart;

-- �ֹ������� �ִ� ȸ���� ���� ���� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸�, �ֹ���ȣ, �ֹ�����, ��ǰ�� ��ȸ�ϱ�
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

-- a001 ȸ���� �ֹ��� ��ǰ�� ����
-- ��ǰ�з��ڵ�, ��ǰ�з��� ��ȸ�ϱ�
SELECT lprod_gu, lprod_nm
  FROM lprod
 WHERE lprod_gu IN (SELECT prod_lgu
                     FROM prod 
                     WHERE prod_id IN (SELECT cart_prod
                                         FROM cart 
                                        WHERE cart_member = 'a001'));

-- �̻��� ȸ���� �ֹ��� ��ǰ ��
-- ��ǰ�з��ڵ尡 P201 �̰�,
-- �ŷ�ó�ڵ尡 P20101��
-- ��ǰ�ڵ� ��ǰ�� ��ȸ
SELECT prod_id, prod_name 
  FROM prod
 WHERE prod_lgu = 'P201'
   AND prod_buyer = 'P20101'                                                                     
   AND prod_id IN (SELECT cart_prod 
                     FROM cart
                    WHERE cart_member IN (SELECT mem_id
                                            FROM member
                                           WHERE mem_name = '�̻���')); 

-- '��'���� �����ϴ� ��� ���ڿ� ��ȸ                                           
SELECT prod_id, prod_name
  FROM prod
 WHERE prod_name LIKE '��%';

-- �ι�° ���ڰ� '��'���� �����ϴ� ��� ���ڿ� ��ȸ 
SELECT prod_id, prod_name
  FROM prod
 WHERE prod_name LIKE '_��%';

-- 'ġ'�� ������ ��� ���ڿ� ��ȸ 
SELECT prod_id, prod_name
  FROM prod
 WHERE prod_name LIKE '%ġ';

-- 'ġ'�� ������ ��� ���ڿ��� �����ϰ� ��ȸ                      
SELECT prod_id, prod_name
  FROM prod
 WHERE prod_name NOT LIKE '%ġ';

-- ���ڿ��� '%'�� �� ���
-- ESCAPE '������' �����ʿ� �ִ� ���� ���ڿ��� �ν�
-- ��, ȫ% �� ������ ��� ���ڿ� ��ȸ
SELECT lprod_gu, lprod_nm
  FROM lprod
 WHERE lprod_nm LIKE '%ȫ\%' ESCAPE '\';
 
-- CONCAT ���ڿ��� ��ĥ�� ���
SELECT CONCAT('�̸� : ', mem_name)
  FROM member;

-- || ������ ���ڿ� ��ĥ�� ���  
SELECT '���̵�:' || mem_id || ' �̸�:' || mem_name
  FROM member;
  
SELECT '<' || TRIM('   A A A   ')||'>' TRIM1,
       '<' || TRIM(LEADING 'a' FROM 'aaAaBaAaa') || '>' TRIM2,
       '<' || TRIM('a' FROM 'aaAaBaAaa') || '>' TRIM3
  FROM dual;

-- SUBSTR ���ڿ� �ڸ��� �Լ� (SUBSTR(���ڿ�,��������,�Ÿ�)
SELECT SUBSTR('SQL PROJECT',1,3) RESULT1,
       SUBSTR('SQL PROJECT',5) RESULT2,
       SUBSTR('SQL PROJECT',-7,3) RESULT3
  FROM dual;

SELECT mem_id, SUBSTR(mem_name,1,1) ����
  FROM member;
  
SELECT prod_id,prod_name 
  FROM prod
 WHERE SUBSTR(prod_name,4,2) = 'Į��';
 
-- REPLACE ���ڿ� ġȯ
SELECT buyer_name, REPLACE(buyer_name,'��','��') "��->��"
  FROM buyer;
  
SELECT mem_name ȸ����, REPLACE(SUBSTR(mem_name,1,1),'��','��') || 
                                SUBSTR(mem_name,2,2) ȸ����ġȯ
  FROM member;

-- ��ǰ�з� �߿� '����'�� ���Ե� ��ǰ�� ������ ȸ�� ��ȸ�ϱ�
-- ȸ�����̵�, ȸ���̸� ��ȸ�ϱ�
-- ��, ��ǰ���߿� �Ｚ���ڰ� ���Ե� ��ǰ�� ������ ȸ��
-- �׸��� ��̰� ������ ȸ��
SELECT mem_id, mem_name 
  FROM member
 WHERE mem_like = '����'
   AND mem_id IN (
          SELECT cart_member
            FROM cart
           WHERE cart_prod IN (
                       SELECT prod_id
                         FROM prod
                        WHERE prod_name LIKE '%�Ｚ����%'
                          AND prod_lgu IN (
                                   SELECT lprod_gu
                                     FROM lprod
                                    WHERE lprod_nm LIKE '%����%')));

-- ROUND �Ҽ��� �ݿø�        
-- TRUNK �Ҽ��� ����
SELECT mem_mileage, ROUND(mem_mileage / 12, 2) ROUND,
                    TRUNC(mem_mileage / 12, 2) TRUNC
  FROM member;
  
-- MOD ������ �� ������
SELECT MOD(10,3)
  FROM dual;
  
SELECT 
    * FROM member;
    
SELECT mem_name,mem_regno1,mem_regno2, MOD(SUBSTR(mem_regno2,1,1),2) �����ڵ�
FROM member;

-- SYSDATE ���� ��¥
SELECT SYSDATE "����ð�",
       SYSDATE-1 "���� �̽ð�",
       SYSDATE+1 "���� �̽ð�"
  FROM dual;
  
SELECT mem_name, mem_bir, mem_bir + 12000 "12000��°"
  FROM member;
  
SELECT ADD_MONTHS(SYSDATE, 5)
  FROM dual;
  
SELECT NEXT_DAY(SYSDATE,'������'),
       LAST_DAY(SYSDATE)
  FROM dual;
  
SELECT LAST_DAY(SYSDATE) - SYSDATE
  FROM dual;
  
SELECT ROUND(SYSDATE,'YYYY'),
       ROUND(SYSDATE,'Q')
  FROM dual;
  
-- EXTRACT ��¥���� �ʿ��� �κ� ����
SELECT EXTRACT(YEAR FROM SYSDATE) "�⵵",
       EXTRACT(MONTH FROM SYSDATE) "��",
       EXTRACT(DAY FROM SYSDATE) "��"
  FROM dual;
  
SELECT mem_name, mem_bir
  FROM member
 WHERE EXTRACT(MONTH FROM mem_bir) = 3;
 
-- CAST �� ��ȯ
SELECT CAST('1997/12/25' AS DATE)
  FROM dual;

SELECT '[' || CAST('Hello' AS CHAR(30)) || ']' "����ȯ"
  FROM dual;

SELECT '[' || CAST('Hello' AS VARCHAR(30)) || ']' "����ȯ"
  FROM dual;

SELECT TO_CHAR(SYSDATE,'AD YYYY,CC"����"')
  FROM dual;
SELECT TO_CHAR(CAST('2008-12-25' AS DATE),
               'YYYY.MM.DD HH24:MI')
  FROM dual;
  
SELECT prod_name,prod_sale,TO_CHAR(prod_insdate, 'YYYY-MM-DD')
  FROM prod;
  
SELECT mem_name||'���� '||TO_CHAR(mem_bir,'YYYY')||'�� '||
       TO_CHAR(mem_bir,'MM') || '�� ����̰� �¾ ������ ' ||
       TO_CHAR(mem_bir,'DAY')||' �Դϴ�' "BIR"
  FROM member;  
  
SELECT TO_CHAR(1234.6, '99,999.00'),
       TO_CHAR(1234.6, '9999.99'),
       TO_CHAR(1234.6, '9999999999999.999')
  FROM dual;
  
SELECT TO_CHAR(1234.6, 'L99,999.00PR'),
       TO_CHAR(-1234.6, 'L99,999.99PR')

  FROM dual;
  
-- ������ ȸ���� ������ ��ǰ ��
-- ��ǰ�з��� ���ڰ� ���ԵǾ� �ְ�
-- �ŷ�ó�� ������ ������
-- ��ǰ�ڵ�, ��ǰ�� ��ȸ�ϱ�
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
             WHERE lprod_nm LIKE '%����%')
   AND prod_buyer IN (
              SELECT buyer_id 
                FROM buyer
               WHERE SUBSTR(buyer_add1,1,2) = '����');
                                                 
                                                 
-- �����Լ�                                                 
SELECT ROUND(AVG(DISTINCT prod_cost),2) rnd_1, 
       ROUND(AVG(ALL prod_cost),2) rnd_2, 
       ROUND(AVG(prod_cost),2) rnd_3
  FROM prod;
  
SELECT COUNT(DISTINCT prod_cost), 
       COUNT(ALL prod_cost),
       COUNT(prod_cost),
       COUNT(*)
  FROM prod;

-- �����Լ��� ����ϴ� ��� GROUP BY ���� ����
-- �����Լ� : sum(), avg(), min(), max(), count()
-- ��ȸ�� �Ϲ� �÷��� ���Ǵ� ��쿡�� GROUP BY�� ���
-- GROUP BY ������ ��ȸ�� ���� �Ϲ� �÷� �ʼ�
-- �Լ��� ����� ��� ���� �״�� ���
-- ORDER BY ���� ���Ǵ� �÷��� GROUP BY ���� �ʼ� ���
SELECT mem_job, mem_like,
       COUNT(mem_job) as cnt_1,
       COUNT(*) as cnt_2
  FROM member
 WHERE mem_mileage > 10
   AND mem_mileage > 10
 GROUP BY mem_job, mem_like, mem_id
 ORDER BY cnt_1, mem_id DESC;
 
-- ������ ��̷� �ϴ� ȸ������
-- �ַ� �����ϴ� ��ǰ�� ���� ���� ��ȸ
-- ��ǰ�� count ����
-- ��ȸ �÷� : ��ǰ��, ��ǰcount
-- ������ ��ǰ�ڵ带 �������� ��������.

SELECT prod_name as P_NAME, COUNT(prod_name) as P_COUNT
  FROM prod
 WHERE prod_id IN (
           SELECT cart_prod
             FROM cart
            WHERE cart_member IN(
                          SELECT mem_id 
                            FROM member
                           WHERE mem_like = '����' ))
 GROUP BY prod_name,prod_id
 ORDER BY prod_id DESC;

-- 70�⵵�� �¾ ������ ��� ȸ����
-- ������ ��ǰ ��ȸ
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
                             AND SUBSTR(mem_add1,1,2) = '����'))
