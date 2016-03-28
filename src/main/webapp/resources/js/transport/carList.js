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
        url: window.ctx+'/transport/carList',
        onSelectPage:function(pageNumber,pageSize){
            $('#easyUi_table').datagrid("reload",
                {
                    pageNumber:pageNumber,
                    pageSize:pageSize,
                    disabled:$("#disabled").val(),
                    carCountry:$("#carCountry").val(),
                    carLicence:$("#carLience").val()
                })

        },
        columns:[
            {field:'id',title:'车辆ID',width:80,hidden:true},
            {
                field:"carLicence",
                title:'车牌号',
                width:80,
                align:'center',
                formatter: function(value,rec){
                    return '<a href="#" <button onclick="detail(\''+rec.id+'\')">'+value+'</a>';
                }
            },{
                field:"carCountry",
                title:'车牌国籍',
                width:80,
                align:'center',
                formatter: function(value,row,index){
                    if (value==1){
                        return '<span class="disabled">中国</span>';
                    } else if (value==2){
                        return '<span class="undisabled">俄罗斯</span>';
                    }
                }
            },{
                field:"carType",
                title:'车辆类型',
                width:80,
                align:'center',
                formatter: function(value,row,index){
                    if (value==1){
                        return '<span class="disabled">围栏车</span>';
                    } else if (value==2){
                        return '<span class="disabled">冷藏车</span>';
                    } else if (value==3){
                        return '<span class="disabled">箱车</span>';
                    }
                }
            },{
                field:"carCapacity",
                title:'载重量',
                width:80,
                align:'center',
                formatter: function(value,row,index){
                    return value+'吨';
                }
            },{
                field:"disabled",
                title:'车辆状态',
                width:80,
                align:'center',
                formatter: function(value,row,index){
                    if (value){
                        return '<span class="disabled">停用</span>';
                    } else {
                        return '<span class="undisabled">可用</span>';
                    }
                }
            }
        ]

    };

    $(window).resize(function(){
        easyUiTable.initTable(easyUiTableParam);
    });

    easyUiTable.initTable(easyUiTableParam);

})

function changeCarStauts(id,disabled) {
        $.ajax({
            url: window.ctx + '/transport/changeCarStatus?id=' + id+"&disabled="+disabled,
            success: function (msg) {

                $('#easyUi_table').datagrid("reload")
            }
        })
}

$("#search").click(function(){
    $('#easyUi_table').datagrid('load',{
        disabled:$("#disabled").val(),
        carCountry:$("#carCountry").val(),
        carLicence:$("#carLience").val()
    });
})

$("#add").on("click",function(){
    window.location.href=window.ctx+"/transport/carInsert"
})

function detail(id){
    window.location.href=window.ctx+"/transport/detailCar?type=detail&id="+id;
}
function reset(){
    $('#myform')[0].reset();
    window.location.href=window.ctx+"/transport/listCar";
}





