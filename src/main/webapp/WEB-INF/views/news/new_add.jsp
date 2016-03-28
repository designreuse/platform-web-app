<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/global/common.jsp"%>
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
        <a href="${ctx}/news/add">新增资讯</a>
    </li>
</nav>
<div class="container-fluid">
    <div class="formtable">
        <input type="hidden" id="disabled"  value="${newsAddView.newsBo.disabled}"/>
        <form class="cmxform" id="form1">
            <input type="hidden" id="id" name="id" value="${newsAddView.newsBo.id}"/>
            <div class="formtable-cont">
                <h4 class="header" id="base">基本信息</h4>
                <c:if test="${newsAddView.newsBo.id != null}">

                    <c:if test="${!newsAddView.newsBo.disabled}">
                        <button type="button" class="btn btn-danger header-button status">停用</button>
                    </c:if>
                    <c:if test="${newsAddView.newsBo.disabled}">
                        <button type="button" class="btn btn-success header-button status">启用</button>
                    </c:if>
                    <button type="button" class="btn btn-danger header-button " id="deleteNews">删除</button>
                    <div class="clear"></div>
                </c:if>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">标题(中文)：</label>
                    <div class="col-xs-6">
                        <input class="form-control" id="title" name="title" value="${newsAddView.newsBo.title}">
                    </div>
                </div>
                <div class="formtable-list" id="divTitleRu"<c:if test="${newsAddView.newsBo.appId !=5}"> style="display: none"</c:if>>
                    <label class="col-sm-2 formtable-list-require">标题(俄文)：</label>
                    <div class="col-xs-6">
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
                    <div class="col-sm-4 input-group date-timepicker date" style="padding:5px 10px 5px 20px;">
                        <input type="text" id="releaseTime" name="releaseTime" value="<odpf:formatDate style='DATE_HOUR' date='${newsAddView.date}'/>"  class=" form-control no_mar" >
                        <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">内容(中文)：</label>
                    <div class="col-sm-9">
                        <textarea id="myEditor" class="required " name="content" style="width:100%;">${newsAddView.newsBo.content}</textarea>
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2">内容(俄文)：</label>
                    <div class="col-sm-9">
                        <textarea id="myEditorRu" class="required " name="contentRu" style="width:100%;">${newsAddView.newsBo.contentRu}</textarea>
                    </div>
                </div>

            </div>
            <div class="formtable-cont text_c">
                <button id="save" class="btn btn-primary check-text">保存</button>
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
<script type="application/javascript" >
</script>
</body>
</html>
