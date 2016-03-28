<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>会员中西-信息编辑</title>
    <%@include file="/WEB-INF/common/global/common.jsp" %>
    <link rel="stylesheet" href="${ctx}/resources/js/uploadCrop/cropper.min.css">
</head>
<body>
<div class="container-fluid">
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">会员中心</a>
    </li>
    <li>
        <a href="${ctx}/personalMbr/list">个人会员管理</a>
    </li>
    <li>
        <a href="${ctx}/personalMbr/edit?userId=${personalMbrView.userBo.userId}">个人会员编辑</a>
    </li>
</nav>
<div class="formtable" id="userInfoSaveForm">


<div class="formtable-nav">
    <ul class="list-inline">
        <li><a href="#baseInfo" class="btn btn-primary">基本信息</a></li>
        <li><a href="#password" class="btn btn-primary">修改密码</a></li>
        <li class="pull-right">
            <c:if test="${personalMbrView.userBo.accountState==1}">
                <a  href="${ctx}/personalMbr/changeMbrStatus?userId=${personalMbrView.userBo.userId}&accountState=2" onclick="return confirm('确定要停用该用户吗？')" class="btn btn-danger">停用</a>
            </c:if>
            <c:if test="${personalMbrView.userBo.accountState!=1}">
                <a  href="${ctx}/personalMbr/changeMbrStatus?userId=${personalMbrView.userBo.userId}&accountState=1" class="btn btn-success" onclick="return confirm('确定要启用该用户吗？')">启用</a>
            </c:if>
            <a href="${ctx}/personalMbr/info?userId=${personalMbrView.userBo.userId}" class="btn btn-default">返回</a>
        </li>
    </ul>
</div>
<form class="formtable-cont" action="${ctx}/personalMbr/saveUser" method="post" id="personalMbrForm">
<h4 class="header header-fl" id="baseInfo">基本信息</h4>
<button  class="btn btn-primary header-button">保存</button>
<input type="hidden" name="userId" value="${personalMbrView.userBo.userId}"/>
<input type="hidden" name="regSource" value="${personalMbrView.userBo.regSource}"/>

<div class="clear"></div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4 formtable-list-require">注册平台：</label>

        <div class="col-sm-7 col-md-8 label-cont">
            <c:if test="${personalMbrView.userBo.regSource==5}">俄站</c:if>
            <c:if test="${personalMbrView.userBo.regSource==3}">中站</c:if>
            <c:if test="${personalMbrView.userBo.regSource==2}">运营平台</c:if>
            <span class="hidden"><input name="regSource" value="${personalMbrView.userBo.regSource}" type="checkbox" checked="checked"/></span>
        </div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4 formtable-list-require">关系：</label>
        <input type="hidden" value="${personalMbrView.userBo.regSource}" name="regSource"/>
        <div class="col-sm-7 col-md-8">
            <input type="hidden" name="entUserStatus" value="${personalMbrView.userBo.entUserStatus}"/>
            <label class="radio-inline">
                <input type="radio" value="1" name="entUserStatus" disabled
                       <c:if test="${personalMbrView.userBo.entUserStatus==1}">checked="checked" </c:if>> 隶属
            </label>
            <label class="radio-inline">
                <input type="radio" value="2" name="entUserStatus" disabled
                       <c:if test="${personalMbrView.userBo.entUserStatus==2}">checked="checked" </c:if>> 个人
            </label>
            <%--如果是隶属 待审批状态 显示 审核按钮--%>
            <c:if test="${personalMbrView.userBo.userType ==1}">
                    <button type="button" id="relateCheckOk" class="btn btn-primary mar_l5">审批通过</button>
                    <button type="button" id="relateCheckRefuse" class="btn btn-primary mar_l5">拒绝</button>
            </c:if>
        </div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4 formtable-list-require">姓名（中文）：</label>

        <div class="col-sm-7 col-md-8">
            <input type="text" class="form-control" name="userNameCn" value="${personalMbrView.userBo.userNameCn}">
        </div>
    </div>
