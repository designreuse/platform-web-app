<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/global/common.jsp" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>新增服务订单</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">交易中心</a>
    </li>
    <li>
        <a href="${ctx}/serviceOrder/list">服务订单管理</a>
    </li>
    <li>
        <a href="${ctx}/serviceOrder/add">服务订单新增</a>
    </li>
</nav>
<div class="container-fluid">
    <div class="formtable">
        <form class="cmxform" id="srvOrderForm">
            <div class="formtable-cont">
                <h4 class="header">基本信息</h4>
                <c:if test="${empty srvOrderView.orderId}">
                    <div class="formtable-list">
                        <label class="col-sm-2 formtable-list-require">服务委托方：</label>

                        <div class="col-sm-6">
                            <input class="form-control" id="userName" name="userName" placeholder="请输入个人名称" value class="input-text">
                            <span id="orgName"></span>
                            <input type="hidden" name="orgId" value id="orgId">
                            <input class="hide" name="contacts" value id="contacts">
                        </div>
                    </div>
                    <div class="formtable-list">
                        <label class="col-sm-2 formtable-list-require">代理企业：</label>
                        <input type="hidden" name="auditStatus" value="1">
                        <div class="col-sm-4">
                            <select class="form-control" id="actingOrgId" name="actingOrgId">
                                <option value="">请选择</option>
                            </select>
                        </div>
                    </div>
                </c:if>
                <c:if test="${not empty srvOrderView.orderId}">
                    <div class="formtable-list">
                        <label class="col-sm-2 formtable-list-require">服务委托方：</label>
                        <input type="hidden" name="auditStatus" value="2">
                        <div class="col-sm-6">
                            <select class="form-control" name="orgId" id="buyOrgId">
                                <option value="${srvOrderView.orderBo.buyOrgId}"
                                        data-contacts="${srvOrderView.orderBo.buyUserId}"
                                        data-actingName="${srvOrderView.orderBo.buyActingOrgNameRu}"
                                        data-acting="${srvOrderView.orderBo.buyActingOrgId}">买方：${srvOrderView.orderBo.buyOrgNameRu}-${srvOrderView.orderBo.buyUserNameRu}</option>
                                <option value="${srvOrderView.orderBo.saleOrgId}"
                                        data-contacts="${srvOrderView.orderBo.saleUserId}"
                                        data-actingName="${srvOrderView.orderBo.saleActingOrgNameCn}"
                                        data-acting="${srvOrderView.orderBo.saleActingOrgId}">卖方：${srvOrderView.orderBo.saleOrgNameCn}-${srvOrderView.orderBo.saleUserNameCn}</option>
                            </select>
                            <input class="hide" name="contacts" value id="buyContacts">
                        </div>
                    </div>
                    <div class="formtable-list">
                        <label class="col-sm-2 formtable-list-require">代理企业：</label>
                        <div class="col-sm-4">
                            <select class="form-control"  id="buyActionOrgId" disabled>
                                <option value="${srvOrderView.orderBo.buyActingOrgId}">${srvOrderView.orderBo.buyActingOrgNameRu}</option>
                            </select>
                            <input type="hidden" name="actingOrgId">
                        </div>
                    </div>
                </c:if>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">客服：</label>

                    <div class="col-sm-4">
                        <select class="form-control" id="customService" name="customService">
                            <c:forEach items="${srvOrderView.userBoList}" var="user">
                                <option value="${user.userId}">${user.userNameCn}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-sm-2 formtable-list-require">委托服务：</label>

                    <div class="col-sm-10 input-group select-label" style="padding:5px 10px 5px 20px;">
                        <c:forEach items="${srvOrderView.serviceBoList}" var="service">
                            <label class="btn btn-default">
                                <input type="checkbox" name="serviceId" class="service"
                                       value="${service.serviceId}"> ${service.srvNameCn}
                            </label>
                        </c:forEach>
                        <input type="hidden" id="serviceIds" name="serviceIds">
                    </div>
                </div>

                <div class="formtable-list">
                    <label class="col-sm-2 ">订单备注：</label>

                    <div class="col-sm-9">
                        <textarea id="myEditor" name="memo" rows="10" class="form-control"></textarea>
                    </div>
                </div>
            </div>
            <div class="formtable-cont text_c">
                <input type="submit" class="btn btn-primary" value="保存"/>
            </div>
            <input type="hidden" name="orderId" value="${srvOrderView.orderId}"/>
        </form>
    </div>
</div>
<script type="text/javascript" src="${ctx}/resources/js/serviceorder/new_add.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>
