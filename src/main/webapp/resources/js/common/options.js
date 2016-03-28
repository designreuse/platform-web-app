//使用class 选项卡
//点击审核通过和未审核通过的效果
var Audit = function () {

    $(".via").click(function () {
        $(".bw400").addClass("hide");
    });
    $(".not-by").click(function () {
        $(".bw400").removeClass("hide");
    });
    $(".viaUser").click(function () {
        $(".nopass_box").addClass("hide");
        $(".bwuser400").addClass("hide");
    	$(".msguser400").removeClass("hide").val("尊敬的"+$("#userName").val()+"，您好！您的个人认证申请已通过审核。欢迎使用融链天下平台。");

    });
    $(".not-byUser").click(function () {
        var checked = getCheckedVal();
        var flag = isOthersChecked(checked);
        if(flag){
            $(".bwuser400").removeClass("hide");
        }else{
            $(".bwuser400").addClass("hide");
        }
        $(".nopass_box").removeClass("hide");
        $(".msguser400").removeClass("hide");
        var str = "尊敬的"+$("#userName").val()+"，您好！您的个人认证申请未通过审核。原因："+checked+$("input[name='objectUserDescription']").val()+"，请重新提交相关证件申请认证。";
        str = str.replace("其它","").replace("：，","：").replace(",，","，");
        if(checked == ""){
            str = str.replace("原因：","");
        }
        $(".msguser400").removeClass("hide").val(str);

//        var checked = [];
//        $('input:checkbox:checked').each(function() {
//            checked.push($(this).val());
//        });
    });

    $(".nopass_box").click(function(){
        var checked = getCheckedVal();
        var flag = isOthersChecked(checked);
        if(flag){
            $(".bwuser400").removeClass("hide");
        }else{
            $(".bwuser400").addClass("hide");
        }

        var str = "尊敬的"+$("#userName").val()+"，您好！您的个人认证申请未通过审核。原因："+checked+$("input[name='objectUserDescription']").val()+"，请重新提交相关证件申请认证。";
        str = str.replace("其它","").replace("：，","：").replace(",，","，");
        if(checked == ""){
            str = str.replace("原因：","");
        }
        $(".msguser400").removeClass("hide").val(str);
    });

    $("input[name='objectUserDescription']").change(function(){
        var checked = getCheckedVal();
        var str = "尊敬的"+$("#userName").val()+"，您好！您的个人认证申请未通过审核。原因："+checked+$("input[name='objectUserDescription']").val()+"，请重新提交相关证件申请认证。";
        str = str.replace("其它","").replace("：，","：").replace(",，","，");
        if(checked == ""){
            str = str.replace("原因：","");
        }
        $(".msguser400").removeClass("hide").val(str);
    });
};

//查询的身份证的时候

var Query = function () {
    //获取文不框的中的内容

    $("#id").focus(function () {

        if ($(this).val() == "请输入身份证!" || $(this).val() == "") {
            $(this).val("");
            $(this).css("color", "");
        }
    });

    $("#id").blur(function () {
        if ($(this).val() == "") {
            $(this).css("color", "red");
            $(this).val("请输入身份证!");
        }
    });
    $("#query").click(function () {
        var val = $("#id").val();

        if (val == "请输入身份证!" || val == "") {
            $("#id").css("color", "red");

            $("#id").val("请输入身份证!");

        }
        else {
            $("#id").css("color", "");
        }
    });
};

var getCheckedVal = function(){
    var checked = [];
    $('input:checkbox:checked').each(function() {
        checked.push($(this).val());
    });
    return checked;
};

var isOthersChecked = function(checked){
    var flag = false;
    for(var i=0; i<checked.length; i++){
        if(checked[i]=="其它"){
            flag = true;
            break;
        }
    }
    return flag;
};

//条件的搜索的展示和隐藏  
var Show = function () {

    $(".condition").click(function () {
        var text = $(this).text();
        if (text == "更多搜索条件") {
            $(this).text("精简搜索条件");
            $(".opr-searchbox").addClass("full-search");
        }
        else if (text == "精简搜索条件") {
            $(this).text("更多搜索条件");
            $(".opr-searchbox").removeClass("full-search");
        }
    });
}



