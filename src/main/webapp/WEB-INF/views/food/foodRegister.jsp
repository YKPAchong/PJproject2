<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>


<c:set value="${pageContext.request.contextPath }" var="ContextPath"></c:set>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/food/foodRegister.css">

<!-- summernote -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<!-- include plugin -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resource/js/summernote-ko-KR.js" type="module"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resource/js/summernote-lite.js" type="module"></script>

<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4312ec82fed74fec65ab6c6ffa59a5c8&libraries=services,clusterer,drawing"></script>

<!--주소화면 외부js  -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="<%=request.getContextPath()%>/resource/js/address.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>



<title></title>
</head>
<body>

	<div class="body_wrapper">
		<tag:nav></tag:nav>

		<!-- .contatiner>.row>.col>h1{게시물 작성} -->
		<div class="main_container">
			<!-- header -->

				<div class="main_register_head_container">
					<div class="main_register_head_wrapper">
						<div class="main_register_head_title">맛집 공유</div>
						<div class="main_register_head_box">
							<div class="main_register_head_mainicon">
								<img src="${pageContext.request.contextPath }/resource/img/foodImg/dragon_head_food.png"  alt="" class="main_register_head_mainicon_iconimage">
							</div>
							<div class="main_register_head_content">용필이에게 다양한 맛집을 알려주세요~</div>
						</div>
					</div>
				</div>



			<!-- 게시판 -->
			<div class="main_register_container">
				<div class="main_register_wrapper">
					<div class="item main_register_PageName_container">
						<div class="main_register_PageName_wrapper">
							<div class="main_register_PageName_input">용필이의 골목식당</div>
						</div>
					</div>

					<form id="form1" method="post" enctype="multipart/form-data">
						<input type="hidden" name="id" value="${food.id }">
						<input type="hidden" name="name" value="${sessionScope.loggedUser.name }">
						<input type="hidden" name="memberId" value="${sessionScope.loggedUser.id }">


						<div class="item main_register_titlePrice_container">
							<div class="main_register_titlePrice_titleWrapper">
								<div class="main_register_titlePrice_titleName">제 목 :</div>
								<div class="main_register_titlePrice_titleInput">
									<input type="text" maxlength='30' class="titlePrice_titleInput" id="titleInput" name="title">
								</div>
							</div>
							<div class="main_register_titlePrice_priceWrapper">
								<div class="main_register_titlePrice_priceName">날짜 :</div>
								<div class="main_register_titlePrice_priceInput">
									<!-- <input type="text" class="titlePrice_priceInput" onBlur="parseelement(this)" id="priceInput" name="price"> -->
									${nowDate }	
								</div>
							</div>
						</div>
						<div class="item main_register_nickNameDate_container">
							<div class="main_register_nickNameDate_nickNameWrapper">
								<div class="main_register_nickNameDate_nickName">작성자 :</div>
								<div class=" main_register_nickNameDate_nickNameInput">
									<input type="text" class="nickNameDate_nickNameInput" id="writerInput" name="writer" readonly value="${sessionScope.loggedUser.nickName }">
								</div>
							</div>
							
							
							
							<div class="main_register_nickNameDate_dateWrapper">
								<div class="main_register_nickNameDate_dateName"><!-- 날짜 : --></div>
									<div class="main_register_nickNameDate_dateInput">
										<!-- ${nowDate } -->				
									</div>
								</div>
							</div>
							
							
							
							
						<div class="item main_register_summernote_container">
							<div class="main_register_summernote">
								<textarea class="form-control" id="summernote" name="contents"></textarea>
							</div>
						</div>
						<div class="item main_register_address_container">
							<div class="main_register_address_wrapper">
								<div class="main_register_address_addressName">주 소 :</div>
								<div class="main_register_address_addressInput">
									<input type="text" class="address_addressInput" id="addressInput" required name="address" value="${loggedUser.address }">
								</div>
							</div>
							<!-- <div class="main_register_address_wrapper2"></div> -->
						</div>
						<div class="item main_register_addressImage_container">
							<div class="main_register_addressImage_wrapper">
								<div class="main_register_addressImage_addressImageInput">
									<div id="map" style="width: 500px; height: 300px; margin-top: 10px;"></div>
									<div id="clickLatlng" style="display: none"></div>
								</div>
							</div>
						</div>
						<div class="item main_register_button_container">
							<div class="main_register_button_wrapper">
								<div class="main_register_registerBtn">
									<button class="btn submit" id="submitButton1" name="submitBtn">등록</button>
									<button class="btn back" style="float: right;">
										<a href="javascript:history.back();">뒤로가기</a>
									</button>
								</div>
							</div>
						</div>
					</form>
		         <div class="food_get_body_main_bottom_box">
		            <div class="food_get_main_bottom_box_title">
		                <div class="food_get_main_bottom_foodBoardTitle">
		                    용필이 골목식당
		                </div>
		            </div>
		            <div class="food_get_main_bottom_mainicon">
		                <div class="food_get_main_bottom_mainicon">
		                     <img src="${pageContext.request.contextPath }/resource/img/foodImg/Dragon_Logo_food.png" alt="" class="food_get_main_bottom_iconimage">
		                </div>
		            </div>   
		        </div> 
				</div>
			</div>

			<!-- 여기까지 -->

			<tag:footer></tag:footer>
			<tag:menu></tag:menu>

			<script>
    
</script>

			<script>
