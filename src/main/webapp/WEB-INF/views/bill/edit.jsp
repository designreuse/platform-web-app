<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>结算中心-阿拉丁账单</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">结算中心</a>
    </li>
    <li>
        <a href="${ctx}/bill/list">阿拉丁账单</a>
    </li>
    <li>
        <a href="${ctx}/bill/edit/${billEditView.billBo.id}">阿拉丁账单详情</a>
    </li>
</nav>
<input id="billId" hidden="hidden" value="${billEditView.billBo.id}"/>
<input id="usdRate" hidden="hidden" value="${billEditView.rateBo.usdRate}"/>
<input id="rubRate" hidden="hidden" value="${billEditView.rateBo.rubRate}"/>

<div class="container-fluid">
    <div class="formtable">
        <div class="formtable-cont mar_t30">
            <table id="tb" class="table table-hover f-size-12" style="border: 1px solid #dddddd; border-top: none;margin-bottom: 0">
                <thead class="header">
                <th >创建时间</th>
                <th>费用名称 | 所属服务</th>
                <th>往来公司</th>
                <th>金额 | 汇率</th>
                <th >操作员</th>
                <th >状态</th>
                <th width="10%">结算时间  |<br/>   操作</th>
                </thead>
                <tbody>
                <tr>
                    <td colspan="2" class="line_h46" >
                                <b>服务订单编号：</b>${billEditView.billBo.srvOrderCode}
                    </td>
                    <td colspan="1" class="line_h46" >
                        <b>下单时间：</b><odpf:formatDate style='DATE_HOUR' date='${billEditView.billBo.orderTime}'/>
                    </td>
                    <td colspan="4" class="line_h46" >
                        <b>委托方：</b>

                        <c:if test="${billEditView.billBo.entrustOrgCountryType==1}">
                            ${billEditView.billBo.entrustOrgName}
                        </c:if>
                        <c:if test="${billEditView.billBo.entrustOrgCountryType==2}">
                            ${billEditView.billBo.entrustOrgNameRu}
                        </c:if>



                        <a id="search" width="130"  href="#">
                            <a href="#" onclick="_chatLogic.openChatWindow(${billEditView.billBo.userId},0)">
                                <i class="icon_all icon_all--chart"></i>
                            </a>
                            和我联系
                        </a>
                    </td>
                </tr>
                <c:forEach var="billDetailBo" items="${billEditView.billDetailCountBo.billDetailBoList}" >
                    <tr onmouseover="javascript:over(this)" >
                        <td>
                            <odpf:formatDate style='DATE_HOUR' date='${billDetailBo.createTime}'/>
                        </td>
                        <td>
                            <p>${billDetailBo.feeName}
                                <c:if test="${billDetailBo.remarks!=null}">
                                    <i class="icon_all icon_all--remarks" data-container="body" data-toggle="popover" data-placement="right" title="备注" data-trigger="hover" data-content="${billDetailBo.remarks}">
                                    </i>
                                </c:if>
                            </p>
                            <p>${billDetailBo.srvName}</p>
                        </td>
                        <td>
                            <c:if test="${billDetailBo.dealingsOrgCountryType==1}">
                                ${billDetailBo.dealingsOrgName}
                            </c:if>
                            <c:if test="${billDetailBo.dealingsOrgCountryType==2}">
                                ${billDetailBo.dealingsOrgNameRu}
                            </c:if>
                        </td>
                        <td>
                            <c:if test="${billDetailBo.paymentStatus==0 ||billDetailBo.paymentStatus==1}">
                                <p class="font_color--warning"><b>+¥<fmt:formatNumber value="${billDetailBo.rmb}" pattern="#,##0.00"/></b></p>
                            </c:if>
                            <c:if test="${billDetailBo.paymentStatus==2 ||billDetailBo.paymentStatus==3}">
                            <p class="font_color--success"><b>-¥<fmt:formatNumber value="${billDetailBo.rmb}" pattern="#,##0.00"/></b></p>
                            </c:if>
                            <p>
                                <c:if test="${billDetailBo.costMark!=null}">
                                    <c:if test="${billDetailBo.costMark!='¥'}">
                                        ${billDetailBo.costMark}<fmt:formatNumber value="${billDetailBo.cost}" pattern="#,##0.00"/> *
                                    </c:if>
                                </c:if>
                                <c:if test="${billDetailBo.costMark!='¥'}">
                                    <fmt:formatNumber value="${billDetailBo.rate}" pattern="#,##0.00"/>
                                </c:if>
                            </p>
                        </td>
                        <td>
                            <p>${billDetailBo.userName}</p>
                        </td>
                        <td>
                                <c:if test="${billDetailBo.paymentStatus==0}" >
                                    未收
                                </c:if>
                                <c:if test="${billDetailBo.paymentStatus==1}" >
                                    已收
                                </c:if>
                                <c:if test="${billDetailBo.paymentStatus==2}" >
                                    未付
                                </c:if>
                                <c:if test="${billDetailBo.paymentStatus==3}" >
                                    已付
                                </c:if>
                        </td>
                        <td hidden="hidden">
                            ${billDetailBo.id}
                        </td>
                        <td hidden="hidden">
                                ${billDetailBo.remarks}
                        </td>
                        <td hidden="hidden">
                            ${billDetailBo.cost}
                        </td>
                        <td hidden="hidden">
                                ${billDetailBo.rate}
                        </td>
                        <td hidden="hidden">
                                ${billDetailBo.feeName}
                        </td>
                        <td hidden="hidden">
                                ${billDetailBo.dealingsOrgName}
                        </td>
                        <td hidden="hidden">
                                ${billDetailBo.feeId}
                        </td>
                        <td hidden="hidden">
                                ${billDetailBo.dealingsOrgId}
                        </td>
                        <td>
                            <c:if test="${billDetailBo.paymentStatus==1 || billDetailBo.paymentStatus==3}">
                                <odpf:formatDate style='DATE_HOUR' date='${billDetailBo.settlementDate}'/>
                                <%--<i id="" class="icon_all icon_all--remarks" >--%>
                                <%--</i>--%>
                                <a href="#" data-toggle="modal" data-target="#trade_edit--cancel">
                                    <span class="icon icon-edit visible"></span>
                                </a>
                            </c:if>

                            <c:if test="${billDetailBo.paymentStatus==0 || billDetailBo.paymentStatus==2}">
                                <ul class="trade_edit pos_ab">
                                        <li class="trade_edit--active trade_edit--count">
                                            结算
                                        </li>
                                </ul>
                            </c:if>

                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <form id="addForm">
        <div id="newCount" class="border hidden">

        </div>
        <button id="addFormSubmit" class="submit" hidden="hidden"/>
    </form>
        <div id="tip" type="button">

        </div>
        <button class="btn btn-primary btn-sm mar_t10" type="button" id="addCount">新增一笔</button>
        <button class="btn btn-primary btn-sm hidden mar_t10" type="button" id="saveCount">确认并保存</button>

    <table class="table border mar_t20 f-size-12">
        <tbody>
        <tr class="text_r">
            <td colspan="7" class="no-border">
                <p>
                    <b>账单统计：</b>
                    <b class="mar_l20">收款共${billEditView.billDetailCountBo.billStaticsBo.gatheringCount}笔 <em class="font_color--warning mar_l10"> ¥<fmt:formatNumber value="${billEditView.billDetailCountBo.billStaticsBo.gatheringAmount}" pattern="#,##0.00"/></em></b>
                    <b class="mar_l20">付款共${billEditView.billDetailCountBo.billStaticsBo.payCount}笔 <em class="font_color--success mar_l10"> ¥<fmt:formatNumber value="${billEditView.billDetailCountBo.billStaticsBo.payAmount}" pattern="#,##0.00"/></em></b>
                </p>
                <p>
                    <span><b>进行中：</b><em class="mar_l10">未收${billEditView.billDetailCountBo.billStaticsBo.noGatheringCount}笔</em><em class="mar_l10">¥<fmt:formatNumber value="${billEditView.billDetailCountBo.billStaticsBo.noGatheringAmount}" pattern="#,##0.00"/></em><em class="mar_l10">未付${billEditView.billDetailCountBo.billStaticsBo.noPayCount}笔</em><em class="mar_l10">¥<fmt:formatNumber value="${billEditView.billDetailCountBo.billStaticsBo.noPayAmount}" pattern="#,##0.00"/></em>  </span>
                    <span class="mar_l20"><b>进行中：</b><em class="mar_l10">实收${billEditView.billDetailCountBo.billStaticsBo.gatherEdCount}笔</em><em class="mar_l10">¥<fmt:formatNumber value="${billEditView.billDetailCountBo.billStaticsBo.gatherEdAmount}" pattern="#,##0.00"/></em><em class="mar_l10">实付${billEditView.billDetailCountBo.billStaticsBo.payEdCount}笔</em><em class="mar_l10">¥<fmt:formatNumber value="${billEditView.billDetailCountBo.billStaticsBo.payEdAmount}" pattern="#,##0.00"/></em>  </span>
                </p>
            </td>
        </tr>
        </tbody>
    </table>

    <a  href="/platform/serviceOrder/${billEditView.billBo.srvOrderId}/edit" class="btn btn-primary btn-sm wid-60">返回服务订单详情</a>

