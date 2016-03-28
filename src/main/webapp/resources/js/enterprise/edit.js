var adultId;
$(document).ready(function () {
    //地址三级联动
    $(".chklist").labelauty("chklist", "check");
    var provSelect = $("#provSelect");
    var countrySelect = $("#countrySelect");
    var citySelect = $("#citySelect");
    var distSelect = $("#distSelect");
    if("" === $("#provSelect").val()){
    var countryId = countrySelect.val();
    citySelect.hide();
    distSelect.hide();
    loadAddress("/address/province/"+countryId,provSelect);
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


    //保存企业基本信息
    $("#orgSubmit").click(function(){

        if(!$("#orgNameCn").val()){
            alert("公司名称（中文）必须填写");
            return;
        }
        if(!$("#citySelect").val()){
            alert("公司地址（中文）必须填写");
            return;
        }
        if(!$("#addrCn").val()){
            alert("公司地址（中文）必须填写");
            return;
        }
        if(!$("#corporation").val()){
            alert("公司法人必须填写");
            return;
        }
        if(!$("#corporationPy").val()){
            alert("公司法人（拼音）必须填写");
            return;
        }

        if(!$("#optRegionCn").val()){
            alert("经营范围（中文）必须填写");
            return;
        }

        if(!$("#taxCert").val()){
            alert("税务登记号必须填写");
            return;
        }

        //获取复选框的值
        var identityList =[];//定义一个数组
        $('input[name="identityIdList"]:checked').each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数
            var identity = {}
            identity.identityId = $(this).val()
            identityList.push(identity);//将选中的值添加到数组chk_value中
        });
        var identityJson=JSON.stringify(identityList);
        $.ajax({
            url:window.ctx+"/enterprise/edits?"+$("#orgForm").serialize(),
            type:"POST",
            data:{
                json:identityJson
            },
            dataType:"json",
            success:function(){
                alert("保存成功！");
                location.reload();
            },error:function(){
                alert("保存失败！");
            }
        });
    });

    //启用
    $("#start").click(function(){
        updateDisabled(false,false)
    });

    //禁用
    $("#forbidden").click(function(){
        updateDisabled(true,true)
    });

    //保存服务信息
    $("#serviceSubmit").click(function(){
        //获取复选框的值
        var serviceList =[];//定义一个数组
        $('input[name="serviceId"]:checked').each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数
            var entity={}
            entity.serviceId=$(this).val()
            entity.orgId=$("#orgId").val()
            serviceList.push(entity);//将选中的值添加到数组chk_value中
        });
        var services=JSON.stringify(serviceList);
        $.ajax({
            url:window.ctx+"/enterprise/serviceEdit",
            type:"POST",
            data:{
                service:services,
                id:$("#orgId").val()
            },
            success:function(){
                alert("保存成功！");
                location.reload();
            },error:function(){
                alert("保存失败！");
            }
        })
    })

    //保存行业信息行业
    $("#industrySubmit").click(function(){
        //获取复选框的值
        var chk_value =[];//定义一个数组
        $('input[name="industryId"]:checked').each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数
            var entity={}
            entity.industryId=$(this).val()
            entity.optType=$(this).data('type')
            entity.orgId=$("#orgId").val()
            chk_value.push(entity);//将选中的值添加到数组chk_value中
        });
        var strJson=JSON.stringify(chk_value);
        $.ajax({
            url:window.ctx+"/enterprise/industryEdit",
            type:"POST",
            data:{
                indestry:strJson,
                id:$("#orgId").val()
            },
            success:function(){
                alert("保存成功！");
                location.reload();
            },error:function(){
                alert("保存失败！");
            }
        })
    })

    //审核
    $(".ent_adult").click(function(){
        if(!$("#adultContent").val()){
            alert("审核内容不能为空!")
            return false;
        };
        $("#adultStatus").val($(this).attr("data_status"))
        $("#adultForm").submit();
    })

})




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



 function updateDisabled(e,data){
    $.ajax({
        url:window.ctx+"/enterprise/edit",
        type:"POST",
        data:{
            disabled:e,
            id:$("#orgId").val()
        },
        success:function(){
            if(data == true){
                $("#start").attr("style","")
                $("#forbidden").attr("style","display:none")
            }else{
                $("#forbidden").attr("style","")
                $("#start").attr("style","display:none")
            }
        }
    })
}


//审核
function adultShow(orgId){
    $("#dynamicId").val(orgId);
    $("#applyType").val(1);
}

//审核
function adultShowByFile(aduitId){
    $("#id").val(aduitId);
    $("#applyType").val(2);
}

//文件审核审核
function fileAdultSubmit(id,orgId,applyType){
    aldutSubmit(orgId,applyType);
    $("#id").val(id);
}

function clearAduitInfo(){
    $("#dynamicId").val('');
    $("#applyType").val('');
    $("#id").val('');
    $("#adultContent").val('');
    $("#adultStatus").val('');
}

//
//function submitAdult(){
//    $.ajax({
//        url:window.ctx+"/adult/updateStatus",
//        type:"POST",
//        dataType:"json",
//        data:$("#adultForm").serialize(),
//        success:function(data){
//            if ( $("#applyType").val()=="1")
//            {
//                alert("审核完成！");
//                location.reload();
//            }
//            else {
//                var adult
//                alert("审核完成！")
//                $("#" + $("#id").val() + " td").remove();
//                adult = '<td>'
//                adult += data.adultBo.applyUserName
//                adult += '</td><td>'
//                adult += data.adultBo.applyContent
//                adult += '</td><td>'
//                adult += new Date(data.adultBo.createTime).Format("yyyy-MM-dd hh:mm")
//                adult += '</td><td>'
//                if (data.adultBo.adultStatus == 1) {
//                    adult += '审核通过</td>'
//                } else {
//                    adult += '审核拒绝</td>'
//                }
//                adult += '<td>'
//                adult += data.adultBo.modifyUserName
//                adult += '</td><td>'
//                adult += new Date(data.adultBo.modifyTime).Format("yyyy-MM-dd hh:mm")
//                adult += '</td><td>'
//                adult += data.adultBo.adultContent
//                adult += '</td>'
//                adult += '<td></td>'
//                $("#" + $("#id").val()).html(adult);
//                clearAduitInfo();
//            }
//            },
//            error:function(){
//                alert("审核出现错误！")
//            }
//})
//}




//
//    $('#sattachMent').on('change', function(fileType) {
//        fileSubmit("attachment",1,$("#attachmentName").val())
//    })
//    var fileSubmit =function(fileId,fileType,fileName) {
//        $.ajaxFileUpload({
//            url:window.ctx+'/uploadImg',
//            secureuri:false,
//            fileElementId:fileId,//file标签的id
//            dataType: 'json',//返回数据的类型
//            data:{
//                attachmentType:fileType,
//                attachmentName:fileName
//            },//一同上传的数据
//            success: function (data, status) {
//
//            },
//            error: function (data, status, e) {
//                alert(e);
//            }
//        });
//    };

