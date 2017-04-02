

$(function(){
  var  oCon = $('.personal_list')
 oH3List = oCon.find('.drophead')
 oUlList = oCon.find('.drop')
 oDivList = oCon.find('.dropwrap')
 for(var i=0;i<oUlList.length;i++){
  oH3List[i].xuhao=i;
  oH3List[i].onclick=function(){
   clickNum =this.xuhao;
   changeCatalog();
  };
 }
})

var speed = 30;
var oCon = null; 
var oH3List = null;
var oDivList = null;
var oUlList = null;
var oldNum = null;
var clickNum = null;
var hideTimer=null;
var showTimer=null;
 
function changeCatalog(){
 var old_num_2,click_num_2;
 old_num_2 = null;
 click_num_2= null;
 if(oldNum==null){
  click_Num_2=clickNum;
  showTimer = setInterval("showUl("+click_Num_2+")",speed);
 }else if(oldNum == clickNum){
  old_num_2=oldNum;
  hideTimer = setInterval("hideUl("+old_num_2+")",speed);
 }else{
  old_num_2=oldNum;
  click_num_2=clickNum;
  hideTimer = setInterval("hideUl("+old_num_2+")",speed);
  showTimer = setInterval("showUl("+click_num_2+")",speed);
 }
}
function showUl(num){
 
 var move_num1 =Math.ceil((oUlList[num].offsetHeight-oDivList[num].offsetHeight)/10);
 if(move_num1>=1){
  oDivList[num].style.height = oDivList[num].offsetHeight+move_num1+"px";
 }else{
  oldNum=num;
  clearInterval(showTimer);
 }
}
function hideUl(num){
 var move_num2=Math.ceil((oDivList[num].offsetHeight)/10);
 if(move_num2>0){
  oDivList[num].style.height=oDivList[num].offsetHeight -move_num2+"px";
 }else{
  clearInterval(hideTimer);
  if(clickNum==num){
   oldNum=null;
  }
 }
}