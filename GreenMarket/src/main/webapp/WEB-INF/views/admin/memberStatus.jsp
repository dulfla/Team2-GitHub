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

<script src="${path}resources/script//.js"></script>
<link rel="stylesheet" href="${path}resources/style/basicStryle.css">
<style type="text/css">
	#container{
		position: relative;
	}
	.index{
		width:25vw;
		font-size:0.4vw;
		padding: 20px 10px;
		border-top-left-radius: 15px;
		border-top-right-radius: 15px;
		border:1px solid black;
		border-bottom:none;
	}
	#first{
		
	}
	#second{
		position: absolute;
		
		
	}
	#third{
		
	}
	.page{
		width:100%;
		position: absolute;
		top: 0;
	}
	.data{
		border: 1px solid black;
		border-radius: 15px;
	}
	#first 
</style>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
 	<div id="container" class="container position-relative">
 		<div class="position-relative row align-items-center">
 			<div class="chart-container col-xl-8">
		        <canvas id="realTimeMemberAdmin"></canvas>
		    </div>
		    <div class="chart-container col-xl-4">
		        <canvas id="memberAdminByYear"></canvas>
		    </div>
 		</div>
 		<div class="position-relative row  align-items-center">
		    <div class="chart-container col-xl-4">
		        <canvas id="withdrawByYear"></canvas>
		    </div>
		    <div class="chart-container col-xl-8 position-relative">
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
	                    tension: 1,
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
					text: years[datas[0].length-1]+'년 월별 회원수 추이',
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