-- memberHistory 자동 작성 트리거
CREATE OR REPLACE TRIGGER memberAdmin
BEFORE INSERT OR DELETE
    ON member
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO memberHistory
        VALUES(memberTracking_seq.NEXTVAL, :NEW.email,:NEW.regdate, 'IN'); -- sysdate 여야 함
    ELSIF DELETING THEN
        INSERT INTO memberHistory
        VALUES(memberTracking_seq.NEXTVAL, :OLD.email,:OLD.regdate, 'OUT'); -- sysdate 여야 함
    END IF;
END memberAdmin;

-- productHistory 자동 작성 트리거 
CREATE OR REPLACE TRIGGER trackingProduct
BEFORE INSERT OR UPDATE OR DELETE
    ON productDetail
FOR EACH ROW
BEGIN
    IF inserting THEN
        INSERT INTO productHistory
        VALUES(productTracking_seq.NEXTVAL, :NEW.p_id, :NEW.category, :NEW.regdate, 'IN');
    ELSIF updating THEN
        IF :NEW.trade='CLEAR' OR :NEW.trade='clear' THEN
            INSERT INTO productHistory
            VALUES(productTracking_seq.NEXTVAL, :OLD.p_id, :NEW.category, :OLD.regdate, 'TRADE'); -- sysdate 여야 함
        END IF;
    ELSIF deleting THEN
        INSERT INTO productHistory
        VALUES(productTracking_seq.NEXTVAL, :OLD.p_id, :OLD.category, :OLD.regdate, 'OUT'); -- sysdate 여야 함
    END IF;
END;

-- category pk 수정시 외래키 자동 수정 트리거
CREATE OR REPLACE TRIGGER categoryChange
AFTER UPDATE ON category
FOR EACH ROW
BEGIN
    IF updating THEN
        IF :NEW.category<>:OLD.category THEN
            UPDATE productHistory
            SET category = :NEW.category
            WHERE category=:OLD.category;
            
            UPDATE productDetail
            SET category = :NEW.category
            WHERE category=:OLD.category;
        END IF;
    END IF;
END;