$(document).ready(function(){
	
	
	/*섬머노트  */
	const appRoot = '${pageContext.request.contextPath}';
	var fontList = ['맑은 고딕', '돋움', '궁서', '굴림', '굴림체', '궁서체', '나눔 고딕', '바탕', '바탕체',
		'새굴림', 'HY견고딕', 'HY견명조', 'HY궁서B', 'HY그래픽M', 'HY목각파임B', 'HY신명조', 'HY얕은샘물M',
		'HY엽서L', 'HY엽서M', 'HY중고딕', 'HY헤드라인M', '휴먼매직체', '휴먼모음T', '휴먼아미체',
		'휴먼둥근헤드라인', '휴먼편지체', '휴먼옛체'
		];
var toolbar =  [
['style', ['style']],
['font', ['bold', 'underline', 'clear']],
['fontname', ['fontname','fontsize','fontsizeunit']],
['color', ['color']],
['para', ['ul', 'ol', 'paragraph']],
['table', ['table']],
['insert', ['link', 'picture']],
['view', ['fullscreen', 'codeview', 'help']]
];
var setting = {
 placeholder: "맛집을 맛있게 작성해주세요!",
 height: 400,
 lang : 'ko-KR',
 minHeight: null,
 maxHeight: null,
 fontNames: fontList,
 fontNamesIgnoreCheck: fontList,
 fontSizes: ['8','9','10','11','12','14','18','24','36'],
 toolbar : toolbar,
 //콜백 함수
 /*
 callbacks : { 
    onImageUpload : function(files, editor, welEditable) {
    	// 파일 업로드(다중업로드를 위해 반복문 사용)
    	for (var i = files.length - 1; i >= 0; i--) {
    		uploadSummernoteImageFile(files[i], this);
    	}
    }
 }
*/
 callbacks : {
	 onImageUpload: function(files) {
	     // upload image to server and create imgNode...
	     for(var i = files.length -1; i>= 0; i-- ){
	    	 uploadSummernoteImageFile(files[i], this);
	     }
	     
	     //uploadSummernoteImageFile(files[0], this);
	     
     }
 }
};

$('#summernote').summernote(setting);

/**
* 이미지 파일 업로드
*/

			function uploadSummernoteImageFile(file, el) {
				let data = new FormData();
				data.append("file", file);
				$.ajax({
				data : data,
				type : "POST",
				url : appRoot + "/food/uploadSummernoteImageFile",
				contentType : false,
				enctype : 'multipart/form-data',
				processData : false,
				success : function(d) {
					/* const parseData = JSON.parse(d);
					console.log("s-data:", parseData.url); */
					//$(el).summernote('editor.insertImage', d.url);
					let imgNode = document.createElement("img");
					$(imgNode).attr("src", d.url);
					$(el).summernote('insertNode', imgNode);
					
					$("#form1").append($("<input name='imageKey' type='hidden' />").val(d.imageKey));
					
			}
		});
	}
				
	
	// #submitButton1 버튼 클릭됬을때
	// 사용 가능 또는 불가능 메세지 출려
		// 아래 코드에서 필요한 요소를 선택
		const titleInput = $("#titleInput");
		const contentInput = $("#summernote");
		const submitButton = $("#submitButton1");

		
		// submit 버튼 활성화 조건 변수
		const confirmFunction = function() {
			console.log('confirm func');
			const titleValue = titleInput.val();
			const contentValue = contentInput.val();
			
			console.log(titleValue);
			//console.log(priceValue);
			
			if ( (titleValue != "") ) {
				submitButton.removeAttr("disabled");
			} else {
				submitButton.attr("disable", true);
				
			}
	};
		

	submitButton.attr("disabled", true); 
	
	titleInput.keyup(confirmFunction);
	
	contentInput.keyup(confirmFunction);
	//priceInput.keyup(confirmFunction);
	

	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.499817, 127.030277), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 

	//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new kakao.maps.MapTypeControl();

	// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
	// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	var addressMap = $("#addressInput").val();
	console.log(addressMap);

	const mapHandler = () => {
		
		 //카카오 지도 발생
	    new daum.Postcode({
	        oncomplete: function(data) { //선택시 입력값 세팅
	            document.getElementById("addressInput").value = data.address; // 주소 넣기
				
	            geocoder.addressSearch(data.address, function(result, status) {

	                // 정상적으로 검색이 완료됐으면 
	                 if (status === kakao.maps.services.Status.OK) {
	            		
	                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	            		var message = 'latlng: new kakao.maps.LatLng(' + result[0].y + ', ';
	            		message += result[0].x + ')';
	            		
	            		var resultDiv = document.getElementById('clickLatlng'); 
	            		resultDiv.innerHTML = message;
	            		
	                    // 결과값으로 받은 위치를 마커로 표시합니다
	                    var marker = new kakao.maps.Marker({
	                        map: map,
	                        position: coords
	                    });

		                var iwContent = '<div style="padding:5px 10px 5px 5px; font-size: small;white-space: nowrap;">'+addressMap+'<br><a href="https://map.kakao.com/link/map/'+addressMap+','+result[0].y+','+result[0].x+
		                '" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/'+addressMap+
		                ','+result[0].y+','+result[0].x+'" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		                iwPosition = new kakao.maps.LatLng(result[0].y, result[0].x);
	                    
	                    // 인포윈도우로 장소에 대한 설명을 표시합니다
	                    var infowindow = new kakao.maps.InfoWindow({
	                    	position : iwPosition,
	                        content: '<div style="width:150px;text-align:center;padding:6px 0;">장소</div>'
	                    });
	                    infowindow.open(map, marker);

	                    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	                    map.setCenter(coords);
	                } 
	            })
	            
			//	document.querySelector("input[name=price]").focus();
			// document.querySelector("input[name=addressDetail]").focus(); //상세입력 포커싱
	        }


	    }).open();
		
	}
	
	document.getElementById("addressInput").addEventListener("click", mapHandler)//주소입력칸을 클릭하면

})
</script>

<script src="${pageContext.request.contextPath }/resource/js/main.js" type="module"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>

</body>
</html>








