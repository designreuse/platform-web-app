

$(document).keypress(function(e) {
    // 回车键事件
    if(e.which == 13) {
        jQuery("#search").click();
    }
});

$(function () {

    //设置表格初始化配置属性
    var easyUiTableParam = {
        url: window.ctx+'/activity/activityList',
        columns: [{
            field:"id",
            title:'编号',
            align:'center',
            width:"50px"
        },
            {
                field:'activityName',
                title:'活动标题',
                align:'center',
                width:"100px",
                formatter:function(value,row,index){
                    return '<a href="'+window.ctx+'/activity/'+row.id+'/edit" nowrap="false">'+row.activityName;
                }
            },
            {
                field:'activityAddress',
                title:'地址',
                align:'center',
                width:"80px"
            },
            {
                field:'startDate',
                title:'时间',
                align:'center',
                width:"130px",
                formatter:function(value,row,index){
                    return new Date(row.startDate).Format("yyyy年MM月dd日") + "--<br/>" + new Date(row.endDate).Format("yyyy年MM月dd日");
                }
            },
            {
                field:'activityJoinNo',
                title:'报名人数',
                align:'center',
                width:"30px"
            },
            {
                field:'appName',
                title:'平台',
                align:'center',
                width:"80px"
            },
            {
                field:'createdByNameCn',
                title:'发布人',
                align:'center',
                width:"50px"
            },
            {
                field:'createdDate',
                title:'发布日期',
                align:'center',
                width:"120px",
                formatter:function(value,row,index){
                    return new Date(row.createdDate).Format("yyyy-MM-dd hh:mm");
                }
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
            }
        ],
        onSelectPage:function(pageNumber,pageSize){
            $('#easyUi_table').datagrid("reload",
                {
                    pageNumber:pageNumber,
                    pageSize:pageSize,
                    activityName:$("#activityName").val(),
                    appId:$('#appId').val(),
                    startDate:$('#startDate').val(),
                    endDate:$('#endDate').val(),
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
        activityName:$("#activityName").val(),
        appId:$('#appId').val(),
        startDate:$('#startDate').val(),
        endDate:$('#endDate').val(),
        disabled:$('#disabled').val()
    });
})

$("#add").click(function(){
    window.location.href=window.ctx+"/activity/add"
})

$("#reset").click(function(){
    window.location.href=window.ctx + "/activity/list";
})