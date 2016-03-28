/**
 * Created by Administrator on 2015/11/16.
 */
$(function () {

    //复选框样式
    $(".select-label input").click(function () {
        if ($(this).children("input").is(":checked") == true) {
            $(this).parent().addClass("active")
        } else {
            $(this).parent().removeClass("active")
        }
    });
    $(".select-label label").click(function () {
        if ($(this).children("input").is(":checked") == true) {
            $(this).addClass("active")
        } else {
            $(this).removeClass("active")
        }
    })

    //结算，仓储样式
    $(".fl-window a").mouseover(function () {
        $(this).children(".hover-text").toggle();
    });
    $(".fl-window a").mouseout(function () {
        $(this).children(".hover-text").toggle();
    });


    //选择国内仓库
    $(document).on('change', '.store-type-cn', function () {
        getStoreList(this, 1)
    });
    //选择国外仓库
    $(document).on('change', '.store-type-ru', function () {
        getStoreList(this, 2)
    });
    //改变仓库，如果是成林仓库则选择枯萎，其余的手动输入
    $(document).on('change', '.stock', function () {
        var dom = $(this)
        dom.parent().next().remove()
        if (dom.val() == 1 || dom.val() == 2) {
            $.ajax({
                url: window.ctx + "/serviceOrder/getStockList",
                dataType: "json",
                type: "post",
                success: function (data) {
                    var str = '<div class="form-group" ><select class="form-control" data-alias="storageName" name="storeName">'
                    data.data.forEach(function (d) {
                        str += '<option value="' + d.warehouseName + '">' + d.warehouseName + '</option>'
                    })
                    str += '</select></div>'
                    dom.parent().after(str)
                }
            })
        } else {
            var str = '<div class="form-group" ><input class="form-control" data-alias="storageName" name="storeName"/></div>'
            dom.parent().after(str)
        }

    });
    //设置表格初始化配置属性
    var easyUiTableParam = {
        url: window.ctx + '/serviceOrder/srvOrderNodeList?srvOrderId=' + $("#srvOrderId").val(),
        columns: [{
            field: "srvNameCn",
            title: '基本服务',
            align: 'center',
            width: "60px"
        },
            {
                field: 'srvOrgNameCn',
                title: '服务商',
                align: 'center',
                width: "127px"
            },
            {
                field: 'nodeNameCn',
                title: '操作环节',
                align: 'center',
                width: "90px"
            },
            {
                field: 'statusNameCn',
                title: '状态',
                align: 'center',
                width: "55px"
            },
            {
                field: 'counts',
                title: '附件',
                align: 'center',
                width: "40px",
                formatter: function (value, row, index) {
                    if (value > 0) {
                        return '<a href="#" data-toggle="modal" onclick="clickAtta(' + row.id + ')" data-target="#checkAtta">查看</a>'
                    } else {
                        return ""
                    }
                }
            },
            {
                field: 'deptName',
                title: '操作角色',
                align: 'center',
                width: "60px"
            },
            {
                field: 'actualDate',
                title: '环节完成时间',
                align: 'center',
                width: "100px",
                formatter: function (value, row, index) {
                    if (value) {
                        return new Date(value).Format("yyyy-MM-dd");
                    }
                    else {
                        return ""
                    }
                }
            },
            {
                field: 'planDate',
                title: '服务计划完成时间',
                align: 'center',
                width: "120px",
                formatter: function (value, row, index) {
                    if (value) {
                        return new Date(value).Format("yyyy-MM-dd");
                    }
                    else {
                        return ""
                    }
                }
            }
        ],
        onSelectPage: function (pageNumber, pageSize) {
            $('#easyUi_table').datagrid("reload",
                {
                    pageNumber: pageNumber,
                    pageSize: pageSize
                })
        }
    };
    //初始化加载表格
    easyUiTable.initTable(easyUiTableParam);

    //修改服务订单基本信息
    var srvOrder = {
        ele: "#srvOrderForm",
        postUrl: window.ctx + "/serviceOrder/edit",
        submitType: "post",
        rules: {
            serviceId: {
                required: true
            },
            memo: {
                maxlength: 500
            }
        }, message: {
            serviceId: {
                required: "服务不能为空"
            },
            memo: {
                maxlength: "最多输入500个字"
            }
        },
        postDone: function (data) {
            alert(data.msg)
            location.reload()
        }
    }
    //出口代理，报关，报检，清关保存
    var applyProxy = {
        ele: "#applyProxyForm",
        submitType: "auto",
        rules: {
            srvPrice: {
                number: true,
                required: true,
                range: [0.01, 9999999999]
            },
            boker: {
                required: true,
                maxlength: 50
            }
        },
        message: {
            srvPrice: {
                number: "请输入数字",
                range: "请输入正确的价格！",
                required: "价格不能为空"
            },
            boker: {
                required: "报关行不能为空",
                maxlength: "最多输入50个字"
            }
        },
        validateDone: function (form) {
            saveFee($("#applyProxySrvPrice").val(), $("#broker").val(), 3, $("#applyProxyDtl").val(), $("#applyProxyId"), 3)
        }
    }
    var exportTrade = {
        ele: "#exportTradeForm",
        submitType: "auto",
        rules: {
            srvPrice: {
                number: true,
                required: true,
                range: [0.01, 9999999999]
            }
        }, message: {
            srvPrice: {
                range: "请输入正确的价格",
                number: "请输入正确的价格",
                required: "价格不能为空"
            }
        },
        validateDone: function (form) {
            saveFee($("#exportTradeSrvPrice").val(), "", 1, $("#exportTradeDtl").val(), $("#exportTradeId"), 3)
        }
    }
    var inspection = {
        ele: "#inspectionForm",
        submitType: "auto",
        rules: {
            srvPrice: {
                number: true,
                range: [0.01, 9999999999],
                required: true
            }
        }, message: {
            srvPrice: {
                number: "请输入正确的价格",
                range: "请输入正确的价格",
                required: "价格不能为空"
            }
        },
        validateDone: function (form) {
            saveFee($("#inspectionSrvPrice").val(), "", 2, $("#inspectionDtl").val(), $("#inspectionId"), 3)
        }
    }
    var ruClearance = {
        ele: "#ruClearanceForm",
        submitType: "auto",
        rules: {
            srvPrice: {
                number: true,
                range: [0.01, 9999999999],
                required: true
            }
        }, message: {
            srvPrice: {
                range: "请输入正确的价格",
                number: "请输入正确的价格",
                required: "价格不能为空"
            }
        },
        validateDone: function (form) {
            saveFee($("#ruClearanceSrvPrice").val(), "", 4, $("#ruClearanceDtl").val(), $("#ruClearanceId"), 3)
        }
    }
    //新增贸易订单
    var editOrder = {
        ele: "#addOrderForm",
        submitType: "auto",
        rules: {
            tradeCode:{
                required:true,
                maxlength:50
            },
            buyUserName: {
                required: true,
                maxlength: 50
            },
            saleUserName: {
                required: true,
                maxlength: 50
            },
            buyOrgName: {
                required: true,
                maxlength: 50
            },
            saleOrgName: {
                required: true,
                maxlength: 50
            },
            buyContact: {
                required: true,
                maxlength: 50
            },
            saleContact: {
                required: true,
                maxlength: 50
            },
            skuJson: {
                required: true
            },
            cost: {
                number: true,
                range: [0.01, 9999999999]
            }

        },
        message: {
            tradeCode:{
                required:"请输入订单编号",
                maxlength:"最多输入50个字"
            },
            buyUserName: {
                required: "不能为空",
                maxlength: "最多输入50个字"
            },
            saleUserName: {
                required: "不能为空",
                maxlength: "最多输入50个字"
            },
            buyOrgName: {
                required: "不能为空",
                maxlength: "最多输入50个字"
            },
            saleOrgName: {
                required: "不能为空",
                maxlength: "最多输入50个字"
            },
            buyContact: {
                required: "不能为空",
                maxlength: "最多输入50个字"
            },
            saleContact: {
                required: "不能为空",
                maxlength: "最多输入50个字"
            },
            skuJson: {
                required: "商品不能为空"
            },
            cost: {
                number: "只能为数字",
                range: "输入正确的价格"
            }
        },
        validateDone: function (form) {
            skuJson()
            $.ajax({
                url: window.ctx + "/serviceOrder/tradeOrderSave",
                dataType: "json",
                type: "post",
                data: $("#addOrderForm").serialize(),
                success: function (data) {
                    alert(data.msg)
                    location.reload()
                }
            })
        }
    }
    //运输保存
    var CnTrans = {
        ele: "#CnTransForm",
        submitType: "auto",
        rules: {
            srvPrice: {
                range: [0.01, 9999999999],
                number: true,
                required: true
            },
            startProvId: {
                required: true
            },
            startCityId: {
                required: true
            },
            startDistId: {
                required: true
            },
            startAddr: {
                required: true,
                maxlength: 100
            },
            endProvId: {
                required: true
            },
            endCityId: {
                required: true
            },
            endDistId: {
                required: true
            },
            endAddr: {
                required: true,
                maxlength: 100
            },
            contacts: {
                required: true,
                maxlength: 500
            },
            contactsTel: {
                required: true,
                maxlength: 20
            },
            deliveryDate: {
                required: true
            },
            arriveDate: {
                required: true
            },
            deliveryType: {
                required: true
            },
            transType: {
                required: true
            },
            transSpec: {
                required: true
            },
            transVolume: {
                required: true
            }
        },
        message: {
            srvPrice: {
                number: "请输入正确的价格",
                range: "请输入正确的价格",
                required: "服务价格不能为空"
            },
            startProvId: {
                required: "起始省份不能为空"
            },
            startCityId: {
                required: "起始城市不能为空"
            },
            startDistId: {
                required: "起始地区不能为空"
            },
            startAddr: {
                required: "起始地区详细地址不能为空",
                maxlength: "最多输入100个字"
            },
            endProvId: {
                required: "到达省份不能为空"
            },
            endCityId: {
                required: "到达城市不能为空"
            },
            endDistId: {
                required: "到达地区不能为空"
            },
            endAddr: {
                required: "到达地区详细地址不能为空",
                maxlength: "最多输入100个字"
            },
            contacts: {
                required: "联系人姓名不能为空",
                maxlength: "最多输入100个字"
            },
            contactsTel: {
                required: "联系人手机不能为空",
                maxlength: "最多输入20个字"
            },
            deliveryDate: {
                required: "预计发货时间不能为空"
            },
            arriveDate: {
                required: "预计到货时间不能为空"
            },
            deliveryType: {
                required: "交货方式不能为空"
            },
            transType: {
                required: "车辆车型不能为空"
            },
            transSpec: {
                required: "车辆载重不能为空"
            },
            transVolume: {
                required: "车辆规格不能为空"
            }
        },
        validateDone: function (form) {
            orderTrans("Cn", 3)
        }
    }
    var RuTrans = {
        ele: "#RuTransForm",
        submitType: "auto",
        rules: {
            srvPrice: {
                number: true,
                range: [0.01, 9999999999],
                required: true
            },
            endDistIdRu: {
                required: true
            },
            endAddrRu: {
                required: true,
                maxlength: 100
            },
            contacts: {
                required: true,
                maxlength: 100
            },
            contactsTel: {
                required: true,
                maxlength: 20
            },
            deliveryDate: {
                required: true
            },
            arriveDate: {
                required: true
            },
            deliveryType: {
                required: true
            },
            transType: {
                required: true
            },
            transSpec: {
                required: true
            },
            transVolume: {
                required: true
            }
        },
        message: {
            srvPrice: {
                range: "请输入正确的价格",
                number: "请输入正确的价格",
                required: "服务价格不能为空"
            },
            endDistIdRu: {
                required: "交货地不能为空"
            },
            endAddrRu: {
                required: "交货地详细地址不能为空",
                maxlength: "最多输入100个字"
            },
            contacts: {
                required: "联系人姓名不能为空",
                maxlength: "最多输入100个字"
            },
            contactsTel: {
                required: "联系人手机不能为空",
                maxlength: "最多输入20个字"
            },
            deliveryDate: {
                required: "预计发货时间不能为空"
            },
            arriveDate: {
                required: "预计到货时间不能为空"
            },
            deliveryType: {
                required: "交货方式不能为空"
            },
            transType: {
                required: "车辆车型不能为空"
            },
            transSpec: {
                required: "车辆载重不能为空"
            },
            transVolume: {
                required: "车辆规格不能为空"
            }
        },
        validateDone: function (form) {
            orderTrans("Ru", 3)
        }
    }

    //仓库保存
    var CnStore = {
        ele: "#CnStoreForm",
        submitType: "auto",
        rules: {
            srvPrice: {
                number: true,
                range: [0.01, 9999999999],
                required: true
            },
            storageDate: {
                required: true
            },
            deliveryDate: {
                required: true
            },
            storeType: {
                required: true
            },
            storeCapactiy: {
                required: true,
                digits: true,
                range: [1, 9999999999]
            },
            storeDays: {
                required: true,
                digits: true,
                range: [1, 9999999999]
            },
            storeName: {
                maxlength: 100
            }
        }, message: {
            srvPrice: {
                range: "请输入正确的价格",
                number: "请输入正确的价格",
                required: "价格不能为空"
            },
            storageDate: {
                required: "预计入库日期不能为空"
            },
            deliveryDate: {
                required: "预计出库日期不能为空"
            },
            storeType: {
                required: "仓库类型不能为空"
            },
            storeCapactiy: {
                required: "仓库使用面积不能为空",
                digits: "请输入正确的面积",
                range: "请输入正确的面积"
            },
            storeDays: {
                required: "仓库使用天数不能为空",
                digits: "请输入正确的天数",
                range: "请输入正确的天数"
            },
            storeName: {
                maxlength: "最多输入100个字"
            }
        },
        validateDone: function (form) {
            orderStore("Cn", 3)
        }
    }
    var RuStore = {
        ele: "#RuStoreForm",
        submitType: "auto",
        rules: {
            srvPrice: {
                number: true,
                range: [0.01, 9999999999],
                required: true
            },
            storageDate: {
                required: true
            },
            deliveryDate: {
                required: true
            },
            storeType: {
                required: true
            },
            storeCapactiy: {
                required: true,
                digits: true,
                range: [1, 9999999999]
            },
            storeDays: {
                required: true,
                digits: true,
                range: [1, 9999999999]
            },
            storeName: {
                maxlength: 100
            }
        }, message: {
            srvPrice: {
                range: "请输入正确的价格",
                number: "请输入正确的价格",
                required: "价格不能为空"
            },
            storageDate: {
                required: "预计入库日期不能为空"
            },
            deliveryDate: {
                required: "预计出库日期不能为空"
            },
            storeType: {
                required: "仓库类型不能为空"
            },
            storeCapactiy: {
                required: "仓库使用面积不能为空",
                digits: "请输入正确的面积",
                range: "请输入正确的面积"
            },
            storeDays: {
                required: "仓库使用天数不能为空",
                digits: "请输入正确的天数",
                range: "请输入正确的天数"
            },
            storeName:{
                maxlength:"最多输入100个字"
            }
        },
        validateDone: function (form) {
            orderStore("Ru", 3)
        }
    }


    //选择贸易订单
    $("#selTradeOrder").on("change", function () {
        changeTradeOrder()
    });
    //编辑贸易订单页面
    $(document).on('click', '#updateOrder', function () {
        $.ajax({
            url: window.ctx + "/serviceOrder/getOrderEdit/" + $("#selTradeOrder").val(),
            type: "get",
            success: function (data) {
                $("#orderDetail").empty();
                $("#orderDetail").append(data);
            }

        })
    })
    //新增贸易订单页面
    $("#addTradeOrder").on("click", function () {
        $("#orderDetail").attr("style", "display:none");
        $("#addOrder").removeAttr("style")
    })
    //取消新增贸易订单
    $("#reset").on("click", function () {
        $("#addOrder").attr("style", "display:none");
        $("#orderDetail").removeAttr("style")
        $("#addOrderForm")[0].reset()
        $("#addSkuForm")[0].reset()
        $("#tradeOrderSku").empty()
        $("#addSkuDiv").addClass("hidden")
    })
    //修改贸易订单新增商品属性
    $(document).on('click', '#add', function () {
        addSku();
    });
    //修改贸易订单保存
    $(document).on('click', '#editOrderSave', function () {
        skuJson()
        $.ajax({
            url: window.ctx + "/serviceOrder/tradeOrderSave",
            type: "post",
            dataType: "json",
            data: $("#addOrderForm").serialize(),
            success: function (data) {
                alert(data.msg)
                location.reload()
            }
        })
    });
    //修改贸易订单，取消
    $(document).on('click', '#resetEdit', function () {
        changeTradeOrder()
    });
    //新增，编辑贸易订单 展示新增商品输入框
    $(document).on('click', '.add-comm-info-button', function () {
        $(".add-comm-info").removeClass("hidden")
    });
    //新增，编辑贸易订单 隐藏新增商品输入框
    $(document).on('click', '.del-comm-info-button', function () {
        $(".add-comm-info").addClass("hidden")
    });
    //关联贸易订单
    $("#saveOrder").click(function () {
        var isExist = false;
        $("#selTradeOrder option").each(function () {
            if ($(this).text().toUpperCase() == $("#orderCode").val().toUpperCase()) {
                alert("此订单已添加");
                isExist = true;
                return false;
            }
        });

        if (!isExist) {
            $.ajax({
                url: window.ctx + "/serviceOrder/correlation",
                type: "post",
                async: false,
                data: {
                    serviceId: $("#srvOrderId").val(),
                    tradeCode: $("#orderCode").val()
                },
                dataType: "json",
                success: function (e) {
                    if (e.result) {
                        alert("订单添加成功")
                        location.reload()
                    } else {
                        alert("这张订单不属于服务委托方或者订单不存在")
                    }
                }
            });
        }
    });

    $('[data-toggle="tooltip"]').tooltip()

    //增加删除，运输，仓储的车辆和仓库
    $(".car-info-Ru .icon-add").click(function () {
        addTrans(this)
    });
    $(".car-info-Cn .icon-add").click(function () {
        addTrans(this)
    });
    $(".store-info-Cn .icon-add").on("click", function () {
        addStore(this, "cn")
    });
    $(".store-info-Ru .icon-add").on("click", function () {
        addStore(this, "ru")
    });
    $(".car-info-Ru .form-del .icon-del").click(function () {
        $(this).parent().remove();
    });
    $(".car-info-Cn .form-del .icon-del").click(function () {
        $(this).parent().remove();
    });
    $(".store-info-Ru .form-del .icon-del").click(function () {
        $(this).parent().parent().remove();
    });
    $(".store-info-Cn .form-del .icon-del").click(function () {
        $(this).parent().parent().remove();
    });

    //起始地，目的地
    var provSelectCn = $("#startProvCn");
    var citySelectCn = $("#startCityCn");
    var distSelectCn = $("#startDistCn");
    var endProvId = $("#endProvId");
    var endCityId = $("#endCityId");
    var endDistId = $("#endDistId");
    if ("" === $("#startProvCn").val()) {
        citySelectCn.hide();
        distSelectCn.hide();
        loadAddress("/address/province/1", provSelectCn);
    }
    if ("" === $("#endProvId").val()) {
        endCityId.hide();
        endDistId.hide();
        loadAddress("/address/province/1", endProvId);
    }
    if ("" === $("#startDistCn").val()) {
        distSelectCn.hide();
    }
    if ("" === $("#endDistId").val()) {
        endDistId.hide();
    }
    provSelectCn.on("change", function () {
        var provId = provSelectCn.val();
        if (provId) {
            distSelectCn.hide();
            distSelectCn.children().first().siblings().remove();
            loadAddress("/address/city/" + provId, citySelectCn);
        }
    });
    endProvId.on("change", function () {
        var provId = endProvId.val();
        if (provId) {
            endDistId.hide();
            endDistId.children().first().siblings().remove();
            loadAddress("/address/city/" + provId, endCityId);
        }
    });
    citySelectCn.on("change", function () {
        var cityId = citySelectCn.val();
        if (cityId) {
            loadAddress("/address/district/" + cityId, distSelectCn);
        }
    });
    endCityId.on("change", function () {
        var cityId = endCityId.val();
        if (cityId) {
            loadAddress("/address/district/" + cityId, endDistId);
        }
    });
    validatorFrom.initValidatorFrom(applyProxy);
    validatorFrom.initValidatorFrom(editOrder);
    validatorFrom.initValidatorFrom(exportTrade);
    validatorFrom.initValidatorFrom(inspection);
    validatorFrom.initValidatorFrom(ruClearance);
    validatorFrom.initValidatorFrom(CnTrans);
    validatorFrom.initValidatorFrom(RuTrans);
    validatorFrom.initValidatorFrom(CnStore);
    validatorFrom.initValidatorFrom(RuStore);
    validatorFrom.initValidatorFrom(srvOrder);
})

