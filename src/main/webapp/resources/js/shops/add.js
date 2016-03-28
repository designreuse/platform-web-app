var photoCount=0;

var webCount=0;

var cropOptionLogo = {
    $cropBtn: "#imgCropBtn",
    $btn: "#imgUploadBtn",
    uploadSuccess: function (file,response) {
        $(".imgCropModal").modal("hide");
        var src=response.resultData.urlPath;
        // var src=getImgTag(response.resultData.urlPath,400,400)
         $("#imgCropBtn").attr("src",getImgTag(response.resultData.urlPath,210,90));
         $("#shopsLogo").val(response.resultData.urlPath);
    },
    uploadError: function (reason) {

    },
    uploadComplete: function (file) {

    }
};
cropUpload(cropOptionLogo);



/*var cropOptionWeb = {
    $cropBtn: "#imgUploadWeb",
    $btn: "#imgUploadBtn",
    isCrop: "false",
    uploadSuccess: function (file,response) {
        $(".imgCropModal").modal("hide");
        var src=response.resultData.urlPath;


        var children = $("#photoDiv").children();
        if(children.length>=5){
            alert("最多添加三张图片");
            return;
        }
        var str ='<div class="col-sm-3">'
        str += '<img  style="width: 300px;height: 60px" src="'+src+'" class="img-responsive" alt="">';
        str += '<input name="url" placeholder="如：http://www.51aladdin.com" type="text" class="form-control">';
        str += '请输入图片url';
        str += '<a href="javascript: void(0)" onclick="removePhoto(this)" data-type="web" class="icon icon-del visible icon-tr"></a>';
        str += '</div>';
        webCount +=1;
        $("#photoTip").html('你还可以上传'+(3-webCount)+'/3张图片');
        $("#imgCorpBoxWebApp").after(str);
        if(webCount>=3){
            $("#imgCorpBoxWebApp").hide();
        }
    },
    uploadError: function (reason) {

    },
    uploadComplete: function (file) {

    }
};
cropUpload(cropOptionWeb);*/


/*var cropOptionApp = {
    $cropBtn: "#imgUploadApp",
    $btn: "#imgUploadBtn",
    isCrop: "false",
    uploadSuccess: function (file,response) {
        $(".imgCropModal").modal("hide");
        var src=response.resultData.urlPath;


        var children = $("#photoDivApp").children();
        if(children.length>=5){
            alert("最多添加三张图片");
            return;
        }
        var str ='<div class="col-sm-3">'
        str += '<img  style="width: 300px;height: 60px" src="'+src+'" class="img-responsive" alt="">';
        str += '<input name="url" placeholder="如：http://www.51aladdin.com" type="text" class="form-control">';
        str += '请输入图片url';
        str += '<a href="javascript: void(0)" onclick="removePhoto(this)" data-type="app" class="icon icon-del visible icon-tr"></a>';
        str += '</div>';
        photoCount +=1;
        $("#photoTipApp").html('你还可以上传'+(3-photoCount)+'/3张图片');
        $("#imgCorpBoxApp").after(str);
        if(photoCount>=3){
            $("#imgCorpBoxApp").hide();
        }
    },
    uploadError: function (reason) {

    },
    uploadComplete: function (file) {

    }
};
cropUpload(cropOptionApp);*/


//图片上传
imgUpload();


//触发file的点击事件
function reOLUploadFro(){
    $("#shopsLogoId").trigger("click");
}

function bannerLogoClick(){
    $("#bannerLogoId").trigger("click");
}

$('.datepicker').datetimepicker({
    language: 'zh-CN',
    format: 'yyyy-mm-dd',
    minView: "month",
    autoclose: 1,
    todayHighlight: 1
});

function removePhoto(node){
  /*  var appType=$(node).data("type");
    if(appType=='web'){
        webCount=webCount-1;
        $("#imgCorpBoxWebApp").show();
        $("#photoTip").html('你还可以上传'+(3-webCount)+'/3张图片');
    }
    if(appType=='app'){
        photoCount=photoCount-1;
        $("#imgCorpBoxApp").show();
        $("#photoTipApp").html('你还可以上传'+(3-photoCount)+'/3张图片');
    }*/
    photoCount=photoCount-1;
    $("#photoTip").html('图片大小支持2MB，图片尺寸为400X400<br>你还可以上传'+(3-photoCount)+'/3张图片');
    $(node).parent().remove();
}

