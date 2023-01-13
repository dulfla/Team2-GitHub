
let messageBox;
let msg;

let productId;
let chatRoomId;

// window.sessionStorage;
// let email = sessionStorage.getItem("authInfo");
// console.log(email)

window.onload = function(){
	messageBox = document.getElementById('messageBox');
	messageBox.innerHTML = null;
	
	productId = null;
	chatRoomId = null;

	msg = document.getElementsByName('message')[0];
	msg.addEventListener('change', (e) => {
		let sendBtn = document.getElementsByName("sendBtn")[0];
		if(e.currentTarget.value!=null && e.currentTarget.value!=""){
			sendBtn.addEventListener('click', sendMessage, false);
		}else{
			sendBtn.removeEventListener('click', sendMessage);
		}
	}, false);

	let chattingBtn = document.getElementById('openChattingBtn');
	chattingBtn.addEventListener('click', chatting, false);
	
	let closeBtn = document.getElementById('closeBtn');
	closeBtn.addEventListener('click', chattingClose, false);
}

function chatting(prod_id){
	prod_id = "pid2"
	$.ajax({
	    url: "ChatRoomCheck",
	    type: "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
    	data : JSON.stringify({ // 연결할 채팅방 아이디 확인
    		p_id : prod_id
    	}),
	    error: function() {
	    	console.log('통신실패!!');
	    },
	    success: function(data) { // 채팅방으로 연결
	    	if(data!=null){
	    		chatRoomId = data.map.chattingRoomId;
	    		connecteToSocket();
	    	}
	    }
	});
}

function connecteToSocket(){
	$.ajax({
		url : "ConnecteWithClientServer",
		type : "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
		data : JSON.stringify({ c_id : chatRoomId }),
		error:function(){  
			console.log('서버와의 연결이 이어지지 않았습니다.'); 
		},
		success:function(data){
			if(data==1){console.log('서버와의 연결이 정상적으로 이어졌습니다.');}
			chattingStart();
		}
	});
}

function chattingStart(){
	$.ajax({
		url : "Chat",
		type : "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
		data : JSON.stringify({ c_id : chatRoomId }),
		error:function(){  
			console.log('이전에 나눴던 메세지를 가져오지 못했습니다.'); 
		},
		success:function(messages){
			messageBox.innerHTML = null;
			let msgL = messages.map.messages.myArrayList;
			msgL.forEach((msgL) => {
				if(msgL.map.sender == 'hong@naver.com'){
					let myText = document.createElement('div');
					myText.classList.add('messageBox', 'myMessageBox');
					
					let myMessage = document.createElement('p');
					myMessage.classList.add('message', 'send');
					
					myMessage.innerHTML = msgL.map.message;
				
					myText.appendChild(myMessage);
					messageBox.appendChild(myText);
				}else{
					let reciveText = document.createElement('div');
					reciveText.classList.add('messageBox', 'reciveMessageBox');
					
					let sendingMessage = document.createElement('p');
					sendingMessage.classList.add('message', 'recive');
					
					sendingMessage.innerHTML = msgL.map.message;
					
					let nowPosition = messageBox.scrollTop;
					let result = approximateCheck(nowPosition);
					
					reciveText.appendChild(sendingMessage);
					messageBox.appendChild(reciveText);
				}
			});
		},
		complete: function(){
			messageBox.scrollTo(0, messageBox.scrollHeight);
		}
	});	
}

function chattingClose(){
	$.ajax({
		url : "BreakeOffClientServer",
		method : "POST",
		async : false,
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
		data : JSON.stringify({ c_id : chatRoomId }),
		success:function(){   
			console.log('서버와의 연결이 정상적으로 해제되었습니다.');
		},   
		error:function(){
			console.log('서버와의 연결이 해제되지 않았습니다.');
		}
	});
}

function sendMessage(){
	$.ajax({
		url:"SendMessage",
		method:"POST",
		contentType:'application/json; charset=UTF-8',
		async : false,
		data : JSON.stringify({
			c_id : chatRoomId,
    		p_id : "pid2",
    		message : msg.value
    	}),
    	error:function(){
			alert('서버 연결에 문제가 생겨 메세지가 전송되지 않았습니다.');
		},
		success:function(){
			let myText = document.createElement('div');
			myText.classList.add('messageBox', 'myMessageBox');
			
			let myMessage = document.createElement('p');
			myMessage.classList.add('message', 'send');
			
			myMessage.innerHTML = msg.value;
			msg.value = null;
		
			myText.appendChild(myMessage);
			messageBox.appendChild(myText);
			
			scrollCheck(true);
		}
	});
}

function scrollCheck(result){
	if(result){
		messageBox.scrollTo(0, messageBox.scrollHeight);
	}else{
		messagePopup();
	}
}

function approximateCheck(nowPosition){
	let originPosition = messageBox.scrollHeight-messageBox.offsetHeight;
	if(originPosition==nowPosition | originPosition-nowPosition<=5){
		return true;
	}else{
		return false;
	}
}
