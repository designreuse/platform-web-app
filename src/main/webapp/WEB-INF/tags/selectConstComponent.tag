<%@ tag import="java.lang.reflect.Field" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="selData" type="java.util.Map" required="true"%>
<%@ attribute name="constKey" type="java.lang.Long" required="true"%>
<%

%>
<select id="sel_<%=constKey%>">
    <c:forEach items="${selData}" var="selData" varStatus="varStatus">
    </c:forEach>
</select>