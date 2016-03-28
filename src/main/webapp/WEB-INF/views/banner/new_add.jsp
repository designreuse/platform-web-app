<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>内容中心-新增广告</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">内容中心</a>
    </li>
    <li>
        <a href="${ctx}/banner/list">广告管理</a>
    </li>
    <li>
        <a href="#">广告编辑</a>
    </li>
</nav>
<div class="container-fluid">
    <div class="formtable">
        <input type="hidden" id="disabled"  value="${banner.bannerBo.disabled}"/>
        <form class="cmxform" id="form1" action="${ctx}/banner/save" method="post">
            <input type="hidden" id="id" name="id" value="${banner.bannerBo.id}"/>
            <div class="formtable-cont">
                <h4 class="header" id="base">基本信息</h4>
                <c:if test="${banner.bannerBo.id != null}">
                    <c:if test="${!banner.bannerBo.disabled}">
                        <button type="button" class="btn btn-danger header-button status">停用</button>
                    </c:if>
                    <c:if test="${banner.bannerBo.disabled}">
                        <button type="button" class="btn btn-success header-button status">启用</button>
                    </c:if>
                    <button type="button" class="btn btn-danger header-button" id="deleteBanner">删除</button>
                    <div class="clear"></div>
                </c:if>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">平台：</label>
                        <div class="col-sm-7 col-md-8">
                            <select class="form-control" id="appId" name="appId">
                                <option value="">请选择</option>
                                <c:forEach items="${banner.platTypes}" var="type">
                                    <option value="${type.constValue}" <c:if test="${type.constValue == banner.bannerBo.appId}">selected ="selected"</c:if> >${type.constName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">广告位：</label>
                        <div class="col-sm-7 col-md-8">
                            <select class="form-control" id="adLocationId" name="adLocationId">
                                <option value="">请选择</option>
                                <c:forEach items="${banner.adLocations}" var="type">
                                    <option value="${type.id}" <c:if test="${type.id == banner.bannerBo.adLocationId}">selected ="selected"</c:if>>${type.adLocationKey}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="col-xs-6 label-cont" style="float:left;" id="locationDesc">${banner.bannerBo.adLocationBo.adLocationKey}  ${banner.bannerBo.adLocationBo.adDescribe}:${banner.bannerBo.adLocationBo.picSize}</div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">投放时间：</label>
                    <div class="col-sm-10 pad_l20">
                        <div class="col-xs-4 col-sm-3 input-group datepicker date">
                            <input type="text" id="startTime" name="startTime"  value="<odpf:formatDate style='DATE' date='${banner.bannerBo.startTime}'/>" class="no_mar form-control" >
                            <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                        </div>
                        <span class="pad_10 fl_l">-</span>
                        <div class="col-xs-4 col-sm-3 input-group datepicker date">
                            <input type="text" id="endTime" name="endTime"  value="<odpf:formatDate style='DATE' date='${banner.bannerBo.endTime}'/>"  class="no_mar form-control" >
                            <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">广告图片：</label>
                    <input type="hidden" id="bannerLogo" value="${banner.bannerBo.bannerLogo}"/>
                    <div class="col-sm-10 pad_10 hide-input">
                        <img src="${ctx}/resources/images/bn.jpg" class="img-responsive mar_l10" id="bannerSrc" onclick="reOLUploadFro();">
                        <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0" class="btn-uploadpic" name="file" multiple="" id="bannerUrl">
                        <input class="hide" name="bannerLogo" value="${banner.bannerBo.bannerLogo}">
                        <input type="hidden" name="resourceCode" id="resourcesCode">
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 ">跳转链接：</label>
                        <div class="col-sm-7 col-md-8">
                            <input class="form-control" type="text" id="url" name="url" value="${banner.bannerBo.url}"/>
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">广告描述：</label>
                    <div class="col-sm-9 pad_10">
                        <textarea id="myEditor" class="required"  name="bannerDesc" style="width:100%;" value="${banner.bannerBo.bannerDesc}" rows="18">${banner.bannerBo.bannerDesc}</textarea>
                    </div>
                </div>
            </div>
            <div class="formtable-cont text_c">
                <button id="save" type="submit" class="btn btn-primary">保存</button>
            </div>
        </form>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/banner/add.js"></script>
<%--百度编辑器开始--%>
<%--<link href="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/lang/zh-cn/zh-cn.js"></script>--%>
<%--百度编辑器结束--%>
<script type="application/javascript" >

</script>
</body>
</html>
