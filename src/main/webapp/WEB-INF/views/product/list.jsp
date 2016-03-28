<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 15-7-27
  Time: 上午4:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
    window.ctx="${ctx}"
</script>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/easyui.css"/>
    <link type="text/css" href="${ctx}/resources/css/easyui-table.css" rel="stylesheet" />
    <title>商铺商品报价管理</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 服务订单 <span class="c-gray en">&gt;</span> 商铺商品报价管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a></nav>
<div class="pd-20">
    <div class="text-l" id ="queryParam">
        商品名称：<input type="text" class="easyui-validatebox" style="width:150px" placeholder="输入商品名称" id="productNameCn" name="productNameCn">
        HSCODE：<input type="text" class="easyui-validatebox" style="width:150px" placeholder="输入HSCODE" id="hscode" name="hscode">
        品类：<input id="catalogId" />
        状态：<select name="disabled" id="disabled" class="easyui-combobox">
                    <option value="">全部</option>
                    <option value="0">可用</option>
                    <option value="1">停用</option>
                </select>
        <a class="easyui-linkbutton r" id="search" ><i class="icon-search"></i> 搜索</a>
        <a class="easyui-linkbutton r" id="add" >新增标准商品</a>
    </div>
    <div id="queryContent">
        <table id="easyUi_table">

        </table>
    </div>
    <div id="queryPage" class="easyui-panel">
        <div id="page"></div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common/dateformat.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/easyui-table.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/product/list.js"></script>
</body>
</html>
