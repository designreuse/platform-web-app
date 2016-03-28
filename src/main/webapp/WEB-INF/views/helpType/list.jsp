<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <title>问题类型列表</title>
</head>
<body>
<%--nav_breadCrumb--%>
<ul class="breadcrumb">您当前位置：
    <li>
        <a href="#">内容中心</a>
    </li>
    <li>
        <a href="${ctx}/help/helpTypeList">问题类型列表</a>
    </li></ul>
<%--table_block--%>
<div id="queryBlock" class="pd-20 formtable" style="margin-left: auto;margin-right: auto">
    <%--table_tool--%>

    <div id="queryParam" class="formtable">
        <div class="formtable-query mar_t20">
            <form class="form-inline">
                <div class="form-group">
                    <label>类型名称：</label>
                    <input type="text" id="selectName" class="form-control">
                </div>
                <div class="form-group">
                    <label>平台：</label>
                    <select class="form-control" id="selectAppId">
                        <option value="">请选择</option>
                        <option value="3">供应商</option>
                        <option value="5">采购商</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>状态：</label>
                    <select class="form-control" id="disabled" name="disabled">
                        <option value="">全部</option>
                        <option value="0">启用</option>
                        <option value="1">禁用</option>
                    </select>
                </div>
                      <span class="form-group">
                        <a href="#" class="btn btn-primary btn-sm wid-60" id="search">搜索</a>
                        <button type="reset" class="btn btn-primary btn-sm wid-60" id="reset">重置</button>
                        <a href="#" data-toggle="modal" data-target="#addHelpType" class="btn btn-primary btn-sm wid-60" id="add">新增</a>
                      </span>
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

    <%--新增--%>
    <div class="modal fade" id="addHelpType" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">新增类型</h4>
                    </div>
                    <form id="form1" class="cmxform" action="${ctx}/helpType/save" method="post">
                        <input class="form-control" type="hidden" name="id" value="" />
                        <div class="modal-body">
                            <div class="formtable">
                                <div class="formtable-cont">
                                    <div class="formtable-list">
                                        <label class="col-xs-4 formtable-list-require">类型名称：</label>
                                        <div class="col-xs-6" >
                                            <input class="form-control" type="text" name="name" value="" />
                                        </div>
                                    </div>
                                    <div class="formtable-list" id="divAddNameRu" style="display: none">
                                        <label class="col-xs-4 formtable-list-require">类型名称（俄文）：</label>
                                        <div class="col-xs-6" >
                                            <input class="form-control" type="text" name="nameTranslation" value=""/>
                                        </div>
                                    </div>
                                    <div class="formtable-list">
                                        <label class="col-xs-4 formtable-list-require">平台：</label>
                                        <div class="col-xs-6" >
                                            <select class="form-control"  name="appId" id="appAddId">
                                                <option value="3">供应商</option>
                                                <option value="5">采购商</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary"  id="edit" >保存</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    <%--编辑--%>
    <div class="modal fade" id="editHelpType" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">编辑类型</h4>
                </div>
                <form id="form2" class="cmxform" action="${ctx}/helpType/save" method="post">
                    <input class="form-control" type="hidden" name="id" value="" id="id" />
                    <div class="modal-body">
                        <div class="formtable">
                            <div class="formtable-cont">
                                <div class="formtable-list">
                                    <label class="col-xs-4 formtable-list-require">类型名称：</label>
                                    <div class="col-xs-6" >
                                        <input class="form-control" type="text" name="name" value="" id="name"/>
                                    </div>
                                </div>
                                <div class="formtable-list" id="divEditNameRu" style="display: none">
                                    <label class="col-xs-4 formtable-list-require">类型名称（俄文）：</label>
                                    <div class="col-xs-6" >
                                        <input class="form-control" type="text" name="nameTranslation" value="" id="nameTranslation"/>
                                    </div>
                                </div>
                                <div class="formtable-list">
                                    <label class="col-xs-4 formtable-list-require">平台：</label>
                                    <div class="col-xs-6" >
                                        <select class="form-control" id="appId"  name="appId">
                                            <option value="3">供应商</option>
                                            <option value="5">采购商</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary"  id="save" >保存</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-danger"  data-dismiss="modal"  id="changeDisabled">停用</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


</div>

</body>
<script type="text/javascript" src="${ctx}/resources/js/helpType/list.js"></script>

<%@include file="/WEB-INF/common/global/footer.jsp"%>



</html>
