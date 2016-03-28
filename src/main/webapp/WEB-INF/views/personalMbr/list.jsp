<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<html>
<head>
    <%@include file="/WEB-INF/common/global/common.jsp" %>
    <%@include file="/WEB-INF/common/global/tableCommon.jsp" %>
    <title>个人会员管理</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">会员中心</a>
    </li>
    <li>
        <a href="${ctx}/personalMbr/list">个人会员管理</a>
    </li>
</nav>
<div class="formtable">
    <div class="formtable-query">
        <div class="formtable-query mar_t20">
            <form id="personalMbrform">
                <div class="form-inline" >
                    <div class="form-group">
                        <label>公司名称：</label>
                        <input type="text" class="form-control" name="orgName">
                    </div>
                    <div class="form-group">
                        <label>姓名：</label>
                        <input type="text" class="form-control" name="userName">
                    </div>
                    <div class="form-group">
                        <label>手机号：</label>
                        <input type="text" class="form-control" name="mobile">
                    </div>


                    <div class="form-group">
                        <label>注册来源：</label>
                        <select class="form-control" name="regSource">
                            <option value="">全部</option>
                            <option value="5">俄文站点</option>
                            <option value="3">中文站点</option>
                            <option value="2">运营平台</option>
                        </select>
                    </div>
                </div>
                <div class="form-inline mar_t20">
                    <div class="form-group">
                        <label>注册日期：</label>

                        <div class="input-group datepicker date wid-120">
                            <input type="text" class="form-control" readonly style="margin: 0px;" id="beginCreateTime"
                                   name="createTimeStart">
                            <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                        </div>
                        <em class="pad_10">-</em>

                        <div class="input-group datepicker date wid-120">
                            <input type="text" class="form-control" readonly style="margin: 0px;" id="endCreateTime"
                                   name="createTimeEnd">
                            <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>审核：</label>
                        <select class="form-control" name="statusType" id="statusType">
                            <option value="">全部</option>
                            <c:forEach items="${view.statusList}" var="status">
                                <option value="${status.constValue}" <c:if test="${status.constValue == view.status}">selected</c:if> >${status.constName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>隶属关系：</label>
                        <select class="form-control" name="entUserStatus">
                            <option value="">全部</option>
                            <option value="1">隶属</option>
                            <option value="2">个人</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>状态：</label>
                        <select class="form-control" name="accountState">
                            <option value="">全部</option>
                            <option value="1">可用</option>
                            <option value="2">停用</option>
                        </select>
                    </div>
                    <div class="form-group fl-r">
                        <a href="#" class="btn btn-primary btn-sm wid-60" id="search">搜索</a>
                        <button  class="btn btn-primary btn-sm wid-60">重置</button>
                        <a href="${ctx}/personalMbr/addPage" class="btn btn-primary btn-sm wid-60">新增</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div id="queryContent" class="mar_t20">
        <table id="easyUi_table">

        </table>
    </div>

    <div class="easyui-panel" id="queryPage">
        <div id="page"></div>
    </div>


</div>
</body>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript"  src="${ctx}/resources/js/personalMbr/list.js">

</script>
</html>



