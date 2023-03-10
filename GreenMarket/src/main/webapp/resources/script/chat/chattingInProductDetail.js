let offCanvas = null;
let memberType = null;

let messageBox = null;
let msg = null;
let fileInput = null;
let addFileBtn = null;
let startB = null;

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

	startB = document.getElementById('openChattingBtn');
	startB.addEventListener('click', function (e){
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

	document.addEventListener('click', offCanvasCloseChecking, false);
	
	let closeBtn = document.getElementById('closeBtn chatOffcanvas');
	closeBtn.addEventListener('click', closeServer, false);
});

function offCanvasCloseChecking(){
	let activeE = document.activeElement;
	let body = document.getElementsByTagName('body')[0];
	if(activeE==body){
		closeServer();
	}else if(activeE==startB){
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
}

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
    		p_id : productId
    	}),
	    error: function(){
	    	// console.log('????????????!!');
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
    	data : JSON.stringify({
    		p_id : productId
    	}),
	    error: function(data) {
	    	// console.log(JSON.stringify(data));
	    	// console.log('????????????!!');
	    },
	    success: function(data) {
	    	if(data!=null){
				data.forEach((r) => {
					let aT = document.createElement('a');
					aT.classList.add('list-group-item', 'list-group-item-action', 'd-flex', 'gap-3', 'py-3');
					aT.setAttribute('aria-current', true);
					aT.setAttribute('connection', r.c_id);

					let imgT = document.createElement('img');
					imgT.setAttribute('src', 'resources/img/icon.png'); // https://github.com/twbs.png
					imgT.setAttribute('alt', '?????? ?????? ??????');
					imgT.classList.add('rounded-circle', 'flex-shrink-0', 'chatRoomImg');

					let expressZone = document.createElement('div');
					expressZone.classList.add('d-flex', 'gap-2', 'w-100', 'justify-content-between');

					let textZone = document.createElement('div');

					let h6T = document.createElement('h6');
					h6T.classList.add('mb-0');
					h6T.innerHTML = ((r.p_name.length<=10)?(r.p_name):(r.p_name.substr(0, 10)+"..."));

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
				div.innerHTML = "?????? ???????????? ????????? ????????????.";
				roomBox.appendChild(div);
			}
			
			if(roomBox.innerHTML==null || roomBox.innerHTML==''){
				let div = document.createElement('div');
				div.innerHTML = "?????? ???????????? ????????? ????????????.";
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
	backPageA.innerHTML = "???";
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
	msgBox.classList.add("overflow-auto", "position-relative");
	msgBox.setAttribute('id', "messageBox");

	let messageBoxContainer = document.createElement('div');
	messageBoxContainer.classList.add('container', 'position-relative');
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
	messageInput.setAttribute('placeholder', "???????????? ???????????????");
	messageInput.setAttribute('name', "message");
	messageInput.setAttribute('aria-label', "message");
	messageInput.setAttribute('aria-describedby', "basic-addon1");

	let sendBtn = document.createElement('button');
	sendBtn.classList.add('input-group-text');
	sendBtn.setAttribute('name', "sendBtn");
	sendBtn.setAttribute('id', "basic-addon1");
	sendBtn.innerHTML = "??????";

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

function chatting(){
	$.ajax({
	    url: "ChatRoomCheck",
	    type: "POST",
	    dataType : 'text',
    	contentType : 'application/json; charset=UTF-8',
    	data : JSON.stringify({
    		p_id : productId
    	}),
	    error: function(){
	    	// console.log('????????????!!');
	    },
	    success: function(data) {
	    	if(data!=null){
	    		chatRoomId = data;
	    		connecteToSocket();
	    	}
	    }
	});
}

function connecteToSocket(){
	// 192.168.0.57 // localhost
	sock = new SockJS("ws/server?c_id="+chatRoomId+"&email="+personalId, null, {transports: ["websocket", "xhr-streaming", "xhr-polling"]});
	sock.onmessage = onMessage;
	
	setTimeout(() => {
		$.ajax({
			url : "ConnecteWithClientServer",
			type : "POST",
		    dataType : 'text',
	    	contentType : 'application/json; charset=UTF-8',
			data : JSON.stringify({ 
				c_id : chatRoomId
			}),
			error:function(){  
				// console.log('???????????? ????????? ???????????? ???????????????.'); 
			},
			success:function(data){
				if(data==1){ /* console.log('???????????? ????????? ??????????????? ??????????????????.'); */ }
				chattingStart();
			}
		});
	}, 500);
}

function onMessage(msg) {
    let data = msg.data;
    let reciveText = document.createElement('div');
	reciveText.classList.add('messageBox', 'reciveMessageBox');
	
	let sendingMessage = document.createElement('p');
	sendingMessage.classList.add('message', 'recive');
	
	sendingMessage.innerHTML = m.message;
	
	reciveText.appendChild(sendingMessage);
	messageBox.appendChild(reciveText);
}

function chattingStart(){
	messageBox.innerHTML = null;
	document.addEventListener('keydown', enterSend, false);
	document.getElementsByName("sendBtn")[0].addEventListener('click', msgNullcheck, false);
	
	$.ajax({
		url : "Chat",
		type : "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
		data : JSON.stringify({ 
			c_id : chatRoomId
		}),
		error:function(){
			// console.log('????????? ????????? ???????????? ???????????? ???????????????.'); 
		},
		success:function(data){
			let msgL = data.messages;
			if(0<msgL.length){
				msgL.forEach((m) => {
					let newElem = insertMessage(m.sender, m.nickname, m.message, m.messType, m.read);
					if(m.messType=='IMG'){
						newElem.addEventListener('load', function(){
							scrollCheck(true);
						}, false);
					}
				});
			}
		},
		complete: function(){
			scrollCheck(true);
		}
	});	
}

function chattingClose(){
	sock.close();
	
	document.removeEventListener('keydown', enterSend, false);
	document.getElementsByName("sendBtn")[0].removeEventListener('click', msgNullcheck, false);
	
	$.ajax({
		url : "BreakeOffClientServer",
		method : "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
		data : JSON.stringify({ 
			c_id : chatRoomId
		}),
		success:function(){   
			// console.log('???????????? ????????? ??????????????? ?????????????????????.');
			messageBox.innerHTML = null;
		},   
		error:function(){
			// console.log('???????????? ????????? ???????????? ???????????????.');
		}
	});
}

function sendFile(e){
	let files = e.currentTarget.files;
	let currectFiles = [];
	let errorFiles = [];
	
	if(0<files.length){
		for(let i=0; i<files.length; i++){
			let fileType = files[i].name.split(".");
			fileType = fileType[fileType.length-1];
			
			if(imgFileCheck(fileType, files[i].size)){
				currectFiles.push(files[i]);
			}else{
				errorFiles.push(files[i]);
			}
			
			if(i==files.length-1){
				filesConfrim(errorFiles, currectFiles);
			}
		}
	}
}

function filesConfrim(errorFiles, currectFiles){
	let header = "";
	let msg = "";
	if(currectFiles.length==0){
		header = "????????? ????????? ??? ????????????.";
		msg = "?????? ????????? ?????????????????????.";
		imgList = null;
	}else{
		header = "????????? ?????????????????????????";
		if(errorFiles.length==0){
			msg = "????????? ????????? ????????????."
		}else{
			msg = errorFiles.length+" ?????? ????????? ?????????????????????."
		}
		imgList = "<br>= ?????? ????????? ?????? =<br><br>";
		for(let i=currectFiles.length-1; 0<=i; i--){
			let tempUrl = window.URL.createObjectURL(currectFiles[i]);
			imgList += "<img src='"+tempUrl+"' style='width:400px; margin-bottom:10px;'>";
		}
	}
	
	document.removeEventListener('click', offCanvasCloseChecking);
	
	Swal.fire({
	   title: header,
	   html: '- '+msg+' -<br><small>.jpg, .png ????????? 1MB ????????? ????????? ?????? ???????????????.</small><br><br>'+imgList,
	   
	   showCancelButton: true,
	   confirmButtonColor: '#3085d6',
	   cancelButtonColor: '#d33',
	   confirmButtonText: '??????',
	   cancelButtonText: '??????',
	   
	   reverseButtons: false,
	   
	}).then(result => {
	    if (result.isConfirmed) {
	    	fileSend(currectFiles);
	    }else if (result.isDismissed) {
	    	setTimeout(() => {
				document.addEventListener('click', offCanvasCloseChecking, false);
			}, 100);
	    }
	});
}

function fileSend(files){
	if(0<files.length){
		for(let i=files.length-1; 0<=i; i--){
			let formData = new FormData();
			formData.append("file", files[i]);
			
			let fileType = files[i].name.split(".");
			fileType = fileType[fileType.length-1];
			
			const date = new Date();
			let day = ""+date.getFullYear()+((date.getMonth()+1)<=9?"0"+(date.getMonth()+1):(date.getMonth()+1))+(date.getDate()<=9?"0"+date.getDate():date.getDate());
			let time = date.getTime();
			let newFileName = day+"_"+time+"."+fileType;
			
			$.ajax({
			 	url: 'SendFile?c_id='+chatRoomId+'&name='+newFileName,
			 	processData : false,
			 	contentType : false,
			 	data : formData,
			 	type : 'POST',
			 	dataType : 'json',
			 	success : function(data){
			 		if(data==1){
			 			// console.log('?????? ?????? ??????');
			 		}else if(data==2){
			 			// console.log('?????? ?????? ??????');
			 		}
			 	},
			 	error : function(data){
			 		// console.log(JSON.stringify(data))
			 	},
			 	complete : function(){
				 	document.addEventListener('click', offCanvasCloseChecking, false);
			 	}
			});
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

function sendMessage(){
	$.ajax({
		url:"SendMessage",
		method:"POST",
		contentType:'application/json; charset=UTF-8',
		data : JSON.stringify({
			c_id : chatRoomId,
    		p_id : productId,
    		message : msg.value,
    		type : "TEXT"
    	}),
    	error:function(){
			alert('?????? ????????? ????????? ?????? ???????????? ???????????? ???????????????.');
		},
		success:function(data){
			if(data==1){ /* console.log('????????? ?????? ??????'); */ }
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
		
	if(msgInfo[3][1]=='READ'){
		if(msgInfo[0][1]!=personalId){
			let imgs = document.getElementById('messageBox').getElementsByTagName('img');
			if(imgs.length==0){
				removeReadMarks();
			}else{
				if(imgs[imgs.length-1].complete){
					removeReadMarks();
				}else{
					imgs[imgs.length-1].addEventListener('load', function(){
						removeReadMark();
					});
				}
			}
		}	 
	}else{
		let check = insertMessage(msgInfo[0][1], msgInfo[4][1], msgInfo[2][1], msgInfo[3][1], 1);
		
		if(msgInfo[0][1]==personalId){
			scrollCheck(true);
		}else{
			readMsge(msgInfo[5][1]);
			if(result && msgInfo[3][1]=='IMG'){
				check.addEventListener('load', function(){
					if(!scrollCheck(result)){
						messagePopup(msgInfo[0][1], msgInfo[4][1], msgInfo[2][1], msgInfo[3][1]);
					}
				}, false);
			}else{
				if(!scrollCheck(result)){
					messagePopup(msgInfo[0][1], msgInfo[4][1], msgInfo[2][1], msgInfo[3][1]);
				}
			}
		}
	}
}

function removeReadMarks(){
	let readM = document.getElementsByClassName('readMarks');
	
	for(let i=readM.length-1; i>=0; i--){
 	 	readM[i].parentElement.removeChild(readM[i]);
 	};
}

function readMsge(msgIdx){
	$.ajax({
		url:"ReadMessage",
		method:"POST",
		contentType:'application/json; charset=UTF-8',
		data : JSON.stringify({
			c_id : chatRoomId,
    		p_id : null,
    		msgIdx : msgIdx,
    		type : "READ"
    	}),
    	error:function(){
			alert('?????? ????????? ????????? ?????? ???????????? ???????????? ???????????????.');
		},
		success:function(data){
			if(data==1){ /* console.log('?????? ??????'); */ }
		}
	});
}

function insertMessage(sender, nick, msg, msgType, read){
	if(sender==personalId){
		let myText = document.createElement('div');
		myText.classList.add('messageBox', 'myMessageBox');
		myText.setAttribute('sender', sender);
		
		let myMessage;
		if(msgType=='TEXT'){
			myMessage = document.createElement('p');
			myMessage.classList.add('message', 'send');
			myMessage.innerHTML = msg;
			
			myText.appendChild(myMessage);
			messageBox.appendChild(myText);
	
			if(read==1){
				let readMarks = document.createElement('p');
				readMarks.classList.add('readMarks');
				readMarks.innerHTML = "1";
				
				let ph = myMessage.clientHeight;
				readMarks.setAttribute('style', "margin-top:"+(ph-15)+"px;");
				myText.appendChild(readMarks);
			}
			
			return myMessage;
		}else if(msgType=='IMG'){
			myMessage = document.createElement('img');
			myMessage.classList.add('chattingImage');
			myMessage.classList.add('send');
			myMessage.setAttribute('src', "ChattingImage?c_id="+chatRoomId+"&fileName="+msg);
			myMessage.addEventListener('load', function(){
				scrollCheck(true);
			
				if(read==1){
					let readMark = document.createElement('p');
					readMark.classList.add('readMark');
					readMark.innerHTML = "1";
					
					let ph = myMessage.clientHeight;
					readMark.setAttribute('style', "margin-top:"+(ph-15)+"px;");
					myText.appendChild(readMark);
				}
			}, false);
			
			myText.appendChild(myMessage);
			messageBox.appendChild(myText);
			
			return myMessage;
		}
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
		
		return sendingMessage;
	}
}

function scrollCheck(result){
	if(result){
		messageBox.scrollTo(0, messageBox.scrollHeight);
		return true;
	}else{
		return false;
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

function messagePopup(sender, nick, msg, msgType){
	let toast = document.createElement('div');
	toast.setAttribute('sender', sender);
	toast.classList.add("messagePopUp");
	
	let header = document.createElement('div');
	let name = document.createElement('h6');
	name.innerHTML = nick;
	
	let body = document.createElement('div');
	let msge = document.createElement('small');
	msge.innerHTML = (msgType=='IMG')?("(??????)"):((msg.length<=20)?(msg):(msg.substr(0, 20)+"..."));
	
	body.appendChild(msge);
	header.appendChild(name);
	toast.appendChild(header);
	toast.appendChild(body);
	toast.addEventListener('click', function(){
		messageBox.removeChild(toast);
		scrollCheck(true);
	}, false);
	
	messageBox.appendChild(toast);

	setTimeout(()=>{
		messageBox.removeChild(toast);
	}, 1300);
}
