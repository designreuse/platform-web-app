<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<html>
<head>
    <title>活动管理</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 内容中心 <span class="c-gray en">&gt;</span> 活动管理 </nav>
<div class="text-l" id ="queryParam">
    标题：<input type="text" class="easyui-validatebox" style="width:150px" placeholder="输入标题" id="activityName" name="activityName">
    <td height="20">平台：</td>
    <td>
        <select class="easyui-combobox" name="appId" id="appId" style="width:100px;">
            <option value="">请选择</option>
            <option value="2">神灯速贸运营平台</option>
            <option value="3">神灯速贸中文平台</option>
            <option value="5">神灯速贸俄文平台</option>
        </select>
    </td>
    <td  width="6%">发布日期：</td>
    <td>
        <input  class="easyui-datebox" id="startDate" name="startDate" style="width:150px;" value="">
        -
        <input  class="easyui-datebox" id="endDate" name="endDate"  style="width:150px;" value="">
    </td>
    <td></td>
    <td height="20">状态：</td>
    <td>
        <select class="easyui-combobox" name="disabled" id="disabled" style="width:100px;">
            <option value="">全部</option>
            <option value="1">可用</option>
            <option value="0">停用</option>
        </select>
    </td>
    <a class="easyui-linkbutton r" id="search" ><i class="icon-search"></i> 搜索</a>
    <a class="easyui-linkbutton r" id="add" >新增活动</a>
</div>
</div>
<div id="queryContent">
    <table id="easyUi_table">

    </table>
</div>
<div id="queryPage" class="easyui-panel">
    <div id="page"></div>
</div>
<script type="text/javascript" src="${ctx}/resources/js/activity/list.js"></script>
</body>
</html>
