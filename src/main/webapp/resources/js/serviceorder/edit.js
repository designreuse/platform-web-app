/**
 * Created by Administrator on 2015/8/10.
 */

$(document).ready(function () {
    //美化CheckBox 参数{input类名，选择类型(单选or多选)}
    //地址栏
    var provSelectCn = $("#startProvCn");
    var citySelectCn = $("#startCityCn");
    var distSelectCn = $("#startDistCn");
    var endProvId = $("#endProvId");
    var endCityId = $("#endCityId");
    var endDistId = $("#endDistId");
    if("" === $("#startProvCn").val()){
        citySelectCn.hide();
        distSelectCn.hide();
        loadAddress("/address/province/1",provSelectCn);
    }
    if("" === $("#endProvId").val()){
        endCityId.hide();
        endDistId.hide();
        loadAddress("/address/province/1",endProvId);
    }
    if("" === $("#startDistCn").val()){
        distSelectCn.hide();
    }
    if("" === $("#endDistId").val()){
        endDistId.hide();
    }

    provSelectCn.on("change",function(){
        var provId = provSelectCn.val();
        if(provId){
            distSelectCn.hide();
            distSelectCn.children().first().siblings().remove();
            loadAddress("/address/city/"+provId,citySelectCn);
        }
    });
    endProvId.on("change",function(){
        var provId = endProvId.val();
        if(provId){
            endDistId.hide();
            endDistId.children().first().siblings().remove();
            loadAddress("/address/city/"+provId,endCityId);
        }
    });
    citySelectCn.on("change",function(){
        var cityId = citySelectCn.val();
        if(cityId){
            loadAddress("/address/district/"+cityId,distSelectCn);
        }
    });
    endCityId.on("change",function(){
        var cityId = endCityId.val();
        if(cityId){
            loadAddress("/address/district/"+cityId,endDistId);
        }
    });

    $("#srvOrder_stop").click(function(){
        if(confirm("是否确认取消订单？")){
            updateStatus($("#srvOrderId").val(),5)
        }
    })

    $("#srvOrder_stops").click(function(){
        if(confirm("是否确认终止订单？")) {
            updateStatus($("#srvOrderId").val(), 6)
        }
    })

    $("#srv_confirm").click(function(){
        if(confirm("是否确认订单？")){
            var srvOrderId = $("#srvOrderId").val();
            updateStatus(srvOrderId,2);
        }
    })

    //添加贸易订单
    $("#addTradeOrders").click(function(){
//        $("#saveUpdate").hide()
//        $("#addTradeOrder").attr("style","display:block")
//        $("#tradeOrders").attr("style","display:none")
        $("#orderShow").attr("style","display:none")
        $("#orderEdit").attr("style","display:block")

    });

    //删除贸易订单
    $("#delTradeOrder").on("click",function(){
        delTradeOrder()
    })


    //编辑贸易订单
    $("#tradeOrderUpdate").on("click",function(){
        delTradeOrder()
    })

    $("#product").change(function(){
        $.ajax({
            url:window.ctx+"/srvOrder/getPropertyByProduct",
            data:{
                productId:$("#product").val()
            },
            type:"post",
            dataType:"json",
            success:function(){

            }
        })
    })

    //保存基本信息
    $("#save").click(function(){
        var chk_value =[];//定义一个数组
        $('input[name="serviceId"]:checked').each(function(){//遍历每一个名字为interest的复选框，其中选中的执行函数
            var service = {}
            service.serviceId = $(this).val()
            chk_value.push(service);//将选中的值添加到数组chk_value中
        });
        var strJson=JSON.stringify(chk_value);
        $.ajax({
            url:window.ctx+"/serviceOrder/edit?"+$("#orderForm").serialize(),
            type:"post",
            data:{
                json:strJson
            },
            dataType:"json",
            success:function(data){
                if(data.result){
                    location.reload()
                }
                alert(data.msg)
            }
        })
    });

    //添加仓储
    $(".addStore").click(function() {
        var store = '<tr>'
        store += '<td>'
        store += '<select class="select storageType" onchange="changeStore(this)" data-alias="storageType" size="1" style="width:120px"> '
        $("select[data-alias='storageType']").eq(0).find("option").each(function(i,n){
            store+='<option value="'+$(n).val()+'">'+$(n).text()+'</option>'
        })
        store += '</select>'
        store += ' <input type="text" data-alias="capacity" value="" style="width:150px" class="input-text"> 立方米 '
        store += ' <input data-alias="days" type="text" class="input-text" style="width:150px"> 天 '
        store += ' <select class="select storageSelect" data-alias="srvStoreId" size="1" style="width:120px">'
        store += ' <option>仓库名称</option>'
        store += '</select>'
        store += ' <input data-alias="storageSeat" type="text" class="input-text"  placeholder="库位" style="width:150px">'
        store += ' <button type="button" class="delStore" onclick="deleteStores(this)">删除</button></td></tr>'
        $(this).closest("table").after(store)
    });



    //删除仓储
    $(".delStores").click(function(){
        $(this).closest("tr").remove()
    });

    //添加车辆
    $(".addTrans").click(function() {
        var trans = '<tr>'
        trans += '<td>'
        trans += '<select class="select" data-alias="autoType" size="1" style="width:120px">'
        $("select[data-alias='autoType']").eq(0).find("option").each(function(i,n){
            trans+='<option value="'+$(n).val()+'">'+$(n).text()+'</option>'
        })
        trans += '</select>'
        trans += ' - <select class="select" data-alias="autoSpec"  size="1" style="width:120px">'
        $("select[data-alias='autoSpec']").eq(0).find("option").each(function(i,n){
            trans+='<option value="'+$(n).val()+'">'+$(n).text()+'</option>'
        })
        trans += '</select>'
        trans += ' - <select class="select" data-alias="autoVolume" size="1" style="width:120px">'
        $("select[data-alias='autoVolume']").eq(0).find("option").each(function(i,n){
            trans+='<option value="'+$(n).val()+'">'+$(n).text()+'</option>'
        })
        trans += '</select>'
        trans += ' - <input type="text" data-alias="autoLicense"  placeholder="车牌" value="" style="width:120px" class="input-text">'
        trans += ' <input type="text" data-alias="driver" placeholder="司机姓名" value="" style="width:120px" class="input-text">'
        trans += ' <input type="text" data-alias="driverTel" placeholder="司机手机" value="" style="width:120px" class="input-text"> '
        trans += '<button type="button"  class="deleteTrans" onclick="deleteTrans(this)">删除</button></td></tr>';
        $(this).closest("table").after(trans)
    });

    //删除车辆
    $(".delTrans").click(function(){
        $(this).closest("tr").remove()
    });



    $("#correlations").click(function(){

        if ($("#linkTradeCode").val().trim()==""){
            alert("请输入订单号");
            return;
        }
        var isExist=false;
        $("#selTradeOrder option").each(function(){
            if ($(this).text().toUpperCase()==$("#linkTradeCode").val().toUpperCase()){
                alert("此订单已添加");
                isExist=true;
                return false;
            }
        });

        if (!isExist){
            $.ajax({
                url:window.ctx+"/serviceOrder/correlation",
                type:"post",
                data:{
                    serviceId:$("#srvOrderId").val(),
                    tradeCode:$("#linkTradeCode").val()
                },
                dataType:"json",
                success:function(e){
                    alert(e.msg)
                    location.reload()
                }
            });
        }
    });
    //选择关联订单
    $("#selTradeOrder").change(function(){
        $.ajax({
            url:window.ctx+"/serviceOrder/getorder/"+$("#selTradeOrder").val(),
            type:"get",
            success:function(data){
                $("#orderDetail tr").remove();
                $("#orderDetail").append(data);
            }

        })
    });

    $("#exportTradeSubmit").click(function(){
        submitFee($("#exportTrade").val(),1,$("#exportTradeDtl").val(),$("#exportTradeId"))
    });

    $("#inspectionSubmit").click(function(){
        submitFee($("#inspection").val(),2,$("#inspectionDtl").val(),$("#inspectionId"))
    });

    $("#applyproxySubmit").click(function(){
        if(!$("#applyproxy").val()){
            alert("服务价格不能为空")
            return;
        }
        if(!$("#broker").val()){
            alert("报关行不能为空")
            return;
        }
        $.ajax({
            url: window.ctx + "/serviceOrder/serviceFree",
            type: "post",
            dataType:"json",
            data: {
                srvPrice: $("#applyproxy").val(),
                serviceId: 3,
                srvOrderDtlId: $("#applyproxyDtl").val(),
                broker:$("#broker").val(),
                id:$("#applyproxyId").val(),
                srvOrderId:$("#srvOrderId").val()
            },
            success: function (data) {
                alert(data.msg)
                if(data.result){
                    $("#applyproxyId").val(data.data)
                }
                console.log(data)
            },
            error: function () {
                alert("保存失败！")
            }
        })
    });

    $("#ruClearanceSubmit").click(function(){
        submitFee($("#ruClearance").val(),4,$("#ruClearanceDtl").val(),$("#ruClearanceId"))
    });

    //国内物流保存
    $("#CnTrans").click(function(){
        if(!$("#startCityCn").val()){
            alert("发货地不能为空");
            return;
        }
        if(!$("#startAddr").val()){
            alert("发货地具体地址不能为空");
            return;
        }
        if(!$("#endCityId").val()){
            alert("目的地不能为空");
            return;
        }
        if(!$("#endAddr").val()){
            alert("目的地具体地址不能为空");
            return;
        }
        orderTrans($("#CnTransTable tr"),"Cn");

    });

    //俄境物流保存
    $("#RuTrans").click(function(){
        if(!$("#endProvIdRu").val()){
            alert("交货地不能为空");
            return;
        }
        if(!$("#endAddrRu").val()){
            alert("交货地具体地址不能为空");
            return;
        }

        orderTrans($("#RuTransTable tr"),"Ru");

    });

    //国内物流保存
    $("#CnStore").click(function(){
        orderStore($("#CnStoreTable tr"),"Cn");
    });

    //俄境仓储保存
    $("#RuStore").click(function(){
        orderStore($("#RuStoreTable tr"),"Ru");
    });





});

