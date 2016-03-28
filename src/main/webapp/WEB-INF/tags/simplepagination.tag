<%@ tag pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 简单列表分页。仅包含：  上一页   下一页 -->
<div class="uc-pages"><c:if test="${page.currentPage > 1 }"><a href="javascript:void(0);" data-page-number="${page.currentPage - 1}" class="ucp-pre page_a" title="上一页">上一页<i class="icon i5 ico-prearrow"></i></a></c:if><c:if test="${page.currentPage <= 1 }"><span class="ucp-pre"><i class="icon i5 ico-prearrow" title="上一页"></i></span></c:if><c:if test="${page.currentPage >= page.pages }"><span class="ucp-next"><i class="icon i5 ico-nextarrow" title="下一页"></i></span></c:if><c:if test="${page.currentPage < page.pages}"><a href="javascript:void(0);" data-page-number="${page.currentPage + 1}" class="ucp-next page_a" title="下一页">下一页<i class="icon i5 ico-nextarrow"></i></a></c:if></div>


