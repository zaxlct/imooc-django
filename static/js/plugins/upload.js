/*******************************************************************************
* 异步上传文件兼容IE8，火狐和谷歌可用
* 实现单个多次上传不刷新
* 修改自：http://www.ponxu.com
* @author 柳伟伟 <702295399@qq.com>
* @version 1.3 (2015-6-14)
*******************************************************************************/
(function ($) {

    var frameCount = 0;
    var formName = "";

    var iframeObj = null;
    var state = {};


    //var fileHtml = "";
    var colfile = null;

    //清空值
    function clean(target) {

        var file = $(target);
        var col = file.clone(true).val("");
        file.after(col);
        file.remove();
        //关键说明
        //先得到当前的对象和参数，接着进行克隆（同时克隆事件）
        //将克隆好的副本放在原先的之后，按照顺序逐个删除，最后初始化克隆的副本
    }
    function ajaxSubmit(target) {

        var options = state.options;

        if (options.url == '' || options.url == null) {
            alert("无上传地址");
            return;
        }
        if ($(target).val() == '' || $(target).val() == null) {
            alert("请选择文件");
            return;
        }

        if (iframeObj == null) {

            var frameName = 'upload_frame_' + (frameCount++);
            var iframe = $('<iframe style="position:absolute;top:-9999px" ><script type="text/javascript"></script></iframe>').attr('name', frameName);
            formName = 'form_' + frameName;
            var form = $('<form method="post" style="display:none;" enctype="multipart/form-data" />').attr('name', formName);
            form.attr("target", frameName).attr('action', options.url);
            //

            var fileHtml = $(target).prop("outerHTML");


             colfile = $(target).clone(true);


            $(target).replaceWith(colfile)

            var formHtml = "";
            // form中增加数据域
            for (key in options.params) {
                formHtml += '<input type="hidden" name="' + key + '" value="' + options.params[key] + '">';
            }

            form.append(formHtml);

            form.append(target);

            iframe.appendTo("body");

            form.appendTo("body");


            iframeObj = iframe;
        }
        //禁用
        $(colfile).attr("disabled", "disabled");


        var canSend = options.onSend($(target), $(target).val());
        if (!canSend) {
            return;
        }

        var form = $("form[name=" + formName + "]");

        //加载事件
        iframeObj.bind("load", function () {
            var contents = $(this).contents().get(0);
            var data = $(contents).find('body').text();
            if ('json' == options.dataType) {
                data = window.eval('(' + data + ')');
            }

            options.onComplate(data);

            iframeObj.remove();
            form.remove();
            iframeObj = null;

            //启用
            $(colfile).removeAttr("disabled")
        });

        try {
            form.submit();
        } catch (Eobject) {
            console.log(Eobject)
            //alert(Eobject)
        }
    };
    //构造
    $.fn.upload = function (options) {
        if (typeof options == "string") {
            return $.fn.upload.methods[options](this);
        }
        options = options || {};
        state = $.data(this, "upload");
        if (state)
            $.extend(state.options, options);
        else {
            state = $.data(this, "upload", {
                options: $.extend({}, $.fn.upload.defaults, options)
            });
        }

        //var opts = state.options;

        //if (opts.url == '') {
        //    return;
        //}
    };
    //方法
    $.fn.upload.methods = {
        clean: function (jq) {
            return jq.each(function () {
                clean(jq);
            });
        },
        ajaxSubmit: function (jq) {
            return jq.each(function () {
                ajaxSubmit(jq);
            });
        },
        getFileVal: function (jq) {
            return jq.val()
        }
    };
    //默认项
    $.fn.upload.defaults = $.extend({}, {
        url: '',
        dataType: 'json',
        params: {},
        onSend: function (obj, str) { return true; },
        onComplate: function () { return true; }
    });
})(jQuery);