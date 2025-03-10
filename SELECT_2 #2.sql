
-- emp 테이블에서 급여가 300이상이면서 700이하인 사원들의 
-- 사번 , 사원명, 급여 를 조회 쿼리 작성 

SELECT EMPNO,ENAME,SAL FROM emp WHERE SAL >= 300 AND SAL <= 700;

-- 위와 같이 특정범위 를 조건으로 작성할 때는 BETWEEN 연산자를 사용 
-- WHERE 컬럼 A BERWEEN B

SELECT EMPNO , ENAME ,SAL FROM emp WHERE SAL BETWEEN 300 AND 700;

-- EMP 테이블에 저장된 직원 정보 중 
-- 사번이 1003번에서 1007 사이이고 , COMM 커미션은 NULL 이 아닌 직원들의 
-- 사번 사원명 급여 커미션 조회 

SELECT EMPNO, ENAME, SAL,COMM FROM emp WHERE EMPNO BETWEEN 1003 AND 1007 AND COMM IS NOT NULL ;

-- EMP 테이블에 저장된 직원정보 중에서 급여가 300,400,500인 사원들의 모든정보 조회 
SELECT * FROM emp WHERE SAL BETWEEN 300 OR 400 OR 500;

--위의 쿼리문은 아래처럼 IN 연산자를 사용하여 작성할수도 있다.
-- IN 연산자 : WHERE 컬럼 IN (값1 , 값2 , 값3 ......);
SELECT * FROM emp WHERE SAL IN (300,400,500);

-- EMP 테이블에 저장된 직원 정보 중 
-- 사번이 1003, 1005,1007 번인 사원들의 
-- 사번,사원명 ,입사일 조회 
SELECT EMPNO,ENAME,HIREDATE FROM emp WHERE EMPNO IN (1003,1005,1007);

-- 조회 데이터 정렬하기 
-- 정렬 문법 : ORDER BY 정렬기준컬럼 정렬방법 (오름차순,내림차순);
-- 오름차순 : ASC ,생략   \  내림차순 : DESC 
-- 정렬을 위한 ORDER BY 는  무조건 조호 쿼리문의 가장 마지막에 작성. 

-- 급여기준 오름차순 정렬 조회 

SELECT * FROM emp ORDER BY SAL ASC;

-- 내림차순 
SELECT * FROM emp ORDER BY SAL DESC;


-- 사원명 기준 오름차순으로 정렬 조회
SELECT * FROM emp ORDER BY ENAME;


-- EMP 테이블에 저장된 직원 정보 중에서 
-- 부서번호가 10번이 아닌 직원들의 
-- 사번, 사원명, 부서번호 를 조회하되 
-- 부서번호 기준 오름차순 정렬 후 사번기준 내림차순 정렬

SELECT EMPNO, ENAME , DEPTNO FROM emp WHERE DEPTNO != 10  ORDER BY DEPTNO ASC , EMPNO DESC;


-- EMP 테이블에서 직급이 사원, 과장,부장 인 사원들의 
-- 사원명, 직급, 급여 조회 &&  직급 기준 내림차순 정렬 , 급여기준 오름차순 정렬 

SELECT ENAME, JOB, SAL FROM emp WHERE JOB IN ('사원 ','부장','과장') ORDER BY JOB DESC ,  SAL;

-- 사원명에 '이 '라는 글자가 포함된 사원들의 모든 컬럼 조회 
-- 이렇게 컬럼에 특정한 값이 포함된 데이터를 조회할 때는
-- LIKE 연산잔와 와일드카드를 사용  
-- 와일드카드는 '%' , '_' 두개가 존재.
-- % : 0개 이상의 어떤글자.
-- '_' : 1개의 어떤 글자 
-- '김_' : 김으로 시작하는 두글자를 찿는다 (김 X , 김1, 김나 , 김자바 X)
-- '_나 __' : 두번째 글자가 나 인 네글자 
-- '박%' : 박으로 시작하는 모든글자 (박 o )
-- '_이%' : 두번째글자 '이 ' 인 모든글자  

SELECT * FROM emp WHERE ENAME LIKE '%이%';


-- 조회 데이터에서 중복 제거하기 
-- 조회시 컬러명 앞에 DISTINCT 키워드를 작성하면 중복 데이터 제거 

SELECT DISTINCT JOB FROM emp

-- DISTINCT 키워드를 사용하면 모든 컬럼에서 중복 제거 
-- 중복 : 조회디는 모든 컬럼의 값이 같을 경우 중복으로판단 
SELECT DISTINCT JOB, DEPTNO FROM emp  WHERE JOB = '과장';



SELECT ENAME, SAL , COMM FROM emp WHERE SAL BETWEEN 350 AND 650 AND COMM IS NOT NULL;

SELECT EMPNO, ENAME JOB FROM emp WHERE JOB IN ('과장', '차장','부장') ORDER BY JOB;

SELECT EMPNO, ENAME , DEPTNO, SAL FROM emp WHERE   DEPTNO IN (10,20) AND ENAME LIKE '%이%' ORDER BY DEPTNO DESC, SAL; 
  
SELECT * FROM emp WHERE ENAME LIKE '%기' AND COMM IS NULL AND SAL BETWEEN 400 AND 800;

3개















