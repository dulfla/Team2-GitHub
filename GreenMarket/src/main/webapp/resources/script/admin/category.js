let newCategoryAdd = null;
let categoryModal = null;
let completeBtn = null;

let choosedCategoryBoxIdx = null;
let activeBtnType = null;
let sortation = null;
let selectedCategory = null;
let selectedIcon = null;

let fileCheck = false;
let nameCheck = false;

let newIconFile = null;

window.onload = function(){
	categoryModal = document.getElementById('categoryModal');
	
	newCategoryAdd = document.getElementsByClassName('categoryBox')[0];
	newCategoryAdd.addEventListener('click', openModal, false);
	
	categoryModal.addEventListener('show.bs.modal', chooseMatchedModal, false);
	categoryModal.addEventListener('hide.bs.modal', closeModal, false);
	
	completeBtn = document.getElementById('completeBtn');
	completeBtn.addEventListener('click', sendCategoryAdminForm, false);
	
	let categoryDeleteBtn = document.getElementsByClassName('categoryDelete');
	for(let i=0; i<categoryDeleteBtn.length; i++){
		categoryDeleteBtn[i].addEventListener('click', categoryDelete, false);
	}
}

function openModal(){
	let categoryRegisterBtn = document.getElementById('categoryRegisterBtn').click();
}

function chooseMatchedModal() {
	fileCheck = false;
	nameCheck = false;
	newIconFile = null;
	
	activeBtnType = document.activeElement;
	sortation = activeBtnType.getAttribute('sortation');
	if(sortation==null){
		sortation = "registerC";
	}
	
	if(sortation!="registerC"){
		choosedCategoryBoxIdx = activeBtnType.parentElement.parentElement.parentElement.parentElement.getAttribute('idx');
		if(choosedCategoryBoxIdx==0){
			sortation = 'noAction';
		}
		
		selectedCategory = activeBtnType.parentElement.parentElement.parentElement.getElementsByClassName('categoryName')[0].innerHTML;
		selectedIconUrl = activeBtnType.parentElement.parentElement.parentElement.getElementsByTagName('img')[0].getAttribute('src');
	}
	
	const modalTitle = document.getElementById('categoryModifyModalLabel');
	const modalFormList = document.getElementById('categoryAdminModal').childNodes[0].parentElement.getElementsByTagName('form');
	
	let modalForm = null;
	for(let i=0; i<modalFormList.length; i++){
		if(modalFormList[i].getAttribute('id')==sortation){
			modalForm = modalFormList[i];
			modalFormList[i].classList.remove('remove');
			break;
		}
	}
	
	if(modalForm!=null){
		if(sortation=='categoryMf'){
			modalTitle.innerHTML = "\""+selectedCategory+"\" 카테고리 명칭 수정";
			
			document.getElementById('beforeModifyC').value=selectedCategory;
			document.getElementById('afterModifyC').addEventListener('input', canUesThisCategoryTitle, false);
			
			document.getElementsByName('titleModifyOption').forEach(rido => {
				if(rido.value=='this'){
					rido.checked=true;
				}else if(rido.checked){
					rido.checked=false;
				}
				rido.addEventListener('click', onOffOptionSelect, false);
			});
			
			let selectC = document.getElementsByName('selectC')[0];
			selectC.innerHTML = null;
			$.ajax({
			 	url: 'CategoryList',
			 	type : 'POST',
			 	dataType : 'json',
			 	success : function(data){
			 		if(data!=null && 1<data.length){
			 			for(let i=0; i<data.length; i++){
			 				let opt = document.createElement('option');
				 			opt.setAttribute('name', "selectOptionC");
				 			opt.setAttribute('value', data[i].category);
				 			opt.innerHTML = data[i].category
				 			if(data[i].category==selectedCategory){
				 				opt.setAttribute('disabled', "disabled");
				 			}
				 			selectC.appendChild(opt);
			 			}
				 	}
			 	},
			 	error : function(data){
			 		// console.log(JSON.stringify(data));
			 	}
			});
		}else if(sortation=='iconMf'){
			modalTitle.innerHTML = "\""+selectedCategory+"\" 아이콘 수정";
			
			document.getElementById('beforeModifyI').setAttribute('src', selectedIconUrl);
			document.getElementById('beforeModifyI').setAttribute('alt', selectedCategory+" 수정 전 이미지");
			
			document.getElementById('afterModifyI').value = null;
			document.getElementById('afterModifyI').addEventListener('change', imgCheckAndView, false);
			
			document.getElementById('iconChooseBtn').addEventListener('click', function(){
				document.getElementById('afterModifyI').click();
			}, false);
		}else if(sortation=='registerC'){
			modalTitle.innerHTML = "카테고리 등록";
			
			document.getElementById('registerCate').addEventListener('input', canUesThisCategoryTitle, false);
			document.getElementById('registerI').value = null;
			document.getElementById('registerI').addEventListener('change', imgCheckAndView, false);
			
			document.getElementById('iconSelectBtn').addEventListener('click', function(){
				document.getElementById('registerI').click();
			}, false);
		}else if(sortation=='noAction'){
			modalTitle.innerHTML = "";
		}
	}
}

