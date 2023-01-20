<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
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
<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous">
</script>

<!-- sweetalert -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<style>
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
			-webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
			-moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
			box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
		}
	</style>


<jsp:include page="../include/header.jsp"/>
</head>
<body>

	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-3">비밀번호 변경</h4>
					<div class="mb-3">
						<label for="currentPassword">현재 비밀번호</label> <input type="password" class="form-control" id="currentPassword"
							name="currentPassword" oninput="checkPwd()" required>
					</div>
					
					<div class="mb-3">
						<label for="newPassword">새 비밀번호</label> <input type="password" class="form-control" id="newPassword"
							name="newPassword" oninput="checkPwd()" required>
					</div>
					<div class="mb-3">
						<label for="newPassword2">새 비밀번호 확인</label> <input type="password" class="form-control"
							id="newPassword2" name="newPassword2" oninput="checkPwd()" required>
						<div>
							<span id="result_checkPwd" style="font-size: 14px;"></span>
							<input type="hidden" id="result_checkPwd2" value="">
						</div>
					</div>

					<div class="mb-3">
						<button class="btn btn-primary btn-lg btn-block button" type="button" onclick="changePasswordCheck()">변경하기</button>
					</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript" defer="defer" src="${path}resources/script/edit/changePassword.js"></script>

<jsp:include page="../include/footer.jsp"/>
</html>