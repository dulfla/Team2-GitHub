update chatMessage
set read=1
where c_id='chat1' AND idx<=10;

UPDATE chatMessage
SET read=1
WHERE send_date<=sysdate;

select * from chatMessage
order by send_date DESC;