<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${product.p_id}</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<script src="${path}resources/script/chat/chatting.js"></script>
<style type="text/css">
	#container{
		height:100vh;
		width:100vw;
	}
	img{
		height:18vh;
		width:18vh;
	}
	#text{
		display:inline-block;
	}
	#info{
		height:20vh
	}
	#message{
		height:10vh;
	}
	#messageBox{
		height:70vh;
		width:100%;
		position:absolute;
		top:20vh;
	}
	.messageBox{
		display:block;
		width:60vw;
		padding:0px 10px;
		padding-top:10px;
	}
	.recive{
		position:relative;
		left:40vw;
		text-align:right;
	}
	.myMessage{
		margin:0;
		display:inline-block;
		padding:5px 12px;
		border-radius:15px;
		background-color:rgb(232, 255, 198);
	}

</style>
</head>
<body>
	<div class="bg-light" id="container">
		<div class="fixed-top p-2 bg-light" id="info">
			<img class="rounded-circle" src="${path}resources/img/sample.jpg">
			<div id="text" class="mt-1 ms-2">
				<h2>${product.p_name} 상품명</h2>
				<p>${product.p_name} 상품 설명</p>
			</div>
		</div>
		<div id="messageBox" class="overflow-auto">
			
		</div>
		<div class="input-group fixed-bottom mb-2 p-2  bg-light" id="message">
		    <input type="text" class="form-control" placeholder="메세지를 입력하세요" name="message" aria-label="message" aria-describedby="basic-addon1">
		    <button onclick="sendMessage()" class="input-group-text" id="basic-addon1">전송</button>
	  	</div>
	</div>
</body>
</html>