//checkbox全选和全不选的效果  
var IsFullSelect = function () {
    $(".checkAll").click(function () {
        if (this.checked) {
            $(".ckbox").each(function () {
                this.checked = "checked";
            })
        } else {   //反之 取消全选
            $(".ckbox").each(function () {
                $(this).attr("checked", false);
            })
        }
    });
    $(".checkAllOne").click(function () {
        if (this.checked) {
            $(".ckboxone").each(function () {
                this.checked = "checked";
            })
        } else {   //反之 取消全选
            $(".ckboxone").each(function () {
                $(this).attr("checked", false);
            })
        }
    });
    $(".checkAllTwo").click(function () {
        if (this.checked) {
            $(".ckboxtwo").each(function () {
                this.checked = "checked";
            })
        } else {   //反之 取消全选
            $(".ckboxtwo").each(function () {
                $(this).attr("checked", false);
            })
        }
    });

    $(".checkAllThree").click(function () {

        if (this.checked) {
            $(".ckboxthree").each(function () {
                this.checked = "checked";
            })
        } else {   //反之 取消全选
            $(".ckboxthree").each(function () {
                $(this).attr("checked", false);
            })
        }
    });
    $(".checkAllFour").click(function () {

        if (this.checked) {
            $(".ckboxfour").each(function () {
                this.checked = "checked";
            })
        } else {   //反之 取消全选
            $(".ckboxfour").each(function () {
                $(this).attr("checked", false);
            })
        }
    });
    //判断其选中的个数和总个数是否相等
    $("tbody .ckbox").change(function () {
        if ($("tbody .ckbox:checked").length == $("tbody .ckbox").length) {

            $(".checkAll").prop("checked", true);
            //  $(".checkAll").attr("checked", true);
        }
        else {
            $(".checkAll").prop("checked", false);
            // $(".checkAll").attr("checked", false);
        }

    });
    //判断其选中的个数和总个数是否相等
    $("tbody .ckboxone").change(function () {
        if ($("tbody .ckboxone:checked").length == $("tbody .ckboxone").length) {

            $(".checkAllOne").prop("checked", true);
            //  $(".checkAll").attr("checked", true);
        }
        else {
            $(".checkAllOne").prop("checked", false);
            // $(".checkAll").attr("checked", false);
        }

    });
    //判断其选中的个数和总个数是否相等
    $("tbody .ckboxtwo").change(function () {
        if ($("tbody .ckboxtwo:checked").length == $("tbody .ckboxtwo").length) {

            $(".checkAllTwo").prop("checked", true);
            //  $(".checkAll").attr("checked", true);
        }
        else {
            $(".checkAllTwo").prop("checked", false);
            // $(".checkAll").attr("checked", false);
        }

    });
    //判断其选中的个数和总个数是否相等
    $("tbody .ckboxthree").change(function () {
        if ($("tbody .ckboxthree:checked").length == $("tbody .ckboxthree").length) {

            $(".checkAllThree").prop("checked", true);
            //  $(".checkAll").attr("checked", true);
        }
        else {
            $(".checkAllThree").prop("checked", false);
            // $(".checkAll").attr("checked", false);
        }

    });
    //判断其选中的个数和总个数是否相等
    $("div .ckboxfour").change(function () {
        if ($("div .ckboxfour:checked").length == $("div .ckboxfour").length) {

            $(".checkAllFour").prop("checked", true);
            //  $(".checkAll").attr("checked", true);
        }
        else {
            $(".checkAllFour").prop("checked", false);
            // $(".checkAll").attr("checked", false);
        }

    });
}

//新写的表格上的选项卡的设计
var Switch=function()
{
	//改变其中的内容，是不是默认的情况下进行设定的
	//第一次点击的时候是用来切换，接下来的点击是为了改变升降序的
	//asc代表升序 desc代表降序
	var textasc="↑";
	var textdesc="↓";
	//var count=1;
	$(".uc-tab a").click(function()
	{
		//var text=$(this).children("em").text();
		
		if($(this).parent().hasClass("crt"))
		{
			$(this).parent().siblings("li").removeClass("crt");
			
			if($(this).children("em").text()=="↑")
		   {
			   $(this).children("em").text("↓");
			   }
			   else if($(this).children("em").text()=="↓")
			   {
				   $(this).children("em").text("↑");
				   }
			}
			else
			{
				$(this).parent().addClass("crt");
				$(this).parent().siblings("li").removeClass("crt");
		     }
		});
	}
