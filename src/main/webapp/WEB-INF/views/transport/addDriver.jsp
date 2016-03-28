<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>园区中心-司机新增</title>
    <script type="text/javascript">
        window.ctx="${ctx}"
    </script>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">园区中心</a>
    </li>
    <li>
        <a href="${ctx}/transport/listDriver">司机管理</a>
    </li>
    <li>
        <a href="#">新增司机</a>
    </li>
</nav>

<div class="formtable">
    <form id="form1" action="${ctx}/transport/saveDriver" method="post">
        <div class="formtable-cont">
            <h4 class="header">新增司机</h4>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">司机姓名：</label>
                        <div class="col-sm-7 col-md-8">
                            <input class="form-control" type="text" id="driverName" name="driverName">
                        </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">司机国籍：</label>
                    <div class="col-sm-7 col-md-8" name="countryId">
                        <label><input type="radio" name="countryId"  value="1" checked>中国</label>
                        <label><input type="radio" name="countryId"  value="2" >俄罗斯</label>
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">司机手机：</label>
                    <div class="col-sm-7 col-md-8 form-inline">
                        <div class="form-group">
                            <select class="form-control" id="countryNo" name="countryNo">
                                <c:forEach var="country" items="${view.countrymobile}" >
                                    <option value="${country.constValue}">${country.constName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <input class="form-control wid-150" type="text" id="driverMobile" name="driverMobile">
                        </div>
                        <div class="form-group">
                            <span id="msg">中国号码</span>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">身份证号码/护照号：</label>
                    <div class="col-sm-7 col-md-8">
                        <input class="form-control" type="text" id="idCard" name="idCard">
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4">其他联系方式：</label>
                    <div class="col-sm-7 col-md-8">
                       <input class="form-control" type="text" id="otherContact" name="otherContact">
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4">驾驶证号码：</label>
                    <div class="col-sm-7 col-md-8">
                        <input class="form-control" type="text" id="driverLicence" name="driverLicence">
                    </div>
                </div>
            </div>
        </div>
        <input id="ids" style="display: none"/>
        <div class="formtable-cont text_c">
            <a href="${ctx}/transport/listDriver" class="fl_l font_color--danger">取消返回上一步</a>
            <button class="btn btn-primary"  id="submitForm" type="submit">保存</button>
        </div>
    </form>
</div>




<script type="text/javascript" src="${ctx}/resources/js/transport/updatedriver.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>
