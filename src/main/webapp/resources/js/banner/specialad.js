$(".hover-menu").mouseover(function() {
    $(this).next().next().addClass("show");
});
$(".hover-menu").mouseout(function() {
    $(this).next().next().removeClass("show");
});

function adSelected(isMourning,value){
    if(isMourning != 1){
        $("input[name='cnId']").each(function(){
            if($(this).data("mourning") != 1 && $(this).val() != value){
                $(this).attr("checked",false);
            }
        })
    }
}
function adRuSelected(isMourning,value){
    if(isMourning != 1){
        $("input[name='ruId']").each(function(){
            if($(this).data("mourning") != 1 && $(this).val() != value){
                $(this).attr("checked",false);
            }
        })
    }
}

$("#support").on("click",function(){
    var json = [];
    $("input[name='cnId']:checked").each(function(){
        var obj = {};
        obj.id = $(this).val();
        json.push(obj);
    })
    $.ajax({
        url:window.ctx + "/banner/updateSpecialAd",
        type:"post",
        data:{"ids":JSON.stringify(json)},
        dataType:"json",
        success:function(data){
            if(data.isSuccess){
                util.alertOk("修改成功")
                window.location.href=window.ctx + "/banner/specialAd";
            }else{
                util.alertError("保存失败")
            }
        }
    })
})
$("#supportRu").on("click",function(){
    var json = [];
    $("input[name='ruId']:checked").each(function(){
        var obj = {};
        obj.id = $(this).val();
        json.push(obj);
    })
    $.ajax({
        url:window.ctx + "/banner/updateRuSpecialAd",
        type:"post",
        data:{"ids":JSON.stringify(json)},
        dataType:"json",
        success:function(data){
            if(data.isSuccess){
                util.alertOk("修改成功")
                window.location.href=window.ctx + "/banner/specialAd";
            }else{
                util.alertError("保存失败")
            }
        }
    })
})