window.onload = function scroll(){
	let messageBox = document.getElementById('messageBox');
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

	let messageList = document.getElementById("messageBox");
	let message = document.getElementsByName("message")[0];
	
	$.ajax({
		url:"SendMessage",
		type:"POST",
		contentType:'application/json; charset=UTF-8',
		data : JSON.stringify({
			c_id : "chat26",
    		p_id : "pid2",
    		email : "hong@naver.com"
    	}),
    	error:function(){
			console.log('통신실패!!');
		},
		success:function(){
			let myText = document.createElement('div');
			myText.classList.add('messageBox', 'myMessageBox');
			
			let myMessage = document.createElement('p');
			myMessage.classList.add('message', 'myMessage');
			
			myMessage.innerHTML = message.value;
			message.value = null;
		
			let nowPosition = messageBox.scrollTop;
			let result = approximateCheck(nowPosition);
			
			myText.appendChild(myMessage);
			messageList.appendChild(myText);
			
			scrollCheck(result);
		},
		complate:function(){
			
		}
	});
	
	// let messageTemp = document.createElement('p');
	// messageTemp.classList.add('reciveMessage');
	
	//	if(data!=null){
	//		let reciveText = document.createElement('div');
	//		reciveText.classList.add('messageBox');
	//		reciveText.classList.add('recive');
	//		
	//		let sendingMessage = document.createElement('p');
	//		sendingMessage.classList.add('myMessage');
	//		
	//		sendingMessage.innerHTML;
	//	
	//		reciveText.appendChild(sendingMessage);
	//		messageList.appendChild(reciveText);
	//	}
	
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