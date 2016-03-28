$(function(){

    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
        }
    });


    //设置表格初始化配置属性
    var easyUiTableParam = {
        url: window.ctx+'/news/newsList',
        columns: [{
            field:"id",
            title:'编号',
            align:'center',
            width:"80px"
        },
            {
                field:'title',
                title:'标题',
                align:'center',
                width:"130px",
                formatter:function(value,row,index){
                    return '<a href="'+window.ctx+'/news/'+row.id+'/edit" nowrap="false">'+row.title;
                }
            },
            {
                field:'appName',
                title:'平台',
                align:'center',
                width:"100px"
            },
            {
                field:'constName',
                title:'栏目',
                align:'center',
                width:"100px"
            },
            {
                field:'userNameCn',
                title:'发布人',
                align:'center',
                width:"80px"
            },
            {
                field:'releaseTime',
                title:'发布时间',
                align:'center',
                width:"90px",
                formatter:function(value,row,index){
                    return new Date(row.releaseTime).Format("yyyy-MM-dd hh:mm");
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
                    title:$("#title").val(),
                    appId:$("#appId").val(),
                    channel:$("#channel").val(),
                    releaseStartDate:$("#releaseStartDate").val(),
                    releaseEndDate:$("#releaseEndDate").val(),
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
        title:$("#title").val(),
        appId:$("#appId").val(),
        channel:$("#channel").val(),
        releaseStartDate:$("#releaseStartDate").val(),
        releaseEndDate:$("#releaseEndDate").val(),
        disabled:$("#disabled").val()
    });
})

$("#add").click(function(){
    window.location.href=window.ctx+"/news/add"
})


//当平台改变时触发修改栏目
$("#appId").change(function(){
    //alert(1);
    var appId=$("#appId").val();
    //清除之前的option
    $("#channel option").remove();
    $.ajax({
        type:"POST",
        contentType :"text/html;charset:utf-8",
        url:window.ctx+"/news/ajaxGetChannel",
        data:appId,
        success:function(data){
            $("#channel").append("<option value=''>请选择</option>");
            //alert(data[i].constName)
            for ( var i =0 ;i <data.resultData.length;i++){
                $("#channel").append("<option value="+data.resultData[i].constValue+">"+data.resultData[i].constName+"</option>");
            }
        },
        dataType:"JSON"
    })
});

$("#reset").click(function(){
    window.location.href=window.ctx + "/news/list";
})