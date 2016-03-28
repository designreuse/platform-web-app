$(document).ready(function () {

//    $("input[name='regSource']").each(function(){
//        var temp = 0;
//        var flag = $(this).attr("checked");
//        if($(this).attr("checked") == "checked" && temp == 0){
//            alert("1");
//        }
//    });

//    $("input[name='regSource']").each(function(){
//        var flag = $(this).attr("checked");
//        if($(this).attr("checked") == "checked" && $(this).attr("value") == 3){
//            alert("3");
//        }
//        if($(this).attr("checked") == "checked" && $(this).attr("value") == 5){
//            alert("5");
//        }
//        if($(this).attr("checked") == "checked" && $(this).attr("value") == 2){
//            alert("2");
//        }
//    });

    $("#shop_pass").click(function(){
        updateStatusType(1)
    })

    $("#shop_refuse").click(function(){
        updateStatusType(2)
    })

    $("#rdobox1").click(function(){
        $("#nth").empty();
        $("#nth").append("<span class='c-red'  id='nid'>*</span> 姓名（中文）：");
        $("#mth").empty();
        $("#mth").append("<span class='c-red' id='mid'>*</span> 手机");
        $("#yid").remove();
    });
    $("#rdobox2").click(function(){
        $("#nid").remove();
        $("#mid").remove();
        $("#you").empty();
        $("#you").append("<span class='c-red' id='yid'>*</span>邮箱：");
    });
    $("#rdobox3").click(function(){
        $("#nth").empty();
        $("#nth").append("<span class='c-red'  id='nid'>*</span> 姓名（中文）：");
        $("#mth").empty();
        $("#mth").append("<span class='c-red' id='mid'>*</span> 手机");
        $("#yid").remove();
    });



    //根据用户输入公司模糊查询搜索
    $( "#orgName" ).autocomplete({
        source:window.ctx + "/user/orgList",
        minLength: 1,
        autoFocus:true,
        search: function(e, ui){
            $("#orgId").val('');
        },
        select: function(e, ui){
            $("#orgId").val(ui.item.id);
        },
    });

    //参数{input类名，选择类型(单选or多选)}
    $(".rdolist").labelauty("rdolist", "rdo");
    $(".chklist").labelauty("chklist", "check");

    //隱藏验证码输入框，隐藏验证按钮
    $("#code").hide();
    $("#validateCode").hide();

    //地址三级联动
    var provSelect = $("#provSelect");
    var countrySelect = $("#countrySelect");
    var citySelect = $("#citySelect");
    var distSelect = $("#distSelect");

    if("" === $("#provSelect").val()){
        citySelect.hide();
        distSelect.hide();
        loadAddress("/address/province/1",provSelect);
    }

    if("" === $("#distSelect").val()){
        distSelect.hide();
    }

    countrySelect.on("change",function(){
        var countryId = countrySelect.val();
        if(countryId){
            citySelect.hide();
            distSelect.hide();
            citySelect.children().first().siblings().remove();
            distSelect.children().first().siblings().remove();
            loadAddress("/address/province/"+countryId,provSelect);
        }
    });

    provSelect.on("change",function(){
        var provId = provSelect.val();
        if(provId){
            distSelect.hide();
            distSelect.children().first().siblings().remove();
            loadAddress("/address/city/"+provId,citySelect);
        }
    });
    citySelect.on("change",function(){
        var cityId = citySelect.val();
        if(cityId){
            loadAddress("/address/district/"+cityId,distSelect);
        }
    });

    //启用
    $("#start").click(function(){
        updateEdit(1)
    })
    //禁用
    $("#forbidden").click(function(){
        updateEdit(2)
    })




    //保存基本信息
    $("#submitUser").on("click",function(){
//        alert(new Date());
//        alert($("#birthday").val());
//        var birthday = $("#birthday").val();
//        var today = new Date();
//        alert(birthday < today);
//        if(birthday > today){
//            alert("111111");
//        }

        if(!$("#orgName").val()){
            alert("公司名必须注册");
            return;
        }
        if($("#tel").val() || $("#tel2").val() || $("#tel4").val()){
            if(!$("#tel").val()){
                alert("电话国家号必填");
                return;
            }
            if(!$("#tel2").val()){
                alert("电话区号必填");
                return;
            }
            if(!$("#tel4").val()){
                alert("电话号必填");
                return;
            }

        }
        if($("#Fax").val() || $("#Fax1").val() || $("#Fax2").val()){
            if(!$("#Fax").val()){
                alert("传真国家号必填");
                return;
            }
            if(!$("#Fax1").val()){
                alert("传真区号必填");
                return;
            }
            if(!$("#Fax2").val()){
                alert("传真号必填");
                return;
            }

        }
        if(!$("#orgId").val()){
            alert("请选择公司");
            return;
        }
        if($("#nid").length > 0){
            if(!$("#userNameCn").val()){
                alert("姓名必须填写");
                return;
            }
        }
        if(!$("#userNameFirst").val()){
            alert("FirstName必须填写");
            return;
        }
        if(!$("#userNameLast").val()){
            alert("LastName必须填写");
            return;
        }
        if($("#regSource").val() == 3|| $("#regSource").val() == 6 || $("input[name=regSource]:checked").val() == 3){
            if(!$("#mobile").val()){
                alert("手机号必须填写");
                return;
            }
            if(!$.isNumeric($("#mobile").val())){
                alert("手机号必须是数字");
                return;
            }
            checkUsername()
        }
        if($("#regSource").val() == 5 || $("#regSource").val() == 7 ||  $("input[name=regSource]:checked").val() == 5){
            if(!$("#email").val()){
                alert("邮箱必须填写");
                return;
            }
        }
        if($("#userId").val() == null){
            if(!$("#password").val()){
                alert("密码必须填写");
                return;
            }
        }
        if($("#password").val() !=null){
            if($("#password2").val() != $("#password").val()){
                alert("两次密码不一致");
                return;
            }
        }







        $.ajax({
            type:"POST",
            url:window.ctx+"/user/edit",
            data:$("#userDetail").serialize(),
            async: false,
            dataType : "json",
            success:function(data){
                alert(data.msg);
                if(data.result){
                    window.location.href=window.ctx+"/user/list"
                }
            }
        })
    });

    //$("#orgName").on("blur",function(){
    //    var orgName = $("#orgName").val();
    //    $.ajax({
    //        type:"POST",
    //        url:window.ctx+"/user/checkOrg",
    //        data:{"orgName":orgName},
    //        dataType: "json",
    //        async: false,
    //        success:function(data) {
    //            if(data.result){
    //                var orgId = data.data.id
    //                $("#orgId").val(orgId);
    //                $("#noOrglabel").hide();
    //            }else{
    //                alert(data.msg);
    //                $("#noOrglabel").show();
    //            }
    //        }
    //    })
    //})

    $("#entUserStatus3").on("click",function(){
        if( $("#entUserStatus3").prop('checked')){
            $("#orgName").val('');
            $("#orgId").val('');
        }
    });
    //发送验证码
    $("#sendCode").click(function(e){
        if($("#mobile").val().trim()!="")
        {
            e.preventDefault();
            $("#code").show();
            $("#validateCode").show();
            var mobile = $("#mobile").val();
            var _url = window.ctx + "/user/sendCode";
            var url = encodeURI(_url);
            $.ajax({
                type: "post",
                url: url,
                dataType: "json",
                data: {"mobile": mobile},
                success: function () {
                    $(e.target).text("验证码已发送");
                },
                error: function () {
                    alert("发送失败")
                }
            });
        }
        else
        {
            alert("手机号码不能为空")
        }
    });
    //校验验证码
    $("#validateCode").on("click",function(){
        var code=$("#code").val();
        var mobile=$("#mobile").val();
        if (code!="" && mobile!="") {
            $.ajax({
                type: "POST",
                url: window.ctx + "/user/reset/validCode",
                data: {
                    "mobile": mobile,
                    "code": code
                },
                async: false,
                success: function (data) {
                    if (data.success) {
                        $("#span").html('<img src="${ctx}/resources/images/icon_right_s.png" width="18" height="20">已验证');
                        $("#mobileStatus").val(1)
                    } else {
                        $("#span").html('<img src="${ctx}/resources/images/icon_right_s2.jpg" width="18" height="17">验证失败');
                    }
                },
                error: function () {
                    $("mobilevalidate").text("验证未通过")
                }
            });
        }
        else
        {
            alert("手机号码,验证码不能为空")
        }
    });

    //挂靠退出申请
    $("#quitAnchored").click(function(){
        var orgId = $("#orgId").val();
        var userId = $("#userId").val();
        $.ajax({
            url:window.ctx+"/user/quitAnchored",
            type:"post",
            dataType : "json",
            data:{
                "applyType":$(this).val(),"orgId":orgId,"userId":userId
            },
            success:function(e){
                if(e.result){
                    alert("申请成功")
                    location.reload();
                }else{
                    alert("申请失败")
                    location.reload();
                }
            }
        })
    })

    //退出公司
    $("#quitOrg").click(function(){
        if(confirm("是否确认退出")){
            var orgId = $("#orgId").val();
            var userId = $("#userId").val();
            $.ajax({
                url:window.ctx+"/user/quitOrg",
                type:"post",
                dataType : "json",
                data:{
                    "orgId":orgId,"userId":userId
                },
                success:function(data){
                    if(data.result){
                        alert("退出成功")
                        location.reload()
                    }else{
                        alert("退出失败")
                    }
                }
            })
        }
    })

    //同意
    $(".user_adult").click(function(){
        var orgId = $("#orgId").val();
        var userId = $("#userId").val();
        $.ajax({
            url:window.ctx+"/user/doApply",
            type:"post",
            dataType:"json",
            data:{
                "adultStatus":$(this).val(),
                "applyType":$(this).attr("data_type"),
                "orgId":orgId,
                "userId":userId
            },
            success:function(e){
                alert(e.msg)
                location.reload();
            }
        })
    })

    //拒绝
    $(".refuse").click(function(){
        var orgId = $("#orgId").val();
        var userId = $("#userId").val();
        $.ajax({
            url:window.ctx+"/user/doApply",
            type:"post",
            data:{
                "adultStatus":2,"applyType":$(this).val(),"orgId":orgId,"userId":userId
            },
            success:function(data){
                if(data.result){
                    alert("申请成功")
                    location.reload();
                }else{
                    alert("申请失败")
                    location.reload();
                }
            }
        })
    })

    $(".joinSuccess").click(function(){
        $.ajax({
            url:window.ctx+"/user/join",
            ype:"post",
            data:{
                adultStatus:$(this).val(),
                status:1
            },
            success:function(){
                alert("申请成功")
                location.reload();
            }
        })
    })

    $(".joinError").click(function(){
        $.ajax({
            url:window.ctx+"/user/join",
            ype:"post",
            data:{
                adultStatus:$(this).val(),
                status:0
            },
            success:function(){
                alert("申请成功")
                location.reload();
            }
        })
    })

    //修改密码
    $("#submitPwd").on("click",function(){
        if(!$("#newPwd").val()){
            alert("密码不能为空");
            return;
        }
        if(!($("#newPwd").val() === $("#newPwd2").val())){
            alert("两次密码输入不一致")
            return;
        }
        $.ajax({
            type:"POST",
            url:window.ctx+"/user/resetPwd",
            data:{
                userId:$("#userId").val(),
                password:$("#newPwd").val()
            },
            async: false,
            success:function(){
                alert("保存成功！")
            }
        });
    });

});

