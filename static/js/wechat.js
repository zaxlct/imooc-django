(function($){
    $.fn.serializeJson=function(){
        var serializeObj={};
        var array=this.serializeArray();
        var str=this.serialize();
        $(array).each(function(){
            if(serializeObj[this.name]){
                if($.isArray(serializeObj[this.name])){
                    serializeObj[this.name].push(this.value);
                }else{
                    serializeObj[this.name]=[serializeObj[this.name],this.value];
                }
            }else{
                serializeObj[this.name]=this.value;
            }
        });
        return serializeObj;
    };
})(jQuery);
function showWebMsg(msg){
        var $tips = $('#tips') || '';
        if($tips.size() == 0){
            $tips = $('<div class="alert-tips" id="tips"></div>');
            $(document.body).append($tips);
        }
        if($tips.css('display')=='none'){
            $tips.text(msg).show();
            setTimeout(_returnTips,2000);
        }
        function _returnTips(){
            $tips.hide();
        }
    }
function showAlert(msg){
        var tmpFrame = document.createElement('iframe');
        tmpFrame.setAttribute('src', 'data:text/plain,');
        document.documentElement.appendChild(tmpFrame);
        var conf = window.frames[0].window.alert(msg);
        tmpFrame.parentNode.removeChild(tmpFrame);
    }
$(function(){
    FastClick.attach(document.body);
    document.body.addEventListener('touchstart', function () { });

    $("#focus").flexslider({
        direction:"horizontal",
        easing:"swing",
        animation :"slide",
        slideshowSpeed:"3000",
        directionNav: false,
        controlNav: true,
        prevText: "",
        nextText: ""
    });

    var opts = {
        theme: 'ios',
        mode: 'scroller',
        display: 'bottom',
        lang: 'zh',
        dateFormat: 'yy-mm-dd',
        timeFormat:'',
        timeWheels:'yymmdd',
        minDate: new Date(new Date().getFullYear(),new Date().getMonth(),new Date().getDate()),
        maxDate:new Date(new Date().getFullYear()+7,new Date().getMonth(),new Date().getDate())
    };
    $('#measureType').mobiscroll().datetime(opts);
    $('#deco_time').mobiscroll().datetime(opts);

	//input的focus和blur效果
	$('.box input').focus(function(){
		var div = $(this).parent('.box');
		div.attr('class','box');
		div.addClass('focus');
	});
	$('.box input').blur(function(){
		var div = $(this).parent('.box');
		div.attr('class','box');
		div.addClass('blur');
	});

    $('#jsPerfectSubmit2').on('click', function(){
        var $jsPerfectSubmit = $(this),
            $jsPerfectForm = $('#jsPerfectForm2'),
            $jsPerfetTips = $('#jsPerfetTips2'),
            paramJson = $jsPerfectForm.serializeJson(),
            errorMsg = '',
            is_validate = true;
           $.each(paramJson,function(name,val){
            if(!val){
                is_validate = false;
                switch (name){
                    case 'name':
                        $('#jsName').addClass('errorput');
                        errorMsg = errorMsg || Dml.Msg.epName;
                        break;
                    case 'mobile':
                        $('#jsMobile').addClass('errorput');
                        errorMsg = errorMsg || Dml.Msg.epPhone;
                        break;
                    case 'district_name':
                        $('#jsDistrictName').addClass('errorput');
                        errorMsg = errorMsg || Dml.Msg.epDistrictName;
                        break;
                    default :
                        is_validate = true;
                        break;
                }
            }else{
                if(name == 'mobile' && !Dml.regExp.phone.test(val)){
                    $('#jsMobile').addClass('errorput');
                    errorMsg = errorMsg || Dml.Msg.erPhone;
                    is_validate = false;
                }
            }
        });

         if(!is_validate){
            showWebMsg(errorMsg);
            return false;
        }

        $.ajax({
            cache: false,
            type: 'post',
            dataType:'json',
            url:'/company/add_require/',
            data:$jsPerfectForm.serialize(),
            async: true,
            beforeSend:function(XMLHttpRequest){
                $jsPerfectSubmit.val("提交中...")
                $jsPerfectSubmit.attr("disabled","disabled")
            },
            success: function(data) {
                if(data.status == 'success'){
                    $jsPerfectForm[0].reset();
                    showAlert('您的装修需求提交成功!相关公司稍后会与您联系，请留意电话。');
                    Dml.fun.winReload();
                }else if(data.status == 'failure'){
                    showAlert(data.msg);
                }
            },
            complete: function(XMLHttpRequest){
                $jsPerfectSubmit.val("立即提交");
                $jsPerfectSubmit.removeAttr("disabled");
            },
            error: function(xhr, error){
                showAlert(xhr.statusText);
            }
        });
    });
});