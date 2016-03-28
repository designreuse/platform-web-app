/**
 * Created by Administrator on 2015/12/3.
 */

$(function(){


//    $("#skuList").find("div").forEach(function(d){
//        console.log(d)
//    })

    $("#divDeliveryDate").datetimepicker("setStartDate",new Date().Format("yyyy-MM-dd"));
    $("#divLastDate").datetimepicker("setStartDate",new Date().Format("yyyy-MM-dd"));

    //预付款比例为100%，尾款支付期限不展示
    $("#paywayPercent").on("change",function(){
            if($(this).val()==3){
                $("#paywayLast").attr("style","display:none")
                $("#paywayLast").val(null)
            }else{
                $("#paywayLast").removeAttr("style")
                $("#paywayLast").val(1)

            }
    })


    $(document).on('click', '.border-transparent', function(){
        $(this).parent().children(".border-transparent").css("border-color","transparent");
        $(this).css("border-color","#5bc0de");
        $('input[name=skuId]:checked').removeAttr('checked');
        $(this).children(".select-box").children("input[name=skuId]").prop('checked',true);
    })


    //模糊搜索买方
    $( "#userName" ).autocomplete({
        source:window.ctx+"/inquiry/userList",
        minLength: 1,
        autoFocus:true,
        select: function(e, ui) {
            $( "#userId").val(ui.item.id);
        },
        change:function(e,ui){
            $( "#userId").val(ui.item.id);
        }
    });
    //模糊搜索卖方商铺
    $("#shopsName").autocomplete({
        source:window.ctx+"/inquiry/shopList",
        minLength : 1,
        autoFocus:true,
        search: function(e, ui) {
            $("#shopsId").val('');
            $("#addSku").show();
            $("#findSku").hide();
        },
        select : function(e,ui){
            $("#shopsId").val(ui.item.id);
            $("#addSku").hide();
            $("#findSku").show();
            $("#skuTable").empty();
            getSkuList()
        }
    });

    //更改货币类型，清空以选择的所有商品，商铺的商品列表展示货币类型为该类型的sku
    $("#costType").on("change",function(){
        getSkuList()
        $("#skuTable").empty()
    })

    //添加product商品
    var addSku = {
        ele: "#addSkuForm",
        submitType: "auto",
        rules: {
            productId: {
                required: true
            },
            purchareNum: {
                required: true,
                number:true
            },
            unitPrice:{
                required: true,
                number:true
            },
            standard:{
                required: true,
                number:true
            },
            product:{
                required:function(e){
                    var table = $("#addSkuForm");
                    var productSelect = $("select[name='productId']",table);
                    var productId = productSelect.val();
                    //$("#skuTable").children("tr").forEach(function(n){
                    //    if($(n).data("productid")==productId){
                    //        return true
                    //    }
                    //})
                    return false;
                }
                //required:true
            }
        },
        messages: {
            productId: {
                required: "请选择商品"
            },
            purchareNum: {
                required: "采购量不能为空",
                number:"采购量必须是数字"
            },
            unitPrice:{
                required: "求购价不能为空",
                number:"求购价必须是数字"
            },
            standard:{
                required: "标准件不能为空",
                number:"标准件必须是数字"
            },
            product:{
                required:"标准商品重复"
            }
        },
        validateDone:function(data){
            var table = $("#addSkuForm");
            var productSelect = $("select[name='productId']",table);
            var obj={}
            obj.productId = productSelect.val();                                  //产品id
            obj.skuNameCn = "";                                                   //sku名称
            obj.skuId = "";                                                   //sku名称
            obj.productName = $("option:selected",productSelect).text();          //产品名称
            obj.prop = "--";                                             //产品属性
            obj.logoUrl = $("option:selected",productSelect).attr("data-logoUrl");//产品图片
            obj.costType = $("select[name='costType']",table).val();               //货币类型
            obj.unit = $("option:selected",productSelect).data("unitid");                         //单位id
            obj.unitName = $("option:selected",productSelect).data("unitname");                 //单位名称
            obj.stanardUnit = $("option:selected",productSelect).data("standardunitid");                         //单位id
            obj.stanardUnitName = $("option:selected",productSelect).data("standardunitname");                 //单位名称
            obj.unitPrice = $("input[name='unitPrice']",table).val();               //单价
            obj.purchareNum = $("input[name='purchareNum']",table).val();         //采购数量
            obj.standard = $("input[name='standard']",table).val();               //标准件
            var packageTypeSelect = $("select[name='packageType']",table);
            obj.packageType = packageTypeSelect.val();                          //包装方式编号
            obj.packageTypeName = $("option:selected",packageTypeSelect).text();  //包装方式名称
            $("#skuTable").append(buildTr(obj));
            $("#addComm .close").click();//关闭模态框
            $("#inquiryType").val(2)//不定项询盘
            $(".table-hide").next("div").remove()
        }
    }
    validatorFrom.initValidatorFrom(addSku);
    //添加商铺商品
    var findSkuForm = {
        ele: "#findSkuForm",
        submitType: "auto",
        rules: {
            skuId: {
                required: true
            },
            purchareNum: {
                required: true,
                number:true
            },
            unitPrice:{
                required: true,
                number:true
            },
            standard:{
                required: true,
                number:true
            }
        },
        messages: {
            skuId: {
                required: "请选择商品"
            },
            purchareNum: {
                required: "采购量不能为空",
                number:"采购量必须是数字"
            },
            unitPrice:{
                required: "求购价不能为空",
                number:"求购价必须是数字"
            },
            standard:{
                required: "标准件不能为空",
                number:"标准件必须是数字"
            }
        },
        validateDone:function(form){
            $.ajax({
                url:window.ctx+"/inquiry/getSkuBo",
                dataType:"json",
                type:"post",
                data:{
                    skuId:$(form).find("input[name=skuId]:checked").val()
                },
                success:function(data){
                    var table = $("#findSkuForm");
                    var obj={}
                    var prop = "";
                    data.data.skuPropertyBoList.forEach(function (d) {
                        prop += d.propertyNameCn + "：" + d.propertyValue + "<br/>";
                    });
                    obj.prop = prop
                    obj.skuId = data.data.skuId
                    obj.skuNameCn = data.data.skuNameCn
                    obj.productId = data.data.productId                                  //产品id
                    obj.productName = data.data.productNameCn          //产品名称
                    obj.logoUrl = data.data.logoUrl;//产品图片
                    obj.unit = data.data.unitId                      //单位id
                    obj.unitName = data.data.unitNameCn                 //单位名称
                    obj.stanardUnit = data.data.standardUnitId                        //单位id
                    obj.stanardUnitName = data.data.standardUnitCn               //单位名称
                    obj.unitPrice = $("input[name='unitPrice']",table).val();               //单价
                    obj.purchareNum = $("input[name='purchareNum']",table).val();         //采购数量
                    obj.standard = $("input[name='standard']",table).val();               //标准件
                    var packageTypeSelect = $("select[name='packageType']",table);
                    obj.packageType = packageTypeSelect.val();                          //包装方式编号
                    obj.packageTypeName = $("option:selected",packageTypeSelect).text();  //包装方式名称
                    $("#skuTable").append(buildTr(obj));
                    ($("#skuList").find("div[data-skuid='"+data.data.skuId+"']")).remove()
                    $("#chooseComm .close").click();
                    $("#inquiryType").val(1)
                }
            })
        }
    }
    validatorFrom.initValidatorFrom(findSkuForm);
    //修改商品
    var updateSkuForm = {
        ele: "#updateSkuForm",
        submitType: "auto",
        rules: {
            purchareNum: {
                required: true,
                number:true
            },
            unitPrice:{
                required: true,
                number:true
            },
            standard:{
                required: true,
                number:true
            }
        },
        messages: {
            purchareNum: {
                required: "采购量不能为空",
                number:"采购量必须是数字"
            },
            unitPrice:{
                required: "求购价不能为空",
                number:"求购价必须是数字"
            },
            standard:{
                required: "标准件不能为空",
                number:"标准件必须是数字"
            }
        },
        validateDone:function(form){
            var sku = ''
            if($("#updateSkuId").val()){
                sku = $("#skuTable").find("tr[data-skuid = "+$("#updateSkuId").val()+"]").children()
            }else(
                sku = $("#skuTable").find("tr[data-productid = "+$("#updateProductId").val()+"]").children()
            )
            sku.eq(0).data("unit",$("#updateSkuUnit").data("unit"))
            sku.eq(0).data("unitprice",$("#updateSkuPrice").val())
            sku.eq(0).data("standard",$("#updateSkuStandard").val())
            sku.eq(0).data("purcharenum",$("#updateSkuPurchareNum").val())
            sku.eq(0).data("packagetype",$("#updateSkuPackageType").val())
            sku.eq(0).data("standardunitname",$("#updateSkuStandard").data("standardunit"))
            sku.eq(0).data("unitname",$("#updateSkuUnit").text())
            sku.eq(2).text("采购量："+formatNumber($("#updateSkuPurchareNum").val(),2,0)+$("#updateSkuUnit").text())
            sku.eq(3).text("标准件："+formatNumber($("#updateSkuStandard").val(),2,0)+$("#updateSkuUnit").text()+"/"+$("#updateSkuPackageType").find("option:selected").text())
            sku.eq(4).text("求购价："+formatNumber($("#updateSkuPrice").val(),2,1))
            sku.eq(5).text(formatNumber(($("#updateSkuPurchareNum").val()*$("#updateSkuPrice").val()),2,1))
            $("#updateSkuForm .close").click();
        }
    }
    validatorFrom.initValidatorFrom(updateSkuForm);
    //新增询回盘
    var inquiryForm = {
        ele: "#inquiryForm",
        submitType: "auto",
        rules: {
            deliveryDate: {
                required: true
            },
            effectiveDate:{
                required:true
            },
            userId:{
                required:true
            },
            lastDate:{
                required: true
            },
            memo:{
                maxlength:200
            },
            tableLength:{
                required:function(){
                    if($("#skuTable tr").length>0){
                        return false
                    }else{
                        return true
                    }
                }
            }
        },
        messages: {
            deliveryDate: {
                required: "预计交货日期不能为空"
            },
            effectiveDate:{
                required: "询盘有效期不能为空"
            },
            userId:{
                required:"请输入正确的买方"
            },
            lastDate: {
                required: "最晚交货日期不能为空"
            },
            memo:{
                maxlength:"最多输入200字"
            },
            tableLength:{
                required:"商品不能为空"
            }
        },
        validateDone:function(form){
            var skuJson = []
            $("#skuTable").children().each(function(i,n){
                var obj = {}
                obj.skuId = $(this).children().eq(0).data("skuid")
                obj.productid = $(this).children().eq(0).data("productid")
                obj.standard = $(this).children().eq(0).data("standard")
                obj.unitPrice = $(this).children().eq(0).data("unitprice")
                obj.unit = $(this).children().eq(0).data("unit")
                obj.purcharenum = $(this).children().eq(0).data("purcharenum")
                obj.packagetype = $(this).children().eq(0).data("packagetype")
                obj.costType = $("#costType").val()
                skuJson.push(obj)
            })
            $("#skuJson").val(JSON.stringify(skuJson))
            $.ajax({
                url:window.ctx+"/inquiry/edit",
                type:"post",
                dataType:"json",
                async : false,
                data:$("#inquiryForm").serialize(),
                success:function(data){
                    alert(data.msg)
                    location.href=window.ctx+"/inquiry/list";
                }
            })
        }
    }
    validatorFrom.initValidatorFrom(inquiryForm);
})

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
    target.children(":not(:first)").remove();
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
                .attr("data-standardunitid", d.standardUnitId)
                .attr("data-standardunitname", d.standardUnitCn)
                .attr("data-logoUrl", d.logoUrl)
                .attr("data-unitid", d.unitId)
                .attr("data-unitname", d.unitNameCn)
                .appendTo(target);
        });
    }, "json");
}

