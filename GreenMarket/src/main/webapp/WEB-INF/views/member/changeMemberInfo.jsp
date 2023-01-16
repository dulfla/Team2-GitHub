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

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous">
</script>

<!-- sweetalert -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<!-- address api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<jsp:include page="../include/header.jsp"/>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-sm-12">
				<div class="col-sm-2"></div>
				<div class="col-sm-9">
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
								<td>이메일</td>
								<td><input type="email" value="${member.email}"
									name="email" id="email" class="form-control"></td>
								<td><button onclick="updateEmail()" class="btn btn-primary">수정</button>
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
								<td colspan="2" class="text-center"><input type="button"
									value="나가기" class="btn btn-success" onclick="window.history.go(-2)" >
								</td>
								<td></td>
							</tr>
						</table>
					<!-- </form> -->

				</div>
			</div>
			<!-- col-sm-12 -->
		</div>
		<!-- row -->
	</div>
	<!-- container end-->
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

<script type="text/javascript">

//전화번호 정규식
const autoHyphen2 = (target) => {
	target.value = target.value
		.replace(/[^0-9]/g, '')
		.replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
}
// 생년월일 숫자길이 = 8
function numberMaxLength(e) {
	if (e.value.length > e.maxLength) {

		e.value = e.value.slice(0, e.maxLength);
	}
}


function ModifySuccess() {
	Swal.fire({
	    icon: 'success',
	    title: '수정이 완료되었습니다.'

    })
}

function noValue() {
	Swal.fire({
	    icon: 'warning',
	    title: '수정할 값을 입력해주세요.'

    })
}

function updatePhone() {
	var email = $("#email").val();
	var birth = $("#birth").val();
	var address = $("#address_kakao").val();
	var phone = $("#phone").val();
	var name = $("#name").val();
	var nickname = $("#nickname").val();
	
	var jsonData ={
		"name": name,
		"nickname": nickname,
		"email": email,
		"birth": birth,
		"phone": phone,
		"address": address
	};
	
	$.ajax({
		type:"POST",
		url:"updatePhone",
		data : JSON.stringify(jsonData),  
		dataType : 'json', 
		contentType : 'application/json;charset=UTF-8', 
		 success: function(result){
			 console.log(result +'전화번호');
			 if(result == 2){
					Swal.fire({
					    icon: 'warning',
					    title: '이미 같은 전화번호 입니다.'

				    });
				}else if(result == 0){
					noValue();
					
				}else{
					ModifySuccess();
				}
			 
		 		
	  	}
	})
}

function updateBirth(){
	var email = $("#email").val();
	var birth = $("#birth").val();
	var address = $("#address_kakao").val();
	var phone = $("#phone").val();
	var name = $("#name").val();
	var nickname = $("#nickname").val();
	
	var jsonData ={
		"name": name,
		"nickname": nickname,
		"email": email,
		"birth": birth,
		"phone": phone,
		"address": address
	};
	
	$.ajax({
		type:"POST",
		url:"updateBirth",
		data : JSON.stringify(jsonData),  
		dataType : 'json', 
		contentType : 'application/json;charset=UTF-8', 
		 success: function(result){
			 console.log(result);
				if(result == 2){
					Swal.fire({
					    icon: 'warning',
					    title: '이미 같은 생년월일 입니다.'

				    });
				}else if(result == 0){
					noValue();
					
				}else{
					ModifySuccess();
				}
			 
		 		
	  	}
	})
}

function updateName(){
	var email = $("#email").val();
	var birth = $("#birth").val();
	var address = $("#address_kakao").val();
	var phone = $("#phone").val();
	var name = $("#name").val();
	var nickname = $("#nickname").val();
	
	var jsonData ={
		"name": name,
		"nickname": nickname,
		"email": email,
		"birth": birth,
		"phone": phone,
		"address": address
	};
	
	
	
	console.log(jsonData);
	
		$.ajax({
			type:"POST",
			url:"updateName",
			data : JSON.stringify(jsonData),  
			dataType : 'json', 
			contentType : 'application/json;charset=UTF-8', 
			 success: function(result){
				 console.log(result);
				if(result == 2){
					Swal.fire({
					    icon: 'warning',
					    title: '이미 같은 이름 입니다.'

				    });
				}else if(result == 0){
					noValue();
					
				}else{
					ModifySuccess();
				}
			 		
		  	}
		})
		
		
	}
	
function updateAddress(){
	
	var email = $("#email").val();
	var birth = $("#birth").val();
	var address = $("#address_kakao").val();
	var phone = $("#phone").val();
	var name = $("#name").val();
	var nickname = $("#nickname").val();
	
	var jsonData ={
		"name": name,
		"nickname": nickname,
		"email": email,
		"birth": birth,
		"phone": phone,
		"address": address
	};
	
	
	$.ajax({
		type:"POST",
		url:"updateAddress",
		data : JSON.stringify(jsonData),  
		dataType : 'json', 
		contentType : 'application/json;charset=UTF-8', 
		 success: function(result){
			 console.log(result +'주소')
			 if(result == 2){
					Swal.fire({
					    icon: 'warning',
					    title: '이미 같은 주소 입니다.'

				    });
				}else if(result == 0){
					noValue();
					
				}else{
					ModifySuccess();
				}
		 		
	  	}
	})
	
}	

function updateEmail(){
	
	var email = $("#email").val();
	var birth = $("#birth").val();
	var address = $("#address_kakao").val();
	var phone = $("#phone").val();
	var name = $("#name").val();
	var nickname = $("#nickname").val();
	
	var jsonData ={
		"name": name,
		"nickname": nickname,
		"email": email,
		"birth": birth,
		"phone": phone,
		"address": address
	};
	
	
	$.ajax({
		type:"POST",
		url:"updateEmail",
		data : JSON.stringify(jsonData),  
		dataType : 'json', 
		contentType : 'application/json;charset=UTF-8', 
		 success: function(result){
			 console.log(result +'이메일')
			 if(email == null || email == ''){
				 noValue();
			 
			 }else if(result == 2){
					Swal.fire({
					    icon: 'warning',
					    title: '이메일 형식이아닙니다.'

				    });
				}else if(result == 1){
					Swal.fire({
					    icon: 'warning',
					    title: '이미 있는 이메일 입니다.'

				    });
					
				}else{
					ModifySuccess();
				}
		 		
	  	}
	})
	
}	

function updateNickname(){
	
	var email = $("#email").val();
	var birth = $("#birth").val();
	var address = $("#address_kakao").val();
	var phone = $("#phone").val();
	var name = $("#name").val();
	var nickname = $("#nickname").val();
	
	var jsonData ={
		"name": name,
		"nickname": nickname,
		"email": email,
		"birth": birth,
		"phone": phone,
		"address": address
	};
	
	
	$.ajax({
		type:"POST",
		url:"updateEmail",
		data : JSON.stringify(jsonData),  
		dataType : 'json', 
		contentType : 'application/json;charset=UTF-8', 
		 success: function(result){
			 console.log(result +'닉네임')
			 if(nickname == '' || nickname == null){
				 noValue();
			 } else if(result == 1){
					Swal.fire({
					    icon: 'warning',
					    title: '이미 있는 닉네임 입니다.'

				    });
					
			}else{
				ModifySuccess();
			}
		 		
	  	}
	})
	
}	
</script>

<jsp:include page="../include/footer.jsp"/>
</html>