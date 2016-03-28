<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 15-7-27
  Time: 上午4:38
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8">
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/easyui.css"/>

    <script type="text/javascript">
        window.ctx="${ctx}"
    </script>
    <title>商铺商品报价管理</title>
</head>
<body>

<nav id="navBreadcrumb" class="Hui-breadcrumb">
    <i class="icon-home"></i> 首页
    <span class="c-gray en">&gt;</span> 服务订单
    <span class="c-gray en">&gt;</span> 商铺商品报价管理
    <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" >
        <i class="icon-refresh"></i></a>
</nav>

<div id="queryBlock" class="pd-20">

    <div id ="queryParam" class="text-l">

    </div>

    <div id="queryContent">
        <table id="product_table">

        </table>
    </div>

    <div id="queryPage" class="easyui-panel">
        <div id="page"></div>
    </div>
</div>

<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery.easyui.min.js"></script>

</body>
</html>