<%@ taglib prefix="odfp" uri="http://www.wl.com/odp-framework/taglibs" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/common/global/common.jsp" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>会员中心-会员商铺新增</title>
    <link rel="stylesheet" href="${ctx}/resources/js/uploadCrop/cropper.min.css">
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">会员中心</a>
    </li>
    <li>
        <a href="${ctx}/shops/list">商铺管理</a>
    </li>
    <li>
        <a href="${ctx}/shops/add">商铺新增</a>
    </li>
</nav>
<div class="container-fluid">
    <div class="formtable">
        <form id="addForm" class="formtable-cont">
            <h4 class="header" id="baseInfo">基本信息</h4>

            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">关系：</label>

                    <div class="col-sm-7 col-md-8 mar_t5 select-label">
                        <label id="iden0" class="btn btn-primary">
                            <input type="radio" name="iden" value="1" checked> 隶属
                        </label>
                        <label id="iden1" class="btn btn-default">
                            <input type="radio" name="iden" value="2"> 个人
                        </label>
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div id="orgOrPersonParent">
                    <div class="orgOrPerson col-xs-6">
                        <label name="orgNameFlag" class="col-sm-5 col-md-4 formtable-list-require">所属公司：</label>

                        <div name="orgNameFlag" class="col-sm-7 col-md-8 hide-input">
                            <input id="orgName" placeholder="模糊搜索 选取结果" type="text" class="form-control">
                            <input id="orgId" name="orgId" class="hide"/>
                            <input id="adminUser" name="orgId" class="hide"/><%--管理人ID（用户ID）--%>
                        </div>
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">商铺名称（中文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <input id="shopsNameCn" name="shopsNameCn" type="text" class="form-control">
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">商铺名称（俄文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <input id="shopsNameRu" name="shopsNameRu" type="text" class="form-control">
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">商铺介绍（中文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <textarea id="adTxt" name="adTxt" class="form-control" rows="7"></textarea>
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">商铺介绍（俄文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <textarea id="summaryRu" name="summaryRu" class="form-control" rows="7"
                                  placeholder="俄文介绍公司产品、公司实力、业务范围，重点突出商铺主营/热销产品（可帮助买家快速定位商家）、特色卖点/优惠/折扣等；适当添加主营类目名称和关键词，文字通顺；有吸引力的商铺介绍，有助于提升该商铺在搜索引擎中的点击，提升商铺曝光率。"></textarea>
                    </div>
                </div>
            </div>
            <div class="formtable-list mar_b20">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">商铺LOGO：</label>
                    <%--<div class="col-sm-7 col-md-8 pad_10 hide-input">
                        <img src="http://devimg.51aladdin.com/6fc813be-fb4d-4eaa-a654-373804dd535e.jpg" width="300" height="100" id="shopsLogoSrc" onclick="reOLUploadFro();">
                        <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0" class="btn-uploadpic form-control" name="file" multiple="" id="shopsLogoId">
                        <input class="hide" id="shopsLogo" name="shopsLogo" value="http://devimg.51aladdin.com/6fc813be-fb4d-4eaa-a654-373804dd535e.jpg">
                        <input type="hidden" id="resourceCode">
                        <p class="mar_t10">图片大小支持2MB，图片尺寸为182X63</p>
                    </div>--%>
                    <div class="imgCropBox col-sm-7 col-md-8 pad_10" id="imgCropBox">
                        <img src="<odfp:GetImgTag imgUrl='http://devimg.51aladdin.com/6fc813be-fb4d-4eaa-a654-373804dd535e.jpg' height='90' width='210'
                         />" alt="" class="imgCropBtn img-responsive" id="imgCropBtn"
                             style=""  data-width="210" data-height="90" >
                        <p class="mar_t10">图片大小支持2MB，图片尺寸为210X90</p>
                    </div>
                    <input class="hide" id="shopsLogo" name="shopsLogo"
                           value="http://devimg.51aladdin.com/6fc813be-fb4d-4eaa-a654-373804dd535e.jpg">

                </div>
                <div class="col-xs-6">
                    <button type="button" class="btn btn-primary" id="delLogo">删除商铺Logo</button>
                </div>
            </div>
            <div class="formtable-list mar_b20">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">商铺横幅广告：</label>
                    <%-- <div class="col-sm-7 col-md-8 pad_10 hide-input">
                         <img src="${ctx}/resources/images/bn.jpg" width="300" height="100" id="bannerLogoSrc" onclick="bannerLogoClick();">
                         <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0" class="btn-uploadpic form-control" name="file" multiple="" id="bannerLogoId">
                         <input class="hide" id="bannerLogo" name="bannerLogo">
                         <p class="mar_t10">图片大小支持4MB，图片尺寸为1600X120</p>
                     </div>--%>

                    <div class="uploadModal col-sm-7 col-md-8 pad_10" style="width: 300px;height: 100px;">
                        <span class="uploadBtn"></span>

                        <div class="progress progress-striped active" style="display:none;">
                            <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="45"
                                 aria-valuemin="0" aria-valuemax="100" style="width: 0%"></div>
                        </div>
                        <div class="showModal">
                            <div class="addBtn"></div>
                        </div>
                        <img src="${ctx}/resources/images/bn.jpg"
                             alt="" class="img-responsive"/>
                        <input type="text" value="" id="bannerLogo" name="bannerLogo" class=" inputVal hide"
                        />

                        <p class="mar_t10">图片大小支持4MB，图片尺寸为1600X120</p>
                    </div>


                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4">横幅广告链接：</label>

                    <div class="col-sm-7 col-md-8">
                        <input id="bannerUrl" type="text" class="form-control">
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <label class="col-sm-2 formtable-list-require">商铺广告：</label>

                <div id="photoDiv" class="col-sm-10 label-cont">
                      <div class="col-sm-3">
                          <a href="javascript:;" class="pic-upload"><!-- 需要預覽上傳圖片的話，衹需要改變這裡的background-image就可以了 -->
                              <input id="shopsAd" type="file" name="file" onchange="change('')" multiple="" accept=".jpg, .png">
                          </a>
                      </div>

                  <%--  <div class="imgCropBox col-sm-3 pad_10" id="imgCorpBoxWebApp">
                        <img src="${ctx}/resources/images/btn-upload.png" alt="" class="imgCropBtn img-responsive"
                             id="imgUploadWeb" data-width="192" data-height="38">

                        <p class="mar_t10">图片大小支持2MB，图片尺寸为1920*380</p>
                    </div>--%>

                    <div id="photoTip" class="col-xs-12 mar_t20">
                        你还可以上传3/3张图片
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <label class="col-sm-2 formtable-list-require">APP商铺广告：</label>

                <div id="photoDivApp" class="col-sm-10 label-cont">
                     <div class="col-sm-3">
                         <a href="javascript:;" class="pic-upload"><!-- 需要預覽上傳圖片的話，衹需要改變這裡的background-image就可以了 -->
                             <input id="shopsAdApp" type="file" name="file" onchange="change('App')" multiple="" accept=".jpg, .png">
                         </a>
                     </div>
                     <div id="photoTipmobApp" class="col-xs-12 mar_t20">
                         图片大小支持2MB，图片尺寸为750*148
                         <br>你还可以上传3/3张图片
                     </div>
                    <%--<div class="imgCropBox col-sm-3 pad_10" id="imgCorpBoxApp">
                        <img src="${ctx}/resources/images/btn-upload.png" alt="" class="imgCropBtn img-responsive"
                             id="imgUploadApp"
                             data-width="192" data-height="38">

                        <p class="mar_t10">图片大小支持2MB，图片尺寸为1920*380</p>
                    </div>
                    <div id="photoTipApp" class="col-xs-12 mar_t20">
                        你还可以上传3/3张图片
                    </div>--%>
                </div>
            </div>
            <div class="formtable-list" name="shopsContactsDiv">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">商铺联系人：</label>

                    <div class="col-sm-7 col-md-8">
                        <div class="form-inline">
                            <div class="form-group">
                                <select id="shopsContacts" name="shopsContacts" class="form-control">
                                    <option value="">请选择</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">商铺品类：</label>

                    <div class="col-sm-7 col-md-8">
                        <div class="form-inline">
                            <div class="form-group">
                                <select id="categoryId" name="categoryId" class="form-control">
                                    <c:forEach var="catalog" items="${view.catalogs}">
                                        <option value="${catalog.catalogId}">${catalog.catalogNameCn}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <label class="col-sm-2">配色风格：</label>

                <div class="col-sm-10 mar_t10">

                    <c:forEach var="styleModel" items="${view.styleModelList}">

                    <c:if test="${styleModel.constValue==1}">
                        <div class="col-xs-2" style="width: 10%;">
                            <img src="${ctx}/resources/images/shop1.jpg" width="64" height="64"
                                 class="img-thumbnail theme-style" data-toggle="popover" data-trigger="hover"
                                 data-original-title="" title="">

                            <p class="text-center"><input type="radio" name="styleModel" value="1"
                                                          checked>${styleModel.constName}</p>

                            <div class="theme-style-cont" style="display: none">
                                <img src="${ctx}/resources/images/theme1.jpg" class="img-responsive"/>
                            </div>
                        </div>

                    </c:if>

                    <c:if test="${styleModel.constValue==2}">
                        <div class="col-xs-2" style="width: 10%;">
                            <img src="${ctx}/resources/images/shop2.jpg" width="64" height="64"
                                 class="img-thumbnail theme-style" data-toggle="popover" data-trigger="hover"
                                 data-original-title="" title="">

                            <p class="text-center"><input type="radio" name="styleModel"
                                                          value="2">${styleModel.constName}</p>

                            <div class="theme-style-cont" style="display: none">
                                <img src="${ctx}/resources/images/theme2.jpg" class="img-responsive"/>
                            </div>
                        </div>

                    </c:if>

                    <c:if test="${styleModel.constValue==3}">
                        <div class="col-xs-2" style="width: 10%;">
                            <img src="${ctx}/resources/images/shop3.jpg" width="64" height="64"
                                 class="img-thumbnail theme-style" data-toggle="popover" data-trigger="hover"
                                 data-original-title="" title="">

                            <p class="text-center"><input type="radio" name="styleModel"
                                                          value="3">${styleModel.constName}</p>

                            <div class="theme-style-cont" style="display: none">
                                <img src="${ctx}/resources/images/theme3.jpg" class="img-responsive"/>
                            </div>
                        </div>

                    </c:if>
                    <c:if test="${styleModel.constValue==4}">
                        <div class="col-xs-2" style="width: 10%;">
                            <img src="${ctx}/resources/images/shop4.jpg" width="64" height="64"
                                 class="img-thumbnail theme-style" data-toggle="popover" data-trigger="hover"
                                 data-original-title="" title="">

                            <p class="text-center"><input type="radio" name="styleModel"
                                                          value="2">${styleModel.constName}</p>

                            <div class="theme-style-cont" style="display: none">
                                <img src="${ctx}/resources/images/theme4.jpg" class="img-responsive"/>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${styleModel.constValue==5}">
                    <div class="col-xs-2" style="width: 10%;">
                        <img src="${ctx}/resources/images/shop5.jpg" width="64" height="64"
                             class="img-thumbnail theme-style" data-toggle="popover" data-trigger="hover"
                             data-original-title="" title="">

                        <p class="text-center"><input type="radio" name="styleModel" value="5">${styleModel.constName}
                        </p>

                        <div class="theme-style-cont" style="display: none">
                            <img src="${ctx}/resources/images/theme5.jpg" class="img-responsive"/>
                        </div>
                    </div>
                </div>
                </c:if>

                </c:forEach>


            </div>
            <div class="text-center mar_t20">
                <%--<a id="saveBtn" href="#" class="btn btn-primary btn-sm wid-60">保存</a>--%>

                <button id="saveBtn" type="submit" class="btn btn-primary">保存</button>
            </div>
        </form>
    </div>
</div>
<div class="modal fade" id="reviewShop">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">审核</h4>
            </div>
            <div class="modal-body text-center">
                <div class="row">
                    <label class="formtable-list-require col-sm-3">审核意见：</label>

                    <div class="col-sm-8">
                        <textarea class="form-control" rows="7"></textarea>
                    </div>
                </div>
            </div>
            <div class="modal-footer text-center">
                <button type="button" class="btn btn-primary">通过</button>
                <button type="button" class="btn btn-default">拒绝</button>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/common/global/footer.jsp" %>


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
                <button type="button" class="btn btn-primary imgUploadFile">上传</button>
                <button type="button" class="btn btn-primary imgUploadRetry">重试</button>
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
<script type="text/javascript" src="${ctx}/resources/js/shops/add.js"></script>
</body>
</html>