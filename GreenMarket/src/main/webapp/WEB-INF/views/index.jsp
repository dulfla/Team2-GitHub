<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린 마켓</title>
<<<<<<< HEAD

<link rel="icon" href="resources/img/favicon-32x32.png">

=======
<link rel="icon" href="${path}resources/img/icon.png">
>>>>>>> c78c0f44744ceb4ab5c567ce4ef55099db17c8d5
<!-- bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />

<!-- gsap & ScrollToPlugin -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js" integrity="sha512-WFN04846sdKMIP5LKNphMaWzU7YpMyCU245etK3g/2ARYbPK9Ub18eG+ljU96qKRCWh+quCY7yefSmlkQw1ANQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.11.3/gsap.min.js" integrity="sha512-gmwBmiTVER57N3jYS3LinA9eb8aHrJua5iQD7yqYCKa5x6Jjc7VDVaEA0je0Lu0bP9j7tEjV3+1qUm6loO99Kw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.11.3/ScrollToPlugin.min.js" integrity="sha512-Eenw6RBFiF4rO89LCaB5fkd4WXI4Y7GSRxrLMMWx73dZNcl+dBU3/pJtITD2gTCoEGIf/Ph3spwp0zZnF+UEJg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<!-- scrollMagic -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/ScrollMagic/2.0.8/ScrollMagic.min.js" integrity="sha512-8E3KZoPoZCD+1dgfqhPbejQBnQfBXe8FuwL4z/c8sTrgeDMFEnoyTlH3obB4/fV+6Sg0a0XF+L/6xS4Xx1fUEg==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>


<style type="text/css">
	#main{
			min-height:100vh;
		} 
	/* 카테고리 */	
	#categorys {
		width: 50vw;
		margin: 0px auto;
		text-align: center;
	}
	
	.moveToCategorys {
		display: inline-block;
		text-decoration: none;
		text-align: center;
		color: black;
		margin: 10px 20px;
	}
	
	.categoryIcon {
		width: 45px;
		height: 45px;
	}
	
	.categoryTitle {
		display: inline-block;
		font-size: 12px;
		font-weight: bold;
	}
	
	.moveToCategorys:hover .categoryTitle {
		background-color: darkgreen;
		color: white;
	}
	
	.radi {
		border-radius: 40px;
		overflow: hidden;
		box-shadow: 4px 4px 10px rgba(0, 0, 0, .15);
		cursor: pointer;
	}
	
	.itemRadi {
		border-radius: 25px;
		overflow: hidden;
		box-shadow: 4px 4px 10px rgba(0, 0, 0, .15);
		cursor: pointer;
	}
	
	/* 이미지 슬라이드 */
	#imgS {
		width: 70%;
		margin: 50px auto;
	}
	
	/* 광고 배너*/
	.pos{
		position: relative;
	}	
	
	.advertising  .badges2 {
		position: fixed;
		top: 200px;
		right: 40px;
	}
	
	.advertising  .badges2 .badge2 {
		border-radius: 5px;
		overflow: hidden;
		margin-bottom: 12px;
		box-shadow: 4px 4px 10px rgba(0, 0, 0, .15);
		cursor: pointer;
	}
	
	/* 추천 카테고리 아이템 */
	#portfolio .portfolio-item {
		max-width: 26rem;
		margin-left: auto;
		margin-right: auto;
	}
	
	#portfolio .portfolio-item .portfolio-link {
		position: relative;
		display: block;
		margin: 0 auto;
	}
	
	#portfolio .portfolio-item .portfolio-link .portfolio-hover {
		display: flex;
		position: absolute;
		width: 100%;
		height: 100%;
		background: rgba(255, 200, 0, 0.9);
		align-items: center;
		justify-content: center;
		opacity: 0;
		transition: opacity ease-in-out 0.25s;
	}
	
	#portfolio .portfolio-item .portfolio-link .portfolio-hover .portfolio-hover-content {
		font-size: 1.25rem;
		color: white;
	}
	
	#portfolio .portfolio-item .portfolio-link:hover .portfolio-hover {
		opacity: 1;
	}
	
	#portfolio .portfolio-item .portfolio-caption {
		padding: 1.5rem;
		text-align: center;
		background-color: #fff;
	}
	
	#portfolio .portfolio-item .portfolio-caption .portfolio-caption-heading
		{
		font-size: 1.5rem;
		font-family: "Montserrat", -apple-system, BlinkMacSystemFont, "Segoe UI",
			Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji",
			"Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
		font-weight: 700;
		margin-bottom: 0;
	}
	
	#portfolio .portfolio-item .portfolio-caption .portfolio-caption-subheading
		{
		font-style: italic;
		font-family: "Roboto Slab", -apple-system, BlinkMacSystemFont,
			"Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif,
			"Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol",
			"Noto Color Emoji";
	}
	
	.portfolio-modal .modal-dialog {
		margin: 1rem;
		max-width: 100vw;
	}
	
	.portfolio-modal .modal-content {
		padding-top: 6rem;
		padding-bottom: 6rem;
		text-align: center;
	}
	
	.portfolio-modal .modal-content h2, .portfolio-modal .modal-content .h2
		{
		font-size: 3rem;
		line-height: 3rem;
	}
	
	.portfolio-modal .modal-content p.item-intro {
		font-style: italic;
		margin-bottom: 2rem;
		font-family: "Roboto Slab", -apple-system, BlinkMacSystemFont,
			"Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif,
			"Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol",
			"Noto Color Emoji";
	}
	
	.portfolio-modal .modal-content p {
		margin-bottom: 2rem;
	}
	
	.portfolio-modal .modal-content ul.list-inline {
		margin-bottom: 2rem;
	}
	
	.portfolio-modal .modal-content img {
		margin-bottom: 2rem;
	}
	
	.portfolio-modal .close-modal {
		position: absolute;
		top: 1.5rem;
		right: 1.5rem;
		width: 3rem;
		height: 3rem;
		cursor: pointer;
		background-color: transparent;
	}
	
	.portfolio-modal .close-modal:hover {
		opacity: 0.3;
	}
	
	.position-absolute {
		right: 150px;
	}
	
	/* 스크롤 */
	
	#to-top {
		width: 50px;
		height: 50px;
		background-color: #333;
		color: #fff;
		border: 2px solid #fff;
		border-radius: 10px;
		cursor: pointer;
		display: flex;
		justify-content: center;
		align-items: center;
		position: fixed;
		bottom: 30px;
		right: 30px;
		z-index: 9;
	}
