<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://www.wl.com/taglibs/staticResource" prefix="resource" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="isEdit" value="${param['action'] eq 'edit' || action eq 'edit'}"/>
<c:set var="isCreate" value="${param['action'] eq 'create' || action eq 'create'}"/>
<c:set var="isView" value="${param['action'] eq null || action eq null || action eq ''}"/>