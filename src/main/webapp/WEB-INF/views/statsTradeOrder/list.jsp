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
    <title>贸易订单数据统计</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">交易中心</a>
    </li>
    <li>
        <a href="#">贸易订单数据统计</a>
    </li>
</nav>
<div class="panel panel-default">
    <div class="panel-heading">买方企业统计表</div>
    <div class="panel-body">
        <div class="text-l formtable-query query-param" onkeypress='if(event.keyCode==13){jQuery("#buyerSearch").click(); return false;}'>
            <div class="form-inline mar_t20">
                <div class="form-group">
                    <label>下单日期：</label>
                    <div class="input-group datepicker date wid-120">
                        <input type="text"  class=" form-control" readonly id="buyerStartTime" name="beginCreateTime" value="<fmt:formatDate value='${lastMonth}' pattern="yyyy-MM-dd"/>">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                    <em class="pad_10">-</em>
                    <div class="input-group datepicker date wid-120">
                        <input type="text"  class=" form-control" readonly id="buyerEndTime" name="endCreateTime" value="<fmt:formatDate value='${curDate}' pattern="yyyy-MM-dd"/>">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                </div>
                <div class="form-group">
                    <label>企业：</label>
                    <input class="form-control" type="text" id="buyerOrgNameCN">
                </div>
                <div class="form-group">
                    <button class="btn btn-primary btn-sm" id="buyerSearch">搜索</button>
                </div>
            </div>
        </div>
        <p class="text-right" id="buyerStats">
            总计成交 0 个订单，成交量 0 条，总金额 0 元
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
    <div class="panel-heading">商铺统计表</div>
    <div class="panel-body">
        <div id ="queryParam2" class="text-l formtable-query query-param" onkeypress='if(event.keyCode==13){jQuery("#salerSearch").click(); return false;}'>
            <div class="form-inline mar_t20">
                <div class="form-group">
                    <label>下单日期：</label>
                    <div class="input-group datepicker date wid-120">
                        <input type="text"  class=" form-control" readonly id="salerStartTime" name="beginCreateTime" value="<fmt:formatDate value='${lastMonth}' pattern="yyyy-MM-dd"/>">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                    <em class="pad_10">-</em>
                    <div class="input-group datepicker date wid-120">
                        <input type="text"  class=" form-control" readonly id="salerEndTime" name="endCreateTime" value="<fmt:formatDate value='${curDate}' pattern="yyyy-MM-dd"/>">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                </div>
                <div class="form-group">
                    <label>企业：</label>
                    <input class="form-control" type="text" id="salerOrgNameCN">
                </div>
                <div class="form-group">
                    <label>商铺：</label>
                    <input class="form-control" type="text" id="shopsNameCN">
                </div>
                <div class="form-group">
                    <button class="btn btn-primary btn-sm" id="salerSearch">搜索</button>
                </div>
            </div>
        </div>

        <p class="text-right" id="salerStats"></p>

        <div id="queryContent2">
            <table class="easyui-panel mutil-table-2">

            </table>
        </div>
        <div class="query-page">
            <div class="page"></div>
        </div>
    </div>
</div>
<div class="panel panel-default">
    <div class="panel-heading">商品统计表</div>
    <div class="panel-body">
        <div id ="queryParam3" class="text-l formtable-query query-param"  onkeypress='if(event.keyCode==13){jQuery("#productSearch").click(); return false;}'>
            <div class="form-inline mar_t20">
                <div class="form-group">
                    <label>下单日期：</label>
                    <div class="input-group datepicker date wid-120">
                        <input type="text"  class=" form-control" readonly id="pstartTime" name="beginCreateTime" value="<fmt:formatDate value='${lastMonth}' pattern="yyyy-MM-dd"/>">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                    <em class="pad_10">-</em>
                    <div class="input-group datepicker date wid-120">
                        <input type="text"  class=" form-control" readonly id="pendTime" name="endCreateTime" value="<fmt:formatDate value='${curDate}' pattern="yyyy-MM-dd"/>">
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                </div>
                <div class="form-group">
                    <label>商品：</label>
                    <select id="catalog1Id" onchange="loadCs2(this);" class="form-control">
                        <option value="">一级品类</option>
                        <c:forEach items="${catalogList}" var="catalog">
                            <option value="${catalog.catalogId}" <c:if test="${catalog.catalogId == catalogw.catalogId}">selected="selected" </c:if>>${catalog.catalogNameCn}</option>
                        </c:forEach>
                    </select>
                    <select id="catalog2Id" onchange="loadCs3(this);" class="select catalogSelect2 form-control" name="catalog2">
                        <option value="">二级品类</option>
                    </select>
                    <select id="catalog3Id" onchange="loadPro(this);" class="select catalogSelect3 form-control" name="catalog3">
                        <option value="">三级品类</option>
                    </select>
                    <select id="productId" class="select productSelect form-control" name="productId">
                        <option value="">标准商品</option>
                    </select>
                </div>
                <div class="form-group">
                    <button class="btn btn-primary btn-sm" id="productSearch">搜索</button>
                </div>
            </div>
        </div>

        <p class="text-right" id="productStats"></p>

        <div id="queryContent3">
            <table class="easyui-panel mutil-table-3">

            </table>
        </div>
        <div class="query-page">
            <div class="page"></div>
        </div>
    </div>
</div>

<div class="panel panel-default">
    <!-- Default panel contents -->
    <div class="panel-heading">商品分布图</div>
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
        <div class="col-md-6" id="chartNum" style="width:550px;height:500px">

        </div>
        <div class="col-md-6" id="chartAmount"  style="width:550px;height:500px">

        </div>
    </div>
</div>
<div class="panel panel-default">
    <!-- Default panel contents -->
    <div class="panel-heading">交易走势</div>
    <div class="panel-body">
        <div class="panel-body">
            <div  class="text-l formtable-query"  onkeypress='if(event.keyCode==13){jQuery("#trendBtn").click(); return false;}'>
                <div class="form-inline mar_t20">
                    <div class="form-group">
                        <label>下单日期：</label>
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
                        <button class="btn btn-primary btn-sm" id="trendBtn">搜索</button>
                    </div>
                </div>
            </div>
        <div style="width:1100px;height:400px" id="trendTradeOrder">

        </div>

    </div>
</div>
</div>
</body>
<script src="${ctx}/resources/library/echarts/js/echarts.js"></script>
<script src="${ctx}/resources/js/DataChart.js"></script>
<script src="${ctx}/resources/js/statsTradeOrder/list.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</html>

