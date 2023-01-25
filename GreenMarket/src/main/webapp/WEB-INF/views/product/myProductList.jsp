<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- <%@ page import="spring.controller.ProductDateTimeAgo" contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="dateTime" class="spring.controller.ProductDateTimeAgo" scope="page" /> --%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>그린 마켓</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="../include/header.jsp" %>

<%-- <c:if test="${!empty productModel}">정보 넘어옴</c:if> --%>
	<%-- <c:forEach items="${productModel}" var="pic" varStatus="p">
		<img alt="tkwls" src="${path}resources/img/${pic.f_proxy_name}">
	</c:forEach>	 --%>
	<div class="container">
	<div class="list-group">
  <a href="myProduct" class="list-group-item list-group-item-action">내 상품</a>
  <a href="sell" class="list-group-item list-group-item-action">판매완료된 상품</a>
  <a href="unSell" class="list-group-item list-group-item-action">판매중인 상품</a>
</div>
	</div>
 <div class="album py-5 bg-light">
    <div class="container">
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
      <c:forEach items="${productModel}" var="p">
      	<div class="col">
          <div class="card shadow-sm">
            <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" 
            role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false">       
            <title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/>
            <image href="display?fileName=${p.imgurl}" width="100%" height="100%"></svg> <!-- /GreenMarket/product/ -->

            <div class="card-body">
               <p class="card-text">${p.category}</p>
               <h4 class="card-head mb-3">${p.p_name}</h4>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button href="productDetail?p_id=${p.p_id}" type="button" class="btn btn-sm btn-outline-secondary" name="moveToDetail">보기</button>
                </div>
                <small class="text-muted"></small>
              </div>
            </div>
          </div>
        </div>
      </c:forEach>
      </div>
    </div>
  </div>  
  <%@ include file="../include/footer.jsp" %>
  <script type="text/javascript">
  	window.onload = function(){
  		let moveToDetail = document.getElementsByName('moveToDetail');
  		for(let i=0; i<moveToDetail.length; i++){console.log(moveToDetail[i])
  			moveToDetail[i].addEventListener('click', function(){
  	  			let href = moveToDetail[i].getAttribute('href');
  	  			location.href = href;
  	  		}, false);
  		}
  	}
  </script>
</body>
</html>