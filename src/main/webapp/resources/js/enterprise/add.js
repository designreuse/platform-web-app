var adultId;
$(document).ready(function () {
    //地址三级联动
    $(".chklist").labelauty("chklist", "check");
    var provSelect = $("#provSelect");
    var countrySelect = $("#countrySelect");
    var citySelect = $("#citySelect");
    var distSelect = $("#distSelect");
    if("" === provSelect.val()){
    citySelect.hide();
    distSelect.hide();
    loadAddress("/address/province/1",provSelect);
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
            if(!$("#addrCn").val()){
                alert("公司地址（中文）必须填写");
                return;
            }
            if(!$("#corporation").val()){
                alert("公司法人必须填写");
                return;
            }
            if(!$("#website-static3").val()){
                alert("公司法人（拼音）");
                return;
            }

            if(!$("#website-uploadfile").val()){
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
        console.log(identityJson)
        $.ajax({
            url:window.ctx+"/enterprise/edits?"+$("#orgForm").serialize(),
            type:"POST",
            data:{
                json:identityJson
            },
            dataType:"json",
            success:function(result){
                alert("保存成功！");
                window.location.href=window.ctx+"/enterprise/"+result.data+"/edit"
            },error:function(){
                alert("保存失败！");
            }
        });
    });

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
                $("#end").attr("style","display:none")
            }else{
                $("#end").attr("style","")
                $("#start").attr("style","display:none")
            }
        }
    })
}


//审核
function aldutSubmit(id){
    $("#id").val(id);
    adultId=id;
}

function submitAdult(){
    $.ajax({
        url:window.ctx+"/adult/updateStatus",
        type:"POST",
        dataType:"json",
        data:$("#adultForm").serialize(),
        success:function(data){
            var adult
            alert("审核完成！")
            $("#"+adultId+" td").remove();
            adult='<td>'
            adult+=data.adultBo.applyUserName
            adult+='</td><td>'
            adult+=data.adultBo.applyContent
            adult+='</td><td>'
            adult+=new Date(data.adultBo.createTime).Format("yyyy-MM-dd hh:mm")
            adult+='</td><td>'
            if(data.adultBo.adultStatus ==1){
                adult+='审核通过</td>'
            }else{
                adult+='审核拒绝</td>'
            }
            adult+='<td>'
            adult+=data.adultBo.modifyUserName
            adult+='</td><td>'
            adult+=new Date(data.adultBo.modefyTime).Format("yyyy-MM-dd hh:mm")
            adult+='</td><td>'
            adult+=data.adultBo.adultContent
            adult+='</td>'
            adult+='<td></td>'
            $("#"+adultId).html(adult)
            },
            error:function(){
                alert("审核出现错误！")
            }
})
}




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

