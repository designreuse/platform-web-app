/**
 * Created by Administrator on 2015/11/16.
 */

$(function () {

    var re = /^[0-9]+.?[0-9]*$/

    //改变服务订单号，展示对应服务订单详情
    $("#srvOrderList").on("change", function () {
        $.ajax({
            url: window.ctx + "/order/getSrvOrder",
            data: {
                srvOrderId: $("#srvOrderList").val()
            },
            dataType: "json",
            type: "post",
            success: function (data) {
                console.log(data.data)
                $("#status").text(data.data.statusNameCn);
                if(data.data.countryType==1){
                    $("#orgNameCn").text(data.data.orgNameCn);
                    $("#userNameCn").text(data.data.userNameCn);
                }
                if(data.data.countryType==2){
                    $("#orgNameCn").text(data.data.orgNameRu);
                    $("#userNameCn").text(data.data.userNameFirst);
                }
//                $("#orgNameCn").text(data.data.orgNameCn);
//                $("#userNameCn").text(data.data.userNameCn);
                $("#customNameCn").text(data.data.customNameCn);
                $("#serviceName").text(data.data.srvNameCn);
                $("#createTime").text(new Date(data.data.createTime).Format("yyyy-MM-dd"));
                $("#srvOrderDtl").attr("href", window.ctx + '/srvOrder/' + data.data.srvOrderId + '/edit');
            }
        })
    })

    //预付款比例为100%，尾款支付期限不要
    $("#paywayPercent").on("change", function () {
        if ($(this).val() == 3) {
            $("#finalPayType").attr("style", "display:none")
        } else {
            $("#finalPayType").removeAttr("style")
        }
    })

    //订单完成，取消，修改订单状态
    $("#execute").on("click", function () {
        updateOrderStatus($("#orderId").val(), 2)//执行
    })
    $("#cancel").on("click", function () {
        updateOrderStatus($("#orderId").val(), 3)//取消
    })

    //保存贸易订单
    var orderSave = {
        ele: "#orderForm",
        submitType: "auto",
        rules: {
            deliveryDate: {
                required: true
            },
            lastDate: {
                required: true

            }
        },
        messages: {
            deliveryDate: {
                required: "预计交货日期不能为空"
            },
            lastDate: {
                required: "最晚交货日期不能为空"
            }
        },
        validateDone: function (form) {
            //保存贸易订单
            var json = []
            $("#orderSku tr").each(function (n) {
                var sku = {}
                sku.productId = $(this).children("td").eq(0).data("productid");
                sku.skuId = $(this).children("td").eq(0).data("skuid");
                sku.photoUrl = $(this).children("td").eq(0).data("photourl")
                sku.unit = $(this).children("td").eq(2).data("unit")
                sku.unitPrice = $(this).children("td").eq(4).text().replace(/,/g,'');
                sku.purchareNum = $(this).children("td").eq(2).data("purcharenum").replace(/,/g,'');
                sku.standard = $(this).children("td").eq(3).data("standard").replace(/,/g,'')
                sku.packageType = $(this).children("td").eq(3).data("packagetype")
                sku.costType = $(this).children("td").eq(2).data("costtype")
                console.log(sku)
                json.push(sku)
            })
            $("#skuJson").val(JSON.stringify(json))
            $.post(window.ctx + "/order/edit",
                $(form).serialize(),
                function (data) {
                    alert(data.msg)
                },"json");
        }
    };
    validatorFrom.initValidatorFrom(orderSave);
    //修改商品属性，保存
    var editSkuSave = {
        ele: "#editSkuForm",
        submitType: "auto",
        rules: {
            orderEditSkuPurchareNum: {
                required: true,
                number:true,
                range: [0.01, 9999999999]
            },
            orderEditSkuStandard: {
                required: true,
                number:true,
                range: [0.01, 9999999999]
            },
            orderEditSkuUnitPrice: {
                required: true,
                number:true,
                range: [0.01, 9999999999]
            }
        },
        messages: {
            orderEditSkuUnitPrice: {
                required: "单价不能为空",
                number:"单价必须是数字",
                range: "请输入正确的价格！"
            },
            orderEditSkuStandard: {
                required: "标准件不能为空",
                number:"标准件必须是数字",
                range:"请输入正确的标准件！"
            },
            orderEditSkuPurchareNum: {
                required: "采购量不能为空",
                number:"采购量必须是数字",
                range:"请输入正确的采购量！"
            }
        },
        validateDone: function (form) {
             var skuId = $("#orderEditSkuId").val()
            var money= $("#orderEditSkuPurchareNum").val()*$("#orderEditSkuUnitPrice").val()
            $("#" + skuId).children("td").eq(2).text(formatNumber($("#orderEditSkuPurchareNum").val(),2,0) + $("#orderEditSkuUnitName1").text()).data("purcharenum",formatNumber($("#orderEditSkuPurchareNum").val(),2,0) )
            $("#" + skuId).children("td").eq(3).text(formatNumber($("#orderEditSkuStandard").val(),2,0) + $("#orderEditSkuUnitName1").text()).data("standard",formatNumber($("#orderEditSkuStandard").val(),2,0))
            $("#" + skuId).children("td").eq(4).text(formatNumber($("#orderEditSkuUnitPrice").val(),2,1))
            $("#" + skuId).children("td").eq(5).text(formatNumber(money,2,1))
            $("#" + skuId).children("td").eq(5).data("money",money)
            $("#count").text("合计："+$("#count").data("costname")+formatNumber(($("#count").data("money")-$("#hideMoney").val()+money),2,1))
            $("#close").click()
            $("#count").data("money",($("#count").data("money")-$("#hideMoney").val()+money))
        }
    };
    validatorFrom.initValidatorFrom(editSkuSave);

})

function updateOrderStatus(orderId, status) {
    if (confirm("是否确认操作！")) {
        $.ajax({
            url: window.ctx + "/order/changeStatus",
            type: "post",
            dataType:"json",
            data: {
                orderId: orderId,
                status: status
            },
            success: function (data) {
                alert(data.msg)
                location.href = window.ctx + "/order/list"
            }

        })

    }
}

//删除一行商品
function delSku(skuId){
    if($("#orderSku").children().length>1){
        var money=$("#" + skuId).children("td").eq(5).data("money")
        $("#" + skuId).remove();
        $("#count").text("合计："+$("#count").data("costname")+formatNumber(($("#count").data("money")-money),2,1))
    }else{
        alert("商品是必填")
    }
}

//将商品信息展示到模态框
function editSku(skuId) {
    $("#orderEditSkuName").text($("#" + skuId).children("td").eq(1).data("catalogfirstnamecn") + ">" +
        $("#" + skuId).children("td").eq(1).data("catalogsecondnamecn") + ">" +
        $("#" + skuId).children("td").eq(1).data("catalognamecn") + ">" +
        $("#" + skuId).children("td").eq(1).data("productnamecn"))
    $("#orderEditSkuUnitPrice").val($("#" + skuId).children().eq(4).text().replace(/,/g,''))
    $("#orderEditSkuPurchareNum").val($("#" + skuId).children().eq(2).data("purcharenum").replace(/,/g,''))
    $("#orderEditSkuStandard").val($("#" + skuId).children().eq(3).data("standard").replace(/,/g,''))
    $("#orderEditSkuUnitName1").text($("#" + skuId).children().eq(2).data("unitnamecn"))
    $("#orderEditSkuUnitName2").text($("#" + skuId).children().eq(2).data("unitnamecn")+"/份")
    $("#orderEditSkuId").val(skuId)
    $("#hideMoney").val($("#" + skuId).children().eq(5).data("money"))
}