//保存价格
function saveFee(srvPrice, broker, serviceId, srvOrderDtlId, id, costType) {
    $.ajax({
        url: window.ctx + "/serviceOrder/saveFee",
        type: "post",
        async: false,
        dataType: "json",
        data: {
            srvPrice: srvPrice,
            serviceId: serviceId,
            srvOrderDtlId: srvOrderDtlId,
            brokerName: broker,
            id: id.val(),
            srvOrderId: $("#srvOrderId").val(),
            costType: costType
        },
        success: function (data) {
            if (data.result) {
                id.val(data.data)
            }
            alert(data.msg)
        }
    })
}
//车辆
function orderTrans(langTag, costType) {
    var saveUrl = "/serviceOrder/serviceTrans";
    var transObj = []
    $(".car-info-" + langTag).children("div").each(function (i, n) {
        var transTable = {};
        transTable.autoType = $(this).find("select[data-alias='autoType']").val()
        transTable.autoSpec = $(this).find("select[data-alias='autoSpec']").val()
        transTable.autoVolume = $(this).find("select[data-alias='autoVolume']").val()
        transTable.autoLicense = $(this).find("select[data-alias='car']").val()
        var name = $("option:selected", $(this).find("select[data-alias='driver']"))
        var tel = $("option:selected", $(this).find("select[data-alias='driver']"))
        transTable.driver = ("option:selected", name).data("name");
        transTable.driverTel = ("option:selected", tel).data("mobile");
        transObj.push(transTable)
    })
    $("#" + langTag + "TransJson").val(JSON.stringify(transObj))
    $("#" + langTag + "TransSrvOrderId").val($("#srvOrderId").val())
    transStoreSave($("#" + langTag + "TransForm").serialize() + "&costType=" + costType,
        saveUrl,
        $("#" + langTag + "TransId"),
        costType
    );
}
//仓库
function orderStore(langTag, costType) {
    var saveUrl = "/serviceOrder/serviceStore";
    var storeObj = []
    $(".store-info-" + langTag).children("div").each(function (i, n) {
        var cnStoreTable = {};
        cnStoreTable.storageType = $(this).find("select[data-alias='storageType']").val()
        cnStoreTable.storageSize = $(this).find("input[data-alias='capacity']").val()
        cnStoreTable.days = $(this).find("input[data-alias='days']").val()
        cnStoreTable.storageId = $(this).find("select[data-alias='storageId']").val()
        if (cnStoreTable.storageId == 1 || cnStoreTable.storageId == 2) {
            cnStoreTable.storageSeat = $(this).find("select[data-alias='storageName']").find("option:selected").text()
        } else {
            cnStoreTable.storageSeat = $(this).find("input[data-alias='storageName']").val()
        }

        storeObj.push(cnStoreTable)
    })
    console.log(storeObj)
    $("#" + langTag + "StoreJson").val(JSON.stringify(storeObj))
    $("#" + langTag + "StoreSrvOrderId").val($("#srvOrderId").val())
    transStoreSave($("#" + langTag + "StoreForm").serialize() + "&costType=" + costType,
        saveUrl,
        $("#" + langTag + "StoreId"));
}

