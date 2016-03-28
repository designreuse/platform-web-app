<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/jquery-ui.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/popModal.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <link type="text/css" href="${ctx}/resources/css/index.css" rel="stylesheet" />
    <link type="text/css" href="${ctx}/resources/css/labelauty.css" rel="stylesheet" />
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span>订单中心 <span class="c-gray en">&gt;</span> 服务订单管理 <span class="c-gray en">&gt;</span> 服务订单执行 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a></nav>
<div class="pd-20">
<div id="message_position">
    <div id="position_fixed" class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l">
    <a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_a_click">
        基本信息</a>
    <%--<a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">--%>
        <%--贸易信息</a>--%>
    <a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
         服务分配</a>
    <a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
        执行跟踪</a>
    <a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
         账单</a>
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
<form id="orderForm">
    <table class="table table-border table-bordered table-hover table-bg">
        <tbody>
        <tr>
            <th class="text-r">服务订单编号：</th>
            <td>${serviceOrderBo.srvOrderCode}</td>
            <th class="text-r">服务订单状态：</th>
            <td>
                <c:if test="${serviceOrderBo.status==2}">待分配</c:if>
                <c:if test="${serviceOrderBo.status==3}">执行中</c:if>
                <c:if test="${serviceOrderBo.status==4}">已执行</c:if>
                <c:if test="${serviceOrderBo.status==5}">已取消</c:if>
                <c:if test="${serviceOrderBo.status==6}">已终止</c:if>
            </td>
        </tr>
        <input type="hidden" value="${serviceOrderBo.srvOrderId}"name="srvOrderId" id="srvOrderId">
        <tr>
            <th class="text-r">服务委托方：</th>
            <td><c:if test="${serviceOrderBo.countryType ==1}">${serviceOrderBo.orgNameCn}</c:if><c:if test="${serviceOrderBo.countryType ==2}">${serviceOrderBo.orgNameRu}</c:if></td>
            <th class="text-r">委托方联系人：</th>
            <td><c:if test="${serviceOrderBo.countryType ==1}">${serviceOrderBo.userNameCn}</c:if><c:if test="${serviceOrderBo.countryType ==2}">${serviceOrderBo.userNameFirst}&nbsp;${serviceOrderBo.userNameLast}</c:if></td>
        </tr>
        <tr>
            <th class="text-r">服务供应商：</th>
            <td>满洲里阿拉丁信息技术有限公司</td>
            <th class="text-r">客服：</th>
            <td>${serviceOrderBo.customServiceName}</td>
        </tr>
        <tr>
            <th class="text-r">委托服务：</th>
            <td>
                <c:forEach items="${serviceList}" var="service">
                    &nbsp;${service.serviceName}&nbsp;
                </c:forEach>
            </td>
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
<%--<div class="clear"></div>--%>
<%--<table class="table table-border table-bordered table-bg table-sort mt-15">--%>
    <%--<thead>--%>
    <%--<tr class="text-l">--%>
        <%--<th width="106" class="public_click_content"><span class="l f-16">贸易信息</span>--%>
    <%--</tr>--%>
    <%--</thead>--%>
    <%--<tbody>--%>
    <%--</tbody>--%>
