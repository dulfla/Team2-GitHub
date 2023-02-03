
function loginCheck(){
	if(document.frm.email.value.length == 0){
		 Swal.fire({
			    icon: 'error',
			    title: '아이디를 입력해주세요.',
			  });
		document.frm.email.focus();
		return false;
	}
	
	if(document.frm.password.value == ''){
		Swal.fire({
		    icon: 'error',
		    title: '비밀번호를 입력해주세요.',
		  });
		document.frm.password.focus();
		return false;
	}
	return loginAjax();
}

function loginAjax(){
	var email = $("#email").val();
	var password = $("#password").val();
	
	var jsonData ={
		"email" : email,
		"password" : password
	};
	
		$.ajax({
			type:"POST",
			url:"postLogin",
			data : JSON.stringify(jsonData),  
			dataType : 'json', 
			contentType : 'application/json;charset=UTF-8', 
			 success: function(result){
				 if(result != null){
					 Swal.fire({
						    icon: 'success',
						    title: '로그인성공!',
						    text: result.nickname +'님 환영합니다.'

					    }).then(result => {
					      // 만약 Promise리턴을 받으면,
					      if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면

							 document.location.href = "index";  
					      }
					    });
				}
			 		
		  	},error : function(error) {
		  		Swal.fire({
				    icon: 'error',
				    title: '로그인실패',
				    text: '아이디와 비밀번호를 확인해주세요!'
				  });
			}
		})
	}