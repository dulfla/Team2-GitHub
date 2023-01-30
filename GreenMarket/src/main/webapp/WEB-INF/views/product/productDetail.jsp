<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린 마켓</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	490ef0680625aa2086d3bf61d038acea"></script>
<style type="text/css">
/* 	#result_card img{
		max-width: 100%;
	    height: 500px;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;
	    border-radius: 2%;
	} */
	.pics {      /* 전체 케러셀 */
		width: 600px;
		float: left;
		position: relative;
		left: 50%;		
        }
	.carousel-inner {
		width: 100%;
		height: 400px; /* 이미지 높이 변경 */
		cursor: pointer;
	}
	.breadcrumb {
    	margin-top: 0px;
    	font-size: 13px;
	}
	.breadcrumb li {
	    display: inline-block
	}
	.breadcrumb a {
	    color: #b5b6bd;
	    display: inline-block;
	    margin-right: 5px;
	    padding-right: 14px;
	    position: relative;
	    text-decoration-line: none;
	}
	.breadcrumb a:hover {
	    color: #086fcf
	}
	.breadcrumb a:after {
	    color: #b5b6bd;
	    content: ">";
	    position: absolute;
	    right: 0
	}
	#profile, .description, .map {
		margin-top: 15px;
		padding-bottom: 10px;
		border-bottom: 2px solid #e9ecef;
	}
	#kakaoMap {
		padding-bottom: 23px;
		border-bottom: 2px solid #e9ecef;
	}
	.title {
		font-size: 20px;
	    font-weight: 600;
	    line-height: 1.5;
	    letter-spacing: -0.6px;
	}
	#title {
		margin-top: 20px;
	}
	.regdate {
		float: right;
	}
	.views {
		float: left;
	}
	.regdate, .views {
	    letter-spacing: -0.6px;
	    color: #868e96;
	    margin-top: 15px;
	}
	.category {
		margin-top: 4px;
	    font-size: 13px;
	    line-height: 1.46;
	    letter-spacing: -0.6px;
	    color: #868e96;
	}
	.price {
		margin-top: 4px;
		font-size:18px; 
		font-weight:bold;
		line-height: 1.76;
    	letter-spacing: -0.6px;
	}
	.description {
		font-size: 17px;
	    line-height: 1.6;
	    letter-spacing: -0.6px;
	    margin: 16px 0;
	    word-break: break-all;
	    white-space: pre-wrap;
    	overflow-wrap: break-word;
	}
	#profileImg {
		width: 40px;
	    height: 40px;
	    object-fit: cover;
	    border-radius: 50%;
	}