//商品
function buildTr(obj){
    var costType=$("#costType").val()
    var tr = $("<tr></tr>").attr("data-skuId",obj.skuId).attr("data-productId",obj.productId);
    $("<td data-skuid='"+obj.skuId+"' data-productid='"+obj.productId+"' data-unit='"+obj.unit+"' data-unitPrice='"+obj.unitPrice+"'" +
        " data-unitname='"+obj.unitName+"' data-standardunitname='"+obj.stanardUnitName+"'"+
        " data-standard='"+obj.standard+"' data-purchareNum='"+obj.purchareNum+"' data-packageType='"+obj.packageType+"'>" +
        "<img src='"+obj.logoUrl+"' width='80' height='80' class='l mr-10'>"+
        " <p class='dis_inb'> "+obj.skuNameCn+"<br/>"+obj.productName+"<br></p></td>").appendTo(tr);
    $("<td>"+obj.prop+"</td>").appendTo(tr);
    $("<td>采购量："+formatNumber(obj.purchareNum,2,0)+"&nbsp;"+obj.unitName+"</td>").appendTo(tr);
    $("<td>标准件："+formatNumber(obj.standard,2,0)+"&nbsp;"+obj.stanardUnitName+"/"+obj.packageTypeName+"</td>").appendTo(tr);
    $("<td>求购价："+formatNumber(obj.unitPrice,2,1)+"</td>").appendTo(tr);
    $("<td>"+formatNumber((obj.purchareNum*obj.unitPrice),2,1)+"</td>").appendTo(tr);
    $("<td class='f-14 user-manage'>" +
        "<a href='javascript:void(0)' class='icon icon-edit visible' data-toggle='modal'data-target='#editComm' onClick='editProduct(this);'></a>"+
        "<a href='javascript:void(0)' onClick='$(this).parent().parent().remove();' class='icon icon-del visible'></a>"+
        "<i class='icon-trash'></i></a></td>").appendTo(tr);
    return tr;
}

