
function chatting(prod_id){
	prod_id = "pid2"
	$.ajax({
	    url: "chatRoomCheck",
	    method: "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
    	data : JSON.stringify({ // 연결할 채팅방 아이디 확인
    		p_id : prod_id
    	}),
	    error: function() {
	    	console.log('통신실패!!');
	    },
	    success: function(data) { // 채팅방으로 연결
	    	let url="Chat?c="+data.map.chattingRoomId;
		    let w = 450;
		    let h = 600;
		    let popupX = (window.screen.width/2)-(w/2);
		    let popupY = (window.screen.height/2)-(h/2);
		
		    window.open(url, '_blank_1',
				'toolbar=no, menubar=no, scrollbars=yes, resizeable=no'+
				', width='+w+', height='+h+', left='+popupX+', top='+popupY);
	    }
	});

}

function eixt(){
	self.close();
}