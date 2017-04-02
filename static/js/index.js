$(function() {
	/*index*/
	$('.module3 .company').hover(function(){
		$(this).find('.score').stop(true,true).fadeToggle(200);
	});

	/*banner imgslide*/
    var unslider = $('.imgslide').unslider({
		speed: 500,               //  The speed to animate each slide (in milliseconds)
		delay: 5000,              //  The delay between slide animations (in milliseconds)
		complete: function() {},  //  A function that gets called after every slide animation
		keys: true,               //  Enable keyboard (left, right) arrow shortcuts
		dots: true,               //  Display dot navigation
		fluid: false              //  Support responsive design. May break non-responsive designs
	});
    $('.unslider-arrow').click(function() {
        var fn = this.className.split(' ')[1];
        unslider.data('unslider')[fn]();
    });

    var unslider2 = $('.imgslide2').unslider({
		speed: 500,              
		complete: function() {},  
		keys: true,               
		dots: false,              
		fluid: false             
	});
    $('.unslider-arrow2').click(function() {
        var fn = this.className.split(' ')[1];
        unslider2.data('unslider')[fn]();
    });

    var unslider3 = $('.imgslide3').unslider({
		speed: 500,              
		delay: 3000,             
		complete: function() {}, 
		keys: true,               
		dots: true,              
		fluid: false             
	});
    $('.unslider-arrow3').click(function() {
        var fn = this.className.split(' ')[1];
        unslider3.data('unslider')[fn]();
    });

    var unslider4 = $('.imgslide4').unslider({
		speed: 500,               
		delay: 3000,             
		complete: function() {}, 
		keys: true,               
		dots: true,             
		fluid: false             
	});
    $('.unslider-arrow4').click(function() {
        var fn = this.className.split(' ')[1];
        unslider4.data('unslider')[fn]();
    });

    var unslider5 = $('.imgslide5').unslider({
		speed: 500,              
		delay: 3000,              
		complete: function() {},  
		keys: true,               
		dots: false,               
		fluid: false             
	});
    $('.unslider-arrow5').click(function() {
        var fn = this.className.split(' ')[1];
        unslider5.data('unslider')[fn]();
    });

	$('.sec_top_li').on('click', function(){
		var _self = $(this),
			type = _self.attr('data-type'),
			$secTips = $('#secTips');
		$('#jsWantType').val(type);
		_self.siblings().removeClass('on');
		_self.addClass('on');
		$('.index_ico_arrow').css('left', 38 + 77*$(this).index()+'px');
		$('#jsDemandForm > #name').focus();
		switch (type){
			case '1':
				$secTips.html('快速获取课程资讯信息');
				break;
			case '2':
				$secTips.html('提交教师信息，快速获取教师资讯');
				break;
		}
	});

    $('#jsDemandBtn').on('click', function(){
        perfect_demand_form_submit({
            jsPerfectSubmit: this,
            jsPerfectForm: '#jsDemandForm',
            jsPerfetTips:'#jsDemandTips',
            isIndex: 'index'
        });
    });

});

