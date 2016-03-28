var serviceName;
var rowSelected;

function over(e){
    rowSelected = e;
}
var btsloader = function (param, success, error) {
    var q = param.q || "";
    if (q.length == 0) {
        return false;
    }
    $.ajax({
            url: window.ctx+"/bill/getFeeName",
            type: "post",
            data: {param: q},
            dataType: "json",
            success: function (data) {
                var items = $.each(data, function (value) {
                    serviceName=data.label;
                    console.log(data[value])
                    return value;
                });
                console.log(items)
                success(items);
            }
        }
    );
}

var dealingsOrgNameLoader = function (param, success, error) {
    var q = param.q || "";
    if (q.length == 0) {
        return false;
    }
    $.ajax({
            url: window.ctx+"bill/getOrgName",
            type: "post",
            data: {param: q},
            dataType: "json",
            success: function (data) {
                var items = $.each(data, function (value) {
                    serviceName=data.label;
                    console.log(data[value])
                    return value;
                });
                success(items);
            }
        }
    );
}

function delCount(){
    if ($(".add-count").length<5){
        $("#tip").hide();
        $("#addCount").show();
        if ($(".add-count").length==0){
            $("#newCount").hide();
            $("#saveCount").hide();
        }
    }

}

// 报价方式
function quoteType(priceType){
    var quoteTypeStr = "";
    var url = window.ctx+"/bill/getCurrencyType";
    $.ajax({url:url,
        type:"post",
        async:false,
        success:function(data){
            data= $.parseJSON(data);
            for (var i = 0; i <data.resultData.length; i++){
                if (priceType == data.resultData[i].constValue){
                    quoteTypeStr += '<option value='+data.resultData[i].id+' selected>'+data.resultData[i].constName+'</option>';
                }else{
                    quoteTypeStr += '<option value='+data.resultData[i].id+'>'+data.resultData[i].constName+'</option>';
                }
            }
        }
    });
    return quoteTypeStr;
}

