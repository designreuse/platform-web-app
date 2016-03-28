<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    <title>个人信息</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 用户中心 <span class="c-gray en">&gt;</span> 新建员工 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a></nav>
<div class="pd-20">
    <table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top">
        <thead>
        <tr class="text-l">
            <th width="106"><span class="l f-16">基本信息</span> <span class="r">
          <button class="btn btn-success radius" type="submit"><i class="icon-ok"></i> 保存</button>
          </span> </th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    <table class="table table-border table-bordered table-bg table-sort">
        <tbody>
        <tr>
            <th width="190" class="text-r"><span class="c-red">*</span> 姓名（中文）：</th>
            <td><input type="text" style="width:200px" class="input-text" value="" placeholder="" id="cn-name" name="user-name" datatype="*2-16" nullmsg="用户名不能为空"></td>
        </tr>
        <tr>
            <th width="190" class="text-r"><span class="c-red">*</span> First Name</th>
            <td><input type="text" style="width:200px" class="input-text" value="" placeholder="" id="fi-name" name="user-name" datatype="*2-16" nullmsg="用户名不能为空"></td>
        </tr>
        <tr>
            <th width="190" class="text-r"><span class="c-red">*</span> Last Name</th>
            <td><input type="text" style="width:200px" class="input-text" value="" placeholder="" id="la-name" name="user-name" datatype="*2-16" nullmsg="用户名不能为空"></td>
        </tr>
        <tr>
            <th class="text-r">生日：</th>
            <td><input class="Wdate" type="text" id="d15" onFocus="WdatePicker({isShowClear:false,readOnly:true})"/></td>
        </tr>
        <tr>
            <th class="text-r"><span class="c-red">*</span> 性别：</th>
            <td><label>
                <input name="sex" type="radio" id="six_1" value="3" checked>
                男</label>
                <label>
                    <input type="radio" name="sex" value="4" id="six_0">
                    女</label></td>
        </tr>
        <tr>
            <th class="text-r"><span class="c-red">*</span> 手机</th>
            <td><input type="text" style="width:300px" class="input-text" value="" placeholder="" id="user-tel2" name="user-tel2">
                <a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_examine">发送验证短信</a><span>
          <input type="text" style="width:100px" class="input-text" value="请输入验证码" placeholder="" id="fi-name2" name="fi-name">
          <a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_examine">验证</a></span> <span><img src="images/icon_right_s.png" width="18" height="20">已验证</span> <span><img src="images/icon_right_s2.jpg" width="18" height="17">验证失败</span></td>
        </tr>
        <tr>
            <th class="text-r">邮箱：</th>
            <td><input type="text" style="width:300px" class="input-text" value="" placeholder="" id="user-tel3" name="user-tel3">
                <a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_examine">发送验证邮件</a> <span>验证邮件已发送，请打开您的邮箱并点击验证链接。<a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_examine">重发送验证邮件</a></span> <span><img src="images/icon_right_s.png" width="18" height="20">已验证</span> <span><img src="images/icon_right_s2.jpg" width="18" height="17">验证失败</span></td>
        </tr>
        <tr>
            <th class="text-r"><span class="c-red">*</span> 登录密码：</th>
            <td><input type="text" style="width:300px" class="input-text" value="请输入6~20位数字、字母或字符" placeholder="" id="user-tel1" name="user-tel">
                <span><img src="images/icon_right_s.png" width="18" height="20"></span> <span><img src="images/icon_right_s2.jpg" width="18" height="17"></span></td>
        </tr>
        <tr>
            <th class="text-r">居住地址：</th>
            <td><br>
                <input type="text" style="width:300px" class="input-text" value="" placeholder="" id="user-address2" name="user-address2"></td>
        </tr>
        <tr>
            <th class="text-r">身份证号：</th>
            <td><input type="text" style="width:300px" class="input-text" value="" placeholder="" id="user-address" name="user-address"></td>
        </tr>
        <tr>
            <th valign="top" class="text-r">身份证： </th>
            <td valign="top"><table border="0" cellspacing="0" cellpadding="0">
                <tbody>
                <tr>
                    <td class="table table-border table-bordered table-bg table-sort"><table width="72%" height="150" border="0" cellpadding="0" cellspacing="0" class="photo_bg" style="border:0px;margin:0px;padding:0px;">
                        <tr>
                            <td width="194" class="upload_img" style="border:0px;margin:0px;padding:0px;"> 点击上传<br>
                                限JPEG、PNG文件<br>
                                5M大小以内<br></td>
                        </tr>
                    </table>
                        <table width="200" border="0">
                            <tr>
                                <td style="border:0px;" class="photo_shenhe"><img src="images/icon_right_s.png">审核通过&nbsp;</td>
                            </tr>
                        </table></td>
                    <td class="table table-border table-bordered table-bg table-sort"><table width="72%" height="150" border="0" cellpadding="0" cellspacing="0" class="photo_bg" style="border:0px;margin:0px;padding:0px;">
                        <tr>
                            <td width="194" class="upload_img" style="border:0px;margin:0px;padding:0px;"> 点击上传<br>
                                限JPEG、PNG文件<br>
                                5M大小以内<br></td>
                        </tr>
                    </table>
                        <table width="200" border="0">
                            <tr>
                                <td style="border:0px;" class="photo_shenhe"><img src="images/icon_right_s2.jpg">审核通过&nbsp;</td>
                            </tr>
                        </table></td>
                </tr>
                </tbody>
            </table></td>
        </tr>
        <tr>
            <th valign="top" class="text-r">服务执行部门：</th>
            <td valign="top"><select class="select" name="Audit" size="1" style="width:120px">
                <option value="1" selected>无</option>
                <option value="2">财务</option>
                <option value="3">司机</option>
                <option value="4">跟单</option>
            </select></td>
        </tr>
        <tr>
            <th valign="top" class="text-r">&nbsp;</th>
            <td valign="top"><button name="system-base-save" id="system-base-save" class="btn btn-success radius" type="submit"><i class="icon-ok"></i> 保存</button></td>
        </tr>
        </tbody>
    </table>
    <div class="clear"></div>
</div>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/layer/layer.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/pagenav.cn.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
</body>
</html>