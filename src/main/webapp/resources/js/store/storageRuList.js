$(function () {

    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
            return false;
        }
    });

    //设置表格初始化配置属性
    var easyUiTableParam = {
        url: window.ctx+'/logisticsAndStorage/storageRuList',
        columns: [{
            field:"id",
            title:'编号',
            align:'center',
            width:"50px"
        },
            {
                field:'districtNameCn',
                title:'城市',
                align:'center',
                width:"80px"
            },
            {
                field:'storageNameCn',
                title:'仓库',
                align:'center',
                width:"80px"
            },
            {
                field:'storageTypeName',
                title:'仓库类型',
                align:'center',
                width:"100px"
            },
            {
                field:'addressCn',
                title:'地址',
                align:'center',
                width:"150px"
            },
            {
                field:'fee',
                title:'单价',
                align:'center',
                width:"50px"
            },
            {
                field:'unitName',
                title:'单位',
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
                        btn = '<button id="able'+rec.id+'"   class="btn btn-success  btn-sm wid-200" onclick="changeRow(\''+rec.id+'\',this)">启用</button>' + '<a style="display: none;" href="#" data-toggle="modal" data-target="#editStorage" class="btn btn-primary btn-sm wid-200" id="add'+rec.id+'" onclick="editRow(\''+rec.id+'\')">编辑</a>';
                    }else{
                        btn = '<a href="#" id="add'+rec.id+'" data-toggle="modal" data-target="#editStorage" class="btn btn-primary btn-sm wid-200"  onclick="editRow(\''+rec.id+'\')">编辑</a>' + '<button id="able'+rec.id+'" style="display: none;"  class="btn btn-success  btn-sm wid-200" onclick="changeRow(\''+rec.id+'\',this)">启用</button>';
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
                    district:$("#district").val(),
                    storageNameCn:$('#storageNameCn').val(),
                    storageType:$('#storageType').val(),
                    disabled:$('#disabled').val()
                })
        }
    };

    //初始化加载表格
    easyUiTable.initTable(easyUiTableParam);
    $(window).resize(function(){
        easyUiTable.initTable(easyUiTableParam);
    });
});

$("#search").on("click",function(){
    $('#easyUi_table').datagrid('load',{
        district:$("#district").val(),
        storageNameCn:$('#storageNameCn').val(),
        storageType:$('#storageType').val(),
        disabled:$('#disabled').val()
    });
})

/* $("#add").click(function(){
 window.location.href=window.ctx+"/transport/ratesCn/add"
 })*/

$("#reset").click(function(){
    window.location.href=window.ctx + "/logisticsAndStorage/storageRu/list";
})



$(function(){
    //参数校验
    var option1 = {
        ele: "#form1",
        submitType: "auto",
        rules: {
            districtId: {
                required: true
            },
            storageNameCn: {
                required: true
            },
            storageName:{
                required:true
            },
            addressCn:{
                required:true
            },
            address:{
                required:true
            },
            storageType:{
                required:true
            },
            fee:{
                required:true
            },
            unit:{
                required:true
            }
        },
        messages:{
            districtId: {
                required: "城市不能为空"
            },
            storageNameCn: {
                required: "仓库名称不能为空"
            },
            storageName:{
                required:"仓库名称(俄文)不能为空"
            },
            addressCn:{
                required:"仓库地址不能为空"
            },
            address:{
                required:"仓库地址(俄文)不能为空"
            },
            storageType:{
                required:"类型不能为空"
            },
            fee:{
                required:"单价不能为空"
            },
            unit:{
                required:"单位不能为空"
            }
        },
        validateDone:function(form){
            $("#saveStore").attr("disabled","disabled")
            $.ajax({
                url:window.ctx+"/logisticsAndStorage/storageRuSave",
                type:"post",
                dataType:"json",
                data:$("#form1").serialize(),
                success:function(data){
                    location.href = window.ctx+"/logisticsAndStorage/storageRu/list"
                }
            })
        }
    }
    var option2 = {
        ele: "#form2",
        submitType: "submit",
        rules: {
            districtId: {
                required: true
            },
            storageNameCn: {
                required: true
            },
            storageName:{
                required:true
            },
            addressCn:{
                required:true
            },
            address:{
                required:true
            },
            storageType:{
                required:true
            },
            fee:{
                required:true
            },
            unit:{
                required:true
            }
        },
        messages:{
            districtId: {
                required: "城市不能为空"
            },
            storageNameCn: {
                required: "仓库名称不能为空"
            },
            storageName:{
                required:"仓库名称(俄文)不能为空"
            },
            addressCn:{
                required:"仓库地址不能为空"
            },
            address:{
                required:"仓库地址(俄文)不能为空"
            },
            storageType:{
                required:"类型不能为空"
            },
            fee:{
                required:"单价不能为空"
            },
            unit:{
                required:"单位不能为空"
            }
        }
    }
    validatorFrom.initValidatorFrom(option1);
    validatorFrom.initValidatorFrom(option2);
})

function editRow(id){
    $.ajax({
        type: "POST",
        url: window.ctx+"/logisticsAndStorage/ajaxFindStorageById",
        data: {"id":id},
        success: function(data){
            $("#id").val(data.resultData.id);
            $("#districtId option").each(function(){
                if($(this).val() == data.resultData.districtId){
                    $(this).attr("selected","selected");
                }
            });
            $("#storageCn").val(data.resultData.storageNameCn);
            $("#storageRu").val(data.resultData.storageName);
            $("#addressCn").val(data.resultData.addressCn);
            $("#address").val(data.resultData.address);
            $("#fee").val(data.resultData.fee);
            $("#type option").each(function(){
                if($(this).val() == data.resultData.storageType){
                    $(this).attr("selected","selected");
                }
            })
            $("#unit option").each(function(){
                if($(this).val() == data.resultData.unit){
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
            url: window.ctx+"/logisticsAndStorage/ajaxFindStorageDistrictById",
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
        url: window.ctx+"/logisticsAndStorage/ajaxFindStorageDistrictById",
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
    if(confirm("确定要这么做吗？")) {

        $.ajax({
            url: window.ctx + "/logisticsAndStorage/ajaxChangeStorageDisabled",
            data: {"id": id, "disabled": "false"},
            dataType: "json",
            success: function (data) {
                if (data.isSuccess) {
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
            url: window.ctx + "/logisticsAndStorage/ajaxChangeStorageDisabled",
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
