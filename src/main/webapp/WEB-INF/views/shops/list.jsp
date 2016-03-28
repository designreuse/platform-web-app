<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>商铺管理</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 会员中心 <span class="c-gray en">&gt;</span> 商铺管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a></nav>
<form action="${ctx}/shops/list"  method="post" id="searchform" class="searchform">
<div class="pd-20">
    <div class="text-l">
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr>
                    <td width="7%" height="44">商铺名称：</td>
                    <td width="23%"><input type="text" class="input-text" style="width:222px" placeholder="输入店铺名称" id="input" name="shopsNameCn" value="${shopsEntity.shopsNameCn}"></td>
                    <td width="7%">所属公司：</td>
                    <td width="18%"><input type="text" class="input-text" style="width:170px" placeholder="输入公司名" id="input2" name="orgNameCn" value="${shopsEntity.orgNameCn}"></td>
                    <td width="6%">管理人：</td>
                    <td width="13%"><input type="text" class="input-text" style="width:110px" placeholder="输入姓名" id="input3" name="userNameCn" value="${shopsEntity.userNameCn}"></td>
                    <td width="7%">手机号：</td>
                    <td width="18%"><input type="text" class="input-text" style="width:150px" placeholder="手机号" id="input4" name="mobile" value="${shopsEntity.mobile}"></td>
                </tr>
                <tr>
                    <td height="46">日期范围：</td>
                    <td><input type="text" onFocus="WdatePicker({isShowClear:true,readOnly:true})"
                                           value="<odpf:formatDate style='DATE' date='${shopsEntity.createTimeBegin}'/>"  name="createTimeBegin" id="datemin" class="input-text Wdate" style="width:100px;">
                        -
                        <input type="text" onFocus="WdatePicker({isShowClear:true,readOnly:true})"
                               value="<odpf:formatDate style='DATE' date='${shopsEntity.createTimeEnd}'/>" name="createTimeEnd" id="datemax" class="input-text Wdate" style="width:100px;"></td>
                    <td>审核：</td>
                    <td><select class="select" name="shopsStatus" size="1" style="width:120px" >
                        <option value="">全部</option>
                        <option value="1" <c:if test="${shopsEntity.shopsStatus == 1}">selected</c:if>>待初审</option>
                        <option value="2" <c:if test="${shopsEntity.shopsStatus == 2}">selected</c:if>>已通过</option>
                        <option value="3" <c:if test="${shopsEntity.shopsStatus == 3}">selected</c:if>>待审核</option>
                        <option value="4" <c:if test="${shopsEntity.shopsStatus == 4}">selected</c:if>>已拒绝</option>
                    </select></td>
                    <td>状态：</td>
                    <td><select class="select" name="disabled" size="1" style="width:120px">
                        <option value="">全部</option>
                        <option value="0" <c:if test="${shopsEntity.disabled == 0}">selected</c:if>>可用</option>
                        <option value="1" <c:if test="${shopsEntity.disabled == 1}">selected</c:if>>停用</option>
                    </select></td>
                    <td>隶属关系：</td>
                    <td><select class="select" name="shopsType" size="1" style="width:120px">
                        <option value="">全部</option>
                        <option value="1" <c:if test="${shopsEntity.shopsType == 1}">selected</c:if>>隶属</option>
                        <option value="2" <c:if test="${shopsEntity.shopsType == 2}">selected</c:if>>挂靠</option>
                    </select></td>
                    <td><button type="submit" class="btn btn-success" id="button" name="">
                        <i class="icon-search"></i> 搜索</button></td>
                </tr>

            </table>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
        <a href="${ctx}/shops/add" class="btn btn-primary radius"><i class="icon-plus"></i> 新增店铺</a>
        <span class="r">共有数据：<strong>${count}</strong> 条</span> </div>
    <table class="table table-border table-bordered table-hover table-bg table-sort">
        <thead>
        <tr class="text-c">
            <th width="106">商铺名称</th>
            <th width="107">所属公司</th>
            <th width="100">管理人姓名</th>
            <th width="183">管理人联系方式</th>
            <th width="58">隶属关系</th>
            <th width="58">审核</th>
            <th width="104">加入时间</th>
            <th width="85">状态</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${shopsList}" var="shops">
            <tr class="text-c">
                <td><a href="${ctx}/shops/edit/${shops.shopsId}">${shops.shopsNameCn}</a></td>
                <td><a href="${ctx}/enterprise/${shops.orgId}/edit">${shops.orgNameCn}</a></td>
                <td><a href="${ctx}/user/${shops.userId}/edit">${shops.userNameCn}</a></td>
                <td>手机：${shops.mobile}<br/>
                    邮箱：${shops.email} </td>
                <td><c:if test="${shops.shopsType == 1}">隶属</c:if>
                    <c:if test="${shops.shopsType == 2}">挂靠</c:if></td>
                <td>
                    <c:if test="${shops.shopsStatus == 1}">待初审</c:if>
                    <c:if test="${shops.shopsStatus == 2}">审核通过</c:if>
                    <c:if test="${shops.shopsStatus == 3}">待审核</c:if>
                    <c:if test="${shops.shopsStatus == 4}">审核拒绝</c:if>
                </td>
                <td>
                    <odpf:formatDate style="DATE_HOUR_SECOND" date="${shops.createTime}"/>
                </td>
                <td class="user-status">
                    <c:if test="${shops.disabled == 0}"><span class="label label-success">可用</span></c:if>
                    <c:if test="${shops.disabled == 1}"><span class="label label-danger">停用</span></c:if>
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
<script type="text/javascript" src="${ctx}/resources/js/pagenav.cn.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common/page.js"></script>
<script type="text/javascript">
    $(function(){
        if('${msg}' != ''){
            alert('${msg}');
        }
    });
</script>
</body>
</html>