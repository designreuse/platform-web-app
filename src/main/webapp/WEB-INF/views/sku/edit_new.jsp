<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>商品中心-商铺商品新增</title>
    <link rel="stylesheet" href="${ctx}/resources/js/uploadCrop/cropper.min.css">
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">商品中心</a>
    </li>
    <li>
        <a href="${ctx}/sku/list">商铺商品管理</a>
    </li>
    <li>
        <a href="${ctx}/sku/edit/${view.skuBo.skuId}">商铺商品编辑</a>
    </li>
</nav>
<div class="container-fluid">
<form id="saveForm" class="formtable">
<input type="hidden" id="skuId" value="${view.skuBo.skuId}">
<input type="hidden" id="unitNameCn" value="${view.productPropertyBo.unitNameCn}">

<input type="hidden" id="catalogIdFirst" value="${view.skuBo.catalogIdFirst}">
<input type="hidden" id="catalogIdSecond" value="${view.skuBo.catalogIdSecond}">
<input type="hidden" id="catalogId" value="${view.skuBo.catalogId}">
<input type="hidden" id="productId" value="${view.skuBo.productId}">
<input type="hidden" id="productNameCn" value="${view.skuBo.productNameCn}">
<input type="hidden" id="skuPhotoCount" value="${view.skuBo.skuPhotoCount}">

<input type="hidden" id="quoteTypeList" value="${view.quoteTypeList}">
<div class="formtable-nav">
    <ul class="list-inline">
        <li><a href="#baseInfo" class="btn btn-primary">基本信息</a></li>
        <li><a href="#commProp" class="btn btn-primary">商品属性</a></li>
        <li><a href="#commPrise" class="btn btn-primary">商品售价</a></li>
        <li><a href="#commDescri" class="btn btn-primary">商品描述</a></li>
        <li class="pull-right">
            <c:if test="${view.skuBo.isOffline==true}">
                <a id="onLineBtn" href="#" class="btn btn-primary">上架</a>
            </c:if>
            <c:if test="${view.skuBo.isOffline==false}">
                <a id="offLineBtn" href="#" class="btn btn-primary">下架</a>
            </c:if>
            <a id="disabledBtn" href="#" class="btn btn-danger">停用</a>
            <a id="deleteBtn" href="#" class="btn btn-danger">删除</a>
        </li>
    </ul>
</div>
<div class="formtable-cont">
    <h4 class="header" id="baseInfo">基本信息</h4>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4 formtable-list-require">商铺名称：</label>
            <div class="col-sm-7 col-md-8">
<%--
                <input class="form-control" id="shopsName" name="shopsName" value="${view.skuBo.shopsNameCn}" placeholder="请输入商铺名称" type="text">
