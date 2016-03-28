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
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/plugin/My97DatePicker/skin/WdatePicker.css"/>
    <link type="text/css" href="${ctx}/resources/css/index.css" rel="stylesheet" />
    <link type="text/css" href="${ctx}/resources/css/labelauty.css" rel="stylesheet" />
    <script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
    <title>企业信息编辑</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 会员中心 <span class="c-gray en">&gt;</span> 企业会员管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a> <span class="c-gray en">&gt;</span><a href="#">企业会员编辑</a></nav>
<div class="pd-20">
<div id="message_position">
    <div id="position_fixed" class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l">
    <a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_a_click">
         基本信息</a>
    <a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
         从事行业</a>
    <a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
        服务范围</a>
    <a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click">
         审核</a>

    </span>
       <c:if test="${orgBo.id !=1}"><span class="r"> <a id="start" href="javascript:void(0)" target="_self" class="btn btn-primary radius" <c:if test="${orgBo.disabled ==false }">style="display:none"</c:if> > 启用</a> <a href="#"  id="forbidden" name="_self" class="btn btn-primary radius"<c:if test="${orgBo.disabled ==true}">style="display:none"</c:if>> 停用</a> </span></c:if>
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
        <th class="text-r"> <span class="c-red">*</span>企业身份：</th>
        <td colspan="3"><table width="100%" border="0" cellspacing="0" cellpadding="0" id="news_add_center">
            <tbody>
            <tr>
                <td width="65%">
                    <%--<c:forEach items="${identityList}" var="identity">--%>
                        <%--<input type="checkbox" name="identityIdList" class="chklist"--%>
                                <%--<c:forEach items="${myIdentityList}" var="identityIdList">--%>
                                    <%--<c:if test="${identityIdList.identityId == identity.identityId}"> checked="checked"</c:if></c:forEach>--%>
                               <%--value="${identity.identityId}" />--%>
                        <%--<label class="chkbox">--%>
                            <%--<span class="check-image"></span>--%>
                            <%--<span class="radiobox-content">${identity.identityName}</span>--%>
                    <%--</c:forEach>--%>




                    <input type="checkbox" name="identityIdList" class="chklist"
                            <c:forEach items="${myIdentityList}" var="identityIdList">
                                <c:if test="${identityIdList.identityId == 3}"> checked="checked"</c:if></c:forEach>
                           value="3" id="identity3"/>
                    <label class="chkbox">
                    <span class="check-image"></span>
                    <span class="radiobox-content">供应商</span>
                </label>
                    <input type="checkbox" name="identityIdList" class="chklist"
                            <c:forEach items="${myIdentityList}" var="identityIdList">
                                <c:if test="${identityIdList.identityId == 6}"> checked="checked"</c:if>
                            </c:forEach> value="6" id="identity6"/>
                    <label class="chkbox">
                        <span class="check-image"></span>
                        <span class="radiobox-content">采购商</span>
                    </label>
                    <input type="checkbox" name="identityIdList" class="chklist"
                            <c:forEach items="${myIdentityList}" var="identityIdList">
                                <c:if test="${identityIdList.identityId == 4}"> checked="checked"</c:if>
                            </c:forEach> value="4" id="identity4"/>
                    <label class="chkbox">
                        <span class="check-image"></span>
                        <span class="radiobox-content">代理商</span>
                    </label>
                    <input type="checkbox" name="identityIdList" class="chklist"
                            <c:forEach items="${myIdentityList}" var="identityIdList">
                                <c:if test="${identityIdList.identityId == 5}"> checked="checked"</c:if>
                            </c:forEach> value="5" id="identity5"/>
                    <label class="chkbox">
                        <span class="check-image"></span>
                        <span class="radiobox-content">物流商</span>
                    </label>
                </td>
            </tr>
            </tbody>
        </table></td>
    </tr>
    <form id="orgForm">
        <input type="hidden" id="identityJson" name="identityJson"/>
        <input type="hidden" value="${orgBo.id}" id="orgId" name="id">
    <tr>
        <th class="text-r">企业状态：</th>
        <td colspan="3">
            <%--<div class="State">--%>
                <ul>
                    <c:choose>
                        <c:when test="${orgBo.orgAdultStatus ==2}">
                            <li class="onshow">审核通过</li>
                        </c:when>
                        <c:when test="${orgBo.orgAdultStatus ==3}">
                            <li class="onshow">等待审核</li>
                        </c:when>
                        <c:when test="${orgBo.orgAdultStatus ==4}">
                            <li class="onshow">审核拒绝</li>
                        </c:when>
                        <c:otherwise>
                            <li class="state2">待初审</li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            <%--</div>--%>
            <input type="hidden" name="orgAdultStatus" value="${orgBo.orgAdultStatus}"/>
        </td>
    </tr>
    <tr>
        <th class="text-r" width="103"><span class="c-red">*</span>公司名称（中文）：</th>
        <td width="317"><input type="text" id="orgNameCn" name="orgNameCn" placeholder="" value="${orgBo.orgNameCn}" style="width:250px" class="input-text"></td>
        <td class="text-r" width="133">公司名称（俄文）：</td>
        <td width="324"><input type="text" id="orgNameRu" name="orgNameRu" placeholder="" value="${orgBo.orgNameRu}" style="width:250px" class="input-text"></td>
    </tr>
    <tr>
        <th rowspan="2" class="text-r"><span class="c-red">*</span>公司地址（中文）：</th>
        <td rowspan="2">
            <select class="select"  size="1" style="width:150px" name="countryType" id="countrySelect">
                <option value="1" <c:if test="${orgBo.countryType==1}">selected</c:if>>中国</option>
                <option value="2" <c:if test="${orgBo.countryType==2}">selected</c:if>>俄罗斯</option>
            </select>
            <select class="select" name="provId" size="1" style="width:150px" id="provSelect">
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
            <select class="select" name="distId" size="1" style="width:150px" id="distSelect">
                <option value="">---请选择区---</option>
                <c:forEach items="${distList}" var="dist">
                    <option value="${dist.id}" <c:if test="${orgBo.distId==dist.id}">selected</c:if> >
                            ${dist.cnname}(${dist.enname})</option>
                </c:forEach>
            </select>
           </td>
        <td class="text-r"><span class="c-red">*</span> 公司地址（中文）：</td>
        <td><input type="text" id="addrCn" name="addrCn" placeholder="" value="${orgBo.addrCn}" style="width:250px;margin-top:10px;" class="input-text">
        </td>
    </tr>
    <tr>
        <td class="text-r">
            <c:forEach items="${myIdentityList}" var="identityIdList">
                <c:if test="${identityIdList.identityId == 6}"><span class="c-red">*</span></c:if>
            </c:forEach>
            公司地址（俄文）：</td>
        <td><input type="text" id="addrRu" name="addrRu" placeholder="控制在25个字、50个字节以内" value="${orgBo.addrRu}" style="width:250px;margin-top:10px;" class="input-text"></td>
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
        <td><input type="text" id="corporation" name="corporation" placeholder="" value="${orgBo.corporation}" style="width:250px" class="input-text"></td>
        <td class="text-r"><span class="c-red">*</span>公司法人（拼音）： </td>
        <td><input type="text" name="corporationPy" id="corporationPy" placeholder="" value="${orgBo.corporationPy}" style="width:250px" class="input-text"></td>
    </tr>
    <tr>
        <th class="text-r"><span class="c-red">*</span>经营范围（中文）：</th>
        <td><input type="text" id="optRegionCn" name="optRegionCn" placeholder="" value="${orgBo.optRegionCn}" style="width:250px" class="input-text"></td>
        <td class="text-r">经营范围（俄文）： </td>
        <td><input type="text" id="website-static4" name="optRegionRu" placeholder="" value="${orgBo.optRegionRu}" style="width:250px" class="input-text"></td>
    </tr>
    <tr>
        <th class="text-r">注册地（中文）：</th>
        <td><input type="text" id="corpRegaddr" name="corpRegaddrCn" placeholder="" value="${orgBo.corpRegaddrCn}" style="width:250px" class="input-text"></td>
        <td class="text-r">注册地（俄文）： </td>
        <td><input type="text" id="website-static5" name="corpRegaddrRu" placeholder="" value="${orgBo.corpRegaddrRu}" style="width:250px" class="input-text"></td>
    </tr>
        <tr>
            <th class="text-r">注册时间：</th>
            <td colspan="3">
                <input type="text"
                value="<odpf:formatDate style='DATE' date='${orgBo.corpRegtime}'/>"
                onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true,readOnly:true,minDate:'1980',maxDate:'%y-%M-%d'})"
                id="corpRegtime" name="corpRegtime" class="input-text Wdate" style="width:260px;">
            </td>
        </tr>
    <tr>
        <th class="text-r"><span class="c-red">*</span>税务登记号：</th>
        <td><input type="text" id="taxCert" name="taxCert" placeholder="" value="${orgBo.taxCert}" style="width:250px" class="input-text"></td>
        <td class="text-r">
            <c:forEach items="${myIdentityList}" var="identityIdList">
                <c:if test="${identityIdList.identityId == 3}">
                    <font style="margin-left:20px;"><span class="c-red">*</span>挂靠资质</font>：
                </c:if>
            </c:forEach>
        </td>
        <td>
            <c:forEach items="${myIdentityList}" var="identityIdList">
                <c:if test="${identityIdList.identityId == 3}">
                    <input type="radio" name="isCanAnchored" <c:if test="${orgBo.isCanAnchored==1}">  checked="checked" </c:if> class="shuiwu" value="1">
                    <font>可挂靠</font>
                    <input type="radio" name="isCanAnchored" <c:if test="${orgBo.isCanAnchored==0}"> checked="checked" </c:if> class="shuiwu" value="0">
                    <font>不可挂靠</font>
                </c:if>
            </c:forEach>
        </td>
    </tr>


        </form>
    </tbody>
