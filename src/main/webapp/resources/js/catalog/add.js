$(function(){




    var option = {
        ele: "#form1",
        submitType: "submit",
        rules: {
            catalogNameCn: {
                required: true
            },
            catalogNameRu: {
                required: true
            },
            level:{
                required:true
            },
            firstCatalogId:{
                required:true
            },
            secondCatalogId:{
                required:true
            },
            logo:{
                required:true
            },
            hscode:{
                number:true,
                required:function(){
                    return ($("input[name=level]:checked").val()==3)
                }
            },
            indexSort:{
                required:function(){
                    if($("#level").val() == 3){
                        return true;
                    }else{
                        return false;
                    }
                },
                number:true
            }
        },
        messages:{
            catalogNameCn: {
                required: "不能为空"
            },
            catalogNameRu: {
                required: "不能为空"
            },
            level:{
                required:"不能为空"
            },
            firstCatalogId:{
                required:"不能为空"
            },
            secondCatalogId:{
                required:"不能为空"
            },
            logo:{
                required:"图片logo不能为空"
            },
            hscode:{
                requird:"HS CODE不能为空",
                number:"只能输入数字"
            },
            indexSort:{
                required:"不能为空",
                number:"只能输入数字"
            }
        }
    }

    validatorFrom.initValidatorFrom(option);

})


$("#secondLevel").on("change",function(){
    $.ajax({
        url:window.ctx + "/catalog/ajaxGetCatalogListByParent",
        type:"post",
        data:{"catalogId":$("#secondLevel").val()},
        dataType:"json",
        success:function(data){
            $("#third option").remove();
            $("#third").append("<option value=''>请选择</option>");
            //alert(data[i].constName)
            for ( var i =0 ;i <data.resultData.length;i++){
                $("#third").append("<option value="+data.resultData[i].catalogId+">"+data.resultData[i].catalogNameCn  +"</option>");
            }
        }
    })
})

$("input[name=level]").on("change",function(){
    var level = $("input[name=level]:checked").val();
    if(level == 1){
        $("#parentCatalog").attr("class","col-xs-6 hide");
        $("#indexShowDiv").attr("class","formtable-list hide");
        $("#third").attr("class","form-control hide");
        $("#indexShow").attr("class","col-md-4");
        $("#hs_code").attr("class","col-sm-5 col-md-4");
    }
    if(level == 2){
        $("#parentCatalog").attr("class","col-xs-6");
        $("#indexShowDiv").attr("class","formtable-list");
        $("#third").attr("class","form-control hide");
        $("#indexShow").attr("class","col-md-4");
        $("#hs_code").attr("class","col-sm-5 col-md-4");
        $.ajax({
            url:window.ctx + "/catalog/ajaxFindCatalogByLevel",
            type:"post",
            data:{"level":1},
            dataType:"json",
            success:function(data){
                $("#secondLevel option").remove();
                $("#secondLevel").append("<option value=''>请选择</option>");
                //alert(data[i].constName)
                for ( var i =0 ;i <data.resultData.length;i++){
                    $("#secondLevel").append("<option value="+data.resultData[i].catalogId+">"+data.resultData[i].catalogNameCn  +"</option>");
                }
            }
        })
    }
    if(level == 3){
        $("#parentCatalog").attr("class","col-xs-6");
        $("#indexShowDiv").attr("class","formtable-list");
        $("#third").attr("class","form-control");
        $("#indexShow").attr("class","col-md-4 ");
        $("#hs_code").attr("class","col-sm-5 col-md-4 formtable-list-require");
        $.ajax({
            url:window.ctx + "/catalog/ajaxFindCatalogByLevel",
            type:"post",
            data:{"level":1},
            dataType:"json",
            success:function(data){
                $("#secondLevel option").remove();
                $("#secondLevel").append("<option value=''>请选择</option>");
                //alert(data[i].constName)
                for ( var i =0 ;i <data.resultData.length;i++){
                    $("#secondLevel").append("<option value="+data.resultData[i].catalogId+">"+data.resultData[i].catalogNameCn  +"</option>");
                }
            }
        })
    }
})

//触发file的点击事件
function reOLUploadFro(){
    $("#catalogLogoUrl").trigger("click");
}
//file点击后会选择修改文件,当文件改变时触发
$(document).on("change","#catalogLogoUrl",function(){
    var $dom = $("#catalogLogoUrl");
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
                $("#catalogLogo").next(".popover").remove()
                $("[name=logo]").val(src);
                $("#catalogSrc").attr('src',src);
            }else{
                alert("上传图片失败");
            }
        },error: function (xml, status, e){
            alert("上传图片失败");
        }
    });
})
