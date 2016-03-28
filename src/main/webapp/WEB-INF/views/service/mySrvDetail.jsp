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

    <title>服务订单编辑</title>

</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span>订单中心 <span class="c-gray en">&gt;</span> 服务订单管理 <span class="c-gray en">&gt;</span> 服务订单编辑 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a></nav>
<div class="pd-20">
<div id="message_position">
    <div id="position_fixed" class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l">
    <a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_a_click">
         基本信息</a>
    <a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
        贸易信息</a>
    <a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
        服务信息</a>
    <a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
        执行跟踪</a>
    <a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
        单据</a>
    <a href="javascript:;" name="_self"  class="btn btn-primary radius public_a_click">
        账单</a>
    </span>

    </div>
</div>
<table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top">
    <thead>
    <tr class="text-l">
        <th width="106"><span class="l f-16">基本信息</span><c:if test="${serviceOrderBo.status==1}"><span class="r"><a href="#" id="save" name="_self" class="btn btn-primary radius"> 保存</a> </span></c:if> </th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<form id="orderForm">
    <input type="hidden" value="${serviceOrderBo.srvOrderId}" id="srvOrderId" name="srvOrderId">
    <input type="hidden" value="${serviceOrderBo.orgId}" id="orgId"  name="orgId">
<table class="table table-border table-bordered table-hover table-bg">
    <tbody>
    <tr>
        <th class="text-r">服务订单编号：</th>
        <td  width="40%">${serviceOrderBo.srvOrderCode}</td>
        <th class="text-r">服务订单状态：</th>
        <td width="20%"><c:if test="${serviceOrderBo.status==1}">待确认<input id="srv_confirm" type="button" class="btn btn-success" value="确认"></input></c:if>
            <c:if test="${serviceOrderBo.status==2}">待分配</c:if>
            <c:if test="${serviceOrderBo.status==3}">执行中</c:if>
            <c:if test="${serviceOrderBo.status==4}">已执行</c:if>
            <c:if test="${serviceOrderBo.status==5}">已取消</c:if>
            <c:if test="${serviceOrderBo.status==6}">已终止</c:if>
        </td>

    </tr>
    <tr>
        <th class="text-r">服务委托方：</th>
        <td><c:if test="${serviceOrderBo.countryType ==1}">${serviceOrderBo.orgNameCn}</c:if><c:if test="${serviceOrderBo.countryType ==2}">${serviceOrderBo.orgNameRu}</c:if></td>
        <th class="text-r">委托方联系人：</th>
        <td>
            <select name="contacts">
                <c:forEach items="${contactsNameList}" var="contactsName">
                    <option value="${contactsName.userId}" <c:if test="${contactsName.userId == serviceOrderBo.contacts}">selected</c:if>><c:if test="${serviceOrderBo.countryType ==1}">${contactsName.userNameCn}</c:if><c:if test="${serviceOrderBo.countryType ==2}">${contactsName.userNameFirst}&nbsp;${contactsName.userNameLast}</c:if></option>
                </c:forEach>
            </select>
        </td>
    </tr>
    <tr>
        <th class="text-r">服务供应商：</th>
        <td> ${org.orgNameCn}</td>
        <th class="text-r">客服：</th>
        <td>
            <select name="customService">
                <option value="">--请选择--</option>
                <c:forEach items="${customServiceName}" var="customServiceName">
                    <option value="${customServiceName.userId}" <c:if test="${customServiceName.userId == serviceOrderBo.customService}">selected="selected"</c:if>>${customServiceName.userNameCn}</option>
                </c:forEach>
            </select>
        </td>
    </tr>
    <tr>
        <th class="text-r">委托服务：</th>
        <td><table border="0" cellpadding="0" cellspacing="0" id="news_add_center">
            <tr>
                <div style="width:400px; float:left">
                <input type="checkbox" name="serviceId" class="chklist"  <c:forEach items="${serviceList}" var="service"><c:if test="${service.serviceId == '1'}"> checked="checked"</c:if></c:forEach> value="1"/>
                <label class="chkbox checked"> <span class="check-image "></span> <span class="radiobox-content">出口代理</span> </label>
                <input type="checkbox" name="serviceId" class="chklist" value="2" <c:forEach items="${serviceList}" var="service"><c:if test="${service.serviceId == '2'}"> checked="checked"</c:if></c:forEach>/>
                <label class="chkbox"> <span class="check-image"></span> <span class="radiobox-content">出口报检</span> </label>
                <input type="checkbox" name="serviceId" class="chklist" value="3"<c:forEach items="${serviceList}" var="service"><c:if test="${service.serviceId == '3'}"> checked="checked"</c:if></c:forEach>/>
                <label class="chkbox"> <span class="check-image"></span> <span class="radiobox-content">出口报关</span> </label>
                <input type="checkbox" name="serviceId" class="chklist" value="4" <c:forEach items="${serviceList}" var="service"><c:if test="${service.serviceId == '4'}"> checked="checked"</c:if></c:forEach>/>
                <label class="chkbox"> <span class="check-image"></span> <span class="radiobox-content">俄境清关</span> </label>
                <input type="checkbox" name="serviceId" class="chklist" value="5" <c:forEach items="${serviceList}" var="service"><c:if test="${service.serviceId == '5'}"> checked="checked"</c:if></c:forEach>>
                <label class="chkbox"> <span class="check-image"></span> <span class="radiobox-content">国内运输</span> </label>
                <input type="checkbox" name="serviceId" class="chklist" value="6" <c:forEach items="${serviceList}" var="service"><c:if test="${service.serviceId == '6'}"> checked="checked"</c:if></c:forEach>/>
                <label class="chkbox"> <span class="check-image"></span> <span class="radiobox-content">俄境运输</span> </label>
                <input type="checkbox" name="serviceId" class="chklist" value="7" <c:forEach items="${serviceList}" var="service"><c:if test="${service.serviceId == '7'}"> checked="checked"</c:if></c:forEach>/>
                <label class="chkbox"> <span class="check-image"></span> <span class="radiobox-content">国内仓储</span> </label>
                <input type="checkbox" name="serviceId" class="chklist" value="8" <c:forEach items="${serviceList}" var="service"><c:if test="${service.serviceId == '8'}"> checked="checked"</c:if></c:forEach>/>
                <label class="chkbox"> <span class="check-image"></span> <span class="radiobox-content">俄境仓储</span> </label>
                </div>
            </tr>

        </table></td>
        <th class="text-r">下单时间：</th>
        <td><odpf:formatDate style="DATE" date="${serviceOrderBo.createTime}"/></td>
    </tr>
    <tr>
        <th rowspan="4" valign="top" class="text-r">订单备注：</th>
        <td rowspan="4" valign="top"><textarea name="memo" cols="50" rows="5">${serviceOrderBo.memo}</textarea></td>
        <th class="text-r">创建人：</th>
        <td><c:if test="${serviceOrderBo.countryType ==1}">${serviceOrderBo.createByCn}</c:if><c:if test="${serviceOrderBo.countryType ==2}">${serviceOrderBo.createByFirst}&nbsp;${serviceOrderBo.createByLast}</c:if> </td>
    </tr>
    <tr>
        <th class="text-r">创建时间： </th>
        <td><odpf:formatDate style="DATE" date="${serviceOrderBo.createTime}"/></td>
    </tr>
    <tr>
        <th class="text-r">更新时间： </th>
        <td><odpf:formatDate style="DATE" date="${serviceOrderBo.modifyTime}"/> </td>
    </tr>
    </tbody>
</table>
</form>
<div class="clear"></div>
<table class="table table-border table-bordered table-bg table-sort mt-15">
    <thead>
    <tr class="text-l">
        <th width="106" class="public_click_content"><span class="l f-16">贸易信息</span>

        </th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<div class="tab" id="orderShow" <c:if test="${empty boList}">style="display: none" </c:if>>
<table class="table table-border table-bordered table-bg table-sort mt-10">
    <thead>
    <tr class="text-l">
        <th width="106" class="">
            <select class="select_a" name="selTradeOrder" id="selTradeOrder" size="1" style="width:240px">
                <c:forEach items="${boList}" var="boList">
                <option value="${boList.tradeOrderId}">${boList.tradeCode}</option>
            </c:forEach>
        </select>
        </th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<form id="addTradeOrderForm">