</table>
</form>
<div class="clear"></div>
<table class="table table-border table-bordered table-bg table-sort">
    <thead>
    <tr class="text-l">
        <th width="106" class="public_click_content">
            <span class="l f-16">企业资质</span> <span class="r">
            </span>
        </th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<table border="0" cellspacing="0" cellpadding="0" class="table table-border table-bordered table-bg table-sort">
    <tbody>
    <tr>
        <td width="186" class="text-r">营业执照： </td>
        <td width="200"><table width="72%" height="150" border="0" cellpadding="0" cellspacing="0" class="photo_bg" style="border:0px;margin:0px;padding:0px;">
            <tr>
                <td width="200" height="51" class="text-r">
                    <table width="200" border="0">
                    </table>
                    <table width="72%" height="150" border="0" cellpadding="0" cellspacing="0" class="photo_bg" style="border:0px;margin:0px;padding:0px;">
                        <tr>
                            <td width="194" class="upload_img" style="border:0px;margin:0px;padding:0px; text-align:center;">
                                <img src="${orgLicence.attaPath}" width="300" height="100" id="orgLicenceSrc" onclick="reOLUploadFro();"/>
                                <c:if test="${orgLicence.attaStatus != 2}">
                                    <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0" class="btn-uploadpic" name="file" multiple id="orgLicenceId">
                                </c:if>
                                <input type="hidden"  name="orgLicence" value="${orgLicence.attaPath}">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
            <table width="200" border="0">
                <tr>
                    <c:if test="${orgLicence.attaStatus == 2}">
                        <td style="border:0px;" class="photo_shenhe"><img src="${ctx}/resources/images/icon_right_s.png">审核通过&nbsp;</td>
                    </c:if>
                    <c:if test="${orgLicence.attaStatus != 2}">
                        <td style="border:0px;" class="photo_shenhe"><img src="${ctx}/resources/images/icon_right_s2.jpg">审核未通过&nbsp;</td>
                    </c:if>
                </tr>
            </table></td>
        <td width="186" class="text-r">税务登记证： </td>
        <td width="235">
            <table width="72%" height="150" border="0" cellpadding="0" cellspacing="0" class="photo_bg" style="border:0px;margin:0px;padding:0px;">
                <tr>
                    <td width="260" height="51" class="text-r">
                        <table width="200" border="0">
                        </table>
                        <table width="72%" height="150" border="0" cellpadding="0" cellspacing="0" class="photo_bg" style="border:0px;margin:0px;padding:0px;">
                            <tr>
                                <td width="194" class="upload_img" style="border:0px;margin:0px;padding:0px; text-align:center;">
                                    <img src="${taxCertificate.attaPath}" width="300" height="100" id="taxCertificateSrc" onclick="reTCUploadFro();"/>
                                    <c:if test="${taxCertificate.attaStatus != 2}">
                                        <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0" class="btn-uploadpic" name="file" multiple id="taxCertificateId">
                                    </c:if>
                                    <input type="hidden"  name="taxCertificate" value="${taxCertificate.attaPath}">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table width="200" border="0">
                <tr>
                    <c:if test="${taxCertificate.attaStatus == 2}">
                        <td style="border:0px;" class="photo_shenhe"><img src="${ctx}/resources/images/icon_right_s.png">审核通过&nbsp;</td>
                    </c:if>
                    <c:if test="${taxCertificate.attaStatus != 2}">
                        <td style="border:0px;" class="photo_shenhe"><img src="${ctx}/resources/images/icon_right_s2.jpg">审核未通过&nbsp;</td>
                    </c:if>
                </tr>
            </table>
        </td>
        <td width="176" class="text-r">组织机构代码证</td>
        <td width="235">
            <table width="72%" height="150" border="0" cellpadding="0" cellspacing="0" class="photo_bg" style="border:0px;margin:0px;padding:0px;">
                <tr>
                    <td width="260" height="51" class="text-r">
                        <table width="200" border="0">
                        </table>
                        <table width="72%" height="150" border="0" cellpadding="0" cellspacing="0" class="photo_bg" style="border:0px;margin:0px;padding:0px;">
                            <tr>
                                <td width="194" class="upload_img" style="border:0px;margin:0px;padding:0px; text-align:center;">
                                    <img src="${orgCertificate.attaPath}" width="300" height="100" id="orgCertificateSrc" onclick="reOCUploadFro();"/>
                                    <c:if test="${orgCertificate.attaStatus != 2}">
                                        <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0" class="btn-uploadpic" name="file" multiple id="orgCertificateId">
                                    </c:if>
                                    <input type="hidden"  name="orgCertificate" value="${orgCertificate.attaPath}">
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table width="200" border="0">
                <tr>
                    <c:if test="${orgCertificate.attaStatus == 2}">
                        <td style="border:0px;" class="photo_shenhe"><img src="${ctx}/resources/images/icon_right_s.png">审核通过&nbsp;</td>
                    </c:if>
                    <c:if test="${orgCertificate.attaStatus != 2}">
                        <td style="border:0px;" class="photo_shenhe"><img src="${ctx}/resources/images/icon_right_s2.jpg">审核未通过&nbsp;</td>
                    </c:if>
                </tr>
            </table>
        </td>
    </tr>
    </tbody>
