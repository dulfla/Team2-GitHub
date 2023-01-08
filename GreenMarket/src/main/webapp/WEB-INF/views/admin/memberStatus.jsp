<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 현황</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

<script src="${path}resources/script/chat/chattingRoom.js"></script>
<script src="${path}resources/script//.js"></script>
<link rel="stylesheet" href="${path}resources/style/basicStryle.css">
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<div id="container">
		<div class="main">
		    <div class="chart-container" style="position: relative; height:40vh; width:80vw">
		        <canvas id="chart1"></canvas>
		    </div>
		</div>    
	</div>
	</div>
	<%@ include file="../include/footer.jsp" %>
	<script>
		const json = ${memberAdmin};
		console.log(json);
		
		let dateArr = [];
		let countArr = []
		for(let i=0; i<json["count"][0]["leftMemberAdmin"].length; i++){
			dateArr.push(json["count"][0]["leftMemberAdmin"][i]["date"]);
			countArr.push(json["count"][0]["leftMemberAdmin"][i]["count"]);
		}
		
		   var ctx = document.getElementById('chart1').getContext('2d');
		   var chart = new Chart(ctx, {
		       type: 'line',
		       data: {
		           labels: dateArr,
		           datasets: [{
		               label: '누적 회원수',
		               tension: 0.5,
		           	pointStyle: 'circle',
		           	fill: false,
		               backgroundColor: 'rgba(255, 99, 132, 0.5)',
		               borderColor: 'rgb(255, 99, 132,1.5)',
		               data: countArr
		           }]
		       },
		
		       // Configuration options go here
		       options: {
		           title: {
		               display: true,
		               text: '★가입일자별 현재 회원수★',
		               fontSize: 30,
		               fontColor: 'rgba(46, 49, 49, 1)'
		           },
		           legend: {
		               labels: {
		                   fontColor: 'rgba(83, 51, 237, 1)',
		                   fontSize: 15
		               }
		           },
		           scales: {
		               xAxes: [{
		                   ticks: {
		                       fontColor: 'rgba(27, 163, 156, 1)',
		                       fontSize: '15'
		                   }
		               }],
		               yAxes: [{
		                   ticks: {
		                       beginAtZero: true,
		                       fontColor: 'rgba(246, 36, 89, 1)',
		                       fontSize: '15'
		                   }
		               }]
		           }
		       }
		   });
	</script>
</body>
</html>