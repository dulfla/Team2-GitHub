-- < 인식 못함
-- <![CDATA[ "쿼리 작성" ]]> '<'나 '>'가 있는 쿼리부분을 저 틀안에 작성해야 함
------------------------------------------------------------------------------------------------------------------

-- 해당 이메일의 회원이 특정 제품에 구매 희망자로 참여하고 있는 채팅방
SELECT c_id
FROM chatInfomation
WHERE 
    c_id IN (SELECT c_id FROM chatParticipants WHERE sender_email='hong@naver.com')
    AND p_id='pid1';

-- 해당 제품에 특정 이메일의 회원이 구매 희망자로 참여하고 있는 채팅방
SELECT c_id
FROM chatParticipants
WHERE
    c_id IN (SELECT c_id FROM chatInfomation WHERE p_id='pid1')
    AND sender_email='choi@naver.com';

-- 특정 회원이 판매자로 참여하는 채팅방
SELECT cr.c_id, cr.p_id
FROM
    chatInfomation cr,(SELECT p_id FROM product WHERE email='hong@naver.com') p
WHERE cr.p_id=p.p_id;

-- 특정 회원이 구매자로 참여하는 채팅방
SELECT cr.c_id, cr.p_id
FROM chatInfomation cr,
    (SELECT c_id FROM chatParticipants WHERE sender_email='hong@naver.com') m
WHERE cr.c_id=m.c_id;

-- 특정 회원의 구매자 혹은 판매자로 참여하는 모든 채팅방 목록 보기
SELECT cr.c_id, cr.p_id, 'sell' AS "type" -- 내가 판매자인 채팅방
FROM chatInfomation cr,
    (SELECT p_id FROM product WHERE email='hong@naver.com') p
WHERE cr.p_id=p.p_id
UNION
SELECT cr.c_id, cr.p_id, 'buy' AS "type" -- 내가 구매자인 채팅방
FROM chatInfomation cr,
    (SELECT c_id FROM chatParticipants WHERE sender_email='hong@naver.com') m
WHERE cr.c_id=m.c_id;

------------------------------------------------------------------------------------------------------------------

-- 회원 기록이 있는 년도
SELECT TO_CHAR(trakingDate,'YYYY') as "year"
FROM memberHistory
GROUP BY TO_CHAR(trakingDate,'YYYY')
ORDER BY "year" ASC;

-- 년도별 누적 회원수
SELECT dates, COUNT(CASE WHEN m2.type='IN' THEN 1 END)-COUNT(CASE WHEN m2.type='OUT' THEN 1 END) AS "count"
FROM
    (SELECT TO_CHAR(trakingDate,'YYYY') AS dates FROM memberHistory GROUP BY TO_CHAR(trakingDate,'YYYY')) m1,
    memberHistory m2
WHERE TO_DATE(TO_CHAR(m2.trakingDate,'YYYY'), 'YYYY')<=TO_DATE(dates, 'YYYY')
GROUP BY dates
ORDER BY dates ASC;

-- 년도별 가입 건수
SELECT
    TO_CHAR(trakingDate,'YYYY') as "year",
    COUNT(*)
FROM memberHistory
WHERE type='IN'
GROUP BY TO_CHAR(trakingDate,'YYYY')
ORDER BY "year" ASC;

-- 년도별 탈퇴 건수
SELECT
    TO_CHAR(trakingDate,'YYYY') as "year",
    COUNT(*)
FROM memberHistory
WHERE type='OUT' -- IN OUT
GROUP BY TO_CHAR(trakingDate,'YYYY')
ORDER BY "year" ASC;

-- 월별 가입 건수, 탈퇴 건수
SELECT
    TO_CHAR(trakingDate,'YYYY') as "year",
    TO_CHAR(trakingDate,'MM') as "month",
    COUNT(*)
