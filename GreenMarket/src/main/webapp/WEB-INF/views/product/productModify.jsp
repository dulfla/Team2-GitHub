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

</head>
<body>

	<%@ include file="../include/header.jsp" %>
	<div id="container">
		<form action="productModify" id="modiForm" method="POST" autocomplete="off" enctype="multipart/form-data">
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
		</form>
				
	</div>
	<%@ include file="../include/footer.jsp" %>
	
	<script type="text/javascript">
	
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
			url: '/GreenMarket/product/uploadAjaxAction',
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
		str += "<img src='/GreenMarket/product/display?fileName=" + fileCallPath +"'>";
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
			 
			  
			  $.getJSON("/GreenMarket/getImageList", {p_id : p_id}, function(arr){
				  
				 	if(arr.length === 0){	
					  
				 		
				 		
						let str = "";
						
						str += "<div id='result_card'>";
						str += "<img src='../resources/img/noImage.png'>";
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
					str += "<img src='/GreenMarket/product/display?fileName=" + fileCallPath +"'>";
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