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

	<div class="album py-5 bg-light">
		<div class="container">
			<h4>
				<span>${search}</span>의 검색결과 ${count}개
			</h4>
			<div class="btn-group mb-4">
				<button class="btn btn-secondary dropdown-toggle" type="button"
					data-bs-toggle="dropdown" data-bs-display="static"
					aria-expanded="false">
					<c:choose>
						<c:when test="${empty c}">카테고리</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${c eq 'all'}">전체 보기</c:when>
								<c:otherwise>${c}</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</button>
				<ul class="dropdown-menu dropdown-menu-end">
					<li><a class="dropdown-item"
						href="search?c=all&v=${v}&keyword=${search}">전체 보기</a></li>
					<c:forEach items="${categoryList}" var="c">
						<li><a class="dropdown-item"
							href="search?c=${c.category}&v=${v}&keyword=${search}">${c.category}</a></li>
					</c:forEach>
				</ul>
			</div>
			<div class="btn-group mb-4">
				<button class="btn btn-secondary dropdown-toggle" type="button"
					data-bs-toggle="dropdown" data-bs-display="static"
					aria-expanded="false">
					<!-- data-bs-offset="10,20" -->
					<c:choose>
						<%-- <a class="dropdown-item" href="search?c=${c.category}&v=product&keyword=${search}">${c.category}</a> --%>
						<c:when test="${v eq 'product'}">조회유형</c:when>
						<c:when test="${v eq 'brandNew'}">최신순</c:when>
						<c:when test="${v eq 'viewsLevel'}">조회순</c:when>
						<c:when test="${v eq 'priceLow'}">낮은 가격순</c:when>
						<c:when test="${v eq 'priceHigh'}">높은 가격순</c:when>
						<c:otherwise>${v}</c:otherwise>
					</c:choose>
				</button>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item"
						href="search?c=${c}&v=brandNew&keyword=${search}">최신순</a></li>
					<li><a class="dropdown-item"
						href="search?c=${c}&v=viewsLevel&keyword=${search}">조회순</a></li>
					<li><a class="dropdown-item"
						href="search?c=${c}&v=priceLow&keyword=${search}">낮은 가격순</a></li>
					<li><a class="dropdown-item"
						href="search?c=${c}&v=priceHigh&keyword=${search}">높은 가격순</a></li>
				</ul>
			</div>
			<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
				<c:forEach items="${productModel}" var="p">
					<div class="col">
						<div class="card shadow-sm">
							<svg class="bd-placeholder-img card-img-top" width="100%"
								height="225" xmlns="http://www.w3.org/2000/svg" role="img"
								aria-label="Placeholder: Thumbnail"
								preserveAspectRatio="xMidYMid slice" focusable="false">       
		            <title>Placeholder</title><rect width="100%" height="100%"
									fill="#55595c" />
		            <c:choose>
			            <c:when test="${empty p.imgurl}">
			            	<image href="${path}resources/img/그린마켓2.png"
											width="100%" height="100%"></svg>
							</c:when>
							<c:when test="${!empty p.imgurl}">
								<image href="display?fileName=${p.imgurl}" width="100%"
									height="100%">
								</svg> <!-- /GreenMarket/product/ -->
							</c:when>
							</c:choose>
							<div class="card-body">
								<div id="card-body-header" class="row">
									<div class="col">
										<p class="card-text">${p.category}</p>
									</div>
									<div class="col">
										<c:choose>
											<c:when test="${p.trade eq'trade' or p.trade eq 'TRADE'}">
												<p class="position-relative text-end">거래중</p>
											</c:when>
											<c:when test="${p.trade eq'clear' or p.trade eq 'CLEAR'}">
												<p class="position-relative text-end">거래완료</p>
											</c:when>
										</c:choose>
									</div>
								</div>
								<h4 class="card-head mb-3">${p.p_name}</h4>

								<div class="d-flex justify-content-between align-items-center">
									<div class="btn-group">
										<button href="productDetail?p_id=${p.p_id}" type="button"
											class="btn btn-sm btn-outline-secondary" name="moveToDetail">보기</button>
									</div>
									<small class="text-muted"><fmt:formatNumber
											value="${p.price}" pattern="###,###,###" />원</small>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
</body>
<script type="text/javascript">
	window.onload = function() {
		let moveToDetail = document.getElementsByName('moveToDetail');
		for (let i = 0; i < moveToDetail.length; i++) {
			moveToDetail[i].addEventListener('click', function() {
				let href = moveToDetail[i].getAttribute('href');
				location.href = href;
			}, false);
		}
	}
</script>
<jsp:include page="../include/footer.jsp"/>
</html>