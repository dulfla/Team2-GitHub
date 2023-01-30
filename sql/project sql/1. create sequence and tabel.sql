
-- DROP TABLE;
DROP TABLE member CASCADE CONSTRAINTS;
DROP TABLE search CASCADE CONSTRAINTS;
DROP TABLE product CASCADE CONSTRAINTS;
DROP TABLE productDetail CASCADE CONSTRAINTS;
DROP TABLE productPic CASCADE CONSTRAINTS;
DROP TABLE category CASCADE CONSTRAINTS;
DROP TABLE chatInfomation CASCADE CONSTRAINTS;
DROP TABLE chatMessage CASCADE CONSTRAINTS;
DROP TABLE chatParticipants CASCADE CONSTRAINTS;
DROP TABLE memberHistory CASCADE CONSTRAINTS;
DROP TABLE productHistory CASCADE CONSTRAINTS;

-- DROP SEQUENCE ;
DROP SEQUENCE search_seq;
DROP SEQUENCE memberTracking_seq;
DROP SEQUENCE pid_seq;
DROP SEQUENCE product_seq;
DROP SEQUENCE picture_seq;
DROP SEQUENCE sampleMessage_seq;
DROP SEQUENCE chatMessage_seq;
DROP SEQUENCE productTracking_seq;
DROP SEQUENCE chatInfomation_seq;
DROP SEQUENCE chatParticipants_seq;

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

-- SEQUENCE
CREATE SEQUENCE search_seq START WITH 1 NOCYCLE NOCACHE; -- search(idx)
CREATE SEQUENCE memberTracking_seq START WITH 1 NOCYCLE NOCACHE; -- memberHistory(idx)
CREATE SEQUENCE pid_seq START WITH 1 NOCYCLE NOCACHE; -- productDetail(p_id)
CREATE SEQUENCE product_seq START WITH 1 NOCYCLE NOCACHE; -- product(idx)
CREATE SEQUENCE picture_seq START WITH 1 NOCYCLE NOCACHE; -- productPic(idx)
CREATE SEQUENCE productTracking_seq START WITH 1 NOCYCLE NOCACHE; -- productHistory(idx)
CREATE SEQUENCE chatInfomation_seq START WITH 1 NOCACHE NOCYCLE; -- chatInfomation(c_id)
CREATE SEQUENCE chatParticipants_seq START WITH 1 NOCACHE NOCYCLE; -- chatParticipants(idx)
CREATE SEQUENCE sampleMessage_seq START WITH 1 NOCACHE NOCYCLE; -- chatMessage(message)
CREATE SEQUENCE chatMessage_seq START WITH 1 NOCACHE NOCYCLE; -- chatMessage(idx)


-- 회원 관련 테이블 ------------------------------------------------------------------------------------------------------
CREATE TABLE member(
    email VARCHAR2(50),
    password VARCHAR2(50), --  NOT NULL
    birth NUMBER, --  NOT NULL
    address VARCHAR2(200), --  NOT NULL
    phone CHAR(13), --  NOT NULL
    name NVARCHAR2(20) NOT NULL,
    nickname NVARCHAR2(20) UNIQUE NOT NULL,
    type CHAR(1) DEFAULT 'U' NOT NULL, -- 회원 : U, 관리자 : M
    regdate date DEFAULT sysdate NOT NULL,
    
    CONSTRAINT PK_member_email PRIMARY KEY(email)
);

CREATE TABLE memberHistory(
    idx NUMBER CONSTRAINT memberHistory_pk_idx PRIMARY KEY,
    email VARCHAR2(50) NOT NULL,
    trakingDate DATE NOT NULL,
    type char(5) NOT NULL
);


-- 검색어 테이블 --------------------------------------------------------------------------------------------------------
CREATE TABLE search(
    idx number,
    keyword NVARCHAR2(20) NOT NULL,
    email VARCHAR2(50), -- 회원이 아닌 사람도 검색 가능
    regdate date DEFAULT sysdate NOT NULL,
    
    CONSTRAINT PK_search_idx PRIMARY KEY(idx)
);


