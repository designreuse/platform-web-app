<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/global/common.jsp" %>
<head>
    <meta charset="UTF-8">
    <title>交易中心-贸易订单编辑</title>
    <script type="text/javascript" src="${ctx}/resources/js/order/new_edit.js"></script>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">交易中心</a>
    </li>
    <li>
        <a href="${ctx}/order/list">贸易订单管理</a>
    </li>
    <li>
        <a href="${ctx}/order/${orderView.orderBo.orderId}/edit">贸易订单编辑</a>
    </li>
</nav>
<div class="container-fluid  datepicker_checktime">
    <input type="hidden" id="orderId" name="orderId" value="${orderView.orderBo.orderId}">
    <div class="formtable">
        <div class="formtable-nav">
            <ul class="list-inline">
                <li><a href="#detail" class="btn btn-primary">基本信息</a></li>
                <li><a href="#orderDetail" class="btn btn-primary">贸易信息</a></li>
                <li><a href="#serviceDetail" class="btn btn-primary">服务信息</a></li>
                <c:if test="${orderView.orderBo.status!=2 && orderView.orderBo.status!=3 }">
                    <c:if test="${orderView.srvOrderList.size()==0 || orderView.srvOrderList.size()==orderView.count}">
                        <li class="pull-right"><a href="#" id="cancel" class="btn btn-default">取消</a></li>
                    </c:if>
                </c:if>
            </ul>
        </div>
        <div id="detail" class="formtable-cont">
            <h4 class="header">基本信息</h4>

            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4">贸易订单编号：</label>

                    <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.orderCode}</div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4">订单状态：</label>

                    <div class="label-cont col-sm-7 col-md-8">
                        ${orderView.orderBo.statusNameCn}
                        <c:if test="${orderView.orderBo.status ==1 || orderView.orderBo.status ==4 || orderView.orderBo.status ==5}"><a
                                id="execute" class="btn btn-primary"
                                style="margin: -10px 15px;">执行</a></c:if>
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4">下单时间：</label>

                    <div class="label-cont col-sm-7 col-md-8"><odpf:formatDate style="DATE_HOUR"
                                                                               date="${orderView.orderBo.createOrderTime}"/></div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4">创建人：</label>

                    <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.createByNameCn}</div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4">创建时间：</label>

                    <div class="label-cont col-sm-7 col-md-8"><odpf:formatDate style="DATE_HOUR"
                                                                               date="${orderView.orderBo.createTime}"/></div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4">修改人：</label>

                    <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.modifyByNameCn}</div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4">更新时间：</label>

                    <div class="label-cont col-sm-7 col-md-8"><odpf:formatDate style="DATE_HOUR"
                                                                               date="${orderView.orderBo.modifyTime}"/></div>
                </div>
            </div>
        </div>
        <div id="orderDetail datepicker_checktime">
            <c:choose>
            <c:when test="${orderView.srvOrderList.size() ==0 && orderView.orderBo.status==1}">
                <form id="orderForm">
                    <input type="hidden" name="skuJson" id="skuJson">
                    <input type="hidden" name="orderId" value="${orderView.orderBo.orderId}">
                    <div class="formtable-cont ">
                        <h4 class="header header-fl">贸易信息</h4>
                        <input type="submit" class="btn btn-primary header-button" id="saveOrder" value="保存">

                        <div class="clear"></div>
                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4  formtable-list-require">预计交货日期：</label>

                                <div class="col-sm-7 col-md-8">
                                    <div class="col-md-5 input-group datepicker date auto_width-r">
                                        <input type="text" class="form-control" name="deliveryDate"
                                               style="margin: 0px;"
                                               value="<odpf:formatDate style='DATE' date='${orderView.orderBo.deliveryDate}'/>">
                                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4  formtable-list-require">最晚交货日期：</label>

                                <div class="col-sm-7 col-md-8">
                                    <div class="col-md-5 input-group datepicker date auto_width-r">
                                        <input type="text" class="form-control" name="lastDate"
                                               style="margin: 0px;"
                                               value="<odpf:formatDate style='DATE' date='${orderView.orderBo.lastDate}'/>">
                                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4  formtable-list-require">买方：</label>

                                <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.buyOrgNameRu}</div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4  formtable-list-require">卖方：</label>

                                <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.saleOrgNameCn}</div>
                            </div>
                        </div>
                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4  formtable-list-require">买方代理企业：</label>

                                <div class="label-cont col-sm-7 col-md-8"><c:if
                                        test="${empty orderView.orderBo.buyActingOrgNameRu}">无</c:if>
                                        ${orderView.orderBo.buyActingOrgNameRu}</div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4  formtable-list-require">卖方代理企业：</label>

                                <div class="label-cont col-sm-7 col-md-8"><c:if
                                        test="${empty orderView.orderBo.saleActingOrgNameCn}">无</c:if>
                                        ${orderView.orderBo.saleActingOrgNameCn}</div>
                            </div>
                        </div>
                        <div class="formtable-list">
                            <div class="col-xs-6"></div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4  formtable-list-require">卖方商铺：</label>

                                <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.shopsNameCn}</div>
                            </div>
                        </div>
                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4  formtable-list-require">买方联系人：</label>

                                <div class="col-sm-7 col-md-8 form-group">
                                    <select class="form-control wid-50p" name="buyUserId">
                                        <c:forEach items="${orderView.buyUserList}" var="userBo">
                                            <option value="${userBo.userId}"
                                                    <c:if test="${userBo.userId == orderView.orderBo.buyUserId}">selected="selected"</c:if>>${userBo.userNameRu}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4  formtable-list-require">卖方联系人：</label>

                                <div class="col-sm-7 col-md-8 form-group">
                                    <select class="form-control wid-50p" name="saleUserId">
                                        <c:forEach items="${orderView.saleUserList}" var="userBo">
                                            <option value="${userBo.userId}"
                                                    <c:if test="${userBo.userId == orderView.orderBo.saleUserId}">selected="selected"</c:if>>${userBo.userNameCn}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4  formtable-list-require">买方联系方式：</label>

                                <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.buyUserEmail}<br/>${orderView.orderBo.buyUserMobile}
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4  formtable-list-require">卖方联系方式：</label>

                                <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.saleUserMobile}<br/>${orderView.orderBo.saleUserEmail}
                                </div>
                            </div>
                        </div>
                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4">买方贸易合同号：</label>

                                <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.buyContractCode}</div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4">卖方贸易合同号：</label>

                                <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.saleContractCode}</div>
                            </div>
                        </div>
                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4">买方合同金额：</label>

                                <div class="label-cont col-sm-7 col-md-8"><fmt:formatNumber
                                        value="${orderView.orderBo.buyContractValue}"
                                        pattern="#,##0.00"/> ${orderView.orderBo.costNameCn}</div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4">卖方合同金额：</label>

                                <div class="label-cont col-sm-7 col-md-8"><fmt:formatNumber
                                        value="${orderView.orderBo.saleContractValue}"
                                        pattern="#,##0.00"/> ${orderView.orderBo.costNameCn}</div>
                            </div>
                        </div>
                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4  formtable-list-require">提货方式：</label>

                                <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.takeGoodsTypeNameCn}</div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4  formtable-list-require">交货地：</label>

                                <div class="col-sm-7 col-md-8 form-group">
                                    <select class="form-control wid-50p" name="deliveryAddrId">
                                        <c:forEach items="${orderView.deliveryAddrList}" var="deliveryAddr">
                                            <option value="${deliveryAddr.constValue}"
                                                    <c:if test="${deliveryAddr.constValue == orderView.orderBo.deliveryAddrId}">selected="selected"</c:if>>${deliveryAddr.constName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4  formtable-list-require">支付方式</label>

                                <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.payTypeNameCn}</div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4  formtable-list-require">预付款比例：</label>

                                <div class="col-sm-7 col-md-8 form-group">
                                    <select class="form-control wid-50p" name="paywayPercent" id="paywayPercent">
                                        <c:forEach items="${orderView.paywayPercent}" var="paywayPercent">
                                            <option value="${paywayPercent.constValue}"
                                                    <c:if test="${paywayPercent.constValue == orderView.orderBo.paywayPercent}">selected="selected"</c:if>>${paywayPercent.constName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="formtable-list" id="finalPayType"
                             <c:if test="${orderView.orderBo.paywayPercent == 3}">style="display: none"</c:if>>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4  formtable-list-require">尾款支付限期：</label>

                                <div class="col-sm-7 col-md-8 form-group">
                                    <select class="form-control wid-70p" name="paywayLast">
                                        <c:forEach items="${orderView.finalPayType}" var="finalPayType">
                                            <option value="${finalPayType.constValue}"
                                                    <c:if test="${finalPayType.constValue == orderView.orderBo.paywayLast}">selected="selected"</c:if>>${finalPayType.constName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="formtable-list">
                            <div class="col-md-12">
                                <label class="col-sm-2">附加说明：</label>

                                <div class="col-sm-10 form-group">
                                    <textarea class="form-control" rows="4" name="memo"
                                              id="memo">${orderView.orderBo.memo}</textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="formtable-cont">
                        <h4 class="header  formtable-list-require">商品信息</h4>
                        <table class="table table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>商品</th>
                                <th>商品属性</th>
                                <th>采购量</th>
                                <th>标准件</th>
                                <th>求购价(${orderView.orderBo.costNameRu})</th>
                                <th>总价(${orderView.orderBo.costNameRu})</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="orderSku">
                            <c:forEach var="sku" items="${orderView.orderBo.orderSkuList}">
                                <c:set var="totalMoney" value="${totalMoney + sku.unitPrice * sku.purchareNum}"
                                       scope="page"/>
                                <tr id="${sku.skuId}">
                                    <td class="text_l" data-skuId="${sku.skuId}" data-productId="${sku.productId}"
                                        data-photoUrl="${sku.photoUrl}">
                                        <a target="_black" href="/purchase/sku/detail/${sku.skuId}">
                                            <img src="${sku.photoUrl}" width="70" height="70"
                                                 style="margin-right:20px">
                                            <p class="dis_inb">${sku.skuNameCn}<br/>${sku.catalogNameCn}»${sku.productNameCn}</p>
                                        </a>
                                    </td>
                                    <td data-productNameCn="${sku.productNameCn}"
                                        data-catalogNameCn="${sku.catalogNameCn}"
                                        data-catalogSecondNameCn="${sku.catalogNameSecondCn}"
                                        data-catalogFirstNameCn="${sku.catalogNameFirstCn}">
                                        <c:forEach items="${sku.orderSkuPropertyList}" var="property">
                                            ${property.propertyNameCn}:${property.propertyValue}<br/>
                                        </c:forEach>
                                    </td>
                                    <td data-unit="${sku.unit}" data-purchareNum="${sku.purchareNum}"
                                        data-costType="${sku.costType}" data-unitNameCn="${sku.unitNameCn}">
                                        <fmt:formatNumber value="${sku.purchareNum}" pattern="#.##"/>${sku.unitNameCn}

                                    </td>
                                    <td data-standard="${sku.standard}"
                                        data-packageType="${sku.packageType}"
                                        data-packagenamecn="${sku.packageNameCn}"><fmt:formatNumber
                                            value="${sku.standard}" pattern="#.##"/>${sku.unitNameCn}
                                        /${sku.packageNameCn}</td>
                                    <td data-unitprice="${sku.unitPrice}"><fmt:formatNumber value="${sku.unitPrice}"
                                                                                            pattern="#,##0.00"/></td>
                                    <td data-money="${sku.unitPrice * sku.purchareNum}"><fmt:formatNumber
                                            value="${sku.unitPrice * sku.purchareNum}"
                                            pattern="#,##0.00"/></td>
                                    <td>
                                        <a data-toggle="modal" data-target="#editOrderSku"
                                           onclick="javascript:editSku(${sku.skuId})">
                                            <div class="icon-edit visible icon"></div>
                                        </a>
                                        <a onclick="javascript:delSku(${sku.skuId})">
                                            <div class="icon-del visible icon"></div>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <strong class="pull-right hei-45" id="count" data-money="${totalMoney}"
                                data-costname="${orderView.orderBo.costNameRu}">合计：${orderView.orderBo.costNameRu}
                            <fmt:formatNumber value="${totalMoney}" pattern="#,##0.00"/> </strong>
                        <input type="hidden" id="hideMoney">
                        <div class="clear"></div>
                    </div>
                </form>
            </c:when>
            <c:otherwise>
            <div class="formtable-cont">
                <h4 class="header">贸易信息</h4>

                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4  formtable-list-require">预计交货日期：</label>

                        <div class="col-sm-7 col-md-8 label-cont">
                            <odpf:formatDate style='DATE' date='${orderView.orderBo.deliveryDate}'/>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4  formtable-list-require">最晚交货日期：</label>

                        <div class="col-sm-7 col-md-8 label-cont">
                            <odpf:formatDate style='DATE' date='${orderView.orderBo.lastDate}'/>
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4  formtable-list-require">买方：</label>

                        <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.buyOrgNameRu}</div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4  formtable-list-require">卖方：</label>

                        <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.saleOrgNameCn}</div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4  formtable-list-require">买方代理企业：</label>

                        <div class="label-cont col-sm-7 col-md-8"><c:if
                                test="${empty orderView.orderBo.buyActingOrgNameRu}">无</c:if>
                                ${orderView.orderBo.buyActingOrgNameRu}</div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">卖方代理企业：</label>

                        <div class="label-cont col-sm-7 col-md-8"><c:if
                                test="${empty orderView.orderBo.saleActingOrgNameCn}">无</c:if>
                                ${orderView.orderBo.saleActingOrgNameCn}</div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6"></div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">卖方商铺：</label>

                        <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.shopsNameCn}</div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">买方联系人：</label>

                        <div class="col-sm-7 col-md-8 label-cont">
                                ${orderView.orderBo.buyUserNameRu}
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">卖方联系人：</label>

                        <div class="col-sm-7 col-md-8 label-cont">
                                ${orderView.orderBo.saleUserNameCn}
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">买方联系方式：</label>

                        <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.buyUserEmail}<br/>${orderView.orderBo.buyUserMobile}
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">卖方联系方式：</label>

                        <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.saleUserMobile}<br/>${orderView.orderBo.saleUserEmail}
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">买方贸易合同号：</label>

                        <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.buyContractCode}</div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">卖方贸易合同号：</label>

                        <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.saleContractCode}</div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">买方合同金额：</label>

                        <div class="label-cont col-sm-7 col-md-8"><fmt:formatNumber
                                value="${orderView.orderBo.buyContractValue}"
                                pattern="#,##0.00"/> ${orderView.orderBo.costNameCn}</div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">卖方合同金额：</label>

                        <div class="label-cont col-sm-7 col-md-8"><fmt:formatNumber
                                value="${orderView.orderBo.saleContractValue}"
                                pattern="#,##0.00"/> ${orderView.orderBo.costNameCn}</div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">提货方式：</label>

                        <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.takeGoodsTypeNameCn}</div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">交货地：</label>

                        <div class="col-sm-7 col-md-8 label-cont">
                                ${orderView.orderBo.deliveryAddrNameCn}
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">支付方式：</label>

                        <div class="label-cont col-sm-7 col-md-8">${orderView.orderBo.payTypeNameCn}</div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">预付款比例：</label>

                        <div class="col-sm-7 col-md-8 label-cont">
                                ${orderView.orderBo.paywayPercentNameCn}
                        </div>
                    </div>
                </div>
                <c:if test="${empty orderView.orderBo.paywayLastNameCn}">
                    <div class="formtable-list">
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4 formtable-list-require">尾款支付限期：</label>

                            <div class="col-sm-7 col-md-8 label-cont">
                                    ${orderView.orderBo.paywayLastNameCn}
                            </div>
                        </div>
                    </div>
                </c:if>
                <div class="formtable-list">
                    <div class="col-md-12">
                        <label class="col-sm-2">附加说明：</label>

                        <div class="col-sm-10 label-cont">
                                ${orderView.orderBo.memo}
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="formtable-cont">
            <h4 class="header  formtable-list-require">商品信息</h4>
            <table class="table table-bordered table-hover">
                <thead>
                <tr>
                    <th>商品</th>
                    <th>商品属性</th>
                    <th>采购量</th>
                    <th>标准件</th>
                    <th>求购价(${orderView.orderBo.costNameRu})</th>
                    <th>总价(${orderView.orderBo.costNameRu})</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="sku" items="${orderView.orderBo.orderSkuList}">
                    <c:set var="totalMoney" value="${totalMoney + sku.unitPrice * sku.purchareNum}" scope="page"/>
                    <tr>
                        <td class="text_l">
                            <a target="_black" href="/purchase/sku/detail/${sku.skuId}">
                                <img src="${sku.photoUrl}" width="70" height="70"
                                     style="margin-right:20px">
                                     <p class="dis_inb">${sku.skuNameCn}<br/>${sku.catalogNameCn}»${sku.productNameCn}</p>
                            </a>
                        </td>
                        <td>
                            <c:forEach items="${sku.orderSkuPropertyList}" var="property">
                                ${property.propertyNameCn}:${property.propertyValue}<br/>
                            </c:forEach>
                        </td>
                        <td>
                                ${sku.purchareNum}${sku.unitNameCn}

                        </td>
                        <td>${sku.standard}${sku.unitNameCn}/${sku.packageNameCn}</td>
                        <td><fmt:formatNumber value="${sku.unitPrice}" pattern="#,##0.00"/></td>
                        <td><fmt:formatNumber value="${sku.unitPrice * sku.purchareNum}"
                                              pattern="#,##0.00"/></td>
                        <td>

                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <strong class="pull-right hei-45">合计：${orderView.orderBo.costNameRu}<fmt:formatNumber value="${totalMoney}"
                                                                                                  pattern="#,##0.00"/></strong>

            <div class="clear"></div>
        </div>
        </form>
        </c:otherwise>
        </c:choose>
        <div class="formtable-cont" id="serviceDetail">
            <h4 class="header <c:if test="${orderView.srvOrderList.size()==0 && orderView.orderBo.status ==1 }">header-fl </c:if>">
                服务信息</h4>
            <c:if test="${orderView.srvOrderList.size()==0 && orderView.orderBo.status ==1}">
                <a href="${ctx}/serviceOrder/add?orderId=${orderView.orderBo.orderId}"
                   class="btn btn-primary header-button">申请服务</a>

                <div class="clear"></div>
            </c:if>
            <c:if test="${orderView.srvOrderList.size()>0}">
                <div class="formtable-list">
                    <form class="form-inline">
                        <div class="form-group">
                            <select class="form-control" id="srvOrderList">
                                <c:forEach items="${orderView.srvOrderList}" var="srvOrderList">
                                    <option value="${srvOrderList.srvOrderId}">${srvOrderList.srvOrderCode}</option>
                                </c:forEach>
                            </select>
                            <label>关联 ${fn:length(orderView.srvOrderList)}条服务信息</label>
                        </div>
                    </form>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2">服务订单状态：</label>

                    <div class="label-cont col-sm-10" id="status">${orderView.srvOrderBo.statusNameCn}</div>

                </div>
                <div class="formtable-list">
                    <label class="col-sm-2">服务委托方：</label>

                    <div class="label-cont col-sm-10" id="orgNameCn">
                        <c:if test="${orderView.srvOrderBo.countryType ==1}">
                            ${orderView.srvOrderBo.orgNameCn}
                        </c:if>
                        <c:if test="${orderView.srvOrderBo.countryType ==2}">
                            ${orderView.srvOrderBo.orgNameRu}
                        </c:if>
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2">委托方联系人：</label>

                    <div class="label-cont col-sm-10" id="userNameCn">
                        <c:if test="${orderView.srvOrderBo.countryType ==1}">
                            ${orderView.srvOrderBo.userNameCn}
                        </c:if>
                        <c:if test="${orderView.srvOrderBo.countryType ==2}">
                            ${orderView.srvOrderBo.userNameFirst}
                        </c:if>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">服务供应商：</label>

                        <div class="label-cont col-sm-7 col-md-8">
                                ${orderView.orgBo.orgNameCn}
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">客服：</label>

                        <div class="label-cont col-sm-7 col-md-8"
                             id="customNameCn">
                                ${orderView.srvOrderBo.customNameCn}
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2">委托服务：</label>

                    <div class="label-cont col-sm-10" id="serviceName">${orderView.srvOrderBo.srvNameCn}</div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2">下单时间：</label>

                    <div class="label-cont col-sm-10" id="createTime"><odpf:formatDate style="DATE_HOUR"
                                                                                       date="${orderView.srvOrderBo.createTime}"/></div>
                </div>
                <div class="formtable-list">
                    <div class="col-md-12 text_c" style="margin:10px 0">
                        <a id="srvOrderDtl"
                           href="${ctx}/serviceOrder/${orderView.srvOrderBo.srvOrderId}/edit">查看服务订单详情</a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

