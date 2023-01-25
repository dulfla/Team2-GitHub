let offCanvas = null;
let memberType = null;

let messageBox = null;
let msg = null;
let fileInput = null;
let addFileBtn = null;

let roomBox = null;

let productId = null;
let chatRoomId = null;

let sock = null;

let personalId = null;

window.addEventListener('load', function() {
  	offCanvas = document.getElementById('offcanvasRight chatOffcanvas');
	
	memberType = offCanvas.getAttribute('type');
	productId = document.getElementById('productId').value;
	
	if(memberType=='buy'){
		messageBox = document.getElementById('messageBox');
		messageBox.innerHTML = null;
		msg = document.getElementsByName('message')[0];

		addFileBtn = document.getElementsByName('addFileBtn')[0];
		addFileBtn.addEventListener('click', actionInputFile, false);
		fileInput = document.getElementById('fileInput');
		fileInput.addEventListener('change', sendFile, false);
	}else if(memberType=='sell'){
		roomBox = document.getElementById('chattingRooms');
		roomBox.innerHTML = null;
	}

	let startBtn = document.getElementById('openChattingBtn');
	startBtn.addEventListener('click', function (e){
		personalId = document.getElementById('userEmail').value;
		if(memberType=='buy'){
			chatting();
		}else if(memberType=='sell'){
			chattingRoom();
		}
	}, false);
	
	window.onbeforeunload = function(event) {
		if(offCanvas.classList.contains('show')){
			event.preventDefault();
			closeServer();
		}
	};

	document.addEventListener('click', () => {
		let activeE = document.activeElement;
		let body = document.getElementsByTagName('body')[0];
		if(activeE==body){
			closeServer();
		}else if(activeE==startBtn){
			if(offCanvas.classList.contains('show')){
				closeServer();
			}else{
				let chatRoomOffcanvs = document.getElementById('offcanvasRight chatRoomOffcanvas');
				if(chatRoomOffcanvs){
					if(chatRoomOffcanvs.classList.contains('show')){
						chatRoomOffcanvs.classList.toggle('show');
					}
				}
				openOffCanvas();
			}
		}
	}, false);
	
	let closeBtn = document.getElementById('closeBtn chatOffcanvas');
	closeBtn.addEventListener('click', closeServer, false);
});

function actionInputFile(){
	document.getElementById('fileInput').click();
}

function openOffCanvas(){
	let chatPdPic = document.getElementById('chatPdPic');
	$.ajax({
	    url: "GetProductImg",
	    type: "POST",
	    dataType : 'text',
    	contentType : 'application/json; charset=UTF-8',
    	data : JSON.stringify({
    		p_id : productId,
    		email : personalId
    	}),
	    error: function(){
	    	console.log('통신실패!!');
	    },
	    success: function(data) {
	    	if(data!=null && data!=""){
	    		chatPdPic.setAttribute('src', "display?fileName="+data);
	    	}else{
	    		chatPdPic.setAttribute('src', "./resources/img/sample.jpg");
	    	}
			offCanvas.classList.add('show');
	    }
	});
}

function closeServer(){
	if(memberType=='buy'){
		if(offCanvas.classList.contains('show')){
			chattingClose();
			offCanvas.classList.toggle('show');
		}
	}else if(memberType=='sell'){
		if(offCanvas.classList.contains('show') && offCanvas.classList.contains('chattingOpen')){
			backToChattRooms();
			offCanvas.classList.toggle('show');
		}else if(offCanvas.classList.contains('show') && offCanvas.classList.contains('chattingRooms')){
			roomBox.innerHTML = null;
			offCanvas.classList.toggle('show');
		}
	}
}

function chattingRoom(){
	roomBox.innerHTML = null;
	$.ajax({
	    url: "SelectChatRoom",
	    type: "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
    	data : JSON.stringify({ // 해당되는 모든 채팅방을 가져올 구분자(상품 id)
    		p_id : productId,
    		email : personalId /* 임시 */
    	}),
	    error: function(data) {
	    	console.log(JSON.stringify(data));
	    	console.log('통신실패!!');
	    },
	    success: function(data) { // 채팅방 리스트 보여주기
	    	if(data!=null){
				data.forEach((r) => {
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

					roomBox.appendChild(aT);
					
					aT.addEventListener('click', openChatting, false);
				});
	    	}else{
				let div = document.createElement('div');
				div.innerHTML = "현재 참여중인 채팅이 없습니다.";
				roomBox.appendChild(div);
			}
			
			if(roomBox.innerHTML==null || roomBox.innerHTML==''){
				let div = document.createElement('div');
				div.innerHTML = "현재 참여중인 채팅이 없습니다.";
				roomBox.appendChild(div);
			}
	    }
	});
}

