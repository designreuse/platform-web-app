 //图片上传
    $(function () {
        $("img[img-tag='upload']").each(function(){

        });

        $("div").delegate("input[type='file']", "change", function () {
            var id = 'fileUpload' + new Date().getTime();
            var name = $(this).attr('name');
            $(this).attr({id: id, name: "file"});
            $.ajaxFileUpload({
                url: window.ctx +"/aldUpload/testUploadImg",
                secureuri: false,
                fileElementId: id,
                dataType: "json",
                success: function (data) {
                    if (data.result) {
                        var src = data.data.urlPath;
                        $("#" + id).siblings("img").attr({"src": src});
                        $("#" + id).siblings("input[type='hidden']").val(src.replace('@.jpg',''));
                    }

                }, error: function (xml, status, e) {
                    alert("上传图片失败");
                }
            });
        });
    });


