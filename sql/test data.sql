
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



EXECUTE newChattingRoom('pid3', 'hong@naver.com');
