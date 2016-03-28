<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/12/7
  Time: 12:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/global/common.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>交易中心-询盘回复</title>
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
        <a href="${ctx}/inquiry/feedBack?inquiryId=${view.inquiryBo.inquiryId}&feedBackId=${view.inquiryBo.inquiryFeedbackId}&inquiryStatus=${view.inquiryBo.inquiryStatus}&inquiryType=${view.inquiryBo.inquiryType}">询盘回复</a>
    </li>
</nav>
<div class="container-fluid">
    <form id="inquiryForm">
        <input type="hidden" id="costType" name="costType" value="${view.inquiryBo.costType}">
        <input type="hidden" id="inquiryId" name="inquiryId" value="${view.inquiryBo.inquiryId}">
        <input type="hidden" id="inquiryType" name="inquiryType" value="${view.inquiryBo.inquiryType}">
        <input type="hidden" id="inquiryFeedbackId" name="inquiryFeedbackId"
               value="${view.inquiryBo.inquiryFeedbackId}">

        <div class="formtable">
            <div class="formtable-cont">
                <h4 class="header">询盘回复</h4>

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
                                <p>${view.inquiryBo.buyerOrgNameRu}</p>
                            </c:if>
                            <c:if test="${not empty view.inquiryBo.buyerActingOrgNameRu}">
                                <p><span
                                        class="label label-primary label-sm">代</span>${view.inquiryBo.buyerActingOrgNameRu}
                                </p>
                            </c:if>
                            <p>${view.inquiryBo.buyerUsernameRu}
                                <a type="button" class="btn btn-success btn-sm"
                                   onclick="_chatLogic.openChatWindow(${view.inquiryBo.userId},0)">和我联系</a>
                            </p>
                        </div>
                    </div>
                    <div class="col-xs-6 mar_t20">
                        <c:if test="${view.inquiryBo.inquiryType == 1}">
                            <div class="col-xs-12">
                                <div class="col-sm-3 round-turn">
                                    <img src="${view.inquiryBo.sellerUserPhoto}" class="img-responsive center-block">
                                    <c:if test="${empty view.inquiryBo.sellerUserPhoto}">
                                        <img src="${ctx}/resources/images/pic.jpg" class="img-responsive center-block">
                                    </c:if>
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
                                        <br><span
                                            class="label label-primary label-sm">商铺</span> ${view.inquiryBo.shopsNameCn}
                                    </p>

                                    <p> ${view.inquiryBo.shopsContactsCn}
                                        <a type="button" class="btn btn-success btn-sm"
                                           onclick="_chatLogic.openChatWindow(${view.inquiryBo.sellerUserId},0)">和我联系</a>
                                    </p>
                                </div>
                            </div>
                            <input type="hidden" name="shopsId" value="${view.inquiryBo.shopsId}"
                        </c:if>
                        <c:if test="${view.inquiryBo.inquiryType == 2}">
                            <div class="col-xs-12">
                                <label class="col-sm-4 formtable-list-require wid-120">目标商铺：</label>

                                <div class="col-sm-8 hide-input">
                                    <input class="form-control" id="shopsName" name="shopsName" placeholder="请输入店铺名称">
                                    <input class="hide" name="shopsId" id="shopsId">
                                </div>
                            </div>
                        </c:if>
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
                        <tbody id="skuTable">
                        <c:forEach var="inquiryProduct" items="${view.inquiryBo.inquiryProductList}"
                                   varStatus="product">
                            <c:set var="totalMoney"
                                   value="${totalMoney + inquiryProduct.unitPrice * inquiryProduct.purchareNum}"
                                   scope="page"/>
                            <tr id="sku_${product.index}" data-purcharenum="${inquiryProduct.purchareNum}"
                                data-productid="${inquiryProduct.id}"
                                data-productfeedbackid="${inquiryProduct.inquiryFeedbackProductId}"
                                data-skuid="${inquiryProduct.skuId}"
                                data-unitprice="${inquiryProduct.unitPrice}">
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
                                <td name="skuProperties">
                                    <c:if test="${view.inquiryBo.inquiryType ==1}">
                                        <c:forEach items="${inquiryProduct.properties}" var="properties">
                                            ${properties.propertyNameCn}：${properties.propertyValueCn}<br/>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${view.inquiryBo.inquiryType ==2}">
                                        <button class="btn btn-primary" type="button" data-toggle="modal"
                                                onclick="findSku(${product.index},${inquiryProduct.productId})"
                                                data-target="#chooseComm">选择现有商品
                                        </button>
                                        <a href="#" class="btn btn-primary addSku">新增商品</a>
                                        <div class="hide-input">
                                            <input class="hide" name="sku">
                                        </div>
                                    </c:if>
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
                                    <input type="text" name="unitPrice" class="form-control wid-100 dis_inb"
                                           onblur="changePrice(this)">
                                </td>
                                <td data-money="${inquiryProduct.unitPrice * inquiryProduct.purchareNum}">
                                    <fmt:formatNumber value="${inquiryProduct.unitPrice * inquiryProduct.purchareNum}"
                                                      pattern="#,##0.00"/>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <strong  class="pull-right hei-45"  id="countMoney" data-costtype="${view.inquiryBo.costTypeNameRu}">合计：${view.inquiryBo.costTypeNameRu} <fmt:formatNumber value="${totalMoney}" pattern="#,##0.00"/></strong>
                    <input type="hidden" id="skuJson" name="skuJson">
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
                        <div class="col-xs-9 label-cont">--</div>
                    </c:if>
                </div>
                <div class="formtable-list">
                    <label class="col-xs-3">附加说明</label>

                    <div class="col-xs-9 label-cont">
                        买方：${view.inquiryBo.memo}
                        <div class="form-inline">
                            回复：
                            <div class="form-group">
                                <input type="text" class="form-control wid-min-400" name="memo">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="text-center">
                <button class="btn btn-primary" id="saveFeedBack">回复</button>
                <button type="button" id="refuse" class="btn btn-default">拒绝</button>
            </div>
        </div>
    </form>
    <div class="modal fade" id="chooseComm" tabindex="-1">
        <div class="modal-dialog">
            <form id="skuForm">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">选择商品</h4>
                    </div>
                    <div class="modal-body">
                        <div class="row" id="skuList" style="padding: 0 8px;">
                        </div>
                    </div>
                    <input type="hidden" id="skuTr">
                    <input type="hidden" id="productId">

                    <div class="modal-footer">
                        <button class="btn btn-primary">选择</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script src="${ctx}/resources/js/inquiry/new_feedBack.js"></script>
</body>
</html>