//标签切换


var Tab = function(){
   
   //获取客户的编号
    var clientid=$(".clientid").val();
	$(this).addClass("crt").siblings().removeClass("crt");
	
	if(clientid=="")
	{
		$(".tabswitch li:eq(0)").siblings().addClass("hide");
		}
		else
		{
			$(".tabswitch li:eq(0)").siblings().removeClass("hide");
		}
	
	$(".tabswitch li").click(function(){
		$(this).addClass("crt").siblings().removeClass("crt");
		
		var index = $(".tabswitch li").index($(this));
		
		$(".uc-cont").addClass("hide");
		
		$(".uc-cont:eq("+ index +")").removeClass("hide");
		
		//隐藏单位标签
		   $(".select-shipper-info").removeClass("hide");
		   $(".select-shipper-info").addClass("hide");
	});

	
	//编辑货源的弹框标签切换
	$(".windowcar .win li ").click(function()
	{
		$(this).addClass("crt").siblings().removeClass("crt");
		
		var index = $(".windowcar .win li").index($(this));
		
		$(" .windowcar .uc-div").addClass("hide");
		
		$(".uc-div:eq("+ index +")").removeClass("hide");
		
    });
}

  
//全部展示的切换
var Options=function()
{
	  
	
	$(".tabchange li").click(function(){
		
		$(this).addClass("crt").siblings().removeClass("crt")
		var index = $(".tabchange li").index($(this));
		$(".tab-index").val($(this).children("a").attr("class"));
		$(".uc-cont").addClass("hide");
		$(".uc-cont:eq("+ index +")").removeClass("hide");
		
		//隐藏单位以及个人标签
		$(".goods-win").removeClass("hide");
		$(".goods-win").addClass("hide");
	});
	
}
	
/*           营业执照	        bizLicence 1
	    	 组织机构代码证	orgCodeCert	2
			 税务登记证	    taxRegCert	    3
			 个人身份证	    identity	    4
			 运输从业资格证	qualificationLicense	9
			 驾驶证	        driverLicense	        5
			 车辆照片	truckImage	                    6
			 行驶证	drivingLicense	                7
			 运营许可证	operateLicense	            8 

             车辆保险   insurance                  10

*/


