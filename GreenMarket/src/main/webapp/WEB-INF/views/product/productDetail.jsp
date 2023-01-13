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
<script src="${path}resources/script/product/productDetailJsForChat.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.slim.js" integrity="sha256-HwWONEZrpuoh951cQD1ov2HUK5zA5DwJ1DNUXaM6FsY=" crossorigin="anonymous"></script>
<style type="text/css">
	#container{
		width:100%;
		height:100vh;
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