--%>        <ul class="breadcrumb mar_t5">
                <li id="shopsName" name="shopsName">${view.skuBo.shopsNameCn}</li>
            </ul>
                <input type="hidden" name="shopsId"  id="shopsId" value="${view.skuBo.shopsId}" >
            </div>
        </div>
    </div>
    <div class="formtable-list">
        <label class="col-sm-2 formtable-list-require">销售商品：</label>
        <div class="col-sm-10">
            <div class="form-inline">
                <ul class="breadcrumb mar_t5">
                    <li value="${view.skuBo.catalogIdFirst}">${view.skuBo.catalog1NameCn}</li>
                    <li value="${view.skuBo.catalogIdSecond}">${view.skuBo.catalog2NameCn}</li>
                    <li value="${view.skuBo.catalogId}">${view.skuBo.catalog3NameCn}</li>
                    <li value="${view.skuBo.productId}">${view.skuBo.productNameCn}</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4 formtable-list-require">商品标题（中文）：</label>
            <div class="col-sm-7 col-md-8">
                <input id="skuNameCn" name="skuNameCn" value="${view.skuBo.skuNameCn}" class="form-control" type="text">
            </div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4 formtable-list-require">商品标题（俄文）：</label>
            <div class="col-sm-7 col-md-8">
                <input id="skuNameRu" name="skuNameRu" value="${view.skuBo.skuNameRu}" class="form-control" type="text">
            </div>
        </div>
    </div>
    <%--<div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4 formtable-list-require">交货地：</label>
            <div class="col-sm-7 col-md-8">
                <select id="deliveryCityId" class="form-control wid-120">
                    <c:forEach var="deliveryAddr" items="${view.deliveryAddrList}">
                        <c:if test="${deliveryAddr.constName!='全部'}">
                            <option value="${deliveryAddr.constValue}">${deliveryAddr.constName}</option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>
        </div>
    </div>--%>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4 formtable-list-require">交货地：</label>
            <div class="col-sm-7 col-md-8">
                <select id="deliveryCityId" class="form-control wid-120">
                    <c:forEach var="deliveryAddr" items="${view.deliveryAddrList}">
                        <c:if test="${deliveryAddr.constValue == view.skuBo.deliveryCityId}">
                            <option value="${deliveryAddr.constValue}" selected>${deliveryAddr.constName}</option>
                        </c:if>
                        <c:if test="${deliveryAddr.constValue != view.skuBo.deliveryCityId}">
                            <option value="${deliveryAddr.constValue}">${deliveryAddr.constName}</option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4 formtable-list-require">交货期：</label>
            <div class="col-sm-7 col-md-8">
                <div class="form-inline">
                    <div class="form-group">
                        <input id="deliveryDay" name="deliveryDay" value="${view.skuBo.deliveryDay}"   type="text" class="form-control wid-120"> 天
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4 formtable-list-require">最小起订量：</label>
            <div class="col-sm-7 col-md-8">
                <div class="form-inline">
                    <div class="form-group">
                        <input id="moq" name="moq" value="<fmt:formatNumber value="${view.skuBo.moq}" pattern="######.##"/>" class="form-control wid-120" type="text">
                        <span id="moqUnitNameCn">${view.productPropertyBo.unitNameCn}</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4 formtable-list-require">库存量：</label>
            <div class="col-sm-7 col-md-8">
                <div class="form-inline">
                    <div class="form-group">
                        <input id="stockNum" name="stockNum" value="<fmt:formatNumber value="${view.skuBo.stockNum}" pattern="######.##"/>" class="form-control wid-120" type="text">
                        <span id="stockNumUnitNameCn">${view.productPropertyBo.unitNameCn}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4 formtable-list-require">有效期：</label>
            <div class="col-sm-7 col-md-8">
                <div class="input-group datepicker date col-xs-6 mar_l5" id="validityDateId">
                    <input id="validityDate" name="validityDate" value="<fmt:formatDate value='${view.skuBo.validityDate}' pattern='yyyy-MM-dd'/>" type="text" class="form-control"  style="margin: 0px;">
                    <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
                </div>
            </div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-sm-5 col-md-4">
            <label class="col-sm-6">俄站首页热销商品：</label>
            <div class="col-sm-6">
                <c:if test="${view.skuBo.isHomepage == true}">
                    <label class="radio-inline">
                        <input type="radio" name="isHomepage" value="1" checked> 是
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="isHomepage" value="0"> 否
                    </label>
                </c:if>
                <c:if test="${view.skuBo.isHomepage == false}">
                    <label class="radio-inline">
                        <input type="radio" name="isHomepage" value="1" > 是
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="isHomepage" value="0" checked> 否
                    </label>
                </c:if>
                <c:if test="${view.skuBo.isHomepage == null}">
                    <label class="radio-inline">
                        <input type="radio" name="isHomepage" value="1" > 是
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="isHomepage" value="0" checked> 否
                    </label>
                </c:if>
            </div>
        </div>
        <div class="col-sm-5 col-md-4">
            <label class="col-sm-5">热门商品：</label>
            <div class="col-sm-7">
                <c:if test="${view.skuBo.isHot == true}">
                    <label class="radio-inline">
                        <input type="radio" name="isHot" value="1" checked> 是
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="isHot" value="0"> 否
                    </label>
                </c:if>
                <c:if test="${view.skuBo.isHot == false}">
                    <label class="radio-inline">
                        <input type="radio" name="isHot" value="1" > 是
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="isHot" value="0" checked> 否
                    </label>
                </c:if>
            </div>
        </div>
        <div class="col-sm-5 col-md-4">
            <label class="col-sm-5">促销：</label>
            <div class="col-sm-7">
                <c:if test="${view.skuBo.isSales == true}">
                    <label class="radio-inline">
                        <input type="radio" name="isSales" value="1" checked> 是
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="isSales" value="0"> 否
                    </label>
                </c:if>
                <c:if test="${view.skuBo.isSales == false}">
                    <label class="radio-inline">
                        <input type="radio" name="isSales" value="1" > 是
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="isSales" value="0" checked> 否
                    </label>
                </c:if>
            </div>
        </div>
    </div>
    <div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4 formtable-list-require">SKU状态：</label>
            <div class="col-sm-7 col-md-8 pad_10">
                <c:if test="${view.skuBo.skuStatus=='1'}">
                    <span class="icon icon-wait"></span> 待初审
                    <button  type="button" onclick="checkStatus(1)" class="btn btn-primary btn-sm">审核通过</button>
                    <button  type="button" onclick="checkStatus(0)" class="btn btn-default btn-sm">审核不通过</button>
                </c:if>
                <c:if test="${view.skuBo.skuStatus=='2'}">
                    <span class="icon icon-right"></span> 审核通过
                </c:if>
                <c:if test="${view.skuBo.skuStatus=='3'}">
                    <span class="icon icon-wait"></span> 待审核
                    <button name="checkPass" type="button" onclick="checkStatus(1)" class="btn btn-primary btn-sm">审核通过</button>
                    <button name="checkNoPass" type="button" onclick="checkStatus(0)" class="btn btn-default btn-sm">审核不通过</button>
                </c:if>

                <c:if test="${view.skuBo.skuStatus=='4'}">
                    <span class="icon icon-close"></span> 审核未通过
                    <button name="checkPass" type="button" onclick="checkStatus(1)" class="btn btn-primary btn-sm">审核通过</button>
                </c:if>

            </div>
        </div>
    </div>