</div>
        <span id="noneOrSingleHide">
            <div class="formtable-list"  <c:if test="${personalMbrView.userBo.entUserStatus!=1}">style="display: none"</c:if>>

                    <label class="col-sm-2 formtable-list-require">所属公司：</label>

                    <div class="col-sm-10">
                        <div class="form-inline">
                            <div class="form-group">
                                <input type="text" class="form-control" name="orgName"  id="searchOrg" value="${personalMbrView.userBo.orgName}" <c:if test="${personalMbrView.userBo.entUserStatus==1}">disabled="disabled" </c:if>>
                                <input type="text" name="orgId" id="dealingsOrgId" hidden="hidden" value="${personalMbrView.userBo.orgId}">
                            </div>
                            <%--如果该员工关系 为隶属 且公司Id 不为null  显示退出按钮--%>
                            <c:if test="${personalMbrView.userBo.entUserStatus==1}">
                                <a href="${ctx}/personalMbr/free?orgId=${personalMbrView.userBo.orgId}&userId=${personalMbrView.userBo.userId}&reSource=${personalMbrView.userBo.regSource}" onclick="return confirm('确定要退出该公司?退出该公司该用户将会被删除！')" class="btn btn-primary">退出所属公司</a>
                            </c:if>
                        </div>
                    </div>
            </div>
            <%--企业为代理商、服务商时显示--%>
            <div class="formtable-list" <c:if test="${!personalMbrView.proxyOrPurchase}">style="display: none"</c:if>>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4">服务执行部门：</label>

                    <div class="col-sm-7 col-md-8">
                        <select class="form-control" id="ownerDepart" name="deptId"  <c:if test="${!personalMbrView.proxyOrPurchase}">disabled="disabled" </c:if>>
                            <option value="">无</option>
                            <c:forEach items="${personalMbrView.departmentList}" var="deprt">
                                <option <c:if test="${deprt.id==personalMbrView.userBo.deptId}">selected </c:if> value="${deprt.id}">${deprt.deptName}</option>
                            </c:forEach>
                        </select>


                    </div>
                </div>
            </div>

            <div class="formtable-list"
                 <c:if test="${personalMbrView.userBo.entUserStatus!=1}">style="display: none"</c:if>>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4">企业管理员：</label>

                    <div class="col-sm-7 col-md-8">
                        <label class="radio-inline">
                            <input type="radio"  name="isRoot" <c:if test="${personalMbrView.userBo.isRoot==1}">checked="checked" </c:if> value="1"> 是
                        </label>
                        <label class="radio-inline">
                            <input type="radio"  name="isRoot" value="0" <c:if test="${personalMbrView.userBo.isRoot==0}">checked="checked" </c:if>   > 否
                        </label>
                    </div>
                </div>
            </div>

        </span>

