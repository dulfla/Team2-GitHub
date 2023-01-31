-- 카테고리
INSERT INTO category VALUES('디지털 기기', '디지털 기기.png');
INSERT INTO category VALUES('생활가전', '생활가전.png');
INSERT INTO category VALUES('생활주방', '생활주방.png');
INSERT INTO category VALUES('유아동', '유아동.png');
INSERT INTO category VALUES('의류', '의류.png');
INSERT INTO category VALUES('잡화', '잡화.png');
INSERT INTO category VALUES('뷰티 미용', '뷰티 미용.png');
INSERT INTO category VALUES('취미 게임 음반', '취미 게임 음반.png');
INSERT INTO category VALUES('도서', '도서.png');
INSERT INTO category VALUES('중고차', '중고차.png');
INSERT INTO category VALUES('가공식품', '가공식품.png');
INSERT INTO category VALUES('반려동물 물품', '반려동물 물품.png');
INSERT INTO category VALUES('기타 중고물품', '기타 중고물품.png');

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
VALUES('manager@naver.com','1234',19970205,'경기도오산시','0103455556','관리자','홍판서','M');

------------------------------------------------------------------------------------------------------------------------

-- 상품 상세
INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'컴퓨터','최신형 컴퓨터입니다','디지털 기기','2022/05/30',0,1000000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'hong@naver.com', 'pid'||pid_seq.CURRVAL);

INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'K5','상태 좋습니다','중고차','2022/11/13',1,30000000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'lee@naver.com', 'pid'||pid_seq.CURRVAL);

INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'지갑','상태 굿','잡화','2022/09/20',60,500000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'pack@naver.com', 'pid'||pid_seq.CURRVAL);

INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'츄르','츄르 2박스 입니다','반려동물 물품','2022/11/03',0,15000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'jeong@naver.com', 'pid'||pid_seq.CURRVAL);

INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'에어팟 맥스','에어팟 맥스 미개봉 상품입니다','디지털 기기','2022/12/25',115,600000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'choi@naver.com', 'pid'||pid_seq.CURRVAL);

INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'에어팟','에어팟 맥스 미개봉 상품입니다','디지털 기기','2022/01/25',115,500000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'pack@naver.com', 'pid'||pid_seq.CURRVAL);

------------------------------------------------------------------------------------------------------------------------

-- 검색어
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

SELECT * FROM CHATINFOMATION;
SELECT * FROM CHATMESSAGE;
SELECT * FROM CHATPARTICIPANTS;

SELECT * FROM memberHistory;
SELECT * FROM productHistory;