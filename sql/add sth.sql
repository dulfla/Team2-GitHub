-- 검색어 fk 추가
ALTER TABLE search
ADD CONSTRAINT fk_search_email FOREIGN KEY(email)
REFERENCES member(email)
ON DELETE CASCADE;

-- 상품 fk 추가
ALTER TABLE product
ADD CONSTRAINT product_fk_email FOREIGN KEY(email) REFERENCES member(email) ON DELETE CASCADE;
ALTER TABLE product
ADD CONSTRAINT product_fk_p_id FOREIGN KEY(p_id) REFERENCES productDetail(p_id) ON DELETE CASCADE;

-- 상품 상세보기 fk 추가
ALTER TABLE productDetail
ADD CONSTRAINT productDetail_fk_category FOREIGN KEY(category) REFERENCES category(category) ON DELETE CASCADE;

-- 상품 사진 fk 추가
ALTER TABLE productPic
ADD CONSTRAINT productPic_fk_p_id FOREIGN KEY(p_id) REFERENCES productDetail(p_id) ON DELETE CASCADE;
ALTER TABLE productPic
ADD CONSTRAINT productPic_fk_f_id FOREIGN KEY(f_id) REFERENCES picDetail(f_id) ON DELETE CASCADE;

-- 채팅방 fk 추가
ALTER TABLE chatInfomation
ADD CONSTRAINT chatInfomation_fk_p_id FOREIGN KEY(p_id) REFERENCES productDetail(p_id) ON DELETE CASCADE;

-- 채팅 메세지 fk 추가
ALTER TABLE chatMessage
ADD CONSTRAINT chatMessage_fk_c_id FOREIGN KEY(c_id) REFERENCES chatInfomation(c_id) ON DELETE CASCADE;

-- 채팅 인원 fk 추가
ALTER TABLE chatParticipants
ADD CONSTRAINT chatParticipants_fk_c_id FOREIGN KEY(c_id) REFERENCES chatInfomation(c_id) ON DELETE CASCADE
ADD CONSTRAINT chatPartic_fk_sender_email FOREIGN KEY(sender_email) REFERENCES member(email) ON DELETE CASCADE;

-- 상품 거래 fk 추가
ALTER TABLE trade
ADD CONSTRAINT trade_fk_p_id FOREIGN KEY(p_id) REFERENCES productDetail(p_id) ON DELETE CASCADE
ADD CONSTRAINT trade_fk_email FOREIGN KEY(email) REFERENCES member(email) ON DELETE CASCADE;

-- 상품관련 트리거 만들기
drop table productHistory cascade constraints;
create table productHistory(
    idx number CONSTRAINT productHistory_pk_idx PRIMARY key,
    p_id varchar2(10),
    category nvarchar2(20),
    trackDate date not null,
    type char(5)
);

DROP SEQUENCE productHistory_seq;
create SEQUENCE productHistory_seq
start with 1
NOCACHE
NOCYCLE;

create or REPLACE TRIGGER trackingProduct
before insert or update or delete on productDetail
for each row
declare
begin
    if inserting then
        insert into productHistory
        VALUES(productHistory_seq.NEXTVAL, :new.p_id, :new.category, :new.regdate, 'IN');
    elsif updating then
        update productHistory
        set category = :new.category
        where p_id=:old.p_id;
    elsif deleting then
        insert into productHistory
        VALUES(productHistory_seq.NEXTVAL, :old.p_id, :old.category, :old.regdate, 'OUT'); -- sysdate 여야 함
    end if;
end;

create or REPLACE TRIGGER trackingProductTrade
before insert on trade
for each row
declare
    trackdate date;
    category nvarchar2(20);
begin
    select regdate into trackdate from productDetail where p_id=:new.p_id; -- sysdate 여야 함
    select category into category from productDetail where p_id=:new.p_id;
    insert into productHistory
    VALUES(productHistory_seq.NEXTVAL, :new.p_id, category, trackdate, 'TRADE');
end;


INSERT INTO productDetail
VALUES('pid10','츄르','츄르 2박스 입니다','반려동물 물품','2022/11/03',0,15000);
INSERT INTO productDetail
VALUES('pid12','에어팟 맥스','에어팟 맥스 미개봉 상품입니다','디지털 기기','2022/12/25',115,600000);

UPDATE productDetail
SET category='기타 중고물품'
WHERE p_id='pid10';
UPDATE productDetail
SET p_id='pid13'
WHERE p_id='pid11';

delete productDetail
where p_id='pid10';