<div class="formtable-list">
    <div class="col-xs-12">
        <label class="col-sm-2">姓名（俄/英）：</label>
        <div class="col-sm-10">
            <div class="col-sm-4">
                <div class="form-inline">
                    <div class="form-group">
                        <label>First Name</label>
                        <input style="display: none" name="userNameFirst"/>
                        <input type="text" class="form-control wid-150" name="ruName1"
                           value="${fn:split(personalMbrView.userBo.userNameFirst,',')[0]}">
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="form-inline">
                    <div class="form-group">
                        <label>Middle Name</label>
                        <input type="text" class="form-control wid-150" name="ruName2"
                           value="${fn:split(personalMbrView.userBo.userNameFirst,',')[1]}">
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="form-inline">
                    <div class="form-group">
                        <label>Last Name</label>
                        <input type="text" class="form-control wid-150" name="ruName3"
                           value="${fn:split(personalMbrView.userBo.userNameFirst,',')[2]}">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-12 pad_10">
        <label class="col-sm-2">头像：</label>

        <div class="col-sm-7 col-md-8">
            <div class="col-xs-5 col-sm-3 col-sm-2">
             <%--   <c:if test="${empty personalMbrView.userBo.personHeadPhoto}">
                    <img src="${ctx}/resources/images/bn.jpg" class="img-responsive"/>
                </c:if>
                <c:if test="${!empty personalMbrView.userBo.personHeadPhoto}">
                    <img src="${personalMbrView.userBo.personHeadPhoto}" class="img-responsive"/>
                </c:if>
                <input type="file" style="display: none">
                <input type="hidden" name="personHeadPhoto">--%>

                 <div class="imgCropBox" id="imgCropBox" style="height: 200px;width: 200px;">
                     <c:if test="${empty personalMbrView.userBo.personHeadPhoto}">
                         <img src="${ctx}/resources/images/bn.jpg" alt="" class="imgCropBtn" id="imgCropBtn" data-width="300" data-height="300">
                     </c:if>
                     <c:if test="${!empty personalMbrView.userBo.personHeadPhoto}">
                         <img src="<odpf:GetImgTag imgUrl='${personalMbrView.userBo.personHeadPhoto}' width='200' height='200'></odpf:GetImgTag>" alt="" class="imgCropBtn" id="imgCropBtn" data-width="300" data-height="300">
                     </c:if>
                     <input type="text" name="personHeadPhoto" id="personHeadPhoto" class="hide imgCropInput"/>
                 </div>

            </div>
        </div>

    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4">生日：</label>

        <div class="col-sm-7 col-md-8">
            <div class="input-group datepicker date mar_l5">
                <input name="birthday" type="text" class="form-control" style="margin: 0px;"
                       value="<fmt:formatDate value='${personalMbrView.userBo.birthday}' pattern="yyyy-MM-dd"/>"/>
                <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
            </div>
        </div>
    </div>
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4">性别：</label>

        <div class="col-sm-7 col-md-8 label-cont">
            <input type="radio" name="sex" value="1" <c:if test="${personalMbrView.userBo.sex==1}">checked</c:if>/> 男
            <input type="radio" name="sex" value="2" <c:if test="${personalMbrView.userBo.sex==2}">checked</c:if>/> 女
        </div>
    </div>
</div>

<div class="formtable-list">
    <label class="col-sm-2">电话：</label>
    <div class="col-sm-10">
        <div class="form-inline">
            <div class="form-group">
                <input type="text" class="form-control" placeholder="国家" name="telCountry" value="${personalMbrView.userBo.telCountry}">
            </div>
            --
            <div class="form-group">
                <input type="text" class="form-control" placeholder="区号" name="telZone" value="${personalMbrView.userBo.telZone}">
            </div>
            --
            <div class="form-group">
                <input type="text" class="form-control" placeholder="电话号码" name="tel" value="${personalMbrView.userBo.tel}">
            </div>
            --
            <div class="form-group">
                <input type="text" class="form-control" placeholder="分机" name="telExt" value="${personalMbrView.userBo.telExt}">
            </div>
        </div>
    </div>
</div>
<div class="formtable-list">
    <label class="col-sm-2">传真：</label>
    <div class="col-sm-10">
        <div class="form-inline">
            <div class="form-group">
                <input type="text" class="form-control" name="faxCountry" placeholder="国家" value="${personalMbrView.userBo.faxCountry}">
            </div>
            --
            <div class="form-group">
                <input type="text" class="form-control" name="faxZone" placeholder="区号" value="${personalMbrView.userBo.faxZone}">
            </div>
            --
            <div class="form-group">
                <input type="text" class="form-control" name="fax" placeholder="电话号码" value="${personalMbrView.userBo.fax}">
            </div>
            --
            <div class="form-group">
                <input type="text" class="form-control" name="faxExt" placeholder="分机" value="${personalMbrView.userBo.faxExt}">
            </div>
        </div>
    </div>
</div>


