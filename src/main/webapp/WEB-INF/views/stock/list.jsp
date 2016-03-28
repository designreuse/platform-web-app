<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<html>
<head>
    <meta charset="utf-8">

    <title>园区中心-出入库管理</title>

</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">园区中心</a>
    </li>
    <li>
        <a href="${ctx}/stock/list">出入库明细</a>
    </li>
</nav>
<%--<input id="cc" class="easyui-combobox" name="dept" data-options="valueField:'id',textField:'driverName',url:'${ctx}/transport/getDriverName'" value="s" />--%>


<div class="formtable">
        <div class="formtable-query mar_t20">
            <form class="form-inline" id="myform">
                <div class="form-group">
                    <select class="form-control" id="type">
                        <option value="1">委托方</option>
                        <option value="2" >商品名称</option>
                        <c:if test="${empty view.warehouseId}">
                            <option value="3">仓库名称</option>
                        </c:if>
                    </select>
                    <input type="text" class="form-control" placeholder="关键词" id="keyWord">
                </div>
                <div class="form-group">
                    <label>商品一级品类：</label>
                    <select class="form-control" id="catalogIdFirst">
                        <option value="">全部</option>
                        <c:forEach var="levels" items="${view.level}" >
                            <option value="${levels.catalogId}">${levels.catalogNameCn}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>出入库类型：</label>
                    <select class="form-control" id="ioType">
                        <option value="">全部</option>
                        <option value="2">入库</option>
                        <option value="1">出库</option>
                    </select>
                </div>
		  <span class="form-group">
            <a href="#" class="btn btn-primary btn-sm wid-60" id="search">搜索</a>
            <a href="#" class="btn btn-primary btn-sm wid-60" onclick="reset()">重置</a>
			<a href="#" class="btn btn-primary btn-sm wid-60" data-toggle="modal" data-target="#addDoc">补录单据</a>
		  </span>
            </form>
        </div>

        <div  id="queryContent" class="mar_t20">
            <table id="easyUi_table">

            </table>
        </div>

        <div class="easyui-panel" id="queryPage">
            <div id="page"></div>
        </div>

        <input style="display: none" id="warehouseId" value="${view.warehouseId}"/>

       <div class="modal fade" id="addDoc">
           <div class="modal-dialog">
               <div class="modal-content">
                   <div class="modal-header">
                       <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                       <h4 class="modal-title">请选择出入库类型</h4>
                   </div>
                   <div class="modal-body text-center">
                       <button type="button" class="btn btn-primary" id="in">入库</button>
                       <button type="button" class="btn btn-default" id="out">出库</button>
                   </div>
               </div>
           </div>
       </div>
</div>

<script type="text/javascript" src="${ctx}/resources/js/stock/list.js"></script>

</body>
</html>
