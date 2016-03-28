<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/10
  Time: 9:47
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
  <!--[if lt IE 9]>
  <script type="text/javascript" src="${ctx}/resources/js/html5.js"></script>
  <script type="text/javascript" src="${ctx}/resources/js/respond.min.js"></script>
  <script type="text/javascript" src="${ctx}/resources/js/PIE_IE678.js"></script>

  <![endif]-->
  <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
  <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/easyui.css"/>
  <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
  <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
  <!--[if IE 7]>
  <link href="${ctx}/resources/font/font-awesome-ie7.min.css" rel="stylesheet" type="text/css" />
  <![endif]-->
  <title>商品中心 - 标准商品编辑页</title>

</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 贸易订单管理 <span class="c-gray en">&gt;</span> 新建服务订单 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a></nav>
<div class="pd-20">
  <form id="productForm" method="post">
    <input type="hidden" name="productId" id="productId" value="${productBo.productId}">
    <input type="hidden" name="propertyIdList" id="property">
    <table class="table table-border table-bordered table-bg table-sort public_click_content" style="margin-top: 0px;">
      <thead>
      <tr class="text-l">
        <th width="106">
          <span class="l f-16">基本信息</span>
            <c:if test="${not empty productBo.productId}">
          <span class="r"><button class="btn btn-success radius" type="button" id="productSubmit"><i class="icon-ok"></i> 保存</button></span>
          </c:if>
        </th>
      </tr>
      </thead>
    </table>
    <table class="table table-border table-bordered table-bg table-sort">
      <tbody>
      <tr>
        <th width="190" class="text-r"><span class="c-red">*</span> 商品名称（中文）：</th>
        <td><input type="text" style="width:400px" class="easyui-validatebox" value="${productBo.productNameCn}" placeholder="请输入商品名称（中文）" name="productNameCn"></td>
      </tr>
      <tr>
        <th width="190" class="text-r"><span class="c-red">*</span> 商品名称（俄文）：</th>
        <td><input type="text" style="width:400px" class="easyui-validatebox" value="${productBo.productNameRu}" placeholder="请输入商品名称（俄文）" name="productNameRu"></td>
      </tr>
      <tr>
        <th width="190" class="text-r"><span class="c-red">*</span> 上级品类：</th>
        <td>
          <input type="hidden" name="catalogIdFirst" id="catalogIdFirst"  value="${productBo.catalogIdFirst}">
          <input type="hidden" name="catalogIdSecond" id="catalogIdSecond"  value="${productBo.catalogIdSecond}">
          <input type="hidden" name="catalogId" id="catalog"  value="${productBo.catalogId}">
          <input id="catalogId" value="${productBo.catalogNameCn}">
        </td>
      </tr>
      <tr>
        <th width="190" class="text-r"><span class="c-red">*</span> HSCODE：</th>
        <td><input type="text" style="width:400px" class="easyui-validatebox" value="${productBo.hscode}" placeholder="HSCODE" name="hscode"></td>
      </tr>
      <tr>
        <th width="190" class="text-r"><span class="c-red">*</span> 销售计量单位：</th>
        <td>
          <select class="easyui-combobox" name="unitId" size="1" style="width:200px" id="unitId">
              <c:forEach items="${unit}" var="unit">
                <option value="${unit.id}" <c:if test="${unit.id == productBo.unitId}">selected="selected"</c:if>>${unit.constName}</option>
              </c:forEach>
          </select>
        </td>
      </tr>
      <tr>
        <th width="190" class="text-r"><span class="c-red">*</span> 标准价格：</th>
        <td>￥<input type="text" style="width:400px" class="easyui-validatebox" value="${productBo.price}" placeholder="请输入标准价格"  name="price"></td>
      </tr>
      <tr>
        <th width="190" class="text-r"><span class="c-red">*</span> 可浮动价值：</th>
        <td>￥<input type="text" style="width:400px" class="easyui-validatebox" value="${productBo.floatPrice}" placeholder="可浮动价格"  name="floatPrice"></td>
      </tr>
      <tr>
        <th width="190" class="text-r"><span class="c-red">*</span> 商品图片：</th>
        <td><img src="${ctx}/resources/images/bn.jpg" width="300" height="100" id="productSrc" onclick="reOLUploadFro();">
          <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0" class="btn-uploadpic" name="file" multiple="" id="productLogoUrl">
          <input type="hidden" name="logoUrl">
          <input type="hidden" name="resourceCode" id="resourcesCode">
        </td>
      </tr>
      </tbody>
    </table>
  </form>
  <form method="post" id="productCatalogForm">
    <input type="hidden" name="propertyIdList" id="catalogProperty">
    <input type="hidden" name="productId" value="${productBo.productId}">
    <table class="table table-border table-bordered table-bg table-sort public_click_content" style="margin-top: 0px;">
      <thead>
      <tr class="text-l">
        <th width="106">
          <span class="l f-16">属性信息</span>
          <c:if test="${not empty productBo.productId}">
            <span class="r">
              <button class="btn btn-success radius" type="button" id="productCatalogSubmit"><i class="icon-ok"></i> 保存</button></span>
          </c:if>
         </th>
      </tr>
      </thead>
    </table>
    <table class="table table-border table-bordered table-bg table-sort">
      <tbody>
      <tr id="catalogPropertyList">
        <c:forEach items="${catalogPropertyList}" var="catalogProperty">
          <td>
            <label>
              <input class="product_checkbox" name="propertyIdList" type="checkbox" value="${catalogProperty.propertyId}"
              <c:forEach items="${propertyList}" var="property">
                <c:if test="${catalogProperty.propertyId == property.propertyId}"> checked="checked"</c:if>
              </c:forEach>>${catalogProperty.propertyNameCn}
            </label>
              ${catalogProperty.propertyValue}
          </td>
        </c:forEach>
      </tr>
      </tbody>
    </table>
  </form>
  <c:if test="${empty productBo.productId}">
    <span class="r" style="margin: 20px 0;"><button class="btn btn-success radius" type="button" id="submitForm"><i class="icon-ok"></i> 保存</button></span>
  </c:if>
</div>
<script type="text/javascript" src="${ctx}/resources/js/product/edit.js"></script>
</body>
</html>