//获取商铺商品列表
function getSkuList(){
    $.ajax({
        url:window.ctx+"/inquiry/skuList",
        dataType:"json",
        type:"post",
        data:{
            shopsId:$("#shopsId").val(),
            costType:$("#costType").val()
        },
        success:function(data){
            $("#skuList").empty()
            data.forEach(function(d){
                var div = $("<div class='row border-transparent'></div>")
                    .attr("data-unit", d.skuUnitId)
                    .attr("data-unitnamecn", d.skuUnitCn)
                    .attr("data-standunit", d.skuStandardUnitCn)
                    .attr("data-skuId", d.skuId)
                div.append($("<div class='col-xs-4 select-box'><img src='"+d.logoUrl+"' class='img-responsive'>"+
                        "<input type='radio' name='skuId' value="+ d.skuId+"></div><div class='col-xs-8'>"+ d.skuNameCn+
                        "<br/>"+ d.productNameCn+"</div>")
                    )
                    .appendTo($("#skuList"));
            })

            $("#skuList").children().each(function(i,n){
                $(n).on("click",function(){
                    $("#choosePrice").text($("#costType").find("option:selected").text())
                    $("#chooseNum").text($(this).data("unitnamecn"))
                    $("#chooseStand").text($(this).data("standunit"))
                })
        })

        }
    })
}

