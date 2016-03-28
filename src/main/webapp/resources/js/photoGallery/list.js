$(document).on('ready',function(){
    var imgBoxWidth =  $(".imgCloud_box").width();

    if(imgBoxWidth ==0){
        setTimeout(
            function () {
                while (imgBoxWidth == 0) {
                    imgBoxWidth = $(".imgCloud_box").width();
                    if(imgBoxWidth > 0){
                        loadList(imgBoxWidth);
                        break;
                    }
                }
            }, 500);
    }else{
        loadList(imgBoxWidth);
    }

});

function loadList(imgBoxWidth){
    var setWidth = parseInt((imgBoxWidth - 19*5)/6);
    $(".imgCloud_list").outerWidth(setWidth);
    $(".imgCloud_list_set").on("click", function(){
        var $this = $(this);
        var id = $this.data("id");
        var $par = $this.parents(".imgCloud_list");
        var imgName = $par.find(".imgCloud_name").text();
        $(".imgCloud_list_set_box").hide();
        if($par.children().hasClass("imgCloud_list_set_box")){
            $par.find(".imgCloud_list_set_box").show();
        }else {
            var listSetTpl = '<div class="imgCloud_list_set_box">'+
                '<h2 class="imgCloud_list_set_header">编辑名称</h2>'+
                '<input type="text" class="form-control mar_b10">'+
                '<button class="btn btn-primary pull-left img-btn-sure" data-id="'+id+'">确定</button>'+
                '<button class="btn btn-default pull-right img-btn-cancel">取消</button>'+
                '</div>';
            $par.append(listSetTpl);
        }
        $par.find(".form-control").val(imgName);
        $(".img-btn-sure").off("click").on("click", function(){
            var $this = $(this);
            var $par = $this.parents(".imgCloud_list");
            var changeName = $par.find(".form-control").val();
            var fileId  = $this.data("id");
            savePhotoName(fileId,changeName);
            $par.find(".imgCloud_list_set_box").hide();
            $par.find(".imgCloud_name").text(changeName);
        });
        $(document).on("click",".img-btn-cancel", function(){
            var $this = $(this);
            var $par = $this.parents(".imgCloud_list");
            $par.find(".form-control").val("");
            $par.find(".imgCloud_list_set_box").hide();
        });
    });
    $(".imgCloud_list_del").on('click', function(){
        if(confirm("确定删除图片吗？")){
            var $this = $(this);
            var $par = $this.parents(".imgCloud_list");
            var fileId  = $this.data("id");
            deletePhoto(fileId);
            $par.remove();
        }

    });
    util.imgBox($(".imgCloud_box"));
    $(".imgCloud_box").find("img.lazy").lazyload({
        event: "scrollstop",
        effect : "fadeIn",
        threshold : 200
    });
    var option = {
        $btn: "#imgCloudBtn",
        server:  window.ctx +'/aldUploadNew/uploadGalleryImg',
        uploadSuccess: function (file, response) {
            location.reload();
        },
        uploadError: function () {
        }
    };
    imgCloud(option);
}


function savePhotoName(id,name){
    $.ajax({
        url: window.ctx + "/photoGallery/savePhotoName",
        type: "POST",
        data :{id: id,name:name,deleted:0},
        dataType:"json",
        success: function (data) {
            alert("保存成功")
            location.reload();
        }, error: function () {
            alert("保存失败")
        }
    });
}

function deletePhoto(id){
    $.ajax({
        url: window.ctx + "/photoGallery/savePhotoName",
        type: "POST",
        data :{id: id,deleted:1},
        dataType:"json",
        success: function (data) {
            alert("删除成功");
            location.reload();
        }, error: function () {
            alert("删除失败")
        }
    });
}

