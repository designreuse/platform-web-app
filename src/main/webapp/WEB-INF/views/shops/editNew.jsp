<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="odfp" uri="http://www.wl.com/odp-framework/taglibs" %>
<%@include file="/WEB-INF/common/global/common.jsp" %>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>会员中心-会员商铺编辑</title>
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
        <a href="${ctx}/shops/edit/${view.shopsBo.shopsId}">商铺编辑</a>
    </li>
</nav>
<div class="container-fluid">
    <div class="formtable">
        <div class="formtable-nav">
            <ul class="list-inline">
                <li><a href="#baseInfo" class="btn btn-primary">基本信息</a></li>
                <li><a href="#review" class="btn btn-primary">审核</a></li>
                <li class="pull-right">
                    <a href="/purchase/shop/index/${view.shopsBo.shopsId}" target="_blank" class="btn btn-primary">查看商铺（俄文站点）</a>
                    <c:if test="${view.shopsBo.shopsDisabled==true}">
                        <a id="abledBtn" href="#" class="btn btn-success">启用</a>
                    </c:if>
                    <c:if test="${view.shopsBo.shopsDisabled==false}">
                        <a id="disabledBtn" href="#" class="btn btn-danger">停用</a>
                    </c:if>
                </li>
            </ul>
        </div>

        <form id="editForm" class="formtable-cont">
            <input id="shopsId" value="${view.shopsBo.shopsId}" hidden="hidden">
            <input id="userId" value="${view.shopsBo.userId}" hidden="hidden">
            <h4 class="header header-fl" id="baseInfo">基本信息</h4>
            <button id="saveBtn" type="submit" class="btn btn-primary header-button">保存</button>
            <div class="clear"></div>
            <c:if test="${view.shopsBo.orgId!=null}">
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">所属公司：</label>

                        <div class="col-sm-7 col-md-8 label-cont">${view.shopsBo.orgNameCn}</div>
                    </div>
                </div>
            </c:if>
            <c:if test="${view.shopsBo.orgId==null}">
                <div class="formtable-list">
                    <div class="col-xs-6">
                        <label class="col-sm-5 col-md-4 formtable-list-require">所属会员：</label>

                        <div class="col-sm-7 col-md-8 label-cont">${view.shopsBo.mobile}&nbsp;&nbsp;&nbsp;&nbsp;${view.shopsBo.userNameCn}</div>
                    </div>
                </div>
            </c:if>

            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">商铺名称（中文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <input id="shopsNameCn" name="shopsNameCn" value="${view.shopsBo.shopsNameCn}" type="text"
                               class="form-control">
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">商铺名称（俄文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <input id="shopsNameRu" name="shopsNameRu" value="${view.shopsBo.shopsNameRu}" type="text"
                               class="form-control">
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">推广语（俄文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <textarea id="adTxt" name="adTxt" class="form-control" rows="7"><c:if
                                test="${view.shopsBo.adTxt!=null}">${view.shopsBo.adTxt}</c:if></textarea>
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">商铺介绍（俄文）：</label>

                    <div class="col-sm-7 col-md-8">
                        <textarea id="summaryRu" name="summaryRu" class="form-control" rows="7"
                                  placeholder="俄文介绍公司产品、公司实力、业务范围，重点突出商铺主营/热销产品（可帮助买家快速定位商家）、特色卖点/优惠/折扣等；适当添加主营类目名称和关键词，文字通顺；有吸引力的商铺介绍，有助于提升该商铺在搜索引擎中的点击，提升商铺曝光率。"><c:if
                                test="${view.shopsBo.summaryRu!=null}">${view.shopsBo.summaryRu}</c:if></textarea>
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">商铺LOGO：</label>
                    <%-- <div class="col-sm-7 col-md-8 pad_10 hide-input">
                         <a>
                             <c:if test="${view.shopsBo.shopsLogo!=null}">
                                 <img src="${view.shopsBo.shopsLogo}" width="300" height="100" id="shopsLogoSrc" onclick="reOLUploadFro();">

                             </c:if>
                             <c:if test="${view.shopsBo.shopsLogo==null}">
                                 <img src="${ctx}/resources/images/bn.jpg"  width="300" height="100" id="shopsLogoSrc" onclick="reOLUploadFro();">

                             </c:if>
                         </a>
                         <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0" class="btn-uploadpic" name="file" multiple="" id="shopsLogoId">
                         <input class="hide" id="shopsLogo" name="shopsLogo" value="${view.shopsBo.shopsLogo}">
                         <input type="hidden" id="resourceCode" value="${view.shopsBo.resourceCode}">
                         <p class="mar_t10">图片大小支持2MB，图片尺寸为300X100</p>
                     </div>--%>
                    <div class="imgCropBox col-sm-7 col-md-8 pad_10" id="imgCropBox">
                        <c:if test="${view.shopsBo.shopsLogo!=null}">
                            <img src="<odfp:GetImgTag imgUrl='${view.shopsBo.shopsLogo}' height='90' width='210'/>"
                                 alt="" class="imgCropBtn img-responsive"   id="imgCropBtn" style="" data-width="210" data-height="90">
                        </c:if>
                        <c:if test="${view.shopsBo.shopsLogo==null}">
                            <img src="<odfp:GetImgTag imgUrl='http://devimg.51aladdin.com/6fc813be-fb4d-4eaa-a654-373804dd535e.jpg' height='90' width='210'/>"
                                 alt="" class="imgCropBtn img-responsive" id="imgCropBtn" style="" data-width="210" data-height="90">
                        </c:if>
                        <p class="mar_t10">图片大小支持2MB，图片尺寸为210X90</p>
                    </div>
                    <input class="hide" id="shopsLogo" name="shopsLogo" value="${view.shopsBo.shopsLogo}">


                </div>
                <div class="col-xs-6">
                    <button type="button" class="btn btn-primary" id="delLogo">删除商铺Logo</button>
                </div>
            </div>
            <div class="formtable-list mar_b20">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">商铺横幅广告：</label>
                    <%-- <div class="col-sm-7 col-md-8 pad_10 hide-input">
                         <a>
                             <c:if test="${view.shopsBo.bannerLogo!=null}">
                                 <img  width="300" src="${view.shopsBo.bannerLogo}" height="100" id="bannerLogoSrc" onclick="bannerLogoClick();">
                             </c:if>
                             <c:if test="${view.shopsBo.bannerLogo==null}">
                                 <img src="${ctx}/resources/images/bn.jpg" width="300" height="100" id="bannerLogoSrc" onclick="bannerLogoClick();">
                             </c:if>
                         </a>
                         <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0" class="btn-uploadpic" name="file" multiple="" id="bannerLogoId">
                         <input class="hide" id="bannerLogo" name="bannerLogo" value="${view.shopsBo.bannerLogo}">
                         <p class="mar_t10">图片大小支持4MB，图片尺寸为600X100</p>
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
                        <%--<img src="${ctx}/resources/images/bn.jpg" alt="" class="img-responsive"/>--%>
                        <c:if test="${view.shopsBo.bannerLogo!=null}">
                            <img src="${view.shopsBo.bannerLogo}" alt="" class="img-responsive"/>
                        </c:if>
                        <c:if test="${view.shopsBo.bannerLogo==null}">
                            <img src="${ctx}/resources/images/bn.jpg" alt="" class="img-responsive"/>
                        </c:if>

                        <input type="text" value="${view.shopsBo.bannerLogo}" id="bannerLogo" name="bannerLogo" class=" inputVal hide"
                        />
                        <p class="mar_t10">图片大小支持4MB，图片尺寸为1600X120</p>
                    </div>


                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4">横幅广告链接：</label>

                    <div class="col-sm-7 col-md-8">
                        <input id="bannerUrl" value="${view.shopsBo.bannerUrl}" type="text" class="form-control">
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <label class="col-sm-2 formtable-list-require">商铺广告：</label>

                <div id="photoDiv" class="col-sm-10 label-cont">
                    <div class="col-sm-3">
                        <a href="javascript:;" class="pic-upload"><!-- 需要預覽上傳圖片的話，衹需要改變這裡的background-image就可以了 -->
                            <input id="shopsAd" type="file" name="file" onchange="change('')" multiple=""
                                   accept=".jpg, .png">
                        </a>
                    </div>
                  <%-- <div class="imgCropBox col-sm-3 pad_10 " <c:if test="${fn:length(view.shopsAd)>=3}">style="display:none;"</c:if>  id="imgCorpBoxWebApp">
                       <img src="${ctx}/resources/images/btn-upload.png" alt="" class="imgCropBtn img-responsive" id="imgUploadWeb"
                            data-width="192" data-height="38">
                       <p class="mar_t10">图片大小支持2MB，图片尺寸为1920*380</p>
                   </div>--%>

                    <c:forEach var="shopsAd" items="${view.shopsAd}">
                        <div class="col-sm-3">
                            <img class="img-responsive" alt="" name="shopsAd" src="${shopsAd.adLogo}"
                                 style="width: 300px;height: 60px"/>
                            <input name="url" placeholder="如：http://www.51aladdin.com" type="text" class="form-control"
                                   value="${shopsAd.adUrl}">
                            请输入图片url
                            <a href="javascript: void(0)" data-type="web" onclick="removePhoto(this)"
                               class="icon icon-del visible icon-tr"></a>
                        </div>
                    </c:forEach>
                    <div id="photoTip" class="col-xs-12 mar_t20">
                       共可以上传三张图片
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <label class="col-sm-2 formtable-list-require">APP商铺广告：</label>

                <div id="photoDivApp" class="col-sm-10 label-cont">
                    <div class="col-sm-3">
                        <a href="javascript:;" class="pic-upload"><!-- 需要預覽上傳圖片的話，衹需要改變這裡的background-image就可以了 -->
                            <input id="shopsAdApp" type="file" name="file" onchange="change('App')" multiple=""
                                   accept=".jpg, .png">
                        </a>
                    </div>

                      <%-- <div class="imgCropBox col-sm-3" <c:if test="${fn:length(view.shopsAdApp)>=3}">style="display:none;"</c:if>  id="imgCorpBoxApp">
                           <img src="${ctx}/resources/images/btn-upload.png" alt="" class="imgCropBtn img-responsive" id="imgUploadApp"
                                data-width="192" data-height="38">
                           <p class="mar_t10">图片大小支持2MB，图片尺寸为1920*380</p>
                       </div>--%>

                    <c:forEach var="shopsAdApp" items="${view.shopsAdApp}">
                        <div class="col-sm-3">
                            <img class="img-responsive" alt="" name="shopsAdApp" src="${shopsAdApp.adLogo}"
                                 style="width: 300px;height: 60px"/>
                            <input name="url" placeholder="如：http://www.51aladdin.com" type="text" class="form-control"
                                   value="${shopsAdApp.adUrl}">
                            请输入图片url
                            <a href="javascript: void(0)" data-type="app" onclick="removePhoto(this)"
                               class="icon icon-del visible icon-tr"></a>
                        </div>
                    </c:forEach>
                    <div id="photoTipApp" class="col-xs-12 mar_t20">
                        共可以上传三张图片
                    </div>
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
                                    <c:forEach var="item" items="${view.userBoList}">
                                        <c:if test="${view.shopsBo.shopsContacts==item.userId}">
                                            <option value="${item.userId}" selected>${item.userNameCn}</option>
                                        </c:if>
                                        <c:if test="${view.shopsBo.shopsContacts!=item.userId}">
                                            <option value="${item.userId}">${item.userNameCn}</option>
                                        </c:if>
                                    </c:forEach>
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
                                    <c:forEach var="catalog" items="${view.catalogBos}">
                                        <option value="${catalog.catalogId}"
                                                <c:if test="${catalog.catalogId == view.shopsBo.categoryId}">selected="selected" </c:if>>${catalog.catalogNameCn}</option>
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

                                <p class="text-center">
                                    <c:if test="${view.shopsBo.styleModel==1}">
                                        <input type="radio" name="styleModel" value="1" checked> ${styleModel.constName}
                                    </c:if>
                                    <c:if test="${view.shopsBo.styleModel!=1}">
                                        <input type="radio" name="styleModel" value="1"> ${styleModel.constName}
                                    </c:if></p>

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

                                <p class="text-center">
                                    <c:if test="${view.shopsBo.styleModel==2}">
                                        <input type="radio" name="styleModel" value="2" checked> ${styleModel.constName}
                                    </c:if>
                                    <c:if test="${view.shopsBo.styleModel!=2}">
                                        <input type="radio" name="styleModel" value="2"> ${styleModel.constName}
                                    </c:if></p>

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

                                <p class="text-center">
                                    <c:if test="${view.shopsBo.styleModel==3}">
                                        <input type="radio" name="styleModel" value="3" checked> ${styleModel.constName}
                                    </c:if>
                                    <c:if test="${view.shopsBo.styleModel!=3}">
                                        <input type="radio" name="styleModel" value="3"> ${styleModel.constName}
                                    </c:if></p>

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

                                <p class="text-center">
                                    <c:if test="${view.shopsBo.styleModel==4}">
                                        <input type="radio" name="styleModel" value="4" checked> ${styleModel.constName}
                                    </c:if>
                                    <c:if test="${view.shopsBo.styleModel!=4}">
                                        <input type="radio" name="styleModel" value="4"> ${styleModel.constName}
                                    </c:if></p>

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

                                <p class="text-center">
                                    <c:if test="${view.shopsBo.styleModel==5}">
                                        <input type="radio" name="styleModel" value="5" checked> ${styleModel.constName}
                                    </c:if>
                                    <c:if test="${view.shopsBo.styleModel!=5}">
                                        <input type="radio" name="styleModel" value="5"> ${styleModel.constName}
                                    </c:if></p>

                                <div class="theme-style-cont" style="display: none">
                                    <img src="${ctx}/resources/images/theme5.jpg" class="img-responsive"/>
                                </div>
                            </div>

                        </c:if>

                    </c:forEach>


                </div>
            </div>

            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4">商铺状态：</label>

                    <div class="col-sm-7 col-md-8 label-cont">
                        <c:if test="${view.shopsBo.shopsStatus==1}">
                            <span class="icon icon-wait"></span> 待初审
                        </c:if>
                        <c:if test="${view.shopsBo.shopsStatus==2}">
                            <span class="icon icon-right"></span> 审核通过
                        </c:if>
                        <c:if test="${view.shopsBo.shopsStatus==3}">
                            <span class="icon icon-wait"></span> 待审核
                        </c:if>
                        <c:if test="${view.shopsBo.shopsStatus==4}">
                            <span class="icon icon-close"></span> 审核拒绝
                        </c:if>
                    </div>
                </div>
            </div>
        </form>
        <form class="formtable-cont">
            <c:if test="${view.shopsBo.shopsStatus==1 || view.shopsBo.shopsStatus==3}">
                <h4 class="header header-fl" id="review">审核记录</h4>
                <a class="btn btn-primary header-button" data-toggle="modal" data-target="#reviewShop">商铺审核</a>
            </c:if>
            <c:if test="${view.shopsBo.shopsStatus==2 || view.shopsBo.shopsStatus==4}">
                <h4 class="header" id="review">审核记录</h4>
            </c:if>
            <div class="clear"></div>
            <div class="pad_r10 formtable-list">
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>申请人</th>
                        <th>申请内容</th>
                        <th>申请时间</th>
                        <th>状态</th>
                        <th>审核人</th>
                        <th>审核意见</th>
                        <th>审核时间</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="adultLogBo" items="${view.adultLogBoList}">
                        <tr>
                            <td>
                                <c:if test="${adultLogBo.userNameCn!=null}">
                                    ${adultLogBo.userNameCn}
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${adultLogBo.applyContent!=null}">
                                    ${adultLogBo.applyContent}
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${adultLogBo.applyTime!=null}">
                                    <fmt:formatDate value='${adultLogBo.applyTime}' pattern='yyyy-MM-dd HH:mm'/>
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${adultLogBo.adultStatus!=null}">
                                    <c:if test="${adultLogBo.adultStatus==1}">
                                        审核中
                                    </c:if>
                                    <c:if test="${adultLogBo.adultStatus==2}">
                                        审核通过
                                    </c:if>
                                    <c:if test="${adultLogBo.adultStatus==3}">
                                        审核拒绝
                                    </c:if>
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${adultLogBo.adultUserNameCn!=null}">
                                    ${adultLogBo.adultUserNameCn}
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${adultLogBo.adultContent!=null}">
                                    ${adultLogBo.adultContent}
                                </c:if>
                            </td>
                            <td>
                                <c:if test="${adultLogBo.adultTime!=null}">
                                    <fmt:formatDate value='${adultLogBo.adultTime}' pattern='yyyy-MM-dd HH:mm'/>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </form>

    </div>