<%--</table>--%>
<%--<c:if test="${fn:length(boList) > 0}">--%>
<%--<div class="tab">--%>
    <%--<table class="table table-border table-bordered table-bg table-sort mt-10">--%>
        <%--<thead>--%>
        <%--<tr class="text-l">--%>
            <%--<th width="106" >--%>
                <%--<select class="select_a" name="selTradeOrder" id="selTradeOrder" size="1" style="width:240px">--%>
                    <%--<c:forEach items="${boList}" var="boList">--%>
                        <%--<option value="${boList.tradeOrderId}">${boList.tradeCode}</option>--%>
                    <%--</c:forEach>--%>
                <%--</select>--%>
            <%--</th>--%>
        <%--</tr>--%>
        <%--</thead>--%>
        <%--<tbody>--%>
        <%--</tbody>--%>
    <%--</table>--%>
    <%--<div class="con1" id="tradeOrders">--%>
        <%--<table class="table table-border table-bordered table-hover table-bg">--%>
            <%--<tbody id="orderDetail">--%>
            <%--<tr>--%>
                <%--<th class="text-r" width="103"><span class="c-red">*</span>贸易合同号：</th>--%>
                <%--<td width="317">${bo.tradeCode}</td>--%>
                <%--<td class="text-r" width="133">合同金额：</td>--%>
                <%--<td width="324"><fmt:formatNumber value="${bo.cost}" pattern="#,##0.00"/><c:if test="${empty bo.cost}">元</c:if> </td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th class="text-r"><span class="c-red">*</span>买方：</th>--%>
                <%--<td>${bo.buyOrgName}</td>--%>
                <%--<td class="text-r"><span class="c-red">*</span>卖方：</td>--%>
                <%--<td>${bo.saleOrgName}</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<td class="text-r"><span class="c-red">*</span>卖方商铺：</td>--%>
                <%--<td colspan="3">${bo.shopName}</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th class="text-r"><span class="c-red">*</span>买方联系人：</th>--%>
                <%--<td>${bo.buyUserName}</td>--%>
                <%--<td class="text-r"><span class="c-red">*</span>卖方联系人： </td>--%>
                <%--<td>${bo.saleUserName}</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th class="text-r"><span class="c-red">*</span>买方联系方式：</th>--%>
                <%--<td>${bo.buyContact}</td>--%>
                <%--<th class="text-r"><span class="c-red">*</span>卖方联系方式：</th>--%>
                <%--<td>${bo.saleContact}</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th class="text-r"><span class="c-red">*</span>交货地：</th>--%>
                <%--<td>--%>
                    <%--<c:if test="${bo.deliveryAddrId ==1}"> 满州里</c:if>--%>
                    <%--<c:if test="${bo.deliveryAddrId ==2}"> 赤塔</c:if>--%>
                    <%--<c:if test="${bo.deliveryAddrId ==3}"> 乌兰乌德</c:if>--%>
                    <%--<c:if test="${bo.deliveryAddrId ==4}"> 伊尔库兹克</c:if>--%>
                    <%--<c:if test="${bo.deliveryAddrId ==5}"> 新西伯利亚</c:if>--%>
                <%--</td>--%>
                <%--<td class="text-r"><span class="c-red">*</span>提货方式： </td>--%>
                <%--<td><c:if test="${bo.takeGoodsType ==1 }">自提</c:if></td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th class="text-r"><span class="c-red">*</span>预计交货日期：</th>--%>
                <%--<td><odpf:formatDate style="DATE" date="${bo.deliveryDate}"/></td>--%>
                <%--<td class="text-r">最晚交货日期：</td>--%>
                <%--<td><odpf:formatDate style="DATE" date="${bo.lastDate}"/></td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th class="text-r">付款方式：</th>--%>
                <%--<td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="table-border">--%>
                    <%--<tbody>--%>
                    <%--<tr>--%>
                        <%--<td width="32%">预付款比例:</td>--%>
                        <%--<td width="68%">--%>
                            <%--<c:if test="${bo.paywayPercent == 3}"> 100% </c:if>--%>
                            <%--<c:if test="${bo.paywayPercent == 2}"> 50% </c:if>--%>
                            <%--<c:if test="${bo.paywayPercent == 1}"> 30% </c:if>--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td>尾款支付限期:</td>--%>
                        <%--<td><c:if test="${bo.paywayLast ==1}">提货前付款</c:if><c:if test="${bo.paywayLast ==2}">提货后30天付款</c:if><c:if test="${bo.paywayLast ==3}">提货后30天付款</c:if></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td>支付方式：</td>--%>
                        <%--<td><c:if test="${bo.payType ==1}">线下付款</c:if></td>--%>
                    <%--</tr>--%>
                    <%--</tbody>--%>
                <%--</table></td>--%>
                <%--<td class="text-r">附加说明：</td>--%>
                <%--<td>${bo.memo}</td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th class="text-r">商品信息：</th>--%>
                <%--<td colspan="3" id="shuiwu"><table class="table table-border table-bordered table-hover table-bg table-sort">--%>
                    <%--<thead>--%>
                    <%--<tr class="text-c">--%>
                        <%--<th>商品</th>--%>
                        <%--<th>采购量</th>--%>
                        <%--<th>计量单位</th>--%>
                        <%--<th>标准件</th>--%>
                        <%--<th>包装方式</th>--%>
                        <%--<th>单价 </th>--%>
                        <%--<th>总价 </th>--%>
                    <%--</tr>--%>
                    <%--</thead>--%>
                    <%--<tbody>--%>
                    <%--<c:forEach items="${productBoList}" var="productBo">--%>
                        <%--<tr>--%>
                            <%--<td><span class="pl-10 w-200">${productBo.productName}</span></td>--%>
                            <%--<td>${productBo.purchareNum}</td>--%>
                            <%--<td>${productBo.unitName}</td>--%>
                            <%--<td>${productBo.standard}</td>--%>
                            <%--<td><c:if test="${productBo.packageType==1}">箱</c:if><c:if test="${productBo.packageType==2}">包</c:if><c:if test="${productBo.packageType==3}">篮</c:if></td>--%>
                            <%--<td>--%>
                                <%--<fmt:formatNumber value=" ${productBo.unitPrice}" pattern="#,##0.00"/>--%>
                           <%--</td>--%>
                            <%--<td>--%>
                                <%--<fmt:formatNumber value=" ${productBo.unitPrice * skuList.purchareNum}" pattern="#,##0.00"/>--%>
                            <%--</td>--%>
                        <%--</tr>--%>
                    <%--</c:forEach>--%>
                    <%--</tbody>--%>
                <%--</table></td>--%>
            <%--</tr>--%>
            <%--<tr>--%>
                <%--<th class="text-r">&nbsp;</th>--%>
                <%--<td colspan="3" align="right" class="text-r">--%>
                    <%--<c:if test="${bo.orderId !=0 && bo.orderId !=null}"><a href="${ctx}/order/${bo.orderId}/edit"> 查看贸易订单详情</a></c:if>--%>
                <%--</td>--%>
            <%--</tr>--%>
            <%--</tbody>--%>
        <%--</table>--%>
    <%--</div>--%>
