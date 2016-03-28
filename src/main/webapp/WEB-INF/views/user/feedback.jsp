<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>会员中心-留言管理</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">会员中心</a>
    </li>
    <li>
        <a href="${ctx}/userFeedback/list">留言管理</a>
    </li>
</nav>
<div class="formtable">
    <div class="formtable-query mar_t20">
        <form class="form-inline">
            <div class="form-group">
                <label style="width: 60px">联系人：</label>
                    <input class="form-control" style="width: 152px" type="text" id="contactName">
            </div>
            <div class="form-group">
                <label style="width: 60px">企业：</label>
                    <input class="form-control" type="text" id="orgName">
            </div>
            <div class="form-group">
                <label>手机号：</label>
                    <input class="form-control" type="text" id="contactTel">
            </div>
            <div class="form-group">
            <label>留言平台：</label>
                <select  class="form-control" style="width: 149px" id="app">
                    <option value="">全部</option>
                    <c:forEach items="${view.platTypeList}" var="type">
                        <option value="${type.constValue}">${type.constName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>留言类型：</label>
                <select class="form-control" style="width: 152px" id="type">
                    <option value="">全部</option>
                    <c:forEach items="${view.feedbackTypeList}" var="type">
                        <option value="${type.constValue}">${type.constName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>留言日期：</label>
                <div class="input-group datepicker date wid-120">
                    <input type="text" id="createTimeStart"  class=" form-control" readonly>
                    <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                </div>
                <em class="pad_10">-</em>
                <div class="input-group datepicker date wid-120">
                    <input type="text" id="createTimeEnd"  class=" form-control" readonly>
                    <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                </div>
            </div>
            <div class="form-group">
                <a id="search" href="#" class="btn btn-primary btn-sm wid-60">搜索</a>
                <a id="againSet" href="#" class="btn btn-primary btn-sm wid-60">重置</a>
            </div>
        </div>
        </form>
    </div>

</div>
<div id="queryContent">
    <table id="easyUi_table">

    </table>
</div>
<div id="queryPage" class="easyui-panel">
    <div id="page"></div>
</div>
<script type="text/javascript" src="${ctx}/resources/js/user/feedback.js"></script>
<script>
    $(function(){

    })
</script>
</body>

</html>