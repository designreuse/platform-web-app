<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="${ctx}/resources/js/html5.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/respond.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/PIE_IE678.js"></script>
    <![endif]-->
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <!--[if IE 7]>
    <link href="${ctx}/resources/font/font-awesome-ie7.min.css" rel="stylesheet" type="text/css" />
    <![endif]-->
    <title>询盘详情</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 商机中心 <span class="c-gray en">&gt;</span> 询盘回盘管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a> <span class="c-gray en">&gt;</span><a href="#">询盘详情</a></nav>
<div class="pd-20">
    <table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top">
        <thead>
        <tr class="text-l">
            <th width="106"><span class="l f-16">询盘信息</span> <span class="r">询盘编号：${entity.inquiryCode}</span> </th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <table class="table table-border table-bordered table-bg table-sort">
        <tbody>
        <tr>
            <th width="80" class="text-r"> 状态：</th>
            <td width="728">
                <c:choose>
                    <c:when test="${entity.inquiryStatus == 1}">询价中</c:when>
                    <c:when test="${entity.inquiryStatus == 2}">待买家确认</c:when>
                    <c:when test="${entity.inquiryStatus == 3}">待卖家确认</c:when>
                    <c:when test="${entity.inquiryStatus == 4}">已确认</c:when>
                    <c:when test="${entity.inquiryStatus == 5}">已取消</c:when>
                </c:choose>
            </td>
            <th width="149" class="text-r">操作：</th>
            <td width="648">
                <c:choose>
                    <c:when test="${entity.inquiryType == 1 and entity.inquiryStatus == 1}">
                        <a class="btn btn-primary radius" href="${ctx}/inquiry/feedback/${entity.inquiryId}">
                            <i class="icon-plus"></i>回盘
                        </a>
                    </c:when>
                    <c:when test="${(entity.inquiryType == 1 and entity.inquiryStatus == 2) or (entity.inquiryType == 2 and entity.feedbackStatus == 2)}">
                        <a class="btn btn-primary radius" href="javascript:buyersConfirm('${entity.inquiryFeedbackId}','${entity.inquiryType}');">
                            买方确认
                        </a>
                        <a class="btn btn-primary radius" href="javascript:buyersRefuse('${entity.inquiryFeedbackId}','${entity.inquiryType}');">
                            买方拒绝
                        </a>
                    </c:when>
                    <c:when test="${(entity.inquiryType == 1 and entity.inquiryStatus == 3) or (entity.inquiryType == 2 and entity.feedbackStatus == 3)}">
                        <a class="btn btn-primary radius" href="javascript:sellerConfirm('${entity.inquiryFeedbackId}');">
                            卖方确认
                        </a>
                        <a class="btn btn-primary radius" href="javascript:sellerRefuse('${entity.inquiryFeedbackId}');">
                            卖方拒绝
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a class="btn btn-primary radius" href="javascript:;">
                            无
                        </a>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <th width="80" class="text-r"> 买方：</th>
            <td width="728">${entity.orgName}&nbsp;</td>
            <th width="149" class="text-r">买方联系人姓名：</th>
            <td width="648">${entity.userName}</td>
        </tr>
        <tr>
            <th class="text-r">卖方：</th>
            <td>${entity.feedbackOrgName} &gt; ${entity.feedbackShopsName}</td>
            <th class="text-r">卖方联系人姓名：</th>
            <td>${entity.sellerName}</td>
        </tr>
        </tbody>
    </table>
    <table class="table table-border table-bordered table-hover table-bg table-sort">
        <thead>
        <tr class="text-c">
            <th width="409">商品</th>
            <th width="430">商品属性</th>
            <th width="308">采购详情</th>
            <th width="215">单价<br>(CNY)</th>
            <th width="239">总价<br>(CNY)</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${entity.inquiryProductList}" var="product">
            <c:if test="${entity.inquiryType == 1}">
                <c:if test="${entity.inquiryStatus == 1 or entity.inquiryStatus == 5}">
                    <c:set var="totalMoney" value="${totalMoney + product.purchareNum * product.unitPrice}" scope="page"/>
                </c:if>
                <c:if test="${entity.inquiryStatus > 1 and entity.inquiryStatus < 5}">
                    <c:set var="totalMoney" value="${totalMoney + product.purchareNum * product.quotedPrice}" scope="page"/>
                </c:if>
            </c:if>
            <c:if test="${entity.inquiryType == 2}">
                <c:if test="${entity.feedbackStatus == null}">
                    <c:set var="totalMoney" value="${totalMoney + product.purchareNum * product.unitPrice}" scope="page"/>
                </c:if>
                <c:if test="${entity.feedbackStatus > 1 and entity.feedbackStatus < 5}">
                    <c:set var="totalMoney" value="${totalMoney + product.purchareNum * product.quotedPrice}" scope="page"/>
                </c:if>
            </c:if>
            <tr class="text-l">
                <td><img src="${product.logoUrl}" width="80" height="80" class="l mr-10">
                    <span><br>${product.skuName}&nbsp;&nbsp;${product.productName}</span>
                </td>
                <td>
                    <c:if test="${fun:length(product.properties) == 0}">--</c:if>
                    <c:forEach items="${product.properties}" var="prop">
                        ${prop.propertyName}：${prop.propertyValue}<br/>
                    </c:forEach>
                </td>
                <td>
                    采购量：${product.purchareNum}&nbsp;${product.unitName} <br>
                    标准件：${product.standard}&nbsp;${product.unitName}&nbsp;/
                    <c:if test="${product.packageType == 1}">箱</c:if>
                    <c:if test="${product.packageType == 2}">盒子</c:if>
                    <c:if test="${product.packageType == 3}">桶</c:if>
                </td>
                <td>求购价：<fmt:formatNumber value="${product.unitPrice}" pattern="#,##0.00"/><br/>
                    <c:if test="${entity.inquiryType == 1 and entity.inquiryStatus > 1 and entity.inquiryStatus < 5}">
                        报价：<fmt:formatNumber value="${product.quotedPrice}" pattern="#,##0.00"/>
                    </c:if>
                    <c:if test="${entity.inquiryType == 2 and entity.feedbackStatus > 1 and entity.feedbackStatus < 5}">
                        报价：<fmt:formatNumber value="${product.quotedPrice}" pattern="#,##0.00"/>
                    </c:if>
                </td>
                <td >
                    <c:if test="${entity.inquiryType == 1}">
                        <c:if test="${entity.inquiryStatus == 1 or entity.inquiryStatus == 5}">
                            <fmt:formatNumber value="${product.purchareNum * product.unitPrice}" pattern="#,##0.00"/>
                        </c:if>
                        <c:if test="${entity.inquiryStatus > 1 and entity.inquiryStatus < 5}">
                            <fmt:formatNumber value="${product.purchareNum * product.quotedPrice}" pattern="#,##0.00"/>
                        </c:if>
                    </c:if>
                    <c:if test="${entity.inquiryType == 2}">
                        <c:if test="${entity.feedbackStatus == null or entity.feedbackStatus == 5}">
                            <fmt:formatNumber value="${product.purchareNum * product.unitPrice}" pattern="#,##0.00"/>
                        </c:if>
                        <c:if test="${entity.feedbackStatus > 1 and entity.feedbackStatus < 5}">
                            <fmt:formatNumber value="${product.purchareNum * product.quotedPrice}" pattern="#,##0.00"/>
                        </c:if>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top2">
        <thead>
        <tr class="text-l">
            <th width="106"><span class="r">合计：CNY&nbsp;
            <fmt:formatNumber value="${totalMoney}" pattern="#,##0.00"/>
            </span></th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <div class="clear"></div>
    <table class="table table-border table-bordered table-bg table-sort mt-15">
        <tbody>
        <tr>
            <th width="190" class="text-r"><span class="c-red">*</span> 交货地：</th>
            <td width="400">
                <c:if test="${entity.deliveryAddrId == 1}"> 满洲里</c:if>
                <c:if test="${entity.deliveryAddrId == 2}"> 赤塔</c:if>
                <c:if test="${entity.deliveryAddrId == 3}"> 乌兰乌德</c:if>
                <c:if test="${entity.deliveryAddrId == 4}"> 伊尔库兹克</c:if>
                <c:if test="${entity.deliveryAddrId == 5}"> 新西伯利亚</c:if>
            </td>
            <th class="text-r"><span class="c-red">*</span>询盘有效期： </th>
            <td><odpf:formatDate style='DATE' date='${entity.effectiveDate}'/></td>
        </tr>
        <tr>
            <th width="194" class="text-r"><span class="c-red">*</span>交货日期：</th>
            <td><odpf:formatDate style='DATE' date='${entity.deliveryDate}'/>&nbsp;&nbsp;—>&nbsp;&nbsp;<odpf:formatDate style='DATE' date='${entity.lastDate}'/></td>
        </tr>
        <tr>
            <th rowspan="3" valign="top" class="text-r"><span class="c-red">*</span>付款方式：</th>
            <td rowspan="3" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" class="table-border">
                <tbody>
                <tr>
                    <td>支付方式：</td>
                    <td><c:if test="${entity.payType == 1}"> 线下支付</c:if></td>
                </tr>
                <tr>
                    <td width="32%">预付款比例:</td>
                    <td width="68%">
                        <c:if test="${entity.paywayPercent == 1}"> 30% </c:if>
                        <c:if test="${entity.paywayPercent == 2}"> 50% </c:if>
                        <c:if test="${entity.paywayPercent == 3}"> 100% </c:if>
                    </td>
                </tr>
                <c:if test="${entity.paywayPercent != 3}">
                    <tr>
                        <td>尾款支付限期:</td>
                        <td> <c:if test="${entity.paywayLast == 1}"> 提货时付款</c:if>
                            <c:if test="${entity.paywayLast == 2}"> 提货后30天内付款</c:if>
                            <c:if test="${entity.paywayLast == 3}"> 提货后60天内付款</c:if> </td>
                    </tr>
                </c:if>
                </tbody>
            </table></td>
            <th height="47" valign="top" class="text-r"><p><span class="c-red">*</span>提货方式：</p></th>
            <td valign="top"><c:if test="${entity.takeGoodsType == 1}">自提</c:if><br></td>
        </tr>
        <tr>
            <th valign="top" class="text-r">附加说明：</th>
            <td valign="top">${entity.memo}</td>
        </tr>
        <c:if test="${entity.inquiryType == 1 and entity.inquiryStatus > 1 and entity.inquiryStatus < 5}">
            <tr>
                <th valign="top" class="text-r">附加说明回复：</th>
                <td valign="top">${entity.feedbackMemo}</td>
            </tr>
        </c:if>
        <c:if test="${entity.inquiryType == 2 and entity.feedbackStatus > 1 and entity.feedbackStatus < 5}">
            <tr>
                <th valign="top" class="text-r">附加说明回复：</th>
                <td valign="top">${entity.feedbackMemo}</td>
            </tr>
        </c:if>
        </tbody>
    </table>
    <p>&nbsp;</p>