//获取地址
function loadAddress(url, target) {
    $.get(window.ctx + url, function (data) {
        target.children().first().siblings().remove();
        data.forEach(function (d, i) {
            target.append($("<option></option>").val(d.id).text(d.cnname));
        });
        if (data.length > 0) {
            target.show();
        }
    }, "json");
}

/**
 * 查询商品分类 生成select
 * @param cid      父分类id
 * @param target   目标select
 */
function loadCatalogList(url, target) {
    cleanOption(target);
    $.get(url, function (data) {
        data.forEach(function (d) {
            target.append($("<option/>").val(d.catalogId).text(d.catalogNameCn));
        });
    }, "json");
}

//清除select下除了第一个之外的option
function cleanOption(target) {
    target.children().first().siblings().remove();
}
//加载二级产品分类
function loadCs2(s) {
    loadCatalogList(window.ctx + "/catalog/subCatalog?catalogId=" + $(s).val(), $("select.catalogSelect2:visible"));
    cleanOption($("select.catalogSelect3:visible"));
    cleanOption($("select.productSelect:visible"));
}
//加载三级产品分类
function loadCs3(s) {
    cleanOption($("select.productSelect:visible"));
    loadCatalogList(window.ctx + "/catalog/subCatalog?catalogId=" + $(s).val(), $("select.catalogSelect3:visible"));
}
//加载产品列表
function loadPro(s) {
    var target = $("select.productSelect:visible");
    cleanOption(target);
    $.get(window.ctx + "/catalog/getProduct?catalogId=" + $(s).val(), function (data) {
        data.forEach(function (d) {
            $("<option/>")
                .val(d.productId)
                .text(d.productNameCn)
                .attr("data-hscode", d.hscode)
                .attr("data-productnameru", d.productNameRu)
                .attr("data-logoUrl", d.logoUrl)
                .attr("data-unitid", d.unitId)
                .attr("data-unitname", d.unitNameCn)
                .appendTo(target);
        });
    }, "json");
}


