<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>修改用户协议</title>
</head>
<body>
<div class="container-fluid">
    <div class="formtable">
        <form class="cmxform" id="form1" action="${ctx}/userAgreement/edit" method="post">
            <input type="hidden" id="id" name="id" value="${userAgreement.id}"/>
            <div class="formtable-cont">
                <h4 class="header" id="base">基本信息</h4>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">平台：</label>
                    <div class="col-sm-4">
                        <select class="form-control" disabled>
                            <option>${userAgreement.appName}</option>
                        </select>
                    </div>
                </div>

                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">内容：</label>
                    <div class="col-sm-9">
                        <textarea id="myEditor" class="required " name="content" style="width:100%;">${userAgreement.content}</textarea>
                    </div>
                </div>

                <c:if test="${ userAgreement.appId == 5}">
                    <div class="formtable-list">
                        <label class="col-sm-2 formtable-list-require">内容(俄文)：</label>
                        <div class="col-sm-9">
                            <textarea id="myEditorRu" class="required " name="contentRu" style="width:100%;">${userAgreement.contentRu}</textarea>
                        </div>
                    </div>
                </c:if>
            </div>
            <div class="formtable-cont text_c">
                <button id="save" class="btn btn-primary check-text">保存</button>
            </div>
        </form>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<%--<script type="text/javascript" src="${ctx}/resources/js/news/add.js"></script>--%>

<%--百度编辑器开始--%>
<link href="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/lang/zh-cn/zh-cn.js"></script>
<%--百度编辑器结束--%>
<script type="application/javascript" >
$(function(){
    //初始化百度编辑器
    UM.getEditor('myEditor');
    UM.getEditor('myEditorRu');
    var appSelectNode = $(".appSelectClass")
    $(".appSelectClass").remove();

    if('${msg}' !== ''){
        alert('${msg}');
    }
})

</script>
</body>
</html>
