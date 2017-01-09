var LQ=jQuery;
LQ.selectUi={
	show:function(options){
		var def={
			id:"", //selectUi的ID值
			hiddenInput:"", //设置下拉列表获取值保存的字段；
			selectInit:"", //接收下拉表数据，数组[{name:name,value:value}]
			selectNext:"", //二级菜单值
			pulldown:function(){},//下拉列表选择后返回函数
			callback:function(){} //callback 初始插件时返回函数
		};
		var ini=$.extend(def,options);
		
		var $this=$("#"+ini.id);
		if($this.length<=0) return;
		
		$this.css({zIndex:10});
		$this.addClass("select_ul_ui");
		
		if(ini.selectInit){
			if(typeof(ini.selectInit)=='object'){
				var option='';
				if(typeof(ini.selectInit[0]) != 'object' && ini.selectInit[0]=='') return;
				for(var i=0; i<ini.selectInit.length; i++){
					option+="<option value="+ini.selectInit[i]['AID']+">"+ini.selectInit[i]['AName']+"</option>";
					//option+="<option value="+ini.selectInit[i]['value']+">"+ini.selectInit[i]['name']+"</option>";
				}
				$this.children('select').remove();
				$this.append('<select>'+option+'</select>');
			}
			
		}
		
		var sel=$this.children("select");
		if(sel.length<=0) return;
		var sellen=sel.children("option").length;
		var ulid;
		var html="";
		sel.hide();
		
		if(ini.hiddenInput){
			$u=ini.hiddenInput;
		}else{
			$u=ini.id;
		}
		
		/*是否传值过来*/
		$val=$this.children(".selectfocus").attr("data-value");
		$options=sel.find("option");
		if($val != undefined){
			if($options.length==0){
				//获取同类值
				val=LQ.selectUi.getPreventData($val);
				LQ.selectUi.appendData(ini.id,val);
				LQ.selectUi.selectOption(sel,$val);
				
			}else{
				LQ.selectUi.selectOption(sel,$val);
				
			}
		}
		
		var items=0;
		for(var i=0; i<sel.children("option").length; i++){
			html+="<li data-val="+sel.children("option").eq(i).val()+">"+sel.children("option").eq(i).html()+"</li>";
			items++;
			
		}
		ulid="ul_"+$u;
		$this.append('<input type=\"hidden\" name=\"'+$u+'\" id=\"'+$u+'\" />');
		
		/*传值后设置hidden值*/
		
		if($val != undefined){
			LQ.selectUi.setHiddenValue($this,$val);
		}
		
		/*是否已经选定值*/
		if(sel.find("option[selected]").text() != ''){
			$this.children(".selectfocus").html('<em>'+sel.find("option[selected]").text()+'</em>');
			$("#"+ini.hiddenInput).val(sel.find("option[selected]").val());
		}
		
		$this.children("#"+ulid+"").remove();
		$this.append('<ul id='+ulid+'>'+html+'</ul>');
		
		var ul=$this.children("ul");
		if(items>10){
			ul.height(200);
		}
		
		ini.callback();
		
		ul.css({zIndex:11}).width($this.width()-2);
		ul.children("li").bind("click",function(e){
			e.stopPropagation();
			$(this).parent().siblings('.selectfocus').html('<em>'+$(this).text()+'</em>');
			$(this).parent().siblings('input[type="hidden"]').val($(this).attr("data-val"));
			ulStatus();
			ini.pulldown();
			
			if(ini.selectNext){
				LQ.selectUi.selectFun(ini.selectNext,$(this).attr("data-val"));
			}
		});
		
		$this.bind("click",function(e){
			e.stopPropagation();
			var id=$(".select_ul_ui").index($this); //获取索引值
			ulhide(id);
			ulStatus();
		});
		
		$(document).bind("click",function(e){
			var status=ul.css("display");
			if(status!="none"){
				ul.hide();
				ul.parent().css({zIndex:11});
			}
		})
		
		function ulStatus(){
			if(ul.css("display")=="none"){
				ul.show();
				ul.parent().css({zIndex:13});
			}else{
				ul.hide();
				ul.parent().css({zIndex:11});
			}
		}
		
		function ulhide(id){
			var len=$(".select_ul_ui").length;
			if(len==0) return;
			for(var i=0; i<len; i++){
				if(i!=id){
					$(".select_ul_ui").eq(i).children("ul").hide().parent().css({zIndex:11});
				}
			}
		}
		
	},
	selectOption:function($sel,$val){
		if($val==undefined) return;
		$sel.find("option").each(function(index,element){
			if($(element).val()==$val){
				$(element).attr("selected","true");
			}
		})
	},
	setHiddenValue:function($this,$val){
		if($val==undefined) return;
		$this.children('input[type="hidden"]').val($val);
	},
	selectFun:function(obj,value){
		var id = obj['selectid'];
		$("#"+id).show();
		$("#"+id).children('.selectfocus').html('<em>'+obj['selectTxt']+'</em>');
		$("#"+id).children('input[type="hidden"]').val('');
		LQ.selectUi.appendData(id,value);
		$("#"+id).find("li").bind("click",function(e){
			e.stopPropagation();
			$(this).parent().siblings('.selectfocus').html('<em>'+$(this).text()+'</em>');
			$(this).parent().siblings('input[type="hidden"]').val($(this).attr("data-val"));
			$(this).parent().hide().css({zIndex:11});
		});
	},
	appendData:function(id,val){
		var items=0;
		var value=LQ.selectUi.getData(val);
		if(value){
			if(typeof(value)=='object'){
				var option='';
				var listr='';
				if(typeof(value[0]) != 'object' && value[0]=='') return;
				for(var i=0; i<value.length; i++){
					option+="<option value="+value[i]['AID']+">"+value[i]['AName']+"</option>";
					listr+="<li data-val="+value[i]['AID']+">"+value[i]['AName']+"</li>";
					items++;
				}
				$("#"+id).children("select").empty();
				$("#"+id).children("select").append(option);
				$("#"+id).children("ul").empty();
				$("#"+id).children("ul").append(listr);
			}
		}
		
		var ul=$("#"+id).children("ul");
		if(items>10){
			ul.height(200);
		}else{
			ul.height('');
		}
		
	},
	getData:function(value){
		var html=[];
		for(var i=0; i<areas.length; i++){
			if(areas[i]["APid"]==value){
				html.push(areas[i]);
			}
		}
		return html;
	},
	getPreventData:function(value){
		var $id=null;
		for(var i=0; i<areas.length; i++){
			if(areas[i]["AID"]==value){
				$id=areas[i]["APid"];
			}
		}
		return $id;
	}
}