<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4 formtable-list-require">手机（登录名）：</label>

        <div class="col-sm-7 col-md-8">
            <input type="text" class="form-control" name="mobile" value="${personalMbrView.userBo.mobile}">
            <input type="hidden" class="form-control"value="${personalMbrView.userBo.mobile}">
        </div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4">邮箱：</label>

        <div class="col-sm-7 col-md-8">
            <input type="text" class="form-control" name="email" value="${personalMbrView.userBo.email}">
            <input type="hidden" class="form-control" name="emailOrginal" value="${personalMbrView.userBo.email}">
        </div>
    </div>
</div>
<div class="formtable-list">
        <label class="col-sm-2">居住地址：</label>
        <div class="col-sm-10">
            <div class="form-inline">
                <div class="form-group">
                    <select class="form-control" id="countryId" name="countryId" >
                        <option value="">--国家--</option>
                        <c:forEach items="${personalMbrView.countryList}" var="ctr">
                            <option value="${ctr.constValue}"
                                    <c:if test="${ctr.constValue==personalMbrView.userBo.countryId}">selected="selected" </c:if>>${ctr.constName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <select class="form-control" id="provinceId" name="provId" >
                        <option value="">--省份--</option>
                        <c:forEach items="${personalMbrView.provinceBoList}" var="pro">
                            <option value="${pro.id}"
                                    <c:if test="${pro.id==personalMbrView.userBo.provId}">selected="selected"</c:if>>${pro.cnname}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <select class="form-control" id="cityId" name="cityId">
                        <option value="">--市/地区--</option>
                        <option value="${personalMbrView.userBo.cityId}"
                              <c:if test="${!empty personalMbrView.userBo.cityNameCn}">  selected="selected" </c:if> >${personalMbrView.userBo.cityNameCn}</option>
                    </select>
                </div>
                <div class="form-group">
                    <select class="form-control" id="districtId" name="distId">
                        <option value="">--区/县--</option>
                        <option value="${personalMbrView.userBo.distId}"
                        <c:if test="${!empty personalMbrView.userBo.districtNameCn}">selected="selected" </c:if>>${personalMbrView.userBo.districtNameCn}</option>
                    </select>
                </div>
                <input type="text" class="form-control" name="address" placeholder="请输入详细地址" value="${personalMbrView.userBo.address}">
            </div>
        </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4">身份证号：</label>

        <div class="col-sm-7 col-md-8">
            <input type="text" class="form-control" name="idcard" value="${personalMbrView.userBo.idcard}">
        </div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-12">
        <label class="col-sm-2">身份证：</label>

        <div class="col-sm-10">
            <div class="col-sm-4">
                <div class="inden-pic">
                    <p>身份证正面</p>

                   <%-- <div class="reload-pic">
                        <c:if test="${!empty personalMbrView.userBo.idcardPathFront}">
                            <img type="upload" src="${personalMbrView.userBo.idcardPathFront}" class="img-responsive"
                                 alt="">
                        </c:if>
                        <c:if test="${empty personalMbrView.userBo.idcardPathFront}">
                            <img type="upload" src="${ctx}/resources/images/bn.jpg" class="img-responsive" alt="">
                        </c:if>
                        <input type="file" style="display: none">
                        <input type="hidden" name="idcardPathFront" class="btn-uploadpic mar_t10">
                    </div>--%>

                    <div class="uploadModal" style="width: 180px;height: 114px;">
                        <span class="uploadBtn"></span>

                        <div class="progress progress-striped active" style="display:none;">
                            <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="45"
                                 aria-valuemin="0" aria-valuemax="100" style="width: 0%"></div>
                        </div>
                        <div class="showModal">
                            <div class="addBtn"></div>
                        </div>
                        <img src="<c:if test="${empty  personalMbrView.userBo.idcardPathFront}">${ctx}/resources/images/bn.jpg</c:if>
                             <c:if test="${not empty  personalMbrView.userBo.idcardPathFront}">${personalMbrView.userBo.idcardPathFront}</c:if>"
                             alt="" class="img-responsive"/>
                        <input type="text" value="${personalMbrView.userBo.idcardPathFront}" name="idcardPathFront"
                               class=" inputVal hide"
                               id="idcardPathFront"/>
                    </div>


                </div>
            </div>
            <div class="col-sm-4">
                <div class="inden-pic">
                    <p>身份证反面</p>

                  <%--  <div class="reload-pic">
                        <c:if test="${!empty personalMbrView.userBo.idcardPathBack}">
                            <img type="upload" src="${personalMbrView.userBo.idcardPathBack}" class="img-responsive"
                                 alt="">
                        </c:if>
                        <c:if test="${empty personalMbrView.userBo.idcardPathBack}">
                            <img type="upload" src="${ctx}/resources/images/bn.jpg" class="img-responsive" alt="">
                        </c:if>
                        <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0">
                        <input type="hidden" name="idcardPathBack" class="btn-uploadpic mar_t10">


                    </div>--%>

                    <div class="uploadModal" style="width: 180px;height: 114px;">
                        <span class="uploadBtn"></span>

                        <div class="progress progress-striped active" style="display:none;">
                            <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="45"
                                 aria-valuemin="0" aria-valuemax="100" style="width: 0%"></div>
                        </div>
                        <div class="showModal">
                            <div class="addBtn"></div>
                        </div>
                        <img src="<c:if test="${empty  personalMbrView.userBo.idcardPathBack}">${ctx}/resources/images/bn.jpg</c:if>
                               <c:if test="${not empty  personalMbrView.userBo.idcardPathBack}">${personalMbrView.userBo.idcardPathBack}</c:if>" alt=""
                             class="img-responsive"/>
                        <input type="text" value="${personalMbrView.userBo.idcardPathBack}" name="idcardPathBack" class=" inputVal hide"
                               id="idcardPathBack"/>
                    </div>

                </div>
            </div>
            <div class="col-sm-4">
                <div class="inden-pic">
                    <p>本人手持身份证合影</p>

                   <%-- <div class="reload-pic">
                        <c:if test="${!empty personalMbrView.userBo.idcardPathUser}">
                            <img src="${personalMbrView.userBo.idcardPathUser}" class="img-responsive" alt="">
                        </c:if>
                        <c:if test="${empty personalMbrView.userBo.idcardPathUser}">
                            <img src="${ctx}/resources/images/bn.jpg" class="img-responsive" alt="">
                        </c:if>
                        <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0">
                        <input type="hidden" name="idcardPathUser" class="btn-uploadpic mar_t10">

                    </div>--%>

                    <div class="uploadModal" style="width: 180px;height: 114px;" >
                        <span class="uploadBtn" ></span>
                        <div  class="progress progress-striped active" style="display:none;">
                            <div  class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%"></div>
                        </div>
                        <div class="showModal">
                            <div class="addBtn"></div>
                        </div>
                        <img  src="<c:if test="${empty  personalMbrView.userBo.idcardPathUser}">${ctx}/resources/images/bn.jpg</c:if>
                             <c:if test="${not empty  personalMbrView.userBo.idcardPathUser}">${personalMbrView.userBo.idcardPathUser}</c:if>"
                              alt="" class="img-responsive" />
                        <input type="text" value="${personalMbrView.userBo.idcardPathUser}" name="idcardPathUser" class=" inputVal hide"
                               id="idcardPathUser"/>
                    </div>

                </div>
            </div>
            <div class="col-sm-12 pad_10">
                <c:if test="${personalMbrView.userBo.statusType==1}"> <span
                        class="icon icon-wait"></span> 初审</c:if>
                <c:if test="${personalMbrView.userBo.statusType==2}"> <span
                        class="icon icon-right"></span> 审核通过</c:if>
                <c:if test="${personalMbrView.userBo.statusType==3}"> <span
                        class="icon icon-wait"></span>待审核</c:if>
                <c:if test="${personalMbrView.userBo.statusType==4}"> <span
                        class="icon icon-close"></span> 审核拒绝</c:if>
            </div>
        </div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4">护照号：</label>

        <div class="col-sm-7 col-md-8">
            <input class="form-control" name="passport" value="${personalMbrView.userBo.passport}"/>
        </div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4">从业起始时间：</label>

        <div class="col-sm-7 col-md-8">
            <div class="input-group datepicker date mar_l5">
                <input name="workingTime" type="text" class="form-control"  style="margin: 0px;"
                       value="<fmt:formatDate value='${personalMbrView.userBo.workingTime}' pattern="yyyy-MM-dd"/>"/>
                <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
            </div>
        </div>
    </div>
</div>
</form>

<form class="formtable-cont" action="${ctx}/personalMbr/changMbrPwd" method="post" id="changeMbrPwdForm">
    <h4 class="header header-fl" id="password">修改密码</h4>
    <input type="submit"  class="btn btn-primary header-button" value="保存"/>

    <div class="clear"></div>
    <input type="hidden" value="${personalMbrView.userBo.userId}" name="userId"/>
    <div class="formtable-list">
        <label class="col-sm-2 formtable-list-require">新密码：</label>

        <div class="col-sm-10">
            <div class="col-xs-6 col-sm-4">
                <input type="password" class="form-control" name="newPassword" id="repeatPwd">
            </div>
        </div>
    </div>
    <div class="formtable-list">
        <label class="col-sm-2 formtable-list-require">再次输入新密码：</label>

        <div class="col-sm-10">
            <div class="col-xs-6 col-sm-4">
                <input type="password" class="form-control" name="repeatPwd" >
            </div>

        </div>
    </div>
</form>
</div>
</div>
<form action="${ctx}/cmpMbr/checkRelate" method="post" class="hidden" id="checkRelateForm">
        <input name="regSource" type="hidden" value="${personalMbrView.userBo.regSource}"/>
        <input name="orgId" type="hidden" value="${personalMbrView.userBo.orgId}"/>
        <input name="userId" type="hidden" value="${personalMbrView.userBo.userId}"/>
        <input name="actionCode" type="hidden" value="2"/>
</form>

<!--imgCropModal-->
<div class="modal fade imgCropModal" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">图片裁剪</h4>
            </div>
            <div class="modal-body" id="uploader">
                <div class="row img-modal">
                    <div class="col-md-12 mar_b--10">
                        <button class="btn btn-primary">图片裁剪</button>
                    </div>
                    <div class="col-md-8 img-box">
                        <div class="img-box-file" id="imgUploadBtn">
                            <img src="${ctx}/resources/js/uploadCrop/img-upload.png" alt="">
                        </div>
                        <p class="img-box-text">生成预览图中，请稍候</p>

                        <div class="img-box-container">

                        </div>
                        <div class="img-box-set">
                            <div class="img-add pull-left" id="img-add">
                                <p><img src="${ctx}/resources/js/uploadCrop/img-add.png" alt="">重新上传</p>
                            </div>
                            <div class="img-crop-reset pull-left">
                                <p><img src="${ctx}/resources/js/uploadCrop/crop-reset.png" alt="">重置裁剪</p>
                            </div>
                            <div class="img-rotate pull-right">
                                <p><img src="${ctx}/resources/js/uploadCrop/img-rotate.png" alt="">90°旋转</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 ">
                        <h3 class="page-header img-preview-header hide">Preview</h3>

                        <div class="img-preview"></div>
                        <div class="progress progress-striped active" style="display:none;">
                            <div id="progressBar" class="progress-bar progress-bar-success" role="progressbar"
                                 aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary imgUploadFile" >上传</button>
                <button type="button" class="btn btn-primary imgUploadRetry" >重试</button>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script src="${ctx}/resources/js/uploadCrop/webuploader.min.js"></script>
<script src="${ctx}/resources/js/uploadCrop/cropper.min.js"></script>
<script src="${ctx}/resources/js/uploadCrop/imgCropBtn.js"></script>
<script src="${ctx}/resources/js/imageUpload/SimpleAjaxUploader.min.js"></script>
<script src="${ctx}/resources/js/imageUpload/imgUpLoad.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/personalMbr/edit.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>