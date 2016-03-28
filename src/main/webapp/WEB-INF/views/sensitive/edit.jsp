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

    <table class="table table-border table-bordered table-bg table-sort">
      <tbody>
      <tr>
        <th width="190" class="text-r"><span class="c-red">*</span> 敏感词名称：</th>
        <td><input type="text" style="width:400px" class="input-text"  placeholder="请输入敏感词名称" name="name"></td>
      </tr>
      </tbody>
    </table>
  </form>

    <span class="r" style="margin: 20px 0;"><button class="btn btn-success radius" type="button" id="submitForm"><i class="icon-ok"></i> 保存</button></span>
</div>

<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script type="text/javascript">
  window.ctx="${ctx}"
</script>
<script type="text/javascript" src="${ctx}/resources/js/sensitive/edit.js"></script>
</body>
</html>
