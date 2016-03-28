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
    <title>服务订单</title>
</head>
<body>
<%--nav_breadCrumb--%>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">交易中心</a>
    </li>
    <li>
        <a href="${ctx}/serviceOrder/list">服务订单管理</a>
    </li>
</nav>
<%--table_block--%>
<div id="queryBlock" class="pd-20 formtable">
    <%--table_tool--%>
    <div id ="queryParam" class="text-l  formtable-query">
        <form class="form-inline" id="srvOrderForm">
            <div class="form-group">
                <label>服务订单编号：</label>
                <input type="text" class="form-control" id="srvOrderCode" name="srvOrderCode">
            </div>
            <div class="form-group">
                <label>委托方：</label>
                <input type="text" class="form-control" id="orgName" name="orgName">
            </div>
            <div class="form-group">
                <label>联系人：</label>
                <input type="text" class="form-control" name="contactsName" id="contactsName">
            </div>
            <div class="form-group">
                <label>下单日期：</label>
                <div class="input-group datepicker date wid-120">
                    <input type="text" class="form-control" readonly style="margin: 0px;" id="beginCreateTime" name="beginCreateTime">
                    <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                </div>
                <em class="pad_10">-</em>
                <div class="input-group datepicker date wid-120">
                    <input type="text" class="form-control" readonly style="margin: 0px;" id="endCreateTime" name="endCreateTime">
                    <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                </div>
            </div>
            <div class="form-group">
                <label>委托服务：</label>
                <select class="form-control"  id="service" name="service">
                    <option value="">全部</option>
                    <c:forEach items="${view.serviceList}" var="service">
                        <option value="${service.serviceId}">${service.srvNameCn}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>状态：</label>
                <select class="form-control"  id="status" name="status">
                    <c:forEach var="type" items="${view.statusList}">
                        <option value="${type.constValue}"<c:if test="${type.constValue == view.status}">selected</c:if> >${type.constName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <a href="#" class="btn btn-primary btn-sm wid-60" id="search">搜索</a>
                <a href="#" class="btn btn-primary btn-sm wid-60" id="reset">重置</a>
                <a href="${ctx}/serviceOrder/add" class="btn btn-primary btn-sm wid-60" >新增</a>
            </div>
        </form>

    </div>
    <%--table_content--%>
    <div id="queryContent">
        <table id="easyUi_table">

        </table>
    </div>
    <%--table_footer--%>
    <div id="queryPage" class="easyui-panel">
        <div id="page"></div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/resources/js/serviceorder/new_list.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>
