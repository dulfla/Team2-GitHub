<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />	
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700&display=swap" rel="stylesheet">

<!-- jQuery -->
<script
  src="https://code.jquery.com/jquery-3.6.3.js"
  integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
  crossorigin="anonymous">
</script>

<style>
	header .search {
	  position: relative;
	  height: 34px;
	}
	header .search input[type=search] {
	  width: 36px;
	  height: inherit;
	  padding: 4px 10px;
	  border: 1px solid #ccc;
	  box-sizing: border-box;
	  border-radius: 5px;
	  outline: none;
	  background-color: #fff;
	  color: #777;
	  font-size: 16px;
	  transition: width .4s;
	}
	header .search input[type=search]:focus {
	  width: 190px;
	  border-color: #669900;
	}
	
	header .search .material-symbols-outlined {
	 height: 24px;
	  position: absolute;
	  top: 0;
	  bottom: 0;
	  right: 5px;
	  margin: auto; 
	  transition: .4s;
	}
	header .search.focused .material-symbols-outlined {
	  opacity: 0;
	} 
</style>
    
<header class="p-3 border-bottom"> <!-- mb-3  -->
	<div class="container">
    	<div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
      		<a href="index" class="d-flex align-items-center mb-2 mb-lg-0 text-dark text-decoration-none">
        		<img class="bi me-2" width="150" height="60" role="img" alt="그린마켓 로고" src="${path}resources/img/그린마켓2.png">
        		<!-- 로고 비율 최적화 == w:150, h:60 -->
      		</a>

		    <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
			    <li><a href="productList?c=all&v=product" class="nav-link px-2 link-dark">중고 거래</a></li>
			    <li><a href="popularSearch" class="nav-link px-2 link-dark">인기검색어</a></li>
		    	<c:if test="${!empty authInfo && authInfo.type=='U'}">
				    <li>
				    	<a href="#" class="nav-link px-2 link-dark dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">내 물건</a>
				        <ul class="dropdown-menu text-small">
				            <li><a class="dropdown-item" href="productRegister">상품 등록</a></li>
				            <li><a class="dropdown-item" href="myProduct">상품 관리</a></li>
				        </ul>
				    </li>
		    	</c:if>
		    	<c:if test="${!empty authInfo && authInfo.type=='M'}">
				    <li>
				    	<a href="#" class="nav-link px-2 link-dark dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">현황 확인</a>
				        <ul class="dropdown-menu text-small">
				            <li><a class="dropdown-item" href="MemberStatus">회원 현황</a></li>
				            <li><a class="dropdown-item" href="ProductStatus">게시물 현황</a></li>
				        </ul>
				    </li>
				    <li><a href="Server" class="nav-link px-2 link-dark">서버 설정</a></li>
				    <li><a href="CategoryAdmin" class="nav-link px-2 link-dark">카테고리 관리</a></li>
		    	</c:if>
		    </ul>
		      	 <form class="col-8 col-lg-auto mb-2 mb-lg-0 me-lg-4" role="search" action="search" method="get">
			      	<div class="search col-4 col-lg-auto mb-2 mb-lg-0 me-lg-0" >
		          		<input type="hidden" name="c" value="all">
		          		<input type="hidden" name="v" value="product">
		          		<input type="hidden" name="email" value="${authInfo.email}">
		          		<input type="search"  id="keyword" name="keyword" aria-label="Search">
		        		<div class="material-symbols-outlined col-11 col-lg-auto ">search</div>
		        	</div>
	        	</form> 
	        	
	        	<c:choose>
	        		<c:when test="${empty member}">
	        			<div class="nav-link px-2 link-dark">${authInfo.nickname}</div>
	        		</c:when>
	        		<c:otherwise>
	        			<div class="nav-link px-2 link-dark">${member.nickname}</div>
	        		</c:otherwise>
	        	</c:choose>
	        	
	      	<div class="dropdown text-end">
	      		<c:if test="${empty authInfo}">
	      			<a href="login"><button type="button" class="btn btn-outline-dark me-2">로그인</button></a>
				    <a href="register"><button type="button"class="btn btn-warning">회원가입</button></a>	
		    	</c:if>
	        	<c:if test="${!empty authInfo}"> 
				    <a href="#" class="d-block link-dark text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
			            <img src="https://github.com/mdo.png" alt="mdo" width="32" height="32" class="rounded-circle">
			        </a>
			        <ul class="dropdown-menu text-small">
			        	<c:if test="${authInfo.type=='U'}">
			        		<li><a id="myChattings" class="dropdown-item" href="#">채팅방</a></li>
			        	</c:if>
				            <li><a class="dropdown-item" href="memberDetail?email=${authInfo.email}">정보수정</a></li>
				            <li><hr class="dropdown-divider"></li>
			            <li><a class="dropdown-item" href="logout">로그아웃</a></li>
			        </ul>
		    	</c:if>
	     	</div>
	  	</div>
   	</div>
</header>
<c:if test="${!empty authInfo && authInfo.type=='U'}">
	<%@ include file="chat/chatRoom.jsp" %>
</c:if>

<script type="text/javascript">
	
	const searchEl = document.querySelector('.search');
	const searchInputEl = searchEl.querySelector('input[type=search]');
	
	searchEl.addEventListener('click',function(){
	  searchInputEl.focus();
	});
	
	searchInputEl.addEventListener('focus',function(){
	  searchEl.classList.add('focused');
	  searchInputEl.setAttribute('placeholder','물품검색');
	});
	
	searchInputEl.addEventListener('blur',function(){
	  searchEl.classList.remove('focused');
	  searchInputEl.setAttribute('placeholder','');
	});  
</script>
