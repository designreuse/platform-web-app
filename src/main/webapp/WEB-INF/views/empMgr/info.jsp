<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>用户中心-个人信息查看</title>
    <%@include file="/WEB-INF/common/global/common.jsp"%>
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">用户中心</a>
    </li>
    <li>
        <a href="/platform/empMgr/list">员工管理</a>
    </li>
    <li>
        <a href="/platform/empMgr/info?userId=${userInfo.userBo.userId}">员工信息查看</a>
    </li>
</nav>
<div class="container-fluid">
    <div class="formtable">
        <div class="formtable-nav">
            <ul class="list-inline">
                <li><a href="#baseInfo" class="btn btn-primary">基本信息</a></li>
                <li><a href="${ctx}/empMgr/edit?userId=${userInfo.userBo.userId}" class="btn btn-primary">修改密码</a></li>
                <li class="pull-right"><a href="${ctx}/empMgr/edit?userId=${userInfo.userBo.userId}" class="btn btn-default">编辑</a></li>
            </ul>
        </div>
        <div class="formtable-cont">
            <h4 class="header" id="baseInfo">基本信息</h4>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-xs-4">所属公司：</label>
                    <div class="col-xs-8 label-cont">${userInfo.userBo.orgNameCn}</div>
                </div>
                <div class="col-xs-6">
                    <label class="col-xs-4">隶属状态：</label>
                    <div class="col-xs-8 label-cont">
                        <c:if test="${userInfo.userBo.userType==0}"> 无企业</c:if>
                        <c:if test="${userInfo.userBo.userType==1}"> 申请中</c:if>
                        <c:if test="${userInfo.userBo.userType==2}"> 已通过</c:if>
                        <c:if test="${userInfo.userBo.userType==3}"> 申请解除</c:if>
                        <c:if test="${userInfo.userBo.userType==4}"> 已解除</c:if>
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-sm-2 pad_10">
                    <img src="${userInfo.userBo.personHeadPhoto}" class="img-responsive" alt="">
                </div>
                <div class="col-sm-10">
                    <label class="col-xs-4 col-sm-3 col-md-2">姓名（中文）：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">${userInfo.userBo.userNameCn}&nbsp;</div>
                    <label class="col-xs-4 col-sm-3 col-md-2">姓名（俄/英）：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">${fn:replace(userInfo.userBo.userNameFirst,',',' ')}&nbsp;</div>
                    <label class="col-xs-4 col-sm-3 col-md-2">生日：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont"><fmt:formatDate value="${userInfo.userBo.birthday}" pattern="yyyy-MM-dd"/>&nbsp;</div>
                    <label class="col-xs-4 col-sm-3 col-md-2">性别：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">
                        <c:if test="${userInfo.userBo.sex==1}">男</c:if>
                        <c:if test="${userInfo.userBo.sex==2}">女</c:if>
                        <c:if test="${userInfo.userBo.sex==0}">保密</c:if>
                        &nbsp;
                    </div>
                    <label class="col-xs-4 col-sm-3 col-md-2">手机（登录名）：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">${userInfo.userBo.mobile}&nbsp;</div>
                    <label class="col-xs-4 col-sm-3 col-md-2">邮箱：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">${userInfo.userBo.email}&nbsp;</div>
                    <label class="col-xs-4 col-sm-3 col-md-2">居住地址：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">${userInfo.userBo.provinceNameCn}
                    ${userInfo.userBo.cityNameCn}  ${userInfo.userBo.districtNameCn}  ${userInfo.userBo.address}&nbsp;</div>
                    <label class="col-xs-4 col-sm-3 col-md-2">身份证号：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">${userInfo.userBo.idcard}&nbsp;</div>
                    <label class="col-xs-4 col-sm-3 col-md-2">身份证：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">
                        <div class="row">
                            <div class="col-sm-4">
                                <c:if test="${empty userInfo.userBo.idcardPathFront}">
                                    <img src="${ctx}/resources/images/bn.jpg" class="img-responsive" alt="">
                                </c:if>
                                <c:if test="${!empty userInfo.userBo.idcardPathFront}">
                                    <img src="${userInfo.userBo.idcardPathFront}" class="img-responsive" alt="">
                                </c:if>

                            </div>
                            <div class="col-sm-4">
                                <c:if test="${empty userInfo.userBo.idcardPathBack}">
                                    <img src="${ctx}/resources/images/bn.jpg" class="img-responsive" alt="">
                                </c:if>
                                <c:if test="${!empty userInfo.userBo.idcardPathBack}">
                                    <img src="${userInfo.userBo.idcardPathBack}" class="img-responsive" alt="">
                                </c:if>
                            </div>
                            <div class="col-sm-4">
                                <c:if test="${empty userInfo.userBo.idcardPathUser}">
                                    <img src="${ctx}/resources/images/bn.jpg" class="img-responsive" alt="">
                                </c:if>
                                <c:if test="${!empty userInfo.userBo.idcardPathUser}">
                                    <img src="${userInfo.userBo.idcardPathUser}" class="img-responsive" alt="">
                                </c:if>
                            </div>
                            <div class="col-xs-12 mar_t5">
                                <c:if test="${userInfo.userBo.statusType==1}"> <span
                                        class="icon icon-wait"></span> 初审</c:if>
                                <c:if test="${userInfo.userBo.statusType==2}"> <span
                                        class="icon icon-right"></span> 审核通过</c:if>
                                <c:if test="${userInfo.userBo.statusType==3}"> <span
                                        class="icon icon-wait"></span>待审核</c:if>
                                <c:if test="${userInfo.userBo.statusType==4}"> <span
                                        class="icon icon-close"></span> 审核拒绝</c:if>
                            </div>
                        </div>
                    </div>
                    <label class="col-xs-4 col-sm-3 col-md-2">服务执行部门：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">${userInfo.userBo.deptName}&nbsp;</div>
                    <label class="col-xs-4 col-sm-3 col-md-2">企业管理员：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">
                        <c:if test="${userInfo.userBo.isRoot==1}">
                            是
                        </c:if>
                        <c:if test="${userInfo.userBo.isRoot==0}">
                            否
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script>

</script>
</body>
</html>