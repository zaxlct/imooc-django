$(function() {
	comment_toggle();
	submit_comment();
	page_commment('1');
	click_load_more();
	$('#loadmore_page').val(1);

})
// 回复事件
function re_keyup(e){
    if(e.keyCode== 46||e.keyCode== 8){
        if($(this).attr("vu").length>=$(this).val().length||!($(this).val().indexOf($(this).attr("vu"))>-1)){
            $(this).val($(this).attr("vu"));
        }
    }
}
String.prototype.trim=function(){
　　    return this.replace(/(^\s*)|(\s*$)/g, "");
　　 }
function comment_toggle(){
	$('.com_child_toggle').live('click',function(){
		 $(this).toggle(function(){
		 	$(this).parent().parent().find('>div:last').css('display','block').find("textarea").focus().val("回复"+$(this).next().html()+":").attr("vu","回复"+$(this).next().html()+":");
		 	$(this).parent().parent().find('>div:last').find('textarea').keyup(re_keyup);
			 child_uid = "child_"+$(this).nextAll("span:last").html();
		 	$(this).parent().parent().find('>div:last').find('.btnbox').attr("id",child_uid);
		 },function(){
		 	$(this).parent().parent().find('>div:last').css('display','none').find("textarea").focus().val("回复"+$(this).next().html()+":");
		 }).trigger('click');
	});


}

function submit_comment(){
	var lesson_id = $("#lesson-id").val();
	var	picurl = $('#pic_url').val();
	var	cur_name = $('#cur_name').val();
	var	is_teacher = $('#is_teacher').val();
	var	teacher = "";
		if(is_teacher =='True'){
			teacher = '<span class="grade">老师</span>';
		}
	//zhouyi:8-5
	$('#release_com').click(function(){

		comment = $(this).parent().parent().find('textarea:first').val();
		if(comment.trim()=='') {
			layer.tips('内容不能为空!', '.comment-input .btnbox>button', {tips: [2, '#68c8b6']});
			return;
		}
		parent_id = ""
		child_uid = ""
		cur_name = $('#cur_name').val();
		uid = $('#use_id').val();
		com_id= ajax_submit_comment(comment,lesson_id,parent_id,child_uid);
		getopage(1,com_id);
		//str_div = '<ul class="media-list"><li class="media"> <a href="javascript:void(0);" class="pull-left"><img src="'+picurl+'" class="media-object"></a><div class="media-body"><h4 class="media-heading"><a class="com_toggle" href="javascript:;">回复</a><span class="user-name">'+cur_name+'</span>'+teacher+'<span class="time">刚刚</span><span class="child_uid">'+uid+'</span></h4><p>'+comment+'</p><div class="media child_comment" style="display: none;"><a class="pull-left" href="javascript:void(0);"><img class="media-object" src="'+picurl+'"></a><div class="media-body"><h4 class="media-heading"><span class="user-name">'+cur_name+'</span></h4><div class="comment-input"><textarea class="form-control" rows="3" placeholder="我要评论"></textarea><div class="btnbox"><button type="button" class="btn btn-micv5 btn-lg-fts reply com_'+com_id+'">回复</button></div></div></div></div></div></li></ul>';
        if(comment!=""){
			//$("#commentbox").after(str_div);
			$('#load_message').css("display","none");
			$('.comment_area').val('');
		}
	});

	$('.reply').live("click",function(){
		comment = $(this).parent().parent().find('textarea:first').val();
		if(comment.trim()=='') {
			layer.tips('内容不能为空!', '.comment-input .btnbox>button', {tips: [2, '#68c8b6']});
			return;
		}
		classname = $(this).attr('class');
		arr = classname.split(" ");
		parent_id = arr[4].split("_")[1];
		child_id = $(this).parent().attr("id");
		child_uid = child_id.split("_")[1];
		ajax_submit_comment(comment,lesson_id,parent_id,child_uid);
		str_div = '<div class="media"><a href="javascript:void(0);" class="pull-left"><img src="'+picurl+'" class="media-object"></a><div class="media-body"><h4 class="media-heading"><a class="com_child_toggle" href="javascript:;">回复</a><span class="user-name">'+cur_name+'</span>'+teacher+'<span class="time">刚刚</span><span class="child_uid">'+child_uid+'</span></h4><div class="zy_shou"><p class="t5o">'+html_encode(comment)+'</p><p>查看更多</p></div></div></div>';
		str_div=$(str_div);
		if(comment!=""){
			$(this).parents('.child_comment').before(str_div);
			// $(this).parent().parent().find('textarea:first').val("");
			$(this).parents('.child_comment').hide();

			str_div.find(".zy_shou").each(function(){
				if($(this).children().eq(0).height()>114){
					$(this).children().eq(0).height(114);
					$(this).children().eq(1).show();
					$(this).children().eq(1).unbind().click(function(){
						console.log($(this).prev().height())
						if($(this).prev().height()<=114) {
							$(this).prev().height("auto");
						}
						else{
							$(this).prev().height(114);
						}
					});
				}
			});

		}
		// $(this).parents('.child_comment').find("textarea").html('sssssssss');
	});

}

