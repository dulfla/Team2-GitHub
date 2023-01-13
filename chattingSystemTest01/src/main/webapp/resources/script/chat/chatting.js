let messageBox;
let msg;

window.onload = function scroll(){
		
	let close = document.getElementById('close');
	close.addEventListener('click', () => {
		$.ajax({
			url : "BreakeOffClientServer",
			type : "POST",
			async : false,
			success:function(){   
				console.log('서버와의 연결이 정상적으로 해제되었습니다.');
				self.close();
			},   
			error:function(){  
				console.log('서버와의 연결이 해제되지 않았습니다.');
			}
		});
	}, false);
	
	messageBox = document.getElementById('messageBox');
	msg = document.getElementsByName('message')[0];
	
	messageBox.scrollTo(0, messageBox.scrollHeight);
	
	let message = document.getElementsByName("message")[0];
	message.addEventListener('change', (e) => {
		let sendBtn = document.getElementsByName("sendBtn")[0];
		if(e.currentTarget.value!=null && e.currentTarget.value!=""){
			sendBtn.addEventListener('click', sendMessage, false);
		}else{
			sendBtn.removeEventListener('click', sendMessage);
		}
	}, false);
	
}

function sendMessage(){
	
	$.ajax({
		url:"SendMessage",
		type:"POST",
		contentType:'application/json; charset=UTF-8',
		data : JSON.stringify({
			c_id : "chat26",
    		p_id : "pid2",
    		email : "hong@naver.com",
    		message : msg.value
    	}),
    	error:function(){
			console.log('통신실패!!');
		},
		success:function(){
			let myText = document.createElement('div');
			myText.classList.add('messageBox', 'myMessageBox');
			
			let myMessage = document.createElement('p');
			myMessage.classList.add('message', 'myMessage');
			
			myMessage.innerHTML = msg.value;
			msg.value = null;
		
			myText.appendChild(myMessage);
			messageBox.appendChild(myText);
			
			scrollCheck(true);
		},
		complate:function(){
			
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


/*
	
	let messageTemp = document.createElement('p');
	messageTemp.classList.add('reciveMessage');
	
	if(data!=null){
		let reciveText = document.createElement('div');
		reciveText.classList.add('messageBox');
		reciveText.classList.add('recive');
		
		let sendingMessage = document.createElement('p');
		sendingMessage.classList.add('myMessage');
		
		sendingMessage.innerHTML = data.message;
		
		let nowPosition = messageBox.scrollTop;
		let result = approximateCheck(nowPosition);
		
		reciveText.appendChild(sendingMessage);
		messageList.appendChild(reciveText);
	}
	
*/