<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>用户中心-个人信息编辑</title>
    <%@include file="/WEB-INF/common/global/common.jsp" %>
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
        <a href="/platform/empMgr/edit?userId=${userInfo.userBo.userId}">员工信息编辑</a>
    </li>
</nav>

<div class="container-fluid">
<div class="formtable">

<input type="hidden" name="regSource" value="${userInfo.userBo.regSource}"/>
<input type="hidden" name="orgId" value="${userInfo.userBo.orgId}"/>

<div class="formtable-nav">
    <ul class="list-inline">
        <li><a href="#baseInfo" class="btn btn-primary">基本信息</a></li>
        <li><a href="#password" class="btn btn-primary">修改密码</a></li>
        <li class="pull-right">
            <c:if test="${userInfo.userBo.accountState==1}">
                <a  href="${ctx}/empMgr/changeMbrStatus?userId=${userInfo.userBo.userId}&accountState=2" onclick="return confirm('确定要停用该用户吗？')" class="btn btn-danger">停用</a>
            </c:if>
            <c:if test="${userInfo.userBo.accountState!=1}">
                <a  href="${ctx}/empMgr/changeMbrStatus?userId=${userInfo.userBo.userId}&accountState=1" onclick="return confirm('确定要启用该用户吗？')" class="btn btn-success">启用</a>
            </c:if>
            <a href="${ctx}/empMgr/info?userId=${userInfo.userBo.userId}" class="btn btn-default">返回</a>
        </li>
    </ul>
</div>
<form class="formtable-cont" id="empInfoSaveForm" action="${ctx}/empMgr/saveUser" method="post">
<h4 class="header header-fl" id="baseInfo">基本信息</h4>
<input type="submit" class="btn btn-primary header-button" value="保存"/>
<input type="hidden" name="userId" value="${userInfo.userBo.userId}"/>
<input type="hidden" name="orgId" value="${userInfo.userBo.orgId}"/>
<div class="clear"></div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4 formtable-list-require">姓名（中文）：</label>

        <div class="col-sm-7 col-md-8">
            <input type="text" class="form-control" name="userNameCn" value="${userInfo.userBo.userNameCn}">
        </div>
    </div>
</div>
<div class="formtable-list">
        <label class="col-sm-2 formtable-list-require">姓名（俄/英）：</label>

        <div class="col-sm-10">
            <div class="col-sm-4">
                <div class="form-inline">
                    <div class="form-group">
                        <label>First Name</label>
                            <input style="display: none" name="userNameFirst"/>
                            <input type="text" class="form-control wid-150" name="ruName1"
                           value="${fn:split(userInfo.userBo.userNameFirst,',')[0]}">
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="form-inline">
                    <div class="form-group">
                        <label>Middle Name</label>
                        <input type="text" class="form-control wid-150" name="ruName2"
                           value="${fn:split(userInfo.userBo.userNameFirst,',')[1]}">
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="form-inline">
                    <div class="form-group">
                        <label>Last Name</label>
                        <input type="text" class="form-control wid-150" name="ruName3"
                           value="${fn:split(userInfo.userBo.userNameFirst,',')[2]}">
                    </div>
                </div>
            </div>
        </div>
</div>
<div class="formtable-list">
        <label class="col-sm-2 formtable-list-require">头像：</label>

        <div class="col-sm-7 col-md-8 label-cont">
            <div class="col-xs-5 col-sm-3 col-sm-2">
                <c:if test="${empty userInfo.userBo.personHeadPhoto}">
                    <img src="${ctx}/resources/images/bn.jpg" class="img-responsive"/>
                </c:if>
                <c:if test="${!empty userInfo.userBo.personHeadPhoto}">
                    <img src="${userInfo.userBo.personHeadPhoto}" class="img-responsive"/>
                </c:if>
                <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0">
                <input type="hidden" name="personHeadPhoto">
            </div>
        </div>

</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4">生日：</label>

        <div class="col-sm-7 col-md-8">
            <div class="input-group datepicker date mar_l5">
                <input name="birthday" type="text" class="form-control" readonly style="margin: 0px;"
                       value="<fmt:formatDate value='${userInfo.userBo.birthday}' pattern="yyyy-MM-dd"/>"/>
                <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
            </div>
        </div>
    </div>
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4">性别：</label>

        <div class="col-sm-7 col-md-8 label-cont">
            <input type="radio" name="sex" value="1" <c:if test="${userInfo.userBo.sex==1}">checked</c:if>/>
            男
            <input type="radio" name="sex" value="2" <c:if test="${userInfo.userBo.sex==2}">checked</c:if>/>
            女
        </div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4 formtable-list-require">手机（登录名）：</label>

        <div class="col-sm-7 col-md-8">
            <input type="text" class="form-control" name="mobile" value="${userInfo.userBo.mobile}">
            <input type="hidden" class="form-control"value="${userInfo.userBo.mobile}">
        </div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4">邮箱：</label>

        <div class="col-sm-7 col-md-8">
            <input type="text" class="form-control" name="email" value="${userInfo.userBo.email}">
        </div>
    </div>
