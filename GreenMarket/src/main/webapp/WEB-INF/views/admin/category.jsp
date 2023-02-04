<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린 마켓</title>
<link rel="icon" href="${path}resources/img/icon.png">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="${path}resources/script/admin/category.js"></script>
<style type="text/css">
	#main{
		min-height: 100vh;
	}
	.categoryBox{
		width:160px;
	}
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
	<div id="main">
		<div class="container mt-5 mb-5">
			<div class="row row-cols-auto g-5" id="categoryList">
				<div class="col categoryBox" width="110px" height="150px" idx="0">
			    	<div class="position-relative card shadow-sm">
				        <img class="bd-placeholder-img card-img-top bg-light p-3" src="${path}resources/img/category/newCategory.png" alt="새 카테고리 등록하기">
			            <div class="card-body p-2">
			               	<h4 class="card-head mb-2 categoryName">새 카테고리 추가</h4>
			               	<p class="card-text count">카테고리 등록</p>
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
	</div>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>