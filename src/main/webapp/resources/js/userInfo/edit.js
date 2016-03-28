/*function imgOnUploadComplete($this , response){
    console.log($this);
    console.log(response);
    if($this.attr("id")=="upd001"){

    }
}*/

//图片上传
/*imgUpload(imgOnUploadComplete);*/

imgUpload();

//裁剪图片处理

var cropOption = {
    $cropBtn: ".imgCropBtn",
    $btn: "#imgUploadBtn",
    isCrop: "true",
    uploadSuccess: function (file, response) {
        console.log(response);
        if(typeof (response)=='string'){
            response=JSON.parse(response);
        }
       // alert(response.resultData.urlPath);
        $(".imgCropModal").modal("hide");
        $(".imgCropBtn").attr("src",getImgTag(response.resultData.urlPath,200,200));
        $("#personHeadPhoto").val(response.resultData.urlPath);
    },
    uploadError: function (reason) {

    },
    uploadComplete: function (file) {

    }
};
cropUpload(cropOption);







if ($(".select-face").length>0) {
	$(".btn-uploadpic").click(function(){
		$(".select-face").each(function() {   
			this.reset();   
		}); 
	})
}
    $(function(){
        //地址三级联动
        var provSelect = $("#provinceId");
        var citySelect = $("#cityId");
        var distSelect = $("#districtId");

        if ("" === $("#provSelect").val()) {
            loadAddress("/address/province/1", provSelect);
        }
        provSelect.on("change", function () {
            var provId = provSelect.val();
            if (provId) {
                distSelect.children().first().siblings().remove();
                loadAddress("/address/city/" + provId, citySelect);
            } else {
                citySelect.children().first().siblings().remove();
                distSelect.children().first().siblings().remove();
            }
        });
        citySelect.on("change", function () {
            var cityId = citySelect.val();
            if (cityId) {
                loadAddress("/address/district/" + cityId, distSelect);
            }
        });
        function loadAddress(url,target){
            $.get(window.ctx+url,function(data){
                target.children().first().siblings().remove();
                data.forEach(function(d) {
                    target.append($("<option></option>").val(d.id).text(d.cnname+"("+ d.enname+")"));
                });
                if(data.length>0){
                    target.show();
                }
            },"json");
        }
    })
    //图片上传
$(function(){
    $("img").click(
        function(){
            $(this).siblings("input[type='file']").trigger("click");
        }
    );

    $("div").delegate("input[type='file']","change",function(){
        var id='fileUpload'+new Date().getTime();
        var name=$(this).attr('name');
        $(this).attr({id:id,name:"file"});
        $.ajaxFileUpload({
            url:window.ctx+"/aldUpload/uploadImg",
            secureuri:false,
            fileElementId:id,
            dataType:"json",
            success: function(data){
                if(data.result){
                    var src= data.data.urlPath;
                        $("#"+id).siblings("img").attr({"src":src});
                        $("#"+id).siblings("input[type='hidden']").val(src);
                    }

            },error: function (xml, status, e){
                alert("上传图片失败");
            }
        });
    });
})
//表单验证
$(function(){
    validatorFrom.initValidatorFrom({
        ele:"#userInfoSaveForm",
        submitType:"auto",
        rules: { userNameCn:{
                    required:true,
                    maxlength:100
                },
                ruName1:{required:true,maxlength:30},
                ruName2:{required:true,maxlength:30},
                ruName3:{required:true,maxlength:30},
                email:{
                    email:true
                    ,maxlength:30
                }
            ,mobile:{
                required:true,
                maxlength:20,
                remote:{
                    url:window.ctx+"/personalMbr/checkMobileExists",
                    type:"post",
                    data:{isSelf:function(){
                        console.info($("input[name='mobile']").val());
                        console.info($("input[name='mobile']").siblings("input").val());
                        return $("input[name='mobile']").val()==$("input[name='mobile']").siblings("input").val();
                    }}
                }
            } , address:{

                maxlength:500
            },idcard:{
                maxlength:20
            }
               },
        messages:{userNameCn:'请输入中文名称',mobile:{remote:'该手机号已存在！！！'}},
        validateDone: function (form) {
            var name1=$("input[name='ruName1']").val()||"";
            var name2=$("input[name='ruName2']").val()||"";
            var name3=$("input[name='ruName3']").val()||"";
            $("input[name='userNameFirst']").val(name1+","+name2+","+name3);
            form.submit();
        }
    });
});

