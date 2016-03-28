

/*====================================
	
	网站：杭州江城-股骨头坏死病因
	
	时间：2015.05.21

====================================*/





$(function(){
	
	$("body").Position({
		Pos_Menu:'#position_menu dl dd',//导航
		Pos_Position:'#position_menu',//导航浮动
		Pos_Content:'.position_con',//对应主题内容
		Pos_Current:'position_color',//对应背景
		Pos_Top:"#menu"//导航距离顶部高度
		})
	
	
	var oThree = $("#three");
	oThree.find("dl dd").each(function(){
		$(this).hover(function(){
			$(this).find("p").stop(true, true).animate({opacity:"0.5"}, 300);
			$(this).find("span").stop(true, true).animate({opacity:"1"}, 300);
			}, function(){
				$(this).find("p").stop(true, true).animate({opacity:"0"}, 100);
				$(this).find("span").stop(true, true).animate({opacity:"0"}, 100);
				})
		})
	
	var oSix = $("#six");
	oSix.find("ul li").each(function(_this){
		$(this).hover(function(){
			$(this).addClass("current").siblings().removeClass("current");
			oSix.find("dl dd").eq(_this).show().siblings().hide();
			})
		})
	
	var oSeven = $("#seven");
	oSeven.find("ul li").each(function(_this){
		$(this).hover(function(){
			$(this).addClass("current").siblings().removeClass("current");
			oSeven.find("dl dd").eq(_this).show().siblings().hide();
			})
		})
	
	
	})
