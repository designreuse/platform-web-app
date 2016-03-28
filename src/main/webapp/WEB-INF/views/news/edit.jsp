<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<jsp:useBean id="now" class="java.util.Date" />
<html>
<head>
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/plugin/My97DatePicker/skin/WdatePicker.css"/>
    <script type="text/javascript" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/third-party/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
    <link href="${ctx}/resources/font/font-awesome-ie7.min.css" rel="stylesheet" type="text/css" />
    <title>编辑资讯</title>
    <%--百度编辑器开始--%>
    <script>
        window.ctx = '${ctx}';
    </script>
    <link href="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
    <script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/lang/zh-cn/zh-cn.js"></script>
    <%--百度编辑器结束--%>
    <script type="text/javascript">
        $(function(){
            if('${msg}' != ''){
                alert('${msg}');
            }
            $(".cb-enable").click(function(){
                var parent = $(this).parents('.switch');
                $('.cb-disable',parent).removeClass('selected');
                $(this).addClass('selected');
            });
            $(".cb-disable").click(function(){
                var parent = $(this).parents('.switch');
                $('.cb-enable',parent).removeClass('selected');
                $(this).addClass('selected');
            });
        });
    </script>
    <style type="text/css">
        /* Used for the Switch effect:*/
        .cb-enable, .cb-disable, .cb-enable span, .cb-disable span {
            background: url(${ctx}/resources/images/switch.gif) repeat-x;
            display: block;
            float: left;
        }
        .cb-enable span, .cb-disable span {
            line-height: 30px;
            display: block;
            background-repeat: no-repeat;
            font-weight: bold;
        }
        .cb-enable span {
            background-position: left -90px;
            padding: 0 10px;
        }
        .cb-disable span {
            background-position: right -180px;
            padding: 0 10px;
        }
        .cb-disable.selected {
            background-position: 0 -30px;
        }
        .cb-disable.selected span {
            background-position: right -210px;
            color: #fff;
        }
        .cb-enable.selected {
            background-position: 0 -60px;
        }
        .cb-enable.selected span {
            background-position: left -150px;
            color: #fff;
        }
        .switch label {
            cursor: pointer;
        }
    </style>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span>内容中心 <span class="c-gray en">&gt;</span> 资讯管理 <span class="c-gray en">&gt;</span> <c:if test="${empty entity}">新增资讯</c:if> <c:if test="${not empty entity}">编辑资讯</c:if></nav>
<div class="pd-20">
    <form class="Huiform" action="${ctx}/news/edit" method="post" onsubmit="return checkForm()">
        <input type="hidden" id="newsId" name="id" value="${entity.id}"/>
        <table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top">
            <thead>
                <tr class="text-l">
                    <th width="106"><span class="l f-16">基本信息</span> <span class="r">
                <p class="field switch" id=""switch>
                    <c:if test="${entity.id != null}">
                    <span class="r"> <a id="start" href="javascript:void(0)" target="_self" class="btn btn-primary radius" <c:if test="${entity.disabled ==0 }">style="display:none"</c:if> > 启用</a> <a href="#"  id="forbidden" name="_self" class="btn btn-primary radius"<c:if test="${entity.disabled ==1}">style="display:none"</c:if>> 停用</a> </c:if></span>
                </p>
                </span> </th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <table class="table table-border table-bordered table-hover table-bg">
            <tbody>
            <tr>
                <th class="text-r" width="103">标题：</th>
                <td width="317"><input type="text" id="newsName" placeholder="控制在25个字以内"
                                     name="title"  value="${fn:escapeXml(entity.title)}" style="width:250px" class="input-text"></td>
            </tr>
            <tr>
                <th class="text-r">平台：</th>
                <td><select class="select" id="appId" name="appId" size="1" style="width:260px" onchange="selectApp()">
                    <%--<c:forEach items="${appList}" var="app">--%>
                        <%--<option value="${app.id}" <c:if test="${entity.appId == app.id}">selected</c:if>>${app.appName}</option>--%>
                    <%--</c:forEach>--%>
                        <option value="2" <c:if test="${entity.appId == 2}">selected</c:if>>神灯速贸运营平台</option>
                        <option value="3" <c:if test="${entity.appId == 3}">selected</c:if>>神灯速贸中文平台</option>
                        <option value="5" <c:if test="${entity.appId == 5}">selected</c:if>>神灯速贸俄文平台</option>

                </select></td>
            </tr>
            <tr>
                <th class="text-r">栏目：</th>
                <td><select class="select" id="channel" name="channel" size="1" style="width:260px">
                    <option value="1" <c:if test="${entity.channel == 1}">selected</c:if>>平台公告</option>
                    <option class="appSelectClass" value="2" <c:if test="${entity.channel == 2}">selected</c:if>>行业资讯</option>
                    <option class="appSelectClass" value="3" <c:if test="${entity.channel == 3}">selected</c:if>>政策法规</option>
                    <option class="appSelectClass" value="4" <c:if test="${entity.channel == 4}">selected</c:if>>热门活动</option>
                </select></td>
            </tr>
            <tr>
                <th class="text-r">发布日期</th>
                <td>
                   <input type="text"
                    value="<odpf:formatDate style='DATE' date='${entity.createTime}'/><c:if test="${empty entity.createTime}"><fmt:formatDate value="${now}" type="both" dateStyle="long" pattern="yyyy-MM-dd" /></c:if>"
                    onFocus="WdatePicker({isShowClear:true,readOnly:true})"
                    id="createTime" name="createTime" class="input-text Wdate" style="width:260px;">
                </td>
            </tr>
            <tr>
                <th valign="top" class="text-r">正文内容：</th>
                <td>
                    <textarea id="myEditor" name="content" style="width:100%;height:400px;">${entity.content}</textarea>
                </td>
            </tr>
            <tr>
            <th class="text-r">&nbsp;</th>
            <td><button class="btn btn-success radius" type="submit"><i class="icon-ok"></i>保存</button></td>
            </tbody>
        </table><br>
    </form>
</div>
<script>
    UM.getEditor('myEditor');
    var appSelectNode = $(".appSelectClass")
    $(".appSelectClass").remove();
    function checkForm(){
        if(!$("#newsName").val()){
            alert("新闻标题不能为空！");
            return false;
        }
        if($("#newsName").val().length >50){
            alert("标题长度不能大于25个字")
            return false;
        }
        if(!$("#myEditor").val()){
            alert("正文内容必须填写！");
            return false;
        }
    }
    $("#start").click(function(){
        updateDisabled($("#newsId").val(),false);
    })
    $("#forbidden").click(function(){
        updateDisabled($("#newsId").val(),true);
    })
    function updateDisabled(id,status){
        $.ajax({
            url:"${ctx}/news/updateStatus",
            data:{
                id:id,
                disabled:status
            },
            type:"post",
            dataType:"json",
            success:function(data){
                console.log(data)
                alert(data.msg)
                location.reload()
            }
        })
    }

    function selectApp(){
        var node = $("#appId").val();
        if(2==node){
            $(".appSelectClass").remove();
        }else{
//            $(".appSelectClass").parent().removeClass(".appSelectClass");
            $("#channel").append(appSelectNode);
        }

    }
</script>
</body>
</html>