</div>
<div class="modal fade" id="editOrderSku" tabindex="-1">
    <div class="modal-dialog">
        <form id =editSkuForm>
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" id="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">编辑商品</h4>
                </div>
                <div class="modal-body">
                    <div class="formtable">
                        <div class="formtable-cont" style="border-top: solid 1px #cdcdcd">
                            <div class="formtable-list">
                                <label class="col-sm-5 col-md-4 formtable-list-require">商品：</label>
                                <div class="col-xs-6 label-cont" id="orderEditSkuName"></div>
                            </div>
                            <div class="formtable-list">
                                <label class="col-sm-5 col-md-4 formtable-list-require">单价：</label>
                                <div class="col-xs-6">
                                    <div class="col-sm-5 col-md-5 mar_l-15">
                                        <input class="form-control" id="orderEditSkuUnitPrice" name="orderEditSkuUnitPrice">
                                    </div>
                                    <b class="fl_l line_h46" id="orderEditSkuUnitName">
                                    </b>
                                </div>
                            </div>
                            <div class="formtable-list">
                                <label class="col-sm-5 col-md-4 formtable-list-require">采购量：</label>
                                <div class="col-xs-6">
                                    <div class="col-sm-5 col-md-5 mar_l-15">
                                        <input class="form-control" id="orderEditSkuPurchareNum" name="orderEditSkuPurchareNum">
                                    </div>
                                    <b class="fl_l line_h46" id="orderEditPurchareNum">
                                    </b>
                                </div>
                            </div>
                            <div class="formtable-list">
                                <label class="col-sm-5 col-md-4 formtable-list-require">标准件：</label>

                                <div class="col-xs-6">
                                    <div class="col-sm-5 col-md-5 mar_l-15">
                                        <input class="form-control" id="orderEditSkuStandard" name="orderEditSkuStandard">
                                    </div>
                                    <b class="fl_l line_h46" id="orderEditSkuStandardName">
                                    </b>
                                </div>
                            </div>
                            <div class="formtable-list">
                                <label class="col-sm-5 col-md-4 formtable-list-require">包装方式：</label>

                                <div class="col-md-5 form-group">
                                    <select class="form-control" id="orderEditSkuPackageType">
                                        <c:forEach items="${orderView.packageType}" var="constantsBo">
                                            <option>${constantsBo.constName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="hidden" id="orderEditSkuId">
                <div class="modal-footer">
                    <button  class="btn btn-primary" id="saveSku">保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
</div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>

</body>
</html>
