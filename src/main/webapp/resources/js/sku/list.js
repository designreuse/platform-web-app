
$(document).ready(function(){
    $("#submitform").on("click",function(){
        $("#searchform").submit();
    });
    //loadPro(s);
});

/**
* 查询商品分类 生成select
* @param cid      父分类id
* @param target   目标select
*/
function loadCatalogList(url,target){
    cleanOption(target);
    $.get(url,function(data){
    data.forEach(function(d){
    target.append($("<option/>").val(d.catalogId).text(d.catalogNameCn));
    });
    },"json");
    }
//清除select下除了第一个之外的option
function cleanOption(target){
    target.children().first().siblings().remove();
    }
//加载二级产品分类
function loadCs2(s){
    loadCatalogList(window.ctx+"/inquiry/catalogList/"+$(s).val(),$("select.catalogSelect2:visible"));
    cleanOption($("select.catalogSelect3:visible"));
    cleanOption($("select.productSelect:visible"));
    }
//加载三级产品分类
function loadCs3(s){
    cleanOption($("select.productSelect:visible"));
    loadCatalogList(window.ctx+"/inquiry/catalogList/"+$(s).val(),$("select.catalogSelect3:visible"));
    }

//加载产品列表
function loadPro(s) {
    var target = $("select.productSelect:visible");
    cleanOption(target);
    $.get(window.ctx + "/inquiry/productList/" + $(s).val(), function (data) {
        data.forEach(function (d) {
            console.log(d)
            $("<option/>")
                .val(d.productId)
                .text(d.productNameCn)
                .attr("data-hscode", d.hscode)
                .attr("data-logoUrl", d.logoUrl)
                .appendTo(target);
        });
    }, "json");
}