function addSku() {
    var sku = '<tr id="sku' + $("#tradeOrderSkuTable tr").length + '"><td><table><tbody><tr><td>'
    var productId = $("#productId").val();
    var productName = $("#productId option:selected").text()+"</br>"+$("#productId").find("option:selected").data("productnameru");
    var unitId = $("#productId").find("option:selected").data("unitid");
    var logourl = $("#productId").find("option:selected").data("logourl");
    var unitName = $("#productId").find("option:selected").data("unitname");
    var costTypeName = $("#costType").find("option:selected").data("costname")
    var packageName = $("#packageType").find("option:selected").data("packagename")
    var costType = $("#costType").find("option:selected").val();
    sku += '<img src="' + logourl + '" width="70" height="70" style="margin-right:20px"></td><td class="text_l"><br/>'
    sku += productName;
    sku += '</td></tr></tbody></table></td>';
    sku += '<td data-logourl="' + logourl + '">' + $("#count").val() + '</td>';
    sku += '<td data-unitid="' + unitId + '" data-productid="'+productId+'">' + unitName + '</td>';
    sku += '<td>' + $("#stand").val() + '</td>';
    sku += '<td data-packagetype="' + $("#packageType").val() + '">';
    sku += packageName;
    sku += '</td>'
    var unitPrice = $("#price").val();
    sku += '<td data-costtype="' + costType + '" data-unitprice="' + unitPrice + '">';
    sku += unitPrice;
    sku += '</td><td>';
    sku += unitPrice * $("#count").val() + '</td>';
    sku += '<input type="hidden" value="' + $("#catalog2").val() + '">';
    sku += '<input type="hidden" value="' + $("#catalog2").val() + '">';
    sku += '<input type="hidden" value="' + $("#catalog2").val() + '">';
    sku += '<input type="hidden" value="' + $("#productId").val() + '">';
    sku += '<td>';
    sku += '<span class="icon icon-del visible" onclick="delSku(this)"></span>';
    sku += '</td>';
    sku += '</tr>';
    $("#tradeOrderSku").append(sku)
}

