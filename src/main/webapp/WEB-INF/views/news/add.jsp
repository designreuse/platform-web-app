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
<div class="container">
    <div class="formtable">
        <form id="form1" action="${ctx}/news/save" method="post">
        <div class="formtable-cont">
            <h4 class="header">基本信息</h4>
            <div class="formtable-list">
                <label class="col-md-2 formtable-list-require">标题：</label>
                <div class="col-md-6">
                    <input class="form-control" id="title" name="title">
                </div>
            </div>
            <div class="formtable-list">
                <label class="col-md-2 formtable-list-require">平台：</label>
                <div class="col-md-4">
                    <select class="form-control" id="appId" name="appId">
                        <option value="">请选择</option>
                        <c:forEach items="${newsBo.platTypes}" var="type">
                            <option value="${type.constValue}">${type.constName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="formtable-list">
                <label class="col-md-2 formtable-list-require">栏目：</label>
                <div class="col-md-4">
                    <select class="form-control" id="channel" name="channel">
                        <option value="">请选择</option>
                        <c:forEach items="${newsBo.newsTypes}" var="type">
                            <option value="${type.constValue}">${type.constName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="formtable-list">
                <label class="col-md-2 formtable-list-require">发布日期：</label>
                <div class="col-md-4 input-group datepicker date" style="padding:5px 10px 5px 20px;">
                    <input type="text" id="releaseTime" name="releaseTime"  class=" form-control no_mar" readonly>
                    <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                </div>
            </div>
            <div class="formtable-list">
                <label class="col-md-2 formtable-list-require">内容：</label>
                <div class="col-md-10">
                    <textarea id="myEditor"  name="content" style="width:100%;height:100%;"></textarea>
                </div>
            </div>
        </div>

        <div class="formtable-cont text_c">
            <button id="save"  class="btn btn-primary">保存</button>
        </div>
        </form>
    </div>
</div>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/news/add.js"></script>
<%--百度编辑器开始--%>
<link href="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/lang/zh-cn/zh-cn.js"></script>
<%--百度编辑器结束--%>
</body>
</html>
