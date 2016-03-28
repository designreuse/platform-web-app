<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 15-7-27
  Time: 上午4:38
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
    window.ctx="${ctx}"
</script>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/easyui.css"/>
    <link type="text/css" href="${ctx}/resources/css/easyui-table.css" rel="stylesheet" />
    <title>广告管理</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 内容中心 <span class="c-gray en">&gt;</span> 广告管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a></nav>
<div class="pd-20">
    <div>
        平台：<select name="appId" id="appId" class="easyui-combobox"  style="width:125px">
                    <option value="" selected>全部</option>
                    <option value="2">神灯速贸运营平台</option>
                    <option value="3">神灯速贸中文平台</option>
                    <option value="5">神灯速贸俄文平台</option>
              </select>
        广告位：<%--<input id="effectiveDate" class="easyui-datebox" data-options="sharedCalendar:'#cc'">--%>
        <select name="adId" id="adId" class="easyui-combobox" style="width:100px">
            <option value="">全部</option>
        <c:forEach items="${adList}" var="ad">
            <option value="${ad.id}">${ad.adName}</option>
        </c:forEach>


        </select>
        <input type="hidden" id="adList" value="${adList}"/>

        有效日期：
        <input id="effectiveTime" name="effectiveTime" class="easyui-datebox" style="width:100px"></input>
        状态：<select name="disabled" id="disabled" class="easyui-combobox" style="width:100px">
                    <option value="">全部</option>
                    <option value="0">可用</option>
                    <option value="1">停用</option>
                </select>
        <a class="easyui-linkbutton" id="search" ><i class="icon-search"></i> 搜索</a>
        <a class="easyui-linkbutton" id="add" >新增</a>

    </div>

    <%--<table id="banner_table">--%>

    <%--</table>--%>

    <div id="queryContent">
        <table id="easyUi_table">

        </table>
    </div>
    <div id="queryPage" class="easyui-panel">
        <div id="page"></div>
    </div>

</div>


<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common/dateformat.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/easyui-table.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/banner/list.js"></script>
</body>
</html>