insert into trade
values('tid15', 'pid12', 'pack@naver.com');


select * from productHistory;

-- 전체 상품 수
SELECT COUNT(*) FROM productHistory
WHERE type='IN';
-- 전체 거래건수
SELECT COUNT(*) FROM productHistory
WHERE type='TRADE';
-- 미거래 삭제 건수
SELECT COUNT(*) FROM productHistory
WHERE type='OUT' AND p_id NOT IN (SELECT p_id FROM productHistory WHERE type='TRADE');


-- 카테고리별 등록된 상품 수
SELECT c.category, COUNT(p_id)
FROM category c LEFT OUTER JOIN (SELECT category, p_id FROM productHistory WHERE type='IN') p
ON c.category = p.category
GROUP BY c.category;
-- 월별 - 카테고리별 거래된 상품 수
SELECT TO_CHAR(trackDate, 'YYYY'), TO_CHAR(trackDate, 'MM'), c.category, COUNT(p_id)
FROM category c LEFT OUTER JOIN (SELECT category, p_id, trackDate FROM productHistory WHERE type='IN') p
ON c.category = p.category
GROUP BY TO_CHAR(trackDate, 'YYYY'), TO_CHAR(trackDate, 'MM'), c.category;


-- 카테고리별 거래된 상품 수
SELECT c.category, COUNT(p_id)
FROM category c LEFT OUTER JOIN (SELECT category, p_id FROM productHistory WHERE type='TRADE') p
ON c.category = p.category
GROUP BY c.category;
-- 월별 - 카테고리별 거래된 상품 수
SELECT TO_CHAR(trackDate, 'YYYY'), TO_CHAR(trackDate, 'MM'), c.category, COUNT(p_id)
FROM category c LEFT OUTER JOIN (SELECT category, p_id, trackDate FROM productHistory WHERE type='TRADE') p
ON c.category = p.category
GROUP BY TO_CHAR(trackDate, 'YYYY'), TO_CHAR(trackDate, 'MM'), c.category;


-- 카테고리별 삭제 상품 수
SELECT c.category, COUNT(p_id)
FROM category c LEFT OUTER JOIN (SELECT category, p_id FROM productHistory WHERE type='OUT') p
ON c.category = p.category
GROUP BY c.category;
-- 월별 - 카테고리별 삭제 상품 수
SELECT TO_CHAR(trackDate, 'YYYY'), TO_CHAR(trackDate, 'MM'), c.category, COUNT(p_id)
FROM category c LEFT OUTER JOIN (SELECT category, p_id, trackDate FROM productHistory WHERE type='OUT') p
ON c.category = p.category
GROUP BY TO_CHAR(trackDate, 'YYYY'), TO_CHAR(trackDate, 'MM'), c.category;


-- 카테고리별 미 거래 삭제 상품 수
SELECT c.category, COUNT(p_id)
FROM category c LEFT OUTER JOIN (SELECT category, p_id FROM productHistory WHERE type='OUT' AND type<>'TRADE') p
ON c.category = p.category
GROUP BY c.category
ORDER BY category ASC;
-- 월별 - 카테고리별 미 거래 삭제 상품 수
SELECT TO_CHAR(trackDate, 'YYYY'), TO_CHAR(trackDate, 'MM'), c.category, COUNT(p_id)
FROM category c LEFT OUTER JOIN (SELECT category, p_id, trackDate FROM productHistory WHERE type='OUT' AND type<>'TRADE') p
ON c.category = p.category
GROUP BY TO_CHAR(trackDate, 'YYYY'), TO_CHAR(trackDate, 'MM'), c.category
ORDER BY category ASC;


-- 카테고리별 거래 후 삭제 상품 수
SELECT c.category, COUNT(p_id)
FROM category c LEFT OUTER JOIN (SELECT category, p_id FROM productHistory WHERE type='OUT' AND type='TRADE') p
ON c.category = p.category
GROUP BY c.category
ORDER BY category ASC;
-- 월별 - 카테고리별 거래 후 삭제 상품 수
SELECT TO_CHAR(trackDate, 'YYYY'), TO_CHAR(trackDate, 'MM'), c.category, COUNT(p_id)
FROM category c LEFT OUTER JOIN (SELECT category, p_id, trackDate FROM productHistory WHERE type='OUT' AND type='TRADE') p
ON c.category = p.category
GROUP BY TO_CHAR(trackDate, 'YYYY'), TO_CHAR(trackDate, 'MM'), c.category
ORDER BY category ASC;

