let btn;
let containerDiv;

window.onload = function(){
	btn = document.getElementsByName('controllServer')[0];
	
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
			changeBtn(0);
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
			changeBtn(1);
		}
	});
}

function changeBtn(newBtnType){
	let btnColor = ["danger", "warning"]
	let btnText = ['서버 끄기', '서버 켜기'];
	
	btn.setAttribute('id', "serverSetOff");
	btn.setAttribute('class', 'btn btn-outline-'+btnColor[newBtnType]);
	btn.classList.add('position-absolute', 'top-50', 'start-50', 'translate-middle');
	btn.innerHTML = btnText[newBtnType];
	
	if(newBtnType==0){
		btn.removeEventListener('click', serverSetOn);
		btn.addEventListener('click', serverSetOff, false);
	}else if(newBtnType==1){
		btn.removeEventListener('click', serverSetOff);
		btn.addEventListener('click', serverSetOn, false);
	}
}