<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${product.p_name}</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="${path}resources/script/chat/chatting.js"></script>
<link href="${path}resources/style/chattingStyle.css" rel="stylesheet">
</head>
<body>
	<div class="bg-light" id="container">
		<div class="fixed-top bg-light container row" id="info">
			<div class="p-0 col-3">
				<img class="rounded-circle" src="${path}resources/img/sample.jpg" alt="${product.p_name} 사진">
			</div>
			<div id="text" class="col-9 mt-2">
				<h2>${product.p_name} 상품명</h2>
				<p>${product.p_name} 상품 설명</p>
			</div>
		</div>
		<div id="messageBox" class="overflow-auto p-3">
			<c:if test="${!empty messages}">
				<c:forEach items="${messages}" var="message">
					<c:choose>
						<c:when test="${message.messType eq 'TEXT'}">
							<c:choose>
								<c:when test="${message.sender eq 'hong@naver.com'}"> <!-- message.sender eq member.email -->
									<div class="messageBox myMessageBox">
										<p class="message myMessage">${message.message}</p>
									</div>
								</c:when>
								<c:otherwise>
									<div class="messageBox reciveMessageBox">
										<p class="message recive">${message.message}</p>
									</div>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${message.messType eq 'IMG'}">
							으갸갸갸갸
						</c:when>
					</c:choose>
				</c:forEach>
			</c:if>
		</div>
		<div class="input-group fixed-bottom mb-2 p-2  bg-light" id="message">
		    <input type="text" class="form-control" placeholder="메세지를 입력하세요" name="message" aria-label="message" aria-describedby="basic-addon1">
		    <button name="sendBtn" class="input-group-text" id="basic-addon1">전송</button>
	  	</div>
	</div>
	<input type="hidden" name="c_id" value="">
	<input type="hidden" name="p_id" value="">
	<input type="hidden" name="myEmail" value="">
	<input type="hidden" name="rec" value="">
</body>
</html>