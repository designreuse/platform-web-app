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
    <title>企业会员管理</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 会员中心 <span class="c-gray en">&gt;</span> 企业会员管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a></nav>
<form action="${ctx}/enterprise/list" class="searchform"  method="post" id="searchform">
<div class="pd-20">
    <div class="text-l">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tbody>
            <tr>
                <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="7%">
                                公司名称：
                            </td>
                            <td  width="33%"><input type="text" class="input-text" style="width:220px" placeholder="输入公司名称" id="orgNameCn" name="orgNameCn" value="${orgVo.orgNameCn}"></td>
                            <td width="7%">
                                日期范围：
                            </td>
                            <td width="24%">
                                <input type="text"
                                       value="<odpf:formatDate style='DATE' date='${orgVo.dateMin}'/>"
                                       onFocus="WdatePicker({isShowClear:true,readOnly:true})"
                                       id="datemin" name="dateMin" class="input-text Wdate" style="width:100px;">
                                -
                                <input type="text"
                                       value="<odpf:formatDate style='DATE' date='${orgVo.dateMax}'/>"
                                       onFocus="WdatePicker({isShowClear:true,readOnly:true})"
                                       id="datemax" name="dateMax" class="input-text Wdate" style="width:100px;">
                            </td>
                            <td width="7%">注册来源：</td>
                            <td width="10%">
                                <select class="select" id="countryType" name="countryType" size="1" style="width:100px">
                                <option value=""  <c:if test="${not empty orgVo.countryType}">selected</c:if>>全部</option>
                                <option value="1" <c:if test="${orgVo.countryType ==1}">selected</c:if>>中文站点</option>
                                <option value="2" <c:if test="${orgVo.countryType ==2}">selected</c:if>>俄文站点</option>
                            </select>
                            </td>

                            </td>
                        </tr>

                        <tr>
                            <td height="60" >企业身份：</td>
                            <td>
                                <c:forEach items="${identityList}" var="identity">
                                    <input type="checkbox" name="identityIdList" class="chklist"
                                        <c:forEach items="${orgVo.identityIdList}" var="identitys">
                                            <c:choose>
                                                <c:when test="${identityIdList.identityId == identity.identityId}"> checked="checked"</c:when>
                                                <c:when test="${identitys == identity.identityId}">checked = "checked"</c:when>
                                            </c:choose>
                                        </c:forEach>
                                        value="${identity.identityId}" />
                                    <label class="chkbox">
                                        <span class="check-image"></span>
                                        <span class="radiobox-content">${identity.identityName}</span>
                                    </label>
                                </c:forEach>
                            </td>
                            <td> 状态：</td>
                            <td>
                                <select class="select" name="orgStatus" id = "orgStatus" size="1" style="width:100px">
                                    <option value=""  <c:if test="${not empty orgVo.orgStatus}">selected</c:if>>全部</option>
                                    <option value="1" <c:if test="${orgVo.orgStatus ==1}">selected</c:if>>已启用</option>
                                    <option value="2" <c:if test="${orgVo.orgStatus ==2}">selected</c:if>>已停用</option>
                                </select>
                            </td>
                            <td width="7%"> 审核：</td>
                            <td width="16%"><select class="select" id="orgAdultStatus" name="orgAdultStatus" size="1" style="width:100px">
                                <option value=""  <c:if test="${not empty orgVo.orgAdultStatus}">selected</c:if>>全部</option>
                                <option value="1" <c:if test="${orgVo.orgAdultStatus ==1}">selected</c:if>>待初审</option>
                                <option value="2" <c:if test="${orgVo.orgAdultStatus ==2}">selected</c:if>>已通过</option>
                                <option value="3" <c:if test="${orgVo.orgAdultStatus ==3}">selected</c:if>>待审核</option>
                                <option value="4" <c:if test="${orgVo.orgAdultStatus ==4}">selected</c:if>>已拒绝</option>
                            </select>
                            <td colspan="6">
                                <button type="button" class="btn btn-success" id="submitform" name="submitform"><i class="icon-search"></i>搜索</button>
                            </td>
                        </tr>

                    </table>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
        <a href="${ctx}/enterprise/add" class="btn btn-primary radius"><i class="icon-plus"></i> 新增企业</a></span>
        <span class="r">共有数据：<strong>${count}</strong> 条</span>
    </div>
    <table class="table table-border table-bordered table-hover table-bg table-sort">
        <thead>
        <tr class="text-c">
            <th width="267">公司名称</th>
            <th width="291">企业身份</th>
            <th width="154">注册来源</th>
            <th width="139">审核</th>
            <th width="213">创建时间</th>
            <th width="142">状态</th>
            <th width="142">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${orgList}" var="orgList" varStatus="varStatus">
            <tr>
                <c:choose>
                    <c:when test="${orgList.countryType == 2}">
                        <td><a href="${ctx}/enterprise/${orgList.id}/edit">${orgList.orgNameRu}</a></td>
                        <td>${orgList.identityName}</td>
                        <td>俄文站点</td>
                    </c:when>
                    <c:otherwise>
                        <td><a href="${ctx}/enterprise/${orgList.id}/edit">${orgList.orgNameCn}</a></td>
                        <td>${orgList.identityName}</td>
                        <td>中文站点</td>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${orgList.orgAdultStatus == 2}">
                        <td>审核通过</td>
                    </c:when>
                    <c:when test="${orgList.orgAdultStatus == 3}">
                        <td>等待审核</td>
                    </c:when>
                    <c:when test="${orgList.orgAdultStatus == 4}">
                        <td>审核拒绝</td>
                    </c:when>
                    <c:otherwise>
                        <td>待初审</td>
                    </c:otherwise>
                </c:choose>
                <td><odpf:formatDate style="DATE_HOUR_SECOND" date="${orgList.createTime}"/></td>
                <td class="user-status"><span class="label label-success"><c:if test="${orgList.disabled ==true}">已停用</c:if><c:if test="${orgList.disabled ==false}">已启用</c:if></span></td>
                <td>
                    <c:if test="${orgList.orgAdultStatus == 1 || orgList.orgAdultStatus == 3}">
                        <a href="${ctx}/enterprise/${orgList.id}/edit"  class="btn btn-primary radius public_examine"   id="enterpriseSubmit"> 企业审核</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <script type="text/javascript" src="${ctx}/resources/js/page/page-common.js"></script>
    <tags:pageComponent pageNumber="${page.currentPage}" pageSize="${page.pageSize}" totalRows="${count}"/>

</div>
</form>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/layer/layer.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/labelauty.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/enterprise/list.js"></script>

</body>
</html>