//Sku重置取消
function resetSku (){
    $("#orderShow").attr("style","display:block");
    $("#orderEdit").attr("style","display:none");
}

//Sku保存skuSubmit
function skuSubmit(){
    var sku=[]
    $("#tradeOrderSkuList tr").each(function(i,n){
        
        var skuList = {}
        skuList.productName=$.trim($(this).children("td").eq(0).text())
        skuList.purchareNum=$.trim($(this).children("td").eq(1).text())
        skuList.unit=$(this).children("td").eq(2).data("unitid")
        skuList.unitPrice=$(this).children("td").eq(5).data("unitprice")
        skuList.photoUrl=$(this).children("td").eq(1).data("logourl")
        skuList.costType = $(this).children("td").eq(5).data("costtype")
        skuList.standard=$.trim($(this).children("td").eq(3).text())
        if($(this).children("td").eq(4).text()=="箱"){
            skuList.packageType=1
        }
        if($(this).children("td").eq(4).text()=="盒"){
            skuList.packageType=2
        }
        if($(this).children("td").eq(4).text()=="桶"){
            skuList.packageType=3
        }
        console.log(skuList);
        sku.push(skuList);
    })
    $.ajax({
        url:window.ctx+"/serviceOrder/tradeOrderSave?"+$("#createTradeOrderForm").serialize(),
        type:"post",
        data:{
            skuJson:JSON.stringify(sku)
        },
        success:function(data){
            alert("保存成功！")
            $(':input','#createTradeOrderForm')
                .not(':button, :submit, :reset, :hidden')
                .val('')
                .removeAttr('checked')
                .removeAttr('selected');
            $("#addTradeOrder").attr("style","display:none")
            $("#tradeOrders").attr("style","")
            location.reload();
        }
    });
}


