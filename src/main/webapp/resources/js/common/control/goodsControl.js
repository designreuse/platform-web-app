//货品分类控件
	function loadGoodsControl(){
		jQuery.post(window.ctx+"/goodsclass/control",goodsControlCallBack);
	}
//危险品分类控件
	function loadHzCodeControl(){
		jQuery.post(window.ctx+"/goods/control",hzCodeControlCallBack);
	}
	
	function goodsControlCallBack(list){
		jQuery("#mlist dt").remove();
		jQuery("#mlist dd").remove();
		var goodsStr = "";
		for(var i=0;i<list.length;i++){
			var goodsclass = list[i].goodsClass;
			var goodsList = list[i].goodsList;
			
			goodsStr += '<dt class="lv1 lvshow br"><span class="ftbold">'+goodsclass.name+'</span></dt>';
			goodsStr += '<dd class="lv2">';
			for(var j=0;j<goodsList.length;j++){
				var goods = goodsList[j];
				goodsStr += '<p><label for="'+goods.id+'" class="ckname">'+goods.goodsName+'</label></p>';
			}
			goodsStr += '</dd>';
		}
		jQuery("#mlist").append(goodsStr);
		lv1();
		SelectGoods();
	}
	
	function hzCodeControlCallBack(list){
		jQuery("#mlist dt").remove();
		jQuery("#mlist dd").remove();
		var hzCodeStr = "";
		for(var i=0;i<list.length;i++){
			var hzTypeEntity = list[i].hzTypeEntity;
			var hzCodeList = list[i].hzCodeList;
			
			hzCodeStr += '<dt class="lv1 lvshow br"><span class="ftbold">'+hzTypeEntity.hzTypeName+'</span></dt>';
			hzCodeStr += '<dd class="lv2">';
			for(var j=0;j<hzCodeList.length;j++){
				var hzCodes = hzCodeList[j];
				hzCodeStr += '<p><label for="'+hzCodes.id+'" class="ckname">'+hzCodes.hzName+'</label></p>';
			}
			hzCodeStr += '</dd>';
		}
		jQuery("#mlist").append(hzCodeStr);
		lv1();
		SelectGoods();
	}
	
	function lv1(){
		$("#mlist dt").click(function(){
			//获取最新的数据
			if($(this).hasClass("lvshow"))
			{
				$(this).removeClass("lvshow");
				$(this).next(".lv2").addClass("hide");
		    }
			else{
			   $(this).addClass("lvshow");
			   $(this).next(".lv2").removeClass("hide");
		    }
		});
	}
	
	 var SelectGoods=function()
	 {
		 $(".goods-choose").click(function()
		 {
			 var left=$(this).offset().left;
			 var top=$(this).offset().top+5;
			 $(".goods-win").removeClass("hide").css({"position":"absolute","left":left,"top":top});	
	     });
		
		 
			  $(".goods-win").hover(
			 
			    function(){$(this).removeClass("hide");},
				function(){$(this).addClass("hide");}
			 ); 
		   $(".goods-choose").blur(function()
		     {
				 
		   $(".lv2 .ckname").click(function()
			 {
			  $(".goods-choose").val($(this).text());
			  $(".goods-chooseId").val($(this).attr("for"));
			   $(".goods-win").addClass("hide");
			 });
			 //获取浏览器在页面上的位置
	        
	           
			 });
			 
		 }
