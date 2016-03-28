<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>会员中心-会员商铺编辑</title>
</head>
<body>
<div class="container-fluid">
<div class="formtable">
<form id="editForm" class="formtable-cont">
    <div class="formtable-nav">
    <ul class="list-inline">
        <li><a href="#baseInfo" class="btn btn-primary">基本信息</a></li>
        <li class="pull-right">
            <c:if test="${friendshipLinkBo.disabled == 1}">
                <a id="abledBtn" href="#" class="btn btn-success">启用</a>
                <input id="disabled" name="disabled" value="1" hidden="hidden">
            </c:if>
            <c:if test="${friendshipLinkBo.disabled != 1}">
                <a id="disabledBtn" href="#" class="btn btn-danger">停用</a>
                <input id="disabled" name="disabled"  value="0" hidden="hidden">
            </c:if>
        </li>
    </ul>
</div>
    <input id="id" name="id" value="${friendshipLinkBo.id}" hidden="hidden">
    <h4 class="header header-fl" id="baseInfo">基本信息</h4>
    <button id="saveBtn" class="btn btn-primary header-button">保存</button>
    <div class="clear"></div>
    <%--<div class="formtable-list">--%>
            <%--<div class="col-xs-6">--%>
                <%--<label class="col-sm-5 col-md-4 formtable-list-require">所属平台：</label>--%>
                <%--<div class="col-sm-7 col-md-8">--%>
                    <%--<div class="form-inline">--%>
                        <%--<div class="form-group">--%>
                            <%--<select id="appId" name="appId" class="form-control">--%>
                                <%--<c:forEach var="item" items="${appType}">--%>
                                    <%--<option value="${item.constValue}" <c:if test="${item.constValue == friendshipLinkBo.appId}">selected</c:if> >${item.constName}</option>--%>
                                <%--</c:forEach>--%>
                            <%--</select>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
    <%--</div>--%>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4 formtable-list-require">链接图片：</label>
            <div class="col-sm-7 col-md-8 pad_10 hide-input">
                <a>
                    <c:if test="${friendshipLinkBo.logoUrl!=null}">
                        <img  width="300" src="${friendshipLinkBo.logoUrl}" height="100" id="logoUrlSrc" onclick="LogoClick()">
                    </c:if>
                    <c:if test="${friendshipLinkBo.logoUrl==null}">
                        <img src="${ctx}/resources/images/bn.jpg" width="300" height="100" id="logoUrlSrc" onclick="LogoClick()">
                    </c:if>
                </a>
                <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0" class="btn-uploadpic" name="file" multiple="" id="logoUrlId">
                <input class="hide" id="logoUrl" name="logoUrl" value="${friendshipLinkBo.logoUrl}">
                <p class="mar_t10">图片大小支持4MB，图片尺寸为600X100</p>
            </div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">链接地址：</label>
            <div class="col-sm-7 col-md-8">
                <input id="url" name="url" value="${friendshipLinkBo.url}" type="text" class="form-control">
            </div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4">链接顺序：</label>
            <div class="col-sm-7 col-md-8">
                <input id="sort" name="sort" value="${friendshipLinkBo.sort}" type="text" class="form-control">
            </div>
        </div>
    </div>
</form>
</div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/validation/util.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/friendShip/edit.js"></script>
</body>
</html>