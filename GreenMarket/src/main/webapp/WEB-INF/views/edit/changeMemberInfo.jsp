<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린 마켓</title>

<link rel="icon" href="resources/img/favicon-32x32.png">

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

<!-- address api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style type="text/css">
	#main{
		min-height:100vh;
	}
</style>
<jsp:include page="../include/header.jsp"/>
</head>
<body>
<div id="main">
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<div class="col-sm-2"></div>
				<div class="col-md-8 mt-4 mx-auto">
					<h2 class="text-center">회원 정보 수정하기</h2>
						<table class="table table-striped">
							<tr>
								<td>이름</td>
								<td><input type="text" value="${member.name}"
									name="name" id="name" class="form-control"></td>
								<td><button onclick="updateName()" class="btn btn-primary">수정</button>
								</td>	
							</tr>

							<tr>
								<td>닉네임</td>
								<td><input type="text" value="${member.nickname}"
									name="nickname" id="nickname" class="form-control"></td>
								<td><button onclick="updateNickname()" class="btn btn-primary">수정</button>
								</td>	
							</tr>

							<tr>
								<td>생년월일</td>
								<td><input type="number" value="${member.birth}"
									name="birth" id=birth maxlength="8" oninput="numberMaxLength(this);"  class="form-control"></td>
								<td><button onclick="updateBirth()" class="btn btn-primary">수정</button>
								</td>	
							</tr>
							<tr>
								<td>전화번호</td>
								<td><input type="text" value="${member.phone}"
									name="phone" id="phone" oninput="autoHyphen2(this)" maxlength="13"  class="form-control"></td>
								<td><button onclick="updatePhone()" class="btn btn-primary">수정</button>
								</td>	
							</tr>
							<tr>
								<td>주소</td>
								<td><input type="text" value="${member.address}"
									id="address_kakao" name="address" class="form-control"></td>
								<td><button onclick="updateAddress()" class="btn btn-primary">수정</button>
								</td>	
							</tr>
							<tr>
								<td colspan="3" class="text-center">
									<button type="button"
									class="btn btn-success" onclick="location.href='index'">나가기</button>
								</td>
							</tr>
						</table>

				</div>
			</div>
			<!-- col-sm-12 -->
		</div>
		<!-- row -->
	</div>
	<!-- container end-->
</div>
</body>

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
<script type="text/javascript" defer="defer" src="${path}resources/script/edit/changeMemberInfo.js"></script>

<jsp:include page="../include/footer.jsp"/>
</html>