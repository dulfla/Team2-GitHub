let offCanvas = null;

let bton = null;
let activeBtn = null;
let sellChatRoomBtn = null;
let allChatRoomBtn = null;
let buyChatRoomBtn = null;

let messageBox = null;
let msg = null;

let roomBox = null;

let productId = null;
let chatRoomId = null;

let sock = null;

let personalId = null;

window.onload = function(){
	offCanvas = document.getElementById('offcanvasRight');

	bton = document.getElementById('chatRoomBtnGroup').childNodes;
	for(let i=0; i<bton.length; i++){
		if(i%2!=0){
			bton[i].addEventListener('click', function(e){
			activeBtn = e.currentTarget.getAttribute('type');
			chattingRoom();
		}, false);
		}
	}
	
	sellChatRoomBtn = document.getElementById('sellChatRoomBtn');
	allChatRoomBtn = document.getElementById('allChatRoomBtn');
	buyChatRoomBtn = document.getElementById('buyChatRoomBtn');
	
	roomBox = document.getElementById('chattingRooms');
	roomBox.innerHTML = null;

	offCanvas.classList.add('chattingRooms');
	
	window.onbeforeunload = function(event) { // 페이지 새로 고침, 창 닫기 시 채팅 서버랑 연결되어 있다면 해당 연결 끊기
		event.preventDefault();
		closeServer();
	};
	
	document.addEventListener('click', () => { // 오프캔버스를 닫을 경우 서버와 연결 끊기
		let activeE = document.activeElement;
		let body = document.getElementsByTagName('body')[0];
		if(activeE==body){
			closeServer();
		}
	}, false);
	
	let startBtn = document.getElementById('myChattings');
	startBtn.addEventListener('click', function (){
		activeBtn = "all";
		chattingRoom();
	}, false);
	
	let closeBtn = document.getElementById('closeBtn');
	closeBtn.addEventListener('click', closeServer, false);
}

function closeServer(){ // 오프캔버스를 닫을 때 동작할 기능
	if(offCanvas.classList.contains('show')){
		if(offCanvas.classList.contains('chattingOpen')){
			backToChattRooms();
		}else if(offCanvas.classList.contains('chattingRooms')){
			roomBox.innerHTML = null;
		}
	}
}

function chattingRoom(){
	$.ajax({
	    url: "SelectChatRooms",
	    type: "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
    	data : JSON.stringify({ // 해당되는 모든 채팅방을 가져올 구분자(상품 id)
    		p_id : productId,
    		email : personalId,
			type : activeBtn
    	}),
	    error: function(data) {
	    	console.log(JSON.stringify(data));
	    	console.log('통신실패!!');
	    },
	    success: function(data) { // 채팅방 리스트 보여주기
	    	if(data!=null){
				data.forEach((r) => {
					if(activeBtn=='all' || r.type==activeBtn){
						let aT = document.createElement('a');
						aT.classList.add('list-group-item', 'list-group-item-action', 'd-flex', 'gap-3', 'py-3');
						aT.setAttribute('aria-current', true);
						aT.setAttribute('connection', r.c_id);
	
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
						
						aT.addEventListener('click', openChatting, false);
					}
				});
	    	}else{

			}
	    }
	});
}

function backToChattRooms(){
	chattingClose();
	
	if(offCanvas.classList.contains('chattingOpen')){
		offCanvas.classList.remove('chattingOpen');
	}
	offCanvas.classList.add('chattingRooms');
	
	let offcanvasHeader = document.getElementsByClassName('offcanvas-header')[0];
	let backToChatRoomLBtn = document.getElementById('backBtn');
	offcanvasHeader.removeChild(backToChatRoomLBtn);

	let backPageBtn = document.createElement('button');
	backPageBtn.setAttribute('type', "button");
	backPageBtn.setAttribute('id', "closeBtn");
	backPageBtn.setAttribute('data-bs-dismiss', "offcanvas");
	backPageBtn.setAttribute('aria-label', "Close");
	backPageBtn.classList.add('btn-close');
	backPageBtn.addEventListener('click', closeServer, false);
	offcanvasHeader.appendChild(backPageBtn);

	let offcanvasBody = document.getElementsByClassName('offcanvas-body')[0];
	offcanvasBody.innerHTML = null;
	
	let chatRL = document.createElement('div');
	chatRL.setAttribute('id', "chatRoomList");
	chatRL.classList.add('overflow-auto', 'container');
	
	let listGroup = document.createElement('div');
	listGroup.setAttribute('id', "chattingRooms");
	listGroup.classList.add('list-group', 'w-auto', 'mt-2', 'h-100', 'mb-2');

	chatRL.appendChild(listGroup);
	offcanvasBody.appendChild(chatRL);
	
	roomBox = document.getElementById('chattingRooms');
}

