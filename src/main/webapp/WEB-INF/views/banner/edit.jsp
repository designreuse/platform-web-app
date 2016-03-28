<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/global/common.jsp"%>
<html>
<head>
    <title>内容中心—广告编辑页</title>
</head>
<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页 <span class="c-gray en">&gt;</span> 广告管理 <span class="c-gray en">&gt;</span> 编辑广告 </nav>
<div class="pd-20">
  <form id="bannerForm" method="post">
      <table class="table table-border table-bordered table-bg table-sort">
          <tbody>
          <tr>
              <th width="190" height="30" class="text-r"><span class="c-red">*</span> 平台：</th>
              <td>
                  <select name="appId" id="appId" class="easyui-combobox"  style="width:125px">
                      <option value="">全部</option>
                  <c:if test="${aldBannerBo.appId==2}">
                      <option value="2" selected>神灯速贸运营平台</option>
                      <option value="3">神灯速贸中文平台</option>
                      <option value="5">神灯速贸俄文平台</option>
                  </c:if>
                  <c:if test="${aldBannerBo.appId==3}">
                      <option value="2" >神灯速贸运营平台</option>
                      <option value="3" selected>神灯速贸中文平台</option>
                      <option value="5">神灯速贸俄文平台</option>
                  </c:if>
                  <c:if test="${aldBannerBo.appId==5}">
                      <option value="2" selected>神灯速贸运营平台</option>
                      <option value="3">神灯速贸中文平台</option>
                      <option value="5" selected>神灯速贸俄文平台</option>
                  </c:if>
                  </select>
              </td>
          </tr>

          <tr>
              <th width="190" height="30" class="text-r"><span class="c-red">*</span>广告位：</th>
              <td>
                  <select name="adId" id="adId" class="easyui-combobox" style="width:125px">
                      <option value="">全部</option>
                      <c:forEach items="${adList}" var="ad">
                        <c:choose>
                            <c:when test="${aldBannerBo.adId==ad.id}">
                                <option value="${ad.id}" selected>${ad.adName}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${ad.id}">${ad.adName}</option>
                            </c:otherwise>
                      </c:choose>
                    </c:forEach>
                  </select>
              </td>
          </tr>


          <tr>
              <th width="190" height="30" class="text-r"><span class="c-red">*</span> 投放时间：</th>
              <td>
                  <input id="startTime" name="startTime" value="<odpf:formatDate style="DATE" date="${aldBannerBo.startTime}"/>" class="easyui-datebox"    style="width:100px"/>
                    ~
                  <input id="endTime" name="endTime" value="<odpf:formatDate style="DATE" date="${aldBannerBo.endTime}"/>" class="easyui-datebox"   style="width:100px"/>

              </td>
          </tr>

          <tr>
              <th width="190" class="text-r"><span class="c-red">*</span>广告LOGO：</th>
              <td><img src="${aldBannerBo.bannerLogo}" width="300" height="100" id="bannerLogoSrc" onclick="reOLUploadFro();">
                  <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0" class="btn-uploadpic" name="file" multiple="" id="bannerLogoId">
                  <input type="hidden" name="logoUrl" value="${aldBannerBo.bannerLogo}" id="logoUrl">
                  <input type="hidden" name="resourceCode" id="resourcesCode">
              </td>
          </tr>

          <tr>
              <th width="190" class="text-r"><span class="c-red">*</span>跳转链接：</th>
              <td>
                  <input id="url" type="text" value="${aldBannerBo.url}" class="easyui-validatebox" style="width:200px;height: 30px"  name="url">

              </td>

          </tr>

          <tr>
              <th width="190" class="text-r"><span class="c-red">*</span>广告描述：</th>
              <td>
                  <input id="bannerDesc" type="text" value="${aldBannerBo.bannerDesc}"  class="easyui-validatebox" style="width:400px;height: 30px" name="bannerDesc">

              </td>

          </tr>

          <tr>
              <td></td>
              <td>
                  <button class="btn btn-success radius" type="button" id="submitForm"><i class="icon-ok"></i> 保存</button>

              </td>
          </tr>
          </tbody>
      </table>
  </form>
    <input id="bannerId" type="hidden" value="${aldBannerBo.id}"/>
</div>


<script type="text/javascript" src="${ctx}/resources/js/banner/edit.js"></script>

