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
    read char(1) NOT NULL, -- 읽음 : 0, 안 읽음 : 1
    send_date DATE NOT NULL
);

CREATE TABLE chatParticipants(
    idx NUMBER CONSTRAINT chatParticipants_pk_idx PRIMARY KEY,
    c_id VARCHAR2(50),
    sender_email VARCHAR2(50),
    join_date date NOT NULL
);
