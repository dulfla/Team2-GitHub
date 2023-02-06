<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린 마켓</title>

<link rel="icon" href="resources/img/favicon-32x32.png">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="${path}resources/script/chat/chattingServer.js"></script>
<style type="text/css">
	#main{
		min-height: 100vh;
	}
</style>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<div id="main">
		<c:choose>
			<c:when test="${empty serverOption or serverOption eq 'Off'}">
				<button type="button" name="controllServer" class="btn btn-outline-warning position-absolute top-50 start-50 translate-middle" id="serverSetOn">서버 켜기</button>
			</c:when>
			<c:when test="${serverOption eq 'On'}">
				<button type="button" name="controllServer" class="btn btn-outline-danger position-absolute top-50 start-50 translate-middle" id="serverSetOff">서버 끄기</button>
			</c:when>
		</c:choose>
	</div>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>