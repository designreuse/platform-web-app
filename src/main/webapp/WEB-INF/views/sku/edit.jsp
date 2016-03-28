<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 15-7-7
  Time: 下午3:42
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.wl.com/odp-framework/taglibs" prefix="odpf" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<script>
    window.ctx = '${ctx}';
</script>
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
    <title>新建商铺商品</title>
</head>


<body>
<nav class="Hui-breadcrumb"><i class="icon-home"></i> 首页<span class="c-gray en">&gt;</span> 商品中心 <span class="c-gray en">&gt;</span>商铺商品管理<span class="c-gray en">&gt;</span> 商铺商品编辑</nav>
<div class="pd-20">
    <form class="skuForm" method="post" action="${ctx}/sku/save" id="skuForm">
        <input type="hidden" name="skuId" value="${skuBo.skuId}" id="skuId">
        <input type="hidden" name="unitId" value="" id="unitId">
        <input type="hidden" name="unitName" value="" id="unitName">
        <input type="hidden" name="shopsName" value="${skuBo.shopsName}" >
        <table class="table table-border table-bordered table-bg table-sort public_click_content" id="header_top">
            <thead>
            <tr class="text-l">
                <th width="106"><span class="l f-16">基本信息</span><span class="r"></span>
                    <c:if test="${skuBo.isOffline==1}">
                <span class="r">
                    <button class="btn btn-success radius" type="button" onclick="offlineSku(${skuBo.skuId},0)"><i class="icon-ok"></i>下架</button>
                </span>
                    </c:if>
                    <c:if test="${skuBo.isOffline==0}">
                <span class="r">
                    <button class="btn btn-success radius" type="button" onclick="offlineSku(${skuBo.skuId},1)"><i class="icon-ok"></i>上架</button>
                </span>
                    </c:if>
                </th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <table class="table table-border table-bordered table-hover table-bg">
            <tbody>

            <tr>
                <th class="text-r" width="120">商铺名称：</th>
                <td colspan="3">
                    <c:if test="${empty skuBo.skuId}">
                        <input type="text" id="shopsName" name="shopsName" placeholder="请输入商铺名称" value="${fn:escapeXml(skuBo.shopsName)}" style="width:250px" class="input-text">
                    </c:if>
                    <c:if test="${not empty skuBo.skuId}">
                        ${skuBo.shopsName}
                    </c:if>
                    <input type="hidden" name="shopsId" value="${skuBo.shopsId}" id="shopsId">
                </td>
            </tr>
            <tr>
                <th class="text-r"><span class="c-red">*</span>销售商品：</th>
                <td colspan="3">
                    <select onchange="loadCs2(this);" class="select" name="catalogIdFirst" size="1" style="width:120px">
                        <option value="">==请选择==</option>
                        <c:forEach items="${catalogsFirst}" var="catalogFirst">
                            <option value="${catalogFirst.catalogId}" <c:if test="${catalogFirst.catalogId ==skuBo.catalogIdFirst}"> selected</c:if>>${catalogFirst.catalogNameCn}</option>
                        </c:forEach>
                    </select>
                    <select onchange="loadCs3(this);" class="select catalogSelect2" name="catalogIdSecond" size="1" style="width:120px">
                        <option value="">==请选择==</option>
                        <c:forEach items="${catalogsSecond}" var="catalogSecond">
                            <option value="${catalogSecond.catalogId}"  <c:if test="${catalogSecond.catalogId ==skuBo.catalogIdSecond}"> selected</c:if>>${catalogSecond.catalogNameCn}</option>
                        </c:forEach>
                    </select>
                    <select onchange="loadPro(this);" class="select catalogSelect" name="catalogId" id="catalogId" size="1" style="width:120px">
                        <option value="">==请选择==</option>
                        <c:forEach items="${catalogsThird}" var="catalogThird">
                            <option value="${catalogThird.catalogId}"  <c:if test="${catalogThird.catalogId ==skuBo.catalogId}"> selected</c:if>>${catalogThird.catalogNameCn}</option>
                        </c:forEach>
                    </select>
                    <select class="select productSelect" name="productId" id="productId" size="1" style="width:120px">
                        <option value="">==请选择==</option>
                        <c:forEach items="${productList}" var="product">
                            <option value="${product.productId}"  <c:if test="${product.productId ==skuBo.productId}"> selected</c:if>>${product.productNameCn}</option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <th class="text-r"><span class="c-red">*</span>商品标题（中文）：</th>
                <td colspan="3"><input type="text" id="skuNameCn" name="skuNameCn" placeholder="商品标题（中文）" value="${fn:escapeXml(skuBo.skuNameCn)}" style="width:250px" class="input-text"></td>
            </tr>
            <tr>
                <th class="text-r"><span class="c-red">*</span>商品标题（俄文）：</th>
                <td colspan="3"><input type="text" id="skuNameRu" name="skuNameRu" placeholder="商品标题（英文）" value="${fn:escapeXml(skuBo.skuNameRu)}" style="width:250px" class="input-text"></td>
            </tr>
            <tr>
                <th class="text-r"><span class="c-red">*</span>交货地：</th>
                <td width="503"><select class="select" name="deliveryCityId" size="1" style="width:120px">
                    <c:forEach items="${deliveryAddrList}" var="delivery">
                        <option value="${delivery.constValue}" <c:if test="${skuBo.deliveryCityId ==delivery.constValue}"> selected</c:if>>${delivery.constName}</option>
                    </c:forEach>
                </select></td>
                <th colspan="2" width="343" class="text-l"><span class="c-red">*</span>交货期：
                    <input type="text" id="deliveryDay" name="deliveryDay" placeholder="交货期" value="${skuBo.deliveryDay}" style="width:100px" class="input-text"></th>
            </tr>
            <tr>
                <th class="text-r"><span class="c-red">*</span>最小起订量：</th>
                <td><input type="text" id="moq" name="moq" placeholder="最小起定量" value="${skuBo.moq}" style="width:100px" class="input-text"><span id = "productUnit">${unitName}</span></td>
                <th colspan="2" class="text-l"><span class="c-red">*</span>有效期：
                    <input class="Wdate" type="text" name="validityDate" value="<odpf:formatDate style='DATE' date='${skuBo.validityDate}'/>" id="validityDate" onFocus="WdatePicker({isShowClear:false,readOnly:true})"/></th>
            </tr>

            <tr>
                <th class="text-r"><span class="c-red">*</span>库存量：</th>
                <td><input type="text" name="stockNum"  id="website-static10" placeholder="库存" value="${skuBo.stockNum}" style="width:100px" class="input-text"><span id = "productUnitLib">${unitName}</span></td>
                <th class="text-r">热门商品：</th>
                <td><input type="radio"  name="isHot"  value="1"  <c:if test="${skuBo.isHot ==1}">checked</c:if>>
                    <label for="radio">是
                        <input type="radio" name="isHot"  value="0"  <c:if test="${skuBo.isHot ==0}">checked</c:if>>
                        否
                    </label></td>
            </tr>

            <tr>
                <th class="text-r">促销：</th>
                <td>
                    <input type="radio" name="isSales" value="1"  <c:if test="${skuBo.isSales ==1}">checked</c:if>>
                    <label for="radio2">是
                        <input type="radio" name="isSales"  value="0"  <c:if test="${skuBo.isSales ==0}">checked</c:if>>
                        否 </label>
                </td>
                <th class="text-r">是否首页：</th>
                <td>
                    <input type="radio" name="isHomepage"  value="1" <c:if test="${skuBo.isHomepage ==1}">checked</c:if> >
                    <label for="radio3">是
                        <input type="radio" name="isHomepage"  value="0" <c:if test="${skuBo.isHomepage ==0}">checked</c:if>>
                        否 </label>
                </td>
            </tr>
            <tr>
                <th class="text-r">SKU状态：</th>
                <td colspan="3">
                    <c:choose>
                        <c:when test="${skuBo.skuStatus ==0}">
                            待初审
                            <button  class="btn btn-primary radius public_examine"  onclick="adultSku(${skuBo.skuId},1);" type="button"  id="skuPass"><i class="icon-ok"></i>审核通过</button>
                            <button  class="btn btn-primary radius public_examine"  onclick="adultSku(${skuBo.skuId},3);" type="button"  id="skuRefuse"><i class="icon-trash"></i>审核拒绝</button>
                        </c:when>
                        <c:when test="${skuBo.skuStatus ==1}">
                            审核通过
                        </c:when>
                        <c:when test="${skuBo.skuStatus ==2}">
                            待审核
                            <button  class="btn btn-primary radius public_examine"  onclick="adultSku(${skuBo.skuId},1);" type="button"  id="skuPass"><i class="icon-ok"></i>审核通过</button>
                            <button  class="btn btn-primary radius public_examine"  onclick="adultSku(${skuBo.skuId},3);" type="button"  id="skuRefuse"><i class="icon-trash"></i>审核拒绝</button>
                        </c:when>
                        <c:otherwise>
                            审核未通过 <button  class="btn btn-primary radius public_examine"  onclick="adultSku(${skuBo.skuId},1);" type="button"  id="skuPass"><i class="icon-ok"></i>审核通过</button>
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
            </tbody>
        </table>

        <table class="table table-border table-bordered table-bg table-sort public_click_content mt-15" >
            <thead>
            <tr class="text-l">
                <th width="106"><span class="l f-16">商品属性</span></th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <input type="hidden" id="priceList" name="priceList">
        <table class="table table-border table-bordered table-hover table-bg">
            <tbody id="propertyTable">
            <c:forEach items="${propertyList}" var="propertyList">
                <tr>
                    <th class="text-r" width="171">${propertyList.propertyNameCn}</th>
                    <c:if test="${propertyList.propertyType ==2}">
                        <td width="848"><input type="text" name="propertyValue_${propertyList.propertyId}_${propertyList.skuId}"  value="${propertyList.propertyValue}" style="width:200px" class="input-text propertyValue"></td>
                    </c:if>
                    <c:if test="${propertyList.propertyType ==1 && propertyList.propertyId ==5}">
                        <td width="848">
                            <select class="select propertyValue" name="propertyValue_${propertyList.propertyId}" size="1" style="width:200px">
                                <option value="1" <c:if test="${propertyList.propertyValue == 1}"> selected</c:if>>次品</option>
                                <option value="2" <c:if test="${propertyList.propertyValue == 2}"> selected</c:if>>合格品</option>
                                <option value="3" <c:if test="${propertyList.propertyValue == 3}"> selected</c:if>>精品</option>
                            </select>
                        </td>
                    </c:if>
                    <c:if test="${propertyList.propertyType ==1 && propertyList.propertyId ==7}">
                        <td width="848">
                            <select class="select propertyValue" name="propertyValue_${propertyList.propertyId}" size="1" style="width:200px">
                                <option value="1" <c:if test="${propertyList.propertyValue == 1}"> selected</c:if>>箱装</option>
                                <option value="2" <c:if test="${propertyList.propertyValue == 2}"> selected</c:if>>盒装</option>
                                <option value="3" <c:if test="${propertyList.propertyValue == 3}"> selected</c:if>>桶装</option>
                            </select>
                        </td>
                    </c:if>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <table class="table table-border table-bordered table-bg table-sort public_click_content mt-15" >
            <thead>
            <tr class="text-l">

                <th width="106"><span class="l f-16">商品售价</span>
          <span class="r">
          <button class="btn btn-success radius" id="addPrice" type="button"><i class="icon-ok"></i> 新增区间</button>
        </span>
                </th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <table class="table table-border table-bordered table-hover table-bg">
            <tbody id="priceTable">
            <tr>
                <th class="text-r" width="76">币种：</th>
                <td width="262"><select class="select" name="costType" size="1" style="width:150px">
                    <option value="1" selected>人民币</option>
                </select></td>
                <td width="53">&nbsp;</td>
                <td width="420">&nbsp;</td>
            </tr>
            <c:forEach items="${priceList}" var="priceList" varStatus="status">
                <tr>
                    <th class="text-r">数量：&gt;=</th>
                    <td><input type="text" name="oq"  placeholder="数量" value="${priceList.oq}" style="width:150px" class="input-text">
                        <span id="unitNameSpan"></span></td>
                    <th class="text-r">包装均价：</th>
                    <c:if test="${priceList.priceType == 1}">
                        <td><select class="select" name="priceType" onchange="priceTypeChange(this,${status.count})" size="1" style="width:160px">
                            <option value="1"selected>定价</option>
                            <option value="2">价格区间</option>
                            <option value="3">议价</option>
                        </select>
                            <input type="text" name="priceStart" placeholder="价格" value="${priceList.priceStart}" style="width:150px" class="input-text">
                            <c:if test="${priceList.costType ==2}">元</c:if><c:if test="${priceList.costType ==1}">美元</c:if>
                            <c:if test="${status.count >1}">
                                <input type='button' value='删除' onclick='deleteTr(this);'>
                            </c:if>
                        </td>
                    </c:if>
                    <c:if test="${priceList.priceType == 2}">
                        <td><select class="select" name="priceType" size="1" style="width:160px">
                            <option value="1">定价</option>
                            <option value="2"selected>价格区间</option>
                            <option value="3">议价</option>
                        </select>
                            <input type="text" placeholder="起始价格" id="priceStart" name="priceStart" value="${priceList.priceStart}" style="width:150px" class="input-text">
                            <span>~</span>
                            <input type="text" placeholder="截止价格" id="priceEnd" name="priceEnd" value="${priceList.priceEnd}" style="width:150px" class="input-text">
                            <c:if test="${priceList.costType ==2}">元</c:if><c:if test="${priceList.costType ==1}">美元</c:if>
                            <c:if test="${status.count >1}">
                                <input type='button' value='删除' onclick='deleteTr(this);'>
                            </c:if>
                        </td>
                    </c:if>
                    <c:if test="${priceList.priceType == 3}">
                        <td><select class="select" name="priceType" size="1" style="width:160px">
                            <option value="1">定价</option>
                            <option value="2">价格区间</option>
                            <option value="3"selected>议价</option>
                        </select>
                            <c:if test="${status.count >1}">
                                <input type='button' value='删除' onclick='deleteTr(this);'>
                            </c:if>
                        </td>
                    </c:if>

                </tr>
            </c:forEach>
            </tbody>
        </table>
        <table class="table table-border table-bordered table-bg table-sort public_click_content mt-15" >
            <thead>
            <tr class="text-l">
                <th width="106"><span class="l f-16">商品描述</span></th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <input id="photoList" type="hidden" name="photoList">
        <table class="table table-border table-bordered table-hover table-bg">
            <tbody>
            <tr>
                <th class="text-r" width="110"><span class="c-red">*</span>产品图片：</th>
                <td width="1335" colspan="2"><div id="skuImgListId">
                    <c:forEach items="${skuPhotoList}" var="skuPhoto" >
                        <div>
                            <img src="${skuPhoto.photoUrl}" data-code="${skuPhoto.resourceCode}" id="${skuPhoto.resourceCode}"/>&nbsp;&nbsp;
                            <input type="button" class="delPhoto" value="删除"/>
                        </div>
                    </c:forEach>
                </div>
                    <div style="line-height:20px; margin:10px 0 0 0;">
                        最多可以上传6张图片。<br>
                        图片大小支持2MB，图片尺寸为360*360<br>
                        切勿盗用他人图片，以免受网规处罚，上传优质产品图片会获得更多的站内外流量。
                        <br>
                        优质产品图片定义：产品原图，即无人为修改痕迹、无水印、无修饰边框和文字。
                        <br>
                        <input type="file" class="btn-uploadpic"  name="file" id="skuLogoId">
                        <input type="hidden"  name="skuLogo" value="${shop.shopsLogo}">
                    </div></td>
            </tr>
            <tr>
                <th class="text-r"><span class="c-red">*</span>产品描述：</th>
                <td><textarea name="skuSimpleDesc" cols="80" rows="5">${skuBo.skuSimpleDesc}</textarea></td>
            </tr>
            <tr>
                <th class="text-r"><span class="c-red">*</span>产品详情：</th>
                <td>
                    <textarea id="skuDesc" name="skuDesc" style="width:100%;height:400px;">${skuBo.skuDesc}</textarea>
                </td>
            </tr>
            <tr>
                <th class="text-r">&nbsp;</th>
                <td><button id="saveSku" class="btn btn-success radius" type="button"><i class="icon-ok"></i> 保存</button></td>
            </tr>
            </tbody>
        </table>
    </form>
