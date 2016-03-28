<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/M-an.admin.css"/>
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/font/font-awesome.min.css"/>
    <link type="text/css" href="${ctx}/resources/css/index.css" rel="stylesheet" />
    <link type="text/css" href="${ctx}/resources/css/labelauty.css" rel="stylesheet" />
    <link type="text/css" rel="stylesheet" href="${ctx}/resources/css/jquery-ui.css"/>
    <title>企业会员管理</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 会员中心 <span class="c-gray en">&gt;</span> 个人会员管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a> <span class="c-gray en">&gt;</span><a href="#"><c:if test="${not empty userEntity.userId}">个人会员编辑</c:if><c:if test="${empty userEntity.userId}">新增个人会员</c:if></a></nav>
<div class="pd-20">
    <div id="message_position">
        <div id="position_fixed" class="cl pd-5 bg-1 bk-gray mt-20">
  <span>
  <span class="l">
  <a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_a_click">
       基本信息</a>
  <c:if test="${not empty userEntity.userId}">
  <a href="javascript:void(0)" name="_self" class="btn btn-primary radius public_a_click">
      修改密码</a>
  </c:if>
  </span>
  <c:if test="${not empty userEntity}">
  <span class="r">
      <a id="start" href="javascript:void(0)" target="_self" class="btn btn-primary radius" <c:if test="${userEntity.accountState == 1}">style="display:none"</c:if> > 启用</a> <a href="#"  id="forbidden" name="_self" class="btn btn-primary radius"<c:if test="${userEntity.accountState == 2}">style="display:none"</c:if>> 停用</a>
  </span>
  </c:if>
        </div>
    </div>
