var photoCount=0;
var yuan  = "元";
var unitNameCn = "千克";

var cropOption = {
    $cropBtn: ".imgCropBtn",
    $btn: "#imgUploadBtn",
   /* clickFun: function(){
        alert(222);
        return false;
    },*/
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

var util = (function(){
    return{
        alertError: function(msg){
            notyfy({
                text: msg,
                type: 'error',
                dismissQueue: true,
                layout: 'top',
                timeout: 1000,
                buttons: false
            });
        },
        alertOk: function(msg){
            notyfy({
                text: msg,
                type: 'success',
                dismissQueue: true,
                layout: 'top',
                timeout: 1500,
                buttons: false
            });
        },
        popover: function(ele, mes ,state){
            var _popover;
            _popover = ele.popover({
                trigger: "manual",
                placement: "bottom",
                content: mes,
                template: "<div class=\"popover\"><div class=\"arrow\"></div><div class=\"popover-inner\"><div class=\"popover-content\"><p></p></div></div></div>"
            });
            _popover.data("bs.popover").options.content = mes;
            if(state == "show"){
                return ele.popover("show");
            }
            else{
                return ele.popover("hide");
            }
        }
    }
})();

$(".comm-price .icon-del").click(function(){
    $(this).parent().parent().parent().parent().remove()
});
$(".product-pic .icon-del").click(function(){
    $(this).parent().remove()
});

$(".add-interval").click(function(){

    var children = $("#saleContent").children();
    if(children.length>=3){
        alert("最多添加三条商品售价");
        return;
    }

    var quoteTypeStr=quoteType();

    $("#saleContent").append(
            '<div class="formtable-list">' +
            '<div class="col-xs-5 col-md-4">' +
            '<label class="col-sm-4">数量：>=</label>' +
            '<div class="col-sm-8">' +
            '<div class="form-inline">' +
            '<div class="form-group">' +
            '<input name="oq" type="text" class="form-control wid-120"><span class="unitNameCnText">'+unitNameCn+'</span>'+
            '</div></div></div></div>' +
            '<div class="col-xs-7 col-md-8"><label class="col-sm-4">包干均价：</label>' +
            '<div class="col-sm-8"><div class="form-inline">' +
            '<div class="form-group"><select class="form-control" onchange="selectChange(this)">' +
            quoteTypeStr +
            '</select></div> ' +
            '<div class="form-group">' +
            '<input name="priceStart" type="text"   class="form-control wid-max-80"> <span name="isNotValidPrice" hidden="hidden">- <input name="priceEnd" type="text"   class="form-control wid-max-80"></span><span class="yuanText">'+yuan+'</span>/<span class="unitNameCnText">'+unitNameCn+'</span></div> <a href="javascript:void(0)" class="icon icon-del visible" onclick="$(this).parent().parent().parent().parent().remove()"></a></div></div></div></div>')
})
//富文本编辑器
UM.getEditor('myEditor');
UM.getEditor('myEditorRu');
function removePhoto(node){
    photoCount=photoCount-1;
    $("#photoTip").html('图片大小支持2MB，图片尺寸为400X400<br>你还可以上传'+(6-photoCount)+'/6张图片');
    $(node).parent().remove();
    $("#imgCropBox").show();

}


//裁剪图片处理



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


function saveSkuInfo(){
    var skuSaveVo={};
    skuSaveVo.shopsId=$("#shopsId").val();
    skuSaveVo.catalogIdFirst = $("#catalogIdFirst").find("option:selected").val();
    skuSaveVo.catalogIdSecond = $("#catalogIdSecond").find("option:selected").val();
    skuSaveVo.catalogId = $("#catalogId").find("option:selected").val();
    skuSaveVo.productId = $("#productId").find("option:selected").val();
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

    var skuDesc = $("#myEditor").val();
    var skuDescRu = $("#myEditorRu").val();
    if(skuDesc==null || skuDesc==""){
        alert("产品详情不能为空");
        return;
    }
    if(skuDescRu==null || skuDescRu==""){
        alert("产品详情不能为空");
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
    var bool = true;

    var firstPrice = null;
    var secondprice = null;
    var thirdPrice = null;
    $("#saleContent").find('div[class="formtable-list"]').each(function(){
        var skuPriceVo = {};
        skuPriceVo.costType = costType;
        if(bool){
            skuPriceVo.oq = $("#moq").val();
            bool = false;
        }else{
            skuPriceVo.oq = $(this).find('input[name="oq"]').val();
        }
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
                async:false,
                data: {
                    skuSaveVoStr: skuSaveVoStr,
                    skuPropertyVoStr: skuPropertyVoStr,
                    skuPriceVoStr: skuPriceVoStr,
                    skuPhotoVoStr: skuPhotoVoStr
                },
                success: function () {
                    alert("新增成功！");
                    window.location.href = window.ctx + "/sku/list";

                }, error: function () {
                    alert("保存失败！");
                }
            });
        }
    }

}


