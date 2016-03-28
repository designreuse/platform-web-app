/**
 * Created by Administrator on 2016/2/23.
 */
$(function(){

    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
        }
    });

    //设置表格初始化配置属性
    var easyUiTableParam = {
        url: window.ctx+'/keyword/keywordList',
        columns: [{
                field:"locationKey",
                title:'位置编号',
                align:'center',
                width:"60px",
                formatter:function(value,row,index){
                    return "<a href='"+window.ctx+"/keyword/"+row.id+"/edit'>"+value+"</a>"
                }
            },
            {
                field:'appName',
                title:'平台',
                align:'center',
                width:'100px'
            },
            {
                field:'appId',
                title:'标题',
                align:'center',
                width:"75px",
                formatter:function(value,row,index){
                    if(value == 5){
                        return row.titleRu;
                    }else{
                        return row.titleCn;
                    }
                }
            },
            {
                field:'keywordCn',
                title:'关键字',
                align:'center',
                width:'100px',
                formatter:function(value,row,index){
                    if(row.appId == 5){
                        return row.keywordRu
                    }else {
                        return value
                    }
                }
            },
            {
                field:'modifyTime',
                title:'修改时间',
                align:'center',
                width:"75px",
                formatter:function(value,row,index){
                    console.log(value)
                    return new Date(value).Format("yyyy-MM-dd hh:mm");
                }
            }
        ],
        onSelectPage:function(pageNumber,pageSize){
            $('#easyUi_table').datagrid("reload",
                {
                    title:$("#title").val(),
                    locationKey:$("#locationKey").val(),
                    keyword:$("#keyword").val(),
                    appId:$("#appId").val(),
                    pageNumber:pageNumber,
                    pageSize:pageSize
                })
        }
    };

    $(window).resize(function(){
        easyUiTable.initTable(easyUiTableParam);
    });

    //初始化加载表格
    easyUiTable.initTable(easyUiTableParam);

})

$("#search").on("click",function(){
    $('#easyUi_table').datagrid('load',{
        title:$("#title").val(),
        locationKey:$("#locationKey").val(),
        keyword:$("#keyword").val(),
        appId:$("#appId").val()
    });
})

$("#reset").on("click",function(){
    $("#keywordForm")[0].reset()
    $('#easyUi_table').datagrid('load',{});
})