SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;'
FROM user_tables;

-- 혹시 모르니 테이블 삭제 ----------------------------------------------------------------------------------------
DROP TABLE member CASCADE CONSTRAINTS;
DROP TABLE search CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE productDetail CASCADE CONSTRAINTS;
DROP TABLE productPic CASCADE CONSTRAINTS;
DROP TABLE PicDetail CASCADE CONSTRAINTS;
DROP TABLE category CASCADE CONSTRAINTS;
DROP TABLE chatInfomation CASCADE CONSTRAINTS;
DROP TABLE chatMessage CASCADE CONSTRAINTS;
DROP TABLE chatParticipants CASCADE CONSTRAINTS;
DROP TABLE withdraw CASCADE CONSTRAINTS;
DROP TABLE trade cascade constraints;

-- 회원 관련 테이블 ------------------------------------------------------------------------------------------------
CREATE TABLE member(
    email VARCHAR2(50),
    password VARCHAR2(50) NOT NULL,
    birth NUMBER NOT NULL,
    address VARCHAR2(200) NOT NULL,
    phone CHAR(13) NOT NULL,
    name NVARCHAR2(20) not null,
    nickname NVARCHAR2(20) UNIQUE not null,
    type CHAR(1) DEFAULT 'U' NOT NULL, -- 회원 : U, 관리자 : M
    regdate date DEFAULT sysdate NOT NULL,
    
    CONSTRAINT PK_member_email PRIMARY KEY(email)
);

CREATE TABLE withdraw(
    email VARCHAR2(50) CONSTRAINT withdraw_pk_email PRIMARY KEY,
    wd_date DATE NOT NULL
);


-- 검색어 테이블 -------------------------------------------------------------------------------------------------
CREATE TABLE search(
    idx number,
    search NVARCHAR2(20) NOT NULL,
    email VARCHAR2(50) NOT NULL, 
    regdate date DEFAULT sysdate NOT NULL,
    
    CONSTRAINT PK_search_idx PRIMARY KEY(idx)
);


-- 상품 관련 테이블 ----------------------------------------------------------------------------------------------
CREATE TABLE product(
    idx number,
    email varchar2(50) NOT NULL,
    p_id varchar2(10) NOT NULL,
    CONSTRAINT  product_pk_f_idx PRIMARY KEY(idx)
);

CREATE TABLE productDetail(
    p_id varchar2(10),
    p_name nvarchar2(150) NOT NULL,
    description nclob NOT NULL,
    category nvarchar2(20) NOT NULL,
    regdate date NOT NULL,
    views number DEFAULT 0 NOT NULL,
    price number NOT NULL,
    CONSTRAINT  productDetail_pk_p_id PRIMARY KEY(p_id)
);

CREATE TABLE productPic(
    idx number,
    p_id varchar2(10) NOT NULL,
    f_id varchar2(10) NOT NULL,
    CONSTRAINT  productPic_pk_idx PRIMARY KEY(idx)
);

CREATE TABLE PicDetail(
    f_id varchar2(10),
    f_type varchar2(50) NOT NULL,
    f_origin_name nvarchar2(250) NOT NULL,
    f_proxy_name nvarchar2(250) NOT NULL,
    CONSTRAINT  PicDetail_pk_f_id PRIMARY KEY(f_id)
);

create table trade(
    t_id varchar2(20) CONSTRAINT trade_pk_t_id PRIMARY KEY,
    p_id varchar2(10),
    email varchar2(50)
);

CREATE TABLE category(
    category NVARCHAR2(20) CONSTRAINT category_pk_category PRIMARY KEY
);

