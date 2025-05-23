-- 주석

-- 실행 : 현재 열려있는 쿼리탭의 모든 쿼리를 일괄 실행 
-- 선택 실행: 마우스로 드래그 한 쿼리만 실행
-- 현재쿼리 실행 : 현재 커서가 올라가 있느 쿼리만 실행


-- 데이터 조회 
-- SELECT 컬럼명 FROM 테이블명 WHERE 조건 ; 
-- EMP 테이블의 사원들의 사번을 조회 

 SELECT EMPNO FROM emp;
 
 
 -- EMP 테이블에서 모든 사원의 사번, 사원명, 급여 조회 
 SELECT EMPNO, ENAME,JOB,SAL FROM emp;
 
 -- 별칭 사용. 조회시 조회되는 컬럼명을 변경하여 조회 
 SELECT EMPNO AS 사번, ENAME AS 이름 ,JOB AS 직급 ,SAL 급여  FROM emp;
 
 -- EMP 테이블의 모든 컬럼을 조회 
 
 SELECT * FROM board;
 
 -- SELECT 로 이런 것도 조회할 수 있어요 
 
 SELECT 5 FROM emp;
 SELECT 7, 'JAVA', 3+3 FROM DEPT;
 
 -- 문법 확인용 
 SELECT 'DB', 3+5;
 
 -- SELECT EMPNO ; 오류 컬럼명 조회시 반드시 테이블명을 명시 !
 
 -- 조회에 조건 사용하기 
 -- 크기 비교 : > , <, >= , <= , =, !=, <> 
 -- 급여가 300 이상인 사원들의 사번, 사원명 , 급여를 조회
 SELECT EMPNO , ENAME , SAL FROM emp WHERE SAL >= 300; 
 
 -- 직급이 대리인 사원들의 사번 , 사원명 , 직급 , 입사일을 조회
 SELECT EMPNO , ENAME , JOB, HIREDATE FROM emp WHERE JOB = '대리';
 
 
 -- 동시에 만족 : AND , 둘중하나 만족 : OR 
 -- WHERE 조건 1 OR 조건2
 -- 급여가 400이상이고 , 직급이 '과장' 인 사원들의 모든 컬럼 조회 
 SELECT * FROM EMP 
 WHERE SAL >= 400 AND JOB = '과장';
 
 -- EMP 테이블의 모든 사원들 중에  급여가  400이하이거나  700이상인 사원들의 사번 ,사원명, 급여 
 
 
 
 SELECT EMPNO , ENAME , JOB , SAL FROM emp  WHERE SAL <= 400 OR SAL >=  700;
 
 -- 조건절을  작성할때는 NULL 체크 문법에 주의!
 -- 조건 COMM 이 NULL인 데이터만 조회  IS , IS NOT 
 SELECT EMPNO, ENAME, SAL ,COMM FROM emp
 WHERE COMM IS NOT NULL;
 
 SELECT EMPNO , ENAME , SAL ,COMM  FROM emp ;
 
 SELECT EMPNO ,ENAME NAME, JOB FROM emp WHERE  EMPNO >= 1005 ;
 
 SELECT JOB, ENAME, SAL  FROM emp WHERE  JOB = '대리' AND JOB = '과장';
 
 SELECT * FROM emp WHERE SAL >= 300 AND COMM >= 300;
 
 SELECT  ENAME , SAL ,COMM, JOB  FROM emp WHERE SAL <= 900 AND COMM IS NOT NULL AND (JOB = '대리' OR  JOB = '과장');
 
 
 
 
 
 
 
 
 
 