$("#add").click(function(){
    addSku();
});

function addSku() {
    var sku = '<tr id="' + $("#tradeOrderSkuTable tr").length + '"><td>'
    var productId = $("#productId option:selected").val();
    if("" == $("#productId").val() || null == $("#productId").val()){
        return alert("填写数据不完整");
    }
    var productName = $("#productId option:selected").text();
    var unitId = $("#productId").find("option:selected").data("unitid");
    var logourl = $("#productId").find("option:selected").data("logourl");
    var unitName = $("#productId").find("option:selected").data("unitname");
    var costTypeName = $("#costType").find("option:selected").text();
    var costType = $("#costType").find("option:selected").val();
    sku += productName;
    sku += '</span></td>';
    sku += '<td data-logourl="'+logourl+'">'+$("#Count").val()+'</td>';
    sku += '<td data-unitid="'+unitId+'">'+unitName+'</td>';
    sku += '<td>'+$("#stand").val()+'</td>';
    sku += '<td>';
    if ($("#type").val() == 1) {
        sku += "箱";
    }
    if ($("#type").val() == 2) {
        sku += "盒";
    }
    if ($("#type").val() == 3) {
        sku += "桶";
    }
    sku += '</td>'
    var unitPrice = $("#price").val();
    sku +='<td data-costtype="'+costType+'" data-unitprice="'+unitPrice+'">';
    sku += unitPrice+costTypeName;
    sku += '</td><td>';
    sku += unitPrice * $("#Count").val() + '</td>';
    sku += '<input type="hidden" value="' + $("#catalog2").val() + '">';
    sku += '<input type="hidden" value="' + $("#catalog2").val() + '">';
    sku += '<input type="hidden" value="' + $("#catalog2").val() + '">';
    sku += '<input type="hidden" value="' + $("#productId").val() + '">';
    sku += '<td class="f-14 user-manage">';
//    sku += '<a title="编辑" onclick="updateSku(this)" href="javascript:void(0)" target="_self" class="ml-5 public_examine" style="text-decoration:none">';
//    sku += '<i class="icon-edit"></i>';
//    sku += '</a> ';
    sku += '<a title="删除" onclick="delSku(this)" href="javascript:void(0)"  class="ml-5" style="text-decoration:none">';
    sku += '<i class="icon-trash"></i>';
    sku += '</a>';
    sku += '</td>';
    sku += '</tr>';
    $("#tradeOrderSkuList").append(sku)
}


