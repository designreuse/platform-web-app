<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/common/global/common.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>
        <c:if test="${ empty view.storeBo.id}">
             园区中心-新增仓库
        </c:if>

        <c:if test="${view.storeBo.id != null}">
                园区中心-编辑仓库
        </c:if>
   </title>
</head>

<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">园区中心</a>
    </li>
    <li>
        <a href="${ctx}/store/list">仓库管理</a>
    </li>

    <c:if test="${ empty view.storeBo.id}">
        <li>
            <a href="#">新增仓库</a>
        </li>
    </c:if>

    <c:if test="${view.storeBo.id != null}">
        <li>
            <a href="#">编辑仓库</a>
        </li>
    </c:if>
</nav>
<div class="container-fluid">
    <form id="form1">
        <div class="formtable">
            <div class="formtable-cont" id="manag">
                <h4 class="header">
                    <c:if test="${ empty view.storeBo.id}">
                        新增仓库
                    </c:if>

                    <c:if test="${view.storeBo.id != null}">
                        编辑仓库
                    </c:if>

                </h4>

                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">仓库名称：</label>

                        <div class="col-sm-7 col-md-8">
                            <input class="form-control" type="text" name="warehouseName" id="warehouseName"
                                   value="${view.storeBo.warehouseName}">
                            <span id="swarehouseName"></span>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">所属园区：</label>

                        <div class="col-sm-7 col-md-8">
                            <div class="form-inline">
                                <div class="form-group">
                                    <select class="form-control" name="parkId" id="parkId">
                                        <option value="">---请选择区---</option>
                                        <c:forEach var="store" items="${view.parkList}">
                                            <option value="${store.constValue}"
                                                    <c:if test="${view.storeBo.parkId == store.constValue}">selected</c:if> > ${store.constName}</option>
                                        </c:forEach>
                                    </select>
                                    <span id="sparkId"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">委托方名称：</label>

                        <div class="col-sm-7 col-md-8 hide-input">
                            <%--<input class="easyui-combobox" name="orgId" id="orgId" data-options="valueField:'id' , textField:'value', loader : btsloader, mode : 'remote' "/>--%>
                            <input type="text" id="dealingsOrgEdit"  placeholder="请输入公司名称"
                                   class="input-text form-control" value="${view.storeBo.orgNameCn}">
                            <input type="text" id="orgId" class="hide" name="dealingsOrgEdit" value="${view.storeBo.orgId}">
                            <span id="sorgId"></span>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">有效期限：</label>

                        <div class="col-sm-7 col-md-8 pad_l20">
                            <div class="col-md-5 input-group datepicker date">
                                <input type="text" class="form-control"  style="margin: 0px;" name="startDate"
                                       id="startDate"
                                       value="<fmt:formatDate value='${view.storeBo.startDate}' pattern="yyyy-MM-dd" />"/>
                                <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                            </div>

                            <em class="fl_l" style="padding: 10px 5px">-</em>

                            <div class="col-md-5 input-group datepicker date">
                                <input type="text" class="form-control"  style="margin: 0px;" name="endDate"
                                       id="endDate"
                                       value="<fmt:formatDate value='${view.storeBo.endDate}' pattern="yyyy-MM-dd" />">
                                <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                            </div>
                        </div>
                        <%--<span id="sdate" style="margin-left: 20px"></span>--%>
                    </div>
                </div>
                <c:if test="${view.storeBo.warehouseManagerBoList.size()==0 || view.storeBo.warehouseManagerBoList.size()==null}">

                    <div class="formtable-list">
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4 formtable-list-require">库管员：</label>

                            <div class="col-sm-7 col-md-8"><input class="form-control" type="text" name="userName"></div>
                        </div>
                        <div class="col-xs-6">
                            <label class="col-sm-5 col-md-4">库管员手机号：</label>

                            <div class="col-sm-7 col-md-8"><input class="form-control" type="text" name="contacts"></div>
                        </div>
                    </div>
                </c:if>

                <c:forEach var="store" items="${view.storeBo.warehouseManagerBoList}" varStatus="num">
                    <c:if test="${num.count == 1}">
                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4 formtable-list-require">库管员：</label>

                                <div class="col-sm-7 col-md-8"><input class="form-control" type="text" name="userName"
                                                             value="${store.userName}">
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4">库管员手机号：</label>

                                <div class="col-sm-7 col-md-8"><input class="form-control" type="text" name="contacts"
                                                             value="${store.contacts}">
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${num.count > 1}">

                        <div class="formtable-list">
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4 formtable-list-default">库管员：</label>

                                <div class="col-sm-7 col-md-8">
                                    <input class="form-control" type="text" name="userNameOther" value="${store.userName}">
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <label class="col-sm-5 col-md-4">库管员手机号：</label>
                                <div class="col-sm-7 col-md-8">
                                    <div class="form-inline">
                                        <div class="form-group">
                                            <input class="form-control" type="text" name="contactsOther"
                                                   value="${store.contacts}">
                                        </div>
                                        <button type="button" class="close mar_t10"
                                                onclick="javascript: $(this).parent().parent().parent().parent().remove();">
                                            <span aria-hidden="true">×</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>

            </div>
            <button class="btn btn-primary" id="addManag" type="button">继续添加库管员</button>
            <div class="formtable-cont text_c mar_t20">
                <a href="${ctx}/store/list" class="fl_l font_color--danger">取消返回上一步</a>
                <button class="btn btn-primary" type="submit" id="submitForm">保存</button>
            </div>
        </div>
    </form>
</div>
<input id="id" style="display: none" value="${view.storeBo.id}"/>
<input id="sorgIdd" style="display: none" value="${view.storeBo.orgId}"/>
<input id="sorgName" style="display: none" value="${view.storeBo.orgNameCn}"/>
<script type="text/javascript" src="${ctx}/resources/js/store/editStore.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>
