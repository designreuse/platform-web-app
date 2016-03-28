/**
 * Created by Administrator on 2015/10/20.
 */
$(function(){
    $("#productForm").form({
        url:window.ctx+"/sensitive/insert",
        success:function(data){

            alert(data)
        }
    })
    $('#catalogId').combotree({
        url: '${ctx}/product/getCatlogBylevel?parentId=0',
        animate:true,
        lines:true,
        onBeforeSelect: function(node) {
            if (!$(this).tree('isLeaf', node.target)) {
                return false;
            }
        },
        onClick: function(node) {
            if (!$(this).tree('isLeaf', node.target)) {
                $('#catalogId').combo('showPanel');
                alert("请点击'+'选择下级分类")
            }
        },
        onBeforeExpand:function(node){
            $('#catalogId').combotree("tree").tree("options").url=window.ctx+"/product/getCatlogBylevel?parentId="+node.id

        },
        onSelect:function(node){
            var node1 = $(this).tree('getParent',node.target)
            var node2 = $(this).tree('getParent',node1.target)
            $("#catalogIdFirst").val(node2.id)
            $("#catalogIdSecond").val(node1.id)
            $("#catalog").val(node.id)
            $.ajax({
                url:window.ctx+"/product/getPropertyList",
                dataType:"json",
                type:"post",
                data:{
                    id:node.id,
                },
                success:function(data){
                    console.log(data.data)
                    var text=""
                    data.data.forEach(function(i,n){
                        text+="<td><label>" +
                            "<input class='product_checkbox' name='propertyIdList' type='checkbox' value="+ i.propertyId+">"
                        text+= i.propertyNameCn
                        text+="</label>"
                        text+= i.propertyValue
                        text+="</td>"
                    })
                    $("#catalogPropertyList").find("td").remove()
                    $("#catalogPropertyList").append(text)
                }
            })
        },

    });
    $('#catalogId').combotree('setValue',$("#catalog").val());
    $("#productCatalogForm").form({
        url:window.ctx+"/product/property",
        success:function(data){
            var result = jQuery.parseJSON(data)
            alert(result.msg)
        }
    })
})
function reOLUploadFro(){
    $("#productLogoUrl").trigger("click");
}
$(document).on("change","#productLogoUrl",function(){
    var $dom = $("#productLogoUrl");
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
                $("[name=logoUrl]").val(src);
                $("#productSrc").attr('src',src);
            }else{
                alert("上传图片失败");
            }
        },error: function (xml, status, e){
            alert("上传图片失败");
        }
    });
})

$("#productSubmit").click(function(){
    $("#productForm").submit()
})
$("#productCatalogSubmit").click(function(){
    $("#productCatalogForm").submit()
})
$("#submitForm").click(function(){
    var texts=""
    $(".product_checkbox").each(function() {
        //$(this).attr("checked","checked");
        if ($(this).is(':checked')) {
            texts += ","+$(this).val();
        }
    });
    $("#property").val(texts)
    $("#productForm").submit()
})
