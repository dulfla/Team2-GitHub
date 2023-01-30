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

@font-face {
  font-family: "hana";
  src: url("${path}resources/fonts/BMJUA_ttf.ttf");
}

@import 'https://fonts.googleapis.com/css?family=Open+Sans:600,700';

h2{
	font-family: hana;
}

.rwd-table {
	margin: auto;
	min-width: 300px;
	max-width: 100%;
	border-collapse: collapse;
}

.rwd-table tr:first-child {
	border-top: none;
	background-color: #9acd32;
	/*  background: #428bca; */
	color: white;
	font-size: 21px;
}

.rwd-table tr {
	border-top: 1px solid #f9f9f9; 
	border-bottom: 1px solid #f9f9f9; 
	background-color:;
}

.rwd-table tr:nth-child(odd):not(:first-child) {
	background-color:;
}

.rwd-table th {
	display: none;
}

.rwd-table td {
	display: block;
}

.rwd-table td:first-child {
	margin-top: .5em;
}

.rwd-table td:last-child {
	margin-bottom: .5em;
}

.rwd-table td:before {
	content: attr(data-th) ": ";
	font-weight: bold;
	width: 120px;
	display: inline-block;
	color: #000;
}

.rwd-table th, .rwd-table td {
	text-align: left;
}

.rwd-table {
	color: #333;
	border-radius: .4em;
	overflow: hidden;
}

.rwd-table tr {
	border-color: #bfbfbf;
}

.rwd-table th, .rwd-table td {
	padding: .5em 1em;
}

@media screen and (max-width: 601px) {
	.rwd-table tr:nth-child(2) {
		border-top: none;
	}
}

@media screen and (min-width: 600px) {
	.rwd-table tr:hover:not(:first-child) {
		background-color: #d8e7f3;
	}
	.rwd-table td:before {
		display: none;
	}
	.rwd-table th, .rwd-table td {
		display: table-cell;
		padding: .25em .5em;
	}
	.rwd-table th:first-child, .rwd-table td:first-child {
		padding-left: 0;
	}
	.rwd-table th:last-child, .rwd-table td:last-child {
		padding-right: 0;
	}
	.rwd-table th, .rwd-table td {
		padding: 1em !important;
	}
}

/* THE END OF THE IMPORTANT STUFF */

/* Basic Styling */
h1 {
	text-align: center;
	font-size: 2.4em;
}

.container {
	display: block;
	text-align: center;
}

h3 {
	display: inline-block;
	position: relative;
	text-align: center;
	font-size: 1.5em;
	color: #cecece;
}

h3:before {
	content: "\25C0";
	position: absolute;
	left: -50px;
	-webkit-animation: leftRight 2s linear infinite;
	animation: leftRight 2s linear infinite;
}

h3:after {
	content: "\25b6";
	position: absolute;
	right: -50px;
	-webkit-animation: leftRight 2s linear infinite reverse;
	animation: leftRight 2s linear infinite reverse;
}

@
-webkit-keyframes leftRight { 0% {
	-webkit-transform: translateX(0)
}

25
%
{
-webkit-transform
:
translateX(
-10px
)
}
75
%
{
-webkit-transform
:
translateX(
10px
)
}
100
%
{
-webkit-transform
:
translateX(
0
)
}
}
@
keyframes leftRight { 0% {
	transform: translateX(0)
}

25
%
{
transform
:
translateX(
-10px
)
}
75
%
{
transform
:
translateX(
10px
)
}
100
%
{
transform
:
translateX(
0
)
}
}
a {
	text-decoration: none;
	color: black;
}

.tbody {
	font-family: "hana"; 
	font-size: 18px;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	border-radius: 10px;
	-webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	-moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
	box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
}
</style>

<jsp:include page="../include/header.jsp"/>
</head>
<body>
	<div class="container">
		<h2 class="mb-4 mt-4">오늘의 중고 인기 검색어</h2>
		  <table class="rwd-table col-4 tbody">
		    <tbody>
		      <tr>
		        <th>#</th>
		        <th>인기 검색어</th>
		      </tr>
				<c:forEach begin="0" end="9" items="${list}" var="list"
					varStatus="status">
					<tr>
						<c:choose>
							<c:when test="${status.count lt 4}">
								<th id="count" scope="row" style="color:#ff5232">${status.count}</th>
								<td><a style="color: #ff5232" href="search?c=all&v=product&keyword=${list.keyword}">${list.keyword}</a></td>
							</c:when>
							<c:otherwise>
								<th id="count" scope="row">${status.count}</th>
								<td><a href="search?c=all&v=product&keyword=${list.keyword}">${list.keyword}</a></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
		  </table>
		  <h3 class="mb-5 mt-3">Resize Me</h3>
	</div>
</body>
<script type="text/javascript"></script>
<jsp:include page="../include/footer.jsp"/>
</html>