function closeModal() {
	const modalTitle = document.getElementById('categoryModifyModalLabel');
	const modalFormList = document.getElementById('categoryAdminModal').childNodes[0].parentElement.getElementsByTagName('form');

	modalTitle.innerHTML = null;
	for(let i=0; i<modalFormList.length; i++){
		if(!modalFormList[i].classList.contains('remove')){
			modalFormList[i].classList.add('remove');
		}
	}
	
	let iconImgDiv = document.getElementsByClassName('showSelectedIcon');
	for(let i=0; i<iconImgDiv.length; i++){
		iconImgDiv[i].innerHTML = null;
	}
	
	if(!document.getElementById('selectC').classList.contains('remove')){
		document.getElementById('selectC').classList.add('remove');
	}
	
	document.getElementById("registerCate").value=null;
	if(document.getElementById("registerCate").classList.contains('border-danger')){
		document.getElementById("registerCate").classList.remove('border-danger');
	}
	
	document.getElementById("afterModifyC").value=null;
	if(document.getElementById("afterModifyC").classList.contains('border-danger')){
		document.getElementById("afterModifyC").classList.remove('border-danger');
	}
}

function sendCategoryAdminForm(){
	if(sortation=='iconMf'){
		if(fileCheck){ modifyCategoryIconSubmit(); }
	}else if(sortation=='categoryMf'){
		if(nameCheck){ modifyCategoryCategorySubmit(); }
	}else if(sortation=='registerC'){
		if(fileCheck && nameCheck){ registerCategorySubmit(); }
	}
}

function onOffOptionSelect(e){
	let option = e.currentTarget.value;
	if(option=='other'){
		document.getElementById('selectC').classList.remove('remove');
	}else if(!document.getElementById('selectC').classList.contains('remove')){
		document.getElementById('selectC').classList.add('remove');
	}
}

function canUesThisCategoryTitle(e){
	let targetId = e.currentTarget.getAttribute('id');
	let target = document.getElementById(targetId);
	let title = target.value;
	
	if(title==selectedCategory){
		nameCheck = false;
		if(!target.classList.contains('border-danger')){
			target.classList.add('border-danger');
		}
	}else{
		$.ajax({
		 	url: "CheckCategoryTitle",
		 	type : 'POST',
			contentType:'application/json; charset=UTF-8',
		 	data : JSON.stringify({
				oldC : selectedCategory,
				newC : title
	    	}),
		 	dataType : 'json',
		 	success : function(data){
		 		if(data){
		 			nameCheck = true;
		 			if(target.classList.contains('border-danger')){
		 				target.classList.remove('border-danger');
					}
		 		}else{
		 			nameCheck = false;
		 			if(!target.classList.contains('border-danger')){
		 				target.classList.add('border-danger');
					}
		 		}
		 	},
		 	error : function(data){
		 		// console.log(JSON.stringify(data))
		 	}
		});
	}
}

function imgCheckAndView(e){
	let iconImgDiv = document.getElementsByClassName('showSelectedIcon');
	for(let i=0; i<iconImgDiv.length; i++){
		iconImgDiv[i].innerHTML = null;
	}
	
	let target = e.currentTarget;
	if(0<target.files.length){
		let file = target.files[0];
		let fileType = file.name.split(".");
		fileType = fileType[fileType.length-1];
		
		let num = (sortation=='iconMf')?(0):(1);
		
		if(iconFileChecking(fileType, file.size)){
			fileCheck = true;
			
			let tempUrl = window.URL.createObjectURL(file);
			
			let iconImg = document.createElement('img');
			iconImg.setAttribute('src', tempUrl);
			iconImg.setAttribute('alt', "수정을 위해 등록한 이미지");
			iconImg.classList.add('mt-2')
			document.getElementsByClassName('showSelectedIcon')[num].appendChild(iconImg);
			
			newIconFile = file;
		}else{
			fileCheck = false;
			let notice = document.createElement('h6');
			notice.classList.add('mt-4');
			notice.innerHTML = "해당 파일은<br>카테고리 아이콘으로<br>등록 할수 없습니다.";
			document.getElementsByClassName('showSelectedIcon')[num].appendChild(notice);
		}
	}else{
		fileCheck = false;
	}
}

