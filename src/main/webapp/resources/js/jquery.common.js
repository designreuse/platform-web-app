

/*====================================
	
	��վ�����ݽ���-�ɹ�ͷ��������
	
	ʱ�䣺2015.05.21

====================================*/





$(function(){
	
	$("body").Position({
		Pos_Menu:'#position_menu dl dd',//����
		Pos_Position:'#position_menu',//��������
		Pos_Content:'.position_con',//��Ӧ��������
		Pos_Current:'position_color',//��Ӧ����
		Pos_Top:"#menu"//�������붥���߶�
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
