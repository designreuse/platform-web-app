/**
 * Created by Administrator on 2015/11/16.
 */
$(function(){

    //多选框样式
    $(".select-label input").click(function() {
        if ($(this).children("input").is(":checked")== true){
            $(this).parent().addClass("active")
        }else {
            $(this).parent().removeClass("active")
        }
    });
    $(".select-label label").click(function() {
        if ($(this).children("input").is(":checked")== true){
            $(this).addClass("active")
        }else {
            $(this).removeClass("active")
        }
    })

    var option = {
        ele: "#srvOrderForm",
        rules: {
            userName: {
                required: true
            },
            contacts: {
                required: true
            },
            serviceId:{
                required:true
            },
            memo:{
                maxlength:500
            }
        },
        messages:{
            userName: {
                required: "委托方不能为空",
            },
            serviceId:{
                required:"服务不能为空"
            },
            contacts: {
                required: "请选择正确的委托方用户",
            },
            memo:{
                maxlength:"最多输入500个字",
            }
        },
        submitType:"post",
        postUrl:window.ctx+"/serviceOrder/edit",
        postDone:function(data){
            alert("保存成功")
            location.href=window.ctx+"/serviceOrder/list"
        }
    }
    validatorFrom.initValidatorFrom(option);

    //模糊查询委托方个人
    $( "#userName" ).autocomplete({
        source:window.ctx+"/serviceOrder/getContacts/",
        minLength: 1,
        autoFocus:true,
        select: function(e, ui) {
            $( "#contacts").val(ui.item.id);
            //根据个人找企业,代理企业
            $.ajax({
                url:window.ctx+"/serviceOrder/getOrg",
                type:"post",
                dataType:"json",
                data:{
                    userId:ui.item.id
                },
                success:function(e){
                    console.log(e.data)
                    $("#actingOrgId").empty()

                    //俄罗斯企业
                    if(e.data.orgName.countryId==2){
                        e.data.actingOrgList.forEach(function(d){
                            $("<option>").val(d.id).text(d.orgNameRu).appendTo($("#actingOrgId"));
                        })
                        if(e.data.entStatus ==1) {
                            $("#orgName").text(e.data.orgName.orgNameRu)
                            $("#orgId").val(e.data.orgName.orgId)
                            $("#actingOrgId").append("<option value=''>使用原企业</option>")
                        }else {
                            $("#orgId").val(e.data.orgName.orgId)
                        }
                    }else{
                        e.data.actingOrgList.forEach(function(d){
                            $("<option>").val(d.id).text(d.orgNameCn).appendTo($("#actingOrgId"));
                        })
                        if(e.data.entStatus ==1) {
                            $("#orgName").text(e.data.orgName.orgNameCn)
                            $("#orgId").val(e.data.orgName.orgId)
                            $("#actingOrgId").append("<option value=''>使用原企业</option>")
                        }else {
                            $("#orgId").val(e.data.orgName.orgId)
                        }
                    }
                }
            })
        }
    });

    //通过贸易订单申请服务订单，选择委托方企业，改变代理企业
    $("#buyOrgId").on("change",function(){
        $("#buyContacts").val($("#buyOrgId").data("contacts"))
        $("#buyActionOrgId").children().remove();
        console.log($("#buyOrgId").find("option:selected").data("acting"))
        if($("#buyOrgId").find("option:selected").data("acting")){
            $("<option>").val($("#buyOrgId").find("option:selected").data("acting")).text($("#buyOrgId").find("option:selected").data("actingname")).appendTo($("#buyActionOrgId"))
        }else{
            $("<option>").val("").text("无代理企业").appendTo($("#buyActionOrgId"))
        }
    })
})