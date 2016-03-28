<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>基础模块-公告详情</title>
</head>
<body>
<div class="container-fluid">
    <div class="formtable">
        <div class="formtable-cont">
            <h4 class="header">平台公告</h4>
        </div>
        <div class="notice">
            <div class="notice_list">
                <h3>${news.newsBo.title}</h3>
                <p>${news.newsBo.content}</p>
                <p class="text_r"><span class="notice_list_data"><odpf:formatDate style="BPO_DATE_CHINA" date="${news.newsBo.releaseTime}"/></span></p>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>
