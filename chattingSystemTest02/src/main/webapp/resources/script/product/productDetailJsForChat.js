let memberType;

let messageBox;
let msg;

let roomBox;

let productId;
let chatRoomId;

let personalId; /* 임시 */

window.onload = function(){
	memberType = document.getElementById('offcanvasRight').getAttribute('type'); // 들어온 사람이 판매자 본인인지 다른 회원(구매 희망자 이하 구매자)인지 구분
	productId = "pid2"; /* 임시 */ // document.getElementById('').value;
	chatRoomId = null;

	if(memberType=='buy'){ // 첫 접속에 메세지 박스가 있으려면 일단 구매자여야 함
		roomBox = null;
		messageBox = document.getElementById('messageBox');
		messageBox.innerHTML = null;
		msg = document.getElementsByName('message')[0];
		setMsgChangeCheck(); // 구매자가 들어온 경우, 메세지 입력장이 비어있는 상태로 보내려고 하는지 확인하는 기능 등록
	}else if(memberType=='sell'){
		messageBox = null;
		roomBox = document.getElementById('chattingRooms');
		roomBox.innerHTML = null;
	}

	window.onbeforeunload = function(event) { // 페이지 새로 고침, 창 닫기 시 채팅 서버랑 연결되어 있다면 해당 연결 끊기
		event.preventDefault();
		if(memberType=='buy'){ // 구매자라면, 오프캔버스 창이 열려있을 경우 무조건 서버랑 연결된 상태임. :: 캔버스가 열린 채로 새로고침 하거나 나간다면 무조건 연결 끊기
			if(offCanvas.classList.contains('show')){
				chattingClose();
			}
		}else if(memberType=='sell'){ // 판매자라면, 캔버스가 열려 있어도 서버랑 연결은 안 되어 있을 수 있음. :: 해당 창이 채팅방에 접속 상태인지 확인 후 채팅방 접속 상태일 때만 연결 끊기
			if(offCanvas.classList.contains('show') && offCanvas.classList.contains('chattingOpen')){
				chattingClose();
			}
		}
	};

	let offCanvas = document.getElementById('offcanvasRight');
	document.addEventListener('click', (e) => { // 오프캔버스를 닫을 경우 서버와 연결 끊기
		let activeE = document.activeElement;
		let body = document.getElementsByTagName('body')[0];
		if(activeE==body){
			if(memberType=='buy'){ // 구매자라면, 캔버스는 무조건 채팅창 연결이므로 캔버스를 닫을 경우 무조건 서버 연결 닫기
				if(offCanvas.classList.contains('show')){
					chattingClose();
				}
			}else if(memberType=='sell'){ // 판매자라면, 캔버스가 열려 있어도 채팅서버 연결이 아닐 수 있으므로 해당 창이 채팅방에 접속 상태인지 확인 후 연결 끊기
				if(offCanvas.classList.contains('show') && offCanvas.classList.contains('chattingOpen')){
					chattingClose();
				}
			}
		}
	}, false);


	let chattingBtn = document.getElementById('openChattingBtn');
	chattingBtn.addEventListener('click', function (){ // 채팅 버튼을 클릭 했을 때 오프캔버스에 띄울 기능
		if(memberType=='buy'){ // 구매자라면 바로 채팅기능으로 넘기기
			chatting();
		}else if(memberType=='sell'){ // 판매자라면 해당 상품에 대한 모든 채팅방을 먼저 보여주고 해당 채팅방에서 골라 들어가게 작성
			chattingRoom();
		}
	}, false);
	
	let closeBtn = document.getElementById('closeBtn');
	closeBtn.addEventListener('click', function (){ // 오프캔버스 닫기를 클릭 했을 때 동작할 기능
		if(memberType=='buy'){ // 구매자라면 바로 서버 연결 해제
			chattingClose();
		}else if(memberType=='sell'){ // 판매자라면 해당 오프캔버스가 채팅일 경우 서버를 끊고 다시 채팅방으로, 채팅방일 경우 오프캔버스 닫기만 작동
			/* 아직 안 만듦 */
		}
	}, false);
}

