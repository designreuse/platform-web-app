<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <link type="text/css" href="${ctx}/resources/css/index.css" rel="stylesheet" />
    <link type="text/css" href="${ctx}/resources/css/labelauty.css" rel="stylesheet" />
    <title>贸易订单管理</title>
</head>
<body>
<form action="${ctx}/order/list" method="post" class="searchform" id="searchform">
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 订单中心 <span
        class="c-gray en">&gt;</span> 贸易订单管理 <a class="btn btn-success radius r mr-20"
        style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新"><i
        class="icon-refresh"></i></a></nav>
<div class="pd-20">
    <div class="text-l">

            <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr>
                    <td width="9%" height="44">贸易订单编号：</td>
                    <td width="25%"><input type="text" class="input-text" style="width:222px" placeholder="输入服务订单编号"
                                           value="${entity.orderCode}" id="input" name="orderCode"></td>
                    <td width="5%">买方：</td>
                    <td width="19%"><input type="text" class="input-text" style="width:150px" placeholder="输入买方企业名称"
                                           value="${entity.buyOrgNameCn}" id="input2" name="buyOrgNameCn"></td>
                    <td width="4%">卖方：</td>
                    <td width="18%"><input type="text" class="input-text" style="width:150px" placeholder="输入卖方企业名称"
                                           value="${entity.saleOrgNameCn}" id="input3" name="saleOrgNameCn"></td>
                    <td width="4%">状态：</td>
                    <td width="15%"><select class="select" name="orderStatus" size="1" style="width:100px">
                        <option value="">全部</option>
                        <option value="1" <c:if test="${entity.orderStatus == 1}">selected</c:if>>执行中</option>
                        <option value="2" <c:if test="${entity.orderStatus == 2}">selected</c:if>>已执行</option>
                        <option value="3" <c:if test="${entity.orderStatus == 3}">selected</c:if>>已取消</option>
                    </select></td>
                </tr>
                <tr>
                    <td height="46">日期范围：</td>
                    <td>
                        <input type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})"
                             value="<odpf:formatDate style='DATE' date='${entity.createTimeBegin}'/>" name="createTimeBegin" id="datemin" class="input-text Wdate" style="width:100px;">
                        -
                        <input type="text" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d'})"
                               value="<odpf:formatDate style='DATE' date='${entity.createTimeEnd}'/>" name="createTimeEnd" id="datemax" class="input-text Wdate" style="width:100px;">

                    </td>
                    <td>交货地：</td>
                    <td>
                        <select class="select" name="deliveryAddrId" size="1" style="width:120px">
                            <option value="">全部</option>
                            <option value="1" <c:if test="${entity.deliveryAddrId == 1}">selected</c:if>>满洲里</option>
                            <option value="2" <c:if test="${entity.deliveryAddrId == 2}">selected</c:if>>赤塔</option>
                            <option value="3" <c:if test="${entity.deliveryAddrId == 3}">selected</c:if>>乌兰乌德</option>
                            <option value="4" <c:if test="${entity.deliveryAddrId == 4}">selected</c:if>>伊尔库兹克</option>
                            <option value="5" <c:if test="${entity.deliveryAddrId == 5}">selected</c:if>>新西伯利亚</option>
                        </select>
                    </td>

                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>
                        <button type="submit" class="btn btn-success" id="button" name="">
                            <i class="icon-search"></i> 搜索
                        </button>
                    </td>
                </tr>
            </table>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20"><span class="r">共有数据：<strong>${count}</strong> 条</span>
    </div>
    <table class="table table-border table-bordered table-hover table-bg table-sort">
        <thead>
        <tr class="text-c">
            <th width="144">订单编号</th>
            <th width="133">买方</th>
            <th width="134">卖方</th>
            <th width="126">商品</th>
            <th width="104">交货地</th>
            <th width="93">创建时间</th>
            <th width="62">状态</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${orderList}" var="order">
            <tr class="text-c">
                <td><a href="${ctx}/order/${order.orderId}/edit">${order.orderCode}</a></td>
                <td><a href="${ctx}/enterprise/${order.buyOrgId}/edit">${order.buyOrgNameRu}</a></td>
                <td><a href="${ctx}/enterprise/${order.saleOrgId}/edit">${order.saleOrgNameCn}</a></td>
                <td>
                    <c:forEach items="${fn:split(order.products,',')}" var="product">
                        ${product}&nbsp;&nbsp;千克<br/>
                    </c:forEach>
                </td>
                <td>${order.deliveryName}</td>
                <td><odpf:formatDate style='DATE_HOUR_SECOND' date='${order.createTime}'/>
                </td>
                <td class="user-status"><span class="label label-success">
                <c:choose>
                    <c:when test="${order.orderStatus == 1}">执行中</c:when>
                    <c:when test="${order.orderStatus == 2}">已执行</c:when>
                    <c:when test="${order.orderStatus == 3}">已取消</c:when>
                </c:choose>
            </span></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <script type="text/javascript" src="${ctx}/resources/js/page/page-common.js"></script>
    <tags:pageComponent pageNumber="${page.currentPage}" pageSize="${page.pageSize}" totalRows="${count}"/>

</div>
</form>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/layer/layer.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
</body>
</html>