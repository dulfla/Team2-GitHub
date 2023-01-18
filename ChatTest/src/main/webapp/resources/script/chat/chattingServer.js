let btn;
let containerDiv;

window.onload = function(){
	btn = document.getElementsByName('controllServer')[0];
	containerDiv = document.getElementById('container');
	
	if(btn.getAttribute('id')=='serverSetOn'){
		btn.addEventListener('click', serverSetOn, false);
	}else if(btn.getAttribute('id')=='serverSetOff'){
		btn.addEventListener('click', serverSetOff, false);
	}
}

function serverSetOn(){
	$.ajax({
		url:"ServerOpen",
		type:"POST",
    	error: function() {
	    	console.log('통신실패!!');
	    },
		success:function(data){
			newBtnCreate(0);
		}
	});
}

function serverSetOff(){
	$.ajax({
		url:"ServerClose",
		type:"POST",
		error: function() {
	    	console.log('통신실패!!');
	    },
		success:function(){
			newBtnCreate(1);
		}
	});
}

function newBtnCreate(newBtnType){
	let btnColor = ["danger", "warning"]
	let btnText = ['서버 끄기', '서버 켜기'];
	
	containerDiv.innerHTML = null;
	let newBtn = document.createElement('button');
	newBtn.setAttribute('type', "button");
	newBtn.setAttribute('id', "serverSetOff");
	newBtn.setAttribute('name', "controllServer");
	newBtn.classList.add('btn', 'btn-outline-'+btnColor[newBtnType]);
	newBtn.innerHTML = btnText[newBtnType];
	if(newBtnType==0){
		newBtn.addEventListener('click', serverSetOff, false);
	}else if(newBtnType==1){
		newBtn.addEventListener('click', serverSetOn, false);
	}
	containerDiv.appendChild(newBtn);
}