</table>
<table class="table table-border table-bordered table-bg table-sort">
    <thead>
    <tr class="text-l">
        <th width="106" class="public_click_content"><span class="l f-16">从事行业</span> <span class="r">
          <button class="btn btn-success radius" type="button" id="industrySubmit"><i class="icon-ok"></i>保存</button>
        </span></th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<table class="table table-border table-bordered table-bg table-sort">
    <tbody>
        <tr>
            <th height="50" class="text-r">出口：</th>
            <td width="819"><div class="fuxuan">
                <c:forEach items="${industryEntities}" var="industryEntity">
                    <c:if test="${industryEntity.industryType == 1}">
                        <input type="checkbox" name="industryId" data-type="1" class="chklist" value="${industryEntity.industryId}"
                                <c:forEach items="${myIndustryList}" var="myIndustry">
                                    <c:if test="${myIndustry.industryId ==industryEntity.industryId}"> checked="checked"
                                    </c:if>
                                </c:forEach>/>
                        <label class="chkbox"> <span class="check-image"></span>
                            <span class="radiobox-content">${industryEntity.industryNameCn}</span> </label>
                    </c:if>
                </c:forEach>
            </div>
            </td>
        </tr>

        <tr>
            <th width="128" class="text-r">进口：</th>
            <td><div class="fuxuan">
                <c:forEach items="${industryEntities}" var="industryEntity">
                    <c:if test="${industryEntity.industryType == 2}">
                        <input type="checkbox" name="industryId" data-type="2" class="chklist" value="${industryEntity.industryId}"
                                <c:forEach items="${myIndustryList}" var="myIndustry">
                                    <c:if test="${myIndustry.industryId ==industryEntity.industryId }"> checked="checked"
                                    </c:if>
                                </c:forEach>/>
                        <label class="chkbox"> <span class="check-image"></span>
                            <span class="radiobox-content">${industryEntity.industryNameCn}</span> </label>
                    </c:if>
                </c:forEach>
            </div></td>
        </tr>
    </tbody>
