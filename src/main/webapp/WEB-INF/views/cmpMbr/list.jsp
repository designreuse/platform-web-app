<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/common/global/common.jsp" %>
<%@include file="/WEB-INF/common/global/tableCommon.jsp" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">

    <title>员工管理</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">会员中心</a>
    </li>
    <li>
        <a href="${ctx}/cmpMbr/list">企业会员管理</a>
    </li>
</nav>
<div class="container-fluid">
    <div class="formtable">
            <form id="cmpMgrform" class="formtable-query mar_t20">
                <input type='text' style='display:none'/>
                <div class="form-inline" >
                    <div class="form-group">
                        <label>公司名称：</label>
                        <input type="text" class="form-control" name="orgName" id="orgName">
                    </div>
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
                        <select class="form-control" name="orgAdultStatus" id="orgAdultStatus">
                            <option value="">全部</option>
                            <c:forEach items="${view.statusList}" var="status">
                                <option value="${status.constValue}" <c:if test="${status.constValue == view.status}">selected</c:if> >${status.constName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>状态：</label>
                        <select class="form-control" name="disabled" id="disabled">
                            <option value="">全部</option>
                            <option value="0">可用</option>
                            <option value="1">停用</option>
                        </select>
                    </div>
                </div>
                <div class="form-inline mar_t20">
                    <div class="form-group">
                        <label>企业身份：</label>
                        <select name="identityIdList[0]" class="form-control" id="identity">
                            <option value="">全部</option>
                            <option value="3">供应商</option>
                            <option value="6">采购商</option>
                            <option value="4">代理商</option>
                            <option value="5">物流商</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <a href="#" class="btn btn-primary btn-sm wid-60" id="search">搜索</a>
                        <button  class="btn btn-primary btn-sm wid-60">重置</button>
                        <a href="${ctx}/cmpMbr/add" class="btn btn-primary btn-sm wid-60">新增</a>
                    </div>
                </div>
            </form>
        </div>

    <div id="queryContent" class="mar_t20">
        <table id="easyUi_table">

        </table>
    </div>

    <div class="easyui-panel" id="queryPage">
        <div id="page"></div>
    </div>


</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/cmpMbr/list.js"></script>
</body>
</html>