</div>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/layer/layer.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script language="javascript" src="${ctx}/resources/js/position_top.js"></script>
<script type="text/javascript">
    //买家确认
    function buyersConfirm(inquiryFeedbackId,inquiryType){
        $.get("${ctx}/inquiry/buyersConfirm",{inquiryFeedbackId:inquiryFeedbackId,type:inquiryType},function(){
            alert("操作成功！");
            window.location.href="${ctx}/inquiry/list";
        });
    }
    //买家拒绝
    function buyersRefuse(inquiryFeedbackId,inquiryType){
        $.get("${ctx}/inquiry/buyersRefuse",{inquiryFeedbackId:inquiryFeedbackId,type:inquiryType},function(){
            alert("操作成功！");
            window.location.href="${ctx}/inquiry/list";
        });
    }

    //卖方确认
    function sellerConfirm(inquiryFeedbackId){
        $.get("${ctx}/inquiry/sellerConfirm",{inquiryFeedbackId:inquiryFeedbackId},function(){
            alert("操作成功！");
            window.location.href="${ctx}/inquiry/list";
        });
    }
    //卖方拒绝
    function sellerRefuse(inquiryFeedbackId){
        $.get("${ctx}/inquiry/sellerRefuse",{inquiryFeedbackId:inquiryFeedbackId},function(){
            alert("操作成功！");
            window.location.href="${ctx}/inquiry/list";
        });
    }
</script>
</body>
</html>