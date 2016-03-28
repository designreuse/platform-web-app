$(function() {

    $('#myform')[0].reset();

    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
        }
    });

    var easyUiTableParam = {
        url: window.ctx+'/store/storeList',
        onSelectPage:function(pageNumber,pageSize){
            $('#easyUi_table').datagrid("reload",
                {
                    pageNumber:pageNumber,
                    pageSize:pageSize,
                    warehouseName:$("#warehouseName").val(),
                    orgNameCn:$("#orgNameCn").val(),
                    disabled:$("#disabled").val()
                })

        },
        columns:[
            {field:'id',title:'仓库ID',width:80,hidden:true},
            {
                field:"warehouseName",
                title:'仓库名称',
                width:80,
                align:'center',
                formatter: function(value,rec){
                    return '<div class="wh-hover"> <a href="#" onclick="stock(\''+rec.id+'\')">'+value+'</a></a><a href="#" onclick="detail(\''+rec.id+'\')"><span class="icon-edit icon"></span></a><a href="#" data-toggle="modal" data-target="#wh-del" onclick="confirm1(\''+rec.warehouseName+'\',\''+rec.disabled+'\',\''+rec.id+'\')"><span class="icon-del icon"></span></a></div>';
                }
            },{
                field:"orgNameCn",
                title:'委托方名称',
                width:130,
                align:'center'
            },{
                field:"parkName",
                title:'仓库归属园区',
                width:120,
                align:'center'
            },{
                field:'opt',title:'有效期限',width:200,align:'center',
                formatter:function(value,rec){
                    return new Date( rec.startDate).Format("yyyy-MM-dd") +' ~  '+ new Date( rec.endDate).Format("yyyy-MM-dd");
                }
            },{
                field:"disabled",
                title:'仓库状态',
                width:180,
                align:'center',
                formatter: function(value,row,index){
                   if(value){
                       return "停用";
                   }else{
                       return "可用";
                   }
                }
            },{
                field:"warehouseManagerBoList",
                title:'库管员',
                width:180,
                align:'center',
                formatter: function(value,row,index){
                    var manageList=value;
                    var manager='';
                    for(var i=0;i<manageList.length;i++){
                       manager+=manageList[i].userName
                        if(i < manageList.length-1){
                            manager+=",";
                        }
                    }
                   return manager;
                }
            }
        ]

    };

    $(window).resize(function(){
        easyUiTable.initTable(easyUiTableParam);
    });

    easyUiTable.initTable(easyUiTableParam);

})


$("#search").click(function(){
    $('#easyUi_table').datagrid('load',{
        warehouseName:$("#warehouseName").val(),
        orgNameCn:$("#orgNameCn").val(),
        disabled:$("#disabled").val()
    });
})

$("#add").on("click",function(){
    window.location.href=window.ctx+"/store/add"
})

$("#allDetail").on("click",function(){
    window.location.href=window.ctx+"/stock/list";
})

function stock(id){
    window.location.href=window.ctx+"/store/stockList?id="+id;
}

function confirm1(name,disable,id){
    var dis;
    if(disable == 'true'){
        dis='启用';
    }else{
        dis='停用';
    }
    $.messager.confirm(dis+'仓库', '确定'+dis+name+'?', function(r){
        if (r){
            $.ajax({
                url: window.ctx + '/store/changeStatus?id=' + id+"&disabled="+disable,
                success: function (msg) {
                    $('#easyUi_table').datagrid("reload")
                }
            })
        }
    });
}

function detail(id){
    window.location.href=window.ctx+"/store/detail?id="+id;
}

function reset(){
    $('#myform')[0].reset();
    window.location.href=window.ctx+"/store/list";
}







