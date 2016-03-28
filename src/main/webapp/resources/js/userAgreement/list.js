/**
 * Created by Administrator on 2016/2/19.
 */
$(function(){

    //设置表格初始化配置属性
    var easyUiTableParam = {
        url: window.ctx+'/userAgreement/agreementList',
        columns: [{
            field:"appName",
            title:'平台',
            align:'center',
            width:"175px",
            formatter:function(value,row,index){
                return "<a href='"+window.ctx+"/userAgreement/"+row.id+"/edit'>"+value+"</a>"
            }
        },
            {
            field:'disabled',
            title:'状态',
            align:'center',
            width:'60px',
            formatter: function(value,row,index){
                if(1==value){
                    return '停用';
                }else if(0==value){
                    return '可用';
                }
            }
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
                    pageSize:pageSize
                })
        }
    };

    $(window).resize(function(){
        easyUiTable.initTable(easyUiTableParam);
    });

    //初始化加载表格
    easyUiTable.initTable(easyUiTableParam);
});