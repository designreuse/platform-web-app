<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <title>国内运价列表</title>
</head>
<body>
<%--nav_breadCrumb--%>
<ul class="breadcrumb">您当前位置：
    <li>
        <a href="#">内容中心</a>
    </li>
    <li>
        <a href="${ctx}/logisticsAndStorage/ratesCn/list">国内运价列表</a>
    </li></ul>
<%--table_block--%>
<div id="queryBlock" class="pd-20 formtable" style="margin-left: auto;margin-right: auto">
    <%--table_tool--%>

    <div id="queryParam" class="formtable">
        <div class="formtable-query mar_t20">
            <form class="form-inline">
                <div class="form-group">
                    <label>发货地：</label>
                    <input type="text" id="startAddr" class="form-control">
                </div>
                <div class="form-group">
                    <label>目的地：</label>
                    <input type="text" id="endAddr" value="满洲里"  class="form-control">
                </div>
                <div class="form-group">
                    <label>车型：</label>
                    <select class="form-control" id="carType" name="carType">
                        <option value="">全部</option>
                        <c:forEach var="carTypes" items="${transport.carTypes}">
                            <option value="${carTypes.constValue}">${carTypes.constName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>状态：</label>
                    <select class="form-control" id="disabled" name="disabled">
                        <option value="">全部</option>
                        <c:forEach var="disabled" items="${transport.disableds}">
                            <option value="${disabled.constValue}">${disabled.constName}</option>
                        </c:forEach>
                    </select>
                </div>
                      <span class="form-group">
                        <a href="#" class="btn btn-primary btn-sm wid-60" id="search">搜索</a>
                        <button type="reset" class="btn btn-primary btn-sm wid-60" id="reset">重置</button>
                        <a href="#" data-toggle="modal" data-target="#addRates" class="btn btn-primary btn-sm wid-60" id="add">新增</a>
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
    <div class="modal fade" id="addRates" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">新增运价</h4>
                </div>
                <form id="form1" class="cmxform" action="${ctx}/logisticsAndStorage/ratesCnSave" method="post">
                    <input class="form-control" type="hidden" name="startAddrRu" value="" id="startAddrRu"/>
                    <input class="form-control" type="hidden" name="startAddrCn" value="" id="startAddrCn"/>
                    <input class="form-control" type="hidden" name="startCountry" value="" id="startCountry" />
                    <input class="form-control" type="hidden" name="endAddrRu" value="" id="endAddrRu"/>
                    <input class="form-control" type="hidden" name="endAddrCn" value="" id="endAddrCn"/>
                    <input class="form-control" type="hidden" name="endCountry" value="" id="endCountry" />
                    <input class="form-control" type="hidden" name="logisticsId" value="" id="logisticsId" />
                    <div class="modal-body">
                        <div class="formtable">
                            <div class="formtable-cont">
                                <div class="formtable-list">
                                    <label class="col-xs-4 formtable-list-require">起始地：</label>
                                    <div class="col-xs-6" >
                                        <select class="form-control" id="startAddrCode"  name="startAddr">
                                            <option value="">全部</option>
                                            <c:forEach var="districtBo" items="${transport.districtBoList}">
                                                <option value="${districtBo.id}">${districtBo.districtNameCn}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="formtable-list">
                                    <label class="col-xs-4 formtable-list-require">目的地：</label>
                                    <div class="col-xs-6" >
                                        <select class="form-control" id="endAddrCode"  name="endAddr">
                                            <option value="">全部</option>
                                            <c:forEach var="districtBo" items="${transport.districtBoList}">
                                                <option value="${districtBo.id}">${districtBo.districtNameCn}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div id="logisticsLengthDiv" class="formtable-list" style="display: none;">
                                    <label class="col-xs-4 formtable-list-require">车程：</label>
                                    <div class="col-xs-6" >
                                        <input class="form-control" type="text" name="logisticsLength" value="" id="logisticsLength"/>
                                    </div>
                                </div>
                                <div class="formtable-list">
                                    <label class="col-xs-4 formtable-list-require">车型：</label>
                                    <div class="col-xs-6" >
                                        <select class="form-control"  name="carType">
                                            <option value="">全部</option>
                                            <c:forEach var="carTypes" items="${transport.carTypes}">
                                                <option value="${carTypes.constValue}">${carTypes.constName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="formtable-list">
                                    <label class="col-xs-4 formtable-list-require">运价：</label>
                                    <div class="col-xs-6" >
                                        <input class="form-control" type="text"  name="fee"/>
                                    </div>
                                </div>
                                <div class="formtable-list">
                                    <label class="col-xs-4 formtable-list-require">载重量：</label>
                                    <div class="col-xs-6" >
                                        <input class="form-control" type="text"  name="carCapacity"/>
                                    </div>
                                </div>
                                <div class="formtable-list">
                                    <label class="col-xs-4 formtable-list-require">规格：</label>
                                    <div class="col-xs-6" >
                                        <input class="form-control" type="text"  name="carSpec"/>
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

    <%--编辑--%>
    <div class="modal fade" id="editRates" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">编辑运价</h4>
                </div>
                <form id="form2" class="cmxform" action="${ctx}/logisticsAndStorage/ratesCnEdit" method="post">
                    <input type="hidden" name="id" id="id"/>
                    <div class="modal-body">
                        <div class="formtable">
                            <div class="formtable-cont">
                                <div id="" class="formtable-list" >
                                    <label class="col-xs-4 formtable-list-require">路线：</label>
                                    <div class="col-xs-6" >
                                        <input class="form-control" type="text" name="logisticsNameCn" id="logisticsNameCn" value="" readonly="readonly"/>
                                    </div>
                                </div>
                                <div class="formtable-list">
                                    <label class="col-xs-4 formtable-list-require">车型：</label>
                                    <div class="col-xs-6" >
                                        <select class="form-control"  name="carType" id="editCarType">
                                            <option value="">全部</option>
                                            <c:forEach var="carTypes" items="${transport.carTypes}">
                                                <option value="${carTypes.constValue}"  >${carTypes.constName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="formtable-list">
                                    <label class="col-xs-4 formtable-list-require">运价：</label>
                                    <div class="col-xs-6" >
                                        <input class="form-control" type="text" id="fee"  name="fee"/>
                                    </div>
                                </div>
                                <div class="formtable-list">
                                    <label class="col-xs-4 formtable-list-require">载重量：</label>
                                    <div class="col-xs-6" >
                                        <input class="form-control" type="text" id="carCapacity" name="carCapacity"/>
                                    </div>
                                </div>
                                <div class="formtable-list">
                                    <label class="col-xs-4 formtable-list-require">规格：</label>
                                    <div class="col-xs-6" >
                                        <input class="form-control" type="text" id="carSpec"  name="carSpec"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary"  id=edit >保存</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-danger"  data-dismiss="modal"  id="changeDisabled">停用</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
<script type="text/javascript" src="${ctx}/resources/js/transport/ratesList.js"></script>
<script type="application/javascript" >



    <%@include file="/WEB-INF/common/global/footer.jsp"%>
</script>
</html>
