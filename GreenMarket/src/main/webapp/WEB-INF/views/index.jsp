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

<style type="text/css">
	#main{
		min-height:100vh;
	}
	#categorys{
		width:50vw;
		margin:0px auto;
		text-align:center;
	}
	.moveToCategorys{
		display:inline-block;
		text-decoration:none;
		text-align:center;
		color:black;
		margin:10px 20px;
	}
	.categoryIcon{
		width:45px;
		height:45px;
	}
	.categoryTitle{
		display:inline-block;
		font-size:12px;
		font-weight:bold;
	}
	.moveToCategorys:hover .categoryTitle{
		background-color:darkgreen;
		color:white;
	}
	.radi{
		border-radius: 40px;
		overflow: hidden;
		box-shadow: 4px 4px 10px rgba(0, 0, 0, .15);
		cursor: pointer;
	}
	#imgS{
		width:80%;
		margin:50px auto;
	}
	
	
	/* 광고 배너*/
	.advertising  .badges2 {
		position: absolute;
		top: 132px;
		right:40px;
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
	<div id="main">
		<div id="imgS">
			<div id="carouselExampleDark" class="carousel carousel-dark slide m-5" data-bs-ride="carousel" data-bs-interval="2500">
				<div class="carousel-indicators">
					<button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
					<button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1" aria-label="Slide 2"></button>
					<button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="2" aria-label="Slide 3"></button>
					<button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="3" aria-label="Slide 4"></button>
					<button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="4" aria-label="Slide 5"></button>
				</div>
				<div class="carousel-inner" >
					<div class="carousel-item active">
						<div class="container w-75">
							<img src="${path}resources/img/mainPageImg/1.png" class="d-block w-100 radi" alt="샘플 이미지">
						</div>
					</div>
					<div class="carousel-item">
						<div class="container w-75">
							<img src="${path}resources/img/mainPageImg/2.png" class="d-block w-100 radi" alt="샘플 이미지">
						</div>
					</div>
					<div class="carousel-item">
						<div class="container w-75">
							<img src="${path}resources/img/mainPageImg/3.png" class="d-block w-100 radi" alt="샘플 이미지">
						</div>
					</div>
					<div class="carousel-item">
						<div class="container w-75">
							<img src="${path}resources/img/mainPageImg/4.png" class="d-block w-100 radi" alt="샘플 이미지">
						</div>
					</div>
					<div class="carousel-item">
						<div class="container w-75">
							<img src="${path}resources/img/mainPageImg/5.png" class="d-block w-100 radi" alt="샘플 이미지">
						</div>
					</div>
				</div>
				<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>
		</div>
		<div id="categorys" class="mb-5">
			<c:forEach items="${categoryList}" var="c" varStatus="ci">
				<a class="moveToCategorys" href="productList?c=${c.category}&v=brandNew">
					<img alt="${c.category} 아이콘" src="CategoryImage?fileName=${c.icon}" class="categoryIcon">
					<br>
					<p class="categoryTitle">${c.category}</p>
				</a>
			</c:forEach>
		<div class="advertising ">
			<div class="badges2">
		      <div class="badge2">
		        <a href="https://www.starbucks.co.kr/index.do" target='_blank'><img src="${path}resources/img/badge3.jpg" alt="Badge"></a> 
		      </div>
		      <div class="badge2">
		        <a href="https://suwon.greenart.co.kr/" target='_blank'><img src="https://greened.co.kr/assets/_img/header/new23_headerlogo0.svg?3" alt="Badge"></a> 
		      </div>
		    </div>
		</div>
	</div>
	<!-- navigation -->
        <nav class="navbar navbar-default">
            <div class="container">
                <div class="navbar-header">
                    <a class="navbar-brand" href="">
                        <img alt="" src="">
                    </a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li>
                            <a class="" href="">
                                <i class="fa fa-home" aria-hidden="true"></i>
                                Home
                            </a>
                        </li>
                        <li>
                            <a class="" href="">
                                <i class="fa fa-certificate"></i>
                                Courses
                            </a>
                        </li>
                        <li>
                            <a class="" href="">
                                <i class="fa fa-lightbulb-o"></i>
                                Our Method
                            </a>
                        </li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a class="sign-in" href="">
                                Dashboard
                                <i class="fa fa-tachometer"></i>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- end navigation -->

        <!-- main content -->
        <main>

        </main>
        <!-- end main content -->

        <!-- footer -->
        <footer class="footer">
            <div class="container-fluid bg-footer">
                <div class="container">

                    <!-- footer menus -->
                    <div class="row">
                        <div class="col-md-3">
                            <h3>About</h3>

                        </div>
                        <div class="col-md-3">
                            <h3>Help</h3>
                            <ul class="list-unstyled">
                                <li>
                                    <a href="">
                                        Go to a class
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        Find an order
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        Courses
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        Jobs
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        Contact us
                                    </a>
                                </li>
                                <li>
                                    <a href="">
                                        About us
                                    </a>
                                </li>
                            </ul>
                        </div>
                        <div class="col-md-3">
                            <h3>Social</h3>
                            <ul class="list-unstyled">
                                <li>
                                    <h3>
                                        <i class="fa fa-facebook" aria-hidden="true"></i>
                                    </h3>
                                </li>
                                <li>
                                    <h3>
                                        <i class="fa fa-twitter" aria-hidden="true"></i>
                                    </h3>
                                </li>
                                <li>
                                    <h3>
                                        <i class="fa fa-vk" aria-hidden="true"></i>
                                    </h3>
                                </li>
                            </ul>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <a class="btn btn-alt btn-block" href="">
                                    Student Login
                                </a>
                            </div>
                            <div class="form-group">
                                <a class="btn btn-alt btn-block" href="">
                                    Teacher Login
                                </a>
                            </div>
                        </div>
                    </div>
                    <!-- end footer menus -->


                    <!-- footer subtext -->
                    <!-- end footer subtext -->

                </div>
            </div>

            <!-- end sub footer -->

        </footer>
        <!-- end footer -->
	
	<%@ include file="include/footer.jsp" %>
</body>
</html>