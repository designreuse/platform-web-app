<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<%response.setStatus(500);%>

<!--[if IE 8]> <html  class="ie8"> <![endif]-->
<!--[if IE 9]> <html  class="ie9"> <![endif]-->
<!--[if !IE]><!-->
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
<meta name="renderer" content="webkit">
<title>融链</title>
<meta name="keywords" content="wl.com，融链" />
<meta name="description" content="wl.com 融链 重卡物流服务整合平台" />
<style>
* { padding:0; margin:0; }
body {background:#f6f6f6;font:normal 12px/1  microsoft yahei, "\5b8b\4f53", Tahoma, Helvetica, Arial, sans-serif; line-height:22px}
.pr {position: relative; z-index: 10 }
.pa {position: absolute; z-index: 20 }
.innerwp {width: 1000px; min-width: 1000px; margin:0 auto;}
.container {background:#f6f6f6; padding-bottom:24px;}
.container { background:url(img/404.jpg) no-repeat center center; height:800px }
.backinfo { width:480px; margin:0 auto; padding-top:140px; text-align:center }
.errortype { display:block; height:200px; font:bold 200px/200px "Trebuchet MS",Helvetica,Arial,"Times New Roman","Lucida Sans Unicode"; color:#777; text-shadow:1px 1px 0 #23639b }
.tips { font-size:24px; color:#f60; padding-top:20px } 
.tips span { display:block; padding-top:10px; font-size:14px; color:#777 }
.tips span a { color:#1d75c3; text-decoration:underline; margin-left:10px }
.tips span a:hover { color:#f60 }
.toctrl { position:absolute; width:132px; height:133px; line-height:100px; text-align:center; left:135px; top:330px; color:#df6d41; font-size:18px; background:url(img/go.jpg) no-repeat 0 0 }
.footer { bottom:0; box-shadow:none; height:83px; background:#f1f1f1;background: #f1f1f1 url(img/ftbg.jpg) no-repeat center 0; width:100% }
.footer .innerwp {padding:19px 0;}
</style>
<script src="${ctx}/static/lib/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
</head>
<!-- END HEAD -->
<!-- BEGIN BODY -->
<body style="background-color: #e9e9e9;">
<div class="container">
<div class="innerwp pr">
<div class="backinfo">
<strong class="errortype">500</strong>
<p class="tips">
很抱歉，服务器超时!<span>5秒后跳转到登录界面，您也可以点击</span><a href="${ctx }/logout" title="马上重新登录">马上重新登录  &gt; </a>登录
</p>
</div>
</div>
</div>
<script type="text/javascript">
window.setTimeout("window.location.href='${ctx}/logout'",5000);
</script>
</body>
</html>
