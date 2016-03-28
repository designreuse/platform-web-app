var yuan  = "--";
var unitNameCn;

var photoCount = $("#skuPhotoCount").val();


$(".comm-price .icon-del").click(function(){
    $(this).parent().parent().parent().parent().remove();
});
$(".product-pic .icon-del").click(function(){
    $(this).parent().remove();
    photoCount = photoCount-1;
   // alert(photoCount);
    $("#photoTip").html('图片大小支持2MB，图片尺寸为400X400<br>你还可以上传'+(6-photoCount)+'/6张图片');
    $("#imgCropBox").show();
});


var cropOption = {
    $cropBtn: ".imgCropBtn",
    $btn: "#imgUploadBtn",

    uploadSuccess: function (file,response) {

        if(typeof (response)=='string'){
            response=JSON.parse(response);
        }

        $(".imgCropModal").modal("hide");
        var src=response.resultData.urlPath;
        // var src=getImgTag(response.resultData.urlPath,400,400)
        // $(".imgCropBtn").attr("src",getImgTag(response.resultData.urlPath,200,200));
        // $("#personHeadPhoto").val(response.resultData.urlPath);
        var children = $("#photoDiv").children();
        if(children.length>=8){
            alert("最多添加六张图片");
            return;
        }


        var str ='<div class="col-sm-2">'
        str += '<img  src="'+src+'" class="img-responsive" alt="" >';
        str += '<a href="javascript: void(0)" onclick="removePhoto(this)" class="icon icon-del visible icon-tr"></a>';
        str += '</div>';

        photoCount +=1;
        if(photoCount==6){
            $("#imgCropBox").hide();
        }
        $("#photoTip").html('图片大小支持2MB，图片尺寸为400X400<br>你还可以上传'+(6-photoCount)+'/6张图片');
        $("#photoDiv .col-xs-12.mar_t20").before(str);

    },
    uploadError: function (reason) {

    },
    uploadComplete: function (file) {

    }
};
cropUpload(cropOption);



function checkStatus(status){
    if(confirm("确认修改SKU状态?")){
        var skuId = $("#skuId").val();
        var productNameCn = $("#productNameCn").val();
        var shopsId = $("#shopsId").val();
        $.ajax({
            url:window.ctx+"/sku/changeExamineStatus",
            type:"post",
            dataType:"json",
            data:{
                skuId:skuId,
                shopsId:shopsId,
                productNameCn:productNameCn,
                status:status
            },
            success: function (data) {
                alert("SKU审核状态修改成功");
                window.location.href=window.ctx+"/sku/edit/"+skuId;

            }, error: function () {
                alert("SKU审核状态修改失败，服务器出现错误");
            }
        });
    }



}

