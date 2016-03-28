//裁剪图片处理

var cropOption = {
    $cropBtn: ".imgCropBtn",
    $btn: "#imgUploadBtn",
    uploadSuccess: function (file,response) {

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

//图片上传
imgUpload();


if ($(".select-face").length > 0) {
    $(".btn-uploadpic").click(function () {
        $(".select-face").each(function () {
            this.reset();
        });
    })
}
$(function () {
    //关系

    $("input[name='entUserStatus']").on("change", function () {
        var selectVal = $(this).val();
        console.info("selectVal:" + selectVal)
        if (selectVal && (selectVal == 0 || selectVal == 2)) {
            //清空 value
            $("#noneOrSingleHide").find("input").val("");
            $("#noneOrSingleHide").find("select").val("");
            $("#noneOrSingleHide").children().css({"display": "none"});
        } else {
            $("#noneOrSingleHide").find("input").val("");
            $("#noneOrSingleHide").find("select").val("");
            $("#noneOrSingleHide").children().css({"display": "block"});
        }
    });


    //地址三级联动
    var provSelect = $("#provinceId");
    var citySelect = $("#cityId");
    var distSelect = $("#districtId");


    $("#countryId").change(function () {
        loadAddress("/address/province/" + $(this).val(), provSelect);
        provSelect.children().first().siblings().remove();
        citySelect.children().first().siblings().remove();
        distSelect.children().first().siblings().remove();
    });
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
            url: window.ctx + "/aldUpload/uploadImg",
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
    //个人信息保存
    $("input[name='regSource']").change(function () {
        //如果是运营 只能是隶属关系
        if ($(this).val() == 2) {
            $("input[name='entUserStatus'][value='1']").click();
            $("input[name='entUserStatus'][value='1']").attr({"checked": "checked"});
            $("input[name='entUserStatus']").attr({"disabled": "disabled"});
            $(this).append($("<input id='entId' type='hidden' value='1' name='entUserStatus'/>"));
        } else {
            $("input[name='entUserStatus']").removeAttr("disabled");
            $("#entId").remove();
        }
    });


    jQuery.validator.addMethod("pwdCheck", function (value, element) {
        return this.optional(element) || /^[\u0391-\uFFE5\w]{6,20}$/.test(value);
    }, "请输入6~20位数字、字母或字符");
    var validator = validatorFrom.initValidatorFrom({
        ele: '#addUserForm',
        focusCleanup: true,
        rules: {
            userNameCn: {
                required: {
                    depends: function () {
                        var regSource = $("input[name='regSource']:checked").val();
                        return regSource != 5;
                    }
                },
                maxlength: 100
            }, regSource: 'required', entUserStatus: 'required', orgId: {required: {depends: function () {
                var relate = $("input[name='entUserStatus']:checked");
                //如果是隶属 该字段必输
                return relate && relate[0].value == 1;
            }}}, ruName1: {
                required: {
                    depends: function () {
                        var regSource = $("input[name='regSource']:checked").val();
                        return regSource == 5;
                    }
                },
                maxlength: 30
            }, ruName2: {
                required: {
                    depends: function () {
                        var ruName1 = $("input[name='ruName1']").val();
                        return ruName1 ? true : false;
                    }
                },
                maxlength: 30
            }, ruName3: {
                required: {
                    depends: function () {
                        var ruName1 = $("input[name='ruName1']").val();
                        return ruName1 ? true : false;
                    }
                },
                maxlength: 30
            }, personHeadPhoto: 'required', password: {
                required: true,
                pwdCheck: true
            }, email: {
                required: {
                    depends: function () {
                        var regSource = $("input[name='regSource']:checked").val();
                        return regSource == 5;
                    }
                }, email: true, remote: {
                    url: window.ctx + "/personalMbr/checkMobileExists",
                    type: "post",
                    data: {isSelf: false,mobile:function(){return $("input[name='email']").val()}}
                }, maxlength: 30


            }, mobile: {
                required: {
                    depends: function () {
                        var regSource = $("input[name='regSource']:checked").val();
                        return regSource != 5;
                    }
                },
                maxlength: 20,
                isMobile:true,
                remote: {
                    url: window.ctx + "/personalMbr/checkMobileExists",
                    type: "post",
                    data: {isSelf: false}
                }
            }, passport: {
                required: {
                    depends: function () {
                        var regSource = $("input[name='regSource']:checked").val();
                        return parseInt(regSource) == 5;
                    }
                },
                maxlength: 20
            }, workingTime: {
                //“中文站点”时，关系选择为“个人”时，居住地址和从业开始时间为必填项
                required: {
                    depends: function () {
                        var regSource = $("input[name='regSource']:checked").val();
                        var relate = $("input[name='entUserStatus']:checked").val();
                        return regSource == 3 && relate == 2;
                    }
                }
            }, countryId: {
                required: {
                    depends: function () {
                        var regSource = $("input[name='regSource']:checked").val();
                        var relate = $("input[name='entUserStatus']:checked").val();
                        return regSource == 3 && relate == 2;
                    }
                }
            },
            provId: {
                required: {
                    depends: function () {
                        var regSource = $("input[name='regSource']:checked").val();
                        var relate = $("input[name='entUserStatus']:checked").val();
                        return regSource == 3 && relate == 2;
                    }
                }
            },
            cityId: {
                required: {
                    depends: function () {
                        var regSource = $("input[name='regSource']:checked").val();
                        var relate = $("input[name='entUserStatus']:checked").val();
                        return regSource == 3 && relate == 2;
                    }
                }
            },
            distId: {
                required: {
                    depends: function () {
                        var regSource = $("input[name='regSource']:checked").val();
                        var relate = $("input[name='entUserStatus']:checked").val();
                        return regSource == 3 && relate == 2;
                    }
                }
            },
            address: {
                required: {
                    depends: function () {
                        var regSource = $("input[name='regSource']:checked").val();
                        var relate = $("input[name='entUserStatus']:checked").val();
                        return regSource == 3 && relate == 2;
                    }
                },
                maxlength: 500
            },
            telCountry: {
                maxlength: 20
            },
            telZone: {
                required: {
                    depends: function () {
                        var telCountry = $("input[name='telCountry']").val();
                        return telCountry ? true : false;
                    }
                }
            },
            tel: {
                required: {
                    depends: function () {
                        var telCountry = $("input[name='telCountry']").val();
                        return telCountry ? true : false;
                    }
                }
            },
            telExt: {
                maxlength: 20
            },
            faxCountry: {

                maxlength: 20
            },
            faxZone: {
                required: {
                    depends: function () {
                        var telCountry = $("input[name='faxCountry']").val();
                        return telCountry ? true : false;
                    }
                },
                maxlength: 20
            },
            fax: {
                required: {
                    depends: function () {
                        var telCountry = $("input[name='faxCountry']").val();
                        return telCountry ? true : false;
                    }
                },
                maxlength: 20
            }, faxExt: {
                maxlength: 20
            },
            idcard: {
                maxlength: 20
            }
        },
        submitType: 'auto',
        messages: {mobile: {
            remote: '该手机号已存在!!!'
        }},
        validateDone: function (form) {
            var name1 = $("input[name='ruName1']").val();
            var name2 = $("input[name='ruName2']").val() || "";
            var name3 = $("input[name='ruName3']").val() || "";
            var name = name1 ? name1 + "," + name2 + "," + name3 : "";
            $("input[name='userNameFirst']").val(name);
            form.submit();
        }
    });
    //公司模糊搜索
    $("#searchOrg").autocomplete({
            delay: 1,
            source: function (request, response) {
                var data = {};
                var regSource = $("input[name='regSource']:checked").val();
                if (parseInt(regSource) == 2) {
                    data = {identityIdList: [4, 5], term: request.term, regSource: regSource};
                } else {
                    data = {term: request.term, regSource: regSource};
                }
                $.ajax({
                    url: window.ctx + "/personalMbr/getOrgName",
                    data: data,
                    success: function (data) {
                        $("#dealingsOrgId").val("");
                        data = $.parseJSON(data);
                        response(data);
                    }
                });
            },
            minLength: 1,
            autoFocus: true,
            select: function (e, ui) {
                $("#dealingsOrgId").val(ui.item.id);
                var otherValue = ui.item.otherValue;
                console.log("otherValue：" + otherValue);
                if (otherValue != "1") {
                    $("#ownerDepart").attr({"disabled": "disabled"});
                } else {
                    //带出所有部门 添加到  执行部门select 标签中
                    $("#ownerDepart").removeAttr("disabled");
                    $("#ownerDepart").children().first().siblings().remove();
                    var selectHtm = "";
                    $.each(ui.item.departmentBoList, function () {
                        selectHtm += "<option value='" + this.id + "'>" + this.deptName + "</option>";
                    });
                    $("#ownerDepart").append(selectHtm);
                }

            }
        }
    );


    //中文站点 运营 邮箱非必输 手机必输
    $("input[name='regSource']").click(function () {
        $("input[name='orgName']").val('');
        $("input[name='orgId']").val('');
        validator.resetForm();
        var form = $(this).closest("form");
        $("input + .popover", form).remove();
        //俄文站点 中文名称非必输  手机非必输
        if ($(this).val() == 5) {
            $("input[name='userNameCn']").closest(".formtable-list").find("label").removeClass("formtable-list-require");
            $("input[name='mobile']").closest(".formtable-list").find("label").removeClass("formtable-list-require");
            $("input[name='email']").closest(".formtable-list").find("label").addClass("formtable-list-require");
            $("input[name='passport']").closest(".formtable-list").find("label").addClass("formtable-list-require");
            $("input[name='ruName1']").closest(".formtable-list").find("label").addClass("formtable-list-require");
            $("#countryId").closest(".formtable-list").find("label").removeClass("formtable-list-require");
            $("input[name='workingTime']").closest(".formtable-list").find("label").removeClass("formtable-list-require");

        } else {
            $("input[name='userNameCn']").closest(".formtable-list").find("label").addClass("formtable-list-require");
            $("input[name='mobile']").closest(".formtable-list").find("label").addClass("formtable-list-require");
            $("input[name='email']").closest(".formtable-list").find("label").removeClass("formtable-list-require");
            $("input[name='passport']").closest(".formtable-list").find("label").removeClass("formtable-list-require");
            $("input[name='ruName1']").closest(".formtable-list").find("label").removeClass("formtable-list-require");
        }
    });

    $("input[name='entUserStatus']").click(function () {
        if ($(this).val() == 2) {
            $("#countryId").closest(".formtable-list").find("label").addClass("formtable-list-require");
            $("input[name='workingTime']").closest(".formtable-list").find("label").addClass("formtable-list-require");
        } else {
            $("#countryId").closest(".formtable-list").find("label").removeClass("formtable-list-require");
            $("input[name='workingTime']").closest(".formtable-list").find("label").removeClass("formtable-list-require");

        }
    });

});

