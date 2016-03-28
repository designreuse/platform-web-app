<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>结算中心-发票管理</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">结算中心</a>
    </li>
    <li>
        <a href="${ctx}/invoice/list">发票管理</a>
    </li>
    <li>
        <a href="${ctx}/invoice/edit/${view.invoiceBasicBo.id}">发票详情</a>
    </li>
</nav>
<div class="container-fluid">
    <div class="formtable">
        <div class="formtable-cont">
            <h4 class="header">发票信息</h4>
            <input id="invoiceId" hidden="hidden" value="${view.invoiceBasicBo.id}"/>
            <div class="invoice row no_mar" style="padding: 20px 30px 0">
                <section class="col-sm-6 col-md-4 col-md-offset-1 invoice_mes">
                    <div class="pad_10">
                        <strong>发票抬头</strong>
                    </div>
                    <div>
                        <p>
                            <c:if test="${view.invoiceTitleBo.orgFullName!=null}">
                                    ${view.invoiceTitleBo.orgFullName}
                            </c:if>
                        </p>
                        <p>
                            <c:if test="${view.invoiceTitleBo.taxpayerCode!=null}">
                                ${view.invoiceTitleBo.taxpayerCode}
                            </c:if>
                        </p>
                        <p>
                            <c:if test="${view.invoiceTitleBo.registeredAddress!=null}">
                                ${view.invoiceTitleBo.registeredAddress}
                            </c:if>
                            <c:if test="${view.invoiceTitleBo.telephone!=null}">
                                ${view.invoiceTitleBo.telephone}
                            </c:if>
                        </p>
                        <p>
                            <c:if test="${view.invoiceTitleBo.bankAccount!=null}">
                                ${view.invoiceTitleBo.bankAccount}
                            </c:if>
                            <c:if test="${view.invoiceTitleBo.branchName!=null}">
                                ${view.invoiceTitleBo.branchName}
                            </c:if>
                            <c:if test="${view.invoiceTitleBo.cardNumber!=null}">
                                ${view.invoiceTitleBo.cardNumber}
                            </c:if>
                        </p>
                    </div>
                </section>

                <div class="col-sm-6 col-md-offset-1 invoice_state">
                    <ul>
                        <li>
                            <label class="text_r">状态：</label>
                            <c:if test="${view.invoiceBasicBo.invoiceStatusText!=null}">
                                ${view.invoiceBasicBo.invoiceStatusText}
                            </c:if>
                            <c:if test="${view.invoiceBasicBo.invoiceStatus==1}">
                                <button id="checkBtn" type="button" class="btn btn-primary">确认开票</button>
                                <button id="cancelBtn" type="button" class="btn btn-primary">取消</button>
                            </c:if>
                            <c:if test="${view.invoiceBasicBo.invoiceStatus==2}">
                                <button id="cancelBtn" type="button" class="btn btn-primary">取消</button>
                            </c:if>
                        </li>
                        <li>
                            <label class="text_r">发票类型：</label>
                            <c:if test="${view.invoiceBasicBo.invoiceTypeText!=null}">
                                ${view.invoiceBasicBo.invoiceTypeText}
                            </c:if>
                        </li>
                        <li>
                            <label class="text_r">发票备注：</label>
                            <c:if test="${view.invoiceBasicBo.remarks!=null}">
                                ${view.invoiceBasicBo.remarks}
                            </c:if>
                        </li>

                    </ul>
                </div>
            </div>
        </div>
        <div class="formtable-cont mar_t30">
            <h4 class="header">发票明细</h4>
            <table class="table table-bordered table-hover f-size-14">
                <thead>
                <th>货物或应税劳务名称</th>
                <th>规格型号</th>
                <th>单位</th>
                <th>数量</th>
                <th>单价</th>
                <th>金额</th>
                </thead>
                <tbody>
                <c:forEach var="invoiceDetailBo" items="${view.invoiceDetailBoList}">
                    <tr>
                        <td>
                            <p>
                                <c:if test="${invoiceDetailBo.goodsName!=null}">
                                    ${invoiceDetailBo.goodsName}
                                </c:if>
                            </p>
                        </td>
                        <td>
                            <p>
                                <c:if test="${invoiceDetailBo.specName!=null}">
                                    ${invoiceDetailBo.specName}
                                </c:if>
                            </p>
                        </td>
                        <td>
                            <p>
                                <c:if test="${invoiceDetailBo.unitName!=null}">
                                    ${invoiceDetailBo.unitName}
                                </c:if>
                            </p>
                        </td>
                        <td>
                            <p>
                                <fmt:formatNumber value="${invoiceDetailBo.nums}" pattern="#,##0"/>
                            </p>
                        </td>
                        <td>
                            <p>
                                <fmt:formatNumber value="${invoiceDetailBo.unitPrice}" pattern="#,##0.00"/>元
                            </p>
                        </td>
                        <td>
                            <fmt:formatNumber value="${invoiceDetailBo.totalPrice}" pattern="#,##0.00"/>元
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
                <tfoot>
                <tr class="text_r">
                    <td colspan="6"><b>金额：<fmt:formatNumber value="${view.invoiceBasicBo.totalPriceAllInvoices}" pattern="#,##0.00"/>元</b></td>
                </tr>
                </tfoot>
            </table>
        </div>
    </div>

</div>
<!--trade_edit-check-->
<div class="modal fade" id="trade_edit--check">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">确认开票</h4>
            </div>
            <div class="modal-body">
                <p class="text_c"><i class="icon icon_warning"></i>您确定要开票吗？</p>
                <div class="text_c">
                    <button id="checkInvoicingBtn" type="button" class="btn btn-primary">确认</button>
                    <button type="button" class="btn btn-default mar_l20" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!--trade_edit-cancel-->
<div class="modal fade" id="trade_edit--cancel">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">取消开票</h4>
            </div>
            <div class="modal-body">
                <p class="text_c"><i class="icon icon_warning"></i>您确定要取消开票吗？</p>
            </div>
            <div class="modal-footer text_c">
                <button id="checkCancelInvoicingBtn" type="button" class="btn btn-primary">确认</button>
                <button type="button" class="btn btn-default mar_l20" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/invoice/edit.js"></script>

<script>

</script>
</body>
</html>