

	/**
	 * 列表页面右上角排序控制初始化
	 */
	var initLoad = function() {
		//初始选中
		var orderColumnName = jQuery("#orderColumn").val();
		var orderModeName = jQuery("#orderMode").val();
		if(null!=orderColumnName&&orderColumnName!=""){
			$(".crt").removeClass("crt");
			jQuery("a[name='"+orderColumnName+"']").parent().addClass("crt");
			if(orderModeName=="ASC"){
				jQuery("a[name='"+orderColumnName+"']").find("em").text("↑");
			}else{
				jQuery("a[name='"+orderColumnName+"']").find("em").text("↓");
			}
		}
		
		//list页面更多搜索条件替换
		$(".condition").click(function () {
	        var text = $(this).text();
	        if (text == "更多搜索条件") {
	        	$("#searchBarState").val("close");
	        }
	        else if (text == "精简搜索条件") {
	        	$("#searchBarState").val("open");
	        }
	    });
		
		//排序点击
		$(".orderClass").click(function() {
			jQuery("#orderColumn").val($(this).attr("name"));
			if($(this).find("em").text()=="↑"){
				jQuery("#orderMode").val("ASC");
			}else{
				jQuery("#orderMode").val("DESC");
			}
			
			var pageSize = $(".chzn-select").val();
			if($(this).attr("mark")!="ajax"){
				jQuery("form").submit();
			}
		});
		
	};
	
	/**
	 * 通用提交表单查询(ajax) 第一版
	 * @param currentPage
	 */
	function query(currentPage){
		if(jQuery("form").attr("action")){
			var pageSize = $(".chzn-select").val();
			if(currentPage){
				jQuery("#currentPage").val(currentPage);
			}else{
				jQuery("#currentPage").val(1);
			}
			if(pageSize){
				jQuery("#pageSize").val(pageSize);
			}else{
				jQuery("#pageSize").val(10);
			}
			jQuery.post(jQuery("form").attr("action"),jQuery("form").serialize(),loadCallback);	
		}
	}
	
	/**
	 * 通用提交表单查询(ajax) 第二版
	 * @param currentPage
	 */
	function requestData(currentPage,parent){
		var myForm;
		if(parent){
			myForm = jQuery("form",parent);
			if(currentPage){
				jQuery("#currentPage",parent).val(currentPage);
			}else{
				jQuery("#currentPage",parent).val(1);
			}
		}else{
			var length = jQuery("form").length;
			if(length!=1){
				myForm = jQuery("form",".opr-searchbox");
			}else{
				myForm = jQuery("form");
			}
			if(currentPage){
				jQuery("#currentPage").val(currentPage);
			}else{
				jQuery("#currentPage").val(1);
			}
		}
		if(jQuery(".loading",parent).html()){
			jQuery(".loading",parent).removeClass("hide");
		}else{
			myForm.append('<div class="loading pf">&nbsp;</div>');
		}
		jQuery.post(myForm.attr("action"),myForm.serialize(),loadCallback);
	}
	
	/**
	 * 这是分页标签数据
	 * @param page
	 */
	function setPage(page,totalCount,parent){
		jQuery(".loading",parent).addClass("hide");
		
		var pageSize = page.pageSize;
		var currentPage = page.currentPage;
		if(parent){
			$("#totalCount",parent).text(totalCount);
			$('#list_page_size',parent).val(pageSize);
		}else{
			$("#totalCount").text(totalCount);
			$('#list_page_size').val(pageSize);
		}
		renderPage(currentPage,pageSize,totalCount,parent);
	}
	
	
	function alertMsg(msg){
		if($(".formValidateMsg").is(":hidden")){
			$(".formValidateMsg").html(msg);
			$(".formValidateMsg").fadeIn(2000);
			$(".formValidateMsg").fadeOut(1000);
		}
	}
	
	function initValidate(){
		$(".numberText").keyup(function(){
			$(this).val($(this).val().replace(/\D/g,''));
			alertMsg("请输入数字...");
		});
		
		$(".englishText").keyup(function(){
			$(this).val($(this).val().replace(/[\u4E00-\u9FA5\uFF00-\uFFFF]/g,''));
		});
		
		$(".doubleText").blur(function(){
			var test = /^\d+(.\d+)?$/;
			if(!test.test($(this).val())){
				$(this).val("");
				alertMsg("请输入数字或者小数类型...");
			}
		});
		
		$(".feedbackText").blur(function(){
			var test = /^(([0-4]{1}(.\d+)?)|(5{1}(.0)?))$/;
			if(!test.test($(this).val())){
				$(this).val("");
				alertMsg("请输入不大于5的数字或者小数类型...");
			}
		});
		
		$(".englishText").keypress(function(event){
			var regTest = /^[^\u4e00-\u9fa5]{0,}$/;
			var eventObj = event || e;
			var keyCode = eventObj.keyCode || eventObj.which;
			if ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122))
			    return true;
			else
				return false;
		});
		
	}
	
	function submitValidate(){
		var length = $(".isNotNull").length;
		for(var i=0;i<length;i++){
			if($(".isNotNull").eq(i).val()==""||$(".isNotNull").eq(i).val()==null){
				alertMsg("*形标注文本框不能为空...");
				return false;
			}
		}
        var complaintStatus = $("select[name='complaintStatus']").find("option:selected").val();
        if(complaintStatus=="3"){
            var targetName = $("#targetName").val();
            var deductedScore = $("input[name='deductedScore']").val();
            if(!confirm(targetName+"将要被扣"+deductedScore+"分？")){
                return false;
            }
        }
		return true;
	}
	
	function submitForm(){
		if(submitValidate()){
			$(".manageForm").submit();
		}
	}
	
	//JS 去空格
	function isEmpty(value){
    	if(null==value||"null"==value){
    		return "";
    	}
    	return value;
    }
	//数值 为空判断
	function isEmptyByFloat(value,unit){
		if(null==unit||"null"==unit){
			return "";
		}else{
			if(null==value||"null"==value){
	    		return 0;
	    	}
		}
    	return value;
	}
	//表单清空
	function resetForm(){
		$('.searchform')[0].reset();
	}
	
	/**
	 * 全选
	 */
	function checkAll(parent){
		$(".checkAll",parent).click(function () {

	        if (this.checked) {
	            $(".audio-select",parent).each(function () { //遍历所有的name为selectFlag的 checkbox  
	                this.checked = "checked";
	                $(this).addClass("ckbox1");
	            })
	        } else {   //反之 取消全选   
	            $(".audio-select",parent).each(function () { //遍历所有的name为selectFlag的 checkbox  
	                $(this).attr("checked", false);
	                $(this).removeClass("ckbox1");
	            })
	        }
	    });
	    //判断其选中的个数和总个数是否相等
	    $(".audio-select",parent).each(function () {
	        $(this).click(function () {
	            if ($(".audio-select:checked",parent).length == $(".audio-select",parent).length) {
	                $(".checkAll",parent).attr("checked", "checked");
	                return true;
	            }

	            else {
	                $(".checkAll",parent).attr("checked", false);
	                return true;
	            }
	        });
	        
	    });
	}
	
	/**
	*
	*获取当前日期间隔日期 
	* @return yyyy-MM-dd HH24:mi:ss
	*/
	function getSpecificTime(yyyy, mm, dd, hh, mi, ss) {
		var nowTime = new Date();
		nowTime.setFullYear(nowTime.getFullYear()+yyyy);
		nowTime.setMonth(nowTime.getMonth()+mm);
		nowTime.setDate(nowTime.getDate()+dd);
		nowTime.setHours(nowTime.getHours()+hh);
		nowTime.setMinutes(nowTime.getMinutes()+mi);
		nowTime.setSeconds(nowTime.getSeconds()+ss);
		
		var year = nowTime.getFullYear();
		// month
		var month = nowTime.getMonth() + 1;
		if (month < 10) {
			month = '0' + month;
		}
		//day
		var day = nowTime.getDate();
		if (day < 10) {
			day = '0' + day;
		}

		var hour = nowTime.getHours();
		if (hour < 10) {
			hour = '0' + hour;
		}

		var minute = nowTime.getMinutes();
		if (minute < 10) {
			minute = '0' + (minute + mi);
		}
		var second = nowTime.getSeconds();
		if (second < 10) {
			second = '0' + (second + ss);
		}

		var specificTime = year + "-" + month + "-" + day + " " + hour + ":"
				+ minute + ":" + second;
		return specificTime;
	}
	
	
	/**
	*格式化日期
	*nowTime:date类型
	* @return yyyy-MM-dd HH24:mi:ss
	*/
	function getFormatTime(nowTime) {
		var year = nowTime.getFullYear();
		// month
		var month = nowTime.getMonth() + 1;
		if (month < 10) {
			month = '0' + month;
		}
		//day
		var day = nowTime.getDate();
		if (day < 10) {
			day = '0' + day;
		}

		var hour = nowTime.getHours();
		if (hour < 10) {
			hour = '0' + hour;
		}

		var minute = nowTime.getMinutes();
		if (minute < 10) {
			minute = '0' + minute;
		}
		var second = nowTime.getSeconds();
		if (second < 10) {
			second = '0' + second;
		}

		var specificTime = year + "-" + month + "-" + day + " " + hour + ":"
				+ minute + ":" + second;
		return specificTime;
	}

