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

function ModifySuccess2() {
	Swal.fire({
	    icon: 'success',
	    title: '수정이 완료되었습니다.'

    }).then(result => {
					// 만약 Promise리턴을 받으면,
					if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면

						document.location.href = "login";
					}
				});
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
	
	
		$.ajax({
			type:"POST",
			url:"updateName",
			data : JSON.stringify(jsonData),  
			dataType : 'json', 
			contentType : 'application/json;charset=UTF-8', 
			 success: function(result){
			 
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
		url:"updateNickname",
		data : JSON.stringify(jsonData),  
		dataType : 'json', 
		contentType : 'application/json;charset=UTF-8', 
		 success: function(result){
		 
			 if(result == 2){
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