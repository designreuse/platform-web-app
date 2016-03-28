<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
    <title>融链</title>
    <link href="../resources/css/base.css" rel="stylesheet" />
    <link href="../resources/css/main.css" rel="stylesheet" />
    <script src="../resources/lib/jquery-1.9.1.js"></script>
    <script src="../resources/js/options.js"></script>
    <script type="text/javascript">
        $(function () {
            Menum();
            SaveShow();
            Surplus();
           
        });
    </script>
</head>
<body>
    <!--头部版块 -->
    <div class="header">
        <div class="innerwp clearfix">
            <div class="logo fl"><a href="" title="综合运营管理中心">综合运营管理中心</a></div>
            <div class="hdlinks fr">
                <ul>

                    <li><a href="#">当前用户：<span class="ftwhite">袁益怀</span></a></li>
                    <li><a href="#">所属部门：<span class="ftwhite">物流平台部</span></a></li>
                    <li><a href="#">职位：<span class="ftwhite">总监</span></a></li>
                    <li class="noline"><a href="#">退出</a></li>
                </ul>
            </div>
        </div>
    </div>
    <!--面包屑版块 -->
    <div class="breadquick">
        <div class="innerwp clearfix">
            <div class="breadcrumb fl">
                <a href="" class="ftbold">我的融链</a> &gt; <a href="" class="ftgrey">字典管理</a> &gt;<span class="ftgrey"> 地区</span>&gt;<span class="ftgrey">区域</span>
            </div>
        </div>
    </div>
    <!--中间板块 -->
    <div class="container clearfix">
        <div class="innerwp">
            <!--左侧菜单版块 -->
            <div class="leftmenu">
                <ul class="lm-lv1">
                    <li class="oper-co1"><a href="">首页</a></li>
                    <li>
                        <a href="" class="left_nav"><i class="icon i8-5 ico-droparrow"></i><i class="oper-triangle"></i>会员管理</a>
                        <ul class="lm-lv2">
                             <li><a href="${ctx}/truckOwner/list" target="_functionShow">车主页面</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="" class="left_nav"><i class="icon i8-5 ico-droparrow"></i><i class="oper-triangle"></i>审核管理</a>
                        <ul class="lm-lv2">
                            <li><a href="${ctx}/certManage/list" target="_functionShow">货主/物流公司审核</a></li>
                            <li><a href="${ctx}/truckOwnerCert/list" target="_functionShow">车主审核</a></li>
                            <li><a href="${ctx}/truckCert/list" target="_functionShow">车辆审核</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="" class="left_nav"><i class="icon i8-5 ico-droparrow"></i><i class="oper-triangle"></i>消息中心</a>
                        <ul class="lm-lv2">
                           <li><a href="${ctx}/contact/list" target="_functionShow">消息页面</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="" class="left_nav"><i class="icon i8-5 ico-droparrow"></i><i class="oper-triangle"></i>字典管理</a>
                        <ul class="lm-lv2">
                            <li><a href="${ctx}/bizCodeType/list" target="_functionShow" >标准业务编码管理</a></li>
                            <li><a href="${ctx}/bizCode/list" target="_functionShow" >标准业务编码</a></li>
                            <li><a href="${ctx}/province/list" target="_functionShow">地区</a></li>
                            <li><a href="${ctx}/goodsclass/list" target="_functionShow">货物分类列表</a></li>
                            <li><a href="${ctx}/goods/list" target="_functionShow">货物列表</a></li>
                            <li><a href="${ctx}/bank/list" target="_functionShow">银行</a></li>
                            <li><a href="${ctx}/plateNumberLocation/list" target="_functionShow">银行</a></li>
                            <li><a href="${ctx}/truckModelBase/list" target="_functionShow">基础车型列表</a></li>
                            <li><a href="${ctx}/truckModel/list" target="_functionShow" >组合车型列表</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <!--主体内容版块 -->
            <div class="mainwrapper withleftcolumn">
               <iframe name="_functionShow" style="top:0px;" width="1500px" height="1000px" frameborder="0" src="" ></iframe>
            </div>
        </div>
    </div>



    <!--底部版块 -->
    <div class="footer">
        <div class="innerwp clearfix">
            <div class="copyright fl">
                <ul class="cplink">
                    <li class="nopl"><a href=""><i class="icon i3-5 ico-arrow"></i>新手入门</a></li>
                    <li><a href=""><i class="icon i3-5 ico-arrow"></i>交易指南</a></li>
                    <li><a href=""><i class="icon i3-5 ico-arrow"></i>交易保障</a></li>
                    <li><a href=""><i class="icon i3-5 ico-arrow"></i>融链联盟</a></li>
                    <li><a href=""><i class="icon i3-5 ico-arrow"></i>帮助中心</a></li>
                    <li class="noline nopr"><a href=""><i class="icon i3-5 ico-arrow"></i>联系我们</a></li>
                </ul>
                <p class="cpinfo"><span class="ftarial">&copy; Copyright     上海融链信息科技有限公司   rltx.com  All Rights Reserved. <br> 沪ICP备15012288号</p>
            </div>
        </div>
    </div>
</body>
</html>
