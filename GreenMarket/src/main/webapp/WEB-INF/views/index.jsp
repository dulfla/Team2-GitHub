<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린 마켓</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<%-- <link rel="stylesheet" href="${path}resources/style/basicStryle.css"> --%>

<style type="text/css">

/* 광고 배너*/
.advertising  .badges2 {
	position: absolute;
	top: 132px;
	right: 12px;
}

.advertising  .badges2 .badge2 {
	border-radius: 5px;
	overflow: hidden;
	margin-bottom: 12px;
	box-shadow: 4px 4px 10px rgba(0, 0, 0, .15);
	cursor: pointer;
}
</style>
</head>
<body>
	<%@ include file="include/header.jsp" %>
	<div id="container">
		<!-- 메인 공간 -->
		<!-- 광고 배너 -->
		<div class="advertising ">
			<div class="badges2">
		      <div class="badge2">
		        <img src="${path}resources/img/badge3.jpg" alt="Badge">
		      </div>
		      <div class="badge2">
		        <img src="https://greened.co.kr/assets/_img/header/new23_headerlogo0.svg?3" alt="Badge">
		      </div>
		      <div class="badge2">
		      </div>
		    </div>
		</div>
	</div>
	<%@ include file="include/footer.jsp" %>
</body>
</html>