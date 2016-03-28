

$(function () {

    //初始化百度编辑器
   /* UM.getEditor('myEditor');
    var appSelectNode = $(".appSelectClass")
    $(".appSelectClass").remove();*/


    $("#appId").change(function () {
        //alert(1)
        var appId = $("#appId").val();
        //清除之前的option
        $("#adLocationId option").remove();
        $.ajax({
            type:"POST",
            contentType :"text/html;charset:utf-8",
            url:window.ctx+"/banner/ajaxGetadLocation",
            data:appId,
            success:function(data){
                $("#adLocationId").append("<option value=''>请选择</option>");
                //alert(data[i].constName)
                for ( var i =0 ;i <data.resultData.length;i++){
                    $("#adLocationId").append("<option value="+data.resultData[i].id+">"+data.resultData[i].adLocationKey  +"</option>");
                }
            },
            dataType:"JSON"
        })
    });

})

//触发file的点击事件
function reOLUploadFro(){
    $("#bannerUrl").trigger("click");
}
//file点击后会选择修改文件,当文件改变时触发
$(document).on("change","#bannerUrl",function(){
    var $dom = $("#bannerUrl");
    var id=$dom.attr("id");
    if (!/\.(gif|jpg|jpeg|png|bmp|GIF|JPG|PNG|BMP|JPEG)$/.test($dom.val())) {
        util.alertError('"错误",hideClose:true,msgTitle: "请上传.jpg .jpeg .gif .png .bmp格式图像!"');
        return false;
    }
    if ($dom.get(0).files[0].size > 1024 * 1024 * 5){
        util.alertError('不能上传超过5M的文件，您上传的文件过大，请重新上传！');
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
                $("[name=bannerLogo]").val(src);
                $("#bannerSrc").attr('src',src);
            }else{
                util.alertError("上传图片失败");
            }
        },error: function (xml, status, e){
            util.alertError("上传图片失败");
        }
    });
});


$(function(){
    var bannerLogo=$("#bannerLogo").val();
    if(bannerLogo.length > 0){
        $("#bannerSrc").attr("src",bannerLogo);
    }
})

$(function(){
    var option = {
        ele: "#form1",
        submitType: "auto",
        rules: {
            appId: {
                required: true
            },
            adLocationId: {
                required: true
            },
            startTime:{
                required:true,
                remote:{
                    url:window.ctx + "/banner/ajaxDateIsConflict",
                    type:"post",
                    dataType:"json",
                    data:{
                        validDate:function(){
                            return $("#startTime").val();
                        },
                        startTime:function(){
                            return $("#startTime").val();
                        },
                        endTime:function(){
                            return $("#endTime").val();
                        },
                        adLocationId:function(){
                            return $("#adLocationId").val();
                        },
                        bannerId:function(){
                            return $("#id").val();
                        }
                    },
                    dataFilter:function(data){
                        var datas=JSON.parse(data);
                        if (datas.isSuccess == true){
                            return false;
                        }else{
                            return true;
                        }
                    }

                }
            },
            endTime:{
                required:true,
                remote:{
                    url:window.ctx + "/banner/ajaxDateIsConflict",
                    type:"post",
                    dataType:"json",
                    data:{

                        validDate:function(){
                            return $("#endTime").val();
                        },
                        startTime:function(){
                            return $("#startTime").val();
                        },
                        endTime:function(){
                            return $("#endTime").val();
                        },
                        adLocationId:function(){
                            return $("#adLocationId").val();
                        },
                        bannerId:function(){
                            return $("#id").val();
                        }
                    },
                    dataFilter:function(data){
                        var datas=JSON.parse(data);
                        if (datas.isSuccess == true){
                            return false;
                        }else{
                            return true;
                        }
                    }

                }
            },
            url:{
                url:true
            },
            bannerLogo:{
                required:true
            },
            bannerDesc:{
                required:true
            }
        },
        messages:{
            appId: {
                required: "平台不能为空"
            },
            adLocationId: {
                required: "广告位不能为空"
            },
            startTime:{
                required:"开始时间不能为空",
                remote:"投放时间冲突"
            },
            endTime:{
                required:"结束时间不能为空",
                remote:"投放时间冲突"
            },
            bannerLogo:{
                required:"广告图片logo不能为空"
            },
            bannerDesc:{
                required:"广告描述不能为空"
            }
        },
        validateDone:function(form){
            $("#save").attr("disabled","disabled")
            $.ajax({
                url:window.ctx+"/banner/save",
                type:"post",
                dataType:"json",
                data:$("#form1").serialize(),
                success:function(data){
                    location.href = window.ctx+"/banner/list"
                }
            })
        }
    }

    validatorFrom.initValidatorFrom(option);

})

$("#adLocationId").change(function(){
    var adLocationId = $("#adLocationId").val();
    $.ajax({
        type:"POST",
        contentType :"text/html;charset:utf-8",
        url:window.ctx+"/banner/ajaxGetAdLocationById",
        data:adLocationId,
        success:function(data){
            $("#locationDesc").text(data.resultData.adLocationKey + "  " + data.resultData.adDescribe + " :" +data.resultData.picSize);
        },
        dataType:"JSON"
    })
});

$(function(){
    var id = $("#id").val();
    if (id.length > 0){
        $("#base").attr("class","header header-fl");
    }
});





$("#deleteBanner").on("click",function(){
    if(confirm("确认删除吗？")){
        var bannerId = $("#id").val();
        $.ajax({
            type: "POST",
            url: window.ctx+"/banner/ajaxChangeDeleted",
            data: {"bannerId":bannerId},
            success: function(data){
                util.alertOk("删除成功")
                location.href=window.ctx+"/banner/list"
            },
            dataType:"json"
        });
    }
})


$(".status").click(function(){
    if(confirm("确定要这么做吗？")){
        var bannerId = $("#id").val();
        var disabled = $("#disabled").val();
        $.ajax({
            type: "POST",
            url: window.ctx+"/banner/ajaxChangeDisabled",
            data: {"bannerId":bannerId,"disabled":disabled},
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

/*$("#startTime").change(function(){
    //alert(1)
    var startTime = $("#startTime").val();
    var adLocationId = $("#adLocationId").val();
    $.ajax({
        type: "POST",
        url: window.ctx+"/banner/ajaxDateIsConflict",
        data: {"validDate":startTime,"adLocationId":adLocationId},
        success: function(data){
            if(data.isSuccess){
                util.alertError("投放时间冲突,请重新选择")
            }
        },
        dataType:"json"
    });
})

$("#endTime").change(function(){
    //alert(1)
    var startTime = $("#startTime").val();
    var endTime = $("#endTime").val();
    var adLocationId = $("#adLocationId").val();
    $.ajax({
        type: "POST",
        url: window.ctx+"/banner/ajaxDateIsConflict",
        data: {"validDate":endTime,"adLocationId":adLocationId,"startTime":startTime,"endTime":endTime},
        success: function(data){
            if(data.isSuccess){
                util.alertError("投放时间冲突,请重新选择")
            }
        },
        dataType:"json"
    });
})*/

/*$("#save").click(function(){
    var startTime = $("#startTime").val();
    var endTime = $("#endTime").val();
    var adLocationId = $("#adLocationId").val();
    $.ajax({
        type: "POST",
        url: window.ctx+"/banner/ajaxDateIsConflict",
        data: {"validDate":endTime,"adLocationId":adLocationId,"startTime":startTime,"endTime":endTime},
        success: function(data){
            if(data.isSuccess){
                alert("投放时间冲突,请重新选择")
            }else{
                $("#save").attr("type","submit");
            }
        },
        dataType:"json"
    });
})*/




