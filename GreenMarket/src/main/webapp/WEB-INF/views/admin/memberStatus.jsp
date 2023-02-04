<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린 마켓</title>
<link rel="icon" href="${path}resources/img/icon.png">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

<style type="text/css">
	#container{
		min-height: 100vh;
	}
</style>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
 	<div id="container">
 		<div id="carouselExampleControlsNoTouching" class="position-relative carousel carousel-dark slide mt-5 mb-5" data-bs-touch="false" data-bs-interval="false">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<div class="container w-75 chart-container">
						<canvas id="memberAdminByYear"></canvas>
					</div>
				</div>
				<div class="carousel-item">
					<div class="container w-75 chart-container">
						<canvas id="withdrawByYear"></canvas>
					</div>
				</div>
				<div class="carousel-item">
					<div class="container w-75 chart-container position-relative">
						<select class="form-select text-center position-absolute top-0 end-0 m-3" id="selectYear_memberAdminByMonth" style="width:15%">
				    		<option value="default">==선택==</option>
				    		<c:forEach items="${memberAdmin['memberAdmin'][0]['countByYear'][0]['years']}" var="year" varStatus="c">
					    		<option value="${c.index}">${year}</option>
				    		</c:forEach>
				    	</select>
				        <canvas id="memberAdminByMonth"></canvas>
					</div>
				</div>
			</div>
			<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControlsNoTouching" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControlsNoTouching" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
	</div>
	<%@ include file="../include/footer.jsp" %>
	<script>
		const json = ${memberAdmin};
				
		let memberAdminByYearCet = document.getElementById('memberAdminByYear').getContext('2d');
		let memberAdminByYear = new Chart(memberAdminByYearCet, {
			type: 'bar',
			data:{
	            labels: json["memberAdmin"][0]["countByYear"][0]["years"],
	            datasets: [
	                {
	                    label: '누적 회원수',
	                    yAxisID: 'total',
	                    type: 'line',
	                    fill: false,
	                    tension: 0,
	                    data: json["memberAdmin"][0]["countByYear"][2]["data"][0],
	                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
	                    borderColor: 'rgba(255, 99, 132, 1)',
	                    borderWidth: 1
	                },
	                {
	                    label: '년도별 신규 가입자',
	                    yAxisID: 'year',
	                    type: 'bar',
	                    data: json["memberAdmin"][0]["countByYear"][2]["data"][1],
	                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
	                    borderColor: 'rgba(54, 162, 235, 1)',
	                    borderWidth: 1
	                },
	                {
	                    label: '년도별 탈퇴자',
	                    yAxisID: 'year',
	                    type: 'bar',
	                    data: json["memberAdmin"][0]["countByYear"][2]["data"][2],
	                    backgroundColor: 'rgba(122, 245, 212, 0.2)',
	                    borderColor: 'rgba(122, 245, 212, 1)',
	                    borderWidth: 1
	                }
	            ]
			},
	        options: {
	        	scales: {
	                yAxes: [{
	                	id: 'total',
	                    title: {
   							display: true,
   							text: '누적 회원수'
   	                    },
	                    type: 'linear',
	                    position: 'left',
	                    ticks: {
	                      fontColor: '#ffbaa2'
	                    },
	                    afterDataLimits: (scale) => {
	                        scale.max = scale.max * 1.05;
	                    }},{
   	                	id: 'year',
   	                    title: {
   							display: true,
   							text: '년도별 가입/탈퇴 수'
   	                    },
   	                    position: 'right',
   	                 	ticks: {
		                    fontColor: '#7aabf5'
	                    },
	                    afterDataLimits: (scale) => {
	                        scale.max = scale.max * 1.05;
	                    }
                   }]
	            },
	        	responsive: true,
	        	legend: {
					position:'top',
					labels:{
        				boxWidth:7,
        				usePointStyle: true
        			}
				},
	        	title: {
					display: true,
					text: '회원수 추이',
					fontSize: 30
				}
	        }
	    });
		
		let withdrawByYearCet = document.getElementById('withdrawByYear').getContext('2d');
		let withdrawByYear = new Chart(withdrawByYearCet, {
	        type: 'doughnut',
	        data: {
	            labels: json["memberAdmin"][0]["countByYear"][0]["years"],
	            datasets: [
	                {
	                    label: '년도별 탈퇴 회원',
	                    fill: false,
	                    data: json["memberAdmin"][0]["countByYear"][2]["data"][2],
	                    backgroundColor: colorSet(0.2),
	                    borderWidth: 1
	                } 
	            ]
	        },
	        options: {
	        	legend: {
					position:'right',
					labels:{
        				boxWidth:7,
        				usePointStyle: true
        			}
				},
				title: {
					display: true,
					text: '년도별 탈퇴 회원 비율',
					fontSize: 30
				}
	        }
	    });
		
		function colorSet(transparency) {
			let colors = [];
			for(let i=0; i<json["memberAdmin"][0]["countByYear"][0]["years"].length; i++){
				colors.push('rgba('+Math.floor(Math.random()*225)+', '+Math.floor(Math.random()*225)+', '+Math.floor(Math.random()*225)+', '+transparency+')');
			}
			return colors;
		}
		
		let memberAdminByMonthCet = document.getElementById('memberAdminByMonth').getContext('2d');
		let years = json["memberAdmin"][1]["withdrawMonths"][0]["years"];
		let datas = json["memberAdmin"][1]["withdrawMonths"][2]["data"];
		let memberAdminByMonth = new Chart(memberAdminByMonthCet, {
	        type: 'bar',
	        data: {
	            labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	            datasets: [
	                {
	                    label: '가입자수',
	                    fill: false,
	                    data: datas[0][datas[0].length-1],
	                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
	                    borderColor: 'rgba(75, 192, 192, 1)',
	                    borderWidth: 1
	                } ,
	                {
	                    label: '탈퇴자수',
	                    fill: false,
	                    data: datas[1][datas[0].length-1],
	                    backgroundColor: 'rgba(153, 102, 255, 0.2)',
	                    borderColor: 'rgba(153, 102, 255, 1)',
	                    borderWidth: 1
	                }
	            ]
	        },
	        options: {
	        	scales: {
	                yAxes: [{
                        ticks: {
                            beginAtZero: true
                        },
                        afterDataLimits: (scale) => {
	                        scale.max = scale.max * 1.05;
	                    }
                    }]
	            },
	        	responsive: true,
	        	legend: {
					position:'top',
					labels:{
        				boxWidth:10
        			}
				},
	        	title: {
					display: true,
					text: years[datas[0].length-1]+'년 월별 회원 가입/탈퇴',
					fontSize: 30
				}
	        }
	    });
		
		window.onload = function yearSelect() {
			let selects = document.getElementById('selectYear_memberAdminByMonth');
			selects.addEventListener('change', function(){
				let selectVu;
				if(selects.value=='default'){
					selectVu = datas[0].length-1;
				}else{
					selectVu = selects.value;
				}
				yearOptionChange(selectVu);
			}, false);
		}
		
		function yearOptionChange(arrNum) {
			memberAdminByMonth.data.datasets[0].data = datas[0][arrNum];
			memberAdminByMonth.data.datasets[1].data = datas[1][arrNum];
			memberAdminByMonth.options.title.text = years[arrNum]+'년 월별 회원 가입/탈퇴';
			memberAdminByMonth.update();
		}
	</script>
</body>
</html>