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
<script src="https://code.jquery.com/jquery-3.6.0.js" crossorigin="anonymous"></script>
</head>
<body>

	<%@ include file="../include/header.jsp" %>
	<div id="container">
		<form action="" id="regForm" method="POST" autocomplete="off" enctype="multipart/form-data">
			<input type="hidden" name="n" value="${Product.p_id}" />
			<div>
				<span>카테고리</span>
				<select class="category" name="category">
					<option value="null">선택</option>
					<c:forEach items="${category}" var="cate"><option value="${cate.category}">${cate.category}</option></c:forEach>
				</select>
			</div>	
			<div>
			<input type="text" name="p_name" placeholder="상품명을 입력해주세요">
			</div>
			<div>
			<input type="text" name="price" placeholder="상품가격">
			</div>
			<div>
				<label>사진 업로드</label>
				<input type="file" name='uploadFile' style="height: 30px;">
			</div>
			<div>
			<textarea rows="5" cols="50" name="description" placeholder="내용을 입력하세요"></textarea>
			</div>
			<button>상품등록</button>
			<button type="button">목록</button>
		</form>
				
	</div>
	<%@ include file="../include/footer.jsp" %>
	
	<script type="text/javascript">

		
  	$("input[type='file']").on("change", function(e){
			
			var formData = new FormData();
			
			let fileInput = $('input[name="uploadFile"]');
			let fileList = fileInput[0].files;
			let fileObj = fileList[0];
						
			if(!fileCheck(fileObj.name, fileObj.size)){
				return false;
			}
			formData.append("uploadFile", fileObj);
			
			$.ajax({
				type : 'POST',
				url: '/member/uploadAjaxAction',
		    	processData : false,
		    	contentType : false,
		    	data : formData,		    	
		    	dataType : 'json' 
			});			
		});
		
		let regex = new RegExp("(.*?)\.(jpg|jpeg|png)$");
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

	</script>
</body>
</html>