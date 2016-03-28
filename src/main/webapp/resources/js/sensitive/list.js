/**
 * Created by Administrator on 2015/10/19.
 */
function delteRow(id){
    $.messager.confirm('提示', '确认删除吗?', function(r){
        if (r){
            window.location.href=window.ctx+'/sensitive/delete?id='+id;
        }
    });
    }

$(document).keypress(function(e) {
    // 回车键事件
    if(e.which == 13) {
        jQuery("#search").click();
        return false;
    }
});

    $("#search").click(function(){
        $('#easyUi_table').datagrid('load',{
            name:$("#name").val()
        });
    })


$(function(){

    var easyUiTableParam = {
        url: window.ctx+'/sensitive/sensitiveList',
                onSelectPage:function(pageNumber,pageSize){
                    $('#easyUi_table').datagrid("reload",
                        {
                            pageNumber:pageNumber,
                            pageSize:pageSize,
                            name:$("#name").val()
                        })

                },
        columns:[
            {field:'id',title:'ID',width:80,align:'center'},
            {
                field:"name",
                title:'敏感词名称',
                width:200,align:'center'
            },

            {field:'opt',title:'操作',width:50,align:'center',
                formatter:function(value,rec){
                    var btn = '<button  class="btn btn-primary btn-sm wid-200" onclick="delteRow(\''+rec.id+'\')">删除</button>';//<a class="editcls" onclick="delteRow(\''+rec.id+'\')" href="javascript:void(0)">删除</a>
                    return btn;// btn = btn+'       <a class="editcls" onclick="updateRow(\''+rec.id+'\',\''+rec.name+'\')" href="javascript:void(0)">修改</a>';
                }
            }
        ]

    };
    easyUiTable.initTable(easyUiTableParam);
});

$(function(){
    var option = {
        ele: "#form1",
        submitType: "submit",
        rules: {
            name: {
                required: true
            }
        },
        messages:{
            name: {
                required: "关键词不能为空"
            }
        }
    }
    validatorFrom.initValidatorFrom(option);

    $("#reset").click(function(){
        window.location.href=window.ctx + "/sensitive/list";
    })
})

$("#sensitiveName").blur(function(){
    var sensitiveName = $("#sensitiveName").val();
    if (sensitiveName.length > 0){
        $.ajax({
            type:"POST",
            url:window.ctx+"/sensitive/ajaxFindSensitiveIsExist",
            data:{"name":sensitiveName},
            success:function(data){
                if(data){
                    util.alertError("敏感词已存在")
                }
            },
            dataType:"JSON"
        })
    }
})