<%--</div>--%>
<%--</c:if>--%>
<br>
<table class="table table-border table-bordered table-bg table-sort mt-15">
    <thead>
    <tr class="text-l">
        <th width="106" class="public_click_content"><span class="l f-16">服务分配</span></th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<form id="serviceSave">
<input type="hidden" value="${serviceOrderBo.srvOrderId}"name="srvOrderId">
<table width="100%" border="0" cellspacing="3" cellpadding="0">
    <tr>
        <td class="text-r">服务商：    </td>
        <td><span class="text-r">
                <input type="text" name="srvOrgName" id="orgName" placeholder="请输入公司名称名称"  style="width:250px" class="input-text">
                <input type="hidden" name="srvOrgId" id="orgId">
    </span></td>
        <td class="text-r">操作任务：</td>
        <td><select class="select" name="serviceId" size="1" style="width:120px">
            <c:forEach var="delList" items="${delList}">
                <c:if test="${delList.srvOrgId == null}">
                    <option value="${delList.serviceId}">${delList.serviceName}</option>
                </c:if>
            </c:forEach>
        </select></td>
        <td class="text-r">计划完成：</td>
        <td><span class="text-r">
      <input type="text" onFocus="WdatePicker({isShowClear:false,readOnly:true})" id="finishDate" name="finishDate" class="input-text Wdate" style="width:150px;">
    </span></td>
    <td>
        <c:if test="${serviceOrderBo.status==2 || serviceOrderBo.status==3}">
        <button type="button" id="saveService" class="btn btn-primary radius" >保存</button>
        </c:if>
    </td>
    </tr>
</table>
</form>