function selectChange(node){

    var select = $(node).find("option:selected").val();
    var tt=$(node).parent().next().find("span");
    if(select == 1){
        var str= "";
        str +='<input type="text" name="priceStart" value=""  class="form-control wid-max-80">';
        str += yuan+'/'+unitNameCn;
        $(node).parent().next().html(str);
    }else if(select == 2){
        var str= "";
        str +='<input type="text" name="priceStart" value=""  class="form-control wid-max-80">';
        str +='<span name="isNotValidPrice">- <input type="text" name="priceEnd" value="" class="form-control wid-max-80"></span>';
        str += yuan+'/'+unitNameCn;
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

    $("#moq").on("blur",function(){
        $("#oq").val($("#moq").val());
    })

    var option={
        ele: "#saveForm",
        submitType: "auto",
        rules: {
            shopsId: {
                required : true
            },
            productId:{
                required : true
            },
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
                min:0.000000000000000000000000000000000000000001
            },
            stockNum:{
                required:true,
                number:true,
                param0AboveParam1:['moq']
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
//            myEditor:{
//                required:true,
//                maxlength:65535
//            }
        },
        messages: {
            shopsId: {
                required : "请选择商铺！"
            },
            productId:{
                required : "请选择商品"
            },
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
//            myEditor:{
//                required:"产品详情不能为空",
//                maxlength:jQuery.validator.format("内容过多，数据过大")
//            }
        },
        validateDone: saveSkuInfo

    }

    $( "#shopsName" ).on("blur",function(){
        if($(this).val()==""){
            $(this).next().val("");
        }
    })

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


    // 取得下一级品类
    function getChildCatalog(parentid,level,obj){
        var url = window.ctx+"/catalog/subCatalog";
        if (parentid==""){
            parentid=-1;
        }
        $.ajax({
            url:url,
            type:"post",
            data:{
                catalogId:parentid
            },
            async:false,
            success:function(data){
                var data = $.parseJSON(data);
                var catalog1= '<option value="" selected>一级分类</option>';
                var catalog2= '<option value="" selected>二级分类</option>';
                var catalog3= '<option value="" selected>三级分类</option>';
                var productStandard= '<option value="" selected>标准商品</option>';
                if(data.length > 0) {
                    var html="";
                    if (level==1){
                        $("#catalogIdSecond").empty();
                        $("#catalogId").empty();
                        $("#productId").empty();
                        $("#catalogId").append(catalog3);
                        $("#catalogIdSecond").append(catalog2);
                        $("#productId").append(productStandard);
                    } else if (level==2) {
                        $("#catalogId").empty();
                        $("#productId").empty();
                        $("#catalogId").append(catalog3);
                        $("#productId").append(productStandard);
                    }else if(level==3){
                        $("#productId").empty();
                        $("#productId").append(productStandard);
                    }
                    for(var i = 0 ; i < data.length ; i++){
                        html += '<option value="' + data[i]["catalogId"] + '">' + data[i]["catalogNameCn"]+ '</option>';
                    }
                    console.log(html);
                    obj.append(html);
                }else{
                    if (level==1){
                        $("#catalogId").empty();
                        $("#catalogIdSecond").empty();
                        $("#productId").empty();
                        $("#catalogId").append(catalog3);
                        $("#catalogIdSecond").append(catalog2);
                        $("#productId").append(productStandard);
                    } else if (level==2) {
                        $("#catalogId").empty();
                        $("#productId").empty();
                        $("#catalogId").append(catalog3);
                        $("#productId").append(productStandard);
                    }else if(level==3){
                        $("#productId").empty();
                        $("#productId").append(productStandard);
                    }
                }
            }
        });
    }

    // 取得产品属性列表
    function getProductPropertyList(productId) {
        var url = window.ctx+"/ShopsSku/getProperty";
        $.ajax({
            url:url,
            type:"post",
            dataType:"json",
            data:{
                productId:productId
            },
            async:false,
            success:function(data){
//                    var productPropertyBo = $.parseJSON(data);
                var productPropertyBo =data.productPropertyBo;
                var productPropertyBoList = productPropertyBo.productPropertyBoList;
                $("#productPropertyId").empty();
                var str ='<h4 class="header">商品属性</h4>';
                if(typeof(productPropertyBoList)!="undefined"){
                    for (var i = 0; i<productPropertyBoList.length ;i++){
                        str +='<div class="formtable-list">';
                        str +='<div class="col-xs-6">';
                        str +='<label class="col-sm-5 col-md-4 formtable-list-default">'+productPropertyBoList[i].propertyNameCn+"："+'</label>';
                        str +='<div class="col-sm-7 col-md-8">';
                        str +='<input class="form-control"  id="'+productPropertyBoList[i].propertyId+'" value="" />';
                        str +='</div>';
                        str +='</div>';
                        str +='</div>';
                    }
                }

                unitNameCn=productPropertyBo.unitNameCn;
                $("#productPropertyId").append(str);

                $("#saleContent").find("span[class=unitNameCnText]").each(function(){
                        $(this).text(unitNameCn);
                    }
                );
            }
        });



    }

    // 取得标准商品
    function getProduct(parentid,level,obj){
        var url = window.ctx+"/product/getProduct";
        if (parentid==""){
            parentid=-1;
        }
        $.ajax({
            url:url,
            type:"post",
            data:{
                catalogId:parentid
            },
            async:false,
            success:function(data){
                data = $.parseJSON(data);
                var def= '<option value="" selected>标准商品</option>';
                if(data.length > 0) {
                    var html="";
                    $("#productId").empty();
                    $("#productId").append(def);
                    for(var i = 0 ; i < data.length ; i++){
                        html += '<option value="' + data[i].productId + '">' + data[i].productNameCn + '</option>';
                    }
                    obj.append(html);
                }else{
                    $("#productId").empty();
                    $("#productId").append(def);
                }
            }
        });
    }



    $("#catalogIdFirst").on("change",function() {
        var catalogId = $("#catalogIdFirst").val();
        getChildCatalog(catalogId,1,$("#catalogIdSecond"));
    });
    $("#catalogIdSecond").on("change",function() {
        var catalogId = $("#catalogIdSecond").val();
        getChildCatalog(catalogId,2,$("#catalogId"));
    });
    $("#catalogId").change(function() {
        var catalogId = $("#catalogId").val();
        getProduct(catalogId,3,$("#productId"));
    });


    $("#productId").change(function() {
        var productId = $("#productId").val();
        getProductPropertyList(productId);
        $("#moqUnitNameCn").text(unitNameCn);
        $("#stockNumUnitNameCn").text(unitNameCn);
    });

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
        $("#saleContent").find("span[class=unitNameCnText]").each(function(){
                $(this).text(unitNameCn);
            }
        );
    });

    validatorFrom.initValidatorFrom(option);


});

