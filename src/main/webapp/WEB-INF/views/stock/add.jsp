<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/common/global/common.jsp" %>
<html>
<head>
    <meta charset="utf-8">

    <title>园区中心-出入库添加</title>

</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">园区中心</a>
    </li>
    <li>
        <a href="${ctx}/stock/list">出入库明细</a>
    </li>
    <li>
    <a href="#">新增出入库</a>
</li>
</nav>

<div class="container-fluid">
    <form id="form1">
        <input type="hidden" value="${view.srvOrderId}" id="srvOrderId"/>
        <div class="formtable">
            <div class="formtable-cont">
                <h4 class="header">基本信息</h4>

                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">服务订单编号：</label>

                        <div class="col-sm-7 col-md-8 hide-input">
                            <input type="text" id="srOrder"  placeholder="请输入服务订单编号"
                                   class="input-text form-control" value="${view.srvOrderCode}">
                            <input type="text" id="srOrderId" class="hide" name="srOrder" value="${view.srvOrderId}">
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">仓库名称：</label>

                        <div class="col-sm-7 col-md-8 hide-input">
                            <input type="text" id="warehouse"  placeholder="请输入仓库名称"
                                   class="input-text form-control">
                            <input type="text" id="warehouseId" name="warehouse" class="hide">
                            <a href="${ctx}/store/add" target="view_window" class="mar_l5">找不到仓库名称？</a>
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">
                            <c:if test="${view.types == 'in'}">
                                入库类型：
                            </c:if>

                            <c:if test="${view.types == 'out'}">
                                出库类型：
                            </c:if>
                        </label>

                        <div class="col-sm-7 col-md-8">
                            <select class="form-control" id="ioDetailType">
                                <c:forEach var="inout" items="${view.inOutList}">
                                    <option value="${inout.constValue}"
                                            <c:if test="${view.stockBo.ioDetailType == inout.constValue}">selected</c:if> > ${inout.constName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">
                            <c:if test="${view.types == 'in'}">
                                入库时间：
                            </c:if>

                            <c:if test="${view.types == 'out'}">
                                出库时间：
                            </c:if>
                        </label>

                        <div class="col-sm-7 col-md-8">
                            <%--<div class="input-group date-timepicker date auto_width-r mar_l5">--%>
                                <%--<input type="text" class="form-control"  style="margin: 0px;" id="dates" name="dates">--%>
                                <%--<i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>--%>
                            <%--</div>--%>
                            <div class="col-sm-8 input-group date-timepicker date" style="padding:5px 10px 5px 20px;">
                                <input type="text" id="dates" name="dates" value="<odpf:formatDate style='DATE_HOUR' date='${newsAddView.date}'/>"  class=" form-control no_mar">
                                <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">委托方：</label>

                        <div class="col-sm-7 col-md-8">
                            <input type="text" id="dealingsOrgEdit" name="dealingsOrgEdit" placeholder="请输入公司名称" disabled
                                   class="input-text form-control">
                            <input type="text" id="orgId" hidden="hidden">
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">库管员：</label>

                        <div class="col-sm-7 col-md-8 hide-input">
                            <input type="text" id="manager"  placeholder="请输入库管员名称" class="input-text form-control">
                            <input type="text" id="managerId" name="manager" class="hide">

                            <div class="mar_tb5"><a href="javascript:notFindManager()"  class="mar_l5">找不到库管员？</a></div>
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">凭证图片：</label>

                        <div class="col-sm-7 col-md-8 label-cont">
                            <img src="${ctx}/resources/images/bn.jpg" class="img-responsive" id="stockSrc"
                                 onclick="reOLUploadFro()">
                            <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0"
                                   class="btn-uploadpic" name="file" multiple="" id="stockLogoUrl">
                            <input type="hidden" name="stockLogo" id="stockLogo">
                            <input type="hidden" name="resourceCode" id="resourcesCode">
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">备注：</label>

                        <div class="col-sm-7 col-md-8">
                            <textarea class="form-control" rows="7" id="marks"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="formtable-cont">
                <h4 class="header">详细信息</h4>

                <div id="productInfo">

                </div>

            </div>
            <div class="formtable-cont text_c">
                <a href="${ctx}/stock/list" class="fl_l font_color--danger">取消返回上一步</a>
                <button class="btn btn-primary btn-save">保存</button>
            </div>
        </div>
    </form>
</div>
<div style="display: none">
    <form action="${ctx}/stock/saveInOut" method="post" id="addStockDtlForm">
        <input name="params"/>
    </form>
</div>
<input type="hidden" id="ioType" value="${view.types}"/>
<script type="text/javascript" src="${ctx}/resources/js/stock/add.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script>
    $(".btn-save").newcheck()
</script>
</body>
</html>
