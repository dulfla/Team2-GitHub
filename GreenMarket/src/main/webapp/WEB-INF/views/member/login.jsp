<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>        	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>

<!-- 부트스트랩 링크 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
	crossorigin="anonymous">
</script>

<!-- 제이쿼리 -->
<script
  src="https://code.jquery.com/jquery-3.6.3.js"
  integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
  crossorigin="anonymous">
</script>

<!-- sweetalert -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<style type="text/css">
@import
	url('https://fonts.googleapis.com/css?family=Montserrat:400,800');

*{
	box-sizing: border-box;
} 

main {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	font-family: 'Montserrat', sans-serif;
	height: 100vh;
	margin: -20px 0 50px;
}

main h1 {
	font-weight: bold;
	margin: 0;
}

main p {
	font-size: 14px;
	font-weight: 100;
	line-height: 20px;
	letter-spacing: 0.5px;
	margin: 20px 0 30px;
}

span {
	font-size: 12px;
}

main a {
	color: #333;
	font-size: 14px;
	text-decoration: none;
	margin: 15px 0;
}

main button {
	border-radius: 20px;
	border: 1px solid yellowgreen;
	background-color: yellowgreen;
	color: #FFFFFF;
	font-size: 12px;
	font-weight: bold;
	padding: 12px 45px;
	letter-spacing: 1px;
	text-transform: uppercase;
	transition: transform 80ms ease-in;
}

form {
	background-color: #FFFFFF;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	padding: 0 50px;
	height: 100%;
	text-align: center;
}

input {
	background-color: #eee;
	border: none;
	padding: 12px 15px;
	margin: 8px 0;
	width: 100%;
}

.container2 {
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25), 0 10px 10px
		rgba(0, 0, 0, 0.22);
	position: relative;
	overflow: hidden;
	width: 768px;
	max-width: 100%;
	min-height: 480px;
}

.form-container {
	position: absolute;
	top: 0;
	height: 100%;
}

.log-in-container {
	left: 0;
	width: 50%;
	z-index: 2;
}

.overlay-container {
	position: absolute;
	top: 0;
	left: 50%;
	width: 50%;
	height: 100%;
}

.overlay {
	background: yellowgreen;
	background: -webkit-linear-gradient(to right, #8aff2b, yellowgreen);
	background: linear-gradient(to right, #8aff2b, yellowgreen);  
	background-repeat: no-repeat;
	background-size: cover;
	background-position: 0 0;
	color: #FFFFFF;
	position: relative;
	left: -100%;
	height: 100%;
	width: 200%;
}

.overlay-panel {
	position: absolute;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	padding: 0 40px;
	text-align: center;
	top: 0;
	height: 100%;
	width: 50%;
}

.overlay-right {
	right: 0;
}

.social-container {
	margin: 50px 0;
}

.social-container a {
	border: 1px solid #DDDDDD;
	border-radius: 50%;
	display: inline-flex;
	justify-content: center;
	align-items: center;
	margin: 0 5px;
	height: 40px;
	width: 40px;
}
</style>
<jsp:include page="../include/header.jsp"/>
</head>
<body>
	<main>
		<div class="container2" id="container2">
		<div class="form-container log-in-container">
			<form action="postLogin" method="post" name="frm">
			<form:errors />
				<h1>로그인</h1>
				<div class="social-container">
					<a href="#" class="social"><i class="fa fa-facebook fa-2x"></i></a>
					<a href="#" class="social"><i class="fab fa fa-twitter fa-2x"></i></a>
				</div>
				<span>or use your account</span>
				<input type="email"	name="email" id="email"  placeholder="이메일" /> 
				<input type="password" name="password" id="password" placeholder="비밀번호" /> 
				<a href="#">Forgot your password?</a>
				<button type="submit" onclick="return loginCheck()">Log In</button>
			</form>	
		</div>
		<div class="overlay-container">
			<div class="overlay">
				<div class="overlay-panel overlay-right">
					<h1>Green Market Login Form</h1>
					<p>This login form is created using pure HTML and CSS. For
						social icons, FontAwesome is used.</p>
				</div>
			</div>
		</div>
	</div>
	</main>
<script type="text/javascript">


/* $("#alertStart").click(function () {
  Swal.fire({
    icon: 'success',
    title: 'Alert가 실행되었습니다.',
    text: '이곳은 내용이 나타나는 곳입니다.',
  });
}); */

function loginCheck(){
	if(document.frm.email.value.length == 0){
		 Swal.fire({
			    icon: 'error',
			    title: '아이디를 입력해주세요.',
			  });
		document.frm.email.focus();
		return false;
	}
	
	if(document.frm.password.value == ''){
		Swal.fire({
		    icon: 'error',
		    title: '비밀번호를 입력해주세요.',
		  });
		document.frm.password.focus();
		return false;
	}
	return loginAjax();
}

function loginAjax(){
	var email = $("#email").val();
	var password = $("#password").val();

	var jsonData ={
		"email" : email,
		"password" : password
	};
	console.log(jsonData);
	
		$.ajax({
			type:"POST",
			url:"postLogin",
			data : JSON.stringify(jsonData),  
			dataType : 'json', 
			contentType : 'application/json;charset=UTF-8', 
			/* contentType:" application/x-www-form-urlencoded", */
			 success: function(result){
				 console.log(result);
				 if(result == "1"){
					
					window.location.href = "index"; 
				}else{
					Swal.fire({
					    icon: 'error',
					    title: '로그인실패',
					  });
				}
			 		
		  	},error : function(error) {
		  		console.log(result);
				alert("전송에 실패하였습니다.");
				 /* window.location.href = "index"; */
			}
		})
	}
	
</script>
</body>
<jsp:include page="../include/footer.jsp"/>
</html>

