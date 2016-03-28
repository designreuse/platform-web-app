<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>园区中心-司机编辑</title>

</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">内容中心</a>
    </li>
    <li>
        <a href="${ctx}/transport/listDriver">司机管理</a>
    </li>
    <li>
        您<a href="#">编辑司机</a>
    </li>
</nav>

       <form id="form1" action="${ctx}/transport/saveDriver" method="post">
            <div class="formtable">
            <div class="formtable-cont">
                <h4 class="header">编辑司机</h4>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">司机姓名：</label>
                    <span class="col-sm-7 col-md-8 no_pad">
                        <div class="col-md-11">
                            <input class="form-control" type="text" id="driverName" name="driverName" value="${view.driverBo.driverName}">
                        </div>
                    </span>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">司机国籍：</label>
                    <span class="col-sm-7 col-md-8 label-cont">
                        <label class="mar_l5"><input type="radio" name="countryId"  value="1" <c:if test="${view.driverBo.countryId==1}">checked</c:if>>中国</label>
                        <label><input type="radio" name="countryId"  value="2" <c:if test="${view.driverBo.countryId==2}">checked</c:if>>俄罗斯</label>
                    </span>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">司机手机：</label>
                        <div class="col-sm-7 col-md-8">
                        <div class="form-inline">
                            <div class="form-group">
                                <select class="form-control" id="countryNo" name="countryNo">
                                    <c:forEach var="country" items="${view.countrymobile}" >
                                        <option value="${country.constValue}" <c:if test="${view.driverBo.countryNo == country.constValue}">selected</c:if> > ${country.constName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <input class="form-control wid-150" type="text" id="driverMobile" name="driverMobile" value="${view.driverBo.driverMobile}">
                            </div>
                            <div class="form-group">
                                <label id="msg"><c:if test="${view.driverBo.countryNo==1}"> 中国号码</c:if><c:if test="${view.driverBo.countryNo==2}"> 俄罗斯号码</c:if></label>
                            </div>
                        </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">身份证号码/护照号：</label>
                        <div class="col-sm-7 col-md-8">
                           <input class="form-control" type="text" name="idCard" id="idCard" value="${view.driverBo.idCard}">
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">其他联系方式：</label>
                        <div class="col-sm-7 col-md-8">
                           <input class="form-control" type="text" id="otherContact" name="otherContact" value="${view.driverBo.otherContact}">
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4">驾驶证号码：</label>
                        <div class="col-sm-7 col-md-8">
                        <input class="form-control" type="text" id="driverLicence" name="driverLicence" value="${view.driverBo.driverLicence}">
                        </div>
                    </div>
                </div>
            </div>
            <input id="ids" style="display: none" value="${view.driverBo.id}" name="id"/>
            <div class="formtable-cont text_c">
                <a href="${ctx}/transport/detailDriver?type=detail&id=${view.driverBo.id}" class="fl_l font_color--danger" id="">取消返回上一步</a>
                <button class="btn btn-primary"  id="submitForm" type="submit">保存</button>
            </div>
           </div>
           </form>



<script type="text/javascript" src="${ctx}/resources/js/transport/updatedriver.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>