<form action="${ctx}/serviceOrder/${serviceOrderBo.srvOrderId}/execute" method="post">
<table class="table table-border table-bordered table-bg table-sort mt-15">
    <thead>
    <tr class="text-l">
        <a name="execute_genzong"></a>
        <th width="106" class="public_click_content"><span class="l f-16">执行跟踪</span>
            <c:if test="${btnShowFlag==true}">
                 <span class="r">
                  <button class="btn btn-success radius"   type="button" id="executeSuccess"><i class="icon-ok"></i>执行完成</button>
                </span>
            </c:if>
        </th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<table width="100%" border="0" cellspacing="3" cellpadding="0">
    <tr>
        <td width="7%" height="46"> 筛选： </td>
        <td width="51%"><select class="select" name="serviceId" size="1" style="width:100px">
            <option value="" selected>全部</option>
            <option value="1" <c:if test="${nodeVo.serviceId == 1}">selected</c:if>>出口代理</option>
            <option value="2" <c:if test="${nodeVo.serviceId == 2}">selected</c:if>>出口报检</option>
            <option value="3" <c:if test="${nodeVo.serviceId == 3}">selected</c:if>>出口报关</option>
            <option value="4" <c:if test="${nodeVo.serviceId == 4}">selected</c:if>>俄境清关</option>
            <option value="5" <c:if test="${nodeVo.serviceId == 5}">selected</c:if>>国内运输</option>
            <option value="6" <c:if test="${nodeVo.serviceId == 6}">selected</c:if>>俄境运输</option>
            <option value="7" <c:if test="${nodeVo.serviceId == 7}">selected</c:if>>国内仓储</option>
            <option value="8" <c:if test="${nodeVo.serviceId == 8}">selected</c:if>>俄境仓储</option>
        </select>
            <select class="select" name="status" size="1" style="width:100px">
                <option value="" selected>全部</option>
                <option value="0" <c:if test="${nodeVo.status == 0}">selected</c:if>>未执行</option>
                <option value="1" <c:if test="${nodeVo.status == 1}">selected</c:if>>执行中</option>
                <option value="2" <c:if test="${nodeVo.status == 2}">selected</c:if>>已完成</option>
            </select>
            <select class="select" name="orgId" id="srvOrgName" size="1" style="width:200px">
                <option value="" selected>全部</option>
                <c:forEach items="${orgMap}" var="orgMap">
                    <option value="${orgMap.key}" <c:if test="${nodeVo.orgId == orgMap.key}">selected="selected"</c:if>>${orgMap.value}</option>
                </c:forEach>
            </select>
            <select class="select roleName" name="deptId" id="roleName" size="1" style="width:100px">
                <option value="" selected>全部</option>
                <c:forEach items="${deptList}" var="dept">
                    <option value="${dept.id}" <c:if test="${dept.id == nodeVo.deptId}">selected = "selected"</c:if>>${dept.deptName}</option>
                </c:forEach>
            </select>
            <input type="hidden" name="srvOrderId" value="${serviceOrderBo.srvOrderId}">
            <%--<select class="select userName" name="userId" id="userName" size="1" style="width:100px">--%>
                <%--<option value="" selected>全部</option>--%>
            <%--</select></td>--%>
        <td width="17%"><button type="submit" class="btn btn-success"  name="" id="search"><i class="icon-search"></i> 搜索</button></td>
        <td width="3%">&nbsp;</td>
    </tr>
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
        <th>执行</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${nodeBoList}" var="nodeBoList">
        <tr id="srvNode_${nodeBoList.id}">
        <td>${nodeBoList.serviceName}</td>
        <td><p>${nodeBoList.srvOrgName}</p></td>
        <td>${nodeBoList.nodeName}</td>
        <td><c:if test="${nodeBoList.status ==0}">未执行</c:if><c:if test="${nodeBoList.status ==1}">执行中</c:if><c:if test="${nodeBoList.status ==2}">已完成</c:if></td>
        <td><a>查看</a></td>
        <td>${nodeBoList.roleName}</td>
        <td>${nodeBoList.userName}</td>
        <td><odpf:formatDate style="DATE" date="${nodeBoList.modifyTime}"/></td>
        <td><odpf:formatDate style="DATE" date="${nodeBoList.planDate}"/></td>
        <td>
            <c:if test="${(nodeBoList.status ==0 || nodeBoList.status ==1) && (serviceOrderBo.status==2 || serviceOrderBo.status==3)}">
                <button type="button"  onclick="execute(this)" class="btn btn-primary radius" data-dialogmodalbind=".dialog_content11">执行</button>
            </c:if>
        </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<p>&nbsp;</p>
