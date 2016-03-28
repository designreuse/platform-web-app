<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/8/18
  Time: 13:59
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <link type="text/css" href="${ctx}/resources/css/index.css" rel="stylesheet" />
    <link type="text/css" href="${ctx}/resources/css/labelauty.css" rel="stylesheet" />
    <title>企业信息编辑</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 会员中心 <span class="c-gray en">&gt;</span> 企业会员管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a> <span class="c-gray en">&gt;</span><a href="#">新增企业</a></nav>
<div class="pd-20">
<div id="message_position">
    <div id="position_fixed" class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l">
    <a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_a_click">
        基本信息</a>

    </span>
      </div>
</div>


<table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top">
    <thead>
    <tr class="text-l">
        <th width="106"><span class="l f-16">基本信息</span> <span class="r">
          <button class="btn btn-success radius" type="button" id="orgSubmit"><i class="icon-ok"></i> 保存</button>
          </span> </th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<table class="table table-border table-bordered table-hover table-bg">
    <tbody>
    <tr>
        <th class="text-r"><span class="c-red">*</span>企业身份：</th>
        <td colspan="3"><table width="100%" border="0" cellspacing="0" cellpadding="0" id="news_add_center">
            <tbody>
            <tr>
                <td width="65%">
                    <input type="checkbox" name="identityIdList" class="chklist"
                            <c:forEach items="${orgBo.identityIdList}" var="identityIdList">
                                <c:if test="${identityIdList ==3}"> checked="checked"</c:if></c:forEach>
                           value="3"/>
                    <label class="chkbox">
                        <span class="check-image"></span>
                        <span class="radiobox-content">供应商</span>
                    </label>
                    <input type="checkbox" name="identityIdList" class="chklist"
                            <c:forEach items="${orgBo.identityIdList}" var="identityIdList">
                                <c:if test="${identityIdList ==6}"> checked="checked"</c:if>
                            </c:forEach> value="6" />
                    <label class="chkbox">
                        <span class="check-image"></span>
                        <span class="radiobox-content">采购商</span>
                    </label>
                    <input type="checkbox" name="identityIdList" class="chklist"
                            <c:forEach items="${orgBo.identityIdList}" var="identityIdList">
                                <c:if test="${identityIdList ==4}"> checked="checked"</c:if>
                            </c:forEach> value="4" />
                    <label class="chkbox">
                        <span class="check-image"></span>
                        <span class="radiobox-content">代理商</span>
                    </label>
                    <input type="checkbox" name="identityIdList" class="chklist"
                            <c:forEach items="${orgBo.identityIdList}" var="identityIdList">
                                <c:if test="${identityIdList ==5}"> checked="checked"</c:if>
                            </c:forEach> value="5" />
                    <label class="chkbox">
                        <span class="check-image"></span>
                        <span class="radiobox-content">物流商</span>
                    </label>
                </td>
            </tr>
            </tbody>
        </table></td>
    </tr>
    <form id="orgForm" >
        <input type="hidden" value="${orgBo.id}" id="orgId" name="id">
        <tr>
            <th class="text-r" width="103"><span class="c-red">*</span>公司名称（中文）：</th>
            <td width="317">
                <input type="text" id="orgNameCn" name="orgNameCn" placeholder="公司名称（中文）" value="${orgBo.orgNameCn}" style="width:250px" class="input-text"></td>
            <td class="text-r" width="133">公司名称（俄文）：</td>
            <td width="324">
                <input type="text" id="orgNameRu" name="orgNameRu" placeholder="公司名称（俄文）" value="${orgBo.orgNameRu}" style="width:250px" class="input-text"></td>
        </tr>
        <tr>
            <th rowspan="2" class="text-r"><span class="c-red">*</span>公司地址（中文）：</th>
            <td rowspan="2">
                <select class="select"  size="1" style="width:150px" name="countryType" id="countrySelect">
                    <option value="1" <c:if test="${orgBo.countryType==1}">selected</c:if>>中国</option>
                    <option value="2" <c:if test="${orgBo.countryType==2}">selected</c:if>>俄罗斯</option>
                </select>
                <select class="select" name="provId" size="1" style="width:300px" id="provSelect">
                    <option value="">---请选择省---</option>
                    <c:forEach items="${provList}" var="prov">
                        <option value="${prov.id}" <c:if test="${orgBo.provId==prov.id}">selected</c:if> >
                                ${prov.cnname}(${prov.enname})</option>
                    </c:forEach>
                </select>
                <select class="select" name="cityId" size="1" style="width:150px" id="citySelect">
                    <option value="">---请选择市---</option>
                    <c:forEach items="${cityList}" var="city">
                        <option value="${city.id}" <c:if test="${orgBo.cityId==city.id}">selected</c:if> >
                                ${city.cnname}( ${city.enname})</option>
                    </c:forEach>
                </select>
                <select class="select" name="distId" size="1" style="width:300px" id="distSelect">
                    <option value="">---请选择区---</option>
                    <c:forEach items="${distList}" var="dist">
                        <option value="${dist.id}" <c:if test="${orgBo.distId==dist.id}">selected</c:if> >
                                ${dist.cnname}(${dist.enname})</option>
                    </c:forEach>
                </select>
            </td>
            <td class="text-r"><span class="c-red">*</span> 公司地址（中文）：</td>
            <td><input type="text" id="addrCn" name="addrCn" placeholder="公司地址（中文）" value="${orgBo.addrCn}" style="width:250px;margin-top:10px;" class="input-text">
            </td>
        </tr>
        <tr>
            <td class="text-r">公司地址（俄文）：</td>
            <td><input type="text" id="addrRu" name="addrRu" placeholder="公司地址（俄文）" value="${orgBo.addrRu}" style="width:250px;margin-top:10px;" class="input-text"></td>
        </tr>
        <tr>
            <th class="text-r">公司介绍（中文）：</th>
            <td>
                <textarea rows="5" cols="50" name="summaryCn">${orgBo.summaryCn}</textarea>
            </td>
            <td class="text-r">公司介绍（俄文）：</td>
            <td>
                <textarea rows="5" cols="50" name="summaryRu">${orgBo.summaryRu}</textarea>
            </td>
        </tr>
        <tr>
            <th class="text-r"><span class="c-red">*</span>公司法人：</th>
            <td><input type="text" id="corporation" name="corporation" placeholder="公司法人" value="${orgBo.corporation}" style="width:250px" class="input-text"></td>
            <td class="text-r"><span class="c-red">*</span>公司法人（拼音）： </td>
            <td><input type="text" name="corporationPy" id="website-static3" placeholder="公司法人（拼音）" value="${orgBo.corporationPy}" style="width:250px" class="input-text"></td>
        </tr>
        <tr>
            <th class="text-r"><span class="c-red">*</span>经营范围（中文）：</th>
            <td><input type="text" id="optRegion" name="optRegionCn" placeholder="经营范围（中文）" value="${orgBo.optRegionCn}" style="width:250px" class="input-text"></td>
            <td class="text-r">经营范围（俄文）： </td>
            <td><input type="text" id="website-static4" name="optRegionRu" placeholder="经营范围（俄文）" value="${orgBo.optRegionRu}" style="width:250px" class="input-text"></td>
        </tr>
        <tr>
            <th class="text-r">注册地（中文）：</th>
            <td><input type="text" id="corpRegaddr" name="corpRegaddrCn" placeholder="注册地（中文）" value="${orgBo.corpRegaddrCn}" style="width:250px" class="input-text"></td>
            <td class="text-r">注册地（俄文）： </td>
            <td><input type="text" id="website-static5" name="corpRegaddrRu" placeholder="注册地（俄文）" value="${orgBo.corpRegaddrRu}" style="width:250px" class="input-text"></td>
        </tr>
        <tr>
            <th class="text-r"><span class="c-red">*</span>税务登记号：</th>
            <td><input type="text" id="website-uploadfile" name="taxCert" placeholder="税务登记号" value="${orgBo.taxCert}" style="width:250px" class="input-text"></td>
            <td class="text-r"><font style="margin-left:20px;"><span class="c-red">*</span>挂靠资质</font>： </td>
            <td><input type="radio" name="isCanAnchored" checked class="shuiwu" value="1">
                <font>可挂靠</font>
                <input type="radio" name="isCanAnchored" class="shuiwu" value="0">
                <font>不可挂靠</font></td>
        </tr>

    </form>
    </tbody>
</table>

<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/position_top.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/labelauty.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common/dateformat.js"></script>
<script>
    window.ctx="${ctx}";
</script>
<script type="text/javascript" src="${ctx}/resources/js/enterprise/add.js"></script>
</div>
</body>
</html>
