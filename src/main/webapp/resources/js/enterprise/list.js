$(document).ready(function(){


    //参数{input类名，选择类型(单选or多选)}
    $(".rdolist").labelauty("rdolist", "rdo");
    $(".chklist").labelauty("chklist", "check");

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