</div>
<!--modal-->
<!--trade_edit-count-->
<div class="modal fade" id="trade_edit--count">
    <form id="confirmSettlementForm">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">确认结算信息</h4>
                </div>
                <div class="modal-body">
                    <div class="trade_edit--count_cont row no_mar">
                        <p>以下数据可编辑</p>
                        <div class="col-md-6">
                            <lable class="col-md-4 line_h34 text_r no_pad formtable-list-require">金额：</lable>
                            <div class="col-md-8">
                                <input id="rmbConfirmed" name="rmbConfirmed" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <lable class="col-md-4 line_h34 text_r no_pad formtable-list-require">汇率：</lable>
                            <div class="col-md-8">
                                <input id="rateConfirmed" name="rateConfirmed" class="form-control">
                            </div>
                        </div>

                    </div>
                    <div class="trade_edit--count_cont row no_mar">
                        <p>以下数据不可编辑</p>
                        <div class="col-md-6">
                            <lable class="col-md-4 line_h34 text_r no_pad">费用名称：</lable>
                            <div class="col-md-8">
                                <lable id="feeNameConfirmed" class="line_h34 text_r no_pad"></lable>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <lable class="col-md-4 line_h34 text_r no_pad">往来公司：</lable>
                            <div class="col-md-8">
                                <lable id="dealingsOrgConfirmed" class="line_h34 text_r no_pad"></lable>
                            </div>
                        </div>

                    </div>
                    <div class="text_c mar_t30">
                        <button id="confirmSettlementBtn" type="submit" class="btn btn-primary">确认结算</button>
                        <button type="button" class="btn btn-default mar_l20" data-dismiss="modal">取消</button>
                        <p class="text_c mar_t30">确认结算后， 该条数据的状态会改至“已收/已付”。</p>
                    </div>
                </div>
            </div>
        </div>
    </form>

