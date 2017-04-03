var zyemail="",
    zyUname="",
    hash={
        'qq.com': 'http://mail.qq.com',
        'gmail.com': 'http://mail.google.com',
        'sina.com': 'http://mail.sina.com.cn',
        '163.com': 'http://mail.163.com',
        '126.com': 'http://mail.126.com',
        'yeah.net': 'http://www.yeah.net/',
        'sohu.com': 'http://mail.sohu.com/',
        'tom.com': 'http://mail.tom.com/',
        'sogou.com': 'http://mail.sogou.com/',
        '139.com': 'http://mail.10086.cn/',
        'hotmail.com': 'http://www.hotmail.com',
        'live.com': 'http://login.live.com/',
        'live.cn': 'http://login.live.cn/',
        'live.com.cn': 'http://login.live.com.cn',
        '189.com': 'http://webmail16.189.cn/webmail/',
        'yahoo.com.cn': 'http://mail.cn.yahoo.com/',
        'yahoo.cn': 'http://mail.cn.yahoo.com/',
        'eyou.com': 'http://www.eyou.com/',
        '21cn.com': 'http://mail.21cn.com/',
        '188.com': 'http://www.188.com/',
        'foxmail.coom': 'http://www.foxmail.com'
    },
    zy_c_num=60,
    zy_str="";

//激活邮箱事件
function zy_Countdown(){
    zy_c_num--;
    $(".sendE2 span").html(zy_c_num+"s");
    $(".zy_success span").html(zy_str);
    (zy_c_num<58)&&$(".zy_success").addClass("upmove");
    if(zy_c_num<=0){
        zy_c_num=60;
        $(".sendE2").hide();
        $(".sendE").show()
        return false;
    }
    setTimeout("zy_Countdown()",1000);
}

	//注册刷新验证码点击事件
	$('#email_register_form .captcha-refresh').click({'form_id':'email_register_form'},refresh_captcha);
	$('#email_register_form .captcha').click({'form_id':'email_register_form'},refresh_captcha);
	$('#mobile_register_form .captcha').click({'form_id':'jsRefreshCode'},refresh_captcha);
	$('#changeCode').click({'form_id':'jsRefreshCode'},refresh_captcha);
	$('#jsFindPwdForm .captcha-refresh').click({'form_id':'jsFindPwdForm'},refresh_captcha);
	$('#jsFindPwdForm .captcha').click({'form_id':'jsFindPwdForm'},refresh_captcha);
	$('#jsChangePhoneForm .captcha').click({'form_id':'jsChangePhoneForm'},refresh_captcha);

// 刷新验证码
function refresh_captcha(event){
    $.get("/captcha/refresh/?"+Math.random(), function(result){
        $('#'+event.data.form_id+' .captcha').attr("src",result.image_url);
        $('#id_captcha_0').attr("value",result.key);
    });
    return false;
}


//找回密码表单提交
function find_password_form_submit(){
 var $findPwdBtn = $("#jsFindPwdBtn"),
     $idAccount = $("#account");
     verify = verifyDialogSubmit(
        [
            {id: '#account', tips: Dml.Msg.epUserName, errorTips: Dml.Msg.erUserName, regName: 'phMail', require: true},
            {id: '#find-password-captcha_1', tips: Dml.Msg.epVerifyCode, errorTips: Dml.Msg.erVerifyCode, regName: 'verifyCode', require: true}
        ]
    );
    if(!verify){
       return;
    }

    $.ajax({
        cache: false,
        type: 'post',
        dataType:'json',
        url:"/user/password/find/",
        data:$('#jsFindPwdForm').serialize(),
        async: true,
        beforeSend:function(XMLHttpRequest){
            $findPwdBtn.val("提交中...")
            $findPwdBtn.attr("disabled","disabled")
        },
        success: function(data) {
             refresh_captcha({"data":{"form_id":"jsFindPwdForm"}});
            if(data.account){
                Dml.fun.showValidateError($idAccount,data.account);
            }else if(data.captcha_f){
                 Dml.fun.showValidateError($('#find-password-captcha_1'),data.captcha_f);
            }else{
                if($idAccount.val().indexOf("@") > 0 ){
                    Dml.fun.showTipsDialog({
                        title: '提交成功',
                        h2: '我们已经向你的邮箱'+ $idAccount.val() +'发送了邮件，请通过邮件中的链接修改密码。'
                    });
                    $('#jsFindPwdForm')[0].reset();
                    setTimeout(function(){window.location.href = window.location.href;},1500);
                }else{
                    if(data.status == 'success'){
                        $('#jsForgetTips').html("手机短信验证码已发送，请查收！").show();
                        $('#jsInpResetMobil').val($idAccount.val());
                        setTimeout(function(){Dml.fun.showDialog('#jsSetNewPwd')},1500);
                    }else if(data.status == 'failure'){
                        $('#jsForgetTips').html("手机短信验证码发送失败！").show();
                    }
                }
            }
        },
        complete: function(XMLHttpRequest){
            $findPwdBtn.val("提交");
            $findPwdBtn.removeAttr("disabled");
        }
    });
}



$('#jsSetNewPwdBtn').on('click', function(){
    var _self = $(this),
         $idAccount = $("#account");
         verify = verifyDialogSubmit(
            [
                {id: '#jsResetPwd', tips: Dml.Msg.epResetPwd, errorTips: Dml.Msg.erResetPwd, regName: 'pwd', require: true},
                {id: '#jsResetPwd2', tips: Dml.Msg.epRePwd, repwd: '#jsResetPwd', require: true},
                {id: '#jsResetCode', tips: Dml.Msg.epPhCode, errorTips: Dml.Msg.erPhCode, regName: 'phoneCode', require: true}
            ]
        );
    if(!verify){
       return;
    }

    $.ajax({
        cache: false,
        type: 'post',
        dataType:'json',
        url:"/user/mobile/resetpassword/",
        data:$('#jsSetNewPwdForm').serialize(),
        async: true,
        beforeSend:function(XMLHttpRequest){
            _self.val("提交中...")
            _self.attr("disabled","disabled")
        },
        success: function(data) {
            if(data.status == 'success'){
                Dml.fun.showTipsDialog({
                    title:'重置成功',
                    h2:'重置密码成功！'
                });
                $('#jsSetNewPwdForm')[0].reset();
                Dml.fun.winReload();
            }else if(data.status == 'faliuer'){
                 Dml.fun.showTipsDialog({
                    title:'重置失败',
                    h2:data.msg,
                    type:'failbox'
                })
            }else if(data.code){
                 Dml.fun.showValidateError($('#jsResetCode'), data.code);
            }
        },
        complete: function(XMLHttpRequest){
            _self.val("提交");
            _self.removeAttr("disabled");
        }
    });
})
