<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<html>
<head>
    <title>巡回盘统计</title>
</head>
<body>
<%
    Calendar c = Calendar.getInstance();
    request.setAttribute("curDate",c.getTime());
    c.setTime(new Date());
    c.add(Calendar.MONTH, -1);
    request.setAttribute("lastMonth",c.getTime());
%>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">交易中心</a>
    </li>
    <li>
        <a href="#">询盘回盘统计</a>
    </li>
</nav>
<div class="container-fluid">
<div class="panel panel-default">
    <div class="panel-heading">询盘企业统计表</div>
    <div class="panel-body">
        <div id ="queryParam" class="text-l formtable-query query-param">
            <div class="form-inline mar_t20" onkeypress='if(event.keyCode==13){jQuery("#companySearch").click(); return false;}'>
                <div class="form-group">
                    <label>询盘日期：</label>
                    <div class="input-group datepicker date wid-120">
                        <input type="text"  class=" form-control" readonly id="cstartTime" name="beginCreateTime" value="<fmt:formatDate value='${lastMonth}' pattern="yyyy-MM-dd"/>" >
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
                        <input class="form-control" type="text" id="buyerCompanyName">
                </div>
                <div class="form-group">
                    <button class="btn btn-primary btn-sm" id="companySearch">搜索</button>
                </div>
            </div>
        </div>
        <p class="text-right" id="companyStats">总计询盘  条，成功  条 </p>

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
    <div class="panel-heading">询盘商品统计表</div>
    <div class="panel-body">
        <div class="formtable-query query-param">
            <div class="form-inline mar_t20" onkeypress='if(event.keyCode==13){jQuery("#prductSearch").click(); return false;}'>
                <div class="form-group">
                    <label>询盘日期：</label>
                    <div class="input-group datepicker date wid-120">
                        <input type="text" class=" form-control" readonly id="pstartTime" name="beginCreateTime"  value="<fmt:formatDate value='${lastMonth}' pattern="yyyy-MM-dd"/>">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                    <em class="pad_10">-</em>
                    <div class="input-group datepicker date wid-120">
                        <input type="text" class=" form-control" readonly id="pendTime" name="endCreateTime"  value="<fmt:formatDate value='${curDate}' pattern="yyyy-MM-dd"/>">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                </div>
                <div class="form-group">
                    <label>商品：</label>
                    <select id="catalog1Id" onchange="loadCs2(this);" class="form-control">
                        <option value="">--一级品类--</option>
                        <c:forEach items="${catalogList}" var="catalog">
                            <option value="${catalog.catalogId}">${catalog.catalogNameCn}</option>
                        </c:forEach>
                    </select>
                    <select id="catalog2Id" onchange="loadCs3(this);" class="form-control" name="catalog2" >
                        <option value="">--二级品类--</option>
                    </select>
                    <select id="catalog3Id" onchange="loadPro(this);"class="form-control" name="catalog3">
                        <option value="">--三级品类--</option>
                    </select>
                    <select id="productId" class="form-control" name="productId">
                        <option value="">--标准商品--</option>
                    </select>
                </div>
                <div class="form-group">
                    <button class="btn btn-primary" id="prductSearch">搜索</button>
                </div>
            </div>
        </div>

        <p class="text-right" id="productStats"></p>

        <div id="queryContent2">
            <table class="easyui-panel mutil-table-2">

            </table>
        </div>
        <div class="easyui-panel query-page">
            <div class="page"></div>
        </div>
    </div>
</div>

<div class="panel panel-default" onkeypress='if(event.keyCode==13){jQuery("#distributeBtn").click(); return false;}'>
    <!-- Default panel contents -->
    <div class="panel-heading">询盘商品分布图</div>
    <div class="panel-body">
        <div  class="text-l formtable-query form-inline mar_t20" onkeypress='if(event.keyCode==13){jQuery("#distributeBtn").click(); return false;}'>
            <div class="form-group">
                <label>询盘日期：</label>
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
                <button class="btn btn-primary" id="distributeBtn">搜索</button>
            </div>
        </div>
        <div class="col-md-6" id="chartOption11" style="width:550px;height:500px">

        </div>
        <div class="col-md-6" id="chartOption12"  style="width:550px;height:500px">

        </div>
    </div>
</div>
<div class="panel panel-default" onkeypress='if(event.keyCode==13){jQuery("#trendBtn").click(); return false;}'>
    <!-- Default panel contents -->
    <div class="panel-heading">询盘走势</div>
    <div class="panel-body">
        <div class="panel-body">
            <div  class="text-l formtable-query">
                <div class="form-inline mar_t20" >
                    <div class="form-group">
                        <label>询盘日期：</label>
                        <div class="input-group datepicker date wid-120">
                            <input type="text"  class=" form-control" readonly id="tstartTime" name="beginCreateTime" value="<fmt:formatDate value='${lastMonth}' pattern="yyyy-MM-dd"/>">
                            <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                        </div>
                        <em class="pad_10">-</em>
                        <div class="input-group datepicker date wid-120">
                            <input type="text"  class=" form-control" readonly id="tendTime" name="endCreateTime" value="<fmt:formatDate value='${curDate}' pattern="yyyy-MM-dd"/>">
                            <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                        </div>
                    </div>


                    <div class="form-group">
                        <button class="btn btn-primary" id="trendBtn">搜索</button>
                    </div>
                </div>
            </div>
        <div style="width:1100px;height:400px" id="trend">
        </div>
    </div>
</div>
</div>
</div>
</body>
<script src="${ctx}/resources/library/echarts/js/echarts.js"></script>

<script src="${ctx}/resources/js/DataChart.js"></script>
<script src="${ctx}/resources/js/statsInquiry/list.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>

</html>

