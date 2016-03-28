/**
 * Created by Administrator on 2015/12/7.
 */
$(function(){

    $(document).on('click', '.border-transparent', function () {
        $(this).parent().children(".border-transparent").css("border-color", "transparent");
        $(this).css("border-color", "#5bc0de");
        $('input[name=skuId]:checked').removeAttr('checked');
        $(this).children(".select-box").children("input[name=skuId]").prop('checked', true);
    })

    $("#shopsName").autocomplete({
        source:window.ctx+"/inquiry/shopList",
        minLength : 1,
        autoFocus:true,
        select : function(e,ui){
            $("#shopsId").val(ui.item.id)
        }
    });

    $(".addSku").on("click",function(){
        var shopsId=$("#shopsId").val();
        var shopsName=$("#shopsName").val();
        if(shopsId == null){
            alert("请先选择店铺")
        }
        location.href=window.ctx+"/sku/add?shopsId="+shopsId+"&shopsName="+shopsName
    })


    $("#refuse").on("click",function(){
        $.ajax({
            url:window.ctx+"/inquiry/changeStatus",
            dataType:"json",
            type:"post",
            async : false,
            data:{
                inquiryId:$("#inquiryId").val(),
                inquiryType:$("#inquiryType").val(),
                feedBackId:$("#inquiryFeedbackId").val(),
                status:5
            },
            success:function(data){
                alert(data.msg)
                location.href=window.ctx+"/inquiry/list"
            }
        })
    })

    var skuForm = {
        ele: "#skuForm",
        submitType: "auto",
        rules: {
            skuId: {
                required: true
            }
        },
        messages: {
            skuId: {
                required: "请选择商品"
            }
        },
        validateDone:function(data){
            $.ajax({
                url:window.ctx+"/inquiry/getSkuBo",
                dataType:"json",
                type:"post",
                async : false,
                data:{
                    skuId:$("#skuForm").find("input[name=skuId]:checked").val()
                },
                success:function(data){
                    var index=$("#skuTr").val()
                    $("#sku_"+index).find("td[name=skuProperties]").empty();
                    var str=""
                    console.log(data.data)
                    data.data.skuPropertyBoList.forEach(function(d){
                        str+= d.propertyNameCn+":"+d.propertyValue+"<br/>"
                    })
                    $("#sku_"+index).find("td[name=skuProperties]").append(str)
                    $("#sku_"+index).data("skuid",data.data.skuId)
                    $("#chooseComm .close").click();
                }
            })
        }
    }
    validatorFrom.initValidatorFrom(skuForm);
    var inquiryForm = {
        ele: "#inquiryForm",
        submitType: "auto",
        rules: {
            unitPrice: {
                required: true,
                range: [0.01, 9999999999]
            },
            shopsId:{
                required:true
            },
            sku:{
                required:true
            },
            memo:{
                maxlength:200
            }
        },
        messages: {
            unitPrice: {
                required: "价格不能为空",
                range: "请输入正确的价格"
            },
            shopsId:{
                required:"商铺不能为空"
            },
            sku:{
                required:"请选择商品"
            },
            memo:{
                maxlength:"最多输入200字"
            }
        },
        validateDone:function(data){
            var Json=[]
            $("#skuTable").children().each(function(i,n){
                var obj = {}
                obj.skuId =  $(this).data("skuid")
                obj.inquiryProductId = $(this).data("productid")
                obj.purchareNum = $(this).data("purcharenum")
                obj.unitPrice = $(this).find("input[name=unitPrice]").val()
                obj.inquiryFeedbackProductId = $(this).data("productfeedbackid")
                Json.push(obj)
            })
            $("#skuJson").val(JSON.stringify(Json))
            console.log($("#skuJson").val())
            $.ajax({
                url:window.ctx+"/inquiry/feedBackSave",
                dataType:"json",
                type:"post",
                async : false,
                data:$("#inquiryForm").serialize(),
                success:function(data){
                    alert(data.msg)
                    location.href=window.ctx+"/inquiry/detail?inquiryId=" + $("#inquiryId").val() + "&inquiryFeedbackId=" + $("#inquiryFeedbackId").val() + "&inquiryType=" + $("#inquiryType").val()
                }
            })
        }
    }
    validatorFrom.initValidatorFrom(inquiryForm);
})

function findSku(data,productId){
    $("#skuTr").val(data);
    $.ajax({
        url:window.ctx+"/inquiry/skuList",
        type:"post",
        dataType:"json",
        async : false,
        data:{
            shopsId:$("#shopsId").val(),
            costType:$("#costType").val(),
            productId:productId
        },
        success:function(data){
            $("#skuList").empty()
            data.forEach(function(d){
                var div = $("<div class='col-xs-6 border-transparent'></div>")
                    .attr("data-skuId", d.skuId)
                div.append($("<div class='col-xs-4 select-box'><img src='"+d.logoUrl+"' class='img-responsive'>"+
                        "<input type='radio' name='skuId' value="+ d.skuId+"></div><div class='col-xs-8'>"+ d.skuNameCn+
                        "<br/>"+ d.catalog3NameCn +">"+ d.productNameCn+"</div>")
                    )
                    .appendTo($("#skuList"));
            })
        }
    })

}

function changePrice(data){
    var money = ($(data).val()*$(data).parent().parent().data("purcharenum"))
    $(data).parent().next().text(formatNumber(money,2,1))
    $(data).parent().next().data("money",money)
    var countMoney=0
    $("#skuTable").children().each(function(i,n){
        countMoney += ($(n).children().eq(6).data("money")*1)
    })
    $("#countMoney").text("合计："+$("#countMoney").data("costtype")+formatNumber(countMoney,2,1))
}



