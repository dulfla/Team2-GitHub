SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;'
FROM user_tables;

-- 혹시 모르니 삭제 ------------------------------------------------------------------------------------------------
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
-- DROP SEQUENCE ;
DROP SEQUENCE memberTracking_seq;
DROP SEQUENCE pid_seq;
DROP SEQUENCE product_seq;
DROP SEQUENCE picture_seq;
DROP SEQUENCE sampleMessage_seq;
DROP SEQUENCE chatMessage_seq;
DROP SEQUENCE productTracking_seq;
DROP SEQUENCE chatInfomation_seq;
DROP SEQUENCE chatParticipants_seq;

-- 시퀀스
-- CREATE SEQUENCE ; -- member(micname) - 샘플데이터 5개
-- CREATE SEQUENCE ; -- search(idx) - 샘플데이터 3개
CREATE SEQUENCE memberTracking_seq START WITH 1 NOCYCLE NOCACHE; -- memberHistory(idx)
CREATE SEQUENCE pid_seq START WITH 6 NOCYCLE NOCACHE; -- productDetail(p_id) - 샘플데이터 5개
CREATE SEQUENCE product_seq START WITH 6 NOCYCLE NOCACHE; -- product(idx) - 샘플데이터 5개
CREATE SEQUENCE picture_seq START WITH 1 NOCYCLE NOCACHE; -- productPic(idx)
CREATE SEQUENCE productTracking_seq START WITH 1 NOCYCLE NOCACHE; -- productHistory(idx)
CREATE SEQUENCE chatInfomation_seq START WITH 4 NOCACHE NOCYCLE; -- chatInfomation(c_id) - 샘플데이터 3개
CREATE SEQUENCE chatParticipants_seq START WITH 4 NOCACHE NOCYCLE; -- chatParticipants(idx) - 샘플데이터 3개
CREATE SEQUENCE sampleMessage_seq START WITH 1 NOCACHE NOCYCLE; -- chatMessage(message)
CREATE SEQUENCE chatMessage_seq START WITH 1 NOCACHE NOCYCLE; -- chatMessage(idx)


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

CREATE TABLE memberHistory(
    idx NUMBER CONSTRAINT memberHistory_pk_idx PRIMARY KEY,
    email VARCHAR2(50) NOT NULL,
    trakingDate DATE NOT NULL,
    type char(5) NOT NULL
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
    trade varchar2(5) DEFAULT 'TRADE' NOT NULL, -- 거래 중 : TRADE, 거래 완료 : CLEAR
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
    category NVARCHAR2(20) CONSTRAINT category_pk_category PRIMARY KEY
);

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

CREATE TABLE productHistory(
    idx number CONSTRAINT productHistory_pk_idx PRIMARY key,
    p_id varchar2(10),
    category nvarchar2(20),
    trackDate date not null,
    type varchar2(5)
);


-- 채팅 관련 테이블 ------------------------------------------------------------------------------------------------
CREATE TABLE chatInfomation(
    c_id VARCHAR2(50) CONSTRAINT chatInfomation_pk_c_id PRIMARY KEY,
    p_id VARCHAR2(10)
);

