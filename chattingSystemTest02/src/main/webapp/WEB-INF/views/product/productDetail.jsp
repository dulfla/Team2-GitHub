<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	</div>
	<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
		<div class="container p-0">
			<div class="offcanvas-header">
			  	<div class="p-0 col-3">
					<img class="rounded-circle" src="" alt="${product.p_name} 사진"><!-- ${path}resources/img/sample.jpg -->
				</div>
				<div class="col-8 mt-2" class="offcanvas-title" id="offcanvasScrollingLabel">
					<h2>${product.p_name} 상품명</h2>
					<p>${product.p_name} 상품 설명</p>
				</div>
			  	<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close" id="closeBtn"></button>
			</div>
			<div class="offcanvas-body p-0 container">
				<div id="messageBox" class="overflow-auto">
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
				<div class="container fixed-bottom" id="message">
					<div class="input-group mt-2 p-0 bg-light">
						<button class="btn btn-outline-secondary" type="button" id="button-addon1">+</button>
					    <input type="text" class="form-control" placeholder="메세지를 입력하세요" name="message" aria-label="message" aria-describedby="basic-addon1">
					    <button name="sendBtn" class="input-group-text" id="basic-addon1">전송</button>
				  	</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>