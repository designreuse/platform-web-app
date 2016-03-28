<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta name="renderer" content="webkit|ie-comp|ie-stand">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
  <meta http-equiv="Cache-Control" content="no-siteapp" />
  <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
  <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
  <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
  <link type="text/css" href="${ctx}/resources/css/index.css" rel="stylesheet" />
  <link type="text/css" href="${ctx}/resources/css/labelauty.css" rel="stylesheet" />
  <title>平台公告</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 平台公告</nav>
<form action="${ctx}/news/actionList"  method="post" class="searchform" id="searchform">
<div class="pd-20">

  <c:forEach items="${entithyList}" var="entity">
    <table class="table table-bg">
      <thead>
      <tr>
        <th class="f-16">${entity.title}</th>
      </tr>
      <tr>
        <td>${entity.content}</td>
      </tr>
      <tr class="text-r">
        <td><odpf:formatDate style="DATE" date="${entity.createTime}" /></td>
      </tr>
      </thead>
      <tbody>
      </tbody>
    </table>
  </c:forEach>

  <script type="text/javascript" src="${ctx}/resources/js/page/page-common.js"></script>
  <tags:pageComponent pageNumber="${page.currentPage}" pageSize="${page.pageSize}" totalRows="${count}"/>

</div>


</form>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/layer/layer.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common/page.js"></script>

<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>
