<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>        	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린 마켓</title>

<!-- bootstrap -->
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

<!-- jQuery -->
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

.form {
	background-color: #FFFFFF;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-direction: column;
	padding: 0 50px;
	height: 100%;
	text-align: center;
}

.input {
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

	/* 광고 배너*/
	.advertising  .badges2 {
		position: absolute;
		top: 132px;
		right:40px;
	}
	
	.advertising  .badges2 .badge2 {
		border-radius: 5px;
		overflow: hidden;
		margin-bottom: 12px;
		box-shadow: 4px 4px 10px rgba(0, 0, 0, .15);
		cursor: pointer;
	}

</style>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<jsp:include page="../include/header.jsp"/>
</head>
<body>
	<main>
		<div class="container2" id="container2">
			<div class="form-container log-in-container">
				<form class="form" action="postLogin" method="post" id="login_form"
					name="frm">
					<form:errors />
					<h1 class="mt-2">로그인</h1>
					<div class="social-container">
						<div id="naverIdLogin"></div>
					</div>
					<span>or use your account</span> <input class="input" type="email"
						name="email" id="email" placeholder="이메일" /> <input class="input"
						type="password" name="password" id="password" placeholder="비밀번호" />
					<a href="findPassword">비밀번호 찾기</a>
					<button type="button" id="loginBtn" onclick="return loginCheck()">Log
						In</button>
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
		<!-- 광고 배너 -->
		<div class="advertising ">
			<div class="badges2">
				<div class="badge2">
					<a href="https://www.starbucks.co.kr/index.do" target='_blank'><img
						src="${path}resources/img/badge/badge1.jpg" alt="Badge"></a>
				</div>
				<div class="badge2">
					<a href="https://suwon.greenart.co.kr/" target='_blank'><img
						src="https://greened.co.kr/assets/_img/header/new23_headerlogo0.svg?3"
						alt="Badge"></a>
				</div>
			</div>
		</div>
	</main>
	<!-- 네이버 로그인 버튼 생성 위치 -->
</body>
<script type="text/javascript">
	$('#login_form').on('keypress', function(e){ 
	    if(e.keyCode == '13'){ 
	        $('#loginBtn').click(); 
	    }
	}); 
	
	let naverLogin = new naver.LoginWithNaverId(
			{
			/* 테스트용 clientId: "effwoF9_h12zWXZpxtMP", */
			/*	배포용*/ clientId: "zPr1GMk6QFJ0KznVNkPd",
				callbackUrl: "http://192.168.0.57:8085/GreenMarket/login",
				isPopup: false,
				loginButton: {
					color: "white", type: 3, height: 50
				}
			}
		);
	
	naverLogin.init();
	const button = document.getElementById('naverIdLogin');
 
	button.addEventListener('click', function () {
		naverLogin.getLoginStatus(function (status) {

		if (status) {
			
			let birthday = naverLogin.user.getBirthday();
			let email = naverLogin.user.getEmail();
			let name = naverLogin.user.getName();
			let nickName = naverLogin.user.getNickName();
			
			/* console.log(email);
			console.log(name);
			console.log(nickName);
			console.log(birthday); */
			
			let jsonData = {
				'n_email':email,
				'n_name':name,
				'n_nickName':nickName
			}
			
			$.ajax({
				type: 'post',
				url: 'naverSave',
				data : JSON.stringify(jsonData),  
				dataType : 'json', 
				contentType : 'application/json;charset=UTF-8',
				success: function(result) {
					console.log(result);
					if(result.message == 'ok') {
						console.log('확인');
						document.location.href = "index"; 
				/* 		location.replace("http://localhost:8085/GreenMarket/login")  */
					} 
				},
				error: function(result) {
					console.log(result);
					console.log('오류 발생')
				}
			})

		}else {
			
			console.log("callback 처리에 실패하였습니다.");
		}
		});
	});
	
</script>
<script type="text/javascript" defer="defer" src="${path}resources/script/member/login.js"></script>
<jsp:include page="../include/footer.jsp"/>
</html>

