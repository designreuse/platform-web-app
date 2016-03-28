<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <title>国内仓储价格管理</title>
</head>
<body>
<%--nav_breadCrumb--%>
<ul class="breadcrumb">您当前位置：
    <li>
        <a href="#">内容中心</a>
    </li>
    <li>
        <a href="${ctx}/logisticsAndStorage/storageCn/list">国内仓储价格管理</a>
    </li></ul>
<%--table_block--%>
<div id="queryBlock" class="pd-20 formtable" style="margin-left: auto;margin-right: auto">
<%--table_tool--%>

<div id="queryParam" class="formtable">
    <div class="formtable-query mar_t20">
        <form class="form-inline">
            <div class="form-group">
                <label>城市：</label>
                <input type="text" id="district" class="form-control">
            </div>
            <div class="form-group">
                <label>仓库名：</label>
                <input type="text" id="storageNameCn"   class="form-control">
            </div>
            <div class="form-group">
                <label>仓库类型：</label>
                <select class="form-control" id="storageType" name="storageType">
                    <option value="">全部</option>
                    <c:forEach var="storages" items="${storage.storages}">
                        <option value="${storages.constValue}">${storages.constName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>状态：</label>
                <select class="form-control" id="disabled" name="disabled">
                    <option value="">全部</option>
                    <c:forEach var="disabled" items="${storage.disableds}">
                        <option value="${disabled.constValue}">${disabled.constName}</option>
                    </c:forEach>
                </select>
            </div>
                      <span class="form-group">
                        <a href="#" class="btn btn-primary btn-sm wid-60" id="search">搜索</a>
                        <button type="reset" class="btn btn-primary btn-sm wid-60" id="reset">重置</button>
                        <a href="#" data-toggle="modal" data-target="#addStorage" class="btn btn-primary btn-sm wid-60" id="add">新增</a>
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
<div class="modal fade" id="addStorage" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">新增仓储价格</h4>
            </div>
            <form id="form1" class="cmxform" action="${ctx}/logisticsAndStorage/storageCnSave" method="post">
                <div class="modal-body">
                    <div class="formtable">
                        <div class="formtable-cont">
                            <div class="formtable-list">
                                <label class="col-xs-4 formtable-list-require">城市：</label>
                                <div class="col-xs-6" >
                                    <select class="form-control"   name="districtId">
                                        <option value="">全部</option>
                                        <c:forEach var="districtBo" items="${storage.districtBoList}">
                                            <option value="${districtBo.id}">${districtBo.districtNameCn}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div  class="formtable-list" >
                                <label class="col-xs-4 formtable-list-require">仓库名称：</label>
                                <div class="col-xs-6" >
                                    <input class="form-control" type="text" name="storageNameCn" value="" />
                                </div>
                            </div>
                            <div  class="formtable-list" >
                                <label class="col-xs-4 formtable-list-require">仓库名称(俄文)：</label>
                                <div class="col-xs-6" >
                                    <input class="form-control" type="text" name="storageName" value="" />
                                </div>
                            </div>
                            <div  class="formtable-list" >
                                <label class="col-xs-4 formtable-list-require">仓库地址：</label>
                                <div class="col-xs-6" >
                                    <input class="form-control" type="text" name="addressCn" value="" />
                                </div>
                            </div>
                            <div  class="formtable-list" >
                                <label class="col-xs-4 formtable-list-require">仓库地址(俄文)：</label>
                                <div class="col-xs-6" >
                                    <input class="form-control" type="text" name="address" value="" />
                                </div>
                            </div>
                            <div class="formtable-list">
                                <label class="col-xs-4 formtable-list-require">类型：</label>
                                <div class="col-xs-6" >
                                    <select class="form-control"   name="storageType">
                                        <option value="">全部</option>
                                        <c:forEach var="storages" items="${storage.storages}">
                                            <option value="${storages.constValue}">${storages.constName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div  class="formtable-list" >
                                <label class="col-xs-4 formtable-list-require">单价：</label>
                                <div class="col-xs-6" >
                                    <input class="form-control" type="text" name="fee" value="" />
                                </div>
                            </div>
                            <div class="formtable-list">
                                <label class="col-xs-4 formtable-list-require">单位：</label>
                                <div class="col-xs-6" >
                                    <select class="form-control"  name="unit">
                                        <option value="">全部</option>
                                        <c:forEach var="storageUnit" items="${storage.storageUnit}">
                                            <option value="${storageUnit.constValue}">${storageUnit.constName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary" id="saveStore" >保存</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </form>
        </div>
    </div>
</div>

<%--编辑--%>
<div class="modal fade" id="editStorage" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">编辑仓储价格</h4>
            </div>
            <form id="form2" class="cmxform" action="${ctx}/logisticsAndStorage/storageCnSave" method="post">
                <input type="hidden" id="id" name="id"/>
                <div class="modal-body">
                    <div class="formtable">
                        <div class="formtable-cont">
                            <div class="formtable-list">
                                <label class="col-xs-4 formtable-list-require">城市：</label>
                                <div class="col-xs-6" >
                                    <select class="form-control" id="districtId"  name="districtId">
                                        <option value="">全部</option>
                                        <c:forEach var="districtBo" items="${storage.districtBoList}">
                                            <option value="${districtBo.id}" >${districtBo.districtNameCn}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div  class="formtable-list" >
                                <label class="col-xs-4 formtable-list-require">仓库名称：</label>
                                <div class="col-xs-6" >
                                    <input class="form-control" type="text" id="storageCn" name="storageNameCn" value="" />
                                </div>
                            </div>
                            <div  class="formtable-list" >
                                <label class="col-xs-4 formtable-list-require">仓库名称(俄文)：</label>
                                <div class="col-xs-6" >
                                    <input class="form-control" type="text" id="storageRu" name="storageName" value="" />
                                </div>
                            </div>
                            <div  class="formtable-list" >
                                <label class="col-xs-4 formtable-list-require">仓库地址：</label>
                                <div class="col-xs-6" >
                                    <input class="form-control" type="text" id="addressCn" name="addressCn" value="" />
                                </div>
                            </div>
                            <div  class="formtable-list" >
                                <label class="col-xs-4 formtable-list-require">仓库地址(俄文)：</label>
                                <div class="col-xs-6" >
                                    <input class="form-control" type="text" id="address" name="address" value="" />
                                </div>
                            </div>
                            <div class="formtable-list">
                                <label class="col-xs-4 formtable-list-require">类型：</label>
                                <div class="col-xs-6" >
                                    <select class="form-control" id="type"   name="storageType">
                                        <option value="">全部</option>
                                        <c:forEach var="storages" items="${storage.storages}">
                                            <option value="${storages.constValue}">${storages.constName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div id="logisticsLengthDiv" class="formtable-list" >
                                <label class="col-xs-4 formtable-list-require">单价：</label>
                                <div class="col-xs-6" >
                                    <input class="form-control" type="text" id="fee" name="fee" value="" />
                                </div>
                            </div>
                            <div class="formtable-list">
                                <label class="col-xs-4 formtable-list-require">单位：</label>
                                <div class="col-xs-6" >
                                    <select class="form-control" id="unit"  name="unit">
                                        <option value="">全部</option>
                                        <c:forEach var="storageUnit" items="${storage.storageUnit}">
                                            <option value="${storageUnit.constValue}">${storageUnit.constName}</option>
                                        </c:forEach>
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
<script type="text/javascript" src="${ctx}/resources/js/store/storageCnList.js"></script>
<script type="application/javascript" >


    <%@include file="/WEB-INF/common/global/footer.jsp"%>
</script>
</html>