function iconFileChecking(type, size){
	let maxFileSize = 1048576; // 1MB
	
	if(type!='jpg' && type!='png'){
		return false;
	}
	if(maxFileSize<size){
		return false;
	}
	return true;
}

function modifyCategoryIconSubmit() {
	let val = newIconFile;
	let sendData = new FormData();
	sendData.append("file", val);
	
	let fileType = val.name.split(".");
	fileType = fileType[fileType.length-1];
	
	$.ajax({
	 	url: 'CategoryIconModify?c='+selectedCategory+"&fileType="+fileType,
	 	processData : false,
	 	contentType : false,
	 	data : sendData,
	 	type : 'POST',
	 	dataType : 'json',
	 	success : function(data){
	 		if(data==1){
	 			// console.log('수정 완료');
	 			categoryReload();
	 			document.getElementById('modalClose').click();
	 		}else if(data==2){
	 			// console.log('수정 요류');
	 		}
	 	},
	 	error : function(data){
	 		// console.log(JSON.stringify(data));
	 	}
	});
}

function modifyCategoryCategorySubmit() {
	let val = document.getElementById('afterModifyC').value;
	
	let moveOp;
	document.getElementsByName('titleModifyOption').forEach(rido => {
		if(rido.checked==true){
			moveOp = rido.value;
		}
	});
	
	let moveVal;
	if(moveOp=="this"){
		moveVal = val;
	}else{
		moveVal = document.getElementsByName('selectC')[0].value;
	}
	
	$.ajax({
	 	url: 'CategoryTitleModify',
	 	contentType : 'application/json; charset=UTF-8',
	 	data : JSON.stringify({
			category: selectedCategory,
			data: val,
			move: moveVal
    	}),
    	type : 'POST',
	 	dataType : 'json',
	 	success : function(data){
	 		if(data==1){
	 			// console.log('수정 완료');
	 			categoryReload();
	 			document.getElementById('modalClose').click();
	 		}else if(data==2){
	 			// console.log('수정 요류');
	 		}
	 	},
	 	error : function(data){
	 		// console.log(JSON.stringify(data));
	 	}
	});
}

function registerCategorySubmit() {
	let title = document.getElementById('registerCate').value;
	
	let val = newIconFile;
	let sendData = new FormData();
	sendData.append("file", val);
	
	let fileType = val.name.split(".");
	fileType = fileType[fileType.length-1];
	
	$.ajax({
	 	url: 'CategoryRegister?c='+title+"&fileType="+fileType,
	 	processData : false,
	 	contentType : false,
	 	data : sendData,
	 	type : 'POST',
	 	dataType : 'json',
	 	success : function(data){
	 		if(data==1){
	 			// console.log('등록 완료');
	 			categoryReload();
	 			document.getElementById('modalClose').click();
	 		}else if(data==2){
	 			// console.log('등록 요류');
	 		}
	 	},
	 	error : function(data){
	 		// console.log(JSON.stringify(data));
	 	}
	});
}

