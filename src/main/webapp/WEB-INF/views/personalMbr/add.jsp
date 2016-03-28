<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>会员中心-个人会员新建</title>
    <%@include file="/WEB-INF/common/global/common.jsp" %>
    <link rel="stylesheet" href="${ctx}/resources/js/uploadCrop/cropper.min.css">
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">会员中心</a>
    </li>
    <li>
        <a href="${ctx}/personalMbr/list">个人会员管理</a>
    </li>
    <li>
        <a href="${ctx}/personalMbr/add">个人会员新增</a>
    </li>
</nav>
<form class="container-fluid" id="addUserForm" action="${ctx}/personalMbr/addNewUser" method="post">
<div class="formtable">
<div class="formtable-cont">
<h4 class="header" id="baseInfo">基本信息</h4>
<div class="formtable-list">
        <label class="col-sm-2 formtable-list-require">注册平台：</label>
        <div class="col-sm-10 label-cont">
            <label class="radio-inline">
                <input type="radio" name="regSource" value="3" checked="checked"> 中文站点
            </label>
            <label class="radio-inline">
                <input type="radio" name="regSource" value="5" > 俄文站点
            </label>
            <label class="radio-inline">
                <input type="radio" name="regSource" value="2" > 运营平台
            </label>
        </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4 formtable-list-require">关系：</label>
        <div class="col-sm-7 col-md-8">
            <label class="radio-inline">
                <input type="radio" name="entUserStatus" value="1" checked="checked"> 隶属
            </label>
            <label class="radio-inline">
                <input type="radio" name="entUserStatus" value="2"> 个人
            </label>
        </div>
    </div>
</div>
   <span id="noneOrSingleHide">
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">所属公司：</label>

                    <div class="col-sm-7 col-md-8">
                        <div class="form-inline">
                            <div class="form-group hide-input" >
                                <input type="text" class="form-control"  id="searchOrg" name="orgName">
                                <input type="text" name="orgId" id="dealingsOrgId" class="hide">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4">服务执行部门：</label>
                    <div class="col-sm-7 col-md-8">
                        <select class="form-control" id="ownerDepart" name="deptId">
                            <option value="">无</option>
                        </select>
                    </div>
                </div>
            </div>


        </span>

<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4 formtable-list-require">姓名（中文）：</label>
        <div class="col-sm-7 col-md-8">
            <input type="text" class="form-control" name="userNameCn" >
        </div>
    </div>
</div>
<div class="formtable-list">
        <label class="col-sm-2">姓名（俄/英）：</label>
        <div class="col-sm-10">
            <div class="col-sm-4">
                <div class="form-inline">
                    <label>First Name</label>
                    <div class="form-group">
                        <input type="text" class="form-control wid-150" name="ruName1">
                        <input type="hidden"  name="userNameFirst">
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="form-inline">
                    <div class="form-group">
                        <label>Middle Name</label>
                        <input type="text" class="form-control wid-150" name="ruName2">
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="form-inline">
                    <div class="form-group">
                        <label>Last Name</label>
                        <input type="text" class="form-control wid-150" name="ruName3">
                    </div>
                </div>
            </div>
        </div>
</div>
<div class="formtable-list">
        <label class="col-sm-2">头像：</label>
        <div class="col-sm-7 col-md-8 select-label label-cont">
           <%-- <div class="col-xs-5">
                <img src="${ctx}/resources/images/bn.jpg" class="img-responsive"/>
                <input type="file" style="display: none">
                <input type="hidden" name="personHeadPhoto">
            </div>--%>
               <div class="imgCropBox" id="imgCropBox" style="height: 200px;width: 200px;">
                       <img src="${ctx}/resources/images/bn.jpg" alt="" class="imgCropBtn" id="imgCropBtn"
                            data-width="300" data-height="300">
                   <input type="text" name="personHeadPhoto" id="personHeadPhoto" class="hide imgCropInput"/>
               </div>
        </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4">生日：</label>
        <div class="col-sm-7 col-md-8">
            <div class="input-group datepicker date mar_l5">
                <input type="text" class="form-control" name="birthday"   style="margin: 0px;">
                <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
            </div>
        </div>
    </div>
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4">性别：</label>
        <div class="col-sm-7 col-md-8 label-cont">
            <input type="radio" name="sex" value="1" checked="checked"> 男
            <input type="radio" name="sex" value="2"> 女
        </div>
    </div>
</div>
<div class="formtable-list">
    <label class="col-sm-2">电话：</label>
    <div class="col-sm-10">
        <div class="form-inline">
            <div class="form-group">
                <input type="text" class="form-control" placeholder="国家" name="telCountry">
            </div>
            --
            <div class="form-group">
                <input type="text" class="form-control" placeholder="区号" name="telZone">
            </div>
            --
            <div class="form-group">
                <input type="text" class="form-control" placeholder="电话号码" name="tel">
            </div>
            --
            <div class="form-group">
                <input type="text" class="form-control" placeholder="分机" name="telExt">
            </div>
        </div>
    </div>
</div>
<div class="formtable-list">
    <label class="col-sm-2">传真：</label>
    <div class="col-sm-10">
        <div class="form-inline">
            <div class="form-group">
                <input type="text" class="form-control" name="faxCountry" placeholder="国家">
            </div>
            --
            <div class="form-group">
                <input type="text" class="form-control" name="faxZone" placeholder="区号">
            </div>
            --
            <div class="form-group">
                <input type="text" class="form-control" name="fax" placeholder="电话号码">
            </div>
            --
            <div class="form-group">
                <input type="text" class="form-control" name="faxExt" placeholder="分机">
            </div>
        </div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4  formtable-list-require">手机（登录名）：</label>
        <div class="col-sm-7 col-md-8">
            <input type="text" class="form-control" name="mobile">
        </div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4">邮箱：</label>
        <div class="col-sm-7 col-md-8">
            <input type="text" class="form-control" name="email">
        </div>
    </div>
