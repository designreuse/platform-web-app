



/*=========================

	时间：2015.07.16
	
	说明：导航悬浮

==========================*/


if($('#header_top').length > 0){
	positionFixed();
	}


function positionFixed(){
	var oHeaderTop = $('#header_top').offset().top;
	var oMessagePosition = $('#message_position');
	var oHeader = $('#header_top');
	var oPositionFixed = $('#position_fixed');
	
	var oPublicAClick = $('.public_a_click');
	var oPublicClickContent = $('.public_click_content');

	oPublicAClick.each(function(){
		$(this).click(function(){
			
			var _this = oPublicAClick.index(this);
			var oThisScr = oPublicClickContent.eq(_this).offset().top;
			$("body, html").animate({scrollTop:(oThisScr - 42)+'px'}, 500);
			
			})
		})
	
	
	$(window).bind("scroll", function(){
		var oScr = document.documentElement.scrollTop || document.body.scrollTop;
		if(oScr > (oHeaderTop - 50)){
			oHeader.css({marginTop:'60px'});
			oPositionFixed.css({margin:'0 20px'});
			oMessagePosition.css({width:'100%', left:'0px'})
			if(typeof document.body.style.maxHeight === 'undefined'){
				oMessagePosition.css({top:oScr+'px', postion:'absolute'});
				}else{
					oMessagePosition.css({top:'0px', position:'fixed'});
					}
			
			}else{
				oMessagePosition.css({position:'static', margin:'0px'});
				oHeader.css({marginTop:'0px'});
				oPositionFixed.css({margin:'20px 0 0 0'});
				}
		})
	}



/*=========================

	时间：2015.07.16
	
	说明：多选框

==========================*/




var oNewsAddCenter = $("#news_add_center td a");
var oNewsOutCenter = $("#news_out_center td a");
var oNewsInCenter = $("#news_in_center td a");
var oNewsRangeCenter = $("#news_range_center td a");
checkForm(oNewsAddCenter)
checkForm(oNewsOutCenter)
checkForm(oNewsInCenter)
checkForm(oNewsRangeCenter)

function checkForm(obj){
	
	obj.each(function(){
		$(this).click(function(){
			if($(this).hasClass('current')){
				$(this).removeClass('current');
				}else{
					$(this).addClass('current');
					}
			})
		})
	
	}



/*=========================

	时间：2015.07.16
	
	说明：审核弹窗

==========================*/




var oPublicExamine = $(".public_examine");
var oExamineClose = $(".examine_close");
var oExamineBoxBg = $("#examine_box_bg");
var oExamineBox = $("#examine_box");


oPublicExamine.each(function(){
	$(this).click(function(){
		
		var w = $(window).width();
		var h = $(window).height();
		
		oExamineBox.css({left:(w-502)/2+"px", top:(h-302)/2+"px"});
		
		oExamineBoxBg.show();
		oExamineBox.show();
		$(window).bind("scroll", function(){
			var oScr = document.documentElement.scrollTop || document.body.scrollTop;
			if(typeof document.body.style.maxHeight === 'undefined'){
				oExamineBox.css({position:'absolute', top:oScr + (h-302)/2+"px"});
				}else{
					oExamineBox.css({top:(h-302)/2+"px"});
					}
			})
		})
	})

oExamineClose.each(function(){
	$(this).click(function(){
		oExamineBoxBg.hide();
		oExamineBox.hide();
		})
	})
oExamineBoxBg.click(function(){
	oExamineBoxBg.hide();
	oExamineBox.hide();
	})


/*=========================

	时间：2015.07.23
	
	说明：新建贸易订单

==========================*/




var oPublicExamine = $(".public_examine");
var oExamineClose = $(".examine_close");
var oExamineBoxBg = $("#examine_box_bg1");
var oExamineBox = $("#examine_box1");


oPublicExamine.each(function(){
	$(this).click(function(){
		
		var w = $(window).width();
		var h = $(window).height();
		
		oExamineBox.css({left:(w-502)/2+"px", top:(h-302)/2+"px"});
		
		oExamineBoxBg.show();
		oExamineBox.show();
		$(window).bind("scroll", function(){
			var oScr = document.documentElement.scrollTop || document.body.scrollTop;
			if(typeof document.body.style.maxHeight === 'undefined'){
				oExamineBox.css({position:'absolute', top:oScr + (h-302)/2+"px"});
				}else{
					oExamineBox.css({top:(h-302)/2+"px"});
					}
			})
		})
	})

oExamineClose.each(function(){
	$(this).click(function(){
		oExamineBoxBg.hide();
		oExamineBox.hide();
		})
	})
oExamineBoxBg.click(function(){
	oExamineBoxBg.hide();
	oExamineBox.hide();
	})