function loadAddress(url,target){
    $.get(window.ctx+url,function(data){
        target.children().first().siblings().remove();
        data.forEach(function(d) {
            target.append($("<option></option>").val(d.id).text(d.cnname+"("+ d.enname+")"));
        });
        if(data.length>0){
            target.show();
        }
    },"json");
}
//可用修改
function updateEdit (e){
    $.ajax({
        url:window.ctx+"/user/updateStatus",
        type:"POST",
        data:{
            status:e,
            userId:$("#userId").val()
        },
        dataType:"json",
        success:function(e){
            alert(e.msg)
            location.reload();
        }
    })
}

//审核修改
function updateStatusType (e){
    $.ajax({
        url:window.ctx+"/user/updateStatusType",
        type:"POST",
        data:{
            statusType:e,
            userId:$("#userId").val()
        },
        dataType:"json",
        success:function(e){
            alert(e.msg)
            location.reload();
        }
    })
}


//上传
$(document).on("change","#front_upload_img",function(){
    var $dom = $(this);
    var id=$dom.attr("id");
    if (!/\.(gif|jpg|jpeg|png|bmp|GIF|JPG|PNG|BMP|JPEG)$/.test($dom.val())) {
//        $("#driving_uploading_operation").removeClass("hide");
//        $("#driving_uploading_running").addClass("hide");
//        miscs.alert({title: "错误",hideClose:true,msgTitle: "请上传.jpg .jpeg .gif .png .bmp格式图像!",iconCls: "ierror",successBtn: "确认",success:function(t){
//            $(t).popup({close: true});
//
//        }});
        alert('"错误",hideClose:true,msgTitle: "请上传.jpg .jpeg .gif .png .bmp格式图像!"');
        return false;
    }
    //The file size upload at most 5 m
    if ($dom.get(0).files[0].size > 1024 * 1024 * 5){
//        $("#driving_uploading_operation").removeClass("hide");
//        $("#driving_uploading_running").addClass("hide");
//        miscs.alert({title: "错误",hideClose:true,msgTitle: "不能上传超过5M的文件，您上传的文件过大，请重新上传！",iconCls: "ierror",successBtn: "确认",success:function(t){
//            $(t).popup({close: true});
//
//        }});
        alert('不能上传超过5M的文件，您上传的文件过大，请重新上传！');
        $dom.val(null);
        return false;
    }

    var paramsData = getFrontRecordsSizes();

    $.ajaxFileUpload({
        url:ctx+'/aldUpload/uploadImg',
        secureuri:false,
        data: paramsData,
        fileElementId:id,
        dataType:"json",
        success: function(data){
            if(data.result){
                var src= data.data.storePath;
                var resourceCode = data.data.fileId;
                $("[name='idcardPathFront']").val(resourceCode);
                $(".front_img").html('<img src="' + src + '"><i class="del_front_img" title="点击删除"></i>');
            }else{
                alert("上传图片失败");
            }
        },error: function (xml, status, e){
            alert("上传图片失败");
        }
    });
});

