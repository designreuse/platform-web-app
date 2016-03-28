<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<%@include file="/WEB-INF/common/global/tableCommon.jsp"%>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>商品中心-商品留言管理</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        <a href="#">商品中心</a>
    </li>
    <li>
        <a href="${ctx}/sku/message">商品留言列表</a>
    </li>
</nav>
<div class="formtable">
    <div class="formtable-query mar_t20">
        <form class="form-inline">
            <div class="form-group">
                <label>商品名称：</label>
                <input id="productName" type="text"  style="width:125px;height:30px"  class="form-control">
            </div>
            <div class="form-group">
                <label>留言/回复内容：</label>
                <input type="text" id="consultReplyContent" style="width:125px;height:30px"  class="form-control">
            </div>
            <div class="form-group">
                <label>咨询类型：</label>
                <select id="consultType" style="width: 125px" class="form-control">
                    <option value="">全部</option>
                    <c:forEach var="consultType" items="${view.consultTypeList}">
                        <option value="${consultType.constValue}">${consultType.constName}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label>商铺名称：</label>
                <input type="text" id="shopsName" style="width:125px;height:30px"  class="form-control">
            </div>
            <div class="form-group">
                <label>买方个人：</label>
                <input type="text" id="consultUserName" style="width:125px;height:30px"  class="form-control">
            </div>
            <div class="form-group">
                <label style="width: 87px">留言日期：</label>
                <div class="input-group datepicker date wid-120">
                    <input id="startDate" type="text" class="form-control" readonly style="margin: 0px;">
                    <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                </div>
                <em class="pad_10">-</em>
                <div class="input-group datepicker date wid-120">
                    <input id="endDate" type="text" class="form-control" readonly style="margin: 0px;">
                    <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                </div>
            </div>


            <div class="form-group">
                <label style="width: 65px">状态：</label>
                <select id="consultStatus" style="width: 100px" class="form-control">
                    <option value="">全部</option>
                    <c:forEach var="status" items="${view.consultStatusList}">
                        <option value="${status.constValue}">${status.constName}</option>
                    </c:forEach>
                </select>
                </div>
            <div class="form-group">
                <a id="search" href="#" class="btn btn-primary btn-sm wid-60">搜索</a>
                <a id="againSet" href="#" class="btn btn-primary btn-sm wid-60">重置</a>
             </div>
        </form>
    </div>
</div>
<div class="modal fade" id="antworten">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">咨询回复</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <label class="col-xs-3 formtable-list-require text-right">咨询：</label>
                    <div class="col-xs-9" id="answerDiv">【商品咨询】请问苹果在箱子里是散落堆放的吗？</div>
                </div>
                <div class="row mar_t10">
                    <label class="col-xs-3 formtable-list-require text-right">回复身份：</label>
                    <div class="col-xs-9">
                        <label class="radio-inline">
                            <input type="radio" name="antIden" id="platForm" value="1" checked> 平台客服
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="antIden" id="business" value="2"> 商家
                        </label>
                    </div>
                </div>
                <div class="row mar_t10">
                    <label class="col-xs-3 formtable-list-require text-right">回复：</label>
                    <div class="col-xs-8">
                        <textarea id="answerArea" class="form-control" rows="7"></textarea>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button id="answerBtn" type="button" class="btn btn-primary">提交</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
            </div>
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
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/sku/message.js"></script>
</body>
</html>