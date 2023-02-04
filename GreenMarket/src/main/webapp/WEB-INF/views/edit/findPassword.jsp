<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린 마켓</title>
<link rel="icon" href="${path}resources/img/icon.png">
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
    margin: 0;
    padding: 0;
    font-family: Verdana, Geneva, Tahoma, sans-serif;
}

#form-container {
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

#form-inner-container {
    background-color: white;
    max-width: 70%;
    border-radius: 8px;
    box-shadow: 0 0 20px gainsboro;
}

#sign-up-container {
    padding: 60px 80px;
    width: 320px;
    display: inline-block;
    position: relative;
    top: -50px;
}

form input:not(:last-of-type) {
    display: block;
    margin-bottom: 20px;
    border: 1px solid #E5E9F5;
    background-color: #F6F7FA;
    padding: 10px;
    margin-top: 10px;
    border-radius: 10px;
    width: 200px%;
}

#form-controls {
    margin-bottom: 20px;
}


h2 {
    color: red;
    font-size: 150%;
    font-weight: 500;
}

label {
    color: #7369AB;
}

::placeholder {
    color: #C0C7DB;
    font-size: larger;
    letter-spacing: 1.2px;
}

 .button {
    border: none;
    font-size: 120%;
}

 .button:hover {
    cursor: pointer;
}

#form-controls .button[type="button"] {
    padding: 16px 75px;
    background-color: #ED4B5E;
    border-radius: 10px;
    color: white;
}

.button[type="button"]:hover {
    background-color: #ff6678;
}

#form-controls .button[type="button"] {
    padding: 16px 0 16px 35px;
    background-color: transparent;
    color: #ED4B5E;
}

#terms {
    width: 30px;
    height: 30px;
    appearance: none;
    border: 2px solid #7369AB;
    border-radius: 4px;
    position: relative;
}

#terms:checked:after {
    content: '\2713';
    color: #7369AB;
    font-size: 24px;
    position: absolute;
    top: 0;
    left: 3px;
}

label[for="terms"] {
    display: inline-block;
    width: 80%;
    margin-left: 10px;
}

.termsLink {
    color: #EF7886;
    text-decoration: none;
}


#animation-container {
    display: inline-block;
    position: relative;
    top: 50px;
}

/* responsive display */

@media(max-width:1438px) {
    lottie-player {
        width: 300px!important;
    }
}

@media(max-width:1124px) {
    #animation-container {
        display: none;
    }

    #form-inner-container{
        display: flex;
        justify-content: center;
    }
}

@media(max-width: 684px) {
    #form-controls {
        text-align: center;
        margin: 0;
        padding: 0;
    }

    button {
        width: 100%;
    }

    form input:not(:last-of-type) {
        width: 85%;
    }

    #toggleSignIn, #toggleSignUp {
        padding: 16px 75px;
    }

    #terms {
        width: 20px;
        height: 20px;
    }
    
    label[for="terms"] {
        display: inline-block;
        font-size: smaller;
    }
}
</style>
<jsp:include page="../include/header.jsp"/>

</head>
<body>
	
   
    
  <div id="form-container">
      <div id="form-inner-container">
        <!-- Sign up form -->
	  	<div id="sign-up-container">
          <h2>비밀번호 찾기</h2>
          <form>
            <label for="memMail">이메일</label>
            <input type="email" name="memMail" id="memMail" placeholder="이메일 입력">
            
			<div id="form-controls">
              <input type="button" value="메일전송" id="mailAuth" class="btn btn-danger">
            </div>
            
            <label for="authKey">인증번호</label>
            <input type="text" name="authKey" id="authKey" placeholder="인증번호 입력">


            <div id="form-controls">
              <button type="button" class="btn btn-danger" onclick="findPasswordCheck()">인증하기</button>
            </div>
			<div id="form-controls">
            </div>
			
            <input type="hidden" name="terms" id="terms">
          </form>
        </div>


        <!-- Lottie animation -->
        <div id="animation-container">
          <lottie-player src="https://assets3.lottiefiles.com/packages/lf20_aesgckiv.json"  background="transparent"  speed="1"  style="width: 520px; height: 520px;" loop autoplay></lottie-player>
        </div>
      </div>
  </div>


  <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>


</body>

<script type="text/javascript" defer="defer" src="${path}resources/script/edit/findPassword.js"></script>
<jsp:include page="../include/footer.jsp"/>
</html>