<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<html>
<head>
    <meta charset="utf-8">

    <title>园区中心-出入库详细</title>

</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">园区中心</a>
    </li>
    <li>
        <a href="${ctx}/stock/list">出入库明细</a>
    </li>
</nav>

<div class="container-fluid">
    <div class="formtable">
        <div class="formtable-cont">
            <h4 class="header" id="baseInfo">基本信息</h4>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-md-4 formtable-list-require">服务订单编号：</label>
                    <div class="col-md-8 label-cont">${view.stockBo.srvOrderCode}</div>
                </div>
                <div class="col-xs-6">
                    <label class="col-md-4 formtable-list-require">仓库名称：</label>
                    <div class="col-md-8 label-cont">${view.stockBo.warehouseName}</div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-md-4 formtable-list-require">
                           <c:if test="${view.stockBo.ioType==1}">
                               出库类型：
                           </c:if>
                            <c:if test="${view.stockBo.ioType==2}">
                                入库类型：
                            </c:if>
                    </label>
                    <div class="col-md-8 label-cont">
                            <c:forEach var="inOut" items="${view.inOutList}" >
                               <c:if test="${view.stockBo.ioDetailType == inOut.constValue}">${inOut.constName}</c:if>
                            </c:forEach>
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-md-4 formtable-list-require">
                        <c:if test="${view.stockBo.ioType==1}">
                            出库时间：
                        </c:if>
                        <c:if test="${view.stockBo.ioType==2}">
                            入库时间：
                        </c:if>
                    </label>
                    <div class="col-md-8 label-cont">
                        <fmt:formatDate value='${view.stockBo.ioDate}' pattern="yyyy-MM-dd HH:mm" />
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-md-4 formtable-list-require">委托方：</label>
                    <div class="col-md-8 label-cont">${view.stockBo.orgNameCn}</div>
                </div>
                <div class="col-xs-6">
                    <label class="col-md-4 formtable-list-require">库管员：</label>
                    <div class="col-md-8 label-cont">
                        ${view.stockBo.warehouseManager}
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-md-4">凭证图片：</label>
                    <div class="col-md-8 label-cont">
                        <img src="${view.stockBo.voucherLogo}" class="img-responsive" alt="">
                    </div>

                </div>
                <div class="col-xs-6">
                    <label class="col-md-4">备注：</label>
                    <div class="col-md-8 label-cont">
                        ${view.stockBo.marks}
                    </div>
                </div>
            </div>
        </div>
        <div class="formtable-cont">
            <h4 class="header" >详细信息</h4>
            <c:forEach var="product" items="${view.stockBo.stockProductBoList}" >
                <div>
                    <div class="formtable-list">
                        <div class="col-xs-6">
                            <div class="col-xs-4 text-right label-cont">
                                <img src="${product.photoUrl}" width="80" height="80" alt="">
                            </div>
                            <div class="col-xs-8 label-cont pad_l20">
                                <p style="font-weight:300">
                                    <br/>
                                    ${product.productName}
                                    <br/>
                                    ${product.catalogNameCn}
                                    <br/>
                                    HS CODE:${product.hsCode}
                                </p>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <br/>
                            <label class="col-md-4 formtable-list-require">品类：</label>
                            <div class="col-md-8 label-cont">${product.catalogNameCn1}, ${product.catalogNameCn2}, ${product.catalogNameCn} </div>
                            <br/>
                            <label class="col-md-4 formtable-list-require">出库数量：</label>
                            <div class="col-md-8 label-cont">${product.ioNums} 件</div>
                        </div>
                    </div>
                    <div class="formtable-list">
                        <div class="col-xs-6">
                            <label class="col-md-4 formtable-list-require">毛重：</label>
                            <div class="col-md-8 label-cont">${product.grossWeight} 吨</div>
                        </div>
                        <div class="col-xs-6">
                            <label class="col-md-4 formtable-list-require">皮重：</label>
                            <div class="col-md-8 label-cont">${product.tare} 吨</div>
                        </div>
                    </div>
                    <div class="formtable-list">
                        <div class="col-xs-6">
                            <label class="col-md-4 formtable-list-require">净重：</label>
                            <div class="col-md-8 label-cont">${product.netWeight} 吨</div>
                        </div>
                        <div class="col-xs-6">
                            <label class="col-md-4">装卸组：</label>
                            <div class="col-md-8 label-cont">${product.stevedoring}</div>
                        </div>
                    </div>
                    <div class="formtable-list">
                        <c:forEach var="carDriver" items="${product.stockParkCarDriverBoList}" >
                            <div class="col-xs-6">
                                <label class="col-md-4 formtable-list-require">车牌号码：</label>
                                <div class="col-md-8 label-cont">${carDriver.carLicence}</div>
                            </div>
                        <%--</c:forEach>--%>

                        <%--<c:forEach var="driver" items="${product.stockProductDriverBoList}" >--%>
                            <div class="col-xs-6">
                                <label class="col-md-4 formtable-list-require">司机姓名：</label>
                                <div class="col-md-8 label-cont">${carDriver.driverName}</div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="formtable-list">
                    <div class="col-xs-12 label-cont">
                        &nbsp;
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="formtable-cont text_c">
            <a href="${ctx}/stock/list" class="fl_l font_color--danger">取消返回上一步</a>
            <button class="btn btn-primary" id="update">编辑</button>
        </div>
    </div>
</div>

<input style="display: none" id="ids" value="${view.stockBo.id}"/>
<input style="display: none" id="ioType" value="${view.stockBo.ioType}"/>

<%--<script type="text/javascript" src="${ctx}/resources/js/stock/update.js"></script>--%>
<script type="application/javascript">
    $("#update").click(function() {
        var id = $("#ids").val();
        var types = $("#ioType").val();
        var type;
        if(types == 2){
            type="in";
        }else if(types == 1){
            type = "out";
        }

        var url = window.ctx+"/stock/detail?pageType=update&id="+id+"&type="+type;
        window.location.href= url;
    })
</script>

</body>
</html>