</style>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<div>
		<div class="row ">
			<div class="col-lg-5 mx-auto">
				<div class="card mt-2 mx-auto p-4 bg-light">
					<div class="breadcrumb" role="navigation" aria-label="Breadcrumbs">
						<div class="_cont">
							<ol style="padding-left: 0;">
								<li><a href="productList?c=all&v=brandNew">중고거래</a></li>
								<li><a href="productList?c=${product.category}&v=product">${product.category}</a></li>
								<li>${product.p_name}</li>
							</ol>
						</div>
					</div>
					<div class="card-body bg-light">
						<div class = "container">
							<form id="contact-form" role="form" method="POST" autocomplete="off" enctype="multipart/form-data">
								<input type="hidden" name="type" value="${authInfo.type}">
								<input type="hidden" name="p_id" value="${product.p_id}" >
								<input type="hidden" name="email" value="${product.email}">
								<input type="hidden" name="authEmail" value="${authInfo.email}">
								<input type="hidden" name="nickname" value="${product.nickname}">
								<input type="hidden" id="lat" name="lat" value="${product.lat}">
								<input type="hidden" id="lng" name="lng" value="${product.lng}">
								<div class="controls">
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<div id="uploadResult" class="position-relative">
													<div id="carouselExampleControls" class="carousel carousel-dark slide" data-bs-ride="carousel">
													  <div class="carousel-inner" id="imgList">
													    <div class="carousel-item active">
													    	<div class="w-75">
													    		<img src="./resources/img/noImage.png" class="d-block w-100" alt="" class='img-fluid'>
													    	</div>
													    </div>
													  </div>
													  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
													    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
													    <span class="visually-hidden">Previous</span>
													  </button>
													  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
													    <span class="carousel-control-next-icon" aria-hidden="true"></span>
													    <span class="visually-hidden">Next</span>
													  </button>
													</div>
												</div>                       
											</div>
										</div>
									</div>
									<div class="row" id="profile">
										<div class="col-md-9">
											<div class="form-group">
												<img src="https://github.com/mdo.png" alt="${product.nickname}" id="profileImg">
												<span>${product.nickname}</span>
											</div>
										</div>
										<div class="col-md-3">
											<div class="form-group">
													<span class="regdate">
														<fmt:formatDate value="${product.regdate}" pattern="yyyy-MM-dd"/><br>
													</span>
													<span class="views">조회 ${product.views}</span> 
											</div>
										</div>
									</div>    
									<div class="row">
										<div class="col-md-12">
											<div class="form-group" id="title">
												<span class="title">${product.p_name}</span>              
											</div>                          
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<span class="category">${product.category}</span>             
											</div>                          
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<span class="price"><fmt:formatNumber value="${product.price}"  pattern="###,###,###"/>원</span>            
											</div>                          
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<span><pre class="description">${product.description}</pre></span>              
											</div>                          
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group" id="kakaoMap">
												<label style= "width:100%; text-align: center;">직거래 위치</label>
												<div id="map" style="max-width: 100%; height:500px;"></div>
											</div>
										</div>
									</div>
								</div>
							</form> 
						</div>
					</div>
					<div class="col-md-12">
						<!-- 작성자,관리자 수정삭제버튼 -->
						<c:if test="${product.email == authInfo.email || authInfo.type == 'M'}">
						<button type="button" id="modify_Btn" class="btn btn-warning">수정</button>
						<button type="button" id="delete_Btn" class="btn btn-danger">삭제</button>
							</c:if>
							<c:choose>
								<c:when test="${empty authInfo}">
									<button id="chatBtn" class="btn btn-primary" type="button">채팅하기</button>	
									<script type="text/javascript">
										window.onload = function(){
											let btn = document.getElementById('chatBtn');
											btn.addEventListener('click', function(){
												Swal.fire({
												   title: '채팅을 사용하시려면 로그인하셔야 합니다.',
												   text: '로그인 하러 이동하시겠습니까?',
												   icon: 'warning',
												   
												   showCancelButton: true,
												   confirmButtonColor: '#3085d6',
												   cancelButtonColor: '#d33',
												   confirmButtonText: '로그인',
												   cancelButtonText: '취소',
												   
												   reverseButtons: false,
												   
												}).then(result => {
												    if (result.isConfirmed) {
												       	location.href="login";
												    }else if (result.isDismissed) { // 만약 모달창에서 cancel 버튼을 눌렀다면
												    	
												    }
												});
											}, false);
										}
									</script>
								</c:when>
								<c:otherwise>
									<button id="openChattingBtn" class="btn btn-primary" type="button">
										채팅하기
									</button>
									<input type="hidden" name="email" id="userEmail" value="${authInfo.email}">
									<input type="hidden" name="p_id" id="productId" value="${product.p_id}">
									<%@ include file="../include/chat/chat.jsp" %>
								</c:otherwise>
							</c:choose>
							<button type="button" id="list_Btn" class="btn btn-outline-dark">목록</button>
					</div>
				</div> 
			</div>
	</div>
	<%@ include file="../include/footer.jsp" %>
	
	<script>
		var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
		//좌표 
		var lat = $("#lat").val();
		var lng = $("#lng").val();

	
		mapOption = { 
			center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
			level: 3 // 지도의 확대 레벨
		};
	
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(lat, lng); 
	
		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
			position: markerPosition
		});
	
		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
	
	
		var formObj = $("form[role='form']");
	
		$(document).ready(function(){
			
			/* 이미지 정보 호출 */
			let p_id = '<c:out value="${product.p_id}"/>';
			let uploadResult = $("uploadResult");
	
	
			$.getJSON("getImageList", {p_id : p_id}, function(arr){
			    
				console.log(arr);
				if(arr.length === 0){
					return;
				} 
				
/* 				let str = "";
				let obj;
				
				str += "<div id='result_card'"; */
				if(arr.length==1){
					let imgResult = document.getElementById('uploadResult');
					imgResult.innerHTML = null;
					
					obj = arr[0];
					
					let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					
					let img = document.createElement('img');
					img.setAttribute('src', 'display?fileName='+fileCallPath);
					img.classList.add('w-100')
					img.onclick= function () {
							window.open(this.src)
						};
					
					imgResult.appendChild(img)
					
/* 					str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
					str += ">"; */
						
				}else{
					let imgBox = document.getElementById('imgList');
					imgBox.innerHTML = null;
					
					for(let i=0; i<arr.length; i++){
						obj = arr[i];
						let carouselItem = document.createElement('div');
						carouselItem.classList.add('carousel-item');
						
						if(i==0){
							carouselItem.classList.add('active');
						}
						
						let div = document.createElement('div');
						div.classList.add('w-75');
						div.setAttribute('style', 'margin:0px auto');
						
						let fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
						
						let img = document.createElement('img');
						img.setAttribute('src', 'display?fileName='+fileCallPath);
						img.classList.add('w-100')
						img.onclick= function () {
							window.open(this.src)
						};
						
						div.appendChild(img)
						carouselItem.appendChild(div)
						imgBox.appendChild(carouselItem)
					}
				}
				
				/* str += "</div>"; */
				//uploadResult.html(str);
/* 				$("#uploadResult").html(str); */
			});		
		}); 
		$("#modify_Btn").click(function(){ 
			formObj.attr("action", "productModify");
			formObj.attr("method", "get")
			formObj.submit();
		});
	
		$("#delete_Btn").click(function(){
			Swal.fire({
				title: '게시글을 삭제 하시겠습니까?',
				text: '다시 되돌릴 수 없습니다. 신중하세요.',
				icon: 'warning',
	
				showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				confirmButtonText: '승인', // confirm 버튼 텍스트 지정
				cancelButtonText: '취소', // cancel 버튼 텍스트 지정
	
				reverseButtons: true, // 버튼 순서 거꾸로
	
			}).then(result => {
				// 만약 Promise리턴을 받으면,
				if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
	
					Swal.fire({
						title: '삭제가 완료되었습니다.',
						icon: 'success',
					}).then(result => {
						if(result.isConfirmed){
						formObj.attr("action", "productDelete");
						formObj.submit();
						}
					})					
				}
			})		 
		});
		$("#list_Btn").click(function(){ 
			location.href='productList?c=all&v=brandNew'
		});
		
	</script>
</body>
</html>