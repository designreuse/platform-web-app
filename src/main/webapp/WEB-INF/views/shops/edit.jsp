<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.rltx.com/taglibs/framework"  prefix="fw"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>企业商铺管理</title>

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
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 会员中心 <span class="c-gray en">&gt;</span> 商铺管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon-refresh"></i></a> <span class="c-gray en">&gt;</span><a href="#">商铺信息编辑</a></nav>
<div class="pd-20">
<form action="${ctx}/shops/update" method="post" onsubmit="return checkMyForm();">
<div id="message_position">
    <div id="position_fixed" class="cl pd-5 bg-1 bk-gray mt-20">
  <span class="l">
  <a href="javascript:void(0)" target="_self" class="btn btn-primary radius public_a_click">
      <i class="icon-plus">
      </i> 基本信息</a>
  <a href="javascript:;" name="_self" class="btn btn-primary radius public_a_click"><i class="icon-plus"></i> 审核</a> </span>
          <span class="r">
        <a href="/purchase/shops/detail/${shopsEntity.shopsId}" target="_blank" class="btn btn-primary radius"> 查看商品（俄文站点）</a>
        <c:if test="${shopsEntity != null}">
        <a id="start" href="javascript:void(0)" target="_self" class="btn btn-primary radius" <c:if test="${shopsEntity.disabled ==0 }">style="display:none"</c:if> > 启用</a>
      <a href="#"  id="forbidden" name="_self" class="btn btn-primary radius"<c:if test="${shopsEntity.disabled ==1}">style="display:none"</c:if>> 停用</a>

      <%--<a href="#" name="_self" class="btn btn-primary radius"><i class="icon-plus"></i> 启用</a>--%>
    </c:if>
      </span>
    </div>
</div>
<table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top">
    <thead>
    <tr class="text-l">
        <th width="106"><span class="l f-16">基本信息</span> <span class="r">
          <button class="btn btn-success radius" type="submit">
              <i class="icon-ok"></i> 保存</button>
        </span> </th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
    <input type="hidden" value="${shopsEntity.shopsId}" name="shopsId" id="shopsId"/>
<table class="table table-border table-bordered table-hover table-bg">
    <tbody>
    <tr>
        <th class="text-r" width="15%"><span class="c-red">*</span>所属公司：</th>
        <td>${shopsEntity.orgNameCn}</td>
        <th class="text-r" width="15%">隶属关系：</th>
        <td><c:if test="${shopsEntity.shopsType == 1}">隶属</c:if>
            <c:if test="${shopsEntity.shopsType == 2}">挂靠</c:if></td>
    </tr>
    <c:if test="${shopsEntity.shopsType == 2}">
        <tr>
            <th class="text-r"><span class="c-red">*</span>所属会员：</th>
            <td colspan="3">${shopsEntity.userNameCn}  ${shopsEntity.mobile} </td>
        </tr>
    </c:if>
    <tr>
        <th class="text-r" width="68"><span class="c-red">*</span>商铺名称（中文）：</th>
        <td width="392"><input type="text" id="shopsName" placeholder="商铺名称（中文）"
                               name="shopsNameCn" value="${fn:escapeXml(shopsEntity.shopsNameCn)}" style="width:250px" class="input-text"></td>
        <td class="text-r" width="87"><span class="c-red">*</span>商铺名称（俄文）：</td>
        <td width="392"><input type="text" id="shopsNameRu" placeholder="商铺名称（俄文）"
                               name="shopsNameRu" value="${fn:escapeXml(shopsEntity.shopsNameRu)}" style="width:250px" class="input-text"></td>
    </tr>
    <tr>

    </tr>
    <tr>
        <th class="text-r"><span class="c-red">*</span>推广语（中文）：</th>
        <td><textarea name="adTxt" id="adTxt" cols="50" rows="5">${shopsEntity.adTxt}</textarea></td>
        <td class="text-r"><span class="c-red">*</span>商铺介绍（俄文）：</td>
        <td><textarea name="summaryRu" id="summaryRu" cols="50" rows="5">${shopsEntity.summaryRu}</textarea></td>
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
               value="${shopsEntity.bannerUrl}" style="width:250px" class="input-text"></td>
    </tr>
    <tr>
    <th class="text-r"> 店铺状态：</th>
    <td colspan="3"><div class="State">
        <ul>
            <c:choose>
                <c:when test="${shopsEntity.shopsStatus == 1}" >
                    <li class="state1">待初审</li>
                </c:when>
                <c:when test="${shopsEntity.shopsStatus == 2}" >
                    <li class="onshow">审核通过</li>
                </c:when>
                <c:when test="${shopsEntity.shopsStatus == 3}" >
                    <li class="state1">待审核</li>
                </c:when>
                <c:when test="${shopsEntity.shopsStatus == 4}" >
                    <li class="state2">审核拒绝</li>
                </c:when>
            </c:choose>
        </ul>
    </div></td>
    </tr>
    </tbody>