var Fixed=function()
  {
	 var value=$(".tab-index").val();
	 //标识哪个模块
	 var modelName=$("#certModelName").val();
	 //获取索引
	// var index=0;
	 if(value=="bizLicence")
	  {
		  $(".bizLicence").parent("li").addClass("crt").siblings("li").removeClass("crt");
		  $(".uc-cont").addClass("hide");
		  $(".bus-license").removeClass("hide");
		  
	  }
	  else if(value=="orgCodeCert")
	  {
		  $(".orgCodeCert").parent("li").addClass("crt").siblings("li").removeClass("crt");
		  $(".uc-cont").addClass("hide");
		  $(".org-code").removeClass("hide");
	  }
	  
	  else if(value=="taxRegCert")
	  {
		  $(".taxRegCert").parent("li").addClass("crt").siblings("li").removeClass("crt");
		  $(".uc-cont").addClass("hide");
		  $(".tax-code").removeClass("hide");
      }
	
	  else if(value=="identity")
	   
	   {
	     $(".identity").parent("li").addClass("crt").siblings("li").removeClass("crt");
		  $(".uc-cont").addClass("hide");
		  $(".id-code").removeClass("hide");  
	   }
	   else if(value=="qualificationLicense")
	   {
		  $(".identity").parent("li").addClass("crt").siblings("li").removeClass("crt");
		  $(".uc-cont").addClass("hide");
		  $(".id-code").removeClass("hide");  	  
	   }
	   else if(value=="truckImage")
	   {
		  $(".truckImage").parent("li").addClass("crt").siblings("li").removeClass("crt");
		  $(".uc-cont").addClass("hide");
		  $(".car-img").removeClass("hide");  
		}
		else if(value=="drivingLicense")
		{
		  $(".drivingLicense").parent("li").addClass("crt").siblings("li").removeClass("crt");
		  $(".uc-cont").addClass("hide");
		  $(".car-license").removeClass("hide"); 
	    }
		else if(value=="operateLicense")
		{
		  $(".operateLicense").parent("li").addClass("crt").siblings("li").removeClass("crt");
		  $(".uc-cont").addClass("hide");
		  $(".opera-license").removeClass("hide"); 
	    }
	  else if(value=="driverLic")
	  {
		  $(".driverLic").parent("li").addClass("crt").siblings("li").removeClass("crt");
		  $(".uc-cont").addClass("hide");
		  $(".drive-license").removeClass("hide"); 
	  }
	  else if (value == "insurance") {
	      $(".insurance").parent("li").addClass("crt").siblings("li").removeClass("crt");
	      $(".uc-cont").addClass("hide");
	      $(".car-insurance").removeClass("hide");
	     
	  }
     else if(value=="driverIdentity"){
         $(".driverIdentity").parent("li").addClass("crt").siblings("li").removeClass("crt");
         $(".uc-cont").addClass("hide");
         $(".drive-license").removeClass("hide");
     }
     else if(value =="qualificationIdentity"){
         $(".qualificationIdentity").parent("li").addClass("crt").siblings("li").removeClass("crt");
         $(".uc-cont").addClass("hide");
         $(".qualification-license").removeClass("hide");
     }
     else if(value =="hzQualificationIdentity"){
         $(".hzQualificationIdentity").parent("li").addClass("crt").siblings("li").removeClass("crt");
         $(".uc-cont").addClass("hide");
         $(".hzQualification-license").removeClass("hide");
     }
     else if(value =="identity"){
        $(".identity").parent("li").addClass("crt").siblings("li").removeClass("crt");
        $(".uc-cont").addClass("hide");
        $(".id-code").removeClass("hide");
    }
	  else if (value == "") {
	      //获取索引，再去判断
	      $(".tabchange li:first").addClass("crt").siblings("li").removeClass("crt");
	      //判断是哪个审核模块
	      //车辆审核模块
	      if(modelName =="truckCertModel"){
	    	// 车辆照片
		      $(".truckImage").parent("li").addClass("crt").siblings("li").removeClass("crt");
		      $(".uc-cont").addClass("hide");
		      $(".car-img").removeClass("hide");
	      } else if(modelName =="truckOwnerCertModel"){
              $(".identity").parent("li").addClass("crt").siblings("li").removeClass("crt");
              $(".uc-cont").addClass("hide");
              $(".id-code").removeClass("hide");
          }else{
	    	  $(".bizLicence").parent("li").addClass("crt").siblings("li").removeClass("crt");
			  $(".uc-cont").addClass("hide");
			  $(".bus-license").removeClass("hide");
	      }
	  }
  };

  //设置隐藏域的值 value:
  
  //1.默认 default 2.审核对象 certObject 3.审核时间:certTime 4.受理完成时间:CertFinishTime
  
  //动态进行切换
  var TabSwitch=function()
  {
	//获取隐藏域的值
	
	var hiddenval=$(".tabswitch").val();
	
	  if(hiddenval=="default")
	  {
		  $(".default").parent("li").addClass("crt").siblings("li").removeClass("crt");
		  
	  }
	  else if(hiddenval=="certObject")
	  {
		  $(".certObject").parent("li").addClass("crt").siblings("li").removeClass("crt");
	  }
	  else if(hiddenval=="certTime")
	  {
		   $(".certTime").parent("li").addClass("crt").siblings("li").removeClass("crt");
	  }
	  
	  else if(hiddenval=="CertFinishTime")
	   {
		   $(".CertFinishTime").parent("li").addClass("crt").siblings("li").removeClass("crt");
	   }
	   
	   //进行判空操作
	   else if(hiddenval=="")
	   {
		   $(".uc-tab li:first").addClass("crt").siblings("li").removeClass("crt");
	   }
  }
