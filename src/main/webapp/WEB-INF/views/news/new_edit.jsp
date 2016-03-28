<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/views/common.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>内容中心-新增资讯</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">内容中心</a>
    </li>
    <li>
        <a href="${ctx}/news/list">资讯管理</a>
    </li>
    <li>
        <a href="${ctx}/news/${newsAddView.newsBo.id}/edit">资讯编辑</a>
    </li>
</nav>
<div class="container">
    <div class="formtable">
        <form class="cmxform" id="newsForm" action="${ctx}/news/save" method="post">
            <input type="hidden" name="id" value="${newsAddView.newsBo.id}"/>
            <div class="formtable-cont">
                <h4 class="header">基本信息</h4>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">标题(中文)：</label>
                    <div class="col-sm-6">
                        <input class="form-control" id="title" name="title" value="${newsAddView.newsBo.title}">
                    </div>
                </div>
                <div class="formtable-list" id="divTitleRu" <c:if test="${newsAddView.newsBo.appId !=5}"> style="display: none"</c:if>>
                    <label class="col-sm-2 formtable-list-require">标题(俄文)：</label>
                    <div class="col-sm-6">
                        <input class="form-control" id="titleRu" name="titleRu" value="${newsAddView.newsBo.titleRu}">
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">平台：</label>
                    <div class="col-sm-4">
                        <select class="form-control" id="appId" name="appId">
                            <option value="">请选择</option>
                            <c:forEach items="${newsAddView.platTypes}" var="type">
                                <option value="${type.constValue}" <c:if test="${type.constValue == newsAddView.newsBo.appId}">selected ="selected"</c:if> >${type.constName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">栏目：</label>
                    <div class="col-sm-4">
                        <select class="form-control" id="channel" name="channel">
                            <option value="">请选择</option>
                            <c:forEach items="${newsAddView.newsTypes}" var="type">
                                <option value="${type.constValue}" <c:if test="${type.constValue == newsAddView.newsBo.channel}">selected ="selected"</c:if>>${type.constName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">发布日期：</label>
                    <div class="col-sm-4 input-group datepicker date" style="padding:5px 10px 5px 20px;">
                        <input type="text" id="releaseTime" name="releaseTime" value="<odpf:formatDate style='DATE_HOUR' date='${newsAddView.date}'/>"  class=" form-control no_mar" readonly>
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">内容(中文)：</label>
                    <div class="col-sm-9">
                        <textarea id="myEditor" class="required" name="content" style="width:100%;height:100%;">${newsAddView.newsBo.content}</textarea>
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">内容(俄文)：</label>
                    <div class="col-sm-9">
                        <textarea id="myEditorRu" class="required" name="contentRu" style="width:100%;height:100%;">${newsAddView.newsBo.contentRu}</textarea>
                    </div>
                </div>
            </div>
        <div class="formtable-cont text_c">
            <button id="save" class="btn btn-primary">保存</button>
        </div>
        </form>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/news/add.js"></script>
<%--百度编辑器开始--%>
<link href="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/lang/zh-cn/zh-cn.js"></script>
<%--百度编辑器结束--%>
<%--<script type="application/javascript">--%>
    <%--$(function(){--%>
        <%--var option = {--%>
            <%--ele: "#newsForm",--%>
            <%--rules: {--%>
                <%--title: {--%>
                    <%--required: true--%>
                <%--},--%>
                <%--titleRu: {--%>
                    <%--required: function(e){--%>
                        <%--if($("#appId").val() == 3){--%>
                            <%--alert(111)--%>
                            <%--return false--%>
                        <%--}else{--%>
                            <%--return true--%>
                        <%--}--%>
                    <%--}--%>
                <%--},--%>
                <%--appId: {--%>
                    <%--required: true--%>
                <%--},--%>
                <%--channel:{--%>
                    <%--required:true--%>
                <%--},--%>
                <%--releaseTime:{--%>
                    <%--required:true--%>
                <%--},--%>
                <%--myEditor:{--%>
                    <%--required:true--%>
                <%--}--%>
            <%--},--%>
            <%--messages:{--%>
                <%--title: {--%>
                    <%--required: "标题不能为空"--%>
                <%--},--%>
                <%--titleRu: {--%>
                    <%--required: "标题不能为空"--%>
                <%--},--%>
                <%--appId: {--%>
                    <%--required: "请选择平台"--%>
                <%--},--%>
                <%--channel:{--%>
                    <%--required:"请选择栏目"--%>
                <%--},--%>
                <%--releaseTime:{--%>
                    <%--required:"发布时间不能为空"--%>
                <%--},--%>
                <%--myEditor:{--%>
                    <%--required:"资讯内容不能为空"--%>
                <%--}--%>
            <%--},--%>
            <%--submitHandler: function(form){--%>
                <%--$(form).AjaxSubmit();--%>
            <%--}--%>
        <%--}--%>
        <%--validatorFrom.initValidatorFrom(option);--%>
    <%--})--%>

<%--</script>--%>
</body>
</html>
