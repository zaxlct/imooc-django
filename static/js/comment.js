function getCookie(name) {
     var cookieValue = null;
     if (document.cookie && document.cookie != '') {
         var cookies = document.cookie.split(';');
         for (var i = 0; i < cookies.length; i++) {
             var cookie = jQuery.trim(cookies[i]);
             // Does this cookie string begin with the name we want?
             if (cookie.substring(0, name.length + 1) == (name + '=')) {
                 cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                 break;
             }
         }
     }
     return cookieValue;
 };

$(function(){
    function validateTextarea(val){
        if(val.length < 3){
            Dml.fun.showTipsDialog({
                title: '错误提示',
                h2: '评论字数不能少于3个字符！',
                type: 'failbox'
            });
            return false;
        }
        return true;
    }

    var userAvatar = $('#userAvatar').val();
    //textarea绑定focus，blur和字数
    $('.comenlist').on('focus','.wordbox',function(){
        $(this).parent('.text-box').addClass('text-box-on');
        $(this).keyup();
    });

    
    $('.comenlist').on('input propertychange','.wordbox',function(){
        var val = this.value;
        var len = val.length;
        var els = this.parentNode.children;
        var btn = els[1];
        var word = els[2];
        if (len <= 0 ) {
            word.innerHTML = '您没有输入内容';
            $(btn).addClass('btn-off');
        }else if(len > 140){
            word.innerHTML = '您已超出字数';
            btn.style.background='#ccc';
        }else{
            word.innerHTML = len + '/140';  
            btn.style.background='#717171';
        }
    });


    $('.praisebtn').click(function(){
        var txt = $(this).html();
        var btn = $(this);
        var praisesTotal = $(this).parent('div').find('.praiseword');
        var oldTotal = parseInt(praisesTotal.attr('total'));
        var newTotal;
        var newTotal2;

        var request_url = "/common/addpraise/"
        var typeid = 2
        if($(this).hasClass("collected")){
            request_url = "/common/delpraise/"
        }
        var csrftoken = getCookie('csrftoken');

        $.ajax({
            type:"POST",
            url: request_url,
            dataType:"json",
            async: true,
            data:{
                typeid: typeid,
                favid: $(this).attr("data"),
            },
            success:function(data){
                if (!btn.hasClass('collected')) {
                    newTotal = oldTotal + 1;
                    praisesTotal.attr('total', newTotal);
                    if(newTotal == 1){
                        praisesTotal.html('我觉得很赞');
                    }else{
                        praisesTotal.html(newTotal + '个人觉得很赞');
                    }
                    btn.html('取消赞').addClass('collected');
                }else{
                    newTotal2 = oldTotal-1;
                    praisesTotal.attr('total', newTotal2);
                    if(newTotal == 0){
                        praisesTotal.html('还没有人点赞');
                    }else{
                         praisesTotal.html( newTotal2 + '个人觉得很赞');
                    }
                    btn.html('点赞').removeClass('collected');
                }
            },
            beforeSend: function(xhr, settings) {
              xhr.setRequestHeader("X-CSRFToken", csrftoken);
            }

        });
    });

//是否登录控制
    if(isLogin == 'True'){
        $('.comenlist').on('mouseover','.btn',function(){
            $(this).parents('.textinput').find('.wordbox').blur().css('height','60px');
        });
        //评论楼主
       $('.commentbtn').on('click',function(){
            var _self = $(this),
                textarea = _self.parent().find('textarea:first'),
                comment = textarea.val(),
                diary_id = _self.attr("diaryid"),
                csrftoken = getCookie('csrftoken'),
                validate = validateTextarea(comment);
            if(!validate){
                return false;
            }
            $.ajax({
                type: "POST",
                url:"/diary/add_comment/",
                data:{
                    comment:comment,
                    diaryid:diary_id,
                },
                success: function(data) {
                    if (data.id){
                        var textareaval = textarea.val(),
                            len = textareaval.length,
                            evalbox =
                            '<div class="commentbox clearfix" >'+
                                '<div class="head"><img width="50" src="'+ userAvatar +'" alt=""/></div>'+
                                '<div class="comment-content2">' +
                                    '<div class="oldcomment">'+
                                        '<p class="comment-text"><span class="user"><i>我评论</i>：</span>' + textareaval + '</p>' +
                                        '<p class="comment-time">'+ Dml.fun.getDate() +'</p>' +
                                        '<p class="replycomment btn btntop" diaryid="'+diary_id+'" commentid="'+data.id+'" selfName="自己" parentName="自己">回复</p>'+
                                    '</div>'+
                                '</div>'+
                            '</div>';
                        _self.parents('.commentbox').after(evalbox);
                        textarea.val('');
                        $('.word').html('0/140');
                        $('.wordbox').blur();
                    }
                },
                beforeSend: function(xhr, settings) {
                  xhr.setRequestHeader("X-CSRFToken", csrftoken);
                }
            });
    });
        //点击显示评论某楼评论框
       $('.comenlist').on('click','.replycomment',function(){
           var _self = $(this),
                diary_id = _self.attr("diaryid"),
                comment_id = _self.attr("commentid"),
                parentName = _self.attr('parentName'),
                selfName = _self.attr('selfName'),
                evalbox =
                '<div class="replycommentbox textinput">'+
                    '<textarea class="replybox wordbox" autocomplete="off" maxlength="140" placeholder="回复'+ selfName +'..."></textarea>'+
                    '<button class="replycommentbtn btn btnbottom" diaryid="'+diary_id+'" commentid="'+comment_id+'" replyid="'+comment_id+'" selfName="'+selfName+'" parentName="'+parentName+'">回复</button>'+
                    '<span class="word"><span class="length">0</span>/140</span>'+
                '</div>';

            _self.parents('.comment-content2').find('.textinput').remove();
            _self.parents('.comment-content2').append(evalbox);
            _self.parents('.comment-content2').find('.replybox').focus();
        });

       //评论某楼
       $('.comenlist').on('click','.replycommentbtn',function(){
            var _self = $(this),
                textarea = _self.parent().find('textarea:first'),
                comment = textarea.val(),
                diary_id = _self.attr("diaryid"),
                comment_id = _self.attr("commentid"),
                parent_id = _self.attr("replyid"),
                parentName = _self.attr('parentName'),
                selfName = _self.attr('selfName'),
                csrftoken = getCookie('csrftoken'),
                validate = validateTextarea(comment);
            if(!validate){
                return false;
            }
            $.ajax({
                    type: "POST",
                    url:"/diary/add_comment/",
                    data:{
                        comment:comment,
                        diaryid:diary_id,
                        parentid:parent_id,
                        maincommentid:comment_id,
                    },
                    success: function(data) {
                        if (data.id){
                            var textareaval = _self.parent('.replycommentbox').find('.replybox').val(),
                                evalbox =
                                '<div class="replycommentword">' +
                                '<img class="myhead" src="'+ userAvatar+'" alt=""/>' +
                                '<p class="comment-text"><span class="user"><i>我</i> 回复 <i>'+ parentName +'</i>：</span>' + textareaval + '</p>' +
                                '<p class="comment-time">'+ Dml.fun.getDate() +'</p>' +
                                '<p class="replycsomeone btn btntop" diaryid="' + diary_id + '" commentid="' + data.id + '" replyid="'+parent_id+'" selfName="'+selfName+'" parentName="'+parentName+'">回复</p>' +
                                '</div>'
                            _self.parents('.comment-content2').append(evalbox);
                            _self.parents('.comment-content2').find('.replycommentbox').remove();
                        }
                    },
                    beforeSend: function(xhr, settings) {
                      xhr.setRequestHeader("X-CSRFToken", csrftoken);
                    }
            });
        });
        //点击显示回复某人textarea
        $('.comenlist').on('click','.replycsomeone',function(){
            var _self = $(this),
                diary_id = _self.attr("diaryid"),
                comment_id = _self.attr("commentid"),
                parent_id = _self.attr("replyid"),
                parentName = _self.attr('parentName'),
                selfName = _self.attr('selfName'),
                evalbox = '<div class="replysomeonebox textinput">'+
                                '<textarea class="replybox wordbox" autocomplete="off" maxlength="140" placeholder="回复'+ selfName +'..."></textarea>'+
                                '<button class="replysomeonebtn btn btnbottom" diaryid="'+diary_id+'" commentid="'+comment_id+'" replyid="'+parent_id+'" selfName="'+selfName+'" parentName="'+parentName+'">回复</button>'+
                                '<span class="word"><span class="length">0</span>/140</span>'+
                            '</div>';

            _self.parents('.comment-content2').find('.textinput').remove();
            _self.parents('.comment-content2').append(evalbox);
            _self.parents('.comment-content2').find('.replybox').focus();
        });

        //回复某人
        $('.comenlist').on('click','.replysomeonebtn',function(){
            var _self = $(this),
                textarea2 = _self.parent('.replysomeonebox').find('.replybox'),
                textareaval2 = textarea2.val(),
                textarea = _self.parent().find('textarea:first'),
                comment = textarea.val(),
                diary_id = _self.attr("diaryid"),
                comment_id = _self.attr("commentid"),
                parent_id = _self.attr("replyid"),
                parentName = _self.attr('parentName'),
                selfName = _self.attr('selfName'),
                csrftoken = getCookie('csrftoken'),
                validate = validateTextarea(comment);
            if(!validate){
                return false;
            }
            $.ajax({
                type: "POST",
                url:"/diary/add_comment/",
                data:{
                    comment:comment,
                    diaryid:diary_id,
                    parentid:parent_id,
                    maincommentid:comment_id,
                },
                success: function(data) {
                    if (data.id){
                        var evalbox =
                            '<div class="comment-box clearfix">'+
                                '<img class="myhead" src="'+ userAvatar +'" alt=""/>' +
                                '<div class="comment-content">' +
                                '<p class="comment-text"><span class="user"><i>我</i>' +' 回复 <i>'+ parentName +'</i>:</span>  '+ textareaval2 + '</p>' +
                                '<p class="comment-time">'+ Dml.fun.getDate() +'</p>' +
                                '<button class="replycsomeone btn btntop" diaryid="'+diary_id+'" commentid="'+comment_id+'" replyid="'+data.id+'" selfName="'+selfName+'" parentName="'+parentName+'">回复</button>'+
                                '</div>'+
                            '</div>'
                        _self.parents('.comment-content2 ').append(evalbox);
                        _self.parents('.comment-content2').find('.replysomeonebox').remove();
                    }
                },
                beforeSend: function(xhr, settings) {
                  xhr.setRequestHeader("X-CSRFToken", csrftoken);
                }
            });

        });
    }
});