//根据仓库类型获取对应仓库
function changeStore(data){
    var thisSelect = $(data)
    $.ajax({
        url:window.ctx+"/serviceOrder/store",
        data:{
            storageType:thisSelect.val()
        },
        type:"post",
        dataType:"json",
        success:function(data){
            thisSelect.siblings(".storageSelect").children().remove()
            thisSelect.siblings(".storageSelect").append($("<option></option>").val(" ").text("--请选择--"));
            $(data.storeList).each(function(i,n) {
                thisSelect.siblings(".storageSelect").append($("<option></option>").val(n.id).text(n.storageName));
            })
        }
    })
};


function orderTrans(objTr,langTag) {
    if(!$("#contacts"+langTag).val()){
        alert("联系人姓名不能为空");
        return;
    }
    if(!$("#contactsTel"+langTag).val()){
        alert("联系人联系方式不能为空");
        return;
    }
    if(!$("#deliveryDate"+langTag).val()){
        alert("预计发货时间不能为空");
        return;
    }
    if(!$("#arriveDate"+langTag).val()){
        alert("预计到货时间不能为空");
        return;
    }
    if($("#deliveryDate"+langTag).val()>$("#arriveDate"+langTag).val()){
        alert("预计到货时间需大于预计收货时间");
        return;
    }
    if(!$("#transPrice"+langTag).val()){
        alert("服务价格不能为空")
        return
    }
    var saveUrl="/serviceOrder/serviceTrans?";
    var transObj = []
    var flag =false;
    objTr.each(function (i, n) {
        if(i<3){
            return
        }
        var count = objTr.eq(3).find("td").find("tr").length
        if(i== (count+3)){
            return false
        }
        var cnTransTable = {};
        cnTransTable.autoType = $.trim(objTr.eq(3).find("td").find("tr").eq(i-3).children("td").find("select[data-alias='autoType']").val())
        cnTransTable.autoSpec = $.trim(objTr.eq(3).find("td").find("tr").eq(i-3).children("td").find("select[data-alias='autoSpec']").val())
        cnTransTable.autoVolume = $.trim(objTr.eq(3).find("td").find("tr").eq(i-3).children("td").find("select[data-alias='autoVolume']").val())
        cnTransTable.autoLicense = $.trim(objTr.eq(3).find("td").find("tr").eq(i-3).children("td").find("input[data-alias='autoLicense']").val())
        cnTransTable.driver = $.trim(objTr.eq(3).find("td").find("tr").eq(i-3).children("td").find("input[data-alias='driver']").val())
        cnTransTable.driverTel = $.trim(objTr.eq(3).find("td").find("tr").eq(i-3).children("td").find("input[data-alias='driverTel']").val())
        if(!objTr.eq(3).find("td").find("tr").eq(i-3).children("td").find("select[data-alias='autoType']").val()||
            !objTr.eq(3).find("td").find("tr").eq(i-3).children("td").find("select[data-alias='autoSpec']").val()||
            !objTr.eq(3).find("td").find("tr").eq(i-3).children("td").find("select[data-alias='autoVolume']").val()){
            flag = true
            return false;
        }
        transObj.push(cnTransTable)
    })
    console.log(flag)
    if(flag){
        alert("车辆类型，载重量，规格不能为空")
        return
    }
    transStoreSave($("#Trans" + langTag).serialize(),
        transObj,
        saveUrl,
        $("#" + langTag+"TransId")
    );
}
function orderStore(objTr,langTag) {
    if(!$("#storageDate"+langTag).val()){
        alert("预计入库日期不能为空")
        return;
    }
    if(!$("#storeDate"+langTag).val()){
        alert("预计出库日期不能为空")
        return;
    }
    if($("#storageDate"+langTag).val()>$("#storeDate"+langTag).val()){
        alert("预计出库日期需大于预计入库日期");
        return;
    }
    if(!$("#storePrice"+langTag).val()){
        alert("服务价格不能为空")
        return;
    }
    var saveUrl="/serviceOrder/serviceStore?";
    var storeObj=[]
    var flag = false
    objTr.each(function(i,n){

        if(i == objTr.find("td").eq(1).find("tr").length){
            return false;
        }
        var cnStoreTable = {};
        cnStoreTable.storageType=$.trim(objTr.find("td").eq(1).find("tr").eq(i).children("td").find("select:first").val())
        cnStoreTable.storageSize=$.trim(objTr.find("td").eq(1).find("tr").eq(i).children("td").find("input[data-alias='capacity']").val())
        cnStoreTable.days=$.trim(objTr.find("td").eq(1).find("tr").eq(i).children("td").find("input[data-alias='days']").val())
        cnStoreTable.storageId=$.trim(objTr.find("td").eq(1).find("tr").eq(i).children("td").find("select[data-alias='srvStoreId']").val())
        cnStoreTable.storageSeat=$.trim(objTr.find("td").eq(1).find("tr").eq(i).children("td").find("input[data-alias='storageSeat']").val())
        if(!objTr.find("td").eq(1).find("tr").eq(i).children("td").find("select:first").val() ||
            !objTr.find("td").eq(1).find("tr").eq(i).children("td").find("input[data-alias='capacity']").val() ||
            !objTr.find("td").eq(1).find("tr").eq(i).children("td").find("input[data-alias='days']").val()){
            flag = true
            return false;
        }
        storeObj.push(cnStoreTable)
    })
    if(flag){
        alert("仓库类型,仓库面积,天数不能为空")
        return
    }
    transStoreSave($("#Store" + langTag).serialize(),
        storeObj,
        saveUrl,
        $("#" + langTag+"StoreId"));
}

