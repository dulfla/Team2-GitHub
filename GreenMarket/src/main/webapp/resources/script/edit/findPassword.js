function changeBtnName()  {
	var email = $("#memMail").val();
	const btnElement 
	    = document.getElementById('mailAuth');
	 
	console.log(email == '');
	if(email !=''){
	  btnElement.value = "재전송";
	}
	
}

$("#mailAuth").on("click",function(e){
	var email = $("#memMail").val();
	const btnElement 
    = document.getElementById('mailAuth');
	
    isMailAuthed=true;
    
    
    if(email == null || email == ''){
    	Swal.fire({
    	    icon: 'warning',
    	    title: '이메일을 입력해주세요.'

        })
    }else{
    	$.ajax({
            url : "mailAuth.wow" 
            ,data : {"mail" : $("input[name='memMail']").val()}
            ,success: function(result){
            	if(result == 'fail'){
            		Swal.fire({
                	    icon: 'warning',
                	    title: '회원등록된 이메일이 아닙니다.'

                    })
            	}else{
            		btnElement.value = "재전송";
            		Swal.fire({
                	    icon: 'success',
                	    title: '이메일을 전송했습니다.'

                    })
            	}
            },error : function(req,status,err){
                console.log(req);
            }
        });//ajax
    }
   });//mailCheck

function findPasswordCheck() {
	var email = $("#memMail").val();
	var authKey = $("#authKey").val();
	
	var jsonData ={
			"email": email,
			"authKey": authKey,
		};
	$.ajax({
		type:"POST",
		url:"findPasswordAuth",
		data : JSON.stringify(jsonData),  
		dataType : 'json', 
		contentType : 'application/json;charset=UTF-8', 
		success: function(result){
			 if(result == 0){
				 Swal.fire({
					    icon: 'success',
					    title: '인증 완료!'

				    }).then(result => {
				      // 만약 Promise리턴을 받으면,
				      if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면

						 document.location.href = "mailAuthSuccess";  
				      }
				    });
			 }else{
				 Swal.fire({
					    icon: 'error',
					    title: '인증번호가 일치하지 않습니다.'

				    });
			 }
		}
		
	})// ajax
	
}