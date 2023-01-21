function changePasswordCheck() {
	var currentPassword = $('#currentPassword').val();
	var newPassword = $('#newPassword').val();
	var newPassword2 = $('#newPassword2').val();
	
	var jsonData = {
		"currentPassword" : currentPassword,	
		"newPassword": newPassword,
		"newPassword2": newPassword2
	};
	console.log(currentPassword);
	$.ajax({
		type: "POST",
		url: "changePasswordPost",
		data: JSON.stringify(jsonData),
		dataType: 'json',
		contentType: 'application/json;charset=UTF-8',
		success: function (result) {
			console.log(result);
			if(result == 2){
				Swal.fire({
				    icon: 'error',
				    title: '새 비밀번호가 일치하지 않습니다.'

			    })
			
			}else if (result == 1) {
				Swal.fire({
				    icon: 'error',
				    title: '현재 비밀번호가 일치하지 않습니다.'

			    })
			} else {
			     Swal.fire({
					   icon: 'success',
				       title: '수정이 완료되었습니다.'
				   }).then(result => {
					   
					   if(result.isConfirmed){
						   	document.location.href = "login";
					   }
				   })
			    
			}


		}
	});
}

function checkPwd() {
	var newPassword = $('#newPassword').val();
	var newPassword2 = $('#newPassword2').val();

	var jsonData = {
		"newPassword": newPassword,
		"newPassword2": newPassword2
	};

	$.ajax({
		type: "POST",
		url: "updateConfirmPassword",
		data: JSON.stringify(jsonData),
		dataType: 'json',
		contentType: 'application/json;charset=UTF-8',
		success: function (result) {
			console.log(newPassword);
			console.log(newPassword2);
			if (result == 1) {
				
				if (newPassword2 == '') {
					$("#result_checkPwd").html('');
				} else {

					$("#result_checkPwd").html('비밀번호가 일치합니다.').css("color", "green");
				}
			} else {
 
				$("#result_checkPwd").html('비밀번호가 일치하지 않습니다.').css("color", "red");
			}


		}
	});

}