</div>
<!--trade_edit-edit-->
<div class="modal fade" id="trade_edit--edit">
    <form id="tradeEditForm">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">编辑结算信息</h4>
                </div>
                <div class="modal-body">
                    <div class="trade_edit--edit_cont row no_mar">
                        <p>以下数据可编辑</p>
                        <div class="col-md-6">
                            <lable class="col-md-4 line_h34 text_r no_pad formtable-list-require">金额：</lable>
                            <div class="col-md-8">
                                <input id="rmbEdit" name="rmbEdit" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <lable class="col-md-4 line_h34 text_r no_pad formtable-list-require">汇率：</lable>
                            <div class="col-md-8">
                                <input id="rateEdit" name="rateEdit" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-6 mar_t10">
                            <lable class="col-md-4 line_h34 text_r no_pad formtable-list-require">费用名称：</lable>
                            <div class="col-md-8 hide-input">
                                <%--<input id="" class="form-control">--%>

                                <%--
                                                            <input class="easyui-combobox" id="feeNameEdit"  data-options="valueField:'id' , textField:'value', loader : btsloader, mode : 'remote' "/>
                                --%>
                                <input type="text" id="feeNameEdit" name="feeNameEdit"  placeholder="请输入费用名称" style="width:170px" class="input-text form-control">
                                <input type="text" id="feeNameId" name="feeNameId" class="hide">
                            </div>
                        </div>
                        <div class="col-md-6 mar_t10">
                            <lable class="col-md-4 line_h34 text_r no_pad formtable-list-require">往来公司：</lable>
                            <div class="col-md-8 hide-input">
                                <input type="text" id="dealingsOrgEdit" name="dealingsOrgEdit"  placeholder="请输入公司名称" style="width:170px" class="input-text form-control">
                                <input type="text" id="dealingsOrgId" name="dealingsOrgId" class="hide">
                            </div>
                        </div>
                    </div>
                    <div class="text_c mar_t30">
                        <button id="modifyBtn" type="submit" class="btn btn-primary">保存</button>
                        <button id="cancelModifyBtn" type="button" class="btn btn-default mar_l20" data-dismiss="modal">取消</button>
                    </div>
                </div>
            </div>
        </div>

    </form>

</div>
<!--trade_edit-text-->
<div class="modal fade" id="trade_edit--text">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">备注结算信息</h4>
            </div>
            <div class="modal-body">
                <form id="remarksForm">
                    <div class="form-group">
                        <label class="col-sm-2 text_r">备注：</label>
                        <div class="col-sm-9">
                            <textarea id="remarks" name="remarks" class="form-control trade_edit--text_cont"></textarea>
                        </div>
                        <p class="col-md-offset-2">（还可以输入 <span class="trade_edit--text_limit">50</span>字）</p>
                    </div>
                    <div class="text_c mar_t30 ">
                        <button id="commentSaveBtn" type="submit" class="btn btn-primary">保存</button>
                        <button type="button" class="btn btn-default mar_l20" data-dismiss="modal">取消</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
<!--trade_edit-delete-->
<div class="modal fade" id="trade_edit--delete">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">删除结算信息</h4>
            </div>
            <div class="modal-body">
                <p class="text_c"><i class="icon icon_warning"></i>您确定要删除本条结算数据吗？</p>
                <div class="text_c">
                    <button id="delBtn" type="button" class="btn btn-primary">确认</button>
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
                <button  type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">取消结算信息</h4>
            </div>
            <div class="modal-body text-center">
                该信息已收/已付状态，请先取消结算
                <br />取消结算后， 该条数据的状态会改至“未收/未付”。
            </div>
            <div class="modal-footer">
                <a href="#" data-toggle="modal" id="cancelSettlementBtn"  class="btn btn-primary" data-dismiss="modal">取消结算</a>
                <button type="button" class="btn btn-default" data-dismiss="modal">不取消</button>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/bill/edit.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/validation/util.js"></script>
</body>
</html>