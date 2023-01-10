<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고 상품 현황</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

<script src="${path}resources/script//.js"></script>
<link rel="stylesheet" href="${path}resources/style/basicStryle.css">
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<div id="container">
		<div class="chart-container" style="position: relative; height:40vh; width:80vw">
	        <canvas id="productTrade"></canvas>
	    </div>
	    <div class="chart-container" style="position: relative; height:40vh; width:80vw">
	        <canvas id="productCategory"></canvas>
	    </div>
	</div>
	<%@ include file="../include/footer.jsp" %>
	<script>
		const json = ${productAdmin};
		console.log(json)
		
		let productTradeCet = document.getElementById('productTrade').getContext('2d');
		let productTrade = new Chart(productTradeCet, {
	        type: 'doughnut',
	        data: {
	            labels: json["productAdmin"][0]["productAdminType"][0]["type"],
	            datasets: [
	                {
	                    label: '',
	                    fill: false,
	                    data: json["productAdmin"][0]["productAdminType"][1]["data"],
	                    backgroundColor: [
	                    	'rgba(192, 97, 255, 0.5)',
	                    	'rgba(255, 99, 132, 0.5)',
	                    	'rgba(255, 10, 10, 0.5)'
	                    ],
	                    borderWidth: 1
	                } 
	            ]
	        },
	        options: {
	        	legend: {
					position:'right'
				},
				title: {
					display: true,
					text: '전체 상품 등록 대비 상품 현황',
					fontSize: 40
				}
	        }
	    });
		
		let productCategoryCet = document.getElementById('productCategory').getContext('2d');
		let productCategory = new Chart(productCategoryCet, {
	        type: 'bar',
	        data: {
	            labels: json["productAdmin"][1]["productAdminCategory"][1]["category"],
	            datasets: [
	                {
	                    label: '누적 등록 상품수',
	                    fill: false,
	                    data: json["productAdmin"][1]["productAdminCategory"][2]["data"][0],
	                    backgroundColor: 'rgba(97, 255, 173, 0.5)',
	                    borderWidth: 1
	                },
	                {
	                    label: '거래된 상품수',
	                    fill: false,
	                    data: json["productAdmin"][1]["productAdminCategory"][2]["data"][1],
	                    backgroundColor: 'rgba(97, 252, 255, 0.5)',
	                    borderWidth: 1
	                },
	                {
	                    label: '미거래 삭제 상품수',
	                    fill: false,
	                    data: json["productAdmin"][1]["productAdminCategory"][2]["data"][2],
	                    backgroundColor: 'rgba(97, 192, 255, 0.5)',
	                    borderWidth: 1
	                } 
	            ]
	        },
	        options: {
	        	legend: {
					position:'right'
				},
				title: {
					display: true,
					text: '전체 상품 등록 대비 상품 현황',
					fontSize: 40
				}
	        }
	    });
	</script>
</body>
</html>