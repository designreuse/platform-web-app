<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>结算中心-阿拉丁账单</title>
    <link type="text/css" href="${ctx}/resources/css/style-min.css" rel="stylesheet" />

    <style type="text/css">

    </style>

    <script type="text/javascript">
        window.ctx="${ctx}"

    </script></head>
<body>
<div class="container-fluid">
<div class="formtable">
<div class="formtable-cont formtable-query">
    <nav class="breadcrumb">
        <li>
            您当前位置：<a href="#">结算中心</a>
        </li>
        <li>
            <a href="${ctx}/bill/list">阿拉丁账单</a>
        </li>
    </nav>
    <div class="bill">
        <form id="billListForm" action="${ctx}/bill/list"  class="form-inline">
            <div class="form-group">
                <select id="selectKey"   class="form-control">
                    <c:if test="${billListView.aldBillVo.selectKey==null || billListView.aldBillVo.selectKey=='' || billListView.aldBillVo.selectKey==0}">
                        <option value="0" selected>委托方名称</option>
                        <option value="1">订单编号</option>
                        <option value="2">费用名称</option>
                        <option value="3">往来公司</option>
                    </c:if>

                    <c:if test="${billListView.aldBillVo.selectKey==1}">
                        <option value="0" >委托方名称</option>
                        <option value="1" selected>订单编号</option>
                        <option value="2">费用名称</option>
                        <option value="3">往来公司</option>
                    </c:if>

                    <c:if test="${billListView.aldBillVo.selectKey==2}">

                        <option value="0" >委托方名称</option>
                        <option value="1" >订单编号</option>
                        <option value="2" selected>费用名称</option>
                        <option value="3">往来公司</option>
                    </c:if>

                    <c:if test="${billListView.aldBillVo.selectKey==3}">

                        <option value="0" >委托方名称</option>
                        <option value="1" >订单编号</option>
                        <option value="2" >费用名称</option>
                        <option value="3" selected>往来公司</option>
                    </c:if>


                </select>
                <input name="selectKey" hidden="hidden">
                <input id="keyWord" name="keyWord"   type="text" value="${billListView.aldBillVo.keyWord}" class="form-control" placeholder="关键词">
            </div>
            <div class="form-group">
                <label>资金流向：</label>
                <c:if test="${billListView.aldBillVo.income==1}">
                    <input id="positive" type="checkbox" checked> 收入
                    <input id="negative" type="checkbox"> 支出
                </c:if>
                <c:if test="${billListView.aldBillVo.income==0}">
                    <input id="positive" type="checkbox" > 收入
                    <input id="negative" type="checkbox" checked> 支出
                </c:if>
                <c:if test="${billListView.aldBillVo.income==2}">
                    <input id="positive" type="checkbox" checked> 收入
                    <input id="negative" type="checkbox" checked> 支出
                </c:if>
                <c:if test="${billListView.aldBillVo.income==null || billListView.aldBillVo.income==3}">
                    <input id="positive" type="checkbox"> 收入
                    <input id="negative" type="checkbox"> 支出
                </c:if>
            </div>
            <div class="form-group">
                <label>状态：</label>
                <select id="status" class="form-control">
                    <option value="">全部</option>
                    <c:forEach var="aldConstantsBo" varStatus="varStatus" items="${billListView.aldConstantsBoList}">
                        <c:if test="${billListView.aldBillVo.status!=null}">
                            <c:if test="${aldConstantsBo.constValue==billListView.aldBillVo.status}">
                                <option value="${aldConstantsBo.constValue}" selected>${aldConstantsBo.constName}</option>
                            </c:if>
                            <c:if test="${aldConstantsBo.constValue!=billListView.aldBillVo.status}">
                                <option value="${aldConstantsBo.constValue}">${aldConstantsBo.constName}</option>
                            </c:if>
                        </c:if>
                        <c:if test="${billListView.aldBillVo.status==null}">
                            <option value="${aldConstantsBo.constValue}">${aldConstantsBo.constName}</option>
                        </c:if>
                    </c:forEach>
                </select>
                <input id="statusTemp" value="${billListView.aldBillVo.status}" hidden="hidden">
            </div>
		  <div class="form-group">
		    <a id="search" href="#" class="btn btn-primary btn-sm wid-60">搜索</a>
            <a id="againSet" href="#" class="btn btn-primary btn-sm wid-60">重置</a>
          </div>
            <input name="orgName" value="${billListView.aldBillVo.orgName}" hidden="hidden">
            <input name="srvOrderCode" value="${billListView.aldBillVo.srvOrderCode}" hidden="hidden">
            <input name="feeName" value="${billListView.aldBillVo.feeName}" hidden="hidden">
            <input name="contactCompany" value="${billListView.aldBillVo.contactCompany}" hidden="hidden">
            <input name="income" value="${billListView.aldBillVo.income}" hidden="hidden">
            <input name="status" value="${billListView.aldBillVo.status}" hidden="hidden">

            <%--<input name="pageIndex0" value="${billListView.pageIndex}" hidden="hidden">
            <input name="pageSize0" value="${billListView.pageSize}" hidden="hidden">
            <input name="rowCount0" value="${billListView.rowCount}" hidden="hidden">--%>
        </form>
    </div>
