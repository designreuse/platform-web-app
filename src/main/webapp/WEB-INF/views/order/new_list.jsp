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
    <title>贸易订单</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">交易中心</a>
    </li>
    <li>
        <a href="${ctx}/order/list">贸易订单管理</a>
    </li>
</nav>
<div id="queryBlock" class="pd-20 formtable">
    <%--table_tool--%>
    <div id ="queryParam" class="text-l formtable-query">
        <div class="formtable-query mar_t20">
            <form class="form-inline" id="orderForm">
                <div class="form-group">
                    <label>订单编号：</label>
                    <input type="text" class="form-control" id="orderCode" name="orderCode">
                </div>
                <div class="form-group">
                    <label>买方：</label>
                    <input type="text" class="form-control" id="buyOrgName" name="buyOrgName">
                </div>
                <div class="form-group">
                    <label>卖方：</label>
                    <input type="text" class="form-control" id="saleOrgName" name="saleOrgName">
                </div>
                <div class="form-group">
                    <label>商铺：</label>
                    <input type="text" class="form-control" id="shopsName" name="shopsName">
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
                    <label>交货地：</label>
                    <select class="form-control"  id="deliveryAddrId" name="deliveryAddrId">
                        <option value="">全部</option>
                        <c:forEach var="addr" items="${addr}">
                            <option value="${addr.constValue}">${addr.constName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>状态：</label>
                    <select class="form-control"  id="status" name="status">
                        <c:forEach var="type" items="${type}">
                            <option value="${type.constValue}">${type.constName}</option>
                        </c:forEach>
                    </select>
                </div>
		  <div class="form-group">
		    <a href="#" class="btn btn-primary btn-sm wid-60" id="search">搜索</a>
		    <a href="#" class="btn btn-primary btn-sm wid-60" id="reset">重置</a>
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
<script type="text/javascript" src="${ctx}/resources/js/order/new_list.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>