FROM memberHistory
WHERE type='IN'
GROUP BY TO_CHAR(trakingDate,'YYYY'),TO_CHAR(trakingDate,'MM') 
ORDER BY "year" ASC, "month" ASC;
SELECT
    TO_CHAR(trakingDate,'YYYY') as "year",
    TO_CHAR(trakingDate,'MM') as "month",
    COUNT(*)
FROM memberHistory
WHERE type='OUT'
GROUP BY TO_CHAR(trakingDate,'YYYY'),TO_CHAR(trakingDate,'MM') 
ORDER BY "year" ASC, "month" ASC;

-- 현재까지 등록된 삼품의 카테고리별 건수
SELECT category.category, COUNT(p_id) FROM category LEFT OUTER JOIN productDetail
ON category.category = productDetail.category
GROUP BY category.category;

------------------------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------------------------

-- 월별 탈퇴 회원수
SELECT
    TO_CHAR(trakingDate,'YYYY') as "year",
    TO_CHAR(trakingDate,'MM') as "month",
    COUNT(*)
FROM memberHistory
WHERE type='OUT' -- IN OUT
GROUP BY TO_CHAR(trakingDate,'YYYY'),TO_CHAR(trakingDate,'MM') 
ORDER BY "year" ASC, "month" ASC;

-- 년도별 탈퇴 회원수
SELECT
    TO_CHAR(trakingDate,'YYYY') as "year",
    COUNT(*)
FROM memberHistory
WHERE type='OUT' -- IN OUT
GROUP BY TO_CHAR(trakingDate,'YYYY')
ORDER BY "year" ASC;

-- 월별 누적 가입자수
SELECT dates, COUNT(m2.trakingDate)
FROM
    (SELECT TO_CHAR(trakingDate,'YYYY/MM') AS dates FROM memberHistory WHERE type='IN' GROUP BY TO_CHAR(trakingDate,'YYYY/MM')) m1,
    (SELECT * FROM memberHistory WHERE type='IN') m2
WHERE TO_DATE(TO_CHAR(m2.trakingDate,'YYYY/MM'), 'yyyy/mm')<=TO_DATE(dates, 'yyyy/mm')
GROUP BY dates
ORDER BY dates;

-- 년도별 누적 가입자수
SELECT dates, COUNT(m2.trakingDate)
FROM
    (SELECT TO_CHAR(trakingDate,'YYYY') AS dates FROM memberHistory WHERE type='IN' GROUP BY TO_CHAR(trakingDate,'YYYY')) m1,
    (SELECT * FROM memberHistory WHERE type='IN') m2
WHERE TO_DATE(TO_CHAR(m2.trakingDate,'YYYY'), 'YYYY')<=TO_DATE(dates, 'YYYY')
GROUP BY dates
ORDER BY dates;

-- 월별 누적 회원수
SELECT dates, COUNT(CASE WHEN m2.type='IN' THEN 1 END)-COUNT(CASE WHEN m2.type='OUT' THEN 1 END) AS "count"
FROM
    (SELECT TO_CHAR(trakingDate,'YYYY/MM') AS dates FROM memberHistory GROUP BY TO_CHAR(trakingDate,'YYYY/MM')) m1,
    memberHistory m2
WHERE TO_DATE(TO_CHAR(m2.trakingDate,'YYYY/MM'), 'YYYY/MM')<=TO_DATE(dates, 'YYYY/MM')
GROUP BY dates
ORDER BY dates;

-- 년도별 누적 회원수
SELECT dates, COUNT(CASE WHEN m2.type='IN' THEN 1 END)-COUNT(CASE WHEN m2.type='OUT' THEN 1 END) AS "count"
FROM
    (SELECT TO_CHAR(trakingDate,'YYYY') AS dates FROM memberHistory GROUP BY TO_CHAR(trakingDate,'YYYY')) m1,
    memberHistory m2
WHERE TO_DATE(TO_CHAR(m2.trakingDate,'YYYY'), 'YYYY')<=TO_DATE(dates, 'YYYY')
GROUP BY dates
ORDER BY dates;

------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------

-- 특정 날짜를 포함한 컬럼 가져오기
SELECT * FROM withdraw
where wd_date like '%/02/%';