function saveSkuInfo(){
    var skuSaveVo={};
    skuSaveVo.skuId = $("#skuId").val();
    skuSaveVo.shopsId=$("#shopsId").val();

    skuSaveVo.catalogIdFirst = $("#catalogIdFirst").val();
    skuSaveVo.catalogIdSecond = $("#catalogIdSecond").val();
    skuSaveVo.catalogId = $("#catalogId").val();
    skuSaveVo.productId = $("#productId").val();
    if(skuSaveVo.productId==""){
        alert("请选择商品");
        return;
    }
    skuSaveVo.skuNameCn= $("#skuNameCn").val();
    skuSaveVo.skuNameRu= $("#skuNameRu").val();
    skuSaveVo.deliveryCityId = $("#deliveryCityId").find('option:selected').val();
    skuSaveVo.deliveryDay=$("#deliveryDay").val();
    skuSaveVo.moq=$("#moq").val();
    skuSaveVo.stockNum=$("#stockNum").val();
    skuSaveVo.validityDate=$("#validityDate").val();
    skuSaveVo.isHomepage = $("input[name='isHomepage']:checked").val();
    skuSaveVo.isHot = $("input[name='isHot']:checked").val();
    skuSaveVo.isSales = $("input[name='isSales']:checked").val();

    skuSaveVo.skuSimpleDesc = $("#skuSimpleDesc").val();
    skuSaveVo.skuSimpleDescRu = $("#skuSimpleDescRu").val();
//    skuSaveVo.skuDesc = $("#myEditor").val();

    var skuDesc = $("#myEditor").val();
    var skuDescRu = $("#myEditorRu").val();
    if(skuDesc==null || skuDesc==""){
        alert("产品详情(中文)不能为空");
        return;
    }
    if(skuDescRu==null || skuDescRu==""){
        alert("产品详情(俄文)不能为空");
        return;
    }
    skuSaveVo.skuDesc = skuDesc;
    skuSaveVo.skuDescRu = skuDescRu;
    // 属性
    var skuPropertyVoList = [];
    $("#productPropertyId").find("input").each(function(){
        var skuPropertyVo = {};
        skuPropertyVo.skuPropertyId = $(this).attr("id");
        skuPropertyVo.skuPropertyValue = $(this).val();
        skuPropertyVoList.push(skuPropertyVo);
    });

    // 售价
    var skuPriceVoList = [];
    var costType = $("#costType").find("option:selected").val();
    skuSaveVo.costType=costType;
    var firstPrice = null;
    var secondprice = null;
    var thirdPrice = null;

    $("#saleContent").find('div[class="formtable-list"]').each(function(){
        var skuPriceVo = {};
        skuPriceVo.costType = costType;
        var tt = $(this).find('input[name="oq"]').val();
        skuPriceVo.oq = tt;
        var priceType = $(this).find('select option:selected').val();
        if (priceType == 1){
            skuPriceVo.priceStart = $(this).find('input[name="priceStart"]').val();
            skuPriceVo.priceEnd = null;
        }
        if (priceType == 2){
            skuPriceVo.priceStart = $(this).find('input[name="priceStart"]').val();
            skuPriceVo.priceEnd = $(this).find('input[name="priceEnd"]').val();
        }
        if (priceType == 3){
            skuPriceVo.priceStart = null;
            skuPriceVo.priceEnd = null;
        }
        skuPriceVo.priceType = $(this).find('select option:selected').val();
        skuPriceVoList.push(skuPriceVo);

        if(firstPrice==null){
            firstPrice = skuPriceVo.oq;
        }else if(secondprice==null){
            secondprice = skuPriceVo.oq;
        }else if(firstPrice!=null&&secondprice!=null){
            thirdPrice = skuPriceVo.oq;
        }

    });
    if(skuPriceVoList.length<=0){
        alert("至少添加一条商品售价");
        return;
    }
    var flag = "false";
    var moq = $("#moq").val();
    if(thirdPrice!=null){
        if(parseFloat(firstPrice)>parseFloat(secondprice) || parseFloat(firstPrice)>parseFloat(thirdPrice) || parseFloat(secondprice)>parseFloat(thirdPrice)
            || parseFloat(firstPrice)<parseFloat(moq)||parseFloat(secondprice)<parseFloat(moq) ||parseFloat(thirdPrice)<parseFloat(moq)){
            flag = "true";
        }
    }else if(secondprice!=null){
        if(parseFloat(firstPrice)>parseFloat(secondprice) || parseFloat(firstPrice)<parseFloat(moq)||parseFloat(secondprice)<parseFloat(moq)){
            flag = "true";
        }
    }
    if(flag=="true"){
        alert("商品售价中数量不能小于之前的数量");
        return;
    }

    // 图片
    var skuPhotoVoList = [];
    $("#photoDiv").find("img").each(function(i){
        var skuPhotoVo = {};
        if($(this).attr("id")=="imgCropBtn"){
            return;
        }
        skuPhotoVo.photoUrl = $(this).attr("src");
        skuPhotoVo.resourceCode = $(this).attr("id");
        skuPhotoVo.sort = i+1;
        skuPhotoVoList.push(skuPhotoVo);
    });

    var skuSaveVoStr = JSON.stringify(skuSaveVo);
    var skuPropertyVoStr = JSON.stringify(skuPropertyVoList);
    var skuPriceVoStr = JSON.stringify(skuPriceVoList);
    var skuPhotoVoStr = JSON.stringify(skuPhotoVoList);

    if (skuPhotoVoList.length == 0){
        alert("必须上传一张商品图片！");
        return;
    }else{
        if (!$(".popover").length) {
            $.ajax({
                type: "POST",
                url: window.ctx + "/sku/addSku",
                dataType: "JSON",
                data: {
                    skuSaveVoStr: skuSaveVoStr,
                    skuPropertyVoStr: skuPropertyVoStr,
                    skuPriceVoStr: skuPriceVoStr,
                    skuPhotoVoStr: skuPhotoVoStr
                },
                success: function () {
                    alert("修改成功！");
                    window.location.href = window.ctx + "/sku/list";

                }, error: function () {
                    alert("保存失败！");
                }
            });
        }
    }

}

