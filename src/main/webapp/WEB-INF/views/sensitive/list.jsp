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
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/easyui.css"/>
    <link type="text/css" href="${ctx}/resources/css/easyui-table.css" rel="stylesheet" />
    <script type="text/javascript">
        window.ctx="${ctx}"
    </script>
    <title>敏感词管理</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span>内容中心 <span class="c-gray en">&gt;</span> 敏感词管理 </nav>
<div class="pd-20">
    <div class="text-l" id ="queryParam">
        <!--敏感词ID：<input type="text" class="easyui-validatebox" style="width:150px" placeholder="输入敏感词编号" id="hscode" name="hscode">!-->
        敏感词名称：<input type="text" class="easyui-validatebox" style="width:150px" placeholder="输入敏感词名称" id="productNameCn" name="productNameCn">
        <a class="easyui-linkbutton r" id="search" ><i class="icon-search"></i> 搜索</a>
        <a class="easyui-linkbutton r" id="add" >新增敏感词</a>
    </div>
</div>

<div id="queryContent">
    <table id="easyUi_table">

    </table>
</div>

<div class="easyui-panel" id="queryPage">
    <div id="page"></div>
</div>
<div id="content" style="display: none">
    <label>敏感词:</label>
    <input id="sensitiveName" type="text"/>
</div>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common/dateformat.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/sensitive/list.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/easyui-table.js"></script>
</body>
</html>
