$(document).ready(function(){
    $("#kanbuq").on("click", renewCaptcha);

    $("#btLogin").on("click",function(){
        if (submitForm()){
            $("#loginform").submit();
        }
    });

    $("#captcha").on("keydown",function(e){
        if(e.keyCode==13){
            if (submitForm()){
                $("#loginform").submit();
            }
        }
    });

    //读取用户名cookie
    var cookie=document.cookie;
    if(cookie != null && cookie != undefined && cookie != "undefined"){
        username = cookie;
    }
    if(username!=null&&username.length>0){
        var cookievalue=username.split("username=")[1];
        if (cookievalue!=null) {
            if (cookievalue.indexOf(";") != -1) {
                cookievalue = cookievalue.split(";")[0];
            }
            $("#username").val(decodeURI(cookievalue));
        }
    }
});

//刷新验证码
function renewCaptcha(){
    var captchaImg = $("#captchaImg");
    captchaImg.removeAttr("src");
    var now = new Date();
    var url=  window.ctx + "/validateCode?" + now.getTime();
    captchaImg.attr("src",url);
    setCaptchaLocal();
}

//显示错误信息
function tooltip_global_warning (domObj, message) {
    var target = domObj.parent();
    if (!target.hasClass("pr")) {
        domObj.wrap("<div class='pr'></div>");
    }
    target = domObj.parent();
    target.find(".ico-ok").remove();
    target.find("strong").remove();
//    target.append("<i class='icon i14 pa ico-warning'></i>");
    target.append("<strong class='wntext br3 pa'><i class='num-san pa'></i>" + message + "</strong>");
}

//显示Ok信息
function tooltip_global_ok (domObj) {
    var target = domObj.parent();
    if (!target.hasClass('pr')) {
        domObj.wrap("<div class='pr'></div>");
    }
    target = domObj.parent();
    target.find(".ico-warning").remove();
    target.find("strong").remove();
//    target.append("<i class='icon i14 pa ico-ok'></i>");
}

//form提交验证
function submitForm() {
    var userName = $("#username");
    var userNameVal = userName.val();
    if (userNameVal == "") {
        tooltip_global_warning(userName, "用户名不能为空!");
        return false;
    } else {
        tooltip_global_ok(userName);
    }

    var pwd = $("#password");
    var passVal = pwd.val();
    if (passVal == "") {
        tooltip_global_warning(pwd, "密码不能为空!");
        return false;
    } else {
        tooltip_global_ok(pwd);
    }
    var captcha = $("#captcha");
    var captchaMsg = $("#validateMsg");
    var captchaHide = $("#captcha_hide");
    var captchaVal = captcha.val().toLocaleUpperCase();
    var captchaHideVal = captchaHide.val().toLocaleUpperCase();
    if (captchaVal == "" || captchaVal == "验证码:") {
        tooltip_global_warning(captchaMsg, "验证码不能为空!");
        return false;
    }
    //if (captchaHideVal != captchaVal) {
    //   tooltip_global_warning(captchaMsg, "验证码错误!");
    //    return false;
    //}
    return true;
}
