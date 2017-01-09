function AdrInputPopDiv(){
  this.init=function(inpuId, isAbsolute) {
    var dizhiDiv = null;
    var initInput = null;
    if (isAbsolute){
      $(".manage-wrapper").append($(provinceObjectDiv).html());
      var dizhiDiv = $(".manage-wrapper").children(".dizhi_t");
      $(".manage-wrapper").on("click", ".dizhi_city", function(e){
        var curThis = $(this);
        //var top = curThis.outerHeight();
        var left = 0;
        //dizhiDiv.css({top:top, left:left});
        if (initInput && curThis.offset().top != initInput.offset().top && dizhiDiv.is(":visible")){
          dizhiDiv.hide();
        }
        dizhiDiv.toggle();//.css("display", "block");
        initInput = $(this);
      });
    }else{
      initInput = $("#" + inpuId);
      //$(".dizhi_t").appendTo(initInput.parent());
      //initInput.parent().append($(".dizhi_t").parent().html());
      //display: inline-block;
      var _wrap = $('<span style="position:relative;padding:0;z-index:995"></span>');
      initInput.wrap(_wrap);
      initInput.parent().append($(provinceObjectDiv).html()).closest('div').css('overflow','visible');
      dizhiDiv = initInput.parent().children(".dizhi_t");
      initInput.click(function(e){
        var dizhiClsDiv = initInput.closest(".dizhi");
        if (dizhiClsDiv.length > 0){
          var dizhiPar = $("#consignee", dizhiClsDiv).parent();
          if (dizhiPar.hasClass("errorWrap")){
            dizhiPar.css("z-index", 996);
          }
          dizhiPar = $("#consignAdr", dizhiClsDiv).parent();
          if (dizhiPar.hasClass("errorWrap")){
            dizhiPar.css("z-index", 994);
          }
          
          dizhiPar = $("#consignPhone", dizhiClsDiv).parent();
          if (dizhiPar.hasClass("errorWrap")){
            dizhiPar.css("z-index", 993);
          }
          
          //dizhiPar = $("#initConsignAdrCity", dizhiClsDiv).parent();
          //dizhiPar.css("z-index", 995).css("display", "");
        }
        dizhiDiv.toggle();//.css("display", "block");
      });
    }
    dizhiDiv.on('click', '.dizhi_t_1 p', function(e){
      var idx = $(this).attr("idx");
      $(this).parent().find("p").removeClass("hover");
      dizhiDiv.find(".province").css("display", "none");
      dizhiDiv.find(".city").css("display", "none");
      dizhiDiv.find(".area").css("display", "none");
      if (idx == 1){
        $(this).addClass("hover");
        dizhiDiv.find(".province").css("display", "block");
      }else if(idx == 2){
        $(this).addClass("hover");
        dizhiDiv.find(".city").css("display", "block");
      }else if(idx == 3){
        $(this).addClass("hover");
        dizhiDiv.find(".area").css("display", "block");
      }else if(idx == 4){
        $(this).addClass("hover");
        initInput.val("请选择城市");
        initInput.attr("请选择城市");
        initInput.trigger("click");
        dizhiDiv.find('.dizhi_t_1 p[idx=1]').trigger("click");
      }
    });
    
    var selPro = "";
    var selCity = "";
    var proFullName = {"北京":"北京", "天津":"天津", "内蒙古":"内蒙古自治区", "上海":"上海"
      , "广西":"广西壮族自治区", "重庆":"重庆", "西藏":"西藏自治区", "宁夏":"宁夏回族自治区"
      , "新疆":"新疆维吾尔自治区", "香港":"香港特别行政区", "澳门":"澳门特别行政区"};
    dizhiDiv.on('click', '.province .dizhi_t_2_2 p', function(e){
      var pro = $(this).text();
      if (proFullName[pro]){
        pro = proFullName[pro];
      }else{
        pro += "省";
      }
      selPro = pro;
      var city = "";
      $.each(provinceObject[pro], function(v){
        city += "<p style='width:auto;padding-right: 6px;'>" + v + "</p>";
      });
      var cityDiv = dizhiDiv.find(".city .dizhi_t_2 .dizhi_t_2_2");
      cityDiv.html("");
      $(city).appendTo(cityDiv);
      
      dizhiDiv.find('.dizhi_t_1 p[idx=2]').trigger("click");
      
      initInput.val(selPro + "-");
      initInput.attr("title", initInput.val());
    });
    
    dizhiDiv.on('click', '.city .dizhi_t_2_2 p', function(e){
      var city = $(this).text();
      selCity = city;
      var area = "";
      $.each(provinceObject[selPro][city], function(idx, v){
        area += "<p style='width:auto;padding-right: 6px;'>" + v + "</p>";
      });
      var areaDiv = dizhiDiv.find(".area .dizhi_t_2 .dizhi_t_2_2");
      areaDiv.html("");
      $(area).appendTo(areaDiv);
      
      dizhiDiv.find('.dizhi_t_1 p[idx=3]').trigger("click");
      
      initInput.val(selPro + "-" + selCity + "-");
      initInput.attr("title", initInput.val());
    });
    
    dizhiDiv.on('click', '.area .dizhi_t_2_2 p', function(e){
      var area = $(this).text();
      initInput.val(selPro + "-" + selCity + "-" + area);
      initInput.attr("title", initInput.val());
      
      initInput.trigger("click");
    });
    
    $(document).on('click',function(e){
      var target  = e.target || e.srcElement;
      if (target.id == inpuId){
        e.preventDefault();
        return;
      }
      $('.dizhi_t').each(function(){
        if($(target).closest(this).length == 0 
          && $(this).parent().find("input[id='" + inpuId + "']").attr("id") == inpuId
            && $(this).is(':visible')){
          $(this).hide();
        }
      });
    });
    
    $(".wrapper").off("keypress", ".dizhi_city_detail").on('keypress', ".dizhi_city_detail" , function(e){
      var allowedReg = new RegExp('[,]');
      var charCode = typeof e.charCode != 'undefined' ? e.charCode : e.keyCode; 
      var keyChar = String.fromCharCode(charCode);
      if(allowedReg.test(keyChar)){
        e.preventDefault();
        return;
      };
    }).off("blur", ".dizhi_city_detail").on('blur', ".dizhi_city_detail", function(){
      var val = $(this).val();
      if (val.indexOf(",") != -1){
        $(this).val(val.replace(/,/g, ''));
      }
    });
  };
};
