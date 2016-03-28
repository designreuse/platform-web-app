<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<%
    Calendar c = Calendar.getInstance();
    request.setAttribute("curDate",c.getTime());
    c.setTime(new Date());
    c.add(Calendar.MONTH, -1);
    request.setAttribute("lastMonth",c.getTime());
%>
    <title>服务订单数据统计</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">交易中心</a>
    </li>
    <li>
        <a href="#">服务订单统计</a>
    </li>
</nav>
<div class="panel panel-default">
    <div class="panel-heading">服务委托方统计表</div>
    <div class="panel-body">
        <div id ="queryParam" class="text-l formtable-query query-param">
            <div class="form-inline mar_t20" onkeypress='if(event.keyCode==13){jQuery("#companySearch").click(); return false;}'>
                <div class="form-group">
                    <label>下单日期：</label>
                    <div class="input-group datepicker date wid-120">
                        <input type="text"  class=" form-control" readonly id="cstartTime" name="beginCreateTime" value="<fmt:formatDate value='${lastMonth}' pattern="yyyy-MM-dd"/>">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                    <em class="pad_10">-</em>
                    <div class="input-group datepicker date wid-120">
                        <input type="text"  class=" form-control" readonly id="cendTime" name="endCreateTime" value="<fmt:formatDate value='${curDate}' pattern="yyyy-MM-dd"/>">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                </div>
                <div class="form-group">
                    <label>企业：</label>
                    <input class="form-control" type="text" id="buyerOrgNameCN">
                </div>
                <div class="form-group">
                    <button class="btn btn-primary btn-sm" id="companySearch">搜索</button>
                </div>
            </div>
        </div>
        <p class="text-right" id="companyStats">

            总计成交 0 个订单，成交量 0 个服务，服务费 0 元
        </p>

        <div id="queryContent">
            <table class="easyui-panel mutil-table">

            </table>
        </div>
        <div class="query-page">
            <div class="page"></div>
        </div>
    </div>
</div>
<div class="panel panel-default">
    <div class="panel-heading">服务统计表</div>
    <div class="panel-body">
        <div id ="queryParam2" class="text-l formtable-query query-param" onkeypress='if(event.keyCode==13){jQuery("#prductSearch").click(); return false;}'>
            <div class="form-inline mar_t20">
                <div class="form-group">
                    <label class="fl_l line_h34 ">下单日期：</label>
                    <div class="input-group datepicker date wid-120">
                        <input type="text"  class=" form-control" readonly id="istartTime" name="beginCreateTime" value="<fmt:formatDate value='${lastMonth}' pattern="yyyy-MM-dd"/>">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                    <em class="pad_10">-</em>
                    <div class="input-group datepicker date wid-120">
                        <input type="text"  class=" form-control" readonly id="iendTime" name="endCreateTime" value="<fmt:formatDate value='${curDate}' pattern="yyyy-MM-dd"/>">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                </div>
                <div class="form-group">
                    <label>服务：</label>
                    <select id="srvId" class="form-control">
                        <option value="">全部</option>
                        <c:forEach items="${service}" var="service">
                            <option value="${service.serviceId}">${service.srvNameCn}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <button class="btn btn-primary btn-sm" id="prductSearch">搜索</button>
                </div>
            </div>
        </div>

        <p class="text-right" id="srvItemStats">

            总计成交 0 个订单，成交量 0 个服务，服务费 0 元
        </p>

        <div id="queryContent2">
            <table class="easyui-panel mutil-table-2">

            </table>
        </div>
    </div>
</div>

<div class="panel panel-default">
    <!-- Default panel contents -->
    <div class="panel-heading">服务分布图</div>
    <div class="panel-body">
        <div  class="text-l formtable-query" onkeypress='if(event.keyCode==13){jQuery("#distributeBtn").click(); return false;}'>
            <div class="form-inline mar_t20">
                <div class="form-group">
                    <label>下单日期：</label>
                    <div class="input-group datepicker date wid-120">
                        <input type="text"  class=" form-control" readonly id="dstartTime" name="beginCreateTime" value="<fmt:formatDate value='${lastMonth}' pattern="yyyy-MM-dd"/>">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                    <em class="pad_10">-</em>
                    <div class="input-group datepicker date wid-120">
                        <input type="text"  class=" form-control" readonly id="dendTime" name="endCreateTime" value="<fmt:formatDate value='${curDate}' pattern="yyyy-MM-dd"/>">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                </div>

                <div class="form-group">
                    <button class="btn btn-primary btn-sm" id="distributeBtn">搜索</button>
                </div>
            </div>
        </div>
        <div class="col-md-6" id="chartOption11" style="width:550px;height:500px">

        </div>
        <div class="col-md-6" id="chartOption12"  style="width:550px;height:500px">

        </div>
    </div>
</div>
<div class="panel panel-default">
    <!-- Default panel contents -->
    <div class="panel-heading">服务走势</div>
    <div class="panel-body">
        <div class="panel-body">
            <div  class="text-l formtable-query" onkeypress='if(event.keyCode==13){jQuery("#trendBtn").click(); return false;}'>
                <div class="col-md-12 mar_t20 no_pad mar_b20">
                    <label class="fl_l line_h34 ">下单日期：</label>
                    <div class="col-md-2 input-group datepicker date auto_width-r">
                        <input type="text"  class=" form-control" readonly id="tstartTime" name="beginCreateTime" value="<fmt:formatDate value='${lastMonth}' pattern="yyyy-MM-dd"/>">
                        <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                    </div>
                    <span class="pad_10 fl_l">-</span>
                    <div class="col-md-2 input-group datepicker date ">
                        <input type="text"  class=" form-control" readonly id="tendTime" name="endCreateTime" value="<fmt:formatDate value='${curDate}' pattern="yyyy-MM-dd"/>">
                        <span class="input-group-addon"><span class="glyphicon glyphicon-time"></span></span>
                    </div>

                    <div class="fl_r">
                        <button class="btn btn-primary btn-sm" id="trendBtn">搜索</button>
                    </div>
                </div>
            </div>
        <div style="width:1100px;height:400px" id="trend">

        </div>

    </div>
</div>
</div>
</body>
<script src="${ctx}/resources/library/echarts/js/echarts.js"></script>
<script src="${ctx}/resources/js/sku/list.js"></script>
<script src="${ctx}/resources/js/DataChart.js"></script>
<script src="${ctx}/resources/js/statsSrvOrder/list.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>

</html>

