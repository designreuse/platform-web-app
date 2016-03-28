$(function () {

    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
        }
    });

    //设置表格初始化配置属性
    var easyUiTableParam = {
        url: window.ctx+'/logisticsAndStorage/ratesCnList',
        columns: [{
            field:"id",
            title:'运价编号',
            align:'center',
            width:"80px"
        },
            {
                field:'logisticsNameCn',
                title:'路线',
                align:'center',
                width:"130px"
            },
            {
                field:'logisticsLength',
                title:'车程',
                align:'center',
                width:"80px"
            },
            {
                field:'fee',
                title:'运价',
                align:'center',
                width:"100px"
            },
            {
                field:'constName',
                title:'车型',
                align:'center',
                width:"50px"
            },
            {
                field:'carCapacity',
                title:'载重量',
                align:'center',
                width:"50px"
            },
            {
                field:'carSpec',
                title:'规格',
                align:'center',
                width:"90px"
            },
            {
                field:'disabled',
                title:'状态',
                align:'center',
                width:"50px",
                formatter:function(value,rec){
                    var btn;
                    if(rec.disabled){
                        btn =  '停用';
                    }else{
                        btn =  '可用';
                    }
                    return btn;
                }
            },
            {
                field:'d',
                title:'操作',
                align:'center',
                width:"90px",
                formatter:function(value,rec){
                    var btn;
                    if(rec.disabled){
                        btn = '<button id="able'+rec.id+'"   class="btn btn-success  btn-sm wid-200" onclick="changeRow(\''+rec.id+'\',this)">启用</button>' + '<a style="display: none;" href="#" data-toggle="modal" data-target="#editRates" class="btn btn-primary btn-sm wid-200" id="add'+rec.id+'" onclick="editRow(\''+rec.id+'\')">编辑</a>';
                    }else{
                        btn = '<a href="#" id="add'+rec.id+'" data-toggle="modal" data-target="#editRates" class="btn btn-primary btn-sm wid-200"  onclick="editRow(\''+rec.id+'\')">编辑</a>' + '<button id="able'+rec.id+'" style="display: none;"  class="btn btn-success  btn-sm wid-200" onclick="changeRow(\''+rec.id+'\',this)">启用</button>';
                    }
                    return btn;
                }
            }
        ],
        onSelectPage:function(pageNumber,pageSize){
            $('#easyUi_table').datagrid("reload",
                {
                    pageNumber:pageNumber,
                    pageSize:pageSize,
                    startAddr:$("#startAddr").val(),
                    endAddr:$('#endAddr').val(),
                    carType:$('#carType').val(),
                    disabled:$('#disabled').val()
                })
        }
    };

    //初始化加载表格
    $(window).resize(function(){
        easyUiTable.initTable(easyUiTableParam);
    });

    easyUiTable.initTable(easyUiTableParam);

});

$("#search").on("click",function(){
    $('#easyUi_table').datagrid('load',{
        startAddr:$("#startAddr").val(),
        endAddr:$('#endAddr').val(),
        carType:$('#carType').val(),
        disabled:$('#disabled').val()
    });
})

/* $("#add").click(function(){
 window.location.href=window.ctx+"/transport/ratesCn/add"
 })*/

$("#reset").click(function(){
    window.location.href=window.ctx + "/logisticsAndStorage/ratesCn/list";
})



