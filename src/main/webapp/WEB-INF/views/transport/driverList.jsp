<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/common/global/common.jsp" %>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<html>
<style>
    .manag-driver .datagrid-body table tr > td {
        width: 100px !important;
    }
</style>

<head>
    <meta charset="utf-8">

    <title>园区中心-司机管理</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">园区中心</a>
    </li>
    <li>
        <a href="${ctx}/transport/listDriver">司机管理</a>
    </li>
</nav>
<div class="formtable">
    <div class="formtable-query">
        <div class="formtable-query mar_t20">
            <form class="form-inline" id="myform">
                <div class="form-group">
                    <label>司机姓名：</label>
                    <input type="text" class="form-control" placeholder="请输入司机姓名" id="driverName">
                </div>
                <div class="form-group">
                    <label>司机国籍：</label>
                    <select class="form-control" id='countryId'>
                        <option value="">全部</option>
                        <c:forEach var="country" items="${view.countryList}">
                            <option value="${country.constValue}">${country.constName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>司机手机：</label>
                    <input type="text" class="form-control" id="driverMobile">
                </div>
		  <span class="form-group">
            <a href="#" class="btn btn-primary btn-sm wid-60" id="search" >搜索</a>
            <a href="#" class="btn btn-primary btn-sm wid-60" onclick="reset()">重置</a>
		    <a href="#" class="btn btn-primary btn-sm wid-60" id="add">新增</a>
		  </span>
            </form>
        </div>
    </div>

    <div id="queryContent" class="mar_t20">
        <table id="easyUi_table">

        </table>
    </div>

    <div class="easyui-panel" id="queryPage">
        <div id="page"></div>
    </div>

</div>

<script type="text/javascript" src="${ctx}/resources/js/transport/driverList.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>