CREATE TABLE chatMessage(
    idx NUMBER CONSTRAINT chatMessage_pk_idx PRIMARY KEY,
    c_id VARCHAR2(50),
    message NCLOB NOT NULL,
    messType varchar(10), -- 메세지 타입 구분(text, jpg, mp4, mp3..)
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

-- FORING KEY 작성-----------------------------------------------------------------------------------------------

-- 검색어 fk 추가
ALTER TABLE search
ADD CONSTRAINT fk_search_email FOREIGN KEY(email) REFERENCES member(email) ON DELETE CASCADE;

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


-- 트리거 ---------------------------------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER memberAdmin
BEFORE INSERT OR DELETE
    ON member
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO memberHistory
        VALUES(memberTracking_seq.NEXTVAL, :NEW.email,:NEW.regdate, 'IN'); -- sysdate 여야 함
    ELSIF DELETING THEN
        INSERT INTO memberHistory
        VALUES(memberTracking_seq.NEXTVAL, :OLD.email,:OLD.regdate, 'OUT'); -- sysdate 여야 함
    END IF;
END memberAdmin;

CREATE OR REPLACE TRIGGER trackingProduct
BEFORE INSERT OR UPDATE OR DELETE
    ON productDetail
FOR EACH ROW
BEGIN
    IF inserting THEN
        INSERT INTO productHistory
        VALUES(productTracking_seq.NEXTVAL, :NEW.p_id, :NEW.category, :NEW.regdate, 'IN');
    ELSIF updating THEN
        IF :NEW.category<>:OLD.category THEN
            UPDATE productHistory
            SET category = :NEW.category
            WHERE p_id=:OLD.p_id;
        END IF;
    ELSIF deleting THEN
        INSERT INTO productHistory
        VALUES(productTracking_seq.NEXTVAL, :OLD.p_id, :OLD.category, :OLD.regdate, 'OUT'); -- sysdate 여야 함
    END IF;
END;

CREATE OR REPLACE TRIGGER trackingProductTrade
BEFORE UPDATE ON productDetail
FOR EACH ROW
BEGIN
    IF updating THEN
        IF :NEW.trade<>'TRADE' OR :NEW.trade<>'trade' THEN
            INSERT INTO productHistory
            VALUES(productTracking_seq.NEXTVAL, :OLD.p_id, :NEW.category, :OLD.regdate, 'TRADE'); -- sysdate 여야 함
        END IF;
    END IF;
END;


-- 샘플 데이터 ---------------------------------------------------------------------------------------------------

-- 상품 상세
INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid1','컴퓨터','최신형 컴퓨터입니다','디지털 기기','2022/05/30',0,1000000);
INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid2','K5','상태 좋습니다','중고차','2022/11/13',1,30000000);
INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid3','지갑','상태 굿','잡화','2022/09/20',60,500000);
INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid4','츄르','츄르 2박스 입니다','반려동물 물품','2022/11/03',0,15000);
INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
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

INSERT INTO member(email, password,birth, address, phone,name,nickname,type)
VALUES('dulfla@naver.com','1234',19970205,'경기도오산시','0103455556','김예림','여ㅣ림','M');
INSERT INTO member(email, password,birth, address, phone,name,nickname,type)
VALUES('gudrhks@naver.com','1234',19990105,'경기도안산시','0103455557','김형관','형관','M');
INSERT INTO member(email, password,birth, address, phone,name,nickname,type)
VALUES('tjdgur@naver.com','1234',19890506,'경기도안산시','0103455558','윤성혁','성혁','M');
INSERT INTO member(email, password,birth, address, phone,name,nickname,type)
VALUES('dlsrb@naver.com','1234',19900312,'경기도안산시','0103455559','한인규','인규','M');

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

-- 채팅
INSERT INTO chatInfomation
VALUES('chat1', 'pid1');
INSERT INTO chatInfomation
VALUES('chat2', 'pid3');
INSERT INTO chatInfomation
VALUES('chat3', 'pid2');

INSERT INTO chatParticipants
VALUES(1, 'chat1', 'choi@naver.com', '2020/11/12');
INSERT INTO chatParticipants
VALUES(2, 'chat2', 'hong@naver.com', '2020/11/12');
INSERT INTO chatParticipants
VALUES(3, 'chat3', 'hong@naver.com', '2021/11/12');


-- 프로시저 ---------------------------------------------------------------------------------------------------

-- 채팅방 정보와 채팅 참여자 정보를 읽어와서 해당 채팅방에 샘플 메세지를 데이터 넣을 프로시저
CREATE OR REPLACE PROCEDURE chattingMessageSample
IS
    csor_c_id chatParticipants.c_id%TYPE;
    csor_sender_email chatParticipants.sender_email%TYPE;
    timeset DATE;
    CURSOR chattingRoomMember
    IS
        SELECT c_id, email AS "sender_email" FROM chatInfomation c, product p WHERE c.p_id=p.p_id
        UNION
        SELECT c_id, sender_email FROM chatParticipants;
BEGIN
    OPEN chattingRoomMember;
    LOOP
        FETCH chattingRoomMember INTO csor_c_id, csor_sender_email;
        EXIT WHEN chattingRoomMember%NOTFOUND;
        FOR  idx IN 1..15 LOOP
            timeset := TO_DATE('2022121017'||TO_CHAR(idx, '00')||TO_CHAR(ROUND(DBMS_RANDOM.VALUE(0, 59)), '00'), 'YYYYMMDDHH24MISS');
            INSERT INTO chatMessage
            VALUES(chatMessage_seq.NEXTVAL, csor_c_id, 'messageSample'||sampleMessage_seq.NEXTVAL, 'TEXT', csor_sender_email, 0, timeset);
        END LOOP;
    END LOOP;
    CLOSE chattingRoomMember;
END;

-- 채팅방이 없는 경우 채팅방을 새롭게 만들어주는 프로시저 :: 여기서 실행 안 함
CREATE OR REPLACE PROCEDURE newChattingRoom(
    p_id IN chatInfomation.p_id%TYPE,
    email IN chatParticipants.sender_email%TYPE,
    c_id OUT chatInfomation.c_id%TYPE)
IS
    chatR chatInfomation.c_id%TYPE:= 'chat'||chatInfomation_seq.NEXTVAL;
BEGIN
    INSERT INTO chatInfomation VALUES(chatR, p_id);
    INSERT INTO chatParticipants VALUES(chatParticipants_seq.NEXTVAL, chatR, email, sysdate);
    c_id := chatR;
END;

-- 회원 샘플 데이터를 넣어주는 프로시저
CREATE OR REPLACE PROCEDURE member_sampleDate
IS
    maxinput NUMBER:=5000;
    yearNum NUMBER(2);
    monthNum NUMBER(2);
    dayNum NUMBER(2);
    dayDate DATE;
BEGIN
    FOR idx  IN 1..maxinput LOOP
        yearNum:=ROUND(DBMS_RANDOM.VALUE(19, 22));
        monthNum:=ROUND(DBMS_RANDOM.VALUE(1, 12));
        dayNum:=ROUND(DBMS_RANDOM.VALUE(1, 28));
        dayDate:=TO_DATE('20'||yearNum||LPAD(to_char(monthNum),2, '0')||LPAD(to_char(dayNum),2, '0'), 'YYYY/MM/DD');
        
        INSERT INTO member
        VALUES('mail'||idx||'@naver.com',
               '1234', 19990101, '주소'||idx,
               '010'||LPAD(to_char(idx),8, '0'),
               '이름'||idx,'회원'||idx, 'U', dayDate);
    END LOOP;
END;

-- 샘플로 가입한 일부 회원의 탈퇴를 진행하는 프로시저
CREATE OR REPLACE PROCEDURE withdraw_sampleDate
IS
    maxinput NUMBER:=500;
    nums NUMBER(4);
    deleteCheck NUMBER(1);
BEGIN
    FOR idx  IN 1..maxinput LOOP
        LOOP
            nums:=ROUND(DBMS_RANDOM.VALUE(1, 2000)); -- 샘플로 넣은 데이터 최대치로 지정
            SELECT COUNT(*) INTO deleteCheck FROM member WHERE email = 'mail'||nums||'@naver.com';
            IF 0<deleteCheck THEN
                DELETE member
                WHERE email='mail'||nums||'@naver.com';
                EXIT;
            END IF;
        END LOOP;
    END LOOP;
END;

EXECUTE chattingMessageSample;
EXECUTE member_sampleDate;
EXECUTE withdraw_sampleDate;


-- 테이블 확인 ---------------------------------------------------------------------------------------------------
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