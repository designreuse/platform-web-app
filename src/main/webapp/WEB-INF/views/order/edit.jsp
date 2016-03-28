<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <link type="text/css" href="${ctx}/resources/css/index.css" rel="stylesheet" />
    <link type="text/css" href="${ctx}/resources/css/labelauty.css" rel="stylesheet" />
    <title>贸易订单编辑</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 订单中心<span class="c-gray en">&gt;</span>贸易订单管理 <span class="c-gray en">&gt;</span> 贸易订单编辑 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a></nav>
<div class="pd-20">
<div id="message_position">
    <div id="position_fixed" class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l">
<a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_a_click">
     基本信息</a>
<a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
     贸易信息</a>
<c:if test="${tradeOrderList.size()>0}">
<a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
    服务信息</a>
</c:if>
</span><span class="r">
<c:if test="${orderBo.status == 1}">
    <a href="#" name="_self" class="btn btn-primary radius" id="order_cancel"> 取消</a>
</c:if>
 </span> </div>
</div>
<table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top">
    <thead>
    <tr class="text-l">
        <th width="106"><span class="l f-16">基本信息</span></th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<table class="table table-border table-bordered table-hover table-bg">
    <tbody>
    <tr>
        <th width="14%" class="text-r">贸易订单编号：</th>
        <td width="86%" colspan="3">${orderBo.orderCode}</td>
    </tr>
    <tr>
        <th class="text-r">订单状态：</th>
        <td colspan="3"><c:if test="${orderBo.status ==1}">执行中</c:if><c:if test="${orderBo.status ==2}">已执行</c:if><c:if test="${orderBo.status ==3}">已取消</c:if></td>
    </tr>
    <tr>
        <th class="text-r">下单时间：</th>
        <td colspan="3"><odpf:formatDate style="DATE_HOUR" date="${orderBo.createTime}"/></td>
    </tr>
    <tr>
        <th class="text-r">创建人：</th>
        <td colspan="3">${orderBo.createBy} </td>
    </tr>
    <tr>
        <th class="text-r">创建时间：</th>
        <td><odpf:formatDate style="DATE_HOUR" date="${orderBo.createTime}"/></td>
    </tr>
    <tr>
        <th class="text-r">更新时间：</th>
        <td><c:if test="${not empty orderBo.modifyTime}"><odpf:formatDate style="DATE_HOUR" date="${orderBo.modifyTime}"/></c:if></td>
    </tr>
    </tbody>
</table>
<div class="clear"></div>
<form id="orderForm">
    <input type="hidden" id="orderId" name="orderId" value="${orderBo.orderId}">
    <input type="hidden" id="strJson" name="strJson" >