</table>
<table class="table table-border table-bordered table-bg table-sort">
    <thead>
    <tr class="text-l">
        <th width="106" class="public_click_content"><span class="l f-16">服务范围</span> <span class="r">
          <button class="btn btn-success radius" type="button" id="serviceSubmit"><i class="icon-ok" ></i> 保存</button>
        </span></th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<form id="serviceForm">
<table class="table table-border table-bordered table-bg table-sort">
    <tbody>
    <tr>
        <th width="128" height="50" class="text-r"> 服务范围 ：</th>
        <td width="819"><div class="fuxuan">
            <c:forEach items="${serviceEntities}" var="serviceEntity">
                <input type="checkbox" name="serviceId" class="chklist"
                        <c:forEach items="${myServiceList}" var="myService">
                            <c:if test="${myService.serviceId ==serviceEntity.serviceId}"> checked="checked"
                            </c:if>
                        </c:forEach>  value="${serviceEntity.serviceId}"/>
                <label class="chkbox"> <span class="check-image"></span>
                    <span class="radiobox-content">${serviceEntity.srvNameCn}</span> </label>
            </c:forEach>
              </div>
        </td>
    </tr>
    </tbody>
</table>
</form>
    <%--<table class="table table-border table-bordered table-bg table-sort">--%>
    <%--<thead>--%>
    <%--<tr class="text-l">--%>
        <%--<th width="106" class="public_click_content"><span class="l f-16">其他资质</span> <span class="r">--%>
          <%--<button class="btn btn-success radius" type="button" id="orderService"><i class="icon-ok"></i> 保存</button>--%>
        <%--</span></th>--%>
    <%--</tr>--%>
    <%--</thead>--%>
    <%--<tbody>--%>
    <%--</tbody>--%>
    <%--</table>--%>
