<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>园区中心-车辆详细</title>

</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">园区中心</a>
    </li>
    <li>
        <a href="${ctx}/transport/listCar">车辆管理</a>
    </li>
</nav>
<div class="formtable">
    <div class="formtable-cont">
        <h4 class="header header-fl">基本信息 <div class="fl_r mar_l30" style="margin-right:100px">最近一次操作人员：${view.carBo.userName}
             </div><div class="fl_r">最近一次操作时间：<odpf:formatDate style='DATE' date='${view.carBo.modifyTime}'/></div>
        </h4>
        <c:if test="${view.carBo.disabled == false}"><button onclick="changeCarStauts(${view.carBo.id},${view.carBo.disabled})" type="button" class="btn btn-danger header-button status">停用</button></c:if>
        <c:if test="${view.carBo.disabled == true}"><button onclick="changeCarStauts(${view.carBo.id},${view.carBo.disabled})" type="button" class="btn btn-success  header-button status">启用</button></c:if>
        <div class="clear"></div>
        <div class="formtable-list">
            <div class="col-xs-6">
                <label class="col-sm-5 col-md-4 formtable-list-require">车牌号：</label>
                <div class="col-sm-7 col-md-8 label-cont">${view.carBo.carLicence}</div>
            </div>
            <div class="col-xs-6">
                <label class="col-sm-5 col-md-4 formtable-list-require">车辆类型：</label>
                <div class="col-xs-6 label-cont">
                    <c:if test="${view.carBo.carType==1}">围栏车</c:if>
                    <c:if test="${view.carBo.carType==2}">冷藏车</c:if>
                    <c:if test="${view.carBo.carType==3}">箱车</c:if>
                </div>
            </div>
        </div>
        <div class="formtable-list">
            <div class="col-xs-6">
                <label class="col-sm-5 col-md-4 formtable-list-require">载重量：</label>
                <div class="col-sm-7 col-md-8 label-cont">${view.carBo.carCapacity}吨</div>
            </div>
            <div class="col-xs-6">
                <label class="col-sm-5 col-md-4 formtable-list-require">车辆国籍：</label>
                <div class="col-sm-7 col-md-8 label-cont">
                    <c:if test="${view.carBo.carCountry==1}">中国</c:if>
                    <c:if test="${view.carBo.carCountry==2}">俄罗斯</c:if>
                </div>
            </div>
        </div>
        <div class="formtable-list">
                <label class="col-sm-2">常驻地：</label>
                <div class="col-sm-10 label-cont">
                    <span>
                        <c:forEach var="country" items="${view.countryList}" >
                            <c:if test="${view.carBo.countryId==country.constValue}">${country.constName}</c:if>
                        </c:forEach>
                    </span>
                    <span class="mar_l15">
                        <c:forEach items="${view.provList}" var="prov">
                            <c:if test="${view.carBo.provinceId==prov.id}"> ${prov.cnname}</c:if>
                        </c:forEach>
                    </span>
                    <span class="mar_l15">
                        <c:forEach items="${view.cityList}" var="cityId">
                            <c:if test="${view.carBo.cityId==cityId.id}">${cityId.cnname}</c:if>
                        </c:forEach>
                    </span>
                    <span class="mar_l15">
                        <c:forEach items="${view.distList}" var="dist">
                            <c:if test="${view.carBo.districtId==dist.id}">${dist.cnname}</c:if>
                        </c:forEach>
                    </span>
                </div>
        </div>
        <div class="formtable-list">
                <label class="col-sm-2">备注：</label>
                <div class="col-sm-10 label-cont">
                    ${view.carBo.remark}
                </div>
        </div>
    </div>
    <div class="formtable-cont text_c">
        <a href="${ctx}/transport/listCar" class="fl_l font_color--danger">取消返回上一步</a>
        <button class="btn btn-primary" onclick="update()">编辑</button>
    </div>

    <input value="${view.carBo.id}" style="display: none" id="ids" name="id"/>
</div>

<script type="text/javascript" src="${ctx}/resources/js/transport/updatecar.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>
