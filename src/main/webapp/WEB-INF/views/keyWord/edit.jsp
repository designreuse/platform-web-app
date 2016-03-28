<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>SEO详情</title>
    <%@include file="/WEB-INF/common/global/common.jsp" %>
</head>
<body>
<div class="container-fluid">
    <div class="formtable">


        <form class="formtable-cont" id="keywordForm">
            <h4 class="header header-fl" id="baseInfo">基本信息</h4>
            <input type="submit" id="save" value="保存" class="btn btn-primary header-button"/>
            <input type="hidden" value="${keywordBo.id}" name="id">
            <div class="clear"></div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">所属平台：</label>
                    <div class="col-sm-7 col-md-8">
                        <div class="form-inline">
                            <div class="form-group">
                                <select id="appId" name="appId" class="form-control">
                                    <c:forEach var="item" items="${appType}">
                                        <option value="${item.constValue}" <c:if test="${item.constValue == keywordBo.appId}">selected</c:if> >${item.constName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">位置编号：</label>
                    <div class="col-sm-7 col-md-8">
                        <input type="text" name="locationKey" class="form-control" value="${keywordBo.locationKey}">
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 <c:if test="${keywordBo.appId == 3}">formtable-list-require</c:if>  cn">标题（中文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <input type="text" name="titleCn" class="form-control" value="${keywordBo.titleCn}">
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 <c:if test="${keywordBo.appId == 5}">formtable-list-require</c:if> ru">标题（俄文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <input type="text" name="titleRu" class="form-control" value="${keywordBo.titleRu}">
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 <c:if test="${keywordBo.appId == 3}">formtable-list-require</c:if> cn">关键字（中文）：</label>
                    <div class="col-sm-7 col-md-8">
                        <input type="text" name="keywordCn" class="form-control" value="${keywordBo.keywordCn}">
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 <c:if test="${keywordBo.appId == 5}">formtable-list-require</c:if> ru">关键字（俄文）：</label>
                    <div class="col-sm-7 col-md-8">
                        <input type="text" name="keywordRu" class="form-control" value="${keywordBo.keywordRu}">
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 <c:if test="${keywordBo.appId == 3}">formtable-list-require</c:if> cn">描述（中文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <textarea class="form-control" rows="7" name="descCn"
                                  placeholder="请输入500个以内中文字符">${keywordBo.descCn}</textarea>
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 <c:if test="${keywordBo.appId == 5}">formtable-list-require</c:if> ru">描述（俄文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <textarea name="descRu" class="form-control" rows="7"
                                  placeholder="请输入500个以内俄文字符">${keywordBo.descRu}</textarea>
                    </div>
                </div>
            </div>
            <div class="formtable-list " >
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 ">备注说明：</label>

                    <div class="col-sm-7 col-md-8">
                        <input type="text" name="memo" class="form-control" value="${keywordBo.memo}">
                    </div>
                </div>

            </div>
        </form>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/keyWord/edit.js"></script>
</body>
</html>