</table>
</form>
<div class="clear"></div>
<table class="table table-border table-bordered table-bg table-sort">
    <thead>
    <tr class="text-l">
        <th width="106" class="public_click_content"><span class="l f-16">审核记录</span> <span class="r">
            <c:set var="exitId" value="false"></c:set>
            <c:forEach items="${adultLogEntityList}" var="adultList" >
                <c:if test="${adultList.adultStatus ==0}">
                    <c:set var="exitId" value="true"></c:set>
                </c:if>
            </c:forEach>
            <c:if test="${exitId == true}">

                <button  class="btn btn-primary radius public_examine"  onclick="adultShow();" type="button"  id="enterpriseSubmit"><i class="icon-ok"></i> 商铺审核</button>

            </c:if>
        </span></th>
    </tr>
    </thead>
    <tbody>
    </tbody>
</table>
<table class="table table-border table-bordered table-hover table-bg table-sort">
    <thead>
    <tr class="text-c">
        <th width="143">申请人</th>
        <th width="267">申请内容</th>
        <th width="291">申请时间</th>
        <th width="154">状态</th>
        <th width="139">审核人</th>
        <th width="213">审核时间</th>
        <th width="142">审核意见</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${adultLogEntityList}" var="adultLog">
        <tr class="text-c">
            <td>${adultLog.applyUserName}</td>
            <td>${adultLog.applyContent}</td>
            <td><fmt:formatDate  value='${adultLog.applyTime}' pattern="yyyy-MM-dd HH:mm"/>
            </td>
            <td>
                <c:choose>
                    <c:when test="${adultLog.adultStatus == 0}">待审核</c:when>
                    <c:when test="${adultLog.adultStatus == 1}">审核通过</c:when>
                    <c:when test="${adultLog.adultStatus == 2}">审核拒绝</c:when>
                </c:choose>
            </td>
            <td>${adultLog.modifyUserName}</td>
            <td><odpf:formatDate style="DATE" date="${adultLog.modifyTime}"/></td>
            <td>${adultLog.adultContent}</td>

        </tr>
    </c:forEach>
    </tbody>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
</div>

<div id="examine_box_bg"></div>
<div id="examine_box">
    <p><strong>审核</strong><em class="examine_close">X</em></p>
    <font>审核意见</font>
    <form action="${ctx}/shops/adult" method="post" id="adult_form">
        <input type="hidden" name="id" value="" id="adultId"/>
        <input type="hidden" name="adultStatus" value="0" id="adultStatus"/>
        <input type="hidden" name="dynamicId" value="${shopsEntity.shopsId}"/>
        <input type="hidden" name="shopsId" value="${shopsEntity.shopsId}"/>
        <input type="hidden" name="applyType" id="applyType">
        <textarea name="adultContent" id="adultContent"></textarea>
        <div style="clear:both;"></div>
        <span>
            <input type="button" value="通过" onclick="javascript:submitAdultForm(1);">
            <a href="javascript:submitAdultForm(2);" class="examine_close">拒绝</a>
        </span>
    </form>
</div>
<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/layer/layer.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script language="javascript" src="${ctx}/resources/js/position_top.js"></script>
<script>
    $(function(){
        $(".cb-enable").click(function(){
            var parent = $(this).parents('.switch');
            $('.cb-disable',parent).removeClass('selected');
            $(this).addClass('selected');

            var shopsId = $("#shopsId").val();
            $.post("${ctx}/shops/updateDisabled",{shopsId:shopsId,disabled:'false'});
        });
        $(".cb-disable").click(function(){
            var parent = $(this).parents('.switch');
            $('.cb-enable',parent).removeClass('selected');
            $(this).addClass('selected');

            var shopsId = $("#shopsId").val();
            $.post("${ctx}/shops/updateDisabled",{shopsId:shopsId,disabled:'true'});
        });

        if('${msg}' != ''){
            alert('${msg}');
        }

        //启用
        $("#start").click(function(){
            updateDisabled(false,false)
        });

        //禁用
        $("#forbidden").click(function(){
            updateDisabled(true,true)
        });
    });

    function submitAdultForm(type){
        $("#adultStatus").val(type);
        if(!$("#adultContent").val()){
            alert("审核内容不能为空!")
            return false;
        };
        $("#adult_form").submit();
    }
    function checkMyForm(){
        var shopsName = $("#shopsName");
        var shopsNameRu = $("#shopsNameRu");
        var adTxt = $("#adTxt");
        var summaryRu = $("#summaryRu");
        if(!shopsName.val()){
            alert("商铺名称（中文）不能为空！");
            shopsName.focus();
            return false;
        }
        if(!shopsNameRu.val()){
            alert("商铺名称（俄文）不能为空");
            shopsNameRu.focus();
            return false;
        }
        if(!adTxt.val()){
            alert("推广语（中文）不能为空");
            adTxt.focus();
            return false;
        }
        if(!summaryRu.val()){
            alert("商铺介绍（俄文）不能为空");
            summaryRu.focus();
            return false;
        }
        return true;
    }

    function adultShow(){
        $("#applyType").val(3);
    }

    function updateDisabled(e,data){
        $.ajax({
            url:"${ctx}/shops/updateDisabled",
            type:"POST",
            data:{
                disabled:e,
                shopsId:$("#shopsId").val()
            },
            success:function(){
                if(data == true){
                    $("#start").attr("style","")
                    $("#forbidden").attr("style","display:none")
                }else{
                    $("#forbidden").attr("style","")
                    $("#start").attr("style","display:none")
                }
            }
        })
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