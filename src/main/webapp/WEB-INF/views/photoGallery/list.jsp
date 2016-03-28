<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/3/23
  Time: 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <%@include file="/WEB-INF/common/global/common.jsp" %>
    <title>图片库管理</title>
    <link type="text/css" href="${ctx}/resources/css/style-min.css" rel="stylesheet" />
</head>
<body class="background_color--2">
<nav class="breadcrumb">
    <li>
        您当前位置：<a href="#">内容中心</a>
    </li>
    <li>
        <a href="${ctx}/photoGallery/list">图片库管理</a>
    </li>
</nav>
<div class="container-fluid">
    <div class="formtable">
        <div class="formtable-cont">
            <div class="imgCloud">
            <form id="photoForm" method="post" action="${ctx}/photoGallery/list">
                <div class="imgCloud_search clearfix">
                    <div class="col-md-6">
                        <input type="text" name="name" value="${view.photoGalleryVo.name}" class="form-control border_r--no"><button class="btn btn-primary border_r--no">搜 索</button>
                    </div>
                    <div class="col-md-6">
                        <button class="btn btn-primary border_r--no" id="imgCloudBtn" style="left: 30px">本地上传</button>
                        <p style="margin-left: 100px;margin-top: 5px" class="font_color--red font_size--16">（最多支持7张图片同时上传）</p>
                        <div class="imgCloud_progress_box">

                        </div>
                    </div>
                </div>
            </form>
                <div class="imgCloud_box mar_t30">
                    <ul style="-webkit-padding-start: 0;">
                        <c:forEach items="${view.photoGalleryBoList}" var="photo">
                                <li class="imgCloud_list">
                                    <div class="img-box" data-type="same">
                                        <img src="${ctx}/resources/images/loading.gif" alt="" class="img-responsive lazy" data-original="${photo.url}">
                                    </div>
                                    <p class="imgCloud_name ellipsis mar_t10">${photo.name}</p>
                                    <p class="clearfix mar_t10">
                                        <span class="pull-left imgCloud_list_set" data-id="${photo.id}">修改名称</span>
                                        <span class="pull-right imgCloud_list_del" data-id="${photo.id}">删除</span>
                                    </p>
                                </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="pagination pagination-centered width--100 background_color--2 mar_t--20-"
         id = "pageComponent">
    </div>
</div>
<script src="${ctx}/resources/plugin/webuploader/webuploader.min.js"></script>
<script src="${ctx}/resources/plugin/webuploader/imgCloud.js"></script>
<script type="text/javascript" src="${ctx}/resources/js/jpage-class.js"></script>
<script type="text/javascript" src="${ctx}/resources/plugin/lazyload/lazyload.min.js"></script>
<script src="${ctx}/resources/js/photoGallery/list.js"></script>
<script>
    var jpage = $("#pageComponent").SetPageComponent({
        pageIndex : "${photoGalleryListView.pageIndex}",    //当前页码
        pageSize : "${photoGalleryListView.pageSize}",      //每页条数
        rowCount : "${photoGalleryListView.rowCount}",      //数据总数
        pageFormID : "photoForm"      //表单id
    });
</script>
</body>
</html>
