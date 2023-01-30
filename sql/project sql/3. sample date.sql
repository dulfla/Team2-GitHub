-- ī�װ�
INSERT INTO category VALUES('������ ���', '������ ���.png');
INSERT INTO category VALUES('��Ȱ����', '��Ȱ����.png');
INSERT INTO category VALUES('��Ȱ�ֹ�', '��Ȱ�ֹ�.png');
INSERT INTO category VALUES('���Ƶ�', '���Ƶ�.png');
INSERT INTO category VALUES('�Ƿ�', '�Ƿ�.png');
INSERT INTO category VALUES('��ȭ', '��ȭ.png');
INSERT INTO category VALUES('��Ƽ?�̿�', '��Ƽ?�̿�.png');
INSERT INTO category VALUES('���?����?����', '���?����?����.png');
INSERT INTO category VALUES('����', '����.png');
INSERT INTO category VALUES('�߰���', '�߰���.png');
INSERT INTO category VALUES('������ǰ', '������ǰ.png');
INSERT INTO category VALUES('�ݷ����� ��ǰ', '�ݷ����� ��ǰ.png');
INSERT INTO category VALUES('��Ÿ �߰�ǰ', '��Ÿ �߰�ǰ.png');

------------------------------------------------------------------------------------------------------------------------

-- ȸ�� ��
INSERT INTO member(email, password,birth, address, phone,name,nickname)
VALUES('hong@naver.com','1234',19990305,'��⵵�Ȼ��','0103455555','ȫ�浿','�浿��1');
INSERT INTO member(email, password,birth, address, phone,name,nickname)
VALUES('lee@naver.com','1234',19970205,'��⵵�����','0103455556','�̱浿','�浿��2');
INSERT INTO member(email, password,birth, address, phone,name,nickname)
VALUES('pack@naver.com','1234',19990105,'��⵵�Ȼ��','0103455557','�ڱ浿','�浿��3');
INSERT INTO member(email, password,birth, address, phone,name,nickname)
VALUES('jeong@naver.com','1234',19890506,'��⵵�Ȼ��','0103455558','���浿','�浿��4');
INSERT INTO member(email, password,birth, address, phone,name,nickname)
VALUES('choi@naver.com','1234',19900312,'��⵵�Ȼ��','0103455559','�ֱ浿','�浿��5');

INSERT INTO member(email, password,birth, address, phone,name,nickname,type)
VALUES('manager@naver.com','1234',19970205,'��⵵�����','0103455556','������','ȫ�Ǽ�','M');

------------------------------------------------------------------------------------------------------------------------

-- ��ǰ ��
INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'��ǻ��','�ֽ��� ��ǻ���Դϴ�','������ ���','2022/05/30',0,1000000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'hong@naver.com', 'pid'||pid_seq.CURRVAL);

INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'K5','���� �����ϴ�','�߰���','2022/11/13',1,30000000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'lee@naver.com', 'pid'||pid_seq.CURRVAL);

INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'����','���� ��','��ȭ','2022/09/20',60,500000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'pack@naver.com', 'pid'||pid_seq.CURRVAL);

INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'��','�� 2�ڽ� �Դϴ�','�ݷ����� ��ǰ','2022/11/03',0,15000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'jeong@naver.com', 'pid'||pid_seq.CURRVAL);

INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'������ �ƽ�','������ �ƽ� �̰��� ��ǰ�Դϴ�','������ ���','2022/12/25',115,600000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'choi@naver.com', 'pid'||pid_seq.CURRVAL);

INSERT INTO productDetail(p_id, p_name, description, category, regdate, views, price)
VALUES('pid'||pid_seq.NEXTVAL,'������','������ �ƽ� �̰��� ��ǰ�Դϴ�','������ ���','2022/01/25',115,500000);
INSERT INTO product
VALUES(product_seq.NEXTVAL, 'pack@naver.com', 'pid'||pid_seq.CURRVAL);

------------------------------------------------------------------------------------------------------------------------

-- �˻���
INSERT INTO search(idx, keyword, email)
VALUES(search_seq.NEXTVAL, 'ddd', 'hong@naver.com');
INSERT INTO search(idx, keyword, email)
VALUES(search_seq.NEXTVAL, 'dddd', 'lee@naver.com');
INSERT INTO search(idx, keyword, email)
VALUES(search_seq.NEXTVAL, 'ddddd', 'jeong@naver.com');

------------------------------------------------------------------------------------------------------------------------

-- ä��
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