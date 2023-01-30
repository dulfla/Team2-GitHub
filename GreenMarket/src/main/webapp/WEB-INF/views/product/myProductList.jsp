<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<div class="container">
	<div class="list-group">
  		<a href="myProduct" class="list-group-item list-group-item-action">내 상품</a>
  		<a href="selled" class="list-group-item list-group-item-action">판매완료된 상품</a>
  		<a href="unSelled" class="list-group-item list-group-item-action">판매중인 상품</a> 
	</div>
	<div class="btn-group">
	  	<button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" data-bs-display="static" aria-expanded="false">
		  	${pageData.oip} 개
	  	</button>
	  	<ul class="dropdown-menu">
		    <li><a class="dropdown-item" href="${location}?pis=${pageData.pis}&oip=15">15 개</a></li>
		    <li><a class="dropdown-item" href="${location}?pis=${pageData.pis}&oip=30">30 개</a></li>
		    <li><a class="dropdown-item" href="${location}?pis=${pageData.pis}&oip=60">60 개</a></li>
		    <li><a class="dropdown-item" href="${location}?pis=${pageData.pis}&oip=90">90 개</a></li>
	  	</ul>
	</div>
 	<div class="album py-5">
   	 	<div class="container">
      		<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
      			<c:forEach items="${products}" var="p">
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
    </div>
    <div class="paging">
		<c:if test="${!empty totalCnt}">
			<nav aria-label="Page navigation example">
		  		<ul class="pagination justify-content-center">
		  			<c:if test="${totalCnt>pageData.oip}">
						<c:if test="${pageData.s>1}">
							<li class="page-item">
								<a class="page-link" href="${location}?pis=${pageData.pis}&oip=${pageData.oip}&s=${pageData.s-1}&p=${pageData.pis}"><<</a>
							</li>
						</c:if>
						<c:forEach var="page" begin="1" end="${((pageData.s*(pageData.pis*pageData.oip))<totalCnt)?(pageData.pis):(((totalCnt+(pageData.oip-1))-(pageData.s-1)*(pageData.pis*pageData.oip))/pageData.oip)}" step="1">
							<li class="page-item">
								<c:if test="${pageData.p==page}"><b></c:if>
								<a class="page-link" href="${location}?pis=${pageData.pis}&oip=${pageData.oip}&s=${pageData.s}&p=${page}">${((pageData.s-1)*pageData.pis)+page}</a>
								<c:if test="${pageData.p==page}"></b></c:if>
							</li>
						</c:forEach>
						<c:if test="${(pageData.s*(pageData.pis*pageData.oip)) < totalCnt}">
							<li class="page-item">
								<a class="page-link" href="${location}?pis=${pageData.pis}&oip=${pageData.oip}&s=${pageData.s+1}&p=1">>></a>
							</li>
						</c:if>
					</c:if>
				</ul>
			</nav>
		</c:if>
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