<input type="hidden" name="tradeOrderId" value="${bo.tradeOrderId}">
<div class="con1" id="tradeOrders">
<table class="table table-border table-bordered table-hover table-bg">
    <tbody id="orderDetail">
        <tr>
            <th class="text-r" width="103"><span class="c-red">*</span>贸易合同号：</th>
            <td width="317">${bo.tradeCode}</td>
            <td class="text-r" width="133">合同金额：</td>
            <td width="324">
                <c:if test="${not empty bo.cost}">
                    <fmt:formatNumber value="${bo.cost}" pattern="#,##0.00"/>
                    元
                </c:if>
                </td>
        </tr>
        <tr>
            <th class="text-r"><span class="c-red">*</span>买方：</th>
            <td>${bo.buyOrgName}</td>
            <td class="text-r"><span class="c-red">*</span>卖方：</td>
            <td>${bo.saleOrgName}</td>
        </tr>
        <tr>
            <td class="text-r"><span class="c-red">*</span>卖方商铺：</td>
            <td colspan="3">${bo.shopName}<c:if test="${empty bo.shopName}">--</c:if></td>
        </tr>
        <tr>
            <th class="text-r"><span class="c-red">*</span>买方联系人：</th>
            <td>${bo.buyUserName}</td>
            <td class="text-r"><span class="c-red">*</span>卖方联系人： </td>
            <td>${bo.saleUserName}</td>
        </tr>
        <tr>
            <th class="text-r"><span class="c-red">*</span>买方联系方式：</th>
            <td>${bo.buyContact}</td>
            <th class="text-r"><span class="c-red">*</span>卖方联系方式：</th>
            <td>${bo.saleContact}</td>
        </tr>
        <tr>
            <th class="text-r"><span class="c-red">*</span>交货地：</th>
            <td>
                <c:if test="${bo.deliveryAddrId ==1}"> 满州里</c:if>
                <c:if test="${bo.deliveryAddrId ==2}"> 赤塔</c:if>
                <c:if test="${bo.deliveryAddrId ==3}"> 乌兰乌德</c:if>
                <c:if test="${bo.deliveryAddrId ==4}"> 伊尔库兹克</c:if>
                <c:if test="${bo.deliveryAddrId ==5}"> 新西伯利亚</c:if>
            </td>
            <td class="text-r"><span class="c-red">*</span>提货方式： </td>
            <td><c:if test="${bo.takeGoodsType ==1 }">自提</c:if></td>
        </tr>
        <tr>
            <th class="text-r"><span class="c-red">*</span>预计交货日期：</th>
            <td><odpf:formatDate style="DATE" date="${bo.deliveryDate}"/></td>
            <td class="text-r">最晚交货日期：</td>
            <td><odpf:formatDate style="DATE" date="${bo.lastDate}"/></td>
        </tr>
        <tr>
            <th class="text-r">付款方式：</th>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="table-border">
                <tbody>
                <tr>
                    <td width="32%">预付款比例:</td>
                    <td width="68%">
                        <c:if test="${empty bo.paywayPercent}">--</c:if>
                        <c:if test="${bo.paywayPercent == 3}"> 100% </c:if>
                        <c:if test="${bo.paywayPercent == 2}"> 50% </c:if>
                        <c:if test="${bo.paywayPercent == 1}"> 30% </c:if>
                    </td>
                </tr>
                <tr>
                    <td>尾款支付限期:</td>
                    <td><c:if test="${empty bo.paywayLast}">--</c:if><c:if test="${bo.paywayLast ==1}">提货前付款</c:if><c:if test="${bo.paywayLast ==2}">提货后30天内付款</c:if><c:if test="${bo.paywayLast ==3}">提货后60天内付款</c:if></td>
                </tr>
                <tr>
                    <td>支付方式：</td>
                    <td><c:if test="${bo.payType ==1}">线下付款</c:if><c:if test="${empty bo.payType}">--</c:if></td>
                </tr>
                </tbody>
            </table></td>
            <td class="text-r">附加说明：</td>
            <td>${bo.memo}</td>
        </tr>
    <tr>
        <th class="text-r">商品信息：</th>
        <td colspan="3" id="shuiwu"><table class="table table-border table-bordered table-hover table-bg table-sort">
            <thead>
            <tr class="text-c">
                <th>商品</th>
                <th>采购量</th>
                <th>计量单位</th>
                <th>标准件</th>
                <th>包装方式</th>
                <th>单价 </th>
                <th>总价 </th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${productBoList}" var="productBo">
                <c:set var="totalMoney" value="${totalMoney + productBo.unitPrice * productBo.purchareNum}" scope="page"/>
                <tr>
                    <td><span class="pl-10 w-200">${productBo.productName}</span></td>
                    <td><fmt:formatNumber value="${productBo.purchareNum}" pattern="#,##0.00"/></td>
                    <td>${productBo.unitName}</td>
                    <td><fmt:formatNumber value="${productBo.standard}" pattern="#,##0.00"/></td>
                    <td><c:if test="${productBo.packageType==1}">箱</c:if><c:if test="${productBo.packageType==2}">篮</c:if><c:if test="${productBo.packageType==3}">篮</c:if></td>
                    <td>
                        <fmt:formatNumber value=" ${productBo.unitPrice}" pattern="#,##0.00"/>
                    </td>
                    <td>
                        <fmt:formatNumber value=" ${productBo.unitPrice * productBo.purchareNum}" pattern="#,##0.00"/>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <spam class="r">
            <span class="r">合计：<fmt:formatNumber value="${totalMoney}" pattern="#,##0.00"/>元</span>
        </spam>
        </td>
    </tr>
    <tr>
        <th class="text-r">&nbsp;</th>
        <td colspan="3" align="right" class="text-r">
            <c:if test="${bo.orderId==0 || bo.orderId==null}"><a href="#" onclick="updateOrder()">编辑</a></c:if>
            <c:if test="${bo.orderId !=0 && bo.orderId !=null}"><a href="${ctx}/order/${bo.orderId}/edit"> 查看贸易订单详情</a></c:if>
            <a href="#" onclick="delTradeOrder()"> 删除</a>
        </td>
    </tr>
    </tbody>
