SELECT c_id
FROM chatInfomation
WHERE 
    c_id IN (SELECT c_id FROM chatParticipants WHERE sender_email='hong@naver.com')
    AND p_id='pid1';

SELECT c_id
FROM chatParticipants
WHERE
    c_id IN (SELECT c_id FROM chatInfomation WHERE p_id='pid1')
    AND sender_email='choi@naver.com';

SELECT cr.c_id, cr.p_id
FROM
    chatInfomation cr,(SELECT p_id FROM product WHERE email='hong@naver.com') p
WHERE cr.p_id=p.p_id;

SELECT cr.c_id, cr.p_id
FROM chatInfomation cr,
    (SELECT c_id FROM chatParticipants WHERE sender_email='hong@naver.com') m
WHERE cr.c_id=m.c_id;

SELECT cr.c_id, cr.p_id, 'sell' AS "type" -- 내가 판매자인 대화방
FROM chatInfomation cr,
    (SELECT p_id FROM product WHERE email='hong@naver.com') p
WHERE cr.p_id=p.p_id
UNION
SELECT cr.c_id, cr.p_id, 'buy' AS "type" -- 내가 구매자인 대화방
FROM chatInfomation cr,
    (SELECT c_id FROM chatParticipants WHERE sender_email='hong@naver.com') m
WHERE cr.c_id=m.c_id;



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

SELECT * FROM CHATINFOMATION;
SELECT * FROM CHATPARTICIPANTS;
SELECT * FROM CHATMESSAGE;

select c.p_id, c.c_id, email, sender_email
from CHATINFOMATION c, CHATPARTICIPANTS cp, product p
where c.p_id=p.p_id and c.c_id=cp.c_id;

DROP SEQUENCE sampleMessage_seq;
CREATE SEQUENCE sampleMessage_seq
START WITH 1
NOCACHE
NOCYCLE;

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

SELECT message, messType, sender, read, send_date
 		FROM chatMessage
 		WHERE c_id='chat26'
 		ORDER BY TO_CHAR(send_date, 'YYYYMMDDHH24MISS') ASC;