function ajax_submit_comment(comment,lesson_id,parent_id,child_uid){
	var p_id = "";
	// if(typeof(parent_id) == "undefined"){
	// 	parent_id = "";
	// }
	// if(typeof(parent_uid) == "undefined"){
	// 	parent_id = "";
	// }
	$.ajax({
		    type: "POST",
		    async: false,
		    url:"/course/add/comment/",
		    data:{comment:comment,parent_id:parent_id,lesson_id:lesson_id,child_uid:child_uid},
		    success: function(data) {
		    	p_id = data.com_pn;
		    }
	});
	return p_id;

}
//zhouyi8-6
function html_encode(str)   
{   
  var s = "";   
  if (str.length == 0) return "";   
  s = str.replace(/&/g, "&gt;");   
  s = s.replace(/</g, "&lt;");   
  s = s.replace(/>/g, "&gt;");   
  s = s.replace(/ /g, "&nbsp;");   
  s = s.replace(/\'/g, "&#39;");   
  s = s.replace(/\"/g, "&quot;");   
  s = s.replace(/\n/g, "<br>");   
  return s;   
}   
 
function html_decode(str)   
{   
  var s = "";   
  if (str.length == 0) return "";   
  s = str.replace(/&gt;/g, "&");   
  s = s.replace(/&lt;/g, "<");   
  s = s.replace(/&gt;/g, ">");   
  s = s.replace(/&nbsp;/g, " ");   
  s = s.replace(/&#39;/g, "\'");   
  s = s.replace(/&quot;/g, "\"");   
  s = s.replace(/<br>/g, "\n");   
  return s;   
}

function page_commment(page){
	var lesson_id = $("#lesson-id").val();
	if(page<=0) page=1;
    $.ajax({
            type: "get",
            url:'/lesson/comment/?lessonid='+lesson_id+'&page='+page,
            async: true,
            success: function(data) {
            	data = $.trim(data);
            	if(data){
            		$('#comment_list').html(data);
            		$('#load_message').css("cursor","pointer").html('');

					$('#comment_list').find(".zy_shou").each(function(){
						if($(this).children().eq(0).height()>114){
							$(this).children().eq(0).height(114);
							$(this).children().eq(1).show();
							$(this).children().eq(1).unbind().click(function(){
								console.log($(this).prev().height())
								if($(this).prev().height()<=114) {
									$(this).prev().height("auto");
									$(this).html("收起");
								}
								else{
									$(this).prev().height(114);
									$(this).html("查看更多");
								}
							});
						}
					});

            	}else{
            		if(page == 1){
            			$('#load_message').html('沙发空缺中，还不快抢！');
            		}else{
            			$('#load_message').html('没有更多评论了');
            		}
            	}
            }
        });
}

function click_load_more(){
	$('#load_message').click(function(){
		page = $('#loadmore_page').val();
		page = parseInt(page) + 1;
		$('#loadmore_page').val(page);
		page_commment(page);
	});
}
function getopage(zbn,num){
	page_commment(zbn);
	$(".zypage_div").zPages({
		perPage : num, //总页数
		first:"",
        last:"",
		funC:page_commment,
		startPage:zbn
	});
}