-- 상품 관련 테이블 -----------------------------------------------------------------------------------------------------
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
    trade varchar2(5) DEFAULT 'TRADE' NOT NULL, -- 거래 중 : TRADE, 거래 완료 : CLEAR
    lat varchar2(100),  --위도
    lng varchar2(100),  --경도
    CONSTRAINT  productDetail_pk_p_id PRIMARY KEY(p_id)
);

CREATE TABLE productPic(
    p_id varchar2(10),
    fileName nvarchar2(250) NOT NULL,
    uploadPath varchar2(250) NOT NULL,
    uuid nvarchar2(250),
    CONSTRAINT  productPic_pk_uuid PRIMARY KEY(uuid)
);

CREATE TABLE category(
    category NVARCHAR2(20) CONSTRAINT category_pk_category PRIMARY KEY,
    icon NVARCHAR2(150) NOT NULL
);

CREATE TABLE productHistory(
    idx number CONSTRAINT productHistory_pk_idx PRIMARY key,
    p_id varchar2(10),
    category nvarchar2(20),
    trackDate date not null,
    type varchar2(5)
);


-- 채팅 관련 테이블 ------------------------------------------------------------------------------------------------------
CREATE TABLE chatInfomation(
    c_id VARCHAR2(50) CONSTRAINT chatInfomation_pk_c_id PRIMARY KEY,
    p_id VARCHAR2(10)
);

CREATE TABLE chatMessage(
    idx NUMBER CONSTRAINT chatMessage_pk_idx PRIMARY KEY,
    c_id VARCHAR2(50),
    message NCLOB NOT NULL,
    messType varchar(10), -- 메세지 타입 구분(text, img)
    sender VARCHAR2(50), --  보낸사람이 누군지
    read char(1) NOT NULL, -- 읽음 : 0, 안 읽음 : 1
    send_date DATE NOT NULL
);

CREATE TABLE chatParticipants(
    idx NUMBER CONSTRAINT chatParticipants_pk_idx PRIMARY KEY,
    c_id VARCHAR2(50),
    sender_email VARCHAR2(50),
    join_date date NOT NULL
);

-- FORING KEY 작성------------------------------------------------------------------------------------------------------

-- 상품 fk 추가
ALTER TABLE product
ADD CONSTRAINT product_fk_email FOREIGN KEY(email) REFERENCES member(email) ON DELETE CASCADE;
ALTER TABLE product
ADD CONSTRAINT product_fk_p_id FOREIGN KEY(p_id) REFERENCES productDetail(p_id) ON DELETE CASCADE;

-- 상품 상세보기 fk 추가
ALTER TABLE productDetail
ADD CONSTRAINT productDetail_fk_category FOREIGN KEY(category) REFERENCES category(category) ON DELETE CASCADE;

-- 상품 사진 fk 추가
ALTER TABLE productPic
ADD CONSTRAINT productPic_fk_p_id FOREIGN KEY(p_id) REFERENCES productDetail(p_id);

-- 채팅방 fk 추가
ALTER TABLE chatInfomation
ADD CONSTRAINT chatInfomation_fk_p_id FOREIGN KEY(p_id) REFERENCES productDetail(p_id) ON DELETE CASCADE;

-- 채팅 메세지 fk 추가
ALTER TABLE chatMessage
ADD CONSTRAINT chatMessage_fk_c_id FOREIGN KEY(c_id) REFERENCES chatInfomation(c_id) ON DELETE CASCADE;

-- 채팅 인원 fk 추가
ALTER TABLE chatParticipants
ADD CONSTRAINT chatParticipants_fk_c_id FOREIGN KEY(c_id) REFERENCES chatInfomation(c_id) ON DELETE CASCADE
ADD CONSTRAINT chatPartic_fk_sender_email FOREIGN KEY(sender_email) REFERENCES member(email) ON DELETE CASCADE;

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

ROLLBACK;
COMMIT;

SELECT * FROM SEARCH;
SELECT * FROM MEMBER;

SELECT * FROM PRODUCT;
SELECT * FROM PRODUCTDETAIL;
SELECT * FROM PRODUCTPIC;
SELECT * FROM CATEGORY;

SELECT * FROM CHATINFOMATION;
SELECT * FROM CHATMESSAGE;
SELECT * FROM CHATPARTICIPANTS;

SELECT * FROM memberHistory;
SELECT * FROM productHistory;