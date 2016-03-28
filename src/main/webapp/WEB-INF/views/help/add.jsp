<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>内容中心-新增问题</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">内容中心</a>
    </li>
    <li>
        <a href="${ctx}/help/list">帮助中心管理</a>
    </li>
    <li>
        <a href="#">新增问题</a>
    </li>
</nav>
<div class="container-fluid">
    <div class="formtable">
        <form id="form1" class="cmxform">
            <div class="formtable-cont">
                <h4 class="header" id="base">基本信息</h4>
                <div class="formtable-list">
                    <label class="col-md-2 formtable-list-require">问题标题：</label>
                    <div class="col-md-6">
                        <input class="form-control" id="problem" name="problem">
                    </div>
                </div>
                <div class="formtable-list" id="divProblemRu" style="display: none">
                    <label class="col-md-2 formtable-list-require">问题标题（俄文）：</label>
                    <div class="col-md-6">
                        <input class="form-control" id="problemTranslation" name="problemTranslation">
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">平台：</label>
                    <div class="col-sm-4">
                        <select class="form-control" id="appId" name="appId">
                            <option value="3" selected="selected">供应商</option>
                            <option value="5">采购商</option>
                        </select>
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-md-2 formtable-list-require">问题类型：</label>
                    <div class="col-md-4">
                        <select class="form-control" id="helpTypeId" name="helpTypeId">
                            <option value="">请选择</option>
                            <c:forEach items="${helpAddView.helpTypeBoList}" var="type">
                                <option value="${type.id}">${type.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">内容 ：</label>
                    <div class="col-sm-9">
                        <textarea id="myEditor"  name="answer" style="width:100%;"></textarea>
                    </div>
                </div>
                <div class="formtable-list" id="divAnswerRu" style="display: none">
                <label class="col-sm-2 formtable-list-require">内容（俄文）：</label>
                <div class="col-sm-9">
                    <textarea id="myEditorRu"  name="answerTranslation" style="width:100%;"></textarea>
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
<script type="text/javascript" src="${ctx}/resources/js/help/add.js"></script>
<%--百度编辑器开始--%>
<link href="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/lang/zh-cn/zh-cn.js"></script>
<%--百度编辑器结束--%>
</body>
</html>