$(".add-interval").click(function(){
    var quoteTypeList = $("#quoteTypeList").val();
//    alert(quoteTypeList[0]['constValue']);
    for(var i=0;i<quoteTypeList.length;i++){
        var ttt = quoteTypeList[i];
        console.log(ttt);
    }
    var children = $("#saleContent").children();
    if(children.length>=3){
        alert("最多添加三条商品售价");
        return;
    }

    var quoteTypeStr = quoteType();

    $("#saleContent").append(
            '<div class="formtable-list">' +
            '<div class="col-xs-5 col-md-4">' +
            '<label class="col-sm-4">数量：>=</label>' +
            '<div class="col-sm-8">' +
            '<div class="form-inline">' +
            '<div class="form-group">' +
            '<input name="oq" type="text" class="form-control wid-120"><span>'+unitNameCn +
            '</span></div></div></div></div>' +
            '<div class="col-xs-7 col-md-8"><label class="col-sm-4">包干均价：</label>' +
            '<div class="col-sm-8"><div class="form-inline">' +
            '<div class="form-group"><select class="form-control" onchange="selectChange(this)">' +
//                        '<option>价格区间</option><option>定价</option><option>议价</option>' +
            quoteTypeStr +
            '</select></div> ' +
    '<div class="form-group">' +
    '<input type="text" name="priceStart"  class="form-control wid-max-80"> <span name="isNotValidPrice" hidden="hidden">- <input type="text" name="priceEnd" class="form-control wid-max-80"></span> <span class="yuanText">'+yuan+'</span><span class="unitNameCn">/'+unitNameCn+'</span></div> <a href="javascript:void(0)" class="icon icon-del visible" onclick="$(this).parent().parent().parent().parent().remove()"></a></div></div></div></div>')
})

//富文本编辑器
UM.getEditor('myEditor');
UM.getEditor('myEditorRu');
function removePhoto(node){
    photoCount = photoCount-1;
    $("#photoTip").html('图片大小支持2MB，图片尺寸为400X400<br>你还可以上传'+(6-photoCount)+'/6张图片');
    $(node).parent().remove();
    $("#imgCropBox").show();

}

/*
function change(){
    var children = $("#photoDiv").children();
    if(children.length>=8){
        alert("最多添加六张图片");
        return;
    }
    var $dom = $("#skuLogoId");
    var id=$dom.attr("id");
    if (!/\.(gif|jpg|jpeg|png|bmp|GIF|JPG|PNG|BMP|JPEG)$/.test($dom.val())) {
        alert('"错误",hideClose:true,msgTitle: "请上传.jpg .jpeg .gif .png .bmp格式图像!"');
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
//                        $("#resourcesCode").val(resourceCode)
//                        $("[name=logoUrl]").val(src);

                var str ='<div class="col-sm-3">'
                str += '<img id="'+resourceCode+'" src="'+src+'" class="img-responsive" alt="">';
                str += '<a href="javascript: void(0)" onclick="removePhoto(this)" class="icon icon-del visible icon-tr"></a>';
                str += '</div>';


                photoCount +=1;
                $("#photoTip").html('图片大小支持2MB，图片尺寸为400X400<br>你还可以上传'+(6-photoCount)+'/6张图片');
                $("#photoDiv .col-xs-12.mar_t20").before(str);
//                        $("#bannerLogoSrc").attr('src',src);
            }else{
                alert("上传图片失败");
            }
        },error: function (xml, status, e){
            alert("上传图片失败");
        }
    });
}
*/

function selectChange(node){
    var select = $(node).find("option:selected").val();
    var tt=$(node).parent().next().find("span");
    if(select == 1){
        var str= "";
        str +='<input type="text" name="priceStart" value=""  class="form-control wid-max-80">';
        str += '<label class="yuanText">'+yuan+'</label>/'+unitNameCn;
        $(node).parent().next().html(str);
    }else if(select == 2){
        var str= "";
        str +='<input type="text" name="priceStart" value=""  class="form-control wid-max-80">';
        str +='<span name="isNotValidPrice">- <input type="text" name="priceEnd" value="" class="form-control wid-max-80"></span>';
        str += '<label class="yuanText">'+yuan+'</label>/'+unitNameCn;
        $(node).parent().next().html(str);
    }else if(select == 3){
        $(node).parent().next().html("&nbsp;&nbsp;议价");
    }
}

