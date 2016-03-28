$(function(){

    //初始化百度编辑器
    UM.getEditor('myEditorRu');
    UM.getEditor('myEditor');

    //当平台改变时触发修改栏目
    $("#appId").change(function(){
        var appId=$("#appId").val();
        if(appId.length == 0){
            return;
        }
        if(appId == 5){
            $("#divProblemRu").removeAttr("style");
            $("#divAnswerRu").removeAttr("style");
        }else{
            $("#divProblemRu").attr("style","display:none");
            $("#divAnswerRu").attr("style","display:none");
        }

        //清除之前的option
        $("#helpTypeId option").remove();
        $.ajax({
            type:"POST",
            contentType :"text/html;charset:utf-8",
            url:window.ctx+"/help/ajaxGetHelpType",
            data:appId,
            success:function(data){
                $("#helpTypeId").append("<option value=''>请选择</option>");
                //alert(data[i].constName)
                for ( var i =0 ;i <data.resultData.length;i++){
                    $("#helpTypeId").append("<option value="+data.resultData[i].id+">"+data.resultData[i].name+"</option>");
                }
            },
            dataType:"JSON"
        })
    });


    var option = {
        ele: "#form1",
        submitType:"auto",
        rules: {
            problem: {
                required: true
            },
            problemTranslation: {
                required: function(e){
                    if($("#appId").val() == 5){
                        return true
                    }else{
                        return false
                    }
                }
            },
            helpTypeId:{
                required:true
            }
        },
        messages:{
            problem: {
                required: "问题标题不能为空"
            },
            problemTranslation: {
                required: "问题标题（俄文）不能为空"
            },
            helpTypeId: {
                required: "请选择类型"
            }
        },
        validateDone:function(form){
            var activityDesc = $("#myEditor").val();
            var activityDescRu = $("#myEditorRu").val();
            var appId = $("#appId").val()
            if(activityDesc.length == 0){
                alert("答案内容不能为空")
            }else if(activityDescRu.length == 0 && appId == 5) {
                alert("答案内容（俄文）不能为空")
            }else{
                $("#save").attr("disabled","disabled")
                $.ajax({
                    url: window.ctx+"/help/save",
                    type: "post",
                    data: $(form).serialize(),
                    dataType:"json",
                    async:false,
                    success: function(data) {
                        if(data.isSuccess){
                            window.location.href = window.ctx + "/help/list";
                        }
                    }
                });
            }
        }
    }
    validatorFrom.initValidatorFrom(option);
});







$(".status").click(function(){
    if(confirm("确定要这么做吗？")){
        var id = $("#id").val();
        var disabled = $("#disabled").val();
        if(disabled == 0){
            disabled = 1;
        }else{
            disabled =0;
        }
        $.ajax({
            type: "POST",
            url: window.ctx+"/help/ajaxChangeDisabled",
            data: {"id":id,"disabled":disabled},
            success: function(data){
                //alert(data.disabled)
                $("#disabled").val(data.resultData.disabled);
                if(data.resultData.disabled == 0){
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