<c:choose>
    <c:when test="${tradeOrderList.size()>0 || orderBo.status == 2 || orderBo.status == 3}">
        <table class="table table-border table-bordered table-bg table-sort">
            <thead>
            <tr class="text-l">
                <th width="106" class="public_click_content"><span class="l f-16">贸易信息</span> </th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <table  class="table table-border table-bordered table-hover table-bg">
            <tbody>
            <tr>
                <th class="text-r" width="103"><span class="c-red">*</span>贸易合同号：</th>
                <td width="317">${orderBo.orderCode}</td>
                <th class="text-r" width="133">合同金额：</th>
                <td width="324"><fmt:formatNumber value="${orderBo.cost}" pattern="#,##0.00"/><c:if test="${empty orderBo.cost}">元</c:if></td>
            </tr>
            <tr>
                <th rowspan="2" class="text-r"><span class="c-red">*</span>买方：</th>
                <td rowspan="2">${orderBo.buyOrgName}</td>
                <th class="text-r"><span class="c-red">*</span>卖方：</th>
                <td>${orderBo.saleOrgName}</td>
            </tr>
            <tr>
                <th class="text-r"><span class="c-red">*</span>卖方商铺：</th>
                <td>${orderBo.shopsName}</td>
            </tr>
            <tr>

            </tr>
            <tr>
                <th class="text-r"><span class="c-red">*</span>买方联系人：</th>
                <td>${orderBo.buyUserNameFirst}&nbsp;${orderBo.buyUserNameLast}</td>
                <th class="text-r"><span class="c-red">*</span>卖方联系人： </th>
                <td>${orderBo.saleUserName}</td>
            </tr>
            <tr>
                <th class="text-r"><span class="c-red">*</span>买方联系方式：</th>
                <td>${orderBo.buyUserMobile}&nbsp;&nbsp;${orderBo.buyUserEmail} </td>
                <th class="text-r"><span class="c-red">*</span>卖方联系方式：</th>
                <td>${orderBo.saleUserMobile}&nbsp;&nbsp;${orderBo.saleUserEmail} </td>
            </tr>
            <tr>
                <th class="text-r"><span class="c-red">*</span>交货地：</th>
                <td>
                    <c:if test="${orderBo.deliveryAddrId ==1}"> 满州里</c:if>
                    <c:if test="${orderBo.deliveryAddrId ==2}"> 赤塔</c:if>
                    <c:if test="${orderBo.deliveryAddrId ==3}"> 乌兰乌德</c:if>
                    <c:if test="${orderBo.deliveryAddrId ==4}"> 伊尔库兹克</c:if>
                    <c:if test="${orderBo.deliveryAddrId ==5}"> 新西伯利亚</c:if>
                </td>
                <th class="text-r"><span class="c-red">*</span>提货方式： </th>
                <td>自提</td>
            </tr>
            <tr>
                <th class="text-r"><span class="c-red">*</span>预计交货日期：</th>
                <td><odpf:formatDate style='DATE' date='${orderBo.deliveryDate}'/></td>
                <th class="text-r"><span class="c-red">*</span>最晚交货日期：</th>
                <td><odpf:formatDate style='DATE' date='${orderBo.lastDate}'/></td>
            </tr>
            <tr>
                <th class="text-r">付款方式：</th>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="table-border">
                    <tbody>
                    <tr>
                        <td>支付方式：</td>
                        <td>线下支付</td>
                    </tr>
                    <tr>
                        <td width="32%">预付款比例:</td>
                        <td width="68%">
                            <c:if test="${orderBo.paywayPercent ==1}"> 30%</c:if>
                            <c:if test="${orderBo.paywayPercent ==2}"> 50%</c:if>
                            <c:if test="${orderBo.paywayPercent ==3}">100%</c:if>
                        </td>
                    </tr>
                    <c:if test="${orderBo.paywayPercent ==3}">
                        <tr>
                            <td>尾款支付限期:</td>
                            <td><c:if test="${orderBo.paywayLast == 1}"> 提货前付款</c:if>
                                <c:if test="${orderBo.paywayLast == 2}"> 提货后30天内付款</c:if>
                                <c:if test="${orderBo.paywayLast == 3}"> 提货后60天内付款</c:if>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table></td>
                <th class="text-r">附加说明：</th>
                <td>${orderBo.memo}</td>
            </tr>
            <tr>
                <th class="text-r">商品信息：</th>
                <td colspan="3"><table class="table table-border table-bordered table-hover table-bg table-sort">
                    <thead>
                    <tr class="text-c">
                        <th width="487">商品</th>
                        <th width="549">商品属性</th>
                        <th width="107">采购量</th>
                        <th width="107">标准件</th>
                        <th width="107">包装类型</th>
                        <th width="89">计量单位</th>
                        <th width="89">单价</th>
                        <th width="83">总价 </th>
                        <th width="59">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${skuList}" var="skuList">
                        <c:set var="totalMoney" value="${totalMoney + skuList.unitPrice * skuList.purchareNum}" scope="page"/>
                        <tr id="${skuList.id}">
                            <td><span class="pl-10 w-200">${skuList.skuName}</span></td>
                            <td>
                                <c:forEach items="${skuPropertyList}" var="skuPropertyList">
                                    <c:if test="${skuPropertyList.key == skuList.skuId}">
                                        <c:forEach items="${skuPropertyList.value}" var="propertyList">
                                            ${propertyList.propertyName}：${propertyList.propertyValue}<br/>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>${skuList.purchareNum}${skuList.unitName}</td>
                            <td>${skuList.standard}${skuList.unitName}/${skuList.packageName}</td>
                            <td>${skuList.packageName}</td>
                            <td>${skuList.unitName}</td>
                            <td><fmt:formatNumber value="${skuList.unitPrice}" pattern="#,##0.00"/></td>
                            <td>
                                <fmt:formatNumber value="${skuList.unitPrice * skuList.purchareNum}" pattern="#,##0.00"/>
                            </td>
                            <td class="f-14 user-manage"></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                    <span class="r">
                        合计：<fmt:formatNumber value="${totalMoney}" pattern="#,##0.00"/>元
                    </span>
                </td>
            </tr>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <table class="table table-border table-bordered table-bg table-sort">
            <thead>
            <tr class="text-l">
                <th width="106" class="public_click_content"><span class="l f-16">贸易信息</span> <span class="r">
      <button class="btn btn-success radius" type="button" id="orderSubmit"><i class="icon-ok"></i> 保存</button>
      </span> </th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <table class="table table-border table-bordered table-hover table-bg">
            <tbody>
            <tr>
                <th class="text-r" width="103"><span class="c-red">*</span>贸易合同号：</th>
                <td width="317"><input type="text" id="orderCode" name="orderCode" placeholder="贸易合同编号" value="${orderBo.orderCode}" style="width:250px" class="input-text"></td>
                <td class="text-r" width="133">合同金额：</td>
                <td width="324"><input type="text" id="cost" name="cost" placeholder="合同金额" value="${orderBo.cost}" style="width:250px" class="input-text">
                    元</td>
            </tr>
            <tr>
                <th rowspan="2" class="text-r"><span class="c-red">*</span>买方：</th>
                <td rowspan="2">${orderBo.buyOrgName}</td>
                <td class="text-r"><span class="c-red">*</span>卖方：</td>
                <td>${orderBo.saleOrgName}</td>
            </tr>
            <tr>
                <td class="text-r"><span class="c-red">*</span>卖方商铺：</td>
                <td>${orderBo.shopsName}</td>
            </tr>
            <tr>

            </tr>
            <tr>
                <th class="text-r"><span class="c-red">*</span>买方联系人：</th>
                <td>
                    <select name="buyUserId" class="select">
                        <c:forEach items="${buyUserList}" var="userBo">
                            <option value="${userBo.userId}"<c:if test="${userBo.userId == orderBo.buyUserId}">selected="selected"</c:if>>${userBo.userNameFirst}&nbsp;${userBo.userNameLast}</option>
                        </c:forEach>
                    </select>
                </td>
                <td class="text-r"><span class="c-red">*</span>卖方联系人： </td>
                <td>
                    <select name="saleUserId" class="select">
                        <c:forEach items="${saleUserList}" var="userBo">
                            <option value="${userBo.userId}"<c:if test="${userBo.userId == orderBo.saleUserId}">selected="selected"</c:if>>${userBo.userNameCn}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <th class="text-r"><span class="c-red">*</span>买方联系方式：</th>
                <td>${orderBo.buyUserMobile}&nbsp;&nbsp;${orderBo.buyUserEmail} </td>
                <th class="text-r"><span class="c-red">*</span>卖方联系方式：</th>
                <td>${orderBo.saleUserMobile}&nbsp;&nbsp;${orderBo.saleUserEmail} </td>
            </tr>
            <tr>
                <th class="text-r"><span class="c-red">*</span>交货地：</th>
                <td><select class="select" name="deliveryAddrId" size="1" style="width:120px">
                    <option value="1" <c:if test="${orderBo.deliveryAddrId ==1}"> selected</c:if>>满州里</option>
                    <option value="2" <c:if test="${orderBo.deliveryAddrId ==2}"> selected</c:if>>赤塔</option>
                    <option value="3" <c:if test="${orderBo.deliveryAddrId ==3}"> selected</c:if>>乌兰乌德</option>
                    <option value="4" <c:if test="${orderBo.deliveryAddrId ==4}"> selected</c:if>>伊尔库兹克</option>
                    <option value="5" <c:if test="${orderBo.deliveryAddrId ==5}"> selected</c:if>>新西伯利亚</option>
                </select>

                </td>
                <td class="text-r"><span class="c-red">*</span>提货方式： </td>
                <td><select name="takeGoodType" class="select">
                    <option value="1">自提</option>
                </select></td>
            </tr>
            <tr>
                <th class="text-r"><span class="c-red">*</span>预计交货日期：</th>
                <td><input class="Wdate" type="text" id="deliveryDate" value="<odpf:formatDate style='DATE' date='${orderBo.deliveryDate}'/>" name="deliveryDate" onFocus="WdatePicker({isShowClear:false,readOnly:true,minDate:'$y-%M-%d'})"/></td>
                <td class="text-r"><span class="c-red">*</span>最晚交货日期：</td>
                <td><input class="Wdate" type="text" id="lastDate" name="lastDate" value="<odpf:formatDate style='DATE' date='${orderBo.lastDate}'/>" onFocus="WdatePicker({isShowClear:false,readOnly:true,minDate:'$y-%M-%d'})"/></td>
            </tr>
            <tr>
                <th class="text-r">付款方式：</th>
                <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="table-border">
                    <tbody>
                    <tr>
                        <td>支付方式：</td>
                        <td><select class="select" name="payType" size="1" style="width:120px">
                            <option value="1" selected>线下支付</option>
                        </select></td>
                    </tr>
                    <tr>
                        <td width="32%">预付款比例:</td>
                        <td width="68%"><select class="select" id="paywayPercent" name="paywayPercent" size="1" style="width:150px">
                            <option value="1" <c:if test="${orderBo.paywayPercent ==1}"> selected</c:if>>30%</option>
                            <option value="2" <c:if test="${orderBo.paywayPercent ==2}"> selected</c:if>>50%</option>
                            <option value="3" <c:if test="${orderBo.paywayPercent ==3}"> selected</c:if>>100%</option>
                        </select></td>
                    </tr>
                    <tr id="paywayLast" <c:if test="${orderBo.paywayPercent ==3}">style="display: none"</c:if>>
                        <td>尾款支付限期:</td>
                        <td><select class="select" name="paywayLast" size="1" style="width:120px">
                            <option value="1"  <c:if test="${orderBo.paywayLast == 1}"> selected</c:if>>提货前付款</option>
                            <option value="2"  <c:if test="${orderBo.paywayLast == 2}"> selected</c:if>>提货后30天内付款</option>
                            <option value="2"  <c:if test="${orderBo.paywayLast == 3}"> selected</c:if>>提货后60天内付款</option>
                        </select></td>
                    </tr>

                    </tbody>
                </table></td>
                <td class="text-r">附加说明：</td>
                <td><textarea name="memo" cols="50" rows="5">${orderBo.memo}</textarea></td>
            </tr>
            <tr>
                <th class="text-r">商品信息：</th>
                <td colspan="3" id="shuiwu">
                    <table class="table table-border table-bordered table-hover table-bg table-sort">
                    <thead>
                    <tr class="text-c">
                        <th width="487">商品</th>
                        <th width="549">商品属性</th>
                        <th width="107">采购量</th>
                        <th width="107">标准件</th>
                        <th width="107">包装类型</th>
                        <th width="89">计量单位</th>
                        <th width="89">单价</th>
                        <th width="83">总价 </th>
                        <th width="59">操作</th>
                    </tr>
                    </thead>
                    <tbody  id="product">
                    <c:forEach items="${skuList}" var="skuList">
                        <c:set var="totalMoney" value="${totalMoney + skuList.unitPrice * skuList.purchareNum}" scope="page"/>
                        <tr id="${skuList.skuId}">
                            <td><span class="pl-10 w-200">${skuList.skuName}</span></td>
                            <td>
                                <c:forEach items="${skuPropertyList}" var="skuPropertyList">
                                    <c:if test="${skuPropertyList.key == skuList.skuId}">
                                        <c:forEach items="${skuPropertyList.value}" var="propertyList">
                                            ${propertyList.propertyName}：${propertyList.propertyValue}<br/>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </td>
                            <td>
                                ${skuList.purchareNum}${skuList.unitName}
                                <input type="hidden" id="sku_${skuList.skuId}_purchareNum" value=" ${skuList.purchareNum}"/>
                            </td>
                            <td>
                                ${skuList.standard}${skuList.unitName}/${skuList.packageName}
                                <input type="hidden" id="sku_${skuList.skuId}_standard" value=" ${skuList.standard}"/>
                            </td>
                            <td>
                                ${skuList.packageName}
                                <input type="hidden" id="sku_${skuList.skuId}_packageType" value="${skuList.packageType}"/>
                            </td>
                            <td>
                                ${skuList.unitName}
                                <input type="hidden" id="sku_${skuList.skuId}_unit" value="${skuList.unit}"/>
                            </td>
                            <td>
                                <fmt:formatNumber value="${skuList.unitPrice}" pattern="#,##0.00"/>
                                <input type="hidden" id="sku_${skuList.skuId}_unitPrice" value="${skuList.unitPrice}"/>
                            </td>
                            <td>
                                <fmt:formatNumber value="${skuList.unitPrice * skuList.purchareNum}" pattern="#,##0.00"/></td>
                            <td class="f-14 user-manage"><a title="编辑" id="${skuList.skuId}" onclick="updateSku(this)" href="javascript:void(0)" target="_self" class="ml-5 public_examine" style="text-decoration:none"><i class="icon-edit"></i></a> <a title="删除" href="javascript:;" onClick="user_del(this,'1')" class="ml-5" style="text-decoration:none"><i class="icon-trash"></i></a></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                    <span class="r">合计：<fmt:formatNumber value="${totalMoney}" pattern="#,##0.00"/>元</span>
                </td>
            </tr>
            <tr>
                <th class="text-r">&nbsp;</th>
                <td colspan="3" align="right"><button class="btn btn-success radius" id="updateStatus" type="button"><i class="icon-ok"></i>执行</button></td>
            </tr>
            </tbody>
        </table>
    </c:otherwise>
