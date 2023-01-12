
SELECT * FROM SEARCH;
SELECT * FROM MEMBER;

SELECT * FROM PRODUCT;
SELECT * FROM PRODUCTDETAIL;
SELECT * FROM PRODUCTPIC;
SELECT * FROM PICDETAIL;
SELECT * FROM CATEGORY;
SELECT * FROM TRADE;

SELECT * FROM CHATINFOMATION;
SELECT * FROM CHATPARTICIPANTS;
SELECT * FROM CHATMESSAGE;

SELECT * FROM memberHistory;
SELECT * FROM productHistory;

------------------------------------------------------------------------------------------------------------------

delete CHATINFOMATION;
delete CHATPARTICIPANTS;

------------------------------------------------------------------------------------------------------------------

ROLLBACK;
COMMIT;

------------------------------------------------------------------------------------------------------------------

-- 채팅방
INSERT INTO chatInfomation
VALUES('chat1', 'pid1');
INSERT INTO chatParticipants
VALUES(1, 'chat1', 'choi@naver.com', '2020/11/12');
INSERT INTO chatInfomation
VALUES('chat2', 'pid11');
INSERT INTO chatParticipants
VALUES(2, 'chat2', 'hong@naver.com', '2020/11/12');

-- 상품 현황
INSERT INTO productDetail
VALUES('pid10','츄르','츄르 2박스 입니다','반려동물 물품','2022/11/03',0,15000);
INSERT INTO productDetail
VALUES('pid11','에어팟 맥스','에어팟 맥스 미개봉 상품입니다','디지털 기기','2022/12/25',115,600000);

UPDATE productDetail
SET category='기타 중고물품'
WHERE p_id='pid10';

delete productDetail
where p_id='pid10';

insert into trade
values('tid15', 'pid11', 'pack@naver.com');

CREATE SEQUENCE chatInfomation_seq
START WITH 3
NOCACHE
NOCYCLE;

CREATE SEQUENCE chatParticipants_seq
START WITH 3
NOCACHE
NOCYCLE;

EXECUTE newChattingRoom('pid3', 'hong@naver.com');