//点击选择的时候弹出车型选择的div
     
	var CarDialog = function () {
		$(".clickchoose").click(function () {
		   
			$(".windowcar").removeClass("hide");
			$(".blackmask").removeClass("hide");
		
			
			var left=$(".car").offset().left+"px";
			var top=$(".car").offset().top+25+"px";
			
			
			
			$(".windows").removeClass("hide").css({"position":"absolute","left":left,"top":top});
			
		});
	}
	
	
	 var ShowDialog=function()
	 {
	     $(".clickchoose").click(function()
		 {
			 
				var left=$(this).offset().left+405+"px";
				var top=$(this).offset().top+420+"px";
				$(".showdialog").removeClass("hide").css({"position":"absolute","left":left,"top":top});
				 
		  });	 
	 }


 //获取焦点时弹出选择货品窗口
 var SelectGoods=function()
 {
	 $(".goods-choose").click(function()
	 {
		 var left=$(this).offset().left;
		 var top=$(this).offset().top+5+"px";
		
		 $(".goods-type").removeClass("hide").css({"position":"absolute","left":left,"top":top});
     });
	
	
	 $(".car").click(function()
	 {
		 var left=$(this).offset().left;
		 var top=$(this).offset().top+5+"px";
		
		 $(".car-type").removeClass("hide").css({"position":"absolute","left":left,"top":top});		
     });
	 
		  $(".goods-win").hover(
		 
		    function(){$(this).removeClass("hide");},
			function(){$(this).addClass("hide");}
		 ); 
		 
		 
		 
	   $(".goods-choose").blur(function()
	     {
			 
	   $(".lv2-goods .ckname").click(function()
	   {
            
				
	       $(".goods-choose").val($(this).text());

		  
		   $(".goods-win").addClass("hide");
		 });
		 //获取浏览器在页面上的位置
		 });
		 
		  $(".car").blur(function()
	     {
			 
	   $(".lv2-car .ckname").click(function()
	   {
            
				
	       $(".car").val($(this).text());

		  
		   $(".goods-win").addClass("hide");
		 });
		 //获取浏览器在页面上的位置
		 });
	 }
	 
	 
	 
	 //刷新的时候，清除一下车型的内容
	var ClearCarContent = function () {
		
		$(".goods-choose").val("");
	}
 
 //选中货品，将货品放到文本框中
 
//货源的弹出和关闭
var CloseSouce=function()
{
	//点击关闭货源的时候
	$(".close-souce").click(function()
	{
		$(".showdialog").removeClass("hide");
		 $(".blackmask").removeClass("hide");
		
		});
		SameClose(); 
	} 
	
	var InvaildSouce=function()
	{
		$(".invaild-souce").click(function()
		{
			$(".showdialog").removeClass("hide");
			$(".blackmask").removeClass("hide");
			});
		SameClose();
	}
		
		
	//相同点击关闭的按钮
var SameClose=function()
{
	$(".close").click(function()
	{
		$(".showdialog").addClass("hide");
		
	    $(".blackmask").addClass("hide");
	});
		
	$(".cancel").click(function()
	{
			$(".showdialog").addClass("hide");
			 $(".blackmask").addClass("hide");
		});
	 $(".confirm").click(function()
	 {      
	        $("input.car").val($('input[type="radio"][name="auto-select"]:checked').parent().next().text());
		    $(".blackmask").addClass("hide");	   
			  $(".showdialog").addClass("hide");
		});
	
	}	
		
		
//选择下拉框的值

var ChangeArea=function()
{
	$(".area").change(function()
	{
		
		//进行切换的时候进行判断
		$(".ckbox").attr("checked",false);
		
		 var checkText=$(this).find("option:selected").text(); 
		 if(checkText=="国家列表")
		 {
			 $(".country").removeClass("hide");
			 $(".country").siblings("div").addClass("hide");
			 }
			 else if(checkText=="省份列表")
			 {
				  $(".previous").removeClass("hide");
			      $(".previous").siblings("div").addClass("hide");
				 }
				 else if(checkText=="城市列表")
				 {
					   $(".city").removeClass("hide");
			           $(".city").siblings("div").addClass("hide");
					 }
					 else if(checkText=="区县列表")
					 {
						 $(".counties").removeClass("hide");
						 $(".counties").siblings("div").addClass("hide");
					 }
		});
	
	}

	  var MessageDialog=function()
	  {
		  $(".message").click(function()
		  {
			  $(".blackmask").removeClass("hide");
			  $(".showdialog").removeClass("hide");
			  });
		  }
  
  //折叠菜单项 每个页面上需要添加left-nav 
  /******************************/
/******************************/
var Menum = function () {
	 
		
		//设置屏幕的最小高度。
	    //$(".container").css("min-height",content);
		


    //将Jquery转换成Dom对象	
    
    $(".left-nav").click(function () {
		
		 if ($(this).siblings("ul").children().is(":hidden")) {
		
		     $(this).siblings("ul").removeClass("hide");

		     $(this).addClass("arrowbtm");
        }
        else {

		     $(this).siblings("ul").addClass("hide");
		     $(this).removeClass("arrowbtm");
			
		 }

    //点击的时候获取相应的高度
	  
       
    });
}