</table>
</div>
</form>
</div>
<div class="tab" id="orderEdit" style="display: none">
    <form id="createTradeOrderForm">
        <div id ="addTradeOrder">
            <table class="table table-border table-bordered table-hover table-bg">
                <tbody id="createTradeOrderTb">
                    <tr>
                        <th class="text-r" width="103"><span class="c-red">*</span>贸易合同号：</th>
                        <td width="317"><input type="text" name="tradeCode"  placeholder="贸易合同编号" value="" style="width:250px" class="input-text"></td>
                        <td class="text-r" width="133">合同金额：</td>
                        <td width="324"><input type="text" name="cost" id="cost" placeholder="合同金额" value="" style="width:250px" class="input-text">
                            元</td>
                    </tr>
                    <tr>
                        <th class="text-r"><span class="c-red">*</span>买方：</th>
                        <td><input type="text" name="buyOrgName" id="cn-name5" placeholder="买方名称" value="" style="width:250px" class="input-text"></td>
                        <td class="text-r"><span class="c-red">*</span>卖方：</td>
                        <td><input type="text" id="cn-name6" name="saleOrgName" placeholder="卖方名称" value="" style="width:250px" class="input-text"></td>
                    </tr>
                    <tr></tr>
                    <tr>
                        <th class="text-r"><span class="c-red">*</span>买方联系人：</th>
                        <td><input type="text" name="buyUserName" id="website-static2" placeholder="买方联系人名称" value="" style="width:250px" class="input-text"></td>
                        <td class="text-r"><span class="c-red">*</span>卖方联系人： </td>
                        <td><input type="text" name="saleUserName" id="website-static4" placeholder="卖方联系人名称" value="" style="width:250px" class="input-text"></td>
                    </tr>
                    <tr>
                        <th class="text-r"><span class="c-red">*</span>买方联系方式：</th>
                        <td><input type="text" name="buyContact" id="website-static6" placeholder="买方联系方式" value="" style="width:250px" class="input-text"></td>
                        <th class="text-r"><span class="c-red">*</span>卖方联系方式：</th>
                        <td><input type="text" name="saleContact" id="website-static5" placeholder="卖方联系方式" value="" style="width:250px" class="input-text"></td>
                    </tr>
                    <tr>
                        <th class="text-r"><span class="c-red">*</span>交货地：</th>
                        <td>
                            <select name="deliveryAddrId" id="deliveryAddrId">
                                <option value="">--请选择--</option>
                                <c:forEach items="${deliveryAddr}" var="deliveryAddr">
                                    <option value="${deliveryAddr.constValue}">${deliveryAddr.constName}</option>
                                </c:forEach>
                            </select>
                        </td>
                        <td class="text-r"><span class="c-red">*</span>提货方式： </td>
                        <td><select name="takeGoodsType">
                            <option value="1">自提</option>
                        </select></td>
                    </tr>
                    <tr>
                        <th class="text-r"><span class="c-red">*</span>预计交货日期：</th>
                        <td><input class="Wdate" name="deliveryDate" type="text" id="deliveryDate" value="" onFocus="WdatePicker({isShowClear:false,readOnly:true})"/></td>
                        <td class="text-r">最晚交货日期：</td>
                        <td><input class="Wdate" name="lastDate" type="text" id="lastDate" value="" onFocus="WdatePicker({isShowClear:false,readOnly:true})"/></td>
                    </tr>
                    <tr>
                        <td class="text-r">附加说明：</td>
                        <td><textarea name="memo" cols="50" rows="5"></textarea></td>
                        <td class="text-r">结算币种：</td>
                        <td><select name="costType">
                            <option value="1">元</option>
                        </select></td>
                    </tr>
                <tr>
                    <th class="text-r">商品信息：</th>
                    <td colspan="3" id="shuiwu2"><table width="100%" border="0" cellspacing="3" cellpadding="0">
                        <tr>
                            <td width="92%" height="46"> 品类名称：
                                <select class="select" data_alias="Check17" size="1" style="width:150px" id="catalog1" onchange="loadCs2(this);">
                                    <option value="">--请选择--</option>
                                    <c:forEach items="${catalogList}" var="catalog">
                                        <option value="${catalog.catalogId}">${catalog.catalogNameCn}</option>
                                    </c:forEach>
                                </select>
                                <select class="select catalogSelect2" data_alias="Check18"  id="catalog2"size="1" style="width:120px"  onchange="loadCs3(this);">
                                    <option value="">--请选择--</option>
                                </select>
                                <select class="select catalogSelect3" data_alias="Check19" id="catalog3" size="1" style="width:120px"  onchange="loadPro(this);">
                                    <option value="">--请选择--</option>
                                </select>
                                <select class="select productSelect" data_alias="Check20" size="1"  style="width:120px" id="productId">
                                    <option value="">--请选择--</option>
                                </select>
                                <%--<input type="text" id="skuName"  value="" style="width:160px" class="input-text"></td>--%>
                            <td width="8%">&nbsp;</td>
                        </tr>
                        <tr>
                            <td height="46"><input type="text" id="price"  value="" style="width:120px" class="input-text">
                                <select class="select" id="costType" data_alias="Check21" size="1" style="width:120px">
                                    <option value="1" selected>元</option>
                                </select>
                                采购量：
                                <input type="text" id="Count"  value="" style="width:120px" class="input-text">
                                <span id="order_sku_caigou"></span>
                                标准件：
                                <input type="text" id="stand"  value="" style="width:120px" class="input-text">
                                <span id="order_sku_biaozhun"></span>
                                包装方式：
                                <select data_alias="select8" id="type">
                                    <c:forEach var="type" items="${packageType}">
                                        <option value="${type.constValue}">${type.constName}</option>
                                    </c:forEach>
                                </select></td>
                            <td>
                                <input  type="hidden" id="tradeOrderSkuId">
                                <button type="button" class="btn btn-success" id="add"><i class="icon-search"></i> 新增</button>
                            </td>
                        </tr>
                    </table>
                        <table class="table table-border table-bordered table-hover table-bg table-sort" id="tradeOrderSkuTable">
                            <thead>
                            <tr class="text-c">
                                <th>商品</th>
                                <th>采购量</th>
                                <th>计量单位</th>
                                <th>标准件</th>
                                <th>包装方式</th>
                                <th>单价 </th>
                                <th>总价 </th>
                                <th>操作 </th>
                            </tr>
                            </thead>
                            <tbody id="tradeOrderSkuList" >

                            </tbody>
                        </table></td>
                </tr>
                <tr>
                    <th class="text-r">&nbsp;</th>
                    <input type="hidden" value="${serviceOrderBo.srvOrderId}"  name="srvOrderId">
                    <td colspan="3"><a href="#" onclick="skuSubmit()" class="btn btn-primary radius"><i class="icon-plus"></i> 提交</a>
                        <a href="#" onclick="resetSku()" class="btn btn-primary radius"><i class="icon-plus"></i> 取消</a>
                    </td>
                </tr>
                </tbody>

            </table>


        </div>
    </form>
</div>

<br>
<div class="clear"></div>
<table class="table table-border table-bordered table-bg table-sort">
    <thead>
    <tr class="text-l">
        <th width="106" class="public_click_content"><span class="l f-16">服务信息</span></th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<c:forEach var="map" items="${Map}">
    <c:if test="${map.key == 'service1'}">
        <table class="table table-border table-bordered table-bg table-sort mt-15">
            <thead>
            <tr class="text-l">
                <th width="106" class="">出口代理
        <c:if test="${serviceOrderBo.status==1}">
        <span class="r">
            <button class="btn btn-success radius" type="button"  id="exportTradeSubmit"><i class="icon-ok"></i> 保存</button>
        </span>
        </c:if>
                </th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <table class="table table-border table-bordered table-bg table-sort">
            <tbody>

            <tr>
                <th width="128" height="50" class="text-r"><span class="c-red">*</span>服务价格：</th>
                <td width="819">
                    <input type="text"<c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> id="exportTrade" placeholder="请输入出口贸易代理价格" value="${map.value.srvPrice}" style="width:250px" class="input-text">
                    <input type="hidden" value="${map.value.id}" id="exportTradeId">
                    <input type="hidden" id="exportTradeDtl" value="${Map['service1dtl']}" >
                    元 </td>
            </tr>
            </tbody>
        </table>
    </c:if>
    <c:if test="${map.key == 'service2'}">
        <table class="table table-border table-bordered table-bg table-sort mt-15">
            <thead>
            <tr class="text-l">
                <th width="106" class="">报检代理
    <c:if test="${serviceOrderBo.status==1}">
<span class="r">
          <button class="btn btn-success radius" type="button" id="inspectionSubmit"><i class="icon-ok"></i> 保存</button>
          </span>
