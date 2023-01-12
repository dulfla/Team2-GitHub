<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<form action="" id="regForm" method="POST" autocomplete="off" enctype="multipart/form-data">
			<div>
				<span>카테고리</span>
				<select class="category" name="category">
					<option value="null">선택</option>
					<c:forEach items="${category}" var="cate"><option value="${cate.category}">${cate.category}</option></c:forEach>
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
				<input type="file" name='uploadFile' style="height: 30px;">
			</div>
			<div>
			<textarea rows="5" cols="50" name="description" placeholder="내용을 입력하세요">${product.description}</textarea>
			</div>
			<button>상품등록</button>
			<button type="button">목록</button>
		</form>
				
	</div>
	<%@ include file="../include/footer.jsp" %>
	
	<script type="text/javascript">
			
	</script>
</body>
</html>