<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
    window.ctx="${ctx}"
</script>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>基础模块-平台公告</title>
    <link type="text/css" href="${ctx}/resources/css/style-min.css" rel="stylesheet" />
    <link type="text/css" href="${ctx}/resources/css/bootstrap.min.css" rel="stylesheet" />
    <link type="text/css" href="${ctx}/resources/css/labelauty.css" rel="stylesheet" />
    <script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/jquery-ui.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container-fluid">
    <form id="form1" action="${ctx}/news/actionList" method="post">
    <div class="formtable">
        <div class="formtable-cont">
            <h4 class="header">平台公告</h4>
        </div>
        <div class="notice">
            <c:forEach items="${news.newsBos}" var="newsBo">
                <div class="notice_list">
                    <h3><a href="${ctx}/news/${newsBo.id}/noticeDetail"  nowrap="false"> ${newsBo.title}</a></h3>
                    <p>${newsBo.content}</p>
                    <p class="text_r"><span class="notice_list_data"><odpf:formatDate style="BPO_DATE_CHINA" date="${newsBo.releaseTime}"/></span></p>
                </div>
            </c:forEach>
        </div>
    </div>
    </form>
    <c:if test="${news.rowCount>0}">
        <div class="pagination pagination-centered width--100 background_color--2 mar_t--20-"
             id = "pageComponent">
        </div>
    </c:if>

</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
<script type="text/javascript" src="${ctx}/resources/js/jpage-class.js"></script>
<script>
    function detail(id){
        $.ajax({
            url:window.ctx + "/news/noticeDetail",
            type:"post",
            data:{"id":id},
            dataType:"json"
        })
    }


    var jpage = $("#pageComponent").SetPageComponent({
        pageIndex : "${news.pageIndex}",    //当前页码
        pageSize : "${news.pageSize}",      //每页条数
        rowCount : "${news.rowCount}",      //数据总数
        pageFormID : "form1"      //表单id
    });
</script>
</html>