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
				<form:form action="registerPost"
					class="validation-form" method="post" novalidate="novalidate">
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="name">이름</label> <input type="text"
								class="form-control" id="name" name="name" required>
							<div class="invalid-feedback">이름을 입력해주세요.</div>
						</div>
						<div class="col-md-6 mb-3">
							<label for="nickname">닉네임</label> <input type="text"
								class="form-control" id="nickname" name="nickname" oninput="checkNick()" required>
							<div class="invalid-feedback">닉네임을 입력해주세요.</div>
							<div> <span id="result_checkNickname" style="font-size: 14px;"></span></div>
						</div>
					</div>

					<div class="mb-3">
						<label for="email">이메일</label> <input type="email"
							class="form-control" id="email" name="email"
							placeholder="you@example.com" oninput="checkEmail()" required>
						<div class="invalid-feedback">이메일을 입력해주세요.</div>
						<div> <span id="result_email" style="font-size: 12px;"></span></div>
					</div>

					<div class="mb-3">
						<label for="password">비밀번호</label> <input type="password"
							class="form-control" id="password" name="password" oninput="checkPwd()" required>
						<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
					</div>
					<div class="mb-3">
						<label for="confirmPassword">비밀번호 확인</label> <input
							type="password" class="form-control" id="confirmPassword"
							name="confirmPassword" oninput="checkPwd()" required>
						<div class="invalid-feedback">비밀번호를 입력해주세요.</div>
						<div> <span id="result_checkId" style="font-size: 12px;"></span></div>
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
							placeholder="전화번호 입력"  required>
						<div class="invalid-feedback">전화번호를 입력해주세요.</div>
					</div>

					<div class="mb-3">
						<label for="address">주소</label> <input type="text"
							class="form-control" id="address_kakao" name="address" required>
						<div class="invalid-feedback">주소를 입력해주세요.</div>
					</div>


					<div class="mb-4"></div>
					<button class="btn btn-primary btn-lg btn-block" id="button" type="button">가입
						완료</button>
					<button class="btn btn-primary btn-lg btn-block" type="reset">
					다시작성</button>
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
	
	function checkPwd() {
        var inputed = $('#password').val();
        var reinputed = $('#confirmPassword').val();
        
        if(reinputed=="" && (inputed != reinputed || inputed == reinputed)){
            $("#result_checkId").html('비밀번호가 일치하지 않습니다.').css("color","red");
        }
        else if (inputed == reinputed) {
        	$("#result_checkId").html('비밀번호가 일치합니다.').css("color","green");
        } 
    }
	
	
	window.addEventListener('load', () => {
        
	    const forms = document.getElementsByClassName('validation-form');
		const button = document.getElementById('button');
	    Array.prototype.filter.call(forms, (form) => {
	    	
	    button.addEventListener('click', function (event) {
	    	
   		var inputed = $('#password').val();
        var reinputed = $('#confirmPassword').val();
    	var resultCheck = $('#result_checkNickname').val(); 
    	
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
          form.classList.add('was-validated');
          
          console.log(resultCheck);
          
        }else if(checkNick){
        	console.log(checkNick.result);
        	
        }else if(checkEmail){
        	console.log(checkEmail);
        	
        }else if(inputed != reinputed){
        	
        	Swal.fire({
			    icon: 'warning',
			    title: '비밀번호가 일치하지 않습니다.',
			    text: '비밀번호를 확인해주세요.'

		    });
        	
        }else{
        	registerAjax()
        }
				
      });
    });
 });

	
	function registerAjax(){
		var email = $("#email").val();
		var password = $("#password").val();
		var confirmPassword = $("#confirmPassword").val();
		var birth = $("#birth").val();
		var address = $("#address_kakao").val();
		var phone = $("#phone").val();
		var name = $("#name").val();
		var nickname = $("#nickname").val();
		
		var jsonData = {
			"name" : name,		
			"nickname" : nickname,
			"email" : email,
			"password" : password,		
			"confirmPassword" : confirmPassword,		
			"birth" : birth,		
			"phone" : phone,		
			"address" : address		
		};
			console.log(jsonData);
		
		

		$.ajax({
			type:"POST",
			url:"registerPost",
			data : JSON.stringify(jsonData),  
			dataType : 'json', 
			contentType : 'application/json;charset=UTF-8', 
			 success: function(result){
				 
				 if(result == "1"){
					 Swal.fire({
						    icon: 'success',
						    title: '회원가입을 축하합니다.!',
						    text: '그린마켓에 오신걸 환영합니다.'

					    }).then(result => {
					      // 만약 Promise리턴을 받으면,
					      if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면

							 document.location.href = "index";  
					      }
					    });
				}else{
					Swal.fire({
					    icon: 'error',
					    title: '회원가입 실패!',
					    text: '아이디와 비밀번호를 확인해주세요!'
					  });
				}		
			}
		
		});
	}
	
	
	function checkNick() {
        var nickname = $("#nickname").val();
        console.log(nickname);
        var jsonData={
        	"nickname" : nickname	
        };
        
        $.ajax({
        	type:"POST",
            url : "checkNickName",
            data : JSON.stringify(jsonData),  
			dataType : 'json', 
			contentType : 'application/json;charset=UTF-8', 
            success : function(result) {
            	
                if(result == 0) {
                	if(nickname =='' || nickname == null){
                    	console.log('공백');
                    	$("#result_checkNickname").html('');
                    }else{
	                	$("#result_checkNickname").html('사용가능한 닉네임입니다.').css("color","green");
	                	return result;
                    }
                	
                } else {
                	$("#result_checkNickname").html('중복된 닉네임입니다.').css("color","red");
                	
                } 
            }
        });
    }
	
	function checkEmail(){
		var email = $("#email").val();
		
        var jsonData={
        	"email" : email	
        };
        
        console.log(jsonData);
        $.ajax({
        	type:"POST",
            url : "checkEmail",
            data : JSON.stringify(jsonData),  
			dataType : 'json', 
			contentType : 'application/json;charset=UTF-8', 
            success : function(result) {
            	console.log(result);
                if(result == 0) {
                	if(email =='' || email == null){
                    	console.log('공백');
                    	$("#result_email").html('');
                    }else{
	                	$("#result_email").html('사용가능한 이메일입니다.').css("color","green");
                    }
                	
                } else {
                	$("#result_email").html('중복된 이메일입니다.').css("color","red");
                } 
            }
        });
    }
	
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