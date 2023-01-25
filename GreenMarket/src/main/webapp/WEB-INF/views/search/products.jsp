<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- <%@ page import="spring.controller.ProductDateTimeAgo" contentType="text/html;charset=UTF-8" %>
<jsp:useBean id="dateTime" class="spring.controller.ProductDateTimeAgo" scope="page" /> --%>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>그린마켓</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<style>
	h4{
		margin-bottom: 30px;
	}
	span{
		color: red;
	}
</style>
<body>
<%@ include file="../include/header.jsp" %>

<%-- <c:if test="${!empty productModel}">정보 넘어옴</c:if> --%>
	<%-- <c:forEach items="${productModel}" var="pic" varStatus="p">
		<img alt="tkwls" src="${path}resources/img/${pic.f_proxy_name}">
	</c:forEach>	 --%>
	
 <div class="album py-5 bg-light">
    <div class="container">
	<h4 > <span>${search}</span>의 검색결과 ${count}개</h4>
	<div class="btn-group">
	  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" 
	  data-bs-display="static" aria-expanded="false">
	    카테고리
	  </button>
	  <ul class="dropdown-menu dropdown-menu-end">
	  <c:forEach items="${categoryList}" var="c">
	  	<li><a class="dropdown-item" href="search?c=${c.category}&v=product&search=${search}">${c.category}</a></li>
	  </c:forEach>
	    
<!-- 	    <li><a class="dropdown-item" href="#">기타 중고물품</a></li>
	    <li><a class="dropdown-item" href="#">도서</a></li>
	    <li><a class="dropdown-item" href="#">디지털 기기</a></li>
	    <li><a class="dropdown-item" href="#">반려동물 물품</a></li>
	    <li><a class="dropdown-item" href="#">뷰티•미용</a></li>
	    <li><a class="dropdown-item" href="#">생활가전</a></li>
	    <li><a class="dropdown-item" href="#">생활주방</a></li>
	    <li><a class="dropdown-item" href="#">유아동</a></li>
	    <li><a class="dropdown-item" href="#">의류</a></li>
	    <li><a class="dropdown-item" href="#">인기매물</a></li>
	    <li><a class="dropdown-item" href="#">잡화</a></li>
	    <li><a class="dropdown-item" href="#">중고차</a></li>
	    <li><a class="dropdown-item" href="#">취미•게임•음반</a></li> -->
	   
	  </ul>
	</div>
	
	<div class="btn-group">
	  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" 
	  data-bs-display="static" aria-expanded="false"> <!-- data-bs-offset="10,20" -->
	    정렬기준
	  </button>
	  <ul class="dropdown-menu">
	    <li><a class="dropdown-item" href="search?c=${c}&v=brandNew&search=${search}">최신순</a></li>
	    <li><a class="dropdown-item" href="search?c=${c}&v=viewsLevel&search=${search}">조회순</a></li>
	    <li><a class="dropdown-item" href="search?c=${c}&v=priceLow&search=${search}">낮은 가격순</a></li>
	    <li><a class="dropdown-item" href="search?c=${c}&v=priceHigh&search=${search}">높은 가격순</a></li>
	  </ul>
	</div>
		
	<%-- <div class="dropdown">
	  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false"></button>
	  <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0"">
	  	<c:forEach items="${category}" var="c">
		    <li><a class="dropdown-item" href="#">asds</a></li>
		    <li><a class="dropdown-item" href="#">Another action</a></li>
		    <li><a class="dropdown-item" href="#">Something else here</a></li>
		</c:forEach>   
	  </ul>	   
	</div> --%>
	
      <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
      <c:forEach items="${productModel}" var="p">
      	<div class="col">
          <div class="card shadow-sm">
            <svg class="bd-placeholder-img card-img-top" width="100%" height="225" xmlns="http://www.w3.org/2000/svg" 
            role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false">       
            <title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/>
            <c:choose>
	            <c:when test="${empty p.imgurl}">
	            	<image href="${path}resources/img/그린마켓2.png" width="100%" height="100%"></svg>
	            </c:when>
	            <c:when test="${!empty p.imgurl}">
	            	<image href="display?fileName=${p.imgurl}" width="100%" height="100%"></svg> <!-- /GreenMarket/product/ -->
	            </c:when>
            </c:choose>
            
            
            <div class="card-body">
               <p class="card-text">${p.category}</p>
               <h4 class="card-head mb-3">${p.p_name}</h4>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button href="productDetail?p_id=${p.p_id}" type="button" class="btn btn-sm btn-outline-secondary" name="moveToDetail">보기</button>
                </div>
                <small class="text-muted"><fmt:formatNumber value="${p.price}"  pattern="###,###,###"/>원</small>
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
  		for(let i=0; i<moveToDetail.length; i++){
  			moveToDetail[i].addEventListener('click', function(){
  	  			let href = moveToDetail[i].getAttribute('href');
  	  			location.href = href;
  	  		}, false);
  		}
  	}
  </script>
</body>
</html>