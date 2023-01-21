<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script src="${path}resources/script/chat/chattingInProductDetail.js"></script>

<link rel="stylesheet" href="${path}resources/style/chattingStyle.css">
<c:choose>
	<c:when test="${!(authInfo.email eq product.email)}">
		<div class="offcanvas offcanvas-end chattingOpen" tabindex="-1" id="offcanvasRight chatOffcanvas" aria-labelledby="offcanvasRightLabel" type="buy">
			<div class="offcanvas-header chatOffcanvas">
			  	<div class="p-0 col-3">
					<img class="rounded-circle" src="" alt="${product.p_name} 사진"> <%-- ${path}resources/img/sample.jpg --%>
				</div>
				<div class="col-8 mt-2" class="offcanvas-title" id="offcanvasScrollingLabel">
					<h2>${product.p_name} 상품명</h2>
					<p>${product.p_name} 상품 설명</p>
				</div>
			  	<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close" id="closeBtn chatOffcanvas"></button>
			</div>
			<div class="offcanvas-body p-0 container chatOffcanvas">
				<div id="messageBox" class="overflow-auto"></div>
				<div class="container fixed-bottom" id="message">
					<div class="input-group mt-2 p-0">
						<button name="addFileBtn" class="btn btn-outline-secondary" type="button" id="button-addon1">+</button>
					    <input type="text" class="form-control" placeholder="메세지를 입력하세요" name="message" aria-label="message" aria-describedby="basic-addon1">
					    <button name="sendBtn" class="input-group-text" id="basic-addon1">전송</button>
				  	</div>
				</div>
			</div>
		</div>
	</c:when>
	<c:when test="${authInfo.email eq product.email}">
		<div class="offcanvas offcanvas-end chattingRooms" tabindex="-1" id="offcanvasRight chatOffcanvas" aria-labelledby="offcanvasRightLabel" type="sell">
			<div class="offcanvas-header chatOffcanvas">
			  	<div class="p-0 col-3">
					<img class="rounded-circle" src="" alt="${product.p_name} 사진"> <%-- ${path}resources/img/sample.jpg --%>
				</div>
				<div class="col-8 mt-2" class="offcanvas-title" id="offcanvasScrollingLabel">
					<h2>${product.p_name}</h2>
					<p>판매자 : ${product.email}</p>
				</div>
			  	<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close" id="closeBtn chatOffcanvas"></button>
			</div>
			<div class="offcanvas-body p-0 container chatOffcanvas">
				<div id="chatRoomList" class="overflow-auto container">
					<div class="list-group w-auto mt-2 h-100 mb-2" id="chattingRooms"></div>
				</div>
			</div>
		</div>
	</c:when>
</c:choose>