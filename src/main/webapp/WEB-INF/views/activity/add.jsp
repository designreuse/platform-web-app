<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/common/global/common.jsp"%>
<html>
<head>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
    <title>编辑活动</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span>内容中心 <span class="c-gray en">&gt;</span> 活动管理 <span class="c-gray en">&gt;</span> <c:if test="${empty entity}">新增活动</c:if> <c:if test="${not empty entity}">编辑活动</c:if><a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a></nav>


<div class="pd-20">
    <form id="activityForm" class="Huiform" action="${ctx}/activity/edit" method="post" >
        <input type="hidden" id="activityNo" name="activityNo" value="${entity.id}"/>
        <input type="hidden" id="disabled" name="disabled" value=""/>
        <table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top">
            <thead>
            <tr class="text-l">
                <th width="106"><span class="l f-16">基本信息</span>
                       <span class="r">
                        <p class="field switch" id=""switch>
                            <c:if test="${entity.id != null}">
                            <span class="r">
                                   <a id="start" href="javascript:void(0)" target="_self" class="btn btn-primary radius" <c:if test="${entity.disabled ==0 }">style="display:none"</c:if> > 启用</a>
                                   <a href="#"  id="forbidden" name="_self" class="btn btn-primary radius"<c:if test="${entity.disabled ==1}">style="display:none"</c:if>> 停用</a> </c:if>
                            </span>
                        </p>
                        </span>
                </th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <table class="table table-border table-bordered table-hover table-bg">
            <tbody>
            <tr>
                <th class="text-r" width="103"><span class="c-red">*</span>标题：</th>
                <td width="317"><input type="text" id="activityName" placeholder="控制在25个字以内"
                                       name="activityName"  value="${fn:escapeXml(entity.activityName)}" style="width:250px" class="input-text"></td>
            </tr>
            <tr>
                <th class="text-r"><span class="c-red">*</span>平台：</th>
                <td><select class="" id="appId" name="appId" size="1" style="width:260px" >
                    <option value="2" <c:if test="${entity.appId == 2}">selected</c:if>>神灯速贸运营平台</option>
                    <option value="3" <c:if test="${entity.appId == 3}">selected</c:if>>神灯速贸中文平台</option>
                    <option value="5" <c:if test="${entity.appId == 5}">selected</c:if>>神灯速贸俄文平台</option>

                </select></td>
            </tr>
            <tr>
                <th class="text-r" width="103"><span class="c-red">*</span>主办方：</th>
                <td width="317"><input type="text" id="masterName" placeholder="主办方"
                                       name="masterName"  value="${fn:escapeXml(entity.masterName)}" style="width:250px" class="input-text"></td>
            </tr>
            <tr>
                <th class="text-r" width="103"><span class="c-red">*</span>地点：</th>
                <td width="317"><input type="text" id="activityAddress" placeholder="地点"
                                       name="activityAddress"  value="${fn:escapeXml(entity.activityAddress)}" style="width:250px" class="input-text"></td>
            </tr>

            <tr>
                <th class="text-r"><span class="c-red">*</span>时间: </th>
                <td>
                    <input  class="easyui-datebox" id="startDate" name="startDate" style="width:150px;" value="<odpf:formatDate style="DATE" date="${entity.startDate}"/>">
                    -
                    <input  class="easyui-datebox" id="endDate" name="endDate"  style="width:150px;" value="<odpf:formatDate style="DATE" date="${entity.endDate}"/>" >
                </td>
            </tr>
            <tr>
                <th width="190" class="text-r"><span class="c-red">*</span> 活动LOGO：</th>
                <td><img src="${ctx}/resources/images/bn.jpg" width="300" height="100" id="activitySrc" onclick="reOLUploadFro();">
                    <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0" class="btn-uploadpic" name="file" multiple="" id="activityLogoUrl">
                    <input type="hidden" name="activityLogo">
                    <input type="hidden" name="resourceCode" id="resourcesCode">
                </td>
            </tr>
            <tr>
                <th valign="top" class="text-r"><span class="c-red">*</span>正文内容：</th>
                <td>
                    <textarea id="myEditor"  name="activityDesc" style="width:100%;height:400px;">${entity.activityDesc}</textarea>
                </td>
            </tr>
            <tr>
                <th class="text-r">&nbsp;</th>
                <td><button id="submitForm" class="btn btn-success radius" type="button"><i class="icon-ok"></i>保存</button></td>
            </tbody>
        </table><br>
    </form>

</div>
</body>
<%--百度编辑器开始--%>
<link href="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/lang/zh-cn/zh-cn.js"></script>
<%--百度编辑器结束--%>
<script type="text/javascript" src="${ctx}/resources/js/activity/add.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script>
    UM.getEditor('myEditor');
    var appSelectNode = $(".appSelectClass")
    $(".appSelectClass").remove();
</script>
</html>