function chattingRoom(){
	$.ajax({
	    url: "SelectChatRoom", /* 서버가서 만들어야 함 */
	    type: "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
    	data : JSON.stringify({ // 해당되는 모든 채팅방을 가져올 구분자(상품 id)
    		p_id : productId,
    		email : personalId /* 임시 */
    	}),
	    error: function() {
	    	console.log('통신실패!!');
	    },
	    success: function(data) { // 채팅방 리스트 보여주기
	    	if(data!=null){
				let room = data.map.chattingRoomList.myArrayList;
				room.forEach((r) => {
					let aT = document.createElement('a');
					aT.classList.add('list-group-item', 'list-group-item-action', 'd-flex', 'gap-3', 'py-3');
					aT.setAttribute('aria-current', true);
					aT.setAttribute('connection', r.map.c_id);

					let imgT = document.createElement('img');
					imgT.setAttribute('src', 'https://github.com/twbs.png');
					imgT.setAttribute('alt', '임시 사진');
					imgT.classList.add('rounded-circle', 'flex-shrink-0', 'chatRoomImg');

					let expressZone = document.createElement('div');
					expressZone.classList.add('d-flex', 'gap-2', 'w-100', 'justify-content-between');

					let textZone = document.createElement('div');

					let h6T = document.createElement('h6');
					h6T.classList.add('mb-0');
					h6T.innerHTML = '뭘 써야 할까나';

					let pT = document.createElement('p');
					pT.classList.add('mb-0', 'opacity-75' ,'h6');
					pT.innerHTML = '호로로로로로롤ㄹ로';

					let smallT = document.createElement('small')
					smallT.classList.add('opacity-50', 'text-nowrap');

					textZone.appendChild(h6T);
					textZone.appendChild(pT);
					expressZone.appendChild(textZone);
					expressZone.appendChild(smallT);
					aT.appendChild(imgT);
					aT.appendChild(expressZone);

					roomBox.appendChild(aT);
					
					aT.addEventListener('click', (e) => {
						e.preventDefault();
						chatRoomId = null;
						chatRoomId = e.currentTarget.getAttribute('connection');

						let offcanvasBody = document.getElementsByClassName('offcanvas-body')[0];
						offcanvasBody.innerHTML = null;

						let messageBox = document.createElement('div');
						messageBox.classList.add("overflow-auto");
						messageBox.setAttribute('id', "messageBox");

						let messageBoxContainer = document.createElement('div');
						messageBoxContainer.classList.add('container', 'fixed-bottom');
						messageBoxContainer.setAttribute('id', "message");

						let inputGroup = document.createElement('div');
						inputGroup.classList.add('input-group', 'mt-2', 'p-0', 'bg-light');

						let addFileBtn = document.createElement('button');
						addFileBtn.classList.add('btn', 'btn-outline-secondary');
						addFileBtn.setAttribute('type', "button");
						addFileBtn.setAttribute('id', "button-addon1");
						addFileBtn.innerHTML = "+";

						let messageInput = document.createElement('input');
						messageInput.classList.add('form-control');
						messageInput.setAttribute('type', "text");
						messageInput.setAttribute('placeholder', "메세지를 입력하세요");
						messageInput.setAttribute('name', "message");
						messageInput.setAttribute('aria-label', "message");
						messageInput.setAttribute('aria-describedby', "basic-addon1");

						let sendBtn = document.createElement('button');
						sendBtn.classList.add('input-group-text');
						sendBtn.setAttribute('name', "sendBtn");
						sendBtn.setAttribute('id', "basic-addon1");
						sendBtn.innerHTML = "전송";

						inputGroup.appendChild(addFileBtn);
						inputGroup.appendChild(messageInput);
						inputGroup.appendChild(sendBtn);
						messageBoxContainer.appendChild(inputGroup);
						offcanvasBody.appendChild(messageBox);
						offcanvasBody.appendChild(messageBoxContainer);

						
					}, false);
				});
	    	}else{

			}
	    }
	});
}

