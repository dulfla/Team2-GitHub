let offCanvs = null;

let bton = null;
let activeBtn = null;

let messagesBox = null;
let msge = null;

let roomsBox = null;

let chatRId = null;

let socket = null;

let personId = null;

window.addEventListener('load', function() {
	offCanvs = document.getElementById('offcanvasRight chatRoomOffcanvas');
	
	bton = document.getElementById('chatRoomBtnGroup').childNodes;
	for(let i=0; i<bton.length; i++){
		if(i%2!=0){
			bton[i].addEventListener('click', function(e){
				activeBtn = e.currentTarget.getAttribute('chatType');
				if(offCanvs.classList.contains('chattingRoom')){
					chattingRooms();
				}else if(offCanvs.classList.contains('chattings')){
					backToChattRoom();
					chattingRooms();
				}
		}, false);
		}
	}
	
	roomsBox = document.getElementById('chatRooms');
	roomsBox.innerHTML = null;
	
	let startBtn = document.getElementById('myChattings');
	startBtn.addEventListener('click', function (){
		personalId = document.getElementById('authInfo_email').value;
		activeBtn = "all";
		chattingRooms();
	}, false);
	
	window.onbeforeunload = function(event) {
		if(offCanvs.classList.contains('show')){
			event.preventDefault();
			shotServer();
		}
	};
	
	document.addEventListener('click', () => {
		let activeE = document.activeElement;
		let body = document.getElementsByTagName('body')[0];
		if(activeE==body){
			shotServer();
		}else if(activeE==startBtn){
			if(offCanvs.classList.contains('show')){
				shotServer();
			}else{
				let chattingOffcanvs = document.getElementById('offcanvasRight chatOffcanvas');
				if(chattingOffcanvs){
					if(chattingOffcanvs.classList.contains('show')){
						chattingOffcanvs.classList.toggle('show');
					}
				}
				offCanvs.classList.add('show');
			}
		}
	}, false);
	
	let closeBtn = document.getElementById('closeB');
	closeBtn.addEventListener('click', shotServer, false);
});

function shotServer(){
	if(offCanvs.classList.contains('show')){
		if(offCanvs.classList.contains('chattings')){
			backToChattRoom();
			offCanvs.classList.toggle('show');
		}else if(offCanvs.classList.contains('chattingRoom')){
			roomsBox.innerHTML = null;
			offCanvs.classList.toggle('show');
		}
	}
}

function chattingRooms(){
	roomsBox.innerHTML = null;
	$.ajax({
	    url: "SelectChatRooms",
	    type: "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
	    error: function(data) {
	    	console.log(JSON.stringify(data));
	    	console.log('통신실패!!');
	    },
	    success: function(dt) { // 채팅방 리스트 보여주기
    		personId = dt.person;
	    	if(0<dt.data.length){
				dt.data.forEach((r) => {
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
						h6T.innerHTML = r.p_name;
	
						let pT = document.createElement('p');
						pT.classList.add('mb-0', 'opacity-75' ,'h6');
						pT.innerHTML = "<small><i>with,</i></small> "+r.chatMember;
	
						let smallT = document.createElement('small')
						smallT.classList.add('opacity-50', 'text-nowrap');
	
						textZone.appendChild(h6T);
						textZone.appendChild(pT);
						expressZone.appendChild(textZone);
						expressZone.appendChild(smallT);
						aT.appendChild(imgT);
						aT.appendChild(expressZone);
	
						roomsBox.appendChild(aT);
						
						aT.addEventListener('click', openChattings, false);
					}
				});
	    	}else{
				let div = document.createElement('div');
				div.innerHTML = "현재 참여중인 채팅이 없습니다.";
				roomsBox.appendChild(div);
			}
			
			if(roomsBox.innerHTML==null || roomsBox.innerHTML==''){
				let div = document.createElement('div');
				div.innerHTML = "현재 참여중인 채팅이 없습니다.";
				roomsBox.appendChild(div);
			}
	    }
	});
}

function backToChattRoom(){
	chatClose();
	
	document.removeEventListener('keydown', enterSending);
	document.getElementsByName("sendB")[0].removeEventListener('click', msgeNullcheck);
	
	if(offCanvs.classList.contains('chattings')){
		offCanvs.classList.remove('chattings');
	}
	offCanvs.classList.add('chattingRoom');
	
	let offcanvasHeader = document.getElementsByClassName('offcanvas-header chatRoomOffcanvas')[0];
	let backToChatRoomLBtn = document.getElementById('backB');
	offcanvasHeader.removeChild(backToChatRoomLBtn);

	let backPageBtn = document.createElement('button');
	backPageBtn.setAttribute('type', "button");
	backPageBtn.setAttribute('id', "closeB");
	backPageBtn.setAttribute('data-bs-dismiss', "offcanvas");
	backPageBtn.setAttribute('aria-label', "Close");
	backPageBtn.classList.add('btn-close');
	backPageBtn.addEventListener('click', shotServer, false);
	offcanvasHeader.appendChild(backPageBtn);

	let offcanvasBody = document.getElementsByClassName('offcanvas-body chatRoomOffcanvas')[0];
	offcanvasBody.innerHTML = null;
	
	let chatRL = document.createElement('div');
	chatRL.setAttribute('id', "chatRoomList");
	chatRL.classList.add('overflow-auto', 'container');
	
	let listGroup = document.createElement('div');
	listGroup.setAttribute('id', "chatRooms");
	listGroup.classList.add('list-group', 'w-auto', 'mt-2', 'h-100', 'mb-2');

	chatRL.appendChild(listGroup);
	offcanvasBody.appendChild(chatRL);
	
	roomsBox = document.getElementById('chatRooms');
}

