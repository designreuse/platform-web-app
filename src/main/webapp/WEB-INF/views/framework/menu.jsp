<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>

<html >
<head>
    <script src="${ctx}/resources/lib/jquery-1.9.1.min.js"  type="text/javascript"></script>
    <%@include file="../framework/header_common.jsp" %>
</head>
<body>
    <!-- 加载菜单 -->
    <odpf:generateMenu id="5" includeRoot="true" theme="operation"></odpf:generateMenu>
</body>

<script type="text/javascript">

$(".hc").click(function()
		{
			if ($(this).siblings("ul").children().is(":hidden")) {
			
			     $(this).siblings("ul").removeClass("hide");

			     $(this).children("i").addClass("arrowbtm");
	        }
	        else {

			     $(this).siblings("ul").addClass("hide");
			     $(this).children("i").removeClass("arrowbtm");
				
			 }
		});	
    /******************************/

</script>
<%--<script src="${ctx}/resources/lib/require.js"  data-main="${ctx}/resources/js/main"></script>--%>
</html>
