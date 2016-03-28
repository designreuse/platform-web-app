/**
 * Created by Administrator on 2015/11/16.
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
        url: window.ctx+'/order/orderList',
        columns: [{
            field:"orderId",
            title:'订单编号',
            align:'center',
            width:"175px",
            formatter:function(value,row,index){
                return '<a href="'+window.ctx+'/order/'+value+'/edit" nowrap="false">'+row.orderCode;
            }
        },
            {
                field:'buyOrgId',
                title:'买方',
                align:'center',
                width:"140px",
                formatter:function(value,row,index){
                    console.log(row)
                    if (row.buyEnrUserStatus == 1){
                        return row.buyOrgNameRu +"</br>"+row.buyUserNameRu;
                    }else if(row.buyEnrUserStatus ==2){
                        return row.buyUserNameRu;
                    }else{
                        return row.buyOrgNameRu
                    }
                }
            },
            {
                field:'saleOrgId',
                title:'卖方',
                align:'center',
                width:"140px",
                formatter:function(value,row,index){
                    if(row.saleEnrUserStatus == 1){
                        return row.saleOrgNameCn+"</br>"+row.shopsNameCn+"</br>"+row.saleUserNameCn;
                    }else{
                        return row.shopsNameCn+"</br>"+row.saleUserNameCn;
                    }
                }
            },
            {
                field:'productNameCn',
                title:'商品',
                align:'center',
                width:"125px",
                formatter: function(value,row,index){
                    var str = ""
                    value.split(",").forEach(function(i,n){
                        str+=i+"&nbsp;"+ row.purchareNums.split(",")[n]+row.unitNameCns.split(",")[n]+"</br>"
                        console.log(str)
                    })
                    return str
                }
            },
            {field:'deliveryAddrNameCn',title:'交货地',align:'center',width:"60px"},
            {
                field:'statusNameCn',
                title:'状态',
                align:'center',
                width:"75px"
            },
            {
                field:'createTime',
                title:'创建时间',
                align:'center',
                width:"75px",
                formatter:function(value,row,index){
                    console.log(value)
                    return new Date(value).Format("yyyy-MM-dd hh:mm");
                }
            }],
        onSelectPage:function(pageNumber,pageSize){
            $('#easyUi_table').datagrid("reload",
                {
                    pageNumber:pageNumber,
                    pageSize:pageSize,
                    orderCode:$("#orderCode").val(),
                    buyOrgName:$("#buyOrgName").val(),
                    saleOrgName:$("#saleOrgName").val(),
                    status:$("#status").val(),
                    beginCreateTime:$("#beginCreateTime").val(),
                    endCreateTime:$("#endCreateTime").val(),
                    deliveryAddrId:$("#deliveryAddrId").val(),
                    shopsName:$("#shopsName").val()
                })
        }
    };

    //初始化加载表格
    easyUiTable.initTable(easyUiTableParam);
});

$("#search").on("click",function(){
    $('#easyUi_table').datagrid('load',{
        orderCode:$("#orderCode").val(),
        buyOrgName:$("#buyOrgName").val(),
        saleOrgName:$("#saleOrgName").val(),
        status:$("#status").val(),
        beginCreateTime:$("#beginCreateTime").val(),
        endCreateTime:$("#endCreateTime").val(),
        deliveryAddrId:$("#deliveryAddrId").val(),
        shopsName:$("#shopsName").val()
    });
})

$("#reset").on("click",function(){
    $("#orderForm")[0].reset()
    $('#easyUi_table').datagrid('load',{});
})