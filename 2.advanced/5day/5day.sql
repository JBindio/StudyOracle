-- ��üȸ���� 2005�⵵ 4�� �������ڿ� ���� ���ż����� ���� ��ȸ�ϼ���
-- �������ڴ� ��ٱ��� ���̺��� �ֹ���ȣ �� 8�ڸ� �Դϴ�.
-- ���ż����� ��ٱ��� ���̺��� ������ �ǹ��մϴ�.
-- ȸ��ID, ȸ������, ���ż����� �� ��ȸ
-- ���ż����� ������ 0���� ó��

SELECT mem_id, mem_name, SUM(NVL(cart_qty,0)) "SUM_QTY"
  FROM member LEFT OUTER JOIN
      (SELECT cart_member, cart_no, cart_qty
         FROM cart
        WHERE SUBSTR(cart_no,1,8) LIKE '200504%') S
        ON (mem_id = S.cart_member)
 GROUP BY mem_id, mem_name
 ORDER BY mem_id, mem_name;