function backToChattRooms(){
	chattingClose();
	document.removeEventListener('keydown', enterSend);
	document.getElementsByName("sendBtn")[0].removeEventListener('click', msgNullcheck);
	addFileBtn.removeEventListener('click', actionInputFile);
	fileInput.removeEventListener('change', sendFile);
	
	if(offCanvas.classList.contains('chattingOpen')){
		offCanvas.classList.remove('chattingOpen');
	}
	offCanvas.classList.add('chattingRooms');
	
	let offcanvasHeader = document.getElementsByClassName('offcanvas-header chatOffcanvas')[0];
	let backToChatRoomLBtn = document.getElementById('backBtn chatOffcanvas');
	offcanvasHeader.removeChild(backToChatRoomLBtn);

	let backPageBtn = document.createElement('button');
	backPageBtn.setAttribute('type', "button");
	backPageBtn.setAttribute('id', "closeBtn chatOffcanvas");
	backPageBtn.setAttribute('data-bs-dismiss', "offcanvas");
	backPageBtn.setAttribute('aria-label', "Close");
	backPageBtn.classList.add('btn-close');
	backPageBtn.addEventListener('click', closeServer, false);
	offcanvasHeader.appendChild(backPageBtn);

	let offcanvasBody = document.getElementsByClassName('offcanvas-body chatOffcanvas')[0];
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
	let offcanvasHeader = document.getElementsByClassName('offcanvas-header chatOffcanvas')[0];
	let closeOffcavasBtn = document.getElementById('closeBtn chatOffcanvas');
	offcanvasHeader.removeChild(closeOffcavasBtn);

	let backPageA = document.createElement('a');
	backPageA.setAttribute('id', "backBtn chatOffcanvas");
	backPageA.addEventListener('click', (e) => {
		e.preventDefault()
		backToChattRooms();
		chattingRoom();
	}, false);
	backPageA.classList.add('backSpageBtn');
	backPageA.innerHTML = "←";
	offcanvasHeader.appendChild(backPageA);

	e.preventDefault();
	chatRoomId = null;
	chatRoomId = e.currentTarget.getAttribute('connection');
	if(offCanvas.classList.contains('chattingRooms')){
		offCanvas.classList.remove('chattingRooms');
	}
	offCanvas.classList.add('chattingOpen');

	let offcanvasBody = document.getElementsByClassName('offcanvas-body chatOffcanvas')[0];
	offcanvasBody.innerHTML = null;

	let msgBox = document.createElement('div');
	msgBox.classList.add("overflow-auto");
	msgBox.setAttribute('id', "messageBox");

	let messageBoxContainer = document.createElement('div');
	messageBoxContainer.classList.add('container', 'fixed-bottom');
	messageBoxContainer.setAttribute('id', "message");

	let inputGroup = document.createElement('div');
	inputGroup.classList.add('input-group', 'mt-2', 'p-0');

	let filesInput = document.createElement('input');
	filesInput.setAttribute('type', "file");
	filesInput.setAttribute('multiple', "multiple");
	filesInput.setAttribute('id', "fileInput");
	filesInput.setAttribute('style', "display:none;");
	filesInput.addEventListener('change', sendFile, false);

	let addFileBton = document.createElement('button');
	addFileBton.classList.add('btn', 'btn-outline-secondary');
	addFileBton.setAttribute('type', "button");
	addFileBton.setAttribute('name', "addFileBtn");
	addFileBton.setAttribute('id', "button-addon1");
	addFileBton.innerHTML = "+";
	addFileBton.addEventListener('click', actionInputFile, false);

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

	inputGroup.appendChild(filesInput);
	inputGroup.appendChild(addFileBton);
	inputGroup.appendChild(messageInput);
	inputGroup.appendChild(sendBtn);
	messageBoxContainer.appendChild(inputGroup);
	offcanvasBody.appendChild(msgBox);
	offcanvasBody.appendChild(messageBoxContainer);

	messageBox = document.getElementById('messageBox');
	msg = document.getElementsByName('message')[0];
	fileInput = document.getElementById('fileInput');
	addFileBtn = document.getElementsByName('addFileBtn')[0];
	
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

function chatting(){ // 채팅방 연결 - 채팅방이 있으면 해당 채팅방으로, 없으면 새로운 채팅방으로
	$.ajax({
	    url: "ChatRoomCheck",
	    type: "POST",
	    dataType : 'text',
    	contentType : 'application/json; charset=UTF-8',
    	data : JSON.stringify({ // 연결할 채팅방 아이디 확인
    		p_id : productId,
    		email : personalId /* 임시 */
    	}),
	    error: function(){
	    	console.log('통신실패!!');
	    },
	    success: function(data) { // 채팅방으로 연결
	    	if(data!=null){
	    		chatRoomId = data;
	    		console.log(chatRoomId); /*****/
	    		connecteToSocket();
	    	}
	    }
	});
}

function connecteToSocket(){ // 채팅 서버 연결
	sock = new SockJS("http://localhost:8085/GreenMarket/server?c_id="+chatRoomId+"&email="+personalId);
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

function onMessage(msg) { /**************/
    let data = msg.data; console.log(data);
    let reciveText = document.createElement('div');
	reciveText.classList.add('messageBox', 'reciveMessageBox');
	
	let sendingMessage = document.createElement('p');
	sendingMessage.classList.add('message', 'recive');
	
	sendingMessage.innerHTML = m.message;
	
	reciveText.appendChild(sendingMessage);
	messageBox.appendChild(reciveText);
}

function chattingStart(){ // 기존에 메세지가 있었다면 해당 메세지들 긁어오기
	messageBox.innerHTML = null;
	document.addEventListener('keydown', enterSend, false);
	document.getElementsByName("sendBtn")[0].addEventListener('click', msgNullcheck, false);
	
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
		success:function(data){
			let msgL = data.messages;
			if(0<msgL.length){
				msgL.forEach((m) => {
					insertMessage(m.sender, m.nickname, m.message, m.messType);
				});
			}
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

function sendFile(e){
	let files = e.currentTarget.files;
	if(0<files.length){
		for(let i=0; i<files.length; i++){
			let fileType = files[i].name.split(".");
			fileType = fileType[fileType.length-1];
			
			if(imgFileCheck(fileType, files[i].size)){
				let formData = new FormData();
				formData.append("file", files[i]);
				
				const date = new Date(files[i].lastModifiedDate);
				let day = ""+date.getFullYear()+((date.getMonth()+1)<=9?"0"+(date.getMonth()+1):(date.getMonth()+1))+(date.getDate()<=9?"0"+date.getDate():date.getDate());
				let time = date.getTime();
				let newFileName = day+"_"+time+"."+fileType;
				
				$.ajax({
				 	url: 'SendFile?c_id='+chatRoomId+'&email='+personalId+'&name='+newFileName,
				 	processData : false,
				 	contentType : false,
				 	data : formData,
				 	type : 'POST',
				 	dataType : 'json',
				 	success : function(data){
				 		if(data==1){
				 			console.log('파일 전송 완료');
				 		}else if(data==2){
				 			console.log('파일 전송 오류');
				 		}
				 	},
				 	error : function(data){
				 		console.log(JSON.stringify(data))
				 	}
				});
			}
		}		
	}
}

function imgFileCheck(type, size){
	let maxFileSize = 1048576; // 1MB
	
	if(type!='jpg' && type!='png'){
		return false;
	}
	if(maxFileSize<size){
		return false;
	}
	return true;
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
			msg.value = null;
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
			
	let nowPosition = messageBox.scrollTop;
	let result = approximateCheck(nowPosition);
	
	insertMessage(msgInfo[0][1], msgInfo[4][1], msgInfo[2][1], msgInfo[3][1]);
	
	scrollCheck(result);
}

function insertMessage(sender, nick, msg, msgType){
	if(sender==personalId){
		let myText = document.createElement('div');
		myText.classList.add('messageBox', 'myMessageBox');
		myText.setAttribute('sender', sender);
		
		let myMessage;
		if(msgType=='TEXT'){
			myMessage = document.createElement('p');
			myMessage.classList.add('message', 'send');
			myMessage.innerHTML = msg;
		}else if(msgType=='IMG'){
			myMessage = document.createElement('img');
			myMessage.classList.add('chattingImage');
			myMessage.setAttribute('src', "ChattingImage?c_id="+chatRoomId+"&fileName="+msg);
		}
	
		myText.appendChild(myMessage);
		messageBox.appendChild(myText);
		
		scrollCheck(true);
	}else{
		let reciveText = document.createElement('div');
		reciveText.classList.add('messageBox', 'reciveMessageBox');
		reciveText.setAttribute('sender', sender);
		
		let nickPlace;
		if(messageBox.innerHTML=='' || messageBox.innerHTML==null || (messageBox.innerHTML!='' && messageBox.innerHTML!=null && messageBox.lastChild.getAttribute('sender')!=sender)){
			nickPlace = document.createElement('p');
			nickPlace.classList.add('reciveMsgSender');
			nickPlace.innerHTML = nick;

			reciveText.appendChild(nickPlace);
		}
		
		let sendingMessage;
		if(msgType=='TEXT'){
			sendingMessage = document.createElement('p');
			sendingMessage.classList.add('message', 'recive');
			sendingMessage.innerHTML = msg;
		}else if(msgType=='IMG'){
			sendingMessage = document.createElement('img');
			sendingMessage.classList.add('chattingImage');
			sendingMessage.setAttribute('src', "ChattingImage?c_id="+chatRoomId+"&fileName="+msg);
		}
		
		reciveText.appendChild(sendingMessage);
		messageBox.appendChild(reciveText);
	}
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
