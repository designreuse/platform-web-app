<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>

<%--<link type="text/css" href="${ctx}/resources/css/cssreset-min.css" rel="stylesheet" />--%>
<link type="text/css" href="${ctx}/resources/css/bootstrap.min.css" rel="stylesheet" />
<link type="text/css" href="${ctx}/resources/css/labelauty.css" rel="stylesheet" />
<link rel="stylesheet" href="${ctx}/resources/plugin/datetimepicker/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="${ctx}/resources/css/jquery-ui.css">

<script type="text/javascript" src="${ctx}/resources/js/respond.min.js"></script>

<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/bootstrap.min.js"></script>

<script type="text/javascript" src="${ctx}/resources/js/common/dateformat.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-validation/dist/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-validation/validatorFrom.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-validation/jquery.validate.extend.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-validation/dist/localization/messages_zh.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/util.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/notyfy/notyfy.min.js"></script>
<script type="text/javascript">
    window.ctx="${ctx}"
</script>