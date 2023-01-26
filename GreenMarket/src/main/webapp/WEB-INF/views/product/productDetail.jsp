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

<link rel="stylesheet" href="${path}resources/style/basicStryle.css">

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	490ef0680625aa2086d3bf61d038acea"></script>
<style type="text/css">
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
</style>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<div id="container">
		<form role='form' method="POST">
			<input type="hidden" name="type" value="${authInfo.type}">
			<input type="hidden" name="p_id" value="${product.p_id}" >
			<input type="hidden" name="email" value="${product.email}">
			<input type="hidden" name="authEmail" value="${authInfo.email}">
			<input type="hidden" name="nickname" value="${product.nickname}">
			<input type="hidden" id="lat" name="lat" value="${product.lat}">
			<input type="hidden" id="lng" name="lng" value="${product.lng}">

			<div class="inputArea"> 
			 <label>카테고리</label>
			 <span class="category">${product.category}</span>  	      
			</div>
			
			<div class="inputArea"> 
			 <label>등록일</label>
			 <span class="regdate">
			 	<fmt:formatDate value="${product.regdate}" pattern="yyyy-MM-dd"/>
			 </span>        
			</div>
			
			
			<div class="inputArea"> 
			 <label>조회수</label>
			 <span class="views">${product.views}</span>        
			</div>
			
			<div class="inputArea">
			 <label for="p_name">상품명</label>
			 <span>${product.p_name}</span>
			</div>
		
 			 <div class="inputArea">
			 <label for="email">판매자</label>
			 <span>${product.nickname}</span>
			</div>  
			 
			<div class="inputArea">
			 <label for="price">상품가격</label>
			 <span><fmt:formatNumber value="${product.price}"  pattern="###,###,###"/>원</span>
			</div>			
			
			<div class="inputArea">
			 <label for="description">상품소개</label>
			 <span>${product.description}</span>
			</div>
			
			<div class="inputArea">
	            <div class="inputArea_title">
		            <label>상품 이미지</label>
		        </div>
				<div id="uploadResult">
					
				</div>
            </div>
            
            <div class="inputArea">
            	 <div class="inputArea_title">
		            <label>직거래 위치</label>
		        </div>
            	<div id="map" style="width:350px;height:350px;"></div>
            </div>
			
			<!-- 작성자,관리자 수정삭제버튼 -->
			<c:if test="${product.email == authInfo.email || authInfo.type == 'M'}">
				<button type="button" id="modify_Btn" class="btn btn-warning">수정</button>
				<button type="button" id="delete_Btn" class="btn btn-danger">삭제</button>
			</c:if>
			
			</form>
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
							    }else if (result.isDismissed) {
							    	// 만약 모달창에서 cancel 버튼을 눌렀다면
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
	</div>
	<%@ include file="../include/footer.jsp" %>
	
	<script>
	
	
	
	

	/* =======-=-=-=-=-==============================================--========= */
		var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
		
		//좌표 
		var lat = $("#lat").val();
		var lng = $("#lng").val();
		console.log(lat);
		console.log(lng);
		
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
				  
			 		
			 		
					let str = "";
					
					str += "<div id='result_card'>";
					str += "<img src='./resources/img/noImage.png'>";
					str += "</div>";
						
					//uploadResult.html(str);
					//$("#uploadResult").append(str);
					$("#uploadResult").html(str);
					return;
				} 
			  
				let str = "";
				let obj = arr[0];
				
				let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				str += "<div id='result_card'";
				str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
				str += ">";
				str += "<img src='display?fileName=" + fileCallPath +"'>";
				str += "</div>";		
				//uploadResult.html(str);
				$("#uploadResult").html(str);
		  });		
	  }); 
	  $("#modify_Btn").click(function(){ 
	   formObj.attr("action", "productModify");
	   formObj.attr("method", "get")
	   formObj.submit();
	  });
	  
	  $("#delete_Btn").click(function(){   
		var con = confirm("정말로 삭제하시겠습니까?");  
		 
		if(con){
			formObj.attr("action", "productDelete");
		   	formObj.submit();
		}
	  });
 	</script>
</body>
</html>