function deleteTrans(data){
    $(data).closest("tr").remove()
};
function deleteStores(data){
    $(data).closest("tr").remove()
};

function delTradeOrder() {
    $.ajax({
        url: window.ctx+"/serviceOrder/delTradeOrder",
        type: "post",
        data: {
            tradeOrderId: $("#selTradeOrder").val()
        },
        dataType: "json",
        success: function (data) {
            //$("#orderTradeCode").find("option[id=" + data.srvOrderId + "]").remove();
            alert("删除成功")
            location.reload()
        }
    })
}

function updateOrder() {
    $.ajax({
        url:window.ctx+"/serviceOrder/getOrderEdit/"+$("#selTradeOrder").val(),
        type:"get",
        success:function(data){
//            $("#orderDetail tr").remove();
//            $("#orderDetail").append(data);
            $("#orderShow").attr("style","display:none")
            $("#orderEdit").attr("style","display:block")
            $("#createTradeOrderTb tr").remove();
            $("#createTradeOrderTb").append(data);
            $("#saveUpdate").hide();
        }

    })
}

function submitFee (data,serviceId,dtlId,id) {
    if(!data){
        alert("服务价格不能为空")
        return;
    }
    $.ajax({
        url: window.ctx + "/serviceOrder/serviceFree",
        type: "post",
        dataType:"json",
        data: {
            srvPrice: data,
            serviceId: serviceId,
            srvOrderDtlId: dtlId,
            id:id.val(),
            srvOrderId:$("#srvOrderId").val()
        },
        success: function (data) {
            if(data.result){
                id.val(data.data)
            }
            alert(data.msg)
        },
        error: function () {
            alert("保存失败！")
        }
    })
}