</div>
<div class="formtable-list">
        <label class="col-sm-2">居住地址：</label>

        <div class="col-sm-10">
            <div class="form-inline">
                <div class="form-group">
                    <input type="hidden" value="${userInfo.userBo.provId}"/>
                    <select class="form-control" id="provinceId" name="provId">
                        <option value="">--省份--</option>
                        <c:forEach items="${userInfo.provinceBoList}" var="pro">
                            <option value="${pro.id}"
                                    <c:if test="${pro.id==userInfo.userBo.provId}">selected="selected"</c:if>>${pro.cnname}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <select class="form-control" id="cityId" name="cityId">
                        <option value="">--市/地区--</option>
                        <option value="${userInfo.userBo.cityId}"
                              <c:if test="${!empty userInfo.userBo.cityNameCn}"> selected="selected" </c:if>>${userInfo.userBo.cityNameCn}</option>
                    </select>
                </div>
                <div class="form-group">
                    <select class="form-control" id="districtId" name="distId">
                        <option value="">--区/县--</option>
                        <option value="${userInfo.userBo.distId}"
                        <c:if test="${!empty userInfo.userBo.cityNameCn}"> selected="selected" </c:if>>${userInfo.userBo.districtNameCn}</option>
                    </select>
                </div>
                <input type="text" name="address" class="form-control" placeholder="请输入详细地址" value="${userInfo.userBo.address}">
            </div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4">身份证号：</label>

        <div class="col-sm-7 col-md-8">
            <input type="text" class="form-control" name="idcard" value="${userInfo.userBo.idcard}">
        </div>
    </div>
</div>
<div class="formtable-list">
        <label class="col-sm-2">身份证：</label>

        <div class="col-sm-10">
            <div class="col-sm-4">
                <div class="inden-pic">
                    <p>身份证正面</p>

                    <div class="reload-pic">
                        <c:if test="${!empty userInfo.userBo.idcardPathFront}">
                            <img type="upload" src="${userInfo.userBo.idcardPathFront}"
                                 class="img-responsive" alt="">
                        </c:if>
                        <c:if test="${empty userInfo.userBo.idcardPathFront}">
                            <img type="upload" src="${ctx}/resources/images/bn.jpg" class="img-responsive" alt="">
                        </c:if>
                        <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0">
                        <input type="hidden" name="idcardPathFront" class="btn-uploadpic mar_t10">
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="inden-pic">
                    <p>身份证反面</p>

                    <div class="reload-pic">
                        <c:if test="${!empty userInfo.userBo.idcardPathBack}">
                            <img type="upload" src="${userInfo.userBo.idcardPathBack}" class="img-responsive"
                                 alt="">
                        </c:if>
                        <c:if test="${empty userInfo.userBo.idcardPathBack}">
                            <img type="upload" src="${ctx}/resources/images/bn.jpg" class="img-responsive" alt="">
                        </c:if>
                        <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0">
                        <input type="hidden" name="idcardPathBack" class="btn-uploadpic mar_t10">


                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="inden-pic">
                    <p>本人手持身份证合影</p>

                    <div class="reload-pic">
                        <c:if test="${!empty userInfo.userBo.idcardPathUser}">
                            <img src="${userInfo.userBo.idcardPathUser}" class="img-responsive" alt="">
                        </c:if>
                        <c:if test="${empty userInfo.userBo.idcardPathUser}">
                            <img src="${ctx}/resources/images/bn.jpg" class="img-responsive" alt="">
                        </c:if>
                        <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0">
                        <input type="hidden" name="idcardPathUser" class="btn-uploadpic mar_t10">

                    </div>
                </div>
            </div>
            <div class="col-sm-12 pad_10">
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
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4">服务执行部门：</label>

        <div class="col-sm-4 col-md-3">
            <select class="form-control" name="deptId">
                <option value="">无</option>
                <c:forEach items="${userInfo.departmentList}" var="deprt">
                    <option
                            <c:if test="${deprt.id==userInfo.userBo.deptId}">selected </c:if>
                            value="${deprt.id}">${deprt.deptName}</option>
                </c:forEach>
            </select>
        </div>
    </div>
</div>

</form>

<form class="formtable-cont" action="${ctx}/personalMbr/changMbrPwd" method="post" id="changeMbrPwdFormSrv">
    <h4 class="header header-fl" id="password">修改密码</h4>
    <input type="submit"  class="btn btn-primary header-button" value="保存"/>

    <div class="clear"></div>
    <input type="hidden" value="${userInfo.userBo.userId}" name="userId"/>
    <div class="formtable-list">
        <label class="col-sm-2 formtable-list-require">新密码：</label>

        <div class="col-sm-10">
            <div class="col-xs-6 col-sm-4">
                <input type="password" class="form-control" placeholder="请输入6~20位数字、字母或字符" name="newPassword" id="repeatPwdSrv">
            </div>

        </div>
    </div>
    <div class="formtable-list">
        <label class="col-sm-2 formtable-list-require">再次输入新密码：</label>

        <div class="col-sm-10">
            <div class="col-xs-6 col-sm-4">
                <input type="password" class="form-control" placeholder="请再次输入密码" name="repeatPwd" >
            </div>

        </div>
    </div>
</form>
</div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/empMgr/edit.js"></script>

</body>
</html>