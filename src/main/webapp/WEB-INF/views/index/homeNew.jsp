<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>基础模块-工作台</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">首页</a>
    </li>
</nav>
<div class="container-fluid">
    <div class="row">
        <div class="formtable col-md-8">
            <div class="formtable-cont">
                <h4 class="header mar_b-20" id="review1"><strong>待审核企业</strong></h4>
                <a href="${ctx}/cmpMbr/list?status=3" class="header-a">更多&gt;&gt;</a>
                <div class="clear"></div>
                <div class="mar_t10">
                    <table class="table table-bordered table-hover f-size-12">
                        <thead>
                        <tr>
                            <th>公司名称</th>
                            <th>企业身份</th>
                            <th>注册来源</th>
                            <th>审核</th>
                            <th>状态</th>
                            <th>创建时间</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${view.orgList}">
                            <tr>
                                <td>
                                    <a href="${ctx}/cmpMbr/info?orgId=${item.id}">
                                        <c:if test="${item.countryType==null or item.countryType==1}">
                                            ${item.orgNameCn}
                                        </c:if>
                                        <c:if test="${item.countryType==2}">
                                            ${item.orgNameRu}
                                        </c:if>
                                    </a>
                                </td>
                                <td>
                                    <c:if test="${item.identityNameList!=null}">
                                        ${item.identityNameList}
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${item.countryType==1}">
                                        中文站点
                                    </c:if>
                                    <c:if test="${item.countryType==2}">
                                        俄文站点
                                    </c:if>
                                </td>
                                <td>
                                    <font color="#FF0000">
                                        <c:if test="${item.orgAdultStatus==1}">
                                            初审
                                        </c:if>
                                        <c:if test="${item.orgAdultStatus==3}">
                                            待审核
                                        </c:if>
                                    </font>
                                </td>
                                <td>
                                    <c:if test="${item.disabled==true}">
                                        停用
                                    </c:if>
                                    <c:if test="${item.disabled==false}">
                                        可用
                                    </c:if>
                                </td>
                                <td>
                                    <fmt:formatDate value='${item.createTime}' pattern='yyyy-MM-dd'/>
                                    </br>
                                    <fmt:formatDate value='${item.createTime}' pattern='HH:mm'/>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="formtable-cont">
                <h4 class="header mar_b-20" id="review2"><strong>待审核个人</strong></h4>
                <a href="${ctx}/personalMbr/list?status=3" class="header-a">更多&gt;&gt;</a>
                <div class="clear"></div>
                <div class="mar_t10">
                    <table class="table table-bordered table-hover f-size-12">
                        <thead>
                        <tr>
                            <th>姓名</th>
                            <th>公司名称</th>
                            <th>注册来源</th>
                            <th>审核</th>
                            <th>隶属关系</th>
                            <th>状态</th>
                            <th>创建时间</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${view.userList}">
                            <tr>
                                <td>
                                    <a href="${ctx}/personalMbr/info?userId=${item.userId}">
                                        <c:if test="${item.regSource==5}">
                                            ${item.userNameRu}<br>${item.email}
                                        </c:if>
                                        <c:if test="${item.regSource==null || item.regSource!=5}">
                                            ${item.userNameCn}<br>${item.mobile}
                                    </c:if>
                                    </a>
                                </td>
                                <td>
                                    <c:if test="${item.orgNameCn!=null}">
                                        ${item.orgNameCn}
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${item.regSource==5}">
                                        俄站
                                    </c:if>
                                    <c:if test="${item.regSource==3}">
                                        中站
                                    </c:if>
                                    <c:if test="${item.regSource==2}">
                                        运营平台
                                    </c:if>
                                </td>
                                <td>
                                    <font color="#FF0000">
                                        <c:if test="${item.statusType==1}">
                                            初审
                                        </c:if>
                                        <c:if test="${item.statusType==3}">
                                            待审核
                                        </c:if>
                                   </font>
                                </td>
                                <td>
                                    <c:if test="${item.entUserStatus==1}">
                                        隶属
                                    </c:if>
                                    <c:if test="${item.entUserStatus==2}">
                                        个人
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${item.disabled==true}">
                                        逻辑删除
                                    </c:if>
                                    <c:if test="${item.disabled==false}">
                                        有效
                                    </c:if>
                                </td>
                                <td>
                                    <fmt:formatDate value='${item.createTime}' pattern='yyyy-MM-dd'/>
                                    </br>
                                    <fmt:formatDate value='${item.createTime}' pattern='HH:mm'/>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="formtable-cont">
                <h4 class="header mar_b-20" id="review3"><strong>待审核商铺</strong></h4>
                <a href="${ctx}/shops/list?status=3" class="header-a">更多&gt;&gt;</a>
                <div class="clear"></div>
                <div class="mar_t10">
                    <table class="table table-bordered table-hover f-size-12">
                        <thead>
                        <tr>
                            <th>商铺名称</th>
                            <th>所属公司</th>
                            <th>管理人</th>
                            <th>审核</th>
                            <th>隶属关系</th>
                            <th>状态</th>
                            <th>创建时间</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${view.shopsList}">
                            <tr>
                                <td>
                                    <a href="${ctx}/shops/edit/${item.shopsId}">
                                    ${item.shopsNameCn}
                                </a>
                                </td>
                                <td>
                                    ${item.orgNameCn}
                                </td>
                                <td>
                                    ${item.userNameCn}<br>
                                    ${item.mobile}
                                </td>
                                <td>
                                    <font color="#FF0000">
                                        <c:if test="${item.shopsStatus==1}">
                                            初审
                                        </c:if>
                                        <c:if test="${item.shopsStatus==3}">
                                            待审核
                                        </c:if>
                                    </font>
                                </td>
                                <td>
                                    <c:if test="${item.shopsType==1}">
                                        隶属
                                    </c:if>
                                    <c:if test="${item.shopsType==2}">
                                        个人
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${item.disabled==true}">
                                        逻辑删除
                                    </c:if>
                                    <c:if test="${item.disabled==false}">
                                        有效
                                    </c:if>
                                </td>
                                <td>
                                    <fmt:formatDate value='${item.createTime}' pattern='yyyy-MM-dd'/>
                                    </br>
                                    <fmt:formatDate value='${item.createTime}' pattern='HH:mm'/>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="formtable-cont">
                <h4 class="header mar_b-20" id="review4"><strong>待审核商品</strong></h4>
                <a href="${ctx}/sku/list?status=3" class="header-a">更多&gt;&gt;</a>
                <div class="clear"></div>
                <div class="mar_t10">
                    <table class="table table-bordered table-hover f-size-12">
                        <thead>
                        <tr>
                            <th >商品名称</th>
                            <th >报价</th>
                            <th>商铺名称</th>
                            <th>公司名称</th>
                            <th>上/下架</th>
                            <th>审核</th>
                            <th>发布时间</th>
                            <th>有效期</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${view.skuList}">
                            <tr>
                                <td>
                                    <a href="${ctx}/sku/edit/${item.skuId}">
                                        ${item.skuNameCn}
                                    </a>
                                </td>
                                <td>
                                    <c:forEach items="${item.skuPriceBoList}" var="price">
                                        <c:if test="${price.priceType == 1}">
                                            >= ${price.oq}${price.unitCn}&nbsp;  ${price.priceStart}
                                            <c:if test="${price.costType ==1}">
                                                美元/${price.unitCn}
                                            </c:if>
                                            <c:if test="${price.costType ==2}">
                                                卢布/${price.unitCn}
                                            </c:if>
                                            <c:if test="${price.costType ==3}">
                                                元/${price.unitCn}
                                            </c:if>
                                            <br>
                                        </c:if>
                                        <c:if test="${price.priceType == 2}">
                                            >= ${price.oq}${price.unitCn}&nbsp; ${price.priceStart}~${price.priceEnd}
                                            <c:if test="${price.costType ==1}">
                                                美元/${price.unitCn}
                                            </c:if>
                                            <c:if test="${price.costType ==2}">
                                                卢布/${price.unitCn}
                                            </c:if>
                                            <c:if test="${price.costType ==3}">
                                                元/${price.unitCn}
                                            </c:if>
                                            <br>
                                        </c:if>
                                        <c:if test="${price.priceType == 3}">
                                            >= ${price.oq}${price.unitCn}&nbsp;议价<br>
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>
                                    ${item.shopsNameCn}
                                </td>
                                <td>
                                    ${item.orgNameCn}
                                </td>
                                <td>
                                    <c:if test="${item.isOffline==true}">
                                        下架
                                    </c:if>
                                    <c:if test="${item.isOffline==false}">
                                        上架
                                    </c:if>
                                </td>
                                <td>
                                    <font color="#FF0000">${item.skuStatusCn}</font>
                                </td>
                                <td>
                                    <fmt:formatDate value='${item.createTime}' pattern='yyyy-MM-dd'/>
                                    </br>
                                    <fmt:formatDate value='${item.createTime}' pattern='HH:mm'/>
                                </td>
                                <td>
                                    <fmt:formatDate value='${item.validityDate}' pattern='yyyy-MM-dd'/>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="formtable-cont">
                <h4 class="header mar_b-20" id="review5"><strong>待确认服务订单</strong></h4>
                <a href="${ctx}/serviceOrder/list?status=1" class="header-a">更多&gt;&gt;</a>
                <div class="clear"></div>
                <div class="mar_t10">
                    <table class="table table-bordered table-hover f-size-12">
                        <thead>
                        <tr>
                            <th width="175">订单编号</th>
                            <th width="100">委托方</th>
                            <th width="100">联系人</th>
                            <th width="200">委托服务</th>
                            <th width="60">状态</th>
                            <th width="90">创建时间</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${view.srvOrderList}">
                            <tr>
                                <td>
                                    <a href="${ctx}/serviceOrder/${item.srvOrderId}/edit">
                                        ${item.srvOrderCode}
                                    </a>
                                </td>
                                <td>
                                    <c:if test="${item.countryType==1}">
                                        ${item.orgNameCn}
                                    </c:if>
                                    <c:if test="${item.countryType==2}">
                                        ${item.orgNameRu}
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${item.countryType==1}">
                                        ${item.customNameCn}<br>${item.mobile}
                                    </c:if>
                                    <c:if test="${item.countryType==2}">
                                        ${item.customNameRu}<br>${item.email}
                                    </c:if>
                                </td>
                                <td>
                                    ${item.srvNameCn}
                                </td>
                                <td>
                                    <font color="#FF0000">${item.statusNameCn}</font>
                                </td>
                                <td>
                                    <fmt:formatDate value='${item.createTime}' pattern='yyyy-MM-dd'/>
                                    </br>
                                    <fmt:formatDate value='${item.createTime}' pattern='HH:mm'/>
                                </td>
                            </tr>

                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="formtable col-md-4">
            <div class="formtable-cont">
                <h4 class="header mar_b-20" id="review6"><strong>平台公告</strong></h4>
                <a href="${ctx}/news/actionList" class="header-a">更多&gt;&gt;</a>
                <div class="clear"></div>
                <div class="list-group mar_t10">
                    <c:forEach var="item" items="${view.newsBoList}">
                        <a href="${ctx}/news/${item.id}/noticeDetail" class="list-group-item">
                            <c:if test="${item.title!=null}">
                                ${item.title}
                            </c:if>
                            <span class="pull-right">
                                    <fmt:formatDate value='${item.createTime}' pattern='MM'/>/<span class="pull-right"><fmt:formatDate value='${item.createTime}' pattern='dd'/>
                            </span>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>