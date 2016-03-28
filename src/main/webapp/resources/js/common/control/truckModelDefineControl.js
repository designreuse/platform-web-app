//车型与属性分类控件
	function loadTruckModelControl(){
		jQuery.post(window.ctx+"/truckModelDefineAttributeRelation/control",truckModelControlCallBack);
	}
	
	function truckModelControlCallBack(list){
		jQuery("#mlist dt").remove();
		jQuery("#mlist dd").remove();
		var truckModelStr = "";
		for(var i=0;i<list.length;i++){
			var truckmodelDefine = list[i].truckmodelDefine;
			var truckmodelDefineList = list[i].truckmodelDefineList;
			
			truckModelStr += '<dt class="lv1 lvshow br"><span for="'+truckmodelDefine.parentId+'" class="ftbold">'+truckmodelDefine.truckModelName+'</span></dt>';
			truckModelStr += '<dd class="lv2">';
			for(var j=0;j<truckmodelDefineList.length;j++){
				var truckmodelDefine = truckmodelDefineList[j];
				truckModelStr += '<p><label for="'+truckmodelDefine.id+'" class="ckname">'+truckmodelDefine.truckModelName+'</label></p>';
			}
			truckModelStr += '</dd>';
		}
		jQuery("#mlist").append(truckModelStr);
		lv1();
		SelectTruckModel();
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
	
	 var SelectTruckModel=function()
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
			
			$(".lv1 .ftbold").click(function()
			 {
			  $(".goods-choose").val($(this).text());
			  $(".goods-chooseId").val($(this).attr("for"));
			   $(".goods-win").addClass("hide");
			 });
		
		   $(".lv2 .ckname").click(function()
			 {
			  $(".goods-choose").val($(this).text());
			  $(".goods-chooseId").val($(this).attr("for"));
			   $(".goods-win").addClass("hide");
			 });
			 //获取浏览器在页面上的位置
	        
	           
			 });
			 
		 }
