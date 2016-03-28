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
        <a href="${ctx}/inquiry/list">询盘回盘管理</a>
    </li>
</nav>
<%--nav_breadCrumb--%>
<%--table_block--%>
<div id="queryBlock" class="pd-20 formtable">
    <%--table_tool--%>
    <div id ="queryParam" class="text-l">
        <div class="formtable-query" >
            <form class="form-inline" id="inquiryForm">
                <div class="form-group">
                    <label>询盘编号：</label>
                    <input type="text" class="form-control" id="inquiryCode" name="inquiryCode">
                </div>
                <div class="form-group">
                    <label>买方：</label>
                    <input type="text" class="form-control" id="buyerOrgName" name="buyerOrgName">
                </div>
                <div class="form-group">
                    <label>卖方：</label>
                    <input type="text" class="form-control" id="sellerOrgName" name="sellerOrgName">
                </div>
                <div class="form-group">
                    <label>商铺：</label>
                    <input type="text" class="form-control" id="shopsName" name="shopsName">
                </div>
                <div class="form-group">
                    <label>创建日期：</label>
                    <div class="input-group datepicker date wid-120">
                        <input type="text" class="form-control" readonly style="margin: 0px;"id="createTimeBegin" name="createTimeBegin">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                    <em class="pad_10">-</em>
                    <div class="input-group datepicker date wid-120">
                        <input type="text" class="form-control" readonly style="margin: 0px;" id="createTimeEnd" name="createTimeEnd">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                </div>
                <div class="form-group">
                    <label>状态：</label>
                    <select class="form-control"  id="inquiryStatus" name="inquiryStatus">
                        <c:forEach var="type" items="${status}">
                            <option value="${type.constValue}">${type.constName}</option>
                        </c:forEach>
                    </select>
                </div>
                    <div class="form-group">
                        <label>询盘类型：</label>
                        <input type="radio" name="inquiryType" value="1" checked=""> 定向询盘
                        <input type="radio" name="inquiryType" value="2"> 不定向询盘
                    </div>
                <div class="form-group">
                    <a href="#" class="btn btn-primary btn-sm wid-60" id="search">搜索</a>
                    <a href="#" class="btn btn-primary btn-sm wid-60" id="reset">重置</a>
                    <a href="${ctx}/inquiry/add" class="btn btn-primary btn-sm wid-60">新增</a>
                </div>
            </form>
        </div>
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
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/inquiry/new_list.js"></script>
</body>
</html>
