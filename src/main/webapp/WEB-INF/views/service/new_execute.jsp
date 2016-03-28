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
        <a href="${ctx}/serviceOrder/${view.srvOrderBo.srvOrderId}/execute">服务订单执行</a>
    </li>
</nav>
<div class="container-fluid">
    <div class="formtable">
        <div class="formtable-nav">
            <ul class="list-inline">
                <li><a href="#baseInfo" class="btn btn-primary">基本信息</a></li>
                <li><a href="#commInfo" class="btn btn-primary">贸易信息</a></li>
                <li><a href="#perFlo" class="btn btn-primary">执行跟踪</a></li>
            </ul>
        </div>
        <div class="formtable-cont">
            <form id="srvOrderForm">
                <input type="hidden" id="srvOrderId" name="srvOrderId" value="${view.srvOrderBo.srvOrderId}">
                <h4 class="header" id="baseInfo">基本信息</h4>

                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-4">服务订单编号：</label>

                        <div class="col-sm-8 label-cont">${view.srvOrderBo.srvOrderCode}</div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-4">服务订单状态：</label>

                        <div class="col-sm-8 label-cont">
                            ${view.srvOrderBo.statusNameCn}
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-4">服务委托方：</label>

                        <div class="col-sm-8 label-cont">
                            <c:if test="${view.srvOrderBo.countryType ==1}">
                                ${view.srvOrderBo.orgNameCn}
                            </c:if>
                            <c:if test="${view.srvOrderBo.countryType ==2}">
                                ${view.srvOrderBo.orgNameRu}
                            </c:if></div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-4">委托方联系人：</label>

                            <div class="col-sm-8 label-cont">
                                <c:if test="${view.srvOrderBo.countryType ==1}">
                                    ${view.srvOrderBo.userNameCn}
                                </c:if>
                                <c:if test="${view.srvOrderBo.countryType ==2}">
                                    ${view.srvOrderBo.userNameFirst}
                                </c:if>
                        </div>
                    </div>
                    <div class="formtable-list">
                        <div class="col-xs-6">
                            <label class="col-sm-4">服务供应商：</label>

                            <div class="col-sm-8 label-cont">${view.orgBo.orgNameCn}</div>
                        </div>
                        <div class="col-xs-6">
                            <label class="col-sm-4">客服：</label>

                            <div class="col-sm-8 label-cont">
                                ${ view.srvOrderBo.customNameCn}
                            </div>
                        </div>
                    </div>
                    <div class="formtable-list">
                        <div class="col-xs-6">
                            <label class="col-sm-4">委托服务：</label>
                            <input type="hidden" name="serviceIds" id="serviceIds">

                            <div class="col-sm-8 label-cont select-label">
                                ${view.srvOrderBo.srvNameCn}
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <label class="col-sm-4">下单时间：</label>

                            <div class="col-sm-8 label-cont"><odpf:formatDate style="DATE"
                                                                              date="${view.srvOrderBo.createTime}"/></div>
                        </div>
                    </div>
                    <div class="formtable-list">
                        <div class="col-xs-6">
                            <label class="col-sm-4">创建人：</label>

                            <div class="col-sm-8 label-cont">
                                <c:if test="${view.srvOrderBo.countryType ==1}">
                                    ${view.srvOrderBo.createNameCn}
                                </c:if>
                                <c:if test="${view.srvOrderBo.countryType ==2}">
                                    ${view.srvOrderBo.createNameRu}
                                </c:if>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <label class="col-sm-4">修改人：</label>

                            <div class="col-sm-8 label-cont">
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
                            <label class="col-sm-4">创建时间：</label>

                            <div class="col-sm-8 label-cont"><odpf:formatDate style="DATE"
                                                                              date="${view.srvOrderBo.createTime}"/></div>
                        </div>
                        <div class="col-xs-6">
                            <label class="col-sm-4">更新时间：</label>

                            <div class="col-sm-8 label-cont"><odpf:formatDate style="DATE"
                                                                              date="${view.srvOrderBo.modifyTime}"/></div>
                        </div>
                    </div>
                    <div class="formtable-list">
                        <div class="col-sm-12">
                            <label class="col-md-2 col-xs-3">订单备注：</label>

                            <div class="col-md-10 col-xs-9 label-cont form-group">
                                ${view.srvOrderBo.memo}
                            </div>
                        </div>
                    </div>
                   </div>
            </form>
        </div>
        <div class="formtable-cont">
            <h4 class="header" id="commInfo">贸易信息</h4>
            <c:if test="${view.tradeOrderBos.size()>0}">
            <div>
                <div class="formtable-list">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <select class="form-control wid-250 col-xs-3" id="selTradeOrder">
                                <c:forEach items="${view.tradeOrderBos}" var="order">
                                    <option value="${order.tradeOrderId}">${order.tradeCode}</option>
                                </c:forEach>
                            </select>
                            <label class="col-xs-3 text_l">关联${fn:length(view.tradeOrderBos)}条贸易信息</label>
                        </div>
                    </div>
                </div>
            </div>
            <div id="orderDetail">
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-4">贸易合同号：</label>

                        <div class="col-sm-8 label-cont">${view.orderBo.tradeCode}</div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-4">合同金额：</label>

                        <div class="col-sm-8 label-cont"><fmt:formatNumber value="${view.orderBo.cost}"
                                                                           pattern="#,##0.00"/>${view.orderBo.costTypeNameCn}</div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-4">买方：</label>

                        <div class="col-sm-8 label-cont">${view.orderBo.buyOrgName}</div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-4">卖方：</label>

                        <div class="col-sm-8 label-cont">${view.orderBo.saleOrgName}</div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6"></div>
                    <div class="col-xs-6">
                        <label class="col-sm-4">卖方商铺：</label>

                        <div class="col-sm-8 label-cont">${view.orderBo.shopName}</div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-4">买方联系人：</label>

                        <div class="col-sm-8 label-cont">${view.orderBo.buyUserName}</div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-4">卖方联系人：</label>

                        <div class="col-sm-8 label-cont">${view.orderBo.saleUserName}</div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-4">买方联系方式：</label>

                        <div class="col-sm-8 label-cont">${view.orderBo.buyContact}
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-4">卖方联系方式：</label>

                        <div class="col-sm-8 label-cont">${view.orderBo.saleContact}
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-4">交货地：</label>

                        <div class="col-sm-8 label-cont">${view.orderBo.deliveryAddrNameCn}</div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-4">提货方式：</label>

                        <div class="col-sm-8 label-cont">${view.orderBo.takeGoodsTypeNameCn}</div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-4">预计交货日期：</label>

                        <div class="col-sm-8 label-cont"><odpf:formatDate style="DATE"
                                                                          date="${view.orderBo.deliveryDate}"/></div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-4">最晚交货日期：</label>

                        <div class="col-sm-8 label-cont"><odpf:formatDate style="DATE"
                                                                          date="${view.orderBo.lastDate}"/></div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-4">付款方式：</label>

                        <div class="col-sm-8 label-cont">
                            <p>
                                预付款比例：${view.orderBo.paywayPercentNameCn}
                                <br>尾款支付限期：${view.orderBo.paywayLastNameCn}
                                <br>支付方式：${view.orderBo.payTypeNameCn}
                            </p>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-4">附加说明：</label>

                        <div class="col-sm-8 label-cont">${view.orderBo.memo}</div>
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
                                <th>单价</th>
                                <th>总价</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="sku" items="${view.orderBo.tradeOrderProductList}">
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
                                    <td>${sku.packageType}</td>
                                    <td><fmt:formatNumber value="${sku.unitPrice}" pattern="#,##0.00"/></td>
                                    <td><fmt:formatNumber value="${sku.unitPrice * sku.purchareNum}"
                                                          pattern="#,##0.00"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <strong class="hei-45 pull-right">合计：<fmt:formatNumber value="${totalMoney}"
                                                                               pattern="#,##0.00"/>${view.orderBo.costTypeNameCn}</strong>

                        <div class="clear"></div>
                    </div>
                </div>
            </div>
        </div>
        </c:if>
        <div class="formtable-cont">
            <h4 class="header" id="perFlo">执行跟踪</h4>

            <div id="queryParam" class="text-l  formtable-query">
                <form class="form-inline">
                    <label>筛选：</label>

                    <div class="form-group">
                        <select class="form-control" name="service" id="nodeSearchService">
                            <option value="">全部</option>
                            <c:forEach items="${view.srvOrderBoList}" var="service">
                                <option value="${service.serviceId}">${service.srvNameCn}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <select class="form-control" name="status" id="nodeSearchStatus">
                            <option value="">全部</option>
                            <c:forEach items="${view.nodeStatus}" var="status">
                                <option value="${status.constValue}">${status.constName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <select class="form-control" name="org" id="org">
                            <option value="">全部</option>
                            <c:forEach items="${view.orgBoList}" var="org">
                                <option value="${org.id}">${org.orgNameCn}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <select class="form-control" name="dept" id="dept">
                            <option value="">全部</option>
                        </select>
                    </div>
                    <button type="button" id="search" class="btn btn-primary">搜索</button>
            <span class="mar_l20">
             <c:if test="${view.srvOrderDtlBos.size()>0 && view.srvOrderBo.status!=5}">
                 <a href="#" data-toggle="modal" data-target="#missonAssig">
                     <button type="button" class="btn btn-primary">任务分配</button>
                 </a>
             </c:if>
                <c:if test="${view.flag}">
                    <button type="button" onclick="changeStatus(${view.srvOrderBo.srvOrderId},4)"
                            class="btn btn-primary">服务执行完成
                    </button>
                </c:if>
		  </span>
                </form>

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
<div class="modal fade" id="missonAssig" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="execute">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">服务分配</h4>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="srvOrderId" value="${view.srvOrderBo.srvOrderId}"/>

                    <div class="row modal-row">
                        <label class="col-xs-3 formtable-list-require text-right">操作任务：</label>

                        <div class="col-xs-8">
                            <div class="form-inline">
                                <div class="form-group">
                                    <select class="form-control" id="srvOrderDtlService" name="serviceId">
                                        <option value="">--请选择--</option>
                                        <c:forEach items="${view.srvOrderDtlBos}" var="service">
                                            <option value="${service.serviceId}">${service.serviceNameCn}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row modal-row">
                        <label class="col-xs-3 formtable-list-require text-right">服务商：</label>

                        <div class="col-xs-8">
                            <select class="form-control" id="executeOrg" name="srvOrgId">
                                <option value="">--请选择--</option>
                            </select>
                        </div>
                    </div>
                    <div class="row modal-row">
                        <label class="col-xs-3 formtable-list-require text-right">计划完成：</label>

                        <div class="col-xs-8">
                            <div class="input-group datepicker date wid-150">
                                <input type="text" class="form-control" readonly style="margin: 0px;" name="finishDate">
                                <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary">分配</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="modal fade" id="comply" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="executeNode">
                <input type="hidden" name="attaJson" id="attaJson" value="">
                <input type="hidden" name="id" id="nodeId">
                <input type="hidden" name="orderStatus" value="${view.srvOrderBo.status}">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">服务执行</h4>
                </div>
                <div class="modal-body">
                    <div class="row modal-row">
                        <label class="col-xs-3 formtable-list-require text-right">操作环节：</label>

                        <div class="col-xs-8 mar_t5" id="nodeName"></div>
                    </div>
                    <div class="row modal-row">
                        <label class="col-xs-3 formtable-list-require text-right">操作结果：</label>

                        <div class="col-xs-8">
                            <div class="form-inline">
                                <div class="form-group">
                                    <select class="form-control" id="nodeStatus" name="status">
                                        <c:forEach items="${view.nodeStatus}" var="status">
                                            <option value="${status.constValue}">${status.constName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row modal-row">
                        <label class="col-xs-3 text-right">实际完成：</label>

                        <div class="col-xs-8">
                            <div class="input-group datepicker date wid-150">
                                <input type="text" id="actualDate" name="actualDate" class="form-control" readonly
                                       style="margin: 0px;">
                                <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                            </div>
                        </div>
                    </div>
                    <div class="row modal-row mar_b40">
                        <label class="col-xs-3 text-right">文件附件：</label>

                        <div class="col-xs-8">
                            <div class="form-inline">
                                <div class="form-group mar_b5">
                                    <input type="text" class="form-control" placeholder="文件名" id="attaName">
                                </div>
                                <span class="mar_l10" style="color: red">最多可以上传5个文件</span>
                                <a href="javascript:;" class="a-upload show btn btn-primary btn-sm">
                                    <input type="file" id="attaId" name="file">上传
                                </a>
                            </div>

                        </div>
                    </div>
                    <div class="row modal-form-del" id="atta">
                        <div class="clear"></div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary">保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </form>

        </div>
    </div>
</div>
<script src="${ctx}/resources/js/serviceorder/new_execute.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp" %>
</body>
</html>