<%@ tag import="java.lang.reflect.Field" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="pageNumber" type="java.lang.Long" required="true"%>
<%@ attribute name="pageSize" type="java.lang.Long" required="true"%>
<%@ attribute name="totalRows" type="java.lang.Long" required="true"%>
<%
    if (pageSize<=0) {
        pageSize = 10L;
    }

    long totalPage=(totalRows/pageSize);
    if (totalRows % pageSize > 0) {
        totalPage = totalPage + 1;
    }
    long begin = Math.max(1, pageNumber - 5);
    long end = Math.min(pageNumber + 4,totalPage);

    request.setAttribute("pageSize", pageSize);
    request.setAttribute("totalPage", totalPage);
    request.setAttribute("p_begin", begin);
    request.setAttribute("p_end", end);
%>


<div id="pageNav" class="pageNav">
    <input type="hidden" id="pageNumber" name="pageNumber" value="<%=pageNumber%>">
    <input type="hidden" id="pageSize" name="pageSize"  value="<%=pageSize%>">
    <% if (pageNumber!=1){%>
        <a href="javascript:gotoPage(1);" class="pageNum">首页</a>
        <a href="javascript:gotoPage(<%=pageNumber-1%>)" class="pageNum">上一页</a>
    <%}else{%>
        <b>首页</b>
        <b>上一页</b>
    <%}%>
    <c:forEach var="i" begin="${p_begin}" end="${p_end}">
        <c:choose>
            <c:when test="${i == pageNumber}">
                <b>${i}</b>
            </c:when>
            <c:otherwise>
                <a href="javascript:gotoPage(${i});" class="pageNum">${i}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <% if (totalPage>end){%>
        <span class="mor">...</span>
    <%}%>

    <% if (pageNumber!=totalPage){%>
        <a href="javascript:gotoPage(<%=pageNumber+1%>);" class="pageNum">下一页</a>
        <a href="javascript:gotoPage(<%=totalPage%>)" class="pageNum">末页</a>
    <%}else{%>
        <b>下一页</b>
        <b>末页</b>
    <%}%>
</div>
