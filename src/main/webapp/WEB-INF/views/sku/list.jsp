<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>商品中心-商铺商品管理</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">商品中心</a>
    </li>
    <li>
        <a href="${ctx}/sku/list">商铺商品管理</a>
    </li>
</nav>
<div class="formtable">
    <div class="formtable-query mar_t20">
        <form class="form-inline">
            <div class="form-group">
                <label>商品名称：</label>
                <input id="skuName" type="text"  style="width:125px;height:30px"  class="form-control">
            </div>
            <%--<div class="form-group">
                <label style="width: 68px">HSCODE：</label>
                <input id="hscode" type="text"  style="width:125px;height:30px"  class="form-control">
            </div>--%>
            <div class="form-group">
                <label style="width: 60px">品类：</label>
                <select class="form-control float--l" style="width: 106px;" id="catalogIdFirst" name="catalogIdFirst">
                    <option value="">一级分类</option>
                    <c:forEach var="list" items="${view.catalogIdFirstList}">
                        <option value="${list.catalogId}">${list.catalogNameCn}</option>
                    </c:forEach>
                </select>
                <select id="catalogIdSecond" name="catalogIdSecond" class="form-control" name="catalog2"  style="width:105px">
                    <option value="">二级分类</option>
                    <%--<c:forEach items="${catalog2List}" var="catalog2List">--%>
                    <%--<option value="${catalog2List.catalogId}" <c:if test="${catalog2List.catalogId == catalog2.catalogId}">selected="selected" </c:if>>${catalog2List.catalogNameCn}</option>--%>
                    <%--</c:forEach>--%>
                </select>
                <select id="catalogId" name="catalogId" class="form-control" name="catalog3"  style="width:105px">
                    <option value="">三级分类</option>
                    <%--<c:forEach items="${catalog1List}" var="catalog1List">--%>
                    <%--<option value="${catalog1List.catalogId}" <c:if test="${catalog1List.catalogId == catalog1.catalogId}">selected="selected" </c:if>> >${catalog1List.catalogNameCn}</option>--%>
                    <%--</c:forEach>--%>
                </select>
            </div>
            <div class="form-group">
                <label>公司/个人：</label>
                <input type="text" id="orgName" style="width:125px;height:30px"  class="form-control">
            </div>
            <div class="form-group">
                <label style="width: 54px">审核：</label>
                <select id="skuStatus" style="width: 125px" class="form-control">
                    <option value="">全部</option>
                    <c:forEach var="skuStatus" items="${view.skuStatusList}">
                        <option value="${skuStatus.constValue}" <c:if test="${skuStatus.constValue == view.status}">selected</c:if> >${skuStatus.constName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>商铺名称：</label>
                <input type="text" id="shopsName" style="width:125px;height:30px"  class="form-control">
            </div>
            <div class="form-group">
                <label>发布日期：</label>
                <div class="input-group datepicker date wid-120">
                    <input id="releaseTimeStart" type="text" class="form-control" readonly style="margin: 0px;">
                    <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                </div>
                <em class="pad_10">-</em>
                <div class="input-group datepicker date wid-120">
                    <input id="releaseTimeEnd" type="text" class="form-control" readonly style="margin: 0px;">
                    <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                </div>
            </div>
            <div class="form-group">
                <label style="width: 67px">商品性质：</label>
                <select id="nature" style="width: 125px" class="form-control">
                    <option value="">全部</option>
                    <c:forEach var="nature" items="${view.natureList}">
                        <option value="${nature.constValue}">${nature.constName}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label>上/下架：</label>
                <select id="isOffline" style="width: 125px" class="form-control">
                    <option value="">全部</option>
                    <c:forEach var="isOffline" items="${view.isOfflineList}">
                        <option value="${isOffline.constValue}">${isOffline.constName}</option>
                    </c:forEach>
                </select>
            </div>

            <%--<div class="form-group">
                <label style="width: 65px">状态：</label>
                <select id="disabled" style="width: 100px" class="form-control">
                    <option value="">全部</option>
                    <c:forEach var="status" items="${view.statusList}">
                        <option value="${status.constValue}">${status.constName}</option>
                    </c:forEach>
                </select>
                </div>--%>
            <div class="form-group">
                <a id="search" href="#" class="btn btn-primary btn-sm wid-60">搜索</a>
                <a id="againSet" href="#" class="btn btn-primary btn-sm wid-60">重置</a>
                <a id="add" href="${ctx}/sku/add" class="btn btn-primary btn-sm wid-60">新增</a>

            </div>
        </form>
    </div>
    <div class="pad_10">
        <%--<input type="checkbox" id="allSelectBtn">
        <label>全选</label>--%>
        <a id="check" href="#" class="btn btn-primary btn-sm wid-30">审核通过</a>
    </div>
</div>

<div id="queryContent">
    <table id="easyUi_table">

    </table>
</div>
<div id="queryPage" class="easyui-panel">
    <div id="page"></div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/sku/list_new.js"></script>
</body>
</html>