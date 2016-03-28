// JavaScript Document
	var Message = function(){
		
		$(".ckbox").change(function() {
			
			var checktype = $(this).prop("checked");
			
			if(checktype){
				var ckname = $(this).next("label").html();
				var index = $(this).parent("p").index();
				//alert(index);
				$(".reclist").append("<span class='recname rec"+ index +"' i="+index+">"+ ckname +"<a href='javascript:;' title='点击删除'>X</a></span>");
				$(".recname a").click(function(){
					var number = $(this).parent("span").attr("i");
					$(this).parent("span").remove();
					$(".lv2 .ckbox:eq("+ number +")").prop("checked",false);
				})
			}else {
				var index = $(this).parent("p").index();
				
				$(".reclist .rec"+index+"").remove();
			}
		});
		
		$(".lv1").click(function(){
			//获取最新的数据
			if($(this).hasClass("lvshow"))
			{
				$(this).removeClass("lvshow");
				$(this).next(".lv2").addClass("hide");
				
		    }
		else
		   {
			  $(this).addClass("lvshow");
			   $(this).next(".lv2").removeClass("hide");
		   }
		});
	}
	//进行页面的更新
	var Reflash=function()
		{
			$("a.message").click(function()
			{
				//$(".ck").attr("checked",false);
				$(".reclist").text("");
		    });
			//页面加载的时候，所有的checkbox都要进行值得设定
			
		$(".ckbbox").attr("checked",false);
			
	    }
		