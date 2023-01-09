<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 페이지</title>
</head>
<body>
	<%@ include file="../include/header.jsp" %>
	<div id="container">
		<form action="" method="POST" autocomplete="off">
			<div>
				<span>카테고리</span>
				<select class="category" name="category">
					<option selected value="none">선택</option>
				</select>
			</div>	
			<div>
			<input type="text" name="p_name" placeholder="상품명을 입력해주세요">
			</div>
			<div>
			<input type="text" name="price" placeholder="상품가격">
			</div>
			<div>
			<textarea rows="5" cols="50" name="description" placeholder="내용을 입력하세요"></textarea>
			</div>
			<button>상품등록</button>
			<button>목록</button>
		</form>
				
	</div>
	<%@ include file="../include/footer.jsp" %>
	
	<script type="text/javascript">
		let category = JSON.parse('${category}');
		
		let cateArray = new Array();
		let cate1Obj = new Object();
		let cateSelect = $(".category");
	
	    cateSelect.append("<option value='"+cateArray.category+">"+"</option>");
	    
	    obj.category = 
	</script>
</body>
</html>