</form>
<table class="table table-border table-bordered table-bg table-sort">
    <thead>
    <tr class="text-l">
        <th width="106" class="public_click_content"><span class="l f-16">账单</span>
        </th>
        <td>
            <button type="button" id="add_price" class="btn btn-success" ><i class="icon-search"></i>新增收款</button>
        </td>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>

<table class="table table-border table-bordered table-hover table-bg table-sort">
    <thead>
    <tr class="text-c">
        <th width="7%">费用项目</th>
        <th width="22%">收/付公司</th>
        <th width="7%">收付类型</th>
        <th width="5%">币种</th>
        <th width="7%">汇率</th>
        <th width="7%">应收/付 金额 </th>
        <th width="13%">应收/付金额（RMB）</th>
        <th width="5%">收付状态</th>
        <th width="10%">实际收/付 金额 </th>
        <th width="15%">实际收/付 金额（RMB） </th>
        <th width="7%">计划收付</th>
        <th width="7%">实际收付</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${feeList}" var="feeList">
        <tr id="fee_${feeList.id}">
            <td>${feeList.feeitem}</td>
            <td>付款方：<c:if test="${feeList.payCountryType ==1}">${feeList.payOrgNameCn}</c:if>
                <c:if test="${feeList.payCountryType ==2}">${feeList.payOrgNameRu}</c:if>
                <br/>收款方：<c:if test="${feeList.receiveCountryType ==1}">${feeList.receiveOrgNameCn}</c:if>
                <c:if test="${feeList.receiveCountryType ==2}">${feeList.receiveOrgNameRu}</c:if>
            </td>
            <td><c:if test="${feeList.paymentType ==0}">付款</c:if><c:if test="${feeList.paymentType ==1}">收款</c:if></td>
            <td><c:if test="${feeList.planCurrency ==1}">人民币</c:if><c:if test="${feeList.planCurrency ==2}">美元</c:if><c:if test="${feeList.planCurrency ==3}">卢布</c:if></td>
            <td>${feeList.planRate}</td>
            <td><fmt:formatNumber value=" ${feeList.planFee}" pattern="#,##0.00"/></td>
            <td><fmt:formatNumber value=" ${feeList.planFee*feeList.planRate}" pattern="#,##0.00"/></td>
            <td>
                <c:if test="${feeList.status == 0 && feeList.paymentType ==1}">未收</c:if><c:if test="${feeList.status ==1 && feeList.paymentType ==1}">已收</c:if>
                <c:if test="${feeList.status == 0 && feeList.paymentType ==0}">未付</c:if><c:if test="${feeList.status ==1 && feeList.paymentType ==0}">已付</c:if>
            </td>
            <td>
                <c:if test="${not empty feeList.actualFee}">
                    <fmt:formatNumber value=" ${feeList.actualFee}" pattern="#,##0.00"/>
                </c:if>
            </td>

            <td>
                <c:if test="${not empty feeList.actualFee}">
                    <fmt:formatNumber value=" ${feeList.actualFee*feeList.planRate}" pattern="#,##0.00"/>
                </c:if>
            </td>
            <td><odpf:formatDate style="DATE" date="${feeList.planDate}"/></td>
            <td><odpf:formatDate style="DATE" date="${feeList.actualDate}"/></td>
            <td>
                <c:if test="${feeList.status == 0}">
                <c:if test="${feeList.paymentType ==0}"><button onclick="pay(this)"  data-dialogModalBind="dialog_content13" class="btn btn-success radius">付款</button></c:if><c:if test="${feeList.paymentType ==1}"><button id="dialogModal_ex" onclick="pay(this)" class="btn btn-success radius">收款</button></c:if>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
</div>

