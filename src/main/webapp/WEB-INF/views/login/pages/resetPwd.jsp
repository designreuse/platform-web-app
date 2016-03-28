<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 15-7-8
  Time: 下午3:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/global/common.jsp" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title></title>
</head>
<body>
    <div class="resetPwd">
        <form id="form"  action="/platform/sendPassword" method="post">
            <input type="text"  name="username" id="username"><input type="button" class="butCountMinute" id="send" value="验证短信">
            <span id="countMinute" class="btn-normal valibtn validis hide">还剩<strong class="num-count">30</strong>秒</span><br/>
            <input type="text"  name="token" id="token"><br/>
            <input type="text" name="password" id="password"><br/>
            <input type="text" name="pwdTemp" id="pwdTemp"><br/>
            <input type="button" id="submit"><input type="button" id="reset">
    </form>
    </div>
    <script src="${ctx}/resources/lib/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="${ctx}/resources/lib/jquery.validate.min.js" type="text/javascript"></script>
</body>
<script type="text/javascript">
    $().ready(function(){
        $("#countMinute").hide();
        var form ={
            rules:{
                username:{
                    required:true,
                    remote:{
                        type:"POST",
                        url:"/platform/reset/checkUserName",
                        data:{
                            username:function(){
                                return $("#username").val();
                            }
                        }
                    }
                },
                token:{
                    required:true,
                    remote:{
                        type:"POST",
                        url:"/platform/reset/validCode",
                        data:{
                            usermobileOrName: function(){
                                return $("#username").val()
                            },
                            token: function(){
                                return $("#token").val()
                            }
                        }
                    }
                },
                password:{
                    required:true
                },
                pwdTemp:{
                    equalTo:"#password"
                }
            },
            messages:{
                username:{
                    required:"用户名不能为空",
                    remote:"您输入的用户名或者手机号不存在"
                },
                token:{
                    required:"验证码不能为空",
                    remote:"验证码输入有误"
                },
                password:{
                    required:"密码不能为空"
                },
                pwdTemp:{
                    equalTo:"两次密码需相同"
                }
            }
        }
    var step1Validator =  $("#form").validate(form);

    $(".submit").click(function(e){
        var username = $("#username").val();
        var password = $("#password").val();
        if(step1Validator.element("#token") && step1Validator.element("#password") && step1Validator.element("#pwdTemp")){
            $("#form").submit();
        }

    })
    $(".butCountMinute").click(function(e){
        e.preventDefault()
        if(step1Validator.element("#username")){
            $(this).hide()
            $("#countMinute").show();
            var username = $("#username").val();
            timecount(30);
            var _url = "/platform/reset/sendCode";
            var url = encodeURI(_url);
            $.ajax({
                type:"post",
                url:url,
                dataType:"json",
                data:{"username": username},
                success:function(){
                    $(e.target).text("验证码已发送");
                },
                error: function(){
                }
            });
        }
    });
    function timecount(t){
        window.setTimeout(function(){
            t--;
            if(t == 0){
                $(".butCountMinute").text("重新获取验证码").show();
                $("#countMinute").hide();
                $(".num-count").text("30");
            }else{
                $(".num-count").text(t);
                timecount(t);
            }

        },1000);
    };

    })
</script>
</html>
