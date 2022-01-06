<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" integrity="sha512-1PKOgIY59xJ8Co8+NE6FZ+LOAZKjy+KY8iq0G4B3CyeY6wYHN3yt9PW0XpSriVlkMXe40PTKnXrLnZ9+fkDaog==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<script>
$(document).ready(function(){
	// contextPath
	const appRoot = '${pageContext.request.contextPath}';
	
	// 현재 게시물의 댓글 목록을 가져오는 함수
	const foodListReply = function(){
		// 가져올때 댓글 비우기
		$("#foodReplyListContainer").empty();
		$.ajax({
			url : appRoot + "/foodReply/food/${food.id}",
			success : function(list){
				for(let i = 0; i < list.length; i++){
					const foodReplyMediaObject =$(`
						<hr>					
						<div class="media">
						<div class="media-body">
							<h5 class="mt-0">
								<i class="far fa-comment"></i>
								<span class="reply-name"> \${list[i].name} </span>
								님이 \${list[i].customInserted}에 작성 
							</h5>
							<p class="reply-body" style="white-space: pre;"></p>
							
							<div class="input-group" style="display:none">
								<textarea name="" id="replyTextarea\${list[i].id}" class="form-control"></textarea>
								<div class="iput-group-append">
									<button class="btn-outline-secondary cancel-button"><i class="fas fa-ban"></i></button>
									<button class="btn-outline-secondary" id="sendReply\${list[i].id}"><i class="far fa-comment-dots fa-lg"></i></button>
								</div>
							</div>
						 </div>
						</div>`);
					
					foodReplyMediaObject.find("#sendReply" + list[i].id).click(function(){
						const replyText = foodReplyMediaObject.find("#replyTextarea" + list[i].id).val();
						const data = {
							replyText : replyText 
						};
						$.ajax({
							url : appRoot + "/foodReply/" + list[i].id,
							type : "put",	// data를 Json 형식으로 보내야함 
							contentType : "application/json",	// json형태로 바꿔줌
							data : JSON.stringify(data),	// Json 형식으로 보내는 메소드 
							complete : function(){
								foodListReply();
							}
						});
					});
					
					foodReplyMediaObject.find(".reply-name").text(list[i].name);
					foodReplyMediaObject.find(".reply-body").text(list[i].replyText);
					foodReplyMediaObject.find(".form-control").text(list[i].replyText);
					foodReplyMediaObject.find(".cancel-button").click(function(){
						foodReplyMediaObject.find(".reply-body").show();
						foodReplyMediaObject.find(".input-group").hide();
					});
					
					/* 로그인 후 댓글 수정,삭제 버튼 추가 */
					if (list[i].own) {	// own true(로그인)경우 버튼 추가
						// 본인이 작성한 것만 수정버튼 추가
						const modifyButton = $("<button class='btn btn-outline-secondary'>수정</button>");
						modifyButton.click(function(){
							$(this).parent().find('.reply-body').hide();
							$(this).parent().find('.input-group').show();
						});
						
						foodReplyMediaObject.find(".media-body").append(modifyButton);
						
						// 삭제버튼 추가
						const removeButton = $("<button class='btn btn-outline-danger'>삭제</button>");
						foodReplyMediaObject.find(".media-body").append(removeButton);
						removeButton.click(function(){
							if(confirm("삭제하시겠습니까?")){
								$.ajax({
									url : appRoot + "/foodReply/" + list[i].id,
									type : "delete",
									complete : function(){
										foodListReply();
									}
								});
							}
						});
					}
					
					$("#foodReplyListContainer").append(foodReplyMediaObject);
				}
			}
		});
	};
	
	foodListReply();	// 페이지 로딩 후 댓글 리스트 가져오는 함수 한 번 실행
	
	/* 댓글 전송 */
	$("#sendReply").click(function(){
		const replyText = $("#replyTextarea").val();
		const userId = '${sessionScope.loggedUser.id}';
		const foodBoardId = '${food.id}';
		const data = {
			replyText : replyText,
			userId : userId,
			foodBoardId : foodBoardId
		};
		$.ajax({
			url : appRoot + "/foodReply/foodReplyWrite",
			type : "post",
			data : data,
			success : function(){
				// textarea reset
				$("#replyTextarea").val("");
			},
			error : function(){
				alert("댓글 작성되지 않았습니다. 권한이 있는지 확인해보세요.");
				$("#replyTextarea").val("");
			},
			complete : function(){
				// 댓글 리스트 새로 고침
				foodListReply();				
			}
		});
	});
	
});


</script>


<title>Insert title here</title>
</head>
<body>
<!-- .container>.row>.col>h1{게시물 조회}-->
<div class="container">
	<div class="row">
		<div class="col">
			<h1>게시물 조회</h1>
			<!-- .form-group*3>label[for=input$]+input.form-control#input$[readonly] -->
			<div class="form-group">
				<label for="input1">제목</label>
				<input type="text" class="form-control" id="input1" value="${food.title }" readonly="">
			</div>
			<div class="form-group">
				<label for="input2">작성자</label>
				<input type="text" class="form-control" id="input2" value="${food.writer }" readonly="">
			</div>
			<div class="form-group">
				<label for="input3">내용</label>
				<tr>
					<td>${food.contents }</td>
				</tr>
			</div>
			
			<a href="foodList" class="btn btn-outline-secondary">
				목록
			</a>
			
			<a href="foodModify?id=${food.id }" class="btn btn-outline-secondary">
				수정 / 삭제
			</a>
			
		</div>
	</div>
</div>

<c:if test="${not empty sessionScope.loggedUser }">
<!-- 댓글 작성 -->
<div class="container">
	<div class="row">
		<div class="col">
			<hr>
			<div class="input-group">
				<textarea name="" id="replyTextarea" class="form-control"></textarea>
				<div class="iput-group-append">
					<button class="btn-outline-secondary" id="sendReply"><i class="far fa-comment-dots fa-lg"></i></button>
				</div>
			</div>
		</div>
	</div>
</div>
</c:if>

<!-- 댓글 container -->
<hr>
<div class="container">
	<div class="row">
		<div class="col">
			<div id="foodReplyListContainer"></div>
		</div>
	</div>
</div> 

 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</body>
</html>