<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script src="${path}resources/script/chat/chattingRoom.js"></script>

<link rel="stylesheet" href="${path}resources/style/chattingStyle.css">
<div class="offcanvas offcanvas-end chattingRoom" tabindex="-1" id="offcanvasRight chatRoomOffcanvas" aria-labelledby="offcanvasRightLabel" type="sell">
	<div class="offcanvas-header chatRoomOffcanvas">
		<div class="offcanvas-title w-100 mt-2" id="offcanvasScrollingLabel">
			<div class="btn-group mb-2 mb-md-0 btn-block w-100" id="chatRoomBtnGroup">
				<button type="button" id="sellChatRoomBtn" class="btn btn-primary chatRoomBtns" chatType="sell">For Sell</button>
				<button type="button" id="allChatRoomBtn" class="btn btn-outline-primary chatRoomBtns" chatType="all">All</button>
				<button type="button" id="buyChatRoomBtn" class="btn btn-primary chatRoomBtns" chatType="buy">For Buy</button>
			</div>
		</div>
	  	<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close" id="closeB"></button>
	</div>
	<div class="offcanvas-body p-0 container chatRoomOffcanvas">
		<div id="chatRoomList" class="overflow-auto container">
			<div class="list-group w-auto mt-2 h-100 mb-2" id="chatRooms"></div>
		</div>
	</div>
</div>
<input type="hidden" value="${authInfo.email}" name="authInfo_email" id="authInfo_email">