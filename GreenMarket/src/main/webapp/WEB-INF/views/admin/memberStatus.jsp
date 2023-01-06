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
        <canvas id="test1"></canvas>
    </div>
        <script>
            var ctx = document.getElementById('test1').getContext('2d');
            var chart = new Chart(ctx, {
                // The type of chart we want to create
                type: 'bar',

                // The data for our dataset
                data: {
                    labels: ['7월', '8월', '9월', '10월', '11월', '12월'],
                    datasets: [{
                        label: '티스토리 블로그 희망 방문자 수',
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.5)',
                            'rgba(54, 162, 235, 0.5)',
                            'rgba(255, 206, 86, 0.5)',
                            'rgba(75, 192, 192, 0.5)',
                            'rgba(153, 102, 255, 0.5)',
                            'rgba(255, 159, 64, 0.5)'],
                        borderColor: ['rgb(255, 99, 132,1.5)',
                            'rgba(54, 162, 235, 1.5)',
                            'rgba(255, 206, 86, 1.5)',
                            'rgba(75, 192, 192, 1.5)',
                            'rgba(153, 102, 255, 1.5)',
                            'rgba(255, 159, 64, 1.5)'],
                        data: [1000, 1600, 2700, 3400, 4900, 6000]
                    }]
                },

                // Configuration options go here
                options: {
                    title: {
                        display: true,
                        text: '★방문해 주셔서 감사합니다★',
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
    </div>    
</div>
	</div>
	<%@ include file="../include/footer.jsp" %>
</body>
</html>