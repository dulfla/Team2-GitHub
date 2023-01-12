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

SELECT message, messType, sender, read, send_date
 		FROM chatMessage
 		WHERE c_id='chat26'
 		ORDER BY TO_CHAR(send_date, 'YYYYMMDDHH24MISS') ASC;


