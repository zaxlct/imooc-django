function verify(array) {
    var i = 0,length = array.length;
    for(i;i<length;i++) {
        newBlur(array[i]);
    }
}

function newBlur(obj){
    var _this = $(obj.id);
    _this.blur(function () {
         var  validata = true;
         validata = _validate(obj,_this,validata);
    });
}

function verifySubmit(array){
    var i = 0,
        length = array.length,
        validata = true;
    for(i; i < length; i++) {
        var obj = array[i],
            _this = $(obj.id);
        validata = _validate(obj, _this, validata);
    }
    return validata;
}

function _validate(obj,_this,validata){
var tips = obj.tips,
        errorTips = obj.errorTips,
        regName = obj.regName,
        require = obj.require,
        repwd = obj.repwd,
        maxNum = $(obj.maxNum).val() || 0,
        minNum = $(obj.minNum).val() || 0,
        minlength = obj.minlength,
        strlength = obj.strlength,
        value = $.trim(_this.val()),
        reg;
        //为空验证
        if (require && value == '') {
            validata = _showValidateError(_this,tips);
        }else{
            if (regName && !Dml.regExp[regName].test(value)) {
                 validata = _showValidateError(_this,errorTips);
            }

    //最小长度
            if(minlength != undefined){
                if(value.length<=minlength){
                    validata = _showValidateError(_this,'输入长度需大于'+minlength+'位');
                }
            }

    //长度
            if(strlength != undefined){
                if(value.length != strlength){
                     validata = _showValidateError(_this,'输入长度必须为'+strlength+'位');
                }
            }

    //重复密码校验
            if(repwd != undefined){
                if(value != $(repwd).val()){
                    validata = _showValidateError(_this,Dml.Msg.erRePwd);
                }
            }
  //最大值检查
            if(obj.maxNum){
                if( +value > +maxNum){
                    validata = _showValidateError(_this,Dml.Msg.maxNum);
                }
            }

  //最小值检查
            if(obj.minNum){
                if( +value < +minNum ){
                    validata = _showValidateError(_this,Dml.Msg.minNum);
                }
            }

        }

        if(validata){
            _this.siblings('i').html(tips).hide();
            _this.parent().removeClass('errorput').addClass('rightput');
        }
    return validata;
}

function _showValidateError(elem,tips){
    elem.siblings('i').html(tips).css('display','inline-block').show();
    elem.parent().removeClass('rightput').addClass('errorput');
    return false;
}

$(function(){
    $('input').focus(function(){
        $(this).siblings('i').hide();
        $(this).parent().removeClass('errorput');
    })
})