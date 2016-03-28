<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/5
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/global/common.jsp" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>交易中心-询盘买家确认</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">交易中心</a>
    </li>
    <li>
        <a href="${ctx}/inquiry/list">询盘回盘管理</a>
    </li>
    <li>
        <a href="${ctx}/inquiry/feedBack?inquiryId=${view.inquiryBo.inquiryId}&feedBackId=${view.inquiryBo.inquiryFeedbackId}&inquiryStatus=${view.inquiryBo.inquiryStatus}&inquiryType=${view.inquiryBo.inquiryType}">确认询盘</a>
    </li>
</nav>
<input type="hidden" id="inquiryFeedbackId" value="${view.inquiryBo.inquiryFeedbackId}">
<input type="hidden" id="status" value="${view.inquiryBo.inquiryStatus}">
<input type="hidden" id="type" value="${view.inquiryBo.inquiryType}">
<input type="hidden" id="inquiry" value="${view.inquiryBo.inquiryId}">

<div class="container-fluid">
    <div class="formtable">
        <div class="formtable-cont">
            <h4 class="header">
                <c:if test="${view.inquiryBo.inquiryStatus == 2}">
                    买方确认询盘
                </c:if>
                <c:if test="${view.inquiryBo.inquiryStatus == 3}">
                    卖方确认询盘
                </c:if>
            </h4>

            <div class="formtable-list">
                <label>询盘信息</label>
                <span class="pull-right label-cont"> 询盘编号：${view.inquiryBo.inquiryCode}</span>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6 mar_t20">
                    <div class="col-sm-3 round-turn">
                        <c:if test="${empty view.inquiryBo.buyerUserPhoto}">
                            <img src="${ctx}/resources/images/pic.jpg" class="img-responsive center-block">
                        </c:if>
                        <img src="${view.inquiryBo.buyerUserPhoto}" class="img-responsive center-block">
                        <p>买方</p>
                    </div>
                    <div class="col-sm-8 label-cont">
                        <c:if test="${empty view.inquiryBo.buyerActingOrgNameRu}">
                            <c:if test="${view.inquiryBo.buyerOrgType ==1}">
                                <p>${view.inquiryBo.buyerOrgNameRu}</p>
                            </c:if>
                        </c:if>
                        <c:if test="${not empty view.inquiryBo.buyerActingOrgNameRu}">
                            <p><span class="label label-primary label-sm">代</span>${view.inquiryBo.buyerActingOrgNameRu}
                            </p>
                        </c:if>
                        <p>${view.inquiryBo.buyerUsernameRu}
                            <a type="button" class="btn btn-success btn-sm"
                               onclick="_chatLogic.openChatWindow(${view.inquiryBo.userId},0)">和我联系</a>
                        </p>
                    </div>
                </div>
                <div class="col-xs-6 mar_t20">
                    <div class="col-sm-3 round-turn">
                        <c:if test="${empty view.inquiryBo.sellerUserPhoto}">
                            <img src="${ctx}/resources/images/pic.jpg" class="img-responsive center-block">
                        </c:if>
                        <img src="${view.inquiryBo.sellerUserPhoto}" class="img-responsive center-block">

                        <p>卖方</p>
                    </div>
                    <div class="col-sm-8 label-cont">
                        <p>
                            <c:if test="${empty view.inquiryBo.sellerActingOrgNameCn}">
                                <c:if test="${view.inquiryBo.sellerOrgType ==1}">
                                    ${view.inquiryBo.sellerOrgNameCn}
                                </c:if>
                            </c:if>
                            <c:if test="${not empty view.inquiryBo.sellerActingOrgNameCn}">
                                <i class="label label-primary label-sm">代</i>${view.inquiryBo.sellerActingOrgNameCn}
                            </c:if>
                            <br><i class="label label-primary label-sm">商铺</i> ${view.inquiryBo.shopsNameCn}</p>

                        <p> ${view.inquiryBo.shopsContactsCn}
                            <a type="button" class="btn btn-success btn-sm"
                               onclick="_chatLogic.openChatWindow(${view.inquiryBo.sellerUserId},0)">和我联系</a>
                        </p>
                    </div>
                </div>
            </div>
            <div class="formtable-cont mar_t20">
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>商品</th>
                        <th>商品属性</th>
                        <th>采购量
                        </th>
                        <th>标准件</th>
                        <th>求购价（${view.inquiryBo.costTypeNameRu}）</th>
                        <th>报价（${view.inquiryBo.costTypeNameRu}）</th>
                        <th>总价（${view.inquiryBo.costTypeNameRu}）</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="inquiryProduct" items="${view.inquiryBo.inquiryProductList}">
                        <c:set var="totalMoney"
                               value="${totalMoney + inquiryProduct.quotedPrice * inquiryProduct.purchareNum}"
                               scope="page"/>
                        <tr>
                            <td>
                                <a target="_black" href="/purchase/sku/detail/${inquiryProduct.skuId}">
                                    <table>
                                        <tr>
                                            <td><img src="${inquiryProduct.skuLogoUrl}" width="70" height="70"
                                                style="margin-right:20px"></td>
                                            <td class="text_l">
                                                    ${inquiryProduct.skuNameCn}
                                                <br>${inquiryProduct.catalogNameCn}>>${inquiryProduct.productNameCn}
                                            </td>
                                        </tr>
                                    </table>
                                </a>
                            </td>
                            <td>
                                <c:forEach items="${inquiryProduct.properties}" var="properties">
                                    ${properties.propertyNameCn}：${properties.propertyValueCn}<br/>
                                </c:forEach>
                            </td>
                            <td>
                                <fmt:formatNumber value="${inquiryProduct.purchareNum}" pattern="#.##"/>${inquiryProduct.unitNameCn}

                            </td>
                            <td>
                                <fmt:formatNumber value=" ${inquiryProduct.standard}" pattern="#.##"/>${inquiryProduct.standardUnitNameCn}
                                /${inquiryProduct.packageTypeNameCn}

                            </td>
                            <td>
                                <fmt:formatNumber value=" ${inquiryProduct.unitPrice}" pattern="#,##0.00"/>

                            </td>
                            <td>
                                <fmt:formatNumber value=" ${inquiryProduct.quotedPrice}" pattern="#,##0.00"/>

                            </td>
                            <td>
                                <fmt:formatNumber value="${inquiryProduct.quotedPrice * inquiryProduct.purchareNum}"
                                                  pattern="#,##0.00"/>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="8" class="text_r"><strong>合计：${view.inquiryBo.costTypeNameRu} <fmt:formatNumber value="${totalMoney}"
                                                                                    pattern="#,##0.00"/></strong>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="formtable-cont">
            <h4 class="header">询盘细节</h4>

            <div class="formtable-list">
                <label class="col-xs-3">询盘有效期</label>

                <div class="col-xs-9 label-cont"><odpf:formatDate style="DATE"
                                                                  date="${view.inquiryBo.effectiveDate}"/></div>
            </div>
            <div class="formtable-list">
                <label class="col-xs-3">提货方式</label>

                <div class="col-xs-9 label-cont">${view.inquiryBo.takeGoodsTypeNameCn}</div>
            </div>
            <div class="formtable-list">
                <label class="col-xs-3">交货地</label>

                <div class="col-xs-9 label-cont">${view.inquiryBo.deliveryAddrNameCn}</div>
            </div>
            <div class="formtable-list">
                <label class="col-xs-3">交货日期</label>

                <div class="col-xs-9 label-cont"><odpf:formatDate style="DATE"
                                                                  date="${view.inquiryBo.deliveryDate}"/>~<odpf:formatDate
                        style="DATE" date="${view.inquiryBo.lastDate}"/></div>
            </div>
            <div class="formtable-list">
                <label class="col-xs-3">支付方式</label>

                <div class="col-xs-9 label-cont">${view.inquiryBo.payTypeNameCn}</div>
            </div>
            <div class="formtable-list">
                <label class="col-xs-3">预付款比例</label>

                <div class="col-xs-9 label-cont">${view.inquiryBo.paywayPercentNameCn}</div>
            </div>
            <div class="formtable-list">
                <label class="col-xs-3">尾款支付限期</label>
                <c:if test="${not empty view.inquiryBo.paywayLastNameCn}">
                    <div class="col-xs-9 label-cont">${view.inquiryBo.paywayLastNameCn}</div>
                </c:if>
                <c:if test="${ empty view.inquiryBo.paywayLastNameCn}">
                    --
                </c:if>
            </div>
            <div class="formtable-list">
                <label class="col-xs-3">附加说明</label>

                <div class="col-xs-9 label-cont">
                    买方：${view.inquiryBo.memo}
                    <br>卖方：${view.inquiryBo.feedbackMemo}
                </div>
            </div>
        </div>
        <c:if test="${view.inquiryBo.inquiryType==1}">
            <c:if test="${view.inquiryBo.inquiryStatus == 2}">
                <c:if test="${empty view.inquiryBo.inquiryAuditStatus}">
                    <form id="actingForm">
                        <div class="formtable-cont">
                            <h4 class="header">申请业务代理企业</h4>

                            <div class="formtable-list">
                                <div class="label-cont select-label">
                                    <c:forEach items="${view.orgBo}" var="orgBo">
                                        <label class="btn btn-default">
                                            <input type="radio" name="actingOrgId"
                                                   value="${orgBo.id}"> ${orgBo.orgNameCn}
                                        </label>
                                    </c:forEach>
                                    <c:if test="${view.inquiryBo.inquiryStatus == 2 && view.inquiryBo.buyerOrgType == 1}">
                                        <label class="btn btn-default">
                                            <input type="radio" name="actingOrgId" value="${view.inquiryBo.orgId}">
                                            使用原企业
                                        </label>
                                        <input type="hidden" id="orgId" value="${view.inquiryBo.orgId}"/>
                                    </c:if>
                                    <c:if test="${view.inquiryBo.inquiryStatus == 3 && view.inquiryBo.sellerOrgType == 1}">
                                        <label class="btn btn-default">
                                            <input type="radio" name="actingOrgId"
                                                   value="${view.inquiryBo.sellerOrgId}"> 使用原企业
                                        </label>
                                        <input type="hidden" id="orgId" value="${view.inquiryBo.sellerOrgId}"/>
                                    </c:if>
                                    <span class="pull-right" style="line-height: 38px;">**申请后需代理企业审批方可生效</span>
                                </div>
                            </div>
                        </div>
                        <div class="text-center">
                            <input type="submit" class="btn btn-primary" value="确认询盘"/>
                            <button onclick="changeStatus()" type="button" class="btn btn-default">拒绝</button>
                        </div>
                    </form>
                </c:if>
                <c:if test="${view.inquiryBo.inquiryAuditStatus ==1}">
                    <div class="text-center">
                        <button type="button" onclick="changeAudit(${view.inquiryBo.inquiryStatus},2)"
                                class="btn btn-primary">代理审批通过
                        </button>
                        <button type="button" onclick="changeAudit(${view.inquiryBo.inquiryStatus},3)"
                                class="btn btn-default">拒绝
                        </button>
                    </div>
                </c:if>
            </c:if>
            <c:if test="${view.inquiryBo.inquiryStatus == 3}">
                <c:if test="${empty view.inquiryBo.feedbackAuditStatus}">
                    <form id="actingForm">
                        <div class="formtable-cont">
                            <h4 class="header">申请业务代理企业</h4>

                            <div class="formtable-list">
                                <div class="label-cont select-label">
                                    <c:forEach items="${view.orgBo}" var="orgBo">
                                        <label class="btn btn-default">
                                            <input type="radio" name="actingOrgId"
                                                   value="${orgBo.id}"> ${orgBo.orgNameCn}
                                        </label>
                                    </c:forEach>
                                    <c:if test="${view.inquiryBo.inquiryStatus == 2 && view.inquiryBo.buyerOrgType == 1}">
                                        <label class="btn btn-default">
                                            <input type="radio" name="actingOrgId" value="${view.inquiryBo.orgId}">
                                            使用原企业
                                        </label>
                                        <input type="hidden" id="orgId" value="${view.inquiryBo.orgId}"/>
                                    </c:if>
                                    <c:if test="${view.inquiryBo.inquiryStatus == 3 && view.inquiryBo.sellerOrgType == 1}">
                                        <label class="btn btn-default">
                                            <input type="radio" name="actingOrgId"
                                                   value="${view.inquiryBo.sellerOrgId}"> 使用原企业
                                        </label>
                                        <input type="hidden" id="orgId" value="${view.inquiryBo.sellerOrgId}"/>
                                    </c:if>
                                    <span class="pull-right" style="line-height: 38px;">**申请后需代理企业审批方可生效</span>
                                </div>
                            </div>
                        </div>
                        <div class="text-center">
                            <input type="submit" class="btn btn-primary" value="确认询盘"/>
                            <button onclick="changeStatus()" type="button" class="btn btn-default">拒绝</button>
                        </div>
                    </form>
                </c:if>
                <c:if test="${view.inquiryBo.feedbackAuditStatus ==1}">
                    <div class="text-center">
                        <button type="button" onclick="changeAudit(${view.inquiryBo.inquiryStatus},2)"
                                class="btn btn-primary">代理审批通过
                        </button>
                        <button type="button" onclick="changeAudit(${view.inquiryBo.inquiryStatus},3)"
                                class="btn btn-default">拒绝
                        </button>
                    </div>
                </c:if>
            </c:if>
        </c:if>
        <c:if test="${view.inquiryBo.inquiryType==2}">
            <c:if test="${view.inquiryBo.feedbackStatus == 2}">
                <c:if test="${empty view.inquiryBo.inquiryAuditStatus}">
                    <form id="actingForm">
                        <div class="formtable-cont">
                            <h4 class="header">申请业务代理企业</h4>

                            <div class="formtable-list">
                                <div class="label-cont select-label">
                                    <c:forEach items="${view.orgBo}" var="orgBo">
                                        <label class="btn btn-default">
                                            <input type="radio" name="actingOrgId"
                                                   value="${orgBo.id}"> ${orgBo.orgNameCn}
                                        </label>
                                    </c:forEach>
                                    <c:if test="${view.inquiryBo.inquiryStatus == 1 && view.inquiryBo.buyerOrgType == 1}">
                                        <label class="btn btn-default">
                                            <input type="radio" name="actingOrgId" value="${view.inquiryBo.orgId}">
                                            使用原企业
                                        </label>
                                        <input type="hidden" id="orgId" value="${view.inquiryBo.orgId}"/>
                                    </c:if>
                                    <c:if test="${view.inquiryBo.inquiryStatus == 3 && view.inquiryBo.sellerOrgType == 1}">
                                        <label class="btn btn-default">
                                            <input type="radio" name="actingOrgId"
                                                   value="${view.inquiryBo.sellerOrgId}"> 使用原企业
                                        </label>
                                        <input type="hidden" id="orgId" value="${view.inquiryBo.sellerOrgId}"/>
                                    </c:if>
                                    <span class="pull-right" style="line-height: 38px;">**申请后需代理企业审批方可生效</span>
                                </div>
                            </div>
                        </div>
                        <div class="text-center">
                            <input type="submit" class="btn btn-primary" value="确认询盘"/>
                            <button onclick="changeStatus()" type="button" class="btn btn-default">拒绝</button>
                        </div>
                    </form>
                </c:if>
                <c:if test="${view.inquiryBo.inquiryAuditStatus ==1}">
                    <div class="text-center">
                        <button type="button" onclick="changeAudit(${view.inquiryBo.inquiryStatus},2)"
                                class="btn btn-primary">代理审批通过
                        </button>
                        <button type="button" onclick="changeAudit(${view.inquiryBo.inquiryStatus},3)"
                                class="btn btn-default">拒绝
                        </button>
                    </div>
                </c:if>
            </c:if>i
            <c:if test="${view.inquiryBo.feedbackStatus == 3}">
                <c:if test="${empty view.inquiryBo.feedbackAuditStatus}">
                    <form id="actingForm">
                        <div class="formtable-cont">
                            <h4 class="header">申请业务代理企业</h4>

                            <div class="formtable-list">
                                <div class="label-cont select-label">
                                    <c:forEach items="${view.orgBo}" var="orgBo">
                                        <label class="btn btn-default">
                                            <input type="radio" name="actingOrgId"
                                                   value="${orgBo.id}"> ${orgBo.orgNameCn}
                                        </label>
                                    </c:forEach>
                                    <c:if test="${view.inquiryBo.inquiryStatus == 1 && view.inquiryBo.buyerOrgType == 1}">
                                        <label class="btn btn-default">
                                            <input type="radio" name="actingOrgId" value="${view.inquiryBo.orgId}">
                                            使用原企业
                                        </label>
                                        <input type="hidden" id="orgId" value="${view.inquiryBo.orgId}"/>
                                    </c:if>
                                    <c:if test="${view.inquiryBo.inquiryStatus == 3 && view.inquiryBo.sellerOrgType == 1}">
                                        <label class="btn btn-default">
                                            <input type="radio" name="actingOrgId"
                                                   value="${view.inquiryBo.sellerOrgId}"> 使用原企业
                                        </label>
                                        <input type="hidden" id="orgId" value="${view.inquiryBo.sellerOrgId}"/>
                                    </c:if>
                                    <span class="pull-right" style="line-height: 38px;">**申请后需代理企业审批方可生效</span>
                                </div>
                            </div>
                        </div>
                        <div class="text-center">
                            <input type="submit" class="btn btn-primary" value="确认询盘"/>
                            <button onclick="changeStatus()" type="button" class="btn btn-default">拒绝</button>
                        </div>
                    </form>
                </c:if>
                <c:if test="${view.inquiryBo.feedbackAuditStatus ==1}">
                    <div class="text-center">
                        <button type="button" onclick="changeAudit(${view.inquiryBo.inquiryStatus},2)"
                                class="btn btn-primary">代理审批通过
                        </button>
                        <button type="button" onclick="changeAudit(${view.inquiryBo.inquiryStatus},3)"
                                class="btn btn-default">拒绝
                        </button>
                    </div>
                </c:if>
            </c:if>
        </c:if>
    </div>

</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/inquiry/new_confirm.js"></script>
</body>
</html>