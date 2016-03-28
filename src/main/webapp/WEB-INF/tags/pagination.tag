<%@ tag pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script src="<c:url value="/resources/js/common/page.js" />"></script>
<script type="text/javascript">
 	jQuery(document).ready(function(){
 		setClickPage();

 	});
 </script>
<div class="uc-pages" id="paging">
	<c:choose>
		<c:when test="${page.currentPage <= 1 }">
			<span class="ucp-pre"> <i class="icon i5 ico-prearrow"> </i>上一页
			</span>
			<span class="ucp-crt">1</span>
		</c:when>
		<c:otherwise>
			<a class="ucp-pre page_a" href="javascript:void(0);"
				data-page-number="${page.currentPage - 1}"> <i
				class="icon i5 ico-prearrow"></i>上一页
			</a>
			<a href="javascript:void(0);" class="page_a" data-page-number="1">1</a>
		</c:otherwise>
	</c:choose>
	<c:if test="${page.pages > 1 }">
		<c:choose>
			<c:when test="${page.pages<=6}">
				<c:forEach var="i" begin="2" end="${page.pages-1}">
					<c:choose>
						<c:when test="${i == page.currentPage }">
							<span class="ucp-crt">${i }</span>
						</c:when>
						<c:otherwise>
							<a href="javascript:void(0);" class="page_a"
								data-page-number="${i}">${i }</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${page.currentPage < 5}">
						<c:forEach var="i" begin="2" end="5">
							<c:choose>
								<c:when test="${i == page.currentPage }">
									<span class="ucp-crt">${i }</span>
								</c:when>
								<c:otherwise>
									<a href="javascript:void(0);" class="page_a"
										data-page-number="${i}">${i }</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>...</c:when>
					<c:when test="${page.pages < page.currentPage + 4 }">...
<c:forEach var="i" begin="${page.pages - 4}" end="${page.pages - 1}">
							<c:choose>
								<c:when test="${i == page.currentPage }">
									<span class="ucp-crt">${i }</span>
								</c:when>
								<c:otherwise>
									<a href="javascript:void(0);" class="page_a"
										data-page-number="${i}">${i }</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
					<c:otherwise>...<c:forEach var="i"
							begin="${page.currentPage - 2 }" end="${page.currentPage + 2}">
							<c:choose>
								<c:when test="${i == page.currentPage }">
									<span class="ucp-crt">${i }</span>
								</c:when>
								<c:otherwise>
									<a href="javascript:void(0);" class="page_a"
										data-page-number="${i}">${i }</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>...</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
	</c:if>
	<c:choose>
		<c:when test="${page.currentPage >= page.pages }">
			<c:if test="${page.pages > 1 }">
				<span class="ucp-crt">${page.pages }</span>
			</c:if>
			<span class="ucp-next">下一页<i class="icon i5 ico-nextarrow"></i></span>
		</c:when>
		<c:otherwise>
			<c:if test="${page.pages > 1 }">
				<a href="javascript:void(0);" class="page_a"
					data-page-number="${page.pages}">${page.pages }</a>
			</c:if>
			<a href="javascript:void(0);"
				data-page-number="${page.currentPage + 1}" class="ucp-next page_a">下一页<i
				class="icon i5 ico-nextarrow"></i></a>
		</c:otherwise>
	</c:choose>
	<span id="selectPageByOne">每页</span> <select name="pageSize" id="pageSize"
		style="width: 50px;" class="chzn-select pageSize" onchange="getPageSize()">
		<option value="10"
			<c:if test="${page.pageSize == 10}">  selected </c:if>>10
			</option>
		<option value="20"
			<c:if test="${page.pageSize == 20}">  selected </c:if>>20</option>
		<option value="50"
			<c:if test="${page.pageSize == 50}">  selected </c:if>>50</option>
		<option value="100"
			<c:if test="${page.pageSize == 100}">  selected </c:if>>100</option>
	</select> <span>条</span>
</div>

<div class="uc-pages comm"  id="pagingComm">
</div>