</c:choose>
</form>
<c:if test="${tradeOrderList.size()>0}">
<table class="table table-border table-bordered table-bg table-sort">
    <thead>
    <tr class="text-l">
        <th width="106" class="public_click_content"><span class="l f-16">服务信息</span></th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<table class="table table-border table-bordered table-bg table-sort mt-10">
    <thead>
    <tr class="text-l">
        <th width="106" class="public_click_content"><select class="select_a" name="tradeCode" id="tradeCode" size="1" style="width:240px">
            <c:forEach items="${serviceOrderList}" var="serviceOrder">
                <option value="${serviceOrder.srvOrderId}">${serviceOrder.srvOrderCode}</option>
            </c:forEach>
        </select>
        </th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<table class="table table-border table-bordered table-bg table-sort">
    <tbody id = "relevanceServiceOrder">
    <tr>
        <th width="16%" class="text-r">服务订单状态：</th>
        <td width="84%"><c:if test="${serviceOrderBo.status ==1}">待确认</c:if><c:if test="${serviceOrderBo.status ==2}">待分配</c:if><c:if test="${serviceOrderBo.status ==3}">执行中</c:if><c:if test="${serviceOrderBo.status ==4}">已执行</c:if><c:if test="${serviceOrderBo.status ==5}">已取消</c:if><c:if test="${serviceOrderBo.status ==6}">已终止</c:if></td>
    </tr>
    <tr>
        <th class="text-r">服务委托方：</th>
        <td><c:if test="${serviceOrderBo.countryType ==1}"> ${serviceOrderBo.orgNameCn}</c:if><c:if test="${serviceOrderBo.countryType ==2}"> ${serviceOrderBo.orgNameRu}</c:if></td>
    </tr>
    <tr>
        <th class="text-r">委托方联系人：</th>
        <td><c:if test="${serviceOrderBo.countryType ==1}">${serviceOrderBo.userNameCn}</c:if><c:if test="${serviceOrderBo.countryType ==2}">${serviceOrderBo.userNameFirst}&nbsp;${serviceOrderBo.userNameLast}</c:if></td>
    </tr>
    <tr>
        <th class="text-r">服务供应商：</th>
        <td> 满洲里诚林贸易有限责任公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 客服：<c:if test="${empty serviceOrderBo.customServiceName}">无</c:if>${serviceOrderBo.customServiceName} </td>
    </tr>
    <tr>
        <th class="text-r">委托服务：</th>
        <td>${serviceOrderBo.orderService}
            <%--<c:forEach items="${serviceMap}" var="serviceList">--%>
                <%--<c:if test="${serviceList.key ==serviceOrderBo.srvOrderId}">--%>
                    <%--<c:forEach items="${serviceList.value}" var="service">--%>
                       <%--${service.serviceName}--%>
                    <%--</c:forEach>--%>
                <%--</c:if>--%>
            <%--</c:forEach>--%>
        </td>
    </tr>
    <tr>
        <th class="text-r">下单时间：</th>
        <td><odpf:formatDate style="DATE" date="${serviceOrderBo.createTime}"/></td>
    </tr>
    <tr>
        <th class="text-r">&nbsp;</th>
        <td><a href="${ctx}/serviceOrder/${serviceOrderBo.srvOrderId}/edit" _href="javascript:void(0)">查看服务订单详情</a></td>
    </tr>
    <c:if test="${orderBo.status ==1}">
        <tr>
            <th class="text-r">&nbsp;</th>
            <td colspan="3" align="right"><button class="btn btn-success radius" id="updateStatus" type="button"><i class="icon-ok"></i>执行</button></td>
        </tr>
    </c:if>

    </tbody>