</div>


<script type="text/javascript" src="${ctx}/resources/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/H-ui.admin.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/position_top.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/labelauty.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/common/dateformat.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/validation/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>

<%--百度编辑器开始--%>
<link href="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/lang/zh-cn/zh-cn.js"></script>
<%--百度编辑器结束--%>
<script type="text/javascript">

    UM.getEditor('skuDesc');

    if('${msg}' !== ''){
        alert('${msg}');
    }




    //清除select下除了第一个之外的option
    function cleanOption(target){
        target.children().first().siblings().remove();
    }
    //加载二级产品分类
    function loadCs2(s){
        loadCatalogList("${ctx}/inquiry/catalogList/"+$(s).val(),$("select.catalogSelect2:visible"));
        cleanOption($("select.catalogSelect3:visible"));
        cleanOption($("select.catalogSelect:visible"));
        cleanOption($("select.productSelect:visible"));
    }
    //加载三级产品分类
    function loadCs3(s){
        cleanOption($("select.productSelect:visible"));
        loadCatalogList("${ctx}/inquiry/catalogList/"+$(s).val(),$("select.catalogSelect:visible"));
    }

    //加载产品列表
    function loadPro(s){
        var target = $("select.productSelect:visible");
        cleanOption(target);
        $.get("${ctx}/inquiry/productList/"+$(s).val(),function(data){
            data.forEach(function(d){
                $("<option/>")
                        .val(d.productId)
                        .text(d.productNameCn)
                        .attr("data-hscode", d.hscode)
                        .attr("data-logoUrl", d.logoUrl)
                        .appendTo(target);
            });
        },"json");
    }

    /**
     * 查询商品分类 生成select
     * @param cid      父分类id
     * @param target   目标select
     */
    function loadCatalogList(url,target){
        cleanOption(target);
        $.get(url,function(data){
            data.forEach(function(d){
                target.append($("<option/>").val(d.catalogId).text(d.catalogNameCn));
            });
        },"json");
    }

    function adultSku(skuid,status) {
        $.ajax({
            url:"${ctx}/sku/adult",
            type:"post",
            data:{
                skuId:skuid,
                skuStatus:status
            },
            success:function(data){
                alert("审核成功");
                location.reload();

            }
        })
    }

    $("#addPrice").click(function(){
        if ($("#priceTable tr").length<4) {
            var str = "<tr>"
            str += "<th class='text-r'>数量：&gt;=</th>"
            str += "<td><input type='text' name='oq'  placeholder='数量' value style='width:150px' class='input-text'>"
            str +=  $("#unitNameSpan").html()+ "</td>"
            str += "<th class='text-r'>包装均价：</th>"
            str += "<td><select class='select' name='priceType' onchange='priceTypeChange(this,2)' size='1' style='width:160px'>"
            str += "<option value='1'>定价</option>"
            str += "<option value='2'>价格区间</option>"
            str += "<option value='3'selected>议价</option>"
            str += "</select>  <input type='button' value='删除' onclick='deleteTr(this);'>  </td></tr>"
            $("#priceTable").append(str);
        }
        else
        {
            alert("最多只能添加三条价格记录!")
        }
    })

    function deleteTr(obj){
        $(obj).parent().parent().remove();
    }

    $("#productId").change(function(){
        $.ajax({
            url:"${ctx}/ShopsSku/getProperty",
            type:"post",
            data:{
                productId:$("#productId").val()
            },
            dataType:"json",
            success:function(data){
                $("#propertyTable tr").remove()
                console.log(data.propertyList)
                data.propertyList.forEach(function(d){
                    $("#unitId").val(d.unitId);
                    $("#unitName").val(d.unitName);
                    $("#unitNameSpan").html(d.unitName);
                    $("#productUnit").html(d.unitName);
                    $("#productUnitLib").html(d.unitName);
                    var str="<tr>"
                    str += "<th class='text-r' width='171'>"
                    str +=d.propertyName
                    str += "</th>"
                    if(d.propertyType ==2){
                        str += "<td width='848'>"
                        str += "<input type='text' name='propertyValue_"+d.propertyId+"_${skuBo.skuId}'value style='width:200px' placeholder='' class='input-text propertyValue'>"
                        str += "</td>"
                    }
                    if(d.propertyType ==1 && d.propertyId == 7){
                        str += "<td width='848'>"
                        str += "<select class='select propertyValue' name='propertyValue_"+d.propertyId+"_${skuBo.skuId}' size='1' style='width:200px'>"
                        str += " <option value='1' >箱装</option>"
                        str += " <option value='2' >盒装</option>"
                        str += " <option value='3' >桶装</option>"
                        str += " </select></td>"
                        str += " </tr>"
                    }
                    if(d.propertyType ==1 && d.propertyId == 5){
                        str += "<td width='848'>"
                        str += "<select class='select propertyValue' name='propertyValue_"+d.propertyId+"_${skuBo.skuId}' size='1' style='width:200px'>"
                        str += " <option value='1' >次品</option>"
                        str += " <option value='2' >合格品</option>"
                        str += " <option value='3' >精品</option>"
                        str += " </select></td>"
                        str += " </tr>"
                    }
                    $("#propertyTable").append(str)
                })
            }
        })
    })

    function offlineSku(skuid,status) {
        $.ajax({
            url:"${ctx}/sku/offline",
            type:"post",
            data:{
                skuId:skuid,
                offlineStatus:status
            },
            success:function(data){
                alert("上下架成功");
                location.reload();

            }
        })
    }

    function priceTypeChange(data,count){
        if($(data).val() ==1){
            $(data).nextAll().remove()
            var str ="<input type='text' id='priceStart' name='priceStart' placeholder='价格' style='width:150px' class='input-text'> "
            if(count > 1){
                str +=" <input type='button' value='删除' onclick='deleteTr(this);' > "
            }
            $(data).after(str)
        }
        if($(data).val() ==2){
            $(data).nextAll().remove()
            var str ="<input type='text' placeholder='起始价格' id='priceStart' name='priceStart'style='width:150px' class='input-text'><span> ~<span> "
            str +="<input type='text' placeholder='截止价格' id='priceEnd' name='priceEnd'style='width:150px' class='input-text'> "
            if(count > 1){
                str +=" <input type='button' value='删除' onclick='deleteTr(this);' > "
            }
            $(data).after(str)
        }
        if($(data).val() ==3){
            $(data).nextAll().remove()
            if(count > 1){
                var str =" <input type='button' value='删除' onclick='deleteTr(this);' > "
            }
            $(data).after(str)
        }
    }

    $("#saveSku").click(function(){

//            if($("input[name='oq']").length = 2){
        if($("input[name='oq']").eq(1).val()*1<$("input[name='oq']").eq(0).val()*1){
            alert("第二区间的数量必须大于第一区间数量");
            return false
        }
//            }
//            if($("input[name='oq']").length = 3){
        if($("input[name='oq']").eq(2).val()*1 < $("input[name='oq']").eq(1).val()*1){
            alert("第三区间的数量必须大于第二区间数量");
            return false
        }
//            }
        $(".select").each(function(){
            if(!$(this).val()){
                alert("请选满下拉框");
                return false;
            }
        });
        if(!$("#skuNameCn").val()){
            alert("请填写商品标题");
            return false;
        }
        if(!$("#skuNameRu").val()){
            alert("请填写商品标题");
            return false;
        }
        if(!$("#deliveryDay").val()){
            alert("请填写交货期");
            return false;
        }
        if(!$.isNumeric($("#deliveryDay").val())){
            alert("交货期必须填写数字");
            $("#deliveryDay").val("");
            return false;
        }
        if(!$("#moq").val()){
            alert("请填写最小起订量");
            return false;
        }
        if(!$.isNumeric($("#moq").val())){
            alert("最小起订量必须填写数字");
            $("#moq").val("");
            return false;
        }
        if(!$("#validityDate").val()){
            alert("请填写有效期");
            return false;
        }
        if(!$("#website-static10").val()){
            alert("请填写库存量");
            return false;
        }
        if(!$.isNumeric($("#website-static10").val())){
            alert("库存量必须填写数字");
            $("#website-static10").val("");
            return false;
        }
        if($("#priceStart").length > 0) {
            if (!$("#priceStart").val()) {
                alert("请填写起始价格");
                return false;
            }
            if (!$.isNumeric($("#priceStart").val())) {
                alert("起始价格必须填写数字");
                $("#priceStart").val("");
                return false;
            }
        }
        if($("#priceEnd").length > 0){
            if(!$("#priceEnd").val()){
                alert("请填写截止价格");
                return false;
            }
            if(!$.isNumeric($("#priceEnd").val())){
                alert("截止价格必须填写数字");
                $("#priceEnd").val("");
                return false;
            }
        }

        var skuPhotoList = $("#skuImgListId").find("img");
        var skuPhotoListStr =[]
        skuPhotoList.each(function(i,n){
            var photo = {}
            photo.photoUrl=skuPhotoList.eq(i).attr("src")
            photo.resourceCode=skuPhotoList.eq(i).data("code")
            skuPhotoListStr.push(photo)
        })
        $("#photoList").val(JSON.stringify(skuPhotoListStr));
        console.log($("#photoList").val())
//            if(skuPhotoList.length>0){
//                skuPhotoListStr = '"skuPhotoBoList":[';
//                for(var z=0;z < skuPhotoList.length;z++){
//                    var skuPhoto = $(skuPhotoList[z]);
//                    var photoUrl = skuPhoto[0].src;
//                    var resourceCode = skuPhoto.data("code");
//                    skuPhotoListStr += '{"photoUrl":"' + photoUrl;
//                    skuPhotoListStr += '","resourceCode":"' + resourceCode;
//                    skuPhotoListStr += '"},';
//                }
//                skuPhotoListStr = skuPhotoListStr.substr(0, skuPhotoListStr.length - 1);
//                skuPhotoListStr += ']';
//            }

        var priceList=[];
        $("#priceTable tr").each(function(i,n){
            var price = {}
            if(i<1){
                return
            }
            price.oq = $(this).children("td").find("input[name='oq']").val();
            price.priceType = $(this).children("td").find("select[name='priceType']").val();
            price.priceStart = $(this).children("td").find("input[name='priceStart']").val();
            price.priceEnd = $(this).children("td").find("input[name='priceEnd']").val();
            price.productId=$("#productId").val()
            price.shopsId=$("#shopsId").val()
            priceList.push(price);
        })
        $("#priceList").val(JSON.stringify(priceList));
        $("#skuForm").submit()
//        return flag;
    })




    $(document).on("change","#skuLogoId",function(){
        var skuImgSize = $("#skuImgListId").find("img").length;
        if(skuImgSize > 5){
            alert("最多上传6张图片")
            return false;
        }
        var $dom = $(this);
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
            url:'${ctx}/aldUpload/uploadImg',
            secureuri:false,
            fileElementId:id,
            dataType:"json",
            success: function(data){
                if(data.result){
                    var src= data.data.urlPath;
                    var resourceCode =  data.data.resourceCode;
                    var imgStr = '<div><img src="'+src+'"data-code="'+resourceCode+'"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
                    var inputStr = '<input type="button" class="delPhoto" value="删除"/></div>';
                    $("#skuImgListId").append(imgStr+inputStr);
                }else{
                    alert("上传图片失败");
                }
            },error: function (xml, status, e){
                alert("上传图片失败");
            }
        });
    });

    $(document).on("click",".delPhoto",function(){
        var $dom = $(this);
        $dom.parent("div").html("");
    });
</script>


</body>
</html>