</c:if>
                </th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <table class="table table-border table-bordered table-bg table-sort">
            <tbody>

            <tr>
                <th width="128" height="50" class="text-r"><span class="c-red">*</span>服务价格：</th>
                <td width="819">
                    <input type="text" <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> id="inspection" placeholder="请输入报检代理价格" value="${map.value.srvPrice}" style="width:250px" class="input-text">
                    <input type="hidden" id="inspectionDtl" value="${Map['service2dtl']}"  >
                    <input type="hidden" id="inspectionId" value="${map.value.id}"  >
                    元 </td>
            </tr>
            </tbody>
        </table>
    </c:if>
    <c:if test="${map.key == 'service3'}">
        <table class="table table-border table-bordered table-bg table-sort mt-15">
            <thead>
            <tr class="text-l">
                <th width="106" class="">报关代理
            <c:if test="${serviceOrderBo.status==1}">
                <span class="r">
                  <button class="btn btn-success radius" type="button" id="applyproxySubmit"><i class="icon-ok"></i> 保存</button>
                </span>
            </c:if></th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <table class="table table-border table-bordered table-bg table-sort">
            <tbody>
            <tr>
                <th width="15%" height="50" class="text-r"><span class="c-red">*</span>服务价格：</th>
                <td width="35%">
                    <input type="text" <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose>
                           id="applyproxy" placeholder="请输入报关代理价格" value="${map.value.srvPrice}" style="width:250px" class="input-text">
                    <input type="hidden" id="applyproxyDtl" value="${Map['service3dtl']}" >
                    <input type="hidden" id="applyproxyId" value="${map.value.id}" >
                    元 </td>
                <th width="15%" <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="text-r"><span class="c-red">*</span>报关行：</th>
                <td width="35%">
                    <input class="input-text" type="text" id="broker" name="broker" value="${serviceOrderBo.broker}"/></td>
            </tr>
            </tbody>
        </table>
    </c:if>
    <c:if test="${map.key == 'service4'}">
        <table class="table table-border table-bordered table-bg table-sort mt-15">
            <thead>
            <tr class="text-l">
                <th width="106" class="">俄境清关
            <c:if test="${serviceOrderBo.status==1}">
                    <span class="r">
                  <button class="btn btn-success radius" type="button" id="ruClearanceSubmit"><i class="icon-ok"></i> 保存</button>
                </span>
            </c:if></th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <table class="table table-border table-bordered table-bg table-sort">
            <tbody>
            <tr>
                <th width="128" height="50" class="text-r"><span class="c-red">*</span>服务价格：</th>
                <td width="819">
                    <input type="text" <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> id="ruClearance" placeholder="请输入俄境清关价格" value="${map.value.srvPrice}" style="width:250px" class="input-text">
                    <input type="hidden" id="ruClearanceDtl" value="${Map['service4dtl']}"  >
                    <input type="hidden" id="ruClearanceId" value="${map.value.id}"  >
                    元</td>
            </tr>
            </tbody>
        </table>
    </c:if>
    <c:if test="${map.key == 'service5'}">
        <form id="TransCn">
            <input type="hidden" id="TransDtl" name="srvOrderDtlid" value="${Map['service5dtl']}"  >
            <input type="hidden" id="CnTransId" name="transId" value="${map.value.transId}"  >
            <table class="table table-border table-bordered table-bg table-sort mt-15">
                <thead>
                <tr class="text-l">
                    <th width="106" class="">国内运输
                    <c:if test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}">
                    <span class="r">
                      <button class="btn btn-success radius" type="button" id="CnTrans"><i class="icon-ok"></i> 保存</button>
                    </span>
                    </c:if></th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <table class="table table-border table-bordered table-bg table-sort">
                <tbody id="CnTransTable">
                <tr>
                    <input type="hidden" id="transDtlCn">
                    <th width="143" height="50" class="text-r"><span class="c-red">*</span>发货地： </th>
                    <td colspan="3">
                        <select class="select"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> name="startProvId" size="1" style="width:120px" id="startProvCn">
                            <option value="">--请选择省--</option>
                            <option value="${map.value.startProvId}">--请选择--</option>
                            <c:forEach items="${starProvList}" var="prov">
                                <option value="${prov.id}" <c:if test="${map.value.startProvId==prov.id}">selected</c:if> >
                                        ${prov.cnname}</option>
                            </c:forEach>
                        </select>
                        <select  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="select" name="startCityId" size="1" style="width:120px" id="startCityCn">
                            <option value="">--请选择市--</option>
                            <c:forEach items="${starCityList}" var="city">
                                <option value="${city.id}" <c:if test="${map.value.startCityId==city.id}">selected</c:if> >
                                        ${city.cnname}</option>
                            </c:forEach>
                        </select>
                        <select  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="select" name="startDistId" size="1" style="width:120px" id="startDistCn">
                            <option value="">--请选择区--</option>
                            <c:forEach items="${starDistList}" var="dist">
                                <option value="${dist.id}" <c:if test="${map.value.startDistId==dist.id}">selected</c:if> >
                                        ${dist.cnname}</option>
                            </c:forEach>
                        </select>
                        <input <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="input-text" type="text" placeholder="请输入具体地址" name="startAddr" id="startAddr" value="${map.value.startAddr}">
                    </td>
                </tr>
                <tr>
                    <th height="50" class="text-r"><span class="c-red">*</span>目的地： </th>
                    <td colspan="3"><select class="select"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> name="endProvId" size="1" style="width:120px" id="endProvId">
                            <option value="">--请选择省--</option>
                            <c:forEach items="${endProvList}" var="prov">
                                <option value="${prov.id}" <c:if test="${map.value.endProvId==prov.id}">selected</c:if> >
                                        ${prov.cnname}</option>
                            </c:forEach>
                        </select>
                        <select class="select"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> name="endCityId" size="1" style="width:120px" id="endCityId">
                            <option value="">--请选择市--</option>
                            <c:forEach items="${endCityList}" var="city">
                                <option value="${city.id}" <c:if test="${map.value.endCityId ==city.id}">selected</c:if> >
                                        ${city.cnname}</option>
                            </c:forEach>
                        </select>
                        <select class="select"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> name="endDistId" size="1" style="width:120px" id="endDistId">
                            <option value="">--请选择区--</option>
                            <c:forEach items="${endDistList}" var="dist">
                                <option value="${dist.id}" <c:if test="${map.value.endDistId==dist.id}">selected</c:if> >
                                        ${dist.cnname}</option>
                            </c:forEach>
                        </select>
                        <input <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="input-text" type="text" placeholder="请输入具体地址" name="endAddr" id="endAddr" value="${map.value.endAddr}">
                    </td>
                </tr>
                <tr>
                    <th height="50" class="text-r"><span class="c-red">*</span>联系人：</th>
                    <td colspan="3"><input  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="text" name="contacts" id="contactsCn" placeholder="姓名" value="${map.value.contacts}" style="width:150px" class="input-text">
                        -
                        <input  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="text" id="contactsTelCn" name="contactsTel" placeholder="手机" value="${map.value.contactsTel}" style="width:150px" class="input-text"></td>
                </tr>

                <tr id = "autoCn">
                    <th height="50" class="text-r"><span class="c-red">*</span>车辆信息： </th>
                    <td colspan="3">
                        <table id="autoInfoCn"   cellpadding="0" cellspacing="0" border="0">
                                <c:choose>
                                    <c:when test="${map.value.transAutoList != null}">

                                        <c:forEach items="${map.value.transAutoList}" var="transAutoList" varStatus="status">
                                                <tr>
                                                      <td>
                                                    <select class="select"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="autoType" size="1" style="width:120px">
                                                        <option value="" selected>选择车型</option>
                                                        <c:forEach var="carType" items="${carType}">
                                                            <option value="${carType.constValue}" <c:if test="${carType.constValue == transAutoList.autoType}">selected="selected"</c:if>>${carType.constName}</option>
                                                        </c:forEach>
                                                    </select>
                                                    -
                                                    <select class="select"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="autoSpec" size="1" style="width:120px">
                                                        <option value="" selected>选择载重量</option>
                                                        <c:forEach var="loadType" items="${loadType}">
                                                        <option value="${loadType.constValue}" <c:if test="${loadType.constValue == transAutoList.autoSpec}">selected="selected"</c:if>>${loadType.constName}</option>
                                                        </c:forEach>
                                                    </select>
                                                    -
                                                    <select class="select"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="autoVolume"  size="1" style="width:120px">
                                                        <option value="" selected>选择规格</option>
                                                        <c:forEach var="volumeType" items="${volumeType}">
                                                            <option value="${volumeType.constValue}" <c:if test="${volumeType.constValue == transAutoList.autoVolume}">selected="selected"</c:if>>${volumeType.constName}</option>
                                                        </c:forEach>
                                                    </select>
                                                    -
                                                    <input <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="text" data-alias="autoLicense" placeholder="车牌" value="${transAutoList.autoLicense}" style="width:120px" class="input-text">
                                                    <input <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="text" data-alias="driver"  placeholder="司机姓名" value="${transAutoList.driver}" style="width:120px" class="input-text">
                                                    <input <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="text"  data-alias="driverTel" placeholder="司机手机" value="${transAutoList.driverTel}" style="width:120px" class="input-text">
                                                    <!--<button type="button"  class="delTrans">-</button>-->
                                                    <c:choose>
                                                        <c:when test="${status.count ==1}">
                                                            <button  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="addTrans" type="button">添加</button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="button" class="delStore" onclick="deleteTrans(this)">删除</button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                </tr>
                                        </c:forEach>

                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td>
                                                <select class="select"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="autoType" size="1" style="width:120px">
                                                    <option value="" selected>选择车型</option>
                                                    <c:forEach var="carType" items="${carType}">
                                                        <option value="${carType.constValue}" <c:if test="${carType.constValue == transAutoList.autoType}">selected="selected"</c:if>>${carType.constName}</option>
                                                    </c:forEach>
                                                </select>
                                                -
                                                <select class="select"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="autoSpec" size="1" style="width:120px">
                                                    <option value="" selected>选择载重量</option>
                                                    <c:forEach var="loadType" items="${loadType}">
                                                        <option value="${loadType.constValue}" <c:if test="${loadType.constValue == transAutoList.autoSpec}">selected="selected"</c:if>>${loadType.constName}</option>
                                                    </c:forEach>
                                                </select>
                                                -
                                                <select class="select"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="autoVolume"  size="1" style="width:120px">
                                                    <option value="" selected>选择规格</option>
                                                    <c:forEach var="volumeType" items="${volumeType}">
                                                        <option value="${volumeType.constValue}" <c:if test="${volumeType.constValue == transAutoList.autoVolume}">selected="selected"</c:if>>${volumeType.constName}</option>
                                                    </c:forEach>
                                                </select>
                                                -
                                                <input <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="text" id="autoLicense" data-alias="autoLicense" placeholder="车牌" value="" style="width:120px" class="input-text">
                                                <input <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="text" data-alias="driver" id="driver" placeholder="司机姓名" value="" style="width:120px" class="input-text">
                                                <input <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="text" id="driverTel" data-alias="driverTel" placeholder="司机手机" value="" style="width:120px" class="input-text">
                                                <!--<button type="button"  class="delTrans">-</button>-->
                                                <button  class="addTrans"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="button">添加</button>
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th height="50" class="text-r"><span class="c-red">*</span>预计发货日期： </th>
                    <td width="352"><input  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="Wdate" type="text"  value="<odpf:formatDate style='DATE' date='${map.value.deliveryDate}'/>" id="deliveryDateCn" name="deliveryDate" onFocus="WdatePicker({isShowClear:false,readOnly:true})"/></td>
                    <th width="143" height="50" class="text-r"><span class="c-red">*</span>预计到货日期： </th>
                    <td width="831"><input  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="Wdate" type="text"  value="<odpf:formatDate style='DATE' date='${map.value.arriveDate}'/>" id="arriveDateCn" name="arriveDate" onFocus="WdatePicker({isShowClear:false,readOnly:true})"/></td>
                </tr>
                <tr>
                    <th height="50" class="text-r"><span class="c-red">*</span>交货方式： </th>
                    <td><select  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="select" name="deliveryType" size="1" style="width:120px">
                        <option value="1" <c:if test="${map.value.deliveryType == 1}">selected</c:if>>入库</option>
                        <option value="2" <c:if test="${map.value.deliveryType == 2}">selected</c:if>>倒装</option>
                    </select></td>
                    <th height="50" class="text-r"><span class="c-red">*</span>服务价格： </th>
                    <td><input type="text"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>readonly="true"</c:otherwise></c:choose> id="transPriceCn"  name="srvPrice" placeholder="请输入服务价格" value="${map.value.srvPrice}" style="width:150px" class="input-text">元
                        </td>
                </tr>
                </tbody>
            </table>
        </form>
    </c:if>
    <c:if test="${map.key == 'service6'}">
        <form id="TransRu">
            <input type="hidden" name="srvOrderDtlid" value="${Map['service6dtl']}" >
            <input type="hidden" name="transId" id="RuTransId" value="${map.value.transId}" >
            <table class="table table-border table-bordered table-bg table-sort mt-15">
                <thead>
                <tr class="text-l">
                    <th  width="106" class="">俄境运输
                    <c:if test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}">
                        <span class="r">
                           <button class="btn btn-success radius" type="button" id="RuTrans"><i class="icon-ok"></i> 保存</button>
                        </span>
                    </c:if></th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <table class="table table-border table-bordered table-bg table-sort">
                <tbody id="RuTransTable">
                <tr></tr>
                <tr>
                    <input type="hidden" id="transRnDtl">
                    <th width="143" height="50" class="text-r"><span class="c-red">*</span>交货地： </th>
                    <td colspan="3">
                    <select class="select"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> name="endProvIdRu" size="1" style="width:120px" id="endProvIdRu">
                        <option value="">--请选择--</option>
                        <c:forEach items="${deliveryAddr}" var="deliveryAddr">
                            <option value="${deliveryAddr.constValue}" <c:if test="${deliveryAddr.constValue == map.value.endProvIdRu}">selected="selected"</c:if>>${deliveryAddr.constName}</option>
                        </c:forEach>
                    </select>
                        <input <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="input-text" type="text" name="endAddrRu" placeholder="请输入具体地址" id="endAddrRu" value="${map.value.endAddrRu}">
                    </td>

                </tr>
                <tr>
                    <th height="50" class="text-r"><span class="c-red">*</span>联系人：</th>
                    <td colspan="3"><input  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="text" name="contacts" id="contactsRu" placeholder="姓名" value="${map.value.contacts}" style="width:150px" class="input-text">
                        -
                        <input type="text"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> id="contactsTelRu" name="contactsTel" placeholder="手机" value="${map.value.contactsTel}" style="width:150px" class="input-text"></td>
                </tr>
                <tr>
                    <th height="50" class="text-r"><span class="c-red">*</span>车辆信息： </th>
                    <td colspan="3">
                        <table  cellpadding="0" cellspacing="0" border="0">
                            <c:choose>
                                <c:when test="${map.value.transAutoList != null}">

                                    <c:forEach items="${map.value.transAutoList}" var="transAutoList" varStatus="status">
                                        <tr>
                                            <td>
                                                <select class="select"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="autoType" size="1" style="width:120px">
                                                    <option value=" " selected>选择车型</option>
                                                    <c:forEach var="carType" items="${carType}">
                                                        <option value="${carType.constValue}" <c:if test="${carType.constValue == transAutoList.autoType}">selected="selected"</c:if>>${carType.constName}</option>
                                                    </c:forEach>
                                                </select>
                                                -
                                                <select class="select"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="autoSpec" size="1" style="width:120px">
                                                    <option value=" " selected>选择载重量</option>
                                                    <c:forEach var="loadType" items="${loadType}">
                                                        <option value="${loadType.constValue}" <c:if test="${loadType.constValue == transAutoList.autoSpec}">selected="selected"</c:if>>${loadType.constName}</option>
                                                    </c:forEach>
                                                </select>
                                                -
                                                <select class="select"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="autoVolume"  size="1" style="width:120px">
                                                    <option value=" " selected>选择规格</option>
                                                    <c:forEach var="volumeType" items="${volumeType}">
                                                        <option value="${volumeType.constValue}" <c:if test="${volumeType.constValue == transAutoList.autoVolume}">selected="selected"</c:if>>${volumeType.constName}</option>
                                                    </c:forEach>
                                                </select>
                                                -
                                                <input <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="text" data-alias="autoLicense" placeholder="车牌" value="${transAutoList.autoLicense}" style="width:120px" class="input-text">
                                                <input <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="text" data-alias="driver"  placeholder="司机姓名" value="${transAutoList.driver}" style="width:120px" class="input-text">
                                                <input <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="text"  data-alias="driverTel" placeholder="司机手机" value="${transAutoList.driverTel}" style="width:120px" class="input-text">
                                                <!--<button type="button"  class="delTrans">-</button>-->
                                                <c:choose>
                                                    <c:when test="${status.count ==1}">
                                                        <button  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose>  class="addTrans" type="button">添加</button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="button" class="delStore" onclick="deleteTrans(this)">删除</button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td>
                                            <select class="select" data-alias="autoType" size="1" style="width:120px">
                                                <option value=" " selected>选择车型</option>
                                                <c:forEach var="carType" items="${carType}">
                                                    <option value="${carType.constValue}" <c:if test="${carType.constValue == transAutoList.autoType}">selected="selected"</c:if>>${carType.constName}</option>
                                                </c:forEach>
                                            </select>
                                            -
                                            <select class="select" data-alias="autoSpec" size="1" style="width:120px">
                                                <option value=" " selected>选择载重量</option>
                                                <c:forEach var="loadType" items="${loadType}">
                                                    <option value="${loadType.constValue}" <c:if test="${loadType.constValue == transAutoList.autoSpec}">selected="selected"</c:if>>${loadType.constName}</option>
                                                </c:forEach>
                                            </select>
                                            -
                                            <select class="select" data-alias="autoVolume"  size="1" style="width:120px">
                                                <option value=" " selected>选择规格</option>
                                                <c:forEach var="volumeType" items="${volumeType}">
                                                    <option value="${volumeType.constValue}" <c:if test="${volumeType.constValue == transAutoList.autoVolume}">selected="selected"</c:if>>${volumeType.constName}</option>
                                                </c:forEach>
                                            </select>
                                            -
                                            <input <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="text"  data-alias="autoLicense" placeholder="车牌" value="" style="width:120px" class="input-text">
                                            <input <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="text" data-alias="driver"  placeholder="司机姓名" value="" style="width:120px" class="input-text">
                                            <input <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="text"  data-alias="driverTel" placeholder="司机手机" value="" style="width:120px" class="input-text">
                                            <!--<button type="button"  class="delTrans">-</button>-->
                                            <button <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose>  class="addTrans" type="button">添加</button>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </table>
                    </td>
                </tr>
                <tr>
                    <th height="50" class="text-r"><span class="c-red">*</span>预计发货日期： </th>
                    <td width="352"><input  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="Wdate" type="text" id="deliveryDateRu" value="<odpf:formatDate style='DATE' date='${map.value.deliveryDate}'/>" name="deliveryDate" onFocus="WdatePicker({isShowClear:false,readOnly:true})"/></td>
                    <th width="143" height="50" class="text-r"><span class="c-red">*</span>预计到货日期： </th>
                    <td width="831"><input  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="Wdate" type="text" id="arriveDateRu" value="<odpf:formatDate style='DATE' date='${map.value.arriveDate}'/>" name="arriveDate" onFocus="WdatePicker({isShowClear:false,readOnly:true})"/></td>
                </tr>
                <tr>
                    <th height="50" class="text-r"><span class="c-red">*</span>交货方式： </th>
                    <td><select  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="select" name="deliveryType" size="1" style="width:120px">
                        <option value="1" <c:if test="${map.value.deliveryType == 1}">selected</c:if>>入库</option>
                        <option value="2" <c:if test="${map.value.deliveryType == 2}">selected</c:if>>倒装</option>
                    </select></td>
                    <th height="50"  class="text-r"><span class="c-red">*</span>服务价格： </th>
                    <td><input  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>readonly="true"</c:otherwise></c:choose> id="transPriceRu" type="text" name="srvPrice" placeholder="请输入服务价格" value="${map.value.srvPrice}" style="width:150px" class="input-text">元
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
    </c:if>
    <c:if test="${map.key == 'service7'}">
        <form id="StoreCn" >
            <input type="hidden" name="srvOrderDtlid" value="${Map['service7dtl']}" >
            <input type="hidden" name="id" id ="CnStoreId" value="${map.value.id}" >
            <table class="table table-border table-bordered table-bg table-sort mt-15">
                <thead>
                <tr class="text-l">
                    <th width="106" class="">国内仓储
                    <c:if test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}">
                        <span class="r">
                          <button class="btn btn-success radius"  type="button" id="CnStore"><i class="icon-ok"></i> 保存</button>
                        </span>
                    </c:if></th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <table class="table table-border table-bordered table-bg table-sort">
                <tbody id="CnStoreTable">
                <tr>
                    <input type="hidden" id="storeCnDtl">
                    <td width="214" height="50" class="text-r"><span class="c-red">*</span>仓储需求： </td>
                    <td width="1402" colspan="3">
                        <table  cellpadding="0" cellspacing="0" border="0">
                            <c:if test="${map.value.storeAutoList != null}">

                                <c:forEach items="${map.value.storeAutoList}" var="storeAutoList" varStatus="status">
                                    <tr>
                                    <td>
                                        <select  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="select storageType" onchange="changeStore(this)" size="1" style="width:120px" data-alias="storageType">
                                            <option value="0">仓库类型</option>
                                            <c:forEach var="storageType" items="${storageType}">
                                                <option value="${storageType.constValue}" <c:if test="${storageType.constValue == storeAutoList.storageType}">selected="selected"</c:if>>${storageType.constName}</option>
                                            </c:forEach>
                                        </select>
                                        <input  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose>  data-alias="capacity" type="text" placeholder="面积" value="${storeAutoList.storageSize}" style="width:150px" class="input-text">
                                        立方米
                                        <input  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="days"  type="text" class="input-text" value="${storeAutoList.days}" placeholder="天数" style="width:150px">
                                        天
                                        <select <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="select storageSelect"  data-alias="srvStoreId" size="1" style="width:120px">
                                            <option value="">仓库名称</option>
                                            <c:if test="${storeAutoList.storageType ==1}">
                                                <c:forEach var="storage" items="${storage1}">
                                                    <option value="${storage.id}" <c:if test="${storage.id ==storeAutoList.storageId}">selected="selected"</c:if>>${storage.storageName}</option>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${storeAutoList.storageType ==2}">
                                                <c:forEach var="storage" items="${storage2}">
                                                    <option value="${storage.id}" <c:if test="${storage.id ==storeAutoList.storageId}">selected="selected"</c:if>>${storage.storageName}</option>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${storeAutoList.storageType ==3}">
                                                <c:forEach var="storage" items="${storage3}">
                                                    <option value="${storage.id}" <c:if test="${storage.id ==storeAutoList.storageId}">selected="selected"</c:if>>${storage.storageName}</option>
                                                </c:forEach>
                                            </c:if>
                                        </select>
                                        <input <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="storageSeat" type="text" class="input-text"  value="${storeAutoList.storageSeat}" placeholder="库位" style="width:150px">
                                        <c:choose>
                                            <c:when test="${status.count == 1}">
                                                <button  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="addStore" type="button">添加</button>
                                            </c:when>
                                            <c:otherwise>
                                                <button  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="button" class="delStore" onclick="deleteStores(this)" >删除</button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    </tr>
                                </c:forEach>

                            </c:if>
                            <c:if test="${map.value.storeAutoList == null}">
                                <tr><td>
                                    <select  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="select storageType" onchange="changeStore(this)" size="1" style="width:120px" data-alias="storageType">
                                        <option value="">仓库类型</option>
                                        <c:forEach var="storageType" items="${storageType}">
                                            <option value="${storageType.constValue}" <c:if test="${storageType.constValue == storeAutoList.storageType}">selected="selected"</c:if>>${storageType.constName}</option>
                                        </c:forEach>
                                    </select>
                                    <input  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> id="capacity" data-alias="capacity" type="text" placeholder="面积" value="" style="width:150px" class="input-text">
                                    立方米
                                    <input  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="days"  type="text" class="input-text" id="days" placeholder="天数" style="width:150px">
                                    天
                                    <select <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="select storageSelect" data-alias="srvStoreId" size="1" style="width:120px">
                                        <option value="">仓库名称</option>
                                    </select>
                                    <input <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="storageSeat" type="text" class="input-text" id="storageSeat" placeholder="库位" style="width:150px">
                                    <button  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="addStore" type="button">添加</button>

                                </td></tr>
                            </c:if>
                        </table>
                        </td>
                </tr>
                <tr>
                    <td height="50" class="text-r"><span class="c-red">*</span>预计入库日期：</td>
                    <td colspan="3"><input  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="Wdate" type="text" value="<odpf:formatDate style='DATE' date='${map.value.storageDate}'/>" name="storageDate" id="storageDateCn" onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
                        <span class="c-red">*</span>预计出库日期：
                        <input class="Wdate"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="text" name="deliveryDate" id="storeDateCn" value="<odpf:formatDate style='DATE' date='${map.value.deliveryDate}'/>" onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
                        <span class="c-red">*</span>服务价格：
                        <input name="srvPrice"  <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>readonly="true"</c:otherwise></c:choose> type="text" i placeholder="请输入服务价格" value="${map.value.srvPrice}" style="width:150px" class="input-text" id="storePriceCn">
                        元</td>
                </tr>
                </tbody>
            </table>
        </form>
    </c:if>
    <c:if test="${map.key == 'service8'}">
        <form id="StoreRu">
            <input type="hidden" name="srvOrderDtlid"value="${Map['service8dtl']}" >
            <input type="hidden" name="id" id="RuStoreId" value="${map.value.id}" >
            <table class="table table-border table-bordered table-bg table-sort mt-15">
                <thead>
                <tr class="text-l">
                    <th width="106" class="">俄境仓储
                        <c:if test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}">
                            <span class="r">
                              <button class="btn btn-success radius" type="button" id="RuStore"><i class="icon-ok"></i> 保存</button>
                            </span>
                        </c:if></th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <table class="table table-border table-bordered table-bg table-sort">
                <tbody id="RuStoreTable">
                <tr>
                    <input type="hidden" id="storeRuDtl">
                    <td width="214" height="50" class="text-r"><span class="c-red">*</span>仓储需求： </td>
                    <td width="1402" colspan="3">
                        <table  cellpadding="0" cellspacing="0" border="0">
                            <c:if test="${map.value.storeAutoList != null}">

                                <c:forEach items="${map.value.storeAutoList}" var="storeAutoList" varStatus="status">
                                    <tr>
                                        <td>
                                        <select <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="select storageType" onchange="changeStore(this)" size="1" style="width:120px" data-alias="storageType">
                                            <option value="">仓库类型</option>
                                            <c:forEach var="storageType" items="${storageType}">
                                                <option value="${storageType.constValue}" <c:if test="${storageType.constValue == storeAutoList.storageType}">selected="selected"</c:if>>${storageType.constName}</option>
                                            </c:forEach>
                                        </select>
                                        <input <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="capacity" type="text" placeholder="面积" value="${storeAutoList.storageSize}" style="width:150px" class="input-text">
                                        立方米
                                        <input <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="days"  type="text" class="input-text" value="${storeAutoList.days}" placeholder="天数" style="width:150px">
                                        天
                                        <select <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="select storageSelect"  data-alias="srvStoreId" size="1" style="width:120px">
                                            <option value="">仓库名称</option>
                                            <c:if test="${storeAutoList.storageType ==1}">
                                                <c:forEach var="storage" items="${storage1}">
                                                    <option value="${storage.id}" <c:if test="${storage.id ==storeAutoList.storageId}">selected="selected"</c:if>>${storage.storageName}</option>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${storeAutoList.storageType ==2}">
                                                <c:forEach var="storage" items="${storage2}">
                                                    <option value="${storage.id}" <c:if test="${storage.id ==storeAutoList.storageId}">selected="selected"</c:if>>${storage.storageName}</option>
                                                </c:forEach>
                                            </c:if>
                                            <c:if test="${storeAutoList.storageType ==3}">
                                                <c:forEach var="storage" items="${storage3}">
                                                    <option value="${storage.id}" <c:if test="${storage.id ==storeAutoList.storageId}">selected="selected"</c:if>>${storage.storageName}</option>
                                                </c:forEach>
                                            </c:if>
                                        </select>
                                        <input <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="storageSeat" type="text" class="input-text"  value="${storeAutoList.storageSeat}" placeholder="库位" style="width:150px">
                                        <c:choose>
                                        <c:when test="${status.count == 1}">
                                            <button <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose>  class="addStore" type="button">添加</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> type="button" class="delStore" onclick="deleteStores(this)" >删除</button>
                                        </c:otherwise>
                                        </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>

                            </c:if>
                            <c:if test="${map.value.storeAutoList == null}">
                                <tr><td>
                                    <select <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="select storageType" size="1" style="width:120px" onchange="changeStore(this)" data-alias="storageType">
                                        <option value="0">仓库类型</option>
                                        <c:forEach var="storageType" items="${storageType}">
                                            <option value="${storageType.constValue}" <c:if test="${storageType.constValue == storeAutoList.storageType}">selected="selected"</c:if>>${storageType.constName}</option>
                                        </c:forEach>
                                    </select>
                                    <input <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose>  data-alias="capacity" type="text" placeholder="面积" value="" style="width:150px" class="input-text">
                                    立方米
                                    <input <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="days"  type="text" class="input-text"  placeholder="天数" style="width:150px">
                                    天
                                    <select <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose>  class="select storageSelect" data-alias="srvStoreId" size="1" style="width:120px">
                                        <option value="">仓库名称</option>
                                    </select>
                                    <input <c:choose><c:when test="${serviceOrderBo.status==1 || serviceOrderBo.status==2 || serviceOrderBo.status==3}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> data-alias="storageSeat" type="text" class="input-text"  placeholder="库位" style="width:150px">
                                    <button   <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="addStore" type="button">添加</button>

                                </td></tr>
                            </c:if>
                        </table>
                        </td>
                </tr>
                <tr>
                    <td height="50" class="text-r"><span class="c-red">*</span>预计入库日期：</td>
                    <td colspan="3"><input <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled="disabled" </c:otherwise></c:choose> class="Wdate" type="text" value="<odpf:formatDate style='DATE' date='${map.value.storageDate}'/>" name="storageDate" id="storageDateRu"  onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
                        <span class="c-red">*</span>预计出库日期：
                        <input <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>disabled</c:otherwise></c:choose> class="Wdate" id="storeDateRu" type="text" name="deliveryDate" value="<odpf:formatDate style='DATE' date='${map.value.deliveryDate}'/>" onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
                        <span class="c-red">*</span>服务价格：
                        <input <c:choose><c:when test="${serviceOrderBo.status==1}"></c:when><c:otherwise>readonly="true"</c:otherwise></c:choose> name="srvPrice" id="storePriceRu" type="text" i placeholder="请输入服务价格" value="${map.value.srvPrice}" style="width:150px" class="input-text">
                        元
                    </td>
                </tr>
                </tbody>
            </table>
        </form>
    </c:if>
