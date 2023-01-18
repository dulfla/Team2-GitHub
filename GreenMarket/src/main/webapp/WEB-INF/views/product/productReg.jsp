<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<!-- <script src="https://code.jquery.com/jquery-3.6.0.js" crossorigin="anonymous"></script> -->
<script
  src="https://code.jquery.com/jquery-3.6.3.js"
  integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
  crossorigin="anonymous"></script>
  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	490ef0680625aa2086d3bf61d038acea"></script>
  
<style type="text/css">
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
	#result_card {
		position: relative;
	}
	.imgDeleteBtn{
	    position: absolute;
	    top: 0;
	    right: 5%;
	    background-color: #ef7d7d;
	    color: wheat;
	    font-weight: 900;
	    width: 30px;
	    height: 30px;
	    border-radius: 50%;
	    line-height: 26px;
	    text-align: center;
	    border: none;
	    display: block;
	    cursor: pointer;	
	}	
</style>

</head>
<body>

	<%@ include file="../include/header.jsp" %>
	<div id="container">
		<form action="" id="regForm" method="POST" autocomplete="off" enctype="multipart/form-data">
			<span class="contact100-form-title">
				상품 등록
			</span>
			<div>
				<span>카테고리</span>
				<select class="category" name="category">
					<option value="null">선택</option>
					<c:forEach items="${category}" var="cate"><option value="${cate.category}">${cate.category}</option></c:forEach>
				</select>
			</div>
			<label class="label-input100" for="email">상품명</label>
			<div class="wrap-input100 validate-input">
				<input type="text" class="input100" name="p_name" placeholder="상품명을 입력해주세요">
			<span class="focus-input100"></span>	
			</div>
			<div>
			<input type="text" name="price" placeholder="상품가격">
			</div>
			<div>
				<label>사진 업로드</label>
				<input type="file" id="fileItem" name='uploadFile' style="height: 30px;">
					<div id="uploadResult">
					</div>
			</div>
			<label class="label-input100" for="message">상품 정보</label>
			<div class="wrap-input100 validate-input">
				<textarea id="message" class="input100" name="description" placeholder="상품 정보를 입력해주세요"></textarea>
				<span class="focus-input100"></span>
			</div>
			<div class="inputArea">
	            <div class="inputArea_title">
		            <label>거래 희망 위치</label>
		        </div>
				<div id="map" style="width:350px;height:350px;"></div>
					<p><em>지도를 클릭해주세요!</em></p> 
				<div id="clickLatlng"></div>
			</div>
			<button>상품등록</button>
			<button type="button">목록</button>
		</form>
				
	</div>
	<%@ include file="../include/footer.jsp" %>
	
	<script type="text/javascript">
	
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(37.267868108956456, 127.00053552238002), // 지도의 중심좌표
	        level: 5 // 지도의 확대 레벨
	    };
	
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		// 지도를 클릭한 위치에 표출할 마커입니다
		var marker = new kakao.maps.Marker({ 
		    // 지도 중심좌표에 마커를 생성합니다 
		    position: map.getCenter() 
		}); 
		// 지도에 마커를 표시합니다
		marker.setMap(map);
		
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    var latlng = mouseEvent.latLng; 
		    
		    // 마커 위치를 클릭한 위치로 옮깁니다
		    marker.setPosition(latlng);
		    
		    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
		    message += '경도는 ' + latlng.getLng() + ' 입니다';
		    
		    var resultDiv = document.getElementById('clickLatlng'); 
		    resultDiv.innerHTML = message;
		    
		});
	
	
/* =============================================================================================== */
	
		$("input[type='file']").on("change", function(e){
			
			/* 등록된 이미지 존재시 삭제 */
			if($(".imgDeleteBtn").length > 0){
				deleteFile();
			}
			
			let formData = new FormData();
			let fileInput = $('input[name="uploadFile"]');
			let fileList = fileInput[0].files;
			let fileObj = fileList[0];
			
			/*
			if(!fileCheck(fileObj.name, fileObj.size)){
				return false;
			} 
			*/
			// 사용자가 선택한 파일을 FormData에 "uploadFile"이란 이름(key)으로 추가해주는 코드
			for(let i = 0; i < fileList.length; i++){
				formData.append("uploadFile", fileList[i]);
			}
			$.ajax({
				url: 'uploadAjaxAction',
		    	processData : false,
		    	contentType : false,
		    	data : formData,
		    	type : 'POST',
		    	dataType : 'json',
		    	success : function(result){
		    		console.log(result);
		    		showUploadImage(result);
		    	},
		    	error : function(result){
		    		alert("이미지 파일이 아닙니다.");
		    	}
			});	
		});
		
		let regex = new RegExp("(.*?)\.(jpg|png)$");
		let maxSize = 1048576; //1MB	
		
		function fileCheck(fileName, fileSize){

			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
				  
			if(!regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}			
			return true;					
		}
		/* 이미지 출력 */
		function showUploadImage(uploadResultArr){
			
			/* 전달받은 데이터 검증 */
			if(!uploadResultArr || uploadResultArr.length == 0){return}
			
			let uploadResult = $("#uploadResult");
			
			let obj = uploadResultArr[0];
			
			let str = "";
			
			let fileCallPath = obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName;
			
			str += "<div id='result_card'>";
			str += "<img src='display?fileName=" + fileCallPath +"'>";
			str += "<div class='imgDeleteBtn' data-file='"+ fileCallPath +"'>x</div>";
			str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
			str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
			str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";
			str += "</div>";		
			
	   		uploadResult.append(str); 
		}
		/* 이미지 삭제 버튼  동작 */
		$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
			
			deleteFile();
			
		});
		
		
		/* 파일 삭제 메서드 */
		function deleteFile(){
			let targetFile = $(".imgDeleteBtn").data("file");
			
			let targetDiv = $("#result_card");
			
			$.ajax({
				url: 'deleteFile',
				data : {fileName : targetFile},
				dataType : 'text',
				type : 'POST',
				success : function(result){
					console.log(result);
					
					targetDiv.remove();
					$("input[type='file']").val("");
				},
				error : function(result){
					console.log(result);
					
					alert("파일 삭제 실패")
				}
	       });
		}
	</script>
</body>
</html>