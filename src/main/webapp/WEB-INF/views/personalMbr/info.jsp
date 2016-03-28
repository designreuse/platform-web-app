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
        您当前位置：<a href="#">会员中心</a>
    </li>
    <li>
        <a href="${ctx}/personalMbr/list">个人会员管理</a>
    </li>
    <li>
        <a href="${ctx}/personalMbr/info?userId=${personalMbrView.userBo.userId}">个人会员详情</a>
    </li>
</nav>
<div class="container-fluid">
    <div class="formtable">
        <div class="formtable-nav">
            <ul class="list-inline">
                <li><a href="#baseInfo" class="btn btn-primary">基本信息</a></li>
                <li class="pull-right"><a href="${ctx}/personalMbr/edit?userId=${personalMbrView.userBo.userId}" class="btn btn-default">编辑</a></li>
            </ul>
        </div>
        <div class="formtable-cont">
            <h4 class="header" id="baseInfo">基本信息</h4>
            <c:if test="${personalMbrView.userBo.entUserStatus==1}">
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-md-4">所属公司：</label>
                        <div class="col-md-8 label-cont">${personalMbrView.userBo.orgName}</div>
                    </div>
                    <div class="col-xs-6">
                        <label class="col-md-4">隶属状态：</label>
                        <div class="col-md-8 label-cont">
                            <c:if test="${personalMbrView.userBo.userType==0}"> 无企业</c:if>
                            <c:if test="${personalMbrView.userBo.userType==1}"> 申请中</c:if>
                            <c:if test="${personalMbrView.userBo.userType==2}"> 已通过</c:if>
                            <c:if test="${personalMbrView.userBo.userType==3}"> 申请解除</c:if>
                            <c:if test="${personalMbrView.userBo.userType==4}"> 已解除</c:if>
                        </div>
                    </div>
                </div>
            </c:if>

            <div class="formtable-list">
                <div class="col-sm-2 pad_10">
                    <img src="${personalMbrView.userBo.personHeadPhoto}" class="img-responsive" alt="">
                </div>
                <div class="col-sm-10">
                    <label class="col-xs-4 col-sm-3 col-md-2">注册平台：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">
                        <c:if test="${personalMbrView.userBo.regSource==5}">俄站</c:if>
                        <c:if test="${personalMbrView.userBo.regSource==3}">中站</c:if>
                        <c:if test="${personalMbrView.userBo.regSource==2}">运营平台</c:if>
                    &nbsp;</div>
                    <label class="col-xs-4 col-sm-3 col-md-2">姓名（中文）：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">${personalMbrView.userBo.userNameCn}&nbsp;</div>
                    <label class="col-xs-4 col-sm-3 col-md-2">姓名（俄/英）：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">${fn:replace(personalMbrView.userBo.userNameFirst,","," ")}&nbsp;</div>
                    <label class="col-xs-4 col-sm-3 col-md-2">生日：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont"><fmt:formatDate value="${personalMbrView.userBo.birthday}" pattern="yyyy-MM-dd"/>&nbsp;</div>
                    <label class="col-xs-4 col-sm-3 col-md-2">性别：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">
                        <c:if test="${personalMbrView.userBo.sex==1}">男</c:if>
                        <c:if test="${personalMbrView.userBo.sex==2}">女</c:if>
                        <c:if test="${personalMbrView.userBo.sex==0}">保密</c:if>
                        &nbsp;
                    </div>
                    <label class="col-xs-4 col-sm-3 col-md-2">电话：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">
                        <c:if test="${!empty personalMbrView.userBo.telCountry}">
                            +${personalMbrView.userBo.telCountry}-${personalMbrView.userBo.telZone}-${personalMbrView.userBo.tel}
                            <c:if test="${!empty personalMbrView.userBo.telExt}">
                                -${personalMbrView.userBo.telExt}
                            </c:if>
                        </c:if>
                        &nbsp;
                    </div>
                    <label class="col-xs-4 col-sm-3 col-md-2">传真：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">
                        <c:if test="${!empty personalMbrView.userBo.faxCountry}">
                            +${personalMbrView.userBo.faxCountry}-${personalMbrView.userBo.faxZone}-${personalMbrView.userBo.fax}
                            <c:if test="${!empty personalMbrView.userBo.faxExt}">
                                -${personalMbrView.userBo.faxExt}
                            </c:if>
                        </c:if>
                        &nbsp;
                    </div>
                    <label class="col-xs-4 col-sm-3 col-md-2">手机（登录名）：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">${personalMbrView.userBo.mobile}&nbsp;</div>
                    <label class="col-xs-4 col-sm-3 col-md-2">邮箱：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">${personalMbrView.userBo.email}&nbsp;</div>
                    <label class="col-xs-4 col-sm-3 col-md-2">居住地址：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">${personalMbrView.userBo.provinceNameCn}
                    ${personalMbrView.userBo.cityNameCn}  ${personalMbrView.userBo.districtNameCn}  ${personalMbrView.userBo.address}&nbsp;</div>
                    <label class="col-xs-4 col-sm-3 col-md-2">身份证：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">
                        <div class="row">
                            <div class="col-sm-4">
                                <c:if test="${empty personalMbrView.userBo.idcardPathFront}">
                                    <img src="${ctx}/resources/images/bn.jpg" class="img-responsive" alt="">
                                </c:if>
                                <c:if test="${!empty personalMbrView.userBo.idcardPathFront}">
                                    <img src="${personalMbrView.userBo.idcardPathFront}" class="img-responsive" alt="">
                                </c:if>

                            </div>
                            <div class="col-sm-4">
                                <c:if test="${empty personalMbrView.userBo.idcardPathBack}">
                                    <img src="${ctx}/resources/images/bn.jpg" class="img-responsive" alt="">
                                </c:if>
                                <c:if test="${!empty personalMbrView.userBo.idcardPathBack}">
                                    <img src="${personalMbrView.userBo.idcardPathBack}" class="img-responsive" alt="">
                                </c:if>
                            </div>
                            <div class="col-sm-4">
                                <c:if test="${empty personalMbrView.userBo.idcardPathUser}">
                                    <img src="${ctx}/resources/images/bn.jpg" class="img-responsive" alt="">
                                </c:if>
                                <c:if test="${!empty personalMbrView.userBo.idcardPathUser}">
                                    <img src="${personalMbrView.userBo.idcardPathUser}" class="img-responsive" alt="">
                                </c:if>
                            </div>

                            <%--//待初审--%>
                            <%--Integer AUDIT_FIRST = 1;--%>
                            <%--//审核通过--%>
                            <%--Integer AUDIT_PASS = 2;--%>
                            <%--//待审核--%>
                            <%--Integer AUDIT_WAIT = 3;--%>
                            <%--//审核拒绝--%>
                            <%--Integer AUDIT_REFUSE = 4;--%>
                            <div class="col-xs-12 mar_t5">
                                <c:if test="${personalMbrView.userBo.statusType==2}"> 审核通过 <span class="icon icon-right"></span></c:if>
                                <c:if test="${personalMbrView.userBo.statusType==4}"> 审核拒绝 <span class="icon icon-close"></span></c:if>
                                <c:if test="${personalMbrView.userBo.statusType==1 || personalMbrView.userBo.statusType==3}">
                                    证件待审核： <a href="${ctx}/personalMbr/checkIdcard?userId=${personalMbrView.userBo.userId}&&statusType=2"  class="btn btn-default btn-success">通过</a>
                                               <a href="${ctx}/personalMbr/checkIdcard?userId=${personalMbrView.userBo.userId}&&statusType=4"  class="btn btn-default btn-warning">拒绝</a>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <label class="col-xs-4 col-sm-3 col-md-2">身份证号：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">${personalMbrView.userBo.idcard}&nbsp;</div>

                    <label class="col-xs-4 col-sm-3 col-md-2">护照号：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">${personalMbrView.userBo.passport}&nbsp;</div>

                    <label class="col-xs-4 col-sm-3 col-md-2">从业起始时间：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont"><fmt:formatDate value="${personalMbrView.userBo.workingTime}" pattern="yyyy-MM-dd"/>&nbsp;</div>

                    <label class="col-xs-4 col-sm-3 col-md-2">服务执行部门：</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">${personalMbrView.userBo.deptName}&nbsp;</div>

                    <label class="col-xs-4 col-sm-3 col-md-2">企业管理员：&nbsp;</label>
                    <div class="col-xs-8 col-sm-9 col-md-10 label-cont">
                        <c:if test="${personalMbrView.userBo.isRoot==1}">是</c:if>
                        <c:if test="${personalMbrView.userBo.isRoot==0}">否</c:if>
                    </div>


                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>