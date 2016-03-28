<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>特殊广告</title>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">内容中心</a>
    </li>
    <li>
        <a href="${ctx}/banner/list">广告管理</a>
    </li>
    <li>
        <a href="${ctx}/banner/specialAd">特殊广告</a>
    </li>
</nav>
<div class="container-fluid anzeig">
    <div class="formtable">
        <div class="formtable-cont">
            <h4 class="header header-fl">供应商站点</h4>
            <a class="btn btn-primary header-button" id="support">保存</a>
            <div class="clear"></div>
        </div>
        <div class="row no_mar">
            <c:forEach items="${banner.specialAdCn}" var="ad">
                <div class="col-xs-3">
                    <div class="col-md-12 col-sm-12 thema-list-pic thema-list-pic-auto hover-menu" style="background-image:url('${ad.logoUrl}')"></div>
                    <p><input type="checkbox" onchange="adSelected('${ad.isMourning}','${ad.id}')" data-mourning="${ad.isMourning}"  name="cnId" value="${ad.id}" <c:if test="${ad.isUsed}">checked="checked"</c:if>> ${ad.specialAdName}</p>
                    <div class="menu-box menu">
                        <div class="arrow-top"></div>
                        <div class="detail-menu">
                            <img src="${ad.logoUrl}" class="img-responsive" />
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="formtable">
        <div class="formtable-cont">
            <h4 class="header header-fl">采购商站点</h4>
            <a class="btn btn-primary header-button" id="supportRu">保存</a>
            <div class="clear"></div>
        </div>
        <div class="row no_mar">
            <form action="" method="post">
                <c:forEach items="${banner.specialAdRu}" var="ad">
                    <div class="col-xs-3">
                        <div class="col-md-12 col-sm-12 thema-list-pic thema-list-pic-auto hover-menu" style="background-image:url('${ad.logoUrl}')"></div>
                        <p><input type="checkbox" onchange="adRuSelected('${ad.isMourning}','${ad.id}')" data-mourning="${ad.isMourning}"  name="ruId" value="${ad.id}" <c:if test="${ad.isUsed}">checked="checked"</c:if>> ${ad.specialAdName}</p>
                        <div class="menu-box menu">
                            <div class="arrow-top"></div>
                            <div class="detail-menu">
                                <img src="${ad.logoUrl}" class="img-responsive" />
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </form>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/banner/specialad.js"></script>
<script>

</script>
</body>
</html>