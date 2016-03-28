/*
 条件查询
 */


$(document).keypress(function(e) {
    // 回车键事件
    if(e.which == 13) {
        jQuery("#search").click();
        return false
    }
});

$("#againSet").click(function(){
    $("#contactName").val("");
    $("#orgName").val("");
    $("#contactTel").val("");
    $("#app").val("");
    $("#type").val("");
    $("#createTimeStart").val("");
    $("#createTimeEnd").val("");
    $("#consultStatus").val("");

    $("#search").click();
})


$(function(){

    $("#search").on("click",function(){
        //联系人
        var contactName = $("#contactName").val();
        //企业
        var orgName = $("#orgName").val();
        //手机号
        var contactTel = $("#contactTel").val();


        //开始时间
        var startTime =$("#createTimeStart").val();
        //结束时间
        var endTime =$("#createTimeEnd").val();
        var startDate = new Date(startTime);
        var endDate = new Date(endTime);

        var feedbackSource=$("#app").find("option:selected").val();
        var type=$("#type").find("option:selected").val();
        $('#easyUi_table').datagrid('load',{
            contactName:contactName,
            orgName:orgName,
            contactTel:contactTel,
            createTimeStart:startTime,
            createTimeEnd:endTime,
            feedbackSource:feedbackSource,
            type:type
        })
    })

    /*定义easyUITable的相关参数*/
    var easyUiTableParam = {
        url: window.ctx+'/userFeedback/viewList',
        fitColumns:true,
        onSelectPage:function(pageNumber,pageSize){

            //联系人
            var contactName = $("#contactName").val();
            //企业
            var orgName = $("#orgName").val();
            //手机号
            var contactTel = $("#contactTel").val();


            //开始时间
            var startTime =$("#createTimeStart").val();
            //结束时间
            var endTime =$("#createTimeEnd").val();
            var startDate = new Date(startTime);
            var endDate = new Date(endTime);


            var feedbackSource=$("#app").find("option:selected").val();
            var type=$("#type").find("option:selected").val();
            $('#easyUi_table').datagrid('load',{
                pageNumber:pageNumber,
                pageSize:pageSize,
                contactName:contactName,
                orgName:orgName,
                contactTel:contactTel,
                createTimeStart:startTime,
                createTimeEnd:endTime,
                feedbackSource:feedbackSource,
                type:type
            })
        },
        columns:[
            {
                field:'contactName',
                title:'联系人',
                align:'center',
                width:'80px',
                formatter: function(value,row,index){
                    return value+"<br/>"+row.orgName
                }
            },
            {
                field:'contactTel',
                width:'100px',
                align:'center',
                title:'联系方式'
            },
            {
                field:'feedbackSourceNameCn',
                width:'80px',
                align:'center',
                title:'留言平台'
            },
            {
                field:"type",
                title:"留言类型",
                width:'80px',
                align:'center',
                formatter: function(value,row,index){
                    switch (value){
                        case '1':{return "咨询";break;}
                        case '2':{return "建议";break;}
                        case '3':{return "投诉";break;}
                        case '4':{return "询盘";break;}
                        case '5':{return "服务商入驻";break;}
                    }
                }
            },
            {
                field:'content',
                width:'100px',
                align:'center',
                title:'留言内容',
                formatter:function(value,row,index){
//                    return "11111"
                    return "<p title='"+value+"'>"+value.substring(0,40)+"...</p>"
                }
            },
            {
                field:'createTime',
                width:'100px',
                align:'center',
                title:'创建时间',
                formatter: function(value,row,index){
                    return new Date(value).Format("yyyy-MM-dd")+"<br/>"+new Date(value).Format("hh:mm");
                }
            },
            {
                field:'disabled',
                title:'操作',
                align:'center',
                width:"70px",
                /*formatter:function(value,row,index){
                 return new Date(value).Format("yyyy-MM-dd hh:mm");
                 }*/
                formatter: function(value,row,index){
                    if(value ==0){
                        return '<a href="#" onclick="deleteMessage('+row['id']+')">'+"【删除】"+'</a>';

                    }else if(value ==1){
                        return "已删除";
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


});


function deleteMessage(id){
    if(confirm("确认删除这条留言信息？")){
        $.ajax({
            type:"POST",
            url: window.ctx + "/userFeedback/deleteMessage",
            dataType:"JSON",
            data:{
                id:id
            },
            success: function () {
                alert("删除留言成功！");
                location.reload();
            }, error: function () {
                alert("删除留言失败，服务器出现错误");
            }
        });
    }
}





