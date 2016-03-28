<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@include file="/WEB-INF/common/global/common.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <LINK rel="Bookmark" href="/favicon.ico" >
    <LINK rel="Shortcut Icon" href="/favicon.ico" />

    <link href="${ctx}/resources/css/M-an.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/resources/css/M-an.login.css" rel="stylesheet" type="text/css" />

    <title>神灯速贸运营平台-后台登录</title>
    <meta name="keywords" content="神灯速贸">
    <meta name="description" content="神灯速贸-后台系统。">
    <![endif]-->
    <script>
        window.ctx = '${ctx}';
        //js top.location判断自身是否是顶级窗口
        if (window.top !== window.self) { // are you trying to put self in an iframe?
           top.location = self.location;
        }
    </script>
</head>

<body >
<input type="hidden" id="TenantId" name="TenantId" value="" />
<h2 class="header">神灯速贸-运营平台</h2>
<div class="loginWraper">
    <div style="
    float: right;
    margin: 20px;
">

    </div>
    <div class="loginBox">
        <form id="loginform" action="${ctx }/login" method="post">
            <c:if test="${not empty errorMsg}">
               <span>${errorMsg}</span>
            </c:if>
            <div class="formRow user">
                <input id="username" name="username" type="text" placeholder="账户" class="input_text input-big">
            </div>
            <div class="formRow password">
                <input id="password" name="password" type="password" placeholder="密码" class="input_text input-big">
            </div>
            <div class="formRow yzm">
                <input type="hidden" name="captcha_hide" id="captcha_hide"/>
                <input name="captcha" id="captcha" class="input_text input-big" type="text" placeholder="验证码" onBlur="if(this.value==''){this.value='验证码:'}" onClick="if(this.value=='验证码:'){this.value='';}" value="验证码:" style="width:150px;">
                <img src="validateCode" id="captchaImg"> <a id="kanbuq" href="javascript:;">看不清，换一张</a> <br>
                <div id="validateMsg"></div>
            </div>

            <div class="formRow">
                <input name="" id="btLogin" type="button" class="btn radius btn-success btn-big" value="&nbsp;登&nbsp;&nbsp;&nbsp;&nbsp;录&nbsp;">
                <input name="" id="btReset" type="reset" class="btn radius btn-default btn-big" value="&nbsp;取&nbsp;&nbsp;&nbsp;&nbsp;消&nbsp;">
            </div>
        </form>
        <div style="float: right;margin-top: 60px;">
            <img src="${ctx}/resources/images/platform.png" alt=""/>
            <p style="text-align: center">安卓下载</p>
        </div>
        <%--<div style="float: right;margin-top: 60px;margin-right: 20px">--%>
            <%--<img src="${ctx}/resources/images/platform.png" alt=""/>--%>
            <%--<p style="text-align: center">ios下载</p>--%>
        <%--</div>--%>
    </div>
</div>

<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/login/login.js"></script>
</body>
</html>
