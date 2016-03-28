    $(function () {
        //更改公司基本信息

        //如果是供应商 所有信息必填
       //如果是采购商 地址 税务登记号  俄文字段必输
        //如果是代理商或物流商 公司名称中文、俄文  公司地区 税务登记号 必输
        var validator=validatorFrom.initValidatorFrom({
            ele: "#cmpMbrBasicInfo",
            rules: {identities:'required',
                    orgNameCn: {
                        required: {
                            depends: function () {
                                var arr = $("input[name='identities']:checked");
                                if (arr.length > 0)
                                    return !(arr.length == 1 && arr[0].value == 6);
                                return true;
                            }
                        },
                        maxlength:100,
                        remote:{
                            url:window.ctx+"/cmpMbr/checkOrgExists",
                            type:"post",
                            data:{isSelf:false}
                        }
                 },
                orgNameRu:{required:true,
                    maxlength:100,
                    remote:{
                        url:window.ctx+"/cmpMbr/checkOrgExists",
                        type:"post",
                        data:{isSelf:false,orgNameCn:function(){
                            return $("input[name='orgNameRu']").val();
                        }}
                    }
                },
                countryType:'required',
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
                    maxlength:200
                }, addrRu:{
                    required: {
                        //供应商  采购商 必输
                        depends: function () {
                            var arr = $("input[name='identities']:checked");
                            if (arr.length > 0)
                                return (arr.length == 1 && (arr[0].value == 3||arr[0].value == 6));
                            return false;
                        }
                    },
                    maxlength:200
                },
                summaryCn:{
                    required: {
                        //供应商 必输
                        depends: function () {
                            var arr = $("input[name='identities']:checked");
                            if (arr.length > 0)
                                return (arr.length == 1 && arr[0].value == 3);
                            return false;
                        }
                    },
                    maxlength:500
                },
                summaryRu:{
                    required: {
                        //采购商 必输
                        depends: function () {
                            var arr = $("input[name='identities']:checked");
                            if (arr.length > 0)
                                return (arr.length == 1 && (arr[0].value == 3||arr[0].value == 6));
                            return false;
                        }
                    },
                    maxlength:500

                },
                corporation: {  required: {
                    //供应商 必输
                    depends: function () {
                        var arr = $("input[name='identities']:checked");
                        if (arr.length > 0)
                            return (arr.length == 1 && arr[0].value == 3);
                        return false;
                    },
                    maxlength:100
                }},
                corporationPy: {  required: {
                    //采购商 必输
                    depends: function () {
                        var arr = $("input[name='identities']:checked");
                        if (arr.length > 0)
                            return (arr.length == 1 && (arr[0].value == 3||arr[0].value == 6));
                        return false;
                    },
                    maxlength:100
                }},
                optRegionCn: {
                    required: {
                        depends: function () {
                            var arr = $("input[name='identities']:checked");
                            if (arr.length > 0)
                                return (arr.length == 1 && arr[0].value == 3);
                            return false;
                        }
                    },
                    maxlength:500
                },optRegionRu:{
                    required: {
                        depends: function () {
                            var arr = $("input[name='identities']:checked");
                            if (arr.length > 0)
                                return (arr.length == 1 && (arr[0].value == 3||arr[0].value == 6));
                            return false;
                        }
                    },
                    maxlength:500
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
                    maxlength:500
                },   corpRegaddrRu: {
                    required: {
                        depends: function () {
                            var arr = $("input[name='identities']:checked");
                            if (arr.length > 0)
                                return (arr.length == 1 && (arr[0].value == 3||arr[0].value == 6));
                            return false;
                        }
                    },
                    maxlength:500
                }, corpRegtime: {
                    required: {
                        depends: function () {
                            var arr = $("input[name='identities']:checked");
                            if (arr.length > 0)
                                return (arr.length == 1 && arr[0].value == 3);
                            return false;
                        }
                    }
                }
                ,taxCert:{required:true,maxlength:50}},
            messages: {orgNameCn: {required:'公司中文名称为必输项'
                                   ,maxlength:"公司名称不能超过50个字符"
                                   ,remote:"公司名称已存在！"},
                       orgNameRu:{remote:'公司俄文名称已存在!'}
                     },
            submitType: "auto",
            validateDone:function(form){
                $("#save").attr("disabled","disabled")
                $.ajax({
                    url:window.ctx+"/cmpMbr/addMbr",
                    type:"post",
                    dataType:"json",
                    data:$("#cmpMbrBasicInfo").serialize(),
                    success:function(data){
                        console.log(data)
                        location.href = window.ctx+"/cmpMbr/edit?orgId=" + data.resultData;
                    }
                })
            }
        });

        //如果是采购商 公司中文名称 公司地址（中文）
        $("input[name='identities']").click(function(){

            //重置验证
            validator.resetForm();
            var form=$(this).closest("form");
            $(".popover",form).remove();
            $(".error",form).removeClass("error")
            //只有代理商和物流商可以同时选中
            var arr = $("input[name='identities']:checked");

            //
            if (arr.length > 0) {
                //采购商  移出中文必填项
                if (arr.length == 1 && arr[0].value == 6){
                    $(".formtable-list:not(:first) label",form).addClass("formtable-list-require");
                    $("input[name='orgNameCn']").parent().siblings("label").removeClass("formtable-list-require");
                    $("input[name='addrCn']").parent().siblings("label").removeClass("formtable-list-require");
                    $("textarea[name='summaryCn']").parent().siblings("label").removeClass("formtable-list-require");
                    $("input[name='corporation']").parent().siblings("label").removeClass("formtable-list-require");
                    $("input[name='optRegionCn']").parent().siblings("label").removeClass("formtable-list-require");
                    $("input[name='corpRegaddrCn']").parent().siblings("label").removeClass("formtable-list-require");
                    $("input[name='corpRegtime']").closest(".formtable-list").find("label").removeClass("formtable-list-require");
                }else if(arr[0].value != 3){
                    //代理商
                    $(".formtable-list:not(:first) label",form).removeClass("formtable-list-require");
                    $("input[name='orgNameCn']").closest(".formtable-list").find("label").addClass("formtable-list-require");
                    $("input[name='orgNameRu']").closest(".formtable-list").find("label").addClass("formtable-list-require");
                    $("input[name='taxCert']").closest(".formtable-list").find("label").addClass("formtable-list-require");
                    $("input[name='countryType']").closest(".formtable-list").find("label").addClass("formtable-list-require");
                }else if(arr[0].value == 3){
                    $(".formtable-list:not(:first) label",form).addClass("formtable-list-require");
                }
            }
            if($(this).is(":checked")){
                var _thisVal=$(this).val();
                //如果是采购商或供应商  清除其他选中
                if(_thisVal==6||_thisVal==3){
                    $("input[name='identities']:checked").click();
                }
                //如果是代理商或物流商 清除供应商和采购商(如果他们被选中的话)
                else if(_thisVal==4||_thisVal==5){
                    $.each(arr,function(){
                        if($(this).val()!=4&&$(this).val()!=5)$(this).click();
                    });
                }
            }
        });


    });
    $(function () {
        $(".select-label input[type=checkbox]").click(function () {
            if ($(this).children("input[type=checkbox]").is(":checked") == true) {
                $(this).parent().addClass("active")
            } else {
                $(this).parent().removeClass("active")
            }
        });
        $(".select-label label").click(function () {
            if ($(this).children("input[type=checkbox]").is(":checked") == true) {
                $(this).addClass("active")
            } else {
                $(this).removeClass("active")
            }
        });
        $(".select-label input[type=checkbox]:checked").parent().addClass("active");
    });