INSERT INTO category VALUES('인기매물');
INSERT INTO category VALUES('디지털 기기');
INSERT INTO category VALUES('생활가전');
INSERT INTO category VALUES('생활주방');
INSERT INTO category VALUES('유아동');
INSERT INTO category VALUES('의류');
INSERT INTO category VALUES('잡화');
INSERT INTO category VALUES('뷰티•미용');
INSERT INTO category VALUES('취미•게임•음반');
INSERT INTO category VALUES('도서');
INSERT INTO category VALUES('중고차');
INSERT INTO category VALUES('가공식품');
INSERT INTO category VALUES('반려동물 물품');
INSERT INTO category VALUES('기타 중고물품');


-- 채팅 관련 테이블 ------------------------------------------------------------------------------------------------
CREATE TABLE chatInfomation(
    c_id VARCHAR2(50) CONSTRAINT chatInfomation_pk_c_id PRIMARY KEY,
    p_id VARCHAR2(10)
);

CREATE TABLE chatMessage(
    idx NUMBER CONSTRAINT chatMessage_pk_idx PRIMARY KEY,
    c_id VARCHAR2(50),
    message NCLOB NOT NULL,
    read char(1) NOT NULL, -- 읽음 : 0, 안 읽음 : 1
    send_date DATE NOT NULL
);

CREATE TABLE chatParticipants(
    idx NUMBER CONSTRAINT chatParticipants_pk_idx PRIMARY KEY,
    c_id VARCHAR2(50),
    sender_email VARCHAR2(50),
    join_date date NOT NULL
);

-- FORING KEY 작성-----------------------------------------------------------------------------------------------

-- 검색어 fk 추가
ALTER TABLE search ADD CONSTRAINT fk_search_email FOREIGN KEY(email) REFERENCES member(email);

-- 상품 fk 추가
ALTER TABLE product
ADD CONSTRAINT product_fk_email FOREIGN KEY(email) REFERENCES member(email);
ALTER TABLE product
ADD CONSTRAINT product_fk_p_id FOREIGN KEY(p_id) REFERENCES productDetail(p_id);

-- 상품 상세보기 fk 추가
ALTER TABLE productDetail
ADD CONSTRAINT productDetail_fk_category FOREIGN KEY(category) REFERENCES category(category);

-- 상품 사진 fk 추가
ALTER TABLE productPic
ADD CONSTRAINT productPic_fk_p_id FOREIGN KEY(p_id) REFERENCES productDetail(p_id);
ALTER TABLE productPic
ADD CONSTRAINT productPic_fk_f_id FOREIGN KEY(f_id) REFERENCES picDetail(f_id);

-- 채팅방 fk 추가
ALTER TABLE chatInfomation
ADD CONSTRAINT chatInfomation_fk_p_id FOREIGN KEY(p_id) REFERENCES productDetail(p_id);

-- 채팅 메세지 fk 추가
ALTER TABLE chatMessage
ADD CONSTRAINT chatMessage_fk_c_id FOREIGN KEY(c_id) REFERENCES chatInfomation(c_id);

-- 채팅 인원 fk 추가
ALTER TABLE chatParticipants
ADD CONSTRAINT chatParticipants_fk_c_id FOREIGN KEY(c_id) REFERENCES chatInfomation(c_id)
ADD CONSTRAINT chatPartic_fk_sender_email FOREIGN KEY(sender_email) REFERENCES member(email);

-- 상품 거래 fk 추가
ALTER TABLE trade
ADD CONSTRAINT trade_fk_p_id FOREIGN KEY(p_id) REFERENCES productDetail(p_id)
ADD CONSTRAINT trade_fk_email FOREIGN KEY(email) REFERENCES member(email);


-- 프로시저 ---------------------------------------------------------------------------------------------------

CREATE OR REPLACE PROCEDURE member_sampleDate
IS
    maxinput number:=1200;
    yearNum number(2);
    monthNum number(2);
    dayNum number(2);
