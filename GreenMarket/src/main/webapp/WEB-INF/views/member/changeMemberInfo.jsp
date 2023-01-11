<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 변경</title>
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

<jsp:include page="../include/header.jsp"/>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<div class="col-sm-2"></div>
				<div class="col-sm-9">
					<h2 class="text-center">회원 정보 수정하기</h2>

					<form action="MemberUpdateProc.jsp" method="post">

						<table class="table table-striped">
							<tr>
								<td>아이디</td>
								<td></td>
							</tr>

							<tr>
								<td>이메일</td>
								<td><input type="email" value="${member.email}"
									name="email" class="form-control"></td>
							</tr>

							<tr>
								<td>전화</td>
								<td><input type="tel" value="${member.phone}"
									name="email" class="form-control"></td>
							</tr>

							<tr>
								<td>패스워드</td>
								<td><input type="password" value=""
									name="pass1" class="form-control"></td>
							</tr>

							<tr>
								<td colspan="2" class="text-center"><input type="submit"
									value="회원 수정하기" class="btn btn-success">
									<button type="button" class="btn btn-warning"
										onclick="location.href='MemberList.jsp'">회원 전체 보기</button></td>
							</tr>

						</table>

					</form>

				</div>
			</div>
			<!-- col-sm-12 -->
		</div>
		<!-- row -->
	</div>
	<!-- container end-->
</body>
<jsp:include page="../include/footer.jsp"/>
</html>