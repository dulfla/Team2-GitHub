-- 혹시 모르니 테이블 삭제 ----------------------------------------------------------------------------------------
DROP TABLE category;
DROP TABLE chatInfomation;
DROP TABLE chatMessage;
DROP TABLE chatParticipants;
DROP TABLE withdraw;


-- 상품 카테고리 테이블 --------------------------------------------------------------------------------------------
CREATE TABLE category(
    category NVARCHAR2(20) CONSTRAINT category_pk_category PRIMARY KEY
);

INSERT INTO category VALUES('인기매물');
INSERT INTO category VALUES('디지털기기');
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


-- 채팅방 테이블 -------------------------------------------------------------------------------------------------
CREATE TABLE chatInfomation(
    c_id VARCHAR2(50) CONSTRAINT chatInfomation_pk_c_id PRIMARY KEY,
    p_id VARCHAR2(10) -- 외래키
);


-- 채팅 메세지 테이블 ---------------------------------------------------------------------------------------------
CREATE TABLE chatMessage(
    idx NUMBER CONSTRAINT chatMessage_pk_idx PRIMARY KEY,
    c_id VARCHAR2(50), -- 외래키
    message NCLOB NOT NULL,
    read char(1) NOT NULL, -- 읽음 : 0, 안 읽음 1
    send_date DATE NOT NULL
);


-- 채팅방 사용자 테이블 --------------------------------------------------------------------------------------------
CREATE TABLE chatParticipants(
    idx NUMBER CONSTRAINT chatParticipants_pk_idx PRIMARY KEY,
    c_id VARCHAR2(50), -- 외래키
    sender_email VARCHAR2(50), -- 외래키
    join_date date NOT NULL-- 이거 추가됨
);


-- 탈퇴한 회원 테이블 ----------------------------------------------------------------------------------------------
CREATE TABLE withdraw(
    email VARCHAR2(50) CONSTRAINT withdraw_pk_email PRIMARY KEY,
    wd_date DATE NOT NULL
);


-- FORING KEY 작성-----------------------------------------------------------------------------------------------
ALTER TABLE chatInfomation
ADD CONSTRAINT chatInfomation_fk_p_id FOREIGN KEY(p_id) REFERENCES product(p_id);
ALTER TABLE chatMessage
ADD CONSTRAINT chatMessage_fk_c_id FOREIGN KEY(c_id) REFERENCES chatInfomation(c_id);
ALTER TABLE chatParticipants
ADD CONSTRAINT chatParticipants_fk_c_id FOREIGN KEY(c_id) REFERENCES chatInfomation(c_id)
ADD CONSTRAINT chatParticipants_fk_sender_email FOREIGN KEY(sender_email) REFERENCES member(email);
ALTER TABLE withdraw
ADD CONSTRAINT withdraw_fk_email FOREIGN KEY(email) REFERENCES product(p_id);


-- 프로시저 ---------------------------------------------------------------------------------------------------

DROP SEQUENCE year_seq;
DROP SEQUENCE month_seq;
DROP sequence day_seq;

CREATE SEQUENCE year_seq
START WITH 1 INCREMENT BY 1 maxvalue 5
NOCACHE CYCLE;
SET SERVEROUTPUT ON;
CREATE SEQUENCE month_seq
START WITH 1 INCREMENT BY 4 maxvalue 12
NOCACHE CYCLE;
CREATE SEQUENCE day_seq
START WITH 1 INCREMENT BY 4 maxvalue 28
NOCACHE CYCLE;


CREATE OR REPLACE PROCEDURE chatInfomation_sampleDate
IS
    maxinput number:=20;
BEGIN
    FOR idx  IN 1..maxinput LOOP
        INSERT INTO chatInfomation
        VALUES(chatInfomation_seq.NEXTVAL, '상품 ID');
    END LOOP;
END;

CREATE OR REPLACE PROCEDURE chatMessage_sampleDate
IS
    maxinput number:=20;
BEGIN
    FOR idx  IN 1..maxinput LOOP
        INSERT INTO chatMessage
        VALUES(chatMessage_seq.NEXTVAL, '채팅방 ID', '메세지', '읽음 여부', '보낸 날짜');
    END LOOP;
END;

CREATE OR REPLACE PROCEDURE chatParticipants_sampleDate
IS
    maxinput number:=20;
BEGIN
    FOR idx  IN 1..maxinput LOOP
        INSERT INTO chatParticipants
        VALUES(chatParticipants_seq.NEXTVAL, '채팅방 ID', '참여 회원', '참가 날짜');
    END LOOP;
END;

CREATE OR REPLACE PROCEDURE withdraw_sampleDate
IS
    maxinput number:=20;
BEGIN
    FOR idx  IN 1..maxinput LOOP
    --  dbms_output.put_line('20'||LPAD(to_char(year_seq.nextval+16), 2, '0')||LPAD(to_char(month_seq.nextval),2, '0')||'01');
        INSERT INTO withdraw
        VALUES('이메일'||idx||'@naver.com',
            TO_DATE('20'||LPAD(to_char(year_seq.nextval+16), 2, '0')||LPAD(to_char(month_seq.nextval),2, '0')||LPAD(to_char(day_seq.nextval),2, '0'), 'YYYY/MM/DD'));
    END LOOP;
END;


SET SERVEROUTPUT ON;

EXECUTE chatInfomation_sampleDate;
EXECUTE chatMessage_sampleDate;
EXECUTE chatParticipants_sampleDate;
EXECUTE withdraw_sampleDate;


-- 테이블 확인 ---------------------------------------------------------------------------------------------------
SELECT * FROM chatInfomation;
SELECT * FROM chatMessage;
SELECT * FROM chatParticipants;
SELECT * FROM category;
SELECT * FROM withdraw;