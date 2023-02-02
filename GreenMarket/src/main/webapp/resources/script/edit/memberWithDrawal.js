window.addEventListener('load', () => {
	  const forms = document.getElementsByClassName('validation-form');
	  const button = document.getElementById('button');

	  Array.prototype.filter.call(forms, (form) => {
		  button.addEventListener('click', function (event) {
	      if (form.checkValidity() == false) {
	        event.preventDefault();
	        event.stopPropagation();
	      	form.classList.add('was-validated');
	      }else{
	    	  withDrawalCheck();
	      }

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
	
		$.ajax({
			type:"POST",
			url:"memberWithDrawalPost",
			data : JSON.stringify(jsonData),  
			dataType : 'json', 
			contentType : 'application/json;charset=UTF-8', 
			 success: function(result){
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
									   	document.location.href = "deleteMember";
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
    const btnElement 
    = document.getElementById('mailAuth');
    btnElement.value = "재전송";
    
    var password = $("#password").val();
	var authKey = $("#authKey").val();
   
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
	
	