</style>
</head>
<body>
	<%@ include file="include/header.jsp" %>
	
	<div id="main">
		<!--  메인 이미지-->
	    <div class="ratio" style="--bs-aspect-ratio: 35%;">
	       <img src="${path}resources/img/mainImage/money-2724235_1920.jpg" alt="mainImage">
	        <div class="text-white row">
				<div class="col align-self-center text-center mb-5" style="height: 200px">
					<h1 class="fw-bolder px-4">Welcome to Green Market</h1>
					<p class="lead">A functional boilerplate for one page
						scrolling websites</p>
				</div>
			</div>
		</div>
		
		<!-- 카테고리 -->
		<div id="categorys" class="mt-4 mb-5">
			<c:forEach items="${categoryList}" var="c" varStatus="ci">
				<a class="moveToCategorys"
					href="productList?c=${c.category}&v=brandNew"> <img
					alt="${c.category} 아이콘" src="CategoryImage?fileName=${c.icon}"
					class="categoryIcon"> <br>
					<p class="categoryTitle">${c.category}</p>
				</a>
			</c:forEach>
		</div>
			
		<!-- 광고 배너 -->
		<div class="pos">
			<div class="advertising">
				<div class="badges2">
					<div class="badge2">
						<a href="https://www.starbucks.co.kr/index.do" target='_blank'><img
							src="${path}resources/img/badge/badge3.jpg" alt="Badge"></a>
					</div>
					<div class="badge2">
						<a href="https://www.starbucks.co.kr/index.do" target='_blank'><img
							src="${path}resources/img/badge/badge2.jpg"
							alt="Badge"></a>
					</div>
				</div>
			</div>
		</div>
		
		<!-- 이미지 슬라이드 -->
		<div id="imgS">
			<div id="carouselExampleDark"
				class="carousel carousel-dark slide m-5" data-bs-ride="carousel"
				data-bs-interval="2500">
				<div class="carousel-indicators">
					<button type="button" data-bs-target="#carouselExampleDark"
						data-bs-slide-to="0" class="active" aria-current="true"
						aria-label="Slide 1"></button>
					<button type="button" data-bs-target="#carouselExampleDark"
						data-bs-slide-to="1" aria-label="Slide 2"></button>
					<button type="button" data-bs-target="#carouselExampleDark"
						data-bs-slide-to="2" aria-label="Slide 3"></button>
					<button type="button" data-bs-target="#carouselExampleDark"
						data-bs-slide-to="3" aria-label="Slide 4"></button>
					<button type="button" data-bs-target="#carouselExampleDark"
						data-bs-slide-to="4" aria-label="Slide 5"></button>
				</div>
				<div class="carousel-inner">
					<div class="carousel-item active">
						<div class="container w-75">
							<img src="${path}resources/img/mainPageImg/1.png"
								class="d-block w-100 radi" alt="샘플 이미지">
						</div>
					</div>
					<div class="carousel-item">
						<div class="container w-75">
							<img src="${path}resources/img/mainPageImg/2.png"
								class="d-block w-100 radi" alt="샘플 이미지">
						</div>
					</div>
					<div class="carousel-item">
						<div class="container w-75">
							<img src="${path}resources/img/mainPageImg/3.png"
								class="d-block w-100 radi" alt="샘플 이미지">
						</div>
					</div>
					<div class="carousel-item">
						<div class="container w-75">
							<img src="${path}resources/img/mainPageImg/4.png"
								class="d-block w-100 radi" alt="샘플 이미지">
						</div>
					</div>
					<div class="carousel-item">
						<div class="container w-75">
							<img src="${path}resources/img/mainPageImg/5.png"
								class="d-block w-100 radi" alt="샘플 이미지">
						</div>
					</div>
				</div>
				<button class="carousel-control-prev" type="button"
					data-bs-target="#carouselExampleDark" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="#carouselExampleDark" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>
		</div>
	
		<!-- 페이지 아이템 -->
		<section class="page-section bg-light w-100 p-5" 
			id="portfolio" >
			<div class="container">
				<div class="text-center pb-4">
					<h2 class="section-heading text-uppercase">추천 카테고리</h2>
				</div>
				<div class="row">
					<div class="col-lg-4 col-sm-6 mb-4">
						<!-- Portfolio item 1-->
						<div class="portfolio-item itemRadi">
							<a class="portfolio-link" data-bs-toggle="modal"
								href="productList?c=${c.category}&v=brandNew">
								<div class="portfolio-hover">
									<div class="portfolio-hover-content">
										<i class="fas fa-plus fa-3x"></i>
									</div>
								</div> <img class="img-fluid"
								src="${path}resources/img/portfolio/1.jpg" alt="..." />
							</a>
							<div class="portfolio-caption">
								<a class="moveToCategorys" href="productList?c=기타 중고물품&v=brandNew">
									<div class="portfolio-caption-heading">기타 중고물품</div>
									<div class="portfolio-caption-subheading text-muted">Illustration</div>
								</a>
								
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-sm-6 mb-4">
						<!-- Portfolio item 2-->
						<div class="portfolio-item itemRadi">
							<a class="portfolio-link" data-bs-toggle="modal"
								href="#portfolioModal2">
								<div class="portfolio-hover">
									<div class="portfolio-hover-content">
										<i class="fas fa-plus fa-3x"></i>
									</div>
								</div> <img class="img-fluid"
								src="${path}resources/img/portfolio/2.jpg" alt="..." />
							</a>
							<div class="portfolio-caption">
								<a class="moveToCategorys" href="productList?c=잡화&v=brandNew">
									<div class="portfolio-caption-heading">잡화</div>
									<div class="portfolio-caption-subheading text-muted">Graphic
										Design</div>
								</a>		
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-sm-6 mb-4">
						<!-- Portfolio item 3-->
						<div class="portfolio-item itemRadi">
							<a class="portfolio-link" data-bs-toggle="modal"
								href="#portfolioModal3">
								<div class="portfolio-hover">
									<div class="portfolio-hover-content">
										<i class="fas fa-plus fa-3x"></i>
									</div>
								</div> <img class="img-fluid"
								src="${path}resources/img/portfolio/3.jpg" alt="..." />
							</a>
							<div class="portfolio-caption">
								<a class="moveToCategorys" href="productList?c=중고차&v=brandNew">
									<div class="portfolio-caption-heading">중고차</div>
									<div class="portfolio-caption-subheading text-muted">Identity</div>
								</a>	
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-sm-6 mb-4 mb-lg-0">
						<!-- Portfolio item 4-->
						<div class="portfolio-item itemRadi">
							<a class="portfolio-link" data-bs-toggle="modal"
								href="#portfolioModal4">
								<div class="portfolio-hover">
									<div class="portfolio-hover-content">
										<i class="fas fa-plus fa-3x"></i>
									</div>
								</div> <img class="img-fluid"
								src="${path}resources/img/portfolio/4.jpg" alt="..." />
							</a>
							<div class="portfolio-caption">
								<a class="moveToCategorys" href="productList?c=가공식품&v=brandNew">
									<div class="portfolio-caption-heading">가공식품</div>
									<div class="portfolio-caption-subheading text-muted">Branding</div>
								</a>	
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-sm-6 mb-4 mb-sm-0">
						<!-- Portfolio item 5-->
						<div class="portfolio-item itemRadi">
							<a class="portfolio-link" data-bs-toggle="modal"
								href="#portfolioModal5">
								<div class="portfolio-hover">
									<div class="portfolio-hover-content">
										<i class="fas fa-plus fa-3x"></i>
									</div>
								</div> <img class="img-fluid"
								src="${path}resources/img/portfolio/5.jpg" alt="..." />
							</a>
							<div class="portfolio-caption">
								<a class="moveToCategorys" href="productList?c=디지털 기기&v=brandNew">
									<div class="portfolio-caption-heading">디지털 기기</div>
									<div class="portfolio-caption-subheading text-muted">Website
									Design</div>
								</a>	
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-sm-6">
						<!-- Portfolio item 6-->
						<div class="portfolio-item itemRadi">
							<a class="portfolio-link" data-bs-toggle="modal"
								href="#portfolioModal6">
								<div class="portfolio-hover">
									<div class="portfolio-hover-content">
										<i class="fas fa-plus fa-3x"></i>
									</div>
								</div> <img class="img-fluid"
								src="${path}resources/img/portfolio/6.jpg" alt="..." />
							</a>
							<div class="portfolio-caption">
								<a class="moveToCategorys" href="productList?c=취미 게임 음반&v=brandNew">
									<div class="portfolio-caption-heading">취미 게임 음반</div>
									<div class="portfolio-caption-subheading text-muted">Photography</div>
								</a>	
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	
		<!-- footer -->
		<div class="row position-relative">
			<div style="background-color: #f5f5dc">
				<img class="position-absolute" style="float: right"
					src="${path}resources/img/well-done-3182_256.gif" alt="sample">
				<footer>
					<div class="container-fluid bg-footer">
						<div class="container">
							<!-- footer menus -->
							<div class="row mt-5">
								<div class="col-md-3">
									<h3>Member</h3>
									<ul class="list-unstyled" style="color: #808080">
										<li> 김예림 </li>
										<li> 김형관</li>
										<li> 윤성혁 </li>
										<li> 한인규 </li>
									</ul>
								</div>
								<div class="col-md-3">
									<h3>Help</h3>
									<ul class="list-unstyled" style="color: #808080">
										<li> Go to a class </li>
										<li> Find an order </li>
										<li> Courses </li>
										<li> Jobs </li>
										<li> Contact us</li>
										<li> About us </li>
									</ul>
								</div>
								<div class="col-md-3">
									<h3>Service</h3>
									<ul class="list-unstyled">
										<li>
											<p style="color: #808080">
												Tel. 031-976-7779 <br>Fax. 031-976-7779<br> 월 - 금 AM 10:00 -
												17:00<br> (점심시간 13:00~14:00)<br> 토.일.공휴일 휴무
											</p>
	
										</li>
									</ul>
								</div>
								<div class="col-md-3">
									<div class="form-group">
										<a class="btn btn-alt btn-block" href="login"> 로그인 </a>
									</div>
									<div class="form-group">
										<a class="btn btn-alt btn-block" href="register"> 회원가입 </a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</footer>
			</div>
		</div>
	
		<!-- 스크롤  -->
		<div id="to-top">
	    	<div class="material-symbols-outlined">arrow_upward</div>
	  	</div>
	</div>
<%@ include file="include/footer.jsp" %>
</body>
<script type="text/javascript">
	const badgeEl = document.querySelector('.badges2');
	const toTopEl = document.querySelector('#to-top');
	
	window.addEventListener('scroll', _.throttle(function(){
	  if(window.scrollY > 500){
	    // 배지 숨기기
	    // gsap.to(요소, 지속시간, 옵션);
	    gsap.to(badgeEl,.6, {
	      opacity: 0,
	      display: 'none'      
	    });
	    // 버튼 보이기
	    gsap.to(toTopEl, .2,{
	      x:0
	    });
	  }else{
	    // 배지 보이기
	    gsap.to(badgeEl,.6, {
	      opacity: 1,
	      display: 'block'
	    });
	
	    // 버튼 숨기기
	    gsap.to(toTopEl, .2,{
	      x:100
	    });
	  }
	},300));
	
	// _.throttle(함수, 시간)
	
	toTopEl.addEventListener('click',function(){
	  gsap.to(window, .1 ,{
	    scrollTo: 0
	  });
	})
</script>
</html>