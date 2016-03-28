$(function () {

    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
        }
    });

    $("#appId").change(function(){
        var appId=$("#appId").val();
        if(appId.length == 0){
            return;
        }
        if(appId == 5){
            $("#divEditNameRu").removeAttr("style");
        }else{
            $("#divEditNameRu").attr("style","display:none");
        }
    });

    $("#appAddId").change(function(){
        var appId=$("#appAddId").val();
        if(appId.length == 0){
            return;
        }
        if(appId == 5){
            $("#divAddNameRu").removeAttr("style");
        }else{
            $("#divAddNameRu").attr("style","display:none");
        }
    });



    //设置表格初始化配置属性
    var easyUiTableParam = {
        url: window.ctx+'/helpType/helpTypeList',
        columns: [{
            field:"id",
            title:'问题类型编号',
            align:'center',
            width:"80px"
        },
            {
                field:'name',
                title:'类型名称',
                align:'center',
                width:"130px"
            },
            {
                field:'appName',
                title:'平台',
                align:'center',
                width:"80px"
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
                        btn = '<button id="able'+rec.id+'"   class="btn btn-success  btn-sm wid-200" onclick="changeRow(\''+rec.id+'\',this)">启用</button>' + '<a style="display: none;" href="#" data-toggle="modal" data-target="#editHelpType" class="btn btn-primary btn-sm wid-200" id="add'+rec.id+'" onclick="editRow(\''+rec.id+'\')">编辑</a>';
                    }else{
                        btn = '<a href="#" id="add'+rec.id+'" data-toggle="modal" data-target="#editHelpType" class="btn btn-primary btn-sm wid-200"  onclick="editRow(\''+rec.id+'\')">编辑</a>' + '<button id="able'+rec.id+'" style="display: none;"  class="btn btn-success  btn-sm wid-200" onclick="changeRow(\''+rec.id+'\',this)">启用</button>';
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
                    name:$("#selectName").val(),
                    appId:$('#selectAppId').val(),
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
        name:$("#selectName").val(),
        appId:$('#selectAppId').val(),
        disabled:$('#disabled').val()
    });
})


$("#reset").click(function(){
    window.location.href=window.ctx + "/helpType/list";
})



$(function(){
    //参数校验
    var option1 = {
        ele: "#form1",
        submitType: "auto",
        rules: {
            name: {
                required: true
            },
            nameTranslation: {
                required: function(e){
                    if($("#appAddId").val() == 5){
                        return true
                    }else{
                        return false
                    }
                }
            }
        },
        messages:{
            name: {
                required: "类型名称不能为空"
            },
            nameTranslation: {
                required: "类型名称（俄文）不能为空"
            }
        },
        validateDone:function(form){
            //alert(111)
            //console.log($(form).serialize())
            $("#save").attr("disabled","disabled")
            $.ajax({
                url:window.ctx + "/helpType/save",
                data:$(form).serialize(),
                type:"post",
                async:false,
                success:function(data){
                    if(data.isSuccess){
                        util.alertOk("保存成功")
                        window.location.href = window.ctx + "/helpType/list";
                    }
                },
                dataType:"json"
            })
        }
    }

    validatorFrom.initValidatorFrom(option1);


    var option2 = {
        ele: "#form2",
        submitType: "auto",
        rules: {
            name: {
                required: true
            },
            nameTranslation: {
                required: function(e){
                    if($("#appId").val() == 5){
                        return true
                    }else{
                        return false
                    }
                }
            }
        },
        messages:{
            name: {
                required: "类型名称不能为空"
            },
            nameTranslation: {
                required: "类型名称（俄文）不能为空"
            }
        },
        validateDone:function(form){
            //alert(111)
            //console.log($(form).serialize())
            $("#save").attr("disabled","disabled")
            $.ajax({
                url:window.ctx + "/helpType/save",
                data:$(form).serialize(),
                type:"post",
                async:false,
                success:function(data){
                    if(data.isSuccess){
                        util.alertOk("保存成功")
                        window.location.href = window.ctx + "/helpType/list";
                    }
                },
                dataType:"json"
            })
        }
    }

    validatorFrom.initValidatorFrom(option2);
})

function editRow(id){
    $.ajax({
        type: "POST",
        url: window.ctx+"/helpType/edit",
        data: {"id":id},
        success: function(data){
            $("#id").val(data.resultData.id);
            $("#name").val(data.resultData.name);
            $("#nameTranslation").val(data.resultData.nameTranslation);
            $("#appId option").each(function(){
                if($(this).val() == data.resultData.appId){
                    $(this).attr("selected","selected");
                }
            })
            if(data.resultData.appId == 5){
                $("#divEditNameRu").removeAttr("style");
            }else{
                $("#divEditNameRu").attr("style","display:none");
            }

        },
        dataType:"json"
    });
}


function changeRow(id,obj){
    if(confirm("确定要这么做吗？")){
        $.ajax({
            url:window.ctx + "/helpType/ajaxChangeDisabled",
            data:{"id":id,"disabled":"0"},
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
            url: window.ctx + "/helpType/ajaxChangeDisabled",
            data: {"id": id, "disabled": "1"},
            dataType: "json",
            success: function (data) {
                if (data.isSuccess) {
                    $('#easyUi_table').datagrid()
                }
            }
        })
    }
})
