const updateBtn = document.querySelector(".user_edit_updateBtn");
const deleteBtn = document.querySelector(".user_edit_deleteBtn");
const submitBtn = document.querySelector(".user_edit_submitBtn");
const nickNameInput = document.querySelector(".user_edit_nickName");
const emailCheckBtn = document.querySelector(".edit_email_check");
const emailInput = document.querySelector("#user_edit_input2");
const passwordInput = document.querySelector(".user_edit_password");
const passwordCheckInput = document.querySelector(".user_edit_password_check");
const addressInput = document.querySelector(".user_edit_address");

const contextPathInfoElem = document.querySelector(".contextPath");
const firstEamilValueElem = document.querySelector(".firstEamilValue");
const firstNickNameValueElem = document.querySelector(".firstNickNameValue")
const firstPasswordValueElem = document.querySelector(".firstPasswordValue");
const firstAddressValueElem = document.querySelector(".firstAddressValue");

const hiddenForm = document.querySelector(".user_edit_hidden_form");
const emailAlertMessage = document.querySelector(".edit_email_message");
const form = document.querySelector(".user_edit_form");
let contextPathInfo 

let firstEamilValue 
let currentInputValue

let firstPwValue

let firstNickNameValue;

let firstAddressValue;

let httpRequest

let canUseEamil = true;
let canUsePassword = true;

const changeFormActionPathAndSubmit = (path) =>{
	form.action = contextPathInfo+path;
	submitBtn.click();
}

const updateHandler = (e) =>{
	e.preventDefault();
	//console.log(nickNameInput.value)
	changeFormActionPathAndSubmit("/user/update");
}

const deleteHandler = (e) =>{
	e.preventDefault()
	changeFormActionPathAndSubmit("/user/userDelete");
}

const emailValueCheckHandler = (e) =>{
	canUseEamil = false;
	emailCheckBtn.addEventListener("click",makeRequest);
	checkCanPushSubmitBtn();
	const currentInputValue = e.target.value;
	if(currentInputValue == firstEamilValue){
		emailCheckBtn.removeEventListener("click",makeRequest);
		updateBtn.disabled = true;
		canUseEamil = true;
	}
}

const checkCanPushSubmitBtn = () =>{
	const ok1 = passwordInput.value == firstPwValue; 	
	const ok2 = emailInput.value == firstEamilValue;
	const ok3 = nickNameInput.value == firstNickNameValue;
	const ok4 = addressInput.value == firstAddressValue;
	const isAllSame = ok1&&ok2&&ok3&&ok4
	if(canUseEamil&&canUsePassword&&!isAllSame){
		updateBtn.disabled = false;
	}else{
		updateBtn.disabled = true;
	}
}

function makeRequest() {
    httpRequest = new XMLHttpRequest();
	let data ={
		email : emailInput.value
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
			canUseEamil = true;
			checkCanPushSubmitBtn();
		}else{
			emailAlertMessage.innerText = "사용불가능한 이메일 입니다."
		}
      } else {
        console.log('request에 뭔가 문제가 있어요.');
      }
    }
  }

const passwordCheckHandler = () =>{
	let pw1Value = passwordInput.value;
	let pw2Value = passwordCheckInput.value;
	if(pw1Value == firstPwValue){
		canUsePassword= true;
	}else{
		canUsePassword= false;
	}
	if(pw1Value == pw2Value){
		canUsePassword = true;
	}
	checkCanPushSubmitBtn();
}

const  addressHandler = () =>{
	new daum.Postcode({
    oncomplete: function(data) {
        addressInput.value = data.address;
		checkCanPushSubmitBtn();
    }
    }).open();
}

const init = () =>{
	updateBtn.addEventListener("click",updateHandler);
	deleteBtn.addEventListener("click",deleteHandler);
	emailInput.addEventListener("input",emailValueCheckHandler);
	passwordInput.addEventListener("input",passwordCheckHandler);
	passwordCheckInput.addEventListener("input",passwordCheckHandler);
	nickNameInput.addEventListener("input",checkCanPushSubmitBtn);
	addressInput.addEventListener("click",addressHandler);
	
}

if(updateBtn!=null){
	contextPathInfo = contextPathInfoElem.value;
	firstEamilValue = firstEamilValueElem.value;
	firstPwValue = firstPasswordValueElem.value;
	firstNickNameValue = firstNickNameValueElem.value;
	firstAddressValue = firstAddressValueElem.value;
	
	init();	
}