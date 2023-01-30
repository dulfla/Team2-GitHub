-- ä�ù��� ���� ��� ä�ù��� ���Ӱ� ������ִ� ���ν��� :: ���⼭ ���� �� �� - �����ϸ�
CREATE OR REPLACE PROCEDURE newChattingRoom(
    p_id IN chatInfomation.p_id%TYPE,
    email IN chatParticipants.sender_email%TYPE,
    c_id OUT chatInfomation.c_id%TYPE)
IS
    chatR chatInfomation.c_id%TYPE:= 'chat'||chatInfomation_seq.NEXTVAL;
BEGIN
    INSERT INTO chatInfomation VALUES(chatR, p_id);
    INSERT INTO chatParticipants VALUES(chatParticipants_seq.NEXTVAL, chatR, email, sysdate);
    c_id := chatR;
END;

------------------------------------------------------------------------------------------------------------------------

-- ä�ù� ������ ä�� ������ ������ �о�ͼ� �ش� ä�ù濡 ���� �޼����� ������ ���� ���ν���
CREATE OR REPLACE PROCEDURE chattingMessageSample
IS
    csor_c_id chatParticipants.c_id%TYPE;
    csor_sender_email chatParticipants.sender_email%TYPE;
    timeset DATE;
    CURSOR chattingRoomMember
    IS
        SELECT c_id, email AS "sender_email" FROM chatInfomation c, product p WHERE c.p_id=p.p_id
        UNION
        SELECT c_id, sender_email FROM chatParticipants;
BEGIN
    OPEN chattingRoomMember;
    LOOP
        FETCH chattingRoomMember INTO csor_c_id, csor_sender_email;
        EXIT WHEN chattingRoomMember%NOTFOUND;
        FOR  idx IN 1..15 LOOP
            timeset := TO_DATE('2022121017'||TO_CHAR(idx, '00')||TO_CHAR(ROUND(DBMS_RANDOM.VALUE(0, 59)), '00'), 'YYYYMMDDHH24MISS');
            INSERT INTO chatMessage
            VALUES(chatMessage_seq.NEXTVAL, csor_c_id, 'messageSample'||sampleMessage_seq.NEXTVAL, 'TEXT', csor_sender_email, 1, timeset);
        END LOOP;
    END LOOP;
    CLOSE chattingRoomMember;
END;

EXECUTE chattingMessageSample;

------------------------------------------------------------------------------------------------------------------------

-- ȸ�� ���� �����͸� �־��ִ� ���ν���
CREATE OR REPLACE PROCEDURE member_sampleDate
IS
    maxinput NUMBER:=5000;
    yearNum NUMBER(2);
    monthNum NUMBER(2);
    dayNum NUMBER(2);
    dayDate DATE;
BEGIN
    FOR idx  IN 1..maxinput LOOP
        yearNum:=ROUND(DBMS_RANDOM.VALUE(19, 22));
        monthNum:=ROUND(DBMS_RANDOM.VALUE(1, 12));
        dayNum:=ROUND(DBMS_RANDOM.VALUE(1, 28));
        dayDate:=TO_DATE('20'||yearNum||LPAD(to_char(monthNum),2, '0')||LPAD(to_char(dayNum),2, '0'), 'YYYY/MM/DD');
        
        INSERT INTO member
        VALUES('mail'||idx||'@naver.com',
               '1234', 19990101, '�ּ�'||idx,
               '010'||LPAD(to_char(idx),8, '0'),
               '�̸�'||idx,'ȸ��'||idx, 'U', dayDate);
    END LOOP;
END;

EXECUTE member_sampleDate;

------------------------------------------------------------------------------------------------------------------------

-- ���÷� ������ �Ϻ� ȸ���� Ż�� �����ϴ� ���ν���
CREATE OR REPLACE PROCEDURE withdraw_sampleDate
IS
    maxinput NUMBER:=500;
    nums NUMBER(4);
    deleteCheck NUMBER(1);