$(function(){
    //参数校验
    var option1 = {
        ele: "#form1",
        submitType: "auto",
        rules: {
            startAddr: {
                required: true
            },
            endAddr: {
                required: true
            },
            logisticsLength:{
                required:true
            },
            carType:{
                required:true
            },
            fee:{
                required:true
            },
            carCapacity:{
                required:true
            },
            carSpec:{
                required:true
            }
        },
        messages:{
            startAddr: {
                required: "起始地不能为空"
            },
            endAddr: {
                required: "目的地不能为空"
            },
            logisticsLength:{
                required:"车程不能为空"
            },
            carType:{
                required:"车型不能为空"
            },
            fee:{
                required:"运价不能为空"
            },
            carCapacity:{
                required:"载重量不能为空"
            },
            carSpec:{
                required:"规格不能为空"
            }
        },
        validateDone:function(form){
            //alert(111)
            //console.log($(form).serialize())
            $("#save").attr("disabled","disabled")
            $.ajax({
                url:window.ctx + "/logisticsAndStorage/ratesCnSave",
                data:$(form).serialize(),
                type:"post",
                async:false,
                success:function(data){
                    if(data.isSuccess){
                        util.alertOk("保存成功")
                        window.location.href = window.ctx + "/logisticsAndStorage/ratesCn/list";
                    }
                },
                dataType:"json"
            })
        }
    }
    var option2 = {
        ele: "#form2",
        submitType: "auto",
        rules: {
            carType: {
                required: true
            },
            fee: {
                required: true
            },
            carCapacity:{
                required:true
            },
            carSpec:{
                required:true
            }
        },
        messages:{
            carType:{
                required:"车型不能为空"
            },
            fee:{
                required:"运价不能为空"
            },
            carCapacity:{
                required:"载重量不能为空"
            },
            carSpec:{
                required:"规格不能为空"
            }
        },
        validateDone:function(form){
            $.ajax({
                url:window.ctx + "/logisticsAndStorage/ratesEdit",
                data:$(form).serialize(),
                type:"post",
                success:function(data){
                    if(data.isSuccess){
                        util.alertOk("修改成功")
                        window.location.href = window.ctx + "/logisticsAndStorage/ratesCn/list";
                    }
                },
                dataType:"json"
            })
        }
    }
    validatorFrom.initValidatorFrom(option1);
    validatorFrom.initValidatorFrom(option2);
})

function editRow(id){
    $.ajax({
        type: "POST",
        url: window.ctx+"/logisticsAndStorage/ajaxFindLogisticsAutoById",
        data: {"id":id},
        success: function(data){
            $("#id").val(data.resultData.id);
            $("#logisticsNameCn").val(data.resultData.logisticsNameCn);
            $("#fee").val(data.resultData.fee);
            $("#carCapacity").val(data.resultData.carCapacity);
            $("#carSpec").val(data.resultData.carSpec);
            $("#editCarType option").each(function(){
                if($(this).val() == data.resultData.carType){
                    $(this).attr("selected","selected");
                }
            })
        },
        dataType:"json"
    });
}

$("#startAddrCode").on("change",function(){
    var id = $("#startAddrCode").val();
    $.ajax({
        type: "POST",
        url: window.ctx+"/logisticsAndStorage/ajaxFindServiceDistrictById",
        data: {"id":id},
        success: function(data){
            $("#startAddrRu").val(data.resultData.districtNameRu);
            $("#startAddrCn").val(data.resultData.districtNameCn);
            $("#startCountry").val(data.resultData.countryId);
        },
        dataType:"json"
    });
})

$("#endAddrCode").on("change",function(){
    var startAddrCode = $("#startAddrCode").val();
    var endAddrCode = $("#endAddrCode").val();
    $.ajax({
        type: "POST",
        url: window.ctx+"/logisticsAndStorage/ajaxFindServiceDistrictById",
        data: {"id":endAddrCode},
        success: function(data){
            $("#endAddrRu").val(data.resultData.districtNameRu);
            $("#endAddrCn").val(data.resultData.districtNameCn);
            $("#endCountry").val(data.resultData.countryId);
        },
        dataType:"json"
    });
    $.ajax({
        type: "POST",
        url: window.ctx+"/logisticsAndStorage/ajaxFindTransportByAddr",
        data: {"startAddr":startAddrCode,"endAddr":endAddrCode},
        success: function(data){
            if(data.resultData.logisticsId == null){
                $("#logisticsLengthDiv").removeAttr("style")
                $("#logisticsId").val("");
                $("#logisticsLength").val("");
            }else{
                $("#logisticsLengthDiv").attr("style","display: none;")
                //alert(data.logisticsLength)
                $("#logisticsLength").val(data.resultData.logisticsLength);
                $("#logisticsId").val(data.resultData.logisticsId);
            }
        },
        dataType:"json"
    });
})


function changeRow(id,obj){
    if(confirm("确定要这么做吗？")){
        $.ajax({
            url:window.ctx + "/logisticsAndStorage/ajaxChangeTransportPriceDisabled",
            data:{"id":id,"disabled":"false"},
            dataType:"json",
            success:function(data){
                if(data.isSuccess){
                    $('#easyUi_table').datagrid()
                }
            }
        })
    }
}

$("#changeDisabled").on("click", function () {
    if(confirm("确定要这么做吗？")) {
        var id = $("#id").val();
        $.ajax({
            url: window.ctx + "/logisticsAndStorage/ajaxChangeTransportPriceDisabled",
            data: {"id": id, "disabled": "true"},
            dataType: "json",
            success: function (data) {
                if (data.isSuccess) {
                    $('#easyUi_table').datagrid()
                }
            }
        })
    }
})
