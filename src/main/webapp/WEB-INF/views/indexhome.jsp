<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.net.URLDecoder"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="framework/header_common.jsp" %>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page import="com.wl.framework.session.constant.SessionConstant" %>
<%@ page import="com.wl.framework.session.domain.LoginUser" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<html style="overflow-y:hidden;">
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <LINK rel="Bookmark" href="${ctx}/resources/favicon.ico" >
    <LINK rel="Shortcut Icon" href="${ctx}/resources/favicon.ico" />
    <link href="${ctx}/resources/css/M-an.css" rel="stylesheet" type="text/css" />
    <link href="${ctx}/resources/css/M-an.admin.css" rel="stylesheet" type="text/css" />
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/>
    <meta name="renderer" content="webkit"/>
    <title>神灯速贸-运营平台</title>
</head>

<body>
<header class="Hui-header cl"> <a class="Hui-logo l" title="H-ui.admin v2.1" href="${ctx}/">神灯速贸-运营平台</a> <span class="Hui-userbox"><span class="c-white">${user.loginAccount}</span> <a class="btn btn-danger radius ml-10" href="${ctx}/logout" title="退出"><i class="icon-off"></i> 退出</a></span> <a aria-hidden="false" class="Hui-nav-toggle" id="nav-toggle" href="#"></a> </header>
<div class="cl Hui-main">
    <aside class="Hui-aside" style="">
        <odpf:generateMenu id="5" includeRoot="true" theme="platform"></odpf:generateMenu>
    </aside>
    <%--<div class="dislpayArrow"><a class="pngfix" href="javascript:void(0);"></a></div>--%>
    <section class="Hui-article">
        <div style="position: absolute;z-index: 99999;right: 30px;top: 8px" class="btn btn-primary">
            <a onclick="document.getElementsByName('frame1')[document.getElementsByName('frame1').length-1].contentWindow.location.reload(true);" style="color: #ffffff">刷新</a>
        </div>
        <div id="iframe_box" class="Hui-articlebox">
            <div class="show_iframe">
                <div style="display:none" class="loading"></div>
                <iframe scrolling="yes" frameborder="0" src="${ctx}/home" name="frame1" id="frame1"></iframe>
            </div>
        </div>
    </section>
</div>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/layer/layer.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>

</body>
<!--相当于js和css重写-->
<%--<frameset rows="53px,*" border="0" frameborder="0" framespacing="0" marginwidth="0" marginheight="0">--%>

    <%--<frame name="header" src="${ctx}/header"scrolling=no  >--%>

    <%--<frameset cols="192px,2px,*" border="0" frameborder="0" framespacing="0" class="left-right">--%>

        <%--<frame  noresize="noresize" name="menu" src="${ctx}/menu" scrolling="auto" class="left-frame" >--%>
        <%--<frame  noresize="noresize" name="line" src="${ctx}/line" scrolling="auto" class="left-frame" >--%>

        <%--<frame  noresize="noresize" name="main" src="${ctx}/home" scrolling="auto">--%>

    <%--</frameset>--%>
    <%--<noframes>--%>

        <%--<body>暂无内容！</body>--%>

    <%--</noframes>--%>
<%--</frameset>--%>
<script type="text/javascript">

    $(".hc").click(function()
    {
        if ($(this).siblings("ul").children().is(":hidden")) {

            $(this).siblings("ul").removeClass("hide");

            $(this).children("i").addClass("arrowbtm");
        }
        else {

            $(this).siblings("ul").addClass("hide");
            $(this).children("i").removeClass("arrowbtm");

        }
    });
    /******************************/

</script>
<%--<script>--%>

    <%--<%--%>
        <%--if (SecurityUtils.getSubject().getSession().getAttribute(SessionConstant.SESSION_LOGIN_USER_KEY) == null){--%>
    <%--%>--%>
    <%--window.userId = "";--%>
    <%--<%--%>
        <%--}else{--%>
    <%--%>--%>
    <%--window.userId = <%=((LoginUser)SecurityUtils.getSubject().getSession().getAttribute(SessionConstant.SESSION_LOGIN_USER_KEY)).getUserId()%>;--%>
    <%--<%--%>
        <%--}--%>
    <%--%>--%>
    <%--<%--%>
           <%--String accessToken = "";--%>
           <%--if(null != SecurityUtils.getSubject().getSession().getAttribute("accessToken")){--%>
                <%--accessToken = SecurityUtils.getSubject().getSession().getAttribute("accessToken").toString();--%>
           <%--}--%>
    <%--%>;--%>
    <%--window.accessToken = '<%=accessToken%>';--%>
<%--</script>--%>
<%--<!-- E:footer -->--%>
<%--<!--面包屑版块 -->--%>
<%--<script src="http://imsdk.rltx.com/templet2/javascripts/chat-pendant.js"></script>--%>
<%--<script type="text/javascript">--%>
    <%--if(""!=window.accessToken){--%>
        <%--var chatLogic = new ChatLogic({--%>
            <%--accessToken:window.accessToken,--%>
            <%--env :"development",--%>
            <%--userId:window.userId,--%>
            <%--defaultAvatar:"images/pic.jpg"--%>
            <%--//defaultGroupAvatar--%>
        <%--});--%>
        <%--var _rllate = new TranslateElePlugin("rlTransPlugin", "auto", "zh");--%>
        <%--chatLogic.addPlugs(_rllate);--%>
        <%--chatLogic.init();--%>
    <%--}--%>

<%--</script>--%>
</html>