</c:forEach>
    <div class="clear"></div>
<table class="table table-border table-bordered table-bg table-sort mt-15">
    <thead>
    <tr class="text-l">
        <th width="106" class="public_click_content"><span class="l f-16">执行跟踪</span>
        <span class="r">
            <c:if test="${serviceOrderBo.status == 2 || serviceOrderBo.status == 3}"><a href="${ctx}/serviceOrder/${serviceOrderBo.srvOrderId}/execute" name="_self" class="btn btn-success radius"><i class="icon-plus"></i>执行</a></c:if>
        </span>
        </th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<table class="table table-border table-bordered table-hover table-bg table-sort">
    <thead>
    <tr class="text-c">
        <th>基本服务</th>
        <th>服务商</th>
        <th>操作环节</th>
        <th>状态</th>
        <th>附件</th>
        <th>操作角色</th>
        <th>操作人</th>
        <th>操作时间</th>
        <th>服务计划完成</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${nodeBoList}" var="nodeBoList">
        <tr>
        <td>${nodeBoList.serviceName}</td>
        <td><p>${nodeBoList.srvOrgName}</p></td>
        <td>${nodeBoList.nodeName}</td>
        <td><c:if test="${nodeBoList.status ==0}">未执行</c:if><c:if test="${nodeBoList.status ==1}">执行中</c:if><c:if test="${nodeBoList.status ==2}">已完成</c:if></td>
        <td><a>查看</a></td>
        <td>${nodeBoList.roleName}</td>
        <td>${nodeBoList.userName}</td>
        <td><odpf:formatDate style="DATE" date="${nodeBoList.planDate}"/></td>
        <td><odpf:formatDate style="DATE" date="${nodeBoList.actualDate}"/></td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<p>&nbsp;</p>