BEGIN
    FOR idx  IN 1..maxinput LOOP
        yearNum:=ROUND(DBMS_RANDOM.VALUE(19, 22));
        monthNum:=ROUND(DBMS_RANDOM.VALUE(1, 12));
        dayNum:=ROUND(DBMS_RANDOM.VALUE(1, 28));
        
        INSERT INTO member
        VALUES('mail'||idx||'@naver.com', '1234', 19990101, '주소'||idx, '010'||LPAD(to_char(idx),8, '0'), '이름'||idx,'회원'||idx, 'U',
            TO_DATE('20'||yearNum||LPAD(to_char(monthNum),2, '0')||LPAD(to_char(dayNum),2, '0'), 'YYYY/MM/DD'));
    END LOOP;
END;

CREATE OR REPLACE PROCEDURE withdraw_sampleDate
IS
    maxinput number:=200;
    yearNum number(2);
    monthNum number(2);
    dayNum number(2);
BEGIN
    FOR idx  IN 1..maxinput LOOP
        yearNum:=ROUND(DBMS_RANDOM.VALUE(20, 22));
        monthNum:=ROUND(DBMS_RANDOM.VALUE(1, 12));
        dayNum:=ROUND(DBMS_RANDOM.VALUE(1, 28));
        
        INSERT INTO withdraw
        VALUES('email'||idx||'@naver.com',
            TO_DATE('20'||yearNum||LPAD(to_char(monthNum),2, '0')||LPAD(to_char(dayNum),2, '0'), 'YYYY/MM/DD'));
    END LOOP;
END;

EXECUTE member_sampleDate;
EXECUTE withdraw_sampleDate;


-- 샘플 데이터 ---------------------------------------------------------------------------------------------------

-- 상품 상세
INSERT INTO productDetail
VALUES('pid1','컴퓨터','최신형 컴퓨터입니다','디지털 기기','2022/05/30',0,1000000);
INSERT INTO productDetail
VALUES('pid2','K5','상태 좋습니다','중고차','2022/11/13',1,30000000);
INSERT INTO productDetail
VALUES('pid3','지갑','상태 굿','잡화','2022/09/20',60,500000);
INSERT INTO productDetail
VALUES('pid4','츄르','츄르 2박스 입니다','반려동물 물품','2022/11/03',0,15000);
INSERT INTO productDetail
VALUES('pid5','에어팟 맥스','에어팟 맥스 미개봉 상품입니다','디지털 기기','2022/12/25',115,600000);

-- 회원 상세
INSERT INTO member(email, password,birth, address, phone,name,nickname)
VALUES('hong@naver.com','1234',19990305,'경기도안산시','0103455555','홍길동','길동이1');
INSERT INTO member(email, password,birth, address, phone,name,nickname)
VALUES('lee@naver.com','1234',19970205,'경기도오산시','0103455556','이길동','길동이2');
INSERT INTO member(email, password,birth, address, phone,name,nickname)
VALUES('pack@naver.com','1234',19990105,'경기도안산시','0103455557','박길동','길동이3');
INSERT INTO member(email, password,birth, address, phone,name,nickname)
VALUES('jeong@naver.com','1234',19890506,'경기도안산시','0103455558','정길동','길동이4');
INSERT INTO member(email, password,birth, address, phone,name,nickname)
VALUES('choi@naver.com','1234',19900312,'경기도안산시','0103455559','최길동','길동이5');

-- 검색어
insert into search(idx, search, email)
VALUES(1,'ddd','hong@naver.com');
insert into search(idx, search, email)
VALUES(2,'dddd','lee@naver.com');
insert into search(idx, search, email)
VALUES(3,'ddddd','jeong@naver.com');

-- 상품
insert into product
values(1, 'hong@naver.com', 'pid1');
insert into product
values(2, 'lee@naver.com', 'pid2');
insert into product
values(3, 'pack@naver.com', 'pid3');
insert into product
values(4, 'jeong@naver.com', 'pid4');
insert into product
values(5, 'choi@naver.com', 'pid5');

