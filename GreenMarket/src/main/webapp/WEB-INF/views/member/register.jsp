<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>회원가입 페이지</title>

	<!-- bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous">
		</script>

	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.3.js"
		integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous">
		</script>

	<!-- sweetalert -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
	
	<!-- address api -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


	<style>
		body {
			min-height: 100vh;
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
	<jsp:include page="../include/header.jsp" />

</head>

<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-3">회원가입</h4>
				<form:form action="registerPost" class="validation-form" novalidate="novalidate">
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="name">이름</label> <input type="text" class="form-control" id="name" name="name" required>
						</div>
						<div class="col-md-6 mb-3">
							<label for="nickname">닉네임</label> <input type="text" class="form-control" id="nickname"
								name="nickname" oninput="checkNick()" required>
							<div>
								<span id="result_checkNickname" style="font-size: 14px;"></span>
								<input type="hidden" id="result_checkNickname2" value="">
							</div>
						</div>
					</div>

					<div class="mb-3">
						<label for="email">이메일</label> <input type="email" class="form-control" id="email" name="email"
							placeholder="you@example.com" oninput="checkEmail()" required>
						<div>
							<span id="result_email" style="font-size: 14px;"></span>
							<input type="hidden" id="result_email2" value="">
						</div>
					</div>

					<div class="mb-3">
						<label for="password">비밀번호</label> <input type="password" class="form-control" id="password"
							name="password" oninput="checkPwd()" required>
					</div>
					<div class="mb-3">
						<label for="confirmPassword">비밀번호 확인</label> <input type="password" class="form-control"
							id="confirmPassword" name="confirmPassword" oninput="checkPwd()" required>
						<div>
							<span id="result_checkPwd" style="font-size: 14px;"></span>
							<input type="hidden" id="result_checkPwd2" value="">
						</div>
					</div>
					<div class="mb-3">
						<label for="birth">생년월일</label> <input type="number" class="form-control" id="birth" name="birth"
							placeholder="ex 19970518" maxlength="8" oninput="numberMaxLength(this);" required>
					</div>

					<div class="mb-3">
						<label for="phone">전화번호</label> <input type="text" class="form-control" id="phone" name="phone"
							oninput="autoHyphen2(this)" maxlength="13" placeholder="전화번호 입력" required>
					</div>

					<div class="mb-3">
						<label for="address">주소</label> <input type="text" class="form-control" id="address_kakao"
							name="address" required>
					</div>


					<div class="mb-4"></div>
					<button class="btn btn-primary btn-lg btn-block" id="button" type="button">가입
						완료</button>
					<button class="btn btn-primary btn-lg btn-block" id="button" type="reset">다시 작성
					</button>
				</form:form>
			</div>

		</div>
		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; 2023 YD</p>
		</footer>
	</div>
</body>
<jsp:include page="../include/footer.jsp" />

<!-- address api script-->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
window.onload = function () {
	document.getElementById("address_kakao").addEventListener("click", function () { //주소입력칸을 클릭하면
		//카카오 지도 발생
		new daum.Postcode({
			oncomplete: function (data) { //선택시 입력값 세팅
				document.getElementById("address_kakao").value = data.address; // 주소 넣기
				document.querySelector("input[name=address]").focus(); //상세입력 포커싱
			}
		}).open();
	});
}
</script>
<script type="text/javascript" defer="defer" src="${path}resources/script/register.js"></script>


</html>