<table class="table table-border table-bordered table-bg table-sort">
    <thead>
    <tr class="text-l">
        <th width="106" class="public_click_content"><span class="l f-16">单据</span>

        </th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<table class="table table-border table-bordered table-hover table-bg">
    <tbody>
    <tr>
        <div id="picketImages"></div>
    </tr>
    <tr>
        <th class="text-r" width="110"><span class="c-red">*</span>单据名称：</th>
        <td>
            <input type="text" class="delPhoto" id="picketName"/>
        </td>
    </tr>
    <tr>
        <th class="text-r" width="110"><span class="c-red">*</span>产品图片：</th>
        <td width="1335" colspan="2"><div id="skuImgListId">
            <c:forEach items="${skuPhotoList}" var="skuPhoto" >
                <div>
                    <img src="${skuPhoto.photoUrl}" data-code="${skuPhoto.resourceCode}" id="${skuPhoto.resourceCode}"/>&nbsp;&nbsp;
                    <input type="button" class="delPhoto" value="删除"/>
                </div>
            </c:forEach>
        </div>
            <div style="line-height:20px; margin:10px 0 0 0;">
                最多可以上传6张图片。<br>
                图片大小支持2MB，图片尺寸为360*360<br>
                切勿盗用他人图片，以免受网规处罚，上传优质产品图片会获得更多的站内外流量。
                <br>
                优质产品图片定义：产品原图，即无人为修改痕迹、无水印、无修饰边框和文字。
                <br>
                <input type="file" class="btn-uploadpic"  name="file" id="skuLogoId">
                <input type="hidden"  name="skuLogo" value="${shop.shopsLogo}">
            </div></td>
    </tr>

    <tr>
        <th>
            <span class="r">
            <td><button class="btn btn-success radius" id="savePicket" type="button"><i class="icon-ok"></i>新增</button></td>
            </span>
        </th>
    </tr>

    </tbody>
