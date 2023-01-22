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
delete CHATMESSAGE;

-- 전체 채팅 목록 보기
SELECT cr.c_id, cr.p_id, 'sell' AS "type", email
FROM chatInfomation cr,
    (SELECT p_id, email FROM product) p
WHERE cr.p_id=p.p_id
UNION
SELECT cr.c_id, cr.p_id, 'buy' AS "type", email
FROM chatInfomation cr,
    (SELECT c_id, sender_email AS email FROM chatParticipants) m
WHERE cr.c_id=m.c_id;

delete chatInfomation where c_id in ('chat29');

rollback;
commit;


select c.p_id, c.c_id, email, sender_email
from CHATINFOMATION c, CHATPARTICIPANTS cp, product p
where c.p_id=p.p_id and c.c_id=cp.c_id;

SELECT message, messType, sender, read, send_date
 		FROM chatMessage
 		WHERE c_id='chat26'
 		ORDER BY TO_CHAR(send_date, 'YYYYMMDDHH24MISS') ASC;


INSERT INTO chatMessage
VALUES(chatMessage_seq.NEXTVAL, 'chat2', '안녕', 'TEXT', 'hong@naver.com', 0, sysdate);
SELECT chatMessage_seq.NEXTVAL from dual;
SELECT message, messType, sender, read, send_date
FROM chatMessage
WHERE idx=161;


SELECT cr.c_id, cr.p_id, 'sell' AS "type"
		FROM chatInfomation cr,
		    (SELECT p_id FROM product WHERE email='lee@naver.com') p
		WHERE cr.p_id=p.p_id
		UNION
		SELECT cr.c_id, cr.p_id, 'buy' AS "type"
		FROM chatInfomation cr,
		    (SELECT c_id FROM chatParticipants WHERE sender_email='lee@naver.com') m
		WHERE cr.c_id=m.c_id;
        
UPDATE PRODUCTDETAIL SET trade='CLEAR' WHERE p_id='pid5';
delete PRODUCTDETAIL WHERE p_id='pid5';
delete PRODUCTDETAIL WHERE p_id='pid4';


SELECT message, messType, sender, read, send_date, nickname
 		FROM chatMessage c, member m
 		WHERE c.sender = m.email AND c_id='chat3'
 		ORDER BY TO_CHAR(send_date, 'YYYYMMDDHH24MISS') ASC;
        
        SELECT message, messType, sender, read, send_date, nickname
 		FROM chatMessage c, member m
 		WHERE c.sender = m.email AND c_id='chat3'
 		ORDER BY TO_CHAR(send_date, 'YYYYMMDDHH24MISS') ASC;
        
        SELECT pd.p_id, p_name, category, regdate, views, price, email, description, trade, fileName, uploadPath, uuid
		FROM
			(SELECT * FROM productDetail WHERE p_id=(SELECT p_id FROM chatInfomation WHERE c_id='chat5')) pd
				left outer join
			product p on pd.p_id = p.p_id
        		left outer join
        	(select fileName, uploadPath, uuid, p_id from PRODUCTPIC) f on f.p_id = pd.p_id;
            
        SELECT email, nickname, pd.p_id, p_name, price, fileName, uploadPath, uuid
		FROM
			(SELECT * FROM productDetail WHERE p_id=(SELECT p_id FROM chatInfomation WHERE c_id='chat5')) pd
				left outer join
			(SELECT member.email, nickname, p_id FROM product, member WHERE product.email = member.email) m on pd.p_id = m.p_id
        		left outer join
        	(SELECT fileName, uploadPath, uuid, p_id FROM productPic WHERE uuid=(SELECT MIN(uuid) from productPic GROUP BY p_id)) f on f.p_id = pd.p_id;
            
            SELECT c.c_id, p_id, p_name, nickname AS "chatMember", 'sell' AS "type"
		FROM
			(SELECT c_id, p.p_id, p_name FROM chatInfomation ci, productDetail p WHERE ci.p_id=p.p_id) c,
			(SELECT c_id, nickname FROM chatParticipants cp, member b WHERE sender_email=email) m
		WHERE c.c_id = m.c_id
			AND p_id='pid3';
        
        SELECT c.c_id, c.p_id, p_name, nickname AS "chatMember", 'sell' AS "type"
		FROM (SELECT c_id, p.p_id, p_name FROM chatInfomation ci, productDetail p WHERE ci.p_id=p.p_id) c,
            (SELECT nickname, p_id FROM product p, member b WHERE p.email=b.email AND b.email='lee@naver.com') m
		WHERE c.p_id=m.p_id
		UNION
		SELECT c.c_id, c.p_id, p_name, nickname AS "chatMember", 'buy' AS "type"
		FROM (SELECT c_id, p.p_id, p_name FROM chatInfomation ci, productDetail p WHERE ci.p_id=p.p_id) c,
            (SELECT c_id, nickname FROM chatParticipants cp, member b WHERE sender_email=email AND email='lee@naver.com') m
		WHERE c.c_id=m.c_id;
        
        SELECT c.c_id, c.p_id, p_name, nickname AS "chatMember", 'sell' AS "type"
		FROM (SELECT c_id, p.p_id, p_name FROM chatInfomation ci, product p, productDetail pd WHERE ci.p_id=p.p_id AND p.p_id=pd.p_id AND p.email='lee@naver.com') c,
            (SELECT c_id, nickname FROM (SELECT c_id, sender_email FROM chatParticipants WHERE c_id IN (SELECT c_id FROM chatInfomation ci, product p)) cp, member b  WHERE sender_email=email) m
		WHERE c.c_id=m.c_id
		UNION
		SELECT c.c_id, c.p_id, p_name, nickname AS "chatMember", 'buy' AS "type"
		FROM (SELECT c_id, p.p_id, p_name FROM (SELECT cp.c_id, p_id FROM chatParticipants cp, chatInfomation cif WHERE cp.c_id=cif.c_id AND sender_email='lee@naver.com') ci, product p, productDetail pd WHERE ci.p_id=p.p_id AND pd.p_id=p.p_id) c,
            (SELECT c_id, nickname FROM chatInfomation ci, member b, product p WHERE ci.p_id=p.p_id AND p.email=b.email) m
		WHERE c.c_id=m.c_id;
        
        SELECT c.c_id, c.p_id, p_name, nickname AS "chatMember", 'sell' AS "type"
		FROM (SELECT c_id, p.p_id, p_name FROM chatInfomation ci, product p, productDetail pd WHERE ci.p_id=p.p_id AND p.p_id=pd.p_id AND p.email='lee@naver.com') c,
            (SELECT c_id, nickname FROM chatParticipants cp, member b  WHERE sender_email=email) m
		WHERE c.c_id=m.c_id
		UNION
		SELECT c.c_id, c.p_id, p_name, nickname AS "chatMember", 'buy' AS "type"
		FROM (SELECT cp.c_id, pd.p_id, p_name FROM (SELECT c_id FROM chatParticipants WHERE sender_email='lee@naver.com') cp, chatInfomation ci, productDetail pd WHERE cp.c_id=ci.c_id AND ci.p_id=pd.p_id) c,
            (SELECT c_id, nickname FROM chatInfomation ci, product p, member b WHERE ci.p_id=p.p_id AND p.email=b.email) m
		WHERE c.c_id=m.c_id