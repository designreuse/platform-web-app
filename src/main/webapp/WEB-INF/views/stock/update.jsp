<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/common/global/common.jsp" %>
<html>
<head>
    <meta charset="utf-8">

    <title>园区中心-出入库编辑</title>

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
        <a href="#">编辑出入库</a>
    </li>
</nav>
<div class="container-fluid">

<%--<div class="alert alert-danger" role="alert">--%>
    <%--提示：本页数据修改后，重新生成出库单，系统将自动删除原有的出库信息。--%>
    <%--<a href="javascript:void(0)" id="goDetail">取消返回上一页</a>--%>
<%--</div>--%>


<div class="formtable">
<div class="formtable-cont">
    <form id="form1">
        <h4 class="header header-fl" id="baseInfo">基本信息</h4>
        <button type="submit" class="btn btn-primary header-button" id="saveInOut">保存</button>

        <div class="clear"></div>
        <div class="formtable-list">
            <div class="col-xs-6">
                <label class="col-md-4 formtable-list-require">服务订单编号：</label>

                <div class="col-md-8 label-cont">
                    ${view.stockBo.srvOrderCode}
                </div>
            </div>
            <div class="col-xs-6">
                <label class="col-md-4 formtable-list-require">仓库名称：</label>

                <div class="col-md-8 label-cont">
                    ${view.stockBo.warehouseName}
                </div>
            </div>
        </div>
        <div class="formtable-list">
            <div class="col-xs-6">
                <label class="col-md-4 formtable-list-require">
                    <c:if test="${view.stockBo.ioType == 1}">
                        出库类型：
                    </c:if>
                    <c:if test="${view.stockBo.ioType == 2}">
                        入库类型：
                    </c:if>
                </label>

                <div class="col-md-8">
                    <select class="form-control" id="detailType">
                        <c:forEach var="inout" items="${view.inOutList}">
                            <option value="${inout.constValue}"
                                    <c:if test="${view.stockBo.ioDetailType == inout.constValue}">selected</c:if> > ${inout.constName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="col-xs-6">
                <label class="col-md-4 formtable-list-require">
                    <c:if test="${view.stockBo.ioType == 1}">
                        出库时间：
                    </c:if>
                    <c:if test="${view.stockBo.ioType == 2}">
                        入库时间：
                    </c:if>
                </label>

                <div class="col-md-8">
                    <div class="input-group date-timepicker date auto_width-r mar_l5">
                        <input type="text" class="form-control" readonly style="margin: 0px;" name=""
                               value="<fmt:formatDate value='${view.stockBo.ioDate}' pattern="yyyy-MM-dd HH:mm" />"
                               id="dates">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="formtable-list">
            <div class="col-xs-6">
                <label class="col-md-4 formtable-list-require">委托方：</label>

                <div class="col-md-8">
                    <input type="text" id="dealingsOrgEdit" name="dealingsOrgEdit" placeholder="请输入公司名称" disabled
                           value="${view.stockBo.orgNameCn}" class="input-text form-control">
                </div>
            </div>
            <div class="col-xs-6">
                <label class="col-md-4 formtable-list-require">库管员：</label>

                <div class="col-md-8">
                    <input type="text" id="manager" name="manager" placeholder="请输入库管员名称"
                           class="input-text form-control" value="${view.stockBo.warehouseManager}">
                    <input type="text" id="managerId" hidden="hidden">
                    <input type="text" id="warehouseId" name="warehouseId" hidden="hidden" value="${view.stockBo.warehouseId}">
                    <div class="mar_tb5"><a href="#" id="notFindManager">找不到库管员？</a></div>
                </div>
            </div>
        </div>
        <div class="formtable-list">
            <div class="col-xs-6">
                <label class="col-md-4">凭证图片：</label>

                <div class="col-md-8 label-cont">
                    <img src="${view.stockBo.voucherLogo}" width="300" height="100" id="stockSrc"
                         onclick="reOLUploadFro()">
                    <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0"
                           class="btn-uploadpic" name="file" multiple="" id="stockLogoUrl">
                    <input type="hidden" name="stockLogo" id="stockLogo" value="${view.stockBo.voucherLogo}">
                    <input type="hidden" name="resourceCode" id="resourcesCode">
                </div>
            </div>
            <div class="col-xs-6">
                <label class="col-md-4">备注：</label>

                <div class="col-md-8">
                    <textarea class="form-control" rows="7" id="marks">${view.stockBo.marks}</textarea>
                </div>
            </div>
        </div>
    </form>
</div>

<form class="formtable-cont" id="form2">
    <h4 class="header header-fl">详细信息</h4>
    <button class="btn btn-primary header-button" id="saveProduct">保存</button>

    <div class="clear"></div>
    <div >

        <c:forEach var="product" items="${view.stockBo.stockProductBoList}">
            <div class="product" id="${product.productId}">
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <div class="col-xs-4 text-right label-cont">
                            <img src="${product.photoUrl}" width="80" height="80" alt="">
                        </div>
                        <div class="col-xs-8 label-cont">
                            <p style="font-weight:300">
                                    ${product.productName}
                                <br/>
                                    ${product.catalogNameCn}
                                <br/>
                                HS CODE:${product.hsCode}
                            </p>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-md-4 formtable-list-require">品类：</label>

                        <div class="col-md-8 label-cont">${product.catalogNameCn},${product.catalogNameCn1},${product.catalogNameCn2}</div>
                        <label class="col-md-4 formtable-list-require">出库数量：</label>

                        <div class="col-md-8">
                            <div class="form-inline">
                                <div class="form-group">
                                    <input type="text" class="form-control" value="${product.ioNums}" name="ioNums"> 件
                                    <input type="hidden" value="${product.productId}" name="productId"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-md-4 formtable-list-require">毛重：</label>

                        <div class="col-md-8">
                            <div class="form-inline">
                                <div class="form-group">
                                    <input type="text" class="form-control" value="${product.grossWeight}"
                                           name="grossWeight"> 吨
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-md-4 formtable-list-require">皮重：</label>

                        <div class="col-md-8">
                            <div class="form-inline">
                                <div class="form-group">
                                    <input type="text" class="form-control" value="${product.tare}" name="tare"> 吨
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-md-4 formtable-list-require">净重：</label>

                        <div class="col-md-8">
                            <div class="form-inline">
                                <div class="form-group">
                                    <input type="text" class="form-control" value="${product.netWeight}"
                                           name="netWeight"> 吨
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-md-4">装卸组：</label>

                        <div class="col-md-8">
                            <input type="text" class="form-control" value="${product.stevedoring}" name="stevedoring">
                        </div>
                    </div>
                </div>
                <c:forEach var="carDriver" items="${product.stockParkCarDriverBoList}" varStatus="num">
                    <c:if test="${num.count == 1}">
                    <div class="formtable-list">
                        <div class="col-xs-6">
                            <label class="col-md-4 formtable-list-require">车牌号码：</label>

                            <div class="col-md-8">
                                <div>
                                    <div>
                                    <input type="text" class="form-control" name="carLicence"
                                           value="${carDriver.carLicence}">
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="col-xs-6">
                            <label class="col-md-4 formtable-list-require">司机姓名：</label>

                            <div class="col-md-8">
                                <div><div>
                                <input type="text" class="form-control" name="driverName"
                                       value="${carDriver.driverName}">
                                </div></div>
                            </div>
                        </div>
                    </div>
                    </c:if>
                    <c:if test="${num.count > 1}">
                    <div class="formtable-list">
                        <div class="col-xs-6"><label class="col-md-4 formtable-list-require">车牌号码：</label>

                            <div class="col-md-8"><input type="text" class="form-control" name="carLicence" value="${carDriver.carLicence}"></div>
                        </div>
                        <div class="col-xs-6"><label class="col-md-4 formtable-list-require">司机姓名：</label>

                            <div class="col-md-8">
                                <div class="form-inline">
                                    <div class="form-group"><input type="text" class="form-control" name="driverName" value="${carDriver.driverName}"><span
                                            class="icon icon-del visible"
                                            onclick="javascript: $(this).parent().parent().parent().parent().parent().remove()"></span>
                                    </div>
                            </div>
                        </div>
                        </div>
                    </div>
    </c:if>
                </c:forEach>
            </div>

            <div class="formtable-list">
            <div class="col-xs-4 col-md-offset-2 pad_10">
                <a href="javascript:void(0)" class="add-car"><span class="icon icon-add"></span>继续添加车辆</a>
            </div>
        </div>
        </c:forEach>

    </div>
</form>
<div class="formtable-cont text_c">
    <a href="javascript:void(0);" class="fl_l font_color--danger" id="goDetails"> 取消返回上一步</a>
    <%--<button class="btn btn-primary" id="repeatC">重新生成出库单</button>--%>
</div>

</div>
</div>

<input style="display: none" id="ids" value="${view.stockBo.id}"/>
<input style="display: none" id="ioType" value="${view.stockBo.ioType}"/>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/stock/update.js"></script>
</body>
</html>
