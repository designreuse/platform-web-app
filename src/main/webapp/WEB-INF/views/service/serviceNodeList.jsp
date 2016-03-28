<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:forEach items="${nodeBoList}" var="nodeBoList">
    <td>${nodeBoList.serviceName}</td>
    <td><p>${nodeBoList.srvOrgName}</p></td>
    <td>${nodeBoList.nodeName}</td>
    <td><c:if test="${nodeBoList.status ==0}">未执行</c:if><c:if test="${nodeBoList.status ==1}">执行中</c:if><c:if test="${nodeBoList.status ==2}">已完成</c:if></td>
    <td><a>查看</a></td>
    <td>${nodeBoList.roleName}</td>
    <td>${nodeBoList.userName}</td>
    <td><odpf:formatDate style="DATE" date="${nodeBoList.planDate}"/></td>
    <td><odpf:formatDate style="DATE" date="${nodeBoList.actualDate}"/></td>
    <td><odpf:formatDate style="DATE" date="${nodeBoList.actualDate}"/></td>
</c:forEach>