/**
 * 获取上传图片尺寸列表
 * @returns {{widths: Array, heights: Array}}
 */
var getFrontRecordsSizes = function() {
    var widths = [40, 128, 256, 512];
    var heights = [36, 96, 192, 384];

    var width = 256;
    var height = 192;

    return {
        widths: widths,
        heights: heights,
        width: width,
        height: height
    }
}

//    function timecount(t){
//        window.setTimeout(function(){
//            t--;
//            if(t == 0){
//                $(".butCountMinute").text("重新获取验证码").removeClass("hide");
//                $("#countMinute").addClass("hide");
//                $(".num-count").text("60");
//            }else{
//                $(".num-count").text(t);
//                timecount(t);
//            }
//
//        },1000);
//    };

//$("#quitOrg").click(function(e){
//    $.ajax({
//        url:window.ctx+"/user/update",
//        type:"POST",
//        data:{
//            id:$("#id").val(),
//            userType:2
//        },
//        success:function(){
//            $("#orgName").val("")
//            $("userType0").checked
//            alert("修改成功！")
//        }
//
//    })
//})

function checkUsername(){
    var phoneNumber = $("#mobile");
    var data = phoneNumber.val();
    if ($("#oldMobile").val() !=phoneNumber.val()){
        isExist(data,"手机号码重复，请重新输入")
    };
}

function checkUsernameByEmail(){
    var email = $("#email");
    var data = email.val();
    if ($("#oldEmail").val() !=data){
        isExist(data,"邮箱重复，请重新输入")
    }

}

function isExist(data,msg){
    $.ajax({
        url:ctx+"/user/checkMobileAndEmail",
        type:"post",
        data:{
            userName:data
        },
        dataType:"json",
        success:function(data){
            if(!data){
                alert(msg);
                return false;
            }
        }
    })
}