</div>
<div class="formtable-cont mar_t30">
<c:forEach var="billDetailCountBo" varStatus="varStatus" items="${billListView.billDetailCountBoList}">
    <table class="table table-hover f-size-12" style="border: 1px solid #dddddd; border-top: none;margin-bottom: 0">
        <c:if test="${varStatus.index==0}">
            <thead class="header">
            <th >创建时间</th>
            <th>费用名称 | 所属服务</th>
            <th>往来公司</th>
            <th>金额 | 汇率</th>
            <th >操作员</th>
            <th >状态</th>
            <th >结算时间  |  操作</th>
            </thead>
        </c:if>
        <tbody>
        <tr>
            <td colspan="3" class="line_h46">
                <ul class="row no_mar">
                    <li class="col-md-7">
                        <b>服务订单编号：</b>${billDetailCountBo.billBo.srvOrderCode}
                    </li>
                    <li class="col-md-5">
                        <b>下单时间：</b><odpf:formatDate style='DATE_HOUR' date='${billDetailCountBo.billBo.orderTime}'/>
                    </li>
                </ul>
            </td>
            <td colspan="2" class="line_h46">
                <b>委托方：</b>
                <c:if test="${billDetailCountBo.billBo.entrustOrgCountryType==1}">
                    ${billDetailCountBo.billBo.entrustOrgName}
                </c:if>
                <c:if test="${billDetailCountBo.billBo.entrustOrgCountryType==2}">
                    ${billDetailCountBo.billBo.entrustOrgNameRu}
                </c:if>
                <div class="server_chart dis_inb mar_l10">

                    <a href="#"
                       onclick="_chatLogic.openChatWindow(${billDetailCountBo.billBo.userId},0)">
                        <i class="icon_all icon_all--chart"></i>
                    </a>
                    和我联系
                </div>
            </td>
            <td colspan="1" class="line_h46">
                        <c:if test="${billDetailCountBo.billBo.isLock==0}">
                            <a onclick="lockEditRow(${billDetailCountBo.billBo.id})" href="javascript:void(0)">
                                <i class="icon_all icon_all--unlock" data-toggle="modal"></i>
                            </a>
                        </c:if>
                        <c:if test="${billDetailCountBo.billBo.isLock==1}">
                            <a onclick="unlockEditRow(${billDetailCountBo.billBo.id})" href="javascript:void(0)">
                                <i class="icon_all icon_all--lock" data-toggle="modal"></i>
                            </a>
                        </c:if>
            </td>
            <td colspan="1" class="line_h46">
                        <c:if test="${billDetailCountBo.billBo.isLock==0}">
                            <a class="btn btn-primary btn-sm" href="${ctx}/bill/edit/${billDetailCountBo.billBo.id}">编辑</a>
                        </c:if>
                        <c:if test="${billDetailCountBo.billBo.isLock==1}">
                            <span class="bill_download dis_inb">
                            账单下载：<a href="${ctx}/bill/export/${billDetailCountBo.billBo.id}" ><i class="icon_all icon_all--download"></i></a>
                            </span>
                        </c:if>
            </td>
        </tr>

        <c:forEach var="billDetailBo" items="${billDetailCountBo.billDetailBoList}">
            <tr>
                <td width="10%">
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
                <td width="12%">
                    <p><p>${billDetailBo.userName}</p></p>
                </td>
                <td width="10%">
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
                <td width="10%">
                    <c:if test="${billDetailBo.paymentStatus==1 || billDetailBo.paymentStatus==3}">
                        <odpf:formatDate style='DATE_HOUR' date='${billDetailBo.settlementDate}'/>
                    </c:if>
                </td>
            </tr>

        </c:forEach>


        </tbody>
        <tfoot>
        <tr class="text_r">
            <td colspan="7">
                <p>
                    <b>账单统计：</b>
                    <b class="mar_l20">收款共${billDetailCountBo.billStaticsBo.gatheringCount}笔 <em class="font_color--warning mar_l10"> ¥<fmt:formatNumber value="${billDetailCountBo.billStaticsBo.gatheringAmount}" pattern="#,##0.00"/></em></b>
                    <b class="mar_l20">付款共${billDetailCountBo.billStaticsBo.payCount}笔 <em class="font_color--success mar_l10"> ¥<fmt:formatNumber value="${billDetailCountBo.billStaticsBo.payAmount}" pattern="#,##0.00"/></em></b>
                </p>
                <p>
                    <span><b>进行中：</b><em class="mar_l10">未收${billDetailCountBo.billStaticsBo.noGatheringCount}笔</em><em class="mar_l10">¥<fmt:formatNumber value="${billDetailCountBo.billStaticsBo.noGatheringAmount}" pattern="#,##0.00"/></em><em class="mar_l10">未付${billDetailCountBo.billStaticsBo.noPayCount}笔</em><em class="mar_l10">¥<fmt:formatNumber value="${billDetailCountBo.billStaticsBo.noPayAmount}" pattern="#,##0.00"/></em>  </span>
                    <span class="mar_l20"><b>进行中：</b><em class="mar_l10">实收${billDetailCountBo.billStaticsBo.gatherEdCount}笔</em><em class="mar_l10">¥<fmt:formatNumber value="${billDetailCountBo.billStaticsBo.gatherEdAmount}" pattern="#,##0.00"/></em><em class="mar_l10">实付${billDetailCountBo.billStaticsBo.payEdCount}笔</em><em class="mar_l10">¥<fmt:formatNumber value="${billDetailCountBo.billStaticsBo.payEdAmount}" pattern="#,##0.00"/></em>  </span>
                </p>
            </td>
        </tr>
        </tfoot>
    </table>

