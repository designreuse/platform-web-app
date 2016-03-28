jQuery.fn.extend({changeRequired: function () {
    //重置验证

    var form = $(this).closest("form");
    $(".popover", form).remove();
    $(".error", form).removeClass("error")
    //只有代理商和物流商可以同时选中
    var arr = $("input[name='identities']:checked");

    //
    if (arr.length > 0) {
        //采购商  移出中文必填项
        if (arr.length == 1 && arr[0].value == 6) {
            $(".formtable-list:not(:first) label", form).addClass("formtable-list-require");
            $("input[name='orgNameCn']").parent().siblings("label").removeClass("formtable-list-require");
            $("input[name='addrCn']").parent().siblings("label").removeClass("formtable-list-require");
            $("textarea[name='summaryCn']").parent().siblings("label").removeClass("formtable-list-require");
            $("input[name='corporation']").parent().siblings("label").removeClass("formtable-list-require");
            $("input[name='optRegionCn']").parent().siblings("label").removeClass("formtable-list-require");
            $("input[name='corpRegaddrCn']").parent().siblings("label").removeClass("formtable-list-require");
            $("input[name='corpRegtime']").closest(".formtable-list").find("label").removeClass("formtable-list-require");
        } else if (arr[0].value != 3) {
            //代理商
            $(".formtable-list:not(:first) label", form).removeClass("formtable-list-require");
            $("input[name='orgNameCn']").closest(".formtable-list").find("label").addClass("formtable-list-require");
            $("input[name='orgNameRu']").closest(".formtable-list").find("label").addClass("formtable-list-require");
            $("input[name='taxCert']").closest(".formtable-list").find("label").addClass("formtable-list-require");
            $("#countryId").closest(".formtable-list").find("label").addClass("formtable-list-require");
        } else if (arr[0].value == 3) {
            $(".formtable-list:not(:first) label", form).addClass("formtable-list-require");
        }
    }
    if ($(this).is(":checked")) {
        var _thisVal = $(this).val();
        //如果是采购商或供应商  清除其他选中
        if (_thisVal == 6 || _thisVal == 3) {
            $.each(arr, function () {
                if($(this).val() != _thisVal) $(this).click();
            });
        }
        //如果是代理商或物流商 清除供应商和采购商(如果他们被选中的话)
        else if (_thisVal == 4 || _thisVal == 5) {
            $.each(arr, function () {
                if ($(this).val() != 4 && $(this).val() != 5)$(this).click();
            });
        }
    }
}});
$(function () {

    validatorFrom.initValidatorFrom({
        ele: "#saveOrgSrvForm",
        rules:{
            serviceIds:'required'
        },
        submitType:'submit'
    });



    //更改公司基本信息
    //如果是采购商  俄文必输  中文可以不输入
    var validator = validatorFrom.initValidatorFrom({
        ele: "#cmpMbrBasicInfo",
        rules: {identities: 'required',
            orgNameCn: {
                required: {
                    depends: function () {
                        var arr = $("input[name='identities']:checked");
                        if (arr.length > 0)
                            return !(arr.length == 1 && arr[0].value == 6);
                        return true;
                    }
                },
                maxlength: 100,
                remote: {
                    url: window.ctx + "/cmpMbr/checkOrgExists",
                    type: "post",
                    data: {
                        isSelf: function () {
                            console.info($("input[name='orgNameCnOriginal']").val());
                            console.info($("input[name='orgNameCn']").siblings("input").val());
                            return $("input[name='orgNameCn']").val() == $("input[name='orgNameCn']").siblings("input[name='orgNameCnOriginal']").val();
                        }
                    }
                }
            },
            orgNameRu: {required: true, maxlength: 100},
            countryType: 'required',
            provId: 'required',
            cityId: 'required',
            distId: 'required',
            addrCn: {
                required: {
                    depends: function () {
                        var arr = $("input[name='identities']:checked");
                        if (arr.length > 0)
                            return (arr.length == 1 && arr[0].value == 3);
                        return false;
                    }
                },
                maxlength: 200
            }, addrRu: {
                required: {
                    //供应商  采购商 必输
                    depends: function () {
                        var arr = $("input[name='identities']:checked");
                        if (arr.length > 0)
                            return (arr.length == 1 && (arr[0].value == 3 || arr[0].value == 6));
                        return false;
                    }
                },
                maxlength: 200
            },
            summaryCn: {
                required: {
                    //供应商 必输
                    depends: function () {
                        var arr = $("input[name='identities']:checked");
                        if (arr.length > 0)
                            return (arr.length == 1 && arr[0].value == 3);
                        return false;
                    }
                },
                maxlength: 500
            },
            summaryRu: {
                required: {
                    //采购商 必输
                    depends: function () {
                        var arr = $("input[name='identities']:checked");
                        if (arr.length > 0)
                            return (arr.length == 1 && (arr[0].value == 3 || arr[0].value == 6));
                        return false;
                    }
                },
                maxlength: 500

            },
            corporation: {  required: {
                //供应商 必输
                depends: function () {
                    var arr = $("input[name='identities']:checked");
                    if (arr.length > 0)
                        return (arr.length == 1 && arr[0].value == 3);
                    return false;
                }
            },
                maxlength: 100
            },
            corporationPy: {  required: {
                //采购商 必输
                depends: function () {
                    var arr = $("input[name='identities']:checked");
                    if (arr.length > 0)
                        return (arr.length == 1 && (arr[0].value == 3 || arr[0].value == 6));
                    return false;
                }
            },
                maxlength: 100
            },
            optRegionCn: {
                required: {
                    depends: function () {
                        var arr = $("input[name='identities']:checked");
                        if (arr.length > 0)
                            return (arr.length == 1 && arr[0].value == 3);
                        return false;
                    }
                },
                maxlength: 500
            }, optRegionRu: {
                required: {
                    depends: function () {
                        var arr = $("input[name='identities']:checked");
                        if (arr.length > 0)
                            return (arr.length == 1 && (arr[0].value == 3 || arr[0].value == 6));
                        return false;
                    }
                },
                maxlength: 500
            },
            corpRegaddrCn: {
                required: {
                    depends: function () {
                        var arr = $("input[name='identities']:checked");
                        if (arr.length > 0)
                            return (arr.length == 1 && arr[0].value == 3);
                        return false;
                    }
                },
                maxlength: 500
            }, corpRegaddrRu: {
                required: {
                    depends: function () {
                        var arr = $("input[name='identities']:checked");
                        if (arr.length > 0)
                            return (arr.length == 1 && (arr[0].value == 3 || arr[0].value == 6));
                        return false;
                    }
                },
                maxlength: 500
            }, corpRegtime: {
                required: {
                    depends: function () {
                        var arr = $("input[name='identities']:checked");
                        if (arr.length > 0)
                            return (arr.length == 1 && arr[0].value == 3);
                        return false;
                    }
                }
            }, taxCert: {required: true, maxlength: 50}},
        messages: {orgNameCn: {required: '公司中文名称为必输项', maxlength: "公司名称不能超过50个字符", remote: "该公司名称已存在"},
            orgNameRu: '公司英文名称为必输项',
            provId: '公司地区省份为必输项',
            cityId: '公司地区城市为必输项',
            distId: '公司地区区/县为必输项',
            addrCn: '公司中文地址为必输项',
            addrRu: '公司俄文地址为必输项',
            summaryCn: {required: '公司中文简介为必输项', maxlength: "不能超过500个字符"},
            summaryRu: {required: '公司俄文简介为必输项', maxlength: "不能超过500个字符"},
            corporation: '公司法人为必输项',
            optRegionCn: '公司经营范围为必输项',
            corpRegaddrCn: '公司注册地为必输项',
            corpRegtime: '公司注册时间为必输项'},
        submitType: 'submit'
    });

    $("#compApti input").click(function () {
        if ($(this).is(":checked")) {
            $("#threeCombineForm").removeClass("hidden");
            $("#basicAttaForms").addClass("hidden");
            $("input[name='isThree']").val(1);
        } else {
            $("#basicAttaForms").removeClass("hidden");
            $("#threeCombineForm").addClass("hidden");
            $("input[name='isThree']").val(0);
        }
    });

    //新增服务资质
    validatorFrom.initValidatorFrom({
        ele: '#addSrvAttachForm',
        rules: {attaName: 'required', attaPath: 'required'},
        messages: {srvAbilityName: '请输入资质名称'},
        submitType: 'auto',
        validateDone: function (form) {

            $.ajax({
                url: window.ctx + "/company/addSrvAbility",
                data: {attaName: form.srvAbilityName.value, attaType: 4, orgId: $("input[name='orgId']:first").val()},
                success: function (rsp) {
                    var data = $.parseJSON(rsp);
                    if (data.attaId) {

                        //保存成功
                        //关闭输入框
                        $("#addApti").modal("hide");
                        //添加上传文件节点  隐藏attaId
                        var htm = '<div class="col-sm-3">' +
                            '   <div class="pad_20">' +
                            '       <p>' + data.attaName + '</p>' +
                            '       <div class="servapti-input text-center">' +
                            '           <input type="file" class="btn-uploadpic mar_t10" accept=".jpg, .png, .pdf">' +
                            '           <input type="hidden" name="attaId" value="' + data.attaId + '"/>' +
                            '           <button type="submit" class="btn btn-primary mar_t10">上传</button>' +
                            '       </div>' +
                            '   </div>' +
                            '</div>';
                        $(".formtable-cont .clear").append(htm);
                    } else {
                        //保存失败
                    }
                },
                error: function () {
                    alert("保存失败!!!!");
                }
            });

        }
    });

    //增加服务资质附件
    validatorFrom.initValidatorFrom({
        ele: "attaName",

        submitType: 'submit'
    });
    //删除服务资质附件
    $("input.fl_r").click(function () {
        $(this).closest("form[name='delForm']")
            .append("<input name='disabled' value='true'/>").submit();
    });

    function imgOnUploadComplete($this , response){
     console.log($this);
     console.log(response);
        if(typeof (response)=='string'){
            response=JSON.parse(response);
        }
     if($this.attr("id")=="threeLic"){
        // alert(response.resultData.urlPath);
        // console.log(response.resultData.urlPath);
         var $pra=$this.closest("form");
         $pra.find("input[name='attaPath']").val(response.resultData.urlPath);
         $pra.find(".changeSrvAtta").trigger("click");
     }

        if($this.attr("id")=="serviceLic"){
            var $pra=$this.closest("form");
            $pra.find("input[name='attaPath']").val(response.resultData.urlPath);
            $pra.find(".changeSrvAtta").trigger("click");
        }

     }

//图片上传
    imgUpload(imgOnUploadComplete);


    $(".addApti").on('click', function(){
        $("#addApti").modal("show");
        $("#addApti").on("shown.bs.modal", function(){
            //imgUpload(imgOnUploadComplete);
        });
    });

    //上传图片
   /* $("img").click(function () {
        $(this).siblings("input[type='file']").trigger("click");
    });
*/
    /*$("div").delegate("input[type='file']", "change", function () {
        var id = 'fileUpload' + new Date().getTime();
        var name = $(this).attr('name');
        $(this).attr({id: id, name: "file"});
        $.ajaxFileUpload({
            url: window.ctx + "/aldUpload/uploadImg",
            secureuri: false,
            fileElementId: id,
            dataType: "json",
            success: function (data) {
                if (data.result) {
                    var src = data.data.urlPath;
                    $("#" + id).siblings("img").attr({"src": src+"@200w_130h_1l"});
                    $("#" + id).siblings("input[name='attaPath']").val(src.replace('@.jpg',''));
                    $("#" + id).siblings("input[name='resourceCode']").val(data.data.resourceCode);
                    $("#" + id).siblings(".changeSrvAtta").trigger("click");
                }
            }, error: function (xml, status, e) {
                alert("上传图片失败");
            }
        });
    });
*/
    $(".changeSrvAtta").click(function () {
        $(this).closest("form").submit();
    });


    //如果是采购商 公司中文名称 公司地址（中文）
    $("input[name='identities']").click(function () {
        validator.resetForm();
        $(this).changeRequired();

    });
    $("input[name='identities']:checked").parent().addClass("active");
    $("input[name='identities']:checked").changeRequired();
});
    $(function(){
//        $(".select-label input[type=checkbox]").click(function() {
//            if ($(this).children("input[type=checkbox]").is(":checked")== true){
//                $(this).parent().addClass("active")
//            }else {
//                $(this).parent().removeClass("active")
//            }
//        });
        $(".select-label label").click(function() {
            if ($(this).children("input[type=checkbox]").is(":checked")== true){
                $(this).addClass("active")
            }else {
                $(this).removeClass("active")
            }
        });
        $(".select-label input[type=checkbox]:checked").parent().addClass("active");
    });