function change(obj){
    var children = $("#photoDiv"+obj).children();
    if(children.length>=5){
        alert("最多添加三张图片");
        return;
    }
    var $dom = $("#shopsAd"+obj);
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
                var src= data.data.urlPath;
                var resourceCode= data.data.resourceCode;
//                        $("#resourcesCode").val(resourceCode)
//                        $("[name=logoUrl]").val(src);

                var str ='<div class="col-sm-3">'
                str += '<img id="'+resourceCode+'" style="width: 300px;height: 60px" src="'+src+'" class="img-responsive" alt="">';
                str += '<input name="url" placeholder="如：http://www.51aladdin.com" type="text" class="form-control">';
                str += '请输入图片url';
                str += '<a href="javascript: void(0)" onclick="removePhoto(this)" class="icon icon-del visible icon-tr"></a>';
                str += '</div>';

                photoCount +=1;
                $("#photoTip"+obj).html('图片大小支持2MB，图片尺寸为400X400<br>你还可以上传'+(3-photoCount)+'/3张图片');
                $("#photoDiv"+obj+" .col-xs-12.mar_t20").before(str);
//                        $("#bannerLogoSrc").attr('src',src);
            }else{
                alert("上传图片失败");
            }
        },error: function (xml, status, e){
            alert("上传图片失败");
        }
    });
}

$(function() {
    $(".theme-style").popover({
        placement: 'top',
        container: 'body',
        html: true,
        content: function () {
            return $(this).parent().children('.theme-style-cont').html();
        }
    });
})

