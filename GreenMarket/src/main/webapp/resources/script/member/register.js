
// 전화번호 정규식
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


window.addEventListener('load', () => {
	const nicknameCheck3 = document.getElementsByClassName('form-control')[2].getAttribute('class');
	const forms = document.getElementsByClassName('validation-form');
	const button = document.getElementById('button');

	Array.prototype.filter.call(forms, (form) => {

		button.addEventListener('click', function (event) {

			let inputed = $('#password').val();
			let reinputed = $('#confirmPassword').val();
			let resultCheck = $('#result_checkNickname').val();

			const pwdCheck = document.getElementById('result_checkPwd2').getAttribute('value');
			const pwdCheck2 = document.getElementsByClassName('form-control')[5].getAttribute('class');

			const nicknameCheck = document.getElementById('result_checkNickname2').getAttribute('value');
			const nicknameCheck2 = document.getElementsByClassName('form-control')[2].getAttribute('class');

			const emailCheck = document.getElementById('result_email2').getAttribute('value');
			const emailCheck2 = document.getElementsByClassName('form-control')[3].getAttribute('class');

			function emailAlert() {
				form.classList.remove('was-validated');
				Swal.fire({
					icon: 'warning',
					title: '이메일을 확인해주세요.!',
				});
			}

			function nicknameAlert() {
				form.classList.remove('was-validated');

				Swal.fire({
					icon: 'warning',
					title: '닉네임을 확인해주세요.!',
				});
				
			}

			function pwdCheckAlert() {
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

				if (nicknameCheck2 == 'form-control is-invalid') {

					nicknameAlert();

				} else if (emailCheck2 == 'form-control is-invalid') {

					emailAlert();
				} else if (pwdCheck2 == 'form-control is-invalid') {

					pwdCheckAlert();
				};

			} else if (pwdCheck == 'pwdFail') {
				pwdCheckAlert();

			} else if (nicknameCheck == 'nicknameFail') {
				nicknameAlert()

			} else if (emailCheck == 'emailFail') {
				emailAlert();

			}
			else {
				registerAjax()
			}

		},false);
	});
},false);


function registerAjax() {
	let email = $("#email").val();
	let password = $("#password").val();
	let confirmPassword = $("#confirmPassword").val();
	let birth = $("#birth").val();
	let address = $("#address_kakao").val();
	let phone = $("#phone").val();
	let name = $("#name").val();
	let nickname = $("#nickname").val();

	let jsonData = {
		"name": name,
		"nickname": nickname,
		"email": email,
		"password": password,
		"confirmPassword": confirmPassword,
		"birth": birth,
		"phone": phone,
		"address": address
	};
	console.log(jsonData);



	$.ajax({
		type: "POST",
		url: "registerPost",
		data: JSON.stringify(jsonData),
		dataType: 'json',
		contentType: 'application/json;charset=UTF-8',
		success: function (result) {

			if (result == "1") {
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
	let nickname = $("#nickname").val();
	const check = document.getElementById("result_checkNickname2");
	const check2 = document.getElementsByClassName('form-control')[1];

	/* const check2 = document.querySelector(".form-control"); */
	
	let jsonData = {
		"nickname": nickname
	};

	$.ajax({
		type: "POST",
		url: "checkNickName",
		data: JSON.stringify(jsonData),
		dataType: 'json',
		contentType: 'application/json;charset=UTF-8',
		success: function (result) {

			if (result == 0) {
				if (nickname == '' || nickname == null) {
					$("#result_checkNickname").html('');
				} else {
					check.setAttribute('value', 'success');
					check2.setAttribute('class', 'form-control is-valid');
					$("#result_checkNickname").html('사용가능한 닉네임입니다.').css("color", "green");
					return result;
				}

			} else {
				check.setAttribute('value', 'nicknameFail');
				check2.setAttribute('class', 'form-control is-invalid');
				$("#result_checkNickname").html('중복된 닉네임입니다.').css("color", "red");

			}
		}
	});
}

function checkEmail() {
	let email = $("#email").val();
	const check = document.getElementById("result_email2");
	const check2 = document.getElementsByClassName('form-control')[2];

	let jsonData = {
		"email": email
	};
	
	$.ajax({
		type: "POST",
		url: "checkEmail",
		data: JSON.stringify(jsonData),
		dataType: 'json',
		contentType: 'application/json;charset=UTF-8',
		success: function (result) {

			if (result == 2) { // 이메일형식
				if (email == '' || email == null) {
					$("#result_email").html('');
				} else {
					check.setAttribute('value', 'emailFail');
					check2.setAttribute('class', 'form-control is-invalid');
					$("#result_email").html('이메일 형식이 아닙니다.').css("color", "red");
				}

			} else if (result == 0) { // 사용가능
				if (email == '' || email == null) {
					$("#result_email").html('');
				} else {
					check.setAttribute('value', 'success');
					check2.setAttribute('class', 'form-control is-valid');
					$("#result_email").html('사용가능한 이메일입니다.').css("color", "green");
				}

			} else { // 중복
				check.setAttribute('value', 'emailFail');
				check2.setAttribute('class', 'form-control is-invalid');
				$("#result_email").html('중복된 이메일입니다.').css("color", "red");
			}
		}
	});
}

function checkPwd() {
	let password = $('#password').val();
	let confirmPassword = $('#confirmPassword').val();
	const check = document.getElementById("result_checkPwd2");

	const pwdCheck = document.getElementsByClassName('form-control')[3];
	const pwdCheck2 = document.getElementsByClassName('form-control')[4];

	let jsonData = {
		"password": password,
		"confirmPassword": confirmPassword
	};

	$.ajax({
		type: "POST",
		url: "confirmPassword",
		data: JSON.stringify(jsonData),
		dataType: 'json',
		contentType: 'application/json;charset=UTF-8',
		success: function (result) {
			if (result == 1) {
				if (confirmPassword == '') {
					$("#result_checkPwd").html('');
				} else {
					check.setAttribute('value', 'success');
					pwdCheck.setAttribute('class', 'form-control is-valid');
					pwdCheck2.setAttribute('class', 'form-control is-valid');

					$("#result_checkPwd").html('비밀번호가 일치합니다.').css("color", "green");
				}
			} else {
				check.setAttribute('value', 'pwdFail');
				pwdCheck.setAttribute('class', 'form-control is-invalid');
				pwdCheck2.setAttribute('class', 'form-control is-invalid');

				$("#result_checkPwd").html('비밀번호가 일치하지 않습니다.').css("color", "red");
			}


		}
	});

}



