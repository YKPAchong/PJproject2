<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>
<c:set var="userUrl" value="${pageContext.request.contextPath }/user"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resource/css/icon/css/all.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resource/css/styles.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<title>join page</title>
</head>
<body>
<%
    //String clientId = (String)application.getAttribute("naver_client_id");//애플리케이션 클라이언트 아이디값";
    String clientId = "I0h6W4S5fUWk4zc_U2h1";
    String redirectURI = URLEncoder.encode("http://localhost:8080/controller/naver/naverJoin", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
 %>
<div class="body_wrapper">
	<c:url value="/user" var="userUrl"></c:url>
	<tag:flash></tag:flash>
	<tag:nav></tag:nav>
	<div class="main_container main_page_default">
		<div class="join_main_box">
                <div class="join_main_wrapper">
                    <span>회원가입</span>
                    <form method="post" class="join_main_form">
                        <div class="join_main_input_group">
                            <label for="join_input1">이름*</label>
                            <input type="text" id="join_input1" name="name" class="join_name" maxlength="10" required/>
                        </div>
                        <div class="join_main_input_group">
                            <label for="join_input2">닉네임</label>
                            <input type="text" id="join_input2" name="nickName" maxlength="30" class="join_nickName" />
                        </div>
                        <div class="join_main_input_group">
                            <label for="join_input3">이메일*</label>
                            <div class="join_input_group">
                            <input type="email" id="join_input3" name="email" class="join_email" maxlength="30" required/>
                            <input type="button" class="join_email_check" value="Check">
                            <div class="join_email_message">이메일을 확인해 주세요</div>
                        </div>
                        </div>
                        <div class="join_main_input_group">
                            <label for="join_input4">비밀번호*</label>
                            <input type="password" id="join_input4" name="password" class="join_pw" maxlength="20" required/>
                        </div>
                        <div class="join_main_input_group">
                            <label for="join_input5">비밀번호 확인*</label>
                            <input type="password" id="join_input5" class="join_pw_check" maxlength="20" required/>
                        </div>
                        <div class="join_main_input_group">
                            <label for="join_input6">주소</label>
                            <input type="text" id="join_input6" name="address" class="join_address"/>
                        </div>
                        <input type="submit" class="join_submit" value="Join" disabled />
                        <input type="hidden" class="contextPath" value="${pageContext.request.contextPath }"/>
                    </form>
                    <a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=d1f2c7c111ea44b0957fc9dbf10a601f&redirect_uri=http://localhost:8080/controller/kakao/kakaoJoin&prompt=login
                            " class="join_kakao">
                         <div class="join_kakao_img_box">
                             <i class="fas fa-comment"></i>
                             <span>Join with Kakao</span>
                         </div>
                    </a>
                    <a href="<%=apiURL%>" class="join_naver">
                        <div class="join_naver_img_box">
                            <span>N</span>
                            <span>Join with Naver</span>
                        </div>
                    </a>
                </div>
            </div>
	</div>
	<tag:footer></tag:footer>
	<tag:menu></tag:menu>
</div>
<script src="${pageContext.request.contextPath }/resource/js/main.js" type="module"></script>
</body>
</html>