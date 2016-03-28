<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/global/common.jsp" %>
<%@include file="/WEB-INF/common/global/tableCommon.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>交易中心-服务订单查看</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">交易中心</a>
    </li>
    <li>
        <a href="${ctx}/serviceOrder/list">服务订单管理</a>
    </li>
    <li>
        <a href="${ctx}/serviceOrder/${view.srvOrderBo.srvOrderId}/edit">服务订单编辑</a>
    </li>
</nav>
<div class="container-fluid">
    <div class="formtable">
        <div class="formtable-nav">
            <ul class="list-inline">
                <li><a href="#baseInfo" class="btn btn-primary">基本信息</a></li>
                <li><a href="#commInfo" class="btn btn-primary">贸易信息</a></li>
                <li><a href="#servInfo" class="btn btn-primary">服务信息</a></li>
                <li><a href="#perFlo" class="btn btn-primary">执行跟踪</a></li>
                <li class="pull-right">
                    <c:if test="${view.srvOrderBo.status==1}"> <span class="r"><a href="#"
                                                                                  onclick="changeStatus(${view.srvOrderBo.srvOrderId},5)"
                                                                                  class="btn btn-default"
                                                                                  id="srvOrder_stop">取消</a> </span></c:if>
                    <c:if test="${view.srvOrderBo.status==2 || view.srvOrderBo.status==3}"> <a href="#"
                                                                                               onclick="changeStatus(${view.srvOrderBo.srvOrderId},6)"
                                                                                               class="btn btn-default"
                                                                                               id="srvOrder_stops">强制终止</a> </c:if>

                </li>

            </ul>
        </div>
        <div class="formtable-cont">
            <form id="srvOrderForm">
                <input type="hidden" id="srvOrderId" name="srvOrderId" value="${view.srvOrderBo.srvOrderId}">
                <h4 class="header  <c:if test="${view.srvOrderBo.status==1}"> header-fl </c:if>" id="baseInfo">基本信息</h4>
                <c:if test="${view.srvOrderBo.status==1}">
                    <input type="submit" class="btn btn-primary header-button" value="保存"/>

                    <div class="clear"></div>
                </c:if>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">服务订单编号：</label>

                        <div class="col-sm-7 col-md-8 label-cont">${view.srvOrderBo.srvOrderCode}</div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">服务订单状态：</label>

                        <div class="col-sm-7 col-md-8">
                            <c:choose>
                                <c:when test="${view.srvOrderBo.auditStatus ==1}">
                                    <div class="mar_tb5">
                                        待审批 <a onclick="changeAuditStatus(${view.srvOrderBo.srvOrderId},2)"
                                               class="btn btn-primary">审批通过</a><a
                                            onclick="changeAuditStatus(${view.srvOrderBo.srvOrderId},3)"
                                            class="btn btn-primary mar_l5">拒绝</a>
                                    </div>
                                </c:when>
                                <c:when test="${view.srvOrderBo.status ==1}">
                                    <div class="mar_t5">
                                            ${view.srvOrderBo.statusNameCn}
                                        <a href="#" onclick="changeStatus(${view.srvOrderBo.srvOrderId},2)"
                                           class="btn btn-primary">确认</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="mar_t5 label-cont">
                                            ${view.srvOrderBo.statusNameCn}
                                    </div>
                                </c:otherwise>
                            </c:choose>

                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">服务委托方：</label>

                        <div class="col-sm-7 col-md-8 label-cont">
                        <c:if test="${view.srvOrderBo.countryType ==1}">
                            ${view.srvOrderBo.orgNameCn}
                        </c:if>
                        <c:if test="${view.srvOrderBo.countryType ==2}">
                            ${view.srvOrderBo.orgNameRu}
                        </c:if>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">委托方联系人：</label>

                        <div class="col-sm-7 col-md-8 form-group">
                            <select class="form-control wid-50p" id="contacts" name="contacts"
                                    <c:if test="${view.srvOrderBo.status!=1}">disabled </c:if>>
                                <c:forEach items="${view.contacts}" var="contacts">
                                    <option value="${contacts.userId}"
                                            <c:if test="${contacts.userId == view.srvOrderBo.contacts}">selected</c:if>>
                                        <c:if test="${view.srvOrderBo.countryType ==1}"> ${contacts.userNameCn}</c:if><c:if
                                            test="${view.srvOrderBo.countryType ==2}"> ${contacts.userNameRu}</c:if></option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">代理商：</label>

                        <div class="col-sm-7 col-md-8 label-cont">
                                <c:if test="${view.srvOrderBo.countryType ==1}">
                                    <c:choose>
                                        <c:when test="${not empty view.srvOrderBo.actingOrgNameCn}">
                                            ${view.srvOrderBo.actingOrgNameCn}
                                        </c:when>
                                        <c:otherwise>
                                            无
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                                <c:if test="${view.srvOrderBo.countryType ==2}">
                                    <c:choose>
                                        <c:when test="${not empty view.srvOrderBo.actingOrgNameRu}">
                                            ${view.srvOrderBo.actingOrgNameRu}
                                        </c:when>
                                        <c:otherwise>
                                            无
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">下单时间：</label>

                        <div class="col-sm-7 col-md-8 label-cont"><odpf:formatDate style="DATE"
                                                                                   date="${view.srvOrderBo.createTime}"/></div>
                    </div>

                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">服务供应商：</label>

                        <div class="col-sm-7 col-md-8 label-cont">${view.orgBo.orgNameCn}</div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">客服：</label>

                        <div class="col-sm-7 col-md-8 form-group">
                            <select class="form-control wid-50p" id="customService" name="customService"
                                    <c:if test="${view.srvOrderBo.status!=1}">disabled </c:if>>
                                <c:forEach items="${view.customService}" var="customService">
                                    <option value="${customService.userId}"
                                            <c:if test="${customService.userId == view.srvOrderBo.customService}">selected</c:if>>${customService.userNameCn}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">委托服务：</label>
                        <input type="hidden" name="serviceIds" id="serviceIds">

                        <div class="col-sm-7 col-md-8 label-cont select-label">
                            <c:forEach items="${view.serviceBoList}" var="service">
                                <label class="btn btn-default <c:forEach items="${view.srvOrderBo.serviceIdList}" var="serviceId"><c:if test="${serviceId ==service.serviceId}">active</c:if></c:forEach>">
                                    <input type="checkbox" autocomplete="on" name="serviceId"
                                           value="${service.serviceId}"
                                           <c:if test="${view.srvOrderBo.status!=1}">disabled </c:if>
                                    <c:forEach items="${view.srvOrderBo.serviceIdList}" var="serviceId">
                                           <c:if test="${serviceId ==service.serviceId}">checked</c:if>
                                    </c:forEach>> ${service.srvNameCn}
                                </label>
                            </c:forEach>
                        </div>
                    </div>

                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">创建人：</label>

                        <div class="col-sm-7 col-md-8 label-cont">
                            <c:if test="${view.srvOrderBo.countryType ==1}">
                                ${view.srvOrderBo.createNameCn}
                            </c:if>
                            <c:if test="${view.srvOrderBo.countryType ==2}">
                                ${view.srvOrderBo.createNameRu}
                            </c:if>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">修改人：</label>

                        <div class="col-sm-7 col-md-8 label-cont">
                            <c:if test="${view.srvOrderBo.countryType ==1}">
                                ${view.srvOrderBo.modifyNameCn}
                            </c:if>
                            <c:if test="${view.srvOrderBo.countryType ==2}">
                                ${view.srvOrderBo.modifyNameRu}
                            </c:if>
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">创建时间：</label>

                        <div class="col-sm-7 col-md-8 label-cont"><odpf:formatDate style="DATE"
                                                                                   date="${view.srvOrderBo.createTime}"/></div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">更新时间：</label>

                        <div class="col-sm-7 col-md-8 label-cont"><odpf:formatDate style="DATE"
                                                                                   date="${view.srvOrderBo.modifyTime}"/></div>
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2">订单备注：</label>

                    <div class="col-sm-10">
                        <textarea class="form-control" rows="5" name="memo"
                                  <c:if test="${view.srvOrderBo.status!=1}">disabled </c:if>>${view.srvOrderBo.memo}</textarea>
                    </div>
                </div>
            </form>
        </div>
        <div class="formtable-cont">
            <h4 class="header <c:if test="${view.srvOrderBo.status==1}"> header-fl</c:if>" id="commInfo">贸易信息</h4>
            <c:if test="${view.srvOrderBo.status==1}">
                <a id="addTradeOrder" class="btn btn-primary header-button">新建贸易订单</a>
                <a data-toggle="modal" data-target="#correlationOrder" class="btn btn-primary header-button">关联贸易订单</a>
            </c:if>
            <div class="clear"></div>
            <c:if test="${view.tradeOrderBoList.size()>0}">
                <div>
                    <div class="formtable-list">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <select class="form-control wid-250 col-xs-3" id="selTradeOrder">
                                    <c:forEach items="${view.tradeOrderBoList}" var="order">
                                        <option value="${order.tradeOrderId}">${order.tradeCode}</option>
                                    </c:forEach>
                                </select>
                                <label class="col-xs-3 text_l">关联${fn:length(view.tradeOrderBoList)}条贸易信息</label>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${view.tradeOrderBoList.size()>0}">
                <div id="orderDetail">
                    <div class="formtable-list">
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4">贸易合同号：</label>

                            <div class="col-sm-7 col-md-8 label-cont">${view.tradeOrderBo.tradeCode}</div>
                        </div>
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4">合同金额：</label>

                            <div class="col-sm-7 col-md-8 label-cont"><fmt:formatNumber
                                    value="${view.tradeOrderBo.cost}"
                                    pattern="#,##0.00"/><c:if test="${not empty view.tradeOrderBo.cost}">${view.tradeOrderBo.costTypeNameCn}</c:if></div>
                        </div>
                    </div>
                    <div class="formtable-list">
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4">买方：</label>

                            <div class="col-sm-7 col-md-8 label-cont">${view.tradeOrderBo.buyOrgName}</div>
                        </div>
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4">卖方：</label>

                            <div class="col-sm-7 col-md-8 label-cont">${view.tradeOrderBo.saleOrgName}</div>
                        </div>
                    </div>
                    <div class="formtable-list">
                        <div class="col-xs-6"></div>
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4">卖方商铺：</label>

                            <div class="col-sm-7 col-md-8 label-cont">${view.tradeOrderBo.shopName}</div>
                        </div>
                    </div>
                    <div class="formtable-list">
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4">买方联系人：</label>

                            <div class="col-sm-7 col-md-8 label-cont">${view.tradeOrderBo.buyUserName}</div>
                        </div>
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4">卖方联系人：</label>

                            <div class="col-sm-7 col-md-8 label-cont">${view.tradeOrderBo.saleUserName}</div>
                        </div>
                    </div>
                    <div class="formtable-list">
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4">买方联系方式：</label>

                            <div class="col-sm-7 col-md-8 label-cont">${view.tradeOrderBo.buyContact}
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4">卖方联系方式：</label>

                            <div class="col-sm-7 col-md-8 label-cont">${view.tradeOrderBo.saleContact}
                            </div>
                        </div>
                    </div>
                    <div class="formtable-list">
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4">交货地：</label>

                            <div class="col-sm-7 col-md-8 label-cont">${view.tradeOrderBo.deliveryAddrNameCn}</div>
                        </div>
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4">提货方式：</label>

                            <div class="col-sm-7 col-md-8 label-cont">${view.tradeOrderBo.takeGoodsTypeNameCn}</div>
                        </div>
                    </div>
                    <div class="formtable-list">
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4">预计交货日期：</label>

                            <div class="col-sm-7 col-md-8 label-cont"><odpf:formatDate style="DATE"
                                                                                       date="${view.tradeOrderBo.deliveryDate}"/></div>
                        </div>
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4">最晚交货日期：</label>

                            <div class="col-sm-7 col-md-8 label-cont"><odpf:formatDate style="DATE"
                                                                                       date="${view.tradeOrderBo.lastDate}"/></div>
                        </div>
                    </div>
                    <div class="formtable-list">
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4">付款方式：</label>

                            <div class="col-sm-7 col-md-8 label-cont">
                                <p>
                                    预付款比例：<c:if test="${empty view.tradeOrderBo.paywayPercent}">--</c:if>${view.tradeOrderBo.paywayPercentNameCn}
                                    <br>尾款支付限期：<c:if test="${empty view.tradeOrderBo.paywayLast}">--</c:if>${view.tradeOrderBo.paywayLastNameCn}
                                    <br>支付方式：<c:if test="${empty view.tradeOrderBo.payType}">--</c:if>${view.tradeOrderBo.payTypeNameCn}
                                </p>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4">附加说明：</label>

                            <div class="col-sm-7 col-md-8 label-cont">${view.tradeOrderBo.memo}</div>
                        </div>
                    </div>
                    <div class="formtable-list">
                        <label class="col-sm-2">商品信息：</label>

                        <div style="padding: 0 20px 10px 10px">
                            <table class="table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>商品</th>
                                    <th>采购量</th>
                                    <th>计量单位</th>
                                    <th>标准件</th>
                                    <th>包装方式</th>
                                    <th>单价（${view.tradeOrderBo.costTypeNameCn}）</th>
                                    <th>总价（${view.tradeOrderBo.costTypeNameCn}）</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="sku" items="${view.tradeOrderBo.tradeOrderProductList}">
                                    <c:set var="totalMoney"
                                           value="${totalMoney + sku.unitPrice * sku.purchareNum}"
                                           scope="page"/>
                                    <tr>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td><img src="${sku.photoUrl}" width="70" height="70"
                                                             style="margin-right:20px">
                                                    </td>
                                                    <td class="text_l">
                                                        <br>${sku.productName}
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                                ${sku.purchareNum}
                                        </td>
                                        <td>${sku.unitNameCn}</td>
                                        <td>${sku.standard}</td>
                                        <td>${sku.packageNameCn}</td>
                                        <td><fmt:formatNumber value="${sku.unitPrice}" pattern="#,##0.00"/></td>
                                        <td><fmt:formatNumber value="${sku.unitPrice * sku.purchareNum}"
                                                              pattern="#,##0.00"/></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                            <strong class="hei-45 pull-right">合计：${view.tradeOrderBo.costTypeNameRu} <fmt:formatNumber
                                    value="${totalMoney}"
                                    pattern="#,##0.00"/></strong>

                            <div class="clear"></div>
                            <div class="pull-right">
                                <c:if test="${view.srvOrderBo.status==1}">
                                    <a href="#" onclick="delTradeOrder()" class="btn btn-primary">删除</a>
                                </c:if>
                                <c:if test="${view.tradeOrderBo.orderId ==0 && view.srvOrderBo.status ==1}">
                                    <a href="#" id="updateOrder" class="btn btn-primary">编辑贸易订单</a>
                                </c:if>
                                <c:if test="${view.tradeOrderBo.orderId!=0}">
                                    <a href="${ctx}/order/${view.tradeOrderBo.orderId}/edit"
                                       class="btn btn-primary">查看贸易订单详情</a>
                                </c:if>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </div>
                </div>
            </c:if>
            <div class="container-fluid datepicker_checktime" id="addOrder" style="display:none">
                <div class="formtable">
                    <form class="formtable-cont no_mar" id="addOrderForm">
                        <input type="hidden" name="srvOrderId" value="${view.srvOrderBo.srvOrderId}"/>
                        <h4 class="header header-fl">新建/编辑贸易订单</h4>
                        <a class="btn btn-default header-button" id="reset">取消</a>
                        <input type="submit" class="btn btn-primary header-button" value="保存"/>

                        <div class="clear"></div>
                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4 formtable-list-require">贸易合同号：</label>

                                <div class="col-sm-7 col-md-8">
                                    <input type="text" class="form-control" name="tradeCode"
                                           id="tradeCode">
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4">合同金额：</label>

                                <div class="col-sm-7 col-md-8">
                                    <div class="form-inline">
                                        <div class="form-group">
                                            <input type="text" class="form-control" name="cost"
                                                   id="cost"
                                            >
                                        </div>
                                        ${tradeOrderBo.costTypeNameCn}
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4 formtable-list-require">买方：</label>

                                <div class="col-sm-7 col-md-8">
                                    <input type="text" class="form-control" name="buyOrgName"
                                           id="buyOrgName"
                                    >
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4 formtable-list-require">卖方：</label>

                                <div class="col-sm-7 col-md-8">
                                    <input type="text" class="form-control" id="saleOrgName"
                                           name="saleOrgName">
                                </div>
                            </div>
                        </div>
                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4 formtable-list-require">买方联系人：</label>

                                <div class="col-sm-7 col-md-8">
                                    <input type="text" class="form-control" id="buyUserName"
                                           name="buyUserName">
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4 formtable-list-require">卖方联系人：</label>

                                <div class="col-sm-7 col-md-8">
                                    <input type="text" class="form-control" name="saleUserName"
                                           id="saleUserName">
                                </div>
                            </div>
                        </div>
                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4 formtable-list-require">买方联系方式：</label>

                                <div class="col-sm-7 col-md-8">
                                    <input type="text" class="form-control" id="buyContact"
                                           name="buyContact">
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4 formtable-list-require">卖方联系方式：</label>

                                <div class="col-sm-7 col-md-8">
                                    <input type="text" class="form-control" id="saleContact"
                                           name="saleContact">
                                </div>
                            </div>
                        </div>
                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4 formtable-list-require">交货地：</label>

                                <div class="col-sm-7 col-md-8">
                                    <select class="form-control" name="deliveryAddrId">
                                        <c:forEach items="${view.deliveryAddr}" var="deliveryAddr">
                                            <option value="${deliveryAddr.constValue}"
                                                    <c:if test="${deliveryAddr.constValue == tradeOrderBo.deliveryAddrId}">selected="selected"</c:if>>${deliveryAddr.constName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4 formtable-list-require">提货方式：</label>

                                <div class="col-sm-7 col-md-8">
                                    <select class="form-control" name="takeGoodsType">
                                        <option value="1">自提</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4">预计交货日期：</label>

                                <div class="col-sm-7 col-md-8">
                                    <div class="input-group datepicker date auto_width-r mar_l5">
                                        <input type="text" class="form-control" readonly
                                               style="margin: 0px;" id="deliveryDate"
                                               name="deliveryDate">
                                        <i class="input-group-addon"><i
                                                class="glyphicon glyphicon-calendar"></i></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4">最晚交货日期：</label>

                                <div class="col-sm-7 col-md-8">
                                    <div class="input-group datepicker date auto_width-r mar_l5">
                                        <input type="text" class="form-control" readonly
                                               style="margin: 0px;" name="lastDate" id="lastDate">
                                        <i class="input-group-addon"><i
                                                class="glyphicon glyphicon-calendar"></i></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4">附加说明：</label>

                                <div class="col-sm-7 col-md-8">
                                             <textarea class="form-control" rows="5" id="memo"
                                                       name="memo"></textarea>
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4 formtable-list-require">结算币种：</label>

                                <div class="col-sm-7 col-md-8">
                                    <select class="form-control" name="costType" id="costType">
                                        <c:forEach items="${view.costType}" var="costType">
                                            <option data-costname="${costType.constName}"
                                                    value="${costType.constValue}">${costType.constName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <input type="hidden" id="skuJson" name="skuJson">
                    </form>
                    <div class="formtable-cont">
                        <div class="formtable-list">
                            <label class="col-md-2">商品信息：</label>

                            <div class="col-md-10">
                                <div class="text-right mar_t5">
                                    <button class="btn btn-primary add-comm-info-button">新增</button>
                                </div>
                                <table class="table table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <th>商品</th>
                                        <th>采购量
                                        </td>
                                        <th>计量单位</th>
                                        <th>标准件</th>
                                        <th>包装方式</th>
                                        <th>单价</th>
                                        <th>总价</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody id="tradeOrderSku">

                                    </tbody>
                                </table>
                                <div id="addSkuDiv" class="border mar_l5 hidden add-comm-info">
                                    <form id="addSkuForm">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <select class="form-control" id="catalog1"
                                                        onchange="loadCs2(this);">
                                                    <option value="">请选择</option>
                                                    <c:forEach items="${view.catalogList}" var="catalog">
                                                        <option value="${catalog.catalogId}">${catalog.catalogNameCn}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <select class="form-control catalogSelect2" id="catalog2"
                                                        onchange="loadCs3(this);">
                                                    <option value="">请选择</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <select class="form-control catalogSelect3" id="catalog3"
                                                        onchange="loadPro(this);">
                                                    <option value="">请选择</option>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <select class="form-control productSelect" id="productId">
                                                    <option value="">请选择</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <label>采购量：</label>
                                                <input type="text" class="form-control" id="count">
                                                <spam id="countUnit"></spam>
                                            </div>
                                            <div class="form-group">
                                                <label>单价：</label>
                                                <input type="text" class="form-control" placeholder="单价"
                                                       id="price">
                                                <span id="priceUnit"></span>
                                            </div>
                                            <div class="form-group">
                                                <label>包装方式：</label>
                                                <select class="form-control" id="packageType">
                                                    <c:forEach var="type" items="${view.packageType}">
                                                        <option value="${type.constValue}"
                                                                data-packagename="${type.constName}">${type.constName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <label>标准件：</label>
                                                <input type="text" id="stand" class="form-control wid-max-80">
                                                <span id="standUnit"></span>
                                            </div>
                                            <div class="form-group mar_l15">
                                                <button type="button" id="add" class="btn btn-primary">保存</button>
                                                <button type="button" class="btn btn-default del-comm-info-button">取消
                                                </button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="formtable-cont">
                <h4 class="header" id="servInfo">服务信息</h4>
                <c:forEach var="map" items="${view.dtlMap}">
                    <c:if test="${map.key == 'service1'}">
                        <form id="exportTradeForm">
                            <div class="formtable-list formtable-list-header">
                                出口贸易代理
                                <c:if test="${view.srvOrderBo.status==1}"><input type="submit"
                                                                                 class="btn btn-primary header-button save"
                                                                                 value="保存"/> </c:if>
                                <div class="clear"></div>
                            </div>
                            <div class="formtable-list">
                                <div class="col-xs-6">
                                    <label class="col-sm-5 col-md-4 formtable-list-require">服务价格：</label>

                                    <div class="col-sm-7 col-md-8">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <input type="text" class="form-control" name="srvPrice"
                                                       id="exportTradeSrvPrice"
                                                       value='<fmt:formatNumber value="${map.value.srvPrice}" pattern="#.##"/>'
                                                       <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>>
                                                <input type="hidden" value="${map.value.id}" id="exportTradeId">
                                                <input type="hidden" id="exportTradeDtl"
                                                       value="${view.dtlMap['service1dtl']}">
                                                元
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </c:if>
                    <c:if test="${map.key == 'service2'}">
                        <form id="inspectionForm">
                            <div class="formtable-list formtable-list-header">
                                报检代理
                                <c:if test="${view.srvOrderBo.status==1}"><input type="submit"
                                                                                 class="btn btn-primary header-button save"
                                                                                 value="保存"/> </c:if>
                                <div class="clear"></div>
                            </div>
                            <div class="formtable-list">
                                <div class="col-xs-6">
                                    <label class="col-sm-5 col-md-4 formtable-list-require">服务价格：</label>

                                    <div class="col-sm-7 col-md-8">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <input type="text" class="form-control" name="srvPrice"
                                                       id="inspectionSrvPrice"
                                                       value='<fmt:formatNumber value="${map.value.srvPrice}" pattern="#.##"/>'
                                                       <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>>
                                                <input type="hidden" id="inspectionDtl"
                                                       value="${view.dtlMap['service2dtl']}">
                                                <input type="hidden" id="inspectionId" value="${map.value.id}">
                                                元
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </c:if>
                    <c:if test="${map.key == 'service3'}">
                        <form id="applyProxyForm">

                            <div class="formtable-list formtable-list-header">
                                报关代理
                                <c:if test="${view.srvOrderBo.status==1}"><input type="submit"
                                                                                 class="btn btn-primary header-button save"
                                                                                 value="保存"/> </c:if>
                                <div class="clear"></div>
                            </div>
                            <div class="formtable-list">
                                <div class="col-xs-6">
                                    <label class="col-sm-5 col-md-4 formtable-list-require">服务价格：</label>

                                    <div class="col-sm-7 col-md-8">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <input type="text" class="form-control" name="srvPrice"
                                                       id="applyProxySrvPrice"
                                                       value='<fmt:formatNumber value="${map.value.srvPrice}" pattern="#.##"/>'
                                                       <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>>
                                                <input type="hidden" id="applyProxyDtl"
                                                       value="${view.dtlMap['service3dtl']}">
                                                <input type="hidden" id="applyProxyId" value="${map.value.id}">
                                                元
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-6">
                                    <label class="col-sm-5 col-md-4 formtable-list-require">报关行：</label>

                                    <div class="col-sm-7 col-md-8">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <input
                                                        <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                        type="text" class="form-control" id="broker" name="boker"
                                                        value="${view.srvOrderBo.bokerName}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </c:if>
                    <c:if test="${map.key == 'service4'}">
                        <form id="ruClearanceForm">
                            <div class="formtable-list formtable-list-header">
                                俄境清关
                                <c:if test="${view.srvOrderBo.status==1}"><input type="submit"
                                                                                 class="btn btn-primary header-button save"
                                                                                 value="保存"/> </c:if>
                                <div class="clear"></div>
                            </div>
                            <div class="formtable-list">
                                <label class="col-sm-2 formtable-list-require">服务价格：</label>

                                <div class="col-sm-10">
                                    <div class="form-inline">
                                        <div class="form-group">
                                            <input type="text" class="form-control" name="srvPrice"
                                                   id="ruClearanceSrvPrice"
                                                   value='<fmt:formatNumber value="${map.value.srvPrice}" pattern="#.##"/>'
                                                   <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>>
                                            <input type="hidden" id="ruClearanceDtl"
                                                   value="${view.dtlMap['service4dtl']}">
                                            <input type="hidden" id="ruClearanceId" value="${map.value.id}">
                                        </div>
                                        <div class="form-group">
                                            元
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </c:if>
                    <c:if test="${map.key == 'service5'}">
                        <form id="CnTransForm">
                            <input type="hidden" name="srvOrderId" id="CnTransSrvOrderId">
                            <input type="hidden" name="transJson" id="CnTransJson">

                            <div class="formtable-list formtable-list-header">
                                国内运输
                                <c:if test="${view.srvOrderBo.status==1 || view.srvOrderBo.status==2 || view.srvOrderBo.status==3}">
                                    <input type="submit"
                                           class="btn btn-primary header-button"
                                           value="保存"/>
                                </c:if>
                                <div class="clear"></div>
                            </div>
                            <div class="formtable-list datepicker_checktime">
                                <div class="col-sm-12">
                                    <label class="col-md-2 col-xs-3 formtable-list-require">发货地：</label>

                                    <div class="col-md-10 col-xs-9">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <select class="form-control"
                                                        <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                        name="startProvId" id="startProvCn">
                                                    <option value="">--请选择省--</option>
                                                    <c:forEach items="${view.starProvList}" var="prov">
                                                        <option value="${prov.id}"
                                                                <c:if test="${map.value.startProvId==prov.id}">selected</c:if> >
                                                                ${prov.cnname}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <select class="form-control"
                                                        <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                        id="startCityCn" name="startCityId">
                                                    <option value="">--请选择市--</option>
                                                    <c:forEach items="${view.starCityList}" var="city">
                                                        <option value="${city.id}"
                                                                <c:if test="${map.value.startCityId==city.id}">selected</c:if> >
                                                                ${city.cnname}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <select class="form-control"
                                                        <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                        name="startDistId" id="startDistCn">
                                                    <option value="">--请选择区--</option>
                                                    <c:forEach items="${view.starDistList}" var="dist">
                                                        <option value="${dist.id}"
                                                                <c:if test="${map.value.startDistId==dist.id}">selected</c:if> >
                                                                ${dist.cnname}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <input type="text" class="form-control" placeholder="具体地址"
                                                       name="startAddr"
                                                       id="startAddr" value="${map.value.startAddr}"
                                                       <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="col-sm-12">
                                    <label class="col-md-2 col-xs-3 formtable-list-require">目的地：</label>

                                    <div class="col-md-10 col-xs-9">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <select class="form-control"
                                                        <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                        name="endProvId" id="endProvId">
                                                    <option value="">--请选择省--</option>
                                                    <c:forEach items="${view.endProvList}" var="prov">
                                                        <option value="${prov.id}"
                                                                <c:if test="${map.value.endProvId==prov.id}">selected</c:if> >
                                                                ${prov.cnname}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <select class="form-control"
                                                        <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                        name="endCityId" id="endCityId">
                                                    <option value="">--请选择市--</option>
                                                    <c:forEach items="${view.endCityList}" var="city">
                                                        <option value="${city.id}"
                                                                <c:if test="${map.value.endCityId ==city.id}">selected</c:if> >
                                                                ${city.cnname}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <select class="form-control"
                                                        <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                        name="endDistId" id="endDistId">
                                                    <option value="">--请选择区--</option>
                                                    <c:forEach items="${view.endDistList}" var="dist">
                                                        <option value="${dist.id}"
                                                                <c:if test="${map.value.endDistId==dist.id}">selected</c:if> >
                                                                ${dist.cnname}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <input type="text" class="form-control"
                                                       <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                       placeholder="具体地址" name="endAddr" id="endAddr"
                                                       value="${map.value.endAddr}">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <label class="col-md-2 col-xs-3 formtable-list-require">联系人：</label>

                                    <div class="col-md-10 col-xs-9">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <input type="text" class="form-control" placeholder="姓名"
                                                       <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                       id="contactsName" name="contacts" value="${map.value.contacts}">
                                            </div>
                                            <div class="form-group">
                                                <input type="text" class="form-control" placeholder="手机"
                                                       <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                       value="${map.value.contactsTel}" id="contactsTel"
                                                       name="contactsTel">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <label class="col-md-2 col-xs-3 formtable-list-require">车辆信息：</label>

                                    <div class="col-md-10 col-xs-9 car-info-Cn">
                                        <c:choose>
                                            <c:when test="${map.value.transAutoList != null}">

                                                <c:forEach items="${map.value.transAutoList}" var="transAutoList"
                                                           varStatus="status">
                                                    <div class="form-del transCn">
                                                        <div class="form-inline">
                                                            <div class="form-group">
                                                                <select class="form-control"
                                                                        <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                        data-alias="autoType" name="transType">
                                                                    <option value="" selected>选择车型</option>
                                                                    <c:forEach var="carType" items="${view.carType}">
                                                                        <option value="${carType.constValue}"
                                                                                <c:if test="${carType.constValue == transAutoList.autoType}">selected="selected"</c:if>>${carType.constName}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <div class="form-group">
                                                                <select class="form-control"
                                                                        <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                        data-alias="autoSpec" name="transSpec">
                                                                    <option value="" selected>选择载重量</option>
                                                                    <c:forEach var="loadType" items="${view.loadType}">
                                                                        <option value="${loadType.constValue}"
                                                                                <c:if test="${loadType.constValue == transAutoList.autoSpec}">selected="selected"</c:if>>${loadType.constName}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <div class="form-group">
                                                                <select class="form-control"
                                                                        <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                        data-alias="autoVolume" name="transVolume">
                                                                    <option value="" selected>选择规格</option>
                                                                    <c:forEach var="volumeType"
                                                                               items="${view.volumeType}">
                                                                        <option value="${volumeType.constValue}"
                                                                                <c:if test="${volumeType.constValue == transAutoList.autoVolume}">selected="selected"</c:if>>${volumeType.constName}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <div class="form-group">
                                                                <select class="form-control" data-alias="car">
                                                                    <option value="">选择车辆</option>
                                                                    <c:forEach var="car" items="${view.parkCarBoList}">
                                                                        <option value="${car.carLicence}"
                                                                                <c:if test="${car.carLicence == transAutoList.autoLicense}">selected="selected"</c:if>>${car.carLicence}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <div class="form-group">
                                                                <select class="form-control" data-alias="driver">
                                                                    <option data-name="" value="" data-mobile="">选择司机
                                                                    </option>
                                                                    <c:forEach var="driver"
                                                                               items="${view.parkDriverBoList}">
                                                                        <option value="${driver.id}"
                                                                                data-name="${driver.driverName}"
                                                                                data-mobile="${driver.driverMobile}"
                                                                                <c:if test="${driver.driverName == transAutoList.driver}">selected</c:if>>${driver.driverName},${driver.driverMobile}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <c:if test="${status.count !=1 && view.srvOrderBo.status ==1}">
                                                                <a href="javascript:void(0)"
                                                                   class="icon icon-del visible"></a>
                                                            </c:if>
                                                        </div>

                                                    </div>
                                                </c:forEach>
                                                <a href="javascript:void(0)"
                                                   class="icon icon-add"></a>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="form-del">
                                                    <div class="form-inline">
                                                        <div class="form-group">
                                                            <select class="form-control"
                                                                    <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                    data-alias="autoType" name="transType">
                                                                <option value="" selected>选择车型</option>
                                                                <c:forEach var="carType" items="${view.carType}">
                                                                    <option value="${carType.constValue}"
                                                                            <c:if test="${carType.constValue == transAutoList.autoType}">selected="selected"</c:if>>${carType.constName}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="form-group">
                                                            <select class="form-control"
                                                                    <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                    data-alias="autoSpec" name="transSpec">
                                                                <option value="" selected>选择载重量</option>
                                                                <c:forEach var="loadType" items="${view.loadType}">
                                                                    <option value="${loadType.constValue}"
                                                                            <c:if test="${loadType.constValue == transAutoList.autoSpec}">selected="selected"</c:if>>${loadType.constName}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="form-group">
                                                            <select class="form-control"
                                                                    <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                    data-alias="autoVolume" name="transVolume">
                                                                <option value="" selected>选择规格</option>
                                                                <c:forEach var="volumeType" items="${view.volumeType}">
                                                                    <option value="${volumeType.constValue}"
                                                                            <c:if test="${volumeType.constValue == transAutoList.autoVolume}">selected="selected"</c:if>>${volumeType.constName}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="form-group">
                                                            <select class="form-control" data-alias="car">
                                                                <option value="">选择车辆</option>
                                                                <c:forEach var="car" items="${view.parkCarBoList}">
                                                                    <option value="${car.carLicence}">${car.carLicence}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="form-group">
                                                            <select class="form-control" data-alias="driver">
                                                                <option value="" data-name="" data-mobile="">选择司机
                                                                </option>
                                                                <c:forEach var="driver"
                                                                           items="${view.parkDriverBoList}">
                                                                    <option value="${driver.id}"
                                                                            data-name="${driver.driverName}"
                                                                            data-mobile="${driver.driverMobile}">${driver.driverName},${driver.driverMobile}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <a href="javascript:void(0)"
                                                   class="icon icon-add"></a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="col-xs-6">
                                    <label class="col-sm-5 col-md-4 formtable-list-require">预计发货日期：</label>

                                    <div class="col-sm-7 col-md-8">
                                        <div class="col-sm-7 col-md-8 input-group datepicker date mar_l5">
                                            <input type="text" class="form-control" readonly style="margin: 0px;"
                                                   <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                   value="<odpf:formatDate style='DATE' date='${map.value.deliveryDate}'/>"
                                                   id="deliveryDateCn" name="deliveryDate">
                                            <i class="input-group-addon"><i
                                                    class="glyphicon glyphicon-calendar"></i></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-6">
                                    <label class="col-sm-5 col-md-4 formtable-list-require">预计到货日期：</label>

                                    <div class="col-sm-7 col-md-8">
                                        <div class="col-sm-7 col-md-8 input-group datepicker date mar_l5">
                                            <input type="text" class="form-control" readonly style="margin: 0px;"
                                                   <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                   value="<odpf:formatDate style='DATE' date='${map.value.arriveDate}'/>"
                                                   id="arriveDateCn" name="arriveDate">
                                            <i class="input-group-addon"><i
                                                    class="glyphicon glyphicon-calendar"></i></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-6">
                                    <label class="col-sm-5 col-md-4 formtable-list-require">交货方式：</label>

                                    <div class="col-sm-7 col-md-8">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <select class="form-control" name="deliveryType" id="deliveryType"
                                                        <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>>
                                                    <c:forEach items="${view.deliveryType}" var="deliveryType">
                                                        <option value="${deliveryType.constValue}"
                                                                <c:if test="${deliveryType.constValue == map.value.deliveryType}">selected</c:if>>${deliveryType.constName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-6">
                                    <label class="col-sm-5 col-md-4 formtable-list-require">服务价格：</label>

                                    <div class="col-sm-7 col-md-8">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <input type="text" class="form-control" id="transPriceCn"
                                                       name="srvPrice"
                                                       value='<fmt:formatNumber value="${map.value.srvPrice}" pattern="#.##"/>'
                                                       <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>>
                                                <input type="hidden" id="TransDtl" name="srvOrderDtlId"
                                                       value="${view.dtlMap['service5dtl']}">
                                                <input type="hidden" id="CnTransId" name="transId"
                                                       value="${map.value.transId}">
                                                元
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </c:if>
                    <c:if test="${map.key == 'service6'}">
                        <form id="RuTransForm">
                            <input type="hidden" name="srvOrderDtlId" value="${view.dtlMap['service6dtl']}">
                            <input type="hidden" name="transId" id="RuTransId" value="${map.value.transId}">
                            <input type="hidden" name="transJson" id="RuTransJson">
                            <input type="hidden" name="srvOrderId" id="RuTransSrvOrderId">

                            <div class="formtable-list formtable-list-header">
                                俄境运输
                                <c:if test="${view.srvOrderBo.status==1 || view.srvOrderBo.status==2 || view.srvOrderBo.status==3}">

                                    <input type="submit"
                                           class="btn btn-primary header-button"
                                           value="保存"/>
                                </c:if>

                                <div class="clear"></div>
                            </div>
                            <div class="formtable-list datepicker_checktime">
                                <div class="col-sm-12">
                                    <label class="col-md-2 col-xs-3 formtable-list-require">交货地：</label>

                                    <div class="col-md-10 col-xs-9">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <select class="form-control"
                                                        <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                        name="endProvIdRu" id="endProvIdRu">
                                                    <c:forEach items="${view.deliveryAddr}" var="dist">
                                                        <option value="${dist.constValue}"
                                                                <c:if test="${map.value.endProvIdRu == dist.constValue}">selected</c:if> >
                                                                ${dist.constName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group">
                                                <input type="text" class="form-control"
                                                       <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                       placeholder="具体地址" name="endAddrRu" id="endAddrRu"
                                                       value="${map.value.endAddrRu}">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <label class="col-md-2 col-xs-3 formtable-list-require">联系人：</label>

                                    <div class="col-md-10 col-xs-9">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <input type="text" class="form-control" placeholder="姓名"
                                                       <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                       id="contactsNameRu" name="contacts"
                                                       value="${map.value.contacts}">
                                            </div>
                                            <div class="form-group">
                                                <input type="text" class="form-control" placeholder="手机"
                                                       <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                       value="${map.value.contactsTel}" id="contactsTelRu"
                                                       name="contactsTel">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-12">
                                    <label class="col-md-2 col-xs-3 formtable-list-require">车辆信息：</label>

                                    <div class="col-md-10 col-xs-9 car-info-Ru">
                                        <c:choose>
                                            <c:when test="${map.value.transAutoList != null}">

                                                <c:forEach items="${map.value.transAutoList}" var="transAutoList"
                                                           varStatus="status">
                                                    <div class="form-del transCn">
                                                        <div class="form-inline">
                                                            <div class="form-group">
                                                                <select class="form-control"
                                                                        <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                        data-alias="autoType" name="transType">
                                                                    <option value="" selected>选择车型</option>
                                                                    <c:forEach var="carType" items="${view.carType}">
                                                                        <option value="${carType.constValue}"
                                                                                <c:if test="${carType.constValue == transAutoList.autoType}">selected="selected"</c:if>>${carType.constName}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <div class="form-group">
                                                                <select class="form-control"
                                                                        <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                        data-alias="autoSpec" name="transSpec">
                                                                    <option value="" selected>选择载重量</option>
                                                                    <c:forEach var="loadType" items="${view.loadType}">
                                                                        <option value="${loadType.constValue}"
                                                                                <c:if test="${loadType.constValue == transAutoList.autoSpec}">selected="selected"</c:if>>${loadType.constName}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <div class="form-group">
                                                                <select class="form-control"
                                                                        <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                        data-alias="autoVolume" name="transVoluem">
                                                                    <option value="" selected>选择规格</option>
                                                                    <c:forEach var="volumeType"
                                                                               items="${view.volumeType}">
                                                                        <option value="${volumeType.constValue}"
                                                                                <c:if test="${volumeType.constValue == transAutoList.autoVolume}">selected="selected"</c:if>>${volumeType.constName}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <div class="form-group">
                                                                <select class="form-control" data-alias="car">
                                                                    <option value="">选择车辆</option>
                                                                    <c:forEach var="car" items="${view.parkCarBoList}">
                                                                        <option value="${car.carLicence}"
                                                                                <c:if test="${car.carLicence == transAutoList.autoLicense}">selected="selected"</c:if>>${car.carLicence}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <div class="form-group">
                                                                <select class="form-control" data-alias="driver">
                                                                    <option data-name="" value="" data-mobile="">选择司机
                                                                    </option>
                                                                    <c:forEach var="driver"
                                                                               items="${view.parkDriverBoList}">
                                                                        <option value="${driver.id}"
                                                                                data-name="${driver.driverName}"
                                                                                data-mobile="${driver.driverMobile}"
                                                                                <c:if test="${driver.driverName == transAutoList.driver}">selected</c:if>>${driver.driverName},${driver.driverMobile}</option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <c:if test="${status.count !=1 && view.srvOrderBo.status ==1}">
                                                                <a href="javascript:void(0)"
                                                                   class="icon icon-del visible"></a>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                                <a href="javascript:void(0)"
                                                   class="icon icon-add"></a>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="form-del transRu">
                                                    <div class="form-inline">
                                                        <div class="form-group">
                                                            <select class="form-control" name="transType"
                                                                    <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                    data-alias="autoType" size="1" style="width:120px">
                                                                <option value="" selected>选择车型</option>
                                                                <c:forEach var="carType" items="${view.carType}">
                                                                    <option value="${carType.constValue}"
                                                                            <c:if test="${carType.constValue == transAutoList.autoType}">selected="selected"</c:if>>${carType.constName}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="form-group">
                                                            <select class="form-control" name="transSpec"
                                                                    <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                    data-alias="autoSpec" size="1" style="width:120px">
                                                                <option value="" selected>选择载重量</option>
                                                                <c:forEach var="loadType" items="${view.loadType}">
                                                                    <option value="${loadType.constValue}"
                                                                            <c:if test="${loadType.constValue == transAutoList.autoSpec}">selected="selected"</c:if>>${loadType.constName}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="form-group">
                                                            <select class="form-control" name="transVolume"
                                                                    <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                    data-alias="autoVolume" size="1"
                                                                    style="width:120px">
                                                                <option value="" selected>选择规格</option>
                                                                <c:forEach var="volumeType" items="${view.volumeType}">
                                                                    <option value="${volumeType.constValue}"
                                                                            <c:if test="${volumeType.constValue == transAutoList.autoVolume}">selected="selected"</c:if>>${volumeType.constName}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="form-group">
                                                            <select class="form-control" data-alias="car">
                                                                <option value="">选择车辆</option>
                                                                <c:forEach var="car" items="${view.parkCarBoList}">
                                                                    <option value="${car.carLicence}">${car.carLicence}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="form-group">
                                                            <select class="form-control" data-alias="driver">
                                                                <option value="" data-name="" data-mobile="">选择司机
                                                                </option>
                                                                <c:forEach var="driver"
                                                                           items="${view.parkDriverBoList}">
                                                                    <option value="${driver.id}"
                                                                            data-name="${driver.driverName}"
                                                                            data-mobile="${driver.driverMobile}">${driver.driverName},${driver.driverMobile}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                </div>
                                                <a href="javascript:void(0)"
                                                   class="icon icon-add"></a>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="col-xs-6">
                                    <label class="col-sm-5 col-md-4 formtable-list-require">预计发货日期：</label>

                                    <div class="col-sm-7 col-md-8">
                                        <div class="col-sm-7 col-md-8 input-group datepicker date auto_width-r">
                                            <input type="text" class="form-control" readonly style="margin: 0px;"
                                                   <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                   value="<odpf:formatDate style='DATE' date='${map.value.deliveryDate}'/>"
                                                   id="deliveryDateRu" name="deliveryDate">
                                            <i class="input-group-addon"><i
                                                    class="glyphicon glyphicon-calendar"></i></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-6">
                                    <label class="col-sm-5 col-md-4 formtable-list-require">预计到货日期：</label>

                                    <div class="col-sm-7 col-md-8">
                                        <div class="col-sm-7 col-md-8 input-group datepicker date auto_width-r">
                                            <input type="text" class="form-control" readonly style="margin: 0px;"
                                                   <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                   value="<odpf:formatDate style='DATE' date='${map.value.arriveDate}'/>"
                                                   id="arriveDateRu" name="arriveDate">
                                            <i class="input-group-addon"><i
                                                    class="glyphicon glyphicon-calendar"></i></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-6">
                                    <label class="col-sm-5 col-md-4 formtable-list-require">交货方式：</label>

                                    <div class="col-sm-7 col-md-8">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <select class="form-control" name="deliveryType" id="deliveryTypeRu"
                                                        <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>>
                                                    <c:forEach items="${view.deliveryType}" var="deliveryType">
                                                        <option value="${deliveryType.constValue}"
                                                                <c:if test="${deliveryType.constValue == map.value.deliveryType}">selected</c:if>>${deliveryType.constName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xs-6">
                                    <label class="col-sm-5 col-md-4 formtable-list-require">服务价格：</label>

                                    <div class="col-sm-7 col-md-8">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <input type="text" class="form-control" id="transPriceRu"
                                                       name="srvPrice"
                                                       value='<fmt:formatNumber value="${map.value.srvPrice}" pattern="#.##"/>'
                                                       <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>>
                                            </div>
                                            <div class="form-group">
                                                元
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </c:if>
                    <c:if test="${map.key == 'service7'}">
                        <form id="CnStoreForm">
                            <input type="hidden" name="srvOrderDtlId" value="${view.dtlMap['service7dtl']}">
                            <input type="hidden" name="id" id="CnStoreId" value="${map.value.id}">
                            <input type="hidden" name="srvOrderId" id="CnStoreSrvOrderId">
                            <input type="hidden" name="storeJson" id="CnStoreJson">

                            <div class="formtable-list formtable-list-header">
                                国内仓储
                                <c:if test="${view.srvOrderBo.status==1 || view.srvOrderBo.status==2 || view.srvOrderBo.status==3}">
                                    <input type="submit"
                                           class="btn btn-primary header-button"
                                           value="保存"/>
                                </c:if>


                                <div class="clear"></div>
                            </div>
                            <div class="formtable-list datepicker_checktime">
                                <div class="col-sm-12">
                                    <label class="col-md-2 col-xs-3 formtable-list-require">仓储需求：</label>

                                    <div class="col-md-10 col-xs-9 store-info-Cn">
                                        <c:if test="${map.value.storeAutoList != null}">
                                            <c:forEach items="${map.value.storeAutoList}" var="storeAutoList"
                                                       varStatus="status">
                                                <div class="form-del">
                                                    <div class="form-inline ">
                                                        <div class="form-group">
                                                            <select
                                                                    <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                    class="form-control store-type-cn"
                                                                    data-alias="storageType" name="storeType">
                                                                <option value="">仓库类型</option>
                                                                <c:forEach var="storageType"
                                                                           items="${view.storageType}">
                                                                    <option value="${storageType.constValue}"
                                                                            <c:if test="${storageType.constValue == storeAutoList.storageType}">selected="selected"</c:if>>${storageType.constName}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="form-group">
                                                            <input name="storeCapactiy"
                                                                    <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                    data-alias="capacity" type="text" placeholder="面积"
                                                                    value="${storeAutoList.storageSize}"
                                                                    class="form-control">
                                                            平方米
                                                        </div>
                                                        <div class="form-group">
                                                            <input name="storeDays"
                                                                    <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                    data-alias="days" type="text" class="form-control"
                                                                    value="${storeAutoList.days}" placeholder="天数"
                                                            >
                                                            天
                                                        </div>
                                                        <div class="form-group">
                                                            <select class="form-control stock" data-alias="storageId"
                                                                    name="store">
                                                                <option value="" data-alias="">请选择</option>
                                                                <c:if test="${storeAutoList.storageType==1}">
                                                                    <c:forEach var="store" items="${view.storeListCn}">
                                                                        <option
                                                                                <c:if test="${store.id ==  storeAutoList.storageId}">selected</c:if>
                                                                                value="${store.id}"
                                                                                data-alias="">
                                                                                ${store.storageNameCn}</option>
                                                                    </c:forEach>
                                                                </c:if>
                                                                <c:if test="${storeAutoList.storageType==2}">
                                                                    <c:forEach var="store"
                                                                               items="${view.storeListHeatCn}">
                                                                        <option
                                                                                <c:if test="${store.id ==  storeAutoList.storageId}">selected</c:if>
                                                                                value="${store.id}"
                                                                                data-alias="">
                                                                                ${store.storageNameCn}</option>
                                                                    </c:forEach>
                                                                </c:if>
                                                                <c:if test="${storeAutoList.storageType==3}">
                                                                    <c:forEach var="store"
                                                                               items="${view.storeListColdCn}">
                                                                        <option
                                                                                <c:if test="${store.id == storeAutoList.storageId}">selected</c:if>
                                                                                value="${store.id}"
                                                                                data-alias="">
                                                                                ${store.storageNameCn}</option>
                                                                    </c:forEach>
                                                                </c:if>

                                                            </select>
                                                        </div>
                                                        <div class="form-group">
                                                            <c:choose>
                                                                <c:when test="${storeAutoList.storageId ==1 || storeAutoList.storageId ==2}">
                                                                    <select class="form-control"
                                                                            data-alias="storageName">
                                                                        <c:forEach var="stock"
                                                                                   items="${view.stockList}">
                                                                            <option <c:if
                                                                                    test="${stock.warehouseName == storeAutoList.storageSeat}"> selected</c:if>
                                                                                    value="${stock.warehouseName}">${stock.warehouseName}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <input class="form-control" data-alias="storageName"
                                                                           type="text" name="storeName"
                                                                           value="${storeAutoList.storageSeat}"/>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <c:if test="${status.count != 1 }">
                                                            <a href="javascript:void(0)"
                                                               class="icon icon-del visible"></a>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                            <a href="javascript:void(0)"
                                               class="icon icon-add"></a>
                                        </c:if>
                                        <c:if test="${map.value.storeAutoList == null}">
                                            <div class="form-del">
                                                <div class="form-inline">
                                                    <div class="form-group">
                                                        <select name="storeType"
                                                                <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                class="form-control store-type-cn"
                                                                data-alias="storageType">
                                                            <option value="">仓库类型</option>
                                                            <c:forEach var="storageType" items="${view.storageType}">
                                                                <option value="${storageType.constValue}"
                                                                        <c:if test="${storageType.constValue == storeAutoList.storageType}">selected="selected"</c:if>>${storageType.constName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <input name="storeCapactiy"
                                                                <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                data-alias="capacity" type="text" placeholder="面积"
                                                                value="${storeAutoList.storageSize}"
                                                                class="form-control">
                                                        平方米
                                                    </div>
                                                    <div class="form-group">
                                                        <input name="storeDays"
                                                                <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                data-alias="days" type="text" class="form-control"
                                                                value="${storeAutoList.days}" placeholder="天数"
                                                        >
                                                        天
                                                    </div>
                                                    <div class="form-group">
                                                        <select class="form-control stock" data-alias="storageId"
                                                                name="store">
                                                            <option value="" data-alias="">请选择</option>
                                                        </select>
                                                    </div>

                                                </div>
                                            </div>
                                            <a href="javascript:void(0)"
                                               class="icon icon-add"></a>
                                        </c:if>

                                    </div>
                                </div>
                                <div class="col-sm-5 col-md-4">
                                    <label class="col-xs-12 col-md-5 formtable-list-require">预计入库日期：</label>

                                    <div class="col-xs-12 col-md-7">
                                        <div class="input-group datepicker date auto_width-r">
                                            <input type="text" name="storageDate"
                                                   <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                   value="<odpf:formatDate style='DATE' date='${map.value.storageDate}'/>"
                                                   class="form-control" readonly style="margin: 0px;">
                                            <i class="input-group-addon"><i
                                                    class="glyphicon glyphicon-calendar"></i></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-5 col-md-4">
                                    <label class="col-xs-12 col-md-5 formtable-list-require">预计出库日期：</label>

                                    <div class="col-xs-12 col-md-7">
                                        <div class="input-group datepicker date auto_width-r">
                                            <input type="text" name="deliveryDate"
                                                   <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                   value="<odpf:formatDate style='DATE' date='${map.value.deliveryDate}'/>"
                                                   class="form-control" readonly style="margin: 0px;">
                                            <i class="input-group-addon"><i
                                                    class="glyphicon glyphicon-calendar"></i></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-5 col-md-4">
                                    <label class="col-xs-12 col-md-5 formtable-list-require">服务价格：</label>

                                    <div class="col-xs-12 col-md-7">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <input type="text"
                                                       value='<fmt:formatNumber value="${map.value.srvPrice}" pattern="#.##"/>'
                                                       <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                       name="srvPrice" class="form-control wid-100"> 元

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </c:if>
                    <c:if test="${map.key == 'service8'}">
                        <form id="RuStoreForm">
                            <input type="hidden" name="srvOrderDtlId" value="${view.dtlMap['service8dtl']}">
                            <input type="hidden" name="id" id="RuStoreId" value="${map.value.id}">
                            <input type="hidden" name="srvOrderId" id="RuStoreSrvOrderId">
                            <input type="hidden" name="storeJson" id="RuStoreJson">

                            <div class="formtable-list formtable-list-header">
                                俄境仓储
                                <c:if test="${view.srvOrderBo.status==1 || view.srvOrderBo.status==2 || view.srvOrderBo.status==3}">
                                    <input type="submit"
                                           class="btn btn-primary header-button"
                                           value="保存"/>
                                </c:if>
                                <div class="clear"></div>
                            </div>
                            <div class="formtable-list datepicker_checktime">
                                <div class="col-sm-12">
                                    <label class="col-md-2 col-xs-3 formtable-list-require">仓储需求：</label>

                                    <div class="col-md-10 col-xs-9 store-info-Ru">
                                        <c:if test="${map.value.storeAutoList != null}">
                                            <c:forEach items="${map.value.storeAutoList}" var="storeAutoList"
                                                       varStatus="status">
                                                <div class=" form-del">
                                                    <div class="form-inline">
                                                        <div class="form-group">
                                                            <select name="storeType"
                                                                    <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                    class="form-control store-type-ru"
                                                                    data-alias="storageType">
                                                                <option value="">仓库类型</option>
                                                                <c:forEach var="storageType"
                                                                           items="${view.storageType}">
                                                                    <option value="${storageType.constValue}"
                                                                            <c:if test="${storageType.constValue == storeAutoList.storageType}">selected="selected"</c:if>>${storageType.constName}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div class="form-group">
                                                            <input name="storeCapactiy"
                                                                    <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                    data-alias="capacity" type="text" placeholder="面积"
                                                                    value="${storeAutoList.storageSize}"
                                                                    class="form-control">
                                                            平方米
                                                        </div>
                                                        <div class="form-group">
                                                            <input name="storeDays"
                                                                    <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                    data-alias="days" type="text" class="form-control"
                                                                    value="${storeAutoList.days}" placeholder="天数"
                                                            >
                                                            天
                                                        </div>
                                                        <div class="form-group">
                                                            <select class="form-control stock" data-alias="storageId"
                                                                    name="store">
                                                                <option value="" data-alias="">请选择</option>
                                                                <c:if test="${storeAutoList.storageType==1}">
                                                                    <c:forEach var="store" items="${view.storeListRu}">
                                                                        <option
                                                                                <c:if test="${store.id ==  storeAutoList.storageId}">selected</c:if>
                                                                                value="${store.id}"
                                                                                data-alias="">
                                                                                ${store.storageNameCn}</option>
                                                                    </c:forEach>
                                                                </c:if>
                                                                <c:if test="${storeAutoList.storageType==2}">
                                                                    <c:forEach var="store"
                                                                               items="${view.storeListHeatRu}">
                                                                        <option
                                                                                <c:if test="${store.id ==  storeAutoList.storageId}">selected</c:if>
                                                                                value="${store.id}"
                                                                                data-alias="">
                                                                                ${store.storageNameCn}</option>
                                                                    </c:forEach>
                                                                </c:if>
                                                                <c:if test="${storeAutoList.storageType==3}">
                                                                    <c:forEach var="store"
                                                                               items="${view.storeListColdRu}">
                                                                        <option
                                                                                <c:if test="${store.id ==  storeAutoList.storageId}">selected</c:if>
                                                                                value="${store.id}"
                                                                                data-alias="">
                                                                                ${store.storageNameCn}</option>
                                                                    </c:forEach>
                                                                </c:if>
                                                            </select>
                                                        </div>
                                                        <div class="form-group">
                                                            <c:choose>
                                                                <c:when test="${storeAutoList.storageId ==1 || storeAutoList.storageId ==1}">
                                                                    <select class="form-control"
                                                                            data-alias="storageName">
                                                                        <c:forEach var="stock"
                                                                                   items="${view.stockList}">
                                                                            <option <c:if
                                                                                    test="${stock.warehouseName == storeAutoList.storageSeat}"> selected</c:if>
                                                                                    value="${stock.warehouseName}">${stock.warehouseName}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </c:when>
                                                                <c:when test="${empty storeAutoList.storageId}">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <input class="form-control" data-alias="storageName"
                                                                           type="text" name="storeName"
                                                                           value="${storeAutoList.storageSeat}"/>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                        <c:if test="${status.count != 1 }">
                                                            <a href="javascript:void(0)"
                                                               class="icon icon-del visible"></a>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                            <a href="javascript:void(0)"
                                               class="icon icon-add"></a>
                                        </c:if>
                                        <c:if test="${map.value.storeAutoList == null}">
                                            <div class=" form-del">
                                                <div class="form-inline">
                                                    <div class="form-group">
                                                        <select name="storeType"
                                                                <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                class="form-control store-type-ru"
                                                                data-alias="storageType">
                                                            <option value="">仓库类型</option>
                                                            <c:forEach var="storageType" items="${view.storageType}">
                                                                <option value="${storageType.constValue}"
                                                                        <c:if test="${storageType.constValue == storeAutoList.storageType}">selected="selected"</c:if>>${storageType.constName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <input name="storeCapactiy"
                                                                <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                data-alias="capacity" type="text" placeholder="面积"
                                                                value="${storeAutoList.storageSize}"
                                                                class="form-control">
                                                        平方米
                                                    </div>
                                                    <div class="form-group">
                                                        <input name="storeDays"
                                                                <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                                data-alias="days" type="text" class="form-control"
                                                                value="${storeAutoList.days}" placeholder="天数"
                                                        >
                                                        天
                                                    </div>
                                                    <div class="form-group">
                                                        <select class="form-control stock" data-alias="storageId"
                                                                name="store">
                                                            <option value="" data-alias="">请选择</option>
                                                        </select>
                                                        </select>
                                                    </div>

                                                </div>
                                            </div>
                                            <a href="javascript:void(0)"
                                               class="icon icon-add"></a>
                                        </c:if>

                                    </div>
                                </div>
                                <div class="col-sm-5 col-md-4">
                                    <label class="col-xs-12 col-md-5 formtable-list-require">预计入库日期：</label>

                                    <div class="col-xs-12 col-md-7">
                                        <div class="input-group datepicker date mar_l5">
                                            <input type="text" name="storageDate"
                                                   <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                   value="<odpf:formatDate style='DATE' date='${map.value.storageDate}'/>"
                                                   class="form-control" readonly style="margin: 0px;">
                                            <i class="input-group-addon"><i
                                                    class="glyphicon glyphicon-calendar"></i></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-5 col-md-4">
                                    <label class="col-xs-12 col-md-5 formtable-list-require">预计出库日期：</label>

                                    <div class="col-xs-12 col-md-7">
                                        <div class="input-group datepicker date mar_l5">
                                            <input type="text" name="deliveryDate"
                                                   <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                   value="<odpf:formatDate style='DATE' date='${map.value.deliveryDate}'/>"
                                                   class="form-control" readonly style="margin: 0px;">
                                            <i class="input-group-addon"><i
                                                    class="glyphicon glyphicon-calendar"></i></i>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-5 col-md-4">
                                    <label class="col-xs-12 col-md-5 formtable-list-require">服务价格：</label>

                                    <div class="col-xs-12 col-md-7">
                                        <div class="form-inline">
                                            <div class="form-group">
                                                <input type="text"
                                                       value='<fmt:formatNumber value="${map.value.srvPrice}" pattern="#.##"/>'
                                                       <c:if test="${view.srvOrderBo.status !=1}">disabled</c:if>
                                                       name="srvPrice" class="form-control wid-100">
                                            </div>
                                            <div class="form-group">
                                                元
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </c:if>
                </c:forEach>
            </div>
            <div class="formtable-cont" id="perFlo">
                <h4 class="header <c:if test="${view.srvOrderBo.status==2 || view.srvOrderBo.status==3}"> header-fl </c:if>">
                    执行跟踪</h4>
                <c:if test="${view.srvOrderBo.status==2 || view.srvOrderBo.status==3}">
                    <a href="${ctx}/serviceOrder/${view.srvOrderBo.srvOrderId}/execute"
                       class="btn btn-primary header-button">执行</a>
                </c:if>
            </div>

            <div id="queryContent" class="formtable-cont">
                <table id="easyUi_table">

                </table>
            </div>
            <div id="queryPage" class="easyui-panel">
                <div id="page"></div>
            </div>

        </div>
    </div>
    <div class="modal fade" id="correlationOrder" tabindex="-1">
        <div class="modal-dialog">
            <form id="correlationOrderForm">
                <input type="hidden" name="repeatOrder" id="repeatOrder">

                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">关联贸易订单</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row modal-row">
                            <label class="col-xs-4 formtable-list-require">贸易订单编号：</label>

                            <div class="col-xs-6">
                                <input class="form-control" id="orderCode" type="text">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <input type="submit" class="btn btn-primary" id="saveOrder" data-dismiss="modal" value="保存"/>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="modal fade" id="checkAtta" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">查看附件</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row" id="attaRow">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="fl-window">
    <div class="col-xs-12">
        <a href="${ctx}/bill/viewEditBySrvId/${view.srvOrderBo.srvOrderId}" class="pull-right">
            <span class="hover-text">结算</span> <span class="glyphicon glyphicon-yen"></span>
        </a>
    </div>
    <div class="col-xs-12">
        <a href="#" data-toggle="modal" data-target="#wh" class="pull-right">
            <span class="hover-text">仓储</span> <span class="glyphicon glyphicon-home"></span>
        </a>
    </div>
</div>
<div class="modal fade" id="wh" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">选择出入库类型</h4>
            </div>
            <div class="modal-body text-center">
                <a href="${ctx}/stock/add?type=in&srvOrderId=${view.srvOrderBo.srvOrderId}&srvOrderCode=${view.srvOrderBo.srvOrderCode}"
                   class="btn btn-primary btn-lg">入库</a>
                <a href="${ctx}/stock/add?type=out&srvOrderId=${view.srvOrderBo.srvOrderId}&srvOrderCode=${view.srvOrderBo.srvOrderCode}"
                   class="btn btn-default btn-lg">出库</a>
            </div>
            <div class="modal-footer">
                <a href="${ctx}/store/list">查看所有仓库</a>
                <a href="${ctx}/stock/list">查看库存明细</a>
            </div>
        </div>
    </div>
</div>
<script src="${ctx}/resources/js/serviceorder/new_edit.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>