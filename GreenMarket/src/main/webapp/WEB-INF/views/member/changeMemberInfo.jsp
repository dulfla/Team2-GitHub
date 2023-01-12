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
								<td>이름</td>
								<td><input type="text" value="${member.name}"
									name="name" class="form-control"></td>
								<td><button onclick="location.href='changeMemberInfo?email=${member.email}'" class="btn btn-primary">수정</button>
								</td>	
							</tr>

							<tr>
								<td>이메일</td>
								<td><input type="email" value="${member.email}"
									name="email" class="form-control"></td>
								<td><button onclick="location.href='changeMemberInfo?email=${member.email}'" class="btn btn-primary">수정</button>
								</td>
							</tr>

							<tr>
								<td>닉네임</td>
								<td><input type="text" value="${member.nickname}"
									name="phone" class="form-control"></td>
								<td><button onclick="location.href='changeMemberInfo?email=${member.email}'" class="btn btn-primary">수정</button>
								</td>	
							</tr>

							<tr>
								<td>생년월일</td>
								<td><input type="number" value="${member.birth}"
									name="birth" class="form-control"></td>
								<td><button onclick="location.href='changeMemberInfo?email=${member.email}'" class="btn btn-primary">수정</button>
								</td>	
							</tr>
							<tr>
								<td>전화번호</td>
								<td><input type="text" value="${member.phone}"
									name="phone" class="form-control"></td>
								<td><button onclick="location.href='changeMemberInfo?email=${member.email}'" class="btn btn-primary">수정</button>
								</td>	
							</tr>
							<tr>
								<td>주소</td>
								<td><input type="text" value="${member.address}"
									name="address" class="form-control"></td>
								<td><button onclick="location.href='changeMemberInfo?email=${member.email}'" class="btn btn-primary">수정</button>
								</td>	
							</tr>
							<tr>
								<td colspan="2" class="text-center"><input type="button"
									value="나가기" class="btn btn-success" onclick="window.history.go(-1)" >
								</td>
								<td></td>
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
<script type="text/javascript">

	
</script>

<jsp:include page="../include/footer.jsp"/>
<script type="text/javascript" defer="defer" src="${path}resources/script/member.js"></script>
</html>