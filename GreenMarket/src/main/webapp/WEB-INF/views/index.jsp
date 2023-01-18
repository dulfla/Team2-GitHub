<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린 마켓</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<link rel="stylesheet" href="${path}resources/style/basicStryle.css">

<c:if test="${! empty authInfo && authInfo.type=='U'}">
	<!-- 모든 페이지 필수 요소(어디서튼 회원이 선택하면 채팅방을 볼 수 있어야 함) -->
	<script src="${path}resources/script/chat/chattingRoom.js"></script>
</c:if>
</head>
<body>
	<%@ include file="include/header.jsp" %>
	<div id="container">
		<!-- 메인 공간 -->
	</div>
	<%@ include file="include/footer.jsp" %>
</body>
</html>