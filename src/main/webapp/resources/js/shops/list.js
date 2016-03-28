
$('.datepicker').datetimepicker({
    language: 'zh-CN',
    format: 'yyyy-mm-dd',
    minView: "month",
    autoclose: 1,
    todayHighlight: 1
});
/*
 条件查询
 */

$("#againSet").click(function(){
    $("#shopsName").val("");
    $("#orgName").val("");
    $("#userName").val("");
    $("#mobile").val("");
    $("#startCreateDate").val("");
    $("#endCreateDate").val("");
    $("#shopsStatus").val("");
    $("#shopsType").val("");
    $("#disabled").val("");

    $("#search").click();
})


$(function(){
//兼容浏览器回退按钮导致的过滤搜索
//    $("#shopsName").val("");
//    $("#orgName").val("");
//    $("#userName").val("");
//    $("#mobile").val("");
//    $("#startCreateDate").val("");
//    $("#endCreateDate").val("");
//    $("#shopsStatus").val("");
//    $("#shopsType").val("");
//    $("#disabled").val("");


    $("#search").on("click",function(){

        var shopsName = $("#shopsName").val();
        var orgName = $("#orgName").val();

        var userName =$("#userName").val();
        var mobile =$("#mobile").val();

        var startCreateDate =$("#startCreateDate").val();
        var endCreateDate =$("#endCreateDate").val();

        var shopsStatus=$("#shopsStatus").find("option:selected").val();
        var shopsType=$("#shopsType").find("option:selected").val();
        var disabled=$("#disabled").find("option:selected").val();

        $('#easyUi_table').datagrid({
            url:window.ctx+"/shops/viewList",
            queryParams:{
                shopsName:shopsName,
                orgName:orgName,
                userName:userName,
                mobile:mobile,
                categoryId:$("#categoryId").val(),
                startCreateDate:startCreateDate,
                endCreateDate:endCreateDate,
                shopsStatus:shopsStatus,
                shopsType:shopsType,
                disabled:disabled
            }
        })
    })

    /*定义easyUITable的相关参数*/
    var easyUiTableParam = {
        url: window.ctx+'/shops/viewList?shopsStatus='+$("#shopsStatus").val(),
        fitColumns:true,
        onSelectPage:function(pageNumber,pageSize){
            var shopsName = $("#shopsName").val();
            var orgName = $("#orgName").val();

            var userName =$("#userName").val();
            var mobile =$("#mobile").val();

            var startCreateDate =$("#startCreateDate").val();
            var endCreateDate =$("#endCreateDate").val();

            var shopsStatus=$("#shopsStatus").find("option:selected").val();
            var shopsType=$("#shopsType").find("option:selected").val();
            var disabled=$("#disabled").find("option:selected").val();

            $('#easyUi_table').datagrid('reload',{
                pageNumber:pageNumber,
                pageSize:pageSize,
                shopsName:shopsName,
                orgName:orgName,
                userName:userName,
                mobile:mobile,
                categoryId:$("#categoryId").val(),
                startCreateDate:startCreateDate,
                endCreateDate:endCreateDate,
                shopsStatus:shopsStatus,
                shopsType:shopsType,
                disabled:disabled
            })
        },
        columns:[
            {field:'shopsId',title:'shopsId',hidden:true},
            {
                field:'shopsNameCn',
                title:'商铺名称',
                align:'center',
                width:'100px',
                formatter: function(value,row,index){
                    var shopsId=row['shopsId'];
                    return '<a href="'+window.ctx+'/shops/edit/'+shopsId+'">'+value+'</a>';

                }
            },
            {
                field:'orgNameCn',
                title:'所属公司',
                align:'center',
                width:'110px'
            },
            {
                field:'userNameCn',
                title:'管理人',
                align:'center',
                width:'90px'
            },
            {
                field:"catalogNameCn",
                title:"从事行业",
                align:'center',
                width:'100px'

            },
            {
                field:'shopsStatus',
                title:'审核',
                align:'center',
                width:'70px',
                formatter: function(value,row,index){
                    //1初审2通过3待审4拒绝
                    if(value==1){
                        return "待初审";
                    }else if(value==2){
                        return "审核通过";
                    }else if(value==3){
                        return "待审核";
                    }else if(value==4){
                        return "审核拒绝";
                    }
                }
            },
            {
                field:'shopsType',
                title:'隶属关系',
                align:'center',
                width:'70px',
                formatter: function(value,row,index){
                    if(value==1){
                        return "隶属";
                    }else if(value==2){
                        return "个人";
                    }
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
                width:'90px',
                formatter: function(value,row,index){
                    return new Date(value).Format("yyyy-MM-dd hh:mm");
                }
            }
        ]


        /*onClickRow:function(rowIndex,rowData){
            var shopsId=rowData['shopsId'];
            window.location.href=window.ctx+"/shops/edit/"+shopsId;
        },*/
    }

    $(window).resize(function(){
        easyUiTable.initTable(easyUiTableParam);
    });

    /*easyUI初始化表*/
    easyUiTable.initTable(easyUiTableParam);


    /*隐藏活动id不显示*/
    $("#easyUi_table").datagrid('hideColumn', 'shopsId');

});

$(document).keypress(function(e) {
    // 回车键事件
    if(e.which == 13) {
        jQuery("#search").click();
    }
});



