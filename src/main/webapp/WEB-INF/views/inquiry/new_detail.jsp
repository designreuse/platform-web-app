<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/3
  Time: 16:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>交易中心-询盘查看</title>
    <%@include file="/WEB-INF/common/global/common.jsp" %>
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
        <a href="${ctx}/inquiry/detail?inquiryId=${view.inquiryBo.inquiryId}&inquiryType=${view.inquiryBo.inquiryType}">询盘详情</a>
    </li>
</nav>
<div class="container-fluid">
    <input type="hidden" id="inquiryId" value="${view.inquiryBo.inquiryId}">
    <input type="hidden" id="inquiryType" value="${view.inquiryBo.inquiryType}">
    <input type="hidden" id="feedBackId" value="${view.inquiryBo.inquiryFeedbackId}">

    <div class="formtable">
        <div class="formtable-cont">
            <h4 class="header <c:if test="${view.inquiryBo.inquiryStatus !=4 && view.inquiryBo.inquiryStatus !=5}">header-fl</c:if>">
                询盘详情</h4>
            <c:if test="${view.inquiryBo.inquiryStatus !=4 && view.inquiryBo.inquiryStatus !=5}">
                <a id="changeStatus" class="btn btn-default header-button">取消询盘</a>
            </c:if>
            <div class="clear"></div>
            <div class="formtable-list">
                <label>询盘信息</label>
                <span class="pull-right label-cont">询盘编号：${view.inquiryBo.inquiryCode}</span>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6 mar_t20">
                    <div class="col-sm-3 round-turn">
                        <img src="${view.inquiryBo.buyerUserPhoto}" class="img-responsive center-block">
                        <c:if test="${empty view.inquiryBo.buyerUserPhoto}">
                            <img src="${ctx}/resources/images/pic.jpg" class="img-responsive center-block">
                        </c:if>
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
                <c:if test="${view.inquiryBo.inquiryType ==2}">
                    <c:if test="${not empty view.inquiryBo.inquiryFeedbackId}">
                        <div class="col-xs-6 mar_t20">
                            <div class="col-sm-3 round-turn">
                                <img src="${view.inquiryBo.buyerUserPhoto}" class="img-responsive center-block">
                                <c:if test="${empty view.inquiryBo.buyerUserPhoto}">
                                    <img src="${ctx}/resources/images/pic.jpg" class="img-responsive center-block">
                                </c:if>
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
                                    <br><i
                                        class="label label-primary label-sm">商铺</i> ${view.inquiryBo.shopsNameCn}
                                </p>

                                <p> ${view.inquiryBo.shopsContactsCn}
                                    <a class="btn btn-success btn-sm"
                                       onclick="_chatLogic.openChatWindow(${view.inquiryBo.sellerUserId},0)">和我联系</a>
                                </p>
                            </div>
                        </div>
                    </c:if>
                </c:if>
                <c:if test="${view.inquiryBo.inquiryType ==1}">
                    <div class="col-xs-6 mar_t20">
                        <div class="col-sm-4 buyer woman">
                            <img src="${view.inquiryBo.sellerUserPhoto}" class="img-responsive center-block">

                            <p>卖方</p>
                        </div>
                        <div class="col-sm-8 label-cont">
                            <p>
                                <c:if test="${empty view.inquiryBo.sellerActingOrgNameCn}">
                                    ${view.inquiryBo.sellerOrgNameCn}
                                </c:if>
                                <c:if test="${not empty view.inquiryBo.sellerActingOrgNameCn}">
                                    <span class="label label-primary label-sm">代</span>${view.inquiryBo.sellerActingOrgNameCn}
                                </c:if>
                                <br><span class="label label-primary label-sm">商铺</span> ${view.inquiryBo.shopsNameCn}
                            </p>

                            <p> ${view.inquiryBo.shopsContactsCn}
                                <a class="btn btn-success btn-sm"  onclick="_chatLogic.openChatWindow(${view.inquiryBo.sellerUserId},0)">和我联系</a>
                            </p>
                        </div>
                    </div>
                </c:if>
            </div>
            <div class="formtable-list">

            </div>
            <div class="formtable-cont mar_t20">
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>商品</th>
                        <th>商品属性</th>
                        <th>采购量</th>
                        <th>标准件</th>
                        <th>求购价(${view.inquiryBo.costTypeNameRu})</th>
                        <th>报价(${view.inquiryBo.costTypeNameRu})</th>
                        <th>总价(${view.inquiryBo.costTypeNameRu})</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:if test="${view.inquiryBo.inquiryType ==1}">
                        <c:forEach var="inquiryProduct" items="${view.inquiryBo.inquiryProductList}">
                            <c:choose>
                                <c:when test="${view.inquiryBo.inquiryStatus ==1}">
                                    <c:set var="totalMoney"
                                           value="${totalMoney + inquiryProduct.unitPrice * inquiryProduct.purchareNum}"
                                           scope="page"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="totalMoney"
                                           value="${totalMoney + inquiryProduct.quotedPrice * inquiryProduct.purchareNum}"
                                           scope="page"/>
                                </c:otherwise>
                            </c:choose>

                            <tr>
                                <td><a target="_black" href="/purchase/sku/detail/${inquiryProduct.skuId}">
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
                                    <fmt:formatNumber value="${inquiryProduct.purchareNum}" pattern="0.00"/>${inquiryProduct.unitNameCn}
                                </td>
                                <td>
                                    <fmt:formatNumber value=" ${inquiryProduct.standard}" pattern="0.00"/>${inquiryProduct.standardUnitNameCn}
                                    /${inquiryProduct.packageTypeNameCn}
                                </td>
                                <td>
                                    <fmt:formatNumber value=" ${inquiryProduct.unitPrice}" pattern="#,##0.00"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${view.inquiryBo.inquiryStatus ==1}">
                                            --
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${inquiryProduct.quotedPrice}" pattern="#,##0.00"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${view.inquiryBo.inquiryStatus ==1}">
                                            <fmt:formatNumber
                                                    value="${inquiryProduct.unitPrice * inquiryProduct.purchareNum}"
                                                    pattern="#,##0.00"/>
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber
                                                    value="${inquiryProduct.quotedPrice * inquiryProduct.purchareNum}"
                                                    pattern="#,##0.00"/>
                                        </c:otherwise>
                                    </c:choose>

                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${view.inquiryBo.inquiryType ==2}">
                        <c:forEach var="inquiryProduct" items="${view.inquiryBo.inquiryProductList}">
                            <c:choose>
                                <c:when test="${view.inquiryBo.inquiryStatus ==1}">
                                    <c:set var="totalMoney"
                                           value="${totalMoney + inquiryProduct.unitPrice * inquiryProduct.purchareNum}"
                                           scope="page"/>
                                </c:when>
                                <c:otherwise>
                                    <c:set var="totalMoney"
                                           value="${totalMoney + inquiryProduct.quotedPrice * inquiryProduct.purchareNum}"
                                           scope="page"/>
                                </c:otherwise>
                            </c:choose>
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
                                    <c:choose>
                                        <c:when test="${view.inquiryBo.inquiryStatus !=1}">
                                            <c:forEach items="${inquiryProduct.properties}" var="properties">
                                                ${properties.propertyNameCn}：${properties.propertyValueCn}<br/>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            未指定商品属性
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <fmt:formatNumber value="${inquiryProduct.purchareNum}" pattern="#.##"/>${inquiryProduct.unitNameCn}
                                </td>
                                <td>
                                    <fmt:formatNumber value=" ${inquiryProduct.standard}" pattern="#,##"/>${inquiryProduct.standardUnitNameCn}
                                    /${inquiryProduct.packageTypeNameCn}
                                </td>
                                <td>
                                    <fmt:formatNumber value=" ${inquiryProduct.unitPrice}" pattern="#,##0.00"/>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${view.inquiryBo.inquiryStatus !=1}">
                                            <fmt:formatNumber value=" ${inquiryProduct.quotedPrice}"
                                                              pattern="#,##0.00"/>
                                        </c:when>
                                        <c:otherwise>
                                            --
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${view.inquiryBo.inquiryStatus ==1}">
                                            <fmt:formatNumber
                                                    value="${inquiryProduct.unitPrice * inquiryProduct.purchareNum}"
                                                    pattern="#,##0.00"/>
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber
                                                    value="${inquiryProduct.quotedPrice * inquiryProduct.purchareNum}"
                                                    pattern="#,##0.00"/>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <tr>
                        <td colspan="8" class="text_r"><strong>合计：${view.inquiryBo.costTypeNameRu} <fmt:formatNumber value="${totalMoney}"
                                                                                    pattern="#,##0.00"/> </strong>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="formtable-cont col-md-8" style="padding-left: 0">
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
                    <div class="col-xs-9 label-cont">--</div>
                </c:if>
            </div>
            <div class="formtable-list">
                <label class="col-xs-3">附加说明</label>

                <div class="col-xs-9 label-cont">
                    买方：${view.inquiryBo.memo}
                    <br/>卖方：${view.inquiryBo.feedbackMemo}
                </div>
            </div>
        </div>
        <div class="formtable-cont col-md-4" style="padding-right: 0">
            <h4 class="header">询盘状态</h4>

            <div class="formtable-list enquiry-status">
                <div class="col-xs-2 col-xs-offset-2">
                    <c:if test="${view.inquiryBo.inquiryStatus !=5}">
                     <img src="${ctx}/resources/images/u286.png" alt="">
                    </c:if>
                    <c:if test="${view.inquiryBo.inquiryStatus !=5}">
                        <c:if test="${view.inquiryBo.inquiryStatus ==1}">
                            <span class="proz-blue"></span>
                            <span class="proz-white" style="top:50px"></span>
                            <span class="proz-white" style="top:100px"></span>
                            <span class="proz-white" style="top:150px"></span>
                        </c:if>
                        <c:if test="${view.inquiryBo.inquiryStatus ==2}">
                            <span class="proz-blue"></span>
                            <span class="step" style="top:20px"></span>
                            <span class="proz-blue" style="top:50px"></span>
                            <span class="proz-white" style="top:100px"></span>
                            <span class="proz-white" style="top:150px"></span>
                        </c:if>
                        <c:if test="${view.inquiryBo.inquiryStatus ==3}">
                            <span class="proz-blue"></span>
                            <span class="step" style="top:20px"></span>
                            <span class="proz-blue" style="top:50px"></span>
                            <span class="step" style="top:70px"></span>
                            <span class="proz-blue" style="top:100px"></span>
                            <span class="proz-white" style="top:150px"></span>
                        </c:if>
                        <c:if test="${view.inquiryBo.inquiryStatus == 4}">
                            <span class="proz-blue"></span>
                            <span class="step" style="top:20px"></span>
                            <span class="proz-blue" style="top:50px"></span>
                            <span class="step" style="top:70px"></span>
                            <span class="proz-blue" style="top:100px"></span>
                            <span class="step" style="top:120px"></span>
                            <span class="proz-blue" style="top:150px"></span>
                        </c:if>
                        <c:if test="${view.inquiryBo.inquiryStatus ==6}">
                            <span class="proz-white"></span>
                            <span class="proz-white" style="top:50px"></span>
                            <span class="proz-white" style="top:100px"></span>
                            <span class="proz-white" style="top:150px"></span>
                        </c:if>
                    </c:if>
                </div>
                <div class="col-xs-8 enquiry-status-text">
                    <c:if test="${view.inquiryBo.inquiryStatus !=5}">
                        <p <c:if test="${view.inquiryBo.inquiryStatus ==1}"> class="text-primary" </c:if>>询价中</p>

                        <p <c:if test="${view.inquiryBo.inquiryStatus ==2}"> class="text-primary" </c:if>>
                            待买家确认<c:if test="${not empty view.inquiryBo.inquiryAuditStatusNameCn}">(${view.inquiryBo.inquiryAuditStatusNameCn})</c:if></p>

                        <p <c:if test="${view.inquiryBo.inquiryStatus ==3}"> class="text-primary" </c:if>>
                            待卖家确认<c:if test="${not empty view.inquiryBo.feedbackAuditStatusNameCn}">(${view.inquiryBo.feedbackAuditStatusNameCn})</c:if> </p>

                        <p <c:if test="${view.inquiryBo.inquiryStatus ==4}"> class="text-primary" </c:if>>达成贸易订单</p>
                    </c:if>
                    <c:if test="${view.inquiryBo.inquiryStatus ==5}">
                        <p class="text-primary">已取消</p>
                    </c:if>
                </div>
                <div class="col-xs-12 text-center">
                    <c:choose>
                        <c:when test="${view.inquiryBo.inquiryStatus ==1}">
                            <a href="${ctx}/inquiry/feedBack?inquiryId=${view.inquiryBo.inquiryId}&feedbackId=${view.inquiryBo.inquiryFeedbackId}&inquiryType=${view.inquiryBo.inquiryType}&inquiryStatus=${view.inquiryBo.inquiryStatus}"
                               class="btn btn-primary">回盘</a>
                        </c:when>
                        <c:when test="${view.inquiryBo.inquiryStatus ==2 && view.inquiryBo.inquiryType ==1}">
                            <a href="${ctx}/inquiry/feedBack?inquiryId=${view.inquiryBo.inquiryId}&feedbackId=${view.inquiryBo.inquiryFeedbackId}&inquiryType=${view.inquiryBo.inquiryType}&inquiryStatus=${view.inquiryBo.inquiryStatus}"
                               class="btn btn-primary">
                            <c:choose>
                                <c:when test="${view.inquiryBo.inquiryAuditStatus ==1}">
                                    买家审批</a>
                                </c:when>
                                <c:otherwise>
                                    买家确认</a>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:when test="${view.inquiryBo.inquiryStatus ==3 && view.inquiryBo.inquiryType ==1}">
                            <a href="${ctx}/inquiry/feedBack?inquiryId=${view.inquiryBo.inquiryId}&feedbackId=${view.inquiryBo.inquiryFeedbackId}&inquiryType=${view.inquiryBo.inquiryType}&inquiryStatus=${view.inquiryBo.inquiryStatus}"
                               class="btn btn-primary">
                            <c:choose>
                                <c:when test="${view.inquiryBo.feedbackAuditStatus ==1}">
                                    卖家审批</a>
                                </c:when>
                                <c:otherwise>
                                    卖家确认</a>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:when test="${view.inquiryBo.inquiryStatus ==0}">
                            <a href="#" class="btn btn-primary" onclick="adult(${view.inquiryBo.inquiryId},true)">审核通过</a>
                            <a href="#" class="btn btn-default" onclick="adult(${view.inquiryBo.inquiryId},false)">审核拒绝</a>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </div>
        <c:if test="${view.inquiryBo.inquiryType ==2 && empty view.inquiryBo.inquiryFeedbackId}">
            <div class="formtable-cont col-xs-12 no_pad">
                <h4 class="header">
                    回盘情况
                </h4>

                <div class="formtable-list pad_r10">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th>商铺</th>
                            <th>回盘时间</th>
                            <th>类型</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="feedBack" items="${view.inquiryBo.inquiryFeedbackList}">
                            <tr>
                                <td>${feedBack.shopsNameCn}</td>
                                <td><odpf:formatDate date="${feedBack.createTime}" style="DATE_HOUR"/></td>
                                <td>${feedBack.feedbackTypeNameCn}</td>
                                <td>${feedBack.feedbackStatusNameCn}</td>
                                <td>
                                    <c:if test="${feedBack.feedbackStatus== 2}">
                                        <a href="${ctx}/inquiry/feedBack?inquiryId=${view.inquiryBo.inquiryId}&feedbackId=${feedBack.inquiryFeedbackId}&inquiryType=${view.inquiryBo.inquiryType}&inquiryStatus=${feedBack.feedbackStatus}"
                                           class="btn btn-primary">
                                            <c:choose>
                                                <c:when test="${view.inquiryBo.inquiryAuditStatus ==1}">
                                                    买家审批
                                                </c:when>
                                                <c:otherwise>
                                                    买家确认
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                    </c:if>
                                    <c:if test="${feedBack.feedbackStatus == 3}">
                                        <a href="${ctx}/inquiry/feedBack?inquiryId=${view.inquiryBo.inquiryId}&feedbackId=${feedBack.inquiryFeedbackId}&inquiryType=${view.inquiryBo.inquiryType}&inquiryStatus=${feedBack.feedbackStatus}"
                                           class="btn btn-primary">
                                            <c:choose>
                                                <c:when test="${view.inquiryBo.inquiryAuditStatus ==1}">
                                                    卖家审批
                                                </c:when>
                                                <c:otherwise>
                                                    卖家确认
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                    </c:if>
                                    <c:if test="${feedBack.feedbackStatus == 4}">
                                        <a href="${ctx}/inquiry/detail?inquiryId=${view.inquiryBo.inquiryId}&feedbackId=${feedBack.inquiryFeedbackId}&inquiryType=${view.inquiryBo.inquiryType}&inquiryStatus=${feedBack.feedbackStatus}"
                                           class="btn btn-primary">查看</a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
<script type="text/javascript">
    $(function () {
        $("#changeStatus").click(function () {
            if (confirm("是否确认取消")) {
                $.ajax({
                    url: window.ctx + "/inquiry/changeStatus",
                    dataType: "json",
                    type: "post",
                    data: {
                        inquiryId: $("#inquiryId").val()
                    },
                    success: function (data) {
                        alert(data.msg)
                        location.href = window.ctx + "/inquiry/list"
                    }
                })
            }

        })
    })

    function adult(inquiryId,flag){
        var text = "";
        if(flag){
            text = "是否审核通过"
        }else{
            text = "是否审核拒绝"
        }
        if (confirm(text)) {
            $.ajax({
                url: window.ctx + "/inquiry/adult",
                dataType: "json",
                type: "post",
                data: {
                    inquiryId: $("#inquiryId").val(),
                    flag: flag
                },
                success: function (data) {
                    alert(data.msg);
                    location.reload();
                }
            })
        }
    }
</script>
</html>