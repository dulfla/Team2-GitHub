<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

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
	#modifyForm img{
		width:150px;
		height:150px;
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
			        <img class="bd-placeholder-img card-img-top bg-light p-3" src="${path}resources/img/category/newCategory.png" alt="새 카테고리 등록하기" width="110px" height="110px">
		            <div class="card-body p-2">
		               	<h4 class="card-head mb-2 categoryName">카테고리 추가하기</h4>
		               	<p class="card-text count">새로운 카테고리 등록</p>
		          	</div>
	          		<a class="dropdown-toggle position-absolute top-0 end-0 m-1 moreMenu"
	          				role="button" data-bs-toggle="dropdown" aria-expanded="false">
						••
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
				        <img class="bd-placeholder-img card-img-top bg-light p-3" src="CategoryImage?fileName=${c.icon}" alt="${c.category} 아이콘" width="110px" height="110px">
			            <div class="card-body p-2">
			               	<h4 class="card-head mb-2 categoryName">${c.category}</h4>
			               	<p class="card-text count"><fmt:formatNumber value="${c.cnt}" pattern="###,###,###"/> 개</p>
	            		</div>
	            		<a class="dropdown-toggle position-absolute top-0 end-0 m-1 moreMenu"
	            				role="button" data-bs-toggle="dropdown" aria-expanded="false">
							••
						</a>
						<ul class="dropdown-menu">
							<li><button class="dropdown-item" data-bs-toggle="modal" data-bs-target="#categoryModal" type="button" sortation="categoryMf">카테고리 명칭 수정</button></li>
							<li><button class="dropdown-item" data-bs-toggle="modal" data-bs-target="#categoryModal" type="button" sortation="iconMf">카테고리 아이콘 수정</button></li>
							<li><button class="dropdown-item" type="button">카테고리 삭제</button></li>
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
						    	<label for="registerC" class="col-form-label">Title</label>
						    	<input type="text" id="registerC" placeholder="추가하려는 카테고리명을 입력하세요." class="form-control">
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
					    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">수정 취소</button>
					    <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="completeBtn">수정 완료</button>
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
			console.log(sortation)
			if(modalForm!=null){
				if(sortation=='categoryMf'){
					modalTitle.innerHTML = "카테고리 명칭 수정";
					
					document.getElementById('beforeModifyC').value=selectedCategory;
					document.getElementById('afterModifyC').addEventListener('input', canUesThisCategoryTitle, false);
				}else if(sortation=='iconMf'){
					modalTitle.innerHTML = "카테고리 아이콘 수정";
					
					document.getElementById('beforeModifyI').setAttribute('src', selectedIcon);
					document.getElementById('beforeModifyI').setAttribute('alt', selectedCategory+" 수정 전 이미지");
					
					document.getElementById('afterModifyI').addEventListener('change', imgCheckAndView, false);
					
					document.getElementById('iconChooseBtn').addEventListener('click', function(){
						document.getElementById('afterModifyI').click();
					}, false);
				}else if(sortation=='registerC'){
					modalTitle.innerHTML = "카테고리 등록";
					
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
		}
		
		function sendCategoryAdminForm(){
			if((sortation=='icon')?(fileCheck):(nameCheck)){
				if(sortation=='icon'){
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
				}else{
					let val = document.getElementById('afterModify').value; /* **** */
					
					$.ajax({
					 	url: 'CategoryTitleModify',
					 	contentType : 'application/json; charset=UTF-8',
					 	data : JSON.stringify({
							category: selectedCategory,
							data: val
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
			}
		}
		
		function canUesThisCategoryTitle(e){
			let title = e.currentTarget.value;
			if(title==selectedCategory){
				nameCheck = false;
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
				 		}else{
				 			nameCheck = false;
				 		}
				 	},
				 	error : function(data){
				 		console.log(JSON.stringify(data))
				 	}
				});
			}
		}
		
		function imgCheckAndView(e){
			let file = e.currentTarget.files[0];
			let fileType = file.name.split(".");
			fileType = fileType[fileType.length-1];
			
			let resultDiv = document.getElementById('showSelectedIcon'); /* **** */
			resultDiv.innerHTML = null;
			
			if(iconFileChecking(fileType, file.size)){
				fileCheck = true;
				
				let tempUrl = window.URL.createObjectURL(file);
				
				let iconImg = document.createElement('img');
				iconImg.setAttribute('src', tempUrl);
				iconImg.setAttribute('alt', "수정을 위해 등록한 이미지");
				resultDiv.appendChild(iconImg);
				
				newIconFile = file;
			}else{
				fileCheck = false;
				let notice = document.createElement('h6');
				notice.classList.add('mt-4');
				notice.innerHTML = "해당 파일은<br>카테고리 아이콘으로<br>등록 할수 없습니다.";
				resultDiv.appendChild(notice);
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
		
		function categoryReload(){
			let template = document.getElementsByClassName('categoryBox')[0].cloneNode(true);
			let categoryList = document.getElementById('categoryList');
			
			$.ajax({
			 	url: 'CategoryList',
			 	type : 'POST',
			 	dataType : 'json',
			 	success : function(data){
			 		if(data!=null){ categoryList.innerHTML = null; }
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