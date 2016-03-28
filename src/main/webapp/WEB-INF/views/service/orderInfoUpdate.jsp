<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<div class="formtable">
    <form class="formtable-cont no_mar" id="addOrderForm">
        <input type="hidden" name="srvOrderId" value="${tradeOrderBo.srvOrderId}"/>
        <input type="hidden" name="tradeOrderId" value="${tradeOrderBo.tradeOrderId}"/>
        <h4 class="header header-fl">新建/编辑贸易订单</h4>
        <a class="btn btn-default header-button" id="resetEdit">取消</a>
        <input type="button" id="editOrderSave" class="btn btn-primary header-button" value="保存"/>
        <div class="clear"></div>
        <div class="formtable-list">
            <div class="col-xs-6">
                <label class="col-md-4">贸易合同号：</label>

                <div class="col-md-8">
                    <input type="text" class="form-control" name="tradeCode"
                           id="tradeCode" value="${tradeOrderBo.tradeCode}">
                </div>
            </div>
            <div class="col-xs-6">
                <label class="col-md-4">合同金额：</label>

                <div class="col-md-8">
                    <div class="form-inline">
                        <div class="form-group">
                            <input type="text" class="form-control" name="cost"
                                   id="cost" value="${tradeOrderBo.cost}"
                            >
                        </div>
                        ${tradeOrderBo.costTypeNameCn}
                    </div>
                </div>
            </div>
        </div>
        <div class="formtable-list">
            <div class="col-xs-6">
                <label class="col-md-4 formtable-list-require">买方：</label>

                <div class="col-md-8">
                    <input type="text" class="form-control" name="buyOrgName"
                           id="buyOrgName" value="${tradeOrderBo.buyOrgName}"
                    >
                </div>
            </div>
            <div class="col-xs-6">
                <label class="col-md-4 formtable-list-require">卖方：</label>

                <div class="col-md-8">
                    <input type="text" class="form-control" id="saleOrgName"
                           name="saleOrgName" value="${tradeOrderBo.saleOrgName}">
                </div>
            </div>
        </div>
        <div class="formtable-list">
            <div class="col-xs-6">
                <label class="col-md-4 formtable-list-require">买方联系人：</label>

                <div class="col-md-8">
                    <input type="text" class="form-control" id="buyUserName"
                           name="buyUserName" value="${tradeOrderBo.buyUserName}">
                </div>
            </div>
            <div class="col-xs-6">
                <label class="col-md-4 formtable-list-require">卖方联系人：</label>

                <div class="col-md-8">
                    <input type="text" class="form-control" name="saleUserName"
                           id="saleUserName" value="${tradeOrderBo.saleUserName}">
                </div>
            </div>
        </div>
        <div class="formtable-list">
            <div class="col-xs-6">
                <label class="col-md-4 formtable-list-require">买方联系方式：</label>

                <div class="col-md-8">
                    <input type="text" class="form-control" id="buyContact"
                           name="buyContact" value="${tradeOrderBo.buyContact}">
                </div>
            </div>
            <div class="col-xs-6">
                <label class="col-md-4 formtable-list-require">卖方联系方式：</label>

                <div class="col-md-8">
                    <input type="text" class="form-control" id="saleContact"
                           name="saleContact" value="${tradeOrderBo.saleContact}">
                </div>
            </div>
        </div>
        <div class="formtable-list">
            <div class="col-xs-6">
                <label class="col-md-4 formtable-list-require">交货地：</label>

                <div class="col-md-8">
                    <select class="form-control" name="deliveryAddrId">
                        <c:forEach items="${deliveryAddr}" var="deliveryAddr">
                            <option value="${deliveryAddr.constValue}"
                                    <c:if test="${deliveryAddr.constValue == tradeOrderBo.deliveryAddrId}">selected="selected"</c:if>>${deliveryAddr.constName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="col-xs-6">
                <label class="col-md-4 formtable-list-require">提货方式：</label>

                <div class="col-md-8">
                    <select class="form-control" name="takeGoodsType">
                        <option value="1">自提</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="formtable-list">
            <div class="col-xs-6">
                <label class="col-md-4">预计交货日期：</label>

                <div class="col-md-8">
                    <div class="input-group datepicker date auto_width-r mar_l5">
                        <input type="text" class="form-control" readonly
                               style="margin: 0px;" id="deliveryDate"
                               name="deliveryDate"
                               value="<odpf:formatDate style='DATE' date='${tradeOrderBo.deliveryDate}'/>">
                        <i class="input-group-addon"><i
                                class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                </div>
            </div>
            <div class="col-xs-6">
                <label class="col-md-4">最晚交货日期：</label>

                <div class="col-md-8">
                    <div class="input-group datepicker date auto_width-r mar_l5">
                        <input type="text" class="form-control" readonly
                               style="margin: 0px;" name="lastDate" id="lastDate"
                               value="<odpf:formatDate style='DATE' date='${tradeOrderBo.lastDate}'/>">
                        <i class="input-group-addon"><i
                                class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="formtable-list">
            <div class="col-xs-6">
                <label class="col-md-4">附加说明：</label>

                <div class="col-md-8">
                                             <textarea class="form-control" rows="5" id="memo"
                                                       name="memo">${tradeOrderBo.memo}</textarea>
                </div>
            </div>
            <div class="col-xs-6">
                <label class="col-md-4 formtable-list-require">结算币种：</label>

                <div class="col-md-8">
                    <select class="form-control" name="costType" id="costType">
                        <c:forEach items="${costType}" var="costType">
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
                    <button class="btn btn-primary add-comm-info-button" type="button">新增</button>
                </div>
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>商品</th>
                        <th>采购量
                        </th>
                        <th>计量单位</th>
                        <th>标准件</th>
                        <th>包装方式</th>
                        <th>单价（美元）</th>
                        <th>总价（美元）</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="tradeOrderSku">
                    <c:forEach items="${tradeOrderBo.tradeOrderProductList}" var="sku">
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
                            <td data-logourl="${sku.photoUrl}">
                                   ${sku.purchareNum}
                            </td>
                            <td data-unitid="${sku.unit}">${sku.unitNameCn}</td>
                            <td>${sku.standard}</td>
                            <td data-packagetype="${sku.packageType}">${sku.packageNameCn}</td>
                            <td data-costType="${sku.costType}" data-unitprice="${sku.unitPrice}"><fmt:formatNumber value="${sku.unitPrice}" pattern="#,##0.00"/></td>
                            <td><fmt:formatNumber value="${sku.unitPrice * sku.purchareNum}"
                                                  pattern="#,##0.00"/></td>
                            <td>
                                <span class="icon icon-del visible" onclick="delSku(this)"></span>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <div id="addSkuDiv" class="border mar_l5 hidden add-comm-info">
                    <form id="addSkuForm">
                        <div class="form-inline">
                            <div class="form-group">
                                <select class="form-control" id="catalog1"
                                        onchange="loadCs2(this);">
                                    <option value="">请选择</option>
                                    <c:forEach items="${catalogList}" var="catalog">
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
                                    <c:forEach var="type" items="${packageType}">
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
