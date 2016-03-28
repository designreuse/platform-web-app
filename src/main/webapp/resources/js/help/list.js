$(function(){

    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
        }
    });


    //设置表格初始化配置属性
    var easyUiTableParam = {
        url: window.ctx+'/help/helpList',
        columns: [{
            field:"id",
            title:'编号',
            align:'center',
            width:"80px"
        },
            {
                field:'problem',
                title:'问题',
                align:'center',
                width:"130px",
                formatter:function(value,row,index){
                    return '<a href="'+window.ctx+'/help/'+row.id+'/edit" nowrap="false">'+row.problem;
                }
            },
            {
                field:'name',
                title:'问题类型',
                align:'center',
                width:"100px"
            },
            {
                field:'appName',
                title:'平台',
                align:'center',
                width:"100px"
            },
            {
                field:'modifyTime',
                title:'修改时间',
                align:'center',
                width:"90px",
                formatter:function(value,row,index){
                    return new Date(row.modifyTime).Format("yyyy-MM-dd hh:mm");
                }
            },
            {
                field:'disabled',
                title:'状态',
                align:'center',
                width:"90px",
                formatter:function(value,rec){
                    var btn;
                    if(rec.disabled){
                        btn =  '停用';
                    }else{
                        btn =  '可用';
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
                    problem:$("#problem").val(),
                    appId:$("#appId").val(),
                    helpTypeId:$("#helpTypeId").val(),
                    disabled:$("#disabled").val()
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
        problem:$("#problem").val(),
        appId:$("#appId").val(),
        helpTypeId:$("#helpTypeId").val(),
        disabled:$("#disabled").val()
    });
})

$("#add").click(function(){
    window.location.href=window.ctx+"/help/add"
})


$("#reset").click(function(){
    window.location.href=window.ctx + "/help/list";
})