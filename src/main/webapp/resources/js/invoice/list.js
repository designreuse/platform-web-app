/*
 条件查询
 */
$("#againSet").click(function(){
    $("#orgName").val("");
    $("#invoiceTitle").val("");

    $("#startDate").val("");
    $("#endDate").val("");
    $("#status").val("");

    $("#search").click();
})

$(function(){

    $(document).keypress(function(e) {
        // 回车键事件
        if(e.which == 13) {
            jQuery("#search").click();
        }
    });

    $("#orgName").val("");
    $("#invoiceTitle").val("");

    $("#startDate").val("");
    $("#endDate").val("");
    $("#status").val("");

    $("#search").on("click",function(){

        var orgName = $("#orgName").val();
        var invoiceTitle = $("#invoiceTitle").val();

        var startTime =$("#startDate").val();
        var endTime =$("#endDate").val();

        var selectText=$("#status").find("option:selected").text();
        var status;
        switch (selectText){
            case "申请中":status=1;break;
            case "已开票":status=2;break;
            case "已取消":status=3;break;
        }

        $('#easyUi_table').datagrid('load',{
            orgName:orgName,//申请企业
            title:invoiceTitle,//开票title
            startTime:startTime,//申请日期的开始时间
            endTime:endTime,//申请日期的结束时间
            status:status//状态
        })
    })

    /*定义easyUITable的相关参数*/
    var easyUiTableParam = {
        url: window.ctx+'/invoice/viewList',
        fitColumns:true,
        onSelectPage:function(pageNumber,pageSize){
            var orgName = $("#orgName").val();
            var invoiceTitle = $("#invoiceTitle").val();

            var startTime =$("#startDate").val();
            var endTime =$("#endDate").val();

            var selectText=$("#status").find("option:selected").text();
            var status;
            switch (selectText){
                case "申请中":status=1;break;
                case "已开票":status=2;break;
                case "已取消":status=3;break;
            }

            $('#easyUi_table').datagrid('load',{
                pageNumber:pageNumber,
                pageSize:pageSize,
                orgName:orgName,//申请企业
                title:invoiceTitle,//开票title
                startTime:startTime,//申请日期的开始时间
                endTime:endTime,//申请日期的结束时间
                status:status//状态
            })
        },
        columns:[
            {field:'id',title:'id',hidden:true},
            {
                field:'orgName',
                title:'申请企业',
                align:'center',
                width:"120px",
                formatter: function(value,row,index){
                    var id=row['id'];
                    str = '<a href="'+window.ctx+'/invoice/edit/'+id+'">'+value+"</a>";
                    return str;
                }
            },
            {
                field:'userName',
                title:'申请人',
                align:'center',
                width:"150px"
            },
            {
                field:'title',
                title:'发票抬头',
                align:'center',
                width:"150px"
            },
            {
                field:"invoiceContent",
                title:"开票内容",
                align:'center',
                width:"180px"

            },
            {
                field:'totalPriceAllInvoices',
                title:'总金额',
                align:'center',
                width:"120px",
                formatter: function(value,row,index){
                    return value +"元"

                }
            },
            {
                field:'applyTime',
                title:'申请时间',
                align:'center',
                width:"100px",
                formatter: function(value,row,index){
                    return new Date(value).Format("yyyy-MM-dd hh:mm");
                }
            },
            {
                field:'invoiceStatus',
                title:'状态',
                align:'center',
                width:"50px",
                formatter: function(value,row,index){
                   if(1==value){
                       return '<span class="disabled">申请中</span>';
                   }else if(2==value){
                       return '<span class="disabled">已开票</span>'
                   }else if(3==value){
                       return '<span class="disabled">已取消</span>'
                   }else{
                       return '<span class="disabled"></span>'
                   }

                }
            }
        ]

    }

    $(window).resize(function(){
        easyUiTable.initTable(easyUiTableParam);
    });
    /*easyUI初始化表*/
    easyUiTable.initTable(easyUiTableParam);


    /*隐藏活动id不显示*/
    $("#easyUi_table").datagrid('hideColumn', 'id');

});





