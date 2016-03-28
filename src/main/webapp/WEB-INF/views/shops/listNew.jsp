<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>会员中心-会员商铺</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">会员中心</a>
    </li>
    <li>
        <a href="${ctx}/shops/list">商铺管理</a>
    </li>
</nav>
<div class="container-fluid">
    <div class="formtable">
        <form class="formtable-query mar_t20">
            <div class="form-inline">
                <div class="form-group">
                    <label>商铺名称：</label>
                    <input id="shopsName" type="text" class="form-control">
                </div>
                <div class="form-group">
                    <label>所属公司：</label>
                    <input id="orgName" type="text" class="form-control">
                </div>
                <div class="form-group">
                    <label>管理人：</label>
                    <input id="userName" type="text" class="form-control">
                </div>
                <div class="form-group">
                    <label>从事行业：</label>
                    <select id="categoryId" name="categoryId" class="form-control">
                        <option value="">全部</option>
                        <c:forEach var="catalog" items="${view.catalogBos}">
                            <option value="${catalog.catalogId}" >${catalog.catalogNameCn}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>创建日期：</label>
                    <div class="input-group datepicker date wid-120">
                        <input id="startCreateDate" type="text" class="form-control" readonly style="margin: 0px;">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                    <em class="pad_10">-</em>
                    <div class="input-group datepicker date wid-120">
                        <input id="endCreateDate" type="text" class="form-control" readonly style="margin: 0px;">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                </div>
                <div class="form-group">
                    <label>审核：</label>
                    <select id="shopsStatus" class="form-control">
                        <option value="">全部</option>
                        <c:forEach var="auditStatus" items="${view.auditStatusList}">
                            <option value="${auditStatus.constValue}" <c:if test="${auditStatus.constValue == view.status}">selected</c:if> >${auditStatus.constName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>隶属关系：</label>
                    <select id="shopsType" class="form-control">
                        <option value="">全部</option>
                        <c:forEach var="memberShip" items="${view.memberShipList}">
                            <option value="${memberShip.constValue}">${memberShip.constName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>状态：</label>
                    <select id="disabled" class="form-control">
                        <option value="">全部</option>
                        <c:forEach var="status" items="${view.statusList}">
                            <option value="${status.constValue}">${status.constName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <a id="search" href="#" class="btn btn-primary btn-sm wid-60">搜索</a>
                    <a id="againSet" href="#" class="btn btn-primary btn-sm wid-60">重置</a>
                    <a id="addbtn"  href="${ctx}/shops/add" class="btn btn-primary btn-sm wid-60">新增</a>

                </div>
            </div>
        </form>
    </div>
    <div id="queryContent">
        <table id="easyUi_table">

        </table>
    </div>
    <div id="queryPage" class="easyui-panel">
        <div id="page"></div>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/shops/list.js"></script>
</body>
</html>