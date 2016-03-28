<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>修改密码</title>
    <%@include file="/WEB-INF/common/global/common.jsp" %>
</head>
<body>

<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">用户中心</a>
    </li>
    <li>
        <a href="#">修改密码</a>
    </li>


</nav>

<div class="container-fluid">
    <c:if test="${rst==1}">
        <div class="alert alert-success" role="alert">${message}</div>
    </c:if>
    <c:if test="${rst==-1}">
        <div class="alert alert-warning" role="alert">${message}</div>
    </c:if>
    <form id="changPwdForm" method="post" action="${ctx}/userInfo/commitPwd">
    <div class="formtable">
        <div class="formtable-cont">
            <h4 class="header header-fl">修改密码</h4>
            <button class="btn btn-primary header-button" type="submit">保存</button>
            <div class="clear"></div>
                <div class="formtable-list">
                    <label class="col-xs-3 col-sm-2 formtable-list-require">旧密码：</label>

                    <div class="col-xs-4 col-sm-3">
                        <input type="text" name="oldPassword" class="form-control">
                    </div>
                </div>
                <div class="formtable-list">
                    <label class="col-xs-3 col-sm-2 formtable-list-require">新密码：</label>

                    <div class="col-xs-4 col-sm-3">
                        <input type="text" name="newPassword" class="form-control" placeholder="请输入6~20位数字、字母或字符">
                    </div>


                </div>
                <div class="formtable-list">
                    <label class="col-xs-3 col-sm-2 formtable-list-require">再次输入新密码：</label>

                    <div class="col-xs-4 col-sm-3">
                         <input type="text" name="password_again" id="againPwd" class="form-control" placeholder="请再次输入密码">
                    </div>


                </div>


        </div>
    </div>
    </form>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/userInfo/changePwd.js"></script>
</body>
</html>