<div id="examine_box_bg"></div>

<div class="dialogModal open" id="window" style="display: none">
<form id="serviceExecute" action="${ctx}/serviceOrder/executeSave" method="post">
    <input type="hidden" id="nodeId" name="id" class="id">
    <input type="hidden" name="srvOrderId" class="srvOrderId">
    <div class="showdialog uc-uinfoverify uc-upavatar" id="execute_window" style="display: none; z-index: 9001;">
    <div class="sd-hd">
    <h2 class="sdtit">服务分配</h2>
    <a href="javascript:void(0)" onclick="closeWindow('execute_window')"  class="close br3 close_popup" title="点击关闭窗口">关闭</a> </div>
    <div class="sd-bd">
    <table width="100%" class="table">
    <tr>
    <td width="15%" class="text-r"></td>
    <td width="85%">&nbsp;</td>
    </tr>
    <tr>
    <td class="text-r">操作环节：</td>
    <td><input type="text" name="nodeName" id="nodeName" class="nodeName" value="" disabled> </td>
    </tr>
    <tr>
    <td class="text-r">操作结果：</td>
    <td><select class="select status" name="status"  size="1" style="width:120px">
    <option value="1">执行中</option>
    <option value="2">已完成</option>
    </select></td>
    </tr>
    <tr>
    <td class="text-r">
    实际完成：
    </td>
    <td><span class="text-r">
    <input type="text"  onFocus="WdatePicker({isShowClear:false,readOnly:true})" id="actualDate" name="actualDate" class="input-text Wdate actualDate" style="width:150px;">
    </span>
    </td>
    </tr>
    <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    </tr>
    </table>

        <p class="fmbtm">
            <span class="fl ftorange hide"><i class="icon i14 i-sign" style="margin-top: 6px;"></i></span>
            <span class="cancel btn-a-white"><a href="javascript:void(0)" onclick="closeWindow('execute_window')"  class="br3" title="取消" id="cancel-uploady-photo">取消</a></span>
            <span class="confirm btn-a-blue"><a href="javascript:void(0)" onclick="closeWindow('execute_window')"  class="br3" title="保存" id="save_execute">保存 </a></span>
        </p>
    </div>
    </div>
</form>
<form id="SavePay" method="post">
    <input type="hidden" id="payId" name="id" class="id">
    <input type="hidden" name="srvOrderId" class="srvOrderId">
    <div class="showdialog uc-uinfoverify uc-upavatar" id="pay_window" style="display: none; z-index: 9001;">
        <div class="sd-hd">
            <h2 class="sdtit">收/付款</h2>
            <a href="javascript:void(0)" onclick="closeWindow('pay_window')"  class="close br3" title="点击关闭窗口">关闭</a>
            </div>
                <div class="sd-bd">
                    <table width="100%" class="table">
                        <tr>
                            <td width="21%" class="text-r"></td>
                            <td width="79%">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="text-r">实际收/付金额： </td>
                            <td><span class="text-r">
                                <input id="payMoneyActually" type="search" name="actualFee" class="input-text" style="width:200px">
                                元</span></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                    <p class="fmbtm">
                        <span class="fl ftorange hide"><i class="icon i14 i-sign" style="margin-top: 6px;"></i></span>
                        <span class="cancel btn-a-white"><a href="javascript:void(0)" onclick="closeWindow('pay_window')"  class="br3" title="取消">取消</a></span>
                        <span class="confirm btn-a-blue"><a href="javascript:void(0)" onclick="closeWindow('pay_window')"  class="br3" title="保存" id="save_pay">保存 </a></span>
                    </p>
                </div>
            </div>
