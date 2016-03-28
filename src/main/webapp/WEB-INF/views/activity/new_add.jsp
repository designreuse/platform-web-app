<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>内容中心-新增活动</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">内容中心</a>
    </li>
    <li>
        <a href="${ctx}/activity/list">活动管理</a>
    </li>
    <li>
        <a href="#">活动编辑</a>
    </li>

</nav>
<div class="container-fluid">
    <div class="formtable">
        <input type="hidden" id="disabled"  value="${activity.activityBo.disabled}"/>
        <form class="cmxform" id="form1" action="${ctx}/activity/save" method="post">
            <input type="hidden" id="id" name="id" value="${activity.activityBo.id}"/>
            <c:if test="${activity.activityBo != null}">
                <div class="formtable-nav">
                    <ul class="list-inline">
                        <li><a href="#baseInfo" class="btn btn-primary">基本信息</a></li>
                        <li><a href="#queryContent" class="btn btn-primary">活动报名</a></li>
                        <c:if test="${!activity.activityBo.disabled}">
                            <button type="button" class="btn btn-danger header-button status">停用</button>
                        </c:if>
                        <c:if test="${activity.activityBo.disabled}">
                            <button type="button" class="btn btn-success header-button status">启用</button>
                        </c:if>
                        <button type="button" class="btn btn-danger header-button " id="deleteNews">删除</button>
                    </ul>
                </div>
            </c:if>

            <div id="baseInfo" class="formtable-cont">
                <h4 class="header " id="base">基本信息</h4>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">标题：</label>
                        <div class="col-sm-7 col-md-8">
                            <input class="form-control" id="activityName" name="activityName" value="${activity.activityBo.activityName}">
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">平台：</label>
                        <div class="col-sm-7 col-md-8">
                            <select class="form-control" id="appId" name="appId">
                                <option value="">请选择</option>
                                <c:forEach items="${activity.platTypes}" var="type">
                                    <option value="${type.constValue}" <c:if test="${type.constValue == activity.activityBo.appId}">selected ="selected"</c:if> >${type.constName}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">主办方：</label>
                        <div class="col-sm-7 col-md-8">
                            <input class="form-control" id="masterName" name="masterName" value="${activity.activityBo.masterName}">
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">地点：</label>
                        <div class="col-sm-7 col-md-8">
                            <input class="form-control" id="activityAddress" name="activityAddress" value="${activity.activityBo.activityAddress}">
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">时间：</label>
                    <div class="col-sm-10 pad_l20">
                        <div class="col-xs-4 col-sm-3 input-group datepicker date">
                            <input type="text" id="startDate" name="startDate" value="<odpf:formatDate style='DATE' date='${activity.activityBo.startDate}'/>"  class=" form-control no_mar">
                            <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                        </div>
                        <span class="pad_10 fl_l">-</span>
                        <div class="col-xs-4 col-sm-3 input-group datepicker date">
                            <input type="text" id="endDate" name="endDate" value="<odpf:formatDate style='DATE' date='${activity.activityBo.endDate}'/>"  class=" form-control no_mar">
                            <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                        </div>
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">活动图片：</label>
                    <input type="hidden" id="activityLogo" value="${activity.activityBo.activityLogo}"/>
                    <div class="col-sm-10 label-cont pad_l20 hide-input">
                        <img src="${ctx}/resources/images/bn.jpg" width="300" height="100" id="activitySrc" onclick="reOLUploadFro();">
                        <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0" class="btn-uploadpic" name="file" multiple="" id="activityLogoUrl">
                        <input class="hide" name="activityLogo" value="${activity.activityBo.activityLogo}">
                        <input type="hidden" name="resourceCode" id="resourcesCode">
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">内容：</label>
                    <div class="col-sm-9 pad_10">
                        <textarea id="myEditor" name="activityDesc" class="required"  style="width:100%;">${activity.activityBo.activityDesc}</textarea>
                    </div>
                </div>
            </div>
            <div class="formtable-cont text_c">
                <button id="save" type="submit" class="btn btn-primary">保存</button>
            </div>
        </form>
    </div>
    <c:if test="${not empty activity.activityBo.id}">
        <div class="formtable">
            <div class="formtable-cont">
                <h4 class="header " >活动报名</h4>
            </div>
        </div>
        <%--table_content--%>
        <div id="queryContent">
            <table id="easyUi_table" class="table table-bordered table-hover">

            </table>
        </div>
        <%--table_footer--%>
        <div id="queryPage" class="easyui-panel">
            <div id="page"></div>
        </div>
    </c:if>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/activity/add.js"></script>


<%--百度编辑器开始--%>
<link href="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/lang/zh-cn/zh-cn.js"></script>
<%--百度编辑器结束--%>
<script type="application/javascript" >
    $(function(){
        /*定义easyUITable的相关参数*/
        var easyUiTableParam = {
            url: window.ctx+'/activity/activityMemberList',
            onSelectPage:function(pageNumber,pageSize){
                $('#easyUi_table').datagrid("reload",
                        {
                            pageNumber:pageNumber,
                            pageSize:pageSize
                        })
            },
            columns:[
                {field:'userName',title:'姓名',align:'center',width:80},
                {field:'orgName',title:'企业',align:'center',width:120},
                {field:'mobile',title:'手机',align:'center',width:120},
                {field:'joinNumber',title:'参加人数',width:80,align:'center'},
                {field:'appName',title:'报名来源',width:80,align:'center'},
                {field:'createTime',title:'报名时间',width:120,align:'center',
                    formatter:function(value,row,index){
                        return new Date(row.createTime).Format("yyyy-MM-dd");
                    }
                }
            ]
        }
        /*easyUI初始化表*/
        easyUiTable.initTable(easyUiTableParam);
        $(window).resize(function(){
            easyUiTable.initTable(easyUiTableParam);
        });
    })
</script>
</body>
</html>
