$(function () {

    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
        }
    });

    //设置表格初始化配置属性
    var easyUiTableParam = {
        url: window.ctx+'/catalog/catalogList',
        columns: [{
            field:"catalogId",
            title:'品类编号',
            align:'center',
            width:"80px"
        },
            {
                field:'catalogNameCn',
                title:'品类名称',
                align:'center',
                width:"130px",
                formatter:function(value,row,index){
                    return '<a href="'+window.ctx+'/catalog/'+row.catalogId+'/'+row.level+'/edit" nowrap="false">'+value;
                }
            },
            {
                field:'levelName',
                title:'品类级别',
                align:'center',
                width:"100px"
            },
            {
                field:'parentCatalogNameCn',
                title:'上级品类',
                align:'center',
                width:"100px"
            },
            {
                field:'hscode',
                title:'HS CODE',
                align:'center',
                width:"100px"
            },
            {
                field:'indexSort',
                title:'首页排序',
                align:'center',
                width:"100px"
            },
            {
                field:'disabled',
                title:'状态',
                align:'center',
                width:"80px",
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
                field:'createTime',
                title:'创建时间',
                align:'center',
                width:"90px",
                formatter:function(value,row,index){
                    return new Date(row.createTime).Format("yyyy-MM-dd hh:mm");
                }
            }
        ],
        onSelectPage:function(pageNumber,pageSize){
            $('#easyUi_table').datagrid("reload",
                {
                    pageNumber:pageNumber,
                    pageSize:pageSize,
                    catalogNameCn:$("#catalogNameCn").val(),
                    hscode:$('#hscode').val(),
                    disabled:$('#disabled').val(),
                    level:$("#level").val(),
                    parentName:$("#parentId").val()
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
        catalogNameCn:$("#catalogNameCn").val(),
        hscode:$('#hscode').val(),
        disabled:$('#disabled').val(),
        level:$("#level").val(),
        parentName:$("#parentId").val()
    });
})

$("#add").click(function(){
    window.location.href=window.ctx+"/catalog/add"
})

$("#reset").click(function(){
    window.location.href=window.ctx + "/catalog/list";
})