BEGIN
    FOR idx  IN 1..maxinput LOOP
        LOOP
            nums:=ROUND(DBMS_RANDOM.VALUE(1, 2000)); -- ���÷� ���� ������ �ִ�ġ�� ����
            SELECT COUNT(*) INTO deleteCheck FROM member WHERE email = 'mail'||nums||'@naver.com';
            IF 0<deleteCheck THEN
                DELETE member
                WHERE email='mail'||nums||'@naver.com';
                EXIT;
            END IF;
        END LOOP;
    END LOOP;
END;

EXECUTE withdraw_sampleDate;

------------------------------------------------------------------------------------------------------------------------

-- ����¡�� ��ǰ ���� ������ - productDetail tbl
CREATE OR REPLACE PROCEDURE product_sampleDate
IS
    maxinput NUMBER(3);
    priceVu productDetail.price%TYPE;
    randomN NUMBER(3);
    dayDate DATE;
    c category.category%TYPE;
    CURSOR categorys
        IS SELECT category FROM category;
BEGIN
    OPEN categorys;
    LOOP
        FETCH categorys INTO c;
        EXIT WHEN categorys%NOTFOUND;
        
        maxinput:=ROUND(DBMS_RANDOM.VALUE(10, 19))*5; -- *10
        FOR idx IN 1..maxinput LOOP
            priceVu:=ROUND(DBMS_RANDOM.VALUE(5000, 999999));
            randomN:=ROUND(DBMS_RANDOM.VALUE(1, 999));
            dayDate:=TO_DATE(sysdate-randomN);
            
            IF idx<=100 THEN
                INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
                VALUES('pid'||pid_seq.NEXTVAL, 'Product Sample'||pid_seq.CURRVAL, '��ǰ ����'||pid_seq.CURRVAL, c, dayDate, randomN, priceVu);
            ELSE
                INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price, trade)
                VALUES('pid'||pid_seq.NEXTVAL, 'Product Sample'||pid_seq.CURRVAL, '��ǰ ����'||pid_seq.CURRVAL, c, dayDate, randomN, priceVu, 'CLEAR');
            END IF;            
        END LOOP;
    END LOOP;
    CLOSE categorys;
END;

EXECUTE product_sampleDate;

-- ����¡�� ��ǰ ���� ������ - product tbl
CREATE OR REPLACE PROCEDURE product_who_sampleDate
IS
    lastSampleDate NUMBER:=6; -- SELECT pid_seq.CURRVAL INTO lastSampleDate FROM dual;
    num NUMBER(1);
    who product.email%TYPE;
    prodId productDetail.p_id%TYPE;
    CURSOR products
    IS
        SELECT p_id
        FROM productDetail
        WHERE lastSampleDate<TO_NUMBER(SUBSTR(p_id, 4))
        ORDER BY TO_NUMBER(SUBSTR(p_id, 4)) ASC;
BEGIN
    OPEN products;
    LOOP
        FETCH products INTO prodId;
        EXIT WHEN products%NOTFOUND;
        num:=ROUND(DBMS_RANDOM.VALUE(1, 5)); -- �ִ�ġ�� ���� �Է��� member ���� ������ ��ŭ.. �ƴϸ� Ư���ؼ�.?(�ƹ�ư �����ڴ� �ƴϰ�)
        SELECT email INTO who FROM (SELECT email, rn FROM (SELECT email, ROWNUM AS rn FROM member) WHERE rn=num);
        
        INSERT INTO product
        VALUES(pid_seq.NEXTVAL, who, prodId);
    END LOOP;
    CLOSE products;
END;

EXECUTE product_who_sampleDate;

-- �Ϻ� ��ǰ �ŷ��Ϸ�� �ٲٴ� ���ν���
CREATE OR REPLACE PROCEDURE product_trade_sampleDate
IS
    maxinput NUMBER(3);
    randomN NUMBER(3);
    prodId productDetail.p_id%TYPE;
    maxProd NUMBER;
BEGIN
    SELECT COUNT(*) INTO maxProd FROM productDetail;
    maxinput:=ROUND(DBMS_RANDOM.VALUE(10, 19))*2;
    FOR idx IN 1..maxinput LOOP
        randomN:=ROUND(DBMS_RANDOM.VALUE(1, maxProd-1));
        UPDATE productDetail
        SET trade='CLEAR'
        WHERE p_id='pid'||randomN;
    END LOOP;
END;

EXECUTE product_trade_sampleDate;

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