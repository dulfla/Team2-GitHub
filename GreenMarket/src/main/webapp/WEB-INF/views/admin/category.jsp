<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린 마켓</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<style type="text/css">
	.categoryName{
		font-size:12px;
	}
	.count{
		font-size:7px;
		text-align:right;
	}
	.moreMenu{
		text-decoration:none;
		color:black;
		line-height:0.5em;
	}
	.dropdown-item{
		font-size:12px;
	}
	.card img{
		width:110px;
		height:110px;
	}
	#iconMf img{
		width:150px;
		height:150px;
	}
	#registerC img{
		width:380px;
		height:380px;
	}
	.remove{
		display:none;
	}
</style>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<div class="container mt-5 mb-5">
		<div class="row row-cols-auto g-5" id="categoryList">
			<div class="col categoryBox" width="110px" height="150px" idx="0">
		    	<div class="position-relative card shadow-sm">
			        <img class="bd-placeholder-img card-img-top bg-light p-3" src="${path}resources/img/category/newCategory.png" alt="새 카테고리 등록하기">
		            <div class="card-body p-2">
		               	<h4 class="card-head mb-2 categoryName">카테고리 추가하기</h4>
		               	<p class="card-text count">새로운 카테고리 등록</p>
		          	</div>
	          		<a class="dropdown-toggle position-absolute top-0 end-0 m-1 moreMenu"
	          				role="button" data-bs-toggle="dropdown" aria-expanded="false">
						•••
					</a>
					<ul class="dropdown-menu">
						<li><button class="dropdown-item" data-bs-toggle="modal" data-bs-target="#categoryModal" type="button" sortation="categoryMf">카테고리 명칭 수정</button></li>
						<li><button class="dropdown-item" data-bs-toggle="modal" data-bs-target="#categoryModal" type="button" sortation="iconMf">카테고리 아이콘 수정</button></li>
						<li><button class="dropdown-item" type="button">카테고리 삭제</button></li>
					</ul>
		        </div>
	      	</div>
			<c:forEach items="${categorys}" var="c" varStatus="i">
				<div class="col categoryBox" width="110px" height="150px" idx="${i.count}">
			    	<div class="position-relative card shadow-sm">
				        <img class="bd-placeholder-img card-img-top bg-light p-3" src="CategoryImage?fileName=${c.icon}" alt="${c.category} 아이콘">
			            <div class="card-body p-2">
			               	<h4 class="card-head mb-2 categoryName">${c.category}</h4>
			               	<p class="card-text count"><fmt:formatNumber value="${c.cnt}" pattern="###,###,###"/> 개</p>
	            		</div>
	            		<a class="dropdown-toggle position-absolute top-0 end-0 m-1 moreMenu"
	            				role="button" data-bs-toggle="dropdown" aria-expanded="false">
							•••
						</a>
						<ul class="dropdown-menu">
							<li><button class="dropdown-item" data-bs-toggle="modal" data-bs-target="#categoryModal" type="button" sortation="categoryMf">카테고리 명칭 수정</button></li>
							<li><button class="dropdown-item" data-bs-toggle="modal" data-bs-target="#categoryModal" type="button" sortation="iconMf">카테고리 아이콘 수정</button></li>
							<li><button class="dropdown-item categoryDelete" type="button">카테고리 삭제</button></li>
						</ul>
	          		</div>
	        	</div>
	      	</c:forEach>
      	</div>
      	<div class="modal fade" id="categoryModal" tabindex="-1" aria-labelledby="categoryModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
				<div class="modal-content">
					<div class="modal-header">
					    <h1 class="modal-title fs-5" id="categoryModifyModalLabel"></h1>
					    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="modalClose"></button>
					</div>
					<div id="categoryAdminModal" class="modal-body">
					    <form id="categoryMf" class="remove" name="modifyTitleForm">
						    <div class="mb-3" id="beforeC">
						    	<label for="beforeModifyC" class="col-form-label">NOW</label>
						    	<input type="text" id="beforeModifyC" readonly class="form-control">
						    </div>
						    <div class="mb-3" id="afterC">
						    	<label for="afterModifyC" class="col-form-label">NEW</label>
						    	<input type="text" id="afterModifyC" class="form-control">
						    </div>
						    <br>
						    <div class="mb-3" id="optionC">
						    	<h5>바꾸려는 카테고리에 등록된 상품 처리 방식</h5>
						    	<label class="mb-1"><input type='radio' name='titleModifyOption' value='this'> 이 카테고리 유지</label>
						    	<br>
								<label><input type='radio' name='titleModifyOption' value='other'> 새 카테고리로 이전</label>
						    </div>
						    <div class="mb-3 remove" id="selectC">
						    	<select name="selectC" class="form-select" size="5">
						    		<c:forEach items="${categorys}" var="c" varStatus="cc">
							    		<option name="selectOptionC" value="${c.category}">${c.category}</option>
						    		</c:forEach>
						    	</select>
						    </div>
					    </form>
					    <form id="iconMf" class="remove row" name="modifyIconForm" class="row">
						    <div class="mb-3 col-6" id="beforeI">
						    	<label for="beforeModifyI" class="col-form-label">NOW</label>
						    	<br>
						    	<img id="beforeModifyI" alt="" src="" class="mt-2">
						    </div>
						    <div class="mb-3 col-6" id="afterI">
						    	<label for="afterModifyI" class="col-form-label">NEW</label>
						    	<input type="file" id="afterModifyI" style="display:none;">
								<button id="iconChooseBtn" type="button" class="btn btn-warning ms-5">파일 선택</button>
						    	<br>
						    	<div class="showSelectedIcon" class="mt-2"></div>
						    </div>
					    </form>
					    <form id="registerC" class="remove" name="registerForm">
						    <div class="mb-3" id="regC">
						    	<label for="registerCate" class="col-form-label">Title</label>
						    	<input type="text" id="registerCate" placeholder="추가하려는 카테고리명을 입력하세요." class="form-control">
						    </div>
						    <div class="mb-3" id="regI">
						    	<label for="registerI" class="col-form-label col-6">Icon</label>
						    	<input type="file" id="registerI" style="display:none;">
								<button id="iconSelectBtn" type="button" class="btn btn-warning ms-5">파일 선택</button>
						    	<br>
						    	<div class="showSelectedIcon" class="mt-2"></div>
						    </div>
					    </form>
						<form id="noAction" class="remove">
						    <h4>해당 기능을 사용할 수 없습니다.</h4>
						</form>
					</div>
					<div class="modal-footer">
					    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
					    <button type="button" class="btn btn-primary" id="completeBtn">완료</button>
					</div>
				</div>
			</div>
		</div>
		<button id="categoryRegisterBtn" class="remove" data-bs-toggle="modal" data-bs-target="#categoryModal" type="button"></button>
	</div>
	<%@ include file="../include/footer.jsp" %>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script type="text/javascript">
		let newCategoryAdd = null;
		let categoryModal = null;
		let completeBtn = null;
		
		let choosedCategoryBoxIdx = null;
		let activeBtn = null;
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
			
			activeBtn = document.activeElement;
			sortation = activeBtn.getAttribute('sortation');
			if(sortation==null){
				sortation = "registerC";
			}
			
			if(sortation!="registerC"){
				choosedCategoryBoxIdx = activeBtn.parentElement.parentElement.parentElement.parentElement.getAttribute('idx');
				if(choosedCategoryBoxIdx==0){
					sortation = 'noAction';
				}
				
				selectedCategory = activeBtn.parentElement.parentElement.parentElement.getElementsByClassName('categoryName')[0].innerHTML;
				selectedIconUrl = activeBtn.parentElement.parentElement.parentElement.getElementsByTagName('img')[0].getAttribute('src');
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
					
					let selectOpsions = document.getElementsByName('selectOptionC');
					selectOpsions.forEach(so => {
						if(so.value==selectedCategory){
							so.setAttribute('disabled', "disabled");
						}else if(so.getAttribute('disabled')=='disabled'){
							so.removeAttribute('disabled');
						}
					});
				}else if(sortation=='iconMf'){
					modalTitle.innerHTML = "\""+selectedCategory+"\" 아이콘 수정";
					
					document.getElementById('beforeModifyI').setAttribute('src', selectedIconUrl);
					document.getElementById('beforeModifyI').setAttribute('alt', selectedCategory+" 수정 전 이미지");
					
					document.getElementById('afterModifyI').addEventListener('change', imgCheckAndView, false);
					
					document.getElementById('iconChooseBtn').addEventListener('click', function(){
						document.getElementById('afterModifyI').click();
					}, false);
				}else if(sortation=='registerC'){
					modalTitle.innerHTML = "카테고리 등록";
					
					document.getElementById('registerCate').addEventListener('input', canUesThisCategoryTitle, false);
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
				 		console.log(JSON.stringify(data))
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
			 			console.log('수정 완료');
			 			categoryReload();
			 			document.getElementById('modalClose').click();
			 		}else if(data==2){
			 			console.log('수정 요류');
			 		}
			 	},
			 	error : function(data){
			 		console.log(JSON.stringify(data));
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
			 			console.log('수정 완료');
			 			categoryReload();
			 			document.getElementById('modalClose').click();
			 		}else if(data==2){
			 			console.log('수정 요류');
			 		}
			 	},
			 	error : function(data){
			 		console.log(JSON.stringify(data));
			 	}
			});
		}
		
		function registerCategorySubmit() {
			let title = document.getElementById('registerCate').value;
			console.log(document.getElementById('registerCate'))
			console.log(title)
			
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
			 			console.log('등록 완료');
			 			categoryReload();
			 			document.getElementById('modalClose').click();
			 		}else if(data==2){
			 			console.log('등록 요류');
			 		}
			 	},
			 	error : function(data){
			 		console.log(JSON.stringify(data));
			 	}
			});
		}
		
		function categoryDelete(e) {
			let target = e.currentTarget;
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
												category: choosedCategory,
												move: value
									    	}),
										 	type : 'POST',
										 	dataType : 'json',
										 	success : function(data){
										 		if(data==1){
										 			console.log('삭제 완료');
										 			categoryReload();
										 			document.getElementById('modalClose').click();
										 		}else if(data==2){
										 			console.log('삭제 요류');
										 		}
										 	},
										 	error : function(data){
										 		console.log(JSON.stringify(data));
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
					 		console.log(JSON.stringify(data));
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
								cIcon.setAttribute('src', "CategoryImage?fileName="+data[i-1].icon);
								cIcon.setAttribute('alt', data[i-1].category+" 아이콘");
								
								let cH4 = template.getElementsByTagName('h4')[0];
								cH4.innerHTML = data[i-1].category;
								
								let cP = template.getElementsByTagName('p')[0];
								let counts = data[i-1].cnt;
								cP.innerHTML = counts.toLocaleString()+" 개";
								
								categoryList.appendChild(template);
				 			}else{
				 				categoryList.appendChild(template);
				 			}
				 		}
			 		}else{
			 			categoryList.appendChild(template);
			 		}
			 		newCategoryAdd = document.getElementsByClassName('categoryBox')[0];
	 				newCategoryAdd.addEventListener('click', openModal, false);
			 	},
			 	error : function(data){
			 		console.log(JSON.stringify(data));
			 	}
			});
		}
		
		function doseNotActive(){
			console.log('실행 할 수 없음');
		}
	</script>
</body>
</html>