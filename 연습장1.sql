sys
#주문정보 테이블
CREATE TABLE ORDER_INFO(
	ORDER_NUM INT PRIMARY KEY,		#주문번호
	ORDER_ITEM VARCHAR(20),			#주문상품
	ORDER_CNT INT,						#주문수량
	ORDER_USER_ID VARCHAR(20),		#주문자ID
	PAY_NUM INT							#결제번호
);

#결제정보 테이블
CREATE TABLE PAY_INFO (
	PAY_NUM INT PRIMARY KEY,		#결제번호
	PAY_PRICE INT,						#결제금액
	PAY_TYPE VARCHAR(10),			#결제방법
	PAY_DATE DATETIME					#결제일
);

#주문정보 데이터 삽입
INSERT INTO ORDER_INFO VALUES (1, '맨투맨 후드티', 1, 'kim', 3);
INSERT INTO ORDER_INFO VALUES (2, '데님 청바지', 2, 'lee', 1);
INSERT INTO ORDER_INFO VALUES (3, '라운드 긴팔티', 3, 'lee', 4);
INSERT INTO ORDER_INFO VALUES (4, '스포츠 양말', 5, 'kim', 2);
INSERT INTO ORDER_INFO VALUES (5, '슬렉스 바지', 1, 'park', 5);

#결제정보 데이터 삽입
INSERT INTO PAY_INFO VALUES (1, 15000, '계좌이체', '2025-01-10');
INSERT INTO PAY_INFO VALUES (2, 20000, '신용카드', '2025-01-12');
INSERT INTO PAY_INFO VALUES (3, 35000, '신용카드', '2025-01-15');
INSERT INTO PAY_INFO VALUES (4, 10000, '계좌이체', '2025-01-20');
INSERT INTO PAY_INFO VALUES (5, 80000, '계좌이체', '2025-01-22');

COMMIT;

#1. 모든 데이터에 대한 주문번호, 주문상품명, 주문수량, 주문자ID, 결제번호, 결제금액, 결제일을 조회하시오.
#2. 결제방법이 계좌이체이며, 결제금액이 만원을 초과한 주문에 대한 주문상품명, 주문수량, 결제금액, 결제방법을 조회하되, 결제일이 최신인 데이터부터 조회하시오.
#3. 결제일이 2025-01-20일 이전인 주문 중, 주문수량이 주문 수량이 홀수인 주문들의 주문번호, 주문수량, 주문자ID, 결제일을 조회하시오.

SELECT ORDER_NUM,ORDER_ITEM,ORDER_CNT,	ORDER_USER_ID, ORDER_INFO.PAY_NUM ,PAY_INFO.PAY_NUM,PAY_PRICE ,PAY_DATE  FROM order_info INNER JOIN pay_info
ON ORDER_INFO.PAY_NUM = PAY_INFO .PAY_NUM;

SELECT ORDER_ITEM,ORDER_CNT,PAY_PRICE,PAY_TYPE  FROM order_info A INNER JOIN pay_info B
ON A.PAY_NUM = B.PAY_NUM
WHERE PAY_TYPE = '계좌이체' AND PAY_PRICE  > 10000 
ORDER BY PAY_TYPE DESC;



SELECT ORDER_NUM,ORDER_CNT,ORDER_USER_ID,	PAY_DATE  FROM order_info A INNER JOIN pay_info B
ON A.PAY_NUM = B.PAY_NUM
WHERE PAY_DATE < '2025-01-20' AND MOD(ORDER_CNT,2) = 1;






# 조인 : 두테이블의 데어를 한번에 조회
# 사번 사원명 급여 부서번호 부서명 조회
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,dept.DEPTNO ,DNAME FROM emp INNER JOIN dept
ON emp.DEPTNO = dept.DEPTNO;













