function categoryDelete(e) {
	let target = e.currentTarget;
	if(target.parentElement.parentElement.parentElement)
	Swal.fire({
	   title: '삭제하면 되돌릴 수 없습니다.',
	   text: '정말로 삭제하시겠습니까?',
	   icon: 'warning',
	   
	   showCancelButton: true,
	   confirmButtonColor: '#3085d6',
	   cancelButtonColor: '#d33',
	   confirmButtonText: '삭제',
	   cancelButtonText: '취소',
	   
	   reverseButtons: false,
	   
	}).then(result => {
	    if (result.isConfirmed) {
	    	let choosedCategory = target.parentElement.parentElement.parentElement.getElementsByClassName('categoryName')[0].innerHTML;

	    	$.ajax({
			 	url: 'CategoryList',
			 	type : 'POST',
			 	dataType : 'json',
			 	success : function(data){
			 		if(data!=null && 1<data.length){
			 			let selectBox = new Map;
				 		for(let i=0; i<data.length; i++){
				 			if(data[i].category!=choosedCategory){
				 				selectBox.set(data[i].category, data[i].category);
				 			}
				 		}
			 			Swal.fire({
							title: '기존 카테고리의 상품들을<br>이동시킬 카테고리 지정',
						  	input: 'select',
						  	inputOptions: selectBox,
						  	inputPlaceholder: '카테고리',
						  	showCancelButton: true,
						  	inputValidator: function (value) {
						  		return new Promise(function (resolve, reject) {
						      		if (value!='' && value!=null) {
						        		resolve();
						      		} else {
						    	  		resolve('상품을 이동시킬 카테고리를 선택하셔야 합니다.');
						      		}
						    	});
							},
							confirmButtonColor: '#3085d6',
							cancelButtonColor: '#d33',
							confirmButtonText: '확인',
							cancelButtonText: '취소',
							
							reverseButtons: false,
						}).then(function (result) {
							if (result.isConfirmed) {
								let value = result.value;
							 	$.ajax({
								 	url: 'CategoryDelete',
								 	contentType : 'application/json; charset=UTF-8',
								 	data : JSON.stringify({
										data: choosedCategory,
										move: value
							    	}),
								 	type : 'POST',
								 	dataType : 'json',
								 	success : function(data){
								 		if(data==1){
								 			// console.log('삭제 완료');
								 			categoryReload();
								 			document.getElementById('modalClose').click();
								 		}else if(data==2){
								 			// console.log('삭제 요류');
								 		}
								 	},
								 	error : function(data){
								 		// console.log(JSON.stringify(data));
								 	}
								});
							}
		 				});
			 		}else{
			 			Swal.fire({
			 				title: "ERROR!",
							html: "이동할 카테고리가 존재하지 않아서<br>해당 작업을 수행 할 수 없습니다.<br>카테고리삭제 작업이 취소됩니다.",
							icon: "warning",
							confirmButtonColor: '#3085d6',
							confirmButtonText: '닫기',
						});
			 			return;
			 		}
			 	},
			 	error : function(data){
			 		// console.log(JSON.stringify(data));
			 	}
			});
	    }else if (result.isDismissed) {
	    	// 만약 모달창에서 cancel 버튼을 눌렀다면
	    }
	});
}

function categoryReload(){
	let template = document.getElementsByClassName('categoryBox')[0].cloneNode(true);
	let categoryList = document.getElementById('categoryList');
	
	$.ajax({
	 	url: 'CategoryList',
	 	type : 'POST',
	 	dataType : 'json',
	 	success : function(data){
	 		if(data!=null){ 
	 			categoryList.innerHTML = null;
	 			for(let i=0; i<=data.length; i++){
		 			if(0<i){
		 				template = document.getElementsByClassName('categoryBox')[0].cloneNode(true);
		 				
		 				template.setAttribute('idx', i);
						
						let cIcon = template.getElementsByTagName('img')[0];
						cIcon.setAttribute('src', "CategoryImage?fileName="+data[i-1].icon+"&refresh="+(new Date()));
						cIcon.setAttribute('alt', data[i-1].category+" 아이콘");
						
						let cH4 = template.getElementsByTagName('h4')[0];
						cH4.innerHTML = data[i-1].category;
						
						let cP = template.getElementsByTagName('p')[0];
						let counts = data[i-1].cnt;
						cP.innerHTML = counts.toLocaleString()+" 개";
						
						let deleteB = template.getElementsByTagName('li')[2].getElementsByTagName('button')[0];
						deleteB.classList.add('categoryDelete');
						
						categoryList.appendChild(template);
		 			}else{
		 				categoryList.appendChild(template);
		 			}
		 		}
		 		let categoryDeleteBtn = document.getElementsByClassName('categoryDelete');
		 		if(categoryDeleteBtn.length>0){
		 			for(let i=0; i<categoryDeleteBtn.length; i++){
						categoryDeleteBtn[i].addEventListener('click', categoryDelete, false);
					}
		 		}
	 		}else{
	 			categoryList.appendChild(template);
	 		}
	 		newCategoryAdd = document.getElementsByClassName('categoryBox')[0];
			newCategoryAdd.addEventListener('click', openModal, false);
	 	},
	 	error : function(data){
	 		// console.log(JSON.stringify(data));
	 	}
	});
}