function transStoreSave(data,transJson,saveUrl,langTag){
    $.ajax({
        url: window.ctx + saveUrl + data+"&srvOrderId="+$("#srvOrderId").val(),
        type: "post",
        data: {
            transJson: JSON.stringify(transJson)
        },
        dataType:"json",
        success: function (data) {
            alert(data.msg)
            if(data.result){
                langTag.val(data.data)
            }
        }
    })
}

function updateSku(data) {
    $("#saveUpdate").show()
    var tr = $(data).closest("tr")
    $("#skuName").val(tr.find("td").eq(0).text())
    $("#Count").val(tr.find("td").eq(1).text())
    $("#units").val(tr.find("td").eq(2).text())
    $("#stand").val(tr.find("td").eq(3).text())
    if (tr.find("td").eq(3).text() == "箱") {
        $("#stand").val(1)
    }
    if (tr.find("td").eq(3).text() == "盒") {
        $("#stand").val(2)
    }
    if (tr.find("td").eq(3).text() == "桶") {
        $("#stand").val(3)
    }
    $("#price").val(tr.find("td").eq(5).text())
    $("#saveUpdate").attr("onclick", 'saveSkuUpdate(' + tr.attr("id") + ')')
}

function delSku(data){
    $(data).closest("tr").remove()
}

function saveSkuUpdate(data){
    $("#saveUpdate").hide()
    $("#"+data).find("td").eq(0).text($("#skuName").val())
    $("#"+data).find("td").eq(1).text($("#Count").val())
    $("#"+data).find("td").eq(2).text($("#units").val())
    $("#"+data).find("td").eq(3).text($("#stand").val())
    if($("#type").val()==1){
        $("#"+data).find("td").eq(4).text("箱")
    }
    if($("#type").val()==2){
        $("#"+data).find("td").eq(4).text("盒")
    }
    if($("#type").val()==3){
        $("#"+data).find("td").eq(4).text("桶")
    }
    $("#"+data).find("td").eq(5).text($("#price").val())
    $("#"+data).find("td").eq(6).text($("#price").val() * $("#Count").val())
}

/**
 * 查询商品分类 生成select
 * @param cid      父分类id
 * @param target   目标select
 */
function loadCatalogList(url,target){
    cleanOption(target);
    $.get(url,function(data){
        data.forEach(function(d){
            target.append($("<option/>").val(d.catalogId).text(d.catalogNameCn));
        });
    },"json");
}
//清除select下除了第一个之外的option
function cleanOption(target){
    target.children().first().siblings().remove();
}
//加载二级产品分类
function loadCs2(s){
    loadCatalogList(window.ctx+"/inquiry/catalogList/"+$(s).val(),$("select.catalogSelect2:visible"));
    cleanOption($("select.catalogSelect3:visible"));
    cleanOption($("select.productSelect:visible"));
}
//加载三级产品分类
function loadCs3(s){
    cleanOption($("select.productSelect:visible"));
    loadCatalogList(window.ctx+"/inquiry/catalogList/"+$(s).val(),$("select.catalogSelect3:visible"));
}

//加载产品列表
function loadPro(s){
    var target = $("select.productSelect:visible");
    cleanOption(target);
    $.get(window.ctx+"/inquiry/productList/"+$(s).val(),function(data){
        data.forEach(function(d){
            $("<option/>")
                .val(d.productId)
                .text(d.productNameCn)
                .attr("data-hscode", d.hscode)
                .attr("data-logoUrl", d.logoUrl)
                .attr("data-unitid", d.unitId)
                .attr("data-unitname", d.unitName)
                .appendTo(target);
        });
    },"json");
}

function updateStatus(data,status){
   var url=window.ctx+"/serviceOrder/updateStatus";
        $.ajax({
        url:url,
        type:"post",
        data:{
            srvOrderId:data,
            status:status
        },
        success:function(){
            location.reload()
        }
    });
}

function loadAddress(url,target){
    $.get(window.ctx+url,function(data){
        target.children().first().siblings().remove();
        data.forEach(function(d,i) {
            target.append($("<option></option>").val(d.id).text(d.cnname));
        });
        if(data.length>0){
            target.show();
        }
    },"json");
}
