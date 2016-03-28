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
    <link href="${ctx}/resources/css/index.css" rel="stylesheet" />
    <link href="${ctx}/resources/css/labelauty.css" rel="stylesheet" />
    <title>企业会员管理</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 会员中心 <span class="c-gray en">&gt;</span> 个人会员管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a></nav>
<form action="${ctx}/user/list" class="searchform" id="searchform">
<div class="pd-20">
    <div class="text-l">
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr>
                    <td width="6%" height="44">公司名称：</td>
                    <td width="24%"><input type="text" class="input-text" style="width:222px" placeholder="输入公司名称" id="orgName" name="orgName" value="${userVo.orgName}"></td>
                    <td width="4%">姓名：</td>
                    <td width="12%"><input type="text" class="input-text" style="width:120px" placeholder="输入姓名" id="userNameCn" name="userNameCn" value="${userVo.userNameCn}"></td>
                    <td width="5%">手机号：</td>
                    <td width="17%"><input type="text" class="input-text" style="width:150px" placeholder="手机号/邮箱" id="mobile" name="mobile" value="${userVo.mobile}"></td>
                    <td width="6%">注册来源：</td>
                    <td width="17%" colspan="3">
                        <select class="select" id="regSource" name="regSource" size="1" style="width:100px">
                            <option value="">全部</option>
                            <option value="3" <c:if test="${userVo.regSource ==3}">selected</c:if>>中文站点</option>
                            <option value="5" <c:if test="${userVo.regSource ==5}">selected</c:if>>俄文站点</option>
                            <option value="2" <c:if test="${userVo.regSource ==2}">selected</c:if>>运营平台</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td height="46">日期范围：</td>
                    <td>
                        <input type="text"
                               onFocus="WdatePicker({isShowClear:true,readOnly:true})"
                               id="dateMin" name="dateMin" class="input-text Wdate" style="width:100px;"
                               value="<odpf:formatDate style='DATE' date='${userVo.dateMin}'/>">
                        -
                        <input type="text"
                               onFocus="WdatePicker({isShowClear:true,readOnly:true})"
                               id="dateMax" name="dateMax" class="input-text Wdate" style="width:100px;"
                               value="<odpf:formatDate style='DATE' date='${userVo.dateMax}'/>">

                    </td>
                    <td>审核：</td>
                    <td><select class="select" id="statusType" name="statusType" size="1" style="width:100px">
                        <option value="" selected>全部</option>
                        <option value="0" <c:if test="${userVo.statusType == 0 }">selected="selected" </c:if>>侍审核</option>
                        <option value="1"<c:if test="${userVo.statusType == 1}">selected="selected" </c:if>>已审核</option>
                        <option value="2"<c:if test="${userVo.statusType == 2}">selected="selected" </c:if>>已拒绝</option>
                    </select></td>
                    <td>状态：</td>
                    <td><select class="select" id="accountState" name="accountState" size="1" style="width:100px">
                        <option value="" selected>全部</option>
                        <option value="1"<c:if test="${userVo.accountState == 1 }">selected="selected" </c:if>>可用</option>
                        <option value="2"<c:if test="${userVo.accountState == 2 }">selected="selected" </c:if>>停用</option>
                    </select></td>
                    <td>隶属关系：</td>
                    <td>
                        <select class="select" id="entUserStatus" name="entUserStatus" size="1" style="width:100px">
                        <option value="" selected>全部</option>
                        <option value="0" <c:if test="${userVo.entUserStatus == 0}">selected="selected" </c:if>>无企业信息</option>
                        <option value="1" <c:if test="${userVo.entUserStatus == 1 }">selected="selected" </c:if>>隶属</option>
                        <option value="2" <c:if test="${userVo.entUserStatus == 2 }">selected="selected" </c:if>>挂靠</option>
                    </select>
                    </td>
                    <td width="5%">&nbsp;</td>
                    <td><button type="button" class="btn btn-success" id="submitform"><i class="icon-search"></i> 搜索</button></td>
                </tr>
            </table>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
    <a href="${ctx}/user/add" class="btn btn-primary radius"><i class="icon-plus"></i> 新增个人会员</a>
        <span class="r">共有数据：<strong>${count}</strong> 条</span>
    </div>
    <table class="table table-border table-bordered table-hover table-bg table-sort">
        <thead>
        <tr class="text-c">
            <th width="135">姓名</th>
            <th width="116">公司名称</th>
            <th width="146">联系方式</th>
            <th width="72">注册来源</th>
            <th width="67">隶属关系</th>
            <th width="63">审核</th>
            <th width="65">加入时间</th>
            <th width="85">状态</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${userList}" var="userList" varStatus="varStatus">
            <tr>
                <c:choose>
                    <c:when test="${userList.regSource == 3 || userList.regSource == 6}">
                        <td><a href="${ctx}/user/${userList.userId}/edit">${userList.userNameCn}<c:if test="${empty userList.userNameCn}">${userList.mobile}</c:if></a></td>
                        <td>${userList.orgNameCn}</td>
                        <td>
                            <c:if test="${not empty userList.mobile}">
                                电话号码：${userList.mobile}
                            </c:if>
                            <c:if test="${not empty userList.email}">
                                &nbsp;&nbsp;邮箱：${userList.email}
                            </c:if>
                        </td>
                        <td>中文站点</td>
                    </c:when>
                    <c:when test="${userList.regSource == 5 || userList.regSource == 7}">
                        <td><a href="${ctx}/user/${userList.userId}/edit">${userList.userNameFirst}&nbsp;${userList.userNameLast}<c:if test="${empty userList.userNameFirst}">${userList.email}</c:if></a></td>
                        <td>${userList.orgNameRu}</td>
                        <td>
                            <c:if test="${not empty userList.mobile}">
                                电话号码：${userList.mobile}
                            </c:if>
                            <c:if test="${not empty userList.email}">
                                &nbsp;&nbsp;邮箱：${userList.email}
                            </c:if>
                        </td>
                        <td>俄文站点</td>
                    </c:when>
                    <c:otherwise>
                        <td><a href="${ctx}/user/${userList.userId}/edit">${userList.userNameCn}<c:if test="${empty userList.userNameCn}">${userList.mobile}</c:if></a></td>
                        <td>${userList.orgNameCn}</td>
                        <td>
                            <c:if test="${not empty userList.mobile}">
                                电话号码：${userList.mobile}
                            </c:if>
                            <c:if test="${not empty userList.email}">
                                &nbsp;&nbsp;邮箱：${userList.email}
                            </c:if>
                        </td>
                        <td>运营站点</td>
                    </c:otherwise>
                </c:choose>
                <td>
                    <c:choose>
                        <c:when test="${userList.entUserStatus == 1}">
                            隶属
                        </c:when>
                        <c:when test="${userList.entUserStatus == 2}">
                            挂靠
                        </c:when>
                        <c:otherwise>
                            无企业信息
                        </c:otherwise>
                    </c:choose>
                    <br>
                    <c:choose>
                        <c:when test="${userList.userType == 1}">
                            申请绑定
                        </c:when>
                        <c:when test="${userList.userType == 2}">
                            已绑定
                        </c:when>
                        <c:when test="${userList.userType == 3}">
                            申请解除
                        </c:when>
                        <c:when test="${userList.userType == 4}">
                            已解除
                        </c:when>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${userList.statusType == 1}">
                            已审核
                        </c:when>
                        <c:when test="${userList.statusType == 2}">
                            已拒绝
                        </c:when>
                        <c:otherwise>
                            待审核
                        </c:otherwise>
                    </c:choose>
                </td>
                <td><odpf:formatDate style="DATE_HOUR_SECOND" date="${userList.createTime}"/></td>
                <td class="user-status">
                    <c:choose>
                        <c:when test="${userList.accountState == 1}">
                            <span class="label label-success">可用</span>
                        </c:when>
                        <c:when test="${userList.accountState == 2}">
                            <span class="label label-success">停用</span>
                        </c:when>
                        <c:otherwise>
                            <span class="label label-success">黑名单</span>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <script type="text/javascript" src="${ctx}/resources/js/page/page-common.js"></script>
    <tags:pageComponent pageNumber="${page.currentPage}" pageSize="${page.pageSize}" totalRows="${count}"/>
</div>
</form>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/layer/layer.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/user/list.js"></script>
</body>
</html>