</div>
<div class="formtable-list">
    <label class="col-sm-2 formtable-list-require">登录密码：</label>
    <div class="col-sm-10">
        <div class="col-xs-6 col-sm-4 mar_l-15">
            <input type="password" class="form-control" name="password">
        </div>
    </div>
</div>
<div class="formtable-list">
        <label class="col-sm-2">居住地址：</label>
        <div class="col-sm-10">
            <div class="form-inline">
                <div class="form-group">
                    <select class="form-control" id="countryId" name="countryId" >
                        <option value="">--国家--</option>
                        <c:forEach items="${personalMbrView.countryList}" var="ctr">
                            <option value="${ctr.constValue}"
                                    >${ctr.constName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <select class="form-control" id="provinceId" name="provId" >
                        <option value="">--省份--</option>
                        <c:forEach items="${personalMbrView.provinceBoList}" var="pro">
                            <option value="${pro.id}"
                                    >${pro.cnname}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <select class="form-control" id="cityId" name="cityId">
                        <option value="">--市/地区--</option>
                    </select>
                </div>
                <div class="form-group">
                    <select class="form-control" id="districtId" name="distId">
                        <option value="">--区/县--</option>
                    </select>
                </div>
                <input type="text" class="form-control" name="address" placeholder="请输入详细地址">
            </div>
        </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4">身份证号：</label>
        <div class="col-sm-7 col-md-8">
            <input type="text" class="form-control" name="idcard">
        </div>
    </div>
</div>
<div class="formtable-list">
        <label class="col-sm-2">身份证：</label>

        <div class="col-sm-10">
            <div class="col-sm-4">
                <div class="inden-pic">
                    <p>身份证正面</p>
                  <%--  <div class="reload-pic">
                        <img type="upload" src="${ctx}/resources/images/bn.jpg" class="img-responsive" alt="">
                        <input type="file" style="display: none">
                        <input type="hidden" name="idcardPathFront" class="btn-uploadpic mar_t10">
                    </div>--%>

                    <div class="uploadModal" style="width: 180px;height: 114px;">
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
                        <input type="text" value="" name="idcardPathFront"
                               class=" inputVal hide"
                               id="idcardPathFront"/>
                    </div>

                </div>
            </div>
            <div class="col-sm-4">
                <div class="inden-pic">
                    <p>身份证反面</p>

                    <%--<div class="reload-pic">
                        <img type="upload" src="${ctx}/resources/images/bn.jpg" class="img-responsive" alt="">
                        <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0">
                        <input type="hidden" name="idcardPathBack" class="btn-uploadpic mar_t10">
                    </div>--%>

                    <div class="uploadModal" style="width: 180px;height: 114px;">
                        <span class="uploadBtn"></span>

                        <div class="progress progress-striped active" style="display:none;">
                            <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="45"
                                 aria-valuemin="0" aria-valuemax="100" style="width: 0%"></div>
                        </div>
                        <div class="showModal">
                            <div class="addBtn"></div>
                        </div>
                        <img src="${ctx}/resources/images/bn.jpg" alt=""
                             class="img-responsive"/>
                        <input type="text" value="" name="idcardPathBack" class=" inputVal hide"
                               id="idcardPathBack"/>
                    </div>

                </div>
            </div>
            <div class="col-sm-4">
                <div class="inden-pic">
                    <p>本人手持身份证合影</p>
                    <%--<div class="reload-pic">

                        <img src="${ctx}/resources/images/bn.jpg" class="img-responsive" alt="">
                        <input type="file" style="display: none">
                        <input type="hidden" name="idcardPathUser" class="btn-uploadpic mar_t10">
                    </div>--%>
                    <div class="uploadModal" style="width: 180px;height: 114px;" >
                        <span class="uploadBtn" ></span>
                        <div  class="progress progress-striped active" style="display:none;">
                            <div  class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 0%"></div>
                        </div>
                        <div class="showModal">
                            <div class="addBtn"></div>
                        </div>
                        <img  src="${ctx}/resources/images/bn.jpg"
                              alt="" class="img-responsive" />
                        <input type="text" value="" name="idcardPathUser" class=" inputVal hide"
                               id="idcardPathUser"/>
                    </div>

                </div>
            </div>
        </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4">护照号：</label>
        <div class="col-sm-7 col-md-8">
            <input type="text" class="form-control" name="passport" >
        </div>
    </div>
</div>
<div class="formtable-list">
    <div class="col-xs-6">
        <label class="col-sm-5 col-md-4">从业起始时间：</label>
        <div class="col-sm-7 col-md-8">
            <div class="input-group datepicker date mar_l5">
                <input type="text" class="form-control" name="workingTime"  style="margin: 0px;">
                <i class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></i>
            </div>
        </div>
    </div>
</div>
</div>
</div>
<div class="text-center">
    <button type="submit" class="btn btn-primary">新建</button>
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


<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script src="${ctx}/resources/js/uploadCrop/webuploader.min.js"></script>
<script src="${ctx}/resources/js/uploadCrop/cropper.min.js"></script>
<script src="${ctx}/resources/js/uploadCrop/imgCropBtn.js"></script>
<script src="${ctx}/resources/js/imageUpload/SimpleAjaxUploader.min.js"></script>
<script src="${ctx}/resources/js/imageUpload/imgUpLoad.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/personalMbr/add.js"></script>
<%@include file="/WEB-INF/common/global/footer.jsp"%>
</body>
</html>