<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <link type="text/css" href="${ctx}/resources/css/index.css" rel="stylesheet" />
    <link type="text/css" href="${ctx}/resources/css/labelauty.css" rel="stylesheet" />
    <title>我的服务订单</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 服务订单
    <span class="c-gray en">&gt;</span> 我的服务订单
    <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" >
        <i class="icon-refresh"></i></a></nav>
<form action="${ctx}/serviceOrder/myList"  method="post" class="searchform" id="searchform">
    <div class="pd-20">
        <div class="text-l">
            <table width="100%" border="0" cellspacing="3" cellpadding="0">
                <tr>
                    <td width="8%" height="44">服务订单编号：</td>
                    <td width="24%"><input type="text" class="input-text" style="width:150px" placeholder="输入服务订单编号"
                                           value="${entity.srvOrderCode}" id="input" name="srvOrderCode"></td>
                    <td width="6%">委托方：</td>
                    <td width="17%"><input type="text" class="input-text" style="width:150px" placeholder="委托方"
                                           value="${entity.orgName}" id="input3" name="orgName"></td>
                    <td width="5%">联系人：</td>
                    <td width="16%"><input type="text" class="input-text" style="width:150px" placeholder="联系人"
                                           value="${entity.contactsName}" id="input4" name="contactsName"></td>
                </tr>
                <tr>
                    <td height="46">日期范围：</td>
                    <td>
                        <input type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}'})"
                               value="<odpf:formatDate style='DATE' date='${entity.createTimeBegin}'/>" name="createTimeBegin" id="datemin" class="input-text Wdate" style="width:100px;">
                        -
                        <input type="text" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d'})"
                               value="<odpf:formatDate style='DATE' date='${entity.createTimeEnd}'/>" name="createTimeEnd" id="datemax" class="input-text Wdate" style="width:100px;">

                    </td>
                    <td>委托服务：</td>
                    <td>
                        <select class="select" name="orderService" size="1" style="width:120px">
                            <option value="">全部</option>
                            <option value="出口代理" <c:if test="${entity.orderService == '出口代理'}">selected</c:if>>出口代理</option>
                            <option value="出口报检" <c:if test="${entity.orderService == '出口报检'}">selected</c:if>>出口报检</option>
                            <option value="出口报关" <c:if test="${entity.orderService == '出口报关'}">selected</c:if>>出口报关</option>
                            <option value="俄境清关" <c:if test="${entity.orderService == '俄境清关'}">selected</c:if>>俄境清关</option>
                            <option value="国内运输" <c:if test="${entity.orderService == '国内运输'}">selected</c:if>>国内运输</option>
                            <option value="俄境运输" <c:if test="${entity.orderService == '俄境运输'}">selected</c:if>>俄境运输</option>
                            <option value="国内仓储" <c:if test="${entity.orderService == '国内仓储'}">selected</c:if>>国内仓储</option>
                            <option value="俄境仓储" <c:if test="${entity.orderService == '俄境仓储'}">selected</c:if>>俄境仓储</option>
                        </select>
                    </td>
                    <td>状态：</td>
                    <td><select class="select" name="status" size="1" style="width:120px">
                        <option value="">全部</option>
                        <option value="1" <c:if test="${entity.status == 1}">selected</c:if>>待分配</option>
                        <option value="2" <c:if test="${entity.status == 2}">selected</c:if>>待执行</option>
                        <option value="3" <c:if test="${entity.status == 3}">selected</c:if>>已完成</option>
                        <option value="4" <c:if test="${entity.status == 4}">selected</c:if>>已取消</option>
                    </select></td>
                    <td>&nbsp;</td>
                    <td><button type="submit" class="btn btn-success" id="button" name=""><i class="icon-search"></i> 搜索</button></td>
                </tr>
            </table>
        </div>

        <table class="table table-border table-bordered table-hover table-bg table-sort">
            <thead>
            <tr class="text-c">
                <th width="136">订单编号</th>
                <th width="183">委托方</th>
                <th width="92">联系人</th>
                <th width="177">委托服务</th>
                <th width="112">创建时间</th>
                <th width="70">状态</th>
                <th width="106">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${orderList}" var="order">
                <tr class="text-c">
                    <td><a href="${ctx}/serviceOrder/${order.srvOrderId}/mySrvDetail">${order.srvOrderCode}</a></td>
                    <td>${order.orgNameCn}</td>
                    <td>${order.userNameCn} - ${order.mobile}</td>
                    <td>${order.orderService}</td>
                    <td><odpf:formatDate style='DATE' date='${order.createTime}'/></td>
                    <c:if test="${order.status == 1}">
                        <td class="user-status">
                            <span class="label label-success">待确认</span>
                        </td>
                        <td class="f-14 user-manage">
                            <a href="${ctx}/serviceOrder/${order.srvOrderId}/edit"  class="btn btn-primary radius">确认</a>
                        </td>
                    </c:if>
                    <c:if test="${order.status == 2}">
                        <td class="user-status">
                            <span class="label label-success">待分配</span>
                        </td>
                        <td class="f-14 user-manage">
                            <a href="${ctx}/serviceOrder/${order.srvOrderId}/execute"  class="btn btn-primary radius">分配</a>
                        </td>
                    </c:if>
                    <c:if test="${order.status == 3}">
                        <td class="user-status">
                            <span class="label label-success">执行中</span>
                        </td>
                        <td class="f-14 user-manage">
                            <a href="${ctx}/serviceOrder/${order.srvOrderId}/execute"  class="btn btn-primary radius">执行</a>
                        </td>
                    </c:if>
                    <c:if test="${order.status == 4}">
                        <td class="user-status">
                            <span class="label label-success">已执行</span>
                        </td>
                        <td class="f-14 user-manage">
                        </td>
                    </c:if>
                    <c:if test="${order.status == 5}">
                        <td class="user-status">
                            <span class="label label-success">已取消</span>
                        </td>
                        <td class="f-14 user-manage">
                        </td>
                    </c:if>
                    <c:if test="${order.status == 6}">
                        <td class="user-status">
                            <span class="label label-success">已终止</span>
                        </td>
                        <td class="f-14 user-manage">
                        </td>
                    </c:if>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <script type="text/javascript" src="${ctx}/resources/js/page/page-common.js"></script>
        <tags:pageComponent pageNumber="${page.currentPage}" pageSize="${page.pageSize}" totalRows="${count}"/>
    </div>
</form>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/layer/layer.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common/page.js"></script>
</body>
</html>