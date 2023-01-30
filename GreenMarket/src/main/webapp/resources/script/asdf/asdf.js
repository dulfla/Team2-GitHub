var lat = $("#lat").val();
		var lng = $("#lng").val();
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = { 
			center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
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
	/* ============================================================= */
	
	
	$("input[type='file']").on("change", function(e){
		
		/* 등록된 이미지 존재시 삭제 */		
		/* 이미지 없는 게시판 수정시 이미지없음 사진이 안지워져서 수정 */
		//if($(".imgDeleteBtn").length > 0){
/* 		if($("#result_card").length > 0){
			deleteFile();
		} */
		
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
		
		let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
		
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

					$("#uploadResult").html(str);
			  });		
		  });
	
	
		$("#back_Btn").click(function(){
			history.back();	// 뒤로가기
		});
		
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