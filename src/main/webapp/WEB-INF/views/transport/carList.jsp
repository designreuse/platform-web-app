<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<html>
<head>
    <meta charset="utf-8">

    <title>园区中心-车辆管理</title>

    <link rel="stylesheet" href="${ctx}/resources/plugin/bootstrap-switch-master/css/bootstrap-switch.min.css">

</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">园区中心</a>
    </li>
    <li>
        <a href="${ctx}/transport/listCar">车辆管理</a>
    </li>
</nav>
<div class="formtable">
        <div class="formtable-query" >
            <div class="formtable-query mar_t20">
                <form class="form-inline" id="myform">
                    <div class="form-group">
                        <label>车牌号：</label>
                        <input type="text" class="form-control" placeholder="请输入车牌号码" id="carLience">
                    </div>
                    <div class="form-group">
                        <label>车牌国籍：</label>
                        <select class="form-control"  id ='carCountry'>
                            <option value="">全部</option>
                            <c:forEach var="country" items="${view.aldConstantsBoList}" >
                                <option value="${country.constValue}">${country.constName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>车辆状态：</label>
                        <select class="form-control" name="disabled" id="disabled">
                            < <option value="">全部</option>
                            <option value="false">可用</option>
                            <option value="true">停用</option>
                        </select>
                    </div>
		  <span class="form-group">
            <a href="#" class="btn btn-primary btn-sm wid-60" id="search">搜索</a>
            <a href="#" class="btn btn-primary btn-sm wid-60" onclick="reset()">重置</a>
		    <a href="#" class="btn btn-primary btn-sm wid-60" id="add">新增</a>
		  </span>
                </form>
            </div>
        </div>
        <div  id="queryContent" class="mar_t20">
            <table id="easyUi_table">

            </table>
        </div>

        <div class="easyui-panel" id="queryPage">
            <div id="page"></div>
        </div>


</div>

<script src="${ctx}/resources/plugin/bootstrap-switch-master/js/bootstrap-switch.min.js"></script>


<script type="text/javascript" src="${ctx}/resources/js/transport/carList.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>