</div>
<div class="modal fade" id="reviewShop">
    <div class="modal-dialog">
        <form id="shopsAudit">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <%--<a class="btn btn-primary header-button">保存</a>--%>
                    <h4 class="modal-title">审核</h4>
                </div>
                <div class="modal-body text-center">
                    <div class="row">
                        <label class="formtable-list-require col-sm-3">审核意见：</label>

                        <div class="col-sm-8">
                            <textarea id="adultContent" name="adultContent" class="form-control" rows="7"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer text-center">
                    <button onclick="changeAuditStatus(2)" class="btn btn-primary">通过</button>
                    <button onclick="changeAuditStatus(3)" class="btn btn-default">拒绝</button>
                </div>
            </div>
        </form>
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
<script type="text/javascript" src="${ctx}/resources/js/validation/util.js"></script>
<script src="${ctx}/resources/js/uploadCrop/webuploader.min.js"></script>
<script src="${ctx}/resources/js/uploadCrop/cropper.min.js"></script>
<script src="${ctx}/resources/js/uploadCrop/imgCropBtn.js"></script>
<script src="${ctx}/resources/js/imageUpload/SimpleAjaxUploader.min.js"></script>
<script src="${ctx}/resources/js/imageUpload/imgUpLoad.js"></script>
<%--<script >
    var photoCount='${fn:length(view.shopsAd)}';

    var webCount='${fn:length(view.shopsAdApp)}';;
</script>--%>
<script type="text/javascript" src="${ctx}/resources/js/shops/edit.js"></script>


</body>
</html>