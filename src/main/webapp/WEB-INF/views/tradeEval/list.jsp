<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <%@include file="/WEB-INF/common/global/common.jsp" %>
    <%@include file="/WEB-INF/common/global/tableCommon.jsp" %>
    <title>贸易订单评价管理</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">交易中心</a>
    </li>
    <li>
        <a href="${ctx}/tradeEval/list">贸易订单评价管理</a>
    </li>
</nav>

<div class="formtable">
    <div class="formtable-query">
        <div class="formtable-query mar_t20">
           <form class="form-inline" id="userMgrform" >
               <div class="form-group">
                   <label >订单编号：</label>
                   <input class="form-control" id="orderCode" type="text">
               </div>
               <div class="form-group">
                   <label>买方：</label>
                   <input class="form-control" id="buyerOrgCN" type="text">
               </div>
               <div class="form-group">
                   <label>卖方：</label>
                   <input class="form-control" id="salerOrgCN" type="text">
               </div>
               <div class="form-group">
                   <label>商铺：</label>
                   <input id="shopsNameCn" class="form-control" type="text">
               </div>
               <div class="form-group">
                   <label>评价：</label>
                   <select class="form-control" id="level">
                       <option value="">全选</option>
                       <option value="1">好评</option>
                       <option value="2">中评</option>
                       <option value="3">差评</option>
                   </select>
               </div>

                <div class="form-group">
                    <a href="#" class="btn btn-primary btn-sm wid-60" id="search">搜索</a>
                    <button   class="btn btn-primary btn-sm wid-60" >重置</button>
                </div>

           </form>
        </div>
    </div>

    <div id="queryContent">
        <table id="easyUi_table">

        </table>
    </div>
    <div id="queryPage" class="easyui-panel">
        <div id="page"></div>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/tradeEval/list.js"></script>
</body>
</html>


