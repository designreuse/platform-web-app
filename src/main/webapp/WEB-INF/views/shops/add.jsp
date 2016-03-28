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
    <title>新增店铺</title>

    <style type="text/css">
        /* Used for the Switch effect:*/
        .cb-enable, .cb-disable, .cb-enable span, .cb-disable span {
            background: url(${ctx}/resources/images/switch.gif) repeat-x;
            display: block;
            float: left;
        }
        .cb-enable span, .cb-disable span {
            line-height: 30px;
            display: block;
            background-repeat: no-repeat;
            font-weight: bold;
        }
        .cb-enable span {
            background-position: left -90px;
            padding: 0 10px;
        }
        .cb-disable span {
            background-position: right -180px;
            padding: 0 10px;
        }
        .cb-disable.selected {
            background-position: 0 -30px;
        }
        .cb-disable.selected span {
            background-position: right -210px;
            color: #fff;
        }
        .cb-enable.selected {
            background-position: 0 -60px;
        }
        .cb-enable.selected span {
            background-position: left -150px;
            color: #fff;
        }
        .switch label {
            cursor: pointer;
        }
    </style>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 会员中心 <span class="c-gray en">&gt;</span> 商铺管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a> <span class="c-gray en">&gt;</span><a href="#">新增商铺</a></nav>
<div class="pd-20">
<form action="${ctx}/shops/add" method="post" onsubmit="return checkShopsForm();">
<table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top">
    <thead>
    <tr class="text-l">
        <th width="106"><span class="l f-16">基本信息</span>
            <span class="r">
            <button class="btn btn-success radius" type="submit">
              <i class="icon-ok"></i> 保存</button>
            </span>
        </th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
    <input type="hidden" value="" name="shopsId"/>
<table class="table table-border table-bordered table-hover table-bg">
    <tbody>
    <tr>
        <th class="text-r" width="15%"><span class="c-red">*</span>隶属关系：</th>
        <td colspan="3">
            <p class="field switch">
              <input type="radio" id="radio1" name="shopsType" value="1" checked style="display:none;"/>
              <input type="radio" id="radio2" name="shopsType" value="2" style="display:none;"/>
              <label for="radio1" class="cb-enable selected"><span>隶属</span></label>
              <label for="radio2" class="cb-disable"><span>挂靠</span></label>
            </p>
        </td>
    </tr>

    <%--
    <tr id="orgList" style="display: none">
        <th class="text-r" width="15%">所属公司：</th>
        <td colspan="3">
            <select name="orgId" class="input-text">
            <c:forEach items="${orgList}" var="org">
                <option value="${org.id}">${org.orgNameCn}</option>
            </c:forEach>
            </select>
        </td>
    </tr>
    --%>

    <tr id="userInfo">
        <th class="text-r" width="15%"><span class="c-red">*</span>所属个人手机号：</th>
        <td>
            <input id="mobile" type="text" name="mobile" onchange="changeMobile();"
                   style="width:250px;" class="input-text">
            <button class="btn btn-success radius" type="button" onclick="getUserInfo()">
                <i class="icon-search"></i>检索
            </button>
        </td>
        <td  width="15%">
            <b>个人姓名：</b><span id="userName"></span><input id="userId" type="hidden" name="userId"/>
        </td>
        <td>
            <b>挂靠公司：</b><span id="orgName"></span><input id="orgId" type="hidden" name="orgId"/>
        </td>
    </tr>
    <tr>
        <th class="text-r" width="68"><span class="c-red">*</span>商铺名称（中文）：</th>
        <td width="392"><input type="text" id="shopsName" placeholder="商铺名称中文"
                               name="shopsNameCn" value="" style="width:250px" class="input-text"></td>
        <td class="text-r" width="87"><span class="c-red">*</span>商铺名称（俄文）：</td>
        <td width="392"><input type="text" id="shopsNameRu" placeholder="商铺名称俄文"
                               name="shopsNameRu" value="" style="width:250px" class="input-text"></td>
    </tr>
    <tr>

    </tr>
    <tr>
        <th class="text-r"><span class="c-red">*</span>推广语（中文）：</th>
        <td><textarea name="adTxt" id="adTxt" cols="50" rows="5"></textarea></td>
        <td class="text-r"><span class="c-red">*</span>商铺介绍（俄文）：</td>
        <td><textarea name="summaryRu" id="summaryRu" cols="50" rows="5"></textarea></td>
    </tr>
    <tr>
        <th class="text-r"><span class="c-red">*</span>商铺LOGO：</th>
        <td colspan="3"><table class="table table-border table-bordered table-bg table-sort">
            <tbody>
            <tr>
                <td width="260" height="51" class="text-r"><table width="200" border="0">

                </table>
                    <table width="72%" height="150" border="0" cellpadding="0" cellspacing="0" class="photo_bg" style="border:0px;margin:0px;padding:0px;">
                        <tr>
                            <td width="194" class="upload_img" style="border:0px;margin:0px;padding:0px; text-align:center;">
                                <img src="${shopsEntity.shopsLogo}" width="300" height="100" id="shopsLogoSrc" />
                                <input type="file" style="opacity: 0.5;font-size:20px;folat:left" class="btn-uploadpic" name="file" multiple id="shopsLogoId">
                                <input type="hidden"  name="shopsLogo" value="${shopsEntity.shopsLogo}">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            </tbody>
        </table></td>
    </tr>
    <tr>
        <th class="text-r"><span class="c-red">*</span>商铺横幅广告：</th>
        <td colspan="3"><table class="table table-border table-bordered table-bg table-sort">
            <tbody>
            <tr>
                <td width="260" height="51" class="text-r"><table width="200" border="0">

                </table>
                    <table width="72%" height="150" border="0" cellpadding="0" cellspacing="0" class="photo_bg" style="border:0px;margin:0px;padding:0px;">
                        <tr>
                            <td width="194" class="upload_img" style="border:0px;margin:0px;padding:0px; text-align:center;">
                                <img src="${shopsEntity.bannerLogo}" width="300" height="100" id="bannerLogoSrc" />
                                <input type="file" style="opacity: 0.5;font-size:20px;folat:left" class="btn-uploadpic" name="file" multiple id="bannerLogoId">
                                <input type="hidden"  name="bannerLogo" value="${shopsEntity.bannerLogo}">
                            </td>
                        </tr>
                    </table>
                    <table width="200" border="0">

                    </table></td>
            </tr>
            </tbody>
        </table></td>
    </tr>
    <tr>
        <th class="text-r">横幅广告链接：</th>
        <td colspan="3"><input type="text" name="bannerUrl" placeholder="url"
               value="" style="width:250px" class="input-text"></td>
    </tr>
    </tbody>
