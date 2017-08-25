$(function() {

	//轮播图JS
	$(".main_visual").hover(function() {
		$("#btn_prev,#btn_next").fadeIn()
	}, function() {
		$("#btn_prev,#btn_next").fadeOut()
	})
	$dragBln = false;
	$(".main_image").touchSlider({
		flexible: true,
		speed: 200,
		btn_prev: $("#btn_prev"),
		btn_next: $("#btn_next"),
		paging: $(".flicking_con a"),
		counter: function(e) {
			$(".flicking_con a").removeClass("on").eq(e.current - 1).addClass("on");
		}
	});
	$(".main_image").bind("mousedown", function() {
		$dragBln = false;
	})
	$(".main_image").bind("dragstart", function() {
		$dragBln = true;
	})
	$(".main_image a").click(function() {
		if($dragBln) {
			return false;
		}
	})
	timer = setInterval(function() { $("#btn_next").click(); }, 3000);
	$(".main_visual").hover(function() {
		clearInterval(timer);
	}, function() {
		timer = setInterval(function() { $("#btn_next").click(); }, 3000);
	})

	//客服浮动栏
	$('.wx_ico').hover(function() {
		$('.float_contact_bar_wx').toggle();
	})
	$('.kf_ico').hover(function() {
		$('.float_contact_bar_qq').toggle();
	})
	var $top = $('.top_ico');
	$top.hide();
	$(window).scroll(function() {
		if($(this).scrollTop() > 1) {
			$top.fadeIn();
		} else {
			$top.fadeOut();
		}
	});
    $top.click(function(){
        $("html,body").animate({scrollTop:0},800);
        return false;
    });


	//页面滚动导航动态显示隐藏
	var maxScrollTop = 100;
	$(window).scroll(maxScrollTop, function(event) {
		var $me = $(this);
		var $head = $('.head');
		var $logo = $('.logo-img');
		if($me.scrollTop() > event.data) {
			$head.addClass('head-fixed');
			$logo.attr('src','../../images/index/logo_betterment_blue.png');
		} else {
			$head.removeClass('head-fixed');
			$logo.attr('src','../../images/index/logo_betterment.png');
		}
	})

	//显示语言切换
	var $language = $('.language a.active');
	$language.click(function() {
		$(this).parent().toggleClass('open');
		$(this).siblings().toggle();
		return false;
	})

	//自适应菜单子菜单动画
	$('.menu').click(function() {
		var data = {};
		data.height = '240px';
		var $mobNav = $('.mob-nav');
		if($mobNav.height() == '0') {
			$mobNav.animate(data, 200);
		} else {
			$mobNav.animate({ height: '0' }, 200);
		}

	});
	
	//tip
	$('.poshytip').poshytip({
		className: 'tip-twitter',
		showTimeout: 0,
		alignTo: 'target',
		alignX: 'right',
		alignY: 'center',
		offsetX: 5
	});

})