//设置导航菜单的高亮显示

    /*
   var NavHeightLight=function()
   {
	   
	  $(".lm-lv1").children("li").children("a").click(function()
	  {
		  //面包屑中strong中的内容
		  var text=$(".breadcrumb strong").text();
		  //点击导航条a标签中的内容
		  var navtext=$(this).text();
		 if(navtext==text)
		 {
		  $(this).parent("li").addClass("lml1-crt");
		  
		  $(this).parent("li").siblings("li").removeClass("lml1-crt");
		  $(this).parent("li").siblings("ul").children("li").removeClass("lml2-crt");
		  $(this).parent("li").siblings("li").siblings("ul").children("li").removeClass("lml2-crt");
		 }
		  });
		
	  $(".lm-lv2 a").click(function()
	  {
		  
		  //面包屑中strong中的内容
		  var text=$(".breadcrumb strong").text();
		  //点击导航条a标签中的内容
		  var navtext=$(this).text();
		   if(navtext==text)
		 {
		  $(this).parent("li").addClass("lml2-crt");
		  $(this).parent("li").siblings("li").removeClass("lml2-crt");
		  $(this).parent("li").parent("ul").parent("li").removeClass("lml1-crt");
		  $(this).parent("li").parent("ul").parent("li").siblings("li").removeClass("lml1-crt");
		  $(this).parent("li").parent("ul").parent("li").siblings("li").siblings("ul").children("a").removeClass("lml2-crt");
		 }
		
		  });
	
	}
    */

    //判断屏幕的高度，当内容页很小，将底部固定在屏幕的底部，否则，底部就是自适应的
	//var leftmenum=$(".leftmenu")[0];
	//var leftmenum=$(".leftmenu");
	
    //页面第一次加载的时候设置Containter容器的高度


	
	
 /*面包屑内容的追加*/

  /*
 var AppendContent=function()
 {
	 $(".breadcrumb").appendTo($(".breadquick .innerwp"));
	 $(".breadcrumb").removeClass("hide");
	 if($(".breadcrumb").parent(".innerwp").length==0)
	 {
		 $(this).remove();
	 }
 } 	 
 */
  /**
   * 声明属性
   */
  var shipperBoolean=false; //发货方
  var consigneeBoolean=false;//收货方
  var contractorBoolean=false;//承包方
  var payerBoolean=false;//付款方
  var supervisorBoolean = false;//监管方
  var propertyBoolean = false;//生产所有者

  //点击单位文本框的时候，弹出相应的框  
  
  var ClickTxt=function()
  {
	
	  //获取相应文本框的距左边和上面的位置
	  $(".goods-relation-unit .ship-unit").click(function()
	  {
		  
		  var value=$(this).attr("name");
		  if(value=="freight_shipper_unit"){
			  shipperBoolean =true;
		  }else if(value =="freight_consignee_unit"){
			  consigneeBoolean=true;
		  }else if(value=="freight_contractor_unit"){
			  contractorBoolean=true;
		  }else if(value =="freight_payer_unit"){
			  payerBoolean=true;
		  }else if(value="freight_supervisor_unit"){
			  supervisorBoolean=true;
		  }
		  
		  //获取相应文本框对应的索引
		   var left=$(this).offset().left;
		   var top=$(this).offset().top+5+"px";
		   $(".unit").addClass("hide");
		   $(".unit").removeClass("hide").css({ "position": "absolute", "left": left, "top": top });
	  });

  };
 

  


  //键盘点击的时候，获取数据隐藏div的数据
  
  var KeyGetList=function()
  {
	  
	  //发货方
	   $("#freight_shipper_unit").keypress(function(event) {
		   if (event.keyCode==13){  //回车键的键值为13  
			   var value=$(this).val();
			    getOrgUnitByType(value);
			    shipperBoolean=true; 
	        }   
		  });
     //收货方
	  $("#freight_consignee_unit").keypress(function(event) {
		   if (event.keyCode==13){  //回车键的键值为13  
			   var value=$(this).val();
			    getOrgUnitByType(value);
			    consigneeBoolean=true;
	        }   
		  });
	  //承包方
	   $("#freight_contractor_unit").keypress(function(event) {
		   if (event.keyCode==13){  //回车键的键值为13  
			   var value=$(this).val();
			    getOrgUnitByType(value);
			    contractorBoolean=true;
	        }   
		  });
	  //付款方
	  
	   $("#freight_payer_unit").keypress(function(event) {
		   if (event.keyCode==13){  //回车键的键值为13  
			   var value=$(this).val();
			    getOrgUnitByType(value);
			    payerBoolean=true;
	        }   
		  });
		  
	  //监管方
	  
	   $("#freight_supervisor_unit").keypress(function(event) {
		   if (event.keyCode==13){  //回车键的键值为13  
			   var value=$(this).val();
			    getOrgUnitByType(value);
			    supervisorBoolean=true;
	        }   
	   });
  };


