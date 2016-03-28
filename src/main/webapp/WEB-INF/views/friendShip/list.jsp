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
    <title>友情链接</title>
</head>
<body>
<%--nav_breadCrumb--%>
<ul class="breadcrumb">您当前位置：<li><a href="">内容中心</a></li><li><a href="">友情链接</a></li></ul>
<%--table_block--%>
<div id="queryBlock" class="pd-20 formtable">
    <%--table_tool--%>
        <div id ="queryParam" class="text-l formtable-query">
            <div class="formtable-query mar_t20">
                <form class="form-inline" id="friendShipForm">
                    <div class="form-group">
                        <label>平台：</label>
                        <select class="form-control"  id="appId" name="appId">
                            <option value="">全部</option>
                            <c:forEach items="${appType}" var="appType">
                                <option value="${appType.constValue}">${appType.constName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>状态：</label>
                        <select class="form-control"  id="disabled" name="disabled">
                            <option value="">全部</option>
                            <c:forEach items="${disabled}" var="disabled">
                                <option value="${disabled.constValue}">${disabled.constName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <a href="#" class="btn btn-primary btn-sm wid-60" id="search">搜索</a>
                        <a href="#" class="btn btn-primary btn-sm wid-60" id="reset">重置</a>
                        <a href="${ctx}/friendShip/add" class="btn btn-primary btn-sm wid-60" id="add">新增</a>
                    </div>
                </form>
            </div>
        </div>
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
<script type="text/javascript" src="${ctx}/resources/js/friendShip/list.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>
