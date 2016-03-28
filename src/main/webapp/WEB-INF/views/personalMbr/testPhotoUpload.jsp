<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>会员中西-信息编辑</title>
    <%@include file="/WEB-INF/common/global/common.jsp" %>
</head>
<body>
<div class="container-fluid">
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">会员中心</a>
    </li>
    <li>
        <a href="${ctx}/tradeEval/list">会员信息查看</a>
    </li>
</nav>
<div class="formtable" id="userInfoSaveForm">

<form class="formtable-cont" action="${ctx}/personalMbr/saveUser" method="post" id="personalMbrForm">
<div class="clear"></div>
<div class="formtable-list">
    <div class="col-xs-12 pad_10">
        <label class="col-sm-2">头像：</label>

        <div class="col-sm-7 col-md-8">
            <div class="col-xs-5 col-sm-3 col-sm-2">

                    <img img-tag="upload" src="http://devimg.51aladdin.com/b5a4ab3c-ad8b-499b-bfb1-d8779869cc5b.png" class="img-responsive"/>
                <input type="file" style="display: none">
                <input type="hidden" name="personHeadPhoto">
            </div>
        </div>
    </div>
</div>
</form>

</div>
</div>

<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/personalMbr/uploadTest.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>