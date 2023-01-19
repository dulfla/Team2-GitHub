<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script src="${path}resources/script/chat/chattingRoom.js"></script>

<link rel="stylesheet" href="${path}resources/style/chattingStyle.css">
<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel" type="sell">
	<div class="offcanvas-header">
		<div class="offcanvas-title w-100 mt-2" id="offcanvasScrollingLabel">
			<div class="btn-group mb-2 mb-md-0 btn-block w-100" id="chatRoomBtnGroup">
				<button type="button" id="sellChatRoomBtn" class="btn btn-primary chatRoomBtns" type="sell">For Sell</button>
				<button type="button" id="allChatRoomBtn" class="btn btn-outline-primary chatRoomBtns" type="all">All</button>
				<button type="button" id="buyChatRoomBtn" class="btn btn-primary chatRoomBtns" type="buy">For Buy</button>
			</div>
		</div>
	  	<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close" id="closeBtn"></button>
	</div>
	<div class="offcanvas-body p-0 container">
		<div id="chatRoomList" class="overflow-auto container">
			<div class="list-group w-auto mt-2 h-100 mb-2" id="chattingRooms"></div>
		</div>
	</div>
</div>