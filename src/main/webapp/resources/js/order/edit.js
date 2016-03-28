var skuList

$(document).ready(function () {

    $("#paywayPercent").change(function(){
        if($("#paywayPercent").val()==3){
            $("#paywayLast").attr("style","display:none")
        }else{
            $("#paywayLast").removeAttr("style")
        }
    })

    $(".public_examine").click(function(){
        $("#proId").val(this.id)
    });

    $("#submit").click(function() {
        var data = $("#skuId").val()
        console.log($("#" + data + "td"))
        var skutype
        if ($("#skuType").val() == 1) {
            skutype = "箱"
        }
        if ($("#skuType").val() == 2) {
            skutype = "包"
        }
        if ($("#skuType").val() == 3) {
            skutype = "篮"
        }
        $("#" + data + " td").eq(6).text($("#price").val())
        $("#" + data + " td").eq(7).text($("#price").val() * $("#purchareNum").val())
        $("#" + data + " td").eq(2).text($("#purchareNum").val())
        $("#" + data + " td").eq(3).text($("#standard").val())
        $("#" + data + " td").eq(4).text(skutype)
    });

    $("#orderSubmit").click(function() {
        if(!$("#orderCode").val()){
            alert("贸易合同编号不能为空")
            return;
        }
        if(!$("#deliveryDate").val()){
            alert("预计交货日期不能为空")
            return;
        }
        if(!$("#lastDate").val()){
            alert("最晚交货日期不能为空")
            return;
        }
        if($("#lastDate").val() < $("#deliveryDate").val()){
            alert("最晚交货日期需要大于等于预计交货日期")
            return;
        }



        var obj = []
        $("#product tr").each(function (i, n) {
            var product = {};
            var skuType
            if ($(this).children("td").eq(4).text() == "箱") {
                skuType = 1;
            }
            if ($(this).children("td").eq(4).text() == "包") {
                skuType = 2;
            }
            if ($(this).children("td").eq(4).text() == "篮") {
                skuType = 3;
            }
            product.purchareNum = $.trim($(this).children("td").eq(2).text())
            product.standard = $.trim($(this).children("td").eq(3).text())
            product.unit = $.trim($(this).children("td").eq(5).text())
            product.unitPrice = $.trim($(this).children("td").eq(6).text())
            product.skuType = $.trim(skuType)
            obj.push(product)
        });

        if(obj.length ==0){
            alert("商品不能为空")
            return;
        }

        $("#strJson").val(JSON.stringify(obj));
        $.ajax({
            url: window.ctx + "/order/edit",
            type: "post",
            data: $("#orderForm").serialize(),
            success: function () {
                alert("保存成功！")
            }, error: function () {
                alert("保存失败！")
            }
        });
    });

    $("#order_cancel").click(function(){
        if(confirm("确认取消？")){
            $.ajax({
                url:window.ctx+"/order/updateStatus",
                type:"POST",
                data:{
                    orderId:$("#orderId").val(),
                    status:3
                },
                success:function(){
                    location.href=window.ctx+"/order/list"
                }
            })
        }
    });

    $("#updateStatus").click(function(){
        if(confirm("确认完成？")){
            $.ajax({
                url:window.ctx+"/order/updateStatus",
                type:"POST",
                data:{
                    orderId:$("#orderId").val(),
                    status:2
                },
                success:function(){
                    location.reload()
                }
            })
        }
    })

    $("#tradeCode").change(function(){
        $.ajax({
            url:window.ctx+"/order/serviceOrderEdit",
            type:"post",
            data:{
                srvOrderId:$("#tradeCode").val()
            },
            dataType:"json",
            success:function(data){
                console.log(data.serviceOrderBo)
                var str="";
                var status =""
                if(data.serviceOrderBo.status ==1){
                    status="待确认"
                }else if(data.serviceOrderBo.status ==2) {
                    status = "待分配"
                }else if(data.serviceOrderBo.status ==3) {
                    status = "执行中"
                }else if(data.serviceOrderBo.status ==4) {
                    status = "已执行"
                }else if(data.serviceOrderBo.status ==5) {
                    status = "已取消"
                }else{
                    status="已终止"
                }
                jQuery("#relevanceServiceOrder tr").remove();
                console.log(data.serviceOrderBo)
                tabStr='<tr><th width="16%" class="text-r">服务订单状态：</th>'
                tabStr+='<td width="84%">'+status+'</td>'
                tabStr+='</tr><tr><th class="text-r">服务委托方：</th>'
                if(data.serviceOrderBo.countryType == 1){
                    tabStr+='<td>'+data.serviceOrderBo.orgNameCn+'</td>'
                    tabStr+='</tr><tr><th class="text-r">委托方联系人：</th>'
                    tabStr+='<td>'+data.serviceOrderBo.userNameCn+'</td>'
                }else{
                    tabStr+='<td>'+data.serviceOrderBo.orgNameRu+'</td>'
                    tabStr+='</tr><tr><th class="text-r">委托方联系人：</th>'
                    tabStr+='<td>'+data.serviceOrderBo.userNameFirst+'&nbsp;&nbsp;'+data.serviceOrderBo.userNameLast+'</td>'
                }

                tabStr+='</tr><tr><th class="text-r">服务供应商：</th>'
                if(data.serviceOrderBo.customServiceName == null){
                    tabStr+='<td> 满洲里诚林贸易有限责任公司  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 客服：无</td>'
                }else{
                    tabStr+='<td> 满洲里诚林贸易有限责任公司  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 客服：'+data.serviceOrderBo.customServiceName+'</td>'
                }
                tabStr+='</tr><tr><th class="text-r">委托服务：</th>'
                tabStr+='<td>'+data.serviceOrderBo.orderService+'</td>'
                tabStr+='</tr><tr><th class="text-r">下单时间：</th><td>'
                tabStr+=new Date(data.serviceOrderBo.createTime).Format("yyyy-MM-dd");
                tabStr+='</td></tr><tr><th class="text-r">&nbsp;</th>'
                tabStr+='<td><a href="'+window.ctx+'/serviceOrder/'+data.serviceOrderBo.srvOrderId+'/edit" _href="javascript:void(0)">查看服务订单详情</a></td>'
                tabStr+='</tr>'
                $("#relevanceServiceOrder").html(tabStr);
            }
        })
    });
});

function updateSku(data){
    var tr=$(data).closest("tr")
    $.ajax({
        dataType:"json",
        url:window.ctx+"/sku/getDetil",
        type:"post",
        data:{
            skuId:$(data).attr("id")
        },
        success:function(data){
            $("#skuId").val(data.data.skuId)
            $("#price").val($("#sku_"+data.data.skuId+"_unitPrice").val())
            $("#purchareNum").val($("#sku_"+data.data.skuId+"_purchareNum").val())
            $("#standard").val($("#sku_"+data.data.skuId+"_standard").val())
            $("#packageType").val($("#sku_"+data.data.skuId+"_packageType").val())
        }
    })
    }


