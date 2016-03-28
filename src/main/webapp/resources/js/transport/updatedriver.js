$(function() {

    var countryNo = $("#countryNo");

    countryNo.on("change",function(){
        var ids = countryNo.val();
        $.ajax({
            url: window.ctx + '/transport/getCountryMemo?value=' + ids,
            dataType:"json",
            success: function (msg) {
                    $('#msg').text(msg.msg);
            }
        })
    });

    var option = {
        ele: "#form1",
        submitType: "auto",
        rules: {
            driverName: {
                required: true
            },
            driverMobile: {
                required: true,
                isMobile:function(){
                    if($("#countryNo").val()== '1'){
                        return true;
                    }else if($("#countryNo").val()== '3'){
                        return false;
                    }

                }
            },
            idCard:{
                required: true
            }
        },
        messages:{
            carLicence: {
                required: "车牌号不能为空"
            },
            carType: {
                required: "请输入正确的手机号"
            }
        },
        validateDone:function(form){
            $("#submitForm").attr("disabled","disabled")
            $.ajax({
                url:window.ctx+"/transport/saveDriver",
                dataType:"json",
                type:"post",
                data:$("#form1").serialize(),
                success:function(data){
                    location.href = window.ctx+"/transport/listDriver"
                }
            })
        }
    }

    validatorFrom.initValidatorFrom(option);

})

function update(){
    window.location.href=window.ctx+"/transport/detailDriver?id="+$("#id").val()+"&type=update";
}



