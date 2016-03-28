<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/global/common.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>商品中心-商品品类新增</title>
    <link rel="stylesheet" href="${ctx}/resources/js/uploadCrop/cropper.min.css">
    <link type="text/css" href="${ctx}/resources/css/style-min.css" rel="stylesheet" />
</head>
<body>
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">商品中心</a>
    </li>
    <li>
        <a href="${ctx}/catalog/list">商品品类管理</a>
    </li>
    <li>
        <a href="${ctx}/catalog/add">商品品类新增</a>
    </li>
</nav>
<div class="container-fluid">
    <form id="form1" class="formtable" action="${ctx}/catalog/save" method="post">
        <div class="formtable-cont">
            <h4 class="header">基本信息</h4>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">品类名称（中文）：</label>
                    <div class="col-sm-7 col-md-8">
                        <input class="form-control" type="text" name="catalogNameCn">
                    </div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">品类名称（俄文）：</label>
                    <div class="col-sm-7 col-md-8">
                        <input class="form-control" type="text" name="catalogNameRu">
                    </div>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">品类级别：</label>
                    <div class="col-sm-7 col-md-8 pad_l30">
                        <c:forEach items="${catalog.levels}" var="level">
                        <label class="radio-inline">
                            <input type="radio" name="level" value="${level.constValue}"> ${level.constName}
                        </label>
                        </c:forEach>
                        <br>
                        如需添加一级分类，需告知开发者。在版本升级后，才能生效。
                    </div>
                </div>
                <div class="col-xs-6 hide" id="parentCatalog">
                    <label class="col-sm-5 col-md-4 formtable-list-require">上级品类：</label>
                    <div class="col-sm-7 col-md-8">
                        <div class="form-inline">
                            <div class="form-group">
                                  <select class="form-control" id="secondLevel" name="firstCatalogId" >
                                    <option value="">全部</option>
                                  </select>
                            </div>
                            <div class="form-group">
                                  <select class="form-control hide" id="third" name="secondCatalogId">
                                     <option value="">全部</option>
                                  </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="formtable-list hide" id="indexShowDiv">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4" id="indexShow">首页显示：</label>
                    <div class="col-sm-7 col-md-8"><input class="form-control" placeholder="请填写数字" type="text" name="indexSort"><span></span></div>
                </div>
                <div class="col-xs-6">
                   <span style="color: #FF0000">注：该字段为0时，该分类不在首页显示；如填写1时即可在首页显示，数字越大该分类越在首页靠前的位置显示。</span>
                </div>
            </div>
            <div class="formtable-list">
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4" id="hs_code">HS CODE：</label>
                    <div class="col-sm-7 col-md-8"><input class="form-control" placeholder="请填写数字"  type="text" name="hscode"><span></span></div>
                </div>
                <div class="col-xs-6">
                    <label class="col-sm-5 col-md-4 formtable-list-require">商品图片：</label>
                    <%--<div class="col-sm-7 col-md-8 label-cont hide-input">
                        <img src="${ctx}/resources/images/bn.jpg" class="img-responsive" id="catalogSrc" onclick="reOLUploadFro();">
                        <input type="file" style="opacity: 0;font-size:20px;folat:left;width:0; height:0" class="btn-uploadpic form-control" name="file" multiple="" id="catalogLogoUrl">
                        <input class="hide" name="logo" type="text" id="catalogLogo">
                        <input type="hidden" name="resourceCode" id="resourcesCode">
                    </div>--%>

                    <div class="imgCropBox col-sm-7 col-md-8 label-cont hide-input" id="imgCropBox" >
                        <img src="${ctx}/resources/images/btn-upload.png" alt="" class="imgCropBtn img-responsive" id="imgCropBtn"
                             data-width="400" data-height="400">
                        <input class="hide" name="logo" type="text" id="catalogLogo">
                    </div>


                </div>
            </div>
        </div>
        <div class="formtable-cont text_c mar_t20">
            <button class="btn btn-primary">保存</button>
        </div>
    </form>

</div>


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
                        <button class="btn btn-primary img-select img-crop-select">图片裁剪</button>
                        <button class="btn btn-default img-select img-cloud-select">图片库</button>
                    </div>
                    <div class="img-box">
                        <div class="col-md-8">
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

                    <div class="row imgCloud-modal">
                        <div class="imgCloud_box mar_t30 imgCloud_search clearfix">
                            <div class="col-md-6 col-md-offset-3 mar_b--20">
                                <input type="text" name="name" id="selectName" value="" class="form-control border_r--no"><button class="btn btn-primary border_r--no" id="selectId">搜 索</button>
                            </div>
                            <ul class="col-md-12 mar_l--15" id="photoId">

                            </ul>
                        </div>
                        <div class="clear"></div>
                        <div class="pagination pagination-centered width--100"
                             id = "pageComponent">
                        </div>
                    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary imgUploadFile" id="imgUploadCloud">上传</button>
                <button type="button" class="btn btn-primary imgUploadRetry" >重试</button>
            </div>
        </div>
    </div>
</div>


<%@include file="/WEB-INF/common/global/footer.jsp"%>

