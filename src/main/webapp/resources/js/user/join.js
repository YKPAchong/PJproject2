const bodyWrapper = document.querySelector(".body_wrapper");
const pw1 = document.querySelector(".join_pw");
const pw2 = document.querySelector(".join_pw_check");
const submitBtn = document.querySelector(".join_submit");
const email = document.querySelector(".join_email");
const emailCheckBtn = document.querySelector(".join_email_check");
const emailAlertMessage = document.querySelector(".join_email_message")
const addressInput = document.querySelector(".join_address");
const joinMainBox = document.querySelector(".join_main_box");
const contextPathInfoElem = document.querySelector(".contextPath");

let contextPathInfo 


let httpRequest;

let canUseEamil = false;
let canUsePw = false;

const ableSubmitBtn = () =>{
    submitBtn.disabled = false;
}

const unableSubmitBtn = () =>{
	submitBtn.disabled = true;
}

const checkPw = e =>{
    const pw1Value = pw1.value;
    const pw2Value = pw2.value;
    if(pw1Value == pw2Value){
        canUsePw = true;
    }else{
		canUsePw = false;
	}
	checkCanPushSubmitBtn();
}

function makeRequest() {
    httpRequest = new XMLHttpRequest();
	let data ={
		email : email.value
	}
	let jsonData = JSON.stringify(data);
    if(!httpRequest) {
      console.log('XMLHTTP 인스턴스를 만들 수가 없어요 ㅠㅠ');
      return false;
    }
    httpRequest.onreadystatechange = alertContents;
    httpRequest.open('POST', `http://localhost:8080/${contextPathInfo}/user/checkEmail`,false);
	httpRequest.setRequestHeader("Content-Type", "application/json;charset=UTF-8");

    httpRequest.send(jsonData);
}

function alertContents() {
    if (httpRequest.readyState === XMLHttpRequest.DONE) {
      if (httpRequest.status === 200) {
		const message = httpRequest.responseText
		if(message == 'able'){
			emailAlertMessage.innerText = "사용가능한 이메일 입니다."
			email.readOnly=true;
			emailCheckBtn.value="again"
			canUseEamil = true;
			emailCheckBtn.removeEventListener("click",checkInsertInputValue);
			emailCheckBtn.addEventListener("click",()=>{
				email.readOnly=false;
				email.value =""; 
				emailAlertMessage.innerText = "";
				canUseEamil = false;
				emailCheckBtn.value="check"
				checkCanPushSubmitBtn();
				emailCheckBtn.addEventListener("click",checkInsertInputValue);
			},{once:true})
			checkCanPushSubmitBtn();
		}else{
			emailAlertMessage.innerText = "사용불가능한 이메일 입니다."
		}
      } else {
        console.log('request에 뭔가 문제가 있어요.');
      }
    }
  }


const checkCanPushSubmitBtn = () =>{
	if(canUseEamil&&canUsePw){
		ableSubmitBtn();
	}else{
		unableSubmitBtn();
	}
}

const checkInsertInputValue = () =>{
	const value = email.value;
	if(value != ''){
		makeRequest();
	}
}

const addressHandler = () =>{
	new daum.Postcode({
    oncomplete: function(data) {
        addressInput.value = data.address;
    }
    }).open();
}

const init = () =>{
    pw2.addEventListener("keyup",checkPw);
	pw1.addEventListener("keyup",checkPw);
	emailCheckBtn.addEventListener("click",checkInsertInputValue);
	addressInput.addEventListener("click",addressHandler);
}

if(joinMainBox!=null){
	contextPathInfo = contextPathInfoElem.value;
	init();	
}