function transStoreSave(data, saveUrl, langTag) {
    $.ajax({
        url: window.ctx + saveUrl,
        type: "post",
        data: data,
        async: false,
        dataType: "json",
        success: function (data) {
            alert(data.msg)
            langTag.val(data.data)
        }
    })
}

function addTrans(data) {
    var str = ' <div class="form-del">'
    str += '<div class="form-inline"><div class="form-group"> '
    str += '<select class="form-control"data-alias="autoType" name="transType">'
    $("select[data-alias='autoType']").eq(0).find("option").each(function (i, n) {
        str += '<option value="' + $(n).val() + '">' + $(n).text() + '</option>'
    })
    str += '</select></div><div class="form-group"> <select class="form-control" data-alias="autoSpec" name="transSpec">'
    $("select[data-alias='autoSpec']").eq(0).find("option").each(function (i, n) {
        str += '<option value="' + $(n).val() + '">' + $(n).text() + '</option>'
    })
    str += '</select></div><div class="form-group"><select class="form-control" data-alias="autoVolume" name="transVolume">'
    $("select[data-alias='autoVolume']").eq(0).find("option").each(function (i, n) {
        str += '<option value="' + $(n).val() + '">' + $(n).text() + '</option>'
    })
    str += '</select></div><div class="form-group"><select class="form-control" data-alias="car">'
    $("select[data-alias='car']").eq(0).find("option").each(function (i, n) {
        str += '<option value="' + $(n).val() + '">' + $(n).text() + '</option>'
    })
    str += '</select></div><div class="form-group"><select class="form-control" data-alias="driver">'
    $("select[data-alias='driver']").eq(0).find("option").each(function (i, n) {
        str += '<option value="' + $(n).val() + '" data-name="' + $(n).data("name") + '" data-mobile="' + $(n).data("mobile") + '">' + $(n).text() + '</option>'
    })
    str += '</select></div>'
    str += '<a href="javascript:void(0)" class="icon icon-del visible" onclick=" $(this).parent().remove();"></a></div></div>'
    $(data).before(str);
}