function  editProduct(data){
    var td = $(data).parent().prevAll().last()
    var form = $("#updateSkuForm");
    var packageTypeSelect = $("select[name='packageType']",form);
    var cost = $("#costType");
    $("#updateSkuId").val(td.data("skuid"))
    $("#updateProductId").val(td.data("productid"))
    $("#updateSkuPrice").val(td.data("unitprice"))
    $("#updateSkuStandardUnit").text(td.data("standardunitname")+"/份").data("standardunit",td.data("standardunitname"))
    $("#updateSkuStandard").val(td.data("standard"))
    $("#updateSkuUnit").text(td.data("unitname")).data("unit",td.data("unit"))
    $("#updateSkuPurchareNum").val(td.data("purcharenum"))
    $("#updateSkuPackageType").val(packageTypeSelect.val())
    $("#updateSkuCost").text($("option:selected",cost).text()+"/"+td.data("unitname"))
}

//询盘有效期
function effectiveDateChange(){
    if($("#effectiveDateSelect").val()){
        $("input[name='effectiveDate']").val(CurrentDateAddDay($("#effectiveDateSelect").val()))
    }else{
        $("input[name='effectiveDate']").val("");
    }
}

$("#productId").on("change",function(){
        console.log($(this).find("option:selected"))
       $("#unitPriceId").text($("#costType").find("option:selected").text())
       $("#purchareNumId").text($(this).find("option:selected").data("unitname"))
       $("#standardId").text($(this).find("option:selected").data("standardunitname"))
})