</body>
<script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
<script src="${ctx}/resources/js/uploadCrop/webuploader.min.js"></script>
<script src="${ctx}/resources/js/uploadCrop/cropper.min.js"></script>
<script src="${ctx}/resources/js/uploadCrop/imgCropBtn.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/lazyload/lazyload.min.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/catalog/add.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jpage-class.js"></script>


<script>
    var photoUrl = "";
    var initPageIndex = 1;
    var initPageSize = 10;
    var initRowCount = 10;
    var jpage;
    var cropOption = {
        $cropBtn: ".imgCropBtn",
        $btn: "#imgUploadBtn",
        $cloudBtn: "#imgUploadCloud",
        uploadSuccess: function(file,response){

            if(typeof (response)=='string'){
                response=JSON.parse(response);
            }

            $(".imgCropModal").modal("hide");
            var src=response.resultData.urlPath;
            // var src=getImgTag(response.resultData.urlPath,400,400)
            $(".imgCropBtn").attr("src",getImgTag(response.resultData.urlPath,200,200));
            $("#catalogLogo").val(response.resultData.urlPath);
            $("#catalogLogo").next(".popover").remove();
        },
        uploadError: function(reason){

        },
        uploadComplete: function(file){

        },
        imgCLoudSelect: function(){
            getList();
        },
        imgCloudFun: function(){
            $("#imgCropBtn").attr("src",photoUrl);
            $("#catalogLogo").val(photoUrl);
            $(".imgCropModal").modal("hide");
        }
    };
    cropUpload(cropOption);

    function getData(data){
        $("#photoId").html("");
        var html = "";
        for(var j=0;j<data.resultData.photoGalleryBoList.length;j++){
            var photoBo = data.resultData.photoGalleryBoList[j];
            html +='<li class="imgCloud_list">';
            html +='<div class="img-box" data-type="same"><img src="'+window.ctx+'/resources/images/loading.gif" alt="" class="img-responsive lazy" data-original="'+photoBo.url+'"></div>';
            html +='<p class="imgCloud_name ellipsis mar_t10">'+photoBo.name+'</p>';
            html +='<i class="imgCloud-select" data-id="'+photoBo.url+'"></i>';
            html +="</li>";
        }
        $("#photoId").append(html);
        var imgBoxWidth = $(".imgCloud_box").width();
        var setWidth = parseInt((imgBoxWidth - 24 * 5) / 5);
        $(".imgCloud_list").outerWidth(setWidth);
        util.imgBox($("#photoId"));
        $(".imgCloud_box").find("img.lazy").lazyload({
            event: "scrollstop",
            effect : "fadeIn",
            threshold : 200
        });
        $(".imgCloud-modal .imgCloud_list").off('click').on('click', function(){
            $(".imgCloud-select").removeClass("active");
            $(this).find(".imgCloud-select").toggleClass("active");
            photoUrl = $(this).find(".imgCloud-select").data("id");
        });
        jpage.Init();
    }

    $("#selectId").on("click",function(){
        getList();
    });

    function getList(){
        var pageNumber = $("#pageNumber").val();
        var pageSize = $("#pageSize").val();
        var name = $("#selectName").val();
        $("#photoId").html("");
        $.ajax({
            type: "POST",
            url: window.ctx+"/photoGallery/photoList?name="+name,
            dataType:"json",
            data: {'pageNumber':pageNumber,'pageSize':pageSize},
            success: function(data){
                var html = "";
                for(var j=0;j<data.resultData.photoGalleryBoList.length;j++){
                    var photoBo = data.resultData.photoGalleryBoList[j];
                    html +='<li class="imgCloud_list">';
                    html +='<div class="img-box" data-type="same"><img src="'+window.ctx+'/resources/images/loading.gif" alt="" class="img-responsive lazy" data-original="'+photoBo.url+'"></div>';
                    html +='<p class="imgCloud_name ellipsis mar_t10">'+photoBo.name+'</p>';
                    html +='<i class="imgCloud-select" data-id="'+photoBo.url+'"></i>';
                    html +="</li>";
                }
                $("#photoId").append(html);
                var imgBoxWidth = $(".imgCloud_box").width();
                var setWidth = parseInt((imgBoxWidth - 24 * 5) / 5);
                $(".imgCloud_list").outerWidth(setWidth);
                util.imgBox($("#photoId"));
                $(".imgCloud_box").find("img.lazy").lazyload({
                    event: "scrollstop",
                    effect : "fadeIn",
                    threshold : 200
                });
                $(".imgCloud-modal .imgCloud_list").off('click').on('click', function(){
                    $(".imgCloud-select").removeClass("active");
                    $(this).find(".imgCloud-select").toggleClass("active");
                    photoUrl = $(this).find(".imgCloud-select").data("id");
                });
                initRowCount = data.resultData.rowCount;
                jpage = $("#pageComponent").SetPageComponent({
                    pageIndex : initPageIndex,    //当前页码
                    pageSize : initPageSize,      //每页条数
                    rowCount : initRowCount,      //数据总数
                    submitType:"ajax",
                    dataUrl:window.ctx+"/photoGallery/photoList?name="+name,
                    pageBack : getData
                });
            }
        });
    }
</script>



</html>