function setMsgChangeCheck(){
	msg.addEventListener('change', (e) => { // 메세지 입력란이 공백이 아닐 때만 보낼 수 있음
		let sendBtn = document.getElementsByName("sendBtn")[0];
		if(e.currentTarget.value!=null && e.currentTarget.value!=""){
			sendBtn.addEventListener('click', sendMessage, false);
		}else{
			sendBtn.removeEventListener('click', sendMessage);
		}
	}, false);
}

function chatting(){ // 채팅방 연결 - 채팅방이 있으면 해당 채팅방으로, 없으면 새로운 채팅방으로
	personalId = document.getElementById('email').value; /* 임시 */
	$.ajax({
	    url: "ChatRoomCheck",
	    type: "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
    	data : JSON.stringify({ // 연결할 채팅방 아이디 확인
    		p_id : productId,
    		email : personalId /* 임시 */
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

function connecteToSocket(){ // 채팅 서버 연결
	$.ajax({
		url : "ConnecteWithClientServer",
		type : "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
		data : JSON.stringify({ 
			c_id : chatRoomId, 
			email : personalId /* 임시 */
		}),
		error:function(){  
			console.log('서버와의 연결이 이어지지 않았습니다.'); 
		},
		success:function(data){
			if(data==1){console.log('서버와의 연결이 정상적으로 이어졌습니다.');}
			chattingStart();
		}
	});
}

function chattingStart(){ // 기존에 메세지가 있었다면 해당 메세지들 긁어오기
	$.ajax({
		url : "Chat",
		type : "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
		data : JSON.stringify({ 
			c_id : chatRoomId, 
			email : personalId /* 임시 */
		}),
		error:function(){  
			console.log('이전에 나눴던 메세지를 가져오지 못했습니다.'); 
		},
		success:function(messages){
			let msgL = messages.map.messages.myArrayList;
			msgL.forEach((m) => {
				if(m.map.sender == personalId){ /* 임시 */
					let myText = document.createElement('div');
					myText.classList.add('messageBox', 'myMessageBox');
					
					let myMessage = document.createElement('p');
					myMessage.classList.add('message', 'send');
					
					myMessage.innerHTML = m.map.message;
				
					myText.appendChild(myMessage);
					messageBox.appendChild(myText);
				}else{
					let reciveText = document.createElement('div');
					reciveText.classList.add('messageBox', 'reciveMessageBox');
					
					let sendingMessage = document.createElement('p');
					sendingMessage.classList.add('message', 'recive');
					
					sendingMessage.innerHTML = m.map.message;
					
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

function chattingClose(){ // 서버 연결 끊고, messageBox 비우기
	$.ajax({
		url : "BreakeOffClientServer",
		method : "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
		data : JSON.stringify({ 
			c_id : chatRoomId, 
			email : personalId /* 임시 */
		}),
		success:function(){   
			console.log('서버와의 연결이 정상적으로 해제되었습니다.');
			messageBox.innerHTML = null;
		},   
		error:function(){
			console.log('서버와의 연결이 해제되지 않았습니다.');
		}
	});
}

function sendMessage(){ // 메세지 보내기
	$.ajax({
		url:"SendMessage",
		method:"POST",
		contentType:'application/json; charset=UTF-8',
		data : JSON.stringify({
			c_id : chatRoomId,
    		p_id : productId,
    		email : personalId, /* 임시 */
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

function scrollCheck(result){ // 스크롤이 맨 아래에 있다면 새 메세지를 보내거나 받았을 때 스크롤을 아래로 고정, 맨 아래가 아니라면 위치 그대로에, 메세지 보내고, 팝업 띄우기
	if(result){
		messageBox.scrollTo(0, messageBox.scrollHeight);
	}else{
		messagePopup();
	}
}

function approximateCheck(nowPosition){ // 위치 확인 - 맨 아래 스크롤과의 차이가 5 이하라면 맨 아래라고 인식, 그 이상 차이 난다면 팝업으로 전환
	let originPosition = messageBox.scrollHeight-messageBox.offsetHeight;
	if(originPosition==nowPosition | originPosition-nowPosition<=5){
		return true; // 스크롤 맨 아래
	}else{
		return false; // 스크롤 위치 변경됨
	}
}
