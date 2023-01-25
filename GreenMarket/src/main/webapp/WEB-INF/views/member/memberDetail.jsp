<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린 마켓</title>
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
<style type="text/css">
	#container2{
		width:100%;
		height:100vh;
	}
</style>
<jsp:include page="../include/header.jsp"/>
</head>
<body>
	<div id="container2">
	<div class="container">
    	<div class="row">
        <div class="col-sm-12">
            <div class="col-sm-2"></div>
	        <div class="col-sm-9">
	            <h2 class="text-center">회원 정보 보기</h2>
	            <table class="table table-striped">
	              <tr>
	                <td>이름</td>
	                <td>${member.name}</td>
	              </tr>
	               
	              <tr>
	                <td>이메일</td>
	                <td>${member.email}</td>
	              </tr>
	               
	              <tr>
	                <td>닉네임</td>
	                <td>${member.nickname}</td>
	              </tr>
	               
	              <tr>
	                <td>생년월일</td>
	                <td>${member.birth}</td>
	              </tr>
	               
	               <tr>
		           	<td>전화번호</td>
		           	<td>${member.phone}</td>
	               </tr>
	               
	             	<tr>
		            	<td>주소</td>
		                <td>${member.address}</td>
	               	</tr>
	                <tr>
	                  <td class="text-center" colspan="2">
						<button onclick="location.href='changeMemberInfo?email=${member.email}'" class="btn btn-primary">회원수정</button>
						<button onclick="location.href='memberWithDrawal'" class="btn btn-danger">회원탈퇴</button>
						<button onclick="location.href='changePassword'" class="btn btn-warning">비밀번호 변경</button>
	                  
	                 </td>    
	           		</tr> 
	            </table>
			</div>
        </div> <!-- col-sm-12 -->
    </div><!-- row -->
</div> <!-- container end-->
</div>     
</body>
<jsp:include page="../include/footer.jsp"/>
</html>