function addStore(data, str) {
    var strs = ' <div class="form-del">'
    strs += '<div class="form-inline"><div class="form-group"> '
    strs += '<select class="form-control store-type-' + str + '" data-alias="storageType" name="storeType">'
    $("select[data-alias='storageType']").eq(0).find("option").each(function (i, n) {
        strs += '<option value="' + $(n).val() + '">' + $(n).text() + '</option>'
    })
    strs += '</select></div><div class="form-group">'
    strs += '<input type="text" data-alias="capacity" value="" class="form-control" name="storeCapactiy"> 平方米 '
    strs += '</div><div class="form-group">'
    strs += '<input data-alias="days" type="text" class="form-control" placeholder="天数" name="storeDays">天'
    strs += '</div><div class="form-group">'
    strs += '<select class="form-control stock"data-alias="storageId" name="store">'
    $("select[data-alias='storageId']").eq(0).find("option").each(function (i, n) {
        strs += '<option value="' + $(n).val() + '">' + $(n).text() + '</option>'
    })
    strs += '</select></div><div class="form-group"></div>'
    strs += '<a href="javascript:void(0)" class="icon icon-del visible" onclick=" $(this).parent().remove();"></a></div></div>'
    $(data).before(strs);
}


function delSku(data) {
    $(data).closest("tr").remove()
}
//状态
function changeStatus(srvOrderId, status) {
    var flag = true
    if (confirm("是否确认执行？")) {
        if(status == 2){
            $.ajax({
                url:window.ctx+"/serviceOrder/isSrvPriceNotNull",
                type:"post",
                dataType:"json",
                data:{
                    srvOrderId:srvOrderId
                },
                success:function(data){
                    if(!data.result){
                        alert("请输入服务价格")
                    }else{
                        $.ajax({
                            url: window.ctx + "/serviceOrder/changeStatus",
                            type: "post",
                            async: false,
                            data: {
                                srvOrderId: srvOrderId,
                                status: status
                            },
                            dataType: "json",
                            success: function (data) {
                                location.reload()
                            }
                        })
                    }
                }
            })
        }else{
            $.ajax({
                url: window.ctx + "/serviceOrder/changeStatus",
                type: "post",
                async: false,
                data: {
                    srvOrderId: srvOrderId,
                    status: status
                },
                dataType: "json",
                success: function (data) {
                    location.reload()
                }
            })
        }
        }
}
//代理审核状态
function changeAuditStatus(srvOrderId, status) {
    if (confirm("是否确认审核？")) {
        $.ajax({
            url: window.ctx + "/serviceOrder/changeAuditStatus",
            type: "post",
            async: false,
            data: {
                srvOrderId: srvOrderId,
                status: status
            },
            success: function (data) {
                location.reload()
            }
        })
    }
}


