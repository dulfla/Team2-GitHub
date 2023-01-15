<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:choose>
	<c:when test="${!empty authInfo}"></c:when> <%-- ${empty authInfo} --%>
	<c:otherwise>
		<c:choose>
			<c:when test="${!empty authInfo}"> <%-- ${! authInfo.email eq Product.email} --%>
				<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel" type="buy">
					<div class="offcanvas-header">
					  	<div class="p-0 col-3">
							<img class="rounded-circle" src="" alt="${product.p_name} 사진"> <%-- ${path}resources/img/sample.jpg --%>
						</div>
						<div class="col-8 mt-2" class="offcanvas-title" id="offcanvasScrollingLabel">
							<h2>${product.p_name} 상품명</h2>
							<p>${product.p_name} 상품 설명</p>
						</div>
					  	<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close" id="closeBtn"></button>
					</div>
					<div class="offcanvas-body p-0 container">
						<div id="messageBox" class="overflow-auto"></div>
						<div class="container fixed-bottom" id="message">
							<div class="input-group mt-2 p-0 bg-light">
								<button class="btn btn-outline-secondary" type="button" id="button-addon1">+</button>
							    <input type="text" class="form-control" placeholder="메세지를 입력하세요" name="message" aria-label="message" aria-describedby="basic-addon1">
							    <button name="sendBtn" class="input-group-text" id="basic-addon1">전송</button>
						  	</div>
						</div>
					</div>
				</div>
			</c:when>
			<c:when test="${empty authInfo}"> <%-- ${authInfo.email eq Product.email} --%>
				<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel" type="sell">
					<div class="offcanvas-header">
					  	<div class="p-0 col-3">
							<img class="rounded-circle" src="" alt="${product.p_name} 사진"> <%-- ${path}resources/img/sample.jpg --%>
						</div>
						<div class="col-8 mt-2" class="offcanvas-title" id="offcanvasScrollingLabel">
							<h2>${product.p_name} 상품명</h2>
							<p>${product.p_name} 상품 설명</p>
						</div>
					  	<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close" id="closeBtn"></button>
					</div>
					<div class="offcanvas-body p-0 container">
						<div id="chatRoomList" class="overflow-auto container">
							<div class="list-group w-auto mt-2 h-100 mb-2" id="chattingRooms"></div>
						</div>
					</div>
				</div>
			</c:when>
		</c:choose>
	</c:otherwise>
</c:choose>
