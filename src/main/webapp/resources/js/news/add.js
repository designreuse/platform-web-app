$(function(){

    //初始化百度编辑器
    UM.getEditor('myEditorRu');
    UM.getEditor('myEditor');
    var appSelectNode = $(".appSelectClass")
    $(".appSelectClass").remove();

    //当平台改变时触发修改栏目
    $("#appId").change(function(){
        //alert(1);
        var appId=$("#appId").val();
        if(appId.length == 0){
            return;
        }

        if(appId == 5){
            $("#divTitleRu").removeAttr("style")
        }else{
            $("#divTitleRu").attr("style","display:none")
        }

        //清除之前的option
        $("#channel option").remove();
        $.ajax({
            type:"POST",
            contentType :"text/html;charset:utf-8",
            url:window.ctx+"/news/ajaxGetChannel",
            data:appId,
            success:function(data){
                $("#channel").append("<option value=''>请选择</option>");
                //alert(data[i].constName)
                for ( var i =0 ;i <data.resultData.length;i++){
                    $("#channel").append("<option value="+data.resultData[i].constValue+">"+data.resultData[i].constName+"</option>");
                }
            },
            dataType:"JSON"
        })
    });

    //当栏目被修改时判断平台是否被选中了
    $("#channel").click(function(){
        var appId = $("#appId").val()
        if (appId.length == 0){
            util.alertError("请先选择平台");
            return;
        }
    });




});


$(function(){
    var option = {
        ele: "#form1",
        submitType:"auto",
        rules: {
            title: {
                required: true
            },
            titleRu: {
                required: function(e){
                    if($("#appId").val() == 5){
                        return true
                    }else{
                        return false
                    }
                }
            },
            appId: {
                required: true
            },
            channel:{
                required:true
            },
            releaseTime:{
                required:true
            }
        },
        messages:{
            title: {
                required: "标题不能为空"
            },
            titleRu: {
                required: "标题不能为空"
            },
            appId: {
                required: "请选择平台"
            },
            channel:{
                required:"请选择栏目"
            },
            releaseTime:{
                required:"发布时间不能为空"
            }
        },
        validateDone:function(form){
            var activityDesc = $("#myEditor").val();
            var activityDescRu = $("#myEditorRu").val();
            var appId = $("#appId").val()
            if(activityDesc.length == 0){
                alert("资讯内容不能为空")
            }else if(activityDescRu.length == 0 && appId == 5) {
                alert("资讯内容(俄文)不能为空")
            }else{
                $("#save").attr("disabled","disabled")
                $.ajax({
                    url: window.ctx+"/news/save",
                    type: "post",
                    data: $(form).serialize(),
                    dataType:"json",
                    async:false,
                    success: function(data) {
                        if(data.isSuccess){
                            window.location.href = window.ctx + "/news/list";
                        }
                    }
                });
            }
        }
    }
    validatorFrom.initValidatorFrom(option);
})


$(function(){
    var id = $("#id").val();
    if (id.length > 0){
        $("#base").attr("class","header header-fl");
    }
});

$("#deleteNews").on("click",function(){
    if(confirm("确定删除咨询吗？")){
        var newsId = $("#id").val();
        $.ajax({
            type: "POST",
            url: window.ctx+"/news/ajaxChangeDeleted",
            data: {"newsId":newsId},
            success: function(data){
                util.alertOk("删除成功")
                location.href=window.ctx+"/news/list"
            },
            dataType:"json"
        });
    }
})

$(".status").click(function(){
    if(confirm("确定要这么做吗？")){
        var newsId = $("#id").val();
        var disabled = $("#disabled").val();
        $.ajax({
            type: "POST",
            url: window.ctx+"/news/ajaxChangeDisabled",
            data: {"newsId":newsId,"disabled":disabled},
            success: function(data){
                //alert(data.disabled)
                $("#disabled").val(data.resultData.disabled);
                if(!data.resultData.disabled){
                    $(".status").text("停用").attr("class","btn btn-danger header-button status");
                }else{
                    $(".status").text("启用").attr("class","btn btn-success header-button status");
                }
                util.alertOk("修改成功")
            },
            dataType:"json"
        });
    }
    //alert(1)
});