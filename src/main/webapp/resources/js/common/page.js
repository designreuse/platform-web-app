/**
 *
 */
	var page_submit = function(e){
		var pageNumber = $(e.target).data("pageNumber");
		var pageSize = $(".chzn-select").val();
		//var functionName=$("#functionName").val();
		$("#pageSize").val(pageSize);
		$("#currentPage").val(pageNumber);

		var $pageSize = $(".chzn-select");
		var $pageNumber = $("#pageNumber");

		if($pageNumber.length>0){
			$("input[name=pageNumber]").val(pageNumber);
		}else{
			$(".searchform").append('<input name="pageNumber" value="'+pageNumber/*+'" type="hidden" />'*/);
		}
		if($pageSize.length>0){
			$("input[name=pageSize]").val(pageSize);
		}else{
			$(".searchform").append('<input name="pageSize" value="'+pageSize/*+'" type="hidden" />'*/);
		}
		//if(functionName){
			//jQuery.post(jQuery(".searchform").attr("action"),jQuery(".searchform").serialize(),functionName);
		//}else{
		  // if($(".searchform").attr("action")){
			   $(".searchform").submit();
		 //  }
		//}

	};
	var setPagePara = function(pageNumber,pageSize,pages){
		var $pageSize = $(".chzn-select");
			var $pageNumber = $("#pageNumber");
			var $pages = $("#pages");
			if($pageNumber.length>0){
				$("input[name=pageNumber]").val(pageNumber);
			}else{
				$(".searchform").append('<input name="pageNumber" value="'+pageNumber/*+'" type="hidden" />'*/);
			}
			if($pageSize.length>0){
				$("input[name=pageSize]").val(pageSize);
			}else{
				$(".searchform").append('<input name="pageSize" value="'+pageSize/*+'" type="hidden" />'*/);
			}
			if($pages.length>0){
				$("input[name=pages]").val(pages);
			}else{
				$(".searchform").append('<input name="pages" value="'+pages/*+'" type="hidden" />'*/);
			}


	};

	var flush_Page = function(){

		var pagingStr = document.getElementById('pagingComm').innerHTML;
		pagingStr = pagingStr.replace(/\<!--/g,"");
		pagingStr = pagingStr.replace(/--\>/g,"");
		document.getElementById('paging').innerHTML = pagingStr;
	};

	var setClickPage = function(){
		$(".page_a").on("click", function(e){
			page_submit(e);
		});

	};

    var getPageSize = function(){
        var pageNumber = $(this).data("pageNumber");
        pageSubmit(pageNumber);
    }

var pageSubmit = function(pageNumber){
    var pageSize = $(".chzn-select").val();
    $("#pageSize").val(pageSize);
    $("#currentPage").val(pageNumber);

    var $pageSize = $(".chzn-select");
    var $pageNumber = $("#pageNumber");

    if($pageNumber.length>0){
        $("input[name=pageNumber]").val(pageNumber);
    }else{
        $(".searchform").append('<input name="pageNumber" value="'+pageNumber/*+'" type="hidden" />'*/);
    }
    if($pageSize.length>0){
        $("input[name=pageSize]").val(pageSize);
    }else{
        $(".searchform").append('<input name="pageSize" value="'+pageSize/*+'" type="hidden" />'*/);
    }
    $(".searchform").submit();
};



