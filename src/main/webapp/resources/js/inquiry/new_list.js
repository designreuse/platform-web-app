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
        url: window.ctx+'/inquiry/inquiryList?inquiryType=1',
        columns: [{
            field:"inquiryId",
            title:'询盘编号',
            align:'center',
            width:"165px",
            formatter:function(value,row,index){
                if(row.inquiryType ==1){
                    return"<a href='"+window.ctx+"/inquiry/detail?inquiryId="+value+"&inquiryType=1'>"+row.inquiryCode+"</a>"
                }else{
                    return"<a href='"+window.ctx+"/inquiry/detail?inquiryId="+value+"&inquiryType=2'>"+row.inquiryCode+"</a>"
                }
            }
        },
            {
                field:'buyerOrgType',
                title:'买方',
                align:'center',
                width:"150px",
                formatter:function(value,row,index){
                    if(value == 1){
                        return row.buyerOrgNameRu+"</br>"+row.buyerUsernameRu;
                    }else{
                        return row.buyerUsernameRu;
                    }
                }
            },
            {
                field:'sellerOrgType',
                title:'卖方',
                align:'center',
                width:"150px",
                formatter:function(value,row,index){
                    if(row.inquiryType ==1){
                        if(value == 1){
                            return row.sellerOrgNameCn+"</br>"+row.shopsNameCn+"</br>"+row.shopsContactsCn;
                        }else{
                            return row.shopsNameCn+"</br>"+row.shopsContactsCn;
                        }
                    }
                    return "【不定向】"
                }
            },
            {
                field:'productNameCns',
                title:'商品',
                align:'center',
                width:'125px',
                formatter: function(value,row,index){
                    var str=''
                    value.split(",").forEach(function(i,n){
                        str+=i+"&nbsp;"+ row.productNums.split(",")[n]+row.productUnitNameCns.split(",")[n]+"</br>"
                    })
                    return str
                }
            },
            {
                field:'inquiryStatusNameCn',
                title:'状态',
                align:'center',
                width:"75px",
                formatter: function(value,row,index){
                    if(row.inquiryStatus ==2){
                        if(row.inquiryAuditStatusNameCn){
                            return value+"<br/>"+row.inquiryAuditStatusNameCn
                        }
                    }
                    if(row.inquiryStatus ==3){
                        if(row.feedbackAuditStatusNameCn){
                            return value+"<br/>"+row.feedbackAuditStatusNameCn
                        }
                    }
                    return value
                }
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
                field:'inquiryType',
                title:'操作',
                align:'center',
                width:"75px",
                formatter:function(value,row,index){
                    return"<a class='btn btn-info' href='"+window.ctx+"/inquiry/detail?inquiryId="+row.inquiryId+"&inquiryType="+value+"'>查看</a>"
                }
            },
        ],
        onSelectPage:function(pageNumber,pageSize){
            $('#easyUi_table').datagrid(
                {
                    url: window.ctx+'/inquiry/inquiryList?inquiryType='+$('input[name="inquiryType"]:checked ').val(),
                    queryParams:{
                        pageNumber:pageNumber,
                        pageSize:pageSize,
                        inquiryCode:$("#inquiryCode").val(),
                        buyerOrgName:$("#buyerOrgName").val(),
                        sellerOrgName:$("#sellerOrgName").val(),
                        inquiryStatus:$("#inquiryStatus").val(),
                        createTimeBegin:$("#createTimeBegin").val(),
                        createTimeEnd:$("#createTimeEnd").val(),
                        shopsName:$("#shopsName").val()
                    }
                }
            )
        }
    };

    //初始化加载表格
    easyUiTable.initTable(easyUiTableParam);
});

$("#search").on("click",function(){
    $('#easyUi_table').datagrid({
        url: window.ctx+'/inquiry/inquiryList?inquiryType='+$('input[name="inquiryType"]:checked ').val(),
        queryParams:{
            inquiryCode:$("#inquiryCode").val(),
            buyerOrgName:$("#buyerOrgName").val(),
            sellerOrgName:$("#sellerOrgName").val(),
            inquiryStatus:$("#inquiryStatus").val(),
            createTimeBegin:$("#createTimeBegin").val(),
            createTimeEnd:$("#createTimeEnd").val(),
            shopsName:$("#shopsName").val()
        }
    });
})

$("#reset").on("click",function(){
    $("#inquiryForm")[0].reset()
    $('#easyUi_table').datagrid("load",{});
})