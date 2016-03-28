<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<html>
<head>
    <%@include file="/WEB-INF/common/global/common.jsp"%>
    <%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
    <title>员工管理</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">用户中心</a>
    </li>
    <li>
        <a href="/platform/empMgr/list">员工管理</a>
    </li>
</nav>
<div class="formtable">
    <div class="formtable-query" >
        <div class="formtable-query mar_t20">
            <form class="form-inline" id="userMgrform">
                <div class="form-group">
                    <label>姓名（中文）：</label>
                    <input type="text" class="form-control" name="userName">
                </div>
                <div class="form-group">
                    <label>手机：</label>
                    <input type="text" name="mobile" class="form-control">
                </div>
                <div class="form-group">
                    <label>服务执行部门：</label>
                    <select class="form-control" name="deptId">
                        <option value="">全部</option>
                        <c:forEach items="${departmentBoList}" var="deprt">
                            <option value="${deprt.id}">${deprt.deptName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>状态：</label>
                    <select class="form-control" name="accountState" >
                        < <option value="">全部</option>
                        <option value="1">可用</option>
                        <option value="2">停用</option>
                    </select>
                </div>
		  <span class="form-group">
            <a href="#" class="btn btn-primary btn-sm wid-60" id="search">搜索</a>
            <a href="#" class="btn btn-primary btn-sm wid-60" onclick="reset()">重置</a>
		    <a href="${ctx}/empMgr/add" class="btn btn-primary btn-sm wid-60" >新增</a>
		  </span>
            </form>
        </div>
    </div>
    <div  id="queryContent" class="mar_t20">
        <table id="easyUi_table">

        </table>
    </div>

    <div class="easyui-panel" id="queryPage">
        <div id="page"></div>
    </div>


</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
<script type="text/javascript" src="${ctx}/resources/js/empMgr/list.js"></script>
</html>



