<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<style type="text/css">
	body {
			min-height: 100vh;
		}
		.button{
			width: 600px;
		}
		.input-form {
			max-width: 680px;
			margin-top: 80px;
			padding: 32px;
			background: #fff;
			-webkit-border-radius: 10px;
			-moz-border-radius: 10px;
			border-radius: 10px;
			/* -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
			-moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
			box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15) */
		}
</style>
<jsp:include page="../include/header.jsp"/>
</head>
<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-3" align="center">회원탈퇴</h4>
					<div class="mb-3">
						 이름 <input type="text" class="form-control" id="currentPassword"
							name="currentPassword" oninput="checkPwd()" value="${member.name}" readonly="readonly" required>
					</div>
					
					<div class="mb-3">
						<label for="newPassword">비밀번호</label> <input type="password" class="form-control" id="newPassword"
							name="newPassword" oninput="checkPwd()" required>
					</div>
					<div class="mb-3">
						이메일 <input type="email" class="form-control"
							id="newPassword2" name="newPassword2" readonly="readonly" oninput="checkPwd()" value="${member.email}" required>
						<div>
							<span id="result_checkPwd" style="font-size: 14px;"></span>
							<input type="hidden" id="result_checkPwd2" value="">
						</div>
					</div>
						<button type="button">인증</button>	
					<div class="mb-3">
						<button class="btn btn-primary btn-lg btn-block button" type="button" onclick="changePasswordCheck()">변경하기</button>
					</div>
			</div>
		</div>
	</div>
</body>
<jsp:include page="../include/footer.jsp"/>
</html>