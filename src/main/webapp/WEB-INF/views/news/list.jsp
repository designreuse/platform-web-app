<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script type="text/javascript">
    window.ctx="${ctx}"
</script>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>内容中心-资讯管理</title>
    <link rel="stylesheet" href="${ctx}/resources/css/cssreset-min.css">
    <link rel="stylesheet" href="${ctx}/resources/library/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctx}/resources/plugin/datetimepicker/css/bootstrap-datetimepicker.min.css">
    <link href="${ctx}/resources/css/labelauty.css" rel="stylesheet" />
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/easyui.css"/>
    <link type="text/css" href="${ctx}/resources/css/easyui-table.css" rel="stylesheet" />
</head>
<body>
<div class="container formtable">

        <div id="queryParam" class="formtable-query" >
            <div class="col-md-12 no_pad mar_t20">
                <div class="col-md-4">
                    <label class="fl_l line_h34">标题：</label>
                    <div class="auto_width-r no_pad">
                        <input class="form-control" type="text" id="title">
                    </div>
                </div>
                <label class=" fl_l line_h34 text_r">平台：</label>
                <div class="col-md-2 auto_width-r">
                    <select class="form-control" id="appId">
                        <option value="">请选择</option>
                        <c:forEach items="${newsBo.platTypes}" var="type">
                            <option value="${type.constValue}">${type.constName}</option>
                        </c:forEach>
                    </select>
                </div>
                <label class=" fl_l line_h34 text_r">栏目：</label>
                <div class="col-md-2 auto_width-r">
                    <select class="form-control" id="channel">
                        <option value="">请选择</option>
                        <c:forEach items="${newsBo.newsTypes}" var="type">
                            <option value="${type.constValue}">${type.constName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="col-md-12 mar_t20">
                <label class="fl_l line_h34 ">发布日期：</label>
                <div class="col-md-2 input-group datepicker date auto_width-r">
                    <input type="text" id="releaseStartDate"  class=" form-control" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
                <span class="pad_10 fl_l">-</span>
                <div class="col-md-2 input-group datepicker date ">
                    <input type="text" id="releaseEndDate"  class=" form-control" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
                <label class=" fl_l line_h34 text_r">状态：</label>
                <div class="col-md-2 auto_width-r">
                    <select class="form-control" id="disabled">
                        <option value="">全部</option>
                        <c:forEach items="${newsBo.disableds}" var="type">
                            <option value="${type.constValue}">${type.constName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="fl_r">
                    <button class="btn btn-primary" id="search">搜索</button>
                    <button class="btn btn-primary" id="add">新增</button>
                </div>
            </div>
        </div>
        <div id="queryContent">
            <table id="easyUi_table">

            </table>
        </div>
        <div id="queryPage" class="easyui-panel">
            <div id="page"></div>
        </div>


</div>
<script src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery.easyui.min.js"></script>
<script src="${ctx}/resources/library/bootstrap/js/bootstrap.min.js"></script>
<script src="${ctx}/resources/plugin/datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
<script src="${ctx}/resources/plugin/datetimepicker/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/easyui-table.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/news/list.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common/dateformat.js"></script>
<script>
    $('.datepicker').datetimepicker({
        language: 'zh-CN',
        format: 'yyyy-mm-dd',
        minView: "month",
        autoclose: 1,
        todayHighlight: 1
    });

    //当平台改变时触发修改栏目
    $("#appId").change(function(){
        //alert(1);
        var appId=$("#appId").val();
        //清除之前的option
        $("#channel option").remove();
        $.ajax({
            type:"POST",
            contentType :"text/html;charset:utf-8",
            url:window.ctx+"/news/ajaxGetChannel",
            data:appId,
            success:function(data){
                $("#channel").append("<option value=''>请选择</option>");
                //alert(data[i].constName)
                for ( var i =0 ;i <data.length;i++){
                    $("#channel").append("<option value="+data[i].constValue+">"+data[i].constName+"</option>");
                }
            },
            dataType:"JSON"
        })
    });
</script>
</body>
</html>