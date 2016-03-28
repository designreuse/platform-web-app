<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>园区中心-车辆编辑</title>

</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">内容中心</a>
    </li>
    <li>
        <a href="${ctx}/transport/listCar">车辆管理</a>
    </li>
    <li>
        <a href="#">编辑车辆</a>
    </li>
</nav>
        <div class="formtable">
            <form id="form1" action="${ctx}/transport/saveCar" method="post">
            <div class="formtable-cont">
                <h4 class="header">基本信息  <span class="fl_r mar_l30">最近一次操作时间：<odpf:formatDate style='DATE' date='${view.carBo.modifyTime}'/></span><span class="fl_r">最近一次操作人员：${view.carBo.userName}</span></h4>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require" >车牌号：</label>
                        <span class="col-sm-7 col-md-8 ">
                            <input class="form-control" id="carLicence" name="carLicence" value="${view.carBo.carLicence}">
                        </span>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require" >车辆类型：</label>
                        <span class="col-xs-6 ">
                            <select class="form-control" id="carType" name="carType">
                                <option value="">---请选择---</option>
                                <option  <c:if test="${view.carBo.carType==1}">selected</c:if>  value="1">围栏车</option>
                                <option <c:if test="${view.carBo.carType==2}">selected</c:if> value="2">冷藏车</option>
                                <option <c:if test="${view.carBo.carType==3}">selected</c:if> value="3">箱车</option>
                            </select>
                        </span>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">载重量：</label>
                        <span class="col-sm-7 col-md-8 no_pad">
                            <div class="col-sm-5 col-md-4">
                                <input class="form-control" id="carCapacity" name="carCapacity" value="${view.carBo.carCapacity}">
                            </div>
                            <b class="fl_l line_h46">
                                吨
                            </b>
                        </span>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">车辆国籍：</label>
                        <span class="col-sm-7 col-md-8 label-cont" id="carCountry" name="carCountry">
                            <label class="no_pad"><input type="radio" name="carCountry"  value="1" <c:if test="${view.carBo.carCountry==1}">checked</c:if> >中国</label>
                            <label class="no_pad"><input type="radio" name="carCountry"  value="2" <c:if test="${view.carBo.carCountry==2}">checked</c:if>>俄罗斯</label>
                        </span>
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2">常驻地：</label>
                    <div class="col-sm-10">
                        <div class="form-inline">
                            <div class="form-group">
                                <select class="form-control" id="countryId" name="countryId">
                                    <c:forEach var="country" items="${view.countryList}" >
                                        <option value="${country.constValue}" <c:if test="${view.carBo.countryId==country.constValue}">selected</c:if>>${country.constName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <select class="form-control" name="provinceId" size="1" id="provinceId">
                                    <option value="">---请选择省---</option>
                                    <c:forEach items="${view.provList}" var="prov">
                                        <option value="${prov.id}" <c:if test="${view.carBo.provinceId==prov.id}">selected</c:if> >
                                                ${prov.cnname}(${prov.enname})</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <select class="form-control" name="cityId" size="1" id="cityId">
                                    <option value="">---请选择市---</option>
                                    <c:forEach items="${view.cityList}" var="cityId">
                                        <option value="${cityId.id}" <c:if test="${view.carBo.cityId==cityId.id}">selected</c:if> >
                                                ${cityId.cnname}( ${cityId.enname})</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <select class="form-control" name="districtId" size="1" id="districtId">
                                    <option value="">---请选择区---</option>
                                    <c:forEach items="${view.distList}" var="dist">
                                        <option value="${dist.id}" <c:if test="${view.carBo.districtId==dist.id}">selected</c:if> >
                                                ${dist.cnname}(${dist.enname})</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                        <label class="col-sm-2">备注：</label>
                        <div class="col-sm-9">
                            <textarea class="form-control" rows="4" id="mark" name="remark">${view.carBo.remark}</textarea>
                        </div>
                </div>
                <input value="${view.carBo.id}" style="display: none" id="ids" name="id"/>
            <div class="formtable-cont text_c">
                <a href="${ctx}//transport/detailCar?type=detail&id=${view.carBo.id}" class="fl_l font_color--danger">取消返回上一步</a>
                <button class="btn btn-primary" id="submitCar" type="submit">保存</button>
            </div>
        </div>

      </form>
    </div>

<script type="text/javascript" src="${ctx}/resources/js/transport/updatecar.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>