</div>
<form id="userDetail" method="post">
    <input type="hidden" id="userId" name="userId" value="${userEntity.userId}">
    <table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top">
        <thead>
        <tr class="text-l">
            <th width="106"><span class="l f-16">基本信息</span> <span class="r">
          <button class="btn btn-success radius" type="button" id="submitUser"><i class="icon-ok"></i> 保存</button>
        </span> </th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <table class="table table-border table-bordered table-bg table-sort">
        <tbody>
        <tr>
            <th class="text-r"><span class="c-red">*</span>注册来源</th>
            <td width="737">
                <c:if test="${not empty userEntity.userId}">
                    <c:choose>
                        <c:when test="${userEntity.regSource == 3 || userEntity.regSource == 6}">
                            中文
                        </c:when>
                        <c:when test="${userEntity.regSource == 5 || userEntity.regSource == 7}">
                            俄文
                        </c:when>
                        <c:when test="${userEntity.regSource == 2}">
                           运营平台
                        </c:when>
                    </c:choose>
                    <input type="hidden" id="regSource" name="regSource" value="${userEntity.regSource}"/>
                </c:if>
                <table border="0" cellspacing="0" cellpadding="0" id="news_in_center">
                    <c:if test="${empty userEntity.userId}">
                        <tr>
                            <div class="rdo">
                                <input type="radio" name="regSource" class="rdolist" checked="checked" value="3" />
                                <label class="rdobox" id="rdobox1">
                                    <span class="check-image"></span>
                                    <span class="radiobox-content">中文</span>
                                </label>
                                <input type="radio" name="regSource" class="rdolist" value="5" />
                                <label class="rdobox" id="rdobox2">
                                    <span class="check-image"></span>
                                    <span class="radiobox-content">俄文</span>
                                </label>
                                <input type="radio" name="regSource" class="rdolist" value="2"/>
                                <label class="rdobox" id="rdobox3">
                                    <span class="check-image"></span>
                                    <span class="radiobox-content">运营</span>
                                </label>
                            </div>
                        </tr>
                    </c:if>
                </table></td>
        </tr>
        <tr>
            <th width="190" class="text-r"><span class="c-red">*</span> 所属公司：</th>
            <td><input type="search" class="input-text" style="width:250px"<c:if test="${userEntity.regSource == 3 || userEntity.regSource == 6 || userEntity.regSource == 2}"> value="${userEntity.orgNameCn}" </c:if> <c:if test="${userEntity.regSource == 5 || userEntity.regSource == 7}"> value="${userEntity.orgNameRu}" </c:if> id="orgName" name="orgName">
                <input type="hidden"  style="width:200px" value="${userEntity.orgId}" id="orgId" name="orgId">
                &nbsp;
                <c:if test="${userEntity.entUserStatus != 1 && userEntity.entUserStatus != 2}">
                <a href="${ctx}/enterprise/add" class="btn btn-primary radius public_a_click">
                    <i class="icon-plus"></i> 创建公司</a>
                </c:if>
            </td>
        </tr>
        <tr>
            <th class="text-r"><span class="c-red">*</span>关系： </th>
            <td>
                <c:choose>
                    <c:when test="${userEntity.entUserStatus == 1}">
                        <label>
                            隶属
                        </label>
                        <input type="hidden" value="${userEntity.entUserStatus}" name="entUserStatus"/>
                    </c:when>
                    <c:when test="${userEntity.entUserStatus == 2}">
                        <label>
                           挂靠
                        </label>
                        <input type="hidden" value="${userEntity.entUserStatus}" name="entUserStatus"/>
                    </c:when>
                    <c:otherwise>
                        <label>
                            <input name="entUserStatus" type="radio" id="entUserStatus1" value="1" <c:if test="${userEntity.entUserStatus == 1}">checked</c:if>>
                            隶属
                        </label>
                        <label>
                            <input type="radio" name="entUserStatus" value="2" id="entUserStatus2" <c:if test="${userEntity.entUserStatus ==2 } ">checked</c:if>>
                            挂靠
                        </label>
                        <label id="noOrglabel">
                            <input type="radio" name="entUserStatus" value="0" id="entUserStatus3" <c:if test="${userEntity.entUserStatus ==0}">checked</c:if>>
                            无企业信息
                        </label>
                    </c:otherwise>
                </c:choose>
                    <c:if test="${userEntity.userType == 2 && userEntity.entUserStatus == 1}">
                        <button type="button" value="5" id="quitOrg">退出所选公司</button>
                    </c:if>
                    <c:if test="${userEntity.userType == 2 && userEntity.entUserStatus == 2}">
                        <button type="button" value="7"  id="quitAnchored">申请解除挂靠</button>
                    </c:if>
                    <c:if test="${userEntity.userType == 3 && userEntity.entUserStatus == 2}">
                        申请解除挂靠
                        <button type="button" value="1" data_type="7"  class="user_adult">同意</button>
                        <button type="button" value="2" data_type="7"  class="user_adult">拒绝</button>
                    </c:if>
                    <c:if test="${userEntity.userType == 1 && userEntity.entUserStatus == 2}">
                        申请加入挂靠
                        <button type="button" value="1"  data_type="4"  class="user_adult">同意</button>
                        <button type="button" value="2"  data_type="4" class="user_adult">拒绝</button>
                    </c:if>
                    <c:if test="${userEntity.userType == 1 && userEntity.entUserStatus == 1}">
                        申请加入公司
                        <button type="button" value="1"  data_type="6" class="user_adult">同意</button>
                        <button type="button" value="2"  data_type="6" class="user_adult">拒绝</button>
                    </c:if>
                <input type="hidden" name="userType" value="${userEntity.userType}"/>
            </td>

        </tr>
        <tr>
            <th width="190" class="text-r" id="nth"><c:if test="${userEntity.regSource ==3 || userEntity.regSource ==2}"><span class="c-red"  id="nid">*</span></c:if>姓名（中文）：</th>
            <td><input type="text" style="width:200px" class="input-text" value="${userEntity.userNameCn}" placeholder="" id="userNameCn" name="userNameCn" datatype="*2-16" nullmsg="用户名不能为空"></td>
        </tr>
        <tr>
            <th width="190" class="text-r"><c:if test="${userEntity.regSource == 5}"><span class="c-red"  id="nid">*</span></c:if> First Name</th>
            <td><input type="text" style="width:200px" class="input-text" value="${userEntity.userNameFirst}" placeholder="" id="userNameFirst" name="userNameFirst" datatype="*2-16" nullmsg="用户名不能为空"></td>
        </tr>
        <tr>
            <th width="190" class="text-r"><c:if test="${userEntity.regSource == 5}"><span class="c-red"  id="nid">*</span></c:if> Last Name</th>
            <td><input type="text" style="width:200px" class="input-text" value="${userEntity.userNameLast}" placeholder="" id="userNameLast" name="userNameLast" datatype="*2-16" nullmsg="用户名不能为空"></td>
        </tr>
        <tr>
            <th class="text-r">生日：</th>
            <td><input class="Wdate" value="<odpf:formatDate style="DATE" date="${userEntity.birthday}"/>" type="text" id="birthday" name="birthday" onFocus="WdatePicker({isShowClear:false,readOnly:true})"/></td>
        </tr>
        <tr>
            <th class="text-r">性别：</th>
            <td><label>
                <input name="sex" type="radio" id="six_1" value="1" <c:if test="${userEntity.sex ==1}">checked</c:if>>
                男</label>
                <label>
                    <input type="radio" name="sex" value="2" id="six_0" <c:if test="${userEntity.sex ==2}">checked</c:if>>
                    女</label></td>
        </tr>
        <tr>
            <th class="text-r"> 电话：</th>
            <td><input type="text" style="width:50px" class="input-text" value="${userEntity.telCountry}" placeholder="" id="tel" name="telCountry">
                -
                <input type="text" style="width:50px" class="input-text" value="${userEntity.telZone}" placeholder="" id="tel2" name="telZone" >
                -
                <input type="text" style="width:150px" class="input-text" value="${userEntity.tel}" placeholder="" id="tel4" name="tel">
                -
                <input type="text" style="width:50px" class="input-text" value="${userEntity.telExt}" placeholder="" id="tel5" name="telExt">
            </td>
        </tr>
        <tr>
            <th class="text-r">传真：</th>
            <td><input type="text" style="width:50px" class="input-text" value="${userEntity.faxCountry}" placeholder="" id="Fax" name="faxCountry">
                -
                <input type="text" style="width:50px" class="input-text" value="${userEntity.faxZone}" placeholder="" id="Fax1" name="faxZone">
                -
                <input type="text" style="width:150px" class="input-text" value="${userEntity.fax}" placeholder="" id="Fax2" name="fax">
                -
                <input type="text" style="width:50px" class="input-text" value="${userEntity.faxExt}" placeholder="" id="Fax3" name="faxExt"></td>
        </tr>

        <tr>
            <th class="text-r" id="mth"><c:if test="${userEntity.regSource == 3 || userEntity.regSource == 2 || userEntity.regSource == null}"><span class="c-red" id="mid">*</span></c:if> 手机</th>
            <td><input type="text" style="width:300px" class="input-text" value="${userEntity.mobile}" placeholder="" id="mobile" name="mobile" onblur="checkUsername()">
                <input type="hidden" id="oldMobile" value="${userEntity.mobile}">
                <input type="hidden" name="mobileStatus" value="0" id="mobileStatus"/>
                <a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_examine" id="sendCode">发送验证短信</a><span>
          <input type="text" style="width:100px" class="input-text" value="请输入验证码" placeholder="" id="code" >
          <a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_examine" id="validateCode">验证</a></span><span id="span"></span></td>
        </tr>
        <tr>
            <th class="text-r" id="you"> <c:if test="${userEntity.regSource == 5 || userEntity.regSource == 7}"><span class="c-red">*</span></c:if> 邮箱：</th>
            <td><input type="text" style="width:300px" class="input-text" value="${userEntity.email}" placeholder="" id="email" name="email" onblur="checkUsernameByEmail()">
                <input type="hidden" id="oldEmail" value="${userEntity.email}"/>
                <%--<a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_examine">发送验证邮件</a> <span>验证邮件已发送，请打开您的邮箱并点击验证链接。<a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_examine">重发送验证邮件</a></span> <span><img src="images/icon_right_s.png" width="18" height="20">已验证</span> <span><img src="images/icon_right_s2.jpg" width="18" height="17">验证失败</span></td>--%>
        </tr>
        <c:if test="${empty userEntity.userId }">
            <tr>
                <th class="text-r"><span class="c-red" >*</span>密码：</th>
                <td><input id="password" type="password" style="width:300px" class="input-text" value="" placeholder=""  name="password">
                        <%--<a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_examine">发送验证邮件</a> <span>验证邮件已发送，请打开您的邮箱并点击验证链接。<a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_examine">重发送验证邮件</a></span> <span><img src="images/icon_right_s.png" width="18" height="20">已验证</span> <span><img src="images/icon_right_s2.jpg" width="18" height="17">验证失败</span></td>--%>
            </tr><tr>
            <th class="text-r"><span class="c-red">*</span>再次输入密码：</th>
            <td><input id="password2" type="password" style="width:300px" class="input-text" value="" placeholder="">
                    <%--<a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_examine">发送验证邮件</a> <span>验证邮件已发送，请打开您的邮箱并点击验证链接。<a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_examine">重发送验证邮件</a></span> <span><img src="images/icon_right_s.png" width="18" height="20">已验证</span> <span><img src="images/icon_right_s2.jpg" width="18" height="17">验证失败</span></td>--%>
        </tr>

        </c:if>
        <tr>
            <th class="text-r">居住地址：</th>
            <td>
                <select class="select" name="countryId" size="1" style="width:300px" id="countrySelect">
                    <option value="1" <c:if test="${userEntity.countryId==1}">selected</c:if>>中国</option>
                    <option value="2" <c:if test="${userEntity.countryId==2}">selected</c:if>>俄罗斯</option>
                </select>
                <select class="select" name="provId" size="1" style="width:300px" id="provSelect">
                    <option value="">---请选择省---</option>
                    <c:forEach items="${provList}" var="prov">
                        <option value="${prov.id}" <c:if test="${userEntity.provId==prov.id}">selected</c:if> >
                                ${prov.cnname}(${prov.enname})</option>
                    </c:forEach>
                </select>
                <select class="select" name="cityId" size="1" style="width:300px" id="citySelect">
                    <option value="">---请选择市---</option>
                    <c:forEach items="${cityList}" var="city">
                        <option value="${city.id}" <c:if test="${userEntity.cityId==city.id}">selected</c:if> >
                                ${city.cnname}( ${city.enname})</option>
                    </c:forEach>
                </select>
                <select class="select" name="distId" size="1" style="width:300px" id="distSelect">
                    <option value="">---请选择区---</option>
                    <c:forEach items="${distList}" var="dist">
                        <option value="${dist.id}" <c:if test="${userEntity.distId==dist.id}">selected</c:if> >
                                ${dist.cnname}(${dist.enname})</option>
                    </c:forEach>
                </select>
                <br>
                <input type="text" style="width:300px" class="input-text" value="${userEntity.address}" placeholder="" id="user-address2" name="address"></td>
        </tr>
        <tr>
            <th class="text-r">身份证号：</th>
            <td><input type="text" style="width:300px" class="input-text" value="${userEntity.idcard}" placeholder="" id="idcard" name="idcard"></td>
        </tr>
        <tr>
            <th class="text-r"><span class="c-red">*</span>身份证：</th>
            <td colspan="3">
                正面：
                <table class="table table-border table-bordered table-bg table-sort">
                    <tbody>
                        <tr>
                            <td width="260" height="51" class="text-r">
                                <table width="200" border="0">
                                </table>
                                <table width="72%" height="150" border="0" cellpadding="0" cellspacing="0" class="photo_bg" style="border:0px;margin:0px;padding:0px;">
                                    <tr>
                                        <td width="194" class="upload_img" style="border:0px;margin:0px;padding:0px; text-align:center;">
                                            <img src="${userEntity.idcardPathFront}" width="300" height="100" id="idcardPathFrontSrc" />
                                            <%--<c:if test="${userEntity.statusType != 1}">--%>
                                                <input type="file" style="opacity: 0.5;font-size:20px;folat:left" class="btn-uploadpic" name="file" multiple id="idcardPathFrontId">
                                            <%--</c:if>--%>
                                            <input type="hidden"  name="idcardPathFront" value="${userEntity.idcardPathFront}">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </tbody>
                </table>
                反面：
                <table class="table table-border table-bordered table-bg table-sort">
                    <tbody>
                    <tr>
                        <td width="260" height="51" class="text-r">
                            <table width="200" border="0">
                            </table>
                            <table width="72%" height="150" border="0" cellpadding="0" cellspacing="0" class="photo_bg" style="border:0px;margin:0px;padding:0px;">
                                <tr>
                                    <td width="194" class="upload_img" style="border:0px;margin:0px;padding:0px; text-align:center;">
                                        <img src="${userEntity.idcardPathBack}" width="300" height="100" id="idcardPathBackSrc" />
                                        <%--<c:if test="${userEntity.statusType != 1}">--%>
                                            <input type="file" style="opacity: 0.5;font-size:20px;folat:left" class="btn-uploadpic" name="file" multiple id="idcardPathBackId">
                                        <%--</c:if>--%>
                                        <input type="hidden"  name="idcardPathBack" value="${userEntity.idcardPathBack}">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <th class="text-r"><span class="c-red">*</span>个人头像：</th>
            <td>
                <table class="table table-border table-bordered table-bg table-sort">
                    <tbody>
                    <tr>
                        <td width="260" height="51" class="text-r">
                            <table width="200" border="0">
                            </table>
                            <table width="72%" height="150" border="0" cellpadding="0" cellspacing="0" class="photo_bg" style="border:0px;margin:0px;padding:0px;">
                                <tr>
                                    <td width="194" class="upload_img" style="border:0px;margin:0px;padding:0px; text-align:center;">
                                        <img src="${userEntity.personHeadPhoto}" width="300" height="100" id="personHeadPhotoSrc" />
                                        <c:if test="${userEntity.statusType != 1}">
                                            <input type="file" style="opacity: 0.5;font-size:20px;folat:left" class="btn-uploadpic" name="file" multiple id="personHeadPhotoId">
                                        </c:if>
                                        <input type="hidden"  name="personHeadPhoto" value="${userEntity.personHeadPhoto}">
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </td>
        </tr>
        <tr>
            <th valign="top" class="text-r">审核： </th>
            <td valign="top">
                <c:if test="${userEntity.statusType == 0 }">
                    <button type="button" id="shop_pass">审核通过</button>
                </c:if>
                <c:if test="${userEntity.statusType == 1 }">
                    审核通过&nbsp;
                </c:if>
                <c:if test="${userEntity.statusType == 2 }">
                    审核拒绝&nbsp;
                </c:if>
            </td>
        </tr>
        </tbody>
    </table>
    <input type="hidden" value="${userEntity.statusType}" name="statusType"/>
