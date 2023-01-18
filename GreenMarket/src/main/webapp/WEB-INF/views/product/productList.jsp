<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>bootstrap form test</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="../include/header.jsp" %>

<%-- <c:if test="${!empty productModel}">정보 넘어옴</c:if> --%>
	<%-- <c:forEach items="${productModel}" var="pic" varStatus="p">
		<img alt="tkwls" src="${path}resources/img/${pic.f_proxy_name}">
	</c:forEach>	 --%>
	
 <div class="album py-5 bg-light">
    <div class="container">
	
	<div class="btn-group">
	  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" 
	  data-bs-display="static" aria-expanded="false">
	    
	  </button>
	  <ul class="dropdown-menu dropdown-menu-end">
	    <li><a class="dropdown-item" href="#">인기매물</a></li>
	    <li><a class="dropdown-item" href="#">디지털 기기</a></li>
	    <li><a class="dropdown-item" href="#">생활가전</a></li>
	    <li><a class="dropdown-item" href="#">생활주방</a></li>
	    <li><a class="dropdown-item" href="#">유아동</a></li>
	    <li><a class="dropdown-item" href="#">의류</a></li>
	    <li><a class="dropdown-item" href="#">잡화</a></li>
	    <li><a class="dropdown-item" href="#">뷰티•미용</a></li>
	    <li><a class="dropdown-item" href="#">취미•게임•음반</a></li>
	    <li><a class="dropdown-item" href="#">도서</a></li>
	    <li><a class="dropdown-item" href="#">중고차</a></li>
	    <li><a class="dropdown-item" href="#">가공식품</a></li>
	    <li><a class="dropdown-item" href="#">반려동물 물품</a></li>
	    <li><a class="dropdown-item" href="#">기타 중고물품</a></li>
	   
	  </ul>
	</div>
	
	<div class="btn-group">
	  <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" 
	  data-bs-display="static" aria-expanded="false"> <!-- data-bs-offset="10,20" -->
	    
	  </button>
	  <ul class="dropdown-menu">
	    <li><a class="dropdown-item" href="productResult?command=brandNewList">최신순</a></li>
	    <li><a class="dropdown-item" href="productResult?command=viewsLevelList">조회순</a></li>
	    <li><a class="dropdown-item" href="productResult?command=priceLowList">낮은 가격순</a></li>
	    <li><a class="dropdown-item" href="productResult?command=priceHighList">높은 가격순</a></li>
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
            <text x="50%" y="50%" fill="#eceeef" dy=".3em">Thumbnail</text>
            <image href="resources/img/${p.f_proxy_name}" width="100%" height="100%"></svg>

            <div class="card-body">
            <h4 class="card-head">${p.p_name}</h4>
              <p class="card-text">${p.description}</p>
              <div class="d-flex justify-content-between align-items-center">
                <div class="btn-group">
                  <button href="#" type="button" class="btn btn-sm btn-outline-secondary">보기</button>
                </div>
                <small class="text-muted">9 mins</small>
              </div>
            </div>
          </div>
        </div>
      </c:forEach>
      </div>
    </div>
  </div>
  <%@ include file="../include/footer.jsp" %>
</body>
</html>