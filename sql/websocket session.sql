create table websocketsessionmanagement(
    c_id VARCHAR2(50),
    email VARCHAR2(50),
    session_id  VARCHAR2(50) CONSTRAINT websocket_pk PRIMARY KEY
);

ALTER TABLE websocketsessionmanagement
ADD CONSTRAINT websocketsession_fk_c_id FOREIGN KEY(c_id) REFERENCES chatInfomation(c_id) ON DELETE CASCADE
ADD CONSTRAINT websocketsession_fk_email FOREIGN KEY(email) REFERENCES member(email) ON DELETE CASCADE;

select * from websocketsessionmanagement;
delete websocketsessionmanagement;

commit;


SELECT * FROM productPic
		    	WHERE uuid = (SELECT min(uuid)
		    					FROM productPic
		    					WHERE p_id='pid1'
		    					GROUP BY p_id)