<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <title>敏感词管理</title>
</head>
<body>
<%--nav_breadCrumb--%>
<ul class="breadcrumb">您当前位置：
    <li>
        <a href="#">内容中心</a>
    </li>
    <li>
        <a href="${ctx}/sensitive/list">敏感词管理</a>
    </li></ul>
<%--table_block--%>
<div id="queryBlock" class="pd-20 formtable" style="margin-left: auto;margin-right: auto">
    <%--table_tool--%>

    <div class="formtable">
            <div class="formtable-query mar_t20">
                <form class="form-inline">
                    <div class="form-group">
                        <label>关键词：</label>
                        <input type="text" id="name" class="form-control">
                    </div>
                    <div class="form-group">
                        <a href="#" class="btn btn-primary btn-sm wid-60" id="search">搜索</a>
                        <button type="reset" class="btn btn-primary btn-sm wid-60" id="reset">重置</button>
                        <a href="#" data-toggle="modal" data-target="#addsensitive" class="btn btn-primary btn-sm wid-60" id="add">新增</a>
                    </div>
                </form>
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


        <div class="modal fade" id="addsensitive" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">新增敏感词</h4>
                    </div>
                    <input type="hidden" Id="orderEditSkuId">
                    <form id="form1" class="cmxform" action="${ctx}/sensitive/save" method="post">
                    <div class="modal-body">
                        <div class="formtable">
                            <div class="formtable-cont" style="border-top: solid 1px #cdcdcd">
                                <div class="formtable-list">
                                    <label class="col-md-4 formtable-list-require">关键词：</label>
                                    <div class="col-xs-6 label-cont" >
                                        <input class="form-control" type="text" id="sensitiveName" name="name"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary"  id="save" >保存</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    </div>
                    </form>
                </div>
            </div>
        </div>
</div>

</body>
<script type="text/javascript" src="${ctx}/resources/js/sensitive/list.js"></script>
<script type="application/javascript" >


</script>
</html>