-- 년, 월, 일 만 가져오기
SELECT SUBSTR(wd_date, 1, 2) AS "year" FROM withdraw;
SELECT SUBSTR(wd_date, 4, 2) AS "month" FROM withdraw;
SELECT SUBSTR(wd_date, 7, 2) FROM withdraw;

-- 년, 월 로 묶어서 해당 월에 데이터가 얼마나 있는지 확인하기
-- SUBSTR()
SELECT 
    SUBSTR(wd_date, 1, 2) as "year", -- regdate
    SUBSTR(wd_date, 4, 2) as "month",
    count(*)
FROM memberHistory
GROUP BY SUBSTR(wd_date, 1, 2),SUBSTR(wd_date, 4, 2) 
ORDER BY "year" ASC, "month" ASC;
-- TO_CHAR()
SELECT
    TO_CHAR(wd_date,'YYYY') AS "year", -- regdate
    TO_CHAR(wd_date,'MM') AS "month",
    count(*) AS "cnt"
FROM withdraw -- member
GROUP BY TO_CHAR(wd_date,'YYYY'), TO_CHAR(wd_date,'MM') -- regdate
ORDER BY "year" ASC, "month" ASC;

-- 해당 년도에 포함되는 데이터만 구하기
SELECT
    TO_CHAR(wd_date,'YYYY') AS "year", -- regdate
    count(*) AS "cnt"
FROM withdraw -- member
GROUP BY TO_CHAR(wd_date,'YYYY') -- regdate
ORDER BY "year" ASC;

-- 특정 날짜 이하의 데이터 가져오기
SELECT regdate, email FROM member
WHERE regdate<=TO_DATE('20190110', 'yyyy/mm/dd');

-- 해당 날짜 이전까지의 누적 데이터수 구하기
SELECT m1.regdate, count(m2.regdate)
FROM (SELECT regdate FROM member group BY regdate) m1, member m2
WHERE m2.regdate<=m1.regdate
GROUP BY m1.regdate
ORDER BY m1.regdate;

-- 해당 월 이전까지의 누적 데이터수 구하기
SELECT regs, count(m2.regdate)
FROM (select TO_CHAR(regdate,'YYYY/MM') AS regs FROM member GROUP BY TO_CHAR(regdate,'YYYY/MM')) m1, member m2
WHERE TO_DATE(TO_CHAR(m2.regdate,'YYYY/MM'), 'yyyy/mm')<=TO_DATE(regs, 'yyyy/mm')
GROUP BY regs
ORDER BY regs;

-- 해당 월 이전까지의 누적 데이터수 구하기와 년, 월 구분
SELECT
    TO_CHAR(SUBSTR(regs, 1,4)) AS "year",
    TO_CHAR(SUBSTR(regs, 6,2)) AS "month",
    COUNT(m2.regdate) AS "cnt"
FROM (SELECT
          TO_CHAR(regdate,'YYYY/MM') AS regs
      FROM member
      GROUP BY TO_CHAR(regdate,'YYYY/MM')) m1,
    member m2
WHERE TO_DATE(TO_CHAR(m2.regdate,'YYYY/MM'), 'YYYY/MM')<=TO_DATE(regs, 'YYYY/MM')
GROUP BY regs
ORDER BY "year" ASC, "month" ASC;

-- 해당 년도 이전까지의 누적 데이터수 구하기
SELECT
    TO_CHAR(SUBSTR(regs, 1,4)) AS "year",
    COUNT(m2.regdate) AS "cnt"
FROM (SELECT
            TO_CHAR(regdate,'YYYY') AS regs
        FROM member
        GROUP BY TO_CHAR(regdate,'YYYY')) m1,
    member m2
WHERE TO_DATE(TO_CHAR(m2.regdate,'YYYY'), 'YYYY')<=TO_DATE(regs, 'YYYY')
GROUP BY regs
ORDER BY "year" ASC;

------------------------------------------------------------------------------------------------------------------
