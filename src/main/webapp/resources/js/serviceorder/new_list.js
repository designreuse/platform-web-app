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
        url: window.ctx+'/serviceOrder/orderList?status='+$("#status").val(),
        columns: [{
            field:"srvOrderId",
            title:'订单编号',
            align:'center',
            width:"185px",
            formatter:function(value,row,index){
                return '<a href="'+window.ctx+'/serviceOrder/'+value+'/edit">'+row.srvOrderCode;
            }
        },
            {
                field:'orgId',
                title:'委托方',
                align:'center',
                width:"160px",
                formatter:function(value,row,index) {
                    if (row.countryType == 2) {
                        return row.orgNameRu
                    } else {
                        return row.orgNameCn
                    }
                }
            },
            {
                field:'regSource',
                title:'联系人',
                align:'center',
                width:"90px",
                formatter:function(value,row,index){
                    if(row.countryType == 2){
                        return row.userNameFirst+"<br/>"+row.entrustEmail
                    }else{
                        return row.userNameCn+"<br/>"+row.entrustMobile
                    }
                }
            },
            {
                field:'srvNameCn',
                title:'委托服务',
                align:'center',
                width:"160px"
            },
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
                    return new Date(value).Format("yyyy-MM-dd hh:mm");
                }
            },
            {
                field:'status',
                title:'操作',
                align:'center',
                width:"65px",
                formatter:function(value,row,index){
                    if(value ==1){
                        return '<a href="'+window.ctx+'/serviceOrder/'+row.srvOrderId+'/edit" type="button"  class="btn btn-info">确认</a>'
                    }
                    if(value ==2){
                        return '<a href="'+window.ctx+'/serviceOrder/'+row.srvOrderId+'/execute" type="button"  class="btn btn-info">分配</a>'
                    }
                    if(value ==3){
                        return '<a href="'+window.ctx+'/serviceOrder/'+row.srvOrderId+'/execute" type="button"  class="btn btn-info">执行</a>'
                    }
                }
            }
        ],
        onSelectPage:function(pageNumber,pageSize){
            $('#easyUi_table').datagrid("reload",
                {
                    pageNumber:pageNumber,
                    pageSize:pageSize,
                    srvOrderCode:$("#srvOrderCode").val(),
                    orgName:$("#orgName").val(),
                    contactsName:$("#contactsName").val(),
                    status:$("#status").val(),
                    beginCreateTime:$("#beginCreateTime").val(),
                    endCreateTime:$("#endCreateTime").val(),
                    service:$("#service").val()
                })
        }
    };

    //初始化加载表格
    easyUiTable.initTable(easyUiTableParam);
});

$("#search").on("click",function(){
    $('#easyUi_table').datagrid({
        url:window.ctx+'/serviceOrder/orderList',
        queryParams: {
            srvOrderCode: $("#srvOrderCode").val(),
            orgName: $("#orgName").val(),
            contactsName: $("#contactsName").val(),
            status: $("#status").val(),
            beginCreateTime: $("#beginCreateTime").val(),
            endCreateTime: $("#endCreateTime").val(),
            service: $("#service").val()
        }
    });
})

$("#reset").on("click",function(){
    $("#srvOrderForm")[0].reset()
    $('#easyUi_table').datagrid('load',{});
})


function  changeStatus(srvOrderId,status){
    if(confirm("是否确认执行？")){
        $.ajax({
            url:window.ctx+"/serviceOrder/changeStatus",
            type:"post",
            data:{
                srvOrderId:srvOrderId,
                status:status
            },
            success:function(data){
                $('#easyUi_table').datagrid('reload',{
                    srvOrderCode:$("#srvOrderCode").val(),
                    orgName:$("#orgName").val(),
                    contactsName:$("#contactsName").val(),
                    status:$("#status").val(),
                    beginCreateTime:$("#beginCreateTime").val(),
                    endCreateTime:$("#endCreateTime").val(),
                    service:$("#service").val()
                });
            }
        })
    }
}