<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅 서버</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<div id="container">
		<c:choose>
			<c:when test="${empty serverOption or serverOption eq 'Off'}">
				<button type="button" class="btn btn-outline-warning" id="serverSetOn">서버 켜기</button>
			</c:when>
			<c:when test="${serverOption eq 'On'}">
				<button type="button" class="btn btn-outline-danger" id="serverSetOff">서버 끄기</button>
			</c:when>
		</c:choose>
	</div>
	<%@ include file="../include/footer.jsp" %>
	<script type="text/javascript">
		let btn;
		let containerDiv;
		
		window.onload = function(){
			btn = document.getElementsByClassName('btn')[0];
			containerDiv = document.getElementById('container');
			
			if(btn.getAttribute('id')=='serverSetOn'){
				btn.addEventListener('click', serverSetOn, false);
			}else if(btn.getAttribute('id')=='serverSetOff'){
				btn.addEventListener('click', serverSetOff, false);
			}
		}
		
		function serverSetOn(){
			$.ajax({
				url:"ServerOpen",
				type:"POST",
		    	error: function() {
			    	console.log('통신실패!!');
			    },
				success:function(data){
					newBtnCreate(0);
				}
			});
		}
		
		function serverSetOff(){
			$.ajax({
				url:"ServerClose",
				type:"POST",
				error: function() {
			    	console.log('통신실패!!');
			    },
				success:function(){
					newBtnCreate(1);
				}
			});
		}
		
		function newBtnCreate(newBtnType){
			let btnColor = ["danger", "warning"]
			let btnText = ['서버 끄기', '서버 켜기'];
			
			containerDiv.innerHTML = null;
			let newBtn = document.createElement('button');
			newBtn.setAttribute('type', "button");
			newBtn.setAttribute('id', "serverSetOff");
			newBtn.classList.add('btn', 'btn-outline-'+btnColor[newBtnType]);
			newBtn.innerHTML = btnText[newBtnType];
			if(newBtnType==0){
				newBtn.addEventListener('click', serverSetOff, false);
			}else if(newBtnType==1){
				newBtn.addEventListener('click', serverSetOn, false);
			}
			containerDiv.appendChild(newBtn);
		}
	</script>
</body>
</html>