//点击其中的内容的时候，将内容放到相应的文本框中，并隐藏div
  
  var GetText=function()
  {
	  //判断的隐藏域获取值
	 ///  var index=$(".hidindex").val();
	  //点击的时候，数据放到上面去
	  $(".msglist li").click(function()
	  {
		   if(shipperBoolean)
		   {
			   $("#freight_shipper_unit").val($(this).text());
			   shipperBoolean=false;
		   }
		   if(consigneeBoolean)
		       {
			     $("#freight_consignee_unit").val($(this).text());

			     consigneeBoolean=false;
			   }
			   
		   if(contractorBoolean)
		       {
			     $("#freight_contractor_unit").val($(this).text());

			     contractorBoolean=false;
			   }
		   if(payerBoolean)
		       {
			     $("#freight_payer_unit").val($(this).text());

			     payerBoolean=false;
			   }
	       if(supervisorBoolean)
		   	   {
			     $("#freight_supervisor_unit").val($(this).text());

			     supervisorBoolean=false;
	       }

	       if (propertyBoolean) {
	           $("#property").val($(this).text());
	           $("#ownerShipId").val($(this).children("input").val());
	           propertyBoolean = false;
	       }
	       //隐藏窗口
			 $(".unit").addClass("hide");
	  });
	  
  };
  
	//获取发货单位类型
  function getOrgUnitByType(value){
	  
		 $(".msglist li").each(function()
		 {
		    var text=$(this).text();
		    if (text == value){

		    }
			
		 });
  }
  
  
  
//判断下拉框中的值，进而选择页面是否隐藏和显示
 
/* var Changeorgper=function()
 {
      //页面第一次加载的时候,全部隐藏
	 
	  
	 $(".per-org").change(function()
	 {
		 
		  var checkText=$(this).find("option:selected").text(); 
		  if(checkText=="")
		  {
			  $(".car-audit-org").addClass("hide");
			  $(".car-audit-per").addClass("hide");
		  }
		  else if(checkText=="组织")
		  {
			   $(".car-audit-org").removeClass("hide");
		  $(".car-audit-per").addClass("hide");
		  }
		  else if(checkText=="个人")
		  {
			  
			
		   $(".car-audit-per").removeClass("hide");
		  $(".car-audit-org").addClass("hide");
		  }
		 
	 });
 }
 */
 
 //点击组织和个人的时候，获取相应文本的坐标
 //获取相应的方法
 
 var GetChildren=function()
 {
	 
	 
	 $(".org").click(function()
    {
		$("#property").attr("disabled",false);
	});
	$(".per").click(function()
	{
		$("#property").attr("disabled",false);
    });
	
	$("#property").click(function()
		{
			 var windowStatus = "dialogWidth:500px;dialogHeight:500px;center:1;status:0;";  
             var url = "车辆管理产权所有者/home.html";  
             var temp = showModalDialog(url,"",windowStatus); 
	    });
 };
 //判断审核提交单选按钮是否选中
 var isSelectRadio=function(){
	 $(".isSelectRadio").click(function(){
		 	var val=$('input:radio[name="audit"]:checked').val();
			if(val==null){
				alert("会员审核结果必须选择!");
				return false;
			}
			var list= $('input:radio[name="audit"]:checked').val();
			if(list==null){
				alert("请选中一个!");
				return false;
			}
//             if(!confirm("确定提交吗？")){
//                 return false;
//             }
		 });
 };
 