<%--<table class="table table-border table-bordered table-bg table-sort">--%>
    <%--<tbody>--%>
    <%--<tr>--%>
        <%--<td width="260" height="51" class="text-r">--%>
        <%--<input type="file" class="btn-uploadpic" name="" multiple id="attachment">--%>
        <%--<input type="text" class="input-text pt-20" id="attachmentName" style="width:150px" value="输入图片名称">点击上传限JPEG、PNG文件5M大小以内--%>
        <%--</td>--%>
    <%--</tr>--%>
    <%--</tbody>--%>
<%--</table>--%>
<table class="table table-border table-bordered table-bg table-sort">
    <thead>
    <tr class="text-l">
        <th width="106" class="public_click_content"><span class="l f-16">审核记录</span>
            <span class="r">
                <c:if test="${orgBo.orgAdultStatus == 1 || orgBo.orgAdultStatus == 3}">
                 <button  class="btn btn-primary radius public_examine"  onclick="adultShow(${orgBo.id});" type="button"  id="enterpriseSubmit"><i class="icon-ok"></i> 企业审核</button>
                </c:if>
            </span>
        </th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<table id="adult" class="table table-border table-bordered table-hover table-bg table-sort">
    <thead>
    <tr class="text-c">
        <th width="143">申请人</th>
        <th width="267">申请内容</th>
        <th width="291">申请时间</th>
        <th width="154">状态</th>
        <th width="139">审核人</th>
        <th width="213">审核时间</th>
        <th width="142">审核意见</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${adultList}" var="adultList" varStatus="varStatus">
        <c:if test="${adultList.applyType ==2 || adultList.applyType ==1}">
        <tr id="${adultList.id}">
            <td>${adultList.applyUserName}</td>
            <td>${adultList.applyContent}</td>
            <td><odpf:formatDate style="DATE_HOUR" date="${adultList.createTime}"/></td>
            <td><c:if test="${adultList.adultStatus ==0}">申请中</c:if><c:if test="${adultList.adultStatus ==1}">审核通过</c:if><c:if test="${adultList.adultStatus ==2}">审核拒绝</c:if></td>
            <td>${adultList.modifyUserName}</td>
            <td><odpf:formatDate style="DATE_HOUR" date="${adultList.modifyTime}"/></td>
            <td>${adultList.adultContent}</td>
        </tr>
        </c:if>
    </c:forEach>
    </tbody>
