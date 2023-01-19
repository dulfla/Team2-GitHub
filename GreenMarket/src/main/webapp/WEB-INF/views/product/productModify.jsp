<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" crossorigin="anonymous"></script> 
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	490ef0680625aa2086d3bf61d038acea"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-steps/1.1.0/jquery.steps.min.js"></script>
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
	body {
    font-family: 'Lato', sans-serif;
	}
	
	h1 {
	    margin-bottom: 40px;
	}
	
	label {
	    color: #333;
	}
	.help-block.with-errors {
	    color: #ff5050;
	    margin-top: 5px;	
	}
	.card{
		margin-left: 10px;
		margin-right: 10px;
	}
</style>
</head>
<body>

	<%@ include file="../include/header.jsp" %>
	<div id="container">
		<div class=" text-center mt-5 ">
	    <h1 >상품 수정</h1>                   
		</div>
		<div class="row ">
		    <div class="col-lg-7 mx-auto">
		        <div class="card mt-2 mx-auto p-4 bg-light">
		            <div class="card-body bg-light">
		                <div class = "container">
		                    <form action="productModify" id="contact-form" role="form" method="POST" autocomplete="off" enctype="multipart/form-data">
		                        <input type="hidden" name="p_id" value="${product.p_id}">
		                        <div>
		                            <span>판매상태</span>
		                            <select class="trade" name="trade">
		                                <option value="trade">판매중</option>
		                                <option value="clear">판매완료</option>
		                            </select>
		                        </div>
		                        <div class="controls">
		                            <div class="row">
		                                <div class="col-md-12">
		                                    <div class="form-group">
		                                        <label for="form_name">상품명</label>
		                                        <input id="form_name" type="text" name="p_name" class="form-control" placeholder="상품명을 입력해주세요 *" required data-error="상품명은 필수입력입니다." value="${product.p_name}">                        
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="row">
		                                <div class="col-md-6">
		                                    <div class="form-group">
		                                        <label for="form_lastname">상품 가격</label>
		                                        <input id="form_lastname" type="text" name="price" class="form-control" placeholder="가격을 입력해주세요 *" required data-error="가격은 필수입력입니다." value="${product.price}">
		                                    </div>
		                                </div>
		                                <div class="col-md-6">
		                                    <div class="form-group">
		                                        <label for="form_need">카테고리</label>
		                                        <select id="form_need" name="category" class="form-control" required="required" data-error="카테고리는 필수 입력입니다.">
		                                            <option value="" disabled>-카테고리를 골라주세요-</option>
		                                            <c:forEach items="${category}" var="cate">
								                        <option value="${cate.category}" <c:if test ="${product.category eq cate.category}">selected="selected"</c:if>>
									                        ${cate.category}
								                        </option>
							                        </c:forEach>
		                                        </select>          
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="row">
		                                <div class="col-md-12">
		                                    <div class="form-group">
		                                        <label for="form_message">상품 정보</label>
		                                        <textarea id="form_message" name="description" class="form-control" placeholder="상품 정보를 입력해주세요." rows="4" required data-error="상품 정보는 필수입력입니다.">${product.description}</textarea>
		                                    </div>
		                                </div>
		                            </div>  
		                            <div class="row">
			                            <div class="col-md-12">
	                                        <div class="form-group">
	                                            <label for="form_message">상품 이미지</label>
	                                            <input type="file" id="fileItem" name='uploadFile' style="height: 30px;">
	                                            <div id="uploadResult"></div>
	                                        </div>
                                    	</div>
		                            	<div class="col-md-12">
			                                <div class="form-group">
			                                    <label for="form_message">거래 위치</label>
			                                    <div id="map" style="width:350px;height:350px;"></div>
			                                        <p><em>지도를 클릭해주세요!</em></p> 
			                                    <div id="clickLatlng"></div>
		                                    </div>
		                                </div>
		                            </div>
		                            <div class="col-md-12">
		                                <button type="submit" class="btn btn-success btn-send  pt-2 btn-block">상품 수정</button> 
		                                <button type="button" class="btn btn-danger btn-send  pt-2 btn-block" id="back_Btn">취소</button>
		                            </div>
		                        </div>
		                    </form> 
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
		<%-- <form action="productModify" id="modiForm" method="POST" autocomplete="off" enctype="multipart/form-data">
			<input type="hidden" name="p_id" value="${product.p_id}" />
			<div>
				<span>카테고리</span>
				<select class="category" name="category">
					<option value="null">선택</option>
					<c:forEach items="${category}" var="cate">
						<option value="${cate.category}" <c:if test ="${product.category eq cate.category}">selected="selected"</c:if>>
							${cate.category}
						</option>
					</c:forEach>
				</select>
			</div>	
			<div>
			<input type="text" name="p_name" placeholder="상품명을 입력해주세요" value="${product.p_name}">
			</div>
			<div>
			<input type="text" name="price" placeholder="상품가격" value="${product.price}">
			</div>
			<div>
				<label>사진 업로드</label>
				<input type="file" id ="fileItem" name='uploadFile' style="height: 30px;">
			</div>
			<div>
			<textarea rows="5" cols="50" name="description" placeholder="내용을 입력하세요">${product.description}</textarea>
			</div>
			<div>
				<span>판매상태</span>
				<select class="trade" name="trade">
					<option value="trade">판매중</option>
					<option value="clear">판매완료</option>
				</select>
			</div>
			
			<div class="inputArea">
	            <div class="inputArea_title">
		            <label>상품 이미지</label>
		        </div>
				<div id="uploadResult">
																										
				</div>
            </div>
			
			<button>등록</button>
			<button type="button" id="back_Btn">취소</button>
		</form> --%>
				
	</div>
	<%@ include file="../include/footer.jsp" %>
	
	<script type="text/javascript">

	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.267868108956456, 127.00053552238002), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(37.267868108956456, 127.00053552238002); 
	
	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	
	
	/* ============================================================= */
	
	
	$("input[type='file']").on("change", function(e){
		
		/* 등록된 이미지 존재시 삭제 */		
		/* 이미지 없는 게시판 수정시 이미지없음 사진이 안지워져서 수정 */
		//if($(".imgDeleteBtn").length > 0){
		if($("#result_card").length > 0){
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
		
		$("#result_card").remove();
	}
		$(document).ready(function(){
			  /* 이미지 정보 호출 */
			  let p_id = '<c:out value="${product.p_id}"/>';
			  let uploadResult = $("uploadResult");
			 
			  
			  $.getJSON("getImageList", {p_id : p_id}, function(arr){
				  
				 	if(arr.length === 0){	
					  
				 		
				 		
						let str = "";
						
						str += "<div id='result_card'>";
						str += "<img src='./resources/img/noImage.png'>";
						str += "</div>";
							
						//uploadResult.html(str);
						//$("#uploadResult").append(str);
						$("#uploadResult").html(str);
						return;
					} 
				  
					let str = "";
					let obj = arr[0];
					
					let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
					str += "<div id='result_card'";
					str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
					str += ">";
					str += "<img src='display?fileName=" + fileCallPath +"'>";
					str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
					str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
					str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
					str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";
					str += "</div>";		
					//uploadResult.html(str);
					$("#uploadResult").html(str);
			  });		
		  });
	
	
		$("#back_Btn").click(function(){
			history.back();	// 뒤로가기
		});
	</script>
</body>
</html>