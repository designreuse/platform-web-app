$(function() {


    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
            return false;
        }
    });

    $('#myform')[0].reset();

    var easyUiTableParam = {
        url: window.ctx+'/transport/driverList',
        onSelectPage:function(pageNumber,pageSize){
            $('#easyUi_table').datagrid("reload",
                {
                    pageNumber:pageNumber,
                    pageSize:pageSize,
                    driverName:$("#driverName").val(),
                    countryId:$("#countryId").val(),
                    driverMobile:$("#driverMobile").val()
                })

        },
        columns:[
            {field:'id',title:'司机ID',width:"80px",hidden:true},
            {
                field:"driverName",
                title:'司机姓名',
                width:'80px',
                align:'center',
                formatter: function(value,rec){
                    return '<a href="#" <button onclick="detail(\''+rec.id+'\')">'+value+'</a>';
                }
            },{
                field:"countryId",
                title:'司机国籍',
                width:'80px',
                align:'center',
                formatter: function(value,row,index){
                    if (value==1){
                        return '<span class="disabled">中国</span>';
                    } else if (value==2) {
                        return '<span class="undisabled">俄罗斯</span>';
                    }
                }
            },{
                field:"driverMobile",
                title:'司机手机',
                width:'130px',
                align:'center'
            },{
                field:"createTime",
                title:'创建时间',
                width:'180px',
                align:'center',
                formatter:function(value,row,index){
                    return new Date(value).Format("yyyy-MM-dd hh:mm:ss");
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
        driverName:$("#driverName").val(),
        countryId:$("#countryId").val(),
        driverMobile:$("#driverMobile").val()
    });
})

$("#add").on("click",function(){
    window.location.href=window.ctx+"/transport/driverAdd"
})

function detail(id){
    window.location.href=window.ctx+"/transport/detailDriver?id="+id+"&type=detail";
}

function reset(){
    $('#myform')[0].reset();
    window.location.href=window.ctx+"/transport/listDriver";
}




