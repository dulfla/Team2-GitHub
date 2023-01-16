<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<%-- <script src="${path}resources/script/product/productDetailJsForChat.js"></script> --%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<style type="text/css">
	#container{
		width:100%;
		height:100vh;
	}
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
		<form role='form' method="POST" autocomplete="off">
			<input type="hidden" name="p_id" value="${product.p_id}" />

			<div class="inputArea"> 
			 <label>카테고리</label>
			 <span class="category">${product.category}</span>  	      
			</div>
			
			<div class="inputArea"> 
			 <label>등록일</label>
			 <span class="regdate">${product.regdate}</span>        
			</div>
			
			<!-- 거래위치 -->
			
			
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
			 <span>${product.email}</span>
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
			
			<!-- 작성자, 관리자만 보이도록 수정 해야됨 -->
			<div class="inputArea">
			 <button type="button" id="modify_Btn" class="btn btn-warning">수정</button>
			 <button type="button" id="delete_Btn" class="btn btn-danger">삭제</button>
			</div>
			
			</form>
		
		<button onclick="chatting()">채팅하기</button>
		
	</div>
	<%@ include file="../include/footer.jsp" %>
	
	<script>
	  var formObj = $("form[role='form']");
	  
	  $(document).ready(function(){
		  /* 이미지 정보 호출 */
		  let p_id = '<c:out value="${Product.p_id}"/>';
		  let uploadResult = $("uploadResult");
		 
		  
		  $.getJSON("/GreenMarket/product/productImage", {p_id : p_id}, function(arr){
			  
			 	console.log(arr);
			 	if(arr.length === 0){	
				  
					let str = "";
					str += "<div id='result_card'>";
					str += "<img src='../resources/img/noImage.png'>";
					str += "</div>";
						
					//uploadResult.html(str);
					//$("#uploadResult").append(str);
					$("#uploadResult").html(str);
					console.log('펑션되나2?');
					return;
				} 
			  
				let str = "";
				let obj = arr[0];
				
				let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				str += "<div id='result_card'";
				str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
				str += ">";
				str += "<img src='/GreenMarket/product/display?fileName=" + fileCallPath +"'>";
				str += "</div>";		
				//uploadResult.html(str);
				$("#uploadResult").html(str);
				console.log('펑션되나3?');
		  });		
	  }); 
	  $("#modify_Btn").click(function(){ 
	   formObj.attr("action", "/GreenMarket/product/productModify");
	   formObj.attr("method", "get")
	   formObj.submit();
	  });
	  
	  $("#delete_Btn").click(function(){   
		var con = confirm("정말로 삭제하시겠습니까?");  
		 
		if(con){
			formObj.attr("action", "/GreenMarket/product/productDelete");
		   	formObj.submit();
		}
	  });
 	</script>
</body>
</html>