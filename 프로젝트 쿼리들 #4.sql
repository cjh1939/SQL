
# 유저 (사용자) 테이블

CREATE TABLE USER(
   USER_EMAIL VARCHAR(50) PRIMARY KEY NOT NULL,
   USER_PASSWORD VARCHAR(100) NOT NULL UNIQUE,
   USER_TEL VARCHAR(50) NOT NULL UNIQUE,
   USER_ROLE VARCHAR(50) NOT NULL DEFAULT 'ROLE_FARMER',
   JOIN_DATE DATETIME NOT NULL DEFAULT SYSDATE(),
   USER_NAME VARCHAR(50) NOT NULL
); 

INSERT INTO USER (USER_EMAIL, USER_PASSWORD, USER_TEL, USER_ROLE, USER_NAME) VALUES
('test1@example.com', 'testpw1', '010-1111-1111', 'ROLE_FARMER', '김테스트'),
('test2@example.com', 'testpw2', '010-2222-2222', 'ROLE_FARMER', '이테스트'),
('test3@example.com', 'testpw3', '010-3333-3333', 'ROLE_FARMER', '박테스트'),
('test4@example.com', 'testpw4', '010-4444-4444', 'ROLE_FARMER', '최테스트'),
('test5@example.com', 'testpw5', '010-5555-5555', 'team4ROLE_FARMER', '정테스트');


SELECT * FROM user;

# 커뮤니티 게시판 
CREATE TABLE PLANT_STORY(
   BOARD_NUM INT PRIMARY KEY AUTO_INCREMENT
   ,TITLE VARCHAR(100) NOT NULL
   ,CONTENT TEXT NOT NULL
   ,READ_CNT INT DEFAULT 0
   ,REG_DATE DATETIME DEFAULT SYSDATE()
   ,USER_EMAIL VARCHAR(50) NOT NULL REFERENCES USER(USER_EMAIL)
   ,REPLY_CNT INT DEFAULT 0
);

SELECT * FROM plant_story;


#커뮤니티 게시판 댓글
CREATE TABLE PLANT_REPLY(
  COMMENT_ID INT AUTO_INCREMENT PRIMARY KEY,
  CONTENT TEXT NOT NULL,
  BOARD_NUM INT NOT NULL REFERENCES plant_story(BOARD_NUM) ON DELETE CASCADE,  -- 게시글 번호 (FK)
  USER_EMAIL VARCHAR(50) NOT NULL REFERENCES USER(USER_EMAIL) ON DELETE CASCADE, -- 작성자 (FK)
  REG_DATE DATETIME DEFAULT SYSDATE()  
);



# 팔로우 테이블
CREATE TABLE FOLLOW (
   FOLLOW_ID INT AUTO_INCREMENT PRIMARY KEY,  -- 고유 식별자
   FROM_USER_EMAIL VARCHAR(50) NOT NULL,      -- 팔로우 하는 사람
   TO_USER_EMAIL VARCHAR(50) NOT NULL,        -- 팔로우 당하는 사람
   FOLLOW_DATE DATETIME DEFAULT SYSDATE(),    -- 팔로우 등록일

   -- 외래 키 설정
   CONSTRAINT FK_FROM_USER FOREIGN KEY (FROM_USER_EMAIL) # 제약조건을  외래키의 이름 
     REFERENCES USER(USER_EMAIL) ON DELETE CASCADE,

   CONSTRAINT FK_TO_USER FOREIGN KEY (TO_USER_EMAIL)# user 테이블의 유저 이메일 을 참조 해서  팔로우 당하는사람 
     REFERENCES USER(USER_EMAIL) ON DELETE CASCADE, # 참조 하는 부모 테이블의 데이터가 삭제될시 같이 삭제 , 회원탈퇴시  자동 삭제 

   -- 중복 팔로우 방지
   UNIQUE (FROM_USER_EMAIL, TO_USER_EMAIL) # 같은사람을 여러번 팔로우 못하게  하는 쿼리 
);


# 공지사항 게시글 테이블
CREATE TABLE board_FARMERS (
    BOARD_NUM INT PRIMARY KEY AUTO_INCREMENT,
    TITLE VARCHAR(50),
    WRITER VARCHAR(20),
    CONTENT VARCHAR(100),
    VIEWS INT DEFAULT 0,
    DATE DATETIME DEFAULT CURRENT_TIMESTAMP
);

# 공지사항 댓글
CREATE TABLE REPLY_FARMERS (
    REPLY_NUM INT PRIMARY KEY AUTO_INCREMENT,
    CONTENT VARCHAR(100) NOT NULL,
    WRITER VARCHAR(30) NOT NULL,
    DATE DATETIME DEFAULT CURRENT_TIMESTAMP,
    BOARD_NUM INT NOT NULL,
    FOREIGN KEY (BOARD_NUM) REFERENCES board_FARMERS(BOARD_NUM) ON DELETE CASCADE
);



#댓글 조회
SELECT * FROM PLANT_STORY ;

#좋아요 조회
SELECT * FROM like_plant;



DELETE FROM LIKE_PLANT;
COMMIT;




# 좋아요 테이블
CREATE TABLE LIKE_PLANT (
	LIKE_NUM INT PRIMARY KEY AUTO_INCREMENT,
	BOARD_NUM INT REFERENCES plant_story (BOARD_NUM) ON DELETE CASCADE,
	USER_EMAIL VARCHAR(50) REFERENCES user (USER_EMAIL) 
);



INSERT INTO LIKE_PLANT VALUES (4, 3, 'test1@example.com');
SELECT * FROM LIKE_PLANT;

