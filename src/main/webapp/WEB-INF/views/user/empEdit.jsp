<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="${ctx}/resources/js/html5.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/respond.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/PIE_IE678.js"></script>
    <![endif]-->
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <!--[if IE 7]>
    <link href="${ctx}/resources/font/font-awesome-ie7.min.css" rel="stylesheet" type="text/css" />
    <![endif]-->
    <title>编辑员工</title>
    <style type="text/css">
        /* Used for the Switch effect:*/
        .cb-enable, .cb-disable, .cb-enable span, .cb-disable span {
            background: url(${ctx}/resources/images/switch.gif) repeat-x;
            display: block;
            float: left;
        }
        .cb-enable span, .cb-disable span {
            line-height: 30px;
            display: block;
            background-repeat: no-repeat;
            font-weight: bold;
        }
        .cb-enable span {
            background-position: left -90px;
            padding: 0 10px;
        }
        .cb-disable span {
            background-position: right -180px;
            padding: 0 10px;
        }
        .cb-disable.selected {
            background-position: 0 -30px;
        }
        .cb-disable.selected span {
            background-position: right -210px;
            color: #fff;
        }
        .cb-enable.selected {
            background-position: 0 -60px;
        }
        .cb-enable.selected span {
            background-position: left -150px;
            color: #fff;
        }
        .switch label {
            cursor: pointer;
        }
    </style>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页
    <c:if test="${empty personal}">
        <span class="c-gray en">&gt;</span> 员工管理 <span class="c-gray en">&gt;</span> 员工编辑
    </c:if>
    <c:if test="${not empty personal}">
        <span class="c-gray en">&gt;</span> 个人信息
    </c:if>
    <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a></nav>
<form action="${ctx}/user/employee/edit"  method="post" onsubmit="return checkForm()">
<c:if test="${entity.userId != null}">
    <div id="message_position">
        <div id="position_fixed" class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l">
        <a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_a_click">  基本信息</a>
        <a href="javascript:;" name="pw" class="btn btn-primary radius public_a_click">修改密码</a></span>
        </div>
    </div>
