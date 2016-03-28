<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <link type="text/css" href="${ctx}/resources/css/index.css" rel="stylesheet" />
    <link type="text/css" href="${ctx}/resources/css/labelauty.css" rel="stylesheet" />
    <title>询回盘管理</title>
</head>
<body>
<form action="${ctx}/inquiry/list"  method="post" id="searchform" class="searchform">
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 商机管理 <span class="c-gray en">&gt;</span> 询盘管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a></nav>
<div class="pd-20">
    <div class="text-l">
        <table width="100%" border="0" cellspacing="3" cellpadding="0">
            <tr>
                <td width="6%" height="44">询盘编号：</td>
                <td width="25%">
                    <input type="text" class="input-text" style="width:222px" placeholder="输入询盘编号"
                                       id="input1" name="inquiryCode" value="${inquiryEntity.inquiryCode}"></td>
                <td width="4%" >买方：</td>
                <td width="18%">
                    <input type="text" class="input-text" style="width:150px" placeholder="输入买方企业名称"
                                       id="input2" name="orgName" value="${inquiryEntity.orgName}"/></td>

                <td width="4%">商铺：</td>
                <td width="18%">
                    <input type="text" class="input-text" style="width:150px" placeholder="输入卖方商铺名称"
                           id="feedbackShopsName" name="feedbackShopsName" value="${inquiryEntity.feedbackShopsName}"
                           <c:if test="${inquiryEntity.inquiryType == 2}">disabled</c:if> ></td>
                <td>状态：</td>
                <td><select class="select" name="inquiryStatus" size="1" style="width:100px">
                    <option value="">全部</option>
                    <option value="1" <c:if test="${inquiryEntity.inquiryStatus == 1}">selected</c:if>>询价中</option>
                    <option value="2" <c:if test="${inquiryEntity.inquiryStatus == 2}">selected</c:if>>买家待确认</option>
                    <option value="3" <c:if test="${inquiryEntity.inquiryStatus == 3}">selected</c:if>>卖家待确认</option>
                    <option value="4" <c:if test="${inquiryEntity.inquiryStatus == 4}">selected</c:if>>已完成</option>
                    <option value="5" <c:if test="${inquiryEntity.inquiryStatus == 5}">selected</c:if>>已取消</option>
                </select></td>
            </tr>
            <tr>
                <td>日期范围：</td>
                <td><input type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})"
                                       value="<odpf:formatDate style='DATE' date='${inquiryEntity.createTimeBegin}'/>"
                                       name="createTimeBegin" id="datemin" class="input-text Wdate" style="width:100px;">
                    -
                    <input type="text" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d'})"
                           value="<odpf:formatDate style='DATE' date='${inquiryEntity.createTimeEnd}'/>"
                           name="createTimeEnd" id="datemax" class="input-text Wdate" style="width:100px;"></td>
                <td width="4%" >卖方：</td>
                <td width="16%">
                    <input type="text" class="input-text" style="width:150px" placeholder="输入卖方企业名称"
                           id="feedbackOrgName" name="feedbackOrgName" value="${inquiryEntity.feedbackOrgName}"
                           <c:if test="${inquiryEntity.inquiryType == 2}">disabled</c:if> ></td>

                <td>类型：</td>
                <td>
                    定向询盘&nbsp;<input type="radio" name="inquiryType" value="1" onclick="$('#searchform').submit();"
                        <c:if test="${inquiryEntity.inquiryType == 1}">checked</c:if>/>
                    不定向询盘&nbsp;<input type="radio" name="inquiryType" value="2" onclick="$('#searchform').submit();"
                        <c:if test="${inquiryEntity.inquiryType == 2}">checked</c:if> />
                </td>
                <td width="4%"></td>
                <td width="15%"></td>
                <td colspan="2"><button type="submit" class="btn btn-success" id="button" name=""><i class="icon-search"></i> 搜索</button></td>
            </tr>
        </table>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><a class="btn btn-primary radius" href="${ctx}/inquiry/add">
        <i class="icon-plus"></i> 新增询盘</a></span> <span class="r">共有数据：<strong>${page.records}</strong> 条</span> </div>
    <table class="table table-border table-bordered table-bg table-hover table-sort">
        <thead>
        <tr class="text-c">
            <th width="146">询盘编号</th>
            <th width="186">买方</th>
            <th width="225">卖方</th>
            <th width="113">商品</th>
            <th width="92">创建时间</th>
            <th width="109">状态</th>
            <th width="73">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${inquiryList}" var="inquiry">
        <tr class="text-c">
            <td class="text-l">
                <a href="${ctx}/inquiry/detail?inquiryId=${inquiry.inquiryId}&inquiryType=${inquiry.inquiryType}&inquiryStatus=${inquiry.inquiryStatus}" class="text-primary">
                        ${inquiry.inquiryCode}
                </a>
            </td>
            <td><a href="${ctx}/enterprise/${inquiry.orgId}/edit">${inquiry.orgName}</a></td>
            <c:if test="${inquiry.inquiryType == 1}">
            <td>
                <a href="${ctx}/enterprise/${inquiry.feedbackOrgId}/edit">${inquiry.feedbackOrgName}</a><br/>
                <a href="${ctx}/shops/edit/${inquiry.shopsId}">${inquiry.feedbackShopsName}</a><br/>
                <c:if test="${inquiry.feedbackShopsType == 1}">【直属】</c:if>
                <c:if test="${inquiry.feedbackShopsType == 2}">【挂靠】</c:if>
            </td>
            <td>
                <c:forEach items="${fn:split(inquiry.products,',')}" var="product">
                    ${product}&nbsp;&nbsp;<br/>
                </c:forEach>
            </td>
            </c:if>
            <c:if test="${inquiry.inquiryType == 2}">
                <td>不定向询盘</td>
                <td>
                    <c:forEach items="${fn:split(inquiry.products,',')}" var="product">
                        ${product}&nbsp;&nbsp;<br/>
                    </c:forEach>
                </td>
            </c:if>

            <td><odpf:formatDate style="DATE_HOUR_SECOND" date="${inquiry.createTime}"/></td>
            <td class="article-status"><span class="label label-success">
                <c:choose>
                    <c:when test="${inquiry.inquiryStatus == 1}">询价中</c:when>
                    <c:when test="${inquiry.inquiryStatus == 2}">待买家待确认</c:when>
                    <c:when test="${inquiry.inquiryStatus == 3}">待卖家待确认</c:when>
                    <c:when test="${inquiry.inquiryStatus == 4}">已确认</c:when>
                    <c:when test="${inquiry.inquiryStatus == 5}">已取消</c:when>
                </c:choose>
            </span></td>
            <td class="f-14 article-manage">
                <span class="l">
                <c:choose>
                    <c:when test="${inquiry.inquiryStatus == 1}">
                        <a class="btn btn-primary radius" href="${ctx}/inquiry/feedback/${inquiry.inquiryId}">
                            <i class="icon-plus"></i>回盘
                        </a>
                    </c:when>
                    <c:when test="${inquiry.inquiryStatus == 2}">
                        <a class="btn btn-primary radius" href="${ctx}/inquiry/detail?inquiryId=${inquiry.inquiryId}&inquiryType=${inquiry.inquiryType}&inquiryStatus=${inquiry.inquiryStatus}">
                            <i class="icon-plus"></i>买方确认
                        </a>
                    </c:when>
                    <c:when test="${inquiry.inquiryStatus == 3}">
                        <a class="btn btn-primary radius" href="${ctx}/inquiry/detail?inquiryId=${inquiry.inquiryId}&inquiryType=${inquiry.inquiryType}&inquiryStatus=${inquiry.inquiryStatus}">
                            <i class="icon-plus"></i>卖方确认
                        </a>
                    </c:when>
                </c:choose>
                </span>
            </td>
        </tr>
        </c:forEach>
        </tbody>
    </table>

    <script type="text/javascript" src="${ctx}/resources/js/page/page-common.js"></script>
    <tags:pageComponent pageNumber="${page.currentPage}" pageSize="${page.pageSize}" totalRows="${page.records}"/>
</div>
</form>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/layer/layer.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script type="text/javascript">
    $(function(){
        if('${msg}' !== ''){
            alert('${msg}');
        }
    });
    $(":radio").on("click",function(){
        var inquiryType = $(this).val();
        if(inquiryType == 1){
            $("#feedbackOrgName").prop("disabled",false);
            $("#feedbackShopsName").prop("disabled",false);
        }else{
            $("#feedbackOrgName").prop("disabled",true);
            $("#feedbackShopsName").prop("disabled",true);
        }
    });
</script>
</body>
</html>