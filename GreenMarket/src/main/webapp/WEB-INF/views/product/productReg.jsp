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

	#titleGroup a{
		position: absolute;
	    right: 1rem;
	    font-size: 1rem;
	    color: rgb(155, 153, 169);
	    text-decoration: underline;	
	    cursor: pointer;
	}
	textarea {
		height: 20rem;
	}
	#descriptionForm {
		padding-bottom: 2rem;
	}
	#imageForm {
		width: 100%;
	    display: flex;
	    padding: 2rem 0px;
	    border-top: 1px solid rgb(220, 219, 228);
	    border-bottom: 1px solid rgb(220, 219, 228);
	    margin-left: 12.5px;
	}
	#uploud-group{
		display: flex;
	    width: 1006px;
	    overflow-x: hidden;
	    flex-wrap: wrap;
	}

	.uploadResultBox{
	    display: contents;
	}
	#uploud-group input {
	    position: absolute;
	    top: 0px;
	    left: 0px;
	    opacity: 0;
	    cursor: pointer;
	    font-size: 0px;
	}
	
	.file-label {
		width: 225px;
		height: 225px;
		margin-right: 1.4rem;
	}
	.file-li {
	    width: 225px;
	    height: 225px;
	    position: relative;
	    border: 1px solid rgb(230, 229, 239);
	    background: rgb(250, 250, 253);
	    display: flex;
	    -webkit-box-align: center;
	    align-items: center;
	    -webkit-box-pack: center;
	    justify-content: center;
	    flex-direction: column;
	    color: rgb(155, 153, 169);
	    font-size: 1rem;
	    margin-bottom: 1.4rem;
	    cursor: pointer;
	}
	.file-li::before {
	    content: "";
	    background-position: center center;
	    background-repeat: no-repeat;
	    background-size: cover;
	    width: 2rem;
	    height: 2rem;
	    background-image: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIzMiIgaGVpZ2h0PSIzMiIgdmlld0JveD0iMCAwIDMyIDMyIj4KICAgIDxwYXRoIGZpbGw9IiNEQ0RCRTQiIGZpbGwtcnVsZT0iZXZlbm9kZCIgZD0iTTI4LjQ3MSAzMkgzLjUzYy0uOTcxIDAtMS44OTQtLjQyMi0yLjUyOS0xLjE1N2wtLjAyNi0uMDNBNCA0IDAgMCAxIDAgMjguMTk4VjguNjA3QTQgNCAwIDAgMSAuOTc0IDUuOTlMMSA1Ljk2YTMuMzQzIDMuMzQzIDAgMCAxIDIuNTI5LTEuMTU2aDIuNTM0YTIgMiAwIDAgMCAxLjUzNy0uNzJMMTAuNC43MkEyIDIgMCAwIDEgMTEuOTM3IDBoOC4xMjZBMiAyIDAgMCAxIDIxLjYuNzJsMi44IDMuMzYzYTIgMiAwIDAgMCAxLjUzNy43MmgyLjUzNGMuOTcxIDAgMS44OTQuNDIzIDIuNTI5IDEuMTU3bC4wMjYuMDNBNCA0IDAgMCAxIDMyIDguNjA2djE5LjU5MWE0IDQgMCAwIDEtLjk3NCAyLjYxN2wtLjAyNi4wM0EzLjM0MyAzLjM0MyAwIDAgMSAyOC40NzEgMzJ6TTE2IDkuNmE4IDggMCAxIDEgMCAxNiA4IDggMCAwIDEgMC0xNnptMCAxMi44YzIuNjQ3IDAgNC44LTIuMTUzIDQuOC00LjhzLTIuMTUzLTQuOC00LjgtNC44YTQuODA1IDQuODA1IDAgMCAwLTQuOCA0LjhjMCAyLjY0NyAyLjE1MyA0LjggNC44IDQuOHoiLz4KPC9zdmc+Cg==);
	    margin-bottom: 1rem;
	}
	#result_card img{
	    width: 100%;
    	height: 100%;
	}
	#result_card {
		position: relative;
		width: 225px;
    	height: 225px;
    	border: 1px solid rgb(230, 229, 239);
    	position: relative;
    	margin-right: 1.4rem;
    	margin-bottom: 1.4rem;
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
	.location{
		width: 100%;
   		text-align: center;
   		margin-top : 20px;
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
	                                        <div class="form-group" id="titleGroup">
	                                            <label for="form_name">상품명</label>
	                                            <input id="form_name" type="text" name="p_name" class="form-control" placeholder="상품명을 입력해주세요 *" required data-error="상품명은 필수입력입니다.">                        
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="row">
	                                    <div class="col-md-6">
	                                        <div class="form-group">
	                                            <label for="form_lastname">상품가격 (원)</label>
	                                            <input id="form_lastname" type="text" id="price" name="price" class="form-control" placeholder="가격을 입력해주세요  *" 
	                                            	 numberOnlyMinComma="true" required onblur="handleOnInput(this, 9)">
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
	                                    <div class="col-md-12" id="descriptionForm">
	                                        <div class="form-group">
	                                            <label for="form_message">상품 정보</label>
	                                            <textarea id="form_message" name="description" class="form-control" placeholder="상품 정보를 입력해주세요 *" 
	                                            	rows="4" required data-error="상품 정보는 필수입력입니다."></textarea>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="row">
	                                    <div class="col-md-12 p-2 pt-5 pb-5" id="imageForm">
	                                        <div class="form-group" id="uploud-group">
	                                            <label for="chooseFile" class="file-label">
	                                            	<li class="file-li">
	                                            		"이미지 업로드"
	                                            	</li>
	                                            </label>
	                                            <input type="file" class="file" id="chooseFile" name='uploadFile'accept=".jpg, .png" required>
	                                            <div id="uploadResult" class="uploadResultBox"></div>             
	                                        </div>                          
	                                    </div>
	                                    <div class="col-md-12">
	                                        <div class="form-group">
	                                            <label for="form_message" class="location">거래 위치</label>
	                                            <div id="map" style="width:100%;height:400px;"></div>
	                                                <p><em>지도를 클릭해주세요!</em></p>    
	                                            <div id="clickLatlng"></div>
	                                        </div>
	                                    </div>
									</div>
	                                    <div class="col-md-12">
	                                        <button type="submit" id="register_Btn" class="btn btn-success btn-send  pt-2 btn-block" onclick="fileCheck()">상품 등록</button> 
	                                        <button type="button" id="list_Btn" class="btn btn-outline-dark">목록</button>
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

		var formObj = $("form[role='form']");
	
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
 			/* if($(".imgDeleteBtn").length > 0){
					deleteFile();
			}  */
				
			let formData = new FormData();
			let fileInput = $('input[name="uploadFile"]');
			let fileList = fileInput[0].files;
			/* let fileObj = fileList[0];  */
			
		
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
					Swal.fire({
					      icon: 'error',
					      title: '이미지 파일이 아닙니다.',
					      text: '',
					});
					return false;
				}
			});	
		});
			
		let regex = new RegExp("(.*?)\.(jpg|png)$");
		let maxSize = 10485760; //10MB	
			
		function fileCheck(fileName, fileSize){
		
			if(fileSize >= maxSize){
				Swal.fire({
				      icon: 'error',
				      title: '10MB 이상의 파일입니다',
				      text: '',
				});
				return false;
			}
					  
			if(!regex.test(fileName)){
				
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
		
		/* 가격 숫자만 입력, 쉼표 */
 		$(document).on("keyup", "input:text[numberOnlyMinComma]", function()	{
 			var strVal = $(this).val();

 			event = event || window.event;
 			var keyID = (event.which) ? event.which : event.keyCode;

 			if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 )
 						|| keyID == 46 || keyID == 8 || keyID == 109
 						|| keyID == 189 || keyID == 9
 						|| keyID == 37 || keyID == 39){

 				if(strVal.length > 1 && (keyID == 109 || keyID == 189)){
 					return false;
 				}else{
 					return;
 				}
 			}else{
 				return false;
 			}
 		});
 		$(document).on("keyup", "input:text[numberOnlyMinComma]", function()	{
 			$(this).val( $(this).val().replace(/[^-\.0-9]/gi,"") );
 			$(this).val( $(this).val().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") );
 		});  		
 		$(document).on("focusout", "input:text[numberOnlyMinComma]", function()	{
 			$(this).val( $(this).val().replace(",","") );
 			$(this).val( $(this).val().replace(/[^-\.0-9]/gi,"") );
 			$(this).val( $(this).val().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,") );		
 		});
 		$(document).on("focusout", "input:text[numberOnlyMinComma]", function(){
 		    var value = $(this).val();
 		    value = value.replace(/,/g,'');
 		    $(this).val(value);
 		});

 		
 		/* 목록 버튼 */
 		$("#list_Btn").click(function(el, maxlength){ 
			location.href='productList?c=all&v=brandNew'
		});
 		
 		function fileCheck() {
 			var imgFile = $('#chooseFile').val();
 			if($('#chooseFile').val() == ""){
 				Swal.fire({
 				      icon: 'error',
 				      title: '이미지 업로드는 필수입니다!',
 				      text: '',
 				});
 				$('#chooseFile').focus();
 			}
		}
		function handleOnInput(el, maxlength) {
			if(el.value.length > maxlength)  {
				Swal.fire({
				      icon: 'error',
				      title: '가격 최대값 초과',
				      text: '가격은 10억원 미만으로 해주세요',
				 
				});
				el.value = el.value.substr(999999999);
			}
		}


 		
	</script>
</body>
</html>