</form>
<form id="addPay" method="post">
    <input type="hidden" name="srvOrderId" class="srvOrderId">
    <div class="showdialog uc-uinfoverify uc-upavatar" id="addPay_window" style="display: none; z-index: 9001;">
        <div class="sd-hd">
            <h2 class="sdtit">新增收付</h2>
            <a href="javascript:void(0)" onclick="closeWindow('addPay_window')"  class="close br3" title="点击关闭窗口">关闭</a>
            </div>
            <div class="sd-bd">
                <table width="100%" class="table">
                    <tr>
                        <td class="text-r">费用项目： </td>
                        <td><span class="text-r">
                          <input type="search" class="input-text" style="width:200px" name="feeitem">
                        </span></td>
                    </tr>
                    <tr>
                        <td class="text-r">对方公司： </td>
                        <td>
                            <input type="text" id="payOrgName" placeholder="请输入公司名称" value style="width:200px" class="input-text">
                            <input type="hidden" name="orgId"  id="payOrgId">
                        </td>
                    </tr>
                    <tr>
                        <td class="text-r">
                            收付类型： </td>
                        <td><select class="select" name="paymentType" size="1" style="width:100px">
                            <option value="1" >收款</option>
                            <option value="0">付款</option>
                        </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="text-r">应收/付金额： </td>
                        <td><span class="text-r">
                              <input id="payMoney" type="search" name="planFee" class="input-text" style="width:120px">
                              <select class="select" name="planCurrency" size="1" style="width:100px">
                                  <option value="1">人民币</option>
                                  <option value="2">美金</option>
                                  <option value="3">卢布</option>
                              </select>
                            </span></td>
                    </tr>
                    <tr>
                        <td>计划收付时间</td>
                        <td>
                            <input type="text"  onFocus="WdatePicker({isShowClear:false,readOnly:true})" id="planDate" name="planDate" class="input-text Wdate actualDate" style="width:100px;">
                        </td>
                    </tr>
                    <tr>
                        <td class="text-r">汇率： </td>
                        <td><span class="text-r">
                          <input id="rate" type="search" class="input-text" style="width:200px" name="planRate">
                        </span></td>
                    </tr>
                </table>
                <p class="fmbtm">
                    <span class="fl ftorange hide"><i class="icon i14 i-sign" style="margin-top: 6px;"></i></span>
                    <span class="cancel btn-a-white"><a href="javascript:void(0)" onclick="closeWindow('addPay_window')"  class="br3" title="取消">取消</a></span>
                    <span class="confirm btn-a-blue"><a href="javascript:void(0)" onclick="closeWindow('addPay_window')"  class="br3" title="保存" id="add_pay">保存 </a></span>
                </p>
            </div>
        </div>
</form>
</div>


