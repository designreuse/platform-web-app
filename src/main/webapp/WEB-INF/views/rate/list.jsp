<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2015/10/21
  Time: 17:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
    window.ctx="${ctx}"
</script>
<html>
<head>
    <meta charset="utf-8">
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/easyui.css"/>
    <link type="text/css" href="${ctx}/resources/css/easyui-table.css" rel="stylesheet" />
    <script type="text/javascript">
        window.ctx="${ctx}"
    </script>
    <title>商铺商品报价管理</title>
</head>
<body>
<%--nav_breadCrumb--%>
<nav id="navBreadcrumb" class="Hui-breadcrumb">
    <i class="icon-home"></i> 首页
    <span class="c-gray en">&gt;</span> 服务订单
    <span class="c-gray en">&gt;</span> 商铺商品报价管理
    <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" >
        <i class="icon-refresh"></i></a>
</nav>
<%--table_block--%>
<div id="queryBlock" class="pd-20">
    <%--table_tool--%>
    <div id ="queryParam" class="text-l">
        商品名称：<input type="text" class="easyui-validatebox" style="width:150px" placeholder="输入商品名称" id="productNameCn" name="productNameCn">
        HSCODE：<input type="text" class="easyui-validatebox" style="width:150px" placeholder="输入HSCODE" id="hscode" name="hscode">
        品类：<input id="catalogId" />
        状态：<select name="disabled" id="disabled" class="easyui-combobox">
        <option value="">全部</option>
        <option value="0">可用</option>
        <option value="1">停用</option>
    </select>
        <a class="easyui-linkbutton r" id="search" ><i class="icon-search"></i> 搜索</a>
        <a class="easyui-linkbutton r" id="add" >新增标准商品</a>
    </div>
    <%--table_content--%>
    <div id="queryContent">
        <table id="easyUi_table">

        </table>
    </div>
    <%--table_footer--%>
    <div id="queryPage" class="easyui-panel">
        <div id="page"></div>
    </div>
</div>

<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common/dateformat.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/easyui-table.js"></script>
<script>
    $(function(){

        //设置表格初始化配置属性
        var easyUiTableParam = {
            url: window.ctx+'/product/productList',
            title: '标准商品列表',
            columns: [{
                field:"productId",
                title:'商品名称',
                align:'center',
                formatter:function(value,row,index){
                    return row.productNameCn
                }
            },
                {field:'hscode',title:'HSCODE',align:'center'},
                {field:'catalogNameCnFirst',title:'一级分类',align:'center'},
                {field:'catalogNameCnSecond',title:'二级分类',align:'center'},
                {field:'catalogNameCn',title:'三级分类',align:'center'},
                {
                    field:'disabled',
                    title:'是否可用',
                    align:'center',
                    formatter: function(value,row,index){
                        if (value){
                            return '<span class="disabled">停用</span>';
                        } else {
                            return '<span class="undisabled">可用</span>';
                        }
                    }
                },
                {
                    field:'createTime',
                    title:'创建时间',
                    align:'center',
                    formatter:function(value,row,index){
                        return new Date(value).Format("yyyy-MM-dd");
                    }
            }],
            onClickCell: function(rewIndex,field,value){
                window.location.href=window.ctx+'/product/'+value+'/edit'
            },
            onSelectPage:function(pageNumber,pageSize){
                $('#easyUi_table').datagrid("reload",{pageNumber:pageNumber,pageSize:pageSize})
            }
        };

        //初始化加载表格
        easyUiTable.initTable(easyUiTableParam);
    });
</script>
</body>
</html>
