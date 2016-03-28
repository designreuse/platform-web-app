$(function() {

    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
            return false;
        }
    });

  var war=  $('#warehouseId').val()
    var url=url=window.ctx+'/stock/stockList';
   if(war.length>0){
       url=window.ctx+'/stock/stockList?warehouseId='+war;
   }


    var easyUiTableParam = {
        url: url,
        onSelectPage:function(pageNumber,pageSize){
            $('#easyUi_table').datagrid("reload",
                {
                    pageNumber:pageNumber,
                    pageSize:pageSize,
                    type:$("#type").val(),
                    keyWord:$("#keyWord").val(),
                    catalogIdFirst:$("#catalogIdFirst").val(),
                    ioType:$("#ioType").val(),
                    warehouseId:$('#warehouseId').val()
                })

        },
        columns:[
            {
                field:'createTime',title:'创建时间',width:110,align:'center',
                formatter:function(value,rec){
                    return  new Date( value).Format("yyyy-MM-dd hh:mm");
                }
            },{
                field:"stockCode",
                title:'单据编号',
                width:70,
                align:'center',
                formatter: function(value,rec){
                    return '<a href="#" <button onclick="detail(\''+rec.id+'\',\''+rec.ioType+'\')">'+value+'</a>';
                }
            },{
                field:"orgNameCn",
                title:'委托方名称',
                width:120,
                align:'center'
            },{
                field:"productNameCn",
                title:'商品名称',
                width:80,
                align:'center'
            },{
                field:"warehouseName",
                title:'仓库',
                width:80,
                align:'center'
            },{
                field:"ioType",
                title:'类型',
                width:40,
                align:'center',
                formatter: function(value,rec){
                    var btn;
                    if(value == 1){
                        btn='出库';
                    }else{
                        btn='入库';
                    }
                    return btn;
                }
            },{
                field:"ioNums",
                title:'数量',
                width:40,
                align:'center'
            },{
                field:"constName",
                title:'单位',
                width:40,
                align:'center'
            },{
                field:"warehouseManager",
                title:'库管员',
                width:80,
                align:'center'
            }
        ]

    };

    $(window).resize(function(){
        easyUiTable.initTable(easyUiTableParam);
    });

    easyUiTable.initTable(easyUiTableParam);
})


$("#search").click(function(){
    $('#easyUi_table').datagrid('reload',{
        type:$("#type").val(),
        keyWord:$("#keyWord").val(),
        catalogIdFirst:$("#catalogIdFirst").val(),
        ioType:$("#ioType").val(),
        warehouseId:$('#warehouseId').val()
    });
})

function reset(){
    $('#myform')[0].reset();
    window.location.href=window.ctx+"/stock/list";
}


function detail(id,type){
    var types;
    if(type == 1){
       types = 'out';
    } else if(type == 2){
        types = 'in';
    }
    window.location.href=window.ctx+"/stock/detail?pageType=detail&id="+id+"&type="+types;
}

$("#in").on("click",function(){
    window.location.href=window.ctx+"/stock/add?type=in";
})

$("#out").on("click",function(){
    window.location.href=window.ctx+"/stock/add?type=out";
})

