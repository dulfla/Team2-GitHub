<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>그린 마켓</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<!-- <script src="https://code.jquery.com/jquery-3.6.0.js" crossorigin="anonymous"></script> -->
<script
src="https://code.jquery.com/jquery-3.6.3.js"
integrity="sha256-nQLuAZGRRcILA+6dMBOvcRh5Pe310sBpanc6+QBmyVM="
crossorigin="anonymous"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	490ef0680625aa2086d3bf61d038acea"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-steps/1.1.0/jquery.steps.min.js"></script>
 <%--  <link href="${path}resources/style/productreg.css" rel="stylesheet" type="text/css"> --%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
  
<style type="text/css">
	#result_card img{
 		max-width: 100%; 
	    height: 400px; 
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
	#result_card {
		position: relative;
		width:100%
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
		<div class=" text-center mt-5 ">
	    <h1 >상품 등록</h1>                   
	    </div>
	    <div class="row ">
	    <div class="col-lg-7 mx-auto">
	            <div class="card mt-2 mx-auto p-4 bg-light">
	                <div class="card-body bg-light">
	                    <div class = "container">
	                        <form id="contact-form" role="form" method="POST" autocomplete="off" enctype="multipart/form-data">
	                        	<input type="hidden" name="email" value="${authInfo.email}">
	                        	<input type="hidden" name="p_id" value="${product.p_id}">
	                        	<input type="hidden" id="lat" name="lat" value="${product.lat}">
	                        	<input type="hidden" id="lng" name="lng" value="${product.lng}">
	                            <div class="controls">
	                                <div class="row">
	                                    <div class="col-md-12">
	                                        <div class="form-group">
	                                            <label for="form_name">상품명</label>
	                                            <input id="form_name" type="text" name="p_name" class="form-control" placeholder="상품명을 입력해주세요 *" required data-error="상품명은 필수입력입니다.">                        
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="row">
	                                    <div class="col-md-6">
	                                        <div class="form-group">
	                                            <label for="form_lastname">상품 가격</label>
	                                            <input id="form_lastname" type="text" id="price" name="price" class="form-control" placeholder="가격을 입력해주세요  *" oninput="checkPwd()" required>
	                                        </div>
	                                    </div>
	                                    <div class="col-md-6">
	                                        <div class="form-group">
	                                            <label for="form_need">카테고리</label>
	                                            <select id="form_need" name="category" class="form-control" required="required" data-error="카테고리는 필수 입력입니다.">
	                                                <option value="" selected disabled>-카테고리를 골라주세요-</option>
	                                                <c:forEach items="${category}" var="cate"><option value="${cate.category}">${cate.category}</option></c:forEach>
	                                            </select>          
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="row">
	                                    <div class="col-md-12">
	                                        <div class="form-group">
	                                            <label for="form_message">상품 정보</label>
	                                            <textarea id="form_message" name="description" class="form-control" placeholder="상품 정보를 입력해주세요 *" rows="4" required data-error="상품 정보는 필수입력입니다."></textarea>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="form_message" style="margin-top : 20px">사진 업로드</label>
                                            <input type="file" id="fileItem" name='uploadFile' multiple>
                                            <div id="uploadResult"></div> 
                                            
                                        </div>                          
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="form_message" style="margin-top : 20px">거래 위치</label>
                                            <div id="map" style="width:100%;height:400px;"></div>
                                                <p><em>지도를 클릭해주세요!</em></p>    
                                            <div id="clickLatlng"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <button type="submit" class="btn btn-success btn-send  pt-2 btn-block">상품 등록</button> 
                                        <button type="button" class="btn btn-danger btn-send  pt-2 btn-block">목록</button>
                                    </div>
                                </div>
                            </form> 
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
					
			var lat = latlng.getLat();
			var lng = latlng.getLng();
			
			console.log('위도 : ' + lat);
			console.log('경도 : ' + lng);
			
			$("#lat").val(lat);
			$("#lng").val(lng);
		});	


		$("input[type='file']").on("change", function(e){
					
			/* 등록된 이미지 존재시 삭제 */
			if($(".imgDeleteBtn").length > 0){
					deleteFile();
			}
				
			let formData = new FormData();
			let fileInput = $('input[name="uploadFile"]');
			let fileList = fileInput[0].files;
			let fileObj = fileList[0];
		
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
		let maxSize = 10485760; //10MB	
			
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
		
		function checkPwd() {
			var objEv = event.srcElement;
			var numPattern = /([^0-9])/;
			var numPattern = objEv.value.match(numPattern);
			if (numPattern != null) {
				Swal.fire({
				      icon: 'error',
				      title: '상품 가격은 숫자만 입력해주세요',
				      text: '',
				});
				objEv.value = "";
				objEv.focus();
				return false;
			}
		}
	</script>
</body>
</html>