</table>
</div>

<div id="examine_box_bg"></div>
<div id="examine_box">
    <form id ="adultForm" method="post" action="${ctx}/enterprise/adult">
    <p><strong>审核</strong><em class="examine_close">X</em></p>
    <font>审核意见</font>
    <textarea id="adultContent" name="adultContent"></textarea>
    <input type="hidden" id="id" name="id">
    <input type="hidden" id="dynamicId" name="dynamicId">
    <input type="hidden" id="adultStatus" name="adultStatus">
    <input type="hidden" id="applyType" name="applyType">
    <div style="clear:both;"></div>
    <span>
    	<input type="button" id="success" value="通过" class="ent_adult" data_status="1">
    	<input type="button" id="error" class="examine_close ent_adult" value="拒绝" data_status="2">
	</span>
    </form>
</div>

<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/position_top.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/labelauty.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common/dateformat.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/validation/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/validation/jquery.maskedinput.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/validation/jquery.mockjax.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>

<script>
    window.ctx="${ctx}";
    if('${msg}' != ''){
        alert('${msg}');
    }

    $(document).on("change","#orgLicenceId",function(){
        var orgId = $("#orgId").val();
        upload(orgId,"orgLicence",1);
    });

    $(document).on("change","#taxCertificateId",function(){
        var orgId = $("#orgId").val();
        upload(orgId,"taxCertificate",2);
    });

    $(document).on("change","#orgCertificateId",function(){
        var orgId = $("#orgId").val();
        upload(orgId,"orgCertificate",3);
    });

    function upload(orgId,e,attaType){
        var $dom = $("#"+e+"Id");
        var id=$dom.attr("id");
        if (!/\.(gif|jpg|jpeg|png|bmp|GIF|JPG|PNG|BMP|JPEG)$/.test($dom.val())) {
            alert('"错误",hideClose:true,msgTitle: "请上传.jpg .jpeg .gif .png .bmp格式图像!"');
            return false;
        }
        if ($dom.get(0).files[0].size > 1024 * 1024 * 5){
            alert('不能上传超过5M的文件，您上传的文件过大，请重新上传！');
            $dom.val(null);
            return false;
        }
        $.ajaxFileUpload({
            url:"${ctx}/aldUpload/uploadImg",
            secureuri:false,
            fileElementId:id,
            dataType:"json",
            success: function(data){
                if(data.result){
                    var src= data.data.urlPath;
                    console.log($("[name='"+e+"']"))
                    console.log(src)
                    $("[name='"+e+"']").val(src);
                    $("#"+e+"Src").attr('src',src);
                    window.location.href="${ctx}/enterprise/orgAptitudeSave?orgId="+orgId+"&attaType="+attaType+"&attaPath="+src;
                }else{
                    alert("上传图片失败");
                }
            },error: function (xml, status, e){
                alert("上传图片失败");
            }
        });
    }

    function reOLUploadFro(){
        $("#orgLicenceId").trigger("click");
    }

    function reTCUploadFro(){
        $("#taxCertificateId").trigger("click");
    }

    function reOCUploadFro(){
        $("#orgCertificateId").trigger("click");
    }

</script>
<script type="text/javascript" src="${ctx}/resources/js/enterprise/edit.js"></script>
</body>
</html>