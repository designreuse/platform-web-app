$(function () {

    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
        }
    });

    //设置表格初始化配置属性
    var easyUiTableParam = {
        url: window.ctx+'/product/productList',
        columns: [{
            field:"productId",
            title:'商品编号',
            align:'center',
            width:"80px"
        },
            {
                field:'productNameCn',
                title:'商品名称',
                align:'center',
                width:"130px",
                formatter:function(value,row,index){
                    return '<a href="'+window.ctx+'/product/'+row.productId+'/edit" nowrap="false">'+value;
                }
            },
            {
                field:'catalogNameFirstCn',
                title:'一级品类',
                align:'center',
                width:"80px"
            },
            {
                field:'catalogNameSecondCn',
                title:'二级品类',
                align:'center',
                width:"80px"
            },
            {
                field:'catalogNameCn',
                title:'三级品类',
                align:'center',
                width:"80px"
            },
            {
                field:'hscode',
                title:'HS CODE',
                align:'center',
                width:"100px"
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
                    productNameCn:$("#productNameCn").val(),
                    catalogName:$("#catalogName").val(),
                    hscode:$('#hscode').val(),
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
    //alert(1)
    $('#easyUi_table').datagrid('load',{
        productNameCn:$("#productNameCn").val(),
        catalogName:$("#catalogName").val(),
        hscode:$('#hscode').val(),
        disabled:$('#disabled').val()
    });
})

$("#add").click(function(){
    window.location.href=window.ctx+"/product/add"
})

$("#reset").click(function(){
    window.location.href=window.ctx + "/product/list";
})