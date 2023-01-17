<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방 목록</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<body>
	<div class="container">
		<div class="list-group w-auto mt-2">
			<c:forEach items="${chatRoomList}" var="cr">
				<a href="#" class="list-group-item list-group-item-action d-flex gap-3 py-3" aria-current="true">
					<img src="https://github.com/twbs.png" alt="twbs" width="32" height="32" class="rounded-circle flex-shrink-0">
					<div class="d-flex gap-2 w-100 justify-content-between">
						<div>
							<h6 class="mb-0">상품 이름</h6><input type="hidden" value="${cr.c_id},${cr.p_id}">
							<p class="mb-0 opacity-75 h6">여기는 채팅방 내용? 아니면 최근 온 메세지? 아니면 채팅방에 있는 참여자 정보?</p>
						</div>
						<small class="opacity-50 text-nowrap">최근 메세지 시간?</small>
					</div>
			    </a>
			</c:forEach>
		</div>
	</div>
</body>
</html>