<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/Validform_v5.3.2_min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/position_top.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/labelauty.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/popup.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-ui.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        //参数{input类名，选择类型(单选or多选)}
        $(".chklist").labelauty("chklist", "check");
        $("#orgName").autocomplete({
            source:"${ctx}/serviceOrder/srvOrgName",
            minLength: 1,
            autoFocus:true,
            select: function(e, ui) {
                $( "#orgId").val(ui.item.id);
            },
            change:function(e,ui) {
                $( "#orgId").val(ui.item.id);
            }
        });

        $("#executeSuccess").click(function(){
            if(confirm("是否确认执行完成？")) {
                $.ajax({
                    url:"${ctx}/serviceOrder/updateStatus",
                    data:{
                        srvOrderId:$("#srvOrderId").val(),
                        status:4,
                    },
                    type:"post",
                    dataType:"json",
                    success:function(data){

                            location.href="${ctx}/serviceOrder/"+$("#srvOrderId").val()+"/edit"

                    },
                    error:function(){
                        alert("服务器出错！");
                    }
                })
            }
        })

        $( "#payOrgName" ).autocomplete({
            source:"${ctx}/serviceOrder/orgName/",
            minLength: 1,
            autoFocus:true,
            select: function(e, ui) {
                $( "#payOrgId").val(ui.item.id);
            },
            change:function(e,ui) {
                $( "#orgId").val(ui.item.id);
            }
        });

        $("#search").click(function(){
            $("#success_window").popup();
        })
    });


    function execute(data){
        $("#window").removeAttr("style")
        $("#execute_window").removeAttr("style");
        $("#nodeId").val($(data).closest("tr").attr("id").split("_")[1])
        $("#nodeName").val($(data).closest("tr").children("td").eq(0).text())
        if($(data).closest("tr").children("td").eq(0).text() == "未执行"){
            $(".status").val(1)
        }
        if($(data).closest("tr").children("td").eq(0).text() == "执行中"){
            $(".status").val(2)
        }
        if($(data).closest("tr").children("td").eq(0).text() == "已完成"){
            $(".status").val(3)
        }
        $("#actualDate").val($(data).closest("tr").children("td").eq(7).text())
        $(".srvOrderId").val($("#srvOrderId").val())
    }

    function pay(data){
        $("#window").removeAttr("style")
        $("#pay_window").removeAttr("style");
        $("#payId").val($(data).closest("tr").attr("id").split("_")[1])
        $(".srvOrderId").val($("#srvOrderId").val())
    }


    $("#save_execute").click(function(){
        $("#serviceExecute").submit()
    })

    function Payment(data){
        $.ajax({
            url:"${ctx}/serviceOrder/pay",
            type:"post",
            data:data,
            dataType:"json",
            success:function(e){
                alert(e.msg)
                location.reload();
            }
        })
    }

    $("#save_pay").click(function(){

        if(!$("#payMoneyActually").val()){
            alert("应收/付金额不能为空！");
            return;
        }else{
            if(!isDigit($("#payMoneyActually").val())){
                alert("应收/付金额格式不正确！");
                return;
            }

        }
        Payment($("#SavePay").serialize())
    })

    $("#add_pay").click(function(){
        if(!$("#payOrgId").val()){
            alert("没有找到该公司！")
            return
        }
        if(!$("#payMoney").val()){
            alert("应收/付金额不能为空！");
            return;
        }else{
            if(!isDigit($("#payMoney").val())){
                alert("应收/付金额数字格式不正确！");
                return;
            }
        }
        if(!$("#rate").val()){
            $("#rate").val("0.0");
        }else{
            if(!isDigit($("#rate").val())){
                alert("汇率数字格式不正确！");
                return;
            }
        }
        Payment($("#addPay").serialize())
    })

    function isDigit(s)
    {
        var patrn=/^\d+(\.\d+)?$/;
        if (!patrn.exec(s)) return false
        return true
    }

    $("#add_price").click(function(){
        $("#window").removeAttr("style")
        $("#addPay_window").removeAttr("style");
        $(".srvOrderId").val($("#srvOrderId").val())
    })


    $("#srvOrgName").change(function(){
        $.ajax({
            url:"${ctx}/enterprise/"+$("#srvOrgName").val()+"/dept",
            data:$("#srvOrgName").val(),
            type:"get",
            dataType:"json",
            success:function(data){
                $("#roleName option").remove()
                $("#userName option").remove()
                $("<option/>").val("").text("-请选择-").appendTo($("#userName"));
                $("<option/>").val("").text("-请选择-").appendTo($("#roleName"));
                data.boList.forEach(function(d){
                    $("<option/>").val(d.userId).text(d.userNameCn).appendTo($("#userName"));
                })
                data.deptList.forEach(function(d){
                    console.log(d)
                    $("<option/>").val(d.id).text(d.deptName).appendTo($("#roleName"));
                })
            }
        })

    })

    function closeWindow(data){
        $("#"+data).attr("style","display:none")
        $("#window").attr("style","display:none");
    }

    //选择关联订单
    $("#selTradeOrder").change(function(){
        $.ajax({
            url:"${ctx}/serviceOrder/getorder/"+$("#selTradeOrder").val(),
            type:"get",
            success:function(data){
                $("#orderDetail tr").remove();
                $("#orderDetail").append(data);
            }

        })
    });


    $("#saveService").click(function(){
        if(!$("#finishDate").val()){
            alert("计划时间不能为空")
            return false;
        }
        if(!$("#orgId").val()){
            alert("没有找到该公司")
            return false;
        }
        $.ajax({
            url:"${ctx}/serviceOrder/detil",
            type:"post",
            data:$("#serviceSave").serialize(),
            dataType:"json",
            success:function(e){
                alert(e.msg)
                if(e.result){
                    location.reload();
                }
            }
        })
    })

    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }
</script>
</body>
</html>