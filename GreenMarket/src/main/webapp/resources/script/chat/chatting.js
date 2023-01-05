
function sendMessage(){
	
	let messageList = document.getElementById("messageBox");
	let message = document.getElementsByName("message")[0];

	$.ajax({
		type:"get",
		url:"chatting",
		data:{
			
		},
		datatype:"text",// 서버로 부터 응답 받을 데이터 타입  :: text, xml, json
		success:function(data){
			if(message.value!=''){
				let myText = document.createElement('div');
				myText.classList.add('messageBox');
				
				let myMessage = document.createElement('p');
				myMessage.classList.add('myMessage');
				
				myMessage.innerHTML = message.value;
				message.value = null;
			
				myText.appendChild(myMessage);
				messageList.appendChild(myText);
			}
			if(data!=null){
				let reciveText = document.createElement('div');
				reciveText.classList.add('messageBox');
				reciveText.classList.add('recive');
				
				let sendingMessage = document.createElement('p');
				sendingMessage.classList.add('myMessage');
				
				sendingMessage.innerHTML;
			
				reciveText.appendChild(sendingMessage);
				messageList.appendChild(reciveText);
			}
		},
		error:function(){
			alert('서버 에러! 전송이 되지 않았습니다.')
		},
		complate:function(){
			
		}
	});
	
	// let messageTemp = document.createElement('p');
	// messageTemp.classList.add('reciveMessage');
	
}