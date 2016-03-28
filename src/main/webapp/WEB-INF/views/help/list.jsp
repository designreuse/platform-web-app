<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <title>帮助中心管理</title>
</head>
<body>
<%--nav_breadCrumb--%>
<ul class="breadcrumb">您当前位置：

    <li>
        <a href="#">内容中心</a>
    </li>
    <li>
        <a href="${ctx}/help/list">帮助中心管理</a>
    </li>
</ul>
<%--table_block--%>
<div id="queryBlock" class="pd-20 formtable" style="margin-left: auto;margin-right: auto">
    <%--table_tool--%>

    <div id="queryParam" class="formtable">
        <div class="formtable-query mar_t20">
            <form class="form-inline">
                <div class="form-group">
                    <label>问题标题：</label>
                    <input type="text" id="problem" class="form-control">
                </div>
                <div class="form-group">
                    <label>平台：</label>
                    <select class="form-control" id="appId">
                        <option value="">请选择</option>
                        <option value="3">供应商</option>
                        <option value="5">采购商</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>类型：</label>
                    <select class="form-control" id="helpTypeId">
                        <option value="">请选择</option>
                        <c:forEach items="${helpListView.helpTypeBoList}" var="helpTypeBo">
                            <option value="${helpTypeBo.id}">${helpTypeBo.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>状态：</label>
                    <select class="form-control" id="disabled">
                        <option value="">全部</option>
                        <c:forEach items="${helpListView.disableds}" var="type">
                            <option value="${type.constValue}">${type.constName}</option>
                        </c:forEach>
                    </select>
                </div>
                      <span class="form-group">
                        <a href="#" class="btn btn-primary btn-sm wid-60" id="search">搜索</a>
                        <button type="reset" class="btn btn-primary btn-sm wid-60" id="reset">重置</button>
                        <a href="#" class="btn btn-primary btn-sm wid-60" id="add">新增</a>
                      </span>
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
<script type="text/javascript" src="${ctx}/resources/js/help/list.js"></script>
</body>
<script>

</script>
</html>