// 报价方式
function quoteType(priceType){
    var quoteTypeStr = "";
    var url = window.ctx+"/sku/getQuoteType";
    $.ajax({url:url,
        type:"post",
        async:false,
        success:function(data){
            data= $.parseJSON(data);
            for (var i = 0; i <data.resultData.length; i++){
                if (priceType == data.resultData[i].constValue){
                    quoteTypeStr += '<option value='+data.resultData[i].constValue+' selected>'+data.resultData[i].constName+'</option>';
                }else{
                    quoteTypeStr += '<option value='+data.resultData[i].constValue+'>'+data.resultData[i].constName+'</option>';
                }
            }
        }
    });
    return quoteTypeStr;
}

$(function() {
    $("#validityDateId").datetimepicker("setStartDate",new Date().Format("yyyy-MM-dd"));
    $("#saveBtn").newcheck();

    var url = window.ctx+"/sku/getSkuPriceList";

    var skuId = $("#skuId").val();

    $("#photoTip").html('图片大小支持2MB，图片尺寸为400X400<br>你还可以上传'+(6-photoCount)+'/6张图片');

    unitNameCn = $("#unitNameCn").val();
    var index = $("#costType").find('option:selected').val();

    if (index == "1"){
        yuan = "美元";
    }else if (index == "2"){
        yuan = "卢布";
    }else if (index == "3"){
        yuan = "元";
    }

    $.ajax({
        url: url,
        type: "post",
        data: {skuId: skuId},
        dataType:"json",
        async: false,
        success: function (data) {
            for (var i = 0; i < data.length; i++) {
                var str = '<div class="formtable-list">';
                str +='<div class="col-xs-5 col-md-4">';
                str +='<label class="col-sm-4">数量：>=</label>';
                str +='<div class="col-sm-8">';
                str +='<div class="form-inline">';
                str +='<div class="form-group">';
                str +='<input name="oq" type="text" value="'+data[i].oq+'" class="form-control wid-120">'+unitNameCn;
                str +='</div>';
                str +='</div>';
                str +='</div>';
                str +='</div>';
                str +='<div class="col-xs-7 col-md-8">';
                str +='<label class="col-sm-4">包干均价：</label>';
                str +='<div class="col-sm-8"><div class="form-inline">';
                str +='<div class="form-group">';
                str +='<select class="form-control" onchange="selectChange(this)">';
                str += quoteType(data[i].priceType);
                str +='</select>';
                str +='</div>';
                str +='<div class="form-group">';
                if(data[i].priceType=="1"){
                    str +='<input type="text" name="priceStart" value="'+data[i].priceStart+'"  class="form-control wid-max-80">';
                    str += '<span class="yuanText">'+yuan+'</span><span>/'+unitNameCn+"</span>";
                }else if(data[i].priceType=="2"){
                    str +='<input type="text" name="priceStart" value="'+data[i].priceStart+'"  class="form-control wid-max-80">';
                    str +='<span name="isNotValidPrice">- <input type="text" name="priceEnd" value="'+data[i].priceEnd+'" class="form-control wid-max-80"></span>';
                    str += '<span class="yuanText">'+yuan+'</span><span>/'+unitNameCn+"</span>";
                }else{
                    str +='&nbsp;&nbsp;议价';
                }
                str +='</div>';
                str +='<a href="javascript:void(0)" class="icon icon-del visible" onclick="$(this).parent().parent().parent().parent().remove()"></a>';
                str +='</div>';
                str +='</div>';
                str +='</div>';
                str +='</div>';
                $("#saleContent").append(str);
            }
        }
    })

    $("#moq").on("blur",function(){
        $("#oq").val($("#moq").val());
    })

    var option={
        ele: "#saveForm",
        submitType: "auto",
        rules: {

            skuNameCn:{
                required:true
            },
            skuNameRu:{
                required:true
            },
            deliveryDay:{
                required:true,
                number:true
            },
            moq:{
                required:true,
                number:true,
                min:0.0000000000000000000000000000000000001
            },
            stockNum:{
                required:true,
                number:true,
                param0AboveParam1:['moq']
            },
            validityDate:{
                required:true
            },
            validityDate:{
                required:true
            },
            oq:{
                required:true,
                number:true
            },
            priceStart:{
                required:true,
                number:true
            },
            priceEnd:{
                required:true,
                number:true
            },
            skuSimpleDesc:{
                maxlength:500
            },
            skuSimpleDescRu:{
                maxlength:500
            }
        },
        messages: {
            skuNameCn:{
                required:"商品标题(中文)不能为空"
            },
            skuNameRu:{
                required:"商品标题(俄文)不能为空"
            },
            deliveryDay:{
                required:"交货期不能为空",
                number:"数字格式不正确"
            },
            moq:{
                required:"最小起订量不能为空",
                number:"数字格式不正确",
                min:"最小库存量不能小于0"
            },
            stockNum:{
                required:"库存量不能为空",
                number:"数字格式不正确"
            },
            validityDate:{
                required:"有效期不能为空"
            },
            oq:{
                required:"数量不能为空",
                number:"数量数字格式不正确"
            },
            priceStart:{
                required:"价格不能为空",
                number:"数字格式不正确"
            },
            priceEnd:{
                required:"价格不能为空",
                number:"数字格式不正确"
            },
            skuSimpleDesc:{
                maxlength:jQuery.validator.format("最多只能输入500个字符")
            },
            skuSimpleDescRu:{
                maxlength:jQuery.validator.format("最多只能输入500个字符")
            }
        },
        validateDone: saveSkuInfo

    }

    $( "#shopsName" ).autocomplete({
        source:window.ctx+"/sku/shopName/",
        autoFocus:true,
        minLength: 1,
        search: function(e, ui) {
            $("#shopsId").val('');
        },
        select: function(e, ui) {
            $( "#shopsId").val(ui.item.id);
        },
        change:function(e,ui){
            $( "#shopsId").val(ui.item.id);
        }
    });

    validatorFrom.initValidatorFrom(option);

    $("#offLineBtn").on("click",function(){
        var url = window.ctx+"/sku/changeShelvesStatus";
        $.ajax({
            url:url,
            data:{
                skuId:skuId,
                status:1
            },
            type:"post",
            async:false,
            success:function(data){
                alert("下架成功");
                window.location.href = window.ctx + "/sku/list";
            },error:function(data){
                alert("服务器出现错误");
            }
        });
    })

    $("#onLineBtn").on("click",function(){
        var url = window.ctx+"/sku/changeShelvesStatus";
        $.ajax({
            url:url,
            data:{
                skuId:skuId,
                status:0
            },
            type:"post",
            async:false,
            success:function(data){
                alert("上架成功");
                window.location.href = window.ctx + "/sku/list";
            },error:function(data){
                alert("服务器出现错误");
            }
        });
    })

    $("#disabledBtn").on("click",function(){
        if(confirm("确认停用该商铺商品？")){
            var url = window.ctx+"/sku/changeSkuDisabled";
            $.ajax({
                url:url,
                data:{skuId:skuId},
                type:"post",
                async:false,
                success:function(data){
                    alert("停用成功");
                    window.location.href = window.ctx + "/sku/list";
                },error:function(data){
                    alert("服务器出现错误");
                }
            });
        }

    })


    $("#deleteBtn").on("click",function(){
        if(confirm("确认删除该商铺商品？")){
            var url = window.ctx+"/sku/changeSkuDeleted";
            $.ajax({
                url:url,
                data:{skuId:skuId},
                type:"post",
                async:false,
                success:function(data){
                    alert("删除成功");
                    window.location.href = window.ctx + "/sku/list";
                },error:function(data){
                    alert("服务器出现错误");
                }
            });
        }

    })

    $("#costType").change(function() {
        var costType = $("#costType").val();
        if(costType=="3"){
            yuan = "元"
        }else if(costType=="2"){
            yuan = "卢布";
        }else if(costType=="1"){
            yuan = "美元";
        }
        $("#saleContent").find("span[class=yuanText]").each(function(){
                $(this).text(yuan);
            }
        );

    });

});