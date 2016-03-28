<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java"  pageEncoding="UTF-8" %>
<html >
<head>
	<%@include file="../framework/header_common.jsp" %>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <title>工作台</title>
</head>
<body>
<div class="pd-20" style="padding-top:20px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td width="74%" valign="top">
    <div class="cl pd-5 bg-1 bk-gray mt-20">
        <span class="l"><strong>最新加入企业</strong></span>
        <a href="${ctx}/enterprise/list"><span class="r">更多</span></a>
    </div>
    <table class="table table-border table-bordered table-hover table-bg table-sort">
        <thead>
        <tr class="text-c">
            <th width="169">公司名称</th>
            <th width="150">企业身份</th>
            <th width="70">注册来源</th>
            <th width="78">审核</th>
            <th width="78">状态</th>
            <th width="136">加入时间</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${orgList}" var="orgList" varStatus="varStatus">
            <tr class="text-c">
                <c:choose>
                    <c:when test="${orgList.countryType == 2}">
                        <td><a href="${ctx}/enterprise/${orgList.id}/edit">${orgList.orgNameRu}</a></td>
                        <td>俄罗斯供应商</td>
                        <td>俄文站点</td>
                    </c:when>
                    <c:otherwise>
                        <td><a href="${ctx}/enterprise/${orgList.id}/edit">${orgList.orgNameCn}</a></td>
                        <td>中国供应商</td>
                        <td>中文站点</td>
                    </c:otherwise>
                </c:choose>

                <c:choose>
                    <c:when test="${orgList.orgAdultStatus == 2}">
                        <td>审核通过</td>
                    </c:when>
                    <c:when test="${orgList.orgAdultStatus == 3}">
                        <td>等待审核</td>
                    </c:when>
                    <c:when test="${orgList.orgAdultStatus == 4}">
                        <td>审核拒绝</td>
                    </c:when>
                    <c:otherwise>
                        <td>待初审</td>
                    </c:otherwise>
                </c:choose>
                <td><span class="label label-success">
                    <c:if test="${orgList.disabled ==false}">已启用</c:if>
                    <c:if test="${orgList.disabled ==true}">已停用</c:if>
                </td>
                <td><odpf:formatDate style="DATE_HOUR_SECOND" date="${orgList.createTime}"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="cl pd-5 bg-1 bk-gray mt-20">
        <span class="l"><strong>最新加入个人</strong></span>
        <a href="${ctx}/user/list"><span class="r">更多</span></a>
    </div>
    <table class="table table-border table-bordered table-hover table-bg table-sort">
        <thead>
        <tr class="text-c">
            <th width="60">姓名</th>
            <th width="150">公司名称</th>
            <th width="52">注册来源</th>
            <th width="52">隶属关系</th>
            <th width="52">审核</th>
            <th width="52">状态</th>
            <th width="103">加入时间</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${userList}" var="userList" varStatus="varStatus">
            <tr class="text-c">
                <c:choose>
                    <c:when test="${userList.regSource == 5 || userList.regSource == 7}">
                        <td><a href="${ctx}/user/${userList.userId}/edit">${userList.userNameFirst}&nbsp;${userList.userNameLast}<c:if test="${empty userList.userNameFirst}">${userList.email}</c:if></a></td>
                        <td>${userList.orgNameRu}</td>
                        <td>俄文站点</td>
                    </c:when>
                    <c:when test="${userList.regSource == 3 || userList.regSource == 6}">
                        <td><a href="${ctx}/user/${userList.userId}/edit">${userList.userNameCn}<c:if test="${empty userList.userNameCn}">${userList.mobile}</c:if></a></td>
                        <td>${userList.orgNameCn}</td>
                        <td>中文站点</td>
                    </c:when>
                    <c:otherwise>
                        <td><a href="${ctx}/user/${userList.userId}/edit">${userList.userNameCn}<c:if test="${empty userList.userNameCn}">${userList.mobile}</c:if></a></td>
                        <td>${userList.orgNameCn}</td>
                        <td>运营站点</td>
                    </c:otherwise>
                </c:choose>
                <td>
                    <c:choose>
                        <c:when test="${userList.entUserStatus == 1}">
                            隶属
                        </c:when>
                        <c:when test="${userList.entUserStatus == 2}">
                            挂靠
                        </c:when>
                        <c:otherwise>
                            无企业信息
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${userList.statusType == 1}">
                            已通过
                        </c:when>
                        <c:when test="${userList.statusType == 2}">
                            未通过
                        </c:when>
                        <c:otherwise>
                            待审核
                        </c:otherwise>
                    </c:choose>
                </td>
                <td><span class="label label-success">
                    <c:if test="${userList.disabled == false}">已启用</c:if>
                    <c:if test="${userList.disabled == true}">已停用</c:if>
                </td>
                <td><odpf:formatDate style="DATE_HOUR_SECOND" date="${userList.createTime}"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="cl pd-5 bg-1 bk-gray mt-20">
        <span class="l"><strong>最新询盘</strong></span>
        <a href="${ctx}/inquiry/list"><span class="r">更多</span></a>
    </div>
    <table class="table table-border table-bordered table-hover table-bg table-sort">
        <thead>
        <tr class="text-c">
            <th width="136">询盘编号</th>
            <th width="83">买方</th>
            <th width="124">卖方</th>
            <th width="184">商品</th>
            <th width="57">状态</th>
            <th width="109">加入时间</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${inquiryList}" var="inquiry">
            <tr class="text-c">
                <td class="text-l"><a href="${ctx}/inquiry/detail?inquiryId=${inquiry.inquiryId}&inquiryType=1&inquiryStatus=${inquiry.inquiryStatus}">${inquiry.inquiryCode}</a></td>
                <td><a href="${ctx}/enterprise/${inquiry.orgId}/edit">${inquiry.orgName}</a></td>
                <td><a href="${ctx}/enterprise/${inquiry.feedbackOrgId}/edit">${inquiry.feedbackOrgName}</a><br/>
                    <a href="${ctx}/shops/edit/${inquiry.shopsId}">${inquiry.feedbackShopsName}</a><br/>
                    【<c:if test="${inquiry.feedbackShopsType == 1}">直属</c:if>
                    <c:if test="${inquiry.feedbackShopsType == 2}">挂靠</c:if>】</td>
                <td>
                    <c:forEach items="${fn:split(inquiry.products,',')}" var="product">
                        ${product}<br/>
                    </c:forEach>
                </td>
                <td class="article-status"><span class="label label-success">
                <c:choose>
                    <c:when test="${inquiry.inquiryStatus == 1}">询价中</c:when>
                    <c:when test="${inquiry.inquiryStatus == 2}">已回盘</c:when>
                    <c:when test="${inquiry.inquiryStatus == 3}">待确认</c:when>
                    <c:when test="${inquiry.inquiryStatus == 4}">已确认</c:when>
                    <c:when test="${inquiry.inquiryStatus == 5}">已取消</c:when>
                </c:choose>
            </span></td>
                <td><odpf:formatDate style="DATE_HOUR_SECOND" date="${inquiry.createTime}"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>


