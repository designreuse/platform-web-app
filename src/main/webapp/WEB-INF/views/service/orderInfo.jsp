<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-4">贸易合同号：</label>

        <div class="col-sm-8 label-cont">${tradeOrderBo.tradeCode}</div>
    </div>
    <div class="col-xs-6">
        <label class="col-sm-4">合同金额：</label>

        <div class="col-sm-8 label-cont"><fmt:formatNumber value="${tradeOrderBo.cost}"
                                                           pattern="#,##0.00"/>${tradeOrderBo.costTypeNameCn}</div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-4">买方：</label>

        <div class="col-sm-8 label-cont">${tradeOrderBo.buyOrgName}</div>
    </div>
    <div class="col-xs-6">
        <label class="col-sm-4">卖方：</label>

        <div class="col-sm-8 label-cont">${tradeOrderBo.saleOrgName}</div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6"></div>
    <div class="col-xs-6">
        <label class="col-sm-4">卖方商铺：</label>

        <div class="col-sm-8 label-cont">${tradeOrderBo.shopName}</div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-4">买方联系人：</label>

        <div class="col-sm-8 label-cont">${tradeOrderBo.buyUserName}</div>
    </div>
    <div class="col-xs-6">
        <label class="col-sm-4">卖方联系人：</label>

        <div class="col-sm-8 label-cont">${tradeOrderBo.saleUserName}</div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-4">买方联系方式：</label>

        <div class="col-sm-8 label-cont">${tradeOrderBo.buyContact}
        </div>
    </div>
    <div class="col-xs-6">
        <label class="col-sm-4">卖方联系方式：</label>

        <div class="col-sm-8 label-cont">${tradeOrderBo.saleContact}
        </div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-4">交货地：</label>

        <div class="col-sm-8 label-cont">${tradeOrderBo.deliveryAddrNameCn}</div>
    </div>
    <div class="col-xs-6">
        <label class="col-sm-4">提货方式：</label>

        <div class="col-sm-8 label-cont">${tradeOrderBo.takeGoodsTypeNameCn}</div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-4">预计交货日期：</label>

        <div class="col-sm-8 label-cont"><odpf:formatDate style="DATE"
                                                          date="${tradeOrderBo.deliveryDate}"/></div>
    </div>
    <div class="col-xs-6">
        <label class="col-sm-4">最晚交货日期：</label>

        <div class="col-sm-8 label-cont"><odpf:formatDate style="DATE"
                                                          date="${tradeOrderBo.lastDate}"/></div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-4">付款方式：</label>

        <div class="col-sm-8 label-cont">
            <p>
                预付款比例：<c:if test="${empty tradeOrderBo.paywayPercent}"> -- </c:if> ${tradeOrderBo.paywayPercentNameCn}
                <br>尾款支付限期：<c:if test="${empty tradeOrderBo.paywayLast}"> -- </c:if>${tradeOrderBo.paywayLastNameCn}
                <br>支付方式：<c:if test="${empty tradeOrderBo.payType}"> -- </c:if>${tradeOrderBo.payTypeNameCn}
            </p>
        </div>
    </div>
    <div class="col-xs-6">
        <label class="col-sm-4">附加说明：</label>

        <div class="col-sm-8 label-cont">${tradeOrderBo.memo}</div>
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
                <th>单价（${tradeOrderBo.costTypeNameCn}）</th>
                <th>总价（${tradeOrderBo.costTypeNameCn}）</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="sku" items="${tradeOrderBo.tradeOrderProductList}">
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
        <strong class="hei-45 pull-right">合计：<fmt:formatNumber value="${totalMoney}"
                                                               pattern="#,##0.00"/>${tradeOrderBo.costTypeNameCn}</strong>

        <div class="clear"></div>
        <div class="pull-right">
            <c:if test="${tradeOrderBo.orderId ==0 && srvOrderBo.status ==1}">
                <a href="#" class="btn btn-primary" id="updateOrder">编辑贸易订单</a>
            </c:if>
            <c:if test="${tradeOrderBo.orderId!=0}">
                <a href="${ctx}/order/${tradeOrderBo.orderId}/edit"
                   class="btn btn-primary">查看贸易订单详情</a>
            </c:if>
            <c:if test="${srvOrderBo.status ==1}">
                <a href="#" class="btn btn-primary">删除</a>
            </c:if>
        </div>
        <div class="clear"></div>
    </div>
</div>





