//validator拓展
jQuery.validator.addMethod("math", function(value, element, params) {
    return this.optional(element) || value == params[0] + params[1];
}, jQuery.validator.format("Please enter the correct value for {0} + {1}"));
jQuery.validator.addMethod("domain", function(value, element) {
    return this.optional(element) || /^http:\/\/mycorporatedomain.com/.test(value);
}, "请输入正确domain");





jQuery.validator.addMethod("isIdCardNo", function(value, element) {
    var isCard = /^(\d{15}|\d{17}[\dXx])$/;
    return this.optional(element) || isCard.test(value);
}, "请正确输入您的身份证号码");

// 手机号码验证
jQuery.validator.addMethod("isMobile", function(value, element) {
    var length = value.length;
    var mobile = /^0?1[3|4|5|8][0-9]\d{8}$/;
    var ruMobile  = /^0?\d{10}$/;
    if(length == 0){
        return true;
    }
    return this.optional(element) || ((length == 11 && mobile.test(value)) || ruMobile.test(value));
}, "请正确填写您的手机号码");


// 对车牌号进行验证
jQuery.validator.addMethod("isCarLicence", function(value, element) {
    var num ;

    //console.log($(element).parent().parent().parent().parent().attr('id'));

    $.ajax({
        url: window.ctx + "/stock/getCarLicenct?carLicence="+value,
        dataType: "json",
        async:false,
        success: function (msg) {
            num = msg.msg;

        }
    });
    if(!num){
        return false;
    }

    var j=0;
    $("#"+$(element).parent().parent().parent().parent().attr('id')).each(function(i,div){
        var car=$("input[name='carLicence']",div);
        var html="";
        console.log(car.length);
        for(var i=0 ;i< car.length  ; i++){
            if($(car[i]).val()==value){
                j=j+1;
            }
        }
    });
    if(j > 1){
        return false;
    }
    $(element).next("input").val(num);
    return true;

},"该车牌号不存在或者出现重复")

// 对司机进行验证
jQuery.validator.addMethod("isDriverName", function(value, element) {
    var num;
    $.ajax({
        url: window.ctx + "/stock/getDriverName?diverName="+value,
        dataType: "json",
        async:false,
        success: function (msg) {
            num = msg.msg;
        }
    });
    console.log(num)
    if(!num){
        return false;
    }

    var j=0;
    console.log($(element).parent().parent().parent().parent().parent().parent().attr('id'))
    $("#"+$(element).parent().parent().parent().parent().parent().parent().attr('id')).each(function(i,div){
        var driver=$("input[name='driverName']",div);
        var html="";
        console.log(driver.length);
        console.log(value);
        for(var i=0 ;i< driver.length  ; i++){
            console.log($(driver[i]).val());
            if($(driver[i]).val()==value){
                j=j+1;
            }
        }
    });
    if(j > 1){
        return false;
    }
    $(element).next("input").val(num);
    return true;


},"该司机不存在或者出现重复")


jQuery.validator.addMethod("param0AboveParam1", function(value, element,params) {
    var moq = params[0];
    var moq = $("#"+moq).val();
    if(parseInt(value)>=parseInt(moq)){
        return true;
    }else{
        return false;
    }
}, "不能小于最小起订量");