$("#addCount").click(function(){
    var len = $(".add-count").length;
    if(len==0){
        $("#newCount").show();
        $("#saveCount").show();
    }
    var quoteTypeStr = quoteType();
    if (len<5){
        $("#newCount").append(
                '<div class="formtable-query add-count">' +
                '<div class="form-inline mar_t20">' +
                '<div class="form-group hide-input">' +
                '<input type="text" id=\"feeNameEdit'+len+'\"     placeholder="请输入费用名称关键字" style="width:170px;height:34px" class="input-text form-control">'+
                '<input type="text"  id=\"feeNameIdSaved'+len+'\" name="feeNameEdit"   class="hide"><label id=\"serviceNameShow'+len+'\"></label>'+
                '</div>' +
                '<div class="form-group hide-input">' +
                '<input type="text" id=\"dealingsOrgEdit'+len+'\"    placeholder="请输入往来公司关键字" style="width:170px;height:34px" class="input-text form-control">'+
                '<input type="text" id=\"dealingsOrgIdSaved'+len+'\" name="dealingsOrgEdit"   class="hide">'+
                '</div>' +
                '<div class="form-group">' +
                '<select id=\"statusSaved'+len+'\" class="form-control">' +
                '<option value="2">付款</option><option value="0">收款</option>' +
                '</select>' +
                '</div>' +
                '<div class="form-group">' +
                '<select id=\"costTypeSaved'+len+'\" class="form-control">' +
                quoteTypeStr +
//                        '<option>人民币</option><option>美金</option><option>卢布</option>' +
                '</select>' +
                '</div>' +
                '<div class="form-group">' +
                '<input id=\"costSaved'+len+'\" name="costSaved" type="text" class="form-control" placeholder="请输入金额">' +
                '<input id=\"rateSaved'+len+'\" name="rateSaved" type="text" style="width:80px" class="form-control" placeholder="汇率"/>' +
                '</div>' +
                '<button type="button" class="close mar_t5" onclick="javascript: $(this).parent().parent().remove();delCount();">' +
                '<span aria-hidden="true">&times;</span></button>' +
                '</div>' +
                '</div>'
        );
        $("#rateSaved"+len).hide();
        $("#newCount").removeClass("hidden");
        $("#saveCount").removeClass("hidden");

    }else{
        $("#tip").append('为快速保证您的数据，一次最多可保存5条!');
        $("#addCount").hide();
    }

    $("#feeNameEdit"+len).on("blur",function(){
        if($(this).val()==""){
            $(this).next().val("");
            $(this).next().next().val("");
        }
    })

    $("#feeNameEdit"+len).autocomplete({
            source:window.ctx+"/bill/getFeeName",
            minLength: 0,
            autoFocus:true,
            select:function(e, ui) {
                $( "#feeNameIdSaved"+len).val(ui.item.id);
                $("#serviceNameShow"+len).html(ui.item.anotherValue);
            },
            response: function( event, ui ) {
                $( "#feeNameIdSaved"+len).val("");
            }
        }
    );

    $("#dealingsOrgEdit"+len).on("blur",function(){
        if($(this).val()==""){
            $(this).next().val("");
        }
    })

    $("#dealingsOrgEdit"+len).autocomplete({
            source:window.ctx+"/bill/getOrgName",
            minLength: 0,
            autoFocus:true,
            select:function(e, ui) {
                $( "#dealingsOrgIdSaved"+len).val(ui.item.id);
            },
            response: function( event, ui ) {
                $( "#dealingsOrgIdSaved"+len).val("");
            }
        }
    );

    $("#costTypeSaved"+len).on("change",function(){
        var text = $("#costTypeSaved"+len+" option:selected").text();
        if(text!="元"){
            $("#rateSaved"+len).show();
            if(text=="美元"){
                $("#rateSaved"+len).val($("#usdRate").val());
            }else if(text=="卢布"){
                $("#rateSaved"+len).val($("#rubRate").val());
            }

        }else{
            $("#rateSaved"+len).val("1");
            $("#rateSaved"+len).hide();
        }
    })
    //新增
    var optionAdd = {
        ele: "#addForm",
        submitType: "auto",
        rules: {

            feeNameEdit:{
                required: true
            },
            dealingsOrgEdit:{
                required: true
            },
            costSaved: {
                required: true,
                number: true,
                min:0.000000000000000000000000000000000001
            },
            rateSaved:{
                required: true,
                number: true,
                min:0.000000000000000000000000000000000001
            }
        },
        messages:{

            feeNameEdit:{
                required: "费用名称不能为空"
            },
            dealingsOrgEdit:{
                required: "往来公司不能为空"
            },
            costSaved: {
                required:"金额不能为空",
                number: "金额必须为数字",
                min:"金额数字格式不正确"
            },
            rateSaved:{
                required:"汇率不能为空",
                number: "汇率必须为数字",
                min:"汇率数字格式不正确"
            }
        },
        validateDone: function(form){
            var countLength = $(".add-count").length;
            var i;
            var saveDataAry=[];
            var billId = $("#billId").val();

            var reg = /^\d+(?=\.{0,1}\d+$|$)/;

            if(countLength>0){
                for(i=0;i<countLength;i++){


                    var feeId = $("#feeNameIdSaved"+i).val();

                    var dealingsOrgId = $("#dealingsOrgIdSaved"+i).val();
                    var cost = $("#costSaved"+i).val();

                    var costType = $("#costTypeSaved"+i+" option:selected").val();
                    var costTypeText = $("#costTypeSaved"+i+" option:selected").text();
                    switch(costTypeText){
                        case '元':costTypeText="CNY";break;
                        case '美元':costTypeText="USD";break;
                        case '卢布':costTypeText="RUB";break;
                    }

                    var paymentStatus=$("#statusSaved"+i+" option:selected").val();


                    var rate="";
                    rate= $("#rateSaved"+i).val();

                    if(rate==""){
                        rate==1;
                    }
                    var data={
                        "billId":billId,
                        "feeId":feeId,
                        "dealingsOrgId":dealingsOrgId,
                        "cost":cost,
                        "costType":costType,
                        "rate":rate,
                        "costTypeText":costTypeText,
                        "paymentStatus":paymentStatus
                    };
                    saveDataAry.push(data);
                }
            }
            var saveDataJson=JSON.stringify(saveDataAry);
            $.ajax({
                url : window.ctx+'/bill/insertBillDetail',
                type:"post",
                data :{
                    jsonStr:saveDataJson
                },
                dataType:"json",
                success:function(data){
                    alert("新增成功");
                    window.location.href=window.ctx+'/bill/edit/'+$("#billId").val();
                },
                error:function(data){
                    alert("服务器出现错误");
                }
            })
        }
    }
    validatorFrom.initValidatorFrom(optionAdd);
});