</div>
<div id="productPropertyId" class="formtable-cont">
    <h4 class="header" id="commProp">商品属性</h4>
    <c:forEach var="productPropertyBo" items="${view.productPropertyBo.productPropertyBoList}">
        <div class="formtable-list">
            <div class="col-xs-6">
                <label class="col-sm-5 col-md-4 formtable-list-default">${productPropertyBo.propertyNameCn}：</label>
                <div class="col-sm-7 col-md-8">
                <c:set var="id" value="" />
                <c:set var="val" value="" />
                <c:set var="id" value="${productPropertyBo.propertyId}" />
                <c:forEach var="skuPropertyBo" items="${view.skuBo.skuPropertyBoList}" >
                    <c:if test="${skuPropertyBo.propertyId == productPropertyBo.propertyId}">
                        <c:set var="val" value="${skuPropertyBo.propertyValue}" />
                    </c:if>
                    <%--<c:if test="${productPropertyBo.propertyId != skuPropertyBo.propertyId}">
                        <c:set var="id" value="${productPropertyBo.propertyId}" />
                        <c:set var="val" value="" />
                    </c:if>--%>
                </c:forEach>
                <input class="form-control" id="${id}"  value="${val}" />
                </div>
            </div>
        </div>
    </c:forEach>
    <%--<div class="formtable-list">
        <div class="col-xs-6">
            <label class="col-sm-5 col-md-4 formtable-list-require">产品：</label>
            <div class="col-sm-7 col-md-8">
                <input class="form-control" type="text">
            </div>
        </div>
    </div>--%>
</div>
<div  class="formtable-cont comm-price">
    <h4 class="header header-fl" id="commPrise">商品售价</h4>
    <button type="button" class="btn btn-primary header-button add-interval">新增区间</button>
    <div class="clear"></div>
    <div class="formtable-list">
        <div class="col-xs-4">
            <label class="col-sm-5 col-md-4">币种：</label>
            <div class="col-sm-7 col-md-8">
                <select id="costType" class="form-control wid-120">
                    <c:forEach var="currencyType" items="${view.currencyTypeList}">
                        <c:if test="${currencyType.constValue == view.skuBo.costType}">
                            <option value="${currencyType.constValue}" selected>${currencyType.constName}</option>
                        </c:if>
                        <c:if test="${currencyType.constValue != view.skuBo.costType}">
                            <option value="${currencyType.constValue}">${currencyType.constName}</option>
                        </c:if>
                    </c:forEach>
                </select>
            </div>
        </div>
    </div>
    <div id="saleContent">

    </div>

