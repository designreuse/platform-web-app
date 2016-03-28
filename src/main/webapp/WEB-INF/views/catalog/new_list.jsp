<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <title>商品品类管理</title>
</head>
<body>
<%--nav_breadCrumb--%>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">商品中心</a>
    </li>
    <li>
        <a href="${ctx}/catalog/list">商品品类管理</a>
    </li>
</nav>
<%--table_block--%>
<div id="queryBlock" class="pd-20 formtable" style="margin-left: auto;margin-right: auto">
    <%--table_tool--%>

    <div id="queryParam" class="formtable">
            <div class="formtable-query mar_t20">
                <form class="form-inline">
                    <div class="form-group">
                        <label>品类名称：</label>
                        <input type="text" id="catalogNameCn" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>HS CODE：</label>
                        <input type="text" id="hscode" class="form-control">
                    </div>
                    <div class="form-group">
                        <label>状态：</label>
                        <select class="form-control" id="disabled" name="disabled">
                            <option value="">全部</option>
                            <c:forEach var="disabled" items="${catalog.disableds}">
                                <option value="${disabled.constValue}">${disabled.constName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>分类：</label>
                        <select class="form-control" id="level" name="level">
                            <option value="">全部</option>
                            <option value="1">一级分类</option>
                            <option value="2">二级分类</option>
                            <option value="3">三级分类</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>上级分类：</label>
                        <input type="text" id="parentId" class="form-control">
                    </div>
                    <%--<div class="form-group">--%>
                        <%--<label>是否首页：</label>--%>
                        <%--<select class="form-control" id="indexSort" name="indexSort">--%>
                            <%--<option value="">全部</option>--%>
                            <%--<option value="0">不展示</option>--%>
                            <%--<option value="1">展示</option>--%>
                        <%--</select>--%>
                    <%--</div>--%>
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

</body>
<script type="text/javascript" src="${ctx}/resources/js/catalog/list.js"></script>
<script type="application/javascript" >


</script>
</html>
