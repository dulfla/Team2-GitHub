<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="${path}resources/script/chat/chattingRoom.js"></script>
<script src="${path}resources/script/product/productDetailJsForChat.js"></script>
<link rel="stylesheet" href="${path}resources/style/basicStryle.css">
<link rel="stylesheet" href="${path}resources/style/chattingStyle.css">
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<div id="container" class="container">
		<button id="openChattingBtn" class="btn btn-primary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight">
			채팅하기
		</button>
		<input type="email" placeholder="email" name="email" id="email">
	</div>
	<%@ include file="../include/chat.jsp" %>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>