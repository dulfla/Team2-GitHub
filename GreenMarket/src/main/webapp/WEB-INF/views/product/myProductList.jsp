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
					<c:choose>
						<c:when test="${empty p.imgurl}">
							<image href="${path}resources/img/그린마켓2.png" width="100%" height="100%"></svg>
			    		</c:when>
			    		<c:when test="${!empty p.imgurl}">
			         		<image href="display?fileName=${p.imgurl}" width="100%" height="100%"></svg> <!-- /GreenMarket/product/ -->
			     		</c:when>
		     		</c:choose>
		  			<div class="card-body">
		  				<div id="card-body-header" class="row">
		  					<div class="col">
		  						<p class="card-text">${p.category}</p>		                
		  					</div>
		  					<div class="col">
			 					<c:choose>
									<c:when test="${p.trade eq'trade' or p.trade eq 'TRADE'}"><p  class="position-relative text-end">거래중</p></c:when>
									<c:when test="${p.trade eq'clear' or p.trade eq 'CLEAR'}"><p class="position-relative text-end">거래완료</p></c:when>
			 					</c:choose>
				 			</div>
		      			</div>
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
	<div class="cls2">		<!-- 페이징 -->
		<c:if test="${totalCnt != null}">
		<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<c:choose>
				<c:when test="${totalCnt > 100}">		<!-- 전체 갯수가 100개가 넘는가 -->
					<c:if test="${(section*100) < totalCnt}">		<!-- 다음 섹션이 존재하는가  '>>' O -->
						<c:forEach var="page" begin="1" end="10" step="1">		<!-- 번호 매기기 -->
							<c:if test="${section>1 && page==1}">  <!-- 이전 섹션 표시 -->
								<li class="page-item disabled">
									<a class="page-link" href="myProduct?sN=${section-1}&pN=${10}"><<</a>
								</li>
							</c:if>	
								<li class="page-item"><a class="page-link" href="myProduct?sN=${section}&pN=${page}">${(section-1)*10+page}</a></li>
												<!-- 번호를 눌렀을때 해당 섹션과 해당 페이지 번호를 서버에 전달 -->							
							<c:if test="${page==10}">		<!-- 다음 섹션 표시 -->
								<li class="page-item">
									<a class="page-link" href="myProduct?sN=${section+1}&pN=${1}">>></a>
								</li>
							</c:if>
						</c:forEach>
					</c:if>
					<c:if test="${(section*100) >= totalCnt}">		<!-- 다음 섹션이 없는가  '>>' X -->
						<c:forEach var="page" begin="1" end="${((totalCnt+9)-(section-1)*100)/10}" step="1">
							<c:if test="${section>1 && page==1}">  <!-- 이전 섹션 표시 -->
								<li class="page-item disabled">
									<a class="page-link" href="myProduct?sN=${section-1}&pN=${10}"><<</a>
								</li>
							</c:if>							
								<li class="page-item"><a class="page-link" href="myProduct?sN=${section}&pN=${page}">${(section-1)*10+page}</a></li> <!-- 번호를 눌렀을때 해당 섹션과 해당 페이지 번호를 서버에 전달 -->																	
						</c:forEach>
					</c:if>
				</c:when>
				<c:when test="${totalCnt == 100}">		<!-- 전체 갯수가 100개가 딱 맞는가 -->
					<c:forEach var="page" begin="1" end="10" step="1">
						<li class="page-item"><a class="page-link" href="myProduct?sN=${section}&pN=${page}">${(section-1)*10+page}</a></li>
							<!-- 번호를 눌렀을때 해당 섹션과 해당 페이지 번호를 서버에 전달 -->				
					</c:forEach>
				</c:when>
				<c:when test="${totalCnt < 100}">		<!-- 전체 갯수가 100개보다 적은가 -->
					<c:forEach var="page" begin="1" end="${(totalCnt+9)/10}" step="1">
						<li class="page-item"><a class="page-link" href="myProduct?sN=${section}&pN=${page}">${(section-1)*10+page}</a></li>
							<!-- 번호를 눌렀을때 해당 섹션과 해당 페이지 번호를 서버에 전달 -->				
					</c:forEach>
				</c:when>
			</c:choose>
		</c:if>
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