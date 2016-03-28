$(function(){

    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
        }
    });


    //设置表格初始化配置属性
    var easyUiTableParam = {
        url: window.ctx+'/banner/bannerList',
        columns: [{
            field:"appName",
            title:'平台',
            align:'center',
            width:"80px"
        },
            {
                field:'id',
                title:'广告位',
                align:'center',
                width:"170px",
                formatter:function(value,row,index){
                    return '<a href="'+window.ctx+'/banner/'+value+'/edit" nowrap="false">'+row.adLocationKey;
                }
            },
            {
                field:'bannerDesc',
                title:'描述',
                align:'center',
                width:"100px",
                formatter:function(value,row,index){
                    if(value.length>14){
                        return  value.replace(/<\/?.+?>/g,"").substr(0,14)+"..."
                    }else{
                        return value
                    }
                }
            },
            {
                field:'startTime',
                title:'投放时间',
                align:'center',
                width:"100px",
                formatter: function(value,row,index){
                    return  new Date(value).Format("yyyy/MM/dd") + '~<br/>' + new Date(row.endTime).Format("yyyy/MM/dd");
                }
            },
            {
                field:'clickNum',
                title:'点击次数',
                align:'center',
                width:"60px"
            },
            {
                field:'userNameCn',
                title:'发布人',
                align:'center',
                width:"60px"
            },
            {
                field:'createTime',
                title:'发布时间',
                align:'center',
                width:"90px",
                formatter:function(value,row,index){
                    return new Date(row.createTime).Format("yyyy-MM-dd hh:mm");
                }
            },
            {
                field:'disabled',
                title:'状态',
                align:'center',
                width:"60px",
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
                    appId:$("#appId").val(),
                    adLocationId:$("#adLocationId").val(),
                    validDate:$("#validDate").val(),
                    disabled:$("#status").val()
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
        appId:$("#appId").val(),
        adLocationId:$("#adLocationId").val(),
        validDate:$("#validDate").val(),
        disabled:$("#disabled").val()
    });
})

$("#add").click(function(){
    window.location.href=window.ctx+"/banner/add"
})

$("#appId").change(function () {
    var appId = $("#appId").val();
    //清除之前的option
    $("#adLocationId option").remove();
    $.ajax({
        type:"POST",
        contentType :"text/html;charset:utf-8",
        url:window.ctx+"/banner/ajaxGetadLocation",
        data:appId,
        success:function(data){
            $("#adLocationId").append("<option value=''>请选择</option>");
            //alert(data[i].constName)
            for ( var i =0 ;i <data.resultData.length;i++){
                $("#adLocationId").append("<option value="+data.resultData[i].id+">"+data.resultData[i].adLocationKey  +"</option>");
            }
        },
        dataType:"JSON"
    })
})

$("#reset").click(function(){
    window.location.href=window.ctx + "/banner/list";
})

$("#specialAd").click(function(){

    window.location.href=window.ctx + "/banner/specialAd";
})