</form>
<div class="clear"></div>
<c:if test="${not empty userEntity.userId}">
    <form method="post" id="resetPwd">
        <table class="table table-border table-bordered table-bg table-sort">
            <thead>
            <tr class="text-l">
                <th width="106" class="public_click_content"><span class="l f-16">修改密码</span> <span class="r">
              <button class="btn btn-success radius" type="button" id="submitPwd"><i class="icon-ok"></i> 保存</button>
              </span> </th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <table class="table table-border table-bordered table-bg table-sort">
            <tbody>
            <tr>
                <th class="text-r"> 新密码：</th>
                <td width="737"><input type="password"  class="input-text" style="width:200px" id="newPwd"> </td>
            </tr>
            <tr>
                <th width="190" class="text-r">再次输入新密码：</th>
                <td><input type="password" id="newPwd2" class="input-text" style="width:200px"></td>
                    <%--&nbsp;<span class="c-red">二次密码不一样！</span></td>--%>
            </tr>
            </tbody>
        </table>
    </form>
</c:if>
<p>&nbsp;</p>
<p>&nbsp;</p>
</div>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/layer/layer.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/labelauty.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/position_top.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common/dateformat.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery-ui.js"></script>
<script type="text/javascript">

    var ctx = "${ctx}";//勿删

    $(document).on("change","#idcardPathFrontId",function(){
        upload("idcardPathFront");
    });

    $(document).on("change","#idcardPathBackId",function(){
        upload("idcardPathBack");
    });

    $(document).on("change","#personHeadPhotoId",function(){
        upload("personHeadPhoto");
    });


    function upload(e){
        var $dom = $("#"+e+"Id");
        var id=$dom.attr("id");
        if (!/\.(gif|jpg|jpeg|png|bmp|GIF|JPG|PNG|BMP|JPEG)$/.test($dom.val())) {
            alert('"错误",hideClose:true,msgTitle: "请上传.jpg .jpeg .gif .png .bmp格式图像!"');
            return false;
        }
        if ($dom.get(0).files[0].size > 1024 * 1024 * 5){
            alert('不能上传超过5M的文件，您上传的文件过大，请重新上传！');
            $dom.val(null);
            return false;
        }
        $.ajaxFileUpload({
            url:"${ctx}/aldUpload/uploadImg",
            secureuri:false,
            fileElementId:id,
            dataType:"json",
            success: function(data){
                if(data.result){
                    var src= data.data.urlPath;
                    console.log($("[name='"+e+"']"))
                    console.log(src)
                    $("[name='"+e+"']").val(src);
                    $("#"+e+"Src").attr('src',src);
                }else{
                    alert("上传图片失败");
                }
            },error: function (xml, status, e){
                alert("上传图片失败");
            }
        });
    }

</script>
<script type="text/javascript" src="${ctx}/resources/js/user/edit.js">
</script>
</body>
</html>
