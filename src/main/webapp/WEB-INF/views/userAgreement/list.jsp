<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/21
  Time: 17:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <title>用户协议</title>
</head>
<body>
<%--nav_breadCrumb--%>
<ul class="breadcrumb">您当前位置：<li><a href="">内容中心</a></li><li><a href="">用户协议</a></li></ul>
<%--table_block--%>
<div id="queryBlock" class="pd-20 formtable">
    <%--table_tool--%>

    <%--table_content--%>
    <div id="queryContent">
        <table id="easyUi_table" class="table table-bordered table-hover">

        </table>
    </div>
    <%--table_footer--%>
    <div id="queryPage" class="easyui-panel">
        <div id="page"></div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/resources/js/userAgreement/list.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>
