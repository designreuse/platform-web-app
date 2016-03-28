/**
 * Created by Administrator on 2016/2/19.
 */
/*定义easyUITable的相关参数*/
$(function(){
    var easyUiTableParam = {
        url: window.ctx+'/friendShip/friendShipList',
    onSelectPage:function(pageNumber,pageSize){
        var disabled=$("#disabled").find("option:selected").val();
        $('#easyUi_table').datagrid('reload',{
            pageNumber:pageNumber,
            pageSize:pageSize,
            disabled:disabled,
            appId:$("#appId").val()
        })
    },
        columns:[
            {
                field:'sort',
                title:'链接顺序',
                align:'center',
                width:'100px'
            },
            {
                field:'url',
                title:'链接地址',
                align:'center',
                width:'100px',
                formatter:function(value,row,index){
                    return '<a href="'+window.ctx+'/friendShip/'+row.id+'/edit" nowrap="false">'+value;
                }
            },
            {
                field:'disabled',
                title:'状态',
                align:'center',
                width:'60px',
                formatter: function(value,row,index){
                    if(1==value){
                        return '停用';
                    }else if(0==value){
                        return '可用';
                    }
                }
            },
            {
                field:'createTime',
                title:'创建时间',
                align:'center',
                width:'90px',
                formatter: function(value,row,index){
                    return new Date(value).Format("yyyy-MM-dd hh:mm");
                }
            }
        ]

    }

    $(window).resize(function(){
        easyUiTable.initTable(easyUiTableParam);
    });

    /*easyUI初始化表*/
    easyUiTable.initTable(easyUiTableParam);
})


$("#search").on("click",function(){
    $('#easyUi_table').datagrid('load',{
        disabled:$("#disabled").val(),
        appId:$("#appId").val()
    });
})

$("#reset").on("click",function(){
    $("#friendShipForm")[0].reset()
    $('#easyUi_table').datagrid('load',{});
})

$(document).keypress(function(e) {
    // 回车键事件
    if(e.which == 13) {
        jQuery("#search").click();
    }
});