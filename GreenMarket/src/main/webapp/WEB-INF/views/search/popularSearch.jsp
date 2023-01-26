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
	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-6 text-center mb-5">
					<h2 class="heading-section">인기 검색어</h2>
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
	</section>
	
	<%-- <c:forEach begin="0" end="9" items="${list}" var="list">
	  	<li><a href="search?c=all&v=product&keyword=모자">${list.keyword}</a></li>
	  </c:forEach> --%>
</body>
<jsp:include page="../include/footer.jsp"/>
</html>