function openChattings(e){
	if(offCanvs.classList.contains('chattingRoom')){
		offCanvs.classList.remove('chattingRoom');
	}
	offCanvs.classList.add('chattings');
	
	let offcanvasHeader = document.getElementsByClassName('offcanvas-header chatRoomOffcanvas')[0];
	let closeOffcavasBtn = document.getElementById('closeB');
	offcanvasHeader.removeChild(closeOffcavasBtn);

	let backPageBtn = document.createElement('a');
	backPageBtn.setAttribute('id', "backB");
	backPageBtn.addEventListener('click', (e) => {
		e.preventDefault()
		backToChattRoom();
		chattingRooms();
	}, false);
	backPageBtn.classList.add('backSpageBtn');
	backPageBtn.innerHTML = "←";
	offcanvasHeader.appendChild(backPageBtn);

	e.preventDefault();
	chatRId = null;
	chatRId = e.currentTarget.getAttribute('connection');

	let offcanvasBody = document.getElementsByClassName('offcanvas-body chatRoomOffcanvas')[0];
	offcanvasBody.innerHTML = null;

	let msgBox = document.createElement('div');
	msgBox.classList.add("overflow-auto");
	msgBox.setAttribute('id', "messagesBox");

	let messageBoxContainer = document.createElement('div');
	messageBoxContainer.classList.add('container', 'fixed-bottom');
	messageBoxContainer.setAttribute('id', "message");

	let inputGroup = document.createElement('div');
	inputGroup.classList.add('input-group', 'mt-2', 'p-0');

	let addFileBtn = document.createElement('button');
	addFileBtn.classList.add('btn', 'btn-outline-secondary');
	addFileBtn.setAttribute('type', "button");
	addFileBtn.setAttribute('name', "addFileB");
	addFileBtn.setAttribute('id', "button-addon1");
	addFileBtn.innerHTML = "+";

	let messageInput = document.createElement('input');
	messageInput.classList.add('form-control');
	messageInput.setAttribute('type', "text");
	messageInput.setAttribute('placeholder', "메세지를 입력하세요");
	messageInput.setAttribute('name', "msgInput");
	messageInput.setAttribute('aria-label', "message");
	messageInput.setAttribute('aria-describedby', "basic-addon1");

	let sendBtn = document.createElement('button');
	sendBtn.classList.add('input-group-text');
	sendBtn.setAttribute('name', "sendB");
	sendBtn.setAttribute('id', "basic-addon1");
	sendBtn.innerHTML = "전송";

	inputGroup.appendChild(addFileBtn);
	inputGroup.appendChild(messageInput);
	inputGroup.appendChild(sendBtn);
	messageBoxContainer.appendChild(inputGroup);
	offcanvasBody.appendChild(msgBox);
	offcanvasBody.appendChild(messageBoxContainer);

	messagesBox = document.getElementById('messagesBox');
	msge = document.getElementsByName('msgInput')[0];

	connecteWithSocket();
}

function msgeNullcheck(){
	if(msge.value!=null && msge.value!=""){
		sendMsg();
	}
}

function enterSending(e){
	if(e.key=='Enter'){
		msgeNullcheck();
	}
}

function connecteWithSocket(){ // 채팅 서버 연결
	socket = new SockJS("http://localhost:8085/GreenMarket/server?c_id="+chatRId+"&email="+personId); /************/
	socket.onmessage = onMsge;
	
	setTimeout(() => {
		$.ajax({
			url : "ConnecteWithClientServer",
			type : "POST",
		    dataType : 'text',
	    	contentType : 'application/json; charset=UTF-8',
			data : JSON.stringify({ 
				c_id : chatRId, 
				email : personId
			}),
			error:function(data){ 
				console.log(JSON.stringify(data));
				console.log('서버와의 연결이 이어지지 않았습니다.'); 
			},
			success:function(data){
				if(data==1){console.log('서버와의 연결이 정상적으로 이어졌습니다.');}
				chatStart();
			}
		});
	}, 500);
}