</table>
<table  class="table table-border table-bordered table-bg table-sort">
    <thead>
    <tr class="text-l">
        <th  width="106" class="public_click_content"><span class="l f-16">账单</span>
            <span class="r">
               <a href="${ctx}/serviceOrder/${serviceOrderBo.srvOrderId}/execute" name="_self" class="btn btn-success radius"><i class="icon-plus"></i>收付</a>
            </span>
        </th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>

<table class="table table-border table-bordered table-hover table-bg table-sort">
    <thead>
    <tr class="text-c">
        <th width="6%">费用项目</th>
        <th width="24%">收/付公司</th>
        <th width="6%">收付类型</th>
        <th width="6%">币种</th>
        <th width="6%">汇率</th>
        <th width="8%">应收/付金额 </th>
        <th width="8%">应收/付金额（RMB）</th>
        <th width="6%">收付状态</th>
        <th width="7%">实际收/付 金额 </th>
        <th width="7%">实际收/付 金额（RMB） </th>
        <th width="8%">计划收付</th>
        <th width="8%">实际收付</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${feeList}" var="feeList">
        <tr>
            <td>${feeList.feeitem}</td>
            <td>付款方：<c:if test="${feeList.payCountryType ==1}">${feeList.payOrgNameCn}</c:if>
                <c:if test="${feeList.payCountryType ==2}">${feeList.payOrgNameRu}</c:if>
                <br/>收款方：<c:if test="${feeList.receiveCountryType ==1}">${feeList.receiveOrgNameCn}</c:if>
                <c:if test="${feeList.receiveCountryType ==2}">${feeList.receiveOrgNameRu}</c:if>
            </td>
            <td><c:if test="${feeList.paymentType ==0}">付款</c:if><c:if test="${feeList.paymentType ==1}">收款</c:if></td>
            <td><c:if test="${feeList.planCurrency ==1}">人民币</c:if><c:if test="${feeList.planCurrency ==2}">美元</c:if><c:if test="${feeList.planCurrency ==3}">卢布</c:if></td>
            <td>${feeList.planRate}</td>
            <td><fmt:formatNumber value="${feeList.planFee}" pattern="#,##0.00"/></td>
            <td><fmt:formatNumber value="${feeList.planFee*feeList.planRate}" pattern="#,##0.00"/></td>
            <td>
                <c:if test="${feeList.status == 0 && feeList.paymentType ==1}">未收</c:if><c:if test="${feeList.status ==1 && feeList.paymentType ==1}">已收</c:if>
                <c:if test="${feeList.status == 0 && feeList.paymentType ==0}">未付</c:if><c:if test="${feeList.status ==1 && feeList.paymentType ==0}">已付</c:if>
            </td>
            <td>
                <c:if test="${not empty feeList.actualFee}">
                    <fmt:formatNumber value="${feeList.actualFee}" pattern="#,##0.00"/>
                </c:if>
            </td>
            <td>
                <c:if test="${not empty feeList.actualFee}">
                    <fmt:formatNumber value="${feeList.actualFee*feeList.planRate}" pattern="#,##0.00"/>
                </c:if>
            </td>
            <td><odpf:formatDate style="DATE" date="${feeList.planDate}"/></td>
            <td><odpf:formatDate style="DATE" date="${feeList.actualDate}"/></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<p>&nbsp;</p>
