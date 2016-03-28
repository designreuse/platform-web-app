<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>结算中心-发票管理</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">结算中心</a>
    </li>
    <li>
        <a href="${ctx}/invoice/list">发票管理</a>
    </li>
</nav>
    <div class="formtable">
        <div class="formtable-query mar_t20">
            <form class="form-inline">
                <div class="form-group">
                    <label>企业会员：</label>
                    <input type="text" id="orgName" style="width:125px;height:30px"  class="form-control">
                </div>
                <div class="form-group">
                    <label>开票抬头：</label>
                    <input type="text" id="invoiceTitle" style="width:125px;height:30px"  class="form-control">
                </div>
                <div class="form-group">
                    <label>申请日期：</label>
                    <div class="input-group datepicker date wid-120">
                        <input id="startDate" type="text" class="form-control" readonly style="margin: 0px;">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                    <em class="pad_10">-</em>
                    <div class="input-group datepicker date wid-120">
                        <input id="endDate" type="text" class="form-control" readonly style="margin: 0px;">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                </div>
                <div class="form-group">
                    <label>状态：</label>
                    <select id="status" class="form-control">
                        <option value="">全部</option>
                        <c:forEach var="status" items="${invoiceListView.statusList}">
                            <option value="${status.id}">${status.constName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <a id="search" href="#" class="btn btn-primary btn-sm wid-60">搜索</a>
                    <a id="againSet" href="#" class="btn btn-primary btn-sm wid-60">重置</a>
                </div>
            </form>
        </div>

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
<script type="text/javascript" src="${ctx}/resources/js/invoice/list.js"></script>

<script>



    $(function () {

    })
</script>
</body>
</html>