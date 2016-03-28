<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <title>活动管理</title>
</head>
<body>
<%--nav_breadCrumb--%>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">内容中心</a>
    </li>
    <li>
        <a href="${ctx}/activity/list">活动管理</a>
    </li>
</nav>
<%--table_block--%>
<div id="queryBlock" class="pd-20 formtable" style="margin-left: auto;margin-right: auto">
    <%--table_tool--%>

    <div class="formtable">
            <div class="formtable-query mar_t20">
                <form class="form-inline">
                    <div class="form-group">
                        <label>标题：</label>
                        <input type="text" id="activityName" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>平台：</label>
                        <select class="form-control" id="appId" name="appId">
                            <option value="">全部</option>
                            <c:forEach var="plat" items="${activity.platTypes}">
                                <option value="${plat.constValue}">${plat.constName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>发布日期：</label>
                        <div class="input-group timepicker date wid-150" data-date-format="yyyy-mm-dd 00:00:00">
                            <input type="text"  class="form-control date-show" readonly style="margin: 0px;" >
                            <input id="startDate" class="get-time hide" type="text"/>
                            <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                        </div>
                        <em class="pad_10">-</em>
                        <div class="input-group timepicker date wid-150" data-date-format="yyyy-mm-dd 23:59:59">
                            <input type="text"  class="form-control date-show" readonly style="margin: 0px;">
                            <input id="endDate" class="get-time hide" type="text"/>
                            <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>状态：</label>
                        <select class="form-control" id="disabled" name="disabled">
                            <option value="">全部</option>
                            <c:forEach var="disabled" items="${activity.disableds}">
                                <option value="${disabled.constValue}">${disabled.constName}</option>
                            </c:forEach>
                        </select>
                    </div>
                      <div class="form-group">
                        <a href="#" class="btn btn-primary btn-sm wid-60" id="search">搜索</a>
                        <button type="reset" class="btn btn-primary btn-sm wid-60" id="reset">重置</button>
                        <a href="#" class="btn btn-primary btn-sm wid-60" id="add">新增</a>
                      </div>
                </form>
            </div>
        </div>
    <%--table_content--%>
    <div id="queryContent">
        <table id="easyUi_table" class="table table-bordered table-hover">

        </table>
    </div>
    <%--table_footer--%>
    <div id="queryPage" class="easyui-panel">
        <div id="page"></div>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
<script type="text/javascript" src="${ctx}/resources/js/activity/list.js"></script>
<script type="application/javascript" >

</script>
</html>
