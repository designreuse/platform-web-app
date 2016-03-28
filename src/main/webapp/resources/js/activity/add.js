$(function() {

    //初始化百度编辑器
    UM.getEditor('myEditor');
    var appSelectNode = $(".appSelectClass")
    $(".appSelectClass").remove();

    //回显图片
    var activityLogo=$("#activityLogo").val();
    if(activityLogo.length > 0){
        $("#activitySrc").attr("src",activityLogo);
    }

    //回显修改状态按钮时改变状态
    /*var id = $("#id").val();
    if (id.length > 0){
        $("#base").attr("class","header header-fl");
    }*/

    //参数校验
    var option = {
        ele: "#form1",
        submitType: "auto",
        rules: {
            activityName: {
                required: true
            },
            appId: {
                required: true
            },
            masterName:{
                required:true
            },
            startDate:{
                required:true
            },
            endDate:{
                required:true,
                remote:{
                    url:window.ctx + "/activity/ajaxValidateDate",
                    type:"post",
                    dataType:"json",
                    data:{
                        startDate:function(){
                            return $("#startDate").val();
                        },
                        endDate:function(){
                            return $("#endDate").val();
                        }
                    },
                    dataFilter:function(data){
                        var datas=JSON.parse(data);
                        //alert(datas.isSuccess)
                        if (datas.isSuccess){
                            return true;
                        }else{
                            return false;
                        }
                    }
                }
            },
            activityAddress:{
                required:true
            },
            activityLogo:{
                required:true
            }
        },
        messages:{
            activityName: {
                required: "标题不能为空"
            },
            appId: {
                required: "平台不能为空"
            },
            masterName:{
                required:"主办方不能为空"
            },
            startDate:{
                required:"开始时间不能为空"
            },
            endDate:{
                required:"结束时间不能为空",
                remote:"结束日期不能小于开始日期"
            },
            activityAddress:{
                required:"地址不能为空"
            },
            activityLogo:{
                required:"活动logo不能为空"
            }
        },
        validateDone:function(form){
            var activityDesc = $("#myEditor").val();
            if(activityDesc.length == 0){
                alert("活动内容不能为空")
            }else{
                $("#save").attr("disabled","disabled")
                $.ajax({
                 url: form.action,
                 type: form.method,
                 async:false,
                 data: $(form).serialize(),
                 dataType:"json",
                 success: function(data) {
                    if(data.isSuccess){
                        window.location.href = window.ctx + "/activity/list";
                    }
                 }
                 });
            }
        }

    }
        validatorFrom.initValidatorFrom(option);

});


$("#deleteNews").on("click",function(){
    if(confirm("是否确定删除？")){
        var activityId = $("#id").val();
        $.ajax({
            type: "POST",
            url: window.ctx+"/activity/ajaxChangeDeleted",
            data: {"activityId":activityId},
            success: function(data){
                util.alertOk("删除成功")
                location.href=window.ctx+"/activity/list"
            },
            dataType:"json"
        });
    }
})

//修改状态
$(".status").click(function(){
    if(confirm("确定要这么做吗？")){
        var activityId = $("#id").val();
        var disabled = $("#disabled").val();
        $.ajax({
            type: "POST",
            url: window.ctx+"/activity/ajaxChangeDisabled",
            data: {"activityId":activityId,"disabled":disabled},
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

});

//触发file的点击事件
function reOLUploadFro(){
    $("#activityLogoUrl").trigger("click");
}
//file点击后会选择修改文件,当文件改变时触发
$(document).on("change","#activityLogoUrl",function(){
    var $dom = $("#activityLogoUrl");
    var id=$dom.attr("id");
    if (!/\.(gif|jpg|jpeg|png|bmp|GIF|JPG|PNG|BMP|JPEG)$/.test($dom.val())) {
        alert('"错误",hideClose:true,msgTitle: "请上传.jpg .jpeg .gif .png .bmp格式图像!"');
        return false;
    }
    if ($dom.get(0).files[0].size > 1024 * 1024 * 5){
        alert('不能上传超过5M的文件，您上传的文件过大，请重新上传！');
        $dom.val(null);
        return false;
    }
    $.ajaxFileUpload({
        url:window.ctx+"/aldUpload/uploadImg",
        secureuri:false,
        fileElementId:id,
        dataType:"json",
        success: function(data){
            if(data.result){
                console.log(data.data)
                var src= data.data.urlPath;
                var resourceCode= data.data.resourceCode;
                $("#resourcesCode").val(resourceCode)
                $("[name=activityLogo]").val(src);
                $("#activitySrc").attr('src',src);
            }else{
                alert("上传图片失败");
            }
        },error: function (xml, status, e){
            alert("上传图片失败");
        }
    });
})