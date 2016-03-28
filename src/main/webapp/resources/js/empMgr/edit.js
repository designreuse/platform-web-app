    if ($(".select-face").length > 0) {
        $(".btn-uploadpic").click(function () {
            $(".select-face").each(function () {
                this.reset();
            });
        })
    }
    $(function () {
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
        function loadAddress(url, target) {
            $.get(window.ctx + url, function (data) {
                target.children().first().siblings().remove();
                data.forEach(function (d) {
                    target.append($("<option></option>").val(d.id).text(d.cnname + "(" + d.enname + ")"));
                });
                if (data.length > 0) {
                    target.show();
                }
            }, "json");
        }
    })
    //图片上传
    $(function () {
        $("img").click(
                function () {
                    $(this).siblings("input[type='file']").trigger("click");
                }
        );

        $("div").delegate("input[type='file']", "change", function () {
            var id = 'fileUpload' + new Date().getTime();
            var name = $(this).attr('name');
            $(this).attr({id: id, name: "file"});
            $.ajaxFileUpload({
                url: window.ctx+"/aldUpload/uploadImg",
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
    })
    //表单验证
    $(function () {


        validatorFrom.initValidatorFrom({
            ele: "#empInfoSaveForm",
            submitType: "auto",
            rules: {userNameCn: 'required',
                ruName1: {required:true,maxlength:30},
                ruName2: {required:true,maxlength:30},
                ruName3: {required:true,maxlength:30},
                mobile:{
                    required:true,
                    maxlength:20,
                    remote:{
                        url:window.ctx+"/personalMbr/checkMobileExists",
                        type:"post",
                        data:{isSelf:function(){
                            return $("input[name='mobile']").val()==$("input[name='mobile']").siblings("input").val();
                        }}
                    }
                }
            },
            messages: {userNameCn: '请输入中文名称',mobile:{remote:'手机号码已存在！！！'}},
            validateDone: function (form) {
                var name1=$("input[name='ruName1']").val()||"";
                var name2=$("input[name='ruName2']").val()||"";
                var name3=$("input[name='ruName3']").val()||"";
                $("input[name='userNameFirst']").val(name1+","+name2+","+name3);
                form.submit();
            }
        });
        jQuery.validator.addMethod("pwdCheck", function(value, element) {
            return this.optional(element) || /^[\u0391-\uFFE5\w]{6,20}$/.test(value);
        }, "只能包括6-20位中文字、英文字母、数字和下划线");
        //修改pwd
        validatorFrom.initValidatorFrom({
            ele: '#changeMbrPwdFormSrv',
            rules: {
                newPassword:{
                    required:true,
                    minlength:6
                },
                repeatPwd:{
                    required:true,
                    pwdCheck:true,
                    equalTo: "#repeatPwdSrv"
                }
            },
            messages:{
                repeatPwd:{
                    equalTo:'两次输入的密码不一致'
                }
            },
            submitType:'submit'
        });

    });