</c:if>

    <input type="hidden" value="${entity.userId}"  name="userId" id="userId"/>
    <table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top">
        <thead>
        <tr class="text-l">
            <th width="106"><span class="l f-16">基本信息</span>
        <span class="r"><button class="btn btn-success radius" type="submit"><i class="icon-ok"></i> 保存</button>
      </span></th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
    <table class="table table-border table-bordered table-bg table-sort">
        <tbody>
        <tr>
            <th width="190" class="text-r"><span class="c-red">*</span> 姓名（中文）：</th>
            <td><input type="text" style="width:200px" class="input-text" value="${entity.userNameCn}" placeholder=""
                       id="username" name="userNameCn" datatype="*2-16" nullmsg="用户名不能为空"></td>
        </tr>
        <tr>
            <th width="190" class="text-r"><span class="c-red">*</span> First Name</th>
            <td><input type="text" style="width:200px" class="input-text" value="${entity.userNameFirst}" placeholder=""
                       id="firstName" name="userNameFirst" datatype="*2-16" nullmsg="用户名不能为空"></td>
        </tr>
        <tr>
            <th width="190" class="text-r"><span class="c-red">*</span> Last Name</th>
            <td><input type="text" style="width:200px" class="input-text" value="${entity.userNameLast}" placeholder=""
                       id="lastName" name="userNameLast" datatype="*2-16" nullmsg="用户名不能为空"></td>
        </tr>
        <tr>
            <th class="text-r">生日：</th>
            <td><input class="Wdate" type="text" id="d15" name="birthday" value="<odpf:formatDate style='DATE' date='${entity.birthday}'/>"
                       onFocus="WdatePicker({isShowClear:false,readOnly:true})"/></td>
        </tr>
        <tr>
            <th class="text-r"> 性别：</th>
            <td><label>
                <input name="sex" type="radio" id="six_1" value="1" <c:if test="${entity.sex == 1}">checked</c:if>>
                男</label>
                <label>
                    <input type="radio" name="sex" value="2" id="six_0" <c:if test="${entity.sex == 2}">checked</c:if>>
                    女</label>
                <label>
                    <input type="radio" name="sex" value="0" id="six_2" <c:if test="${entity.sex == 0}">checked</c:if>>
                    保密</label></td>
        </tr>
        <tr>
            <th class="text-r"><span class="c-red">*</span> 手机</th>
            <td><input type="text" style="width:300px" class="input-text" value="${entity.mobile}" placeholder=""
                       id="sms_send" name="mobile" onblur="checkUsername()">
                <input type="hidden" value="${entity.mobile}" id="oldMobile">
                <input type="hidden" value="" name="mobileStatus" id="mobileStatus">
                <a href="javascript:sendSms();" target="_self" class="btn btn-primary radius public_examine">发送验证短信</a>
          <span id="code_input" style="display: none;">
          <input type="text" style="width:100px" class="input-text" value="" placeholder="请输入验证码" id="sms_code" name="code">
          <a href="javascript:validCode();" target="_self" class="btn btn-primary radius public_examine">验证</a></span>
                <c:if test="${emp.mobileStatus == 1}"><span><img src="${ctx}/resources/images/icon_right_s.png" width="18" height="20">已验证</span></c:if>
                <c:if test="${emp.mobileStatus == 0}"><span><img src="${ctx}/resources/images/icon_right_s2.jpg" width="18" height="17">验证失败</span></c:if>
            </td>
        </tr>
        <tr>
            <th class="text-r">邮箱：</th>
            <td><input type="text" style="width:300px" class="input-text" value="${entity.email}" placeholder="" id="user-tel3" name="email">
                <a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_examine">发送验证邮件</a>
                <span>验证邮件已发送，请打开您的邮箱并点击验证链接。</span>
                <c:if test="${emp.emailStatus == 1}"><span><img src="${ctx}/resources/images/icon_right_s.png" width="18" height="20">已验证</span></c:if>
                <c:if test="${emp.emailStatus == 0}"><span><img src="${ctx}/resources/images/icon_right_s2.jpg" width="18" height="17">验证失败</span></c:if>
            </td>
        </tr>
        <c:if test="${entity.userId == null}">
            <tr>
                <th class="text-r"><span class="c-red">*</span> 登录密码：</th>
                <td><input type="password" style="width:300px" class="input-text" value="" placeholder="请输入6~20位数字、字母或字符" id="password" name="password">
                        <%--<span><img src="${ctx}/resources/images/icon_right_s.png" width="18" height="20"></span> --%>
                        <%--<span><img src="${ctx}/resources/images/icon_right_s2.jpg" width="18" height="17"></span>--%>
                </td>
            </tr>
        </c:if>
        <tr>
            <th class="text-r">居住地址：</th>
            <td>
            <select class="select" name="countryId" size="1" style="width:300px" id="countrySelect">
                <option value="1" <c:if test="${entity.countryId==1}">selected</c:if>>中国</option>
                <option value="2" <c:if test="${entity.countryId==2}">selected</c:if>>俄罗斯</option>
            </select>
            <select class="select" name="provId" size="1" style="width:300px" id="provSelect">
                <option value="">--请选择省--</option>
                <c:forEach items="${provList}" var="prov">
                    <option value="${prov.id}" <c:if test="${entity.provId==prov.id}">selected</c:if> >
                            ${prov.cnname}(${prov.enname})</option>
                </c:forEach>
            </select>
            <select class="select" name="cityId" size="1" style="width:300px" id="citySelect">
                <option value="">--请选择市--</option>
                <c:forEach items="${cityList}" var="city">
                    <option value="${city.id}" <c:if test="${entity.cityId==city.id}">selected</c:if> >
                            ${city.cnname}( ${city.enname})</option>
                </c:forEach>
            </select>
            <select class="select" name="distId" size="1" style="width:300px" id="distSelect">
                <option value="">--请选择区--</option>
                <c:forEach items="${distList}" var="dist">
                    <option value="${dist.id}" <c:if test="${entity.distId==dist.id}">selected</c:if> >
                            ${dist.cnname}(${dist.enname})</option>
                </c:forEach>
            </select>
                <br>
                <input type="text" style="width:300px" class="input-text" value="${entity.address}" placeholder="" id="user-address2" name="address"></td>
        </tr>
        <tr>
            <th class="text-r">身份证号：</th>
            <td>
                <input type="text" style="width:300px" class="input-text" value="${entity.idcard}" placeholder="" id="idCard" name="idcard">
                <input type="hidden" id="oldIdCard" value="${entity.idcard}">
            </td>
        </tr>
        <tr>
            <th valign="top" class="text-r">服务执行部门：</th>
            <td valign="top">
                <select class="select" name="deptId" size="1" style="width:120px">
                <option value="">无</option>
                <c:forEach items="${departmentList}" var="dept">
                    <option value="${dept.id}" <c:if test="${entity.deptId == dept.id}">selected</c:if>>${dept.deptName}</option>
                </c:forEach>
                </select>
            </td>
        </tr>
        </tbody>
    </table>
</form>
<c:if test="${entity.userId != null}">
    <table class="table table-border table-bordered table-bg table-sort mt-10">
        <thead>
        <tr class="text-l">
            <th width="106" class="public_click_content"><span class="l f-16">修改密码</span> <span class="r">
        <button class="btn btn-success radius" type="button" onclick="resetPassword()"><i class="icon-ok"></i> 保存</button>
      </span></th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <table class="table table-border table-bordered table-hover table-bg">
        <tbody>
        <tr>
            <th class="text-r">旧密码：</th>
            <td><input type="password" id="old-password" style="width:250px" class="input-text">
        </tr>
        <tr>
            <th class="text-r">新密码：</th>
            <td><input type="password" id="new-password" style="width:250px" class="input-text">
        </tr>
        <tr>
            <th class="text-r">再次输入新密码：</th>
            <td><input type="password" id="new-password1" style="width:250px" class="input-text">
        </tr>
        </tbody>
    </table>
