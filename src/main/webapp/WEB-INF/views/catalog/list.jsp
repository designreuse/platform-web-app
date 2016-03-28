<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/21
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<html>
<head>
    <title>商品分类</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 服务订单 <span class="c-gray en">&gt;</span> 商铺商品报价管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a></nav>
<div class="pd-20">
  <div class="text-l" id ="tb">
    品类名称：<input type="text" class="easyui-validatebox" style="width:150px" placeholder="输入商品名称" id="productNameCn" name="productNameCn">
    HSCODE：<input type="text" class="easyui-validatebox" style="width:150px" placeholder="输入HSCODE" id="hscode" name="hscode">
    上级品类：<input type="text" class="easyui-validatebox" style="width:150px" placeholder="上级品类" id="parentName" name="parentName">
    状态：<select name="disabled" id="disabled" class="easyui-combobox">
    <option value="">全部</option>
    <option value="0">可用</option>
    <option value="1">停用</option>
  </select>
    <a class="easyui-linkbutton r" id="search" ><i class="icon-search"></i> 搜索</a>
    <a class="easyui-linkbutton r" id="add" >新增标准商品</a>
  </div>
  <table id="catalog_table">

  </table>
</div>
<div class="easyui-panel" id="a">
  <div id="page"></div>
</div>
<script type="text/javascript" src="${ctx}/resources/js/catalog/list.js"></script>
</body>
</html>