</td>
<td width="2%" valign="top">&nbsp;</td>
<td width="24%" valign="top"><div class="cl pd-5 bg-1 bk-gray mt-20">
    <span class="l"><strong>平台公告</strong></span>
    <a href="${ctx}/news/actionList"><span class="r">更多</span></a>
</div>
    <table class="table table-border table-bordered table-hover table-bg table-sort">
        <thead>
        </thead>
        <tbody>
        <c:forEach items="${newsList}" var="newsList" varStatus="varStatus">
            <tr class="text-c">
                <td><a href="${ctx}/news/${newsList.id}/edit">${newsList.title}</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <!--
    <div class="cl pd-5 bg-1 bk-gray mt-20">
        <span class="l"><strong>辅助工具</strong></span>
        <a href="#"><span class="r">更多</span></a>
    </div>
    <table class="table table-border table-bordered table-sort">
        <thead>
        </thead>
        <tbody>
        <tr class="text-l">
            <td width="57%">
                <div class="l mt-10 ml-20">
                    <p><a href="#"><img src="images/u131.png" width="90" height="89" alt=""/></a> </p>
                    <p class="text-c"><a href="#">HSCODE查询</a></p>
                </div>
                <div class="l mt-10 ml-20">
                    <p><a href="#"><img src="images/u131.png" width="90" height="89" alt=""/></a> </p>
                    <p class="text-c"><a href="#">报检流程</a></p>
                </div>
                <div class="l mt-10 ml-20">
                    <p><a href="#"><img src="images/u131.png" width="90" height="89" alt=""/></a> </p>
                    <p class="text-c"><a href="#">通关状态查询</a></p>
                </div>
                <div class="l mt-10 ml-20">
                    <p><a href="#"><img src="images/u131.png" width="90" height="89" alt=""/></a> </p>
                    <p class="text-c"><a href="#">企业基本情况</a></p>
                </div>
                <div class="l mt-10 ml-20">
                    <p><a href="#"><img src="images/u131.png" width="90" height="89" alt=""/></a> </p>
                    <p class="text-c"><a href="#">汇率查询</a></p>
                </div>
                <div class="l mt-10 ml-20">
                    <p><a href="#"><img src="images/u131.png" width="90" height="89" alt=""/></a> </p>
                    <p class="text-c"><a href="#">天气预报</a></p>
                </div>

            </td>
        </tr>
        </tbody>
    </table>
    -->
</td>
</tr>
</tbody>
</table>

</div>

</body>
</html>

