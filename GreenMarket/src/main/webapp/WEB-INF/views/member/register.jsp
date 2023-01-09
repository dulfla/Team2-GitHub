<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입 페이지</title>

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

<!-- address api -->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
	crossorigin="anonymous">
</script>

<!-- sweetalert -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>


<style>
body {
	min-height: 100vh;

	/*  background: -webkit-gradient(linear, left bottom, right top, from(#92b5db), to(#1d466c));
      background: -webkit-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: -moz-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: -o-linear-gradient(bottom left, #92b5db 0%, #1d466c 100%);
      background: linear-gradient(to top right, #92b5db 0%, #1d466c 100%); */
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
				<form:form modelAttribute="formData" action="registerPost"
					class="validation-form" novalidate="novalidate">
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="name">이름</label> <input type="text"
								class="form-control" id="name" name="name" placeholder=""
								value="" required>
							<div class="invalid-feedback">이름을 입력해주세요.</div>
						</div>
						<div class="col-md-6 mb-3">
							<label for="nickname">닉네임</label> <input type="text"
								class="form-control" id="nickname" name="nickname"
								placeholder="" value="" required>
							<div class="invalid-feedback">닉네임을 입력해주세요.</div>
						</div>
					</div>

					<div class="mb-3">
						<label for="email">이메일</label> <input type="email"
							class="form-control" id="email" name="email"
							placeholder="you@example.com" required>
						<div class="invalid-feedback">이메일을 입력해주세요.</div>
					</div>

					<div class="mb-3">
						<label for="password">비밀번호</label> <input type="password"
							class="form-control" id="password" name="password" required>
						<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="confirmPassword">비밀번호 확인</label> <input
							type="password" class="form-control" id="confirmPassword"
							name="confirmPassword" required>
						<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="birth">생년월일</label> <input type="number"
							class="form-control" id="birth" name="birth"
							placeholder="ex 19970518"  maxlength="8" oninput="numberMaxLength(this);"
							required>
						<div class="invalid-feedback">생년월일을 입력해주세요.</div>
					</div>

					<div class="mb-3">
						<label for="phone">전화번호</label> <input type="text"
							class="form-control" id="phone" name="phone" oninput="autoHyphen2(this)" maxlength="13"
							placeholder="전화번호 입력" required>
						<div class="invalid-feedback">전화번호를 입력해주세요.</div>
					</div>

					<div class="mb-3">
						<label for="address">주소</label> <input type="text"
							class="form-control" id="address_kakao" name="address" required>
						<div class="invalid-feedback">주소를 입력해주세요.</div>
					</div>


					<div class="mb-4"></div>
					<button class="btn btn-primary btn-lg btn-block" type="submit">가입
						완료</button>
				</form:form>
			</div>

		</div>
		<footer class="my-3 text-center text-small">
			<p class="mb-1">&copy; 2023 YD</p>
		</footer>
	</div>
</body>

<jsp:include page="../include/footer.jsp" />
<script type="text/javascript">

// 전화번호 정규식
const autoHyphen2 = (target) => {
	 target.value = target.value
	   .replace(/[^0-9]/g, '')
	  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	}
	
function numberMaxLength(e){
    if(e.value.length > e.maxLength){

        e.value = e.value.slice(0, e.maxLength);
    }
}	
	
	
	window.addEventListener('load', () => {
	    const forms = document.getElementsByClassName('validation-form');
		
	    Array.prototype.filter.call(forms, (form) => {
	      form.addEventListener('submit', function (event) {
	        if (form.checkValidity() === false) {
	          event.preventDefault();
	          event.stopPropagation();
	          form.classList.add('was-validated');
	          
	        }else{
	        	alert('회원가입을 성공했습니다.!');
	        }
					
	      });
	    });
	 });
</script>

<!-- address api script-->
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	window.onload = function(){
	    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
	        //카카오 지도 발생
	        new daum.Postcode({
	            oncomplete: function(data) { //선택시 입력값 세팅
	                document.getElementById("address_kakao").value = data.address; // 주소 넣기
	                document.querySelector("input[name=address]").focus(); //상세입력 포커싱
	            }
	        }).open();
	    });
	}
</script>

</html>