function chatStart(){ // 기존에 메세지가 있었다면 해당 메세지들 긁어오기
	messagesBox.innerHTML = null;
	document.addEventListener('keydown', enterSending, false);
	document.getElementsByName("sendB")[0].addEventListener('click', msgeNullcheck, false);
	$.ajax({
		url : "Chat",
		type : "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
		data : JSON.stringify({ 
			c_id : chatRId, 
			email : personId
		}),
		error:function(){
			console.log('이전에 나눴던 메세지를 가져오지 못했습니다.'); 
		},
		success:function(data){
			let chatTitle = document.getElementById("chatPdTitle");
			chatTitle.innerHTML = data.productInfo.p_name;
			chatTitle.addEventListener('click', function(){
				location.href = "productDetail?p_id="+data.productInfo.p_id;
			}, false);
		
			let msgL = data.messages;
			if(0<msgL.length){
				msgL.forEach((m) => {
					insertMessages(m.sender, m.nickname, m.message);
				});
			}
		},
		complete: function(){
			messagesBox.scrollTo(0, messagesBox.scrollHeight);
		}
	});	
}

function chatClose(){ // 서버 연결 끊고, messagesBox 비우기
	socket = null;
	
	document.removeEventListener('keydown', enterSending, false);
	document.getElementsByName("sendB")[0].removeEventListener('click', msgeNullcheck, false);
	
	$.ajax({
		url : "BreakeOffClientServer",
		method : "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
		data : JSON.stringify({ 
			c_id : chatRId, 
			email : personId /* 임시 */
		}),
		success:function(){   
			console.log('서버와의 연결이 정상적으로 해제되었습니다.');
			messagesBox.innerHTML = null;
		},   
		error:function(){
			console.log('서버와의 연결이 해제되지 않았습니다.');
		}
	});
}

function sendMsg(){ // 메세지 보내기
	$.ajax({
		url:"SendMessage",
		method:"POST",
		contentType:'application/json; charset=UTF-8',
		data : JSON.stringify({
			c_id : chatRId,
    		p_id : null,
    		email : personId, /* 임시 */
    		message : msge.value
    	}),
    	error:function(){
			alert('서버 연결에 문제가 생겨 메세지가 전송되지 않았습니다.');
		},
		success:function(data){
			if(data==1){console.log('메세지 전달 완료')}
			msge.value = null;
		}
	});
}

function onMsge(msg) {
	let data = msg.data.split(",");
	let msgInfo = [];
	for(let i=0; i<data.length; i++){
		let str = data[i].split(":");
		msgInfo.push(str);
	}
	insertMessages(msgInfo[0][1], msgInfo[4][1], msgInfo[2][1]);
}

function insertMessages(sender, nick, msg){
	if(sender==personalId){
		let myText = document.createElement('div');
		myText.classList.add('messageBox', 'myMessageBox');
		myText.setAttribute('sender', sender);
		
		let myMessage = document.createElement('p');
		myMessage.classList.add('message', 'send');
		
		myMessage.innerHTML = msg;
	
		myText.appendChild(myMessage);
		messagesBox.appendChild(myText);
		
		scrollChecking(true);
	}else{
		let reciveText = document.createElement('div');
		reciveText.classList.add('messageBox', 'reciveMessageBox');
		reciveText.setAttribute('sender', sender);
		
		let nickPlace;
		if(messagesBox.innerHTML!='' && messagesBox.innerHTML!=null && messagesBox.lastChild.getAttribute('sender')!=sender){
			nickPlace = document.createElement('p');
			nickPlace.classList.add('reciveMsgSender');
			nickPlace.innerHTML = nick;

			reciveText.appendChild(nickPlace);
		}
		
		let sendingMessage = document.createElement('p');
		sendingMessage.classList.add('message', 'recive');
		sendingMessage.innerHTML = msg;
		
		reciveText.appendChild(sendingMessage);
		
		let nowPosition = messagesBox.scrollTop;
		let result = approximateChecking(nowPosition);
		
		messagesBox.appendChild(reciveText);
		
		scrollChecking(result);
	}
}

function scrollChecking(result){ // 스크롤이 맨 아래에 있다면 새 메세지를 보내거나 받았을 때 스크롤을 아래로 고정, 맨 아래가 아니라면 위치 그대로에, 메세지 보내고, 팝업 띄우기
	if(result){
		messagesBox.scrollTo(0, messagesBox.scrollHeight);
	}else{
		mesgPopup();
	}
}

function approximateChecking(nowPosition){ // 위치 확인 - 맨 아래 스크롤과의 차이가 5 이하라면 맨 아래라고 인식, 그 이상 차이 난다면 팝업으로 전환
	let originPosition = messagesBox.scrollHeight-messagesBox.offsetHeight;
	if(originPosition==nowPosition | originPosition-nowPosition<=5){
		return true; // 스크롤 맨 아래
	}else{
		return false; // 스크롤 위치 변경됨
	}
}