-- 거래
insert into trade
values('tid1', 'pid1', 'choi@naver.com');
insert into trade
values('tid2', 'pid2', 'choi@naver.com');
insert into trade
values('tid3', 'pid3', 'jeong@naver.com');
insert into trade
values('tid4', 'pid4', 'pack@naver.com');
insert into trade
values('tid5', 'pid5', 'hong@naver.com');


-- 테이블 확인 ---------------------------------------------------------------------------------------------------

commit;

SELECT * FROM SEARCH;
SELECT * FROM MEMBER;

SELECT * FROM PRODUCT;
SELECT * FROM PRODUCTDETAIL;
SELECT * FROM PRODUCTPIC;
SELECT * FROM PICDETAIL;
SELECT * FROM CATEGORY;
SELECT * FROM TRADE;

SELECT * FROM CHATINFOMATION;
SELECT * FROM CHATMESSAGE;
SELECT * FROM CHATPARTICIPANTS;

SELECT * FROM WITHDRAW;


----------------------------------------------------------------------------------------------------------------

INSERT INTO chatInfomation
VALUES('chat1', 'pid1');
INSERT INTO chatParticipants
VALUES(1, 'chat1', 'choi@naver.com', '2020/11/12');


SELECT * FROM WITHDRAW
where wd_date like '%02/%';

SELECT SUBSTR(wd_date, 1,4) FROM WITHDRAW;
SELECT SUBSTR(wd_date, 6,2) FROM WITHDRAW;
SELECT SUBSTR(wd_date, 9,2) FROM WITHDRAW;

SELECT SUBSTR(wd_date, 1, 4) AS "year", count(*) FROM WITHDRAW
group by SUBSTR(wd_date, 1, 4);

SELECT SUBSTR(wd_date, 6, 2) as "month", count(*) FROM WITHDRAW
group by SUBSTR(wd_date, 6, 2);

SELECT SUBSTR(wd_date, 1, 4) as "year", SUBSTR(wd_date, 6, 2) as "month", count(*) FROM WITHDRAW
where SUBSTR(wd_date, 1, 4)=2020
group by SUBSTR(wd_date, 1, 4),SUBSTR(wd_date, 6, 2)
order by "year" asc, "month" desc;

SELECT SUBSTR(regdate, 1, 4) as "year", SUBSTR(regdate, 6, 2) as "month", count(*) FROM member
where SUBSTR(regdate, 1, 4)=2020
group by SUBSTR(regdate, 1, 4),SUBSTR(regdate, 6, 2)
order by "year" desc, "month" asc;

SELECT
    SUBSTR(regdate, 1, 4) as "year",
    SUBSTR(regdate, 6, 2) as "month",
    count(*)-(select count(*)
                from withdraw
                where SUBSTR(wd_date, 1, 4)="year" and SUBSTR(wd_date, 6, 2)="month"
group by SUBSTR(regdate, 1, 4),SUBSTR(regdate, 6, 2)
order by "year" desc;

SELECT SUBSTR(wd_date, 1, 4) as "year", SUBSTR(wd_date, 6, 2) as "month", count(*)
FROM WITHDRAW
where SUBSTR(wd_date, 1, 4)=2020
group by SUBSTR(wd_date, 1, 4),SUBSTR(wd_date, 6, 2)
order by "year" desc;

SELECT SUBSTR(wd_date, 1, 4) AS "year", SUBSTR(wd_date, 6, 2) AS "month", count(*) AS "cnt"
		FROM WITHDRAW
		group by SUBSTR(wd_date, 1, 4), SUBSTR(wd_date, 6, 2)
		order by "year" asc, "month" asc;
        
SELECT TO_CHAR(wd_date,'YYYY') AS "year", TO_CHAR(wd_date,'MM') AS "month", count(*) AS "cnt"
FROM WITHDRAW
group by TO_CHAR(wd_date,'YYYY'), TO_CHAR(wd_date,'MM')
order by "year" asc, "month" asc;
