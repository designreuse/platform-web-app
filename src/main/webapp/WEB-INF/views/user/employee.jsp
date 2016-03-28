<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="${ctx}/resources/js/html5.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/respond.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/PIE_IE678.js"></script>
    <![endif]-->
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <!--[if IE 7]>
    <link href="${ctx}/resources/font/font-awesome-ie7.min.css" rel="stylesheet" type="text/css" />
    <![endif]-->
    <title>员工管理</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 用户中心 <span class="c-gray en">&gt;</span> 员工管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a></nav>
<div class="pd-20">
    <div class="text-l">
    <form action="${ctx}/user/employee"  method="post" class="searchform" id="searchform">
        <table width="100%" border="0" cellspacing="3" cellpadding="0">
            <tr>
                <td width="7%" height="46"> 姓名（中文）：</td>
                <td width="12%"><input type="text" class="input-text" style="width:150px" placeholder=""
                                       id="input" name="userNameCn" value="${entity.userNameCn}"></td>
                <td width="4%">手机：</td>
                <td width="12%"><input type="text" class="input-text" style="width:150px" placeholder=""
                                       id="input2" name="mobile" value="${entity.mobile}"></td>

                <td width="7%">服务执行部门：</td>
                <td width="14%">
                    <select class="select" name="deptId" size="1" style="width:100px">
                        <option value="" >全部</option>
                        <c:forEach items="${departmentList}" var="dept">
                            <option value="${dept.id}" <c:if test="${entity.deptId == dept.id}">selected</c:if>>${dept.deptName}</option>
                        </c:forEach>
                    </select>
                </td>
                <td width="5%">状态：</td>
                <td width="11%"><select class="select" name="disabled" size="1" style="width:100px">
                    <option value="" selected>全部</option>
                    <option value="0" <c:if test="${entity.disabled == false}">selected</c:if>>可用</option>
                    <option value="1" <c:if test="${entity.disabled == true}">selected</c:if>>停用</option>
                </select></td>
                <td width="6%"><button type="submit" class="btn btn-success" id="button" name=""><i class="icon-search"></i> 搜索</button></td>
            </tr>
        </table>

    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
        <span class="l"><a href="${ctx}/user/employee/edit" class="btn btn-primary radius"><i class="icon-plus"></i>添加员工</a></span>
        <span class="r">共有数据：<strong>${count}</strong> 条</span>
    </div>
    <table class="table table-border table-bordered table-hover table-bg table-sort">
        <thead>
        <tr class="text-c">
            <th width="144">用户名</th>
            <th width="57">性别</th>
            <th width="128">手机</th>
            <th width="139">邮箱</th>
            <th width="127">执行部门</th>
            <th width="145">身份验证</th>
            <th width="85">状态</th>
            <th width="115">创建时间</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${employeeList}" var="emp">
            <tr class="text-c">
                <td><a href="${ctx}/user/employee/edit?userId=${emp.userId}">${emp.userNameCn}<c:if test="${empty emp.userNameCn}">${emp.mobile}</c:if></a></td>
                <td><c:if test="${emp.sex == 0}">保密</c:if><c:if test="${emp.sex == 1}">男</c:if><c:if test="${emp.sex == 2}">女</c:if></td>
                <td>${emp.mobile}</td>
                <td>${emp.email}</td>
                <td>${emp.deptName}</td>
                <td><c:if test="${emp.mobileStatus == 1}"><img src="${ctx}/resources/images/icon_right_s.png"/></c:if>
                    <c:if test="${emp.mobileStatus == 0}"><img src="${ctx}/resources/images/icon_right_s2.jpg"/></c:if></td>
                <td class="user-status"><span class="label label-success">
                    <c:if test="${emp.disabled == false}">已启用</c:if>
                    <c:if test="${emp.disabled == true}">已禁用</c:if>
                </span></td>
                <td class="f-14 user-manage"><odpf:formatDate style='DATE_HOUR_SECOND' date='${emp.createTime}'/></td>
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
<script type="text/javascript" src="${ctx}/resources/js/pagenav.cn.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common/page.js"></script>
</body>
</html>