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
        $("input[name='entUserStatus']").change(function () {
            var selectVal = $(this).val();
            console.info("selectVal:" + selectVal)
            if (selectVal && (selectVal == 0 || selectVal == 2)) {
                //清空 value
                $("#noneOrSingleHide").find("input").val("");
                $("#noneOrSingleHide").find("select").val("");
                $("#noneOrSingleHide").children().css({"display":"none"});
            } else {
                $("#noneOrSingleHide").find("input").val("");
                $("#noneOrSingleHide").find("select").val("");
                $("#noneOrSingleHide").children().css({"display":"block"});
            }
        });

        //隶属关系审核   relateCheckOk
        $("#relateCheckOk").click(
            function(){
               $("#checkRelateForm>input[name='actionCode']").val(1);
                $("#checkRelateForm").submit();
            }
        );
        $("#relateCheckRefuse").click(function(){
            $("#checkRelateForm>input[name='actionCode']").val(2);
            $("#checkRelateForm").submit();
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
        if ("" === $("#provSelect").val()) {
            loadAddress("/address/province/1", provSelect);
            citySelect.children().first().siblings().remove();
            distSelect.children().first().siblings().remove();
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
                url: window.ctx +"/aldUpload/uploadImg",
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
        jQuery.validator.addMethod("pwdCheck", function(value, element) {
            return this.optional(element) || /^[\u0391-\uFFE5\w]{6,20}$/.test(value);
        }, "只能包括6-20位中文字、英文字母、数字和下划线");
        var validator = validatorFrom.initValidatorFrom({
            ele: '#personalMbrForm',
            rules:  {
                userNameCn:{
                    required:{
                        depends:function(){
                            var regSource=$("input[name='regSource']:checked").val();
                            return regSource!=5;
                        }
                    },
                    maxlength:100
                }
                ,regSource:'required'
                ,entUserStatus:'required'
                ,orgId:{required:{depends:function(){
                    var relate=$("input[name='entUserStatus']:checked");
                    //如果是隶属 该字段必输
                    return relate&&relate[0].value==1;
                }}}
                ,ruName1:{
                    required:{
                        depends:function(){
                            var regSource=$("input[name='regSource']:checked").val();
                            return regSource==5;
                        }
                    },
                    maxlength:30
                }
                ,ruName2:{
                    required:{
                        depends:function(){
                            var regSource=$("input[name='regSource']:checked").val();
                            return regSource==5;
                        }
                    },
                    maxlength:30
                }
                ,ruName3:{
                    required:{
                        depends:function(){
                            var regSource=$("input[name='regSource']:checked").val();
                            return regSource==5;
                        }
                    },
                    maxlength:30
                }
                ,personHeadPhoto:'required'
                ,password:{
                    required:true,
                    pwdCheck:true
                }
                ,email:{
                    required:{
                        depends:function(){
                            var regSource=$("input[name='regSource']:checked").val();
                            return regSource==5;
                        }
                    }
                    ,email:true
                    ,remote:{
                        url: window.ctx + "/personalMbr/checkMobileExists",
                        type: "post",
                        data: {isSelf: function(){
                            var e1=$("input[name='email']").val();
                            var e2=$("input[name='emailOrginal']").val();
                            return e1==e2;
                        },mobile:function(){return $("input[name='email']").val()}}
                    }
                    , maxlength:30
                }
                ,mobile:{
                    required:{
                        depends:function(){
                            var regSource=$("input[name='regSource']:checked").val();
                            return regSource!=5;
                        }
                    },
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
                },passport:{
                    required:{
                        depends:function(){
                            var regSource=$("input[name='regSource']:checked").val();
                            return parseInt(regSource)==5;
                        }
                    },
                    maxlength:20
                },workingTime:{
                    //“中文站点”时，关系选择为“个人”时，居住地址和从业开始时间为必填项
                    required:{
                        depends:function(){
                            var regSource=$("input[name='regSource']:checked").val();
                            var relate=$("input[name='entUserStatus']:checked").val();
                            return regSource==3&&relate==2;
                        }
                    }
                },
                provId:{
                    required:{
                        depends:function(){
                            var regSource=$("input[name='regSource']:checked").val();
                            var relate=$("input[name='entUserStatus']:checked").val();
                            return regSource==3&&relate==2;
                        }
                    }
                },
                cityId:{
                    required:{
                        depends:function(){
                            var regSource=$("input[name='regSource']:checked").val();
                            var relate=$("input[name='entUserStatus']:checked").val();
                            return regSource==3&&relate==2;
                        }
                    }
                },
                distId:{
                    required:{
                        depends:function(){
                            var regSource=$("input[name='regSource']:checked").val();
                            var relate=$("input[name='entUserStatus']:checked").val();
                            return regSource==3&&relate==2;
                        }
                    }
                },
                address:{
                    required:{
                        depends:function(){
                            var regSource=$("input[name='regSource']:checked").val();
                            var relate=$("input[name='entUserStatus']:checked").val();
                            return regSource==3&&relate==2;
                        }
                    },
                    maxlength:500
                },
                telCountry:{
                    maxlength:20
                },
                telZone:{
                    required:{
                        depends:function(){
                            var telCountry=$("input[name='telCountry']").val();
                            return telCountry?true:false;
                        }
                    },
                    maxlength:20
                },
                tel:{
                    required:{
                        depends:function(){
                            var telCountry=$("input[name='telCountry']").val();
                            return telCountry?true:false;
                        }
                    },
                    maxlength:20
                },
                telExt:{
                    maxlength:20
                },
                faxCountry:{

                    maxlength:20
                },
                faxZone:{
                    required:{
                        depends:function(){
                            var telCountry=$("input[name='faxCountry']").val();
                            return telCountry?true:false;
                        }
                    },
                    maxlength:20
                },
                fax:{
                    required:{
                        depends:function(){
                            var telCountry=$("input[name='faxCountry']").val();
                            return telCountry?true:false;
                        }
                    },
                    maxlength:20
                },

                faxExt:{
                    maxlength:20
                },
                idcard:{
                    maxlength:20
                }
            },
            submitType:'auto',
            messages: {mobile:{
                remote:'该手机号已存在!!!'
            },email:{remote:'该邮箱已存在!!!'}
            },
            validateDone: function (form) {
                var name1=$("input[name='ruName1']").val()||"";
                var name2=$("input[name='ruName2']").val()||"";
                var name3=$("input[name='ruName3']").val()||"";
                $("input[name='userNameFirst']").val(name1+","+name2+","+name3);
                form.submit();
            }
        });


        //修改pwd
        validatorFrom.initValidatorFrom({
            ele: '#changeMbrPwdForm',
            rules: {
                newPassword:{
                    required:true,
                    pwdCheck:true
                },
                repeatPwd:{
                    required:true,
                    equalTo: "#repeatPwd"
                }
            },
            messages:{
                repeatPwd:{
                    equalTo:'两次输入的密码不一致'
                }
            },
            submitType:'submit'
        });


        //公司模糊搜索
        $("#searchOrg").autocomplete({
                    source: window.ctx + "/personalMbr/getOrgName?regSource="+$("input[name='regSource']").val(),
                    minLength: 1,
                    autoFocus: true,
                    response:function(){
                        $("#dealingsOrgId").val("");
                    },
                    select: function (e, ui) {
                        $("#dealingsOrgId").val(ui.item.id);
                        var otherValue=ui.item.otherValue;
                        console.log("otherValue："+otherValue);
                        if(otherValue!="1"){
                            $("#ownerDepart").attr({"disabled":"disabled"});
                        }else{
                            //带出所有部门 添加到  执行部门select 标签中
                            $("#ownerDepart").removeAttr("disabled");
                            $("#ownerDepart").children().first().siblings().remove();
                            var selectHtm="";
                            $.each(ui.item.departmentBoList,function(){
                                selectHtm+="<option value='"+this.id+"'>"+this.deptName+"</option>";
                            });
                            $("#ownerDepart").append(selectHtm);
                        }

                    }
                }
        );
        $("input[name='regSource']").initPage();



    });
    $("input[name='entUserStatus']").click(function(){
        if($(this).val()==2){
            $("#countryId").closest(".formtable-list").find("label").addClass("formtable-list-require");
            $("input[name='workingTime']").closest(".formtable-list").find("label").addClass("formtable-list-require");
        }else{
            $("#countryId").closest(".formtable-list").find("label").removeClass("formtable-list-require");
            $("input[name='workingTime']").closest(".formtable-list").find("label").removeClass("formtable-list-require");

        }
    });
    jQuery.fn.extend({
        initPage: function() {
            if($(this).val()==5){
                $("input[name='userNameCn']").closest(".formtable-list").find("label").removeClass("formtable-list-require");
                $("input[name='mobile']").closest(".formtable-list").find("label").removeClass("formtable-list-require");
                $("input[name='email']").closest(".formtable-list").find("label").addClass("formtable-list-require");
                $("input[name='passport']").closest(".formtable-list").find("label").addClass("formtable-list-require");
                $("input[name='ruName1']").closest(".formtable-list").find("label:first").addClass("formtable-list-require");
                $("#provinceId").closest(".formtable-list").find("label").removeClass("formtable-list-require");
                $("input[name='workingTime']").closest(".formtable-list").find("label").removeClass("formtable-list-require");

            }else{
                $("input[name='userNameCn']").closest(".formtable-list").find("label").addClass("formtable-list-require");
                $("input[name='mobile']").closest(".formtable-list").find("label").addClass("formtable-list-require");
                $("input[name='email']").closest(".formtable-list").find("label").removeClass("formtable-list-require");
                $("input[name='passport']").closest(".formtable-list").find("label").removeClass("formtable-list-require");
                $("input[name='ruName1']").closest(".formtable-list").find("label").removeClass("formtable-list-require");
                if($("input[name='entUserStatus']:checked").val()==2){
                    $("#provinceId").closest(".formtable-list").find("label").addClass("formtable-list-require");
                    $("input[name='workingTime']").closest(".formtable-list").find("label").addClass("formtable-list-require");

                }
            }
        }
    });

