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
INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid7','에어팟','에어팟 맥스 미개봉 상품입니다','디지털 기기','2022/01/25',115,500000);

------------------------------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------------------------------

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
insert into product
values(6, 'pack@naver.com', 'pid7');

------------------------------------------------------------------------------------------------------------------------

-- 검색어
insert into search(idx, search, email)
VALUES(1,'ddd','hong@naver.com');
insert into search(idx, search, email)
VALUES(2,'dddd','lee@naver.com');
insert into search(idx, search, email)
VALUES(3,'ddddd','jeong@naver.com');

------------------------------------------------------------------------------------------------------------------------

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