$(function(){

    /*$(document).on("change",".hide-input .form-control",function(){
        $(this).next(".hide")[0].focus();
        $(this).next(".hide")[0].blur();
    })*/

    $(document).on("change","#shopsLogoId",function(){
        var $dom = $("#shopsLogoId");
        var id=$dom.attr("id");
        if (!/\.(gif|jpg|jpeg|png|bmp|GIF|JPG|PNG|BMP|JPEG)$/.test($dom.val())) {
            alert('"错误",hideClose:true,msgTitle: "请上传.jpg .jpeg .gif .png .bmp格式图像!"');
            return false;
        }
        if ($dom.get(0).files[0].size > 1024 * 1024 * 2){
            alert('不能上传超过2M的文件，您上传的文件过大，请重新上传！');
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
                    $("#resourceCode").val(resourceCode)
                    $("#shopsLogo").val(src);
                    $("#shopsLogoSrc").attr('src',src);
                    $("#shopsLogo").next(".popover").remove();
                }else{
                    alert("上传图片失败");
                }
            },error: function (xml, status, e){
                alert("上传图片失败");
            }
        });
    });

    $(document).on("change","#bannerLogoId",function(){
        var $dom = $("#bannerLogoId");
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
                    $("#bannerLogo").val(src);
                    $("#bannerLogoSrc").attr('src',src);
                    $("#bannerLogo").next(".popover").remove();
                }else{
                    alert("上传图片失败");
                }
            },error: function (xml, status, e){
                alert("上传图片失败");
            }
        });
    });

    $("input[name='iden']").click(function(){
        var shopsType = $(":radio[name='iden']:checked").val();
        if(shopsType=="1"){
            $("#iden0").removeClass("btn-default").removeClass('btn-primary');
            $("#iden1").removeClass("btn-default").removeClass('btn-primary');
            $("#iden0").addClass("btn-primary");
            $("#iden1").addClass("btn-default");

            $("#orgOrPersonParent").children(".orgOrPerson").remove();
            $("#orgOrPersonParent").append(
                '<div class="orgOrPerson col-xs-6">'+
                    '<label name="orgNameFlag" class="col-sm-5 col-md-4 formtable-list-require">所属公司：</label>'+
                    '<div name="orgNameFlag" class="col-sm-7 col-md-8 hide-input">'+
                        '<input id="orgName" placeholder="模糊搜索 选取结果" type="text" class="form-control">'+
                        '<input id="orgId" name="orgId" class="hide"/>'+
                        '<input id="adminUser" name="orgId" class="hide"/>'+
                    '</div>'+
                '</div>'
            )
            $("div[name='shopsContactsDiv']").show();
        }else{
            $("#iden0").removeClass("btn-default").removeClass('btn-primary');
            $("#iden1").removeClass("btn-default").removeClass('btn-primary');
            $("#iden1").addClass("btn-primary");
            $("#iden0").addClass("btn-default");

            $("#orgOrPersonParent").children(".orgOrPerson").remove();
            $("#orgOrPersonParent").append(
                '<div class="col-xs-6 orgOrPerson">'+
                    '<label name="personMobileFlag" class="col-sm-5 col-md-4 formtable-list-require">所属个人手机号：</label>'+
                    '<div name="personMobileFlag" class="col-sm-7 col-md-8 hide-input">'+
                        '<input id="mobile"  type="text" class="form-control">'+
                        '<input id="adminUser" name="orgId" class="hide"/>'+
                    '</div>'+
                    '</div>'+
                    '<div class="col-xs-6 orgOrPerson">'+
                    '<label name="personNameFlag" class="col-sm-5 col-md-4" >个人姓名：</label>'+
                    '<div name="personNameFlag" class="col-sm-7 col-md-8" >'+
                    '<input id="personName"   type="text" class="form-control" disabled>'+
                '</div>'
            );
            $("div[name='shopsContactsDiv']").hide();
            $("#mobile").on("blur",function(){
                var mobile = $("#mobile").val();
                if(mobile!=""){
//                $.ajax(
//                        url:window.ctx+"/shops/getUserByMobile"
                    $.ajax({
                        url:window.ctx+"/shops/getUserByMobile",
                        type:"post",
                        dataType:"json",
                        data:{
                            mobile:mobile
                        },
                        success: function (data) {
                            if(data){
                                if(data.isSuccess==false){
                                    $("#personName").val("");
                                    $("#adminUser").val("");
                                    if(data.resultData==null){
                                        alert("不存在该手机号的用户");
                                    }else if(data.resultMsg=="entuserstatus_org"){
                                        alert("该用户已隶属企业");
                                    }else if(data.resultMsg=="shop_exists"){
                                        alert("该用户已建商铺");
                                    }

                                }else{
                                    var resultData = data.resultData;
                                    if(resultData.length<=0){
                                        $("#personName").val("");
                                        $("#adminUser").val("");
                                    }else{
                                        for(var i=0;i<resultData.length;i++){
                                            if(resultData[i]["statusType"] ==2){
                                                $("#personName").val(resultData[i]["userNameCn"]);
                                                $("#adminUser").val(resultData[i]["orgId"]);
                                                break;
                                            }
                                        }
                                    }
                                }
                            }
                        }, error: function () {
                            $("#personName").val("");
                            $("#adminUser").val("");
                        }
                    });
                }
            })

        }
    });

    $("#orgName").on("blur",function(){
        if($(this).val()==""){
            $(this).next().val("");
        }
    })

    $("#orgName").autocomplete({
            source:window.ctx+"/shops/getOrgName",
            minLength: 1,
            autoFocus:true,
            select:function(e, ui) {
                var orgId = ui.item.id
                $( "#orgId").val(orgId);

//                /*$.ajax({
//                    url:window.ctx+"/shops/checkExistShop",
//                    type:"POST",
//                    dataType:"JSON",
//                    data:{
//                        orgId:orgId
//                    },
//                    success: function (data) {
//                        var str='<option value="">请选择</option>';
//                        if(data){
//                            if(data.resultData){
//                                var resultData = data.resultData;
//                                if(resultData.length>0){
//                                    $("#orgId").val("");
//                                    $("#adminUser").val("");
//                                    $("#shopsContacts").empty();
//                                    $("#shopsContacts").append(str);
//                                    alert("该企业已创建商铺")
//                                    $("#orgName")[0].focus();
//                                }
//                            }
//                        }
//                    }, error: function () {
//                        var str='<option value="">请选择</option>';
//                        $("#adminUser").val("");
//                        $("#shopsContacts").empty();
//                        $("#shopsContacts").append(str);
//                    }
//                });*/
                //获取企业管理员
                $.ajax({
                    url:window.ctx+"/shops/getUserListByOrgId",
                    type:"POST",
                    dataType:"JSON",
                    data:{
                        orgId:orgId
                    },
                    success: function (data) {
                        var str='<option value="">请选择</option>';
                        if(data){
                            if(data.resultData){
                                var resultData = data.resultData;
                                if(resultData.length>0){
                                    for(var i=0;i<resultData.length;i++){
                                        var tt=resultData[i].isRoot;
                                        console.log(tt);
                                        if(resultData[i].isRoot==0){
                                            $("#adminUser").val(resultData[i].userId);
                                        }
                                        str+= '<option value="' + resultData[i]["userId"] + '">' + resultData[i]["userNameCn"]+ '</option>';
                                    }
                                    if($("#adminUser").val()==""){
                                        $("#adminUser").val(resultData[0].userId);
                                    }
                                    $("#shopsContacts").empty();
                                    $("#shopsContacts").append(str);
                                }else{
                                    $("#adminUser").val("");
                                    $("#shopsContacts").empty();
                                }
                            }
                        }
                    }, error: function () {
                        $("#adminUser").val("");
                        $("#shopsContacts").empty();
                    }
                });
            },
            response:function(e, ui){
                $(this).next().val("");
            }
        }
    );

    //新增
    var optionAdd = {
        ele: "#addForm",
        submitType: "auto",
        rules: {
            orgId:{
                required:true
            },
            shopsContacts:{
                required:true
            },
            shopsNameCn: {
                required: true
            },
            shopsNameRu:{
                required: true
            },
            adTxt:{
                required: true,
                maxlength:500

            },
            summaryRu:{
                required:true,
                maxlength:500
            },
            shopsLogo:{
                required:true
            },
            bannerLogo:{
                required:true
            }
        },
        messages:{
            orgId:{
                required:"此项为必填项"
            },
            shopsContacts:{
                required:"请选择商铺联系人"
            },
            shopsNameCn: {
                required:"商铺名称（中文）不能为空"
            },
            shopsNameRu:{
                required:"商铺名称（俄文）不能为空"

            },
            adTxt:{
                required:"商铺介绍（中文）不能为空",
                maxlength:jQuery.validator.format("最多只能输入500个字符")
            },
            summaryRu:{
                required:"商铺介绍（俄文）不能为空",
                maxlength:jQuery.validator.format("最多只能输入500个字符")
            },
            shopsLogo:{
                required:"商铺LOGO不能为空"
            },
            bannerLogo:{
                required:"商铺横幅广告链接不能为空"
            }
        },
        validateDone: function(form){

            var shopsType = $(":radio[name='iden']:checked").val();
            var orgId = $("#orgId").val();
            var mobile = $("#mobile").val();
            var userId = $("#adminUser").val();
            var shopsNameCn = $("#shopsNameCn").val();
            var shopsNameRu = $("#shopsNameRu").val();
            var adTxt = $("#adTxt").val();
            var summaryRu = $("#summaryRu").val();
            var shopsLogo = $("#shopsLogo").val();
            var resourceCode = $("#resourceCode").val();
            var bannerLogo = $("#bannerLogo").val();
            var bannerUrl = $("#bannerUrl").val();
            var styleModel = $(":radio[name='styleModel']:checked").val();
            var shopsContacts = $("#shopsContacts").find("option:selected").val();
            var shopsAdList = []
            $("#photoDiv").find("img").each(function(i){
                var skuPhotoVo = {};

                if($(this).attr("id")=="imgUploadWeb"){
                    return;
                }
                skuPhotoVo.adLogo = $(this).attr("src");
                skuPhotoVo.sort = i+1;
                skuPhotoVo.adUrl = $(this).next().val()
                skuPhotoVo.type = 1
                shopsAdList.push(skuPhotoVo);
            });
            $("#photoDivApp").find("img").each(function(i){
                var skuPhotoVoApp = {};
                if($(this).attr("id")=="imgUploadApp"){
                    return;
                }
                skuPhotoVoApp.adLogo = $(this).attr("src");
                skuPhotoVoApp.sort = i+1;
                skuPhotoVoApp.adUrl = $(this).next().val();
                skuPhotoVoApp.type = 2
                shopsAdList.push(skuPhotoVoApp);
            });

            $.ajax({
                url:window.ctx+"/shops/saveShop",
                type:"post",
                dataType:"json",
                async:false,
                data:{
                    shopsType:shopsType,
                    orgId:orgId,
                    mobile:mobile,
                    userId:userId,
                    shopsNameCn:shopsNameCn,
                    shopsNameRu:shopsNameRu,
                    adTxt:adTxt,
                    summaryRu:summaryRu,
                    shopsLogo:shopsLogo,
                    resourceCode:resourceCode,
                    bannerLogo:bannerLogo,
                    bannerUrl:bannerUrl,
                    shopsContacts:shopsContacts,
                    styleModel:styleModel,
                    categoryId:$("#categoryId").val(),
                    shopsAd:JSON.stringify(shopsAdList)
                },
                success: function (data) {
                    alert("新增店铺成功");
                    window.location.href = window.ctx + "/shops/list";

                }, error: function () {
                    alert("新增店铺失败，服务器出现错误");
                }
            });

        }


    }
    validatorFrom.initValidatorFrom(optionAdd);
})


//商铺logo 使用默认图片
$("#delLogo").on("click",function(){
    var defaultLogo="http://devimg.51aladdin.com/6fc813be-fb4d-4eaa-a654-373804dd535e.jpg";
    $("#shopsLogo").val(defaultLogo);
    $("#imgCropBtn").attr('src',getImgTag(defaultLogo,210,90));
});