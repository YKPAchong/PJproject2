const menuOpenBtn = document.querySelector(".header_menu_btn");
const menuCloseBtn = document.querySelector(".menu_title>i");
const menuContainer = document.querySelector(".menu_container");
const hideBtn = document.querySelector(".menu_coummunity_inner_el");
// ----------------------------------------------------------------
const imgBox1 = document.querySelector(".main_content_img_box1");
const imgbox2 = document.querySelector(".main_content_img_box2");
const foodBackGround =  document.querySelector(".main_content_box_background1");
const resellBackGround = document.querySelector(".main_content_box_background2");
const foodContentBox = document.querySelector(".main_content_food_box");
const resellContentBox = document.querySelector(".main_content_resell_box");
const mainContentBox = document.querySelector(".main_content_box");




const openMenuHandler = () =>{
    menuContainer.classList.remove("transfrom");
}

const clostMenuHandler = () =>{
    menuContainer.classList.add("transfrom");
}

const menuinit = () =>{
    menuOpenBtn.addEventListener("click",openMenuHandler)
    menuCloseBtn.addEventListener("click",clostMenuHandler)
}

//-------------------------------------------------------------------

const foodBackGroundHandler = () =>{
    console.log("work")
    foodBackGround.classList.remove("display_none");
    foodBackGround.classList.add("transfrom_scale");
    foodContentBox.removeEventListener("mouseover",foodBackGroundHandler);

    foodContentBox.addEventListener("mouseout",()=>{
        foodBackGround.classList.remove("transfrom_scale");
        foodBackGround.classList.add("display_none");
        foodContentBox.addEventListener("mouseover",foodBackGroundHandler);
    })
}

const resellBackGroundHandler = () =>{
    resellBackGround.classList.remove("display_none");
    resellBackGround.classList.add("transfrom_scale");
    resellContentBox.removeEventListener("mouseover",resellBackGroundHandler);

    resellContentBox.addEventListener("mouseout",()=>{
        resellBackGround.classList.remove("transfrom_scale");
        resellBackGround.classList.add("display_none");
        resellContentBox.addEventListener("mouseover",resellBackGroundHandler);
    })
}

const homeIntroduceInit = () =>{

    foodContentBox.addEventListener("mouseover",foodBackGroundHandler);

    resellContentBox.addEventListener("mouseover",resellBackGroundHandler);
}

//-----------------------------------------------------------

if(mainContentBox != null){
    homeIntroduceInit();
}

if(menuContainer!= null){
    menuinit();
}