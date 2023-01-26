<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>그린 마켓</title>
<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
	crossorigin="anonymous">
</script>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.3.js"
	integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM=" crossorigin="anonymous">
</script>



<style type="text/css">
	thead{
		background-color: #BFCF5B


	}
</style>
<jsp:include page="../include/header.jsp"/>
</head>
<body>
	<%-- <section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
					<h2 class="heading-section">오늘의 인기 검색어</h2>
				</div>
			</div>
			<div class="row justify-content-center">
				<div class="col-md-6">
					<div class="table-wrap">
						<table class="table p-6">
							<thead class="thead thead-primary">
								<tr>
									<th>#</th>
									<th>검색어</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach begin="0" end="9" items="${list}" var="list" varStatus="status">
									<tr>
										<th scope="row">${status.count}</th>
										<td><a href="search?c=all&v=product&keyword=${list.keyword}">${list.keyword}</a></td> 
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section> --%>
	<div class="limiter">
<div class="container-table100">
<div class="wrap-table100">
<div class="table">
<div class="row header">
<div class="cell">
Full Name
</div>
<div class="cell">
Age
</div>
<div class="cell">
Job Title
</div>
<div class="cell">
Location
</div>
</div>
<div class="row">
<div class="cell" data-title="Full Name">
Vincent Williamson
</div>
<div class="cell" data-title="Age">
31
</div>
<div class="cell" data-title="Job Title">
iOS Developer
</div>
<div class="cell" data-title="Location">
Washington
</div>
</div>
<div class="row">
<div class="cell" data-title="Full Name">
Joseph Smith
</div>
<div class="cell" data-title="Age">
27
</div>
<div class="cell" data-title="Job Title">
Project Manager
</div>
<div class="cell" data-title="Location">
Somerville, MA
</div>
</div>
<div class="row">
<div class="cell" data-title="Full Name">
Justin Black
</div>
<div class="cell" data-title="Age">
26
</div>
<div class="cell" data-title="Job Title">
Front-End Developer
</div>
<div class="cell" data-title="Location">
Los Angeles
</div>
</div>
<div class="row">
<div class="cell" data-title="Full Name">
Sean Guzman
</div>
<div class="cell" data-title="Age">
25
</div>
<div class="cell" data-title="Job Title">
Web Designer
</div>
<div class="cell" data-title="Location">
San Francisco
</div>
</div>
<div class="row">
<div class="cell" data-title="Full Name">
Keith Carter
</div>
<div class="cell" data-title="Age">
20
</div>
<div class="cell" data-title="Job Title">
Graphic Designer
</div>
<div class="cell" data-title="Location">
New York, NY
</div>
</div>
<div class="row">
<div class="cell" data-title="Full Name">
Austin Medina
</div>
 <div class="cell" data-title="Age">
32
</div>
<div class="cell" data-title="Job Title">
Photographer
</div>
<div class="cell" data-title="Location">
New York
</div>
</div>
<div class="row">
<div class="cell" data-title="Full Name">
Vincent Williamson
</div>
<div class="cell" data-title="Age">
31
</div>
<div class="cell" data-title="Job Title">
iOS Developer
</div>
<div class="cell" data-title="Location">
Washington
</div>
</div>
<div class="row">
<div class="cell" data-title="Full Name">
Joseph Smith
</div>
<div class="cell" data-title="Age">
27
</div>
<div class="cell" data-title="Job Title">
Project Manager
</div>
<div class="cell" data-title="Location">
Somerville, MA
</div>
</div>
</div>
</div>
</div>
</div>
	
</body>
<jsp:include page="../include/footer.jsp"/>
</html>