</table>
</form>
<div class="clear"></div>
</div>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/layer/layer.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script language="javascript" src="${ctx}/resources/js/position_top.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script>
    $(function(){
        $(".cb-enable").click(function(){
            var parent = $(this).parents('.switch');
            $('.cb-disable',parent).removeClass('selected');
            $(this).addClass('selected');
//            $("#orgList").show();
//            $("#userInfo").hide();
        });
        $(".cb-disable").click(function(){
            var parent = $(this).parents('.switch');
            $('.cb-enable',parent).removeClass('selected');
            $(this).addClass('selected');
//            $("#orgList").hide();
//            $("#userInfo").show();
        });

        if('${msg}' != ''){
            alert('${msg}');
        }
    });
    function getUserInfo(){
        var reg=/^1[3|4|5|7|8][0-9]\d{8}$/;
        var shopsType = $(":radio[name='shopsType']:checked").val();
        var mobile = $("#mobile").val();
        if(reg.test(mobile)){
            $.get("${ctx}/shops/getUserInfo",{mobile:mobile,shopsType:shopsType},function(d) {
                var data = d.data;
                if (d.result) {
                    $("#userName").text(data.userNameCn);
                    $("#orgName").text(data.orgNameCn);
                    $("#userId").val(data.userId);
                    $("#orgId").val(data.orgId);
                }else{
                    alert(d.msg);
                    $("#userName").text("");
                    $("#orgName").text("");
                    $("#userId").val("");
                    $("#orgId").val("");
                }
            },"json");
        }else
            alert("请输入正确的手机号码！");
    }

    function changeMobile(){
        $("#userId").val('');
        $("#orgId").val('');
        $("#userName").text("");
        $("#orgName").text("");
    }

    function checkShopsForm(){
        var flag = true;
        var msg = "";

        var shopsName = $("#shopsName");
        var shopsNameRu = $("#shopsNameRu");
        var adTxt = $("#adTxt");
        var summaryRu = $("#summaryRu");
        if(!shopsName.val()){
            msg = "商铺名称（中文）不能为空！";
            flag = false;
            shopsName.focus();
        }
        if(!shopsNameRu.val()){
            msg = "商铺名称（俄文）不能为空！";
            flag = false;
            shopsNameRu.focus();
        }
        if(!adTxt.val()){
            msg = "推广语（中文）不能为空！";
            flag = false;
            adTxt.focus();
        }
        if(!summaryRu.val()){
            msg = "商铺介绍（俄文）不能为空！";
            flag = false;
            summaryRu.focus();
        }

        if(!$("#userId").val() || !$("#orgId").val()){
            msg = "请确认用户信息！";
            flag = false;
            $("#mobile").focus();
        }

        if(!flag){
            alert(msg);
        }
        return flag;
    }


    $(document).on("change","#shopsLogoId",function(){
        upload("shopsLogo");
    });

    $(document).on("change","#bannerLogoId",function(){
        upload("bannerLogo");
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
</body>
</html>