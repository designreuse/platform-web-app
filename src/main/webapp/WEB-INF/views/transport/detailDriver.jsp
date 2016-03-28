<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>园区中心-司机详细</title>
    <script type="text/javascript">
        window.ctx="${ctx}"
    </script>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">内容中心</a>
    </li>
    <li>
        <a href="${ctx}/transport/listDriver">司机管理</a>
    </li>
</nav>
<div class="formtable">
    <div class="formtable-cont">
        <h4 class="header">司机信息</h4>
        <div class="formtable-list">
            <div class="col-xs-6">
                <label class="col-sm-5 col-md-4 formtable-list-require">司机姓名：</label>
                <div class="col-sm-7 col-md-8 label-cont">${view.driverBo.driverName}</div>
            </div>
            <div class="col-xs-6">
                <label class="col-sm-5 col-md-4 formtable-list-require">司机国籍：</label>
                <div class="col-sm-7 col-md-8 label-cont">
                        <c:if test="${view.driverBo.countryId == 1}">
                            中国
                        </c:if>

                        <c:if test="${view.driverBo.countryId == 2}">
                            俄罗斯
                        </c:if>
                </div>
            </div>
        </div>
        <div class="formtable-list">
            <div class="col-xs-6">
                <label class="col-sm-5 col-md-4 formtable-list-require">司机手机：</label>
                <div class="col-sm-7 col-md-8 label-cont">
                    <c:if test="${view.driverBo.countryNo==1}">(+0086) ${view.driverBo.driverMobile}中国号码</c:if><c:if test="${view.driverBo.countryNo==2}"> (+007) ${view.driverBo.driverMobile}俄罗斯号码</c:if>
                </div>
            </div>
            <div class="col-xs-6">
                <label class="col-sm-5 col-md-4 formtable-list-require">身份证号/护照号：</label>
                <div class="col-sm-7 col-md-8 label-cont">
                    ${view.driverBo.idCard}
                </div>
            </div>
        </div>
        <div class="formtable-list">
            <div class="col-xs-6">
                <label class="col-sm-5 col-md-4">其他联系方式：</label>
                <div class="col-sm-7 col-md-8 label-cont">${view.driverBo.otherContact}</div>
            </div>
            <div class="col-xs-6">
                <label class="col-sm-5 col-md-4 formtable-list-default">驾驶证号码：</label>
                <div class="col-sm-7 col-md-8 label-cont">
                    ${view.driverBo.driverLicence}
                </div>
            </div>
        </div>
    </div>
    <div class="formtable-cont text_c">
        <a href="${ctx}/transport/listDriver" class="fl_l font_color--danger">取消返回上一步</a>
        <button class="btn btn-primary" id="edit" onclick="update()">编辑</button>
    </div>
</div>
<input style="display: none" id="id" value="${view.driverBo.id}"/>
<script type="text/javascript" src="${ctx}/resources/js/transport/updatedriver.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>
