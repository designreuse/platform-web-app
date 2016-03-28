/**
 * Created by Administrator on 2015/12/8.
 */
$(function () {
    $(document).on('click', '.select-label input', function () {
        $(this).parent().parent().children("label").removeClass("active");
        if ($(this).is(":checked") == true) {
            $(this).parent().addClass("active")
        }
    });
    $(document).on('click', '.select-label label', function () {
        $(this).parent().children("label").removeClass("active");
        if ($(this).children("input").is(":checked") == true) {
            $(this).addClass("active")
        }
    })

    var actingForm = {
        ele: "#actingForm",
        submitType: "auto",
        rules: {
            actingOrgId: {
                required: true
            }
        },
        messages: {
            actingOrgId: {
                required: "请先选择代理企业"
            }
        },
        validateDone: function (form) {
            var actingOrgId = $("input[name='actingOrgId']:checked").val();
            if (actingOrgId == $("#orgId").val()) {
                actingOrgId = null
            }
            $.ajax({
                url: window.ctx + "/inquiry/confirm",
                type: "post",
                dataType: "json",
                async : false,
                data: {
                    feedBackId: $("#inquiryFeedbackId").val(),
                    inquiryId: $("#inquiry").val(),
                    inquiryType: $("#type").val(),
                    status: $("#status").val(),
                    actingId: actingOrgId
                },
                success: function (data) {
                    alert(data.msg)
                    location.href = window.ctx + "/inquiry/detail?inquiryId=" + $("#inquiry").val() + "&feedbackId=" + $("#inquiryFeedbackId").val() + "&inquiryType=" + $("#type").val()
                }
            })
        }
    }
    validatorFrom.initValidatorFrom(actingForm);

})

function changeStatus(){
    $.ajax({
        url:window.ctx+"/inquiry/changeStatus",
        type:"post",
        dataType:"json",
        async : false,
        data:{
            inquiryId:$("#inquiry").val(),
            feedBackId:$("#inquiryFeedbackId").val(),
            status:5,
            inquiryType:$("#type").val()
        },
        success:function(data){
            alert(data.msg)
            location.href = window.ctx + "/inquiry/list"
        }
    })
}
function changeAudit(status,auditStatus){
    $.ajax({
        url:window.ctx+"/inquiry/changeAuditStatus",
        type:"post",
        dataType:"json",
        async : false,
        data:{
            inquiryId:$("#inquiry").val(),
            feedBackId:$("#inquiryFeedbackId").val(),
            status:status,
            inquiryType:$("#type").val(),
            auditStatus:auditStatus
        },
        success:function(data){
            alert(data.msg)
            location.href = window.ctx + "/inquiry/list"
        }
    })
}