function getStoreList(datas, type) {
    $(datas).parent().parent().find("select[name='store']").find("option").remove()
    $.ajax({
        url: window.ctx + "/serviceOrder/getStoreList",
        dataType: "json",
        async: false,
        type: "post",
        data: {
            storage: $(datas).val(),
            countryType: type
        },
        success: function (data) {
            $(datas).parent().parent().find("select[name='store']").append("<option value=''>请选择</option>")
            data.data.forEach(function (d) {
                $("<option>").val(d.id).text(d.storageNameCn).appendTo($(datas).parent().parent().find("select[name='store']"))
            })
        }
    })
}


function delTradeOrder() {
    $.ajax({
        url: window.ctx + "/serviceOrder/delTradeOrder",
        type: "post",
        data: {
            tradeOrderId: $("#selTradeOrder").val()
        },
        async: false,
        dataType: "json",
        success: function (data) {
            alert("删除成功！")
            location.reload()
        }
    })
}


function clickAtta(nodeId) {
    $.ajax({
        url: window.ctx + "/serviceOrder/getAtta",
        dataType: "json",
        type: "post",
        async: false,
        data: {
            nodeId: nodeId
        },
        success: function (data) {
            var str = ""
            data.data.forEach(function (d) {
                str += '<div class="col-xs-6">';
                str += '<a target="_blank" href="' + d.attaPath + '"><img src="' + d.attaPath + '" class="img-responsive dis_inb" alt=""></a>';
                str += '<p>' + d.attaName + '</p></div>'
            })
            $("#attaRow").empty()
            $("#attaRow").append(str)
        }
    })
}

function skuJson() {
    var skuStr = []
    $("#tradeOrderSku").children().each(function (i, n) {
        var skuList = {}
        skuList.productName = $.trim($(this).children("td").eq(0).text())
        skuList.productId = $(this).children("td").eq(2).data("productid")
        skuList.purchareNum = $.trim($(this).children("td").eq(1).text())
        skuList.unit = $(this).children("td").eq(2).data("unitid")
        skuList.unitPrice = $(this).children("td").eq(5).data("unitprice")
        skuList.photoUrl = $(this).children("td").eq(1).data("logourl")
        skuList.costType = $(this).children("td").eq(5).data("costtype")
        skuList.standard = $.trim($(this).children("td").eq(3).text())
        skuList.packageType = $(this).children("td").eq(4).data("packagetype")
        skuStr.push(skuList);
    })
    $("#skuJson").val(JSON.stringify(skuStr))
}

function changeTradeOrder() {
    $.ajax({
        url: window.ctx + "/serviceOrder/getOrder/" + $("#selTradeOrder").val(),
        type: "get",
        success: function (data) {
            $("#orderDetail").empty();
            $("#orderDetail").append(data);
        }

    })
}