<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린마켓</title>
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
	
<style type="text/css">
	body {
			min-height: 100vh;
		}
		.button{
			width: 610px;
		}
		.button2{
			float:left;
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
		<form class="validation-form" novalidate="novalidate">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-3" align="center">회원탈퇴</h4>
					<div class="mb-4">
						  <input type="text" class="form-control" id="name"
							name="name" value="${member.name}" readonly="readonly" required>
					</div>
					
					<div class="mb-4">
						 <input type="password" class="form-control" id="password"
							name="password"  placeholder="비밀번호 입력" required>
					</div>
					<div class="form-group">
					<div class="mb-4">
						<div class="input-group">
							 <input type="email" path="memMail"  class="form-control"
								id="memMail" name="memMail" readonly="readonly" value="${member.email}" required>
								<!-- <span id="result_checkPwd" style="font-size: 14px;"></span>
									<input type="hidden" id="result_checkPwd2" value=""> -->
							<input value="인증" class="btn btn-primary btn-lg btn-block button2" id="mailAuth" type="button" onclick="changeBtnName()">	
						</div>	
						</div>
					</div>
					
					<div class="mb-4">
						 <input type="text" class="form-control" id="authKey"
							name="authKey" oninput="return false;" placeholder="인증번호 입력" required>
					</div>
											
					<div class="mb-4">
						<button class="btn btn-primary btn-lg btn-block button" id="button" type="button">탈퇴하기</button>
					</div>
			</div>
		</div>
		</form>
	</div>
	
	
</body>

<script type="text/javascript">
function changeBtnName()  {
	  const btnElement 
	    = document.getElementById('mailAuth');
	  
	  btnElement.value = "재전송";
}


window.addEventListener('load', () => {
	  const forms = document.getElementsByClassName('validation-form');
	  const button = document.getElementById('button');

	  Array.prototype.filter.call(forms, (form) => {
	    form.addEventListener('click', function (event) {
	      if (form.checkValidity() === false) {
	        event.preventDefault();
	        event.stopPropagation();
	      }else{
	    	  withDrawalCheck();
	      }

	      form.classList.add('was-validated');
	    }, false);
	  });
	}, false);

function withDrawalCheck(){
	var email = $("#memMail").val();
	var password = $("#password").val();
	var authKey = $("#authKey").val();
	
	var jsonData ={
		"email": email,
		"password": password,
		"authKey": authKey,
	};
	console.log(memMail);
	console.log(jsonData.email);
	$.ajax({
		type:"POST",
		url:"memberWithDrawalPost",
		data : JSON.stringify(jsonData),  
		dataType : 'json', 
		contentType : 'application/json;charset=UTF-8', 
		 success: function(result){
			 console.log(result);
			if(result == 2){
				Swal.fire({
				    icon: 'error',
				    title: '인증번호가 일치하지 않습니다.'

			    });
			}else if(result == 1){
				Swal.fire({
				    icon: 'error',
				    title: '비밀번호가 일치하지 않습니다.'

			    });	
			
			}else{
				Swal.fire({
					   title: '정말로 회원탈퇴 하시겠습니까?',
					   text: '다시 되돌릴 수 없습니다. 신중하세요.',
					   icon: 'warning',
					   
					   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
					   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
					   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
					   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
					   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
					   
					   reverseButtons: true, // 버튼 순서 거꾸로
					   
					}).then(result => {
					   // 만약 Promise리턴을 받으면,
					   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
					   
						   Swal.fire({
							   title: '회원탈퇴가 완료되었습니다.',
							   text: '화끈하시네요~!',
							   icon: 'success',
						   }).then(result => {
							   
							   if(result.isConfirmed){
								   document.location.href = "index";
							   }
						   })
					      
					   }
					})
				}
		 	}
		})
	}

$("#mailAuth").on("click",function(e){
    isMailAuthed=true;
    $.ajax({
        url : "mailAuth.wow" 
        ,data : {"mail" : $("input[name='memMail']").val()}
        ,success: function(data){
        	Swal.fire({
        	    icon: 'success',
        	    title: '이메일을 전송했습니다.'

            })
        },error : function(req,status,err){
            console.log(req);
        }
    });//ajax
});//mailCheck



</script>

<jsp:include page="../include/footer.jsp"/>
</html>