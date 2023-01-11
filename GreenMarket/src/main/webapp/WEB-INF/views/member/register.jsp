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
					class="validation-form" novalidate="novalidate">
					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="name">이름</label> <input type="text"
								class="form-control" id="name" name="name" required>
						</div>
						<div class="col-md-6 mb-3">
							<label for="nickname">닉네임</label> <input type="text"
								class="form-control" id="nickname" name="nickname" oninput="checkNick()" required>
							<div> 
								<span id="result_checkNickname" style="font-size: 14px;"></span>
								<input type="hidden" id="result_checkNickname2" value="">
							</div>
						</div>
					</div>

					<div class="mb-3">
						<label for="email">이메일</label> <input type="email"
							class="form-control" id="email" name="email"
							placeholder="you@example.com" oninput="checkEmail()" required>
						<div> 
							<span id="result_email" style="font-size: 14px;"></span>
							<input type="hidden" id="result_email2" value="">
						</div>
					</div>

					<div class="mb-3">
						<label for="password">비밀번호</label> <input type="password"
							class="form-control" id="password" name="password" oninput="checkPwd()" required>
					</div>
					<div class="mb-3">
						<label for="confirmPassword">비밀번호 확인</label> <input
							type="password" class="form-control" id="confirmPassword"
							name="confirmPassword" oninput="checkPwd()" required>
						<div> 
							<span id="result_checkPwd" style="font-size: 14px;"></span>
							<input type="hidden" id="result_checkPwd2" value="">
						</div>
					</div>
					<div class="mb-3">
						<label for="birth">생년월일</label> <input type="number"
							class="form-control" id="birth" name="birth"
							placeholder="ex 19970518"  maxlength="8" oninput="numberMaxLength(this);"
							required>
					</div>

					<div class="mb-3">
						<label for="phone">전화번호</label> <input type="text"
							class="form-control" id="phone" name="phone" oninput="autoHyphen2(this)" maxlength="13"
							placeholder="전화번호 입력"  required>
					</div>

					<div class="mb-3">
						<label for="address">주소</label> <input type="text"
							class="form-control" id="address_kakao" name="address" required>
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
       	var password = $('#password').val();
       	var confirmPassword = $('#confirmPassword').val();
       	const check = document.getElementById("result_checkPwd2");
        
       	const pwdCheck = document.getElementsByClassName('form-control')[4];
       	const pwdCheck2 = document.getElementsByClassName('form-control')[5];
       	
        var jsonData ={
        		"password" : password,
        		"confirmPassword" : confirmPassword
        	};
        
        $.ajax({
        	type:"POST",
        	url:"confirmPassword",
        	data : JSON.stringify(jsonData),  
			dataType : 'json', 
			contentType : 'application/json;charset=UTF-8', 
			 success: function(result){
				 if(result == 1){
					 if(confirmPassword == ''){
						$("#result_checkPwd").html('');						 
					 }else{
						check.setAttribute('value','success');
						pwdCheck.setAttribute('class','form-control');
						pwdCheck2.setAttribute('class','form-control');
						
					 	$("#result_checkPwd").html('비밀번호가 일치합니다.').css("color","green");
					 }
				 }else{
					 check.setAttribute('value','pwdFail');
					 pwdCheck.setAttribute('class','form-control is-invalid');
					 pwdCheck2.setAttribute('class','form-control is-invalid');
					 
					 $("#result_checkPwd").html('비밀번호가 일치하지 않습니다.').css("color","red");
				 }
				 
				 
			 }
        });
        
    }
	
	
	window.addEventListener('load', () => {
		const nicknameCheck3 = document.getElementsByClassName('form-control')[2].getAttribute('class');
	    const forms = document.getElementsByClassName('validation-form');
		const button = document.getElementById('button');
		
	    Array.prototype.filter.call(forms, (form) => {
	    
	    button.addEventListener('click', function (event) {
	    	
	   		var inputed = $('#password').val();
	        var reinputed = $('#confirmPassword').val();
	    	var resultCheck = $('#result_checkNickname').val();
	    	
	        const pwdCheck = document.getElementById('result_checkPwd2').getAttribute('value');
	        const pwdCheck2 = document.getElementsByClassName('form-control')[5].getAttribute('class');
	        
	        const nicknameCheck = document.getElementById('result_checkNickname2').getAttribute('value');
	        const nicknameCheck2 = document.getElementsByClassName('form-control')[2].getAttribute('class');
	        
	        const emailCheck = document.getElementById('result_email2').getAttribute('value');
	        const emailCheck2 = document.getElementsByClassName('form-control')[3].getAttribute('class');
        	
	        function emailAlert(){
	        	form.classList.remove('was-validated');
        		Swal.fire({
		        	icon: 'warning',
				    title: '이메일을 확인해주세요.!',
	        	}); 	
	        }
	        
	        function nicknameAlert(){
	        	form.classList.remove('was-validated');
	        	Swal.fire({
		        	icon: 'warning',
				    title: '닉네임을 확인해주세요.!',
	        	}); 
	        }
	        
	        function pwdCheckAlert(){
	        	form.classList.remove('was-validated');
	        	Swal.fire({
		        	icon: 'warning',
				    title: '비밀번호를 확인해주세요.!',
	        	});   
	        }
	        
	        if (form.checkValidity() == false) {
	        	
	           	event.preventDefault(); 
	           	event.stopPropagation(); 
	           	form.classList.add('was-validated');
	           	
	           	if(nicknameCheck2 == 'form-control is-invalid'){
	           		
	           		nicknameAlert();
	           		
	           	}else if(emailCheck2 == 'form-control is-invalid'){
	           		
		        	emailAlert();
	           	}else if(pwdCheck2 == 'form-control is-invalid'){
	           		
	           		pwdCheckAlert();
	           	};
	        	
	        }else if(pwdCheck == 'pwdFail'){
	        	pwdCheckAlert();
	        	
	        }else if(nicknameCheck == 'nicknameFail'){
	        	nicknameCheck();
	        	
	        }else if(emailCheck == 'emailFail'){
	        	emailAlert();
	        	
	        }
	        else{
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
				}
			}
		
		});
	}
	
	
	function checkNick() {
        var nickname = $("#nickname").val();
        const check = document.getElementById("result_checkNickname2");
        const check2 = document.getElementsByClassName('form-control')[2];
        
        /* const check2 = document.querySelector(".form-control"); */
        console.log(check2);
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
                    	$("#result_checkNickname").html('');
                    }else{
                    	check.setAttribute('value','success');
                    	check2.setAttribute('class','form-control');
	                	$("#result_checkNickname").html('사용가능한 닉네임입니다.').css("color","green");
	                	return result;
                    }
                	
                } else {
                	check.setAttribute('value','nicknameFail');
                	check2.setAttribute('class','form-control is-invalid');
                	$("#result_checkNickname").html('중복된 닉네임입니다.').css("color","red");
                	
                } 
            }
        });
    }
	
	function checkEmail(){
		var email = $("#email").val();
		const check = document.getElementById("result_email2");
		const check2 = document.getElementsByClassName('form-control')[3];
		
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
            	
            	if(result == 2){ // 이메일형식
            		if(email =='' || email == null){
                    	$("#result_email").html('');
                    }else{
                    	check.setAttribute('value','success');
                    	check2.setAttribute('class','form-control');
                    	$("#result_email").html('이메일 형식이 아닙니다.').css("color","red");
                    }
            	
            	}else if(result == 0) { // 사용가능
                	if(email =='' || email == null){
                    	$("#result_email").html('');
                    }else{
                    	check.setAttribute('value','success');
                    	check2.setAttribute('class','form-control');
	                	$("#result_email").html('사용가능한 이메일입니다.').css("color","green");
                    }
                	
                } else { // 중복
                	check.setAttribute('value','emailFail');
                	check2.setAttribute('class','form-control is-invalid');
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