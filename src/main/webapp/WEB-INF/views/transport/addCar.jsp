<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<html>
<head>
    <meta charset="UTF-8">

    <title>园区中心-车辆新增</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">园区中心</a>
    </li>
    <li>
        <a href="${ctx}/transport/listCar">车辆管理</a>
    </li>
    <li>
        <a href="#">新增车辆</a>
    </li>
</nav>
        <div class="formtable">
            <form id="form1" class="a" action="${ctx}/transport/saveCar" method="post">
            <div class="formtable-cont">
                <h4 class="header">新增车辆 </h4>

                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require" >车牌号：</label>
                        <div class="col-sm-7 col-md-8">
                            <input class="form-control" id="carLicence" name="carLicence" required>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require" >车辆类型：</label>
                        <div class="col-sm-7 col-md-8">
                            <div class="form-inline">
                                <select class="form-control" id="carType" name="carType">
                                    <option value="">---请选择---</option>
                                    <option value="1">围栏车</option>
                                    <option value="2">冷藏车</option>
                                    <option value="3">箱车</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">载重量：</label>
                        <div class="col-sm-7 col-md-8">
                            <div class="form-inline">
                                <input class="form-control wid-100" id="carCapacity" name="carCapacity"> 吨
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">车辆国籍：</label>
                        <div class="col-sm-7 col-md-8 no_pad" id="carCountry" name="carCountry">
                           <label><input type="radio" name="carCountry"  value="1" checked >中国</label>
                           <label><input type="radio" name="carCountry"  value="2" >俄罗斯</label>
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                        <label class="col-sm-2 formtable-list-require">常驻地：</label>
                        <div class="col-sm-10">
                            <div class="form-inline">
                                <div class="form-group">
                                    <select class="form-control" id="countryId" name="countryId">
                                        <option value="">---选择国家---</option>
                                        <c:forEach var="country" items="${view.countryList}" >
                                            <option value="${country.constValue}">${country.constName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <select class="form-control" name="provinceId" size="1" id="provinceId" >
                                        <option value="">---请选择省---</option>
                                        <c:forEach items="${view.provList}" var="prov">
                                            <option value="${prov.id}" <c:if test="${userEntity.provId==prov.id}">selected</c:if> >
                                                ${prov.cnname}(${prov.enname})</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <select class="form-control" name="cityId" size="1" id="cityId">
                                    <option value="">---请选择市---</option>
                                    <c:forEach items="${cityList}" var="city">
                                        <option value="${city.id}" <c:if test="${userEntity.cityId==city.id}">selected</c:if> >
                                                ${city.cnname}( ${city.enname})</option>
                                    </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <select class="form-control" name="districtId" size="1" id="districtId">
                                        <option value="">---请选择区---</option>
                                        <c:forEach items="${distList}" var="dist">
                                            <option value="${dist.id}" <c:if test="${userEntity.distId==dist.id}">selected</c:if> >
                                                    ${dist.cnname}(${dist.enname})</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                </div>
                <div class="formtable-list">
                        <label class="col-sm-2">备注：</label>
                        <div class="col-sm-10">
                            <textarea class="form-control mar_l-5" rows="4" id="mark" name="remark"></textarea>
                        </div>
                </div>

            </div>
            <div class="formtable-cont text_c">
                <a href="${ctx}/transport/listCar" class="fl_l font_color--danger">取消返回上一步</a>
                <button class="btn btn-primary"  id="submitCar">保存</button>
            </div>
         </form>
    </div>

<script type="text/javascript" src="${ctx}/resources/js/transport/updatecar.js?v=123"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>
