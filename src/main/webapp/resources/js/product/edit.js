



$(".status").on("click",function(){
    if(confirm("确定这样做吗？")){
        var status = $("#status").val();
        var productId = $("#productId").val();
        $.ajax({
            url:window.ctx  + "/product/ajaxChangeDisabled",
            type:"post",
            data:{"productId":productId,"status":status},
            dataType:"json",
            success:function(data){
                $("#status").val(data.resultData.disabled);
                if(!data.resultData.disabled){
                    $(".status").text("停用").attr("class","btn btn-danger header-button status");
                }else{
                    $(".status").text("启用").attr("class","btn btn-success header-button status");
                }
                util.alertOk("修改成功")
            }
        })
    }
})

$("#catalogIdFirst").on("click",function(){
    var catalogIdFirst = $("#catalogIdFirst").val();
    $("#catalogIdSecond option").remove();
    $("#catalogId option").remove();
    if(catalogIdFirst.length > 0){
        $.ajax({
            url:window.ctx + "/product/ajaxGetCatalogByParent",
            type:"post",
            data:{"catalogId":catalogIdFirst},
            dataType:"json",
            success:function(data){
                $("#catalogIdSecond").append("<option value=''>请选择</option>");
                for ( var i =0 ;i <data.resultData.length;i++){
                    $("#catalogIdSecond").append("<option value="+data.resultData[i].catalogId+">"+data.resultData[i].catalogNameCn+"</option>");
                }
            }
        })
    }
})
$("#catalogIdSecond").on("click",function(){
    var catalogIdSecond = $("#catalogIdSecond").val();
    $("#catalogId option").remove();
    if(catalogIdSecond.length > 0){
        $.ajax({
            url:window.ctx + "/product/ajaxGetCatalogByParent",
            type:"post",
            data:{"catalogId":catalogIdSecond},
            dataType:"json",
            success:function(data){
                $("#catalogId").append("<option value=''>请选择</option>");
                for ( var i =0 ;i <data.resultData.length;i++){
                    $("#catalogId").append("<option value="+data.resultData[i].catalogId+">"+data.resultData[i].catalogNameCn+"</option>");
                }
            }
        })
    }
})

$(function(){
    var option = {
        ele: "#form1",
        submitType: "submit",
        rules: {
            productNameCn: {
                required: true
            },
            productNameRu: {
                required: true
            },
            catalogIdFirst:{
                required:true
            },
            catalogIdSecond:{
                required:true
            },
            catalogId:{
                required:true
            },
            hscode:{
                required:true,
                number:true
            },
            unitId:{
                required:true
            },
            standardUnitId:{
                required:true
            },
            price:{
                required:true,
                number:true
            },
            floatPrice:{
                required:true,
                number:true
            },
            logoUrl:{
                required:true
            }
        },
        messages:{
            productNameCn: {
                required: "不能为空"
            },
            productNameRu: {
                required: "不能为空"
            },
            catalogIdFirst:{
                required: "不能为空"
            },
            catalogIdSecond:{
                required: "不能为空"
            },
            catalogId:{
                required:"不能为空"
            },
            hscode:{
                required:"不能为空",
                number:"请填写正确的hscode"
            },
            unitId:{
                required:"不能为空"
            },
            standardUnitId:{
                required:"不能为空"
            },
            price:{
                required:"不能为空",
                number:"请填写正确的标准价格"
            },
            floatPrice:{
                required:"不能为空",
                number:"请填写正确的可浮动价值"
            },
            logoUrl:{
                required:"不能为空"
            }
        }

    }
    validatorFrom.initValidatorFrom(option);
})

////回显图片
//var productLogo=$("#productLogo").val();
//if(productLogo.length > 0){
//    $("#productSrc").attr("src",productLogo);
//}

//触发file的点击事件
function reOLUploadFro(){
    $("#productLogoUrl").trigger("click");
}
//file点击后会选择修改文件,当文件改变时触发
$(document).on("change","#productLogoUrl",function(){
    var $dom = $("#productLogoUrl");
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
                $("#productLogo").next(".popover").remove()
                $("[name=logoUrl]").val(src);
                $("#productSrc").attr('src',src);
            }else{
                util.alertError("上传图片失败");
            }
        },error: function (xml, status, e){
            util.alertError("上传图片失败");
        }
    });
})