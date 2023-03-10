let offCanvs = null;

let bton = null;
let activeBtn = null;
let startBtn = null;

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
	
	startBtn = document.getElementById('myChattings');
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
	
	document.addEventListener('click', offCanvasCloseCheck, false);
	
	let closeBtn = document.getElementById('closeB');
	closeBtn.addEventListener('click', shotServer, false);
});

function offCanvasCloseCheck(){
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
}

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
	    	// console.log(JSON.stringify(data));
	    	// console.log('????????????!!');
	    },
	    success: function(dt) {
	    	if(0<dt.data.length){
				dt.data.forEach((r) => {
					if(activeBtn=='all' || r.type==activeBtn){
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
	
						roomsBox.appendChild(aT);
						
						aT.addEventListener('click', openChattings, false);
					}
				});
	    	}else{
				let div = document.createElement('div');
				div.innerHTML = "?????? ???????????? ????????? ????????????.";
				roomsBox.appendChild(div);
			}
			
			if(roomsBox.innerHTML==null || roomsBox.innerHTML==''){
				let div = document.createElement('div');
				div.innerHTML = "?????? ???????????? ????????? ????????????.";
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
	
	let chatTitle = document.getElementById("chatPdTitle");
	chatTitle.innerHTML = null;

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
	backPageBtn.innerHTML = "???";
	offcanvasHeader.appendChild(backPageBtn);

	e.preventDefault();
	chatRId = null;
	chatRId = e.currentTarget.getAttribute('connection');

	let offcanvasBody = document.getElementsByClassName('offcanvas-body chatRoomOffcanvas')[0];
	offcanvasBody.innerHTML = null;

	let msgBox = document.createElement('div');
	msgBox.classList.add("overflow-auto", "position-relative");
	msgBox.setAttribute('id', "messagesBox");

	let messageBoxContainer = document.createElement('div');
	messageBoxContainer.classList.add('container', 'position-relative');
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
	messageInput.setAttribute('placeholder', "???????????? ???????????????");
	messageInput.setAttribute('name', "msgInput");
	messageInput.setAttribute('aria-label', "message");
	messageInput.setAttribute('aria-describedby', "basic-addon1");

	let sendBtn = document.createElement('button');
	sendBtn.classList.add('input-group-text');
	sendBtn.setAttribute('name', "sendB");
	sendBtn.setAttribute('id', "basic-addon1");
	sendBtn.innerHTML = "??????";

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

function connecteWithSocket(){
	// 192.168.0.57 // localhost
	socket = new SockJS("ws/server?c_id="+chatRId+"&email="+personId, null, {transports: ["websocket", "xhr-streaming", "xhr-polling"]});
	socket.onmessage = onMsge;
	
	setTimeout(() => {
		$.ajax({
			url : "ConnecteWithClientServer",
			type : "POST",
		    dataType : 'text',
	    	contentType : 'application/json; charset=UTF-8',
			data : JSON.stringify({ 
				c_id : chatRId
			}),
			error:function(data){ 
				// console.log(JSON.stringify(data));
				// console.log('???????????? ????????? ???????????? ???????????????.'); 
			},
			success:function(data){
				if(data==1){ /* console.log('???????????? ????????? ??????????????? ??????????????????.'); */ }
				chatStart();
			}
		});
	}, 500);
}

function chatStart(){
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
			c_id : chatRId
		}),
		error:function(){
			// console.log('????????? ????????? ???????????? ???????????? ???????????????.'); 
		},
		success:function(data){
			let chatTitle = document.getElementById("chatPdTitle");
			chatTitle.innerHTML = ((data.productInfo.p_name.length<=10)?(data.productInfo.p_name):(data.productInfo.p_name.substr(0, 10)+"..."));
			chatTitle.addEventListener('click', function(){
				location.href = "productDetail?p_id="+data.productInfo.p_id;
			}, false);
		
			let msgL = data.messages;
			if(0<msgL.length){
				msgL.forEach((m) => {
					let newElem = insertMessages(m.sender, m.nickname, m.message, m.messType, m.read);
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

function chatClose(){
	socket.close();
	
	document.removeEventListener('keydown', enterSending, false);
	document.getElementsByName("sendB")[0].removeEventListener('click', msgeNullcheck, false);
	
	$.ajax({
		url : "BreakeOffClientServer",
		method : "POST",
	    dataType : 'json',
    	contentType : 'application/json; charset=UTF-8',
		data : JSON.stringify({ 
			c_id : chatRId
		}),
		success:function(){   
			// console.log('???????????? ????????? ??????????????? ?????????????????????.');
			messagesBox.innerHTML = null;
		},   
		error:function(){
			// console.log('???????????? ????????? ???????????? ???????????????.');
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
	let header = "";
	let msg = "";
	let imgList = "";
	if(currectFiles.length==0){
		header = "????????? ????????? ??? ????????????.";
		msg = "?????? ????????? ?????????????????????.";
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
	
	document.removeEventListener('click', offCanvasCloseCheck);
	
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
	    	fileSending(currectFiles);
	    }else if (result.isDismissed) {
	    	setTimeout(() => {
				document.addEventListener('click', offCanvasCloseCheck, false);
			}, 100);
	    }
	});
}

function fileSending(files){
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
			 	url: 'SendFile?c_id='+chatRId+'&name='+newFileName,
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
				 	document.addEventListener('click', offCanvasCloseCheck, false);
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

function sendMsg(){
	$.ajax({
		url:"SendMessage",
		method:"POST",
		contentType:'application/json; charset=UTF-8',
		data : JSON.stringify({
			c_id : chatRId,
    		message : msge.value,
    		type : "TEXT"
    	}),
    	error:function(){
			alert('?????? ????????? ????????? ?????? ???????????? ???????????? ???????????????.');
		},
		success:function(data){
			if(data==1){ /* console.log('????????? ?????? ??????'); */}
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
		
	if(msgInfo[3][1]=='READ'){
		if(msgInfo[0][1]!=personId){
			let imgs = document.getElementById('messagesBox').getElementsByTagName('img');
			if(imgs.length==0){
				removeReadMark();
			}else{
				if(imgs[imgs.length-1].complete){
					removeReadMark();
				}else{
					imgs[imgs.length-1].addEventListener('load', function(){
						removeReadMark();
					});
				}
			}
		}
	}else{
		let check = insertMessages(msgInfo[0][1], msgInfo[4][1], msgInfo[2][1], msgInfo[3][1], 1);
	
		if(msgInfo[0][1]==personId){
			scrollChecking(true);
		}else{
			readMsg(msgInfo[5][1]);
			if(result && msgInfo[3][1]=='IMG'){
				check.addEventListener('load', function(){
					if(!scrollChecking(result)){
						mesgPopup(msgInfo[0][1], msgInfo[4][1], msgInfo[2][1], msgInfo[3][1]);
					}
				}, false);
			}else{
				if(!scrollChecking(result)){
					mesgPopup(msgInfo[0][1], msgInfo[4][1], msgInfo[2][1], msgInfo[3][1]);
				}
			}
		}
	}
}

function removeReadMark(){
	let readM = document.getElementsByClassName('readMark');
	
	for(let i=readM.length-1; i>=0; i--){
 	 	readM[i].parentElement.removeChild(readM[i]);
 	};
}

function readMsg(msgIdx){
	$.ajax({
		url:"ReadMessage",
		method:"POST",
		contentType:'application/json; charset=UTF-8',
		data : JSON.stringify({
			c_id : chatRId,
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

function insertMessages(sender, nick, msg, msgType, read){
	if(sender==personId){
		let myText = document.createElement('div');
		myText.classList.add('messageBox', 'myMessageBox');
		myText.setAttribute('sender', sender);

		let myMessage;
		if(msgType=='TEXT'){
			myMessage = document.createElement('p');
			myMessage.classList.add('message', 'send');
			myMessage.innerHTML = msg;
			
			myText.appendChild(myMessage);
			messagesBox.appendChild(myText);
	
			if(read==1){
				let readMark = document.createElement('p');
				readMark.classList.add('readMark');
				readMark.innerHTML = "1";
				
				let ph = myMessage.clientHeight;
				readMark.setAttribute('style', "margin-top:"+(ph-15)+"px;");
				myText.appendChild(readMark);
			}
			
			return myMessage;
		}else if(msgType=='IMG'){
			myMessage = document.createElement('img');
			myMessage.classList.add('chattingImage');
			myMessage.classList.add('send');
			myMessage.setAttribute('src', "ChattingImage?c_id="+chatRId+"&fileName="+msg);
			myMessage.addEventListener('load', function(){
				scrollChecking(true);
				
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
			messagesBox.appendChild(myText);
			
			return myMessage;
		}
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

function scrollChecking(result){
	if(result){
		messagesBox.scrollTo(0, messagesBox.scrollHeight);
		return true;
	}else{
		return false;
	}
}

function approximateChecking(nowPosition){
	let originPosition = messagesBox.scrollHeight-messagesBox.offsetHeight;
	if(originPosition==nowPosition | originPosition-nowPosition<=5){
		return true;
	}else{
		return false;
	}
}

function mesgPopup(sender, nick, msg, msgType){
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
		messagesBox.removeChild(toast);
		scrollChecking(true);
	}, false);
	
	messagesBox.appendChild(toast);

	setTimeout(()=>{
		messagesBox.removeChild(toast);
	}, 1300);
}