</div>
<div class="formtable-cont product-pic">
    <h4 class="header" id="commDescri">商品描述</h4>
    <div class="formtable-list">
        <label class="col-md-2 formtable-list-require">产品图片：</label>
        <div id="photoDiv" class="col-sm-10 label-cont">
          <%--  <div class="col-sm-3">
                <a href="javascript:;" class="pic-upload"><!-- 需要預覽上傳圖片的話，衹需要改變這裡的background-image就可以了 -->
                    <input id="skuLogoId" type="file" name="file" onchange="change()" multiple="" accept=".jpg, .png">
                </a>
            </div> --%>

             <div class="imgCropBox col-sm-2" id="imgCropBox" <c:if test="${fn:length(view.skuBo.skuPhotoBoList)>=6}">style="display: none;" </c:if> >
                  <img src="${ctx}/resources/images/btn-upload.png" alt="" class="imgCropBtn img-responsive" id="imgCropBtn" data-width="400" data-height="400">
              </div>


            <c:forEach var="skuPhotoBo" items="${view.skuBo.skuPhotoBoList}">
                <div class="col-sm-2">
                    <img class="img-responsive" alt="" <%--id="${skuPhotoBo.resourceCode}"--%> name="skuLogo" src="${skuPhotoBo.photoUrl}"/>
                    <a href="javascript: void(0)" class="icon icon-del visible icon-tr"></a>
                </div>
            </c:forEach>



            <div id="photoTip" class="col-xs-12 mar_t20">
                图片大小支持2MB，图片尺寸为400X400
                <br>你还可以上传6/6张图片
            </div>
        </div>
    </div>
    <div class="formtable-list">
        <label class="col-md-2">产品简述(中文)：</label>
        <div class="col-sm-9 label-cont">
            <textarea name="skuSimpleDesc" id="skuSimpleDesc" class="form-control" rows="7" placeholder="商品参数，如：颜色、尺寸、款式、配件、贸易方式等。">${view.skuBo.skuSimpleDesc}</textarea>
        </div>
    </div>
    <div class="formtable-list">
        <label class="col-md-2">产品简述(俄文)：</label>
        <div class="col-sm-9 label-cont">
            <textarea name="skuSimpleDescRu" id="skuSimpleDescRu" class="form-control" rows="7" placeholder="商品参数，如：颜色、尺寸、款式、配件、贸易方式等。">${view.skuBo.skuSimpleDescRu}</textarea>
        </div>
    </div>
    <div class="formtable-list">
        <label class="col-md-2 formtable-list-require">产品详情(中文)：</label>
        <div class="col-sm-9">
            <textarea   class="hide-textare" style="width:100%;" id="myEditor" name="myEditor">${view.skuBo.skuDesc}</textarea>
        </div>
    </div>
    <div class="formtable-list">
        <label class="col-md-2 formtable-list-require">产品详情(俄文)：</label>
        <div class="col-sm-9">
            <textarea   class="hide-textare" style="width:100%;" id="myEditorRu" name="myEditorRu">${view.skuBo.skuDescRu}</textarea>
        </div>
    </div>
</div>
<div class="formtable-cont text_c mar_t20">
    <button class="btn btn-primary" type="submit" id="saveBtn">保存</button>
</div>
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

</div><%--百度编辑器开始--%>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
<link href="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/umeditor.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/umeditor1_2_2-utf8-jsp/lang/zh-cn/zh-cn.js"></script>
<%--百度编辑器结束--%>

<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script src="${ctx}/resources/js/uploadCrop/webuploader.min.js"></script>
<script src="${ctx}/resources/js/uploadCrop/cropper.min.js"></script>
<script src="${ctx}/resources/js/uploadCrop/imgCropBtn.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/sku/edit_new.js"></script>
</body>
</html>