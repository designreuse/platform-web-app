<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
  <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
  <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
  <!--[if IE 7]>
  <link href="${ctx}/resources/font/font-awesome-ie7.min.css" rel="stylesheet" type="text/css" />
  <![endif]-->
  <title>回盘信息</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 商机中心 <span class="c-gray en">&gt;</span> 询盘回盘管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a> <span class="c-gray en">&gt;</span><a href="#">回盘信息</a></nav>
<div class="pd-20">
  <table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top">
    <thead>
    <tr class="text-l">
      <th width="106"><span class="l f-16">回盘信息</span></th>
    </tr>
    </thead>
    <tbody>
    </tbody>
  </table>
    <table class="table table-sort">
      <thead>
      <tr class="text-l">
        <%--<th width="106"><span class="l">系统通知商铺：12家    主动回盘：4条</span></th>--%>
      </tr>
      </thead>
      <tbody>
      </tbody>
    </table>
    <table class="table table-border table-bordered table-hover table-bg table-sort">
      <thead>
      <tr class="text-c">
        <th width="412">商铺</th>
        <th width="555">回盘时间</th>
        <th width="211">类型</th>
        <th width="193">状态</th>
        <th width="233">操作 </th>
      </tr>
      </thead>
      <tbody>
      <c:forEach items="${feedbackList}" var="feedback">
        <tr class="text-l">
          <td>${feedback.shopsName}</td>
          <td><odpf:formatDate style='DATE' date='${feedback.createTime}'/></td>
          <td>${feedback.feedbackType == 1 ? '主动回盘' : '系统回盘'}</td>
            <c:choose>
              <c:when test="${feedback.feedbackStatus == 1}">
                  <td>等待回盘</td>
                  <td><span class="l"><a href="${ctx}/inquiry/feedback/${feedback.inquiryId}" class="btn btn-primary ">
                      <i class="icon-plus"> </i> 回盘</a></span></td>
              </c:when>
              <c:when test="${feedback.feedbackStatus == 2}">
                  <td>待买家待确认</td>
                  <td><span class="l"><a href="${ctx}/inquiry/detail?feedbackId=${feedback.inquiryFeedbackId}&inquiryType=2" class="btn btn-primary ">
                      <i class="icon-plus"> </i> 买家确认</a></span></td>
              </c:when>
              <c:when test="${feedback.feedbackStatus == 3}">
                  <td>待卖家待确认</td>
                  <td><span class="l"><a href="${ctx}/inquiry/detail?feedbackId=${feedback.inquiryFeedbackId}&inquiryType=2" class="btn btn-primary ">
                      <i class="icon-plus"> </i> 卖家确认</a></span></td>
              </c:when>
              <c:when test="${feedback.feedbackStatus == 4}">
                  <td>已完成</td>
                  <td><span class="l"><a href="${ctx}/inquiry/detail?feedbackId=${feedback.inquiryFeedbackId}&inquiryType=2" class="btn btn-primary ">
                      <i class="icon-plus"> </i> 查看</a></span></td>
              </c:when>
              <c:when test="${feedback.feedbackStatus == 5}">
                  <td>已取消</td>
                  <td><span class="l"><a href="${ctx}/inquiry/detail?feedbackId=${feedback.inquiryFeedbackId}&inquiryType=2" class="btn btn-primary ">
                      <i class="icon-plus"> </i> 查看</a></span></td>
              </c:when>
            </c:choose>

        </tr>
      </c:forEach>
      </tbody>
    </table>
</div>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/layer/layer.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script language="javascript" src="${ctx}/resources/js/position_top.js"></script>
</body>
</html>