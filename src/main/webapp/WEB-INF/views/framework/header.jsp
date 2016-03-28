<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.net.URLDecoder"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="${ctx}/resources/css/base.css" rel="stylesheet" />
    <link href="${ctx}/resources/css/main.css" rel="stylesheet" />
</head>
<body>
    <!--头部版块 -->
<div class="header">
  <div class="innerwp clearfix">
    <div class="logo fl"><a href="${ctx}" title="综合运营管理中心"  target="_parent">综合运营管理中心</a></div>
    <div class="hdlinks fr">
      <ul>
        <li><a href="${ctx}/">当前用户：<span class="ftwhite">${user.nickname}</span></a></li>
        <li class="noline"><a href="${ctx}/logout" target="_parent">退出</a></li>
      </ul>
    </div>
  </div>
</div>
<!--面包屑版块 -->
</body>

</html>
