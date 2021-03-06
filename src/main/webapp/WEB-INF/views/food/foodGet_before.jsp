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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<c:set value="${pageContext.request.contextPath }" var="ContextPath"></c:set>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />

<style type="text/css">

.bbsTitleBox{
    border: 1px solid #DDD;
    /* margin: 0 auto 10px; */
    width: 80%;
    margin-bottom: 10px;
}
.bbsTitle {
    position: relative;
    padding: 0 0.6em;
    font-size: 15px;
    font-weight: bold;
    line-height: 34px;
    background: #EEE;
    border-bottom: 1px solid #DDD;
}

.board-view-top {
    width: 100%;
    padding-left: 24px;
    border-bottom: 1px solid #E7E7E7;
    vertical-align: middle;
    position: relative;
    text-align: center;
}

.board-view-top .view-top-function {
    font-size: 0;
    float: right;
    padding: 16px 0;
}

.board-view-top .view-subject {
    float: left;
    font-size: 16px;
    font-weight: 700;
    line-height: 56px;
}

.board-view-top .view-subject a {
    display: inline-block;
}

.board-view-info {
    padding: 16px 16px 16px 24px;
    border-bottom: 1px solid #E7E7E7;
}

ul, ol, li, h2 {
    list-style: none;
    margin: 0;
    padding: 0;
    border: 0;
    font: inherit;
    color: inherit;
}

</style>

<script>
$(document).ready(function(){
	// contextPath
	const appRoot = '${pageContext.request.contextPath}';
	
	// ?????? ???????????? ?????? ????????? ???????????? ??????
	const foodListReply = function(){
		// ???????????? ?????? ?????????
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
								?????? \${list[i].customInserted}??? ?????? 
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
							type : "put",	// data??? Json ???????????? ???????????? 
							contentType : "application/json",	// json????????? ?????????
							data : JSON.stringify(data),	// Json ???????????? ????????? ????????? 
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
					
					/* ????????? ??? ?????? ??????,?????? ?????? ?????? */
					if (list[i].own) {	// own true(?????????)?????? ?????? ??????
						// ????????? ????????? ?????? ???????????? ??????
						const modifyButton = $("<button class='btn btn-outline-secondary'>??????</button>");
						modifyButton.click(function(){
							$(this).parent().find('.reply-body').hide();
							$(this).parent().find('.input-group').show();
						});
						
						foodReplyMediaObject.find(".media-body").append(modifyButton);
						
						// ???????????? ??????
						const removeButton = $("<button class='btn btn-outline-danger'>??????</button>");
						foodReplyMediaObject.find(".media-body").append(removeButton);
						removeButton.click(function(){
							if(confirm("?????????????????????????")){
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
	
	foodListReply();	// ????????? ?????? ??? ?????? ????????? ???????????? ?????? ??? ??? ??????
	
	/* ?????? ?????? */
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
				alert("?????? ???????????? ???????????????. ????????? ????????? ??????????????????.");
				$("#replyTextarea").val("");
			},
			complete : function(){
				// ?????? ????????? ?????? ??????
				foodListReply();				
			}
		});
	});
	
});


</script>


<title>Insert title here</title>
</head>
<body>
<div class="body_wrapper">	
	<tag:nav></tag:nav>
<!-- .container>.row>.col>h1{????????? ??????}-->
	<div class="main_container">
		<div class="row" style="width: 80%">
			<div class="col">
				<div class="main_bbsFood" style="width: 80%">
					<div class="bbsTitleBox">					
						<div class="bbsTitle">
							<a href="#">??????</a>
							<div class="bbsBtnGroup"></div>
						</div>
						<div class="bbsNotice">
							<div>- ????????? ?????? ?????? ?????? ?????? ???????????????.</div>
						</div>
					</div>
				
					<div class="board-view-top">
						<div class="view-subject">
							<a href="">
								????????? ?????? ????????? ??????
							</a>
						</div>
					</div>
					<ul class="view-top-function">
						<li>
							<a href="" class="btn-list" title="??????">
								<span class="sound_only">??????</span>
							</a>
						</li>
					</ul>	
					
					<div class="board-view-info">
						<h2 class="view-tit">test ??????</h2>
						<div class="view-info">
							<span class="view-writer">
								test ?????????
							</span>
						</div>
						<div class="view-date">test ????????????</div>
						<div class="view-hit">test ?????????</div>
					</div>
					
					<div class="board-view-content">
						test ??????
					</div>
					
					<div class="view-bottom-function">
						<a href="#" class="btn-list" title="??????">??????</a>
					</div>
									
				<br><br><br>	
				<hr>
				<!-- .form-group*3>label[for=input$]+input.form-control#input$[readonly] -->
				<div class="form-group">
					<label for="input1">??????</label>
					<input type="text" class="form-control" id="input1" value="${food.title }" readonly="">
				</div>
				<div class="form-group">
					<label for="input2">?????????</label>
					<input type="text" class="form-control" id="input2" value="${food.writer }" readonly="">
				</div>
				<div class="form-group">
					<label for="input3">??????</label>
					<tr>
						<td>${food.contents }</td>
					</tr>
				</div>
				
				<a href="foodList" class="btn btn-outline-secondary">
					??????
				</a>
				
				<a href="foodModify?id=${food.id }" class="btn btn-outline-secondary">
					?????? / ??????
				</a>
				


			<c:if test="${not empty sessionScope.loggedUser }">
			<!-- ?????? ?????? -->
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
			
			<!-- ?????? container -->
			<hr>
			<div class="container">
				<div class="row">
					<div class="col">
						<div id="foodReplyListContainer"></div>
					</div>
				</div>
			</div>
		  </div>
			</div>
		</div>
	</div>
</div>

<tag:footer></tag:footer>
<tag:menu></tag:menu>
 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
</body>
</html>