function openChatting(e){
	let offcanvasHeader = document.getElementsByClassName('offcanvas-header')[0];
	let closeOffcavasBtn = document.getElementById('closeBtn');
	offcanvasHeader.removeChild(closeOffcavasBtn);

	let backPageBtn = document.createElement('button');
	backPageBtn.setAttribute('type', "button");
	backPageBtn.setAttribute('id', "backBtn");
	backPageBtn.addEventListener('click', () => {
		backToChattRooms();
		chattingRoom();
	}, false);
	backPageBtn.classList.add('backSpageBtn');
	backPageBtn.innerHTML = "←";
	offcanvasHeader.appendChild(backPageBtn);

	e.preventDefault();
	chatRoomId = null;
	chatRoomId = e.currentTarget.getAttribute('connection');
	if(offCanvas.classList.contains('chattingRooms')){
		offCanvas.classList.remove('chattingRooms');
	}
	offCanvas.classList.add('chattingOpen');

	let offcanvasBody = document.getElementsByClassName('offcanvas-body')[0];
	offcanvasBody.innerHTML = null;

	let msgBox = document.createElement('div');
	msgBox.classList.add("overflow-auto");
	msgBox.setAttribute('id', "messageBox");

	let messageBoxContainer = document.createElement('div');
	messageBoxContainer.classList.add('container', 'fixed-bottom');
	messageBoxContainer.setAttribute('id', "message");

	let inputGroup = document.createElement('div');
	inputGroup.classList.add('input-group', 'mt-2', 'p-0');

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
	offcanvasBody.appendChild(msgBox);
	offcanvasBody.appendChild(messageBoxContainer);

	messageBox = document.getElementById('messageBox');
	msg = document.getElementsByName('message')[0];

	connecteToSocket();
	chattingStart();
}

function msgNullcheck(){
	if(msg.value!=null && msg.value!=""){
		sendMessage();
	}
}

function enterSend(e){
	if(e.key=='Enter'){
		msgNullcheck();
	}
}

function connecteToSocket(){ // 채팅 서버 연결
	sock = new SockJS("http://localhost:8085/GreenMarket/server?c_id="+chatRoomId+"&email="+personalId); /************/
	sock.onmessage = onMessage;
	
	setTimeout(() => {
		$.ajax({
			url : "ConnecteWithClientServer",
			type : "POST",
		    dataType : 'text',
	    	contentType : 'application/json; charset=UTF-8',
			data : JSON.stringify({ 
				c_id : chatRoomId, 
				email : personalId
			}),
			error:function(){  
				console.log('서버와의 연결이 이어지지 않았습니다.'); 
			},
			success:function(data){
				if(data==1){console.log('서버와의 연결이 정상적으로 이어졌습니다.');}
				chattingStart();
			}
		});
	}, 500);
}

function chattingStart(){ // 기존에 메세지가 있었다면 해당 메세지들 긁어오기
	document.addEventListener('keydown', enterSend, false);
	document.getElementsByName("sendBtn")[0].addEventListener('click', msgNullcheck, false);
	$.ajax({
		url : "Chat",
		type : "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
		data : JSON.stringify({ 
			c_id : chatRoomId, 
			email : personalId
		}),
		error:function(){
			console.log('이전에 나눴던 메세지를 가져오지 못했습니다.'); 
		},
		success:function(messages){
			let msgL = messages.messages;
			msgL.forEach((m) => {
				if(m.sender == personalId){
					let myText = document.createElement('div');
					myText.classList.add('messageBox', 'myMessageBox');
					
					let myMessage = document.createElement('p');
					myMessage.classList.add('message', 'send');
					
					myMessage.innerHTML = m.message;
				
					myText.appendChild(myMessage);
					messageBox.appendChild(myText);
				}else{
					let reciveText = document.createElement('div');
					reciveText.classList.add('messageBox', 'reciveMessageBox');
					
					let sendingMessage = document.createElement('p');
					sendingMessage.classList.add('message', 'recive');
					
					sendingMessage.innerHTML = m.message;
					
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
	sock = null;
	
	document.removeEventListener('keydown', enterSend, false);
	document.getElementsByName("sendBtn")[0].removeEventListener('click', msgNullcheck, false);
	
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
		success:function(data){
			if(data==1){console.log('메세지 전달 완료')}
			
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

function onMessage(msg) {
	let data = msg.data.split(",");
	let msgInfo = [];
	for(let i=0; i<data.length; i++){
		let str = data[i].split(":");
		msgInfo.push(str);
	}
	
	let reciveText = document.createElement('div');
	reciveText.classList.add('messageBox', 'reciveMessageBox');
	
	let sendingMessage = document.createElement('p');
	sendingMessage.classList.add('message', 'recive');
	
	sendingMessage.innerHTML = msgInfo[2][1];
	
	reciveText.appendChild(sendingMessage);
	
	let nowPosition = messageBox.scrollTop;
	let result = approximateCheck(nowPosition);
	
	messageBox.appendChild(reciveText);
	
	scrollCheck(result);
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