$(function () {

    var cancelSettlementFlag=false;//取消结算的标志
    $(document).on("blur",".hide-input .form-control",function(){
        $(this).next(".hide").focus();
        $(this).next(".hide").blur();
    })
//    $(".hide-input .form-control").blur(function(){
//        $(this).next(".hide").focus();
//        $(this).next(".hide").blur();
//    });

    $(".trade_edit").on('click', function(){
        $(".trade_edit").css("z-index", "0");
        var $this = $(this);
        $this.css("z-index","999");
        var trade_html = '<li class="trade_edit--active trade_edit--count" data-toggle="modal">确认结算</li>'+
            '<li class="trade_edit--edit" data-toggle="modal">编辑</li>'+
            '<li class="trade_edit--text" data-toggle="modal">备注</li>'+
            '<li class="trade_edit--delete" data-toggle="modal">删除</li>';
        var trade_base = '<li class="trade_edit--active trade_edit--count">结算</li>';
        $this.html(trade_html);
        $this.on('mouseleave', function(){
            $this.html(trade_base);
        });
        $this.children('li').on('mouseenter', function(){
            var $this = $(this);
            $this.parent('.trade_edit').children('li').removeClass('trade_edit--active');
            $this.addClass('trade_edit--active');
        });
//            确认结算
        $this.children(".trade_edit--count").on('click', function(e){
            e.stopPropagation();
            //金额汇率
            var costTemp =rowSelected.cells[8].innerHTML;
            costTemp = costTemp.trim();

            var rateTemp =rowSelected.cells[9].innerHTML;
            rateTemp = rateTemp.trim();

            //费用名称，往来公司
            var arr2=rowSelected.cells[10].innerHTML;
            var feeNameEditStr= arr2.trim();
            var arr3=rowSelected.cells[11].innerHTML;
            var dealingsOrgEditStr = arr3.trim();


            $("#rmbConfirmed").val(costTemp);
            $("#rateConfirmed").val(rateTemp);
            $("#feeNameConfirmed").html(feeNameEditStr);
            $("#dealingsOrgConfirmed").html(dealingsOrgEditStr);

            $('#trade_edit--count').modal('show');
        });
//            编辑
        $this.children(".trade_edit--edit").on('click', function(e){
            e.stopPropagation();


            var costTemp =rowSelected.cells[8].innerHTML;
            costTemp = costTemp.trim();

            var rateTemp =rowSelected.cells[9].innerHTML;
            rateTemp = rateTemp.trim();

            $("#rmbEdit").val(costTemp);
            $("#rateEdit").val(rateTemp);

            //费用名称，往来公司
            var arr2=rowSelected.cells[10].innerHTML;
            var feeNameEditStr= arr2.trim();
            var arr3=rowSelected.cells[11].innerHTML;
            var dealingsOrgEditStr = arr3.trim();

            //费用名称，往来公司
            var arr4=rowSelected.cells[12].innerHTML;
            var feeId= arr4.trim();
            var arr5=rowSelected.cells[13].innerHTML;
            var dealingsOrgId = arr5.trim();

            $("#feeNameEdit").val(feeNameEditStr);
            if(feeNameEditStr!=""){
                $("#feeNameId").val(feeId);
            }
            $("#dealingsOrgEdit").val(dealingsOrgEditStr);
            if(dealingsOrgEditStr!=""){
                $("#dealingsOrgId").val(dealingsOrgId);
            }
            $('#trade_edit--edit').modal('show');
        });
//            备注
        $this.children(".trade_edit--text").on('click', function(e){
            e.stopPropagation();

            var remarksStr =rowSelected.cells[7].innerHTML;
            remarksStr = remarksStr.trim();
            $("#remarks").val(remarksStr);
            $('#trade_edit--text').modal('show');
        });
//            删除
        $this.children(".trade_edit--delete").on('click', function(e){
            e.stopPropagation();
            $('#trade_edit--delete').modal('show');
        });
    });

    $(".trade_edit--text_cont").on('keyup', function(){
        var len = 50 - $(this).val().length;
        console.log(len);
        $(".trade_edit--text_limit").text(len);
        if(len<0){
            $(this).parents(".form-group").addClass("has-error");
            $(".trade_edit--text_limit").css("color","red")
        }
        else{
            $(this).parents(".form-group").removeClass("has-error");
            $(".trade_edit--text_limit").css("color","black")
        }
    });

    $('[data-toggle="popover"]').popover();

//    $("#dealingsOrgEdit").on("blur",function(){
//
//    });

    $("#dealingsOrgEdit").on("blur",function(){
        if($(this).val()==""){
            $(this).next().val("");
        }
    })

    $("#dealingsOrgEdit").autocomplete({
            source:window.ctx+"/bill/getOrgName",
            minLength: 0,
            autoFocus:true,
            select:function(e, ui) {
                $( "#dealingsOrgId").val(ui.item.id);
            },
            change:function(e,ui){
                if($(this).val()==""){
                    $( "#dealingsOrgId").val("");
                }
            },
            response: function( event, ui ) {
                $( "#dealingsOrgId").val("");
            }

        }
    );

    $("#feeNameEdit").on("blur",function(){
        if($(this).val()==""){
            $(this).next().val("");
        }
    })

    $("#feeNameEdit").autocomplete({
            source:window.ctx+"/bill/getFeeName",
            minLength: 0,
            autoFocus:true,
            select:function(e, ui) {
                $( "#feeNameId").val(ui.item.id);
            },
            change:function(e,ui){
                if($(this).val()==""){
                    $( "#feeNameId").val("");
                }
            },
            response: function( event, ui ) {
                $( "#feeNameId").val("");
            }
        }
    );

    $("#delBtn").on("click",function(){
        var id =rowSelected.cells[6].innerHTML;
        id = id.trim();
        $.ajax({
            url : window.ctx+'/bill/deleteBillDetail/'+id,
            data : {

            },
            dataType:"json",
            success:function(data){
                $('#trade_edit--delete').hide();
                alert("删除成功");
                window.location.href=window.ctx+'/bill/edit/'+$("#billId").val();
            },
            error:function(data){
                alert("服务器出现错误");
            }
        })
    });



    $("#cancelModifyBtn").on("click",function(e){

        if(cancelSettlementFlag==false){
            $("#trade_edit--edit").hide();
            return;
        }
        var id =rowSelected.cells[6].innerHTML;
        id = id.trim();

        var paymentStatus;

        var status =rowSelected.cells[5].innerHTML;
        if(status.indexOf("已收")>=0){
            paymentStatus = 0
        }else if(status.indexOf("已付")>=0){
            paymentStatus = 2
        }else{
            paymentStatus = 0
        }

        $.ajax({
            url : window.ctx+'/bill/modifyBillDetail',
            data : {
                id:id,
                paymentStatus:paymentStatus
            },
            dataType:"json",
            success:function(data){
                $('#trade_edit--edit').hide();
                alert("修改成功");
                cancelSettlementFlag=false;

                window.location.href=window.ctx+'/bill/edit/'+$("#billId").val();
            },
            error:function(data){
                cancelSettlementFlag=false;
                alert("服务器出现错误");
            }
        })
    })

    $("#cancelSettlementBtn").on("click",function(){
        var costTemp =rowSelected.cells[8].innerHTML;
        costTemp = costTemp.trim();

        var rateTemp =rowSelected.cells[9].innerHTML;
        rateTemp = rateTemp.trim();

        $("#rmbEdit").val(costTemp);
        $("#rateEdit").val(rateTemp);

        //费用名称，往来公司
        var arr2=rowSelected.cells[10].innerHTML;
        var feeNameEditStr= arr2.trim();
        var arr3=rowSelected.cells[11].innerHTML;
        var dealingsOrgEditStr = arr3.trim();

        //费用名称，往来公司
        var arr4=rowSelected.cells[12].innerHTML;
        var feeId= arr4.trim();
        var arr5=rowSelected.cells[13].innerHTML;
        var dealingsOrgId = arr5.trim();

//        $("#feeNameEdit").val(feeNameEditStr);
//        $("#dealingsOrgEdit").val(dealingsOrgEditStr);

        $("#feeNameEdit").val(feeNameEditStr);
        if(feeNameEditStr!=""){
            $("#feeNameId").val(feeId);
        }
        $("#dealingsOrgEdit").val(dealingsOrgEditStr);
        if(dealingsOrgEditStr!=""){
            $("#dealingsOrgId").val(dealingsOrgId);
        }

        cancelSettlementFlag=true;
        $('#trade_edit--edit').modal('show');
    })

    $("#saveCount").on("click",function save(){

        $("#addFormSubmit").click();

    })

//确认结算按钮
    var option0 = {
        ele: "#confirmSettlementForm",
        submitType: "auto",
        rules: {
            rmbConfirmed: {
                required: true,
                number:true,
                min:0.000000000000000000000000000000000001
            },
            rateConfirmed: {
                required: true,
                number:true,
                min:0.000000000000000000000000000000000001
            }
        },
        messages:{
            rmbConfirmed: {
                required: "金额不能为空",
                number:"金额必须是数字",
                min:"金额数字格式不正确"
            },
            rateConfirmed: {
                required: "汇率不能为空",
                number:"汇率必须是数字",
                min:"汇率数字格式不正确"
            }
        },
        validateDone: function(form){
            var id =rowSelected.cells[6].innerHTML;
            id = id.trim();
            var status =rowSelected.cells[5].innerHTML;
            if(status.indexOf("未收")>=0){
                status = 1
            }else if(status.indexOf("未付")>=0){
                status = 3
            }else{
                status = 1
            }
            var cost = $("#rmbConfirmed").val();
            var rateStr = $("#rateConfirmed").val();
            $.ajax({
                url : window.ctx+'/bill/settlement',
                type:"post",
                data : {
                    cost:cost,
                    rate:$("#rateConfirmed").val(),
                    id:id,
                    paymentStatus:status
                },
                dataType:"json",
                success:function(data){
                    $("#trade_edit--edit").hide();
                    alert("结算成功");
                    window.location.href=window.ctx+'/bill/edit/'+$("#billId").val();
                },
                error:function(data){
                    alert("服务器出现错误");
                }
            })

        }
    }
//修改按钮
    var option = {
        ele: "#tradeEditForm",
        submitType: "auto",
        rules: {
            rmbEdit: {
                required: true,
                number:true,
                min:0.000000000000000000000000000000000001
            },
            rateEdit: {
                required: true,
                number:true,
                min:0.000000000000000000000000000000000001
            },
            feeNameId: {
                required: true
            },
            dealingsOrgId:{
                required: true
            }
        },
        messages:{
            rmbEdit: {
                required: "金额不能为空",
                number:"金额数字格式不正确"
            },
            rateEdit: {
                required: "汇率不能为空",
                number:"汇率数字格式不正确"
            },
            feeNameId:{
                required: "请选择正确的费用"
            },
            dealingsOrgId:{
                required: "请选择正确的往来公司"
            }
        },
        validateDone: function(form){
            var id =rowSelected.cells[6].innerHTML;
            id = id.trim();

            var paymentStatus;
            if(cancelSettlementFlag==true){
                var status =rowSelected.cells[5].innerHTML;
                if(status.indexOf("已收")>=0){
                    paymentStatus = 0
                }else if(status.indexOf("已付")>=0){
                    paymentStatus = 2
                }else{
                    paymentStatus = 0
                }
            }


            var cost = $("#rmbEdit").val();
            var rate = $("#rateEdit").val();
            var feeName = $("#feeNameEdit").val();

            var feeId;
            var feeNameIdVal = $("#feeNameId").val();
            if(feeNameIdVal!=null){
                if(feeNameIdVal=="noModifyFlag"){
                    feeNameIdVal="";
                }
                feeId = feeNameIdVal;
            }
            var dealingsOrgId;
            var dealingsOrgIdVal = $("#dealingsOrgId").val()
            if(dealingsOrgIdVal!=null){
                if(dealingsOrgIdVal=="noModifyFlag"){
                    dealingsOrgIdVal="";
                }
                dealingsOrgId = dealingsOrgIdVal;
            }
            $.ajax({
                url : window.ctx+'/bill/modifyBillDetail',
                data : {
                    id:id,
                    cost:cost,
                    rate:rate,
                    feeId:feeId,
                    dealingsOrgId:dealingsOrgId,
                    paymentStatus:paymentStatus
                },
                dataType:"json",
                success:function(data){
                    $('#trade_edit--edit').hide();
                    cancelSettlementFlag=false;
                    alert("修改成功");
                    window.location.href=window.ctx+'/bill/edit/'+$("#billId").val();
                },
                error:function(data){
                    cancelSettlementFlag=false;
                    alert("服务器出现错误");
                }
            })

        }
    }
//编辑备注
    var optionRemarks = {
        ele: "#remarksForm",
        submitType: "auto",
        rules: {
            remarks: {
                maxlength: 50
            }
        },
        messages:{
            remarks: {
                maxlength: jQuery.validator.format("亲，备注最多{0}个字符")
            }
        },
        validateDone: function(form){
            var id =rowSelected.cells[6].innerHTML;
            id = id.trim();
            var remarks=$("#remarks").val();
            $.ajax({
                url : window.ctx+'/bill/modifyRemarks',
                data : {
                    id : id,
                    remarks:remarks
                },
                dataType:"json",
                success:function(data){
                    $('#trade_edit--text').hide();
                    alert("修改成功");
                    window.location.href=window.ctx+'/bill/edit/'+$("#billId").val();
                },
                error:function(data){
                    alert("服务器出现错误");
                }
            })

        }
    }
//新增账单详情


    validatorFrom.initValidatorFrom(option0);
    validatorFrom.initValidatorFrom(option);
    validatorFrom.initValidatorFrom(optionRemarks);

})