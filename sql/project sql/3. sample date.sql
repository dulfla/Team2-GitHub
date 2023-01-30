-- 카테고리
INSERT INTO category VALUES('???????? 기기', '???????? 기기.png');
INSERT INTO category VALUES('???????????', '???????????.png');
INSERT INTO category VALUES('??????주방', '??????주방.png');
INSERT INTO category VALUES('?????????', '?????????.png');
INSERT INTO category VALUES('?????', '?????.png');
INSERT INTO category VALUES('??????', '??????.png');
INSERT INTO category VALUES('뷰티 미용', '뷰티 미용.png');
INSERT INTO category VALUES('취??? 게임 ?????', '취??? 게임 ?????.png');
INSERT INTO category VALUES('??????', '??????.png');
INSERT INTO category VALUES('중고??', '중고??.png');
INSERT INTO category VALUES('??공식???', '??공식???.png');
INSERT INTO category VALUES('반려????? 물품', '반려????? 물품.png');
INSERT INTO category VALUES('기?? 중고물품', '기?? 중고물품.png');

------------------------------------------------------------------------------------------------------------------------

-- ?????? ??????
INSERT INTO member(email, password,birth, address, phone,name,nickname)
VALUES('hong@naver.com','1234',19990305,'경기????????????','0103455555','???길동','길동???1');
INSERT INTO member(email, password,birth, address, phone,name,nickname)
VALUES('lee@naver.com','1234',19970205,'경기????????????','0103455556','???길동','길동???2');
INSERT INTO member(email, password,birth, address, phone,name,nickname)
VALUES('pack@naver.com','1234',19990105,'경기????????????','0103455557','박길???','길동???3');
INSERT INTO member(email, password,birth, address, phone,name,nickname)
VALUES('jeong@naver.com','1234',19890506,'경기????????????','0103455558','???길동','길동???4');
INSERT INTO member(email, password,birth, address, phone,name,nickname)
VALUES('choi@naver.com','1234',19900312,'경기????????????','0103455559','최길???','길동???5');

INSERT INTO member(email, password,birth, address, phone,name,nickname,type)
VALUES('manager@naver.com','1234',19970205,'경기????????????','0103455556','??리자','?????????','M');

------------------------------------------------------------------------------------------------------------------------

-- ?????? ??????
INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'컴퓨???','최신??? 컴퓨????????????','???????? 기기','2022/05/30',0,1000000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'hong@naver.com', 'pid'||pid_seq.CURRVAL);

INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'K5','?????? 좋습??????','중고??','2022/11/13',1,30000000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'lee@naver.com', 'pid'||pid_seq.CURRVAL);

INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'????','?????? ??','??????','2022/09/20',60,500000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'pack@naver.com', 'pid'||pid_seq.CURRVAL);

INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'츄르','츄르 2박스 ?????????','반려????? 물품','2022/11/03',0,15000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'jeong@naver.com', 'pid'||pid_seq.CURRVAL);

INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'????????? 맥스','????????? 맥스 미개?? ???????????????','???????? 기기','2022/12/25',115,600000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'choi@naver.com', 'pid'||pid_seq.CURRVAL);

INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'?????????','????????? 맥스 미개?? ???????????????','???????? 기기','2022/01/25',115,500000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'pack@naver.com', 'pid'||pid_seq.CURRVAL);

------------------------------------------------------------------------------------------------------------------------

-- ????????
INSERT INTO search(idx, keyword, email)
VALUES(search_seq.NEXTVAL, 'ddd', 'hong@naver.com');
INSERT INTO search(idx, keyword, email)
VALUES(search_seq.NEXTVAL, 'dddd', 'lee@naver.com');
INSERT INTO search(idx, keyword, email)
VALUES(search_seq.NEXTVAL, 'ddddd', 'jeong@naver.com');

------------------------------------------------------------------------------------------------------------------------

-- 채팅
INSERT INTO chatInfomation
VALUES('chat'||chatInfomation_seq.NEXTVAL, 'pid1');
INSERT INTO chatParticipants
VALUES(chatParticipants_seq.NEXTVAL, 'chat'||chatInfomation_seq.CURRVAL, 'choi@naver.com', '2020/11/12');

INSERT INTO chatInfomation
VALUES('chat'||chatInfomation_seq.NEXTVAL, 'pid3');
INSERT INTO chatParticipants
VALUES(chatParticipants_seq.NEXTVAL, 'chat'||chatInfomation_seq.CURRVAL, 'hong@naver.com', '2020/11/12');

INSERT INTO chatInfomation
VALUES('chat'||chatInfomation_seq.NEXTVAL, 'pid2');
INSERT INTO chatParticipants
VALUES(chatParticipants_seq.NEXTVAL, 'chat'||chatInfomation_seq.CURRVAL, 'hong@naver.com', '2021/11/12');

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

insert into productPic VALUES('pid'||pid_seq.CURRVAL
,airpotmax.jpg
,'2023\01\28'
,'1');

SELECT * FROM CHATINFOMATION;
SELECT * FROM CHATMESSAGE;
SELECT * FROM CHATPARTICIPANTS;

SELECT * FROM memberHistory;
SELECT * FROM productHistory;