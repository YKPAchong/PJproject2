<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" integrity="sha512-1PKOgIY59xJ8Co8+NE6FZ+LOAZKjy+KY8iq0G4B3CyeY6wYHN3yt9PW0XpSriVlkMXe40PTKnXrLnZ9+fkDaog==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" integrity="sha512-bnIvzh6FU75ZKxp0GXLH9bewza/OIw6dLVh9ICg0gogclmYGguQJWl8U30WpbsGTqbIiAwxTsbe76DErLq5EDQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<c:set value="${pageContext.request.contextPath }" var="ContextPath"></c:set>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />


<!-- summernote -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>

<!-- include plugin -->
<script type="text/javascript" src="${pageContext.request.contextPath }/resource/js/summernote-ko-KR.js" type="module" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resource/js/summernote-lite.js" type="module" ></script>

<title>Insert title here</title>
</head>
<body>
<div class="body_wrapper">	
	<tag:nav></tag:nav>
	<div style="width:80%; margin: auto;">
		<form id="modifyForm" method="post">
			<input type="hidden" name="id" value="${food.id }">
			<label>?????????</label>
				<input class="form-control" type="text" id="inputWriter" name="writer" style="width: 40%;" value="${food.writer }"/> <br>
			<label>??????</label>
				<input class="form-control" type="text" id="InputTitle" name="title" style="width: 100%;" value="${food.title }"/> <br>
			<label>??????</label>
			<textarea id="summernote" name="contents">${food.contents }</textarea>
			<button id="modifySubmitButton" type="submit" value="??? ??????" style="float: right;">??? ??????</button>
			<button id="removeSubmitButton" type="submit" value="??? ??????" style="float: right;">??? ??????</button>
		</form>
			<button id="subBtn" type="submit" value="??? ??????" style="float: left;" onclick="${history.go(-1)}">??????</button>
	</div>
</div>
 <script>
 $(document).ready(function() {
	const appRoot = '${pageContext.request.contextPath}';
	 
	$("#removeSubmitButton").click(function (e) {
		e.preventDefault();	// ?????? ????????? ???????????? ????????? ???
		$("#modifyForm").attr("action", "foodRemove").submit();
	});	
	
	$("#modifySubmitButton").click(function (e) {
		e.preventDefault();
		$("#modifyForm").attr("action", "foodModify").submit();
	});
	
	// summerNote
	var fontList = ['?????? ??????', '??????', '??????', '??????', '?????????', '?????????', '?????? ??????', '??????', '?????????',
					'?????????', 'HY?????????', 'HY?????????', 'HY??????B', 'HY?????????M', 'HY????????????B', 'HY?????????', 'HY????????????M',
					'HY??????L', 'HY??????M', 'HY?????????', 'HY????????????M', '???????????????', '????????????T', '???????????????',
					'????????????????????????', '???????????????', '????????????'
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
			 placeholder: 'Hello stand alone ui',
			 height: 400,
	         lang : 'ko-KR',
			 minHeight: null,
			 maxHeight: null,
			 fontNames: fontList,
			 fontNamesIgnoreCheck: fontList,
			 fontSizes: ['8','9','10','11','12','14','18','24','36'],
			 toolbar : toolbar,
			 //?????? ??????
			 /*
	         callbacks : { 
	            onImageUpload : function(files, editor, welEditable) {
	            	// ?????? ?????????(?????????????????? ?????? ????????? ??????)
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
				     // uploadSummernoteImageFile(files[0], this);
			     }
			 }
	};
	
	$('#summernote').summernote(setting);
	
	/**
	* ????????? ?????? ?????????
	*/
    function uploadSummernoteImageFile(file, el) {
		let data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : appRoot + "/food/modifySummernoteImageFile",
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
				
				$("#modifyForm").append($("<input name='imageKey' type='hidden' />").val(d.imageKey));
			}
		});
	}
	
 });
</script>
 
<tag:footer></tag:footer>
<tag:menu></tag:menu>
 ???
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</body>
</html>