/**
 * Created by Administrator on 2016/2/22.
 */

$("#disabledBtn").on("click",function(){
    if(confirm("是否确认停用该链接？")){
        var url = window.ctx+"/friendShip/changeDisabled";
        var id = $("#id").val();
        $.ajax({
            url:url,
            data:{
                id:id,
                disabled:1
            },
            type:"post",
            success:function(data){
                alert("停用成功");
                window.location.href = window.ctx + "/friendShip/list";
            },error:function(data){
                alert("服务器出现错误");
            }
        });
    }

})

$("#abledBtn").on("click",function(){
    if(confirm("是否确认启用该连接？")){
        var url = window.ctx+"/friendShip/changeDisabled";
        var id = $("#id").val();
        $.ajax({
            url:url,
            data:{
                id:id,
                disabled:0
            },
            type:"post",
            success:function(data){
                alert("启用成功");
                window.location.href = window.ctx + "/friendShip/list";
            },error:function(data){
                alert("服务器出现错误");
            }
        });
    }


})

function LogoClick(){
    $("#logoUrlId").trigger("click");
}

$(document).on("change","#logoUrlId",function(){
    var $dom = $("#logoUrlId");
    var id=$dom.attr("id");
    if (!/\.(gif|jpg|jpeg|png|bmp|GIF|JPG|PNG|BMP|JPEG)$/.test($dom.val())) {
        alert('"错误",hideClose:true,msgTitle: "请上传.jpg .jpeg .gif .png .bmp格式图像!"');
        return false;
    }
    if ($dom.get(0).files[0].size > 1024 * 1024 * 4){
        alert('不能上传超过4M的文件，您上传的文件过大，请重新上传！');
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
                console.log(data.data);
                var src= data.data.urlPath;
                var resourceCode= data.data.resourceCode;
                $("#logoUrl").val(src);
                $("#logoUrlSrc").attr('src',src);
//                $("#logoUrl").next(".popover").remove();
            }else{
                alert("上传图片失败");
            }
        },error: function (xml, status, e){
            alert("上传图片失败");
        }
    });
});

$(function(){
    var option = {
        ele: "#editForm",
        submitType: "auto",
        rules: {
            appId: {
                required: true
            },
            logoUrl: {
                required: true
            },
            url:{
                required:true,
                url:true
            },
            sort:{
                required:true,
                number:true
            }
        },
        messages:{
            appId: {
                required: "平台不能为空"
            },
            logoUrl: {
                required: "链接图片不能为空"
            },
            url:{
                required:"链接地址不能为空",
                url:"请输入正确的网址"
            },
            sort:{
                required:"排序不能为空",
                number:"请输入数字"
            }
        },
        validateDone:function(form){
            $("#saveBtn").attr("disabled","disabled")
            $.ajax({
                url:window.ctx+"/friendShip/edit",
                data:$("#editForm").serialize(),
                type:"post",
                dataType:"json",
                success:function(data){
                    alert(data.resultData)
                    location.href=window.ctx+"/friendShip/list"
                }
            })
        }
    }

    validatorFrom.initValidatorFrom(option);
})