</div>



<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script language="javascript" src="${ctx}/resources/js/position_top.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/labelauty.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common/dateformat.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>

<script>
     window.ctx="${ctx}";
    $(function(){
        $(".chklist").labelauty("chklist", "check");

        $(document).on("change","#skuLogoId",function(){
//            var skuImgSize = $("#skuImgListId").find("img").length;
//            if(skuImgSize > 5){
//                alert("最多上传6张图片")
//                return false;
//            }
            var $dom = $(this);
            var id=$dom.attr("id");
            if (!/\.(gif|jpg|jpeg|png|pdf|bmp|GIF|JPG|PNG|BMP|JPEG|PDF)$/.test($dom.val())) {
                alert('"错误",hideClose:true,msgTitle: "请上传.jpg .jpeg .gif .png .bmp .pdf格式图像!"');
                return false;
            }
            if ($dom.get(0).files[0].size > 1024 * 1024 * 5){
                alert('不能上传超过5M的文件，您上传的文件过大，请重新上传！');
                $dom.val(null);
                return false;
            }
            $.ajaxFileUpload({
                url:'${ctx}/aldUpload/uploadImg',
                secureuri:false,
                fileElementId:id,
                dataType:"json",
                success: function(data){
                    if(data.result){
                        var src= data.data.urlPath;
                        var resourceCode =  data.data.resourceCode;
                        var imgStr = '<div><img id="uploadImgNew" src="'+src+'"data-code="'+resourceCode+'"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
                        var inputStr = '<input type="button" class="delPhoto" value="删除"/></div>';
                        $("#skuImgListId").append(imgStr+inputStr);
                    }else{
                        alert("上传图片失败");
                    }
                },error: function (xml, status, e){
                    alert("上传图片失败");
                }
            });
        });


        $(document).on("click",".delPhoto",function(){
            var $dom = $(this);
            $dom.parent("div").html("");
        });

        $(document).on("click","#savePicket",function(){
            if(!$("#picketName").val()){
                alert("请输入单据名称");
                return;
            }
            if(!$("uploadImgNew")){
                alert("请选择上传的单据图片！");
                return;
            }

            $.ajax({
                url:'${ctx}/serviceOrder/addPicket',
                data:{"attaName":$("#picketName").val(),
                    "attaPath":$("#uploadImgNew").attr("src"),
                    "srvOrderId":$("#srvOrderId").val(),
                    "srvOrgId":$("#orgId").val()
                },
                dataType:"json",
                type:"post",
                success: function(data){
                    if(data.result){
                        alert("上传单据成功!");
                    }else{
                        alert("上传图片失败!");
                    }
                },error: function (xml, status, e){
                    alert("上传图片失败");
                }
            });

        })
    })

</script>
<script type="text/javascript" src="${ctx}/resources/js/serviceorder/edit.js"></script>
</body>
</html>