<%--<script type="text/javascript">--%>
  <%--window.ctx="${ctx}"--%>

  <%--$(function(){--%>
<%--//      $("#bannerForm").form({--%>
<%--//          url:window.ctx+"/banner/insert",--%>
<%--//          success:function(data){--%>
<%--//              var result = jQuery.parseJSON(data);--%>
<%--//              alert(result.msg)--%>
<%--//          }--%>
<%--//      })--%>
  <%--})--%>
  <%--function myformatter(date){--%>
      <%--var y = date.getFullYear();--%>
      <%--var m = date.getMonth()+1;--%>
      <%--var d = date.getDate();--%>
      <%--return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);--%>
  <%--}--%>

  <%--function myparser(s){--%>
      <%--if (!s) return new Date();--%>
      <%--var ss = (s.split('-'));--%>
      <%--var y = parseInt(ss[0],10);--%>
      <%--var m = parseInt(ss[1],10);--%>
      <%--var d = parseInt(ss[2],10);--%>
      <%--if (!isNaN(y) && !isNaN(m) && !isNaN(d)){--%>
          <%--return new Date(y,m-1,d);--%>
      <%--} else {--%>
          <%--return new Date();--%>
      <%--}--%>
  <%--}--%>


  <%--function reOLUploadFro(){--%>
      <%--$("#bannerLogoId").trigger("click");--%>
  <%--}--%>
  <%--$(document).on("change","#bannerLogoId",function(){--%>
      <%--var $dom = $("#bannerLogoId");--%>
      <%--var id=$dom.attr("id");--%>
      <%--if (!/\.(gif|jpg|jpeg|png|bmp|GIF|JPG|PNG|BMP|JPEG)$/.test($dom.val())) {--%>
          <%--alert('"错误",hideClose:true,msgTitle: "请上传.jpg .jpeg .gif .png .bmp格式图像!"');--%>
          <%--return false;--%>
      <%--}--%>
      <%--if ($dom.get(0).files[0].size > 1024 * 1024 * 5){--%>
          <%--alert('不能上传超过5M的文件，您上传的文件过大，请重新上传！');--%>
          <%--$dom.val(null);--%>
          <%--return false;--%>
      <%--}--%>
      <%--$.ajaxFileUpload({--%>
          <%--url:window.ctx+"/aldUpload/uploadImg",--%>
          <%--secureuri:false,--%>
          <%--fileElementId:id,--%>
          <%--dataType:"json",--%>
          <%--success: function(data){--%>
              <%--if(data.result){--%>
                  <%--console.log(data.data)--%>
                  <%--var src= data.data.urlPath;--%>
                  <%--var resourceCode= data.data.resourceCode;--%>
                  <%--$("#resourcesCode").val(resourceCode)--%>
                  <%--$("[name=logoUrl]").val(src);--%>
                  <%--$("#bannerLogoSrc").attr('src',src);--%>
              <%--}else{--%>
                  <%--alert("上传图片失败");--%>
              <%--}--%>
          <%--},error: function (xml, status, e){--%>
              <%--alert("上传图片失败");--%>
          <%--}--%>
      <%--});--%>
  <%--})--%>

  <%--$("#submitForm").click(function(){--%>

      <%--if($("#appId").combobox("getValue")==""){--%>
          <%--alert("请选择平台");--%>
          <%--return;--%>
      <%--}--%>
      <%--if($("#adId").combobox("getValue")==""){--%>
          <%--alert("请选择广告位");--%>
          <%--return;--%>
      <%--}--%>

      <%--if($("#startTime").datebox('getValue')==""||$("#endTime").datebox('getValue')==""){--%>
          <%--alert("请选择投放时间");--%>
          <%--return;--%>
      <%--}else if($("#startTime").datebox('getValue')>$("#endTime").datebox('getValue')){--%>
          <%--alert("开始时间大于结束时间");--%>
          <%--return;--%>
      <%--}--%>
      <%--if($("#logoUrl").val()==null||$("#logoUrl").val()==""){--%>
          <%--alert("请选择广告LOGO");--%>
          <%--return;--%>
      <%--}--%>
      <%--if($("#url").val()==null||$("#url").val()==""){--%>
          <%--alert("请输入跳转链接");--%>
          <%--return;--%>
      <%--}--%>

      <%--if($("#bannerDesc").val()==null||$("#bannerDesc").val()==""){--%>
          <%--alert("请输入广告描述");--%>
          <%--return;--%>
      <%--}--%>

<%--//      $("#bannerForm").submit();--%>
      <%--$.ajax({--%>
          <%--type: "post",--%>
          <%--url: window.ctx+"/banner/update",--%>
          <%--data: {--%>
              <%--id:$("#bannerId").val(),--%>
              <%--appId:$("#appId").combobox("getValue"),--%>
              <%--adId:$("#adId").combobox("getValue"),--%>
              <%--startTime:$("#startTime").datebox('getValue'),--%>
              <%--endTime:$("#endTime").datebox('getValue'),--%>
              <%--bannerLogo:$("#logoUrl").val(),--%>
              <%--url:$("#url").val(),--%>
              <%--bannerDesc:$("#bannerDesc").val()--%>

          <%--},--%>
          <%--dataType: "json",--%>
          <%--success: function(data){--%>
              <%--if(data.result){--%>
                  <%--alert(data.msg);--%>
                  <%--window.location=window.ctx+"/banner/list";--%>
              <%--}else{--%>
                  <%--alert(data.msg);--%>
              <%--}--%>

          <%--}--%>
      <%--})--%>
  <%--})--%>
<%--</script>--%>
</body>
</html>