</c:if>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/layer/layer.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/pagenav.cn.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script language="javascript" src="${ctx}/resources/js/position_top.js"></script>
<script type="text/javascript">
    //发送短信验证码
    function sendSms(){
        var phoneNumber = $("#sms_send").val();
        if(!phoneNumber){
            alert("手机号码不能为空！");
            return false;
        }
        $.get("${ctx}/user/checkUsername/"+phoneNumber,function(data){
            if("true" == data){
                $.post("${ctx}/user/sendCode",{mobile:phoneNumber},function(data){
                    if("true" === data){
                        $("#code_input").show();
                    }
                });
            }
        });

    }
    //验证短信验证码
    function validCode(){
        var validCode = $("#sms_code").val();
        if(!validCode){
            alert("验证码不能为空！");
            return false;
        }
        $.post("${ctx}/user/reset/validCode",
                {mobile:phoneNumber,validCode:validCode},
                function(data){
                    if("true" === data){
                        $("#code_input").hide();
                        $("#mobileStatus").val(1);
                        alert("验证成功！");
                    }else
                        alert("验证失败！");
        });
    }

    //异步加载地址
    function loadAddress(url,target){
        $.get("${ctx}/"+url,function(data){
            target.children().first().siblings().remove();
            data.forEach(function(d,i) {
                target.append($("<option></option>").val(d.id).text(d.cnname+"("+ d.enname+")"));
            });
            if(data.length>0){
                target.show();
            }
        },"json");
    }

    //重设密码
    function resetPassword(){
        var password = $("#new-password").val();
        var password1 = $("#new-password1").val();
        var oldPassword = $("#old-password").val();
        if(!oldPassword){
            alert("旧密码不能为空！")
            return false;
        }
        if(!password){
            alert("新密码不能为空！")
            return false;
        }
        if(password && password1 && password === password1){
            $.ajax({
                url:"${ctx}/user/resetPassword/${entity.userId}",
                data:{
                    password:password,
                    password1:password1,
                    oldPassword:oldPassword
                },
                type:"post",
                dataType:"json",
                success:function(data){
                    alert(data.msg);
                    if(data.result){
                        location.reload();
                    }else{
                        $("#new-password").val("");
                        $("#new-password1").val("");
                        $("#old-password").val("");
                    }
                }
            })
        }else{
            alert("两次密码输入不一致！");
            return false;
        }

    }
    //可用禁用开关按钮
    $(function(){
        var provSelect = $("#provSelect");
        var countrySelect = $("#countrySelect");
        var citySelect = $("#citySelect");
        var distSelect = $("#distSelect");
        if("" === "${entity.provId}"){
            citySelect.hide();
            distSelect.hide();
            loadAddress("address/province/1",provSelect);
        }
        if("" === distSelect.val()){
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
                loadAddress("address/city/"+provId,citySelect);
            }
        });
        citySelect.on("change",function(){
            var cityId = citySelect.val();
            if(cityId){
                loadAddress("address/district/"+cityId,distSelect);
            }
        });

        if('${msg}' != ''){
            alert('${msg}');
        }
        $(".cb-enable").click(function(){
            var parent = $(this).parents('.switch');
            $('.cb-disable',parent).removeClass('selected');
            $(this).addClass('selected');
        });
        $(".cb-disable").click(function(){
            var parent = $(this).parents('.switch');
            $('.cb-enable',parent).removeClass('selected');
            $(this).addClass('selected');
        });

        //验证身份证号是否存在
        $("#idCard").blur(function(){
            var data = $(this).val()
            if($("#oldIdCard").val() ==  data){
                data = ""
            }
            $.get("${ctx}/user/checkIdCard/"+data,function(data){
                if("true" === data){
                    return ;
                }else {
                    alert("身份证号已经存在，请重新输入");
                    $("#idCard").val("");
                }
            });
        });

    });
    function checkForm(){
        if(!$("#username").val()){
            alert("用户名不能为空！");
            return false;
        }
        if(!$("#firstName").val()){
            alert("First Name不能为空！");
            return false;
        }
        if(!$("#lastName").val()){
            alert("Last Name不能为空！");
            return false;
        }
        if(!$("#userId").val()){
            if(!$("#password").val()){
                alert("登陆密码不能为空！");
                return false;
            }
        }
        var phoneNumber = $("#sms_send").val();
        if(!phoneNumber){
            alert("手机号码不能为空！");
            return false;
        }
        checkUsername();
    }
    function checkUsername(){
        var phoneNumber = $("#sms_send");
        var data = phoneNumber.val();
        if ($("#oldMobile").val() ==phoneNumber.val()){
            data=''
        };
        $.get("${ctx}/user/checkUsername/"+data,function(data){
            if("false" == data){
                alert("手机号码重复，请重新输入");
                phoneNumber.val("");
                phoneNumber.focus();
                return false;
            }
        });
    }
</script>
</body>
</html>