</table>
<input type="hidden" id="skuList">
</c:if>
</div>

<div id="examine_box_bg"></div>
<div id="examine_box">
    <p><strong>编辑商品</strong><em class="examine_close">X</em></p>
    <table width="100%" class="table">
        <input type ="hidden" id="skuId">
        <tr>
            <td class="text-r">商品：</td>
            <td>水果蔬菜 &gt; 鲜水果 &gt; 苹果 &gt; 红玫瑰 </td>
            <input type="hidden" id="proId">
        </tr>
        <tr>
            <td class="text-r">单价：</td>
            <td><input type="text" id="price" placeholder="单价" value="" style="width:250px;margin-top:10px;" class="input-text order_price"></td>
        </tr>
        <tr>
            <td class="text-r">采购量：</td>
            <td><input type="text" id="purchareNum" placeholder="采购量" value="" style="width:250px;margin-top:10px;" class="input-text order_purchareNum"></td>
        </tr>
        <tr>
            <td class="text-r">标准件：</td>
            <td><input type="text" id="standard" placeholder="标准件" value="" style="width:250px;margin-top:10px;" class="input-text order_standard"></td>
        </tr>
        <tr>
            <td class="text-r">包装方式：</td>
            <td><select id="skuType" class="select order_packageType" name="packageType" size="1" style="width:120px">
                <c:forEach items="${packageType}" var="packageType">
                    <option value="${packageType.constValue}">${packageType.constName}</option>
                </c:forEach>
            </select></td>
        </tr>

    </table>
    <div style="clear:both;"></div>
    <span>
    	<input type="button" class="examine_close" id="submit" value="保存">
    	<a href="javascript:;" class="examine_close">取消</a>
	</span><br>

</div>


<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/Validform_v5.3.2_min.js"></script>
<script language="javascript" src="${ctx}/resources/js/common/dateformat.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script language="javascript" src="${ctx}/resources/js/position_top.js"></script>
<script>
    window.ctx="${ctx}";
</script>
<script language="javascript" src="${ctx}/resources/js/order/edit.js"></script>
</body>
</html>