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

EXECUTE chattingMessageSample;

------------------------------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------------------------------

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

EXECUTE member_sampleDate;

------------------------------------------------------------------------------------------------------------------------

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

EXECUTE withdraw_sampleDate;

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