SELECT 
	USER_EMAIL, BOARD_NUM,
	TITLE, 
	CONTENT, 
	IFNULL((
	  SELECT 
			'Y'
	  FROM LIKE_PLANT
	  WHERE USER_EMAIL = IFNULL('aa@naver.com', '')
	  AND BOARD_NUM = PS.BOARD_NUM
		), 'N') AS IS_LIKE, 
	(
		SELECT COUNT(LIKE_NUM)
		FROM LIKE_PLANT
		WHERE BOARD_NUM = PS.BOARD_NUM
	) AS LIKE_CNT,
	(
		SELECT COUNT(COMMENT_ID)
		FROM PLANT_REPLY
		WHERE BOARD_NUM = PS.BOARD_NUM
	) AS REPLY_CNT
FROM plant_story PS
ORDER BY REG_DATE DESC;






SELECT COUNT(LIKE_NUM)
FROM LIKE_PLANT
WHERE BOARD_NUM = 2;






COMMIT;

SELECT 
	IFNULL(
		SELECT
			LIKE_NUM
		FROM LIKE_PLANT
		WHERE USER_EMAIL = 'AA'
		AND BOARD_NUM = 1
	, 'N');
	
#	서브쿼리를 괄호로 묶고 SELECT 붙여주기
SELECT 
	IFNULL((
	  SELECT 
			'Y'
	  FROM LIKE_PLANT
	  WHERE USER_EMAIL = 'aa@naver.com'
	  AND BOARD_NUM = 3
), 'N') AS IS_LIKE;


SELECT
	LIKE_NUM
FROM LIKE_PLANT
WHERE USER_EMAIL = 'AA'
AND BOARD_NUM = 1;



#상세페이지  테이블
CREATE TABLE DETAIL (
	BORAD_NUM INT PRIMARY KEY  AUTO_INCREMENT
	,TITLE VARCHAR(20) NOT NULL 
	,CONTENT VARCHAR(50) NOT NULL
	,READ_CNT INT 
	,REG_DATE  DATETIME DEFAULT SYSDATE()
	,USER_EMAIL VARCHAR(50) NOT NULL
);



ALTER TABLE detail ADD COLUMN WRITER VARCHAR(10) NOT NULL;

COMMIT;

SELECT * FROM detail;

#온도 조도테이블 
CREATE TABLE ENVIRONMENT(
   ENV_ID INT PRIMARY KEY AUTO_INCREMENT #날짜별로 얻은 데이터를 구별하기 위해 식별번호 ID를 부여  
   ,TEMPERATURE FLOAT #온도   
   ,ILLUMINANCE INT   #조도 
   ,JOIN_DATE DATETIME DEFAULT SYSDATE()#측정 날짜
	,HUMIDITY FLOAT # 습도
	SOIL_MOISTURE FLOAT # 토양수분
);


# 습도 데이터 추가
ALTER TABLE ENVIRONMENT ADD COLUMN HUMIDITY FLOAT;

#토양 수분 데이터 추가
ALTER TABLE ENVIRONMENT ADD COLUMN SOIL_MOISTURE FLOAT;

COMMIT;

# 작물데이터 초기화 
TRUNCATE TABLE ENVIRONMENT;

SELECT * FROM messages;

ROLLBACK;


# 온도,습도,조도 데이터 ,,,D,,D,DD,D,D,,
SELECT * FROM user;

# 연동데이터 
SELECT * FROM crop_standards;

ALTER TABLE crop_standards
CHANGE COLUMN 작물 CROP VARCHAR(50),
MODIFY COLUMN temp_min FLOAT,
MODIFY COLUMN temp_max FLOAT,JDJDJSKLALSKDJALKS;;A;'SA''A;SLD'SDKKDLLL;;ALSLDKDLKJSDLAKJSDDJSKLADJSKAL;;;;;;;
MODIFY COLUMN humid_min FLOAT,
MODIFY COLUMN humid_max FLOAT,
MODIFY COLUMN soil_min FLOAT,
MODIFY COLUMN soil_max FLOAT,
MODIFY COLUMN lux_min INT,
MODIFY COLUMN lux_max INT,
MODIFY COLUMN adc_min INT,
MODIFY COLUMN adc_max INT;

ALTER TABLE crop_standards
ADD COLUMN IMG_NAME VARCHAR(100);

#영어 이름추가
ALTER TABLE crop_standards
ADD COLUMN ENG_NAME VARCHAR(100);

ALTER TABLE crop_standards ADD COLUMN DESCRIPTION TEXT;


SELECT * FROM crop_standards;


COMMIT;




SELECT
            BOARD_NUM,
            USER_EMAIL,
            TITLE,
            CONTENT,
        IFNULL((
            SELECT 'Y'
            FROM LIKE_PLANT
            WHERE USER_EMAIL = IFNULL('aa@naver.com', '')
        AND BOARD_NUM = PS.BOARD_NUM
        ), 'N') AS IS_LIKE,

        (
            SELECT COUNT(LIKE_NUM)
            FROM LIKE_PLANT
            WHERE BOARD_NUM = PS.BOARD_NUM
        ) AS LIKE_CNT,
        (
        SELECT COUNT(COMMENT_ID)
        FROM PLANT_REPLY
        WHERE BOARD_NUM = PS.BOARD_NUM
        ) AS REPLY_CNT,
        IFNULL((SELECT 'Y'
					FROM follow
					WHERE FROM_USER_EMAIL = 'aa@naver.com'
					AND TO_USER_EMAIL = PS.USER_EMAIL
			), 'N') AS IS_FOLLOW   
        FROM plant_story PS
        ORDER BY REG_DATE DESC;


SELECT * FROM plant_story;

WHERE USER_EMAIL = IFNULL('aa@naver.com', '');

SELECT * FROM follow;

DELETE FROM follow;

SELECT * FROM user;







SELECT * FROM environment;













COMMIT;