</c:forEach>


</div>
</div>
<c:if test="${billListView.rowCount>0}">
    <div class="pagination pagination-centered width--100 background_color--2 mar_t--20-"
         id = "pageComponent">
    </div>
</c:if>

</div>
<!--确认锁定账单-->
<div class="modal fade" id="bill_unlock">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">确认锁定账单</h4>
            </div>
            <div class="modal-body">
                <p class="text_c"><i class="icon icon_warning"></i><b>您确定要锁定改账单吗？</b></p>
                <p style="color: red" class="text_c">账单锁定后，将不可新增/修改/删除费用</p>
                <div class="text_c">
                    <button id="lockBtn" type="button" class="btn btn-primary">确认</button>
                    <button type="button" class="btn btn-default mar_l20" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!--确认解锁账单-->
<div class="modal fade" id="bill_lock">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">确认解锁账单</h4>
            </div>
            <div class="modal-body">
                <p class="text_c"><i class="icon icon_warning"></i><b>您确定要解锁账单吗？</b></p>
                <p class="text_c" style="color: red">账单解锁后，操作员可新增/修改/删除费用</p>
                <div class="text_c">
                    <button id="unLockBtn" type="button" class="btn btn-primary">确认</button>
                    <button type="button" class="btn btn-default mar_l20" data-dismiss="modal">取消</button>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/jpage-class.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bill/list.js"></script>
<script>
    var jpage = $("#pageComponent").SetPageComponent({
        pageIndex : "${billListView.pageIndex}",    //当前页码
        pageSize : "${billListView.pageSize}",      //每页条数
        rowCount : "${billListView.rowCount}",      //数据总数
        pageFormID : "billListForm"      //表单id
    });
</script>
</body>
</html>