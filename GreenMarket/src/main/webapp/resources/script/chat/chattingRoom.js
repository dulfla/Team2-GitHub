let offCanvs = null;

let bton = null;
let activeBtn = null;

let messagesBox = null;
let msge = null;
let inputFile = null;
let	addFileB = null;

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
		personId = document.getElementById('authInfo_email').value;
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
	personId = document.getElementById('authInfo_email').value;
	
	$.ajax({
	    url: "SelectChatRooms?email="+personId,
	    type: "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
	    error: function(data) {
	    	console.log(JSON.stringify(data));
	    	console.log('통신실패!!');
	    },
	    success: function(dt) { // 채팅방 리스트 보여주기
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
	addFileB.removeEventListener('click', actionFileInput);
	inputFile.removeEventListener('change', sendingFile);
	
	
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
	msgBox.classList.add("overflow-auto", "position-relative"); /*position-relative*/
	msgBox.setAttribute('id', "messagesBox");

	let messageBoxContainer = document.createElement('div');
	messageBoxContainer.classList.add('container', 'position-relative'); /*position-relative*/
	messageBoxContainer.setAttribute('id', "messages");

	let inputGroup = document.createElement('div');
	inputGroup.classList.add('input-group', 'mt-2', 'p-0');

	let fileInput = document.createElement('input');
	fileInput.setAttribute('type', "file");
	fileInput.setAttribute('multiple', "multiple");
	fileInput.setAttribute('id', "inputFiles");
	fileInput.setAttribute('style', "display:none;");
	fileInput.addEventListener('change', sendingFile, false);
	
	let addFileBtn = document.createElement('button');
	addFileBtn.classList.add('btn', 'btn-outline-secondary');
	addFileBtn.setAttribute('type', "button");
	addFileBtn.setAttribute('name', "addFileB");
	addFileBtn.setAttribute('id', "button-addon1");
	addFileBtn.innerHTML = "+";
	addFileBtn.addEventListener('click', actionFileInput, false);
	
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

	inputGroup.appendChild(fileInput);
	inputGroup.appendChild(addFileBtn);
	inputGroup.appendChild(messageInput);
	inputGroup.appendChild(sendBtn);
	messageBoxContainer.appendChild(inputGroup);
	offcanvasBody.appendChild(msgBox);
	offcanvasBody.appendChild(messageBoxContainer);

	messagesBox = document.getElementById('messagesBox');
	msge = document.getElementsByName('msgInput')[0];
	inputFile = document.getElementById('inputFiles');
	addFileB = document.getElementsByName('addFileB')[0];

	connecteWithSocket();
}

function actionFileInput(){
	document.getElementById('inputFiles').click();
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
	socket = new SockJS("http://localhost:8085/GreenMarket/server?c_id="+chatRId+"&email="+personId);
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
		async: false,
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
					let newElem = insertMessages(m.sender, m.nickname, m.message, m.messType);
					if(m.messType=='IMG'){
						newElem.addEventListener('load', function(){
							scrollChecking(true);
						}, false);
					}
				});
			}
		},
		complete: function(){
			scrollChecking(true);
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

function sendingFile(e){
	let files = e.currentTarget.files;
	let currectFiles = [];
	let errorFiles = [];
	
	if(0<files.length){
		for(let i=0; i<files.length; i++){
			let fileType = files[i].name.split(".");
			fileType = fileType[fileType.length-1];
			
			if(imgFileChecking(fileType, files[i].size)){
				currectFiles.push(files[i]);
			}else{
				errorFiles.push(files[i]);
			}
			
			if(i==files.length-1){
				confrimFiles(errorFiles, currectFiles);
			}
		}
	}
}

function confrimFiles(errorFiles, currectFiles){
	let header;
	let errFiles;
	let imgList;
	if(currectFiles.length==0){
		header = "파일을 전송할 수 없습니다.";
		errFiles = "모든";
		imgList = null;
	}else{
		header = "파일을 전송하시겠습니까?";
		errFiles = errorFiles.length+" 개의";
		imgList = "<br>= 전송 가능한 파일 =<br><br>";
		for(let i=currectFiles.length-1; 0<=i; i--){
			let tempUrl = window.URL.createObjectURL(currectFiles[i]);
			imgList += "<img src='"+tempUrl+"' style='width:400px'>";
		}
	}
	
	Swal.fire({
	   title: header,
	   html: '- '+errFiles+' 파일이 누락되었습니다. -<br><small>.jpg, .png 형식의 1MB 이하의 파일만 전송 가능합니다.</small><br><br>'+imgList,
	   
	   showCancelButton: true,
	   confirmButtonColor: '#3085d6',
	   cancelButtonColor: '#d33',
	   confirmButtonText: '확인',
	   cancelButtonText: '취소',
	   
	   reverseButtons: false,
	   
	}).then(result => {
	    if (result.isConfirmed) {
	    	fileSending(currectFiles);
	    }else if (result.isDismissed) {
	    	resolve(); /*여기 에러남*/
	    }
	});
}

function fileSending(files){
	console.log(files);
	if(0<files.length){
		for(let i=files.length-1; 0<=i; i--){
			let formData = new FormData();
			formData.append("file", files[i]);
			
			let fileType = files[i].name.split(".");
			fileType = fileType[fileType.length-1];
			
			const date = new Date(); /*lastModifiedDate => new Date() 로 변경*/
			let day = ""+date.getFullYear()+((date.getMonth()+1)<=9?"0"+(date.getMonth()+1):(date.getMonth()+1))+(date.getDate()<=9?"0"+date.getDate():date.getDate());
			let time = date.getTime();
			let newFileName = day+"_"+time+"."+fileType;
			
			$.ajax({
			 	url: 'SendFile?c_id='+chatRId+'&email='+personId+'&name='+newFileName,
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

function imgFileChecking(type, size){
	let maxFileSize = 1048576; // 1MB
	
	if(type!='jpg' && type!='png'){
		return false;
	}
	if(maxFileSize<size){
		return false;
	}
	return true;
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
    		message : msge.value,
    		type : "TEXT"
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

	let nowPosition = messagesBox.scrollTop;
	let result = approximateChecking(nowPosition);
	
	let check = insertMessages(msgInfo[0][1], msgInfo[4][1], msgInfo[2][1], msgInfo[3][1]);
	
	if(msgInfo[0][1]==personId){
		scrollChecking(true);
	}else{
		if(result && msgInfo[3][1]=='IMG'){
			check.addEventListener('load', function(){
				scrollChecking(result);
			}, false);
		}else{
			scrollChecking(result);
		}
	}
}

function insertMessages(sender, nick, msg, msgType){
	if(sender==personId){
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
			myMessage.setAttribute('src', "ChattingImage?c_id="+chatRId+"&fileName="+msg);
			myMessage.addEventListener('load', function(){
				scrollChecking(true);
			}, false);
		}
	
		myText.appendChild(myMessage);
		messagesBox.appendChild(myText);
		
		return myMessage;
	}else{
		let reciveText = document.createElement('div');
		reciveText.classList.add('messageBox', 'reciveMessageBox');
		reciveText.setAttribute('sender', sender);
		
		let nickPlace;
		if(messagesBox.innerHTML=='' || messagesBox.innerHTML==null || (messagesBox.innerHTML!='' && messagesBox.innerHTML!=null && messagesBox.lastChild.getAttribute('sender')!=sender)){
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
			sendingMessage.setAttribute('src', "ChattingImage?c_id="+chatRId+"&fileName="+msg);
		}
		
		reciveText.appendChild(sendingMessage);
		messagesBox.appendChild(reciveText);
		
		return sendingMessage;
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

function mesgPopup(){
	/* 
		부트스트랩 토스트 사용.
		
		위치가 메세지 input-group 위, messageBox/messagesBox 안에 있어야 함
		
		해당 메세지 클릭하면 맨 아래로 스크롤
		해당 메세지가 사진일 경우 (사진) 으로 표시
		해당 메세지 팝업이 사라지기 전에 새 메세지가 오는 경우, 해당 메세지로 바꿔치기
		팝업 지우기 버튼
		
		팝업에 뜨는 내용은 사진과 메세지
		만약에 메세지가 너무 길 경우
		split이나 subStr 의 역할을 할 수 있는 걸 찾아다가
		해당 기능으로 일부만 짜른다음 ...으로 처리
		
	*/
}
