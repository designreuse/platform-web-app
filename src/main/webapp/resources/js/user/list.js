
$(document).ready(function(){

    //搜索提交
    $("#submitform").on("click",function(){
        $("#searchform").submit();
    });

    //翻页提交
    $(".page_a").on("click", function (e) {
        var pageNumber = $(this).data("pageNumber");
        pageSubmit(pageNumber);
    });

});


